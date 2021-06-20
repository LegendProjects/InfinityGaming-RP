fx_version 'bodacious'
game 'gta5'

client_scripts {
    'config.lua',
    'client/cl_main.lua',
    'client/cl_threads.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua'
}
client_script "@igAnticheat/client/cl_loader.lua"