Config = {}
-- ESX or not
Config.use_esx = true

-- Command or ( Automatic / Keybind = False )
Config.use_command = true


-- If above is true, set job names here (to add more see above)
Config.job_1 = "police"
Config.job_2 = "ambulance"
-- Config.job_3 = ( Needs to be coded in. INSTRUCTIONS ON LINE 24+ )
-- Config.job_4 = ( Needs to be coded in. INSTRUCTIONS ON LINE 24+ )

-- Update Frequency for Automatic Bag Spawn
Config.freq_bag_on = 1000

-- Update Frequency for Automatic Bag De-Spawn (Player Revived / Respawned)
Config.freq_bag_off = 1000



Config.TackleDistance				= 2.5

---------------------------------------------------------------------------
-- Ped Configs --
---------------------------------------------------------------------------
SpikeConfig = {}
SpikeConfig.PedRestriction = false
SpikeConfig.PedList = {
    "s_m_y_cop_01"
}

---------------------------------------------------------------------------
-- Identifier Configs --
---------------------------------------------------------------------------
SpikeConfig.IdentifierRestriction = false
SpikeConfig.Identifier = "steam" -- [[ license, steam, ip ]] --
SpikeConfig.IdentifierList = { -- [[ YOU MUST ONLY USE !!! ONE !!! IDENTIFIER YOU CAN CHOOSE BETWEEN THE THREE ABOVE ]]--
    "license:c06fbf1faaf995c7b9e207ef77712971a3ed4dc3",
    "steam:1100001081f9ab0",
    "ip:127.0.0.1"
}

---------------------------------------------------------------------------
-- Spikestrips Configs --
---------------------------------------------------------------------------
SpikeConfig.MaxSpikes = 2