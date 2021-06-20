ESX = nil
local currentPlate = ""
local currentType = 0

local job = ""
local callsign = ""
local isLoggedIn = false

local unitCooldown = false
local alertsToggled = true
local unitBlipsToggled = true
local callBlipsToggled = true

local callBlips = {}
local jobInfo = {}
local blips = {}

local scriptLoaded = false
local playerLoaded = false

Citizen.CreateThread( function()
    while ESX == nil do
        TriggerEvent(
            "iG:getSharedObject",
            function(obj)
                ESX = obj
            end
        )
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()

    if Config.Debug then 
        if ESX.IsPlayerLoaded() then
            playerLoaded = true
            job = ESX.GetPlayerData().job.name
            isLoggedIn = true

            if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
                callsign = "NO CALLSIGN"
                if callsign ~= "NO CALLSIGN" then
                    TriggerServerEvent('core_dispatch:setCallSign', callsign)
                end

                updateJobInfo()

                ESX.TriggerServerCallback("core_dispatch:getPersonalInfo", function(firstname, lastname)
                    SendNUIMessage(
                        {
                            type = "Init",
                            firstname = firstname,
                            lastname = lastname,
                            jobInfo = jobInfo
                        }
                    )
                end)
            end
        end
    end

    scriptLoaded = true
end)

RegisterNetEvent("iG:playerLoaded")
AddEventHandler("iG:playerLoaded", function()
    ESX.PlayerData = ESX.GetPlayerData()
    playerLoaded = true
    isLoggedIn = true
    job = ESX.PlayerData.job.name

    if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
        callsign = "NO CALLSIGN"
        if callsign ~= "NO CALLSIGN" then
            TriggerServerEvent('core_dispatch:setCallSign', callsign)
        end

        updateJobInfo()

        ESX.TriggerServerCallback("core_dispatch:getPersonalInfo", function(firstname, lastname)
            SendNUIMessage(
                {
                    type = "Init",
                    firstname = firstname,
                    lastname = lastname,
                    jobInfo = jobInfo
                }
            )
        end)
    end
    
end)

RegisterNetEvent("iG:setJob")
AddEventHandler("iG:setJob", function(JobInfo)
    if playerLoaded and scriptLoaded then 
        ESX.PlayerData = ESX.GetPlayerData()
        Citizen.Wait(1000)
        job = ESX.PlayerData.job.name
        if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
            callsign = "NO CALLSIGN"
            if callsign ~= "NO CALLSIGN" then
                TriggerServerEvent('core_dispatch:setCallSign', callsign)
            end

            updateJobInfo()

            ESX.TriggerServerCallback("core_dispatch:getPersonalInfo", function(firstname, lastname)
                SendNUIMessage(
                    {
                        type = "Init",
                        firstname = firstname,
                        lastname = lastname,
                        jobInfo = jobInfo
                    }
                )
            end)
        end
    end
end)

--Shots in area
Citizen.CreateThread(
    function()
        while Config.EnableShootingAlerts do
            Citizen.Wait(10)
            local whithin = false
            local ped = PlayerPedId()
            local playerPos = GetEntityCoords(ped)

            for _, v in ipairs(Config.ShootingZones) do
                local distance = #(playerPos - v.coords)
                if distance < v.radius then
                    whithin = true
                end
            end

            if whithin then

            
                if IsPedShooting(ped) and math.random(1, 2) == 1 then
                    local gender = "unknown"
                    local model = GetEntityModel(ped)
                    if (model == GetHashKey("mp_f_freemode_01")) then
                        gender = "female"
                    end
                    if (model == GetHashKey("mp_m_freemode_01")) then
                        gender = "male"
                    end

                    local x, y, z = table.unpack(playerPos)
                    local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
                    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                    local zone = tostring(GetNameOfZone(x, y, z))
                    local locationString = currentStreetName .. ', ' .. GetLabelText(zone)

                    TriggerServerEvent("core_dispatch:addCall", 
                    "10-13A", "Reported shots fired within area", {
                        {icon = "fa-globe-europe", info = locationString},
                        {icon = "fa-venus-mars", info = gender}
                    }, {playerPos[1], playerPos[2], playerPos[3]}, "police")

                    Citizen.Wait(20000)
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
)


