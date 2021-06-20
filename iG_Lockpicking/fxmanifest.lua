fx_version 'bodacious'
game 'gta5'

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/script.js",
	"nui/ui.js",
	"nui/style.css",
}

client_script {
	'client.lua',
}

server_script {
  'server.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"