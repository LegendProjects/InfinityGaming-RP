local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy = false
local spawnedVehicles, isInShopMenu = {}, false
local PlayerLoaded = false
local draggedBy = -1
local drag = false
local wasDragged = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

local lib1_char_a, lib2_char_a, lib1_char_b, lib2_char_b, anim_start, anim_pump, anim_success = 'mini@cpr@char_a@cpr_def', 'mini@cpr@char_a@cpr_str', 'mini@cpr@char_b@cpr_def', 'mini@cpr@char_b@cpr_str', 'cpr_intro', 'cpr_pumpchest', 'cpr_success'

Citizen.CreateThread(function()
	RequestAnimDict(lib1_char_a)
	RequestAnimDict(lib2_char_a)

	RequestAnimDict(lib1_char_b)
	RequestAnimDict(lib2_char_b)

	-- RequestAnimDict("mini@cpr")
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	ESX.PlayerData.job = job

	if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance') or (ESX.PlayerData.job and ESX.PlayerData.job.name == 'government') then 
		exports['ig-keybinds']:RegisterKeybind('ToggleEMSActions', '[ANSW] EMS Actions Menu', 'F6', OpenMobileAmbulanceActionsMenu)
		exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
	else
		exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
	end

end)

function OpenAmbulanceActionsMenu()
	local elements = {
		{ label = _U('cloakroom'), value = 'cloakroom' }
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, { label = _U('boss_actions'), value = 'boss_actions' })
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title = _U('ambulance'),
		align = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('iG_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, { wash = false })
		end
	end, function(data, menu)
		menu.close()
	end)
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function OpenMobileAmbulanceActionsMenu()
	if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance') or (ESX.PlayerData.job and ESX.PlayerData.job.name == 'government') then 
		ESX.UI.Menu.CloseAll()
		local elements =  {
			{ label = _U('ems_menu'), value = 'citizen_interaction' }
		}

		if (IsInVehicle()) then
			table.insert(elements, { label = 'Vehicle Setup', value = 'vehicle_settings' })
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
			title = _U('ambulance'),
			align = 'right',
			elements = elements

			

		}, function(data, menu)
			if data.current.value == 'citizen_interaction' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
					title = _U('ems_menu_title'),
					align = 'right',
					elements = {
						{label = _U('ems_menu_revive'), value = 'revive'},
						{label = _U('ems_menu_small'), value = 'small'},
						{label = _U('ems_menu_big'), value = 'big'},
						{label = _U('ems_menu_escort'), value = 'drag'},
						{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
						{label = _U('ems_menu_pull'), value = 'pull'},
						{label = _U('ems_menu_billing'), value = 'billing'}
					}
				}, function(data, menu)
					if isBusy then
						return
					end

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 2.5 then
						exports['mythic_notify']:SendAlert('inform', _U('no_players'))
					else
						if data.current.value == 'revive' then
							isBusy = true
							ESX.TriggerServerCallback('iG-ambulancejob:getItemAmount', function(quantity)
								if quantity > 0 then
									ESX.TriggerServerCallback('iG-death:isPlayerDead', function(isPedDead)
										if isPedDead then
											local playerPed = PlayerPedId()
											ESX.ShowNotification(_U('revive_inprogress'))
											exports['mythic_progbar']:Progress({
												name = "hospital_action",
												duration = 10000,
												label = "Reviving Patient..",
												useWhileDead = true,
												canCancel = true,
												controlDisables = {
													disableMovement = true,
													disableCarMovement = true,
													disableMouse = false,
													disableCombat = true,
												},
												animation = {
													animDict = "mini@cpr@char_a@cpr_str",
													anim = "cpr_success"
												}
											},function(status)
												if not status then
													TriggerServerEvent('iG-ambulancejob:removeItem', 'medkit')
													TriggerServerEvent('iG-ambulancejob:revive', GetPlayerServerId(closestPlayer), 'revive')
													ClearPedTasks(playerPed)
													isBusy = false
													exports['mythic_notify']:SendAlert('inform', _U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
												end
											end)
										else
											isBusy = false
											ESX.ShowNotification(_U('player_not_unconscious'))
										end

									end, GetPlayerServerId(closestPlayer))

								else
									isBusy = false
									ESX.ShowNotification(_U('not_enough_medikit'))
								end
							end, 'medkit')
						elseif data.current.value == 'small' then
							ESX.TriggerServerCallback('iG-ambulancejob:getItemAmount', function(quantity)
								if quantity > 0 then
									local closestPlayerPed = GetPlayerPed(closestPlayer)
									local health = GetEntityHealth(closestPlayerPed)

									if health > 0 then
										local playerPed = PlayerPedId()
										isBusy = true
										ESX.ShowNotification(_U('heal_inprogress'))
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										Citizen.Wait(10000)
										ClearPedTasks(playerPed)
										TriggerServerEvent('iG-ambulancejob:removeItem', 'bandage')
										TriggerServerEvent('iG-ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
										ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
										isBusy = false
									else
										exports['mythic_notify']:SendAlert('inform', _U('player_not_conscious'))
									end
								else
									exports['mythic_notify']:SendAlert('inform', _U('not_enough_bandage'))
								end
							end, 'bandage')

						elseif data.current.value == 'big' then
							ESX.TriggerServerCallback('iG-ambulancejob:getItemAmount', function(quantity)
								if quantity > 0 then
									local closestPlayerPed = GetPlayerPed(closestPlayer)
									local health = GetEntityHealth(closestPlayerPed)

									if health > 0 then
										local playerPed = PlayerPedId()
										isBusy = true
										ESX.ShowNotification(_U('heal_inprogress'))
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										Citizen.Wait(10000)
										ClearPedTasks(playerPed)
										TriggerServerEvent('iG-ambulancejob:removeItem', 'medkit')
										TriggerServerEvent('iG-ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
										ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
										isBusy = false
									else
										exports['mythic_notify']:SendAlert('inform', _U('player_not_conscious'))
									end
								else
									exports['mythic_notify']:SendAlert('inform', _U('not_enough_medkit'))
								end
							end, 'medkit')
						elseif data.current.value == 'drag' then
							TriggerServerEvent('iG_ambulancejob:emsdrag', GetPlayerServerId(closestPlayer))

						elseif data.current.value == 'put_in_vehicle' then
							TriggerServerEvent('iG-ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))

						elseif data.current.value == 'pull' then
							TriggerServerEvent('iG_ambulancejob:pull', GetPlayerServerId(closestPlayer))

						elseif data.current.value == 'billing' then

							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
								title = _U('invoice_amount')
							}, function(data, menu)
								local amount = tonumber(data.value)

								if amount == nil or amount < 0 then
									ESX.ShowNotification(_U('amount_invalid'))
								else
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										exports['mythic_notify']:SendAlert('inform', _U('no_players_nearby'))
									else
										menu.close()
										TriggerServerEvent('iG_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', _U('ambulance'), amount)
									end
								end
							end, function(data, menu)
								menu.close()
							end)
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			elseif data.current.value == 'vehicle_settings' then
				menu.close()
				TriggerEvent('vehicleui:toggleMenu')
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for hospitalNum, hospital in pairs(Config.Hospitals) do

				-- Ambulance Actions
				-- for k, v in ipairs(hospital.AmbulanceActions) do
				-- 	local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				-- 	if distance < Config.DrawDistance then
				-- 		DrawMarker(20, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
				-- 		letSleep = false
				-- 	end

				-- 	if distance < Config.Marker.x then
				-- 		isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				-- 	end
				-- end

				-- Vehicle Spawners
				for k, v in ipairs(hospital.Vehicles) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(36, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
					end
				end

				-- Helicopter Spawners
				for k, v in ipairs(hospital.Helicopters) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
					end
				end

				-- Fast Travels
				for k, v in ipairs(hospital.FastTravels) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						FastTravel(v.To.coords, v.To.heading)
					end
				end

				-- Fast Travels (Prompt)
				for k, v in ipairs(hospital.FastTravelsPrompt) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
					end
				end

			end
		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
			(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('iG-ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('iG-ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('iG-ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('iG-ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		-- if part == 'AmbulanceActions' then
		-- 	CurrentAction = part
		-- 	CurrentActionMsg = _U('actions_prompt')
		-- 	CurrentActionData = {}
		-- else
		if part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = { hospital = hospital, partNum = partNum }
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = { hospital = hospital, partNum = partNum }
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = { to = travelItem.To.coords, heading = travelItem.To.heading }
		end
	end
end)

AddEventHandler('iG-ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 51) then

				-- if CurrentAction == 'AmbulanceActions' then
				-- 	OpenCloakroomMenu()
				-- else
				if CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil

			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('disc-ambulancejob:drag')
AddEventHandler('disc-ambulancejob:drag', function(_source)
    draggedBy = _source
    drag = not drag
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if drag then
			wasDragged = true
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			if not IsPedInParachuteFreeFall(PlayerPedId()) and wasDragged then
				wasDragged = false
				DetachEntity(PlayerPedId(), true, false)    
			end
		end
	end
end)

RegisterNetEvent('iG-ambulancejob:putInVehicle')
AddEventHandler('iG-ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('iG_ambulancejob:pull')
AddEventHandler('iG_ambulancejob:pull', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
	}

	if grade == 'tparamedic' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'paramedic' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'icparamedic' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'acparamedic' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'snrparamedic' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'emssuperintendent' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'emscsuperintendent' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'emscabinet' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'emsdcommissioner' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	elseif grade == 'boss' then
		table.insert(elements, {label = "<strong>  - - - [ NSWA ] - - - </strong>"})
		table.insert(elements, {label = "Short-Sleeve Uniform", value = 'short_wear'})
		table.insert(elements, {label = "Long-Sleeve Uniform", value = 'long_wear'})
		table.insert(elements, {label = "Motorcycle Uniform", value = 'motorcycle_wear'})
		table.insert(elements, {label = "HEMS Uniform", value = 'pilot_wear'})

		table.insert(elements, {label = "<strong>  - - - [ FRNSW ] - - - </strong>"})
		table.insert(elements, {label = "Turnout Uniform", value = 'fire_turnout'})
		table.insert(elements, {label = "Oxygen Tank", value = 'fire_oxygen'})
		table.insert(elements, {label = "Kevlar Helmet", value = 'fire_helmet'})

		table.insert(elements, {label = "<strong>  - - - [ EXTRAS ] - - - </strong>"})
		table.insert(elements, {label = "General Duties Cap", value = 'hat'})
		table.insert(elements, {label = "Medical Bag #1", value = 'medbag'})
		table.insert(elements, {label = "Medical Bag #2", value = 'medbag2'})

	end

	--table.insert(elements, {label = "Uniform Extras", value = 'extra_menu'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('iG_skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
							TriggerEvent('iG_skinchanger:loadSkin', skin)
							TriggerEvent('iG:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
					TriggerEvent('iG_skinchanger:loadSkin', skin)
				end)
			end
		end

		if

			-- NSWA
			data.current.value == 'short_wear' or
			data.current.value == 'long_wear' or
			data.current.value == 'motorcycle_wear' or
			data.current.value == 'pilot_wear' or
			
			-- FRNSW 
			data.current.value == 'fire_turnout' or
			data.current.value == 'fire_oxygen' or
			data.current.value == 'fire_helmet' or

			-- EXTRAS
			data.current.value == 'hat' or
			data.current.value == 'medbag' or
			data.current.value == 'medbag2'

		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'extra_menu' then
			OpenUniformExtras()
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('iG:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('iG_skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function OpenVehicleSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{ label = _U('garage_storeditem'), action = 'garage' },
		{ label = _U('garage_storeitem'), action = 'store_garage' },
		{ label = _U('garage_buyitem'), action = 'buy_vehicle' }
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title = _U('garage_title'),
		align = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k, vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
						name = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						type = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k, v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local hashVehicule = props.model
						local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
						local vehicleName = GetLabelText(aheadVehName)
						local plate = props.plate
						local vehDamage	= tostring(math.floor(props.engineHealth/10) .. "%")
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

						table.insert(garage, {
							label = labelvehicle,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title = _U('garage_title'),
						align = 'right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									exports["LegacyFuel"]:SetFuel(vehicle, 100)
									TriggerServerEvent('iG_VehicleShop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									SetVehicleMaxMods(vehicle)
									-- exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'car')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k, v in ipairs(vehicles) do

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

	ESX.TriggerServerCallback('iG-ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			isBusy = true

			Citizen.CreateThread(function()
				while isBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k, v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			isBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i = 1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		{ label = _U('helicopter_garage'), action = 'garage' },
		{ label = _U('helicopter_store'), action = 'store_garage' },
		{ label = _U('helicopter_buy'), action = 'buy_helicopter' }
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title = _U('helicopter_title'),
		align = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k, helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						type = 'helicopter'
					})
				end
			else
				ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k, v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
						title = _U('helicopter_garage_title'),
						align = 'right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('iG_VehicleShop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									-- exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'helicopter')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title = _U('vehicleshop_title'),
		align = 'right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align = 'right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = exports['iG_VehicleShop']:GeneratePlate()

				
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local props = ESX.Game.GetVehicleProperties(vehicle)
				props.plate = newPlate

				ESX.TriggerServerCallback('iG-ambulancejob:buyJobVehicle', function(bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()

						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)

						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableAllControlActions(0)

			drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i = maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('iG-ambulancejob:heal')
AddEventHandler('iG-ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 20))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 15))
		SetEntityHealth(playerPed, newHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)


RegisterNetEvent('iG-ambulancejob:playCPR')
AddEventHandler('iG-ambulancejob:playCPR', function(playerheading, playercoords, playerlocation)
	local playerPed = PlayerPedId()

	local heading = 0.0

	-- SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
	local coords = GetEntityCoords(playerPed)
	-- NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	--local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
	local x, y, z = table.unpack(playercoords + playerlocation)
	NetworkResurrectLocalPlayer(x, y, z, playerheading, true, false)
	-- SetPlayerInvincible(playerPed, false)
	-- TriggerEvent('iG:onPlayerSpawn', coords.x, coords.y, coords.z)

	-- SetEntityCoords(playerPed, x, y, z)
	SetEntityHeading(playerPed, playerheading - 270.0)

	TaskPlayAnim(playerPed, lib1_char_b, anim_start, 8.0, 8.0, -1, 0, 0, false, false, false)
	Citizen.Wait(15800 - 900)
	TaskPlayAnim(playerPed, lib2_char_b, anim_pump, 8.0, 8.0, -1, 0, 0, false, false, false)
	Citizen.Wait(19000)

end)