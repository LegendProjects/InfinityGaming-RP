ESX = nil
local menuEnabled = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent('iG_Lockpicking:openlockpick')
AddEventHandler('iG_Lockpicking:openlockpick', function()
	ToggleActionMenu()
end)



function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showPlayerMenu = true
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end
end



RegisterNUICallback('close', function(data, cb)
  ToggleActionMenu()
  cb('ok')
end)


RegisterNUICallback('win', function(data, cb)
	SetNuiFocus( false, false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	TriggerServerEvent('iG_Lockpicking:sv_result', true)
  	cb('ok')
end)

RegisterNUICallback('lose', function(data, cb)
	SetNuiFocus( false, false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	TriggerServerEvent('iG_Lockpicking:sv_result', false)
	cb('ok')
end)
