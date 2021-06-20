local ESX	 = nil
local playerLoaded = false
-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	LoadUI()
end)






local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local AllWeapons = json.decode('{"MELEE":{"WEAPON_ARMADYL":"0x3B6CE4AE","WEAPON_KATANA":"0x49DC18B1","WEAPON_DAGGER":"0x92A27487","WEAPON_BAT":"0x958A4A8F","WEAPON_BOTTLE":"0xF9E6AA4B","WEAPON_CROWBAR":"0x84BD7BFD","WEAPON_UNARMED":"0xA2719263","WEAPON_FLASHLIGHT":"0x8BB05FD7","WEAPON_GOLFCLUB":"0x440E4788","WEAPON_HAMMER":"0x4E875F73","WEAPON_HATCHET":"0xF9DCBF2D","WEAPON_KNUCKLE":"0xD8DF3C3C","WEAPON_KNIFE":"0x99B507EA","WEAPON_MACHETE":"0xDD5DF8D9","WEAPON_SWTICHBLADE":"0xDFE37640","WEAPON_NIGHTSTICK":"0x678B81B1","WEAPON_WRENCH":"0x19044EE0","WEAPON_BATTLEAXE":"0xCD274149","WEAPON_POOLCUE":"0x94117305","WEAPON_STONE_HATCHET":"0x3813FC08"},"HANDGUNS":{"WEAPON_CERAMICPISTOL":"0x2B5EF5EC","WEAPON_PISTOL":"0x1B06D571","WEAPON_PISTOL_MK2":"0xBFE256D4","WEAPON_COMBATPISTOL":"0x5EF9FEC4","WEAPON_APPISTOL":"0x22D8FE39","WEAPON_STUNGUN":"0x3656C8C1","WEAPON_PISTOL50":"0x99AEEB3B","WEAPON_SNSPISTOL":"0xBFD21232","WEAPON_SNSPISTOL_MK2":"0x88374054","WEAPON_HEAVYPISTOL":"0xD205520E","WEAPON_VINTAGEPISTOL":"0x83839C4","WEAPON_FLAREGUN":"0x47757124","WEAPON_MARKSMANPISTOL":"0xDC4DB296","WEAPON_REVOLVER":"0xC1B3C3D1","WEAPON_REVOLVER_MK2":"0xCB96392F","WEAPON_DOUBLEACTION":"0x97EA20B8","WEAPON_RAYPISTOL":"0xAF3696A1"},"SMG":{"WEAPON_MICROSMG":"0x13532244","WEAPON_SMG":"0x2BE6766B","WEAPON_SMG_MK2":"0x78A97CD0","WEAPON_ASSAULTSMG":"0xEFE7E2DF","WEAPON_COMBATPDW":"0xA3D4D34","WEAPON_MACHINEPISTOL":"0xDB1AA450","WEAPON_MINISMG":"0xBD248B55","WEAPON_RAYCARBINE":"0x476BF155"},"SHOTGUNS":{"WEAPON_PUMPSHOTGUN":"0x1D073A89","WEAPON_PUMPSHOTGUN_MK2":"0x555AF99A","WEAPON_SAWNOFFSHOTGUN":"0x7846A318","WEAPON_ASSAULTSHOTGUN":"0xE284C527","WEAPON_BULLPUPSHOTGUN":"0x9D61E50F","WEAPON_MUSKET":"0xA89CB99E","WEAPON_HEAVYSHOTGUN":"0x3AABBBAA","WEAPON_DBSHOTGUN":"0xEF951FBB","WEAPON_AUTOSHOTGUN":"0x12E82D3D"},"ASSAULT_RIFLES":{"WEAPON_ASSAULTRIFLE":"0xBFEFFF6D","WEAPON_ASSAULTRIFLE_MK2":"0x394F415C","WEAPON_CARBINERIFLE":"0x83BF0278","WEAPON_CARBINERIFLE_MK2":"0xFAD1F1C9","WEAPON_ADVANCEDRIFLE":"0xAF113F99","WEAPON_SPECIALCARBINE":"0xC0A3098D","WEAPON_SPECIALCARBINE_MK2":"0x969C3D67","WEAPON_BULLPUPRIFLE":"0x7F229F94","WEAPON_BULLPUPRIFLE_MK2":"0x84D6FAFD","WEAPON_COMPACTRIFLE":"0x624FE830"},"MACHINE_GUNS":{"WEAPON_MG":"0x9D07F764","WEAPON_COMBATMG":"0x7FD62962","WEAPON_COMBATMG_MK2":"0xDBBD7280","WEAPON_GUSENBERG":"0x61012683"},"SNIPER_RIFLES":{"WEAPON_SNIPERRIFLE":"0x5FC3C11","WEAPON_HEAVYSNIPER":"0xC472FE2","WEAPON_HEAVYSNIPER_MK2":"0xA914799","WEAPON_MARKSMANRIFLE":"0xC734385A","WEAPON_MARKSMANRIFLE_MK2":"0x6A6C02E0"},"HEAVY_WEAPONS":{"WEAPON_RPG":"0xB1CA77B1","WEAPON_GRENADELAUNCHER":"0xA284510B","WEAPON_GRENADELAUNCHER_SMOKE":"0x4DD2DC56","WEAPON_MINIGUN":"0x42BF8A85","WEAPON_FIREWORK":"0x7F7497E5","WEAPON_RAILGUN":"0x6D544C99","WEAPON_HOMINGLAUNCHER":"0x63AB0442","WEAPON_COMPACTLAUNCHER":"0x781FE4A","WEAPON_RAYMINIGUN":"0xB62D1F67"},"THROWABLES":{"WEAPON_GRENADE":"0x93E220BD","WEAPON_BZGAS":"0xA0973D5E","WEAPON_SMOKEGRENADE":"0xFDBC8A50","WEAPON_FLARE":"0x497FACC3","WEAPON_MOLOTOV":"0x24B17070","WEAPON_STICKYBOMB":"0x2C3731D9","WEAPON_PROXMINE":"0xAB564B93","WEAPON_SNOWBALL":"0x787F0BB","WEAPON_PIPEBOMB":"0xBA45E8B8","WEAPON_BALL":"0x23C9F95C"},"MISC":{"WEAPON_PETROLCAN":"0x34A67B97","WEAPON_FIREEXTINGUISHER":"0x60EC506","WEAPON_PARACHUTE":"0xFBAB5776"}}')