-- AddEventHandler('onResourceStart', function (resourceName)
--     if(GetCurrentResourceName() == resourceName) then
--         while ESX == nil do
--             Citizen.Wait(200)
--         end
        
--         isLoggedIn = true
--         job = ESX.GetPlayerData().job.name
--         currentPlate = ""
--         currentType = 0
--         if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
--             callsign = "NO CALLSIGN"
--             if callsign ~= "NO CALLSIGN" then
--                 TriggerServerEvent('core_dispatch:setCallSign', callsign)
--             end

--             updateJobInfo()

--            ESX.TriggerServerCallback("core_dispatch:getPersonalInfo", function(firstname, lastname)
--                 SendNUIMessage(
--                     {
--                         type = "Init",
--                         firstname = firstname,
--                         lastname = lastname,
--                         jobInfo = jobInfo
--                     }
--                 )
--             end)
--         end
--     end
-- end)

RegisterKeyMapping('dispatch', "Open Dispatch using " .. Config.OpenMenuKey, "keyboard", Config.OpenMenuKey)

local otherCooldownTimer = 0
Citizen.CreateThread(function()
    while true do
        if otherCooldownTimer >= 1 then
            otherCooldownTimer = otherCooldownTimer - 1
        end
        Citizen.Wait(1000)
    end
end)

RegisterCommand('dispatch', function()
    if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance' then 
        if otherCooldownTimer <= 1 then 
            openDispatch()    
            otherCooldownTimer = 10
        elseif otherCooldownTimer >= 2 then
            exports['mythic_notify']:SendAlert('error', 'Error: Please stop spam opening the dispatch system.<br>(Cooldown: ' .. otherCooldownTimer .. ' seconds)')
        end
    end
end, false)

RegisterCommand(Config.JobOne.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addMessage",
        msg,
        {cord[1], cord[2], cord[3]},
        Config.JobOne.job,
        7500,
        Config.callCommandSprite,
        Config.callCommandColor
    )
end, false)

RegisterCommand(Config.JobTwo.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent(
        "core_dispatch:addMessage",
        msg,
        {cord[1], cord[2], cord[3]},
        Config.JobTwo.job,
        7500,
        Config.callCommandSprite,
        Config.callCommandColor
    )
end, false)

RegisterCommand(Config.JobThree.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addMessage",
        msg,
        {cord[1], cord[2], cord[3]},
        Config.JobThree.job,
        7500,
        Config.callCommandSprite,
        Config.callCommandColor
    )
end, false)

function addBlipForCall(sprite, color, coords, text)
    local alpha = 250
    local radius = AddBlipForRadius(coords, 40.0)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.3)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, false)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring("Dispatch: Active Call (ID:" .. text .. ")"))
    EndTextCommandSetBlipName(blip)

    SetBlipHighDetail(radius, true)
    SetBlipColour(radius, color)
    SetBlipAlpha(radius, alpha)
    SetBlipAsShortRange(radius, true)

    table.insert(callBlips, blip)
    table.insert(callBlips, radius)

    while alpha ~= 0 do
        Citizen.Wait(Config.CallBlipDisappearInterval)
        alpha = alpha - 1
        SetBlipAlpha(radius, alpha)

        if alpha == 0 then
            RemoveBlip(radius)
            RemoveBlip(blip)
         
            return
        end
    end
end

