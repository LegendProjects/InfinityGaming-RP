ESX = nil

local timing, isPlayerWhitelisted = math.ceil(Config.Timer * 60000), false
local streetName, playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	ESX.PlayerData.job = job
	Citizen.Wait(500)
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)


function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Config.WhitelistedCops) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end


RegisterNetEvent('iG_Alert:sendNotification')
AddEventHandler('iG_Alert:sendNotification', function(type, data, length)
	if isPlayerWhitelisted then
		if type == 'officer-down' or type == 'medic-down' or type == 'fire-down' then
			SendNUIMessage({action = 'display', style = type, info = data, length = length})
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(2000)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1);
		elseif type == 'robbery' then
			SendNUIMessage({action = 'display', style = type, info = data, length = length})
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
			Citizen.Wait(2000)
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
			Citizen.Wait(750)
			PlaySoundFrontend(GetSoundId(), "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1);
		else
			SendNUIMessage({action = 'display', style = type, info = data, length = length})
		end
	end
end)

RegisterNetEvent('iG_Alert:setWaypoint')
AddEventHandler('iG_Alert:setWaypoint', function(targetCoords)
	if isPlayerWhitelisted then
		SetNewWaypoint(targetCoords.x, targetCoords.y)
		-- print(targetCoords.x, targetCoords.y)
	end
end)
	

local zone = "Unknown";
local currentStreetName = "Unknown";

local isJacking = false
local isJacking2 = false
local isInVehicle = false
local isInCombat = false
local isArmed = false

Citizen.CreateThread(function()
	while true do
		isDead = IsPedDeadOrDying(PlayerPedId())
		isJacking = IsPedTryingToEnterALockedVehicle(PlayerPedId())
		isJacking2 = IsPedJacking(PlayerPedId())
		isInVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
		isInCombat = IsPedInMeleeCombat(PlayerPedId())
		isArmed = IsPedArmed(PlayerPedId(), 6)
		isShooting = IsPedShooting(PlayerPedId())
		hasSilencedWeapon = IsPedCurrentWeaponSilenced(PlayerPedId())
		Citizen.Wait(500)
	end
end)
Citizen.CreateThread(function()
	while true do	
		-- is jackin'
		if isJacking or isJacking2 then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
			currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
			zone = tostring(GetNameOfZone(x, y, z))
			Citizen.Wait(3000)
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			if vehicle and not isPlayerWhitelisted then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				ESX.TriggerServerCallback('iG_Alert:isVehicleOwner', function(owner)
					if not owner then

						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
						vehicleLabel = GetLabelText(vehicleLabel)
						local primary, secondary = GetVehicleColours(vehicle)
						primary = colours[tostring(primary)]
						secondary = colours[tostring(secondary)]
						local vehiclePlate = GetVehicleNumberPlateText(vehicle)

						TriggerServerEvent('iG_Alert:carJackInProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, currentStreetName .. ', ' .. GetLabelText(zone), vehicleLabel .. ', ' .. primary, vehiclePlate)
						isJacking = false
						isJacking2 = false
					end
				end, plate)
			end
		end

		if isArmed or isInCombat and not isPlayerWhitelisted then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
			currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
			zone = tostring(GetNameOfZone(x, y, z))
			local handle, ped = FindFirstPed()
			repeat
				success, ped = FindNextPed(handle)
				local pos = GetEntityCoords(ped)
				local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerCoords['x'], playerCoords['y'], playerCoords['z'], true)
				if not isInVehicle then
					if DoesEntityExist(ped)then
						if not IsPedDeadOrDying(ped) then
							if not IsPedAPlayer(ped) then
								currentped = pos
								if distance <= 15 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
									-- Has a gun
									if not isPlayerWhitelisted and isArmed and not pedIsCalling then
										pedIsCalling = true
										Citizen.Wait(3000)
										oldped = ped
										if not IsPedDeadOrDying(ped) then
											TriggerServerEvent('iG_Alert:personWithFirearm', {
												x = ESX.Math.Round(playerCoords.x, 1),
												y = ESX.Math.Round(playerCoords.y, 1),
												z = ESX.Math.Round(playerCoords.z, 1)
											}, currentStreetName .. ', ' .. GetLabelText(zone))
										end
									end
								end
								if distance <= 40 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
									if not isPlayerWhitelisted and isShooting and not hasSilencedWeapon and not pedIsCalling then
										pedIsCalling = true
										Citizen.Wait(3000)
							
										if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
							
											TriggerServerEvent('iG_Alert:shotsFired', {
												x = ESX.Math.Round(playerCoords.x, 1),
												y = ESX.Math.Round(playerCoords.y, 1),
												z = ESX.Math.Round(playerCoords.z, 1)
											}, currentStreetName .. ', ' .. GetLabelText(zone))
										end
									end
								end
							end
						
						end
					end
				end
			until not success
			EndFindPed(handle)
		end

		if pedIsCalling then
			Citizen.Wait(8000)
			pedIsCalling = false
		else
			Citizen.Wait(0)
		end

	end
end)




