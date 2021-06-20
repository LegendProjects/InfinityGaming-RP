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
Config.VanillaUnicorn = {

	Business = {

		Blip = {
			Coords  = vector3(104.8, -1303.48, 28.76),
			Sprite  = 121,
			Display = 4,
			Scale   = 0.8,
			Colour  = 48
		},

		Cloakrooms = {
			vector3(104.8, -1303.48, 28.76),
		},

		Storage = {
                  vector3(93.92, -1290.96, 29.28)
            },

		Vehicles = {
			{
				Spawner = vector3(136.48, -1278.76, 29.36),
				InsideShop = vector3(139.04, -1274.84, 29.28),
				SpawnPoints = {
					{ coords = vector3(139.04, -1274.84, 29.28), heading = 297.76, radius = 6.0 },
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-2383.56, -663.84, 10.48),
				InsideShop = vector3(-2386.84, -658.68, 11.72),
				SpawnPoints = {
					{ coords = vector3(-2386.84, -658.68, 11.72), heading = 272.16, radius = 10.0 }
				}
			},
			{
				Spawner = vector3(-2322.72, -662.56, 13.4),
				InsideShop = vector3(-2320.32, -658.2, 13.48),
				SpawnPoints = {
					{ coords = vector3(-2320.32, -658.2, 13.48), heading = 91.81, radius = 10.0 }
				}
			},
		},

		BossActions = {
			vector3(92.48, -1291.8, 29.28),
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