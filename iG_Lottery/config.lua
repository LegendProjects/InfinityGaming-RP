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
Config.Lottery = {

	Main = {

		Blip = {
			Coords  = vector3(-1081.34, -249.12, 11.72),
			Sprite  = 468,
			Display = 4,
			Scale   = 0.8,
			Colour  = 60
		},

		Cloakrooms = {
			vector3(-2349.76, -661.56, 13.4),
		},

		Storage = {
			vector3(-1044.6, -234.72, 37.96)
		},

		Vehicles = {
			{
				Spawner = vector3(-1095.6, -259.52, 37.68),
				SpawnPoints = {
					{ coords = vector3(-1099.96, -258.84, 37.68), heading = 175.52, radius = 6.0 },
				}
			}
		},

		BossActions = {
			vector3(-1056.92, -233.2, 44.04),
		}

	},
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	ta_employee = {
		male = {
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

	ta_security = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 30,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = 12,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
        }
	},

	ta_cashier = {
		male = {
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

	ta_manager = {
		male = {
            ['tshirt_1'] = 33,  ['tshirt_2'] = 4,
            ['torso_1'] = 29,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
        }
	}, 

	ta_captain = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] =0,
            ['torso_1'] = 118,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 20,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = 113,  ['helmet_2'] = 5,
            ['chain_1'] = 115,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0
        }
	}, 

	ta_headsecurity = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 30,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = 12,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
        }
	}, 

	ta_cfo = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 30,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
        }
	},  

	boss = {
		male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] =0,
            ['torso_1'] = 30,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 11,    ['chain_2'] = 2,
        }
	}, 
}