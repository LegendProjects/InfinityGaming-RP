Config = {}
Config.Locale = 'en'

Config.MenuAlign = 'right'
Config.DrawDistance = 20

Config.UseCommand = false -- Will allow players to do /getproperties instead of having to log out & back in to see Private Garages.
Config.ParkVehicles = false -- true = Automatically Park all Vehicles in Garage on Server/Script Restart | false = Opposite of true but players will have to go to Pound to get their Vehicle Back.
Config.KickPossibleCheaters = true -- true = Kick Player that tries to Cheat Garage by changing Vehicle Hash/Plate.
Config.UseCustomKickMessage = false -- true = Sets Custom Kick Message for those that try to Cheat. Note: "Config.KickPossibleCheaters" must be true.

Config.GiveSocietyMoney = false -- true = Gives money to society_mechanic. Note: REQUIRES esx_mechanicjob.
Config.ShowVehicleLocation = true -- true = Will show Location of Vehicles in the Garage Menus.
Config.ShowSpacers = true -- true = Shows Spacers in Menus.

Config.PointMarker = {Type = 1, r = 0, g = 255, b = 0, x = 1.0, y = 1.0, z = 1.0} -- Green Color / Standard Size Circle.
Config.DeleteMarker = {Type = 1, r = 255, g = 0, b = 0, x = 1.75, y = 1.75, z = 1.75} -- Red Color / Big Size Circle.
Config.PoundMarker = {Type = 1, r = 255, g = 100, b = 0, x = 1.0, y = 1.0, z = 1.0} -- Blue Color / Standard Size Circle.
Config.JPoundMarker = {Type = 1, r = 255, g = 0, b = 0, x = 1.0, y = 1.0, z = 1.0} -- Red Color / Standard Size Circle.

Config.GarageBlip = {Sprite = 357, Color = 18, Display = 2, Scale = 0.6} -- Public Garage Blip.
Config.PGarageBlip = {Sprite = 290, Color = 53, Display = 2, Scale = 0.6} -- Private Garage Blip.
Config.PoundBlip = {Sprite = 67, Color = 64, Display = 2, Scale = 0.6} -- Pound Blip.
Config.JGarageBlip = {Sprite = 290, Color = 49, Display = 2, Scale = 0.6}  -- Job Garage Blip.
Config.JPoundBlip = {Sprite = 67, Color = 49, Display = 2, Scale = 0.6}  -- Job Pound Blip.

Config.UsePoundTimer = true -- true = Uses Pound Timer
Config.PoundWait = 3 -- How many Minutes someone must wait before Opening Pound Menu Again.

Config.UseJPoundTimer = true -- true = Uses Job Pound Timer
Config.JPoundWait = 3 -- How many Minutes someone must wait before Opening Job Pound Menu Again.

Config.UseDamageMult = false -- true = Costs more to Store a Broken/Damaged Vehicle.
Config.DamageMult = 5 -- Higher Number = Higher Repair Price.

Config.UsingAdvancedVehicleShop = false -- Set to true if using esx_advancedvehicleshop

Config.UseAmbulanceGarages = false -- true = Allows use of Ambulance Garages.
Config.UseAmbulancePounds = true -- true = Allows use of Ambulance Pounds.
Config.UseAmbulanceBlips = true -- true = Use Ambulance Blips.
Config.AmbulancePoundPrice = 1500 -- How much it Costs to get Vehicle from Ambulance Pound.

Config.UsePoliceGarages = false -- true = Allows use of Police Garages.
Config.UsePolicePounds = true -- true = Allows use of Police Pounds.
Config.UsePoliceBlips = true -- true = Use Police Blips.
Config.PolicePoundPrice = 1500 -- How much it Costs to get Vehicle from Police Pound.

Config.UseAircraftGarages = true -- true = Allows use of Aircraft Garages.
Config.UseAircraftBlips = true -- true = Use Aircraft Blips.
Config.AircraftPoundPrice = 8500 -- How much it Costs to get Vehicle from Aircraft Pound.

Config.UseBoatGarages = true -- true = Allows use of Boat Garages.
Config.UseBoatBlips = true -- true = Use Boat Blips.
Config.BoatPoundPrice = 4500 -- How much it Costs to get Vehicle from Boat Pound.

Config.UseCarGarages = true -- true = Allows use of Car Garages.
Config.UseCarBlips = true -- true = Use Car Blips.
Config.CarPoundPrice = 1500 -- How much it Costs to get Vehicle from Car Pound.

Config.UsePrivateCarGarages = false -- true = Allows use of Private Car Garages.

-- Marker = Enter Location | Spawner = Spawn Location | Spawner2 = Job Aircraft Spawn Location | Deleter = Delete Location
-- Deleter2 = Job Aircraft Delete Location | Heading = Spawn Heading | Heading2 = Job Aircraft Spawn Heading

