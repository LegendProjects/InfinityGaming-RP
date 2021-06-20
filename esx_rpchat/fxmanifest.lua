fx_version 'bodacious'
game 'gta5'

--[[

  ESX RP Chat

--]]


description 'ESX RP Chat'

version '1.0.0'

client_script 'client/main.lua'

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'

}

client_script "@igAnticheat/client/cl_loader.lua"