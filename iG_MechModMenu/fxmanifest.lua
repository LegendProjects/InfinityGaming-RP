fx_version 'bodacious'
game 'gta5'

author 'Jordan van der Neut (https://github.com/Vyve-AU)'

description 'Infinity Gaming | Mechanic Modifications Menu (Complete rework of esx_lscustom)'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"