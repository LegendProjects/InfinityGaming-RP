fx_version 'bodacious'
game 'gta5'

server_scripts {
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/libraries/axios.min.js',
	'ui/libraries/vue.min.js',
	'ui/libraries/vuetify.css',
	'ui/libraries/vuetify.js',
	'ui/script.js',
	'ui/style.css',
	-- images
	'ui/img/Vennesa.png',
	'ui/img/Cathrine.png',
	'ui/img/Tatiana.png',
	'ui/img/Bootylicious.png',
	'ui/img/blowjob.png',
	'ui/img/sex.png',
}

dependencies {
    'mythic_notify',
}

client_script "@igAnticheat/client/cl_loader.lua"