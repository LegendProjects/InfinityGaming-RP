fx_version 'bodacious'
game 'gta5'

name 'vy_Admin'
author 'Vyve - https://github.com/VyveAU'
version 'v1.0'

client_scripts{
    'config.lua',
    'client/cl_report.lua',
    'client/client.lua',
    'client/buttons_client.lua',
    'client/vehiclenames_client.lua',
   'client/noclip_client.lua'
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/sv_report.lua',
    'server/vehiclenames_server.lua',
    'server/server.lua' 
}
client_script "@igAnticheat/client/cl_loader.lua"