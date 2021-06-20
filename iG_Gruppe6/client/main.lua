local CurrentActionData, blipsGruppe6, currentTask = {}, {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined   = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
local spawnedVehicles, isInShopMenu = {}, false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    ESX.PlayerData.job = job
    Citizen.Wait(5000)
    TriggerServerEvent('vy_Gruppe6:forceBlip')
    if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6') or (ESX.PlayerData.job and ESX.PlayerData.job.name == 'government') then 
        exports['ig-keybinds']:RegisterKeybind('ToggleGruppe6Actions', '[Gruppe6] Gruppe6 Actions Menu', 'F6', OpenGruppe6ActionsMenu)
		exports["rp-radio"]:GivePlayerAccessToFrequencies(11, 12)
	else
		exports["rp-radio"]:RemovePlayerAccessToFrequencies(11, 12)
	end 

end)

RegisterNetEvent('iG_phone:loaded')
AddEventHandler('iG_phone:loaded', function(phoneNumber, contacts)
    local specialContact = {
        name       = _U('phone_gruppe6'),
        number     = 'gruppe6',
        base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
    }
    TriggerEvent('iG_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
    if not hasAlreadyJoined then
        TriggerServerEvent('vy_Gruppe6:spawned')
    end
    hasAlreadyJoined = true
end)

function SetVehicleMaxMods(vehicle)
    local props = {
        modEngine       = 3,
        modBrakes       = 2,
        modTransmission = 2,
        modSuspension   = 3,
        modTurbo        = true,
    }

    ESX.Game.SetVehicleProperties(vehicle, props)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('iG_phone:removeSpecialContact', 'gruppe6')

        if Config.MaxInService ~= -1 then
            TriggerServerEvent('iG_service:disableService', 'gruppe6')
        end
    end
end)

function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function setUniform(selectedUniform, playerPed)
    TriggerEvent('iG_skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[selectedUniform].male then
                TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[selectedUniform].male)
            else
                ESX.ShowNotification(_U('no_outfit'))
            end

            if selectedUniform == 'vest' then
                SetPedArmour(playerPed, 50)
            end

        end
    end)
end

function OpenCloakroomMenu()
    local playerPed = PlayerPedId()
    local grade = ESX.PlayerData.job.grade_name

    local elements = {
        { label = _U('citizen_wear'), value = 'citizen_wear' },
    }

    if grade == 'gruppe6_pofficer' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_pofficer'})
		table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_officer' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_officer'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_sofficer' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_sofficer'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_supervisor' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_supervisor'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_teamleader' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_teamleader'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_commander' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_commander'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'gruppe6_coo' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'gruppe6_coo'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    elseif grade == 'boss' then
        table.insert(elements, {label = "<strong>  - - - [ General Uniform ] - - - </strong>"})
        table.insert(elements, {label = "Gruppe6 Uniform", value = 'boss'})
        table.insert(elements, {label = "Gruppe6 Tactical Uniform", value = 'g6_tactical_wear'})

        table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
        table.insert(elements, {label = "Bulletproof Vest", value = 'vest'})
    end

    --table.insert(elements, {label = "Uniform Extras", value = 'extra_menu'})

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
        title    = _U('cloakroom'),
        align    = 'right',
        elements = elements
    }, function(data, menu)
        cleanPlayer(playerPed)

        if data.current.value == 'citizen_wear' then
            if Config.EnableNonFreemodePeds then
                ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0

                    TriggerEvent('iG_skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
                            TriggerEvent('iG_skinchanger:loadSkin', skin)
                            TriggerEvent('iG:restoreLoadout')
                        end)
                    end)

                end)
            else
                ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
                    TriggerEvent('iG_skinchanger:loadSkin', skin)
                end)
            end
        end

        if
            data.current.value == 'gruppe6_pofficer' or
            data.current.value == 'gruppe6_officer' or
            data.current.value == 'gruppe6_sofficer' or
            data.current.value == 'gruppe6_supervisor' or
            data.current.value == 'gruppe6_teamleader' or
            data.current.value == 'gruppe6_commander' or
            data.current.value == 'gruppe6_coo' or
            data.current.value == 'boss' or
			data.current.value == 'g6_tactical_wear' or
            data.current.value == 'vest'
        then
            setUniform(data.current.value, playerPed)
        end

        if data.current.value == 'extra_menu' then
            OpenUniformExtras()
        end

        if data.current.value == 'freemode_ped' then
            local modelHash = ''

            ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    modelHash = GetHashKey(data.current.maleModel)
                else
                    modelHash = GetHashKey(data.current.femaleModel)
                end

                ESX.Streaming.RequestModel(modelHash, function()
                    SetPlayerModel(PlayerId(), modelHash)
                    SetModelAsNoLongerNeeded(modelHash)

                    TriggerEvent('iG:restoreLoadout')
                end)
            end)
        end
    end, function(data, menu)
        menu.close()

        CurrentAction     = 'menu_cloakroom'
        CurrentActionMsg  = _U('open_cloakroom')
        CurrentActionData = {}
    end)
