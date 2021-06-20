----------------------------[[
--  CalmAI
----------------------------]]
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("ARMY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("DEALER"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("CIVMALE"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("HEN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("PRIVATE_SECURITY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("SECURITY_GUARD"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("AGGRESSIVE_INVESTIGATE"), GetHashKey('PLAYER'))


local hideRadar = true
local hasGPS = false
local firstSpawnRadar = true
local pedindex 					= {}
-- colors
local r,g,b,a = 166,166,255,255 -- rgba color


--==========================================================================================
--==                            	GET PLAYER LOOP              	                  ==
--==========================================================================================
local playerPed 
local playerPedId
local playerId
local pos = vector3(0.0, 0.0, 0.0)
local isInVehicle = false
Citizen.CreateThread(function() -- 500 MS Loop
	while true do
		playerPed 			= GetPlayerPed(-1)
		playerPedId 		= PlayerPedId()
        playerId	        = PlayerId()
        pos = GetEntityCoords(playerPedId)
        isInVehicle = IsPedSittingInAnyVehicle(playerPedId) 
        SetWeaponDrops()
        SetPedSuffersCriticalHits(playerPedId, false)
		Citizen.Wait(500)
	end
end)


Citizen.CreateThread(function()
    local Generators = {
        { -- Military Carrier
            Coords = vector3(3058.24, -4699.92, 15.28),
            Radius = 200.0
        },
        { -- Cayo Perico
            Coords = vector3(4700.0, -5145.0, 1.0),
            Radius = 1450.0
        },
        { -- Fort Zancudo
            Coords = vector3(-2477.88, 3259.52, 32.84),
            Radius = 100.0
        },
        { -- La Mesa PD #1
            Coords = vector3(836.8, -1348.24, 26.36),
            Radius = 50.0
        },
        {
         -- La Mesa PD #2
            Coords = vector3(830.0, -1265.08, 26.28),
            Radius = 25.0
        },
        {
         -- Grapeseed Garage
            Coords = vector3(1642.52, 4837.84, 42.04),
            Radius = 25.0
        }
    }

    while true do
        local sleep = 1000

        for k, v in pairs (Generators) do
            local dist = #(pos - v.Coords)
            if dist <= v.Radius + 100.0 then 
                sleep = 0
                RemoveVehiclesFromGeneratorsInArea(v.Coords.x - v.Radius, v.Coords.y - v.Radius, v.Coords.z - v.Radius, v.Coords.x + v.Radius, v.Coords.y + v.Radius, v.Coords.z + v.Radius)
            end
        end

        Citizen.Wait(sleep)
    end

end)


Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG" -- Zancudo Big Planes
    }

    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes" -- Far up in the skies jets
    }

    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXORG", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
        "POLICE",
        "POLMAV",
        "FIRETRUK",
        "AMBULANCE",
        "BUZZARD"
    }

    while true do
        for _, model in pairs (SUPPRESSED_MODELS) do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end

        for _, sctyp in pairs (SCENARIO_TYPES) do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in pairs (SCENARIO_GROUPS) do
            SetScenarioGroupEnabled(scgrp, false)
        end
        -- RemoveVehiclesFromGeneratorsInArea(842.64 - 50.0, -1344.32 - 50.0, 26.08 - 50.0, 842.64 + 50.0, -1344.32 + 50.0, 26.08 + 50.0)
        Wait(10000)
    end
end)

--==========================================================================================
--==                            	ANTI-WEAPON DROP FUNCTION               	          ==
--==========================================================================================

function SetWeaponDrops()

    local handle, ped = FindFirstPed()
    local finished = false

    repeat

        if not IsEntityDead(ped) then

            pedindex[ped] = {}

        end

        finished, ped = FindNextPed(handle)

    until not finished

    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do

        if peds ~= nil then

            SetPedDropsWeaponsWhenDead(peds, false)

        end

    end

end

-- local trafficDensity = 0.4
-- local pedDensity = 0.2
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        DisablePlayerVehicleRewards(playerId)
        -- RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0)
        -- SetRandomVehicleDensityMultiplierThisFrame(0.6)
        -- SetParkedVehicleDensityMultiplierThisFrame(0.7)
        -- SetPedDensityMultiplierThisFrame(0.7)
        -- SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1)
        -- SetCreateRandomCops(false) -- disable random cops walking/driving around.
        -- SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
        -- SetCreateRandomCopsOnScenarios(false)
        
        if isInVehicle then
            SetPedHelmet(playerPedId, false)
            DisplayRadar(true)
            -- if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),false),-1) == GetPlayerPed(-1) then
            --     SetVehicleDensityMultiplierThisFrame(0.1)
            -- else
            --     SetVehicleDensityMultiplierThisFrame(0.0)
            -- end
        elseif hasGPS then
            DisplayRadar(true)
        else
            DisplayRadar(false)
        end

    end
end)




-- Marker function, don't touch. 
function Marker(type, x, y, z, voiceS)
     DrawMarker(type, x, y, z - 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, voiceS, voiceS, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
end



--==========================================================================================
--==                                 ARREST ANIMATION FUNCTIONS                   		  ==
--==========================================================================================

function loadAnimDict(dict)
    RequestAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      Citizen.Wait(5)
  end

end

RegisterNetEvent('KneelHU')
AddEventHandler('KneelHU', function()

    local player = GetPlayerPed(-1)

	if (DoesEntityExist(player) and not IsEntityDead(player)) then

        loadAnimDict("random@arrests")
		loadAnimDict("random@arrests@busted")

		if (IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3)) then

			TaskPlayAnim(player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait (3000)
            TaskPlayAnim(player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)

        else

            TaskPlayAnim(player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait (4000)
            TaskPlayAnim(player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait (500)
			TaskPlayAnim(player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait (1000)
			TaskPlayAnim(player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)

        end

    end

end)

RegisterCommand("k", function(source, args, user)

	TriggerEvent('KneelHU', source, {})

end, false)



RegisterNetEvent('vy_UsableItems:useGPS')
AddEventHandler('vy_UsableItems:useGPS', function()
    hasGPS = true
end)

RegisterNetEvent('iG:removeInventoryItem')
AddEventHandler('iG:removeInventoryItem', function(name, count)
    local plyPed = GetPlayerPed(-1)
    if name == 'gps' then
        hasGPS = false
    end
end)
