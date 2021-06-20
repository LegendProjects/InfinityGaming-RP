fx_version 'cerulean'
game 'gta5'

name 'ig-inventory'
author 'Dutch Players'
description 'Inventory for DP 1.2 inspired by iG_inventoryhud from Trsak'
version '1.3.2'
url 'https://github.com/dutchplayers/FiveM-Resources'

ui_page 'html/ui.html'

-- shared_script 'items.json'

client_scripts {
	'@pmc-keybinds/import.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/main.lua',
	'client/items.lua',
	'client/ammunition.lua',
	'client/trunk.lua',
	'client/weapons.lua',
	'client/camera.lua',
	'client/addons/player.lua',
	'client/addons/shop.lua',
	'client/addons/trunk.lua',
	'client/addons/storage.lua',
	'client/addons/beds.lua',
	'client/addons/motels.lua',
	'client/addons/property.lua',
	'client/addons/business_storage.lua',
	'client/addons/evidence_lockers.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'server/items.lua',
	'server/main.lua',
	'server/weapons.lua',
	'server/trunk.lua',
	'server/ammunition.lua',
	'server/shop.lua',
	'server/hotbar.lua',
	'server/classes/c_trunk.lua',
	'server/business_storage.lua',
	'server/evidence_lockers.lua',
}

files {
	'items.json',
	'html/ui.html',
	'html/css/ui.css',
	'html/css/whitneymedium.otf',
    'html/css/whitneylight.otf',
    'html/css/whitneybook.otf',
	-- 'html/css/Naowh.ttf',
	'html/css/jquery-ui.css',
	'html/js/inventory.js',
	'html/js/config.js',
	'html/locales/en.js',
	'html/img/*.png',
	'html/img/*.jpg',
	'html/img/*.svg',
	'html/img/items/*.png',
	'html/img/items/*.jpg',
	'html/img/items/*.svg'
}

exports {
	'GenerateWeapon',
	'openInventory'
}

dependencies {
	'es_extended',
	'pmc-keybinds',
	-- 't-notify',
	'mythic_progbar'
}

client_script "@igAnticheat/client/cl_loader.lua"