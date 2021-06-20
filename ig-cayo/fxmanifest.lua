fx_version 'bodacious'
game 'gta5'

server_scripts {
	'shared/sh_config.lua',
	'server/sv_main.lua',
	-- 'server/sv_usableitems.lua',
	-- 'server/sv_scavengers.lua',
	-- 'server/sv_looting.lua'
}

client_scripts {
	'shared/sh_config.lua',
	'client/cl_main.lua',
	'client/cl_zone.lua',
	-- 'client/cl_scavengers.lua',
	-- 'client/cl_usableitems.lua',
	'client/cl_fishing.lua',
	-- 'client/cl_slayer.lua',
	-- 'client/cl_masters.lua',
	-- 'client/cl_looting.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"