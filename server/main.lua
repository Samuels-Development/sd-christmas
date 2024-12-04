-- Initialize Global States
GlobalState.CandyCanes = Config.CandyCanes

math.randomseed(os.time())

local locale = SD.Locale.T -- Variable to abbreviate the translation function

-- Table to store player data using their identifier
local PlayerData = {}

-- This function listens for the 'onResourceStart' event.
--- @param resource string The name of the resource that started.
local OnResourceStart = function(resource)
    if resource == GetCurrentResourceName() then
        GlobalState.CandyCaneLocation = Config.Ped.Location[math.random(#Config.Ped.Location)]
    end
end

AddEventHandler('onResourceStart', OnResourceStart)

-- This function initializes the Candy Canes and Gift Boxes on server start.
local InitializeCandyCanesAndGiftBoxes = function()
    for _, cane in pairs(Config.CandyCanes) do
        cane.taken = false
    end

    for key, box in pairs(Config.GiftBoxes) do
        SD.Inventory.RegisterUsableItem(box.item, function(source)
            TriggerClientEvent("canes:client:openBox", source, key)
        end)
    end
end

CreateThread(InitializeCandyCanesAndGiftBoxes)

-- This function handles the cooldown and respawn of a Candy Cane.
--- @param locationIndex number The index of the Candy Cane location.
local CaneCooldown = function(locationIndex)
    CreateThread(function()
        Wait(Config.RespawnTime * 1000)
        Config.CandyCanes[locationIndex].taken = false
        GlobalState.CandyCanes = Config.CandyCanes
        TriggerClientEvent('canes:respawnCane', -1, locationIndex)
    end)
end

-- This function increments the player's candy cane count.
--- @param source number The player's source.
local IncrementPlayerCandyCaneCount = function(source)
    local identifier = SD.GetIdentifier(source)
    if not PlayerData[identifier] then
        PlayerData[identifier] = { candyCaneCount = 0, claimedMilestones = {} }
    end
    PlayerData[identifier].candyCaneCount = PlayerData[identifier].candyCaneCount + 1
end

-- This function handles the player picking up a Candy Cane.
--- @param locationIndex number The index of the Candy Cane location.
RegisterNetEvent("canes:pickupCane", function(locationIndex)
    local source = source
    local cane = Config.CandyCanes[locationIndex]
    if cane and not cane.taken then
        local playerPed = GetPlayerPed(source)
        if playerPed then
            local playerCoords = GetEntityCoords(playerPed)
            local caneCoords = cane.location
            local distance = #(playerCoords - caneCoords)
            if distance <= 10.0 then
                cane.taken = true
                GlobalState.CandyCanes = Config.CandyCanes
                TriggerClientEvent("canes:removeCane", -1, locationIndex)
                CaneCooldown(locationIndex)

                SD.Inventory.AddItem(source, Config.RewardItem, 1)
                IncrementPlayerCandyCaneCount(source)
            end
        end
    end
end)

-- This function handles the player purchasing a gift box.
--- @param boxIndex number The index of the Gift Box being purchased.
RegisterNetEvent("canes:server:buyBox", function(boxIndex)
    local source = source
    local box = Config.GiftBoxes[boxIndex]
    if not box then return end

    local cost = box.cost
    local candyCount = SD.Inventory.HasItem(source, Config.RewardItem)

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local npcCoords = vector3(GlobalState.CandyCaneLocation.x, GlobalState.CandyCaneLocation.y, GlobalState.CandyCaneLocation.z)
    local isNearNPC = #(playerCoords - npcCoords) < Config.Ped.Interaction.Distance

    if isNearNPC then
        if candyCount >= cost then
            SD.Inventory.RemoveItem(source, Config.RewardItem, cost)
            SD.Inventory.AddItem(source, box.item, 1)
            local boxName = locale('gift_box.' .. box.name_key)
            TriggerClientEvent('sd_bridge:notification', source, locale('success.purchased_box', {box_name = boxName}), "success", 2500)
        else
            TriggerClientEvent('sd_bridge:notification', source, locale('error.not_enough_canes'), "error", 2500)
        end
    else
        TriggerClientEvent('sd_bridge:notification', source, locale('error.need_to_be_near_santa'), "error", 2500)
    end
end)

-- Helper function to create a deep copy of a table.
--- @param tbl table The table to deep copy.
--- @return table A deep copy of the input table.
local function DeepCopyTable(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            copy[k] = DeepCopyTable(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- This function handles the player claiming a milestone reward.
--- @param milestoneIndex number The index of the milestone being claimed.
RegisterNetEvent("canes:server:claimMilestone", function(milestoneIndex)
    local source = source
    local identifier = SD.GetIdentifier(source)
    if not PlayerData[identifier] then
        PlayerData[identifier] = { candyCaneCount = 0, claimedMilestones = {} }
    end
    local candyCaneCount = PlayerData[identifier].candyCaneCount
    local claimedMilestones = PlayerData[identifier].claimedMilestones

    local milestone = Config.Milestones[milestoneIndex]
    if not milestone then return end

    if candyCaneCount >= milestone.required_count then
        if not claimedMilestones[milestoneIndex] then
            if milestone.reward.type == "item" then
                SD.Inventory.AddItem(source, milestone.reward.item, milestone.reward.amount)
                local itemName = locale('item_name.' .. milestone.reward.item)
                TriggerClientEvent('sd_bridge:notification', source, locale('success.milestone_reward_claimed', {amount = milestone.reward.amount, item_name = itemName}), "success", 2500)
            elseif milestone.reward.type == "money" then
                SD.Money.AddMoney(source, milestone.reward.money_type, milestone.reward.amount)
                TriggerClientEvent('sd_bridge:notification', source, locale('success.milestone_reward_claimed_money', {amount = milestone.reward.amount}), "success", 2500)
            end
            claimedMilestones[milestoneIndex] = true
            PlayerData[identifier].claimedMilestones = claimedMilestones
        else
            TriggerClientEvent('sd_bridge:notification', source, locale('error.milestone_already_claimed'), "error", 2500)
        end
    else
        TriggerClientEvent('sd_bridge:notification', source, locale('error.milestone_not_reached'), "error", 2500)
    end
end)

-- This function sends the player's milestone data to the client.
RegisterNetEvent("canes:server:getMilestoneData", function()
    local source = source
    local identifier = SD.GetIdentifier(source)
    if not PlayerData[identifier] then
        PlayerData[identifier] = { candyCaneCount = 0, claimedMilestones = {} }
    end
    local candyCaneCount = PlayerData[identifier].candyCaneCount
    local claimedMilestones = PlayerData[identifier].claimedMilestones
    TriggerClientEvent("canes:client:receiveMilestoneData", source, candyCaneCount, claimedMilestones)
end)

-- This function handles the player opening a gift box.
--- @param boxIndex number The index of the Gift Box being opened.
RegisterNetEvent("canes:server:openBox", function(boxIndex)
    local source = source
    local box = Config.GiftBoxes[boxIndex]
    if not box then return end

    local boxCount = SD.Inventory.HasItem(source, box.item)
    if boxCount >= 1 then
        SD.Inventory.RemoveItem(source, box.item, 1)

        local rewardsGiven = 0
        local availableRewards = DeepCopyTable(box.rewards)

        while rewardsGiven < Config.NumRewards and #availableRewards > 0 do
            local rewardIndex = math.random(#availableRewards)
            local reward = availableRewards[rewardIndex]

            SD.Inventory.AddItem(source, reward.item, reward.amount)
            TriggerClientEvent('sd_bridge:notification', source, locale('success.received_reward', {
                amount = reward.amount,
                item_name = locale('item_name.' .. reward.item)
            }), "success", 2500)
            rewardsGiven = rewardsGiven + 1
            table.remove(availableRewards, rewardIndex)
        end
    else
        local boxName = locale('gift_box.' .. box.name_key)
        TriggerClientEvent('sd_bridge:notification', source, locale('error.no_box_to_open', {box_name = boxName}), "error", 2500)
    end
end)

-- Clean up player data when they disconnect
AddEventHandler('playerDropped', function(reason)
    local source = source
    local identifier = SD.GetIdentifier(source)
    if PlayerData[identifier] then
        PlayerData[identifier] = nil
    end
end)