-- Start of Ambulance
Config.AmbulancePounds = {
	LosSantos = {
		Marker = vector3(325.51, -564.67, 28.80),
		Spawner = vector3(321.43, -565.64, 28.09),
		Heading = 247.71
	},
	Sandy = {
		Marker = vector3(1646.01, 3812.06, 38.55),
		Spawner = vector3(1665.96, 3808.16, 34.08),
		Heading = 183.6
	},
	Paleto = {
		Marker = vector3(-235.8, 6231.44, 31.48),
		Spawner = vector3(-240.72, 6235.08, 31.44),
		Heading = 135.04
	}
}
-- End of Ambulance

-- Start of Police
Config.PolicePounds = {
	LosSantos = {
		Marker = vector3(429.36, -974.88, 25.68),
		Spawner = vector3(435.44, -975.72, 25.68),
		Heading = 90.0
	},
	Sandy = {
		Marker = vector3(1646.01, 3812.06, 38.55),
		Spawner = vector3(1665.96, 3808.16, 34.08),
		Heading = 183.6
	},
	Paleto = {
		Marker = vector3(-235.8, 6231.44, 31.48),
		Spawner = vector3(-240.72, 6235.08, 31.44),
		Heading = 135.04
	}
}
-- End of Police

-- Start of Society
Config.SocietyPounds = {
	LosSantos = {
		Marker = vector3(-203.88, -1161.92, 23.16),
		Spawner = vector3(-208.76, -1168.96, 23.04),
		Heading = 86.68
	},
	Sandy = {
		Marker = vector3(1644.56, 3808.8, 35.08),
		Spawner = vector3(1638.96, 3802.2, 34.84),
		Heading = 210.12
	},
	Paleto = {
		Marker = vector3(-229.52, 6237.12, 31.48),
		Spawner = vector3(-234.16, 6241.6, 31.44),
		Heading = 135.04
	}
}
-- End of Society

-- Start of Aircrafts
Config.AircraftGarages = {
	Garage_LSAirport = {
		Marker = vector3(-1617.14, -3145.52, 13.99),
		Spawner = vector3(-1657.99, -3134.38, 12.99),
		Deleter = vector3(-1650.99, -3140.82, 13.12),
		Heading = 330.11
	},
	 Garage_SandyAirport = {
	 	Marker = vector3(1776.3, 3246.34, 42.3),
	 	Spawner = vector3(1770.09, 3239.35, 42.14),
	 	Deleter = vector3(1770.09, 3239.35, 41.25),
	 	Heading = 294.88
	 },
	Garage_GrapeseedAirport = {
		Marker = vector3(2152.83, 4797.03, 41.2),
		Spawner = vector3(2122.72, 4804.85, 40.78),
		Deleter = vector3(2122.72, 4804.85, 40.20),
		Heading = 114.91
	}
}

Config.AircraftPounds = {
	Pound_LSAirport = {
		Marker = vector3(-1242.99, -3391.82, 13.94),
		Spawner = vector3(-1271.88, -3382.45, 14.31),
		Heading = 330.4
	},
	Pound_GrapeseedAirport = {
		Marker = vector3(2150.46, 4795.27, 41.18),
		Spawner = vector3(2122.72, 4804.85, 40.78),
		Heading = 114.91
	}
}

-- End of Aircrafts

-- Start of Boats
Config.BoatGarages = {
	Garage_LSDock = {
		Marker = vector3(-719.35, -1326.27, 1.6),
		Spawner = vector3(-759.88, -1390.8, 0.76),
		Deleter = vector3(-759.88, -1390.8, 0.76),
		Heading = 142.64
	},
	Garage_SandyDock = {
		Marker = vector3(1338.39, 4268.87, 31.5),
		Spawner = vector3(1323.29, 4268.65, 30.48),
		Deleter = vector3(1323.29, 4268.65, 30.48),
		Heading = 171.96
	},
	Garage_PaletoDock = {
		Marker = vector3(-1614.84, 5261.0, 3.96),
		Spawner = vector3(-1614.32, 5269.36, 1.08),
		Deleter = vector3(-1614.32, 5269.36, 1.08),
		Heading = 121.12
	}
}

Config.BoatPounds = {
	Pound_LSDock = {
		Marker = vector3(-725.47, -1374.15, 1.6 ),
		Spawner = vector3(-759.88, -1390.8, 0.76),
		Heading = 142.64
	},
	Pound_SandyDock = {
		Marker = vector3(1299.36, 4217.93, 33.91),
		Spawner = vector3(1297.86, 4209.8, 30.02),
		Heading = 261.12
	},
	Pound_PaletoDock = {
		Marker = vector3(-1610.16, 5263.2, 3.96),
		Spawner = vector3(-1614.32, 5269.36,  1.08),
		Heading = 121.12
	}
}
-- End of Boats

