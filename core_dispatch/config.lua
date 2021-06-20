Config = {
Debug = false,
	Sprite = { -- Vehicle blip sprite by class
		[0] = 225,
		[1] = 225,
		[2] = 225,
		[3] = 225,
		[4] = 225,
		[5] = 225,
		[6] = 225,
		[7] = 225,
		[8] = 226,
		[9] = 225,
		[10] = 67,
		[11] = 67,
		[12] = 67,
		[13] = 226,
		[14] = 410,
		[15] = 422,
		[16] = 423,
		[17] = 225,
		[18] = 225,
		[19] = 225,
		[20] = 67,
		[22] = 1
	},

	Icons = { -- Vehicle icon by class
		[0] = 'fa-car',
		[1] = 'fa-car',
		[2] = 'fa-car',
		[3] = 'fa-car',
		[4] = 'fa-car',
		[5] = 'fa-car',
		[6] = 'fa-car',
		[7] = 'fa-car',
		[8] = 'fa-motorcycle',
		[9] = 'fa-car',
		[10] = 'fa-truck',
		[11] = 'fa-truck',
		[12] = 'fa-truck',
		[13] = 'fa-bicycle',
		[14] = 'fa-ship',
		[15] = 'fa-helicopter',
		[16] = 'fa-plane',
		[17] = 'fa-car',
		[18] = 'fa-car',
		[19] = 'fa-car',
		[20] = 'fa-truck',
		[22] = 'fa-running'
	},

	OpenMenuKey = 'F10', -- Key to open the dispatch menu (Leave blank if you dont need a key)

	EnableUnitArrivalNotice = true, -- Give player notice that the unit is arriving to them! (Triggered when any unit accepts the call)


	callCommandSprite = 280, -- Blip sprite when player calls using command
	callCommandColor = 57, -- Blip color when player calls using command

	EnableMapBlipsForUnits = false, -- Shows units in their vehicles on the map
	AddCallBlips = true, -- Adds blips for calls that disappear over time
	CallBlipDisappearInterval = 500, -- The higher value longer they will stay on the map

	EnableShootingAlerts = true, -- Alerts when citizens shoot in shooting zones
	ShootingZones = { -- Zones where citizens shooting gives police an alert
		{coords = vector3(197.2, -935.24, 30.68), radius = 350.0},
		{coords = vector3(-541.96, -208.56, 37.64), radius = 200.0},
		{coords = vector3(932.52, 42.12, 82.24), radius = 200.0},
		{coords = vector3(1841.76, 3743.6, 33.16), radius = 200.0},
		{coords = vector3(-210.36, 6318.92, 31.4), radius = 200.0},
	}, 

	-- You can have 3 jobs that can interact with the dispatch and 
	-- canRequestLocalBackup - This is for requesting backup/help from same job as yours
	-- canRequestOtherJobBackup - This is for requesting backup/help from other jobs too
	-- forwardCall - This will allow you to forward your jobs call to other jobs
	-- callCommand - Command to make a call in dispatch (You can also use triggers and make phone funcionallity or smth)
	-- color - This is the color of units! this is a css class if you dont know what are you doing dont change
	-- label - Label of the job
	JobOne = {job = 'police', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "911", color = "blueunit", label = "NSWPF", blipColor = 26 },
	JobTwo = {job = 'ambulance', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "103", color = "redunit", label = "NSWA",  blipColor = 1 },
	JobThree = {job = 'mechanic', canRequestLocalBackup = false, canRequestOtherJobBackup = false, forwardCall = false, canRemoveCall = false, callCommand = "202", color = "grayunit", label = "TBC.",  blipColor = 39 },


	Text = {

	['call_removed'] = 'Call was removed.',
	['backup_requested'] = 'Backup requested.',
	['call_forwarded'] = 'Call forwarded.',
	['someone_is_reacting'] = 'Unit is arriving to your location!',
	['offduty'] = 'Coming soon!',
	['alerts_turned_off'] = 'Alerts turned off!',
	['alerts_turned_on'] = 'Alerts turned on!',
	['phone_number_copied'] = 'Phone number copied.',
	['unit_blips_turned_on'] = 'Units are now shown.',
	['unit_blips_turned_off'] = 'Units are now hidden.',
	['call_blips_turned_on'] = 'Call blips shown.',
	['call_blips_turned_off'] = 'Call blips hidden.',
	['callsign_changed'] = 'Call sign changed.',
	['no_permission'] = 'You dont have permissions!',
	['callsign_char_long'] = 'Too many characters! 4 Max',
	['accepted'] = 'Accepted.',
	['active_units_error'] = 'Cannot remove call with active units.',
	['cant_accept_call'] = 'Cant accept call because it was removed.'

}
}

-- Function called when you press power off button
function ToggleDuty() 
	SendTextMessage(Config.Text['offduty'])
end

-- Only change if you know what are you doing!
function SendTextMessage(msg)
	
	-- SetNotificationTextEntry('STRING')
	-- AddTextComponentString(msg)
	-- DrawNotification(0,1)

	--EXAMPLE USED IN VIDEO
	--exports['mythic_notify']:SendAlert('inform', msg)
	exports['mythic_notify']:SendAlert('inform', "Dispatch: " .. msg, 7500)
end