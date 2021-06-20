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
end)

local spikes_deployed = false
local obj1 = nil
local obj2 = nil
local obj3 = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'afp' then
            if IsControlPressed(1, 19) and IsControlJustPressed(1, 27) then
                spikes()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if spikes_deployed then
            for peeps = 0, 64 do
                if NetworkIsPlayerActive(GetPlayerFromServerId(peeps)) then
                    
                    local currentVeh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false)
                    if currentVeh ~= nil and currentVeh ~= false then
                        local currentVehcoords = GetEntityCoords(currentVeh, true)
                        local obj1coords = GetEntityCoords(obj1, true)
                        local obj2coords = GetEntityCoords(obj2, true)
                        local obj3coords = GetEntityCoords(obj3, true)
                        local DistanceBetweenObj1 = Vdist(obj1coords['x'], obj1coords['y'], obj1coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj2 = Vdist(obj2coords['x'], obj2coords['y'], obj2coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj3 = Vdist(obj3coords['x'], obj3coords['y'], obj3coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        if DistanceBetweenObj1 < 2.2 or DistanceBetweenObj2 < 2.2 or DistanceBetweenObj3 < 2.2 then
                            
							TriggerServerEvent("police:spikes", currentVeh, peeps)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if spikes_deployed then
        	local obj1coords = GetEntityCoords(obj1, true)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), obj1coords.x, obj1coords.y, obj1coords.z, true) > 100 then -- if the player is too far from his Spikes
           		SetEntityAsMissionEntity(obj1, false, false)
           		SetEntityAsMissionEntity(obj2, false, false)
           		SetEntityAsMissionEntity(obj3, false, false)
           		SetEntityVisible(obj1, false)
           		SetEntityVisible(obj2, false)
           		SetEntityVisible(obj3, false)
           		DeleteObject(obj1)
           		DeleteObject(obj2)
           		DeleteObject(obj3)
                DeleteEntity(obj1)
                DeleteEntity(obj2)
                DeleteEntity(obj3)
                obj1 = nil
                obj2 = nil
                obj3 = nil
                exports['mythic_notify']:SendAlert('inform', 'Stingers: Removing Spikes..')
                -- exports.pNotify:SendNotification({text = "Removing spikes! (D>100)",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
                spikes_deployed = false
        	end
        end
	end
end)

RegisterNetEvent("police:dietyres")
AddEventHandler("police:dietyres", function(currentVeh)
    SetVehicleTyreBurst(currentVeh, 0, false, 1000.0)
    SetVehicleTyreBurst(currentVeh, 1, false, 1000.0)
    SetVehicleTyreBurst(currentVeh, 2, false, 1000.0)
    SetVehicleTyreBurst(currentVeh, 3, false, 1000.0)
    SetVehicleTyreBurst(currentVeh, 4, false, 1000.0)
    SetVehicleTyreBurst(currentVeh, 5, false, 1000.0)
    -- exports.pNotify:SendNotification({text = "You hit a spike strip! Bad luck.",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
    Citizen.Wait(1000)
    SetEntityAsMissionEntity(obj1, false, false)
    SetEntityAsMissionEntity(obj2, false, false)
    SetEntityAsMissionEntity(obj3, false, false)
    SetEntityVisible(obj1, false)
    SetEntityVisible(obj2, false)
    SetEntityVisible(obj3, false)
    DeleteObject(obj1)
    DeleteObject(obj2)
    DeleteObject(obj3)
    DeleteEntity(obj1)
    DeleteEntity(obj2)
    DeleteEntity(obj3)
    obj1 = nil
    obj2 = nil
    obj3 = nil
    spikes_deployed = false
end)

RegisterNetEvent("police:dietyres2")
AddEventHandler("police:dietyres2", function(peeps)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 0, false, 1000.0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 1, false, 1000.0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 2, false, 1000.0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 3, false, 1000.0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 4, false, 1000.0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 5, false, 1000.0)
end)

--=============================================================cALL IT

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function doAnimation()
	local ped 	  = GetPlayerPed(-1)
	local coords  = GetEntityCoords(ped)

	--FreezeEntityPosition(ped, true)
	loadAnimDict("pickup_object")
	TaskPlayAnim(ped, "pickup_object", "pickup_low", 1.0, 1, -1, 33, 0, 0, 0, 0)
end

function spikes()
	TriggerEvent("police:Deploy")
end

RegisterNetEvent("police:Deploy")
AddEventHandler("police:Deploy", function()
    Citizen.CreateThread(function()
        if not spikes_deployed then
            local spikes = GetHashKey("p_stinger_04")
            RequestModel(spikes)
            while not HasModelLoaded(spikes) do
                Citizen.Wait(0)
            end
            exports['mythic_notify']:SendAlert('inform', 'Stingers: Deploying Spikes..')
            -- exports.pNotify:SendNotification({text = "Deploying spikes!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            doAnimation()
            Citizen.Wait(1700)
            ClearPedTasksImmediately(GetPlayerPed(-1))
			--FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(250)
            local playerheading = GetEntityHeading(GetPlayerPed(-1))
            coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
            coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
            obj1 = CreateObject(spikes, coords1['x'], coords1['y'], coords1['z'], true, true, true)
            obj2 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            obj3 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			SetEntityHeading(obj1, playerheading)
            SetEntityHeading(obj2, playerheading)
            SetEntityHeading(obj3, playerheading)
            AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            Citizen.Wait(10)
            DetachEntity(obj1, true, true)
            DetachEntity(obj2, true, true)
            DetachEntity(obj3, true, true)
            spikes_deployed = true
        else
            spikes_deployed = false
            exports['mythic_notify']:SendAlert('inform', 'Stingers: Removing Spikes..')
            -- exports.pNotify:SendNotification({text = "Removing spikes!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            doAnimation()
            Citizen.Wait(1700)
            ClearPedTasksImmediately(GetPlayerPed(-1))
			--FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(200)
            SetEntityCoords(obj1, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj2, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj3, -5000.0, -5000.0, 20.0, true, false, false, true)
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj1))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj2))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj3))
            obj1 = nil
            obj2 = nil
            obj3 = nil
        end
	end)
end)

-- ---------------------------------------------------------------------------
-- -- Important Variables --
-- ---------------------------------------------------------------------------

-- ESX = nil

-- local PoliceModels = {}
-- local SpawnedSpikes = {}
-- local spikemodel = "P_ld_stinger_s"
-- local nearSpikes = false
-- local spikesSpawned = false
-- local PlayerData = {}

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end

-- 	while ESX.GetPlayerData().job == nil do
-- 		Citizen.Wait(10)
-- 	end

-- 	PlayerData = ESX.GetPlayerData()
-- end)


