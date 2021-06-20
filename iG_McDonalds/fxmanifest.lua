fx_version 'adamant'

game 'gta5'


server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua'
}

dependencies {
	'es_extended',
	-- 'iG_BasicNeeds',
	'progressBars'
}

client_script "@igAnticheat/client/cl_loader.lua"