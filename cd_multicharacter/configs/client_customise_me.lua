StartCoords = {}
Config.PedWalk_ALL = {}

Citizen.CreateThread(function()
    ScreenFade(1)
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            ShutdownLoadingScreenNui()
            ScreenFade(1)
            while not IsAuthorised do Wait(0) end
            TriggerServerEvent('cd_multicharacter:GetCharacterInfo')
            TriggerEvent('cd_multicharacter:Start')
            TriggerEvent('pma-voice:toggleMute')
            break
        end
    end
end)
------------------------------------------------------------------------------------------------------
--------------------------------------- EXISTING CHARACTER EVENT -------------------------------------
------------------------------------------------------------------------------------------------------
function CharacterHasLoaded_EXISTING(coords, charid_1, charid_2) --This function is triggered after you have chosen to creater an EXISTING character.
    if Config.ESX_version == '1.1' then
        TriggerServerEvent('es:firstJoinProper', charid_1)
        TriggerEvent('es:allowedToSpawn', charid_1)
    elseif Config.ESX_version == '1.2' then
        TriggerServerEvent('iG:playerJoined', charid_1)
    elseif Config.ESX_version == '1.final' or Config.ESX_version == 'exm' then
        TriggerServerEvent('iG:onPlayerJoined', charid_1)
    end

    SetFocusEntity(GetPlayerPed(PlayerId()))
    if Config.UsingSpawnSelect then
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 256.32,-1055.71,500.00, 300.00,0.00,0.00, 100.00, false, 0)
        ------------------------------------------------------------------------------------------------------
        Wait(2000) --We need to add a wait here to make sure es_extended has enough time to register and load your player data, other wise xPlayer will be nil.
        TriggerEvent('cd_spawnselect:OpenUI')
        --Add any trigger events you need under this wait timer.

        ------------------------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------------------------
    else
        local ped = PlayerPedId()
        RenderScriptCams(false, true, 500, true, true)
        DoScreenFadeIn(3000)
        DisplayHud(true)
        DisplayRadar(true)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(ped, true, 0)
        SetPlayerInvisibleLocally(ped, false)
        SetPlayerInvincible(ped, false)
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
            Citizen.Wait(1)
        end
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
    end
    ------------------------------------------------------------------------------------------------------
    Wait(2000) --We need to add a wait here to make sure es_extended has enough time to register and load your player data, other wise xPlayer will be nil.
    TriggerEvent('cd_dispatch:GrabInfo')
    TriggerServerEvent('cd_identity:IdentityData')
    --Add any trigger events you need under this wait timer.

    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    if Config.SkinScript == 'esx' then
        ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
            if skin ~= nil then
                TriggerEvent('iG_skinchanger:loadSkin', skin)
            else
                print('skin nil')
            end
        end)
    elseif Config.SkinScript == 'other1' or Config.SkinScript == 'other2' then
        TriggerServerEvent('ig-appearance:get_character_current')
        
        --README: You may need to try each of these. Not sure which will work for your skin script.
        --TriggerServerEvent('clothing:checkIfNew')
    end
end


------------------------------------------------------------------------------------------------------
------------------------------------------ NEW CHARACTER EVENT ---------------------------------------
------------------------------------------------------------------------------------------------------
function CharacterHasLoaded_NEW(coords, charid_1, charid_2) --This function is triggered after you have chosen to creater a NEW character.
    local coords = Config.DefaultSpawn
    if Config.ESX_version == '1.1' then
        TriggerServerEvent('es:firstJoinProper', charid_1)
        TriggerEvent('es:allowedToSpawn', charid_1)
    elseif Config.ESX_version == '1.2' then
        TriggerServerEvent('iG:playerJoined', charid_1)
    elseif Config.ESX_version == '1.final' or Config.ESX_version == 'exm' then
        TriggerServerEvent('iG:onPlayerJoined', charid_1)
    end
    local ped = PlayerPedId()
    SetFocusEntity(GetPlayerPed(PlayerId()))
    RenderScriptCams(false, true, 500, true, true)
    DoScreenFadeIn(3000)
    DisplayHud(true)
    DisplayRadar(true)
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true, 0)
    SetPlayerInvisibleLocally(ped, false)
    SetPlayerInvincible(ped, false)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        Citizen.Wait(1)
    end
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    SetEntityHeading(ped, coords.h)
    ------------------------------------------------------------------------------------------------------
    Wait(2000) --We need to add a wait here to make sure es_extended has enough time to register and load your player data, other wise xPlayer will be nil.
    if Config.UsingCDidentity then
        TriggerEvent('cd_identity:OpenIdentityUI', charid_1)
    else
        -- TriggerEvent('esx_skin:openSaveableMenu') --This event will open the esx_skin creation menu.
    end
    --Add any trigger events you need under this wait timer.

    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
end



