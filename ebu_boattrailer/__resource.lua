resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'EBU Boat Trailer'

version '0.0.1'

client_scripts {
	'config.lua',
	'client/client.lua'
}

client_script "@anticheat/acloader.lua"
client_script "@igAnticheat/client/cl_loader.lua"