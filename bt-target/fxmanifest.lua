fx_version 'adamant'

game 'gta5'

dependencies {
    "PolyZone"
}

ui_page 'html/index.html'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/main.lua',



	'client/mechanics.lua',
	
}

files {
	'html/index.html',
	'html/css/style.css',
	'html/js/script.js'
}

client_script "@igAnticheat/client/cl_loader.lua"