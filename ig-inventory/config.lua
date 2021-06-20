---------------------------------------------------
------- GENERAL CONFIGURATION
---------------------------------------------------
Config = {}
Config.Debug = false
Config.ServerName = 'Infinity Gaming'
Config.Locale = 'en' -- Currently supported: nl, en, tr, fr, br, de, fa, pt, es. Your translation file is really appreciated. Send it to our Github repo or Discord server.
Config.ExcludeAccountsList = {'bank', 'money'} -- DO NOT TOUCH!

Config.IncludeCash = true -- Include cash in inventory? true or false.
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)? true or false.
Config.CameraAnimationPocket = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationBag = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationTrunk = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationGlovebox = false -- Set camera focus towards player if in inventory.
Config.EverybodyCanRob = true -- Rob a dead or mugging or handcuffed person or allow jobs only?
Config.JobOnlyInventory = false -- Can jobs use /openinventory ID from anywere? If False only admins can do this.
Config.AllowModerators = true -- Can moderators use /openinventory ID from anywere?
Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk and glovebox. Only if this is on TRUE Config.AllowJOBNAME will work.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.
Config.IllegalshopOpen = false -- if true everybody can enter this shop. If false only Config.InventoryJob.Illegal can enter this shop.
Config.UseLicense = true -- You must have iG_license working on your server. 
Config.useAdvancedShop = false -- es_extended shop system. Not shared, sorry. Just set to false and use the in-build custom shop.
Config.disableVersionCheck = false
Config.disableVersionMessage = false
Config.versionCheckDelay = 60 -- In minutes

-- Config.Command = {Steal = 'steal', CloseInv = 'closeinventory', Unequip = 'unequip'} -- NOT YET SUPPORTED, CHANGE IN /server/main.lua/.

Config.Attachments = {
    'flashlight', 
    'mag', 
    'drummag', 
    'suppressor', 
    'scope', 
    'grip', 
    'skin', 
    'skin1', 
    'skin2', 
    'skin3', 
    'skin4', 
    'skin5', 
    'skin6',
    'skin7'
}

Config.InventoryJob = {Police = 'police', Ambulance = 'ambulance'} -- This must be the name used in your database/jobs table.
Config.CloseUiItems = {
  'tunerchip',
  'divingsuit',
  'lightdivingsuit',
  'radio',
}

Config.License = {Weapon = 'weapon'} -- What license is needed for this shop?

---------------------------------------------------
------- KEY CONTROL & KEYBINDS
---------------------------------------------------
Config.OpenControl = 349 -- F2. player inventory, it is recommend to use the same as CloseControl.
Config.CloseControl = 349 -- F2. player inventory, it is recommend to use the same as OpenControl.
Config.BagControl = 288 -- F4. player bag inventory
Config.SearchBag = 249 -- N. Search a bag on the ground
Config.TakeBag = 38 -- E. Take bag on the ground
Config.OpenKeyGlovebox = 47 -- F3. glovebox inventory (in-car), it is recommend to use the same as OpenKeyTrunk.
Config.OpenKeyTrunk = 47 -- F3. trunk inventory (behind-car), it is recommend to use the same as OpenKeyGlovebox.
Config.RobKeyOne = 38 -- E
Config.RobKeyTwo = 19 -- CTRL


---------------------------------------------------
------- MISC. CONFIGURATION
---------------------------------------------------
Config.ReloadTime = 2000 -- in miliseconds for reloading your ammunition.

Config.LicensePrice = 25000

Config.ShopMinimumGradePolice = 9 -- minimum grade to open the police shop
Config.ShopMinimumGradeNightclub = 0
Config.ShopMinimumGradeMafia = 0

---------------------------------------------------
------- BLIPS & MARKERS HANDLERS
---------------------------------------------------
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 0 -- currently used for most shop blip color.
Config.WeaponColor = 1 -- to be optimized....

Config.ShopBlipID = 52
Config.LiquorBlipID = 52
Config.HardWareBlipID = 106
Config.PrisonShopBlipID = 52
Config.WeaponShopBlipID = 88
Config.PoliceShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.HardWareLength = 2
Config.PrisonShopLength = 2
Config.PoliceShopLength = 2
Config.WeaponShopLength = 2

Config.ShowLockerRentBlip = true
Config.LockerRentBlipID = 357
Config.LockerRentBlipSize = 1.0
Config.LockerRentBlipColor = 3

---------------------------------------------------
------- GENERAL WEIGHT CONFIGURATION
---------------------------------------------------
Config.Weight = 24000 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg).
Config.DefaultWeight = 1 -- Default weight for an item.
Config.MaxBagWeight = 20
Config.MaxBagItemCount = 50 
Config.MaxDifferentBagItems = 5

