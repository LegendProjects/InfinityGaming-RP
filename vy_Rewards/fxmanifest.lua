fx_version 'bodacious'
game 'gta5'

name 'vy_Rewards'
author 'Vyve - https://github.com/VyveAU'
version 'v1.0'

client_scripts{
    -- 'config.lua',
    'client/main.lua'
}

server_scripts{
    -- 'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua' 
}
client_script "@igAnticheat/client/cl_loader.lua"