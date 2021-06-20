
Citizen.CreateThread(function() -- Every Frame Loop
	while true do
		Wait(0)

		if (IsControlJustReleased(0, 83) or IsDisabledControlJustReleased(0, 83)) then

            toggleEngine()

        end
    end
end)

function toggleEngine()

    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then

        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)

    end

end