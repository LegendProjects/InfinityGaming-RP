------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------

players = {}
banlist = {}
cachedplayers = {}

RegisterNetEvent("iG_Admin:adminresponse")
RegisterNetEvent("iG_Admin:amiadmin")
RegisterNetEvent("iG_Admin:fillBanlist")
RegisterNetEvent("iG_Admin:requestSpectate")

RegisterNetEvent("iG_Admin:SetSetting")
RegisterNetEvent("iG_Admin:SetLanguage")

RegisterNetEvent("iG_Admin:TeleportRequest")
RegisterNetEvent("iG_Admin:SlapPlayer")
RegisterNetEvent("iG_Admin:FreezePlayer")
RegisterNetEvent("iG_Admin:CaptureScreenshot")
RegisterNetEvent("iG_Admin:GetPlayerList")
RegisterNetEvent("iG_Admin:GetInfinityPlayerList")
RegisterNetEvent("iG_Admin:fillCachedPlayers")


AddEventHandler('iG_Admin:adminresponse', function(response,permission)
	permissions[response] = permission
	if permission == true then
		isAdmin = true
		exports['ig-keybinds']:RegisterKeybind('OpenAdminMenu', '[STAFF] Open Admin Menu', 'PAGEUP', OpenAdminMenu)
	end
end)

AddEventHandler('iG_Admin:SetSetting', function(setting,state)
	settings[setting] = state
end)

AddEventHandler('iG_Admin:SetLanguage', function(newstrings)
	strings = newstrings
end)


AddEventHandler("iG_Admin:fillBanlist", function(thebanlist)
	banlist = thebanlist
end)

AddEventHandler("iG_Admin:fillCachedPlayers", function(thecached)
	if permissions.ban then
		cachedplayers = thecached
	end
end)

AddEventHandler("iG_Admin:GetPlayerList", function(players)
	playerlist = players
end)

AddEventHandler("iG_Admin:GetInfinityPlayerList", function(players)
	playerlist = players
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
		if frozen then
			FreezeEntityPosition(PlayerPedId(), frozen)
			if IsPedInAnyVehicle(PlayerPedId(), true) then
				FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
			end 
		end
  end
end)

AddEventHandler('iG_Admin:requestSpectate', function(playerId, tgtCoords)
	local localPlayerPed = PlayerPedId()
	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId))) end
	if playerId == GetPlayerServerId(PlayerId()) then 
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
		end
		spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
		frozen = false
		return 
	else
		oldCoords = GetEntityCoords(PlayerPedId())
	end
	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
	frozen = true
	Wait(500)
	local playerId = GetPlayerFromServerId(playerId)
	local adminPed = localPlayerPed
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	--Wait(500)
	--SetEntityCoords(localPlayerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
end)

AddEventHandler('iG_Admin:TeleportRequest', function(playerId, tgtCoords)
	if (tgtCoords.x == 0.0 and tgtCoords.y == 0.0 and tgtCoords.z == 0.0) then
		local tgtPed = GetPlayerPed(GetPlayerFromServerId(id))
		local tgtCoords = GetEntityCoords(tgtPed)
		SetEntityCoords(PlayerPedId(), tgtCoords.x, tgtCoords.y, tgtCoords.z,0,0,0, false)
	else
		SetEntityCoords(PlayerPedId(), tgtCoords.x, tgtCoords.y, tgtCoords.z,0,0,0, false)
	end
end)

AddEventHandler('iG_Admin:SlapPlayer', function(slapAmount)
	local ped = PlayerPedId()
	if slapAmount > GetEntityHealth(ped) then
		ApplyDamageToPed(ped, 5000, false, true,true)
	else
		ApplyDamageToPed(ped, slapAmount, false, true,true)
	end
end)


RegisterCommand("kick", function(source, args, rawCommand)
	local source=source
	local reason = ""
	for i,theArg in pairs(args) do
		if i ~= 1 then -- make sure we are not adding the kicked player as a reason
			reason = reason.." "..theArg
		end
	end
	if args[1] and tonumber(args[1]) then
		TriggerServerEvent("iG_Admin:kickPlayer", tonumber(args[1]), reason)
	end
end, false)

RegisterCommand("ban", function(source, args, rawCommand)
	if args[1] and tonumber(args[1]) then
		local reason = ""
		for i,theArg in pairs(args) do
			if i ~= 1 then
				reason = reason.." "..theArg
			end
		end
		if args[1] and tonumber(args[1]) then
			TriggerServerEvent("iG_Admin:banPlayer", tonumber(args[1]), reason, false, GetPlayerName(args[1]))
		end
	end
end, false)

AddEventHandler('iG_Admin:FreezePlayer', function(toggle)
	frozen = toggle
	FreezeEntityPosition(PlayerPedId(), frozen)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
	end 
end)


AddEventHandler('iG_Admin:CaptureScreenshot', function(toggle, url, field)
	exports['iG-Admin']:requestScreenshotUpload(GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php'), GetConvar("ea_screenshotfield", 'files[]'), function(data)
			TriggerServerEvent("iG_Admin:TookScreenshot", data)
	end)
end)

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then enable = false end
	if(enable)then
			if targetPed == playerPed then
				Wait(500)
				targetPed = GetPlayerPed(target)
			end
			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)

			DrawPlayerInfo(target)
			if not RedM then
				ShowNotification(string.format(GetLocalisedText("spectatingUser"), name))
			end
	else
			if oldCoords then
				RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
				SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			end
			NetworkSetInSpectatorMode(false, targetPed)
			StopDrawPlayerInfo()
			if not RedM then
				ShowNotification(GetLocalisedText("stoppedSpectating"))
			end
			frozen = false

	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end
