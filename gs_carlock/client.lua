ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	exports['ig-keybinds']:RegisterKeybind('ToggleVehicleLocks', 'Toggle Nearby Vehicle Locks', 'L', ToggleVehicleLocks)
end)

local dict
Citizen.CreateThread(function()
 	dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
end)

local Cooldown = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Cooldown >= 2 then 
			Cooldown = Cooldown - 1
		end
	end
end)

ToggleVehicleLocks = function()
	if Cooldown <= 1 then
		Cooldown = 3
		local coords = GetEntityCoords(PlayerPedId())
		local hasAlreadyLocked = false
		cars = ESX.Game.GetVehiclesInArea(coords, 5)
		local carstrie = {}
		local cars_dist = {}		
		notowned = 0

		if #cars == 0 then
			Citizen.Wait(0)
		else
			for j=1, #cars, 1 do
				local coordscar = GetEntityCoords(cars[j])
				local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				table.insert(cars_dist, {cars[j], distance})
			end
			for k=1, #cars_dist, 1 do
				local z = -1
				local distance, car = 999
				for l=1, #cars_dist, 1 do
					if cars_dist[l][2] < distance then
						distance = cars_dist[l][2]
						car = cars_dist[l][1]
						z = l
					end
				end
				if z ~= -1 then
					table.remove(cars_dist, z)
					table.insert(carstrie, car)
				end
			end
			for i=1, #carstrie, 1 do
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
				ESX.TriggerServerCallback('CarLock:isVehicleOwner', function(owner)
					if owner and hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(carstrie[i])
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(carstrie[i], 0, false)
							SetVehicleDoorShut(carstrie[i], 1, false)
							SetVehicleDoorShut(carstrie[i], 2, false)
							SetVehicleDoorShut(carstrie[i], 3, false)
							SetVehicleDoorsLocked(carstrie[i], 2)
							PlayVehicleDoorCloseSound(carstrie[i], 1)
							
							exports['mythic_notify']:SendAlert('inform', 'Vehicle: Locked.')
							TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							if Config.CarLock.CarBleepOnOpen then
								TriggerServerEvent('InteractSound_SV:PlayOnSource', 'lock2', Config.CarLock.CarBleepVolume) 
							end
							if Config.CarLock.BlinkingLighstON then
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 0)
							end
							hasAlreadyLocked = true
						elseif lock == 2 then
							SetVehicleDoorsLocked(carstrie[i], 1)
							PlayVehicleDoorOpenSound(carstrie[i], 0)
							
							
							exports['mythic_notify']:SendAlert('inform', 'Vehicle: Unlocked.')
							TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							if Config.CarLock.CarBleepOnClose then
								TriggerServerEvent('InteractSound_SV:PlayOnSource', 'unlock2', Config.CarLock.CarBleepVolume)
							end 
							if Config.CarLock.BlinkingLighstON then
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 0)
							end
							hasAlreadyLocked = true
						end
					else
						notowned = notowned + 1
					end
					if notowned == #carstrie then
						exports['mythic_notify']:SendAlert('error', 'Error: You can\'t lock this vehicle.')
					end	
				end, plate)
			end			
		end
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming keys. (Cooldown: ' .. Cooldown .. ' seconds)')
	end
