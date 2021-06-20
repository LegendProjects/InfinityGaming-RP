Config                            = {}
Config.DrawDistance               = 25
Config.MarkerColor                = {r = 120, g = 120, b = 240}
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.ResellPercentage           = 0

Config.Locale                     = 'en'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 2
Config.PlateNumbers  = 2
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-42.72, -1093.4, 26.44),
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(-44.72, -1098.4, 26.44),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 250.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-44.72, -1098.4, 26.44),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 250.0,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-32.32, -1114.72, 26.44),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	GiveBackVehicle = {
		Pos     = vector3(-500.0, -500.0, -10),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos     = vector3(-500.0, -500.0, -10),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	}

}
