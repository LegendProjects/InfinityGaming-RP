
local btDat = { rampDoorNum = 5,unloadPos = {vector3(-2.5,1.5,-1.0)},rampPos = {vector3(2.5, -4.0, -1.0), vector3(-2.5, -4.0, -1.0)},carPosition = {vector3(0.0,-1.0,0.0)}, bikePositions = {vector3(1.0,1.5,0.0),vector3(0.0,1.5,0.0), vector3(-1.0,1.5,0.0),vector3(1.0,-1.0,0.0), vector3(0.0,-1.0,0.0),vector3(-1.0,-1.0,0.0),vector3(1.0,-3.5,0.0), vector3(0.0,-3.5,0.0),vector3(-1.0,-3.5,0.0)}}
local bDat = { rampDoorNum = 5,unloadPos = {vector3(-1.5,1.5,-0.25)},rampPos = {vector3(1.5, -3.0, -0.25), vector3(-1.5, -3.0, -0.25)},carPosition = {vector3(0.0, 0.2, 0.1)}, bikePositions = {vector3(0.6, 1.0, 0.1), vector3(-0.6, 1.0, 0.1), vector3(0.6, -1.5, 0.1), vector3(-0.6, -1.5, 0.1)}}
local cDat = { rampDoorNum = 4, unloadPos = {vector3(0.3,-6.5,0.8)},rampPos = {vector3(2.0, -6.0, 0.1), vector3(-1.5, -6.0, 0.1)},carPosition = {vector3(0.25, -3.5, 1.0)}, bikePositions = {vector3(1.0, -2.0, 0.95), vector3(-0.5, -2.0, 0.95), vector3(1.0, -5.0, 0.825), vector3(-0.5, -5.0, 0.825)}}
local dragcartrailerDat = { rampDoorNum = 5, unloadPos = {vector3(0.0,-5.5,0.0)},rampPos = {vector3(2.0, -5.5, -0.50), vector3(-2.1, -5.5, -0.50)},carPosition = {vector3(0.0, 0.0, 0.20)}, bikePositions = {vector3(0.55, 1.5, 0.00), vector3(-0.6, 1.5, 0.00), vector3(0.55, -4.0, 0.00), vector3(-0.6, -4.0, 0.00)}}

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		checkCar = {}
		playerPed = PlayerPedId()
		if Config.UseESX then
			checkCar = ESX.Game.GetVehiclesInArea(vehicleCoords, 8)
		else
			for car in EnumerateVehicles() do
				local cvehicleCoords =  GetEntityCoords(car)
				if GetDistanceBetweenCoords(vehicleCoords, cvehicleCoords, true) < 8 then
					table.insert(checkCar, car)
				end
			end
		end
		for i=1, #checkCar, 1 do
			if -2053002885 == GetEntityModel(checkCar[i])  then
				trailerData = btDat
				trailer = checkCar[i]
			elseif 1200192514 == GetEntityModel(checkCar[i])  then
				trailerData = bDat
				trailer = checkCar[i]
			elseif 1806851433 == GetEntityModel(checkCar[i])  then
				trailerData = dragcartrailerDat
				trailer = checkCar[i]
			elseif 1030000932 == GetEntityModel(checkCar[i])  then
				trailerData = cDat
				trailer = checkCar[i]
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		 vehicle = GetVehiclePedIsIn(playerPed,false)
		 vehicleClass = GetVehicleClass(vehicle)
		 vehicleCoords =  GetEntityCoords(playerPed)
		if trailer then
			trailerPos = GetEntityCoords(trailer)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
			if trailer then

				local trailerHeading = GetEntityHeading(trailer)
				if not IsPedInAnyVehicle(PlayerPedId(),false) then
					for k = 1, #trailerData.rampPos, 1 do
						local rampPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.rampPos[k])
						if Config.DisplayMarkers then
							DrawMarker(Config.MarkerType, rampPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
						end
						if GetDistanceBetweenCoords(vehicleCoords, rampPos, true) < 1.5 then

							BeginTextCommandDisplayHelp("VEH_I_RAMP")
							EndTextCommandDisplayHelp(0, 0, 1, -1)

							if IsDisabledControlJustPressed(0,86) then
								local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.rampDoorNum)
								if trunkopen > 0.0 then
									SetVehicleDoorShut(trailer, trailerData.rampDoorNum, false)
								else
									SetVehicleDoorOpen(trailer,trailerData.rampDoorNum, false, false)
								end
							end
						end
					end
					for k = 1, #trailerData.unloadPos, 1 do
						local unloadPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.unloadPos[k])
						local dist = GetDistanceBetweenCoords(vehicleCoords, unloadPos, true)

						if Config.DisplayMarkers then
							DrawMarker(Config.MarkerType, unloadPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.75, 0.75, 0.75, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
						end
						if dist < 1.5 then
							for i=1, #checkCar, 1 do
								local avehicleCoords =  GetEntityCoords(checkCar[i])
								if GetDistanceBetweenCoords(vehicleCoords, avehicleCoords, true) < 14 then
									if IsEntityAttached(checkCar[i]) and checkCar[i] ~= trailer then
										BeginTextCommandDisplayHelp("VEH_E_DETATCH")
										EndTextCommandDisplayHelp(0, 0, 1, -1)
										if IsDisabledControlJustPressed(0,86) then
											TaskWarpPedIntoVehicle(playerPed, checkCar[i], -1)
										end
									end
								end
							end
						end
					end
				elseif has_value(Config.bikes, vehicleClass) and GetEntityModel(vehicle) ~= model then
					
					for k = 1, #trailerData.bikePositions, 1 do
						local offsetPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.bikePositions[k])
						if Config.DisplayMarkers then
							DrawMarker(Config.MarkerType, offsetPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
						end
						if GetDistanceBetweenCoords(vehicleCoords, offsetPos, false) < 0.8 then
							DisableControlAction(0, 86, 1)
							BeginTextCommandDisplayHelp("VEH_I_AORD")
							EndTextCommandDisplayHelp(0, 0, 1, -1)
							if IsDisabledControlJustPressed(0,86) then
								local vehicleCoords =  GetEntityCoords(vehicle)
								local trailerheight = trailerPos.z
								local carheight = vehicleCoords.z
								local difference = carheight - trailerheight
								if IsEntityAttached(vehicle) then
									FreezeEntityPosition(vehicle, true)
									SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, (vehicleCoords.z + difference + 1.7), 1, 1, 1, 0)
									FreezeEntityPosition(vehicle, false)
									DetachEntity(vehicle, 1, 1)
									SetEntityCanBeDamaged(vehicle, true)
								else
									AttachEntityToEntity(
										vehicle,
										trailer,
										GetEntityBoneIndexByName(vehicle, "chassis"),
										vector3(trailerData.bikePositions[k].x, trailerData.bikePositions[k].y, difference),
										vector3(0.0, 0.0, 0.0),
										1, 0, 1, 0, 0, 1
									)
									SetEntityCanBeDamaged(vehicle, false)
									SetVehicleEngineOn(vehicle, false,false,false)
								end
							end
						end
					end
				elseif has_value(Config.cars, vehicleClass) and vehicle ~= trailer then
					for k = 1, #trailerData.carPosition, 1 do
						local offsetPos = GetOffsetFromEntityInWorldCoords(trailer,trailerData.carPosition[k])
						if Config.DisplayMarkers then
							DrawMarker(Config.MarkerType, offsetPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.CarMarkerSize.x, Config.CarMarkerSize.y, Config.CarMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
						end
						if GetDistanceBetweenCoords(vehicleCoords, offsetPos, false) < 1.5 then
							DisableControlAction(0, 86, 1)
							BeginTextCommandDisplayHelp("VEH_I_AORD")
							EndTextCommandDisplayHelp(0, 0, 1, -1)
							if IsDisabledControlJustPressed(0,86) then
								local vehicleHeading = GetEntityHeading(vehicle)
								local trailerheight = trailerPos.z
								local carheight = vehicleCoords.z
								local difference = carheight - trailerheight
								

								if IsEntityAttached(vehicle) then
									FreezeEntityPosition(vehicle, true)
									SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, (vehicleCoords.z + difference + 1.7), 1, 1, 1, 0)
									FreezeEntityPosition(vehicle, false)
									DetachEntity(vehicle, 1, 1)
									SetEntityCanBeDamaged(vehicle, true)
								else
									
									if (trailerHeading - vehicleHeading) < 90 and (trailerHeading - vehicleHeading) > -90 then
										AttachEntityToEntity(
											vehicle,
											trailer,
											GetEntityBoneIndexByName(trailer, "chassis"),
											vector3(trailerData.carPosition[k].x, trailerData.carPosition[k].y, difference),
											vector3(0.0, 0.0, 0.0),
											1, 0, 1, 0, 0, 1
										)
										SetEntityCanBeDamaged(vehicle, false)
										SetVehicleEngineOn(vehicle, false,false,false)
									else
										AttachEntityToEntity(
											vehicle,
											trailer,
											GetEntityBoneIndexByName(trailer, "chassis"),
											vector3(trailerData.carPosition[k].x, trailerData.carPosition[k].y, difference ),
											vector3(180.0, 180.0, 0.0),
											1, 0, 1, 0, 0, 1
										)
										SetEntityCanBeDamaged(vehicle, false)
										SetVehicleEngineOn(vehicle, false,false,false)
									end
									
								end
							end
						end
					end
				end
			end

	end
end)