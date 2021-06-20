local WHITELISTED_VEHICLES = {
	[GetHashKey('skyline')] = true,
	[GetHashKey('r33')] = true,
	[GetHashKey('jzx100')] = true,
	[GetHashKey('kuruma')] = true,
	[GetHashKey('lwgtr')] = true,
	[GetHashKey('rmodm4gts')] = true,
	[GetHashKey('rmodmustang')] = true,
	[GetHashKey('370z')] = true,
	[GetHashKey('subwrx')] = true,
	[GetHashKey('sultanrs')] = true,
	[GetHashKey('evolution6')] = true,
	[GetHashKey('fe86')] = true,
	[GetHashKey('gt86q')] = true,
	[GetHashKey('gt86rbc')] = true,
	[GetHashKey('infinitig35')] = true,
	[GetHashKey('rmodm3e36')] = true,
	[GetHashKey('s15rb')] = true,
	[GetHashKey('subaruimpreza')] = true,
	[GetHashKey('silvia3')] = true,
	[GetHashKey('180sx')] = true,
	[GetHashKey('m3e46')] = true,
	[GetHashKey('rmodamgc63')] = true,
	[GetHashKey('nis15')] = true,
	[GetHashKey('civic')] = true,
	[GetHashKey('rmodsupra')] = true,
	[GetHashKey('supra2')] = true,
	[GetHashKey('kiagt')] = true,
	[GetHashKey('civicsedan')] = true,	
	[GetHashKey('gt86')] = false,
	[GetHashKey('fulux63')] = true,
	[GetHashKey('gtr7a')] = true,
	[GetHashKey('rmodzl1')] = true,
	[GetHashKey('demon')] = false,
	[GetHashKey('hilux2013')] = true,
	[GetHashKey('r32')] = true,
}
  
function IsVehicleWhitelisted(vehicle)
	local model = GetEntityModel(vehicle)
	return WHITELISTED_VEHICLES[model] or false
end


--==========================================================================================
--==                            	GET PLAYER LOOP              	                  ==
--==========================================================================================
local playerPed 
local playerPedId
local playerId
local isInVehicle = false
Citizen.CreateThread(function() -- 500 MS Loop
	while true do
		playerPed 			= GetPlayerPed(-1)
		playerPedId 		= PlayerPedId()
		playerId	        = PlayerId()
		isInVehicle         = IsPedInAnyVehicle(playerPedId, true)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		if isInVehicle then	

			local vehicleName = GetVehiclePedIsIn(playerPed)

			if IsVehicleWhitelisted(vehicleName) then
				
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local driver = GetPedInVehicleSeat(vehicle, -1)
				local model = GetEntityModel(vehicle)

				if driver == playerPed and IsVehicleOnAllWheels(vehicle) then

					local GetHandlingfInitialDragCoeff = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")
					local GetHandlingfDriveBiasFront = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront')
					local GetHandlingfSteeringLock = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")
					local GetHandlingfTractionCurveMax = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")
					local GetHandlingfTractionCurveMin = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")
					local GetHandlingfTractionCurveLateral = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")
					local GetHandlingfLowSpeedTractionLossMult = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")
					
					if IsControlJustReleased(0, 21) and ((GetVehicleClass(vehicle) == 0) or (GetVehicleClass(vehicle) == 1) or (GetVehicleClass(vehicle) == 2) or (GetVehicleClass(vehicle) == 3) or (GetVehicleClass(vehicle) == 4) or (GetVehicleClass(vehicle) == 5) or (GetVehicleClass(vehicle) == 6) or (GetVehicleClass(vehicle) == 7) or (GetVehicleClass(vehicle) == 9)) then
						if GetHandlingfInitialDragCoeff >= 50.0 then
							DriftOff()
						else
							DriftOn()
						end
					end	
					
				end

			end

		else
			Citizen.Wait(500)
		end

	end

end)

function DriftOff()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
		
	local removeFromfInitialDragCoeff = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")-90.22)
	local removeFromfDriveInertia = (GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia')-0.31)
	local removeFromfSteeringLock = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")-22.0)
	local removeFromfTractionCurveMax = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")+1.1)
	local removeFromfTractionCurveMin = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")+0.4)
	local removeFromfTractionCurveLateral = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")-2.5)
	local removeFromfLowSpeedTractionLossMult = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")+0.57)
	local currentEngineMod = GetVehicleMod(vehicle, 11)

		
		exports['mythic_notify']:SendAlert('inform','TCS, ABS, ESP is ON!')
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', removeFromfInitialDragCoeff)
		--SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront', originalfDriveBiasFront)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveInertia', removeFromfDriveInertia)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fSteeringLock', removeFromfSteeringLock)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax', removeFromfTractionCurveMax)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin', removeFromfTractionCurveMin)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveLateral', removeFromfTractionCurveLateral)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fLowSpeedTractionLossMult', removeFromfLowSpeedTractionLossMult)
		SetVehicleEnginePowerMultiplier(vehicle, 0.0)					
		-- SetVehicleModKit(vehicle, 0)
		-- SetVehicleMod(vehicle, 11, currentEngineMod, true) 
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
		print('stock')
end

function DriftOn()			
	local vehicle = GetVehiclePedIsIn(playerPed, false)

	local addTofInitialDragCoeff = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")+90.22)
	local addTofDriveInertia = (GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia')+0.31)
	local addTofSteeringLock = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")+22.0)
	local addTofTractionCurveMax = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")-1.1)
	local addTofTractionCurveMin = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")-0.4)
	local addTofTractionCurveLateral = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")+2.5)
	local addTofLowSpeedTractionLossMult = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")-0.57)
	
		
		--not a drift handling? let's make it		
		exports['mythic_notify']:SendAlert('inform','ITS DRIFT TIME BABY')
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', addTofInitialDragCoeff)
		--SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront', 0.0)
			if GetHandlingfDriveBiasFront == 0.0 then
				SetVehicleEnginePowerMultiplier(vehicle, 190.0)
			else
				SetVehicleEnginePowerMultiplier(vehicle, 100.0)
			end
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveInertia', addTofDriveInertia)
		--SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', 160)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fSteeringLock', addTofSteeringLock)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax', addTofTractionCurveMax)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin', addTofTractionCurveMin)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveLateral', addTofTractionCurveLateral)
		SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fLowSpeedTractionLossMult', addTofLowSpeedTractionLossMult)
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
		print('drift')
end

-- function drawNotification(text)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawNotification(false, false)
-- end
