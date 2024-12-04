local locale = SD.Locale.T -- Variable to abbreviate the translation function
local SpawnedCandyCanes = {} -- Table to track spawned candy canes

-- Player's candy cane count and claimed milestones
local PlayerCandyCaneCount = 0
local ClaimedMilestones = {}

-- This function registers the exchange/shop menu.
local OpenExchangeMenu = function()
    local options = {}
    for index, box in ipairs(Config.GiftBoxes) do
        local boxName = locale('gift_box.' .. box.name_key)
        table.insert(options, {
            title = boxName,
            description = locale('gift_shop.exchange_description', {cost = box.cost, name = boxName}),
            icon = "fa-gift",
            onSelect = function()
                TriggerServerEvent("canes:server:buyBox", index)
            end
        })
    end
    table.insert(options, {
        title = locale('gift_shop.back'),
        icon = "fa-arrow-left",
        onSelect = function()
            lib.showContext('gift_box_menu')
        end
    })
    lib.registerContext({
        id = 'exchange_menu',
        title = locale('gift_shop.exchange_title'),
        options = options
    })
    lib.showContext('exchange_menu')
end

-- This function registers the gift shop menu.
local RegisterGiftShopMenu = function()
    lib.registerContext({
        id = 'gift_box_menu',
        title = locale('gift_shop.title'),
        options = {
            {
                title = locale('gift_shop.exchange_title'),
                description = locale('gift_shop.exchange_description_main'),
                icon = "fa-gift",
                onSelect = function()
                    OpenExchangeMenu()
                end
            },
            {
                title = locale('milestone.menu_option'),
                description = locale('milestone.menu_option_description'),
                icon = "fa-trophy",
                onSelect = function()
                    TriggerServerEvent("canes:server:getMilestoneData")
                end
            },
        }
    })
end

-- This function spawns the Santa NPC and sets up interactions.
local SpawnSantaNPC = function()
    local pedModel = Config.Ped.Model
    local coords = GlobalState.CandyCaneLocation
    local scenario = Config.Ped.Scenario

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, scenario, 0, true)
    SetEntityInvincible(ped, true)

    exports.qtarget:AddTargetEntity(ped, {
        options = {
            {
                icon = Config.Ped.Interaction.Icon,
                label = locale('target.talk_to_santa'),
                action = function()
                    lib.showContext('gift_box_menu')
                end,
                canInteract = function()
                    return true
                end
            }
        },
        distance = Config.Ped.Interaction.Distance,
    })

    AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
            DeleteEntity(ped)
        end
    end)
end

-- This function creates the blip for Santa's location.
local CreateSantaBlip = function()
    local coords = GlobalState.CandyCaneLocation
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.PedBlip.Sprite)
    SetBlipDisplay(blip, Config.PedBlip.Display)
    SetBlipScale(blip, Config.PedBlip.Scale)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, Config.PedBlip.Colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(locale('gift_shop.title'))
    EndTextCommandSetBlipName(blip)
end

-- Initialize the script.
CreateThread(function()
    while not GlobalState.CandyCaneLocation do
        Wait(0)
    end
    if Config.Ped.Enable then
        SpawnSantaNPC()
    end
    if Config.PedBlip.Enable then
        CreateSantaBlip()
    end
    RegisterGiftShopMenu()
end)

-- This function handles the player picking up a Candy Cane.
--- @param index number The index of the Candy Cane.
local PickupCandyCane = function(index)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        SD.ShowNotification(locale('error.need_to_be_on_foot'), "error")
        return
    end

    SD.LoadAnim('pickup_object')

    TaskPlayAnim(playerPed, 'pickup_object', 'pickup_low', 8.0, -8.0, 2000, 0, 0, false, false, false)
    SD.StartProgress('looting', locale('progress.looting_crate'), math.random(1500, 3000),
    function()
        ClearPedTasks(playerPed)
        TriggerServerEvent("canes:pickupCane", index)
        PlayerCandyCaneCount = PlayerCandyCaneCount + 1
    end, function()
        ClearPedTasks(playerPed)
        SD.ShowNotification(locale('error.canceled'), 'error', 2500)
    end)
end

