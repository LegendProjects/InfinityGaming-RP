
ESX = nil
local playerLoaded = false
PedStatus 						= 0
local count 					= 0
local counting					= false
local activated = false
local PreviousCoords
local isAuthorised = false
local isJumping = false
local isArmed = false
local isSpectating = false

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

	Citizen.Wait(100)
	ESX.TriggerServerCallback('igAnticheat:Authorisation:UserGroup', function(xGroup) 
		if xGroup == 'Moderator' then
        	isAuthorised = true
		elseif xGroup == 'SeniorMod' then
			isAuthorised = true
		elseif xGroup == 'Admin' then
			isAuthorised = true
		elseif xGroup == 'SeniorAdmin' then
			isAuthorised = true
		elseif xGroup == 'HeadAdmin' then
			isAuthorised = true
		elseif xGroup == 'Manager' then
			isAuthorised = true
		elseif xGroup == 'Developer' then
			isAuthorised = true
		elseif xGroup == 'Owner' then
			isAuthorised = true
		else
			isAuthorised = false
		end
	end)

	if ESX.IsPlayerLoaded() then
		playerLoaded = true
	end

end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
	playerLoaded = true
end)

RegisterNetEvent('igAnticheat:PlayerData:isDead') 
AddEventHandler('igAnticheat:PlayerData:isDead', function()
	ESX.TriggerServerCallback('iG-death:isPlayerDead', function(isPedDead)
		print("🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | Death Status: " .. isPedDead)
	end)
end)

RegisterNetEvent('igAnticheat:Exectution:ClearAll')
AddEventHandler('igAnticheat:Exectution:ClearAll', function()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	ClearAreaOfVehicles(coords.x, coords.y, coords.z, 500.00, false, false, false, false)
	ClearAreaOfEverything(coords.x, coords.y, coords.z, 500.00, false, false, false, false)
end)

RegisterNetEvent('igAnticheat:Exectution:SetVisibility')
AddEventHandler('igAnticheat:Exectution:SetVisibility', function()
    SetEntityVisible(GetPlayerPed(-1), true)
end)

--==========================================================================================
--==                                EXPLOSION DETECTION                             ==
--==========================================================================================
RegisterNetEvent('igAnticheat:Detection:Explosions')
AddEventHandler('igAnticheat:Detection:Explosions', function()
	counting = true
	count = count + 1
	print(count)
	if count == 10 then
		print("🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | Explosion detected.")
	end
end)

RegisterNetEvent('igAnticheat:Execution:Activate')
AddEventHandler('igAnticheat:Execution:Activate', function(boolean)
	activated = boolean
end)

--==========================================================================================
--==                                  THREAD HANDLER                             ==
--==========================================================================================
Citizen.CreateThread(function()
	while true do
		if playerLoaded then 
			if isJumping then
				local firstCoord = GetEntityCoords(GetPlayerPed(-1))
				while isJumping do
					Wait (0)
				end
				local secondCoord = GetEntityCoords(GetPlayerPed(-1))
				local jumplength = GetDistanceBetweenCoords(firstCoord, secondCoord, false)
				if jumplength > 10.0 then
					TriggerServerEvent('igAnticheat:Detection:SuperJump', jumplength )
				end
			end

			if isArmed then 
				for _,theWeapon in ipairs(Config.BlacklistedWeapons) do
					Citizen.Wait(1)
					if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
						RemoveAllPedWeapons(PlayerPedId(),false)
					end
				end
			end
			
			while counting do
				Citizen.Wait(1000)
				counting = false
				count = 0
				print("🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | We're always watching..")
			end
		end
		Citizen.Wait(0)
	end
end)

-- Wait 500 threads.
Citizen.CreateThread(function()
	while true do
		if playerLoaded then
			isJumping = IsPedJumping(PlayerPedId())
			isArmed = IsPedArmed(PlayerPedId(), 7)
			isSpectating = NetworkIsInSpectatorMode()
		end
		Citizen.Wait(500)
	end
end)

-- Wait 5000 threads.
Citizen.CreateThread(function()
	while true do
		if playerLoaded then
			if isSpectating then
				if not isAuthorised then 
					TriggerServerEvent("igAnticheat:Detection:Spectate")
				end
			end
		end
		Citizen.Wait(500)
	end
end)


RegisterNetEvent('igAnticheat:Screenshot:requestForcedSS')
AddEventHandler('igAnticheat:Screenshot:requestForcedSS', function()

	exports['iG-Admin']:requestScreenshotUpload(GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php'), GetConvar("ea_screenshotfield", 'files[]'), function(data)
		local res = tostring(data)
        local p1 = string.sub(res, 3)
        local p2 = string.sub(p1, 1, string.len(p1) - 2)
		TriggerServerEvent("igAnticheat:Screenshot:uploadSS", p2)
	end)

end)