function addBlipsForUnits()
    ESX.TriggerServerCallback("core_dispatch:getUnits", function(units)
        local id = GetPlayerServerId(PlayerId())

        for _, z in pairs(blips) do
            RemoveBlip(z)
        end

        blips = {}

        for k, v in pairs(units) do
            if
                k ~= id and
                    (Config.JobOne.job == v.job or Config.JobTwo.job == v.job or Config.JobThree.job == v.job)
                then
                local color = 0
                local title = ""
                if Config.JobOne.job == v.job then
                    color = Config.JobOne.blipColor
                    title = Config.JobOne.label
                end
                if Config.JobTwo.job == v.job then
                    color = Config.JobTwo.blipColor
                    title = Config.JobTwo.label
                end
                if Config.JobThree.job == v.job then
                    color = Config.JobThree.blipColor
                    title = Config.JobThree.label
                end

                local new_blip = AddBlipForEntity(NetworkGetEntityFromNetworkId(v.netId))

                SetBlipSprite(new_blip, Config.Sprite[v.type])
                ShowHeadingIndicatorOnBlip(new_blip, true)
                HideNumberOnBlip(new_blip)
                SetBlipScale(new_blip, 0.7)
                SetBlipCategory(new_blip, 7)
                SetBlipColour(new_blip, color)
                SetBlipAsShortRange(new_blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("(" .. title .. ") " .. v.firstname .. " " .. v.lastname)
                EndTextCommandSetBlipName(new_blip)

                blips[k] = new_blip
            end
        end
    end)
end

function openDispatch()
    if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
        SetNuiFocus(false, false)
        ESX.TriggerServerCallback("core_dispatch:getInfo", function(units, calls, ustatus, callsigns)
            SetNuiFocus(true, true)

            SendNUIMessage(
                {
                    type = "open",
                    units = units,
                    calls = calls,
                    ustatus = ustatus,
                    job = job,
                    callsigns = callsigns,
                    id = GetPlayerServerId(PlayerId())
                }
            )
        end)
    end
end

function updateJobInfo()
    jobInfo[Config.JobOne.job] = {
        color = Config.JobOne.color,
        column = 1,
        label = Config.JobOne.label,
        canRequestLocalBackup = Config.JobOne.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobOne.canRequestOtherJobBackup,
        forwardCall = Config.JobOne.forwardCall,
        canRemoveCall = Config.JobOne.canRemoveCall
    }
    jobInfo[Config.JobTwo.job] = {
        color = Config.JobTwo.color,
        column = 2,
        label = Config.JobTwo.label,
        canRequestLocalBackup = Config.JobTwo.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobTwo.canRequestOtherJobBackup,
        forwardCall = Config.JobTwo.forwardCall,
        canRemoveCall = Config.JobTwo.canRemoveCall
    }
    jobInfo[Config.JobThree.job] = {
        color = Config.JobThree.color,
        column = 3,
        label = Config.JobThree.label,
        canRequestLocalBackup = Config.JobThree.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobThree.canRequestOtherJobBackup,
        forwardCall = Config.JobThree.forwardCall,
        canRemoveCall = Config.JobThree.canRemoveCall
    }
end

RegisterNetEvent("core_dispatch:callAdded")
AddEventHandler("core_dispatch:callAdded", function(id, call, j, cooldown, sprite, color)
    if job == j and alertsToggled then
        SendNUIMessage(
            {
                type = "call",
                id = id,
                call = call,
                cooldown = cooldown
            }
        )

        if Config.AddCallBlips then
            addBlipForCall(sprite, color, vector3(call.coords[1], call.coords[2], call.coords[3]), id)
        end
    end
end)

RegisterNUICallback("dismissCall", function(data)
    local id = data["id"]:gsub("call_", "")

    TriggerServerEvent("core_dispatch:unitDismissed", id)
    DeleteWaypoint()
end)

RegisterNUICallback("updatestatus", function(data)
    local id = data["id"]
    local status = data["status"]

   

    TriggerServerEvent("core_dispatch:changeStatus", id, status)
end)

RegisterNUICallback("sendnotice", function(data)
    local caller = data["caller"]

    if Config.EnableUnitArrivalNotice then
        TriggerServerEvent("core_dispatch:arrivalNotice", caller)
    end
end)

RegisterNetEvent("core_dispatch:SendTextMessage")
AddEventHandler("core_dispatch:SendTextMessage", function(msg)
   SendTextMessage(msg)
end)

RegisterNetEvent("core_dispatch:arrivalNoticeClient")
AddEventHandler("core_dispatch:arrivalNoticeClient", function()
    if not unitCooldown then
        SendTextMessage(Config.Text["someone_is_reacting"])
        unitCooldown = true
        Citizen.Wait(20000)
        unitCooldown = false
    end
end)

RegisterNUICallback("reqbackup", function(data)
    local hasRadio = exports['ig-inventory']:HasItem('radio', 1)
    if hasRadio then 
        local j = data["job"]
        local req = data["requester"]
        local firstname = data["firstname"]
        local lastname = data["lastname"]
        SendTextMessage(Config.Text["backup_requested"])
        local playerPos = GetEntityCoords(GetPlayerPed(-1))
        local x, y, z = table.unpack(playerPos)
        local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
        local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        local zone = tostring(GetNameOfZone(x, y, z))
        local locationString = currentStreetName .. ', ' .. GetLabelText(zone)
        TriggerServerEvent(
            "core_dispatch:addCall",
            "10-32E",
            req .. " Backup Request [Code 3]",
            {
                {icon = "fa-globe-europe", info = locationString},
                {icon = "fa-user-friends", info = ESX.PlayerData.job.grade_label .. " " .. firstname .. " " .. lastname}
            },
            {playerPos[1], playerPos[2], playerPos[3]},
            j
        )
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You must have a radio to call for backup.')
    end
end)

RegisterNUICallback(
    "toggleoffduty",
    function(data)
        ToggleDuty()
    end
)

RegisterNUICallback(
    "togglecallblips",
    function(data)
        callBlipsToggled = not callBlipsToggled

        if callBlipsToggled then
            for _, z in pairs(callBlips) do
                SetBlipDisplay(z, 4)
            end
            SendTextMessage(Config.Text["call_blips_turned_on"])
        else
            for _, z in pairs(callBlips) do
                SetBlipDisplay(z, 0)
            end

            SendTextMessage(Config.Text["call_blips_turned_off"])
        end
    end
)

RegisterNUICallback(
    "toggleunitblips",
    function(data)
        unitBlipsToggled = not unitBlipsToggled

        if unitBlipsToggled then
            addBlipsForUnits()
            SendTextMessage(Config.Text["unit_blips_turned_on"])
        else
            for _, z in pairs(blips) do
                RemoveBlip(z)
            end

            blips = {}
            SendTextMessage(Config.Text["unit_blips_turned_off"])
        end
    end
)

RegisterNUICallback(
    "togglealerts",
    function(data)
        alertsToggled = not alertsToggled

        if alertsToggled then
            SendTextMessage(Config.Text["alerts_turned_on"])
        else
            SendTextMessage(Config.Text["alerts_turned_off"])
        end
    end
)

RegisterNUICallback(
    "copynumber",
    function(data)
        SendTextMessage(Config.Text["phone_number_copied"])
    end
)

RegisterNUICallback(
    "forwardCall",
    function(data)
        local id = data["id"]:gsub("call_", "")

        SendTextMessage(Config.Text["call_forwarded"])
        TriggerServerEvent("core_dispatch:forwardCall", id, data["job"])
    end
)

RegisterNUICallback(
    "acceptCall",
    function(data)

       
        local id = data["id"]:gsub("call_", "")

        SetNewWaypoint(tonumber(data["x"]), tonumber(data["y"]))

        TriggerServerEvent("core_dispatch:unitResponding", id, job)
    end
)

RegisterNUICallback(
    "changecallsign",
    function(data)

       
        local callsign = data["callsign"]


     

        TriggerServerEvent("core_dispatch:changeCallSign",callsign)
    end
)


RegisterNetEvent("core_dispatch:acceptCallClient")
AddEventHandler("core_dispatch:acceptCallClient", function(id, unit)
    if unit == GetPlayerServerId(PlayerId()) then
          SendTextMessage(Config.Text["accepted"])
    end

    SendNUIMessage(
        {
            type = "accept",
            id = unit
        }
    )
end)

RegisterNUICallback("removeCall", function(data)
    if ESX.PlayerData.job.name == 'police' then 
        if ESX.PlayerData.job.grade >= 5 then
            local id = data["id"]:gsub("call_", "")
            TriggerServerEvent("core_dispatch:removeCall", id)
        else
            exports['mythic_notify']:SendAlert('error', 'Error: You do not have permission to remove calls.')
        end
    elseif ESX.PlayerData.job.name == 'ambulance' then 
        local id = data["id"]:gsub("call_", "")
        TriggerServerEvent("core_dispatch:removeCall", id)
    end
end)

RegisterNetEvent("core_dispatch:removeCallClient")
AddEventHandler("core_dispatch:removeCallClient", function(id, unit)
    if unit == GetPlayerServerId(PlayerId()) then

         SendTextMessage(Config.Text["call_removed"])
    end
    SendNUIMessage(
        {
            type = "remove",
            id = id
        }
    )
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)


Citizen.CreateThread( function()
    while Config.EnableMapBlipsForUnits do
        if isLoggedIn then
            if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
                if unitBlipsToggled then
                    addBlipsForUnits()
                end
            end
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread( function()
    while true do
        local sleep = 5000
        if isLoggedIn then
            if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
                sleep = 1500
                status = {
                    carPlate = currentPlate,
                    type = currentType,
                    job = job,
                    netId = NetworkGetNetworkIdFromEntity(PlayerPedId())
                }

                TriggerServerEvent("core_dispatch:playerStatus", status)
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread( function()
    while true do
        local sleep = 5000
        if isLoggedIn then
            if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
                sleep = 1500
                local ped = PlayerPedId()
                
                if IsPedInAnyVehicle(ped) then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    currentPlate = plate
                    currentType = GetVehicleClass(vehicle)
                else
                    currentPlate = ""
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

--EXPORTS

exports("addCall", function(code, title, extraInfo, coords, job, cooldown, sprite, color)
    TriggerServerEvent("core_dispatch:addCall", code, title, extraInfo, coords, job, cooldown or 5000, sprite or 11, color or 5)
end)

exports("addMessage", function(message, coords, job, cooldown, sprite, color)
    TriggerServerEvent("core_dispatch:addMessage", message, coords, job, cooldown or 5000, sprite or 11, color or 5)
end)

RegisterNetEvent('ig-dispatch:addMessage')
AddEventHandler('ig-dispatch:addMessage', function(incMessage, incNumber)
    local cord = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent(
        "core_dispatch:addMessage",
        incMessage,
        {cord[1], cord[2], cord[3]},
        incNumber,
        7500,
        Config.callCommandSprite,
        Config.callCommandColor
    )
end)

local cooldownTimer = 0
Citizen.CreateThread(function()
    while true do
        if cooldownTimer >= 1 then
            cooldownTimer = cooldownTimer - 1
        else
            Citizen.Wait(5000)
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('ig-dispatch:BackupRequest')
AddEventHandler('ig-dispatch:BackupRequest', function(code, name)
    local hasRadio = exports['ig-inventory']:HasItem('radio', 1)
    if hasRadio then 
        if cooldownTimer <= 1 then
            cooldownTimer = 10
            local playerPos = GetEntityCoords(GetPlayerPed(-1))
            local x, y, z = table.unpack(playerPos)
            local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
            local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            local zone = tostring(GetNameOfZone(x, y, z))
            local locationString = currentStreetName .. ', ' .. GetLabelText(zone)

            if code == "1" then 
                SendTextMessage(Config.Text["backup_requested"])

                TriggerServerEvent("core_dispatch:addCall", 
                "10-32A", "Backup Request [Code 1]", {
                    {icon = "fa-globe-europe", info = locationString},
                    {icon = "fa-address-card", info = ESX.PlayerData.job.grade_label .. " " .. name}
                }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
            
            elseif code == "2" then
                SendTextMessage(Config.Text["backup_requested"])

                TriggerServerEvent("core_dispatch:addCall", 
                "10-32B", "Backup Request [Code 2]", {
                    {icon = "fa-globe-europe", info = locationString},
                    {icon = "fa-address-card", info = ESX.PlayerData.job.grade_label .. " " .. name}
                }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
            
            elseif code == "3" then
                SendTextMessage(Config.Text["backup_requested"])

                TriggerServerEvent("core_dispatch:addCall", 
                "10-32C", "Backup Request [Code 3]", {
                    {icon = "fa-globe-europe", info = locationString},
                    {icon = "fa-address-card", info = ESX.PlayerData.job.grade_label .. " " .. name}
                }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
            
            elseif code == "99" then
                SendTextMessage(Config.Text["backup_requested"])

                TriggerServerEvent("core_dispatch:addCall", 
                "10-99A", "Officer Distress Signal [URGENT]", {
                    {icon = "fa-globe-europe", info = locationString},
                    {icon = "fa-address-card", info = ESX.PlayerData.job.grade_label .. " " .. name},
                    {icon = "fa-info-circle", info = "Priority situation, all units attend!"}
                }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Error: Please, stop spamming back-up requests.<br>(Cooldown: ' ..cooldownTimer .. ' seconds..)')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You must have a radio to call for backup.')
    end

end)


RegisterNetEvent('iG_Alert:cl_drugSale')
AddEventHandler('iG_Alert:cl_drugSale', function()
	if playerLoaded and scriptLoaded then
		local playerPos = GetEntityCoords(GetPlayerPed(-1))
        local x, y, z = table.unpack(playerPos)
        local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
        local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        local zone = tostring(GetNameOfZone(x, y, z))
        local locationString = currentStreetName .. ', ' .. GetLabelText(zone)


		TriggerServerEvent("core_dispatch:addCall", 
        "10-63A", "Drug sale in progress", {
            {icon = "fa-globe-europe", info = locationString},
            {icon = "fa-info-circle", info = "Request permission before attending. (Max: 6)"}
        }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
	end
end)

RegisterNetEvent('iG_Alert:Robbery_Alert')
AddEventHandler('iG_Alert:Robbery_Alert', function()
	if playerLoaded and scriptLoaded then
		local playerPos = GetEntityCoords(GetPlayerPed(-1))
		TriggerServerEvent("core_dispatch:addCall", 
        "10-90A", "Robbery in progress", {
            {icon = "fa-globe-europe", info = "Vangelico Fine Jewellery, Rockford Hills"},
            {icon = "fa-info-circle", info = "Priority situation, units please attend. (Max: 12)"}
        }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
	end
end)

RegisterNetEvent('iG_Alert:stockadeRobbery')
AddEventHandler('iG_Alert:stockadeRobbery', function()
	if playerLoaded and scriptLoaded then
        local playerPos = GetEntityCoords(GetPlayerPed(-1))
        local x, y, z = table.unpack(playerPos)
        local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
        local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        local zone = tostring(GetNameOfZone(x, y, z))
        local locationString = currentStreetName .. ', ' .. GetLabelText(zone)
		TriggerServerEvent("core_dispatch:addCall", 
        "10-90C", "Robbery in progress", {
            {icon = "fa-globe-europe", info = locationString},
            {icon = "fa-info-circle", info = "Available units, please attend. (Max: 8)"}
        }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
	end
end)


RegisterNetEvent('iG_Alert:storeRobbery')
AddEventHandler('iG_Alert:storeRobbery', function()
	if playerLoaded and scriptLoaded then
        local playerPos = GetEntityCoords(GetPlayerPed(-1))
        local x, y, z = table.unpack(playerPos)
        local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
        local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        local zone = tostring(GetNameOfZone(x, y, z))
        local locationString = currentStreetName .. ', ' .. GetLabelText(zone)
		TriggerServerEvent("core_dispatch:addCall", 
        "10-90B", "Robbery in progress", {
            {icon = "fa-globe-europe", info = locationString},
            {icon = "fa-info-circle", info = "Available units, please attend. (Max: 4)"}
        }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
	end
end)


RegisterNetEvent('iG_Alert:PacificStandard')
AddEventHandler('iG_Alert:PacificStandard', function()
	if playerLoaded and scriptLoaded then
		local playerPos = GetEntityCoords(GetPlayerPed(-1))
		TriggerServerEvent("core_dispatch:addCall", 
        "10-90B", "Robbery in progress", {
            {icon = "fa-globe-europe", info = "Pacific Standard Bank, Downtown Vinewood"},
            {icon = "fa-info-circle", info = "Priority situation, units please attend. (Max: 16)"}
        }, {playerPos[1], playerPos[2], playerPos[3]}, "police")
	end
end)

RegisterNetEvent('iG_Alert:EMS_Alert')
AddEventHandler('iG_Alert:EMS_Alert', function()
	local playerPos = GetEntityCoords(GetPlayerPed(-1))
    local x, y, z = table.unpack(playerPos)
    local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local zone = tostring(GetNameOfZone(x, y, z))
    local locationString = currentStreetName .. ', ' .. GetLabelText(zone)

    TriggerServerEvent("core_dispatch:addCall", 
    "10-52A", "Injured person", {
        {icon = "fa-globe-europe", info = locationString},
        {icon = "fa-info-circle", info = "Patient status is unknown."}
    }, {playerPos[1], playerPos[2], playerPos[3]}, "ambulance")
end)