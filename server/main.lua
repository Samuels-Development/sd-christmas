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

    for k, v in pairs(Config.giftBoxes) do
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
    else
        TriggerClientEvent('sd_bridge:notification', source, "You are not near the Candy Cane location", "error", 2500)
    end
end)

RegisterNetEvent("canes:server:openBox", function(i)
    local Player = GetPlayer(source)
    local invItem = HasItem(Config.GiftBoxes[i].item)

    if invItem ~= nil and invItem.amount >= 1 then
        local reward = Config.GiftBoxes[i].rewards[math.random(1, #Config.GiftBoxes[i].rewards)]
        RemoveItem(source, Config.GiftBoxes[i].item, 1)
        AddItem(source, reward.item, reward.amount)
    end
end)
