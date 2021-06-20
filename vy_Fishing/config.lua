Config = {}

-- Shrimp (Rivers and lakes) (Deep Sea)
-- Sardine (Coastlines, Saltwater)
-- Anchovies (Out in the sea, Saltwater)
-- Trout (Fresh Water, Lakes, Dams)
-- Salmon (they hatch in fresh water, migrate to the ocean, then return to fresh water to reproduce.)
-- Tuna (saltwater fish)
-- Lobsters (Lobsters live in all oceans, on rocky, sandy, or muddy bottoms)
-- Swordfish (Out in the sea, Saltwater)
-- Monkfish (Northern Ocean)
-- Shark (Out in the sea, Saltwater)
-- Anglerfish (Some live in the deep sea (e.g., Ceratiidae), while others on the continental shelf)

Config.Locations = {
    LakeRegion = {
        Name = 'Fishing: Lake Alamo',
        Coords = vector3(388.04, 3955.0, 30.44),
        AreaSize = 45.0,
        Fish = {
            'trout',
            'salmon'
        }
    },
    NorthernOcean = {
        Name = 'Fishing: Northern Ocean',
        Coords = vector3(-789.6, 6964.08, 1.56),
        AreaSize = 75.0,
        Fish = {
            'anchovies',
            'tuna',
            'swordfish',
            'monkfish',
            'shark'
        }
    },
    WestCoastal = {
        Name = 'Fishing: Tongva Coastline',
        Coords = vector3(-3185.24, 1682.4, 0.64),
        AreaSize = 48.0,
        Fish = {
            'shrimp',
            'sardines'
        }
    },
    CanyonRiver = {
        Name = 'Fishing: Cassidy Creek',
        Coords = vector3(-1409.28, 4329.24, 0.02),
        AreaSize = 25.0,
        Fish = {
            'trout'
        }
    },
    RockyCape = {
        Name = 'Fishing: Rocky Cape',
        Coords = vector3(3924.92, 4313.16, 1.44),
        AreaSize = 45.0,
        Fish = {
            'lobster',
            'anglerfish'
        }
    }
}