fx_version 'bodacious'
game 'gta5'

description 'Disc Death'

version '1.0.1'

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/death.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua',
    'server/death.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"