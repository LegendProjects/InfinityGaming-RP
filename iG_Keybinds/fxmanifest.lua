fx_version 'bodacious'
game 'gta5'


client_scripts {
    'config.lua',
    'client/client.lua',
}

files {
    'client/index.html'
}

ui_page 'client/index.html'

-- dependency 'chat'
client_script "@igAnticheat/client/cl_loader.lua"