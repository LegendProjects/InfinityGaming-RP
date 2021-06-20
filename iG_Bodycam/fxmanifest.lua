fx_version 'bodacious'
game 'gta5'

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}


files {
    'ui/js/app.js',
    'ui/index.html',
    'ui/css/style.css',
    'ui/fonts/*'
}

ui_page {
    'ui/index.html'
}
client_script "@igAnticheat/client/cl_loader.lua"