-- Start of Cars
Config.CarGarages = {
	Garage_1 = {
		Marker = vector3(-334.16, -693.32, 32.92),
		Spawner = vector3(-330.16, -694.28, 32.96-0.9),
		Deleter = vector3(-330.16, -694.28, 32.96-0.9),
		Heading = 268.44
	},
	-- Garage_2 = {
	-- 	Marker = vector3(-15.78, 6.42, 71.56),
	-- 	Spawner = vector3(-11.28, 7.8, 70.4), 
	-- 	Deleter = vector3(-11.96, 6.04, 70.41),
	-- 	Heading = 339.79
	-- },
	Garage_3 = {
		Marker = vector3(286.04, 66.12, 99.89), 
		Spawner = vector3(288.8, 63.64, 99.04), 
		Deleter = vector3(288.28, 62.25, 98.94), 
		Heading = 339.25
	},
	Garage_4 = {
		Marker = vector3(-509.84, 45.2, 52.56), 
		Spawner = vector3(-511.72, 48.24, 51.76), 
		Deleter = vector3(-511.28, 48.28, 51.6), 
		Heading = 84.68
	},
	Garage_5 = {
		Marker = vector3(-1508.89, -585.04, 23.27),
		Spawner = vector3(-1508.46, -582.76, 22.27), 
		Deleter = vector3(-1508.51, -582.66, 22.32), 
		Heading = 34.43
	},
	Garage_6 = {
		Marker = vector3(-708.34, -1287.58, 5.08), 
		Spawner = vector3(-709.26, -1278.17, 4.16), 
		Deleter = vector3(-709.26, -1278.17, 4.12), 
		Heading = 140.32
	},
	Garage_7 = {
		Marker = vector3(-74.05, -1824.92, 26.94),
		Spawner = vector3(-68.56, -1825.32, 27.2), 
		Deleter = vector3(-70.53, -1823.68, 25.98), 
		Heading = 229.81
	},
	Garage_8 = {
		Marker = vector3(642.14, 2772.28, 42.05), 
		Spawner = vector3(644.02, 2775.49, 41.12), 
		Deleter = vector3(644.02, 2775.49, 41.1), 
		Heading = 220.1
	},
	Garage_9 = {
		Marker = vector3(-278.79, 6167.47, 31.4), 
		Spawner = vector3(-272.94, 6172.67, 30.64), 
		Deleter = vector3(-272.94, 6172.67, 30.55), 
		Heading = 314.39
	},
	Garage_10 = {
		Marker = vector3(1645.83, 4842.02, 42.03), 
		Spawner = vector3(1641.48, 4835.79, 41.2), 
		Deleter = vector3(1641.48, 4835.79, 41.05), 
		Heading = 186.68
	},
	Garage_11 = {
		Marker = vector3(1773.6, 3332.84, 41.36), 
		Spawner = vector3(1779.89, 3339.49, 41.0-0.9), 
		Deleter = vector3(1779.89, 3339.49, 41.0-0.9), 
		Heading = 304.52
	},
	Garage_12 = {
		Marker = vector3(998.88, -1855.5, 30.95), 
		Spawner = vector3(995.16, -1862.04, 30.04), 
		Deleter = vector3(995.16, -1862.04, 29.9), 
		Heading = 176.8
	},
	Garage_13 = {
		Marker = vector3(-957.41, -2709.87, 13.83), 
		Spawner = vector3(-960.91, -2707.51, 12.93), 
		Deleter = vector3(-960.91, -2707.51, 12.85), 
		Heading = 12.07
	},
	Garage_14 = {
		Marker = vector3(-3161.11, 1126.63, 20.72), 
		Spawner = vector3(-3155.56, 1133.95, 20.0), 
		Deleter = vector3(-3155.56, 1133.95, 20.0), 
		Heading = 336.96
	},
	Garage_15 = {
		Marker = vector3(1032.64, -762.84, 58.0), 
		Spawner = vector3(1029.32, -763.76, 58.0-0.9), 
		Deleter = vector3(1029.32, -763.76, 58.0-0.9), 
		Heading = 54.88
	},
	Garage_16 = {
		Marker = vector3(944.81, 34.23, 81.00), 
		Spawner = vector3(949.28, 35.53, 80.20), 
		Deleter = vector3(949.28, 35.53, 80.18), 
		Heading = 146.27
	},
}

Config.CarPounds = {
	Los_Santos = {
		Marker = vector3(-201.28, -1167.72, 23.16),
		Spawner = vector3(-208.76, -1168.96, 23.04),
		Heading = 90.44
	},
	Sandy_Shores = {
		Marker = vector3(1651.38, 3804.84, 38.65),
		Spawner = vector3(1665.96, 3808.16, 34.08),
		Heading = 183.6
	},
	Paleto_Bay = {
		Marker = vector3(-234.82, 6198.65, 31.94),
		Spawner = vector3(-232.76, 6188.44, 31.76),
		Heading = 135.04
	},
	-- Mirror_Park = {
	-- 	Marker = vector3(1030.1, -764.52, 57.99),
	-- 	Spawner = vector3(1022.63, -764.06, 57.26),
	-- 	Heading = 322.47
	-- },
}
-- End of Cars