RegisterNetEvent('iG_Alert:carJackInProgress')
AddEventHandler('iG_Alert:carJackInProgress', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.CarJackingAlert then
			local alpha = 250
			local thiefBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)

			SetBlipHighDetail(thiefBlip, true)
			SetBlipColour(thiefBlip, 1)
			SetBlipAlpha(thiefBlip, alpha)
			SetBlipAsShortRange(thiefBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipJackingTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(thiefBlip, alpha)

				if alpha == 0 then
					RemoveBlip(thiefBlip)
					return
				end
			end

		end
	end
end)

RegisterNetEvent('iG_Alert:gunshotInProgress')
AddEventHandler('iG_Alert:gunshotInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('iG_Alert:combatInProgress')
AddEventHandler('iG_Alert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.MeleeAlert then
		local alpha = 250
		local meleeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipMeleeRadius)

		SetBlipHighDetail(meleeBlip, true)
		SetBlipColour(meleeBlip, 17)
		SetBlipAlpha(meleeBlip, alpha)
		SetBlipAsShortRange(meleeBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipMeleeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(meleeBlip, alpha)

			if alpha == 0 then
				RemoveBlip(meleeBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('iG_Alert:OfficerDown_Alert')
AddEventHandler('iG_Alert:OfficerDown_Alert', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))
	
	TriggerServerEvent('iG_Alert:OfficerDown', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
	}, currentStreetName .. ', ' .. GetLabelText(zone))
end)


RegisterNetEvent('iG_Alert:MedicDown_Alert')
AddEventHandler('iG_Alert:MedicDown_Alert', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))
	
	TriggerServerEvent('iG_Alert:MedicDown', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
	}, currentStreetName .. ', ' .. GetLabelText(zone))

end)


RegisterNetEvent('iG_Alert:BackupRequest')
AddEventHandler('iG_Alert:BackupRequest', function(code)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))
	print(code)
	if code == "1" then 
		TriggerServerEvent('iG_Alert:BackupRequest_Code1', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "2" then
		TriggerServerEvent('iG_Alert:BackupRequest_Code2', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "3" then
		TriggerServerEvent('iG_Alert:BackupRequest_Code3', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "4" then
		TriggerServerEvent('iG_Alert:injuredPerson', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "5" then
		TriggerServerEvent('iG_Alert:VangelicoRobbery', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "99" and ESX.PlayerData.job.name == 'ambulance' then 
		TriggerServerEvent('iG_Alert:MedicDown', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "99" and ESX.PlayerData.job.name == 'fire' then 
		TriggerServerEvent('iG_Alert:FireDown', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	elseif code == "99" and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'afp' then 
		TriggerServerEvent('iG_Alert:OfficerDown', {
			x = ESX.Math.Round(playerCoords.x, 1),
			y = ESX.Math.Round(playerCoords.y, 1),
			z = ESX.Math.Round(playerCoords.z, 1)
		}, currentStreetName .. ', ' .. GetLabelText(zone))
	end
end)

RegisterNetEvent('iG_Alert:Robbery_Alert')
AddEventHandler('iG_Alert:Robbery_Alert', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))

	TriggerServerEvent('iG_Alert:VangelicoRobbery', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
	}, currentStreetName .. ', ' .. GetLabelText(zone))
end)

RegisterNetEvent('iG_Alert:EMS_Alert')
AddEventHandler('iG_Alert:EMS_Alert', function()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))

	TriggerServerEvent('iG_Alert:injuredPerson', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1)
	}, currentStreetName .. ', ' .. GetLabelText(zone))

end)

RegisterNetEvent('iG_Alert:trafficViolation')
AddEventHandler('iG_Alert:trafficViolation', function(speed)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local currentStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	zone = tostring(GetNameOfZone(x, y, z))
	local vehicle = GetVehiclePedIsIn(playerPed, true)
	local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	vehicleLabel = GetLabelText(vehicleLabel)
	local primary, secondary = GetVehicleColours(vehicle)
	primary = colours[tostring(primary)]
	secondary = colours[tostring(secondary)]
	
	TriggerServerEvent('iG_Alert:trafficViolation', {
		x = ESX.Math.Round(playerCoords.x, 1),
		y = ESX.Math.Round(playerCoords.y, 1),
		z = ESX.Math.Round(playerCoords.z, 1)
	}, currentStreetName .. ', ' .. GetLabelText(zone), vehicleLabel .. ', ' .. primary, ESX.Math.Round(speed, 0))
end)



RegisterNetEvent('iG_Alert:FireAlert')
AddEventHandler('iG_Alert:FireAlert', function(fireName, fireLocation)
    local type = 'ems'
   	local data = {["code"] = '10-41', ["name"] = 'Fire reported', ["loc"] = fireName}
	local length = 20000
	print(fireName, fireLocation)
    SendNUIMessage({action = 'display', style = type, info = data, length = length})
    SetNewWaypoint(fireLocation.x, fireLocation.y)
end)