local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};







-- Location update
-- Citizen.CreateThread(function()

-- 	while true do
-- 		Citizen.Wait(2000)

-- 		local player = GetPlayerPed(-1)

-- 		local position = GetEntityCoords(player)

-- 		local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
-- 		local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

-- 		local locationMessage = nil

-- 		if zoneNameFull then 
-- 			locationMessage = streetName .. ', ' .. zoneNameFull
-- 		else
-- 			locationMessage = streetName
-- 		end

-- 		locationMessage = string.format(
-- 			Locales[Config.Locale]['you_are_on_location'],
-- 			locationMessage
-- 		)

-- 		SendNUIMessage({ action = 'setText', id = 'location', value = locationMessage })
-- 		-- SendNUIMessage({ action = 'setText', id = 'date', value = trewDate() })
-- 	end
-- end)





-- -- Vehicle Info
-- local vehicleCruiser
-- local vehicleSignalIndicator = 'off'
-- local seatbeltEjectSpeed = 45.0 
-- local seatbeltEjectAccel = 100.0
-- local seatbeltIsOn = false
-- local currSpeed = 0.0
-- local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

-- Citizen.CreateThread(function()
	
-- 	while true do

-- 		Citizen.Wait(100)

-- 		local player = GetPlayerPed(-1)
-- 		local vehicle = GetVehiclePedIsIn(player, false)
-- 		local position = GetEntityCoords(player)
-- 		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
-- 		local vehicleInfo

-- 		if IsPedInAnyVehicle(player, false) and vehicleIsOn then


-- 			local vehicleClass = GetVehicleClass(vehicle)


-- 			-- Vehicle Speed
-- 			local vehicleSpeedSource = GetEntitySpeed(vehicle)
-- 			local vehicleSpeed
-- 			if Config.vehicle.speedUnit == 'MPH' then
-- 				vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
-- 			else
-- 				vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
-- 			end

-- 			-- Vehicle Gradient Speed
-- 			local vehicleNailSpeed

-- 			if vehicleSpeed > Config.vehicle.maxSpeed then
-- 				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
-- 			else
-- 				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
-- 			end


			
-- 			-- Vehicle Fuel and Gear
-- 			local vehicleFuel
-- 			vehicleFuel = GetVehicleFuelLevel(vehicle)

-- 			local vehicleGear = GetVehicleCurrentGear(vehicle)

-- 			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
-- 				vehicleGear = 'N'
-- 			elseif vehicleSpeed > 0 and vehicleGear == 0 then
-- 				vehicleGear = 'R'
-- 			end

-- 			-- Vehicle Lights
-- 			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
-- 			local vehicleIsLightsOn
-- 			if vehicleLights == 1 and vehicleHighlights == 0 then
-- 				vehicleIsLightsOn = 'normal'
-- 			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
-- 				vehicleIsLightsOn = 'high'
-- 			else
-- 				vehicleIsLightsOn = 'off'
-- 			end






-- 			-- Vehicle Siren
-- 			local vehicleSiren

-- 			if IsVehicleSirenOn(vehicle) then
-- 				vehicleSiren = true
-- 			else
-- 				vehicleSiren = false
-- 			end






-- 			-- Vehicle Seatbelt
-- 			if has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then

-- 				local prevSpeed = currSpeed
--                 currSpeed = vehicleSpeedSource

--                 SetPedConfigFlag(PlayerPedId(), 32, true)

--                 if not seatbeltIsOn then
--                 	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
--                     local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
--                     if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

--                         SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
--                         SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
--                         SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
--                     else
--                         -- Update previous velocity for ejecting player
--                         prevVelocity = GetEntityVelocity(vehicle)
--                     end

--                 else

--                 	DisableControlAction(0, 75)

--                 end



-- 			end

			

-- 			vehicleInfo = {
-- 				action = 'updateVehicle',

-- 				status = true,
-- 				speed = vehicleSpeed,
-- 				nail = vehicleNailSpeed,
-- 				gear = vehicleGear,
-- 				fuel = vehicleFuel,
-- 				lights = vehicleIsLightsOn,
-- 				signals = vehicleSignalIndicator,
-- 				cruiser = vehicleCruiser,
-- 				type = vehicleClass,
-- 				siren = vehicleSiren,
-- 				seatbelt = {},

-- 				config = {
-- 					speedUnit = Config.vehicle.speedUnit,
-- 					maxSpeed = Config.vehicle.maxSpeed
-- 				}
-- 			}

-- 			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
-- 		else

			
-- 			vehicleCruiser = false
-- 			vehicleNailSpeed = 0
-- 			vehicleSignalIndicator = 'off'

--             seatbeltIsOn = false

-- 			vehicleInfo = {
-- 				action = 'updateVehicle',

-- 				status = false,
-- 				nail = vehicleNailSpeed,
-- 				seatbelt = { status = seatbeltIsOn },
-- 				cruiser = vehicleCruiser,
-- 				signals = vehicleSignalIndicator,
-- 				type = 0,
-- 			}
-- 		end

-- 		SendNUIMessage(vehicleInfo)




-- 	end
-- end)
Citizen.CreateThread(function()
	local minimap = RequestScaleformMovie("minimap")
	SetRadarBigmapEnabled(true, false)
	Wait(0)
	SetRadarBigmapEnabled(false, false)
	while true do
		Wait(0)
		Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
		Citizen.InvokeNative(0xC3D0841A0CC546A6,3)
		Citizen.InvokeNative(0xC6796A8FFA375E53 )
	end
end)
-- Player status
-- Citizen.CreateThread(function()

-- 	while true do
-- 		Citizen.Wait(1000)

-- 		local playerStatus 
-- 		local showPlayerStatus = 0
-- 		playerStatus = { action = 'setStatus', status = {} }

-- 		if Config.ui.showHealth == true then
-- 			showPlayerStatus = (showPlayerStatus+1)

-- 			playerStatus['isdead'] = false

-- 			playerStatus['status'][showPlayerStatus] = {
-- 				name = 'health',
-- 				value = GetEntityHealth(GetPlayerPed(-1)) - 100
-- 			}

-- 			if IsEntityDead(GetPlayerPed(-1)) then
-- 				playerStatus.isdead = true
-- 			end
-- 		end

-- 		if Config.ui.showArmor == true then
-- 			showPlayerStatus = (showPlayerStatus+1)

-- 			playerStatus['status'][showPlayerStatus] = {
-- 				name = 'armor',
-- 				value = GetPedArmour(GetPlayerPed(-1)),
-- 			}
-- 		end

-- 		if Config.ui.showStamina == true then
-- 			showPlayerStatus = (showPlayerStatus+1)

-- 			playerStatus['status'][showPlayerStatus] = {
-- 				name = 'stamina',
-- 				value = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
-- 			}
-- 		end

-- 		if Config.ui.showHunger == true then
-- 			showPlayerStatus = (showPlayerStatus+1)
-- 			TriggerEvent('iG_status:getStatus', 'hunger', function(status)
-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'hunger',
-- 					value = math.floor(100-status.getPercent())
-- 				}
-- 			end)
-- 		end

