fishing_Level = 0
fishing_Experience = 0

ESX = nil
playerLoaded = false


RegisterNetEvent("iG:playerLoaded")
AddEventHandler('iG:playerLoaded', function()
    playerLoaded = true
end)

RegisterNetEvent("vy_Base:UpdateSkillData")
AddEventHandler('vy_Base:UpdateSkillData', function(data)
    fishing_Level = data.fishing_Level
    -- fishing_Experience = data.fishing_Experience
end)




function FishingMenu(fish)
    local elements = {}
    for i=1, #fish, 1 do
        if fish[i] == 'shrimp' then
            table.insert(elements, {label = "Shrimp (Level: 1)", value = fish[i]})
        elseif fish[i] == 'sardine' then
            table.insert(elements, {label = "Sardine (Level: 5)", value = fish[i]})
        elseif fish[i] == 'anchovies' then
            table.insert(elements, {label = "Anchovies (Level: 15)", value = fish[i]})
        elseif fish[i] == 'trout' then
            table.insert(elements, {label = "Trout (Level: 20)", value = fish[i]})
        elseif fish[i] == 'salmon' then
            table.insert(elements, {label = "Salmon (Level: 30)", value = fish[i]})
        elseif fish[i] == 'tuna' then
            table.insert(elements, {label = "Tuna (Level: 35)", value = fish[i]})
        elseif fish[i] == 'lobster' then
            table.insert(elements, {label = "Lobster (Level: 40)", value = fish[i]})
        elseif fish[i] == 'swordfish' then
            table.insert(elements, {label = "Swordfish (Level: 50)", value = fish[i]})
        elseif fish[i] == 'monkfish' then
            table.insert(elements, {label = "Monkfish (Level: 62)", value = fish[i]})
        elseif fish[i] == 'shark' then
            table.insert(elements, {label = "Shark (Level: 76)", value = fish[i]})
        elseif fish[i] == 'anglerfish' then
            table.insert(elements, {label = "Anglerfish (Level: 82)", value = fish[i]})
        end
    end


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
    if _fish == 'shrimp' then
        if fishing_Level >= 1 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8000,
                label = "Fishing: Shrimp..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 1)')
        end
    elseif _fish == 'sardine' then
        if fishing_Level >= 5 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8000,
                label = "Fishing: Sardine..",
                useWhileDead = false,
                canCancel = true,
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 5)')
        end
    elseif _fish == 'anchovies' then
        if fishing_Level >= 15 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8000,
                label = "Fishing: Anchovies..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 15)')
        end
    elseif _fish == 'trout' then
        if fishing_Level >= 20 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8000,
                label = "Fishing: Trout..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 20)')
        end
    elseif _fish == 'salmon' then
        if fishing_Level >= 30 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8000,
                label = "Fishing: Salmon..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 30)')
        end
    elseif _fish == 'tuna' then
        if fishing_Level >= 35 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 8450,
                label = "Fishing: Tuna..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 35)')
        end
    elseif _fish == 'lobster' then
        if fishing_Level >= 40 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 9250,
                label = "Fishing: Lobster..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 40)')
        end
    elseif _fish == 'swordfish' then
        if fishing_Level >= 50 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 10500,
                label = "Fishing: Swordfish..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 50)')
        end
    elseif _fish == 'monkfish' then
        if fishing_Level >= 62 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 10000,
                label = "Fishing: Monkfish..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 62)')
        end
    elseif _fish == 'shark' then
        if fishing_Level >= 76 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 12500,
                label = "Fishing: Shark..",
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
            exports['mythic_notify']:SendAlert('inform', 'Fishing: You do not have the required fishing level. (Required: 76)')
        end
    elseif _fish == 'anglerfish' then
        if fishing_Level >= 82 then
            exports['mythic_progbar']:Progress({
                name = "fishing",
                duration = 16000,
                label = "Fishing: Anglerfish..",
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
