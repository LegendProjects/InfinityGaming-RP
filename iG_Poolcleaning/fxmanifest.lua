fx_version 'bodacious'
game 'gta5'

description 'ESX Pool Cleaner'

version '1.1'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'client/main.lua',
	'config.lua',
	'vehicles.meta',
	'carvariations.meta',
	'carcols.meta',
}

data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'server/main.lua',
	'config.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"