Citizen.CreateThread(function()

	while true do

		Citizen.Wait(3000)

		if (activated == true) then

			thePeds = EnumeratePeds()
			PedStatus = 0

			for ped in thePeds do

				PedStatus = PedStatus + 1

				if PedStatus >= Config.pedThreshold then

					if not (IsPedAPlayer(ped))then

						DeleteEntity(ped)
						RemoveAllPedWeapons(ped, true)

					end
				end
			end
		end
	end
end)

function KillAllPeds()

    local pedweapon
    local pedid

    for ped in EnumeratePeds() do

        if DoesEntityExist(ped) then

            pedid = GetEntityModel(ped)
            pedweapon = GetSelectedPedWeapon(ped)

            if (activated == true)then

	            if pedweapon == -1312131151 or not IsPedHuman(ped) then

	                ApplyDamageToPed(ped, 1000, false)
	                DeleteEntity(ped)

	            else

	                switch = function (choice)

	                    choice = choice and tonumber(choice) or choice

	                    case =

	                    {
	                        [451459928] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [1684083350] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [451459928] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [1096929346] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [880829941] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [-1404353274] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                        [2109968527] = function ( )
	                            ApplyDamageToPed(ped, 1000, false)
	                            DeleteEntity(ped)
	                        end,

	                       default = function ( )
	                       end,
	                    }

	                    if case[choice] then

	                       case[choice]()

	                    else

	                       case["default"]()

	                    end

                  	end
	                switch(pedid)
	            end
        	end
        end
    end
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end



-- Citizen.CreateThread(function()

--     while (true) do

--         Citizen.Wait(500)

--         KillAllPeds()
--         DeleteEntity(ped)

--     end

-- end)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(500)

		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false

		repeat

			Wait(1)

			if activated == true then

				if IsEntityAttached(object) and DoesEntityExist(object) then

					if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then

						DeleteObjects(object, true)

					end
				end

				for i=1,#Config.ObjectsBL do

					if GetEntityModel(object) == GetHashKey(Config.ObjectsBL[i]) then

						DeleteObjects(object, false)

					end
				end
			end

			finished, object = FindNextObject(handle)

		until not finished
		EndFindObject(handle)
	end
end)

function DeleteObjects(object, detach)

	if (activated == true)then

		if DoesEntityExist(object) then

			NetworkRequestControlOfEntity(object)

			while not NetworkHasControlOfEntity(object) do

				Citizen.Wait(1)
			end

			if detach then

				DetachEntity(object, 0, false)

			end

			SetEntityCollision(object, false, false)
			SetEntityAlpha(object, 0.0, true)
			SetEntityAsMissionEntity(object, true, true)
			SetEntityAsNoLongerNeeded(object)
			DeleteEntity(object)

		end
	end
end


local function collectAndSendResourceList()
	local resourceList = {}
    for i=0,GetNumResources()-1 do
		resourceList[i+1] = GetResourceByFindIndex(i)
		Wait(500)
	end
	Wait(5000)
    TriggerServerEvent("igAnticheat:Detection:checkResources", resourceList)
end

CreateThread(function()
    while true do
        Wait(60000)
        collectAndSendResourceList() 
    end
end)

Citizen.CreateThread(function()
	Wait(10000); -- Wait 10 seconds
	while true do
		if playerLoaded then
			if not isAuthorised then
				Citizen.Wait(1)
				SetPedInfiniteAmmoClip(PlayerPedId(), false)
				SetEntityInvincible(PlayerPedId(), false)
				SetEntityCanBeDamaged(PlayerPedId(), true)
				ResetEntityAlpha(PlayerPedId())
				local fallin = IsPedFalling(PlayerPedId())
				local ragg = IsPedRagdoll(PlayerPedId())
				local parac = GetPedParachuteState(PlayerPedId())
				if parac >= 0 or ragg or fallin then
					SetEntityMaxSpeed(PlayerPedId(), 80.0)
				else
					SetEntityMaxSpeed(PlayerPedId(), 7.1)
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(0)
		end
	end
end)

