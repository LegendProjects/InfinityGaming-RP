ESX = nil
local clipboardEntity

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('iG:getSharedObject', function(obj)
            ESX = obj
        end)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local forceDraw = false
local shouldDraw = false
local shouldOpenMenu = false

RegisterNetEvent('iG-showid:id')
AddEventHandler('iG-showid:id', function()
    forceDraw = not forceDraw
end)


-- RegisterNetEvent('iG-showid:shouldDraw')
-- AddEventHandler('iG-showid:shouldDraw', function(status)
--     shouldDraw = status
-- end)
 

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 178) and shouldDraw == false then
            shouldDraw = true
        elseif IsControlJustReleased(0, 178) and shouldDraw == true then
            shouldDraw = false
        end
    end
end)
]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 178) and IsInputDisabled(0) and shouldDraw == false then
            shouldDraw = true
			Citizen.Wait(200)
        elseif IsControlJustReleased(0, 178) and IsInputDisabled(0) and shouldDraw == true then
            shouldDraw = false
        end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() then
            shouldDraw = false
        end
	end
end)


--Draw Things
Citizen.CreateThread(function()
    local animationState = false
    while true do
        Citizen.Wait(0)
        if animationState ~= shouldDraw then
            animationState = shouldDraw
            if animationState then
                local playerPed = GetPlayerPed(-1)
                ESX.Streaming.RequestAnimDict('missheistdockssetup1clipboard@base', function()
                    TaskPlayAnim(playerPed, 'missheistdockssetup1clipboard@base', 'base', 8.0, -8, -1, 49, 0, 0, 0, 0)
                end)

                clipboardEntity = CreateObject(GetHashKey("p_amb_clipboard_01"), x, y, z, true)
                coords = { x = 0.2, y = 0.1, z = 0.08 }
                rotation = { x = -80.0, y = -20.0, z = 0.0 }
                AttachEntityToEntity(clipboardEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905), coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, 1, 1, 0, 1, 0, 1)
            else
                ClearPedTasks(GetPlayerPed(-1))
                if clipboardEntity ~= nil then
                    DeleteEntity(clipboardEntity)
                    clipboardEntity = nil
                end
            end
        end

        if shouldDraw then
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, v.playerId)
            end
        end
        if forceDraw then
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local x, y, z = table.unpack(v.coords)
                Draw3DTextBig(x, y, z + 1.4, v.playerId)
            end
        end
    end
end)

function Draw3DText(x, y, z, text)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8 * (1 / dist) * (1 / GetGameplayCamFov()) * 100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function Draw3DTextBig(x, y, z, text)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 3 * (1 / dist) * (1 / GetGameplayCamFov()) * 100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, _ = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 50)

    local players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        found_players = true
        table.insert(players_clean, { playerName = GetPlayerName(players[i]), playerId = GetPlayerServerId(players[i]), coords = GetEntityCoords(GetPlayerPed(players[i])) })
    end
    return players_clean
end