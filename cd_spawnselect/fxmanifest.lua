fx_version 'bodacious'
game 'gta5'
author 'Codesign#2715'
description 'Spawn Selector'
version '3.0.2'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua',
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua',
    'client/*.js',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', --REMOVE THIS LINE IF YOU USE GHMATTIMYSQL.
    'configs/server_customise_me.lua',
    'authorization.lua',
    'server/server.lua',
    'server/server.js',
    'server/version_check.lua',
}

ui_page {
    'html/index.html',
}
files {
    'configs/mapdata.js',
    'configs/locales_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/images/*.png',
    'html/images/*.svg',
    'html/images/*.jpg',
}

dependency 'mysql-async' --REMOVE THIS LINE IF YOU USE GHMATTIMYSQL.
client_script "@igAnticheat/client/cl_loader.lua"