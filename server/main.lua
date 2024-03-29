GlobalState.CandyCanes = Config.CandyCanes

-- Event to set the location of Candy Cane NPC when resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        GlobalState.CandyCaneLocation = Config.Ped.Location[math.random(#Config.Ped.Location)]
    end
end)

CreateThread(function()
    for _, v in pairs(Config.CandyCanes) do
        v.taken = false
    end

    for k, v in pairs(Config.GiftBoxes) do
        RegisterUsableItem(v.item, function(source)
            TriggerClientEvent("canes:client:openBox", source, k)
        end)
    end
end)

CaneCooldown = function(loc)
    CreateThread(function()
        Wait(Config.RespawnTime * 1000)
        Config.CandyCanes[loc].taken = false
        GlobalState.CandyCanes = Config.CandyCanes
        Wait(1000)
        TriggerClientEvent('canes:respawnCane', -1, loc)
    end)
end

RegisterNetEvent("canes:pickupCane", function(loc)
    if not Config.CandyCanes[loc].taken then
        Config.CandyCanes[loc].taken = true
        GlobalState.CandyCanes = Config.CandyCanes
        TriggerClientEvent("canes:removeCane", -1, loc)
        CaneCooldown(loc)
        local Player = GetPlayer(source)
        AddItem(source, Config.RewardItem, 1)
    end
end)

RegisterNetEvent("canes:server:buyBox", function(item)
    local Player = GetPlayer(source)
    local cost = Config.GiftBoxes[item].cost
    local invItem = HasItem(source, Config.RewardItem)

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local isNearCandyCane = #(playerCoords - vector3(GlobalState.CandyCaneLocation.x, GlobalState.CandyCaneLocation.y, GlobalState.CandyCaneLocation.z)) < Config.Ped.Interaction.Distance
    if isNearCandyCane then
        if invItem ~= nil and invItem >= cost then
            RemoveItem(source, Config.RewardItem, cost)
            AddItem(source, Config.GiftBoxes[item].item, 1)
        else
            TriggerClientEvent('sd_bridge:notification', source, "You don't have enough Candy", "error", 2500)
        end
    end
end)

RegisterNetEvent("canes:server:openBox", function(i)
    local Player = GetPlayer(source)
    local invItem = HasItem(source, Config.GiftBoxes[i].item)

    if invItem ~= nil and invItem >= 1 then
        RemoveItem(source, Config.GiftBoxes[i].item, 1)

        local numRewards = Config.NumRewards
        local givenRewards = 0

        -- Create a copy of the rewards list to modify
        local availableRewards = {}
        for index, reward in ipairs(Config.GiftBoxes[i].rewards) do
            table.insert(availableRewards, reward)
        end

        while givenRewards < numRewards and #availableRewards > 0 do
            local rewardIndex = math.random(1, #availableRewards)
            local reward = availableRewards[rewardIndex]

            AddItem(source, reward.item, reward.amount)
            givenRewards = givenRewards + 1

            -- Remove the given reward from the available list
            table.remove(availableRewards, rewardIndex)
        end
    end
end)