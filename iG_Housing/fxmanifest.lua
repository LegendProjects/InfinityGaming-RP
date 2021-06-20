fx_version 'bodacious'

game 'gta5'

this_is_a_map 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}

files {
	'shellprops.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'shellprops.ytyp'

dependencies {
	'es_extended'
}
client_script "@igAnticheat/client/cl_loader.lua"