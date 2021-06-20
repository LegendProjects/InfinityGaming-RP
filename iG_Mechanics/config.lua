
Config = {}

Config.DrawDistance = 25.0
Config.Locale = 'en'
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 34, g = 166, b = 240 }
Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }
Config.DeleteMarker = {Type = 1, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.5} -- Red Color / Big Size Circle.

Config.Mechanics = {

	SAR = {
		Job_Auth = 'sar',

		Blip = {
			Name = "Mechanic: Solntservo Auto Repairs",
			Coords  = vector3(732.84, -1079.31, 22.17),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 76,
			
		},

		Cloakroom = {
			vector3(725.38, -1078.71, 22.17),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(721.69, -1084.48, 22.22),
				StorePoint = vector3(716.57, -1083.44, 21.40),
				ShopPoints = {
					{ coords = vector3(716.57, -1083.44, 22.31), heading = 4.36, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(716.57, -1083.44, 22.31), heading = 4.36, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(728.21, -1065.96, 28.31)
		},

		StorageDepot = {
			vector3(729, -1064.49, 22.17)
		},
	},

	SAR2 = {
		Job_Auth = 'sar',

		Blip = {
			Name = "Mechanic: Solntservo Auto Repairs",
			Coords  = vector3(-1424.52, -441.68, 35.88),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 76,
			
		},

		Cloakroom = {
			vector3(-1425.11, -457.01, 35.91),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(-1432.31, -445.2, 35.66),
				StorePoint = vector3(-1428.58, -441.97, 34.90),
				ShopPoints = {
					{ coords = vector3(-1428.58, -441.97, 34.90), heading = 37.01, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(-1428.58, -441.97, 34.90), heading = 37.01, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(-1428.12, -458.15, 35.91),
		},

		StorageDepot = {
			vector3(-1410.25, -447.94, 35.91),
		},
	},

	DragonsJDM = {
		Job_Auth = 'dragonsjdm',

		Blip = {
			Name = "Mechanic: Benny\'s Original Motorworks",
			Coords  = vector3(-205.48, -1310.44, 31.28),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 69
		},

		Cloakroom = {
			vector3(-206.6, -1331.4, 34.88),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(-195.48, -1308.32, 31.28),
				StorePoint = vector3(-195.12, -1305.0, 30.50),
				ShopPoints = {
					{ coords = vector3(-195.12, -1305.0, 31.36), heading = 89.0, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(-195.12, -1305.0, 31.36), heading = 89.0, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(-206.56, -1341.68, 34.88),
		},

		StorageDepot = {
			vector3(-224.24, -1319.92, 30.88),
		},
	},

	SinsGarage = {
		Job_Auth = 'sinsgarage',

		Blip = {
			Name = "Mechanic: Sin\'s Garage",
			Coords  = vector3(1178.32, 2646.36, 37.8),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 81
		},

		Cloakroom = {
			vector3(1171.28, 2637.64, 37.96),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(1198.12, 2639.6, 37.84),
				StorePoint = vector3(1202.96, 2646.01, 36.95),
				ShopPoints = {
					{ coords = vector3(1203.36, 2639.48, 37.84), heading = 313.0, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(1202.96, 2646.01, 36.95), heading = 48.58, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(1186.76, 2637.32, 38.4),
		},

		StorageDepot = {
			vector3(1172.32, 2636.46, 37.79),
		},
	},


	Beekers = {
		Job_Auth = 'beekers',

		Blip = {
			Name = "Mechanic: Beeker's Garage & Parts",
			Coords  = vector3(112.36, 6619.8, 31.8),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 25
		},

		Cloakroom = {
			vector3(111.36, 6631.12, 31.8),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(110.64, 6602.04, 31.92),
				StorePoint = vector3(118.48, 6599.36, 31.10),
				ShopPoints = {
					{ coords = vector3(118.48, 6599.36, 32.0), heading = 271.4, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(118.48, 6599.36, 32.0), heading = 271.4, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(100.24, 6620.44, 32.44),
		},

		StorageDepot = {
			vector3(108.44, 6631.08, 31.8),
		},
	},

	Harwick = {
		Job_Auth = 'harwick',

		Blip = {
			Name = "Mechanic: Harwick Towing Company",
			Coords  = vector3(-191.4, -1160.52, 23.68),
			Sprite  = 643,
			Display = 4,
			Scale   = 0.7,
			Colour  = 60
		},

		Cloakroom = {
			vector3(-192.2, -1166.32, 23.68),
			Size = { x = 1.0, y = 1.0, z = 1.0 },
			Type = 20
		},

		Vehicles = {
			{
				Spawner = vector3(-181.16, -1167.72, 23.16),
				StorePoint = vector3(-178.0, -1167.92, 23.04-0.9),
				ShopPoints = {
					{ coords = vector3(-178.0, -1167.92, 23.04), heading = 177.24, radius = 6.0 }
				},
				SpawnPoints = {
					{ coords = vector3(-178.0, -1167.92, 23.04), heading = 177.24, radius = 6.0 }
				}
			}
		},

		BossActions = {
			vector3(-185.56, -1165.2, 23.68),
		},

		StorageDepot = {
			vector3(-194.44, -1164.68, 23.68),
		},
	},
	

}
-- for i=1, #Config.Towables, 1 do
-- 	Config.Zones['Towable' .. i] = {
-- 		Pos   = Config.Towables[i],
-- 		Size  = { x = 1.5, y = 1.5, z = 1.0 },
-- 		Color = { r = 204, g = 204, b = 0 },
-- 		Type  = -1
-- 	}
-- end

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo'
}


Config.Uniforms = {
	
	sar_tow = {
        male = {
           ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 158,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 1,
            ['arms'] = 26,
            ['pants_1'] = 33,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
        }
    }, 

    sar_apprentice = {
       male = {
           ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 158,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 1,
            ['arms'] = 26,
            ['pants_1'] = 33,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
        }
	},

	sar_mechanic = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
		 }
	}, 

	sar_seniormechanic = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
		 }
	},

	sar_headmechanic = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
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

	sar_floormanager = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
		 }
	},

	sar_coowner = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
		 }
	}, 
	
	boss = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			 ['torso_1'] = 158,   ['torso_2'] = 6,
			 ['decals_1'] = 0,   ['decals_2'] = 1,
			 ['arms'] = 26,
			 ['pants_1'] = 33,   ['pants_2'] = 0,
			 ['shoes_1'] = 25,   ['shoes_2'] = 0,
			 ['helmet_1'] = -1,  ['helmet_2'] = 0,
			 ['chain_1'] = 0,    ['chain_2'] = 0,
		 }
	}
}

