fx_version 'bodacious'
game 'gta5'

author "VYVE | twitch.tv/VyveAU"
description "[ANTICHEAT] DO NOT RESTART THIS RESOURCE!"

shared_script "shared/sh_config.lua"
-- server_script "connectqueue.lua"

-- server_script "shared/sh_queue.lua"
-- client_script "shared/sh_queue.lua"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "shared/sh_locale.lua",
    "locales/en.lua",
    -- "shared/sh_config.lua",
    -- "server/sv_config.lua",
    -- "shared/sh_queue.lua",
    -- "server/sv_queue.lua",
    "server/sv_main.lua",
    "server/sv_identifiers.lua",
    "server/sv_injection.lua"
}

client_scripts {
    -- "shared/sh_config.lua",
    -- "shared/sh_queue.lua",
    "client/cl_main.lua",
    "client/cl_injection.lua",
    "client/cl_enumerators.lua",
    "client/cl_loader.lua"
} 

server_exports {
	'getSharedObject'
}

dependencies {
    'mysql-async',
}