local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for i=1, #Config.candyCanes do
        Config.candyCanes[i].taken = false
    end

    for i=1, #Config.giftBoxes do
        QBCore.Functions.CreateUseableItem(Config.giftBoxes[i].item, function(source)
            TriggerClientEvent("canes:client:openBox", source, i)
        end)
    end
end)

RegisterNetEvent("canes:pickupCane")
AddEventHandler("canes:pickupCane", function(loc)
    local candyCane = Config.candyCanes[loc]
    if not Config.candyCanes[loc].taken then
        if not candyCane.taken then
            candyCane.taken = true
            TriggerClientEvent("canes:syncModels", -1, Config.candyCanes)

            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.AddItem(Config.rewardItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardItem], "add")
        end
    end
end)

RegisterNetEvent("canes:getCanes")
AddEventHandler("canes:getCanes", function()
    TriggerClientEvent("canes:syncModels", source, Config.candyCanes)
end)

RegisterNetEvent("canes:server:buyBox")
AddEventHandler("canes:server:buyBox", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local cost = Config.giftBoxes[item].cost
    local invItem = Player.Functions.GetItemByName(Config.rewardItem)

    if invItem ~= nil and invItem.amount >= cost then
        Player.Functions.RemoveItem(Config.rewardItem, cost)
        Player.Functions.AddItem(Config.giftBoxes[item].item, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.giftBoxes[item].item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough Candy", "error", 2500)
    end
end)

RegisterNetEvent("canes:server:openBox")
AddEventHandler("canes:server:openBox", function(i)
    local Player = QBCore.Functions.GetPlayer(source)
    local invItem = Player.Functions.GetItemByName(Config.giftBoxes[i].item)

    if invItem ~= nil and invItem.amount >= 1 then
        local reward = Config.giftBoxes[i].rewards[math.random(1, #Config.giftBoxes[i].rewards)]
        Player.Functions.RemoveItem(Config.giftBoxes[i].item, 1)
        Player.Functions.AddItem(reward.item, reward.amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[reward.item], "add")
    end
end)
