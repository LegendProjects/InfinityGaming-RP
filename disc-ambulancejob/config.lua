Config                            = {}
iG = {}
Config.DrawDistance               = 25.0

Config.Marker                     = { type = 1, x = 0.5, y = 0.5, z = 0.5, r = 10, g = 255, b = 10, a = 100, rotate = true }

Config.ReviveReward               = 1200  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(305.28, -592.68, 43.28), heading = 340.76 }


Config.Hospitals = {

	PillBox = {

		Blip = {
			coords = vector3(299.27, -584.61, 42.26),
			sprite = 153,
			scale  = 1.1,
			color  = 3,
			name = 'Pillbox Hill Medical Center'
		},

		AmbulanceActions = {
			vector3(298.96307373047, -598.36334228516, 43.284019470215), 
		},

		Vehicles = {
			{
				Spawner = vector3(321.2, -577.44, 28.8),
				InsideShop = vector3(317.52, -573.72, 28.8),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(317.52, -573.72, 28.8), heading = 250.2, radius = 4.0 }
				}
			},
			{
				Spawner = vector3(293.28, -598.16, 43.28),
				InsideShop = vector3(297.76, -605.16, 43.24),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(297.76, -605.16, 43.24), heading = 72.08, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(343.65319824218, -581.93774414062, 74.165641784668), 
				InsideShop = vector3(351.66836547852, -587.97479248046, 74.165580749512),
				Marker = { type = 34, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.66836547852, -587.97479248046, 74.165580749512), heading = 142.70, radius = 10.0 },
				}
			},
			{
				Spawner = vector3(1824.07, 3681.3, 40.5), 
				InsideShop = vector3(1828.88, 3677.19, 40.4),
				Marker = { type = 34, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1828.88, 3677.19, 40.4), heading = 210.27, radius = 10.0 },
				}
			}
		},

		FastTravels = {},

		FastTravelsPrompt = {}

	},

	SandyShores = {

		Blip = {
			coords = vector3(1838.92, 3673.6, 34.28),
			sprite = 153,
			scale  = 1.1,
			color  = 2,
			name = 'Sandy Shores Medical Center'
		},

		AmbulanceActions = {
			vector3(1825.84, 3675.04, 34.28),
		},

		Vehicles = {
			{
				Spawner = vector3(1810.52, 3680.4, 34.28),
				InsideShop = vector3(1808.84, 3683.28, 34.24),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1808.84, 3683.28, 34.24), heading = 294.88, radius = 4.0 }
				}
			}
		},
		Helicopters = {},
		FastTravels = {},
		FastTravelsPrompt = {}

	},

	PaletoBay = {

		Blip = {
			coords = vector3(-248.17652893066, 6332.9536132813, 32.426242828369), 
			sprite = 153,
			scale  = 1.1,
			color  = 2,
			name = 'Paleto Bay Medical Center'
		},

		AmbulanceActions = {
			vector3(-252.97, 6326.81, 32.44),
		},

		Vehicles = {
			{
				Spawner = vector3(-252.58757019043, 6340.3818359375, 32.426239013672),
				InsideShop = vector3(-261.61209106445, 6344.2006835938, 32.426315307617), 
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-261.61209106445, 6344.2006835938, 32.426315307617), heading = 268.62, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-258.92, 6309.68, 37.56),
				InsideShop = vector3(-253.08, 6318.6, 39.64),
				Marker = { type = 34, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-253.08, 6318.6, 39.64), heading = 135.0, radius = 10.0 },
				}
			}
		},

		FastTravels = {},
		FastTravelsPrompt = {}

	},
}

Config.AuthorizedVehicles = {

	tparamedic = {
			
	},

	paramedic = {
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
	},

	acparamedic = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
	},

	icparamedic = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},	
	},

	snrparamedic = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},	
	},

	

	emssuperintendent = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},	
	},

	emscsuperintendent = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},		
		{ model = 'answ_m5', label = '[ANSW] BMW M5', price = 0},		
	},

	emscabinet = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},		
		{ model = 'answ_m5', label = '[ANSW] BMW M5', price = 0},	
	},

	emsdcommissioner = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_m5', label = '[ANSW] BMW M5', price = 0},		
		{ model = 'answ_mustang', label = '[ANSW] Ford Mustang', price = 0},
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
	},

	boss = {
		{ model = 'answ_1200rt', label = '[ANSW] BMW 1200RT (Motorcycle)', price = 0},
		{ model = 'answ_ambo', label = '[ANSW] Ambulance', price = 0},	
		{ model = 'answ_m5', label = '[ANSW] BMW M5', price = 0},		
		{ model = 'answ_mustang', label = '[ANSW] Ford Mustang', price = 0},
		{ model = 'answ_patrol', label = '[ANSW] Nissan Patrol (Offroad)', price = 0},	
		{ model = 'answ_stinger', label = '[ANSW] Kia Stinger', price = 0},	
		{ model = 'answ_vess', label = '[ANSW] Holden VESS Commodore', price = 0},
	},
}

Config.AuthorizedHelicopters = {

	tparamedic = {},

	paramedic = {},

	acparamedic = {},

	icparamedic = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	snrparamedic = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	emssuperintendent = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	emscsuperintendent = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	emscabinet = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	emsdcommissioner = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

	boss = {
		{ model = 'ems_as350', label = '[HEMS] AS350 Helicopter', price = 0},
	},

}

Config.Uniforms = {
    long_wear = {
        male = {
            ['tshirt_1'] = 42,  ['tshirt_2'] = 0,
            ['torso_1'] = 79,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 86,
            ['pants_1'] = 49,   ['pants_2'] = 3,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['chain_1'] = 31,    ['chain_2'] = 0,
      }
},
	short_wear = {
		female = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 195,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 100,
			['pants_1'] = 51,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['chain_1'] = 14,    ['chain_2'] = 0,
	}
},

    short_wear = {
        male = {
            ['tshirt_1'] = 42,  ['tshirt_2'] =0,
            ['torso_1'] = 78,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 85,
            ['pants_1'] = 49,   ['pants_2'] = 3,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['chain_1'] = 31,    ['chain_2'] = 0,
	 },
		
	female = {
            ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 100,
            ['pants_1'] = 51,   ['pants_2'] = 0,
            ['shoes_1'] = 64,   ['shoes_2'] = 0,
            ['chain_1'] = 14,    ['chain_2'] = 0,
		}
	},

    pilot_wear = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] =0,
            ['torso_1'] = 159,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 70,   ['pants_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 79,  ['helmet_2'] = 4,
            ['chain_1'] = 0,    ['chain_2'] = 0,
        }
    },

    motorcycle_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] =0,
			['torso_1'] = 79,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 71,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 9,
			['chain_1'] = 0,    ['chain_2'] = 0,
        }
    },

	medbag = {
		male = {
			['bags_1'] = 45, ['bags_2'] = 0,
		}
	},

	medbag2 = {
		male = {
			['bags_1'] = 53, ['bags_2'] = 0,
		}
	},

	hat = {
		male = {
			['helmet_1'] = 44, ['helmet_2'] = 2,
		}
	},
	
	fire_turnout = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 81,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 43,   ['pants_2'] = 0,
			['shoes_1'] = 33,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0
		}
	},

	fire_oxygen = {
		male = {
			['tshirt_1'] = 68,  ['tshirt_2'] = 0,
			['glasses_1'] = 26,  ['glasses_2'] = 0,
		}
	},

	fire_helmet = {
		male = {
			['helmet_1'] = 45,  ['helmet_2'] = 0,
		}
	},
}