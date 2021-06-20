RegisterNetEvent('iG_VangelicoHeist:cl_updateDoorState')
AddEventHandler('iG_VangelicoHeist:cl_updateDoorState', function(door, state)
    local _door, _state = door, state
    while not DoorSystemGetIsPhysicsLoaded(_door) do Citizen.Wait(500) end
    print('[iG_VangelicoHeist] Update door state of ' .. _door .. ' to ' .. _state)
    DoorSystemSetDoorState(_door, _state, false, true)
end)