-- local inVehicle = false

-- ---------------------------------------------------------------------------
-- -- Checking Distance To Spikestrips --
-- ---------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--     while true do
--         inVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
--         Citizen.Wait(500)
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         if not inVehicle then
--             local vehicle = GetVehiclePedIsIn(LocalPed(), false)
--             if GetPedInVehicleSeat(vehicle, -1) == LocalPed() then
--                 local vehiclePos = GetEntityCoords(vehicle, false)
--                 local spikes = GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
--                 local spikePos = GetEntityCoords(spikes, false)
--                 local distance = Vdist(vehiclePos.x, vehiclePos.y, vehiclePos.z, spikePos.x, spikePos.y, spikePos.z)

--                 if spikes ~= 0 then
--                     nearSpikes = true
--                 else
--                     nearSpikes = false
--                 end
--             else
--                 nearSpikes = false
--             end
--         else
--             nearSpikes = false
--         end

--         if nearSpikes then
--             local tires = {
--                 {bone = "wheel_lf", index = 0},
--                 {bone = "wheel_rf", index = 1},
--                 {bone = "wheel_lm", index = 2},
--                 {bone = "wheel_rm", index = 3},
--                 {bone = "wheel_lr", index = 4},
--                 {bone = "wheel_rr", index = 5}
--             }

