local PlayerLoaded = false
local PlayerData = {}
local ESX = nil
PedStatus 						= 0
local count 					= 0
local counting					= false
local activated = false
local PreviousCoords

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

	PlayerLoaded = true
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('vy_Admin:rollDice')
AddEventHandler('vy_Admin:rollDice', function(a, b)
	local res = math.random(a, b)
	TriggerServerEvent('3dme:shareText', 'Rolling a ' .. b .. ' sided dice. (Min: ' .. a .. ' / Max: ' .. b .. ' )') 
	Citizen.Wait(1500)
	TriggerServerEvent('3dme:shareText', 'Rolled a ' .. res .. '. (Min: ' .. a .. ' / Max: ' .. b .. ' )') 
end)

RegisterNetEvent('vy_Admin:Slay')
AddEventHandler('vy_Admin:Slay', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('vy_Admin:Freeze')
AddEventHandler('vy_Admin:Freeze', function()
    local player = PlayerId()
	local ped = PlayerPedId()
    
    SetEntityCollision(ped, false)
    FreezeEntityPosition(ped, true)
    SetPlayerInvincible(player, true)
    SetEntityVisible(ped, true)
    
    if not IsPedFatallyInjured(ped) then
        ClearPedTasksImmediately(ped)
    end	

end)

RegisterNetEvent('vy_Admin:Unfreeze')
AddEventHandler('vy_Admin:Unfreeze', function()
    local player = PlayerId()
    local ped = PlayerPedId()
    
    SetEntityVisible(ped, true)
    SetEntityCollision(ped, true)
    FreezeEntityPosition(ped, false)
    SetPlayerInvincible(player, false)

    if not IsPedFatallyInjured(ped) then
        ClearPedTasksImmediately(ped)
    end
end)

RegisterNetEvent('vy_Admin:Crash')
AddEventHandler('vy_Admin:Crash', function()
	while true do
	end
end)

RegisterNetEvent('vy_Admin:Slap')
AddEventHandler('vy_Admin:Slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('vy_Admin:TeleportRequest') -- To be fixed...
AddEventHandler('vy_Admin:TeleportRequest', function(tgtCoords)
	PreviousCoords =  GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), tgtCoords) 
end)


RegisterNetEvent('vy_Admin:Teleport') -- To be fixed...
AddEventHandler('vy_Admin:Teleport', function(x, y, z)
    PreviousCoords =  GetEntityCoords(PlayerPedId())
	SetEntityCoords(PlayerPedId(), x, y, z)
end)

RegisterNetEvent('vy_Admin:Goto')
AddEventHandler('vy_Admin:Goto', function(target)
    PreviousCoords =  GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
end)

RegisterNetEvent('vy_Admin:Bring') 
AddEventHandler('vy_Admin:Bring', function(target)
    PreviousCoords =  GetEntityCoords(PlayerPedId())
	SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
end)

RegisterNetEvent('vy_Admin:Return') 
AddEventHandler('vy_Admin:Return', function()
	SetEntityCoords(PlayerPedId(), PreviousCoords) 
end)


RegisterNetEvent('vy_Admin:Whois') 
AddEventHandler('vy_Admin:Whois', function(steamName, steamID, licenseID, liveID, xblID, discordID, playerIP)
    print('------ [vy_Admin] ------') 
    print('------ Player Identifiers ------')
    print(steamName)
	print(steamID)
	print(licenseID)
    print(liveID)
    print(xblID)
    print(discordID)
    print(playerIP)
    print('------ ------ ------ ------ ------')
end)



RegisterNetEvent('vy_Admin:AdminMenu') 
AddEventHandler('vy_Admin:AdminMenu', function()
	OpenToggleMenu()
end)


RegisterNetEvent('vy_Admin:admin_GetPolice') 
AddEventHandler('vy_Admin:admin_GetPolice', function()
	ESX.TriggerServerCallback('vy_Scoreboard:getConnectedPlayers', function(connectedPlayers, maxPlayers, uptime)
		local isPolice, num = {}, 1
		for k,v in pairs(connectedPlayers) do
			if v.job == 'police' or v.job == 'afp' then
				table.insert(isPolice, ('%s, [%s]\n'):format(v.steamName, v.id))
			end
		end
		print('------ [vy_Admin] ------') 
		print('------ On-Duty Police Officers ------')
		print(table.concat(isPolice))
		print('------ ------ ------ ------ ------')
	end)
end)

RegisterNetEvent('vy_Admin:admin_GetEMS') 
AddEventHandler('vy_Admin:admin_GetEMS', function()
	ESX.TriggerServerCallback('vy_Scoreboard:getConnectedPlayers', function(connectedPlayers, maxPlayers, uptime)
		local isEMS, num = {}, 1
		for k,v in pairs(connectedPlayers) do
			if v.job == 'ambulance' then
				table.insert(isEMS, ('%s, [%s]\n'):format(v.steamName, v.id))
			end
		end
		print('------ [vy_Admin] ------') 
		print('------ On-Duty Paramedics ------')
		print(table.concat(isEMS))
		print('------ ------ ------ ------ ------')
	end)
end)


