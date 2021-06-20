fx_version 'bodacious'
game 'gta5'

 
files {
    'data/vehicles.meta',
    'data/carvariations.meta',
    'data/handling.meta',
}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

client_script "@igAnticheat/client/cl_loader.lua"