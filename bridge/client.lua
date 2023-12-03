-- Initialize common variables
PlayerLoaded, PlayerData = nil, {}

-- Check if the 'es_extended' resource is started
if Framework == 'esx' then
    -- Get the shared object for 'es_extended'
    ESX = exports[Config.CoreNames.ESX]:getSharedObject()
    
    -- Triggered when a player has loaded into the game
    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        -- Trigger 'onPlayerLoaded' event for custom script
        TriggerEvent('sd_bridge:onPlayerLoaded')
        -- Save player data to PlayerData variable
        PlayerData = xPlayer
        -- Set PlayerLoaded to true
        PlayerLoaded = true
    end)
    
    -- Triggered when a player logs out
    RegisterNetEvent('esx:onPlayerLogout', function()
        -- Clear the PlayerData table
        table.wipe(PlayerData)
        -- Set PlayerLoaded to false
        PlayerLoaded = false
    end)

    -- Triggered when a resource starts
    AddEventHandler('onResourceStart', function(resourceName)
        -- Check if the current resource is 'es_extended' and if the player has loaded
        if GetCurrentResourceName() ~= resourceName or not ESX.PlayerLoaded then 
            return 
        end
        -- Get the player data and set PlayerLoaded to true
        PlayerData = ESX.GetPlayerData()
        PlayerLoaded = true
    end)

    -- Triggered when the 'esx:setPlayerData' event is called
    AddEventHandler('esx:setPlayerData', function(key, value)
        -- Check if the invoking resource is 'es_extended'
        if GetInvokingResource() ~= Config.CoreNames.ESX then 
            return 
        end
        -- Set the PlayerData key to the given value
        PlayerData[key] = value
    end)
    
-- Check if 'qb-core' resource is started
elseif Framework == 'qb' then
    -- Set QBCore variable to core object of the 'qb-core' resource
    QBCore = exports[Config.CoreNames.QBCore]:GetCoreObject()
    
    -- Add a state bag change handler for 'isLoggedIn' state
    AddStateBagChangeHandler('isLoggedIn', '', function(_bagName, _key, value, _reserved, _replicated)
        -- If the value is true, get the player data, else wipe the PlayerData table
        if value then
            PlayerData = QBCore.Functions.GetPlayerData()
        else
            table.wipe(PlayerData)
        end
        -- Set the PlayerLoaded variable to the value of 'isLoggedIn'
        PlayerLoaded = value
    end)
    
    -- Register event for player loaded
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        TriggerEvent('sd_bridge:onPlayerLoaded')
    end)
    
    -- Add an event handler for resource start
    AddEventHandler('onResourceStart', function(resourceName)
        -- Check if the resource name is the same as the current resource name and the player is logged in
        if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then
            return
        end
        -- Get the player data and set the PlayerLoaded variable to true
        PlayerData = QBCore.Functions.GetPlayerData()
        PlayerLoaded = true
    end)
    
    -- Register event for player data change
    RegisterNetEvent('QBCore:Player:SetPlayerData', function(newPlayerData)
        -- Check if the event was triggered by 'qb-core' resource and source is not empty
        if source ~= '' and GetInvokingResource() ~= Config.CoreNames.QBCore then
            return
        end
        -- Set the PlayerData table to the new player data
        PlayerData = newPlayerData
    end)
else
    -- If neither 'es_extended' nor 'qb-core' is running, print error
    print("Error: Neither ESX nor QBCore resources are running!")
    return
end

-- Helper function to load models
LoadModel = function(model)
	if not HasModelLoaded(model) and IsModelInCdimage(model) then
		RequestModel(model)

        print('Loading model', model)
	
		while not HasModelLoaded(model) do
            print('Waiting for model', model)
			Wait(1)
		end
	end
end

-- Function to display a notification
ShowNotification = function(message, type)
    -- Check if the ox_lib (library) is available
   if lib ~= nil and Config.OxSettings.Notifications then
       -- Display notification using ox_lib
       lib.notify({
           title = 'Gift Shop',
           description = message or false,
           id = id or false,
           position = Config.OxSettings.NotificationsPos,
           icon = "fa-tree",
           duration = 3500,
           type = type
       })
   else
       -- Display notification using the respective framework's method if ox_lib isn't imported.
       if Framework == 'esx' then
           ESX.ShowNotification(message)
       elseif Framework == 'qb' then
        print('Showing notification', message, type or 'error')
           QBCore.Functions.Notify(message, type)
       end
   end
end

-- Event to show a notification to the player
RegisterNetEvent('sd_bridge:notification', function(msg, type)
    -- Call the ShowNotification function to display the notification
    ShowNotification(msg, type)
end)

-- Function to start a progress bar
StartProgress = function(identifier, label, duration, completed, notfinished)
    -- Check if the ox_lib (library) is available for progress bar generation
    if lib ~= nil and Config.OxSettings.ProgressBars then
        -- Determine the type of progress bar from the configuration settings
        if Config.OxSettings.ProgressBarPos == 'circular' then
            -- Initiate a circular progress bar using ox_lib functionalities
            if lib.progressCircle({
                duration = duration,  
                useWhileDead = false, 
                canCancel = true,     
                disable = { move = true }  
            }) then 
                completed()
            else 
                notfinished()
            end
        elseif Config.OxSettings.ProgressBarPos == 'normal' then
            -- Initiate a standard linear progress bar using ox_lib functionalities
            if lib.progressBar({
                duration = duration,  
                label = label,      
                useWhileDead = false,
                canCancel = true,  
                disable = { move = true } 
            }) then 
                completed()
            else 
                notfinished()
            end
        end
    else
        -- If ox_lib isn't available, determine which Framework should be used for the progress bar
        if Framework == 'esx' then
            -- Use the ESX framework's progress bar functionality
            exports.esx_progressbar:Progressbar(label, duration, {
                FreezePlayer = true,  
                onFinish = function()
                    completed()
                end
            })
        elseif Framework == 'qb' then
            -- Use the QB framework's progress bar functionalities
            QBCore.Functions.Progressbar(identifier, label, duration, false, true, {
                disableMovement = true,      
                disableCarMovement = true,    
                disableMouse = false,         
                disableCombat = true,         
            }, {}, {}, {}, completed, notfinished)
        end
    end
end
