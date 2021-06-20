local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local GUI = {}
GUI.Time = 0
local PlayerData = {}
local timer = 0
RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    exports['ig-keybinds']:RegisterKeybind('OpenInteractionMenu', 'Open Interaction Menu', 'F7', OpenInteractionMenu)
end)

OpenInteractionMenu = function()
    if (not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
        TriggerEvent('igMenu:closeAllSubMenu')
        TriggerEvent('igMenu:closeAllMenu')
        TriggerEvent('igMenu:openMenuPersonnel')
        GUI.Time  = GetGameTimer()
    end
    if (ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
        TriggerEvent('igMenu:closeAllSubMenu')
        TriggerEvent('igMenu:closeAllMenu')
        GUI.Time  = GetGameTimer()
    end
end
--Notification joueur
function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

--Message text joueur
function Text(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(0)
    SetTextScale(0.378, 0.378)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.017, 0.977)
end

function OpenPersonnelMenu()

    ESX.UI.Menu.CloseAll()

  

        local elements = {}

        table.insert(elements, { label = 'Identification Menu', value = 'menuperso_moi' })
        -- table.insert(elements, { label = 'View Invoices', value = 'invoicemenu' })

        if (IsInVehicle()) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1)) then
                table.insert(elements, { label = 'Vehicle Menu', value = 'menuperso_vehicule' })
            end
        end

        -- table.insert(elements, { label = 'GPS Menu', value = 'menuperso_gpsrapide' })

        -- if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'commissioner' or PlayerData.job.grade_name == 'dcommissioner' or PlayerData.job.grade_name == 'acommissioner' then
        --     table.insert(elements, { label = 'Business Management', value = 'menuperso_grade' })
        -- end
        -- if timer <= 0 then
        --     table.insert(elements, { label = 'Character Switch', value = 'switch_character' })
        -- elseif timer >= 1 then
        --     table.insert(elements, { label = 'Character Switch (Cooldown: '.. timer .. ' seconds.)', value = 'switch_character' })
        -- end
        ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'menu_perso',
                {
                    css = 'unknownstory',
                    title = 'Interaction Menu',
                    align = 'right',
                    elements = elements
                },
                function(data, menu)

                    elements = {}

                
                    if data.current.value == 'menuperso_vehicule' then
                        OpenVehiculeMenu()
                    end

                    if data.current.value == 'menuperso_moi' then
                        ESX.UI.Menu.Open(
                                'default', GetCurrentResourceName(), 'id_card_menu',
                                {
                                    css = 'unknownstory',
                                    title = 'Identification Menu',
                                    align = 'right',
                                    elements = {
                                        { label = 'Check Identification', value = 'checkID' },
                                        { label = 'Show Identification', value = 'showID' },
                                        { label = 'Check Drivers License', value = 'checkDriver' },
                                        { label = 'Show Drivers License', value = 'showDriver' },
                                        { label = 'Check Firearms License', value = 'checkFirearms' },
                                        { label = 'Show Firearms License', value = 'showFirearms' },
                                    }
                                },
                                function(data2, _)
                                    if data2.current.value == 'checkID' then
                                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                                    elseif data2.current.value == 'checkDriver' then
                                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                                    elseif data2.current.value == 'checkFirearms' then
                                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                                    else
                                        local player, distance = ESX.Game.GetClosestPlayer()

                                        if distance ~= -1 and distance <= 3.0 then
                                            if data2.current.value == 'showID' then
                                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                            elseif data2.current.value == 'showDriver' then
                                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                                            elseif data2.current.value == 'showFirearms' then
                                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                                            end
                                        else
                                            ESX.ShowNotification('No nearby players.')
                                        end
                                    end
                                end,
                                function(_, menu2)
                                    menu2.close()
                                end
                        )
                    end

                end,
                function(data, menu)
                    menu.close()
                end
        )

end

---------------------------------------------------------------------------Vehicule Menu

