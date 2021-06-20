ESX = nil
playerLoaded, scriptLoaded = false
cl_storeData = {}
policeOfficers = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

    if Config.Debug then 
        if ESX.IsPlayerLoaded() then
            playerLoaded = true
            InitialiseStores()
        end
    end
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	playerLoaded = true
    InitialiseStores()
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	ESX.PlayerData.job = job
end)
local Cooldown = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Cooldown >= 2 then 
			Cooldown = Cooldown - 1
		end
	end
end)

AddEventHandler('ig-storerobberies:checkSafe', function()
	if Cooldown <= 1 then
		Cooldown = 5
    	checkSafe()
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming functions. (Cooldown: ' .. Cooldown .. ' seconds)')
	end
end)

AddEventHandler('ig-storerobberies:checkATM', function()
	if Cooldown <= 1 then
		Cooldown = 5
    	checkATM()
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming functions. (Cooldown: ' .. Cooldown .. ' seconds)')
	end
end)

AddEventHandler('ig-storerobberies:checkRegister', function()
	if Cooldown <= 1 then
		Cooldown = 5
    	checkRegister()
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming functions. (Cooldown: ' .. Cooldown .. ' seconds)')
	end
end)


