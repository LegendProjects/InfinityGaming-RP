Config = {}

Config.Bratva = {
    Bunker = {
        -- Cameras = {
        --     vector3(419.48, 4815.48, -59.0)
        -- },

        Storage = {
            vector3(420.44, 4809.28, -59.0),
            vector3(417.28, 4809.44, -59.0),
            vector3(474.56, 4770.12, -59.0),
            vector3(373.88, 4823.04, -59.0)
        }
    }
}

Config.Teleports = {
	["ServerEnterance"] = { 
		["coords"] = vector3(369.36, 4851.92, -59.0),
        ["radius"] = 5.0,
		["goto"] = { 
			"ServerExit"
		} 
    },

    ["ServerExit"] = { 
		["coords"] = vector3(2154.76, 2921.12, -81.08),
        ["radius"] = 5.0,
		["goto"] = { 
			"ServerEnterance"
		} 
    },

    ["HeliExterior"] = { 
		["coords"] = vector3(3406.84, 5504.68, 27.28),
        ["radius"] = 25.0,
		["goto"] = { 
			"HeliInterior"
		} 
    },

    ["HeliInterior"] = { 
		["coords"] = vector3(482.4, 4812.8, -58.4),
        ["radius"] = 25.0,
		["goto"] = { 
			"HeliExterior"
		} 
    },
}