function NetworkDelete(entity)
    Citizen.CreateThread(function()
        if DoesEntityExist(entity) and not (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
            NetworkRequestControlOfEntity(entity)
            local timeout = 5
            while timeout > 0 and not NetworkHasControlOfEntity(entity) do
                Citizen.Wait(1)
                timeout = timeout - 1
            end
            DetachEntity(entity, 0, false)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
end

RegisterNetEvent("igAnticheat:Execution:ClearEntities")
AddEventHandler("igAnticheat:Execution:ClearEntities", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                if (owner ~= -1 and (id == playerID or id == -1)) then
                    NetworkDelete(entity)
                end
            end
        end
    end)
end)

RegisterNetEvent("igAnticheat:Execution:ClearEntitiesAll")
AddEventHandler("igAnticheat:Execution:ClearEntitiesAll", function()
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                NetworkDelete(entity)
            end
        end
    end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(120000);
	while true do
		Citizen.Wait(10000);
		if not isAuthorised then
			local blacklistedCommands = Config.BlacklistedCommands or {}
			local registeredCommands = GetRegisteredCommands()

			for _, command in ipairs(registeredCommands) do
				for _, blacklistedCommand in pairs(blacklistedCommands) do
					if (string.lower(command.name) == string.lower(blacklistedCommand) or
						string.lower(command.name) == string.lower('+' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('_' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('-' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('/' .. blacklistedCommand)) then
						TriggerServerEvent("igAnticheat:Detection:Commands")
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		if playerLoaded then
			if not isAuthorised then
				Citizen.Wait(0)
				local ped = GetPlayerPed(-1)
				local selWeapon = GetSelectedPedWeapon(ped)
				for i = 1, #Config.BlacklistedWeapons do 
					local weapon = Config.BlacklistedWeapons[i];
					if GetHashKey(weapon) == selWeapon then 
						local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | Blacklisted Weapon Detected ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()) .. ' ) (T:161)'
						TriggerServerEvent("igAnticheat:Kick:DropPlayer", reason)
					end 
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(10000) -- Wait 10 seconds
	while true do
		if playerLoaded then
			if not isAuthorised then
				Citizen.Wait(0)
				local ped = PlayerPedId()
				local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
				local still = IsPedStill(ped)
				local vel = GetEntitySpeed(ped)
				local ped = PlayerPedId()
				Wait(3000) -- wait 3 seconds and check again

				local newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
				local newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
				if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 150 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
					TriggerServerEvent('igAnticheat:Detection:FlyHack')
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Prevent keys from being Released 
Citizen.CreateThread(function()
	while true do 
		if not isAuthorised then
			Wait(0);
			local blacklistedKeys = Config.BlacklistedKeys;
			for i = 1, #blacklistedKeys do 
				local keyCombo = blacklistedKeys[i][1];
				local keyStr = blacklistedKeys[i][2];
				if #keyCombo == 1 then 
					local key1 = keyCombo[1];
					if IsDisabledControlJustReleased(0, key1) then 
						local keyString = key1
						TriggerServerEvent('igAnticheat:Detection:KeyBlacklist', keyString);
					end
				elseif #keyCombo == 2 then 
					local key1 = keyCombo[1];
					local key2 = keyCombo[2];
					if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) then 
						local keyString = key1 .. key2 
						TriggerServerEvent('igAnticheat:Detection:KeyBlacklist', keyString);
						Wait(20000); -- Wait 20 seconds 
					end
				elseif #keyCombo == 3 then 
					local key1 = keyCombo[1];
					local key2 = keyCombo[2];
					local key3 = keyCombo[3];
					if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and 
					IsDisabledControlPressed(0, key3) then 
						local keyString = key1 .. key2 .. key3
						TriggerServerEvent('igAnticheat:Detection:KeyBlacklist', keyString);
					end
					Wait(20000); -- Wait 20 seconds 
				elseif #keyCombo == 4 then 
					local key1 = keyCombo[1];
					local key2 = keyCombo[2];
					local key3 = keyCombo[3];
					local key4 = keyCombo[4];
					if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and 
					IsDisabledControlPressed(0, key3) and IsDisabledControlPressed(0, key4) then 
						local keyString = key1 .. key2 .. key3 .. key4
						TriggerServerEvent('igAnticheat:Detection:KeyBlacklist', keyString);
					end
					Wait(20000); -- Wait 20 seconds 
				end
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		Citizen.Wait(120000)
-- 		if playerLoaded then
-- 			ESX.TriggerServerCallback('igAnticheat:Authorisation:UserGroup', function(xGroup)
-- 				if xGroup == 'Moderator' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'SeniorMod' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'Admin' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'SeniorAdmin' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'HeadAdmin' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'Manager' then
-- 					isAuthorised = true
-- 				elseif xGroup == 'Owner' then
-- 					isAuthorised = true
-- 				else
-- 					isAuthorised = false
-- 				end
-- 			end)
-- 		end
-- 	end
-- end)

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(Config.BlacklistedVehicles) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		if playerLoaded then
			if not isAuthorised then 
				Citizen.Wait(500)
				if IsPedInAnyVehicle(GetPlayerPed(-1)) then
					v = GetVehiclePedIsIn(playerPed, false)
				end
				playerPed = GetPlayerPed(-1)
				
				if playerPed and v then
					if GetPedInVehicleSeat(v, -1) == playerPed then
						local car = GetVehiclePedIsIn(playerPed, false)
						carModel = GetEntityModel(car)
						carName = GetDisplayNameFromVehicleModel(carModel)
						if isCarBlacklisted(carModel) then
							DeleteVehicle(car)
							TriggerServerEvent("igAnticheat:Detection:Blacklist", carName)
						end
					end
				end
			else
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)