local PlayerData = {}
ESX = nil
local playerLoaded = false
local pd_Auth = false
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

	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government' then
		pd_Auth = true
	else
		pd_Auth = false
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
	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government' then
		pd_Auth = true
	else
		pd_Auth = false
	end
end)

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

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

			if action == "Cashier Desk" then
				if (
						PlayerData.job.name ~= 'offcasino' or
						PlayerData.job.name ~= 'casino' or
						PlayerData.job.name ~= 'government'
				) then
					TriggerEvent("pNotify:SendNotification", { text = "<div class=\"alert fade alert-simple alert-warning alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fa fa-exclamation-triangle faa-flash animated\"></i><strong>Attempted teleport...</strong><br>You do not have security clearance to access this area, try teleport else-where, or leave this area immediately.</div>", type = "info", timeout = 5000, layout = "centerLeft", queue = "left"})
					return
				end

			elseif action == "FIB Offices" then
				if (
					pd_Auth == false
				) then
					TriggerEvent("pNotify:SendNotification", { text = "<div class=\"alert fade alert-simple alert-warning alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fa fa-exclamation-triangle faa-flash animated\"></i><strong>Attempted teleport...</strong><br>You do not have security clearance to access this area, try teleport else-where, or leave this area immediately.</div>", type = "info", timeout = 5000, layout = "centerLeft", queue = "left"})
					return
				end
			end
            
	    	menu.close()
			DoScreenFadeOut(100)
			Citizen.Wait(250)
			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
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
		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
		Citizen.Wait(250)
		DoScreenFadeIn(100)
	end
end

