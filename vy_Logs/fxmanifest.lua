fx_version 'bodacious'
game 'gta5'

client_script 'client.lua'
server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'Logs/admin.log',
  'Logs/es_extended.log',
  'Logs/all.log',
  'config.lua',
  'server.lua',
  'sv_main.lua'
}
client_script "@igAnticheat/client/cl_loader.lua"