function OpenToggleMenu()
    local playerPed = PlayerPedId()

	local elements = {
		{ label = "Enter Roleplay", value = 'citizen_wear' },
		{ label = "Exit Roleplay", value = 'admin_vest' },
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "Administration Status",
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

            TriggerServerEvent('vy_Admin:offdutyNotification')
		end

		if
			data.current.value == 'admin_vest'

		then
            setUniform(data.current.value, playerPed)
            TriggerServerEvent('vy_Admin:ondutyNotification')
		end

	end, function(data, menu)
		menu.close()
	end)
end

function cleanPlayer(playerPed)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end


function setUniform(value, playerPed)
	TriggerEvent('iG_skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[value].male then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[value].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

		elseif skin.sex == 1 then
			if Config.Uniforms[value].female then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[value].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

RegisterNetEvent('vy_Admin:isDead') 
AddEventHandler('vy_Admin:isDead', function()
	ESX.TriggerServerCallback('iG-death:isPlayerDead', function(isPedDead)
		print(isPedDead)
	end)
end)



RegisterNetEvent("vy_Admin:AntiCheat:ClearAll")
AddEventHandler("vy_Admin:AntiCheat:ClearAll", function()
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	ClearAreaOfVehicles(coords.x, coords.y, coords.z, 500.00, false, false, false, false)
	ClearAreaOfEverything(coords.x, coords.y, coords.z, 500.00, false, false, false, false)
end)


---------------------------------------------------------------------------------
--------------------[[    ANTICHEAT DETECTION SYSTEMS    ]]--------------------
---------------------------------------------------------------------------------
-- local isJumping = false
-- local isArmed = false
-- local isSpectating = false
-- RegisterNetEvent('vy_Admin:AntiCheat:SyncAll')
-- AddEventHandler('vy_Admin:AntiCheat:SyncAll', function()
--     SetEntityVisible(GetPlayerPed(-1), true)
-- end)


-- RegisterNetEvent('vy_Admin:AntiCheat:CountExplosions')
-- AddEventHandler('vy_Admin:AntiCheat:CountExplosions', function()
-- 	counting = true
-- 	count = count + 1
-- 	print(count)
-- 	if count == 10 then
-- 		print("🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | Explosion detected.")
-- 	end
-- end)

-- RegisterNetEvent('vy_Admin:AntiCheat:Activate')
-- AddEventHandler('vy_Admin:AntiCheat:Activate', function(boolean)
-- 	activated = boolean
-- 	print(boolean)
-- end)

-- -- Wait 0 threads.
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if isJumping then
-- 			local firstCoord = GetEntityCoords(GetPlayerPed(-1))
-- 			while isJumping do
-- 				Wait (0)
-- 			end
-- 			local secondCoord = GetEntityCoords(GetPlayerPed(-1))
-- 			local jumplength = GetDistanceBetweenCoords(firstCoord, secondCoord, false)
-- 			if jumplength > 10.0 then
-- 				TriggerServerEvent('vy_Admin:AntiCheat:alertPossibleSuperJump', jumplength )
-- 			end
-- 		end

-- 		if isArmed then 
-- 			for _,theWeapon in ipairs(Config.WeaponBL) do
-- 				Citizen.Wait(1)
-- 				if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
-- 					RemoveAllPedWeapons(PlayerPedId(),false)
-- 				end
-- 			end
-- 		end
		
-- 		while counting do
-- 			Citizen.Wait(1000)
-- 			counting = false
-- 			count = 0
-- 			print("🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | We're always watching..")
-- 		end

-- 		Citizen.Wait(0)
-- 	end
-- end)

-- -- Wait 500 threads.
-- Citizen.CreateThread(function()
-- 	while true do
-- 		isJumping = IsPedJumping(PlayerPedId())
-- 		isArmed = IsPedArmed(PlayerPedId(), 7)
-- 		isSpectating = NetworkIsInSpectatorMode()
-- 		Citizen.Wait(500)
-- 	end
-- end)

-- -- Wait 5000 threads.
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if isSpectating then
-- 			TriggerServerEvent("vy_Admin:AntiCheat:isAuthorised")
-- 		end
-- 		Citizen.Wait(500)
-- 	end
-- end)


-- RegisterNetEvent('vy_Admin:AntiCheat:requestForcedSS')
-- AddEventHandler('vy_Admin:AntiCheat:requestForcedSS', function()

-- 	exports['iG-Admin']:requestScreenshotUpload(GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php'), GetConvar("ea_screenshotfield", 'files[]'), function(data)
-- 		local res = tostring(data)
--         local p1 = string.sub(res, 3)
--         local p2 = string.sub(p1, 1, string.len(p1) - 2)
-- 		TriggerServerEvent("vy_Admin:AntiCheat:uploadSS", p2)
-- 	end)

-- end)



