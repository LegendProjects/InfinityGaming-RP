Config                            = {}

Config.DrawDistance               = 25.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = true -- only turn this on if you are using igLogs

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.GovernmentBuildings = {

	OwenErr = {

		Blip = {
			Coords  = vector3(-545.92, -202.8, 38.24),
			Sprite  = 419,
			Display = 4,
			Scale   = 0.8,
            Colour  = 0,
            Name    = 'Government: Department of Human Services, NSW'
		},

		Cloakrooms = {},
		Armories = {},
		ItemStore = {},
		Vehicles = {},
		Helicopters = {},
		BossActions = {	vector3(-545.08, -204.2, 47.4)	}

	},

	DPIPWE = {

		Blip = {
			Coords  = vector3(386.92, 792.32, 187.68),
			Sprite  = 419,
			Display = 4,
			Scale   = 0.8,
            Colour  = 0,
            Name    = 'Government: Parks & Wildlife Service, NSW'
		},

		Cloakrooms = {},
		Armories = {},
		ItemStore = {},
		Vehicles = {},
		Helicopters = {},
		BossActions = {}
	},

	PaletoBayCouncilChambers = {

		Blip = {
			Coords  = vector3(-140.84, 6300.44, 31.48),
			Sprite  = 419,
			Display = 4,
			Scale   = 0.8,
            Colour  = 0,
            Name    = 'Government: Paleto Bay Council Chambers'
		},

		Cloakrooms = {	vector3(-153.88, 6295.72, 35.48)	},
		Armories = {},
		ItemStore = {},
		Vehicles = {},
		Helicopters = {},
		BossActions = {	vector3(-146.04, 6306.4, 35.48)	}
	}

}

Config.AuthorizedWeapons = {
	Shared = {}
}

Config.GovernmentVehicles = {
	Shared = {}
}

Config.GovernmentHelicopters = {
	Shared = {}
}

Config.Uniforms = {
	suit = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 200,   ['torso_2'] = 11,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
        }
	},

}