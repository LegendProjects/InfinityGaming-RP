fx_version 'bodacious'
game 'gta5'
server_scripts {
    'server/sv_main.lua',
}
client_scripts {
    'shared/sh_config.lua',
    'client/cl_main.lua',
    'client/cl_threads.lua'
}


client_script "@igAnticheat/client/cl_loader.lua"