Config = {}
Config.Debug = false
Config.PoliceRequired = 2
Config.SafeLoot  = {
   { Item = 'usb_green', Max = 1,  Chance = 50 },
   { Item = 'keycard_green', Max = 1,  Chance = 100 },
   { Item = 'laptop_h', Max = 1, Chance = 100 },
   { Item = 'cuff_keys', Max = 2,  Chance = 150 },
   { Item = 'smirnoff', Max = 1,  Chance = 150 },
}

Config.Stores = {

    { -- 24/7 Behind Legion
        Coords = vector3(29.4, -1345.0, 29.48),
        CashRegisters = {
            {
                Coords = vector4(24.94, -1347.28, 29.61, 270.0),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(24.94, -1344.95, 29.61, 270.0),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(33.19, -1348.80, 28.49, 179.99),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(28.19, -1338.55, 28.48, 0.0),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- Grove Street Gas Station
        Coords = vector3(-51.2, -1753.64, 29.44),
        CashRegisters = {
            {
                Coords = vector4(-48.50, -1759.22, 29.53, 49.98),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(-47.19, -1757.67, 29.53, 49.98),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(-57.40, -1751.74, 28.42, 49.98),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(-43.92, -1748.08, 28.42, 50.09),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 behind pacific standard
        Coords = vector3(377.76, 326.6, 103.56),
        CashRegisters = {
            {
                Coords = vector4(373.02, 326.32, 103.68, 255.88),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(373.59, 328.58, 103.68, 255.88),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(380.65, 322.84, 102.56, 165.88),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(378.28, 334.04, 102.56, 345.88),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 east highway
        Coords = vector3(2555.56, 385.8, 108.64),
        CashRegisters = {
            {
                Coords = vector4(2557.20, 381.29, 108.73, 357.71),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(2554.87, 381.38, 108.73, 357.71),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(2559.05, 389.47, 107.62, 267.71),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(2548.68, 384.88, 107.62, 87.71),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 West Great Ocean Below Other
        Coords = vector3(-3041.96, 588.36, 7.92),
        CashRegisters = {
            {
                Coords = vector4(-3039.13, 584.97, 8.02, 17.75),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(-3041.35, 584.26, 8.02, 17.75),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(-3040.20, 593.29, 6.90, 287.75),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(-3048.48, 585.4, 6.90, 107.75),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 West Great Ocean Above Other
        Coords = vector3(-3243.4, 1004.88, 12.84),
        CashRegisters = {
            {
                Coords = vector4(-3242.24, 1000.45, 12.94, 355.07),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(-3244.57, 1000.65, 12.94, 355.07),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(-3240.02, 1008.54, 11.83, 265.07),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(-3250.67, 1004.46, 11.83, 85.07),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 Route 68
        Coords = vector3(544.4, 2668.28, 42.16),
        CashRegisters = {
            {
                Coords = vector4(548.59, 2671.25, 42.27, 97.49),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(548.90, 2668.94, 42.27, 97.49),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(540.22, 2671.68, 41.15, 7.49),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(546.51, 2662.18, 41.15, 187.49),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 Sandy Shores
        Coords = vector3(1963.68, 3744.16, 32.36),
        CashRegisters = {
            {
                Coords = vector4(1960.49, 3740.26, 32.45, 300.0),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(1959.32, 3742.29, 32.45, 300.0),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(1968.39, 3743.07, 31.34, 210.0),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(1958.96, 3749.44, 31.34, 29.99),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 Senora FWY
        Coords = vector3(2678.28, 3285.12, 55.24),
        CashRegisters = {
            {
                Coords = vector4(2678.25, 3279.83, 55.35, 330.87),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(2676.21, 3280.96, 55.35, 330.87),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(2683.59, 3286.3, 54.24, 240.87),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(2672.21, 3286.91, 54.24, 60.87),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- 24/7 East of Paleto
        Coords = vector3(1733.52, 6414.96, 35.04),
        CashRegisters = {
            {
                Coords = vector4(1728.29, 6415.03, 35.15, 243.64),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(1729.32, 6417.12, 35.15, 243.64),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(1735.01, 6410.01, 34.03, 153.64),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(1735.08, 6421.44, 34.03, 333.64),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- Mirror Park Gas Station
        Coords = vector3(1159.04, -323.44, 69.2),
        CashRegisters = {
            {
                Coords = vector4(1164.56, -324.89, 69.31, 100.0),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(1164.20, -322.89, 69.31, 100.0),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(1153.11, -326.90, 68.20, 100.00),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(1158.92, -314.13, 68.20, 100.00),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- Little Seoul Gas Station
        Coords = vector3(-712.4, -913.12, 19.2),
        CashRegisters = {
            {
                Coords = vector4(-706.63, -915.72, 19.32, 90.0),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(-706.63, -913.68, 19.32, 90.0),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(-718.26, -915.71, 18.21, 90.0),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(-710.36, -904.16, 18.21, 90.0),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- Richman Glen Gas Station
        Coords = vector3(-1825.4, 790.48, 138.2),
        CashRegisters = {
            {
                Coords = vector4(-1819.09, 792.31, 138.20, 132.46),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(-1820.46, 793.81, 138.21, 132.46),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(-1827.68, 784.46, 137.31, 132.46),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(-1829.55, 798.40, 137.31, 132.46),
            Cooldown = 0,
            Robbed = false
        }
        
    },

    {  -- Grapeseed Gas Station
        Coords = vector3(1701.84, 4927.56, 42.08),
        CashRegisters = {
            {
                Coords = vector4(1696.63, 4924.53, 42.17, 324.99),
                Cooldown = 0,
                Robbed = false
            },
            {
                Coords = vector4(1698.30, 4923.37, 42.17, 324.99),
                Cooldown = 0,
                Robbed = false
            }
        },

        ATM = {
            Coords = vector4(1703.31, 4934.05, 41.06, 324.99),
            Cooldown = 0,
            Robbed = false
        },
        
        Safe = {
            Coords = vector4(1708.24, 4920.9, 41.06, 324.99),
            Cooldown = 0,
            Robbed = false
        }
        
    },

}