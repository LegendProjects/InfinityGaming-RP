fx_version 'adamant'

game 'gta5'

description 'Disc DrugRuns'

version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    'config.lua',
    'server/main.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"