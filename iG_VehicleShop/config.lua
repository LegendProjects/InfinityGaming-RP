Config                            = {}
Config.DrawDistance               = 10.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }

Config.EnableOwnedVehicles        = true

Config.Locale                     = 'en'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 2
Config.PlateNumbers  = 2
Config.PlateUseSpace = true

Config.Dealerships = {
	
	ShopName = {
		Shop   = {
			vector3(-34.4, -1106.28, 26.44),
			vector3(-783.5, -217.76, 37.24),
		},
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 36
	}
}