---------------------------------------------------
------- GLOVEBOX / TRUNK ITEM WEIGHT CONFIGURATION
---------------------------------------------------
Config.localWeight = { -- Fill this with all your items. This is only for trunk and glovebox! Change your pocket inventory weights in your database! (items table)
	WEAPON_ADVANCEDRIFLE = 5500,
    WEAPON_APPISTOL = 850,
    WEAPON_ARMADYL = 2500,
    WEAPON_ASSAULTRIFLE = 5500,
    WEAPON_ASSAULTRIFLE_MK2 = 6500,
    WEAPON_ASSAULTSHOTGUN = 5500,
    WEAPON_ASSAULTSMG = 4500,
    WEAPON_AUTOSHOTGUN = 5500,
    WEAPON_BALL = 750,
    WEAPON_BAT = 750,
    WEAPON_BATTLEAXE = 750,
    WEAPON_BEANBAG = 3500,
    WEAPON_BONESAW = 2500,
    WEAPON_BOTTLE = 750,
    WEAPON_BREADSTICK = 2500,
    WEAPON_BULLPUPRIFLE = 5500,
    WEAPON_BULLPUPSHOTGUN = 4500,
    WEAPON_BZGAS = 750,
    WEAPON_CARBINERIFLE = 5500,
    WEAPON_CARBINERIFLE_MK2 = 6500,
    WEAPON_COMBATMG = 9500,
    WEAPON_COMBATMG_MK2 = 9500,
    WEAPON_COMBATPDW = 4500,
    WEAPON_COMBATPISTOL = 950,
    WEAPON_COMPACTLAUNCHER = 99999,
    WEAPON_COMPACTRIFLE = 4500,
    WEAPON_CROWBAR = 750,
    WEAPON_DAGGER = 750,
    WEAPON_DBSHOTGUN = 2500,
    WEAPON_DIGISCANNER = 99999,
    WEAPON_DILDO = 2500,
    WEAPON_DOUBLEACTION = 850,
    WEAPON_FIREEXTINGUISHER = 2500,
    WEAPON_FIREWORK = 99999,
    WEAPON_FLARE = 750,
    WEAPON_FLAREGUN = 750,
    WEAPON_FLASHLIGHT = 750,
    WEAPON_FORK = 2500,
    WEAPON_GARBAGEBAG = 750,
    WEAPON_GOLFCLUB = 750,
    WEAPON_GRENADE = 750,
    WEAPON_GRENADELAUNCHER = 99999,
    WEAPON_GUSENBERG = 3500,
    WEAPON_HAMMER = 750,
    WEAPON_HANDCUFFS = 750,
    WEAPON_HATCHET = 750,
    WEAPON_HEAVYPISTOL = 1250,
    WEAPON_HEAVYSHOTGUN = 5500,
    WEAPON_HEAVYSNIPER = 9500,
    WEAPON_HOMINGLAUNCHER = 99999,
    WEAPON_KATANA = 2500,
    WEAPON_KNIFE = 750,
    WEAPON_KNUCKLE = 750,
    WEAPON_MACHETE = 750,
    WEAPON_MACHINEPISTOL = 1350,
    WEAPON_MARKSMANPISTOL = 3500,
    WEAPON_MARKSMANRIFLE = 6500,
    WEAPON_MARKSMANRIFLE_MK2 = 6500,
    WEAPON_MG = 9500,
    WEAPON_MICROSMG = 2500,
    WEAPON_MINIGUN = 99999,
    WEAPON_MINISMG = 1100,
    WEAPON_MOLOTOV = 750,
    WEAPON_MUSKET = 9500,
    WEAPON_NIGHTSTICK = 750,
    WEAPON_PENETRATOR = 2500,
    WEAPON_PETROLCAN = 5000,
    WEAPON_PIPEBOMB = 850,
    WEAPON_PISTOL = 850,
    WEAPON_PISTOL50 = 1100,
    WEAPON_PISTOL_MK2 = 1250,
    WEAPON_POOLCUE = 750,
    WEAPON_PROXMINE = 850,
    WEAPON_PUMPSHOTGUN = 3500,
    WEAPON_PUMPSHOTGUN_MK2 = 3500,
    WEAPON_QUATERSTAFF = 2500,
    WEAPON_RAILGUN = 99999,
    WEAPON_REVOLVER = 1100,
    WEAPON_RPG = 99999,
    WEAPON_SAWNOFFSHOTGUN = 2500,
    WEAPON_SMG = 4750,
    WEAPON_SMG_MK2 = 3500,
    WEAPON_SMOKEGRENADE = 850,
    WEAPON_SNIPERRIFLE = 9500,
    WEAPON_SNOWBALL = 75,
    WEAPON_SNSPISTOL = 3500,
    WEAPON_SNSPISTOL_MK2 = 1250,
    WEAPON_SPECIALCARBINE = 5500,
    WEAPON_SPECIALCARBINE_MK2 = 6500,
    WEAPON_STICKYBOMB = 3500,
    WEAPON_STINGER = 3500,
    WEAPON_STUNGUN = 3500,
    WEAPON_SWITCHBLADE = 750,
    WEAPON_VINTAGEPISTOL = 3500,
    WEAPON_WRENCH = 2500,
    adamant_axe = 240,
    adamant_bar = 480,
    adamant_chainbody = 240,
    adamant_nails = 240,
    adamant_platebody = 240,
    adamantite_ore = 480,
    adrenaline = 350,
    advancedrifle = 12500,
    advlockpick = 75,
    alive_chicken = 1,
    ammopistol = 75,
    ammorifle = 75,
    ammoshotgun = 550,
    ammosmg = 75,
    ammosnp = 550,
    amulet_mould = 240,
    anchovies = 240,
    anglerfish = 240,
    appistol = 75,
    armour1 = 1500,
    armour2 = 2500,
    armour3 = 3500,
    assaultrifle = 12500,
    assaultrifle_mk2 = 12500,
    assaultshotgun = 6500,
    assaultsmg = 3500,
    bagofdope = 75,
    bait = 240,
    ball_of_wool = 75,
    bandage = 350,
    battleaxe = 240,
    beef_mince = 75,
    beer = 75,
    binoculars = 75,
    blank_plate = 75,
    bloodymary = 75,
    blowtorch = 750,
    blue_phone = 75,
    bodycam = 75,
    bracelet_mould = 240,
    bread = 75,
    bricked_cocaine = 100,
    bronze_axe = 240,
    bronze_bar = 480,
    bronze_chainbody = 240,
    bronze_nails = 240,
    bronze_platebody = 240,
    bullpuprifle = 12500,
    bullpuprifle_mk2 = 12500,
    bullpupshotgun = 6500,
    burger = 75,
    bzgas = 800,
    c4_bank = 1750,
    camoskin = 75,
    cannabis = 1,
    carbinerifle = 12500,
    carbinerifle_mk2 = 12500,
    carcleaner = 1250,
    chips = 0,
    chisel = 240,
    clothe = 1,
    coal_ore = 480,
    coca_leaves = 75,
    cocacola = 75,
    coke10g = 10,
    coke1g = 1,
    cokebrick = 100,
    cokeburn = 75,
    combatgrip = 240,
    combatmg = 17500,
    combatmg_mk2 = 17500,
    combatpdw = 3500,
    combatpistol = 1250,
    compactrifle = 3500,
    compensator = 240,
    copper_ore = 480,
    corona = 75,
    cowhide = 240,
    craftingtable = 1,
    crowbar = 240,
    crystal_meth = 250,
    crystalised_iodine = 300,
    cuff_keys = 95,
    cuffs = 240,
    cup_of_milk = 75,
    cupcake = 75,
    cutted_wood = 75,
    dagger = 240,
    dbshotgun = 3500,
    diamond = 240,
    diamond_amulet = 240,
    diamond_bracelet = 240,
    diamond_necklace = 240,
    diamond_ring = 240,
    dirty = 6500,
    divingsuit = 3500,
    donut = 75,
    doubleaction = 1250,
    dried_leaves = 240,
    drugbags = 240,
    drugscales = 240,
    dry_cannabis = 240,
    dryed_poppy_leaves = 240,
    emerald = 240,
    emerald_amulet = 240,
    emerald_bracelet = 240,
    emerald_necklace = 240,
    emerald_ring = 240,
    eschscholzia_poppy = 240,
    ethanol = 1750,
    extendedmag = 240,
    fabric = 1,
    fanta = 75,
    feather = 75,
    fireextinguisher = 240,
    firstaid = 1250,
    fishingnet = 240,
    fishingrod = 240,
    flakedmaize = 480,
    flaregun = 1250,
    flashbang = 800,
    flashlight = 1,
    flyfishingrod = 240,
    gauze = 750,
    gold = 500,
    gold_bar = 480,
    gold_bracelet = 480,
    gold_charm = 480,
    gold_ore = 480,
    goldbar = 500,
    goldchain = 500,
    goldring = 500,
    goldwatch = 500,
    golfclub = 250,
    gps = 75,
    grenade = 800,
    grinded_eschscholzia_poppy = 1,
    gruppecard = 75,
    gusenberg = 3500,
    hardleather = 240,
    hardleather_body = 240,
    harpoon = 240,
    hatchet = 240,
    heavypistol = 1250,
    heavyshotgun = 6500,
    heavysniper = 17500,
    heavysniper_mk2 = 17500,
    high_tier_diamond = 500,
    high_tier_earrings = 480,
    high_tier_goldbar = 500,
    high_tier_pendant = 480,
    high_tier_ring = 480,
    high_tier_rolex = 480,
    highgradefemaleseed = 1,
    highgradefert = 1,
    highgrademaleseed = 1,
    holographic = 240,
    hqscale = 240,
    hydrochloric_acid = 200,
    hydrocodone = 750,
    id_card_f = 75,
    idcard = 1,
    iron_axe = 240,
    iron_bar = 480,
    iron_chainbody = 240,
    iron_nails = 240,
    iron_ore = 480,
    iron_platebody = 240,
    jackdaniels = 75,
    jade = 240,
    jade_amulet = 240,
    jade_bracelet = 240,
    jade_necklace = 240,
    jade_ring = 240,
    jameson = 75,
    jimbean = 75,
    joint = 100,
    katana = 2500,
    keycard_black = 1,
    keycard_blue = 1,
    keycard_gold = 1,
    keycard_green = 1,
    keycard_red = 1,
    knife = 240,
    knuckle = 240,
    laptop_h = 1100,
    largescope = 240,
    leather = 240,
    leather_body = 240,
    lightdivingsuit = 1500,
    liquid_iodine = 100,
    lobster = 240,
    lobsterpot = 240,
    lockpick = 240,
    logs = 240,
    longsight = 240,
    low_tier_diamond = 500,
    low_tier_earrings = 480,
    low_tier_goldbar = 500,
    low_tier_pendant = 480,
    low_tier_ring = 480,
    low_tier_rolex = 480,
    lowgradefemaleseed = 1,
    lowgradefert = 1,
    lowgrademaleseed = 1,
    lsd = 480,
    luminite = 480,
    lysergicacid = 1250,
    lysis = 480,
    machete = 240,
    machinepistol = 1250,
    mahogany_logs = 240,
    maple_logs = 240,
    marksmanpistol = 1250,
    marksmanrifle = 13500,
    marksmanrifle_mk2 = 13500,
    marlboro = 75,
    mcdonalds_burger = 75,
    mcdonalds_drink = 75,
    mcdonalds_fries = 75,
    mcdonalds_meal = 75,
    medium_tier_diamond = 480,
    medium_tier_earrings = 480,
    medium_tier_goldbar = 480,
    medium_tier_pendant = 480,
    medium_tier_ring = 480,
    medium_tier_rolex = 480,
    mediumscope = 240,
    medkit = 750,
    metalfinish = 75,
    meth10g = 10,
    meth1g = 1,
    methbrick = 100,
    methburn = 240,
    mg = 17500,
    microsmg = 3500,
    mini_c4 = 400,
    minismg = 1250,
    mithril_axe = 240,
    mithril_bar = 480,
    mithril_chainbody = 240,
    mithril_nails = 240,
    mithril_ore = 480,
    mithril_platebody = 240,
    mixed_cocaine = 850,
    molotov = 800,
    monkfish = 240,
    moonshine = 1250,
    morninggloryseeds = 275,
    morphine = 500,
    mountedscope = 240,
    musket = 6500,
    necklace_mould = 240,
    nightstick = 240,
    normal_c4 = 600,
    oak_logs = 240,
    opal = 240,
    opal_amulet = 240,
    opal_bracelet = 240,
    opal_necklace = 240,
    opal_ring = 240,
    opium = 850,
    original_plate = 75,
    oxy = 480,
    pacificidcard = 1,
    packaged_cannabis = 1,
    packaged_chicken = 1,
    packaged_plank = 1,
    packaged_taco = 75,
    parachute = 1250,
    pepsi = 75,
    petrolcan = 0,
    phone = 240,
    pickaxe = 1,
    pistol = 1250,
    pistol50 = 1250,
    pistol_mk2 = 1250,
    pistolmag = 250,
    pizza = 75,
    plantpot = 1,
    playersafe = 1,
    poolreceipt = 125,
    pumpshotgun = 6500,
    purifiedwater = 4000,
    radio = 75,
    raspberry = 950,
    recipe_topaz_amulet = 1,
    red_phosphorus = 300,
    redtopaz = 240,
    redwood_logs = 240,
    repairkit_bodywork = 650,
    repairkit_engine = 850,
    revolver = 1250,
    riflemag = 750,
    ring_mould = 240,
    rollingpapers = 75,
    rope = 240,
    ruby = 240,
    ruby_amulet = 240,
    ruby_bracelet = 240,
    ruby_necklace = 240,
    ruby_ring = 240,
    rune_axe = 240,
    rune_bar = 480,
    rune_chainbody = 240,
    rune_nails = 240,
    rune_platebody = 240,
    runite_ore = 480,
    salmon = 240,
    sandwich = 75,
    sandworms = 25,
    sapphire = 240,
    sapphire_amulet = 240,
    sapphire_bracelet = 240,
    sapphire_necklace = 240,
    sapphire_ring = 240,
    sardine = 240,
    sawnoffshotgun = 3500,
    scrap = 1000,
    secure_card = 75,
    shark = 240,
    shrimp = 240,
    silver_bar = 480,
    silver_ore = 480,
    skullsskin = 75,
    slaughtered_chicken = 75,
    smg = 3500,
    smg_mk2 = 3500,
    smgmag = 550,
    smirnoff = 75,
    smokegrenade = 800,
    snakeskin = 75,
    snakeskin_body = 240,
    sniperrifle = 17500,
    snspistol = 1250,
    snspistol_mk2 = 1250,
    sodium_hydroxide = 1250,
    solvent = 1000,
    specialcarbine = 12500,
    specialcarbine_mk2 = 12500,
    sprite = 75,
    steel_axe = 240,
    steel_bar = 480,
    steel_chainbody = 240,
    steel_nails = 240,
    steel_platebody = 240,
    steel_studs = 75,
    stone = 1,
    strained_leaves = 240,
    studded_body = 240,
    stungun = 1250,
    sulfuric_acid = 200,
    suppressor = 240,
    switchblade = 240,
    swordfish = 240,
    taco = 75,
    tacticalflashlight = 240,
    tacticalmuzzle = 240,
    teargas = 800,
    tequila = 75,
    thermal_charge = 850,
    tin_ore = 480,
    topaz_amulet = 240,
    topaz_bracelet = 240,
    topaz_necklace = 240,
    topaz_ring = 240,
    trimmed_cannabis = 1,
    trimmed_marijuana = 1,
    trimmedweed = 1,
    trout = 240,
    tuna = 240,
    tunerchip = 1250,
    ultra_tier_diamond = 480,
    ultra_tier_goldbar = 1000,
    uncut_diamond = 240,
    uncut_emerald = 240,
    uncut_jade = 240,
    uncut_opal = 240,
    uncut_redtopaz = 240,
    uncut_ruby = 240,
    uncut_sapphire = 240,
    veryhigh_tier_diamond = 480,
    veryhigh_tier_goldbar = 480,
    verylow_tier_diamond = 480,
    verylow_tier_goldbar = 480,
    vicodin = 75,
    victoriabitter = 75,
    vintagepistol = 1250,
    vodka = 75,
    water = 75,
    wateringcan = 1250,
    weed20g = 20,
    weed4g = 4,
    weed_bud = 50,
    weed_pouch = 250,
    weed_seed = 25,
    weedbrick = 200,
    weedburn = 240,
    wheat = 240,
    wheatgrain = 240,
    whisky = 75,
    willow_logs = 240,
    wine = 75,
    xpbomb = 0,
    yakhide_body = 240,
    yew_logs = 240,
    ziplock_bag = 240,
    zipties = 75,
}

