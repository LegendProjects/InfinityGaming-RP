-- **Vehicle Impound:**
-- Vehicles that are to be impounded will have to be delivered to the impound itself and dropped in-side a marker.
-- Each mechanic business will have the amount of vehicles they have impounded tracked and the top business each week will receive a bonus from Government.

-- Police are able to request a vehicle to be impounded, from there mechanics will be notified of this request and will be able to accept or deny the request.
-- If a mechanic accepts the request, the vehicles location will be pinged on the mechanics GPS and the officer will be informed.
-- If the mechanic successfully impounds that vehicle, the mechanic will receive money for such work.

-- This will all be logged with the officers name requesting and the mechanic whom does such incase of insider impounding,



local RequestImpoundZone = vector3(-239.28, -1183.8, 23.04)
local onRequestJob = false

local AssignedImpoundZone = vector3(-242.32, -1168.84, 23.04)
local onAssignedJob = false


local cl_UnclaimedImpounds = {}
local cl_ClaimedImpounds = {}
local currentRequestData = {}
local currentAssignedData = {}
currentAssignedData = {
    vehicleInfo = nil,
    plate = nil, 
    coords = nil,
    distance = nil
}
-- Marker / Zone Coordinate Check
Citizen.CreateThread(function()
    while true do

        if isMechanic then

            if onRequestJob then 
                local pos = #(GetEntityCoords(PlayerPedId()) - RequestImpoundZone)
                -- print('[DEBUG] ' .. pos)

                if pos <= 25.0 then
                    DrawMarker(25, RequestImpoundZone.x, RequestImpoundZone.y, RequestImpoundZone.z - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 175, 175, 0, 200, false, false, false, false, false, false, false)
                    if pos <= 2.5 then
                        ESX.Game.Utils.DrawText3D(RequestImpoundZone, 'Press [~b~E~w~] to impound requested vehicle.', 0.4)
                        if IsControlJustReleased(0, 38) then
                            ImpoundTargetRequestedVehicle()
                        end
                    end
                end

            end

            if onAssignedJob then
                local pos = #(GetEntityCoords(PlayerPedId()) - AssignedImpoundZone)
                if pos <= 25.0 then
                    DrawMarker(25, AssignedImpoundZone.x, AssignedImpoundZone.y, AssignedImpoundZone.z - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 175, 175, 0, 50, false, false, false, false, false, false, false)
                    if pos <= 2.5 then
                        ESX.Game.Utils.DrawText3D(AssignedImpoundZone, "Press [~b~E~w~] to impound assigned vehicle.", 0.4)
                        if IsControlJustReleased(0, 38) then
                            ImpoundTargetVehicle()
                        end
                    end
                end
            end

        end
        
        Citizen.Wait(1)
    end
end)


-- Impound Requested Vehicle Function
function ImpoundTargetRequestedVehicle( ... )
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 10.0)
    if #vehicles > 0 then
        for k,v in ipairs(vehicles) do
            if GetVehicleNumberPlateText(v) == currentRequestData.plate then
                local vehicleProps = ESX.Game.GetVehicleProperties(v)
                local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model))
                TriggerServerEvent('iG_Mechanics:impoundSuccessful', currentRequestData.id, vehicleLabel, vehicleProps.plate)
                DeleteEntity(v)
                ESX.Game.DeleteVehicle(v)
                exports['mythic_notify']:SendAlert('success', 'Impound: Vehicle successfully impounded.')
                onRequestJob = false
                break
            end
        end
    end
end

-- Impound Function
function ImpoundTargetVehicle( ... )
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 10.0)
    if #vehicles > 0 then
        for k,v in ipairs(vehicles) do
            if GetVehicleNumberPlateText(v) == currentAssignedData.plate then
                TriggerServerEvent('iG_Mechanics:nonrequestImpound', currentAssignedData.vehicleInfo, currentAssignedData.plate, currentAssignedData.coords, currentAssignedData.distance)
                DeleteEntity(v)
                ESX.Game.DeleteVehicle(v)
                exports['mythic_notify']:SendAlert('success', 'Impound: Assigned vehicle successfully impounded.')
                onAssignedJob = false
                currentAssignedData = {
                    vehicleInfo = nil,
                    plate = nil, 
                    coords = nil,
                    distance = nil
                }
                break
            end
        end
    end
