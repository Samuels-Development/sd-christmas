local CandyCanes = {}

-- Register Menu for Candy Cane NPC 
lib.registerContext({
    id = 'gift_box_menu',
    title = 'Christmas Gift Shop',
    options = (function()
        local items = {}
        for index, box in ipairs(Config.GiftBoxes) do
            table.insert(items, {
                title = box.name,
                description = 'Exchange the following amount of Candy: x' .. tostring(box.cost),
                icon = "fa-gift",
                onSelect = function()
                    TriggerServerEvent("canes:server:buyBox", index)
                end
            })
        end
        -- Add a close option with an appropriate icon
        table.insert(items, {
            title = 'Close',
            icon = "fa-times",
            onSelect = function()
                lib.hideContext()
            end
        })
        return items
    end)()
})

-- Ped Creation Function
CreatePedAtCoords = function(pedModel, coords, scenario)
    if type(pedModel) == "string" then pedModel = GetHashKey(pedModel) end
    LoadModel(pedModel)
    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z, coords.w, false, false)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, scenario, 0, true)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.qtarget:AddTargetEntity(ped, {
        options = {
            {
                action = function()
                    lib.showContext('gift_box_menu')
                end,
                icon = Config.Ped.Interaction.Icon,
                label = 'Talk..',
                canInteract = function() return true end
            },
        },
        distance = Config.Ped.Interaction.Distance,
    })

    AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
            DeleteEntity(ped)
        end
    end)
    
    return ped
end

-- Thread for Ped Creation
CreateThread(function()
    while not GlobalState.CandyCaneLocation do Wait(0) end
    if Config.Ped.Enable then local ped = CreatePedAtCoords(Config.Ped.Model, GlobalState.CandyCaneLocation, Config.Ped.Scenario) end
end)

-- Blip Creation Thread
CreateThread(function()
    if Config.Ped.Enable and Config.PedBlip.Enable then
        local coords = GlobalState.CandyCaneLocation
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, Config.PedBlip.Sprite)
        SetBlipDisplay(blip, Config.PedBlip.Display)
        SetBlipScale(blip, Config.PedBlip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.PedBlip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.PedBlip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('canes:respawnCane', function(loc)
    local v = GlobalState.CandyCanes[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not CandyCanes[loc] then
        CandyCanes[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(CandyCanes[loc], true, true)
        FreezeEntityPosition(CandyCanes[loc], true)
        SetEntityHeading(CandyCanes[loc], v.heading)
        exports.qtarget:AddTargetEntity(CandyCanes[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = 'Pick up candy cane',
                    action = function()
                        PickupCandy(loc)
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

-- Function for picking up Candy Canes.
PickupCandy = function(k)
    local Player = GetPlayerPed()
    StartProgress("pick_cane", 'Picking up Candy Cane..', 2000, 
        function() -- Completed
            TriggerServerEvent("canes:pickupCane", k)
            ClearPedTasks(Player)
        end, 
        function() -- Not Finished
            ClearPedTasks(Player)
        end
    )
end

RegisterNetEvent("canes:init", function()
    for k, v in pairs(GlobalState.CandyCanes) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        -- print('Creating Candy Cane', k, v.model, v.location.x, v.location.y, v.location.z)
        if not v.taken then
            CandyCanes[k] = CreateObject(v.model, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(CandyCanes[k], true, true)
            FreezeEntityPosition(CandyCanes[k], true)
            SetEntityHeading(CandyCanes[k], v.heading)
            exports.qtarget:AddTargetEntity(CandyCanes[k], {
                options = { 
                    {
                        icon = "fas fa-hand",
                        label = 'Pick up candy cane',
                        action = function()
                            local playerPed = PlayerPedId()
                            if IsPedInAnyVehicle(playerPed) then
                                ShowNotification("You can't reach the candy cane..", "error")
                            else
                                RequestAnimDict('amb@prop_human_bum_bin@idle_a')
                                while not HasAnimDictLoaded('amb@prop_human_bum_bin@idle_a') do Wait(100) end

                                TaskPlayAnim(playerPed, 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, -8.0, -1, 49, 0, false, false, false)
                                PickupCandy(k)
                            end
                        end
                    }
                },
                distance = 3.0
            })
        end
    end
end)

RegisterNetEvent("canes:client:openBox", function(item)
    local playerPed = PlayerPedId()
    RequestAnimDict('anim@gangops@facility@servers@')
    while not HasAnimDictLoaded('anim@gangops@facility@servers@') do Wait(100) end

    TaskPlayAnim(playerPed, 'anim@gangops@facility@servers@', 'hotwire', 8.0, -8.0, -1, 49, 0, false, false, false)
    StartProgress("open_box", 'Opening up Gift Box..', math.random(2000, 3500), 
        function() -- Done
            TriggerServerEvent("canes:server:openBox", item)
            ClearPedTasks(PlayerPedId())
        end, 
        function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end
    )
end)

CreateThread(function()
    while not GlobalState.CandyCanes do Wait(0) end
    TriggerEvent("canes:init")
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('bzzz_xmas_script_lollipop_a')
        TriggerEvent('canes:init')
    end
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
