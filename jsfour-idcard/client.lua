ESX = nil

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)
--[[
function OpenIDCardMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'id_card_menu', {
		title = "ID Card Menu",
		align = 'right',
		elements = {
			{ label = 'Present Identification', value = 'present_identification' }
		}
	}, function(data, menu)
		if data.current.value == 'present_identification' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'present_identification', {
				title = "Present Identification",
				align = 'right',
				elements = {
					{label = 'Check your ID', value = 'checkID'},
					{label = 'Show your ID', value = 'showID'},
				}
			}, function(data, menu)
				local val = data.current.value
				
				if val == 'checkID' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
				else
					local player, distance = ESX.Game.GetClosestPlayer()
					
					if distance ~= -1 and distance <= 3.0 then
						if val == 'showID' then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
						end
					else
					  ESX.ShowNotification('No players nearby')
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end
]]--