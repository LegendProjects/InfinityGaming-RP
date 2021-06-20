-- Made by IB1G, edited by Inferno (Christopher M.)

local LicencePlate = {}
LicencePlate.Index = false
LicencePlate.Number = false

RegisterNetEvent('plateRemover:UseBlankPlate')
AddEventHandler('plateRemover:UseBlankPlate', function()
-- Check if the player has plates stored
    if not LicencePlate.Index and not LicencePlate.Number then
        -- Client's ped
        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Client's coords
        local VehicleCoords = GetEntityCoords(Vehicle)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        -- If within range and Ped is in a vehicle
        if Distance < 3.5 and not IsPedInAnyVehicle(PlayerPed, false) then
            -- Notification and animation
            TriggerEvent("mythic_progbar:client:progress", {
                name = "retirarmatricula",
                duration = 7000,
                label = "Removing plate...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                }
            }, function(status)
                if not status then
                    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                end
            end)
            -- Wait 7 seconds
            Citizen.Wait(7000)
            -- Store plate index
            LicencePlate.Index = GetVehicleNumberPlateTextIndex(Vehicle)
            -- Store plate number
            LicencePlate.Number = GetVehicleNumberPlateText(Vehicle)
            -- Set the plate to nothing
            SetVehicleNumberPlateText(Vehicle, " ")
            TriggerServerEvent('vy_UsableItems:GivePlate', 1)
        else
            -- Notification
            exports["mythic_notify"]:SendAlert("error", "No vehicle nearby")
        end
    else
        -- Notification
        exports["mythic_notify"]:SendAlert("error", "You already have a licence plate on you")
    end

end)

RegisterNetEvent('plateRemover:UseOriginalPlate')
AddEventHandler('plateRemover:UseOriginalPlate', function()
-- Check if the player has plates stored
    if LicencePlate.Index and LicencePlate.Number then

        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Client's coords
        local VehicleCoords = GetEntityCoords(Vehicle)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        -- If within range and Ped is in a vehicle
        if Distance < 3.5 and not IsPedInAnyVehicle(PlayerPed, false) then
            -- Notification and animation
            TriggerEvent("mythic_progbar:client:progress", {
                name = "retirarmatricula",
                duration = 7000,
                label = "placing plate...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                }
            }, function(status)
                if not status then
                    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                end
            end)
            -- Wait 0 seconds
            Citizen.Wait(7000)
            -- Set plate index to stored index
            SetVehicleNumberPlateTextIndex(Vehicle, LicencePlate.Index)
            -- Set plate number to stored number
            SetVehicleNumberPlateText(Vehicle, LicencePlate.Number)
            -- Reset stored values
            LicencePlate.Index = false
            LicencePlate.Number = false
            TriggerServerEvent('vy_UsableItems:GivePlate', 2)
        else
            -- Notification
            exports['mythic_notify']:SendAlert("error", "No vehicle nearby")
        end
    else
        -- Notification
        exports['mythic_notify']:SendAlert("error", "You do not have a licence plate on you")
    end

end)