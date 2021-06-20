fx_version 'bodacious'
game 'gta5'

server_script{ 
	'server/sv_main.lua'
}

client_script {
	'shared/sh_config.lua',
	'client/cl_main.lua',
	'client/cl_threads.lua'
}


client_script "@igAnticheat/client/cl_loader.lua"