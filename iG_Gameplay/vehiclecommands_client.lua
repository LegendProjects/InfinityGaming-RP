----------------------------------------------
-- External Vehicle Commands, Made by FAXES --
----------------------------------------------

RegisterCommand("boot", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

	if not DoesVehicleHaveDoor(veh, 5) and not DoesVehicleHaveDoor(vehLast, 5) then
        exports['mythic_notify']:SendAlert('error', 'This vehicle doesn\'t have a boot.')
        return
    end

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
			exports['mythic_notify']:SendAlert('success', "You've closed the trunk.",5000)
        else
            SetVehicleDoorOpen(veh, door, false, false)
            exports['mythic_notify']:SendAlert('success', "You've opened the trunk.",5000)
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                exports['mythic_notify']:SendAlert('success', "You've closed the trunk.",5000)
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                exports['mythic_notify']:SendAlert('success', "You've opened the trunk.",5000)
            end
        else
			exports['mythic_notify']:SendAlert('error', "You're too far away from a vehicle.", 5000)
        end
    end
end)

RegisterCommand("hood", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
			exports['mythic_notify']:SendAlert('success',"You've closed the hood.",5000)
        else
            SetVehicleDoorOpen(veh, door, false, false)
			exports['mythic_notify']:SendAlert('success', "You've opened the hood.",5000)
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
				exports['mythic_notify']:SendAlert('success', "You've closed the hood.",5000)
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
				exports['mythic_notify']:SendAlert('success', "You've opened the hood.",5000)
            end
        else
            exports['mythic_notify']:SendAlert('error', "You're too far away from a vehicle.", 5000)
        end
    end
end)

RegisterCommand("door", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)

    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
		exports['mythic_notify']:SendAlert('error', "Use /door 1 - 4.",5000)
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
				exports['mythic_notify']:SendAlert('success', "You've closed the door.",5000)
            else
                SetVehicleDoorOpen(veh, door, false, false)
				exports['mythic_notify']:SendAlert('success', "You've opened the door.",5000)
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
					exports['mythic_notify']:SendAlert('success', "You've closed the door.",5000)
                else
                    SetVehicleDoorOpen(vehLast, door, false, false)
					exports['mythic_notify']:SendAlert('success', "You've opened the door.",5000)
                end
            else
                exports['mythic_notify']:SendAlert('error', "You're too far away from a vehicle.", 5000)
            end
        end
    end
end)