end
--Citizen.CreateThread(function()
--	local ped = GetPlayerPed(-1)
--	local vehFront = VehicleInFront()
--	local vehCoord = GetEntityCoords(vehFront)
--	local pedCoord = GetEntityCoords(ped)
--	local distanceToVeh = GetDistanceBetweenCoords(pedCoord, vehCoord, 1)
--	local lockStatus  = GetVehicleDoorLockStatus(vehFront)
--    while true do
--		Citizen.Wait(10)
--		if Config.CarLock.TextBovenVoertuig then
--			if distanceToVeh <= 10.0 then
--				if not IsPedInAnyVehicle(ped, true) and not IsPedDeadOrDying(ped, 1) and not IsPlayerDead(ped) then
--					if lockStatus == 1 then
--						CarTextOpen(vehCoord.x, vehCoord.y, vehCoord.z -0.5, "Unlocked", 4, 0.05, 0.05)
--					else
--						CarTextGesloten(vehCoord.x, vehCoord.y, vehCoord.z -0.5, "Locked", 4, 0.05, 0.05)
--					end
--				end
--			end
--		end
--    end
--end)
--
--function CarTextOpen(x,y,z,textInput,fontId,scaleX,scaleY)
--	local px,py,pz=table.unpack(GetGameplayCamCoords())
--	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
--	local scale = (1/dist)*20
--	local fov = (1/GetGameplayCamFov())*100
--	local scale = scale*fov
--	SetTextScale(scaleX*scale, scaleY*scale)
--	SetTextFont(fontId)
--	SetTextProportional(1)
--	SetTextColour(104, 234, 106, 0.8)
--	SetTextDropshadow(1, 1, 1, 1, 255)
--	SetTextEdge(2, 0, 0, 0, 150)
--	SetTextDropShadow()
--	SetTextOutline()
--	SetTextEntry("STRING")
--	SetTextCentre(1)
--	AddTextComponentString(textInput)
--	SetDrawOrigin(x,y,z+2, 0)
--	DrawText(0.0, 0.0)
--	ClearDrawOrigin()
--end
--
--function CarTextGesloten(x,y,z,textInput,fontId,scaleX,scaleY)
--	local px,py,pz=table.unpack(GetGameplayCamCoords())
--	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
--	local scale = (1/dist)*20
--	local fov = (1/GetGameplayCamFov())*100
--	local scale = scale*fov
--	SetTextScale(scaleX*scale, scaleY*scale)
--	SetTextFont(fontId)
--	SetTextProportional(1)
--	SetTextColour(204, 0, 0, 0.8)
--	SetTextDropshadow(1, 1, 1, 1, 255)
--	SetTextEdge(2, 0, 0, 0, 150)
--	SetTextDropShadow()
--	SetTextOutline()
--	SetTextEntry("STRING")
--	SetTextCentre(1)
--	AddTextComponentString(textInput)
--	SetDrawOrigin(x,y,z+2, 0)
--	DrawText(0.0, 0.0)
--	ClearDrawOrigin()
--end
--
--function VehicleInFront()
--    local vehicle, distance = ESX.Game.GetClosestVehicle()
--    if vehicle ~= nil and distance < 3 then
--        return vehicle
--    else
--        return 0
--    end
--end

--Citizen.CreateThread(function()
--  local resetSpeedOnEnter = true
--  while true do
--    Citizen.Wait(0)
--    local playerPed = GetPlayerPed(-1)
--	local vehicle = GetVehiclePedIsIn(playerPed,false)
--	if Config.CarLock.BegrenzerAAN then
--		if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then
--
--		if resetSpeedOnEnter then
--			maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
--			SetEntityMaxSpeed(vehicle, maxSpeed)
--			resetSpeedOnEnter = false
--		end
--		-- Zet Begrenzer UIT
--		if IsControlJustReleased(0,Config.CarLock.BegrenzerKey) and IsControlPressed(0,131) then
--			maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
--			SetEntityMaxSpeed(vehicle, maxSpeed)
--			exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-warning alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fa fa-exclamation-triangle faa-flash animated\"></i><strong>Cruise Control</strong><br> Your speed is no longer limited.</div>", type = "info", timeout = math.random(1000, 10000), layout = "centerLeft", queue = "left"})
--		-- Zet Begrenzer AAN
--		elseif IsControlJustReleased(0,Config.CarLock.BegrenzerKey) then
--			cruise = GetEntitySpeed(vehicle)
--			SetEntityMaxSpeed(vehicle, cruise)
--			cruise = math.floor(cruise * 3.6 + 0.5)
--			exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-info alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon  fa fa-info-circle faa-shake animated\"></i><strong>Cruise Control</strong><br> Your speed is now set at " .. cruise .. "km/h.</div>", type = "info", timeout = math.random(1000, 10000), layout = "centerLeft", queue = "left"})
--		end
--		else
--		resetSpeedOnEnter = true
--		end
--	end
--  end
--end)

function showHelpNotification(msg,time)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
	DrawSubtitleTimed(time, 1)
end