-- 		if Config.ui.showThirst == true then
-- 			showPlayerStatus = (showPlayerStatus+1)
-- 			TriggerEvent('iG_status:getStatus', 'thirst', function(status)
-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'thirst',
-- 					value = math.floor(100-status.getPercent())
-- 				}
-- 			end)
-- 		end

-- 		if Config.ui.showStress == true then
-- 			showPlayerStatus = (showPlayerStatus+1)
-- 			TriggerEvent('iG_status:getStatus', 'stress', function(status)
-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'stress',
-- 					value = math.floor(status.getPercent())
-- 				}
-- 			end)
-- 		end

-- 		SendNUIMessage(playerStatus)

-- 	end
-- end)


-- -- Overall Info
-- RegisterNetEvent('trew_hud_ui:setInfo')
-- AddEventHandler('trew_hud_ui:setInfo', function(info)

-- 	TriggerEvent('iG:getSharedObject', function(obj)
-- 		ESX = obj
-- 		ESX.PlayerData = ESX.GetPlayerData()
-- 	end)


-- 	local playerStatus 
-- 	local showPlayerStatus = 0
-- 	playerStatus = { action = 'setStatus', status = {} }


-- 	TriggerEvent('iG_Status:getStatus', 'hunger', function(hunger)
-- 		TriggerEvent('iG_Status:getStatus', 'thirst', function(thirst)
-- 			TriggerEvent('iG_Status:getStatus','stress',function(stress)

-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'hunger',
-- 					value = hunger.getPercent()
-- 				}

-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'thirst',
-- 					value = thirst.getPercent()
-- 				}

-- 				playerStatus['status'][showPlayerStatus] = {
-- 					name = 'stress',
-- 					value = stress.getPercent()
-- 				}

-- 			end)
-- 		end)
-- 	end)

