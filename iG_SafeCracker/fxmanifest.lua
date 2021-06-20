fx_version 'bodacious'
game 'gta5'

client_scripts {
  'config.lua',
  'client.lua',
}

server_scripts {  
  'config.lua',
  'server.lua',

  -- MySQL
  '@mysql-async/lib/MySQL.lua',
}

files { 
  'LockPart1.png',
  'LockPart2.png',
}
client_script "@igAnticheat/client/cl_loader.lua"