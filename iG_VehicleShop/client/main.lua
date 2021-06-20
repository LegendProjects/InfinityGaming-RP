local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local actionDisplayed         = false
local PlayerData, CurrentActionData, currentTask = {}, {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined  = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
local LastZone = nil
local isInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local testdrive_timer 		  = 25
local inVehicle = false

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.TriggerServerCallback('iG_VehicleShop:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)
	Citizen.Wait(1000)
	ESX.TriggerServerCallback('iG_VehicleShop:getCategories', function (categories)
		Categories = categories
	end)
	
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('iG_VehicleShop:sendCategories')
AddEventHandler('iG_VehicleShop:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('iG_VehicleShop:sendVehicles')
AddEventHandler('iG_VehicleShop:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function StartShopRestriction()

	Citizen.CreateThread(function()
		while isInShopMenu do
			Citizen.Wait(1)
	
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)

end

RegisterNUICallback('TestDrive', function(data, cb) 
	SetNuiFocus(false, false)
	
	local model = data.model
	local playerPed = PlayerPedId()
	local playerpos = GetEntityCoords(playerPed)
	
	isInShopMenu = false
	-- exports['mythic_notify']:SendAlert('START','waiting','vermelho',_U('wait_vehicle'))
	SetEntityCoords(playerPed, vector3(-1728.8, -2909.84, 13.96), false, false, false, true)
	ESX.Game.SpawnVehicle(model, vector3(-1728.8, -2909.84, 13.96), 180.0, function(vehicle)
		-- exports['mythic_notify']:SendAlert('END','waiting')
		SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
		SetVehicleNumberPlateText(vehicle, "TEST")
		-- ESX.ShowNotification(_U('testdrive_notification',testdrive_timer))
		Citizen.CreateThread(function () 
			local counter = testdrive_timer
			
			while counter > 0 do 
				exports['mythic_notify']:SendAlert('inform', _U('testdrive_timer',counter),700)
				counter = counter - 2
				Citizen.Wait(2000)
			end
			DeleteVehicle(vehicle)
			SetEntityCoords(playerPed, playerpos, false, false, false, false)

			ESX.ShowNotification(_U('testdrive_finished'))
		end)

	end)
end)

RegisterNUICallback('CloseMenu', function(data, cb)
    SetNuiFocus(false, false)
	isInShopMenu = false
	cb(false)
end)


RegisterCommand('closeshop', function() 
	SetNuiFocus(false, false)
    isInShopMenu = false
end)

function OpenShopMenu()

	local vehicle = {}

	if not isInShopMenu then
		isInShopMenu = true
		SetNuiFocus(true, true)
		
		SendNUIMessage({
            show = true,
			cars = Vehicles,
			categories = Categories
        })
	end

end


RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function (job)
	ESX.PlayerData.job = job
end)

-- AddEventHandler('iG_VehicleShop:hasEnteredMarker', function (zone)
-- 	if zone == 'Shop' then

-- 		CurrentAction     = 'shop_menu'
-- 		CurrentActionMsg  = _U('shop_menu')
-- 		CurrentActionData = {}
-- 		actionDisplayed = true

-- 	end
-- end)

-- AddEventHandler('iG_VehicleShop:hasExitedMarker', function (zone)
-- 	if not isInShopMenu then
-- 		ESX.UI.Menu.CloseAll()
-- 	end

-- 	CurrentAction = nil
-- end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if isInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()

			local playerPed = PlayerPedId()
			
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Dealerships.ShopName.Shop.Pos)
		end
	end
end)

function Draw3DText(x,y,z,text,scale)
	local onScreen, _x, _y = World3dToScreen2d(x,y,z)
	local pX,pY,pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 255)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len( text )) / 700
	DrawRect(_x, _y + 0.0150, 0.06 +factor, 0.03, 0, 0, 0, 200)
end

-- -- Enter / Exit marker events
-- Citizen.CreateThread(function ()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		local coords      = GetEntityCoords(PlayerPedId())
-- 		local isInMarker  = false
-- 		local currentZone = nil

-- 		for k,v in pairs(Config.Zones) do
-- 			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 3.5) then
-- 				Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z, _U('watch_catalog'),0.4)
-- 				isInMarker  = true
-- 				currentZone = k
-- 			end
-- 		end

-- 		if isInMarker  then
-- 			HasAlreadyEnteredMarker = true
-- 			LastZone                = currentZone
-- 			TriggerEvent('iG_VehicleShop:hasEnteredMarker', currentZone)
-- 		end

-- 		if not isInMarker and HasAlreadyEnteredMarker then
-- 			HasAlreadyEnteredMarker = false
-- 			TriggerEvent('iG_VehicleShop:hasExitedMarker', LastZone)
-- 		end
-- 	end
-- end)

-- -- Key controls
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		if CurrentAction == nil then
-- 			Citizen.Wait(500)
-- 		elseif IsControlJustReleased(0, Keys['E']) then
-- 			if CurrentAction == 'shop_menu' then
-- 				OpenShopMenu()
-- 			end
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							CITIZEN THREAD (0)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentStation, currentPart, currentPartNum

		for k,v in pairs(Config.Dealerships) do
			for i=1, #v.Shop, 1 do
				local distance = GetDistanceBetweenCoords(coords, v.Shop[i], true)

				if distance < Config.DrawDistance then
					DrawMarker(20, v.Shop[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Shop', i
				end
			end
		end
	
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
			if
			(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('iG_VehicleShop:hasExitedMarker', LastStation, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation             = currentStation
			LastPart                = currentPart
			LastPartNum             = currentPartNum

			TriggerEvent('iG_VehicleShop:hasEnteredMarker', currentStation, currentPart, currentPartNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('iG_VehicleShop:hasExitedMarker', LastStation, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(1000)
		end
    end
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							CITIZEN THREAD (1000)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(1000)
		end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())
			currentTask.busy = false
		end
		Citizen.Wait(0)
	end
end)



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							MARKER EVENT HANDLERS
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


AddEventHandler('iG_VehicleShop:hasEnteredMarker', function(station, part, partNum)
    if part == 'Shop' then
		CurrentAction = 'shop_menu'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to access the shop.'
		CurrentActionData = {}
		actionDisplayed = true
    end
end)

AddEventHandler('iG_VehicleShop:hasExitedMarker', function(zone)
	if not isInShopMenu then
        ESX.UI.Menu.CloseAll()
	end
	
    CurrentActionMsg = {}
	CurrentAction = nil
end)