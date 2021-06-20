Config = {}
------------------------------------------------------------------------------------------------------
----------------------------------------------- MAIN -------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Database = 'mysql' --[ 'mysql' / 'ghmattimysql' ] Choose your sql database script.
Config.Language = 'EN' --[ 'EN' / 'FR' / 'ES' / 'CZ' / 'PT' ] You can add your own locales to the Locales.lua. But make sure to add it here.

Config.UseESX = true --Do you use es_extended?
Config.ESXTriggers = { --You can change the esx events (IF NEEDED).
    main = 'iG:getSharedObject',
    load = 'iG:playerLoaded',
    job = 'iG:setJob',
}

Config.NotificationType = { --[ 'chat' / 'mythic_old' / 'mythic_new' / 'esx' / 'custom' ].
    server = 'mythic_new',
    client = 'mythic_new', 
}

Config.EnableTestCommand = false --Set to true to enable the test command 'openspawnselect'.
Config.BuggedSpawnCoords = vector4(314.86, -213.28, 54.09, 44.56) --If there is an error or the database coords are nil, this will be a backup spawn location.

------------------------------------------------------------------------------------------------------
------------------------------------------------- OTHER ----------------------------------------------
------------------------------------------------------------------------------------------------------
Config.CommandName = 'personalspawn' --Set the name of the command to show/set/delete your personal spawn location.
Config.JobSpawns = true --Choose wether you want to enable the option for employees to spawn at their workplace.
Config.PersonalSpawn = false --Choose wether you want to enable the option for a player to set their own personal spawn location.
Config.lastPosition = true --Choose wether you want to enable the option for a player spawn in their last saved location.
Config.DayHours = {[1] = 6, [2] = 22} --If the game time is between 6am to 10pm then dark mode will be enabled, else lightmode will be enabled (using 24 hour clock).


Config.JobSpawnsCoords = { --If Config.JobSpawns is enabled then you can customise which jobs are eligable and where they spawn.

  	['ambulance'] = {x = 354.6, y = -604.56, z = 28.8, h = 278.36, name = 'Pillbox Hospital'},
	['offambulance'] = {x = 354.6, y = -604.56, z = 28.8, h = 278.36, name = 'Pillbox Hospital'},

	['offpolice'] = {x = 441.88, y = -1002.36, z = 30.72, h = 179.12, name = 'Mission Row PD'},
	['police'] = {x = 441.88, y = -1002.36, z = 30.72, h = 179.12, name = 'Mission Row PD'},
	['offafp'] = {x = 441.88, y = -1002.36, z = 30.72, h = 179.12, name = 'Mission Row PD'},
	['afp'] = {x = 441.88, y = -1002.36, z = 30.72, h = 179.12, name = 'Mission Row PD'},

    -- ['mechanic'] 		= {x = 949.64, y = -986.29, z = 39.83, h = 110.17,  	name = 'Mechanic'},
    -- ['cardealer'] 		= {x = -815.98, y = -194.89, z = 37.52, h = 115.08,  	name = 'Car Dealer'},
    -- ['taxi'] 			= {x = 907.01, y = -164.23, z = 74.12, h = 162.66,  	name = 'Taxi'},
    --['enter_here'] 		= {x = 00.0, y = 00.0, z = 00.0, z = 00.0, h = 00.0,	name = 'enter_here'}

}

Config.MainSpawns = { --The names in the mapdata.js must match with the name here to get the correct coordinates.
  	['The Kortz Center'] 					= {x = -2291.47, y = 366.14, z = 174.6, h = 27.47},
  	['Maze Bank Arena'] 					= {x = -249.82, y = -2031.23, z = 29.95, h = 230.62},
  	['Sandy Shores Sheriff\'s Station'] 	= {x = 1877.17, y = 3706.46, z = 33.19, h = 169.16},
  	['Bolingbroke Penitentiary'] 			= {x = 1852.88, y = 2581.95, z = 45.67, h = 283.87},
  	['Luxury Autos'] 						= {x = -815.98, y = -194.89, z = 37.52, h = 115.08},
  	['Vinewood Motel'] 						= {x = 436.25, y = 215.84, z = 103.17, h = 338.43},
  	['Vespucci Police Station'] 			= {x = -1119.71, y = -857.11, z = 19.69, h = 314.65},
  	['Paleto Bay Troopers Office'] 			= {x = -448.05, y = 5986.79, z = 31.49, h = 20.64},
  	['Paleto Garage'] 						= {x = 101.82, y = 6617.12, z = 32.47, h = 239.29},
  	['Grapeseed Store'] 					= {x = 1692.32, y = 4917.21, z = 42.08, h = 59.45},
  	['Airport - LSIA'] 						= {x = -1036.96, y = -2736.84, z = 20.17, h = 327.0},
  	['Del Perro Pier'] 						= {x = -1691.58, y = -1099.54, z = 13.15, h = 47.01},
  	['Eastern Motel'] 						= {x = 317.9, y = 2623.21, z = 44.47, h = 292.39},
  	['Stab City'] 							= {x = 79.08, y = 3708.11, z = 41.08, h = 53.36},
  	['Sandy Shores Airport'] 				= {x = 1759.0, y = 3298.66, z = 41.74, h = 143.01},
  	['Vinewood Casino'] 					= {x = 926.66, y = 45.63, z = 80.9, h = 57.57},
  	['Grove Street Garage'] 				= {x = -78.47, y = -1832.54, z = 27.03, h = 320.42},
  	['Mirror Park Garage'] 					= {x = 1033.57, y = -768.57, z = 58.0, h = 49.98},
  	--['test'] 								= {x = 000, y = 000, z = 000},
}