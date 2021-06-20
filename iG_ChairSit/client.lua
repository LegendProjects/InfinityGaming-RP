ESX = nil
local plyCoords = GetEntityCoords(PlayerPedId())
local isWithinObject = false
local oElement = {}

-- // BASIC
local InUse = false
local IsTextInUse = false
local PlyLastPos = 0

-- // ANIMATION
local Anim = 'sit'
local AnimScroll = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Fast Thread
CreateThread(function()
    while true do
        if isWithinObject and oElement.fObject ~= 0 then
            local ply = PlayerPedId()
            local objectCoords = oElement.fObjectCoords
            local distanceDiff = #(objectCoords - plyCoords)
            if (distanceDiff < 2.0 and not InUse) then
                if (oElement.fObjectIsBed == true) then

                    -- // ARROW RIGHT
                    if IsControlJustPressed(0, 175) then -- right
                        if (AnimScroll ~= 2) then
                            AnimScroll = AnimScroll + 1
                        end
                        if AnimScroll == 1 then
                            Anim = "back"
                        elseif AnimScroll == 2 then
                            Anim = "stomach"
                        end
                    end
                    
                    -- // ARROW LEFT
                    if IsControlJustPressed(0, 174) then -- left
                        if (AnimScroll ~= 0) then
                            AnimScroll = AnimScroll - 1
                        end
                        if AnimScroll == 1 then
                            Anim = "back"
                        elseif AnimScroll == 0 then
                            Anim = "sit"
                        end
                    end

                    if (Anim == 'sit') then
                        DrawText3Ds(objectCoords.x, objectCoords.y, objectCoords.z, Config.Text.SitOnBed .. ' | ' .. Config.Text.SwitchBetween)
                    else
                        DrawText3Ds(objectCoords.x, objectCoords.y, objectCoords.z, Config.Text.LieOnBed .. ' ~b~' .. Anim .. '~w~ | ' .. Config.Text.SwitchBetween)
                    end

                    if IsControlJustPressed(0, Config.objects.ButtonToLayOnBed) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', oElement, oElement.fObjectCoords)
                    end
                else   
                    ESX.Game.Utils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z), 'Press [~b~G~w~] to sit down.', 0.4)
                    if IsControlJustPressed(0, Config.objects.ButtonToSitOnChair) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', oElement, oElement.fObjectCoords)
                    end
                end     
            end

            if (InUse) then
                ESX.Game.Utils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z), 'Press [~b~G~w~] to stand up.', 0.4)
                if IsControlJustPressed(0, Config.objects.ButtonToStandUp) then
                    InUse = false
                    TriggerServerEvent('ChairBedSystem:Server:Leave', oElement.fObjectCoords)
                    ClearPedTasksImmediately(ply)
                    FreezeEntityPosition(ply, false)
                    
                    local x, y, z = table.unpack(PlyLastPos)
                    if GetDistanceBetweenCoords(x, y, z, plyCoords) < 10 then
                        SetEntityCoords(ply, PlyLastPos)
                    end
                end
            end
        end
        Wait(0)
    end
end)

-- Medium Thread
CreateThread(function()
    while true do
        plyCoords = GetEntityCoords(PlayerPedId())
        Wait(1000)
    end
end)

-- Slow Thread
CreateThread(function()
    Wait(1500)
    while true do
        for _, element in pairs(Config.objects.locations) do
            local closestObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 3.0, GetHashKey(element.object), 0, 0, 0)
            local coordsObject = GetEntityCoords(closestObject)
            local distanceDiff = #(coordsObject - plyCoords)
            if (distanceDiff < 3.0 and closestObject ~= 0) then
                if (distanceDiff < 2.0) then
                    oElement = {
                        fObject = closestObject,
                        fObjectCoords = coordsObject,
                        fObjectcX = element.verticalOffsetX,
                        fObjectcY = element.verticalOffsetY,
                        fObjectcZ = element.verticalOffsetZ,
                        fObjectDir = element.direction,
                        fObjectIsBed = element.bed
                    }
                    isWithinObject = true
                end
                break
            else
                isWithinObject = false
            end
        end
        Wait(2000)
    end
end)

RegisterNetEvent('ChairBedSystem:Client:Animation')
AddEventHandler('ChairBedSystem:Client:Animation', function(v, coords)
    local object = v.fObject
    local vertx = v.fObjectcX
    local verty = v.fObjectcY
    local vertz = v.fObjectcZ
    local dir = v.fObjectDir
    local isBed = v.fObjectIsBed
    local objectcoords = coords
    
    local ped = PlayerPedId()
    PlyLastPos = GetEntityCoords(ped)
    FreezeEntityPosition(object, true)
    FreezeEntityPosition(ped, true)
    InUse = true
    if isBed == false then
        if Config.objects.SitAnimation.dict ~= nil then
            SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
            SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
            local dict = Config.objects.SitAnimation.dict
            local anim = Config.objects.SitAnimation.anim
            
            AnimLoadDict(dict, anim, ped)
        else
            TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
        end
    else
        if Anim == 'back' then
            if Config.objects.BedBackAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = Config.objects.BedBackAnimation.dict
                local anim = Config.objects.BedBackAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedBackAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true
            )
            end
        elseif Anim == 'stomach' then
            if Config.objects.BedStomachAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 100.0)
                local dict = Config.objects.BedStomachAnimation.dict
                local anim = Config.objects.BedStomachAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedStomachAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + 100.0, 0, true, true)
            end
        elseif Anim == 'sit' then
            if Config.objects.BedSitAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = Config.objects.BedSitAnimation.dict
                local anim = Config.objects.BedSitAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedSitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + 180.0, 0, true, true)
            end
        end
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end
