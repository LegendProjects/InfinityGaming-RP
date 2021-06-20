local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, WasInPound, WasinJPound = false, false, false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil or ESX.GetPlayerData().job2 == nil or ESX.GetPlayerData().org == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	CreateBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	RefreshJobBlips()
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    ESX.PlayerData.job = job
	DeleteJobBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('iG:setJob2')
AddEventHandler('iG:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
	DeleteJobBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('iG:setOrg')
AddEventHandler('iG:setOrg', function(org)
    ESX.PlayerData.org = org
	DeleteJobBlips()
	RefreshJobBlips()
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Start of Ambulance Code
function ListOwnedAmbulanceMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('<span style="color:lightblue;">%s</span> - <span style="color:darkgoldenrod;">%s</span>'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedAmbulanceCars', function(ownedAmbulanceCars)
		if #ownedAmbulanceCars == 0 then
			ESX.ShowNotification(_U('garage_no_ambulance'))
		else
			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage	   = tostring(math.floor(v.vehicle.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

				if v.striked then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
				elseif v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
				end	

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedAmbulanceAircrafts', function(ownedAmbulanceAircrafts)
			if #ownedAmbulanceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_ambulance_aircraft'))
			else
				for _,v in pairs(ownedAmbulanceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = GetLabelText(aheadVehName)
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('<span style="color:rgb(0, 204, 255);">%s</span> - <span style="color:rgb(255, 204, 0);">%s</span> - '):format(vehicleName, plate)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(vehicleName, plate)

					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="color:rgb(0, 255, 0);">%s</span>'):format(_U('loc_garage'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="color:rgb(255, 51, 0);">%s</span>'):format(_U('loc_pound'))
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_ambulance', {
				title = _U('garage_ambulance'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedAmbulanceMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAmbulanceMenu()
	if WasinJPound then
		-- ESX.ShowNotification(_U('must_wait', Config.JPoundWait))
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.JPoundWait .. ' minutes before using the impound again.')
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedAmbulanceCars', function(ownedAmbulanceCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_ambulance', {
				title = _U('pound_ambulance', ESX.Math.GroupDigits(Config.AmbulancePoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyAmbulance', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payAmbulance')
								if Config.UsePoundTimer then
									WasinJPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Ambulance Code

-- Start of Police Code
function ListOwnedPoliceMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('<span style="color:rgb(0, 204, 255);">%s</span> - <span style="color:rgb(255, 204, 0);">%s</span>'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedPoliceCars', function(ownedPoliceCars)
		if #ownedPoliceCars == 0 then
			ESX.ShowNotification(_U('garage_no_police'))
		else
			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage	   = tostring(math.floor(v.vehicle.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

				if v.striked then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
				elseif v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
				end	

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedPoliceAircrafts', function(ownedPoliceAircrafts)
			if #ownedPoliceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_police_aircraft'))
			else
				for _,v in pairs(ownedPoliceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = GetLabelText(aheadVehName)
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('<span style="color:rgb(0, 204, 255);">%s</span> - <span style="color:rgb(255, 204, 0);">%s</span> - '):format(vehicleName, plate)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(vehicleName, plate)

					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="color:rgb(0, 255, 0);">%s</span>'):format(_U('loc_garage'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="color:rgb(255, 51, 0);">%s</span>'):format(_U('loc_pound'))
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_police', {
				title = _U('garage_police'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedPoliceMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedPoliceMenu()
	if WasinJPound then
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.JPoundWait .. ' minutes before using the impound again.')
		-- ESX.ShowNotification(_U('must_wait', Config.JPoundWait))
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedPoliceCars', function(ownedPoliceCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_police', {
				title = _U('pound_police', ESX.Math.GroupDigits(Config.PolicePoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyPolice', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payPolice')
								if Config.UsePoundTimer then
									WasinJPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Police Code

-- Start of Aircraft Code
function ListOwnedAircraftsMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('<span style="color:rgb(0, 204, 255);">%s</span> - <span style="color:rgb(255, 204, 0);">%s</span>'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			ESX.ShowNotification(_U('garage_no_aircrafts'))
		else
			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage	   = tostring(math.floor(v.vehicle.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

				if v.striked then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
				elseif v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
				end	

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_aircraft', {
			title = _U('garage_aircrafts'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('aircraft_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedAircraftsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAircraftsMenu()
	if WasInPound then
		-- ESX.ShowNotification(_U('must_wait', Config.PoundWait))
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.PoundWait .. ' minutes before using the impound again.')
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedAircrafts', function(ownedAircrafts)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_aircraft', {
				title = _U('pound_aircrafts', ESX.Math.GroupDigits(Config.AircraftPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyAircrafts', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payAircraft')
								if Config.UsePoundTimer then
									WasInPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Aircraft Code

-- Start of Boat Code
function ListOwnedBoatsMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('<span style="color:rgb(0, 204, 255);">%s</span> - <span style="color:rgb(255, 204, 0);">%s</span>'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedBoats', function(ownedBoats)
		if #ownedBoats == 0 then
			ESX.ShowNotification(_U('garage_no_boats'))
		else
			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage	   = tostring(math.floor(v.vehicle.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

				if v.striked then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
				elseif v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
				end	

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_boat', {
			title = _U('garage_boats'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle3(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('boat_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedBoatsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedBoatsMenu()
	if WasInPound then
		-- ESX.ShowNotification(_U('must_wait', Config.PoundWait))
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.PoundWait .. ' minutes before using the impound again.')
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedBoats', function(ownedBoats)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_boat', {
				title = _U('pound_boats', ESX.Math.GroupDigits(Config.BoatPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyBoats', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle3(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payBoat')
								if Config.UsePoundTimer then
									WasInPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Boat Code

-- Start of Car Code
function ListOwnedCarsMenu()
	local elements = {}
	-- table.insert(elements, {label = 'Store Nearby Vehicles', value = 'store_nearby_vehicles'})


	ESX.TriggerServerCallback('iG_VehicleGarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_no_cars'))
		else
			for _,v in pairs(ownedCars) do
				-- print(v.plate)
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage	   = tostring(math.floor(v.vehicle.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

				if v.striked then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
				elseif v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
				end	


				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title = _U('garage_cars'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			elseif data.current.value == 'store_nearby_vehicles' then
				StoreNearbyVehicles(GetEntityCoords(PlayerPedId()))
			else
				if data.current.value.stored and not data.current.value.striked then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				elseif data.current.value.striked then
					ESX.ShowNotification(_U('car_is_striked'))
				else
					ESX.ShowNotification(_U('car_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	elseif ESX.Game.GetVehicleInDirection() then
		local vehicle = ESX.Game.GetVehicleInDirection()
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		-- local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(vehicle)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_VehicleGarage:storeVehicle', function(valid)
			if valid then
				-- if engineHealth < 990 then
				-- 	if Config.UseDamageMult then
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice*Config.DamageMult)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	else
				-- 		local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice)
				-- 		RepairVehicle(apprasial, vehicle, vehicleProps)
				-- 	end
				-- else
					StoreVehicle(vehicle, vehicleProps)
				-- end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else

		
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedCarsMenu()
	if WasInPound then
		-- ESX.ShowNotification(_U('must_wait', Config.PoundWait))
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.PoundWait .. ' minutes before using the impound again.')
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedCars', function(ownedCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
				title = _U('pound_cars', ESX.Math.GroupDigits(Config.CarPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyCars', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payCar')
								if Config.UsePoundTimer then
									WasInPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Car Code

-- WasInPound & WasinJPound Code
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Config.UsePoundTimer then
			if WasInPound then
				Citizen.Wait(Config.PoundWait * 60000)
				WasInPound = false
			end
		end

		if Config.UseJPoundTimer then
			if WasinJPound then
				Citizen.Wait(Config.JPoundWait * 60000)
				WasinJPound = false
			end
		end
	end
end)

-- Repair Vehicles
function RepairVehicle(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ($"..apprasial..")", value = 'yes'},
		{label = _U('see_mechanic'), value = 'no'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title = _U('damaged_vehicle'),
		align = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'yes' then
			TriggerServerEvent('iG_VehicleGarage:payhealth', apprasial)
			vehicleProps.bodyHealth = 1000.0 -- must be a decimal value!!!
			vehicleProps.engineHealth = 1000
			StoreVehicle(vehicle, vehicleProps)
		elseif data.current.value == 'no' then
			ESX.ShowNotification(_U('visit_mechanic'))
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Store Vehicles
function StoreVehicle(vehicle, vehicleProps)
	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
			table.remove(vehInstance, k)
		end
	end

	DeleteEntity(vehicle)
	exports['mythic_notify']:SendAlert('inform', 'Garage: Vehicle stored, engine health: ' .. tostring(math.floor(vehicleProps.engineHealth/10) .. "%"))
	TriggerServerEvent('iG_VehicleGarage:setVehicleState', vehicleProps.plate, true)
	-- ESX.ShowNotification(_U('vehicle_in_garage'))
end

function StoreNearbyVehicles(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('iG_VehicleGarage:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				BeginTextCommandBusyString('STRING')
				AddTextComponentSubstringPlayerName(_U('garage_storing'))
				EndTextCommandBusyString(4)

				while IsBusy do
					Citizen.Wait(100)
				end

				RemoveLoadingPrompt()
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 50 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			for k,v in pairs (vehInstance) do
				if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleId.plate ) then
					table.remove(vehInstance, k)
				end
			end

			TriggerServerEvent('iG_VehicleGarage:setVehicleState', vehicleId.plate, true)
			IsBusy = false

			ESX.ShowNotification(_U('vehicle_in_garage'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

-- Spawn Vehicles
function SpawnVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		-- SetVehicleFixed(callback_vehicle)
		-- SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		-- SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		-- TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('iG_VehicleGarage:setVehicleState', plate, false)
end

function SpawnVehicle2(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner2, this_Garage.Heading2, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF") 
		-- SetVehicleFixed(callback_vehicle)
		-- SetVehicleDeformationFixed(callback_vehicle)
		-- SetVehicleUndriveable(callback_vehicle, false)
		-- SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		-- TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('iG_VehicleGarage:setVehicleState', plate, false)
end

function SpawnVehicle3(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		-- SetVehicleFixed(callback_vehicle)
		-- SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		-- SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('iG_VehicleGarage:setVehicleState', plate, false)
end

-- Check Vehicles
function DoesAPlayerDrivesVehicle(plate)
	local isVehicleTaken = false
	local players = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

-- Entered Marker
AddEventHandler('iG_VehicleGarage:hasEnteredMarker', function(zone)
	if zone == 'ambulance_garage_point' then
		CurrentAction = 'ambulance_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'ambulance_store_point' then
		CurrentAction = 'ambulance_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction = 'ambulance_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'police_garage_point' then
		CurrentAction = 'police_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'police_store_point' then
		CurrentAction = 'police_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'police_pound_point' then
		CurrentAction = 'police_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction = 'aircraft_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction = 'aircraft_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction = 'aircraft_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction = 'boat_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction = 'boat_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction = 'boat_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'car_garage_point' then
		CurrentAction = 'car_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction = 'car_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'society_pound_point' then
		CurrentAction = 'society_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('iG_VehicleGarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		if Config.UseAmbulanceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
				for k,v in pairs(Config.AmbulanceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(25, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_store_point'
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(25, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_store_point'
						end
					end
				end
			end
		end

		if Config.UseAmbulancePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
				for k,v in pairs(Config.AmbulancePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_pound_point'
						end
					end
				end
			end
		end

		if Config.UsePoliceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'afp' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
				for k,v in pairs(Config.PoliceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(25, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_store_point'
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(25, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_store_point'
						end
					end
				end
			end
		end

		if Config.UsePolicePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'afp' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
				for k,v in pairs(Config.PolicePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_pound_point'
						end
					end
				end
			end
		end
		if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'afp' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'unemployed' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'fire' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'ambulance' then
			for k,v in pairs(Config.SocietyPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.JPoundMarker.Type ~= -1 then
						DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.JPoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'society_pound_point'
					end
				end
			end
		end

		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < 35 then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(33, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_garage_point'
					end
				end

				if distance2 < 35 then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(25, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x * 3, Config.DeleteMarker.y* 3, Config.DeleteMarker.z* 3, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x * 3 then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_store_point'
					end
				end
			end

			for k,v in pairs(Config.AircraftPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < 35 then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(33, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_pound_point'
					end
				end
			end
		end

		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(35, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(25, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_store_point'
					end
				end
			end

			for k,v in pairs(Config.BoatPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(35, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_pound_point'
					end
				end
			end
		end

		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(25, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_store_point'
					end
				end
			end

			for k,v in pairs(Config.CarPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(36, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_pound_point'
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('iG_VehicleGarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('iG_VehicleGarage:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local model = GetEntityModel(playerVeh)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'ambulance_garage_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						ListOwnedAmbulanceMenu()
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'ambulance_store_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								StoreOwnedAmbulanceMenu()
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'ambulance_pound_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						ReturnOwnedAmbulanceMenu()
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'police_garage_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcd' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						ListOwnedPoliceMenu()
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'police_store_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcd' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								StoreOwnedPoliceMenu()
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'police_pound_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcd' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
						ReturnOwnedPoliceMenu()
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'society_pound_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcd' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'unemployed'  or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
						exports['mythic_notify']:SendAlert('error', 'Error: You do not have access to the society impound.')
					else
						ReturnOwnedSocietyMenu()
					end
				elseif CurrentAction == 'aircraft_garage_point' then
					ListOwnedAircraftsMenu()
				elseif CurrentAction == 'aircraft_store_point' then
					if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedAircraftsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'aircraft_pound_point' then
					ReturnOwnedAircraftsMenu()
				elseif CurrentAction == 'boat_garage_point' then
					ListOwnedBoatsMenu()
				elseif CurrentAction == 'boat_store_point' then
					if IsThisModelABoat(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedBoatsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'boat_pound_point' then
					ReturnOwnedBoatsMenu()
				elseif CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu()
				elseif CurrentAction == 'car_store_point' then
					if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedCarsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					elseif ESX.Game.GetVehicleInDirection() ~= nil then 
						StoreOwnedCarsMenu()
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'car_pound_point' then
					ReturnOwnedCarsMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
function CreateBlips()
	if Config.UseAircraftGarages and Config.UseAircraftBlips then
		for k,v in pairs(Config.AircraftGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 569)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Garage: Aircraft")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.AircraftPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 569)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Impound: Aircraft")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.UseBoatGarages and Config.UseBoatBlips then
		for k,v in pairs(Config.BoatGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 427)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Garage: Watercraft")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.BoatPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 427)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Impound: Watercraft")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.UseCarGarages and Config.UseCarBlips then
		for k,v in pairs(Config.CarGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 524)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Garage: Automobile")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.CarPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 524)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Impound: Automobile")
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end
end

-- Handles Job Blips
function DeleteJobBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function RefreshJobBlips()
	if Config.UseAmbulanceGarages and Config.UseAmbulanceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
			for k,v in pairs(Config.AmbulanceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, 524)
				SetBlipColour (blip, Config.JGarageBlip.Color)
				SetBlipDisplay(blip, Config.JGarageBlip.Display)
				SetBlipScale  (blip, Config.JGarageBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_ambulance_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.UseAmbulancePounds and Config.UseAmbulanceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
			for k,v in pairs(Config.AmbulancePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, 524)
				SetBlipColour (blip, Config.JPoundBlip.Color)
				SetBlipDisplay(blip, Config.JPoundBlip.Display)
				SetBlipScale  (blip, Config.JPoundBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Impound: NSWA Automobile')
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.UsePoliceGarages and Config.UsePoliceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
			for k,v in pairs(Config.PoliceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, 524)
				SetBlipColour (blip, Config.JGarageBlip.Color)
				SetBlipDisplay(blip, Config.JGarageBlip.Display)
				SetBlipScale  (blip, Config.JGarageBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_police_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end
	
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'afp' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'unemployed' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'fire' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'ambulance' then
		for k,v in pairs(Config.SocietyPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, 524)
			SetBlipColour (blip, Config.JPoundBlip.Color)
			SetBlipDisplay(blip, Config.JPoundBlip.Display)
			SetBlipScale  (blip, Config.JPoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Impound: Society Automobile')
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		end
	end
	if Config.UsePolicePounds and Config.UsePoliceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'afp' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
			for k,v in pairs(Config.PolicePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, 524)
				SetBlipColour (blip, Config.JPoundBlip.Color)
				SetBlipDisplay(blip, Config.JPoundBlip.Display)
				SetBlipScale  (blip, Config.JPoundBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Impound: NSWPF Automobile')
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end
end


function ReturnOwnedSocietyMenu()
	if WasinJPound then
		-- ESX.ShowNotification(_U('must_wait', Config.JPoundWait))
		exports['mythic_notify']:SendAlert('error', 'Error: You must wait ' .. Config.JPoundWait .. ' minutes before using the impound again.')
	else
		ESX.TriggerServerCallback('iG_VehicleGarage:getOutOwnedSocietyCars', function(ownedSocietyCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				
			end

			for _,v in pairs(ownedSocietyCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local vehDamage = tostring(math.floor(v.engineHealth/10) .. "%")
				local labelvehicle
				local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
				local labelvehicle3 = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s)</span>'):format(plate, vehDamage)


				labelvehicle = labelvehicle3

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_society', {
				title = _U('pound_cars', ESX.Math.GroupDigits(Config.CarPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('iG_VehicleGarage:checkMoneyCars', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('iG_VehicleGarage:payCar')
								if Config.UsePoundTimer then
									WasinJPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
