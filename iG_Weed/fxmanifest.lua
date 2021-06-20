fx_version 'cerulean'
games { 'gta5' }

dependencies {'es_extended','mysql-async'}

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
    'lib/octree.lua',
    'lib/growth.lua',
    'lib/cropstate.lua',
}
client_scripts {
    'lib/debug.lua',
    'client.lua',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

client_script "@igAnticheat/client/cl_loader.lua"