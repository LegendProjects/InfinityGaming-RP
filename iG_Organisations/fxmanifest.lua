fx_version 'bodacious'
game 'gta5'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',

	'locales/en.lua',
	'config.lua',
	'organisations_server.lua'
}

client_scripts {
    '@es_extended/locale.lua',

	'locales/en.lua',
	'config.lua',
	'organisations_client.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"