fx_version 'bodacious'
game 'gta5'

client_scripts {
    'client/client.lua',
}

server_scripts {
    '@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    'server/server.lua',
    'server/sv_sync.lua'
}

dependencies {
	'mysql-async',
	'async'
}

exports {
    'AddSkillExperience'
}

client_script "@igAnticheat/client/cl_loader.lua"