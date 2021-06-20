local PlayerData = {}
ESX = nil
local playerLoaded = false
local auth = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()

	if PlayerData.job and PlayerData.job.name == 'offluxuryautos' or PlayerData.job and PlayerData.job.name == 'luxuryautos' then
		auth = true
	else
		auth = false
	end
end)


RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	playerLoaded = true
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(5000)
	if PlayerData.job and PlayerData.job.name == 'offluxuryautos' or PlayerData.job and PlayerData.job.name == 'luxuryautos' then
		auth = true
	else
		auth = false
	end
end)

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			
            if auth then 
                local Ped = PlayerPedId()
			    local PedCoords = GetEntityCoords(Ped)
                local isInVehicle = IsPedInAnyVehicle(Ped, true)
                if isInVehicle then
                    for p, v in pairs(Config.Teleports) do

                        local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

                        if DistanceCheck <= 2.5 then

                            sleepThread = 5

                            ESX.Game.Utils.DrawText3D(v, "[~b~E~w~] Teleport", 0.4)

                            if DistanceCheck <= 1.0 then
                                if IsControlJustPressed(0, 38) then
                                    TeleportPlayer(v)
                                end
                            end
                        end
                    end
                end
            end

			Citizen.Wait(sleepThread)

		end
	end)
end

function TeleportPlayer(pos)
    local Values = pos
	local xPlayer = source
	
	if #Values["goto"] > 1 then
		local elements = {}

		for i, v in pairs(Values["goto"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'igTeleport_menu',
			{
				title    = "Teleport",
				align    = 'right',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]
            
	    	menu.close()
			DoScreenFadeOut(100)
			Citizen.Wait(250)
			SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), position["x"], position["y"], position["z"])
            SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), position["h"])
    		Citizen.Wait(250)
			DoScreenFadeIn(100)		
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goto"][1]]
		DoScreenFadeOut(100)
		Citizen.Wait(250)
		-- SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
        SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), position["x"], position["y"], position["z"])
        SetEntityHeading(GetVehiclePedIsUsing(PlayerPedId()), position["h"])
		Citizen.Wait(250)
		DoScreenFadeIn(100)
	end
end

