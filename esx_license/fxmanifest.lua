fx_version 'bodacious'

game 'gta5'

description 'ESX License'

version '1.0.1'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"