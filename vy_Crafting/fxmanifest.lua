fx_version 'bodacious'
game 'gta5'

client_scripts {
    'client/client.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua',
    'config.lua'
}
client_script "@igAnticheat/client/cl_loader.lua"