function OpenVehiculeMenu()

    ESX.UI.Menu.CloseAll()

    local elements = {}

    if vehiculeON then
        table.insert(elements, { label = 'Toggle Engine (Off)', value = 'menuperso_vehicule_MoteurOff' })
    else
        table.insert(elements, { label = 'Toggle Engine (On)', value = 'menuperso_vehicule_MoteurOn' })
    end

    if porteAvantGaucheOuverte then
        table.insert(elements, { label = 'Left Door (Close)', value = 'menuperso_vehicule_fermerportes_fermerportegauche' })
    else
        table.insert(elements, { label = 'Left Door (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirportegauche' })
    end

    if porteAvantDroiteOuverte then
        table.insert(elements, { label = 'Right Door (Close)', value = 'menuperso_vehicule_fermerportes_fermerportedroite' })
    else
        table.insert(elements, { label = 'Right Door (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirportedroite' })
    end

    if porteArriereGaucheOuverte then
        table.insert(elements, { label = 'Rear Left Door (Close)', value = 'menuperso_vehicule_fermerportes_fermerportearrieregauche' })
    else
        table.insert(elements, { label = 'Rear Left Door (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche' })
    end

    if porteArriereDroiteOuverte then
        table.insert(elements, { label = 'Rear Right Door (Close)', value = 'menuperso_vehicule_fermerportes_fermerportearrieredroite' })
    else
        table.insert(elements, { label = 'Rear Right Door (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite' })
    end

    if porteCapotOuvert then
        table.insert(elements, { label = 'Bonnet (Close)', value = 'menuperso_vehicule_fermerportes_fermercapot' })
    else
        table.insert(elements, { label = 'Bonnet (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrircapot' })
    end

    if porteCoffreOuvert then
        table.insert(elements, { label = 'Trunk (Close)', value = 'menuperso_vehicule_fermerportes_fermercoffre' })
    else
        table.insert(elements, { label = 'Trunk (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrircoffre' })
    end

    if porteAutre1Ouvert then
        table.insert(elements, { label = 'Other #1 (Close)', value = 'menuperso_vehicule_fermerportes_fermerAutre1' })
    else
        table.insert(elements, { label = 'Other #1 (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre1' })
    end

    if porteAutre2Ouvert then
        table.insert(elements, { label = 'Other #2 (Close)', value = 'menuperso_vehicule_fermerportes_fermerAutre2' })
    else
        table.insert(elements, { label = 'Other #2 (Open)', value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre2' })
    end

    if porteToutOuvert then
        table.insert(elements, { label = 'Close All', value = 'menuperso_vehicule_fermerportes_fermerTout' })
    else
        table.insert(elements, { label = 'Open All', value = 'menuperso_vehicule_ouvrirportes_ouvrirTout' })
    end

    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'menuperso_vehicule',
            {
                css = 'unknownstory',
                --  img = 'menu_vehicule',
                title = 'Vehicle Menu',
                align = 'right',
                elements = elements
            },
            function(data, menu)
                --------------------- GESTION MOTEUR
                if data.current.value == 'menuperso_vehicule_MoteurOn' then
                    vehiculeON = true
                    SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false, true)
                    SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_MoteurOff' then
                    vehiculeON = false
                    SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false, true)
                    SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
                    OpenVehiculeMenu()
                end
                --------------------- OUVRIR LES PORTES
                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportegauche' then
                    porteAvantGaucheOuverte = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportedroite' then
                    porteAvantDroiteOuverte = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche' then
                    porteArriereGaucheOuverte = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite' then
                    porteArriereDroiteOuverte = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircapot' then
                    porteCapotOuvert = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircoffre' then
                    porteCoffreOuvert = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre1' then
                    porteAutre1Ouvert = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre2' then
                    porteAutre2Ouvert = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirTout' then
                    porteAvantGaucheOuverte = true
                    porteAvantDroiteOuverte = true
                    porteArriereGaucheOuverte = true
                    porteArriereDroiteOuverte = true
                    porteCapotOuvert = true
                    porteCoffreOuvert = true
                    porteAutre1Ouvert = true
                    porteAutre2Ouvert = true
                    porteToutOuvert = true
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, false, false)
                    SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, false, false)
                    OpenVehiculeMenu()
                end
                --------------------- FERMER LES PORTES
                if data.current.value == 'menuperso_vehicule_fermerportes_fermerportegauche' then
                    porteAvantGaucheOuverte = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerportedroite' then
                    porteAvantDroiteOuverte = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieregauche' then
                    porteArriereGaucheOuverte = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieredroite' then
                    porteArriereDroiteOuverte = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermercapot' then
                    porteCapotOuvert = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermercoffre' then
                    porteCoffreOuvert = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerAutre1' then
                    porteAutre1Ouvert = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerAutre2' then
                    porteAutre2Ouvert = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, false, false)
                    OpenVehiculeMenu()
                end

                if data.current.value == 'menuperso_vehicule_fermerportes_fermerTout' then
                    porteAvantGaucheOuverte = false
                    porteAvantDroiteOuverte = false
                    porteArriereGaucheOuverte = false
                    porteArriereDroiteOuverte = false
                    porteCapotOuvert = false
                    porteCoffreOuvert = false
                    porteAutre1Ouvert = false
                    porteAutre2Ouvert = false
                    porteToutOuvert = false
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, false, false)
                    SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, false, false)
                    OpenVehiculeMenu()
                end

            end,
            function(data, menu)
                menu.close()
            end
    )
end

---------------------------------------------------------------------------Me concernant


-- Verifie si le joueurs est dans un vehicule ou pas
function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end

---------------------------------------------------------------------------------------------------------
--igMenu : gestion des menu
---------------------------------------------------------------------------------------------------------
RegisterNetEvent('igMenu:openMenuPersonnel')
AddEventHandler('igMenu:openMenuPersonnel', function()
    OpenPersonnelMenu()
end)
