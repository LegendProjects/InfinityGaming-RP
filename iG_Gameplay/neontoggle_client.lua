--==========================================================================================
--==                                 TOGGLE VEHICLE NEONS                  		  ==
--==========================================================================================

local isOn	=	false

RegisterCommand("neons", function()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    if veh ~= nil and veh ~= 0 and veh ~= 1 then

		--left
        if isOn then

            SetVehicleNeonLightEnabled(veh, 0, false)
            SetVehicleNeonLightEnabled(veh, 1, false)
            SetVehicleNeonLightEnabled(veh, 2, false)
            SetVehicleNeonLightEnabled(veh, 3, false)

			isOn = false

        else

            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)

			isOn = true

        end

    end

end, false)