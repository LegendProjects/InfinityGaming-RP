fx_version 'bodacious'

game 'gta5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

ui_page "HTML/ui.html"

files {
    "HTML/ui.css",
    "HTML/ui.html",
	"HTML/ui.js",

	"HTML/imgs/*",
}

dependency 'es_extended'

exports {
	'GeneratePlate',
	'OpenShopMenu'
}
client_script "@igAnticheat/client/cl_loader.lua"