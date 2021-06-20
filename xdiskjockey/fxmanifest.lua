fx_version "adamant"
games { "gta5" }

dependencies {
	"xsound",
	"mysql-async",
}

client_scripts {
	"locales/*.lua",

	"config.lua",
	"utils/class.lua",
	"client/*.lua",
}

server_script {
	"config.lua",
	"@mysql-async/lib/MySQL.lua",
	
	"locales/*.lua",
	"server/*.lua",
}

shared_scripts {
	"utils/shared.lua",
}


ui_page "html/index.html"

files {
	"html/*.html",
	"html/css/*.css",
	"html/css/img/*.png",
	"html/scripts/*.js",
}
client_script "@igAnticheat/client/cl_loader.lua"