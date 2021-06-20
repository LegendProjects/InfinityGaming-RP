ig = {}
ig.cayo = {}
playerPed, playerPedId, playerId, playerCoords = nil, nil, nil, nil
ESX = nil
fishing_Level, farming_Level, herblore_Level, slayer_Level, crafting_Level = 0, 0, 0, 0, 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    TriggerEvent('ig-cayo:main:load')
end)

RegisterNetEvent("vy_Base:UpdateSkillData")
AddEventHandler('vy_Base:UpdateSkillData', function(data)
    fishing_Level = data.fishing_Level
    farming_Level = data.farming_Level
    herblore_Level = data.herblore_Level
    slayer_Level = data.slayer_Level
    crafting_Level = data.crafting_Level
end)

Citizen.CreateThread(function()
    while true do
        playerPed = GetPlayerPed(-1)
        playerPedId = PlayerPedId()
        playerId = PlayerId()
        playerCoords = GetEntityCoords(playerPedId)
        Citizen.Wait(1000)
    end
end)

-- Citizen.CreateThread(function()
--     MarkerBlip = AddBlipForCoord(Config.Blips.Marker.Coords.x, Config.Blips.Marker.Coords.y, Config.Blips.Marker.Coords.z)
--     SetBlipSprite(MarkerBlip, Config.Blips.Marker.Sprite)
--     SetBlipDisplay(MarkerBlip, 4)
--     SetBlipScale(MarkerBlip, 0.5)
--     SetBlipAsShortRange(MarkerBlip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString(Config.Blips.Marker.Title)
--     EndTextCommandSetBlipName(MarkerBlip)
-- end)



---------------------------------------------------
------- Debug
---------------------------------------------------
if Config.Debug then

    function debug:print(msg)
        if Config.Debug then
            msg = "^1[^3ig-cayo^1] ^4DEBUG: ^0" .. tostring(msg) .. "^7"
            print(msg)
        end
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(3500)
            ig.cayo:isInZone()
            ig.cayo:CreateScavenger()
        end
    end)

end

