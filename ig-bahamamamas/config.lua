Config                            = {}

Config.DrawDistance               = 25.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.Locale                     = 'en'
Config.MaxInService				  = -1
Config.BahamaMamas = {

	Business = {

		Blip = {
			Coords  = vector3(-1388.48, -586.76, 30.24),
			Sprite  = 93,
			Display = 4,
			Scale   = 0.8,
			Colour  = 8
		},


		Storage = {
                  vector3(-1385.08, -606.36, 30.32)
            },

		Vehicles = {
			{
				Spawner = vector3(-1420.12, -600.4, 30.6),
				InsideShop = vector3(-1420.04, -595.56, 30.52),
				SpawnPoints = {
					{ coords = vector3(-1420.04, -595.56, 30.52), heading = 296.04, radius = 6.0 },
				}
			}
		},

		BossActions = {
			vector3(-1371.32, -625.84, 30.8),
		}

	},
}

	

Config.AuthorizedWeapons = {}



-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'macanturbo', label = 'Porsche Macan Turbo', price = 61400 },
		{ model = 'Wraith', label = 'Rolls Royce Wraith', price = 243500 },
		{ model = 'dinghy', label = 'Dinghy', price = 2500 },
		{ model = 'jetmax', label = 'Jetmax', price = 12500 },
		{ model = 'seashark', label = 'Seashark', price = 7500 },
	},
}

Config.AuthorizedHelicopters = {
	Shared = {
		{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 175000 },
		{ model = 'swift', label = 'Swift', livery = 0, price = 450000 },
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

	vanillaunicorn_dancer = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 

	vanillaunicorn_bartender = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	vanillaunicorn_barmanager = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	vanillaunicorn_security = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	vanillaunicorn_securitymanager = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	vanillaunicorn_manager = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	vanillaunicorn_coowner = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}, 
	
	boss = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		},
		
		female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
		}
	}
	
}