---------------------------------------------------
------- GLOVEBOX / TRUNK SIZE CONFIGURATION
---------------------------------------------------
Config.GloveboxSize = { -- Related to Config.localWeight.
	[0] = 30, --Compact
	[1] = 40, --Sedan
	[2] = 70, --SUV
	[3] = 25, --Coupes
	[4] = 30, --Muscle
	[5] = 10, --Sports Classics
	[6] = 5, --Sports
	[7] = 5, --Super
	[8] = 5, --Motorcycles
	[9] = 180, --Off-road
	[10] = 300, --Industrial
	[11] = 70, --Utility
	[12] = 100, --Vans
	[13] = 0, --Cycles
	[14] = 5, --Boats
	[15] = 20, --Helicopters
	[16] = 0, --Planes
	[17] = 40, --Service
	[18] = 40, --Emergency
	[19] = 0, --Military
	[20] = 300, --Commercial
	[21] = 0 --Trains
}

Config.TrunkSize = { -- Related to Config.localWeight.
	[0] = 3000, --Compact
    [1] = 4000, --Sedan
    [2] = 7000, --SUV
    [3] = 2500, --Coupes
    [4] = 3000, --Muscle
    [5] = 1000, --Sports Classics
    [6] = 500, --Sports
    [7] = 500, --Super
    [8] = 500, --Motorcycles
    [9] = 18000, --Off-road
    [10] = 30000, --Industrial
    [11] = 7000, --Utility
    [12] = 10000, --Vans
    [13] = 0, --Cycles
    [14] = 500, --Boats
    [15] = 2000, --Helicopters
    [16] = 0, --Planes
    [17] = 4000, --Service
    [18] = 4000, --Emergency
    [19] = 0, --Military
    [20] = 30000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
	taxi = 'TAXI',
	cop = 'police',
	police = 'police',
	ambulance = 'ambulance',
	mecano = 'mechano',
	mechanic = 'mechanic',
	police = 'police',
	nightclub = 'nightclub',
	nightclub = 'nightclub',
	bahamas = 'bahamas',
	cardealer = 'dealer'
}


