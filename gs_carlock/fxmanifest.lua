fx_version 'bodacious'
game 'gta5'

name 'gs_CarLock'
description 'Simple CarLock System'
author 'DJS - DGSNL RP'
version 'v1.04'
url 'https://discord.gg/xNh3TpS'

shared_script 'config.lua'
client_scripts {
	"@es_extended/locale.lua",
    "client.lua"
}

server_scripts {
	"server.lua",
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}
client_script "@igAnticheat/client/cl_loader.lua"