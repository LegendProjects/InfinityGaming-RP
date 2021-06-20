Config                            = {}

Config.DrawDistance               = 25.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'en'

Config.Gruppe6_Buildings = {

    Headquarters = {

        Blip = {
            Coords  = vector3(-1316.96, -831.32, 17.0),
            Sprite  = 498,
            Display = 4,
            Scale   = 0.8,
            Colour  = 11
        },

        Storage = {
			vector3(127.52, -1300.18, 29.23),
            vector3(-1312.78, -822.16, 17.15),
		},

        Cloakrooms = {
            vector3(-1300.96, -816.96, 17.16)
        },

        Vehicles = {
            {
                Spawner = vector3(-1330.48, -816.44, 17.0),
                ShopPoints = {
                    { coords = vector3(-1335.04, -807.52, 17.68), heading = 140.0, radius = 6.0 }
                },
                SpawnPoints = {
                    { coords = vector3(-1335.04, -807.52, 17.68), heading = 140.0, radius = 6.0 }
                }
            }
        },

        BossActions = {
            vector3(-1296.08, -837.96, 17.16)
        }

    }
}

Config.Gruppe6_Vehicles = {
    Shared = {},
    gruppe6_pofficer = {
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 }
    },
    gruppe6_officer = {
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 }
    },
    gruppe6_sofficer = {
        { model = 'stockade', label = 'Gruppe6: Stockade', price = 0 },
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 }
    },
    gruppe6_supervisor = {
        { model = 'stockade', label = 'Gruppe6: Stockade', price = 0 },
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 },
        { model = 'g6_wrx', label = 'Gruppe6: Subaru WRX', price = 0 },
        { model = 'g6_focus', label = 'Gruppe6: Ford Focus', price = 0 }
    },
    gruppe6_teamleader = {
        { model = 'stockade', label = 'Gruppe6: Stockade', price = 0 },
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 },
        { model = 'g6_wrx', label = 'Gruppe6: Subaru WRX', price = 0 },
        { model = 'g6_focus', label = 'Gruppe6: Ford Focus', price = 0 },
        { model = 'g6_stinger', label = 'Gruppe6: Kia Stinger', price = 0 },
        { model = 'g6_m5', label = 'Gruppe6: BMW M5', price = 0 }
    },
    gruppe6_commander = {
        { model = 'stockade', label = 'Gruppe6: Stockade', price = 0 },
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 },
        { model = 'g6_wrx', label = 'Gruppe6: Subaru WRX', price = 0 },
        { model = 'g6_focus', label = 'Gruppe6: Ford Focus', price = 0 },
        { model = 'g6_stinger', label = 'Gruppe6: Kia Stinger', price = 0 },
        { model = 'g6_m5', label = 'Gruppe6: BMW M5', price = 0 }
    },
    gruppe6_coo = {
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 },
        { model = 'g6_wrx', label = 'Gruppe6: Subaru WRX', price = 0 },
        { model = 'g6_focus', label = 'Gruppe6: Ford Focus', price = 0 },
        { model = 'g6_stinger', label = 'Gruppe6: Kia Stinger', price = 0 },
        { model = 'g6_m5', label = 'Gruppe6: BMW M5', price = 0 },
        { model = 'g6_mustang', label = 'Gruppe6: Ford Mustang', price = 0 }
    },
    boss = {
        { model = 'stockade', label = 'Gruppe6: Stockade', price = 0 },
        { model = 'g6_vess', label = 'Gruppe6: Holden VESS', price = 0 },
        { model = 'g6_ranger', label = 'Gruppe6: Ford Ranger', price = 0 },
        { model = 'g6_vfss', label = 'Gruppe6: Holden VFSS', price = 0 },
        { model = 'g6_wrx', label = 'Gruppe6: Subaru WRX', price = 0 },
        { model = 'g6_focus', label = 'Gruppe6: Ford Focus', price = 0 },
        { model = 'g6_stinger', label = 'Gruppe6: Kia Stinger', price = 0 },
        { model = 'g6_m5', label = 'Gruppe6: BMW M5', price = 0 },
        { model = 'g6_mustang', label = 'Gruppe6: Ford Mustang', price = 0 }
    }
}
-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
    gruppe6_pofficer = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 95,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 37,
            ['pants_1'] = 33,   ['pants_2'] = 1,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_officer = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 95,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 37,
            ['pants_1'] = 33,   ['pants_2'] = 1,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_sofficer = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 95,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 37,
            ['pants_1'] = 33,   ['pants_2'] = 1,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_supervisor = {
        male = {
            ['tshirt_1'] = 33,  ['tshirt_2'] = 0,
            ['torso_1'] = 29,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 33,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_teamleader = {
        male = {
            ['tshirt_1'] = 33,  ['tshirt_2'] = 0,
            ['torso_1'] = 29,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 33,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_commander = {
        male = {
            ['tshirt_1'] = 6,  ['tshirt_2'] = 2,
            ['torso_1'] = 21,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 26,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 25,    ['chain_2'] = 5,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    gruppe6_coo = {
        male = {
            ['tshirt_1'] = 6,  ['tshirt_2'] = 2,
            ['torso_1'] = 21,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 26,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 25,    ['chain_2'] = 5,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    boss = {
        male = {
            ['tshirt_1'] = 6,  ['tshirt_2'] = 2,
            ['torso_1'] = 21,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 26,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['mask_1'] = 121, ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 25,    ['chain_2'] = 5,
			['glasses_1'] = 5,    ['glasses_2'] = 3,
        }
    },

    vest = {
        male = {
            ['bproof_1'] = 18,  ['bproof_2'] = 0
        }
    },
	
	g6_tactical_gear = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 220,   ['torso_2'] = 20,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 42,
            ['pants_1'] = 33,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['mask_1'] = 52, ['mask_2'] = 10,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['helmet_1'] = 88,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 5,
			['glasses_1'] = 5,    ['glasses_2'] = 3
        }
    },


}