end



RegisterNetEvent('iG_Mechanics:assignImpound')
AddEventHandler('iG_Mechanics:assignImpound', function()
    if not onAssignedJob then
        if IsNearTowTruck() then
            local vehicle   = ESX.Game.GetVehicleInDirection()
            if vehicle ~= nil then
                local coords    = GetEntityCoords(vehicle)
                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model))
                local primary = colours[tostring(vehicleProps.color1)]
                -- local secondary = colours[tostring(vehicleProps.color2)]
                exports['mythic_progbar']:Progress({
                    name = "request_impound",
                    duration = 10500,
                    label = "Assigning vehicle impound..",
                    useWhileDead = true,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard@base",
                        anim = "base",
                        flags = 49,
                    },
                    prop = {
                        model = "p_amb_clipboard_01",
                        bone = 18905,
                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                    },
                    propTwo = {
                        model = "prop_pencil_01",
                        bone = 58866,
                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                    },
                }, function(status)
                    if not status then
                        currentAssignedData.vehicleInfo = tostring(vehicleLabel .. ', ' .. primary)
                        currentAssignedData.plate = GetVehicleNumberPlateText(vehicle)
                        currentAssignedData.coords = coords
                        exports['mythic_notify']:SendAlert('success', 'Impound: Vehicle impound assigned.')
                        exports['mythic_notify']:SendAlert('inform', '<strong>Current Impound Assignment:</strong><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. currentAssignedData.vehicleInfo .. '<br>Plate: ' .. currentAssignedData.plate, 9500)
                        onAssignedJob = true
                        currentAssignedData.distance = #(coords - AssignedImpoundZone)
                        -- print(currentAssignedData.distance)
                        -- print(onAssignedJob)
                        TriggerServerEvent('iG_Mechanics:logAssignedImpound', currentAssignedData.vehicleInfo, currentAssignedData.plate, currentAssignedData.coords, currentAssignedData.distance)
                    end
                end)
            else
                exports['mythic_notify']:SendAlert('error', 'Error: Vehicle not found, please move around and try again.')
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your authorised tow-truck.')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You\'re already on an impound assignment.')
    end
end)

-- Police Mark Vehicle for Impound
RegisterNetEvent('iG_Mechanics:requestImpound')
AddEventHandler('iG_Mechanics:requestImpound', function()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    if vehicle ~= nil then
        local coords    = GetEntityCoords(vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model))
        local primary = colours[tostring(vehicleProps.color1)]
        exports['mythic_progbar']:Progress({
            name = "request_impound",
            duration = 10500,
            label = "Writing impound request..",
            useWhileDead = true,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 49,
            },
            prop = {
                model = "p_amb_clipboard_01",
                bone = 18905,
                coords = { x = 0.10, y = 0.02, z = 0.08 },
                rotation = { x = -80.0, y = 0.0, z = 0.0 },
            },
            propTwo = {
                model = "prop_pencil_01",
                bone = 58866,
                coords = { x = 0.12, y = 0.0, z = 0.001 },
                rotation = { x = -150.0, y = 0.0, z = 0.0 },
            },
        }, function(status)
            if not status then
                local id = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdCanMigrate(id, true)
		        SetEntityAsMissionEntity(vehicle, true, false)
                TriggerServerEvent('iG_Mechanics:insertImpoundRequest', vehicleLabel .. ', ' .. primary, GetVehicleNumberPlateText(vehicle), coords)
                exports['mythic_notify']:SendAlert('success', 'NSWPF: Impound request complete, mechanics have been notified.')
            end
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Error: Vehicle not found, please move around and try again.')
    end
end)





