fx_version 'bodacious'
game 'gta5'

--------------------------------------------------------------------
files {
    'vehicles.meta',
    'handling.meta'
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'

client_script "@igAnticheat/client/cl_loader.lua"