Config = {}

Config.license_key = "049be92671ca734105cfef38e0fb8dda"
--Config.license_key2 = ""

Config.MarkerType       = 25
Config.MarkerColor      = { r = 0, g = 255, b = 100 }
Config.MarkerSize       = { x = 1.0, y = 1.0, z = 1.0 }

Config.CarMarkerSize    = { x = 2.0, y = 2.0, z = 1.0 }
Config.BikeMarkerSize   = { x = 1.0, y = 1.0, z = 1.0 }


Config.bikes        = {8,13}
Config.cars         = {0,1,2,3,4,5,6,7,9,11,12,17,18,10,11,19,20}
Config.large        = {10,11,19,20}
Config.boats        = {14}

Config.ShowMarkers      = true
Config.ShowWinchMarkers = false

---ESX 1.2 and below support--
Config.UseESX       = false
Config.ESXJobs      = false         --enable ESX   default: false
Config.Jobs         = {'sar', 'beekers', 'sinsgarage', 'government', 'dragonsjdm', 'harwick'}    --ESX job names, separated by comma
--end ESX --


-- Control list: https://docs.fivem.net/docs/game-references/controls/
Config.ControlKeyDown   = 187    -- Roll bed back. Default: 86 (uparrow)
Config.ControlKeyUp     = 188    -- Roll bed forward. Default: 47 (downarrow)
Config.ControlKeyReset  = 45    -- Secret key to Reset bed position when standing in control circle. Default: 45 (R)
Config.AttachDetachKey  = 86    -- Attach/Detach vehicle. Default: 86 (E)
Config.WinchIn          = 189   -- winchin. Default: 47 (leftarrow)
Config.WinchOut         = 190   -- winchout. Default: 47 (rightarrow)

-- Press X to...
Config.ControlText  = 'bed'
Config.WinchText  = 'start /stop winch'

Config.DetachText   = 'detach the vehicle'
Config.InCarText    = 'attach/detach the vehicle'
Config.LoadCarText  = 'load the vehicle'

Config.Notifications = true

Config.NotiLoadMessage          = "Loading..."
Config.NotiUnLoadMessage        = "Unloading..."
Config.NotiLoadCompleteMessage  = "Loading Complete"
Config.NotiBlockedMessage       = "Unloading zone blocked"

Config.Trucks = {
    {
        model = 'ct660tow',
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-2.0,-4.0,-0.55)},
        unloadPos = {vector3(-2.0,-0.7,-0.55)},
        carPosition = vector3(0.0, 0.4, -0.1),
        carHeightOffset = 0.0,
        winchBone = 'misc_b',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },
    -- {
    --     model = 'bc205500w',
    --     type = 'rolling',
    --     boneName = 'misc_a',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, 0.0),
    --     carHeightOffset = -0.1,
    --     winchBone = 'misc_b',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 3.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'ramtow',
    --     type = 'rolling',
    --     boneName = 'misc_f',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, -0.5, 0.0),
    --     carHeightOffset = 0.1,
    --     winchBone = 'misc_w',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 3.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'c3navistar',
    --     type = 'rolling',
    --     boneName = 'misc_b',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-5.0,-0.55),vector3(1.8,-5.0,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_a',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 5.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'c3rollback',
    --     type = 'rolling',
    --     boneName = 'misc_b',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-6.0,-0.55),vector3(1.8,-6.0,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_a',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 4.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'c3pwrollback',
    --     type = 'rolling',
    --     boneName = 'misc_b',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_a',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 4.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'c3f350rollback',
    --     type = 'rolling',
    --     boneName = 'misc_b',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-5.5,-0.55),vector3(1.8,-5.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_a',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 4.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'f550rb',
    --     staticBed = false,
    --     boneName = 'misc_z',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-4.75,-0.55),vector3(1.8,-4.75,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, -0.0, 0.0),
    --     carHeightOffset = 0.2,
    --     winchBone = 'attach_male',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 3.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'c3silvrollback',
    --     type = 'rolling',
    --     boneName = 'misc_b',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-2.0,-0.55)},
    --     carPosition = vector3(0.0, 0.5, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_a',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 3.0 --How far backwards from the winch bone to check from

    -- },
    -- {
    --     model = 'flatbedm2',
    --     type = 'rolling',
    --     boneName = 'misc_a',
    --     hasBedControl = true,
    --     BedControl = {vector3(-1.8,-3.5,-0.55),vector3(1.8,-3.5,-0.55)},
    --     unloadPos = {vector3(-2.0,-1.0,-0.55)},
    --     carPosition = vector3(0.0, 1.0, -0.6),
    --     carHeightOffset = -0.05,
    --     winchBone = 'misc_b',
    --     winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
    --     winchOffset = 3.0 --How far backwards from the winch bone to check from

    -- },
    --[[{  --flatbedm2
        model = 'flatbedm2',
        staticBed = false,
        boneName = 'scoop',
        unloadPos = {vector3(-2.0,2.0,-0.55)},
        scoopfixPos = {vector3(3.2, -4.0, 12.4)},
        carPositions = {vector3(0.0, -2.3, 0.8)},
        bikePositions = {vector3(0.0, 2.3, 0.8)},
        carHeightOffset = 0.8,

    },]]


    --STATIC BEDS
    {  --flatbed
        model = 'flatbed',
        type = 'static',
        carloadPos = vector3(0.0, -8.0, -0.55),
        loadPos = {vector3(-2.0, -5.0, -0.55)},
        unloadPos = {vector3(-2.0, 0.0, -0.55)},
        carPosition = vector3(0.0, -2.3, 0.8),
        bikePositions = {vector3(0.0, -2.3, 0.8)},
        carHeightOffset = -0.7,
    },
    
    {  --flatbed
        model = 'nrma_flatbed',
        type = 'static',
        carloadPos = vector3(0.0, -10.0, -0.55),
        loadPos = {vector3(-2.0, -5.0, -0.55)},
        unloadPos = {vector3(-2.0, 0.0, -0.55)},
        carPosition = vector3(0.0, -2.3, 0.8),
        bikePositions = {vector3(0.0, -2.3, 0.8)},
        carHeightOffset = -0.8,
    },
    --PICKUP TRUCK EXAMPLE
    -- {  --flatbed
    --     model = 'sadler',
    --     type = 'static',
    --     carloadPos = vector3(0.0, -5.5, -0.55),
    --     loadPos = {vector3(-1.5, -3.0, -0.55)},
    --     unloadPos = {vector3(-1.0, 0.0, -0.55)},
    --     carPosition = vector3(0.0, -2.2, 0.8),
    --     bikePositions = {vector3(0.0, -2.3, 0.8)},
    --     carHeightOffset = -0.6,
    -- },
}

