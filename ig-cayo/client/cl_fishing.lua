local fishing_Level = 82
local isMaster = false
RegisterNetEvent("vy_Base:UpdateSkillData")
AddEventHandler('vy_Base:UpdateSkillData', function(data)
    fishing_Level = data.fishing_Level
    Citizen.Wait(10000)
    TriggerEvent('vy_Base:checkMasterStatus')
end)

RegisterNetEvent('vy_Base:returnMasterStatus')
AddEventHandler('vy_Base:returnMasterStatus', function(boolean)
    isMaster = boolean
    print('[ig-cayo] isMaster:' .. tostring(isMaster))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped, false)
        for k,v in pairs(Config.FishingLocations) do
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.Coords, false)
            if distance <= 25 then
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

Citizen.CreateThread(function()
    Citizen.Wait(0)
    for _, v in pairs(Config.FishingLocations) do
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



function FishingMenu(fish)
    local elements = {}
    table.insert(elements, {label = "Anglerfish (Level: 82)", value = 'anglerfish'})
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fishing_menu', {
        title    = 'Skill System: Fishing',
        align    = 'right',
        elements = elements
    }, function(data, menu)
        startFishing(data.current.value)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        menu.close()
    end)

end

function startFishing(fish)
    local _fish = fish
    if _fish == 'anglerfish' then
        if fishing_Level >= 82 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 12000,
                label = "Fishing: Anglerfish (Level: 82)",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@lo_res_idles@",
                    anim = "world_human_stand_fishing_lo_res_base",
                    flags = 49,
                },
                prop = {
                    model = "prop_fishing_rod_02",
                    bone = 18905,
                    coords = { x = 0.15, y = 0.075, z = 0.015 },
                    rotation = { x =-100.0, y = -85.0, z = -35.0 },
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('vy_Fishing:fishItem', _fish)
                end
            end)
        else
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 82)')
        end
    end
end


RegisterNetEvent('vy_Fishing:contFishing')
AddEventHandler('vy_Fishing:contFishing', function(fish)
    local ped = GetPlayerPed(-1)
    if not IsPedInAnyVehicle(ped, true) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
        startFishing(fish)
    end
end)