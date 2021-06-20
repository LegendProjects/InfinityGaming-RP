fx_version 'bodacious'
game 'gta5'

name 'Mythic Framework Notification System'
author 'Alzar - https://github.com/Alzar'
version 'v1.1.0'

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
	'html/css/whitneylight.otf',
	'html/css/whitneybook.otf',
	'html/css/whitneymedium.otf',
}

client_scripts {
	'client/main.lua',
}

exports {
	'SendAlert',
	'SendUniqueAlert',
	'PersistentAlert',
}
client_script "@igAnticheat/client/cl_loader.lua"