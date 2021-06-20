Config = {}
Config.Debug = false
Config.MinPolice                 = 4      -- Min number of police needed to rob jewelry store.
Config.ResetTime                 = 60        -- Number of Minutes the store will reset after first case is broken

Config.Closed                    =  false      -- Sets store to closed if the police online is less then MinPolice
Config.AllowPoliceStoreClose     =  true     -- Allows any job set in Config.PoliceJobs to Close the store after a robbery until next store reset.

Config.PoliceNotifyBroken        =  75       -- The chance breaking a case will notify the police.  Setting to 100 will notify first broken case..
Config.PoliceNotifyNonBroken     =  25       -- The chance attempting to break a case will notify the police.  Setting to 100 will notify every attempt.

Config.PlayFailSound             =  true    -- Uses sound for failed attempt to break.

Config.SafePosition = vector3(-625.243, -223.44, 37.78)

Config.SafeRewards = {
   ItemsAmount = 3,
   Items = { 'high_tier_earrings', 'high_tier_ring', 'high_tier_pendant', 'high_tier_rolex' },
}

Config.SecurityCameras = vector3(-631.48, -230.2, 38.04)
Config.OfficeDoor = vector3(-628.56, -229.76, 38.04)
Config.OfficeDoorHash = 1335309163
Config.AlarmPanel = {
    Coords = vector3(-629.44, -229.92, 38.04+1.3),
    Heading = 50.16 + 80
}

Config.VangelicoHeist = {
   Blip = vector3(-630.16, -236.52, 38.04),
    OfficeDoor = {
       Coords = vector3(-628.56, -229.76, 38.04),
       DoorID = 1,
       State = 1,
       Room = 1
    }
}

--  These are the items you can recieve from breaking a case - need to be listed from lowest chance to highest chance.
--  If you have the highest chance set to less then 100 - will have a chance to not recieve any items from box.
--  You will need to change the names of these items to items in your database or enter these items into your database.
Config.ItemDrops  = {

   { name = 'gold_pendant', max = 2,  chance = 75 },
   { name = 'gold_bracelet', max = 2, chance = 75 },
   { name = 'gold_charm', max = 2,  chance = 100 },

   { name = 'low_tier_earrings', max = 1,  chance = 25 },
   { name = 'low_tier_pendant', max = 1,  chance = 25 },
   { name = 'low_tier_ring', max = 1,  chance = 25 },
   { name = 'low_tier_rolex', max = 1,  chance = 25 },

   { name = 'medium_tier_earrings', max = 1, chance = 3 },
   { name = 'medium_tier_pendant', max = 1, chance = 3 },
   { name = 'medium_tier_ring', max = 1, chance = 3 },
   { name = 'medium_tier_rolex', max = 1, chance = 3 },

}

-- Do Not Edit -- This list is just the general information for each of the 20 cases.
Config.CaseLocations = {
   [1] = {
      Pos = { x = -626.3253, y = -239.0511, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
      Looted = false,
   },
   [2] = {
      Pos = { x = -625.2751, y = -238.2881, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
   [3] = {
      Pos = { x = -627.2115, y = -234.8942, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
   [4] = {
      Pos = { x = -626.1613, y = -234.1315, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
      Looted = false,
   },
   [5] = {
      Pos = { x = -626.5439 , y = -233.6047 , z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [6] = {
      Pos = { x = -627.5945 , y = -234.3678, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [7] = {
      Pos = { x = -622.6159, y = -232.5636, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [8] = {
      Pos = { x = -620.5214, y = -232.8823, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
      Looted = false,
   },
   [9] = {
      Pos = { x = -620.1764, y =-230.7865 , z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [10] = {
      Pos = { x = -621.5175, y = -228.9474, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
   [11] = {
      Pos = { x = -623.6147, y = -228.6247, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
      Looted = false,
   },
   -- [12] = {
   --    Pos = { x = -623.9558, y = -230.7263, z = 37.64523 },
   --    Prop = 'des_jewel_cab4_end',
   --    Prop1 = 'des_jewel_cab4_start',
   --    Broken = false,
   --    Looted = false,
   -- },
   [12] = {
      Pos = { x = -619.8483, y = -234.9137, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [13] = {
      Pos = { x = -618.7984, y = -234.1509, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
   [14] = {
      Pos = { x = -624.2796, y = -226.6066, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
      Looted = false,
   },
   [15] = {
      Pos = { x = -625.3300, y = -227.3697, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
   
   [16] = {
      Pos = { x = -619.2031, y = -227.2482, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
      Looted = false,
   },
   [17] = {
      Pos = { x = -619.9662, y = -226.198, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
      Looted = false,
   },
   [18] = {
      Pos = { x = -617.0856, y = -230.1627, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
      Looted = false,
   },
   [19] = {
      Pos = { x = -617.8492, y = -229.1128, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
      Looted = false,
   },
 }
