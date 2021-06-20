-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = false -- OPTIONS: (true/false)
local useFlashingScreen = false -- OPTIONS: (true/false)
local useBlips = true -- OPTIONS: (true/false)
local alertPolice = true -- OPTIONS: (true/false)
local alertSpeed = 150 -- OPTIONS: (1-5000 KMH)

local defaultPrice60 = 150 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 60 ZONES
local defaultPrice80 = 300 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 80 ZONES
local defaultPrice120 = 500 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 120 ZONES

local extraZonePrice10 = 20 -- THIS IS THE EXTRA COST IF 10 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice20 = 50 -- THIS IS THE EXTRA COST IF 20 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice30 = 250 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice50 = 425 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice100 = 635 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice120 = 745 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice140 = 1045 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

ESX = nil
local PlayerData = {}
local playerLoaded = false
local hasBeenCaught = false
local whitelisted = false
local finalBillingPrice = 0;
local isActive = true
local policeOnDuty = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'ambulance' or PlayerData.job and PlayerData.job.name == 'afp' then 
		whitelisted = true
	else
		whitelisted = false
	end
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	-- TriggerServerEvent('iG_policejob:forceBlip')
	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'ambulance' or PlayerData.job and PlayerData.job.name == 'afp' then 
		whitelisted = true
	else
		whitelisted = false
	end
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERAS
local blips = {
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 354.76, y = -665.44, z = 28.52}, -- Lower Pillbox
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 287.88, y = -855.72, z = 28.4}, -- North-East Legion Square
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 172.76, y = -816.92, z = 30.36}, -- North-West Legion Square
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 105.8, y = -998.48, z = 28.6}, -- South-West Legion Square
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 223.92, y = -1042.44, z = 28.56}, -- South-East Legion Square
	{title="NSWPF: Speedcamera (60KM/H)", colour=1, id=184, x = 397.92, y = -1049.72, z = 28.56}, -- Mission Row Police Department
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.4)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- AREAS
local Speedcamera60Zone = {
	{x = 354.76, y = -665.44, z = 28.52}, -- Lower Pillbox
	{x = 287.88, y = -855.72, z = 28.4}, -- North-East Legion Square
	{x = 172.76, y = -816.92, z = 30.36}, -- North-West Legion Square
	{x = 105.8, y = -998.48, z = 28.6}, -- South-West Legion Square
	{x = 223.92, y = -1042.44, z = 28.56}, -- South-East Legion Square
	{x = 397.92, y = -1049.72, z = 28.56}, -- Mission Row Police Department
}

local Speedcamera80Zone = {
    {x = 2506.0671,y = 4145.2431,z = 38.1054},
    {x = 1258.2006,y = 789.4199,z = 103.2190},
    {x = 980.9982,y = 407.4164,z = 92.2374}
}

local Speedcamera120Zone = {
    {x = 1584.9281,y = -993.4557,z = 59.3923},
    {x = 2442.2006,y = -134.6004,z = 88.7765},
    {x = 2871.7951,y = 3540.5795,z = 53.0930}
}

-- ZONES
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

		-- 60 zone
		if not whitelisted and isActive then
			for k in pairs(Speedcamera60Zone) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)

				if dist <= 25.0 then
					local playerPed = GetPlayerPed(-1)
					local playerCar = GetVehiclePedIsIn(playerPed, false)
					-- local veh = GetVehiclePedIsIn(playerPed)
					local SpeedKM = GetEntitySpeed(playerPed)*3.6
					local maxSpeed = 80.0 -- THIS IS THE MAX SPEED IN KM/H
					
					if SpeedKM > maxSpeed then
						if IsPedInAnyVehicle(playerPed, false) then
							if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
								if hasBeenCaught == false then							

									-- if useFlashingScreen == true then
									-- 	Citizen.Wait(200)
									-- 	TriggerServerEvent('iG_SpeedCameras:closeGUI')
									-- end
									-- FLASHING EFFECT (END)								
									exports['mythic_notify']:SendAlert('inform', 'You\'ve been caught by the speedcamera in a 60 zone! Your speed: ' .. math.floor(SpeedKM) .. ' KM/H')

									if useBilling == true then
										if SpeedKM >= 300 then
											finalBillingPrice = 7250
										elseif SpeedKM >= maxSpeed + 140 then
											finalBillingPrice = defaultPrice60 + extraZonePrice140
										elseif SpeedKM >= maxSpeed + 120 then
											finalBillingPrice = defaultPrice60 + extraZonePrice120
										elseif SpeedKM >= maxSpeed + 100 then
											finalBillingPrice = defaultPrice60 + extraZonePrice100
										elseif SpeedKM >= maxSpeed + 50 then
											finalBillingPrice = defaultPrice60 + extraZonePrice50
										elseif SpeedKM >= maxSpeed + 30 then
											finalBillingPrice = defaultPrice60 + extraZonePrice30
										elseif SpeedKM >= maxSpeed + 20 then
											finalBillingPrice = defaultPrice60 + extraZonePrice20
										elseif SpeedKM >= maxSpeed + 10 then
											finalBillingPrice = defaultPrice60 + extraZonePrice10
										else
											finalBillingPrice = defaultPrice60
										end
										TriggerEvent('iG_Alert:trafficViolation', math.floor(SpeedKM))
										TriggerServerEvent('iG_SpeedCameras:FinePlayer', finalBillingPrice)
										-- if policeOnDuty <= 3 then
										-- 	TriggerServerEvent('iG_SpeedCameras:FinePlayer', finalBillingPrice)
										-- 	-- TriggerServerEvent('iG_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police',  '(' .. day .. '/'.. month .. ') Speedcamera (60KM/H) - Speed:' .. math.floor(SpeedKM) .. ' KM/H' , finalBillingPrice) -- Sends a bill from the police
										-- end
									else
										TriggerServerEvent('iG_SpeedCameras:PayBill60Zone')
									end
										
									hasBeenCaught = true
									Citizen.Wait(7500) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
						
						hasBeenCaught = false
					end
				end
			end
	
		end
    end
end)

RegisterNetEvent('iG_SpeedCameras:openGUI')
AddEventHandler('iG_SpeedCameras:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('iG_SpeedCameras:closeGUI')
AddEventHandler('iG_SpeedCameras:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)

RegisterNetEvent('iG_SpeedCameras:UpdatePoliceCount')
AddEventHandler('iG_SpeedCameras:UpdatePoliceCount', function(inc)
	policeOnDuty = inc
	-- print('[DEBUG] [iG_SpeedCameras] Police On-Duty: ' .. policeOnDuty)
end)