------------------------------------------------------------------------------------------------------
--------------------------------------------- OTHER --------------------------------------------------
------------------------------------------------------------------------------------------------------
function GetStartCoords(MaxChars)
    --You can change the coords of each character here.
    if MaxChars == 1 then
        StartCoords[1] = {x = -458.8, y = 1601.1, z = 358.22, h = 180.72}
    elseif MaxChars == 2 then
        StartCoords[1] = {x = -458.8, y = 1601.1, z = 358.22, h = 180.72}
        StartCoords[2] = {x = -457.9, y = 1601.3, z = 358.25, h = 167.72}
    elseif MaxChars == 3 then
        StartCoords[1] = {x = -458.8, y = 1601.1, z = 358.22, h = 180.72}
        StartCoords[2] = {x = -457.9, y = 1601.3, z = 358.25, h = 167.72}
        StartCoords[3] = {x = -457.0, y = 1601.5, z = 358.23, h = 158.72}
    elseif MaxChars == 4 then
        StartCoords[1] = {x = -458.8, y = 1601.1, z = 358.22, h = 180.72}
        StartCoords[2] = {x = -457.9, y = 1601.3, z = 358.25, h = 167.72}
        StartCoords[3] = {x = -457.0, y = 1601.5, z = 358.23, h = 158.72}
        StartCoords[4] = {x = -456.0, y = 1601.7, z = 358.21, h = 148.72}
    elseif MaxChars == 5 then
        StartCoords[1] = {x = -458.8, y = 1601.1, z = 358.22, h = 180.72}
        StartCoords[2] = {x = -457.9, y = 1601.3, z = 358.25, h = 167.72}
        StartCoords[3] = {x = -457.0, y = 1601.5, z = 358.23, h = 158.72}
        StartCoords[4] = {x = -456.0, y = 1601.7, z = 358.21, h = 148.72}
        StartCoords[5] = {x = -455.0, y = 1601.9, z = 358.18, h = 140.72}
    end

    --If Config.PedWalk is enabled, these are the the coords which each ped will walk towards.
    if MaxChars == 1 then
        Config.PedWalk_ALL[1] = {x = -459.91, y = 1594.61, z = 359.55, h = 180.72}
    elseif MaxChars == 2 then
        Config.PedWalk_ALL[1] = {x = -459.91, y = 1594.61, z = 359.55, h = 180.72}
        Config.PedWalk_ALL[2] = {x = -459.91, y = 1594.61, z = 359.55, h = 167.72}
    elseif MaxChars == 3 then
        Config.PedWalk_ALL[1] = {x = -459.91, y = 1594.61, z = 359.55, h = 180.72}
        Config.PedWalk_ALL[2] = {x = -459.91, y = 1594.61, z = 359.55, h = 167.72}
        Config.PedWalk_ALL[3] = {x = -459.91, y = 1594.61, z = 359.55, h = 158.72}
    elseif MaxChars == 4 then
        Config.PedWalk_ALL[1] = {x = -459.91, y = 1594.61, z = 359.55, h = 180.72}
        Config.PedWalk_ALL[2] = {x = -459.91, y = 1594.61, z = 359.55, h = 167.72}
        Config.PedWalk_ALL[3] = {x = -459.91, y = 1594.61, z = 359.55, h = 158.72}
        Config.PedWalk_ALL[4] = {x = -459.91, y = 1594.61, z = 359.55, h = 148.72}
    elseif MaxChars == 5 then
        Config.PedWalk_ALL[1] = {x = -459.91, y = 1594.61, z = 359.55, h = 180.72}
        Config.PedWalk_ALL[2] = {x = -459.91, y = 1594.61, z = 359.55, h = 167.72}
        Config.PedWalk_ALL[3] = {x = -459.91, y = 1594.61, z = 359.55, h = 158.72}
        Config.PedWalk_ALL[4] = {x = -459.91, y = 1594.61, z = 359.55, h = 148.72}
        Config.PedWalk_ALL[5] = {x = -459.91, y = 1594.61, z = 359.55, h = 140.72}
    end
end

function SetAllPedSkin(ped, skin)
    if Config.SkinScript == 'esx' then
        TriggerEvent('iG_skinchanger:loadSkin2', ped, skin)
    elseif Config.SkinScript == 'other1' or Config.SkinScript == 'other2' then
        TriggerEvent('ig-appearance:MultiCharSkin', ped, skin)
    end
end

function SwitchCharacters()
    ScreenFade(1)
    TriggerServerEvent('playerDropped', 'multichar-switch_char')
    Wait(1000)
    TriggerServerEvent('cd_multicharacter:GetCharacterInfo')
    TriggerEvent('cd_multicharacter:Start')
end
------------------------------------------------------------------------------------------------------
------------------------------------------ CHAT COMMANDS ---------------------------------------------
------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    if Config.UseCharCommand then
        TriggerEvent('chat:addSuggestion', '/'..Config.UseCharCommand_commandname, L('staff_command_1'), {{ name=L('action_1'), help=L('action_2')}, { name=L('identifier_1'), help=L('identifier_2')}})
    end
    if Config.SwitchCharacters and Config.SwitchCharactersMethod.Command then
        TriggerEvent('chat:addSuggestion', '/'..Config.SwitchCharactersMethod.Command_name, L('switch_char_title'))
    end
end)
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