---------------------------------------------------
-------  MISC. CONFIGURATION
---------------------------------------------------
Config.Throwables = { -- WEAPON NAME & WEAPON HASH
	WEAPON_MOLOTOV = 615608432,
	WEAPON_GRENADE = -1813897027,
	WEAPON_STICKYBOMB = 741814745,
	WEAPON_PROXMINE = -1420407917,
	WEAPON_SMOKEGRENADE = -37975472,
	WEAPON_PIPEBOMB = -1169823560,
	WEAPON_FLARE = 1233104067,
	WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847

Config.PropList = { -- Here you can change the prop when using the item.
	cash = {['model'] = 'prop_cash_pile_02', ['bone'] = 28422, ['x'] = 0.02, ['y'] = 0.02, ['z'] = -0.08, ['xR'] = 270.0, ['yR'] = 180.0, ['zR'] = 0.0}
}

Config.EnableInventoryHUD = true

---------------------------------------------------
------- AMMUNITION CONFIGURATION
---------------------------------------------------

Config.Ammo = {
    {
        name = 'ammopistol',
        weapons = {
            'WEAPON_PISTOL',
            'WEAPON_PISTOL_MK2',
            'WEAPON_APPISTOL',
			'WEAPON_SNSPISTOL',
            'WEAPON_SNSPISTOL_MK2',
            'WEAPON_COMBATPISTOL',
            'WEAPON_HEAVYPISTOL',
            'WEAPON_MACHINEPISTOL',
            'WEAPON_MARKSMANPISTOL',
            'WEAPON_PISTOL50',
            'WEAPON_VINTAGEPISTOL',
            'WEAPON_REVOLVER',
            'WEAPON_MUSKET',
            'WEAPON_CERAMICPISTOL'
        },
        count = 1
    },
    {
        name = 'pistolmag',
        weapons = {
            'WEAPON_PISTOL',
            'WEAPON_PISTOL_MK2',
            'WEAPON_APPISTOL',
			'WEAPON_SNSPISTOL',
            'WEAPON_SNSPISTOL_MK2',
            'WEAPON_COMBATPISTOL',
            'WEAPON_HEAVYPISTOL',
            'WEAPON_MACHINEPISTOL',
            'WEAPON_MARKSMANPISTOL',
            'WEAPON_PISTOL50',
            'WEAPON_VINTAGEPISTOL',
            'WEAPON_REVOLVER',
            'WEAPON_CERAMICPISTOL'
        },
        count = 12
    },
	{
        name = 'ammoshotgun',
        weapons = {
            'WEAPON_ASSAULTSHOTGUN',
	        'WEAPON_AUTOSHOTGUN',
            'WEAPON_BULLPUPSHOTGUN',
            'WEAPON_BULLPUPSHOTGUN_MK2',
	        'WEAPON_DBSHOTGUN',
            'WEAPON_HEAVYSHOTGUN',
            'WEAPON_PUMPSHOTGUN',
            'WEAPON_PUMPSHOTGUN_MK2',
            'WEAPON_SAWNOFFSHOTGUN'
        },
        count = 16
    },
	{
        name = 'ammosmg',
        weapons = {
            'WEAPON_ASSAULTSMG',
	        'WEAPON_MICROSMG',
            'WEAPON_SMG_MK2',
            'WEAPON_MINISMG',
            'WEAPON_SMG'
        },
        count = 1
    },
    {
        name = 'smgmag',
        weapons = {
            'WEAPON_ASSAULTSMG',
	        'WEAPON_MICROSMG',
            'WEAPON_SMG_MK2',
            'WEAPON_MINISMG',
            'WEAPON_SMG',
            'WEAPON_GUSENBERG',
        },
        count = 24
    },
	{
        name = 'ammorifle',
        weapons = {
            'WEAPON_ADVANCEDRIFLE',
	        'WEAPON_ASSAULTRIFLE',
            'WEAPON_ASSAULTRIFLE_MK2',
            'WEAPON_BULLPUPRIFLE',
            'WEAPON_CARBINERIFLE',
	        'WEAPON_SPECIALCARBINE',
            'WEAPON_COMPACTRIFLE',
            'WEAPON_BULLPUPRIFLE_MK2',
            'WEAPON_CARBINERIFLE_MK2',
            'WEAPON_SPECIALCARBINE_MK2',
            'WEAPON_COMBATMG_MK2',
            'WEAPON_COMBATMG',
        },
        count = 1
    },
    {
        name = 'riflemag',
        weapons = {
            'WEAPON_ADVANCEDRIFLE',
	        'WEAPON_ASSAULTRIFLE',
            'WEAPON_ASSAULTRIFLE_MK2',
            'WEAPON_BULLPUPRIFLE',
            'WEAPON_CARBINERIFLE',
	        'WEAPON_SPECIALCARBINE',
            'WEAPON_COMPACTRIFLE',
            'WEAPON_BULLPUPRIFLE_MK2',
            'WEAPON_CARBINERIFLE_MK2',
            'WEAPON_SPECIALCARBINE_MK2',
            'WEAPON_COMBATMG_MK2',
            'WEAPON_COMBATMG',
        },
        count = 30
    },
	{
        name = 'ammosnp',
        weapons = {
            'WEAPON_SNIPERRIFLE',
	        'WEAPON_HEAVYSNIPER',
            'WEAPON_HEAVYSNIPER_MK2',
            'WEAPON_MARKSMANRIFLE',
            'WEAPON_MARKSMANRIFLE_MK2'
        },
        count = 4
    }
}

---------------------------------------------------
------- SHOPS & ARMOURIES
---------------------------------------------------
Config.Shops = {
    RegularShop = {
        Locations = {
            { x = 373.875, y = 325.896, z = 102.6 },
            { x = 2557.458, y = 382.282, z = 107.652 },
            { x = -3038.939, y = 585.954, z = 6.938 },
            { x = -3241.927, y = 1001.462, z = 11.9 },
            { x = 547.431, y = 2671.710, z = 41.172 },
            { x = 1961.464, y = 3740.672, z = 31.363 },
            { x = 2678.916, y = 3280.671, z = 54.262 },
            { x = 1729.216, y = 6414.131, z = 34.057 },
            { x = -48.519, y = -1757.514, z = 28.51 },
            { x = 1163.373, y = -323.801, z = 68.25 },
            { x = -707.501, y = -914.260, z = 18.235 },
            { x = -1820.523, y = 792.518, z = 137.138 },
            { x = 1698.388, y = 4924.404, z = 41.083 },
            { x = 25.723, y = -1346.966, z = 28.52 }
        },
        Items = {
            { name = 'pizza' , currency = 'money', price = 8},
            { name = 'burger' , currency = 'money', price = 15},
            { name = 'sandwich' , currency = 'money', price = 8},
            { name = 'donut' , currency = 'money', price = 4},
            { name = 'cocacola' , currency = 'money', price = 16},
            { name = 'fanta' , currency = 'money', price = 14},
            { name = 'pepsi' , currency = 'money', price = 12},
            { name = 'sprite' , currency = 'money', price = 18},
            { name = 'water',currency = 'money', price = 10 }, 
            { name = 'phone' , currency = 'money', price = 120},
            { name = 'radio',currency = 'money', price = 220 },
            { name = 'ziplock_bag' , currency = 'money', price = 20},
            { name = 'rollingpapers',currency = 'money', price = 8 },
            { name = 'gps',currency = 'money', price = 200 },
            { name = 'marlboro',currency = 'money', price = 50 } 
        }
    },

    SkillsShop = {
        Locations = {
            {x = 1683.0, y = 4855.2, z = 41.04},
        },
        Items = {
            { name = 'sandworms' , currency = 'money', price = 8},
            { name = 'snakeskin' , currency = 'money', price = 22},
            { name = 'cowhide' , currency = 'money', price = 28},
            { name = 'leather' , currency = 'money', price = 35},
            { name = 'ball_of_wool' , currency = 'money', price = 7},
            { name = 'WEAPON_HATCHET' , currency = 'money', price = 75},
            { name = 'feather' , currency = 'money', price = 4},
            { name = 'bait' , currency = 'money', price = 6},
            { name = 'chisel' , currency = 'money', price = 25},
            { name = 'WEAPON_BATTLEAXE' , currency = 'money', price = 75},
        }
    },

    PoliceFoodShop = {
        Locations = {
            {x = 461.08, y = -982.4, z = 29.68},
            {x = 449.84, y = -973.92, z = 33.96},
            {x = 439.4, y = -978.64, z = 29.68},
        },
        Items = {
            { name = 'donut' , currency = 'money', price = 4},
            { name = 'cocacola' , currency = 'money', price = 16},
            { name = 'fanta' , currency = 'money', price = 14},
            { name = 'pepsi' , currency = 'money', price = 12},
            { name = 'sprite' , currency = 'money', price = 18},
            { name = 'water',currency = 'money', price = 10 }
        }
    },

    Pharmacy = {
        Locations = {
            {x = 306.88, y = -595.0, z = 42.28},
            {x = -260.32, y = 6327.88, z = 31.4},
            {x = 1831.12, y = 3675.36, z = 33.28},
            {x = 301.06, y = -733.57, z = 28.37}
        },
        Items = {
            { name = 'medkit' , currency = 'money', price = 50},
            { name = 'bandage' , currency = 'money', price = 25}
        }
    },

    Ambulance = {
        Locations = {
            {x = -258.68, y = 6317.48, z = 31.4},
            {x = 1843.96, y = 3681.72, z = 33.28},
            {x = 306.72, y = -601.88, z = 43.28 - 0.9}
        },
        Items = {
            { name = 'medkit' , currency = 'money', price = 0},
            { name = 'phone' , currency = 'money', price = 0},
            { name = 'gps' , currency = 'money', price = 0},
            { name = 'radio' , currency = 'money', price = 0},
            { name = 'bodycamera' , currency = 'money', price = 0},
            { name = 'bandage' , currency = 'money', price = 0},
            { name = 'WEAPON_FIREEXTINGUISHER' , currency = 'money', price = 0},
        }
    },

    RobsLiquor = {
        Locations = {
            { x = 1398.41, y = 3607.05, z = 34.02 },
            { x = 1168.88, y = 2707.6, z = 37.24 },
            { x = -2969.76, y = 388.0, z = 14.06 },
            { x = 1136.96, y = -979.0, z = 45.44 },
            { x = -1486.45, y = -382.37, z = 39.17 },
            { x = -1226.24, y = -907.44, z = 11.335 }
        },
        Items = {
            { name = 'beer' , currency = 'money', price = 25},
            { name = 'corona',currency = 'money', price = 25 },
            { name = 'wine',currency = 'money', price = 50 },
            { name = 'vodka',currency = 'money', price = 45 }
        }
    },

    HardWare = {
        Locations = {
            {x = 55.24, y = -1739.44, z = 28.6},
            { x = 2748.32, y = 3472.56, z = 54.68 }
        },
        Items = {
            { name = 'ring_mould',currency = 'money', price = 150 },
            { name = 'necklace_mould' , currency = 'money', price = 150},
            { name = 'bracelet_mould',currency = 'money', price = 150 },
            { name = 'amulet_mould' , currency = 'money', price = 150},
            { name = 'repairkit_engine',currency = 'money', price = 4550 },
            { name = 'repairkit_bodywork' , currency = 'money', price = 4250},
            { name = 'carcleaner',currency = 'money', price = 950 },
            { name = 'chisel' , currency = 'money', price = 35},
            { name = 'lockpick',currency = 'money', price = 25 },
            { name = 'binoculars' , currency = 'money', price = 75},
            { name = 'zipties' , currency = 'money', price = 75},
            { name = 'fishingnet',currency = 'money', price = 15 },
            { name = 'fishingrod' , currency = 'money', price = 25},
            { name = 'flyfishingrod',currency = 'money', price = 35 },
            { name = 'harpoon' , currency = 'money', price = 45},
            { name = 'lobsterpot',currency = 'money', price = 85 },
            { name = 'feather' , currency = 'money', price = 1},
            { name = 'lightdivingsuit',currency = 'money', price = 2500 },
            { name = 'divingsuit' , currency = 'money', price = 5000},
            { name = 'rope' , currency = 'money', price = 250},
            { name = 'pliers' , currency = 'money', price = 100},
            { name = 'oxycutter',currency = 'money', price = 25 },
            { name = 'WEAPON_CROWBAR',currency = 'money', price = 80 },
        }
    },

    PrisonShop = {
        Locations = {
            {x = 1780.72, y = 2559.0, z = 45.68}
        },
        Items = {
            { name = 'sandwich' , currency = 'money', price = 8},
            { name = 'water',currency = 'money', price = 10 }
        }
    },

    WeaponShop = {
        Locations = {
            { x = -662.180,   y = -934.961,   z = 20.829 },
            { x = 810.25,     y = -2157.60,   z = 28.62 },
            { x = 1693.44,    y = 3760.16,    z = 33.71 },
            { x = -330.24,    y = 6083.88,    z = 30.45 },
            { x = 252.63,     y = -50.00,     z = 68.94 },
            { x = 22.09,      y = -1107.28,   z = 28.82 },
            { x = 2567.69,    y = 294.38,     z = 107.73 },
            { x = -1117.58,   y = 2698.61,    z = 17.55 },
            { x = 842.44,     y = -1033.42,   z = 27.19 }
        },

        Items = {
            { name = "WEAPON_PISTOL", currency = 'money', price = 4500},
            { name = "WEAPON_CERAMICPISTOL", currency = 'money', price = 5400},
            { name = "WEAPON_VINTAGEPISTOL", currency = 'money', price = 7500},
            { name = "WEAPON_KNIFE", currency = 'money', price = 650},
            { name = "WEAPON_BAT", currency = 'money', price = 250},
            { name = "WEAPON_CROWBAR", currency = 'money', price = 450},
            { name = "armour1", currency = 'money', price = 1200},
            { name = "pistolmag", currency = 'money', price = 120},
            { name = "GADGET_PARACHUTE", currency = 'money', price = 5000},
            { name = "flashlight", currency = 'money', price = 250}
        }
    },

    BlackMarket = {
        Locations = {
            {x = -1568.72, y = -3224.36, z = 26.32-0.9},
        },

        Items = {
            { name = "WEAPON_DBSHOTGUN", currency = 'black_money', price = 18500},
            { name = "WEAPON_SAWNOFFSHOTGUN", currency = 'black_money', price = 29750},
            { name = "WEAPON_COMPACTRIFLE", currency = 'black_money', price = 49500},
            { name = "WEAPON_GUSENBERG", currency = 'black_money', price = 65000},
            { name = "ammoshotgun", currency = 'black_money', price = 550},
            { name = "riflemag", currency = 'black_money', price = 1250},
            { name = "smgmag", currency = 'black_money', price = 850},
            { name = "scope", currency = 'black_money', price = 1750},
            { name = "suppressor", currency = 'black_money', price = 3250},
            { name = "mag", currency = 'black_money', price = 2950},
            { name = "drummag", currency = 'black_money', price = 4850},
        }
    },

    BlackMarket2 = {
        Locations = {
            {x = -2351.44, y = 3252.4, z = 92.92-0.9},
        },

        Items = {
            { name = "cuff_keys", currency = 'black_money', price = 500},
            { name = "blank_plate", currency = 'black_money', price = 1500},
            { name = "gruppecard", currency = 'black_money', price = 5000},

            { name = "raspberry", currency = 'black_money', price = 2000},
            { name = "tunerchip", currency = 'black_money', price = 10500},
            { name = "laptop_h", currency = 'black_money', price = 5000},

            -- { name = "thermal_charge", currency = 'black_money', price = 8500},
            -- { name = "mini_c4", currency = 'black_money', price = 10000},
            -- { name = "normal_c4", currency = 'black_money', price = 15000},
            
            -- { name = "weedburn", currency = 'black_money', price = 2800},
            -- { name = "cokeburn", currency = 'black_money', price = 4500},
            -- { name = "methburn", currency = 'black_money', price = 6500},
        }
    },

    Bar = {
        Locations = {
            {x = -2335.8, y = -661.88, z = 12.4},
            {x = -2336.0, y = -654.96, z = 12.4},
            {x = -562.52, y = 285.56, z = 81.16},
            {x = 129.28, y = -1283.92, z = 28.28}, -- VU
            {x = 118.96, y = -1302.52, z = 28.28}, -- VU
            {x = -2376.08, y = -658.44, z = 9.56},
            {x = -2244.76, y = -624.6, z = 13.8},
            {x = 2491.08, y = -283.88, z = -57.72},
            {x = 2493.8, y = -245.48, z = -54.12},
            {x = 936.12, y = 28.28, z = 70.84},
            {x = 942.44, y = 25.36, z = 70.84},
            {x = 945.6, y = 16.76, z = 115.16},
            {x = -1376.08, y = -628.28, z = 30.8},
            {x = -1391.4, y = -604.84, z = 30.32}
            
        },

        Items = {
            { name = "beer", currency = 'money', price = 25},
            { name = "corona", currency = 'money', price = 25},
            { name = "wine", currency = 'money', price = 50},
            { name = "whisky", currency = 'money', price = 25},
            { name = "tequila", currency = 'money', price = 35},
            { name = "vodka", currency = 'money', price = 45},
            { name = 'pizza' , currency = 'money', price = 8},
            { name = 'burger' , currency = 'money', price = 15},
            { name = 'sandwich' , currency = 'money', price = 8},
            { name = 'donut' , currency = 'money', price = 4},
            { name = 'cocacola' , currency = 'money', price = 16},
            { name = 'fanta' , currency = 'money', price = 14},
            { name = 'pepsi' , currency = 'money', price = 12},
            { name = 'sprite' , currency = 'money', price = 18},
            { name = 'water',currency = 'money', price = 10 }
        }
    },

    PoliceShop = {
       Locations = {
			{x = 131.12, y = -762.08, z = 242.16},
            {x = 1860.52, y = 3692.97, z = 33.25},
            {x = 479.24, y = -996.76, z = 29.68},
            {x = 482.56, y = -995.16, z = 29.68},
        },
        Items = {
            { name = 'bandage', currency = 'money', price = 0, minGrade = 0 },
            { name = 'bodycam', currency = 'money', price = 0, minGrade = 0 },
            { name = 'radio', currency = 'money', price = 0, minGrade = 0 },
            { name = 'phone', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_NIGHTSTICK', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_STUNGUN', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_FLASHLIGHT', currency = 'money', price = 0, minGrade = 0 },
            { name = 'cuffs', currency = 'money', price = 0, minGrade = 0 },
            { name = 'cuff_keys', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_COMBATPISTOL', currency = 'money', price = 0, minGrade = 1 },
            { name = 'pistolmag', currency = 'money', price = 0, minGrade = 1 },
            { name = 'flashlight', currency = 'money', price = 0, minGrade = 2 },
            { name = 'WEAPON_PUMPSHOTGUN', currency = 'money', price = 0, minGrade = 3 },
            { name = 'ammoshotgun', currency = 'money', price = 0, minGrade = 3 },
            { name = 'WEAPON_SMG', currency = 'money', price = 0, minGrade = 4 },
            { name = 'smgmag', currency = 'money', price = 0, minGrade = 4 },
            { name = 'WEAPON_CARBINERIFLE', currency = 'money', price = 0, minGrade = 5 },
			{ name = 'scope', currency = 'money', price = 0, minGrade = 6 },
            { name = 'suppressor', currency = 'money', price = 0, minGrade = 8 },
            { name = 'grip', currency = 'money', price = 0, minGrade = 6 },
			{ name = 'binoculars', currency = 'money', price = 0, minGrade = 5 },
            { name = 'mag', currency = 'money', price = 0, minGrade = 8 },
			{ name = 'armour2', currency = 'money', price = 0, minGrade = 3 },
            { name = 'riflemag', currency = 'money', price = 0, minGrade = 6 },
        }
    },

    FireShop = {
       Locations = {
            {x = 1207.2, y = -1478.6, z = 33.94},
            {x = 1685.2, y = 3580.68, z = 32.88}
        },
        Items = {
            { name = 'bodycam', currency = 'money', price = 0 },
            { name = 'radio', currency = 'money', price = 0 },
            { name = 'phone', currency = 'money', price = 0 },
            { name = 'WEAPON_FIREEXTINGUISHER', currency = 'money', price = 0 },
            { name = 'divingsuit', currency = 'money', price = 0 },
            { name = 'medkit', currency = 'money', price = 0 },
            { name = 'bandage', currency = 'money', price = 0 },
            { name = 'WEAPON_FLASHLIGHT', currency = 'money', price = 0 },
        }
    },

    Gruppe6 = {
        Locations = {
            {x = -1311.16, y = -819.72, z = 16.16},
        },
        Items = {
            { name = 'radio', currency = 'money', price = 0, minGrade = 0 },
            { name = 'phone', currency = 'money', price = 0, minGrade = 0 },
            { name = 'cuffs', currency = 'money', price = 0, minGrade = 0 },
            { name = 'cuff_keys', currency = 'money', price = 0, minGrade = 0 },
            { name = 'bodycam', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_NIGHTSTICK', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_STUNGUN', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_FLASHLIGHT', currency = 'money', price = 0, minGrade = 0 },
            { name = 'WEAPON_COMBATPISTOL', currency = 'money', price = 0, minGrade = 0 },
            { name = 'pistolmag', currency = 'money', price = 0, minGrade = 0 },
			{ name = 'WEAPON_SMG', currency = 'money', price = 0, minGrade = 0 },
			{ name = 'smgmag', currency = 'money', price = 0, minGrade = 0 },
        }
    },


    MastersLounge = {
        Locations = {
            {x = 5011.96, y = -5758.16, z =  27.84}
        },
        Items = {
            { name = 'vodka', currency = 'money', price = 99999999 },
        }
    },

    License = {
        Locations = {
            {x = -553.96, y = -191.48, z = 37.2},
        }
    }
}

---------------------------------------------------
------- DISABLED FEATURES
---------------------------------------------------
Config.InitialLockerRentPrice = 450
Config.DailyLockerRentPrice = 250
Config.LockerExterior = vector3(-286.23, 280.84, 89.89)
Config.LockerInterior = vector3(1173.24, -3196.62, -39.01)

Config.Lockers = {

	-- ['locker1'] = {
	-- 	locker_name = 'Kluisje #1',
	-- 	location = vector3(1161.87, -3199.07, -39.01),
	-- },
	
	-- ['locker2'] = {
	-- 	locker_name = 'Kluisje #2',
	-- 	location = vector3(1156.71, -3195.3, -39.01),
	-- },
	
	-- ['locker3'] = {
	-- 	locker_name = 'Kluisje #3',
	-- 	location = vector3(1157.61, 3198.92, -39.01),
	-- },
	
	-- ['locker4'] = {
	-- 	locker_name = 'Kluisje #4',
	-- 	location = vector3(1167.05, -3194.64, -39.01),
	-- },
	
	-- ['locker5'] = {
	-- 	locker_name = 'Kluisje #5',
	-- 	location = vector3(1173.29, -3194.47, -39.01),
	-- },
	
	-- ['locker6'] = {
	-- 	locker_name = 'Kluisje #6',
	-- 	location = vector3(1171.73, -3198.81, -39.01),
	-- },
	
}


Config.VaultBox = 'p_v_43_safe_s'
Config.Vault = {
	-- vault = {
	-- 	coords = vector3(-544.61, -197.39, 37.22),
	-- 	heading = 298.73,
	-- 	needItemLicense = 'apple', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
	-- 	InfiniteLicense = true, -- Should one License last forever?
	-- 	show=true,
	-- },
	-- police = { -- blokkenpark kantoor
	-- 	coords = vector3(452.99, -973.48, 29.69),
	-- 	heading = 270.00,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- ambulance = {
	-- 	coords = vector3(337.54, -584.01, 27.9),
	-- 	heading = 74.52,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- mechanic = {
	-- 	coords = vector3(-201.79, -1314.48, 30.09),
	-- 	heading = 358.01,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- nightclub = {
	-- 	coords = vector3(-1496.15, 124.61, 55.67),
	-- 	heading = 229.74,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- bahamas = {
	-- 	coords = vector3(-1382.2, -610.09, 29.82),
	-- 	heading = 344.18,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- taxi = {
	-- 	coords = vector3(891.57, -173.07, 73.67),
	-- 	heading = 57.67,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- pizza = {
	-- 	coords = vector3(447.25, 140.5, 99.2),
	-- 	heading = 160.61,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- cardealer = {
	-- 	coords = vector3(-12.53, -1663.25, 32.04),
	-- 	heading = 169.96,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- starbucks = {
	-- 	coords = vector3(-632.35, 226.28, 80.88),
	-- 	heading = 86.65,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- gemeente = {
	-- 	coords = vector3(-549.06, -199.27, 69.98),
	-- 	heading = 212.86,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- pilot = {
	-- 	coords = vector3(-931.34, -2933.14, 12.95),
	-- 	heading = 327.39,
	-- 	needItemLicense = false,
	-- 	show=true,
	-- },
	-- peaky = {
	-- 	coords = vector3(1391.55,1158.81,114.33),
	-- 	heading = 270.52,
	-- 	needItemLicense = false,
	-- 	show=false,
	-- },
	-- diablo = {
	-- 	coords = vector3(-96.3,817.32,235.72),
	-- 	heading = 192.25,
	-- 	needItemLicense = false,
	-- 	show=false,
	-- },
	-- pericolo = {
	-- 	coords = vector3(-1798.63,451.42,127.29),
	-- 	heading = 0.55,
	-- 	needItemLicense = false,
	-- 	show=true,
	
	-- }
}
