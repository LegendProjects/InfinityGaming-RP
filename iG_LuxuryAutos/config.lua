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
		Pos   = vector3(-782.26, -210.73, 37.24),
		Size  = {x = 0.5, y = 0.5, z = 0.5},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(-791.53, -217.5, 36.71),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 207.34,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-791.53, -217.5, 36.71),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 183.64,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-809.04, -204.76, 37.24),
		Size  = {x = 0.5, y = 0.5, z = 0.5},
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

Config.Teleports = {
    --==========================================--
    --==========[ LUXURY AUTOS ]===========--
    --==========================================--
	["Luxury Autos - Showroom (Inside)"] = { 
		["x"] = -791.53, ["y"] = -217.5, ["z"] = 37.32,
		["h"] = 183.64, 
		["goto"] = { 
			"Luxury Autos - Front (Outside)",
			"Luxury Autos - Rear (Outside)"
		} 
    },

    ["Luxury Autos - Front (Outside)"] = { 
		["x"] = -818.52, ["y"] = -214.16, ["z"] = 37.32,
		["h"] = 31.12, 
		["goto"] = { 
			"Luxury Autos - Showroom (Inside)"
		} 
    },

    ["Luxury Autos - Rear (Outside)"] = { 
		["x"] = -781.36, ["y"] = -194.8, ["z"] = 37.28, 
		["h"] = 28.48, 
		["goto"] = { 
			"Luxury Autos - Showroom (Inside)"
		}
	}
}