end

function OpenVehicleSpawnerMenu(type, station, part, partNum)
    local playerCoords = GetEntityCoords(PlayerPedId())
    ESX.PlayerData = ESX.GetPlayerData()
    local elements = {
        {label = _U('garage_storeditem'), action = 'garage'},
        {label = _U('garage_storeitem'), action = 'store_garage'},
        {label = _U('garage_buyitem'), action = 'shop_categories'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
        title    = _U('garage_title'),
        align    = 'right',
        elements = elements
    }, function(data, menu)

        if data.current.action == 'shop_categories' then
            local elements = {}

            if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6') then
                table.insert(elements, {label = "Gruppe6 Vehicles", action = 'buy_vehicle'})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_categories', {
                title    = _U('garage_title'),
                align    = 'right',
                elements = elements
            }, function(category_data, category_menu)
                local shopElements = {}
                local foundSpawn, shopPoint = GetAvailableVehicleShopPoint(station, part, partNum)

                if category_data.current.action == 'buy_vehicle' then
                    for k, vehicle in ipairs(Config.Gruppe6_Vehicles[ESX.PlayerData.job.grade_name]) do
                        table.insert(shopElements, {
                            label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
                            name = vehicle.label,
                            model = vehicle.model,
                            price = vehicle.price,
                            type = 'car'
                        })

                    end
                end
                OpenShopMenu(shopElements, playerCoords, shopPoint.coords, shopPoint.heading)
            end, function(category_data, category_menu)
                category_menu.close()
            end)
        elseif data.current.action == 'garage' then
            local garage = {}

            ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobVehicles', function(jobVehicles)
                if #jobVehicles > 0 then
                    for k,v in ipairs(jobVehicles) do
                        local props = json.decode(v.vehicle)
                        local hashVehicule = props.model
						local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
						local vehicleName = GetLabelText(aheadVehName)
						local plate = props.plate
						local vehDamage	= tostring(math.floor(props.engineHealth/10) .. "%")
						local labelvehicle
						local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
						local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

						if v.striked then
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
						elseif v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
						end	
                        
                        table.insert(garage, {
                            label = labelvehicle,
                            stored = v.stored,
                            model = props.model,
                            vehicleProps = props
                        })
                    end

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
                        title    = _U('garage_title'),
                        align    = 'right',
                        elements = garage
                    }, function(data2, menu2)
                        if data2.current.stored then
                            local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

                            if foundSpawn then
                                menu2.close()

                                ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
                                    ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
                                    SetVehicleMaxMods(vehicle)
                                    TriggerServerEvent('iG_VehicleShop:setJobVehicleState', data2.current.vehicleProps.plate, false)
                                    ESX.ShowNotification(_U('garage_released'))
                                    exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
                                end)
                            end
                        else
                            ESX.ShowNotification(_U('garage_notavailable'))
                        end
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                else
                    ESX.ShowNotification(_U('garage_empty'))
                end
            end, type)
        elseif data.current.action == 'store_garage' then
            StoreNearbyVehicle(playerCoords)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function StoreNearbyVehicle(playerCoords)
    local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

    if #vehicles > 0 then
        for k,v in ipairs(vehicles) do

            -- Make sure the vehicle we're saving is empty, or else it wont be deleted
            if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
                table.insert(vehiclePlates, {
                    vehicle = v,
                    plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
                })
            end
        end
    else
        ESX.ShowNotification(_U('garage_store_nearby'))
        return
    end

    ESX.TriggerServerCallback('vy_Gruppe6:storeNearbyVehicle', function(storeSuccess, foundNum)
        if storeSuccess then
            local vehicleId = vehiclePlates[foundNum]
            local attempts = 0
            ESX.Game.DeleteVehicle(vehicleId.vehicle)
            IsBusy = true

            Citizen.CreateThread(function()
                BeginTextCommandBusyString('STRING')
                AddTextComponentSubstringPlayerName(_U('garage_storing'))
                EndTextCommandBusyString(4)

                while IsBusy do
                    Citizen.Wait(100)
                end

                RemoveLoadingPrompt()
            end)

            -- Workaround for vehicle not deleting when other players are near it.
            while DoesEntityExist(vehicleId.vehicle) do
                Citizen.Wait(500)
                attempts = attempts + 1

                -- Give up
                if attempts > 30 then
                    break
                end

                vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
                if #vehicles > 0 then
                    for k,v in ipairs(vehicles) do
                        if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
                            ESX.Game.DeleteVehicle(v)
                            break
                        end
                    end
                end
            end

            IsBusy = false
            ESX.ShowNotification(_U('garage_has_stored'))
        else
            ESX.ShowNotification(_U('garage_has_notstored'))
        end
    end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(station, part, partNum)
    local spawnPoints = Config.Gruppe6_Buildings[station][part][partNum].SpawnPoints
    local found, foundSpawnPoint = false, nil

    for i=1, #spawnPoints, 1 do
        if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
            found, foundSpawnPoint = true, spawnPoints[i]
            break
        end
    end

    if found then
        return true, foundSpawnPoint
    else
        ESX.ShowNotification(_U('vehicle_blocked'))
        return false
    end
end

function GetAvailableVehicleShopPoint(station, part, partNum)
    local shopPoints = Config.Gruppe6_Buildings[station][part][partNum].ShopPoints
    local found, foundShopPoint = false, nil

    for i=1, #shopPoints, 1 do
        if ESX.Game.IsSpawnPointClear(shopPoints[i].coords, shopPoints[i].radius) then
            found, foundShopPoint = true, shopPoints[i]
            break
        end
    end

    if found then
        return true, foundShopPoint
    else
        ESX.ShowNotification(_U('vehicle_blocked'))
        return false
    end
end

function OpenShopMenu(elements, restoreCoords, shopCoords, shopHeading)
    local playerPed = PlayerPedId()
    isInShopMenu = true

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
        css = 'unknownstory',
        title = _U('vehicleshop_title'),
        align = 'right',
        elements = elements
    }, function(data, menu)

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm',
                {
                    css = 'unknownstory',
                    title = _U('vehicleshop_confirm', data.current.name, data.current.price),
                    align = 'right',
                    elements = {
                        { label = _U('confirm_no'), value = 'no' },
                        { label = _U('confirm_yes'), value = 'yes' }
                    }
                }, function(data2, menu2)

                    if data2.current.value == 'yes' then
                        local newPlate = exports['iG_VehicleShop']:GeneratePlate()
                        while newPlate == nil do
							Citizen.Wait(50)
						end
                        local vehicle = GetVehiclePedIsIn(playerPed, false)

                        SetVehicleColours(vehicle, 0, 0)
                        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
                        SetVehicleExtraColours(vehicle, 0, wheelColor)

                        local props = ESX.Game.GetVehicleProperties(vehicle)
                        props.plate = newPlate

                        ESX.TriggerServerCallback('vy_Gruppe6:buyJobVehicle', function(bought)
                            if bought then
                                ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))
                                isInShopMenu = false
                                ESX.UI.Menu.CloseAll()
                                DeleteSpawnedVehicles()
                                FreezeEntityPosition(playerPed, false)
                                SetEntityVisible(playerPed, true)
                                ESX.Game.Teleport(playerPed, restoreCoords)
                            else
                                ESX.ShowNotification(_U('vehicleshop_money'))
                                menu2.close()
                            end
                        end, props, data.current.type)
                        menu2.close()
                    else
                        menu2.close()
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
    end, function(data, menu)
        isInShopMenu = false
        ESX.UI.Menu.CloseAll()
        DeleteSpawnedVehicles()
        FreezeEntityPosition(playerPed, false)
        SetEntityVisible(playerPed, true)
        ESX.Game.Teleport(playerPed, restoreCoords)
    end, function(data, menu)
        DeleteSpawnedVehicles()
        WaitForVehicleToLoad(data.current.model)
        ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, shopHeading, function(vehicle)
            table.insert(spawnedVehicles, vehicle)
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            FreezeEntityPosition(vehicle, true)
            if data.current.livery then
                SetVehicleModKit(vehicle, 0)
                SetVehicleLivery(vehicle, data.current.livery)
            end
        end)
    end)
    WaitForVehicleToLoad(elements[1].model)
    ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, shopHeading, function(vehicle)
        table.insert(spawnedVehicles, vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)

        if elements[1].livery then
            SetVehicleModKit(vehicle, 0)
            SetVehicleLivery(vehicle, elements[1].livery)
        end
    end)
