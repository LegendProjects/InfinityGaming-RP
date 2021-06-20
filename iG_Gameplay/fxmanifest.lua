fx_version 'adamant'
game 'gta5'

server_scripts {
	'cooldown_server.lua',
    'piggyback_server.lua',
    -- 'trafficlights_server.lua',
    -- 'bodybag_server.lua',
    'spikestrips_server.lua',
    'tackle_server.lua'
}

client_scripts {
    'config.lua',
    'cctv_client.lua',
    -- 'bodybag_client.lua',
    'anchor_client.lua',
    'spikestrips_client.lua',
	'cooldown_client.lua',
	'customplate_client.lua',
    'hideintrunk_client.lua',
    'piggyback_client.lua',
    'plateremover_client.lua',
    'richpresence_client.lua',
    'seatswitcher_client.lua',
    'showid_client.lua',
    'safezones_client.lua',
    -- 'trafficlights_client.lua',
    'vehiclepush_client.lua',
    -- 'wheelchair_client.lua',
    'enginetoggle_client.lua',
    'neontoggle_client.lua',
    'vehiclecommands_client.lua',
    'tackle_client.lua',
    'handsup_client.lua'
}

client_script "@igAnticheat/client/cl_loader.lua"