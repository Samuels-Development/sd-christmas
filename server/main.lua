local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.CandyCanes = Config.candyCanes

Citizen.CreateThread(function()
    for _, v in pairs(Config.candyCanes) do
        v.taken = false
    end

    for k, v in pairs(Config.giftBoxes) do
        QBCore.Functions.CreateUseableItem(v.item, function(source)
            TriggerClientEvent("canes:client:openBox", source, k)
        end)
    end
end)

function CaneCooldown(loc)
    CreateThread(function()
        Wait(Config.Respawntime * 1000)
        Config.candyCanes[loc].taken = false
        GlobalState.CandyCanes = Config.candyCanes
        Wait(1000)
        TriggerClientEvent('canes:respawnCane', -1, loc)
    end)
end

RegisterNetEvent("canes:pickupCane")
AddEventHandler("canes:pickupCane", function(loc)
    if not Config.candyCanes[loc].taken then
        Config.candyCanes[loc].taken = true
        GlobalState.CandyCanes = Config.candyCanes
        TriggerClientEvent("canes:removeCane", -1, loc)
        CaneCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardItem], "add")
    end
end)

-- RegisterNetEvent("canes:getCanes")
-- AddEventHandler("canes:getCanes", function()
--     TriggerClientEvent("canes:syncModels", source, Config.candyCanes)
-- end)

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
