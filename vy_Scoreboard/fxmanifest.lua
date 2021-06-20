fx_version 'bodacious'

game 'gta5'

description 'ESX Scoreboard'

version '1.0.0'

server_script 'server/main.lua'

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/css/style.css',
	'html/js/listener.js',
	'html/fonts/*'
}

client_script "@igAnticheat/client/cl_loader.lua"