fx_version 'bodacious'
game 'gta5'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/cl_callouts.lua',
	'client/cl_impound.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'data.json',
	'server/sv_impound.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"