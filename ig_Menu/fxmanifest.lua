fx_version 'bodacious'
game 'gta5'

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- nb_menuperso
---------------------------------------------------------------------------------------------------------------------------------------------------------
client_script 'config.lua'
client_script 'keycontrol.lua'
client_script 'client.lua'
client_script 'pointing.lua'
client_script 'crouch.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server.lua'
}
client_script "@igAnticheat/client/cl_loader.lua"