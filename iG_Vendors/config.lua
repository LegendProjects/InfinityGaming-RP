Config = {}

Config.SaleLocations = {
  Mining = {
    Type = 'Mining',
    Name = 'Grand Exchange: Mining',
    Coords = vector3(289.36, 2854.0, 43.64),
    SellItems = {
      {label = 'Copper Ore', item = 'copper_ore', price = 35 },
      {label = 'Tin Ore', item = 'tin_ore', price = 35 },
      {label = 'Iron Ore', item = 'iron_ore', price = 55 },
      {label = 'Silver Ore', item = 'silver_ore', price = 60 },
      {label = 'Coal Ore', item = 'coal_ore', price = 45 },
      {label = 'Gold Ore', item = 'gold_ore', price = 100 },
      {label = 'Mithril Ore', item = 'mithril_ore', price = 120 },
      {label = 'Luminite', item = 'luminite', price = 205 },
      {label = 'Adamantite Ore', item = 'adamantite_ore', price = 150 },
      {label = 'Runite Ore', item = 'runite_ore', price = 335 },
    }
  },
  
  Woodcutting = {
    Type = 'Woodcutting',
    Name = 'Grand Exchange: Woodcutting',
    Coords = vector3(-553.96, 5370.24, 70.36),
    SellItems = {
      {label = 'Logs', item = 'logs', price = 50 },
      {label = 'Oak Logs', item = 'oak_logs', price = 70 },
      {label = 'Willow Logs', item = 'willow_logs', price = 85 },
      {label = 'Maple Logs', item = 'maple_logs', price = 105 },
      {label = 'Mahogany Logs', item = 'mahogany_logs', price = 210 },
      {label = 'Yew Logs', item = 'yew_logs', price = 245 },
      {label = 'Redwood Logs', item = 'redwood_logs', price = 315 },
    }
  },

  Smithing = {
    Type = 'Smithing',
    Name = 'Grand Exchange: Smithing',
    Coords = vector3(1050.6, -1958.2, 31.04),
    SellItems = {
      {label = 'Bronze Bar', item = 'bronze_bar', price = 145 },
      {label = 'Iron Bar', item = 'iron_bar', price = 195 },
      {label = 'Silver Bar', item = 'silver_bar', price = 175 },
      {label = 'Steel Bar', item = 'steel_bar', price = 215 },
      {label = 'Gold Bar', item = 'gold_bar', price = 245 },
      {label = 'Mithril Bar', item = 'mithril_bar', price = 285 },
      {label = 'Adamantite Bar', item = 'adamant_bar', price = 475 },
      {label = 'Runite Bar', item = 'runite_bar', price = 645 },
    }
  },

  Construction = {
    Type = 'Construction',
    Name = 'Grand Exchange: Construction',
    Coords = vector3(-575.52, 5351.4, 70.2),
    SellItems = {
      {label = 'Bronze Nails', item = 'bronze_nails', price = 2 },
      {label = 'Iron Nails', item = 'iron_nails', price = 3 },
      {label = 'Steel Nails', item = 'steel_nails', price = 5 },
      {label = 'Mithril Nails', item = 'mithril_nails', price = 9 },
      {label = 'Adamantite Nails', item = 'adamant_nails', price = 25 },
      {label = 'Rune Nails', item = 'rune_nails', price = 178 }
    }
  },

  Fishing = {
    Type = 'Fishing',
    Name = 'Grand Exchange: Fishing',
    Coords = vector3(-1840.32, -1189.16, 14.32),
    SellItems = {
      {label = 'Raw Shrimp', item = 'shrimp', price = 5 },
      {label = 'Raw Sardine', item = 'sardine', price = 10 },
      {label = 'Raw Anchovies', item = 'anchovies', price = 20 },
      {label = 'Raw Trout', item = 'trout', price = 22 },
      {label = 'Raw Salmon', item = 'salmon', price = 25 },
      {label = 'Raw Tuna', item = 'tuna', price = 35 },
      {label = 'Raw Lobster', item = 'lobster', price = 43 },
      {label = 'Raw Swordfish', item = 'swordfish', price = 75 },
      {label = 'Raw Monkfish', item = 'monkfish', price = 95 },
      {label = 'Raw Shark', item = 'shark', price = 195 },
      {label = 'Raw Anglerfish', item = 'anglerfish', price = 320 },
    }
  },
}