-- This function spawns a Candy Cane object and sets up interactions.
--- @param index number The index of the Candy Cane.
--- @param caneData table The data for the Candy Cane.
local SpawnCandyCane = function(index, caneData)
    local modelHash = GetHashKey(caneData.model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
    end

    local caneObject = CreateObject(modelHash, caneData.location.x, caneData.location.y, caneData.location.z, false, true, true)
    SetEntityAsMissionEntity(caneObject, true, true)
    FreezeEntityPosition(caneObject, true)
    SetEntityHeading(caneObject, caneData.heading)

    exports.qtarget:AddTargetEntity(caneObject, {
        options = {
            {
                icon = "fas fa-candy-cane",
                label = locale('target.pick_up_candy_cane'),
                action = function()
                    PickupCandyCane(index)
                end
            }
        },
        distance = 3.0
    })

    SpawnedCandyCanes[index] = caneObject
end

-- This function removes a Candy Cane object.
--- @param index number The index of the Candy Cane to remove.
local RemoveCandyCane = function(index)
    local caneObject = SpawnedCandyCanes[index]
    if caneObject and DoesEntityExist(caneObject) then
        DeleteEntity(caneObject)
    end
    SpawnedCandyCanes[index] = nil
end

-- This function listens for the 'canes:removeCane' event to remove a Candy Cane object.
--- @param index number The index of the Candy Cane to remove.
RegisterNetEvent('canes:removeCane', function(index)
    RemoveCandyCane(index)
end)

-- This function listens for the 'canes:respawnCane' event to respawn a Candy Cane object.
--- @param index number The index of the Candy Cane to respawn.
RegisterNetEvent('canes:respawnCane', function(index)
    local caneData = GlobalState.CandyCanes[index]
    if caneData then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - caneData.location)
        if distance < 100.0 then
            SpawnCandyCane(index, caneData)
        end
    end
end)

-- This thread monitors the player's proximity to candy canes and spawns or despawns them accordingly.
CreateThread(function()
    while not GlobalState.CandyCanes do
        Wait(100)
    end

    Wait(2500)
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for index, caneData in pairs(GlobalState.CandyCanes) do
            if not caneData.taken then
                local distance = #(playerCoords - caneData.location)
                if distance < 5.0 then
                    if not SpawnedCandyCanes[index] then
                        SpawnCandyCane(index, caneData)
                    end
                else
                    if SpawnedCandyCanes[index] then
                        RemoveCandyCane(index)
                    end
                end
            else
                if SpawnedCandyCanes[index] then
                    RemoveCandyCane(index)
                end
            end
        end
        Wait(1000)
    end
end)

-- This function handles the 'onResourceStop' event to clean up spawned candy canes.
--- @param resourceName string The name of the resource that is stopping.
local OnResourceStop = function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for index, caneObject in pairs(SpawnedCandyCanes) do
            if DoesEntityExist(caneObject) then
                DeleteEntity(caneObject)
            end
            SpawnedCandyCanes[index] = nil
        end
    end
end

AddEventHandler('onResourceStop', OnResourceStop)

-- This function displays the Milestone menu after receiving data from the server.
RegisterNetEvent("canes:client:receiveMilestoneData", function(candyCaneCount, claimedMilestones)
    PlayerCandyCaneCount = candyCaneCount
    ClaimedMilestones = claimedMilestones

    local options = {}
    for index, milestone in ipairs(Config.Milestones) do
        local status = ""
        local requiredCount = milestone.required_count
        local title = locale('milestone.titles.' .. milestone.title_key)
        if ClaimedMilestones[index] then
            status = locale('milestone.status.claimed')
        elseif PlayerCandyCaneCount >= requiredCount then
            status = locale('milestone.status.available')
        else
            status = locale('milestone.status.locked')
        end

        table.insert(options, {
            title = title,
            description = locale('milestone.description', {status = status, required = requiredCount}),
            icon = "fa-trophy",
            disabled = ClaimedMilestones[index] or PlayerCandyCaneCount < requiredCount,
            onSelect = function()
                TriggerServerEvent("canes:server:claimMilestone", index)
            end
        })
    end

    table.insert(options, {
        title = locale('gift_shop.back'),
        icon = "fa-arrow-left",
        onSelect = function()
            lib.showContext('gift_box_menu')
        end
    })

    lib.registerContext({
        id = 'milestone_menu',
        title = locale('milestone.menu_title', {count = PlayerCandyCaneCount}),
        options = options
    })

    lib.showContext('milestone_menu')
end)
