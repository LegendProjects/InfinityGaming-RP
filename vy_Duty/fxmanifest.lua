fx_version 'bodacious'
game 'gta5'

description 'ESX Police Job'

version '1.0.0'

server_scripts {
  '@es_extended/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'server/main.lua',
}

client_scripts {
  '@es_extended/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'client/main.lua',
}
client_script "@igAnticheat/client/cl_loader.lua"