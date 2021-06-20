fx_version 'adamant'
game 'gta5'

description 'Theebu Flatbeds'

version '0.2.2'

client_scripts {
	'config.lua',
		'client/utils.lua',
	'ebu_flatbeds.net.dll',

	'client/client.lua'
}

server_scripts {
	'config.lua',
	'server/server.lua'
}
client_script "@igAnticheat/client/cl_loader.lua"