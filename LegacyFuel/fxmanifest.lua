fx_version 'bodacious'
game 'gta5'

server_scripts {
	'config.lua',
	'source/fuel_server.lua'
}

client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

client_script "@igAnticheat/client/cl_loader.lua"