-- 	SendNUIMessage(playerStatus)


-- end)



-- Weapons
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		local player = GetPlayerPed(-1)
		local status = {}

		if IsPedArmed(player, 7) then

			local weapon = GetSelectedPedWeapon(player)
			local ammoTotal = GetAmmoInPedWeapon(player,weapon)
			local bool,ammoClip = GetAmmoInClip(player,weapon)
			local ammoRemaining = math.floor(ammoTotal - ammoClip)
			
			status['armed'] = true
			for key,value in pairs(AllWeapons) do

				for keyTwo,valueTwo in pairs(AllWeapons[key]) do
					if weapon == GetHashKey(keyTwo) then
						status['weapon'] = keyTwo


						if key == 'melee' then
							SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
							SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
						else
							if keyTwo == 'stungun' then
								SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
								SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
							else
								SendNUIMessage({ action = 'element', task = 'enable', value = 'weapon_bullets' })
								SendNUIMessage({ action = 'element', task = 'enable', value = 'bullets' })
							end
						end

					end
				end

			end

			SendNUIMessage({ action = 'setText', id = 'weapon_clip', value = ammoClip })
			SendNUIMessage({ action = 'setText', id = 'weapon_ammo', value = ammoRemaining })

		else
			Citizen.Wait(1250)
			status['armed'] = false	
		end

		SendNUIMessage({ action = 'updateWeapon', status = status })

	end	

end)


