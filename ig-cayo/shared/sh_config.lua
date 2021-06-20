Config = {}

Config.Debug = false

Config.Blips = {

    Marker = {
        Title = "Minigame: Cayo Perico",
        Coords = {x = 4700.0, y = -5145.0, z = 1.0},
        Sprite = 388,
        Colour = 0
    },
    
    Lounge = {
        Title = "Minigame: Cayo Perico",
        Coords = {x = 5005.16, y = -5750.44, z = 28.68},
        Sprite = 162,
        Colour = 0
    },

    Zone = {
        Coords = {x = 4700.0, y = -5145.0, z = 1.0},
        Radius = 1450.0,
        Sprite = 9,
        Colour = 1
    }

}



Config.Scavengers = {
   
    Models = {
        'a_m_m_hillbilly_02',
        'a_m_m_rurmeth_01',
        'a_m_o_salton_01',
        'a_m_y_salton_01',
        'cs_clay',
        'cs_hunter',
        'cs_josef',
        'cs_russiandrunk',
        'cs_terry',
        'csb_cletus',
        'csb_hao',
        'csb_ramp_hic',
        'csb_ramp_mex',
        'g_f_y_vagos_01',
        'g_m_y_lost_01',
        'g_m_y_lost_03',
        'g_m_y_mexgang_01'
    },

    Weapons = {
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_GUSENBERG',
        'WEAPON_DBSHOTGUN',
        'WEAPON_MICROSMG',
        'WEAPON_MACHINEPISTOL'
    },

    Loot = {

    }

}

Config.MastersLounge = { 
    Door = {
        objHeading = 238.17016601563,
        objCoords = vector3(5006.242, -5750.411, 29.04091),
        objHash = -607013269,
        locked = true,
    },
    NPC = {
        [1] = { 
            ["myPedsLocation"] = {
                ["x"] = 5011.96, ["y"] = -5758.16, ["z"] =  28.84, ["h"] = 44.6, -- Pillbox Desk
                ["hash"] = "s_m_m_doctor_01",
                ["anim_dict"] = "anim@amb@nightclub@peds@",
                ["anim_action"] = "amb_world_human_cheering_female_c"
            },
        },
    }
}

Config.Merchants = {
    Merchant_1 = {
        Coords = {x = 4961.84, y = -5108.12, z = 3.0},
        Heading = 151
    },
}

Config.SlayerMaster = vector3(3310.92, 5176.28, 19.6)
Config.FishingLocations = {
    SolitarioCove = {
        Name = 'Fishing: Solitario Cove',
        Coords = vector3(4763.0, -4781.64, 0.8),
        AreaSize = 10.0,
        Fish = {
            'anglerfish'
        }
    }
}



Config.Looting ={
    Fuel = {
        objHash = -1075526692,
        lootTime = 12,
        itemChance = 100,
        maxQuantity = 1,
        itemTable = {
            'WEAPON_PETROLCAN',
        }
    }
}


Config.Herblore = {

    -- Meth


    -- Heroin
    

    -- Cocaine
    Mixed_Cocaine = {},
    Bricked_Cocaine = {},

    -- Weed
    Weed_Drying = {},

}

Config.Farming = {

    -- Cocaine
    Coca_Harveting = {},

    -- Weed
    Weed_Harvesting = {}
,
}