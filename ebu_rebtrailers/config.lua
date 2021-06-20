
Config = {}

Config.MarkerType       = 25
Config.MarkerColor      = { r = 0, g = 255, b = 100 }
Config.CarMarkerSize    = { x = 2.0, y = 2.0, z = 1.0 }
Config.BikeMarkerSize   = { x = 1.0, y = 1.0, z = 1.0 }

Config.DisplayMarkers   = true --Show green circles for interaction points

--Class definitions
Config.bikes = {8,13}
Config.cars  = {0,1,2,3,4,5,6,7,9,11,12,17,18}


AddTextEntry('VEH_E_DETATCH', 'Press ~INPUT_CONTEXT~ to detach the vehicle')        -- Text for external detach point
AddTextEntry('VEH_I_AORD', 'Press ~INPUT_CONTEXT~ to attach/detach the vehicle')    -- Text for in car attach/detach
AddTextEntry('VEH_I_RAMP', 'Press ~INPUT_CONTEXT~ to toggle ramp')                  -- Text for ramp