-- Mechanic UI Element for Unclaimed Vehicles
function VehicleRequestedImpoundMenu()
	ESX.UI.Menu.CloseAll()
    local elements = {}

    if not onRequestJob then 
        table.insert(elements, {label = 'Unclaimed Impound Requests', value = 'unclaimed_impounds'})
        table.insert(elements, {label = 'Claimed Impound Requests', value = 'claimed_impounds'})
    end

    if onRequestJob then 
        table.insert(elements, {label = 'Current Impound Request', value = 'current_request'})
        table.insert(elements, {label = 'Claimed Impound Requests', value = 'claimed_impounds'})
        table.insert(elements, {label = 'Cancel Current Request', value = 'cancel_request'})
    end
    
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mech_imp_actions', {
		title    = 'Mechanic Impound Menu',
		align    = 'right',
		elements = elements
	}, function(data, menu)

        ---------------------------------------------------
        ------- Unclaimed Impounds Menu Option
        ---------------------------------------------------
        if data.current.value == 'unclaimed_impounds' then

	        ESX.UI.Menu.CloseAll()

            local elements2 = {}

            for k, v in pairs(cl_UnclaimedImpounds) do 
                table.insert(elements2, {label = '(' .. v.id .. ') ' .. v.plate, value = v.id, data = v})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mech_imp_actions', {
                title    = 'Unclaimed Impound Requests',
                align    = 'right',
                elements = elements2
            }, function(data2, menu2)
                
                if data2.current.value ~= nil then

                    local currentStreetHash = GetStreetNameAtCoord(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z, currentStreetHash)
                    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                    local zone = tostring(GetNameOfZone(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z))

                    exports['mythic_notify']:SendAlert('success', '<strong>Impound Request Claimed!</strong><br><strong>Information (ID: ' .. data2.current.value .. ')</strong><br>Officer: ' .. data2.current.data.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. data2.current.data.vehicleInfo .. '<br>Plate: ' .. data2.current.data.plate, 9500)
                   
                    TriggerServerEvent('iG_Mechanics:claimImpoundRequest', data2.current.value)
                    SetNewWaypoint(data2.current.data.coords.x, data2.current.data.coords.y)
                    currentRequestData = data2.current.data
                    onRequestJob = true
                    menu2.close()
                end

            end, function(data2, menu2)
                menu2.close()

            end, function(data2, menu2)

                local currentStreetHash = GetStreetNameAtCoord(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z, currentStreetHash)
                currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                local zone = tostring(GetNameOfZone(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z))
            
                exports['mythic_notify']:SendAlert('inform', '<strong>Information (ID: ' .. data2.current.value .. ')</strong><br>Officer: ' .. data2.current.data.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. data2.current.data.vehicleInfo .. '<br>Plate: ' .. data2.current.data.plate, 9500)
            
            -- end, function(data2, menu2)
            --     menu2.close()
            end)
        
        
        ---------------------------------------------------
        ------- Claimed Impounds Menu Option
        ---------------------------------------------------
        elseif data.current.value == 'claimed_impounds' then

	        ESX.UI.Menu.CloseAll()

            local elements2 = {}

            for k, v in pairs(cl_ClaimedImpounds) do 
                -- print(v.plate)
               table.insert(elements2, {label = '(ID:' .. v.id .. ') ' .. v.mechanic, value = v.id, data = v})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mech_imp_actions', {
                title    = 'Claimed Impound Requests',
                align    = 'right',
                elements = elements2
            }, function(data2, menu2)

                local currentStreetHash = GetStreetNameAtCoord(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z, currentStreetHash)
                currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                local zone = tostring(GetNameOfZone(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z))

                exports['mythic_notify']:SendAlert('inform', '<strong>Information (ID: ' .. data2.current.value .. ')</strong><br>Officer: ' .. data2.current.data.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. data2.current.data.vehicleInfo .. '<br>Plate: ' .. data2.current.data.plate, 9500)
                
                menu2.close()

            end, function(data2, menu2)
                menu2.close()

            end, function(data2, menu2)

                local currentStreetHash = GetStreetNameAtCoord(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z, currentStreetHash)
                currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                local zone = tostring(GetNameOfZone(data2.current.data.coords.x, data2.current.data.coords.y, data2.current.data.coords.z))

                exports['mythic_notify']:SendAlert('inform', '<strong>Information (ID: ' .. data2.current.value .. ')</strong><br>Officer: ' .. data2.current.data.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. data2.current.data.vehicleInfo .. '<br>Plate: ' .. data2.current.data.plate, 9500)                

            -- end, function(data2, menu2)
            --     menu2.close()
            end)
        
        ---------------------------------------------------
        ------- Current Impound Request
        ---------------------------------------------------
        elseif data.current.value == 'current_request' then
            local currentStreetHash = GetStreetNameAtCoord(currentRequestData.coords.x, currentRequestData.coords.y, currentRequestData.coords.z, currentStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            local zone = tostring(GetNameOfZone(currentRequestData.coords.x, currentRequestData.coords.y, currentRequestData.coords.z))

            exports['mythic_notify']:SendAlert('inform', '<strong>Current Impound Request:</strong><br><strong>Information (ID: ' .. currentRequestData.id .. ')</strong><br>Officer: ' .. currentRequestData.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. currentRequestData.vehicleInfo .. '<br>Plate: ' .. currentRequestData.plate, 9500)
            
            SetNewWaypoint(currentRequestData.coords.x, currentRequestData.coords.y)

            menu.close()

        elseif data.current.value == 'cancel_request' then
            local currentStreetHash = GetStreetNameAtCoord(currentRequestData.coords.x, currentRequestData.coords.y, currentRequestData.coords.z, currentStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            local zone = tostring(GetNameOfZone(currentRequestData.coords.x, currentRequestData.coords.y, currentRequestData.coords.z))
            
            exports['mythic_notify']:SendAlert('error', '<strong>Cancelled Impound Request:</strong><br><strong>Information (ID: ' .. currentRequestData.id .. ')</strong><br>Officer: ' .. currentRequestData.officer .. '<br>Location: ' .. currentStreetName .. ', ' .. GetLabelText(zone) .. '<br><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. currentRequestData.vehicleInfo .. '<br>Plate: ' .. currentRequestData.plate, 9500)
            
            TriggerServerEvent('iG_Mechanics:cancelImpoundRequest', currentRequestData.id)
            onRequestJob = false

            menu.close()

        end

    
    end, function(data, menu)
        menu.close()
    end)
end


-- Mechanic UI Element for Unclaimed Vehicles
function VehicleAssignedImpoundMenu()
	ESX.UI.Menu.CloseAll()
    local elements = {}

    if onAssignedJob then 
        table.insert(elements, {label = 'Current Impound Request', value = 'current_request'})
        table.insert(elements, {label = 'Cancel Current Request', value = 'cancel_request'})
    end
    
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mech_ass_actions', {
		title    = 'Assigned Impound Menu',
		align    = 'right',
		elements = elements
	}, function(data, menu)

        ---------------------------------------------------
        ------- Current Impound Request
        ---------------------------------------------------
        if data.current.value == 'current_request' then
            exports['mythic_notify']:SendAlert('inform', '<strong>Current Impound Assignment:</strong><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. currentAssignedData.vehicleInfo .. '<br>Plate: ' .. currentAssignedData.plate, 9500)
            menu.close()

        elseif data.current.value == 'cancel_request' then

            exports['mythic_notify']:SendAlert('error', '<strong>Cancelled Impound Assignment:</strong><br><strong>Vehicle Information:</strong><br>Vehicle: ' .. currentAssignedData.vehicleInfo .. '<br>Plate: ' .. currentAssignedData.plate, 9500)
            onAssignedJob = false

            menu.close()

        end

    
    end, function(data, menu)
        menu.close()
    end)
end


-- Mechanic UI Element for claimed Vehicles





-- Mechanic Notifications
RegisterNetEvent('iG_Mechanics:impoundRequest')
AddEventHandler('iG_Mechanics:impoundRequest', function(data, notify)
    if isMechanic then
        cl_UnclaimedImpounds = data
        if notify then
            exports['mythic_notify']:SendAlert('inform', 'Mechanic: New impound request recieved.')
        end
    end
end)


RegisterNetEvent('iG_Mechanics:updateImpoundData')
AddEventHandler('iG_Mechanics:updateImpoundData', function(svUC, svC)
    if isMechanic then
        cl_UnclaimedImpounds = svUC
        cl_ClaimedImpounds = svC
    end
end)






colours = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steel",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black Steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "Police Car Blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metallic Dark Blue",
    ['147'] = "Black",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "Default Alloy Color",
    ['157'] = "Epsilon Blue",
    ['158'] = "Pure Gold",
    ['159'] = "Brushed Gold",
    ['160'] = "MP100"
}