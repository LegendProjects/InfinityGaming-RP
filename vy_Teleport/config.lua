Config = {}
Config.Teleports = {

    --=================================--
    --==========[  CASINO  ]===========--
    --=================================--
	-- ["Cashier Desk"] = { 
	-- 	["x"] = 982.43, 
	-- 	["y"] = 38.27, 
	-- 	["z"] = 74.88, 
	-- 	["h"] = 51.11, 
	-- 	["goto"] = { 
	-- 		"Leave Cashier Desk" 
	-- 	} 
	-- },
    -- ["Leave Cashier Desk"] = { 
	-- 	["x"] = 978.76, 
	-- 	["y"] = 32.18, 
	-- 	["z"] = 74.88, 
	-- 	["h"] = 56.19, 
	-- 	["goto"] = { 
	-- 		"Cashier Desk" 
	-- 	} 
    -- },
    -- ["to the Casino Roof"] = { 
	-- 	["x"] = 964.70, 
	-- 	["y"] = 58.72, 
	-- 	["z"] = 112.55, 
	-- 	["h"] = 55.00, 
	-- 	["goto"] = { 
	-- 		"to the Casino Reception" 
	-- 	} 
    -- },
    -- ["to the Casino Reception"] = { 
	-- 	["x"] = 948.11, 
	-- 	["y"] = 50.87, 
	-- 	["z"] = 75.11, 
	-- 	["h"] = 280.00, 
	-- 	["goto"] = { 
	-- 		"to the Casino Roof" 
	-- 	} 
    -- },
    -- ["to the Helipad"] = { 
	-- 	["x"] = 1004.76,
	-- 	["y"] = 77.512,
	-- 	["z"] = 73.27, 
	-- 	["h"] = 225.00, 
	-- 	["goto"] = { 
	-- 		"to the Casino Floor" 
	-- 	} 
    -- },
    -- ["to the Casino Floor"] = { 
	-- 	["x"] = 971.70,
	-- 	["y"] = 51.54,
	-- 	["z"] = 120.24, 
	-- 	["h"] = 145.00, 
	-- 	["goto"] = { 
	-- 		"to the Helipad" 
	-- 	} 
    -- },
    -- ["to the Penthouse"] = { 
	-- 	["x"] = 969.26,
	-- 	["y"] = 63.38,
	-- 	["z"] = 112.55, 
	-- 	["h"] = 145.00, 
	-- 	["goto"] = { 
	-- 		"to the Balcony" 
	-- 	} 
    -- },
    -- ["to the Balcony"] = { 
	-- 	["x"] = 968.04,
	-- 	["y"] = 63.47,
	-- 	["z"] = 112.55, 
	-- 	["h"] = 145.00, 
	-- 	["goto"] = { 
	-- 		"to the Penthouse" 
	-- 	} 
    -- },

    --==========================================--
    --==========[  WEED PROCESSING  ]===========--
    --==========================================--
    -- ["to the Drying Room"] = { 
	-- 	["x"] = 94.95,
	-- 	["y"] = -1810.20,
	-- 	["z"] = 27.08, 
	-- 	["h"] = 145.0, 
	-- 	["goto"] = { 
	-- 		"to leave the Drying Room" 
	-- 	} 
    -- },
    -- ["to leave the Drying Room"] = { 
	-- 	["x"] = 1066.23,
	-- 	["y"] = -3183.37,
	-- 	["z"] = -39.16, 
	-- 	["h"] = 145.0, 
	-- 	["goto"] = { 
	-- 		"to the Drying Room" 
	-- 	} 
    -- },

    --===========================================--
    --==========[  UNION DEPOSITORY  ]===========--
    --===========================================--
    ["to the vault"] = { 
		["x"] = 10.34,
		["y"] = -671.13,
		["z"] = 33.44, 
		["h"] = 145.0, 
		["goto"] = { 
			"to the surface" 
		} 
    },
    ["to the surface"] = { 
		["x"] = -0.20,
		["y"] = -706.35,
		["z"] = 16.13, 
		["h"] = 145.0, 
		["goto"] = { 
			"to the vault" 
		} 
    },
    
    --==========================================--
    --==========[ PILLBOX HOSPITAL  ]===========--
    --==========================================--
    ["Pillbox Hospital - Main Floor"] = { 
		["x"] = 332.4, ["y"] = -595.72, ["z"] = 43.28,
		["h"] = 70.16, 
		["goto"] = { 
			"Pillbox Hospital - Helipad",
			"Pillbox Hospital - Garage",
			"Pillbox Hospital - Lower Floor"

		} 
    },

    ["Pillbox Hospital - Helipad"] = { 
		["x"] = 338.52, ["y"] = -583.8, ["z"] = 74.16, 
		["h"] = 145.0, 
		["goto"] = { 
			"Pillbox Hospital - Main Floor",
			"Pillbox Hospital - Garage",
			"Pillbox Hospital - Lower Floor"
		} 
	},
	
	["Pillbox Hospital - Garage"] = { 
		["x"] = 340.12, ["y"] = -584.72, ["z"] = 28.8,
		["h"] = 145.0, 
		["goto"] = { 
			"Pillbox Hospital - Main Floor",
			"Pillbox Hospital - Helipad"
		} 
	},

	["Pillbox Hospital - Lower Floor"] = { 
		["x"] = 344.3, ["y"] = -586.24, ["z"] = 28.8,
		["h"] = 246.12, 
		["goto"] = { 
			"Pillbox Hospital - Main Floor",
			"Pillbox Hospital - Helipad",
		} 
    },

	--===========================================--
	--==========[  FIB BUILDING   ]===========--
	--===========================================--
	["FIB Entrance"] = {
		["x"] = 138.96,
		["y"] = -762.72,
		["z"] = 45.76,
		["h"] = 145.0,
		["goto"] = {
			"FIB Offices",
			"FIB Garage"
		}
	},

	["FIB Offices"] = {
		["x"] = 136.08,
		["y"] = -761.84,
		["z"] = 242.16,
		["h"] = 161.72,
		["goto"] = {
			"FIB Entrance",
			"FIB Garage"
		}
	},

	["FIB Garage"] = {
		["x"] = 122.12,
		["y"] = -740.92,
		["z"] = 33.12,
		["h"] = 161.72,
		["goto"] = {
			"FIB Entrance",
			"FIB Offices"
		}
	},

	--==========================================--
    --==========[ AQUARIUS  ]===========--
    --==========================================--
    ["Aquarius - Rear Door (Exterior)"] = { 
		["x"] = -2313.22,
		["y"] = -658.31,
		["z"] = 7.40, 
		["h"] = 145.0, 
		["goto"] = { 
			"Aquarius - Rear Door (Interior)",
			"Aquarius - Captain's Deck",
			"Aquarius - Engine Room"
		} 
	},

	["Aquarius - Rear Door (Interior)"] = { 
		["x"] = -2336.64,
		["y"] = -658.67,
		["z"] = 7.46, 
		["h"] = 145.0, 
		["goto"] = { 
			"Aquarius - Rear Door (Exterior)" 
		} 
	},
	
	["Aquarius - Captain's Deck"] = { 
		["x"] = -2356.86,
		["y"] = -658.52,
		["z"] = 13.86, 
		["h"] = 145.0, 
		["goto"] = { 
			"Aquarius - Rear Door (Exterior)" 
		} 
	},

	["Aquarius - Engine Room"] = { 
		["x"] = -2350.68,
		["y"] = -654.84,
		["z"] = 4.64, 
		["h"] = 93.19,
		["goto"] = { 
			"Aquarius - Rear Door (Exterior)" 
		} 
	},

	--==========================================--
	--==========[ CASINO ]===========--
    --==========================================--
    -- ["Casino - Entrance (Exterior)"] = { 
	-- 	["x"] = 924.4,
	-- 	["y"] = 46.8,
	-- 	["z"] = 81.12, 
	-- 	["h"] = 240.48, 
	-- 	["goto"] = { 
	-- 		"Casino - Entrance (Interior)"
	-- 	} 
	-- },

	-- ["Casino - Entrance (Interior)"] = { 
	-- 	["x"] = 2468.88,
	-- 	["y"] = -287.44,
	-- 	["z"] = -58.28, 
	-- 	["h"] = 354.88, 
	-- 	["goto"] = { 
	-- 		"Casino - Entrance (Exterior)" 
	-- 	} 
	-- },

	--==========================================--
	--==========[ Vanilla Unicorn ]===========--
    --==========================================--
    -- ["Vanilla Unicorn - Entrance"] = { 
	-- 	["x"] = 133.2,
	-- 	["y"] = -1293.64,
	-- 	["z"] = 29.28, 
	-- 	["h"] = 240.48, 
	-- 	["goto"] = { 
	-- 		"Vanilla Unicorn - Behind Bar"
	-- 	} 
	-- },

	-- ["Vanilla Unicorn - Behind Bar"] = { 
	-- 	["x"] = 132.48,
	-- 	["y"] = -1287.4,
	-- 	["z"] = 29.28, 
	-- 	["h"] = 354.88, 
	-- 	["goto"] = { 
	-- 		"Vanilla Unicorn - Entrance" 
	-- 	} 
	-- },

	--==========================================--
    --==========[ CENTRAL LOS SANTOS HOSPITAL  ]===========--
    --==========================================--
    -- ["CLSBridge"] = { 
	-- 	["x"] = 402.64,
	-- 	["y"] = -1351.92,
	-- 	["z"] = 39.76, 
	-- 	["h"] = 145.0, 
	-- 	["goto"] = { 
	-- 		"CLSCarpark" 
	-- 	} 
	-- },
	-- ["CLSCarpark"] = { 
	-- 	["x"] = 406.44,
	-- 	["y"] = -1347.96,
	-- 	["z"] = 41.04, 
	-- 	["h"] = 145.0, 
	-- 	["goto"] = { 
	-- 		"CLSBridge" 
	-- 	} 
	-- },
	

	--==========================================--
    --==========[ DRUG LOCATION TELEPORTS  ]===========--
    --==========================================--
	["Humane Elevator (Top)"] = { 
		["x"] = 3540.68,
		["y"] = 3675.6,
		["z"] = 28.12, 
		["h"] = 145.0, 
		["goto"] = { 
			"Humane Elevator (Bottom)"
		} 
	},

	["Humane Elevator (Bottom)"] = { 
		["x"] = 3540.68,
		["y"] = 3675.6,
		["z"] = 21.0,
		["h"] = 145.0, 
		["goto"] = { 
			"Humane Elevator (Top)"
		} 
	},
    ["Cocaine (Exterior)"] = { 
		["x"] = 836.84,
		["y"] = -2292.84,
		["z"] = 30.52, 
		["h"] = 145.0, 
		["goto"] = { 
			"Cocaine (Interior)"
		} 
	},

	["Cocaine (Interior)"] = { 
		["x"] = 1088.72,
		["y"] = -3187.52,
		["z"] = -39.0, 
		["h"] = 145.0, 
		["goto"] = { 
			"Cocaine (Exterior)"
		} 
	},

	["LSD (Exterior)"] = { 
		["x"] = 232.44,
		["y"] = -1361.12,
		["z"] = 28.64, 
		["h"] = 145.0, 
		["goto"] = { 
			"LSD (Interior)"
		} 
	},

	["LSD (Interior)"] = { 
		["x"] = 234.56,
		["y"] = -1373.72,
		["z"] = 22.0, 
		["h"] = 145.0, 
		["goto"] = { 
			"LSD (Exterior)"
		} 
	},

	["Meth (Exterior)"] = { 
		["x"] = -91.6,
		["y"] = 6514.68,
		["z"] = 32.12, 
		["h"] = 145.0, 
		["goto"] = { 
			"Meth (Interior)"
		} 
	},

	["Meth (Interior)"] = { 
		["x"] = 996.8,
		["y"] = -3200.64,
		["z"] = -36.4, 
		["h"] = 145.0, 
		["goto"] = { 
			"Meth (Exterior)"
		} 
	},

	["Casino Elevator (Top)"] = { 
		["x"] = 964.96,
		["y"] = 58.52,
		["z"] = 112.56, 
		["h"] = 145.0, 
		["goto"] = { 
			"Casino Elevator (Bottom)"
		} 
	},

	["Casino Elevator (Bottom)"] = { 
		["x"] = 977.6,
		["y"] = 74.0,
		["z"] = 70.24,
		["h"] = 145.0, 
		["goto"] = { 
			"Casino Elevator (Top)"
		} 
	},






	-- Bahama Mamas
	["Bahama Mamas (Bar1)"] = { 
		["x"] = -1381.34,
		["y"] = -632.18,
		["z"] = 30.82, 
		["h"] = 145.0, 
		["goto"] = { 
			"Bahama Mamas (Bar2)"
		} 
	},

	["Bahama Mamas (Bar2)"] = { 
		["x"] = -1379.99,
		["y"] = -631.33,
		["z"] = 30.82, 
		["h"] = 145.0, 
		["goto"] = { 
			"Bahama Mamas (Bar1)"
		} 
	},

	["Bahama Mamas (Bar3)"] = { 
		["x"] = -1387.23,
		["y"] = -609.21,
		["z"] = 30.32, 
		["h"] = 145.0, 
		["goto"] = { 
			"Bahama Mamas (Bar4)"
		} 
	},

	["Bahama Mamas (Bar4)"] = { 
		["x"] = -1388.96,
		["y"] = -610.72,
		["z"] = 30.32, 
		["h"] = 145.0, 
		["goto"] = { 
			"Bahama Mamas (Bar3)"
		} 
	},

}