-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function()
	local isPauseMenu = false
	RequestAnimDict('facials@gen_male@variations@normal')
	RequestAnimDict('mp_facial')
	while true do
		Citizen.Wait(0)

		-- local player = GetPlayerPed(-1)
		-- local vehicle = GetVehiclePedIsIn(player, false)
		-- local vehicleClass = GetVehicleClass(vehicle)

		-- Vehicle Seatbelt
		-- if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) then
		-- 	if IsControlJustReleased(0, Keys[Config.vehicle.keys.seatbelt]) and (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
		-- 		seatbeltIsOn = not seatbeltIsOn
		-- 	end
		-- end

		-- Vehicle Cruiser
		-- if IsControlJustPressed(1, Keys[Config.vehicle.keys.cruiser]) and GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then
			
		-- 	local vehicleSpeedSource = GetEntitySpeed(vehicle)

		-- 	if vehicleCruiser == 'on' then
		-- 		vehicleCruiser = 'off'
		-- 		SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
				
		-- 	else
		-- 		vehicleCruiser = 'on'
		-- 		SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
		-- 	end
		-- end

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
			end

			-- HideHudComponentThisFrame(1)  -- Wanted Stars
			-- HideHudComponentThisFrame(2)  -- Weapon Icon
			-- HideHudComponentThisFrame(3)  -- Cash
			-- HideHudComponentThisFrame(4)  -- MP Cash
			HideHudComponentThisFrame(6)  -- Vehicle Name
			HideHudComponentThisFrame(7)  -- Area Name
			HideHudComponentThisFrame(8)  -- Vehicle Class
			HideHudComponentThisFrame(9)  -- Street Name
			-- HideHudComponentThisFrame(13) -- Cash Change
			-- HideHudComponentThisFrame(17) -- Save Game
			-- HideHudComponentThisFrame(20) -- Weapon Stats
		end



		local playerID = PlayerId()
		local coords = GetEntityCoords(PlayerPedId())
		if NetworkIsPlayerTalking(playerID) and not isTalking then 
			isTalking = not isTalking
			SendNUIMessage({ action = 'isTalking', value = isTalking })
		elseif not NetworkIsPlayerTalking(playerID) and isTalking then 
			isTalking = not isTalking
			SendNUIMessage({ action = 'isTalking', value = isTalking })
		end

		
		for _,player in ipairs(GetActivePlayers()) do
			local boolTalking = NetworkIsPlayerTalking(player)

			if boolTalking then
				local otherCoords = GetEntityCoords(GetPlayerPed(player),true)
				-- PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
				DrawMarker(25, otherCoords.x, otherCoords.y, otherCoords.z - 0.95, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 34, 166, 240, 50, 0, 0, 2, 0, 0, 0, 0)
			-- elseif not boolTalking then
			-- 	PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
			end
		end

	end
end)

-- local Debug = false
-- if Debug then 
-- 	Citizen.CreateThread(function()
-- 		Citizen.Wait(1000)
-- 		playerLoaded = true
-- 		SendNUIMessage({ action = 'ui', config = Config.ui })
-- 		SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
-- 		HideHudComponentThisFrame(7) -- Area
-- 		HideHudComponentThisFrame(9) -- Street
-- 		HideHudComponentThisFrame(6) -- Vehicle
-- 	end)
-- end
RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
	playerLoaded = true

	SendNUIMessage({ action = 'ui', config = Config.ui })
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
	-- SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
	
	-- if Config.voice.levels.current == 0 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.default)
	-- elseif Config.voice.levels.current == 1 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.shout)
	-- elseif Config.voice.levels.current == 2 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.whisper)
	-- end
	-- NetworkSetTalkerProximity(10.0)
	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	-- HideHudComponentThisFrame(3) -- SP Cash
	-- HideHudComponentThisFrame(4) -- MP Cash
	-- HideHudComponentThisFrame(13) -- Cash changes!
end)









-- AddEventHandler('trew_hud_ui:setCarSignalLights', function(status)
-- 	local driver = GetVehiclePedIsIn(GetPlayerPed(-1), false)
-- 	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
-- 	local leftLight
-- 	local rightLight

-- 	if status == 'left' then
-- 		leftLight = false
-- 		rightLight = true
-- 		if hasTrailer then driver = vehicleTrailer end

-- 	elseif status == 'right' then
-- 		leftLight = true
-- 		rightLight = false
-- 		if hasTrailer then driver = vehicleTrailer end

-- 	elseif status == 'both' then
-- 		leftLight = true
-- 		rightLight = true
-- 		if hasTrailer then driver = vehicleTrailer end

-- 	else
-- 		leftLight = false
-- 		rightLight = false
-- 		if hasTrailer then driver = vehicleTrailer end

-- 	end

-- 	TriggerServerEvent('trew_hud_ui:syncCarLights', status)

-- 	SetVehicleIndicatorLights(driver, 0, leftLight)
-- 	SetVehicleIndicatorLights(driver, 1, rightLight)
-- end)



-- RegisterNetEvent('trew_hud_ui:syncCarLights')
-- AddEventHandler('trew_hud_ui:syncCarLights', function(driver, status)

-- 	if GetPlayerFromServerId(driver) ~= PlayerId() then
-- 		local driver = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(driver)), false)

-- 		if status == 'left' then
-- 			leftLight = false
-- 			rightLight = true

-- 		elseif status == 'right' then
-- 			leftLight = true
-- 			rightLight = false

-- 		elseif status == 'both' then
-- 			leftLight = true
-- 			rightLight = true

