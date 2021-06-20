------------------------------------------------------------------------------------------------------
----------------------------------------------- MAIN -------------------------------------------------
------------------------------------------------------------------------------------------------------
RegisterNetEvent('cd_spawnselect:OpenUI')
AddEventHandler('cd_spawnselect:OpenUI', function(coords)
    while Authorised == false do Wait(0) end
    OpenSpawnSelectUI(coords)
end)
------------------------------------------------------------------------------------------------------
---------------------------------------- CHAT COMMANDS -----------------------------------------------
------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    if Config.PersonalSpawn then --Custmoise this for your server
        TriggerEvent('chat:addSuggestion', '/'..Config.CommandName, 'Customise and choose a personal spawn location', {{ name="action", help='[show / set / delete]'}, { name="name", help='Enter the name of your chosen spawn location'}})
    end
end)

if Config.EnableTestCommand then
    RegisterCommand('openspawnselect', function()
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        TriggerEvent('cd_spawnselect:OpenUI', {x = coords.x, y = coords.y, z = coords.z, h = GetEntityHeading(ped)})
    end)
end
------------------------------------------------------------------------------------------------------
------------------------------------------ NOTIFICATIONS ---------------------------------------------
------------------------------------------------------------------------------------------------------
function Notification(notif_type, message)
    if notif_type ~= nil and message ~= nil then
        if Config.NotificationType.client == 'chat' then
            TriggerEvent('chatMessage', message)

        elseif Config.NotificationType.client == 'mythic_old' then
            if notif_type == 1 then
                exports['mythic_notify']:DoCustomHudText('success', message, 10000)
            elseif notif_type == 2 then
                exports['mythic_notify']:DoCustomHudText('inform', message, 10000)
            elseif notif_type == 3 then
                exports['mythic_notify']:DoCustomHudText('error', message, 10000)
            end

        elseif Config.NotificationType.client == 'mythic_new' then
            if notif_type == 1 then
                exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 2 then
                exports['mythic_notify']:SendAlert('inform', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 3 then
                exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.NotificationType.client == 'esx' then
            ESX.ShowNotification(message)

        elseif Config.NotificationType.client == 'custom' then
            --enter custom notification here

        end
    end
end
------------------------------------------------------------------------------------------------------
---------------------------------- FRAMEWORK FUNCTIONS -----------------------------------------------
------------------------------------------------------------------------------------------------------
function GetJob()
    if Config.UseESX then
        while ESX.PlayerData == nil or ESX.PlayerData.job == nil or ESX.PlayerData.job.name == nil do
            Wait(0)
        end
        return ESX.PlayerData.job.name
    else
        return --add your non esx job checks here - (return the jobname as a string).
    end
end
------------------------------------------------------------------------------------------------------
------------------------------------------ OTHER -----------------------------------------------------
------------------------------------------------------------------------------------------------------
function HasFullySpawnedIn(chosenPosition, lastPosition)
    --lastPosition = the clients saved last position in the database (in vector3 format).
    --chosenPosition = the position you choose to spawn (in vector3 format).

    --You can add extra events here after the player has been spawned in.
    TriggerEvent('EMERG:MOTD:OpenMOTD')
    TriggerEvent('vy_Admin:Unfreeze')
    TriggerEvent('pma-voice:toggleMute')
	local ped = GetPlayerPed(-1)
	if GetPedMaxHealth(ped) ~= 200 and not IsEntityDead(ped) then
		SetPedMaxHealth(ped, 200)
		SetEntityHealth(ped, GetEntityHealth(ped) + 25)
    end
    
end