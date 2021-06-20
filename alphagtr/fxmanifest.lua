fx_version 'bodacious'
game 'gta5'

--------------------------------------------------------------------
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

files {
'handling.meta',
'vehicles.meta',
'carcols.meta',
'carvariations.meta',
}
client_script "@igAnticheat/client/cl_loader.lua"