Config.AuthorizedVehicles = {
    Shared = {
		{ model = 'polarf250f', label = 'Ford F350 Superduty', price = 52500 },
		{ model = 'polarf250u', label = 'Ford F350 Superduty (Utility)', price = 52500 },
		{ model = 'flatbedm2', label = 'Freightliner Flatbed', price = 95650 },
		{ model = 'hdwrecker', label = 'Heavy-Loader Towtruck', price = 108650 },
		{ model = 'towpeter', label = 'Flatbed Towtruck', price = 128650 },
	}
}




Config.Towables = {
	{ ['x'] = -2480.8720703125, ['y'] = -211.96409606934, ['z'] = 17.397672653198 },
	{ ['x'] = -2723.392578125, ['y'] = 13.207388877869, ['z'] = 15.12806892395 },
	{ ['x'] = -3169.6235351563, ['y'] = 976.18127441406, ['z'] = 15.038360595703 },
	{ ['x'] = -3139.7568359375, ['y'] = 1078.7182617188, ['z'] = 20.189767837524 },
	{ ['x'] = -1656.9357910156, ['y'] = -246.16479492188, ['z'] = 54.510955810547 },
	{ ['x'] = -1586.6560058594, ['y'] = -647.56115722656, ['z'] = 29.441320419312 },
	{ ['x'] = -1036.1470947266, ['y'] = -491.05856323242, ['z'] = 36.214912414551 },
	{ ['x'] = -1029.1884765625, ['y'] = -475.53167724609, ['z'] = 36.416831970215 },
	{ ['x'] = 75.212287902832, ['y'] = 164.8522644043, ['z'] = 104.69123077393 },
	{ ['x'] = -534.60491943359, ['y'] = -756.71801757813, ['z'] = 31.599143981934 },
	{ ['x'] = 487.24212646484, ['y'] = -30.827201843262, ['z'] = 88.856712341309 },
	{ ['x'] = -772.20111083984, ['y'] = -1281.8114013672, ['z'] = 4.5642876625061 },
	{ ['x'] = -663.84173583984, ['y'] = -1206.9936523438, ['z'] = 10.171216011047 },
	{ ['x'] = 719.12451171875, ['y'] = -767.77545166016, ['z'] = 24.892364501953 },
	{ ['x'] = -970.95465087891, ['y'] = -2410.4453125, ['z'] = 13.344270706177 },
	{ ['x'] = -1067.5234375, ['y'] = -2571.4064941406, ['z'] = 13.211874008179 },
	{ ['x'] = -619.23968505859, ['y'] = -2207.2927246094, ['z'] = 5.5659561157227 },
	{ ['x'] = 1192.0831298828, ['y'] = -1336.9086914063, ['z'] = 35.106426239014 },
	{ ['x'] = -432.81033325195, ['y'] = -2166.0505371094, ['z'] = 9.8885231018066 },
	{ ['x'] = -451.82403564453, ['y'] = -2269.34765625, ['z'] = 7.1719741821289 },
	{ ['x'] = 939.26702880859, ['y'] = -2197.5390625, ['z'] = 30.546691894531 },
	{ ['x'] = -556.11486816406, ['y'] = -1794.7312011719, ['z'] = 22.043060302734 },
	{ ['x'] = 591.73504638672, ['y'] = -2628.2197265625, ['z'] = 5.5735430717468 },
	{ ['x'] = 1654.515625, ['y'] = -2535.8325195313, ['z'] = 74.491394042969 },
	{ ['x'] = 1642.6146240234, ['y'] = -2413.3159179688, ['z'] = 93.139915466309 },
	{ ['x'] = 1371.3223876953, ['y'] = -2549.525390625, ['z'] = 47.575256347656 },
	{ ['x'] = 383.83779907227, ['y'] = -1652.8695068359, ['z'] = 37.278503417969 },
	{ ['x'] = 27.219129562378, ['y'] = -1030.8818359375, ['z'] = 29.414621353149 },
	{ ['x'] = 229.26435852051, ['y'] = -365.91101074219, ['z'] = 43.750762939453 },
	{ ['x'] = -85.809432983398, ['y'] = -51.665500640869, ['z'] = 61.10591506958 },
	{ ['x'] = -4.5967531204224, ['y'] = -670.27124023438, ['z'] = 31.85863494873 },
	{ ['x'] = -111.89884185791, ['y'] = 91.96940612793, ['z'] = 71.080169677734 },
	{ ['x'] = -314.26129150391, ['y'] = -698.23309326172, ['z'] = 32.545776367188 },
	{ ['x'] = -366.90979003906, ['y'] = 115.53963470459, ['z'] = 65.575706481934 },
	{ ['x'] = -592.06726074219, ['y'] = 138.20733642578, ['z'] = 60.074813842773 },
	{ ['x'] = -1613.8572998047, ['y'] = 18.759860992432, ['z'] = 61.799819946289 },
	{ ['x'] = -1709.7995605469, ['y'] = 55.105819702148, ['z'] = 65.706237792969 },
	{ ['x'] = -521.88830566406, ['y'] = -266.7805480957, ['z'] = 34.940990447998 },
	{ ['x'] = -451.08666992188, ['y'] = -333.52026367188, ['z'] = 34.021533966064 },
	{ ['x'] = 322.36480712891, ['y'] = -1900.4990234375, ['z'] = 25.773607254028 }
}