-- Citizen.CreateThread(function()

-- 	while true do

-- 		Citizen.Wait(3000)

-- 		if (activated == true) then

-- 			thePeds = EnumeratePeds()
-- 			PedStatus = 0

-- 			for ped in thePeds do

-- 				PedStatus = PedStatus + 1

-- 				if PedStatus >= Config.pedThreshold then

-- 					if not (IsPedAPlayer(ped))then

-- 						DeleteEntity(ped)
-- 						RemoveAllPedWeapons(ped, true)

-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

-- function KillAllPeds()

--     local pedweapon
--     local pedid

--     for ped in EnumeratePeds() do

--         if DoesEntityExist(ped) then

--             pedid = GetEntityModel(ped)
--             pedweapon = GetSelectedPedWeapon(ped)

--             if (activated == true)then

-- 	            if pedweapon == -1312131151 or not IsPedHuman(ped) then

-- 	                ApplyDamageToPed(ped, 1000, false)
-- 	                DeleteEntity(ped)

-- 	            else

-- 	                switch = function (choice)

-- 	                    choice = choice and tonumber(choice) or choice

-- 	                    case =

-- 	                    {
-- 	                        [451459928] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [1684083350] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [451459928] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [1096929346] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [880829941] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [-1404353274] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                        [2109968527] = function ( )
-- 	                            ApplyDamageToPed(ped, 1000, false)
-- 	                            DeleteEntity(ped)
-- 	                        end,

-- 	                       default = function ( )
-- 	                       end,
-- 	                    }

-- 	                    if case[choice] then

-- 	                       case[choice]()

-- 	                    else

-- 	                       case["default"]()

-- 	                    end

--                   	end
-- 	                switch(pedid)
-- 	            end
--         	end
--         end
--     end
-- end

-- function _DeleteEntity(entity)
-- 	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
-- end



-- -- Citizen.CreateThread(function()

-- --     while (true) do

-- --         Citizen.Wait(500)

-- --         KillAllPeds()
-- --         DeleteEntity(ped)

-- --     end

-- -- end)

-- local entityEnumerator = {
--     __gc = function(enum)
--         if enum.destructor and enum.handle then
--             enum.destructor(enum.handle)
--         end
--         enum.destructor = nil
--         enum.handle = nil
--     end
-- }

-- local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
--     return coroutine.wrap(function()
--         local iter, id = initFunc()
--         if not id or id == 0 then
--             disposeFunc(iter)
--             return
--         end

--         local enum = {handle = iter, destructor = disposeFunc}
--         setmetatable(enum, entityEnumerator)

--         local next = true
--         repeat
--             coroutine.yield(id)
--             next, id = moveFunc(iter)
--         until not next

--         enum.destructor, enum.handle = nil, nil
--         disposeFunc(iter)
--     end)
-- end

-- function EnumerateObjects()
--     return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
-- end

-- function EnumeratePeds()
--     return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
-- end

-- function EnumerateVehicles()
--     return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
-- end

-- function EnumeratePickups()
--     return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
-- end

-- Citizen.CreateThread(function()

-- 	while true do

-- 		Citizen.Wait(500)

-- 		local ped = PlayerPedId()
-- 		local handle, object = FindFirstObject()
-- 		local finished = false

-- 		repeat

-- 			Wait(1)

-- 			if activated == true then

-- 				if IsEntityAttached(object) and DoesEntityExist(object) then

-- 					if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then

-- 						DeleteObjects(object, true)

-- 					end
-- 				end

-- 				for i=1,#Config.ObjectsBL do

-- 					if GetEntityModel(object) == GetHashKey(Config.ObjectsBL[i]) then

-- 						DeleteObjects(object, false)

-- 					end
-- 				end
-- 			end

-- 			finished, object = FindNextObject(handle)

-- 		until not finished
-- 		EndFindObject(handle)
-- 	end
-- end)

-- function DeleteObjects(object, detach)

-- 	if (activated == true)then

-- 		if DoesEntityExist(object) then

-- 			NetworkRequestControlOfEntity(object)

-- 			while not NetworkHasControlOfEntity(object) do

-- 				Citizen.Wait(1)
-- 			end

-- 			if detach then

-- 				DetachEntity(object, 0, false)

-- 			end

-- 			SetEntityCollision(object, false, false)
-- 			SetEntityAlpha(object, 0.0, true)
-- 			SetEntityAsMissionEntity(object, true, true)
-- 			SetEntityAsNoLongerNeeded(object)
-- 			DeleteEntity(object)

-- 		end
-- 	end
-- end