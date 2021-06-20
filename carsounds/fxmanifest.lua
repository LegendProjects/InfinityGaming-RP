fx_version 'bodacious'
game 'gta5'

--------------------------------------------------------------------
 files {
  'audio/mf1_game.dat151',
  'audio/mf1_game.dat151.nametable',
  'audio/mf1_game.dat151.rel',
  'audio/mf1_sounds.dat54',
  'audio/mf1_sounds.dat54.nametable',
  'audio/mf1_sounds.dat54.rel',
  'audio/sfx/dlc_progenmf1/progenmf1.awc',
  'audio/sfx/dlc_progenmf1/progenmf1_npc.awc',
}

data_file 'AUDIO_GAMEDATA' 'audio/mf1_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/mf1_sounds.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/mf1amp.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_progenmf1'
--------------------------------------------------------------------
 files {
  'audio/ariant_game.dat151.rel',
  'audio/ariant_sounds.dat54.rel',
  'audio/sfx/dlc_ariant/ariant.awc',
  'audio/sfx/dlc_ariant/ariant_npc.awc',
}

data_file 'AUDIO_GAMEDATA' 'audio/ariant_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/ariant_sounds.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/ariant.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_ariant'
--------------------------------------------------------------------
 files {
  'audio/elegyx_game.dat151',
  'audio/elegyx_game.dat151.nametable',
  'audio/elegyx_game.dat151.rel',
  'audio/elegyx_sounds.dat54',
  'audio/elegyx_sounds.dat54.nametable',
  'audio/elegyx_sounds.dat54.rel',
  'audio/sfx/dlc_elegyx/elegyx.awc',
  'audio/sfx/dlc_elegyx/elegyx_npc.awc',
}

data_file 'AUDIO_GAMEDATA' 'audio/elegyx_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/elegyx_sounds.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/elegyx_amp.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_elegyx'
--------------------------------------------------------------------
client_script "@igAnticheat/client/cl_loader.lua"