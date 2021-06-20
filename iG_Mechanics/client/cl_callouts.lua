
function IsNearRepairVehicle()
    local pCoords = GetEntityCoords(PlayerPedId())
    if GetClosestVehicle(pCoords, 25.0, GetHashKey('nrma_iload'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('nrma_flatbed'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('nrma_colorado'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('ct660tow'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('flatbed'), 70) ~= 0 then
        return true
    else 
        return false
    end
end

function IsNearTowTruck()
    local pCoords = GetEntityCoords(PlayerPedId())
    if GetClosestVehicle(pCoords, 25.0, GetHashKey('nrma_flatbed'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('ct660tow'), 70) ~= 0 or GetClosestVehicle(pCoords, 25.0, GetHashKey('flatbed'), 70) ~= 0 then
        return true
    else 
        return false
    end
end