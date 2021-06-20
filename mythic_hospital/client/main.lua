local clsCheckin1 = {x = 356.8, y = -1414.36, z = 32.52, h = 229.28}
local clsCheckin2 = {x = 353.48, y = -1418.28, z = 32.52, h = 229.28}
local pillboxCheckin = { x = 312.03366088867, y = -592.84307861328, z = 42.8, h = 180.4409942627 }
local pillboxCheckin2 = {x = 350.8, y = -588.24, z = 28.5, h = 65.04 }
local sandyCheckin = {x = 1832.72, y = 3676.88, z = 33.82, h = 64.04 }
local paletoCheckin = {x = -256.08, y = 6329.36, z = 31.9, h = 132.72 }


local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)

    FreezeEntityPosition(bedObject, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)

    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    SetEntityInvincible(PlayerPedId(), true)


    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()

        exports['mythic_notify']:SendAlert('inform', 'Doctors are treating you.')
        Citizen.Wait(Config.AIHealTimer * 1000)
        TriggerServerEvent('mythic_hospital:server:EnteredBed')
    end)
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	local player = PlayerPedId()
	
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
	end
	
	SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('iG_ambulancejob:revive')
    exports['mythic_notify']:SendAlert('inform', 'You\'ve been treated and billed.')
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local clsDistance1 = #(vector3(clsCheckin1.x, clsCheckin1.y, clsCheckin1.z) - plyCoords)
        local clsDistance2 = #(vector3(clsCheckin2.x, clsCheckin2.y, clsCheckin2.z) - plyCoords)
        local pillboxDistance = #(vector3(pillboxCheckin.x, pillboxCheckin.y, pillboxCheckin.z) - plyCoords)
        local pillboxDistance2 = #(vector3(pillboxCheckin2.x, pillboxCheckin2.y, pillboxCheckin2.z) - plyCoords)
        local sandyDistance = #(vector3(sandyCheckin.x, sandyCheckin.y, sandyCheckin.z) - plyCoords)
        local paletoDistance = #(vector3(paletoCheckin.x, paletoCheckin.y, paletoCheckin.z) - plyCoords)
        
        if clsDistance1 < 1.2 then
            --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
            
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if clsDistance1 < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(clsCheckin1.x, clsCheckin1.y, clsCheckin1.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
					if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_CLS')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end

        elseif clsDistance2 < 1.2 then
            --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
            
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if clsDistance2 < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(clsCheckin2.x, clsCheckin2.y, clsCheckin2.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
					if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_CLS')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end

        elseif pillboxDistance < 1.2 then
            --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
            
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if pillboxDistance < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(pillboxCheckin.x, pillboxCheckin.y, pillboxCheckin.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
					if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_Pillbox')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end

        elseif pillboxDistance2 < 1.2 then 
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if pillboxDistance2 < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(pillboxCheckin2.x, pillboxCheckin2.y, pillboxCheckin2.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
                    if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_Pillbox')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end

        elseif sandyDistance < 1.2 then
            --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
            
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if sandyDistance < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(sandyCheckin.x, sandyCheckin.y, sandyCheckin.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
					if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_Sandy')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end

        elseif paletoDistance < 1.2 then
            --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
            
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if paletoDistance < 5 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                    ESX.Game.Utils.DrawText3D(vector3(paletoCheckin.x, paletoCheckin.y, paletoCheckin.z + 0.5), 'Press [~b~E~w~] to check in to hospital.', 0.4)
					if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                            exports['mythic_progbar']:Progress({
                                name = "hospital_action",
                                duration = 10500,
                                label = "Checking In..",
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
                                    TriggerServerEvent('mythic_hospital:server:RequestBed_Paleto')
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
                        end
                    end
                end
            end
        end
    end
end)
