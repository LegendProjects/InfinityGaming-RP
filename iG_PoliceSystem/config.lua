Config                            = {}

Config.DrawDistance               = 25.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }

Config.EnablePlayerManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = true -- only turn this on if you are using igLogs

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	MRPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 0
		},

		Cloakrooms = {
			vector3(462.12, -999.48, 30.68),
			vector3(461.96, -995.88, 30.68),
		},

		Vehicles = {
			{
				Spawner = vector3(456.56, -974.08, 25.68),
				ShopPoints = {
					{ coords = vector3(449.96, -975.72, 25.68), heading = 90.0, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(449.96, -975.72, 25.68), heading = 90.0, radius = 6.0 },
				}
			},
			{
				Spawner = vector3(461.6, -995.6, 25.68),
				ShopPoints = {
					{ coords = vector3(458.88, -992.84, 25.68), heading = 0.0, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(458.88, -992.84, 25.68), heading = 0.0, radius = 6.0 },
				}
			},

			-- {
			-- 	Spawner = vector3(430.08, -974.08, 25.68),
			-- 	ShopPoints = {
			-- 		{ coords = vector3(435.44, -975.72, 25.68), heading = 90.0, radius = 6.0 },
			-- 	},
			-- 	SpawnPoints = {
			-- 		{ coords = vector3(435.44, -975.72, 25.68), heading = 90.0, radius = 6.0 },
			-- 	}
			-- },

			{
				Spawner = vector3(471.64, -1029.44, 28.2),
				ShopPoints = {
					{ coords = vector3(476.0, -1026.4, 28.12), heading = 330.0, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(476.0, -1026.4, 28.12), heading = 330.0, radius = 6.0 },
				}
			},

		},

		Watercraft = {
			{
				Spawner = vector3(-798.96, -1495.04, 1.6), 
				ShopPoints = {
					{ coords = vector3(-795.36, -1498.28, 1.36), heading = 112.56, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(-795.36, -1498.28, 1.36), heading = 112.56, radius = 6.0 },
				}
			},
			{
				Spawner = vector3(1687.96, 39.44, 161.76), 
				ShopPoints = {
					{ coords = vector3(1688.12, 36.2, 161.08), heading = 274.56, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(1688.12, 36.2, 161.08), heading = 274.56, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				ShopPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				},
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		EvidenceLockers = {
			vector3(474.24, -990.68, 26.28)
		},

		BossActions = {
			vector3(463.36, -984.8, 30.68), 
		}

	},

	SSPD = {

		Blip = {
			Coords  = vector3(1856.5743408204, 3681.37109375, 34.267059326172), 
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 0
		},

		Cloakrooms = {
			vector3(1857.84, 3694.9, 34.28),
		},

		Vehicles = {
			{
				Spawner = vector3(1867.9331054688, 3690.47265625, 33.745513916016), 
				ShopPoints = {
					{ coords = vector3(1869.8566894532, 3694.1320800782, 33.59502029419), heading = 90.0, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(1869.8566894532, 3694.1320800782, 33.59502029419), heading = 90.0, radius = 6.0 },
				}
			},
		},

		Watercraft = {
			{
				Spawner = vector3(1341.08, 4225.12, 33.92), 
				ShopPoints = {
					{ coords = vector3(1346.24, 4222.88, 30.52), heading = 170.24, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(1346.24, 4222.88, 30.52), heading = 170.24, radius = 6.0 },
				}
			},
		},

		Helicopters = {},

		EvidenceLockers = {},

		BossActions = {
			vector3(1862.08, 3689.36, 34.28),
		}
	},
	
	AFP = {

		Blip = {
			Coords  = vector3(88.36, -741.84, 45.76), 
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 0
		},

		Cloakrooms = {
			vector3(128.32, -750.04, 242.16),
		},

		Vehicles = {
			{
				Spawner = vector3(120.48, -740.2, 33.12), 
				ShopPoints = {
					{ coords = vector3(126.32, -729.2, 33.12), heading = 339.64, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(118.92, -736.36, 33.12), heading = 342.64, radius = 6.0 },
					{ coords = vector3(115.08, -735.24, 33.12), heading = 336.84, radius = 6.0 },
					{ coords = vector3(125.16, -719.76, 33.12), heading = 156.28, radius = 6.0 },
				}
			},
		},

		Helicopters = {},
		Watercraft = {},
		EvidenceLockers = {},

		BossActions = {
			vector3(110.36, -751.12, 242.16),
		}
	},

	PPD = {

		Blip = {
			Coords  = vector3(-443.48, 6016.2, 31.72),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 0
		},

		Cloakrooms = {
			vector3(-451.48, 6010.48, 31.84),
		},

		Vehicles = {
			{
				Spawner = vector3(-449.80615234375, 6003.5307617188, 31.490112304688), 
				ShopPoints = {
					{ coords = vector3(-454.73007202148, 6001.9018554688, 31.340549468994), heading = 90.0, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(-454.73007202148, 6001.9018554688, 31.340549468994), heading = 90.0, radius = 6.0 },
				}
			},
		},

		Watercraft = {
			{
				Spawner = vector3(-1612.68, 5262.28, 3.96), 
				ShopPoints = {
					{ coords = vector3(-1601.84, 5258.44, 0.4), heading = 24.28, radius = 6.0 },
				},
				SpawnPoints = {
					{ coords = vector3(-1601.84, 5258.44, 0.4), heading = 24.28, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-462.54537963868, 5994.44140625, 31.24575805664), 
				ShopPoints = {
					{ coords = vector3(-475.24044799804, 5988.4819335938, 31.3367061615), heading = 92.6, radius = 10.0 }
				},
				SpawnPoints = {
					{ coords = vector3(-475.24044799804, 5988.4819335938, 31.3367061615), heading = 92.6, radius = 10.0 }
				},
			}
		},

		EvidenceLockers = {},

		BossActions = {
			vector3(-445.32, 6013.64, 36.68),
		}

	}

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.GD_AuthorizedVehicles = {
	Shared = {},
	pconstable = {},
	constable = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },

	},
	sconstable = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
	},
	isconstable = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
	},
	lsconstable = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
	},
	sergeant = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
	},

	isergeant = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
	},

	ssergeant = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
	},

	inspector = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	cinspector = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	superintendent = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	csuperintendent = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	acommissioner = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	dcommissioner = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	},

	boss = {
		-- General Duties Vehicles
		{ model = 'pgd_vess', label = '[GD] Holden VESS Commodore', price = 0 },
		{ model = 'pgd_patrol', label = '[GD] Nissan Patrol (Offroad)', price = 0 },
		{ model = 'pgd_sub', label = '[GD] Subaru Levorg', price = 0 },
		{ model = 'pgd_1200rt', label = '[GD] BMW 1200RT (Motorcycle)', price = 0 },
		{ model = 'pgd_m5', label = '[GD] BMW M5', price = 0 },
		{ model = 'pgd_stinger', label = '[GD] Kia Stinger', price = 0 },
	}

}