-- 		else
-- 			leftLight = false
-- 			rightLight = false
-- 		end

-- 		SetVehicleIndicatorLights(driver, 0, leftLight)
-- 		SetVehicleIndicatorLights(driver, 1, rightLight)

-- 	end
-- end)





















-- function trewDate()
-- 	local timeString = nil

-- 	local day = _U('day_' .. GetClockDayOfMonth())
-- 	local weekDay = _U('weekDay_' .. GetClockDayOfWeek())
-- 	local month = _U('month_' .. GetClockMonth())
-- 	local day = _U('day_' .. GetClockDayOfMonth())
-- 	local year = GetClockYear()


-- 	local hour = GetClockHours()
-- 	local minutes = GetClockMinutes()
-- 	local time = nil
-- 	local AmPm = ''


-- 	if Config.date.AmPm == true then

-- 		if hour >= 13 and hour <= 24 then
-- 			hour = hour - 12
-- 			AmPm = 'PM'
-- 		else
-- 			if hour == 0 or hour == 24 then
-- 				hour = 12
-- 			end
-- 			AmPm = 'AM'
-- 		end

-- 	end

-- 	if hour <= 9 then
-- 		hour = '0' .. hour
-- 	end
-- 	if minutes <= 9 then
-- 		minutes = '0' .. minutes
-- 	end

-- 	time = hour .. ':' .. minutes .. ' ' .. AmPm




-- 	local date_format = Locales[Config.Locale]['date_format'][Config.date.format]

-- 	if Config.date.format == 'default' then
-- 		timeString = string.format(
-- 			date_format,
-- 			day, month, year
-- 		)
-- 	elseif Config.date.format == 'simple' then
-- 		timeString = string.format(
-- 			date_format,
-- 			day, month
-- 		)

-- 	elseif Config.date.format == 'simpleWithHours' then
-- 		timeString = string.format(
-- 			date_format,
-- 			time, day, month
-- 		)	
-- 	elseif Config.date.format == 'withWeekday' then
-- 		timeString = string.format(
-- 			date_format,
-- 			weekDay, day, month, year
-- 		)
-- 	elseif Config.date.format == 'withHours' then
-- 		timeString = string.format(
-- 			date_format,
-- 			time, day, month, year
-- 		)
-- 	elseif Config.date.format == 'withWeekdayAndHours' then
-- 		timeString = string.format(
-- 			date_format,
-- 			time, weekDay, day, month, year
-- 		)
-- 	end


	

-- 	return timeString
-- end


function LoadUI()
	SendNUIMessage({ action = 'ui', config = Config.ui })
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
	-- SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
	
	-- if Config.voice.levels.current == 0 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.default)
	-- elseif Config.voice.levels.current == 1 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.shout)
	-- elseif Config.voice.levels.current == 2 then
	-- 	NetworkSetTalkerProximity(Config.voice.levels.whisper)
	-- end
	-- NetworkSetTalkerProximity(10.0)
	-- HideHudComponentThisFrame(7) -- Area
	-- HideHudComponentThisFrame(9) -- Street
	-- HideHudComponentThisFrame(6) -- Vehicle
	-- HideHudComponentThisFrame(3) -- SP Cash
	-- HideHudComponentThisFrame(4) -- MP Cash
	-- HideHudComponentThisFrame(13) -- Cash changes!
end



function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end



















-- local toggleui = false
-- RegisterCommand('toggleui', function()
-- 	if not toggleui then
-- 		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
-- 		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
-- 		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
-- 		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
-- 		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
-- 	else
-- 		if (Config.ui.showJob == true) then
-- 			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
-- 		end
-- 		if (Config.ui.showSocietyMoney == true) then
-- 			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
-- 		end
-- 		if (Config.ui.showBankMoney == true) then
-- 			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
-- 		end
-- 		if (Config.ui.showBlackMoney == true) then
-- 			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
-- 		end
-- 		if (Config.ui.showWalletMoney == true) then
-- 			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
-- 		end
-- 	end

-- 	toggleui = not toggleui
-- end)










-- exports('createStatus', function(args)
-- 	local statusCreation = { action = 'createStatus', status = args['status'], color = args['color'], icon = args['icon'] }
-- 	SendNUIMessage(statusCreation)
-- end)




-- exports('setStatus', function(args)
-- 	local playerStatus = { action = 'setStatus', status = {
-- 		{ name = args['name'], value = args['value'] }
-- 	}}
-- 	SendNUIMessage(playerStatus)
-- end)