Config.VendorLocations = {
  -- Casino = {
  --   Type = 'Casino',
  --   Name = 'Exchange: The Diamond Casino',
  --   Coords = vector3(2495.36, -273.88, -58.72),
  --   BuyItems = {
  --     {label = 'Casino Chips', item = 'chips', price = 1 },
  --   },
  --   SellItems = {
  --     {label = 'Casino Chips', item = 'chips', price = 1 },
  --   } 
  -- },

  PawnShop = {
    Type = 'PawnShop',
    Name = 'Shop: Vinewood Pawn & Jewelry',
    Coords = vector3(-1459.4, -413.92, 35.72),
    BuyItems = {
      {label = 'Weed Seed', item = 'weed_seed', price = 200 }
    },
    SellItems = {
      {label = 'Basic Diamond Studs', item = 'low_tier_earrings', price = 750 },
      {label = 'Basic Diamond Pendant', item = 'low_tier_pendant', price = 950 },
      {label = 'Silver Rolex Watch', item = 'low_tier_rolex', price = 550 },
      {label = 'Gold Daytona Rolex', item = 'medium_tier_rolex', price = 1511 },
      {label = 'Diamond Encrusted Datejust Rolex', item = 'high_tier_rolex', price = 7748 },
    } 
  },

  Gold = {
    Type = 'GoldCurrency',
    Name = 'Exchange: Gold Currency Exchange',
    Coords = vector3(-1308.56, -823.92, 17.16),
    BuyItems = {
      {label = '1oz Gold Bullion', item = 'verylow_tier_goldbar', price = 2547 },
      {label = '50g Gold Bullion', item = 'low_tier_goldbar', price = 4090 },
      {label = '5oz Gold Bullion', item = 'medium_tier_goldbar', price = 12677 },
      {label = '250g Gold Bullion', item = 'high_tier_goldbar', price = 20355 },
      {label = '20oz Gold Bullion', item = 'veryhigh_tier_goldbar', price = 32598 },
      {label = '1kg Gold Bullion', item = 'ultra_tier_goldbar', price = 81187 },
    },
    SellItems = {
      {label = '1oz Gold Bullion', item = 'verylow_tier_goldbar', price = 1225 },
      {label = '50g Gold Bullion', item = 'low_tier_goldbar', price = 2550 },
      {label = '5oz Gold Bullion', item = 'medium_tier_goldbar', price = 7950 },
      {label = '250g Gold Bullion', item = 'high_tier_goldbar', price = 17350 },
      {label = '20oz Gold Bullion', item = 'veryhigh_tier_goldbar', price = 34750 },
      {label = '1kg Gold Bullion', item = 'ultra_tier_goldbar', price = 71450 },
    } 
  },
  
  Jewelcrafting = {
    Type = 'Jewelcrafting',
    Name = 'Grand Exchange: Jewelcrafting',
    Coords = vector3(-624.4, -231.08, 38.04),
    BuyItems = {
      {label = '0.31CT Cut Diamond', item = 'verylow_tier_diamond', price = 793 },
      {label = '0.54CT Cut Diamond', item = 'low_tier_diamond', price = 1537 },
      {label = '0.89CT Cut Diamond', item = 'medium_tier_diamond', price = 3323 },
      {label = '1.41CT Cut Diamond', item = 'high_tier_diamond', price = 9101 },
      {label = '1.91CT Cut Diamond', item = 'veryhigh_tier_diamond', price = 19211 },
      {label = '4.58CT Cut Diamond', item = 'ultra_tier_diamond', price = 93504 },
    },
    SellItems = {
      {label = 'Opal Ring', item = 'opal_ring', price = 120 },
      {label = 'Jade Ring', item = 'jade_ring', price = 170 },
      {label = 'Topaz Ring', item = 'topaz_ring', price = 855 },
      {label = 'Opal Necklace', item = 'opal_necklace', price = 125 },
      {label = 'Opal Bracelet', item = 'opal_bracelet', price = 110 },
      {label = 'Jade Necklace', item = 'jade_necklace', price = 180 },
      {label = 'Opal Amulet', item = 'opal_amulet', price = 80 },
      {label = 'Jade Bracelet', item = 'jade_bracelet', price = 130 },
      {label = 'Topaz Necklace', item = 'topaz_necklace', price = 250 },
      {label = 'Jade Amulet', item = 'jade_amulet', price = 135 },
      {label = 'Topaz Bracelet', item = 'topaz_bracelet', price = 614 },
      {label = 'Topaz Amulet', item = 'topaz_amulet', price = 607 },
      {label = 'Emerald Amulet', item = 'emerald_amulet', price = 164 },
      {label = 'Ruby Amulet', item = 'ruby_amulet', price = 295 },
      {label = 'Sapphire Amulet', item = 'sapphire_amulet', price = 168 },
      {label = 'Diamond Amulet', item = 'diamond_amulet', price = 450 },
      {label = '0.31CT Cut Diamond', item = 'verylow_tier_diamond', price = 555 },
      {label = '0.54CT Cut Diamond', item = 'low_tier_diamond', price = 1075 },
      {label = '0.89CT Cut Diamond', item = 'medium_tier_diamond', price = 2326 },
      {label = '1.41CT Cut Diamond', item = 'high_tier_diamond', price = 6370 },
      {label = '1.91CT Cut Diamond', item = 'veryhigh_tier_diamond', price = 13447 },
      {label = '4.58CT Cut Diamond', item = 'ultra_tier_diamond', price = 65452 },
    }
  },
} 