Config.GD_AuthorizedHelicopters = {
	lsconstable = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },
	},
	sergeant = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	isergeant = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	ssergeant = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	inspector = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	cinspector = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	superintendent = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	csuperintendent = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	acommissioner = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	},
	dcommissioner = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },	
	},
	boss = {
		-- General Duties Helicopters
		{ model = 'pgd_as350', label = '[GD] AS350', price = 0 },
		{ model = 'pgd_bell412', label = '[GD] Bell-412', price = 0 },		
	}
}

Config.HWY_AuthorizedVehicles = {
	isconstable = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
	},

	lsconstable = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
	},

	sergeant = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
	},

	isergeant = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
	},

	ssergeant = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	inspector = {
		--- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	cinspector = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	superintendent = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	csuperintendent = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	acommissioner = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	dcommissioner = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	},

	boss = {
		-- Highway Patrol Vehicles
		{ model = 'phwy_vess', label = '[HWY] Holden VESS', price = 0 },
		{ model = 'phwy_m5', label = '[HWY] BMW M5', price = 0 },
		{ model = 'phwy_mustang', label = '[HWY] Ford Mustang (Pursuit)', price = 0 },

		-- Unmarked Police Vehicles
		{ model = 'pum_rav4', label = '[UM] Toyota RAV4', price = 0 },
		{ model = 'pum_vfss', label = '[UM] Holden VFSS', price = 0 },
		{ model = 'pum_focus', label = '[UM] Ford Focus', price = 0 },
		{ model = 'pum_wrx', label = '[UM] Subaru WRX', price = 0 },
		{ model = 'pum_raptor', label = '[UM] Ford Raptor (Offroad)', price = 0 },
		{ model = 'pum_ranger', label = '[UM] Ford Ranger (Offroad)', price = 0 },
	}
}

