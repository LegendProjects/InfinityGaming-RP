fx_version 'bodacious'
game 'gta5'

server_script {  
	'server/server.lua',
	'config.lua'
}

client_script {
	'client/client.lua',
	'config.lua'
}


client_script "@igAnticheat/client/cl_loader.lua"