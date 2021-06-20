fx_version 'bodacious'
game 'gta5'

client_scripts {
    'shared/config.lua',
    'client/cl_doorcontroller.lua',
    'client/cl_base.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'shared/config.lua',
    'server/sv_base.lua'
}

dependancies {
    'datacrack',
    'iG_SafeCracker',
    'iG_Lockpicking'
}
client_script "@igAnticheat/client/cl_loader.lua"