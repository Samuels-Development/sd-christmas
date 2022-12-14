local QBCore = exports['qb-core']:GetCoreObject()
local CandyCanes = {}

-- Blip Creation

Citizen.CreateThread(function()
for k,v in pairs(Config.traderNPCS) do
    local blip = AddBlipForCoord(v.location)
    SetBlipSprite(blip, 214)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 59)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Christmas Gift Shop")
    EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    local shopData = {}
    shopData[1] = {
        header = Config.text.shopTitle,
        isMenuHeader = true
    }
    
    for i=1, #Config.giftBoxes do
        table.insert(shopData, {
            header = Config.giftBoxes[i].name,
            txt = Config.text.shopItem .. tostring(Config.giftBoxes[i].cost),
            params = {
                event = "canes:client:buyBox",
                args = i
            }
        })
    end
    
    shopData[#shopData+1] = {
        header = Config.text.shopClose,
        txt = "",
        params = {
            event = "qb-menu:closeMenu"
        }
    }
    
    for i, traderNPC in pairs(Config.traderNPCS) do
        local hash = GetHashKey(traderNPC.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
        end
    
        traderNPC.ped = CreatePed(0, hash, traderNPC.location, false, false)
        SetEntityAsMissionEntity(traderNPC.ped, true, true)
        FreezeEntityPosition(traderNPC.ped, true)
        SetEntityInvincible(traderNPC.ped, true)
        SetBlockingOfNonTemporaryEvents(traderNPC.ped, true)
        SetEntityHeading(traderNPC.ped, traderNPC.heading)
        exports['qb-target']:AddTargetEntity(Config.traderNPCS[i].ped, {
            options = {
                {
                    icon = "fas fa-hand",
                    label = Config.text.shopCane,
                    canInteract = function()
                        return true
                    end,
                    action = function()
                        exports['qb-menu']:openMenu(shopData)
                    end
                }
            },
            distance = 3.0
        })
    end
end)

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end

RegisterNetEvent('canes:respawnCane', function(loc)
    local v = GlobalState.CandyCanes[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not CandyCanes[loc] then
        CandyCanes[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(CandyCanes[loc], true, true)
        FreezeEntityPosition(CandyCanes[loc], true)
        SetEntityHeading(CandyCanes[loc], v.heading)
        exports['qb-target']:AddTargetEntity(CandyCanes[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = Config.text.pickupCane,
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", Config.text.actionCane, 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("canes:pickupCane", loc)
                            ClearPedTasks(PlayerPedId())
                        end, function() -- Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                }
            },
            distance = 3.0
        })
    end
end)

RegisterNetEvent('canes:removeCane', function(loc)
    if DoesEntityExist(CandyCanes[loc]) then DeleteEntity(CandyCanes[loc]) end
    CandyCanes[loc] = nil
end)

RegisterNetEvent("canes:init", function()
    for k, v in pairs (GlobalState.CandyCanes) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            CandyCanes[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(CandyCanes[k], true, true)
            FreezeEntityPosition(CandyCanes[k], true)
            SetEntityHeading(CandyCanes[k], v.heading)
            exports['qb-target']:AddTargetEntity(CandyCanes[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = Config.text.pickupCane,
                        action = function()
                            if IsPedInAnyVehicle(PlayerPedId()) then
                                QBCore.Functions.Notify("You can't reach the candy cane..", "error")
                              else
                            QBCore.Functions.Progressbar("pick_cane", Config.text.actionCane, 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("canes:pickupCane", k)
                                ClearPedTasks(PlayerPedId())
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        end
                    end
                    }
                },
                distance = 3.0
            })
        end
    end
end)

RegisterNetEvent("canes:client:buyBox")
AddEventHandler("canes:client:buyBox", function(item)
    TriggerServerEvent("canes:server:buyBox", item)
end)

RegisterNetEvent("canes:client:openBox")
AddEventHandler("canes:client:openBox", function(item)
    QBCore.Functions.Progressbar("open_box", Config.text.openBox, math.random(2000,3500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
		animDict = 'anim@gangops@facility@servers@',
		anim = 'hotwire',
		flags = 16,
	}, {}, {}, function() -- Done
        TriggerServerEvent("canes:server:openBox", item)
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
    end)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('bzzz_xmas_script_lollipop_a')
        TriggerEvent('canes:init')
    end
 end)
 
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('bzzz_xmas_script_lollipop_a')
     TriggerEvent('canes:init')
 end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('bzzz_xmas_script_lollipop_a'))
        for k, v in pairs(CandyCanes) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)