--             for a = 1, #tires do
--                 local vehicle = GetVehiclePedIsIn(LocalPed(), false)
--                 local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
--                 local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
--                 local spikePos = GetEntityCoords(spike, false)
--                 local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

--                 if distance < 1.8 then
--                     if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
--                         SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
--                     end
--                 end
--             end
--         end

--         if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'police_spg' or PlayerData.job and PlayerData.job.name == 'police_hwy' then
--             if (spikesSpawned == true) then
--                 DisplayNotification("To remove the spikstrips press ~INPUT_CHARACTER_WHEEL~ + ~INPUT_PHONE~")
--                 if IsControlPressed(1, 19) and IsControlJustPressed(1, 27) then
--                     RemoveSpikes()
--                     spikesSpawned = false
--                 end
--             end

--             if (spikesSpawned == false) then
--                 if IsControlPressed(1, 19) and IsControlJustPressed(1, 173) then
--                     CreateSpikes(2)
--                     spikesSpawned = true
--                 end
--             end
--         end  

--         Citizen.Wait(0)
--     end
-- end)

-- ---------------------------------------------------------------------------
-- -- Spawn Spikes Event --
-- ---------------------------------------------------------------------------
-- RegisterNetEvent("Spikes:SpawnSpikes")
-- AddEventHandler("Spikes:SpawnSpikes", function(config)
--     if config.isRestricted then
--         if CheckPedRestriction(LocalPed(), config.pedList) then
--             CreateSpikes(config.amount)
--         end
--     else
--         CreateSpikes(config.amount)
--     end
-- end)

-- ---------------------------------------------------------------------------
-- -- Delete Spikes Event --
-- ---------------------------------------------------------------------------
-- RegisterNetEvent("Spikes:DeleteSpikes")
-- AddEventHandler("Spikes:DeleteSpikes", function(netid)
--     Citizen.CreateThread(function()
--         local spike = NetworkGetEntityFromNetworkId(netid)
--         DeleteEntity(spike)
--     end)
-- end)

-- ---------------------------------------------------------------------------
-- -- Extra Functions --
-- ---------------------------------------------------------------------------
-- function CreateSpikes(amount)
--     local spawnCoords = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
--     for a = 1, amount do
--         local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
--         local netid = NetworkGetNetworkIdFromEntity(spike)
--         SetNetworkIdExistsOnAllMachines(netid, true)
--         SetNetworkIdCanMigrate(netid, false)
--         SetEntityHeading(spike, GetEntityHeading(LocalPed()))
--         PlaceObjectOnGroundProperly(spike)
--         spawnCoords = GetOffsetFromEntityInWorldCoords(spike, 0.0, 4.0, 0.0)
--         table.insert(SpawnedSpikes, netid)
--     end
--     spikesSpawned = true
-- end

-- -- Citizen.CreateThread(function()
-- --     while true do
-- --         local dev = false

-- --         if dev then
-- --             local plyOffset = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
-- --             DrawMarker(0, plyOffset.x, plyOffset.y, plyOffset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 255, 0, 0, 0, 0, 0, 0, 0)
-- --             local spike = GetClosestObjectOfType(plyOffset.x, plyOffset.y, plyOffset.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
-- --             Citizen.Trace("NETID: " .. ObjToNet(spike))
-- --         end
-- --         Citizen.Wait(0)
-- --     end
-- -- end)

-- function RemoveSpikes()
--     for a = 1, #SpawnedSpikes do
--         TriggerServerEvent("Spikes:TriggerDeleteSpikes", SpawnedSpikes[a])
--     end
--     SpawnedSpikes = {}
-- end

-- function LocalPed()
--     return GetPlayerPed(PlayerId())  
-- end

-- function CheckPedRestriction(ped, pedList)
--     for a = 1, #pedList do
--         if GetHashKey(pedList[a]) == GetEntityModel(ped) then
--             return true
--         end
--     end
--     return false
-- end

-- function DisplayNotification(string)
-- 	SetTextComponentFormat("STRING")
-- 	AddTextComponentString(string)
--     DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- end

