Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    -- ESX.TriggerServerCallback('vy_Base:getPlayerSkills', function(data)
    --     fishing_Level = data.fishing_Level
    --     fishing_Experience = data.fishing_Experience
    -- end)

end)


Citizen.CreateThread(function()
    Citizen.Wait(0)
    for _, v in pairs(Config.Locations) do
        v.blip = AddBlipForCoord(v.Coords)
        SetBlipSprite(v.blip, 382)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.5)
        SetBlipColour(v.blip, 0)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Skills System: Fishing')
        EndTextCommandSetBlipName(v.blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped, false)
        for k,v in pairs(Config.Locations) do
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.Coords, false)
            if distance <= 50 then
                DrawMarker(1, v.Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.AreaSize, v.AreaSize, 0.5, 0, 164, 209, 255, false, true, 2, true, false, false, false)
            end
            if distance <= v.AreaSize then
                if not IsPedInAnyVehicle(ped, true) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
                    if IsControlJustPressed(0, 38) then
                        FishingMenu(v.Fish)
                    end
                end
            end
        end
    end
end)
