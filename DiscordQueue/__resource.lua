resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "client.lua"

server_script "config.lua"
server_script "SharedQueue.lua"
server_script "server.lua"
client_script "@igAnticheat/client/cl_loader.lua"