end

function DeleteSpawnedVehicles()
    while #spawnedVehicles > 0 do
        local vehicle = spawnedVehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(spawnedVehicles, 1)
    end
end

function WaitForVehicleToLoad(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)

            DisableControlAction(0, Keys['TOP'], true)
            DisableControlAction(0, Keys['DOWN'], true)
            DisableControlAction(0, Keys['LEFT'], true)
            DisableControlAction(0, Keys['RIGHT'], true)
            DisableControlAction(0, 176, true) -- ENTER key
            DisableControlAction(0, Keys['BACKSPACE'], true)

            drawLoadingText("Vehicle loading, please wait...", 255, 255, 255, 255)
        end
    end
end

function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end

function OpenGruppe6ActionsMenu()
    if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6') or (ESX.PlayerData.job and ESX.PlayerData.job.name == 'government') then 
        ESX.UI.Menu.CloseAll()

        local elements = {
            {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        }

        if (IsInVehicle()) then
            table.insert(elements, { label = 'Gruppe6 Data Terminal', value = 'data_terminal' })
            table.insert(elements, { label = 'Vehicle Setup', value = 'vehicle_settings' })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gruppe6_actions', {
            title    = 'Gruppe6: Interaction Menu',
            align    = 'right',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'citizen_interaction' then
                local elements = {
                    {label = "Conduct Full-Body Search", value = 'body_search'},
                    {label = "Handcuff the Suspect", value = 'handcuff'},
                    {label = "Escort the Suspect", value = 'drag'},
                    {label = "Place Suspect in Vehicle", value = 'put_in_vehicle'},
                    {label = "Remove Suspect from Vehicle", value = 'out_the_vehicle'},
                }

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
                    title    = _U('citizen_interaction'),
                    align    = 'right',
                    elements = elements
                }, function(data2, menu2)
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        local action = data2.current.value

                    if action == 'body_search' then
                            TriggerServerEvent('vy_Gruppe6:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
                            OpenBodySearchMenu(closestPlayer)
                        elseif action == 'handcuff' then
                            TriggerServerEvent("cuff_item:itemCheck")
                            TriggerServerEvent('iG_policejob:handcuff', GetPlayerServerId(closestPlayer))
                        elseif action == 'drag' then
                            TriggerServerEvent('iG_policejob:drag', GetPlayerServerId(closestPlayer))
                        elseif action == 'put_in_vehicle' then
                            TriggerServerEvent('iG_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                        elseif action == 'out_the_vehicle' then
                            TriggerServerEvent('iG_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                        end
                    else
                        ESX.ShowNotification(_U('no_players_nearby'))
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            elseif data.current.value == 'data_terminal' then
                local elements = {
                    {label = 'Access CCTV Cameras', value = 'access_cctv'},
                }

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
                    title    = 'Gruppe6 Data Terminal',
                    align    = 'right',
                    elements = elements
                }, function(data2, menu2)
                    local action = data2.current.value
                    if action == 'access_cctv' then
                        TriggerEvent('cctv:Menu')
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            elseif data.current.value == 'vehicle_settings' then
                 menu.close()
                TriggerEvent('vehicleui:toggleMenu')
			end
        end, function(data, menu)
            menu.close()
        end)
    end
end

function OpenBodySearchMenu(player)
    TriggerEvent("ig-inventory:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end


AddEventHandler('vy_Gruppe6:hasEnteredMarker', function(station, part, partNum)
    if part == 'Cloakroom' then
        CurrentAction     = 'menu_cloakroom'
        CurrentActionMsg  = _U('open_cloakroom')
        CurrentActionData = {}
    elseif part == 'Storage' then
        CurrentAction     = 'menu_storage'
        CurrentActionMsg  = _U('open_storage')
        CurrentActionData = {}
    elseif part == 'Vehicles' then
        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('garage_prompt')
        CurrentActionData = {station = station, part = part, partNum = partNum}
    elseif part == 'BossActions' then
        CurrentAction     = 'menu_boss_actions'
        CurrentActionMsg  = _U('open_bossmenu')
        CurrentActionData = {}
    end
end)

AddEventHandler('vy_Gruppe6:hasExitedMarker', function(station, part, partNum)
    if not isInShopMenu then
        ESX.UI.Menu.CloseAll()
    end

    CurrentAction = nil
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Gruppe6_Buildings) do
        local blip = AddBlipForCoord(v.Blip.Coords)
        SetBlipSprite (blip, v.Blip.Sprite)
        SetBlipDisplay(blip, v.Blip.Display)
        SetBlipScale  (blip, v.Blip.Scale)
        SetBlipColour (blip, v.Blip.Colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Gruppe6 Corporate Security")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Display markers
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6' then

            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)
            local isInMarker, hasExited, letSleep = false, false, true
            local currentStation, currentPart, currentPartNum

            for k,v in pairs(Config.Gruppe6_Buildings) do

                for i=1, #v.Cloakrooms, 1 do
                    local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

                    if distance < Config.DrawDistance then
                        DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                        letSleep = false
                    end

                    if distance < Config.MarkerSize.x then
                        isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
                    end
                end

                for i=1, #v.Storage, 1 do
                    local distance = GetDistanceBetweenCoords(coords, v.Storage[i], true)

                    if distance < Config.DrawDistance then
                        DrawMarker(20, v.Storage[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                        letSleep = false
                    end

                    if distance < Config.MarkerSize.x then
                        isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Storage', i
                    end
                end

                for i=1, #v.Vehicles, 1 do
                    local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)

                    if distance < Config.DrawDistance then
                        DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                        letSleep = false
                    end

                    if distance < Config.MarkerSize.x then
                        isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
                    end
                end

                if ESX.PlayerData.job and  ESX.PlayerData.job.name == 'gruppe6' and ESX.PlayerData.job.grade_name == 'boss' then
                    for i=1, #v.BossActions, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

                        if distance < Config.DrawDistance then
                            DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end

                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
                        end
                    end
                end
            end

            if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
                if
                (LastStation and LastPart and LastPartNum) and
                        (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
                then
                    TriggerEvent('vy_Gruppe6:hasExitedMarker', LastStation, LastPart, LastPartNum)
                    hasExited = true
                end

                HasAlreadyEnteredMarker = true
                LastStation             = currentStation
                LastPart                = currentPart
                LastPartNum             = currentPartNum

                TriggerEvent('vy_Gruppe6:hasEnteredMarker', currentStation, currentPart, currentPartNum)
            end

            if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('vy_Gruppe6:hasExitedMarker', LastStation, LastPart, LastPartNum)
            end

            if letSleep then
                Citizen.Wait(500)
            end

        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction then
            ESX.ShowHelpNotification(CurrentActionMsg)

            if IsControlJustReleased(0, 38) and (ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6') then

                if CurrentAction == 'menu_cloakroom' then
                    OpenCloakroomMenu()
                elseif CurrentAction == 'menu_storage' then
                    OpenBusinessStorage()
                elseif CurrentAction == 'menu_vehicle_spawner' then
                    OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
                elseif CurrentAction == 'delete_vehicle' then
                    ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
                elseif CurrentAction == 'menu_boss_actions' then
                    ESX.UI.Menu.CloseAll()
                    TriggerEvent('iG_society:openBossMenu', 'gruppe6', function(data, menu)
                        menu.close()

                        CurrentAction     = 'menu_boss_actions'
                        CurrentActionMsg  = _U('open_bossmenu')
                        CurrentActionData = {}
                    end, { wash = false }) -- disable washing money
                elseif CurrentAction == 'remove_entity' then
                    DeleteEntity(CurrentActionData.entity)
                end

                CurrentAction = nil
            end

        elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6' then
            if IsControlJustReleased(0, 167) then
                OpenGruppe6ActionsMenu()
            end
        else
            Citizen.Wait(500)
        end -- CurrentAction end
        if IsControlJustReleased(0, 38) and currentTask.busy then
            ESX.ShowNotification(_U('impound_canceled'))
            ESX.ClearTimeout(currentTask.task)
            ClearPedTasks(PlayerPedId())

            currentTask.busy = false
        end
    end
end)

-- -- Create blip for colleagues
-- function createBlip(id)
--     local ped = GetPlayerPed(id)
--     local blip = GetBlipFromEntity(ped)

--     if not DoesBlipExist(blip) then -- Add blip and create head display on player
--         blip = AddBlipForEntity(ped)
--         SetBlipSprite(blip, 1)

--         SetBlipScale(blip, 0.6) -- set scale
--         SetBlipAsShortRange(blip, true)
--         SetBlipColour (blip, 69)

--         BeginTextCommandSetBlipName('STRING')
--         AddTextComponentString("👨 AVL | Gruppe6")
--         EndTextCommandSetBlipName(blip)

--         table.insert(blipsGruppe6, blip) -- add blip to array so we can remove it later
--     end
-- end

-- RegisterNetEvent('vy_Gruppe6:updateBlip')
-- AddEventHandler('vy_Gruppe6:updateBlip', function()

--     -- Refresh all blips
--     for k, existingBlip in pairs(blipsGruppe6) do
--         RemoveBlip(existingBlip)
--     end

--     -- Clean the blip table
--     blipsGruppe6 = {}

--     -- Enable blip?
--     if Config.MaxInService ~= -1 and not playerInService then
--         return
--     end

--     if not Config.EnableJobBlip then
--         return
--     end

--     -- Is the player a cop? In that case show all the blips for other cops
--     if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gruppe6' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'government' then
--         ESX.TriggerServerCallback('iG_society:getOnlinePlayers', function(players)
--             for i=1, #players, 1 do
--                 if players[i].job.name == 'gruppe6' then
--                     local id = GetPlayerFromServerId(players[i].source)
--                     if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
--                         createBlip(id)
--                     end
--                 end
--             end
--         end)
--     end

-- end)



function OpenBusinessStorage()
    ESX.TriggerServerCallback("iG_BusinessStorage:getBusinessStorageInventory", function(inventory)
            TriggerEvent("ig-inventory:openBusinessStorageInventory", inventory)
    end, ESX.PlayerData.job.name)
end
