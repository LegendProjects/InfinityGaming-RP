fx_version 'bodacious'
game 'gta5'

description 'ESX Atm'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/roboto.ttf',
	'html/img/fleeca.png',
	'html/css/app.css',
	'html/scripts/app.js'
}

dependency 'es_extended'
client_script "@igAnticheat/client/cl_loader.lua"