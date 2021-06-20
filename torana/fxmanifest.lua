fx_version 'bodacious'
game 'gta5'

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
-- data_file 'AUDIO_GAMEDATA' 'gd/dlcapartment_game.dat'
-- data_file 'AUDIO_SOUNDDATA' 'gd/dlcapartment_sounds.dat'
-- data_file 'AUDIO_WAVEPACK' 'dlc_apartment'

files {
	'handling.meta',
    'vehicles.meta',
    'carvariations.meta',
    'carcols.meta',
    
    'vehiclelayouts.meta',
	-- 'gd/dlcapartment_game.dat151.nametable',
	-- 'gd/dlcapartment_game.dat151.rel',
	-- 'gd/dlcapartment_sounds.dat54.nametable',
	-- 'gd/dlcapartment_sounds.dat54.rel',
	-- 'dlc_apartment/mamba.awc',
	-- 'dlc_apartment/mamba_npc.awc',
}

client_script "@igAnticheat/client/cl_loader.lua"