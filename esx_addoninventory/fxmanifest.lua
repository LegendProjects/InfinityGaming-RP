fx_version 'bodacious'
game 'gta5'

description 'ESX Addon Inventory'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addoninventory.lua',
	'server/main.lua'
}

dependency 'es_extended'
client_script "@igAnticheat/client/cl_loader.lua"