Config.SPG_AuthorizedVehicles = {
	lsconstable = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
	},

	sergeant = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	isergeant = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	ssergeant = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	inspector = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	cinspector = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	superintendent = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	csuperintendent = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	acommissioner = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	dcommissioner = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	},

	boss = {
		-- State Protection Group Vehicles
		{ model = 'pspg_ranger', label = '[SPG] Ford Ranger (Offroad)', price = 0 },
		{ model = 'pspg_bcat', label = '[SPG] Lenco Bearcat (Offroad)', price = 0 },
	}
}

Config.SPG_AuthorizedHelicopters = {
	sergeant = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
	},

	isergeant = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
	},

	ssergeant = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	inspector = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	cinspector = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	superintendent = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	csuperintendent = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	acommissioner = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	dcommissioner = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	},

	boss = {
		-- State Protection Group Helicopters
		{ model = 'pspg_as350', label = '[SPG] AS-350', price = 0 },
		{ model = 'pspg_aw139', label = '[SPG] AW-139', price = 0 },
	}

}

Config.AFP_AuthorizedVehicles = {
	Shared = {},
}

Config.Donator_AuthorizedVehicles = {
	inspector = {
		-- Victora Police Highway Vehicles
		-- { model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 119900 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	cinspector = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	superintendent = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	csuperintendent = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	acommissioner = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	dcommissioner = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	},

	boss = {
		-- Victora Police Highway Vehicles
		{ model = 'polhwy_passat', label = 'VHWY Volkswagon Passat', price = 0 },
		{ model = 'polhwy_vicbmw', label = 'VHWY BMW 530D', price = 0 },

		-- State Highway Patrol Vehicles
		{ model = 'polshp_bmw', label = 'SHP BMW 530D', price = 0 },
	}
}


Config.Donator_AuthorizedHelicopters = {
	lsconstable = {
		-- Donator Helicopters
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	sergeant = {
		-- Donator Helicopters
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	isergeant = {
		-- Donator Helicopters
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	ssergeant = {
		-- Donator Helicopters
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	inspector = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	cinspector = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	superintendent = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	csuperintendent = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	acommissioner = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	dcommissioner = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	},

	boss = {
		-- Donator Helicopters
		{ model = 'polspg_valkyrie', label = 'SPG Valkyrie', price = 0 },
		{ model = 'polshp_aw139', label = 'SHP AW-139', price = 0 },
	}

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

	shortsleeve_female = {
        female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		},
	},

	longsleeve_female = {
        female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['bproof_1'] = 34,  ['bproof_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},

	short_pconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		},

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},    

	short_constable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_sconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_isconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_lsconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_sergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_isergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},

	short_ssergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 7,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_inspector = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 8,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_cinspector = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_superintendent = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 10,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 

	short_csuperintendent = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 11,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},  

	short_acommissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 12,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},  

	short_dcommissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 13,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	},  

	short_commissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 12,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 192,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		}
	}, 
	
	long_pconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
		},

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},    

	long_constable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_sconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_isconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_lsconstable = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_sergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_isergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},

	long_ssergeant = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 7,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_inspector = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 8,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_cinspector = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_superintendent = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 10,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	}, 

	long_csuperintendent = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},  

	long_acommissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 12,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},  

	long_dcommissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 13,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},  

	long_commissioner = {
		male = {
            ['tshirt_1'] = 105,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 87,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        },

		female = {
            ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
            ['torso_1'] = 195,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 54,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
        }
	},

	formal_inspector = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 8,
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

	formal_cinspector = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 9,
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

	formal_superintendent = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 10,
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

	formal_csuperintendent = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
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

	formal_acommissioner = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] =  0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
        }
	},  

	formal_dcommissioner = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
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

	formal_commissioner = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 204,   ['torso_2'] = 11,
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

	polofficer_hat = {
		male = {
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		},

		female = {
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		}
	},

	poladmin_hat = {
		male = {
			['helmet_1'] = 46,  ['helmet_2'] = 0,
		}
	},

	shp_wear = {
		male = {
            ['tshirt_1'] = 87,  ['tshirt_2'] = 0,
            ['torso_1'] = 194,   ['torso_2'] = 13,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 35,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 10,  ['helmet_2'] = 1,
            ['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 25,  ['bproof_2'] = 2,
			['mask_1'] = 0, ['mask_2'] = 0
        }
	},

	polofficer_vest = {
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 2
		},

		female = {
			['bproof_1'] = 34,  ['bproof_2'] = 0
		},
	},

	polsgt_vest = {
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 1
		}
	},

	poladmin_vest = {
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 1
		}
	},

	polcabinet_vest = {
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 1
		}
	},

	polco_vest = {
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 0
		}
	},

	hwy_vest = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0
		}
	},

	-- State Protection Group
	spg_helmet = {
		male = {
			['helmet_1'] = 117,  ['helmet_2'] = 0,
		}
	},

	spg_gasmask = {
		male = {
			['mask_1'] = 46, ['mask_2'] = 0
		}
	},

	spg_light_wear = {
		male = {
            ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 93,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 30,
            ['pants_1'] = 59,   ['pants_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0
        }
	},

	spg_tactical_wear = {
		male = {
            ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
            ['torso_1'] = 223,   ['torso_2'] = 20,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 96,
            ['pants_1'] = 59,   ['pants_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 117,  ['helmet_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 52, ['mask_2'] = 0
        }
	},

	spg_vest = {
		male = {
			['bproof_1'] = 8,  ['bproof_2'] = 0
		}
	},
	
	spg_co_vest = {
		male = {
			['bproof_1'] = 9,  ['bproof_2'] = 0
		}
	},

	nswpf_softshelljacket = {
		male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 61,   ['torso_2'] = 0,
            ['arms'] = 1,
        }
	},
	
		-- Australian Federal Police
	afp_helmet = {
		male = {
			['helmet_1'] = 59,  ['helmet_2'] = 0,
		}
	},

	afp_light_wear = {
		male = {
            ['tshirt_1'] = 49,  ['tshirt_2'] = 0,
            ['torso_1'] = 228,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 30,
            ['pants_1'] = 87,   ['pants_2'] = 12,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0
        }
	},

	afp_tactical_wear = {
		male = {
            ['tshirt_1'] = 49,  ['tshirt_2'] = 0,
            ['torso_1'] = 224,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 17,
            ['pants_1'] = 87,   ['pants_2'] = 12,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 52, ['mask_2'] = 10
        }
	},

	afp_vest = {
		male = {
			['bproof_1'] = 17,  ['bproof_2'] = 0
		}
	},

	-- template_wear = {
	-- 		male = {
        --     	['tshirt_1'] = 105, ['tshirt_2'] = 0,
        --     	['torso_1'] = 194,  ['torso_2'] = 2,
        --     	['decals_1'] = 0,   ['decals_2'] = 0,
        --     	['arms'] = 0,
        --     	['pants_1'] = 87,   ['pants_2'] = 0,
		-- 		['shoes_1'] = 24,   ['shoes_2'] = 0,
		-- 		['mask_1'] = 0, 	['mask_2'] = 0,
        --     	['shoes_1'] = 24,   ['shoes_2'] = 0,
        --     	['chain_1'] = 1,    ['chain_2'] = 0,
        -- },

		-- 	female = {
        --     	['tshirt_1'] = 52,  ['tshirt_2'] = 0,
        --     	['torso_1'] = 192,  ['torso_2'] = 0,
        --     	['decals_1'] = 0,   ['decals_2'] = 0,
        --     	['arms'] = 0,
        --     	['pants_1'] = 54,   ['pants_2'] = 2,
        --     	['shoes_1'] = 24,   ['shoes_2'] = 0,
        --     	['mask_1'] = 0, 	['mask_2'] = 0,
        --     	['shoes_1'] = 24,   ['shoes_2'] = 0,
        --     	['chain_1'] = 1,    ['chain_2'] = 0,
		-- }
	-- },


}



Config.AuthorizedWatercraft = {
	isconstable = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
	},
	lsconstable = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
	},
	sergeant = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },		
	},
	isergeant = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },	
	},
	ssergeant = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },		
	},
	inspector = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },	
	},
	cinspector = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },	
	},
	superintendent = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },		
	},
	csuperintendent = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },		
	},
	acommissioner = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },	
	},
	dcommissioner = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },
	},
	boss = {
		-- General Duties Watercraft
		{ model = 'pgd_boat', label = 'GD Watercraft #1', price = 0 },
		{ model = 'pgd_boat2', label = 'GD Watercraft #2', price = 0 },		
	}
}