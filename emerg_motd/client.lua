RegisterNUICallback('discord', function(data, sb)
	local url = data.url
	local s_dui = CreateDui(url, 50, 50)
	Wait(5000)
	DestroyDui(s_dui)
end)

RegisterNUICallback('close', function(data, cb)
	SendNUIMessage({
		type = 'hideMOTD'
	})
	SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
	Wait(100)
	RegisterCommand(config.command, function(source, args, raw)
		SendNUIMessage({
			type = 'showMOTD',
			username = GetPlayerName(PlayerId(-1))
		})
		SetNuiFocus(true, true)
	end)
	TriggerEvent('chat:addSuggestion', '/' .. config.command, 'Opens the message of the day.', {})	
end)

local spawned = false
AddEventHandler("playerSpawned", function ()
	if config.openOnSpawn then
		if not spawned then
			SendNUIMessage({
				type = 'showMOTD',
				username = GetPlayerName(PlayerId(-1))
			})
			SetNuiFocus(true, true)
			spawned = true
		end
	end

	if config.openOnSpawnOnce then
		TriggerServerEvent('EMERG:MOTD:Spawned')
	end
end)

RegisterNetEvent('EMERG:MOTD:OpenMOTD')
AddEventHandler('EMERG:MOTD:OpenMOTD', function()
	SendNUIMessage({
		type = 'showMOTD',
		username = GetPlayerName(PlayerId(-1))
	})
	SetNuiFocus(true, true)
end)

