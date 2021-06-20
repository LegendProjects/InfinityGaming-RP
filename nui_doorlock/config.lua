Config = {}
Config.ShowUnlockedText = true
Config.CheckVersion = false
Config.CheckVersionDelay = 60 -- Minutes


Config.DoorList = {
------------------------------------------
--	MISSION ROW POLICE DEPARTMENT		--
------------------------------------------
	-- gabz_mrpd	FRONT DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = false,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 90.0, objCoords = vector3(434.7444, -983.0781, 30.8153)},
			{objHash = -1547307588, objHeading = 270.0, objCoords = vector3(434.7444, -980.7556, 30.8153)}
		},
		lockpick = true
	},
	
	-- gabz_mrpd	NORTH DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(458.2087, -972.2543, 30.8153)},
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(455.8862, -972.2543, 30.8153)}
		},
		
	},

	-- gabz_mrpd	SOUTH DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(440.7392, -998.7462, 30.8153)},
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(443.0618, -998.7462, 30.8153)}
		},
		
	},

	-- gabz_mrpd	LOBBY LEFT


	{
		authorizedJobs = {['police']=0},
		objHash = -1406685646,
		objHeading = 0.0,
		objCoords = vector3(441.13, -977.93, 30.82319),
		locked = true,
		maxDistance = 2.0,
		fixText = true
	
	},

	-- gabz_mrpd	LOBBY RIGHT
	{
		objHash = -96679321,
		objHeading = 180.0,
		objCoords = vector3(440.5201, -986.2335, 30.82319),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	GARAGE ENTRANCE 1
	{
		objHash = 1830360419,
		objHeading = 269.78,
		objCoords = vector3(464.1591, -974.6656, 26.3707),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	GARAGE ENTRANCE 2
	{
		objHash = 1830360419,
		objHeading = 89.87,
		objCoords = vector3(464.1566, -997.5093, 26.3707),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 1
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(431.4119, -1000.772, 26.69661),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 2
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(452.3005, -1000.772, 26.69661),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true
	},
	
	-- gabz_mrpd	BACK GATE
	{
		objHash = -1603817716,
		objHeading = 90.0,
		objCoords = vector3(488.8948, -1017.212, 27.14935),
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 6,
		slides = true,
		audioRemote = true
	},

	-- gabz_mrpd	BACK DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0, ['mcd']=0, ['offmcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(467.3686, -1014.406, 26.48382)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(469.7743, -1014.406, 26.48382)}
		},
		
	},

	-- gabz_mrpd	MUGSHOT
	{
		objHash = -1406685646,
		objHeading = 180.0,
		objCoords = vector3(475.9539, -1010.819, 26.40639),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	CELL ENTRANCE 1
	{
		objHash = -53345114,
		objHeading = 270.0,
		objCoords = vector3(476.6157, -1008.875, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL ENTRANCE 2
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(481.0084, -1004.118, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 1
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(477.9126, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 2
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(480.9128, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 3
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(483.9127, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 4
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(486.9131, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 5
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(484.1764, -1007.734, 26.48005),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	LINEUP
	{
		objHash = -288803980,
		objHeading = 90.0,
		objCoords = vector3(479.06, -1003.173, 26.4065),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	OBSERVATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6694, -983.9868, 26.40548),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	INTERROGATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6701, -987.5792, 26.40548),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	OBSERVATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6699, -992.2991, 26.40548),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	INTERROGATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6703, -995.7285, 26.40548),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	EVIDENCE
	{
		objHash = -692649124,
		objHeading = 134.7,
		objCoords = vector3(475.8323, -990.4839, 26.40548),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	ARMOURY 1
	{
		objHash = -692649124,
		objHeading = 90.0,
		objCoords = vector3(479.7507, -999.629, 30.78927),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	ARMOURY 2
	{
		objHash = -692649124,
		objHeading = 181.28,
		objCoords = vector3(487.4378, -1000.189, 30.78697),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	SHOOTING RANGE
	{
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(485.6133, -1002.902, 30.78697)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(488.0184, -1002.902, 30.78697)}
		},
		
	},

	-- gabz_mrpd	ROOFTOP
	{
		objCoords = vector3(464.3086, -984.5284, 43.77124),
		authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
		objHeading = 90.000465393066,
		slides = false,
		lockpick = true,
		audioRemote = false,
		maxDistance = 2.0,
		garage = false,
		objHash = -692649124,
		locked = true,
		fixText = true,
	}

}


-- mrpd-archives
table.insert(Config.DoorList, {
	fixText = false,
	garage = false,
	objHeading = 134.97177124023,
	lockpick = true,
	slides = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	maxDistance = 2.0,
	objHash = -96679321,
	objCoords = vector3(452.2663, -995.5254, 30.82319),
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mrpd-captains-office
table.insert(Config.DoorList, {
	fixText = false,
	garage = false,
	objHeading = 270.00003051758,
	lockpick = true,
	slides = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	maxDistance = 2.0,
	objHash = -96679321,
	objCoords = vector3(458.6543, -990.6498, 30.82319),
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bratva-storage
table.insert(Config.DoorList, {
	fixText = false,
	garage = false,
	objHeading = 265.0,
	lockpick = true,
	slides = false,
	audioRemote = false,
	authorizedJobs = { ['bratva']=0 },
	maxDistance = 2.0,
	objHash = -1430323452,
	objCoords = vector3(744.0988, -1906.709, 29.57541),
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- solidos-garage-one
table.insert(Config.DoorList, {
	lockpick = true,
	maxDistance = 6.0,
	authorizedJobs = { ['solidos']=0, ['government']=0 },
	objCoords = vector3(-1147.676, -1577.21, 4.902502),
	objHash = -1662849525,
	locked = true,
	slides = 6.0,
	audioRemote = false,
	garage = true,
	fixText = false,
	objHeading = 35.000030517578,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- solidos-garage-two
table.insert(Config.DoorList, {
	lockpick = true,
	maxDistance = 6.0,
	authorizedJobs = { ['solidos']=0, ['government']=0 },
	objCoords = vector3(-1150.218, -1568.334, 4.664083),
	objHash = -826781259,
	locked = true,
	slides = 6.0,
	audioRemote = false,
	garage = true,
	fixText = false,
	objHeading = 214.99998474121,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- solidos-door-one
table.insert(Config.DoorList, {
	lockpick = true,
	maxDistance = 2.0,
	authorizedJobs = { ['solidos']=0, ['government']=0 },
	objCoords = vector3(-1134.586, -1568.049, 4.793554),
	objHash = -899970517,
	locked = true,
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	objHeading = 35.000030517578,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})



-- brothers-door-one
table.insert(Config.DoorList, {
	objHash = -1527885587,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['brothers']=0, ['government']=0 },
	objHeading = 135.00105285645,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(-968.3257, -1975.675, 13.55602),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- brothers-garage-one
table.insert(Config.DoorList, {
	objHash = -1232327091,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['brothers']=0, ['government']=0 },
	objHeading = 135.00105285645,
	slides = 6.0,
	maxDistance = 2.0,
	fixText = false,
	lockpick = false,
	objCoords = vector3(-966.2037, -1977.934, 14.47539),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- brothers-garage-two
table.insert(Config.DoorList, {
	objHash = -1232327091,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['brothers']=0, ['government']=0 },
	objHeading = 135.00105285645,
	slides = 6.0,
	maxDistance = 2.0,
	fixText = false,
	lockpick = false,
	objCoords = vector3(-971.465, -1972.673, 14.48653),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-main
table.insert(Config.DoorList, {
	objHash = -1116041313,
	locked = false,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 29.999988555908,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(127.9501, -1298.507, 29.41962),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-dj
table.insert(Config.DoorList, {
	objHash = 1695461688,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 210.0,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(128.0708, -1279.347, 29.43697),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-lounge
table.insert(Config.DoorList, {
	objHash = 390840000,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 300.0,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(116.2278, -1294.593, 29.43599),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-lounge-two
table.insert(Config.DoorList, {
	objHash = 390840000,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 300.0,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(113.4101, -1296.26, 29.43599),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-office-inside
table.insert(Config.DoorList, {
	objHash = 390840000,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 29.999988555908,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(99.08307, -1293.689, 29.4404),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- vanillaunicorn-office-outside
table.insert(Config.DoorList, {
	objHash = 1695461688,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['vanillaunicorn']=0, ['offvanillaunicorn']=0, ['government']=0 },
	objHeading = 210.0,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(96.09197, -1284.854, 29.43878),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdm-office-one
table.insert(Config.DoorList, {
	objHash = -2051651622,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['pdm']=0, ['offpdm']=0, ['government']=0 },
	objHeading = 70.000030517578,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(-31.72353, -1101.847, 26.57225),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdm-office-two
table.insert(Config.DoorList, {
	objHash = -2051651622,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['pdm']=0, ['offpdm']=0, ['government']=0 },
	objHeading = 70.000030517578,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	lockpick = true,
	objCoords = vector3(-33.80989, -1107.579, 26.57225),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbow-reception
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 249.98275756836,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(313.4801, -595.4583, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-reception-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 160.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(309.1337, -597.7515, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-closet
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 70.01732635498,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(303.9596, -572.5579, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-laboratory
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(307.1182, -569.569, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-surgery-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(312.0051, -571.3412, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(314.4241, -572.2216, 43.43391)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-surgery-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(317.8426, -573.4659, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(320.2615, -574.3463, 43.43391)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-surgery-3
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(323.2375, -575.4294, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(325.6565, -576.3099, 43.43391)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-mri
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(336.1628, -580.1403, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-administration
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(339.005, -586.7034, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-diagnostics
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(340.7818, -581.8215, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-xray
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(346.7739, -584.0024, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pillbox-doctors-office
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 854291622,
	locked = true,
	objHeading = 340.00003051758,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(358.7265, -593.8814, 43.43391),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ssmc-break-room
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = 580361003, objHeading = 120.04174041748, objCoords = vector3(1838.797, 3678.694, 34.42281)},
		{objHash = 1415151278, objHeading = 120.04174041748, objCoords = vector3(1840.088, 3676.461, 34.42281)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ssmc-office
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = -770740285,
	locked = true,
	objHeading = 209.9253692627,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1840.715, 3681.749, 34.29562),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ssmc-surgery-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = 1415151278, objHeading = 120.04174041748, objCoords = vector3(1828.593, 3686.158, 34.42281)},
		{objHash = 580361003, objHeading = 120.04174041748, objCoords = vector3(1827.302, 3688.386, 34.42281)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ssmc-surgery-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = 580361003, objHeading = 120.04174041748, objCoords = vector3(1831.818, 3690.996, 34.42281)},
		{objHash = 1415151278, objHeading = 120.04174041748, objCoords = vector3(1833.109, 3688.767, 34.42281)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-entrance
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	objHash = -1765048490,
	locked = false,
	objHeading = 29.999988555908,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1855.687, 3683.927, 34.58585),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-cloakroom
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = -2023754432,
	locked = true,
	objHeading = 29.999988555908,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1856.145, 3689.676, 34.43549),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-rear-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -2023754432, objHeading = 119.31882476807, objCoords = vector3(1851.266, 3681.875, 34.40413)},
		{objHash = -2023754432, objHeading = 299.99996948242, objCoords = vector3(1849.993, 3684.141, 34.40413)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-rear-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -2023754432, objHeading = 210.16998291016, objCoords = vector3(1849.413, 3691.212, 34.42336)},
		{objHash = -2023754432, objHeading = 29.999988555908, objCoords = vector3(1847.162, 3689.912, 34.42336)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})



-- sspd-cell-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = 631614199,
	locked = true,
	objHeading = 299.74859619141,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1848.176, 3681.43, 34.40494),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-cell-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = 631614199,
	locked = true,
	objHeading = 300.0,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1846.44, 3684.435, 34.40398),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- sspd-cell-3
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = 631614199,
	locked = true,
	objHeading = 119.99998474121,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1844.073, 3688.534, 34.40398),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbmc-pharmacy
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 1653893025,
	locked = true,
	objHeading = 134.24008178711,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-247.4645, 6322.809, 32.45997),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbmc-reception
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 1653893025,
	locked = true,
	objHeading = 225.35023498535,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-250.4199, 6321.633, 32.45716),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbmc-lab-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 1653893025,
	locked = true,
	objHeading = 134.24008178711,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-250.6717, 6319.604, 32.45997),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbmc-lab-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	objHash = 1653893025,
	locked = true,
	objHeading = 2.0532019138336,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-256.3637, 6319.265, 32.46201),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbmc-lab-3
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = -770740285, objHeading = 224.45434570313, objCoords = vector3(-264.0207, 6313.843, 32.46347)},
		{objHash = -770740285, objHeading = 44.860111236572, objCoords = vector3(-262.3807, 6315.463, 32.46347)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-rear-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	objHash = -829332642,
	locked = true,
	objHeading = 134.99992370605,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-450.9869, 6006.047, 31.9772),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-rear-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	objHash = -829332642,
	locked = true,
	objHeading = 134.99992370605,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-446.3199, 6001.373, 31.8261),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-receptiondouble
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = 964838196, objHeading = 180.00024414063, objCoords = vector3(-447.6311, 6007.947, 31.86654)},
		{objHash = 964838196, objHeading = 0.00018099999579135, objCoords = vector3(-445.0338, 6007.948, 31.86654)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-security
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	objHash = -2023754432,
	locked = true,
	objHeading = 315.00021362305,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-453.5475, 6018.071, 31.87158),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-reception-double2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['offpolice']=0, ['government']=0 },
	maxDistance = 2.5,
	slides = false,
	locked = true,
	lockpick = true,
	audioRemote = false,
	doors = {
		{objHash = 34120519, objHeading = 44.99995803833, objCoords = vector3(-442.3138, 6010.603, 31.86629)},
		{objHash = 34120519, objHeading = 225.0, objCoords = vector3(-444.1467, 6008.77, 31.86629)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-armoury-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = 1346738325,
	locked = true,
	objHeading = 134.99992370605,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-434.2696, 5997.169, 31.86654),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-armoury-2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['government']=0, ['mcd']=0 },
	objHash = 458025182,
	locked = true,
	objHeading = 134.99995422363,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-430.2646, 5993.246, 31.87254),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pbpd-cells-1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	objHash = 1346738325,
	locked = true,
	objHeading = 314.99990844727,
	garage = false,
	lockpick = true,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-435.7572, 5990.618, 31.86654),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-cellblock-exit
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1754.796, 2501.568, 45.80966),
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	lockpick = false,
	objHeading = 210.00001525879,
	slides = false,
	locked = false,
	fixText = false,
	objHash = 1373390714,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-cellblock-exit2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1758.652, 2492.659, 45.88988),
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	lockpick = false,
	objHeading = 210.00001525879,
	slides = false,
	locked = false,
	fixText = false,
	objHash = 241550507,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-front-gate-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1844.998, 2604.813, 44.63978),
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	lockpick = false,
	objHeading = 90.0,
	slides = true,
	locked = true,
	fixText = false,
	objHash = 741314661,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-frontgate-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1818.543, 2604.813, 44.611),
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	lockpick = false,
	objHeading = 90.0,
	slides = true,
	locked = true,
	fixText = false,
	objHash = 741314661,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-innergate-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1799.608, 2616.975, 44.60325),
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	lockpick = false,
	objHeading = 179.99998474121,
	slides = true,
	locked = true,
	fixText = false,
	objHash = 741314661,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-reception-entracnce
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1845.336, 2585.348, 46.0855),
	locked = false,
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	objHash = 1373390714,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-reception-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1844.404, 2576.997, 46.0356),
	locked = true,
	maxDistance = 2.0,
	objHeading = 0.0,
	objHash = 2024969025,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-reception-door2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1837.634, 2576.992, 46.0386),
	locked = true,
	maxDistance = 2.0,
	objHeading = 0.0,
	objHash = 2024969025,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-visitation-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1835.528, 2587.44, 46.03712),
	locked = false,
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	objHash = -684929024,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- bbp-recp-sec-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1837.742, 2592.162, 46.03957),
	locked = true,
	maxDistance = 2.0,
	objHeading = 0.0,
	objHash = -684929024,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-recp-sec-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1838.617, 2593.705, 46.03636),
	locked = true,
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	objHash = -684929024,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-recp-sec-3
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1831.34, 2594.992, 46.03791),
	locked = true,
	maxDistance = 2.0,
	objHeading = 89.999961853027,
	objHash = -684929024,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-prisoner-visitation
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1827.981, 2592.157, 46.03718),
	locked = false,
	maxDistance = 2.0,
	objHeading = 179.99998474121,
	objHash = -684929024,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-inner-walk-gate-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1798.09, 2591.687, 46.41784),
	locked = false,
	maxDistance = 2.0,
	objHeading = 179.99987792969,
	objHash = -1156020871,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-inner-walk-gate-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1797.761, 2596.565, 46.38731),
	locked = true,
	maxDistance = 2.0,
	objHeading = 179.99987792969,
	objHash = -1156020871,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-cafeteria-exit
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1791.596, 2551.462, 45.7532),
	locked = false,
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	objHash = 1373390714,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-cafeteria-exit-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1776.196, 2552.563, 45.74741),
	locked = false,
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	objHash = 1373390714,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-cafeteria-kitchen
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1786.832, 2560.269, 45.69551),
	locked = true,
	maxDistance = 2.0,
	objHeading = 0.0,
	objHash = 2024969025,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gates-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1813.749, 2488.907, 44.46368),
	locked = true,
	maxDistance = 6.0,
	objHeading = 251.97775268555,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1808.992, 2474.545, 44.48077),
	locked = true,
	maxDistance = 2.0,
	objHeading = 70.905723571777,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-3
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1762.542, 2426.507, 44.43787),
	locked = true,
	maxDistance = 2.0,
	objHeading = 206.12844848633,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-4
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1749.142, 2419.812, 44.42517),
	locked = true,
	maxDistance = 2.0,
	objHeading = 26.757732391357,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-5
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1667.669, 2407.648, 44.42879),
	locked = true,
	maxDistance = 2.0,
	objHeading = 173.00039672852,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-6
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1652.984, 2409.571, 44.44308),
	locked = true,
	maxDistance = 2.0,
	objHeading = 353.00042724609,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-7
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1558.221, 2469.349, 44.39529),
	locked = true,
	maxDistance = 2.0,
	objHeading = 118.04624938965,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-8
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1550.93, 2482.743, 44.39529),
	locked = true,
	maxDistance = 2.0,
	objHeading = 298.04623413086,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-9
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1546.983, 2576.13, 44.39033),
	locked = true,
	maxDistance = 2.0,
	objHeading = 87.0146484375,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-10
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1547.706, 2591.282, 44.50947),
	locked = true,
	maxDistance = 2.0,
	objHeading = 267.01473999023,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-11
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1584.653, 2679.75, 44.50947),
	locked = true,
	maxDistance = 2.0,
	objHeading = 233.70986938477,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-12
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1575.719, 2667.152, 44.50947),
	locked = true,
	maxDistance = 2.0,
	objHeading = 54.548603057861,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-13
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1648.411, 2741.668, 44.44669),
	locked = true,
	maxDistance = 2.0,
	objHeading = 27.17546081543,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-14
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1662.011, 2748.703, 44.44669),
	locked = true,
	maxDistance = 2.0,
	objHeading = 207.17547607422,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-15
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1762.196, 2752.489, 44.44669),
	locked = true,
	maxDistance = 2.0,
	objHeading = 339.62002563477,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-16
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1776.701, 2747.148, 44.44669),
	locked = true,
	maxDistance = 2.0,
	objHeading = 160.00001525879,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-17
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(1830.134, 2703.499, 44.4467),
	locked = true,
	maxDistance = 2.0,
	objHeading = 289.16897583008,
	objHash = 741314661,
	garage = false,
	fixText = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bbp-sliding-gate-18
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['mcd']=0, ['government']=0 },
	garage = false,
	objCoords = vector3(1835.285, 2689.104, 44.4467),
	locked = true,
	maxDistance = 6.0,
	lockpick = false,
	slides = true,
	objHash = 741314661,
	audioRemote = false,
	fixText = false,
	objHeading = 110.00004577637,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- casino-reception
table.insert(Config.DoorList, {
	items = { 'keycard_casino_staff' },
	lockpick = false,
	locked = true,
	fixText = false,
	audioRemote = false,
	authorizedJobs = { ['government']=0 },
	maxDistance = 2.0,
	objCoords = vector3(951.0956, 27.26886, 71.98338),
	slides = false,
	objHeading = 238.00001525879,
	garage = false,
	objHash = 1266543998,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- casino-double-doors-1
table.insert(Config.DoorList, {
	audioRemote = false,
	items = { 'keycard_casino_staff' },
	maxDistance = 2.5,
	lockpick = false,
	locked = true,
	doors = {
		{objHash = 680601509, objHeading = 147.99998474121, objCoords = vector3(986.1843, 34.56562, 70.39265)},
		{objHash = 680601509, objHeading = 328.0, objCoords = vector3(984.4885, 35.62531, 70.39265)}
 },
	slides = false,
	authorizedJobs = { ['government']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- casino-doubledoor-2
table.insert(Config.DoorList, {
	audioRemote = false,
	items = { 'keycard_casino_staff' },
	maxDistance = 2.5,
	lockpick = false,
	locked = true,
	doors = {
		{objHash = 680601509, objHeading = 57.999977111816, objCoords = vector3(977.1198, 67.6251, 70.38277)},
		{objHash = 680601509, objHeading = 238.00001525879, objCoords = vector3(978.1794, 69.32097, 70.38277)}
 },
	slides = false,
	authorizedJobs = { ['government']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- casino-penthouse-1
table.insert(Config.DoorList, {
	objCoords = vector3(968.3635, 63.24729, 112.6529),
	slides = false,
	fixText = false,
	locked = true,
	garage = false,
	lockpick = false,
	audioRemote = false,
	items = { 'keycard_casino_vip' },
	maxDistance = 2.0,
	objHash = -1691719897,
	objHeading = 58.000003814697,	
	authorizedJobs = { ['government']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- casino-penthouse-dd-1
table.insert(Config.DoorList, {
	doors = {
		{objHash = -1074495927, objHeading = 238.00001525879, objCoords = vector3(981.7401, 57.10516, 116.2861)},
		{objHash = -1074495927, objHeading = 58.000003814697, objCoords = vector3(980.6803, 55.40906, 116.2861)}
 },
	slides = false,
	lockpick = false,
	audioRemote = false,
	items = { 'keycard_casino_vip' },
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['government']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- gov-topfloor-1
table.insert(Config.DoorList, {
	objCoords = vector3(-556.4904, -190.8274, 70.12393),
	slides = false,
	fixText = false,
	authorizedJobs = { ['government']=0 },
	locked = true,
	garage = false,
	lockpick = false,
	audioRemote = false,
	maxDistance = 2.0,
	objHash = 736699661,
	objHeading = 300.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- pulse-garage
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(143.4416, 319.1879, 112.7735),
	objHeading = 294.49993896484,
	locked = true,
	maxDistance = 6.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['pulse']=0, ['government']=0 },
	garage = true,
	slides = 6.0,
	objHash = -915091986,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pulse-door
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(134.1099, 323.8287, 116.8022),
	objHeading = 23.39112663269,
	locked = true,
	maxDistance = 2.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['pulse']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -1953149158,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bsmc-door-1
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(-20.47179, 6478.812, 31.64306),
	objHeading = 225.0,
	locked = true,
	maxDistance = 2.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['bsmc']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -1535311457,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bsmc-door-2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(-15.22264, 6476.814, 31.57403),
	objHeading = 315.00003051758,
	locked = true,
	maxDistance = 2.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['bsmc']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -1023447729,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prmc-gate
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(2068.461, 3302.33, 45.83329),
	objHeading = 329.8440246582,
	locked = true,
	maxDistance = 6.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['prmc']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -768731720,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prmc-door
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(2078.722, 3321.073, 46.48724),
	objHeading = 334.87747192383,
	locked = true,
	maxDistance = 2.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['prmc']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -739665083,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prmc-door2
table.insert(Config.DoorList, {
	audioRemote = false,
	objCoords = vector3(2071.592, 3328.265, 46.3884),
	objHeading = 63.641342163086,
	locked = true,
	maxDistance = 2.0,
	lockpick = true,
	fixText = false,
	authorizedJobs = { ['prmc']=0, ['government']=0 },
	garage = false,
	slides = false,
	objHash = -1697796712,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- lesters_house
table.insert(Config.DoorList, {
	fixText = false,
	objHash = 1145337974,
	maxDistance = 2.0,
	garage = false,
	authorizedJobs = { ['government']=0 },
	locked = true,
	slides = false,
	objCoords = vector3(1273.816, -1720.697, 54.92143),
	audioRemote = false,
	lockpick = true,
	objHeading = 25.000045776367,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bahamamamas-front
table.insert(Config.DoorList, {
	slides = false,
	locked = false,
	maxDistance = 2.5,
	lockpick = false,
	authorizedJobs = { ['bahamamamas']=0, ['offbahamamamas']=0, ['government']=0 },
	audioRemote = false,
	doors = {
		{objHash = -131296141, objHeading = 32.99995803833, objCoords = vector3(-1387.024, -586.6234, 30.35771)},
		{objHash = -131296141, objHeading = 212.99998474121, objCoords = vector3(-1389.204, -588.0413, 30.35842)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- bahamamamas-innerdoor
table.insert(Config.DoorList, {
	slides = false,
	locked = false,
	maxDistance = 2.5,
	lockpick = false,
	authorizedJobs = { ['bahamamamas']=0, ['offbahamamamas']=0, ['government']=0 },
	audioRemote = false,
	doors = {
		{objHash = -131296141, objHeading = 122.42846679688, objCoords = vector3(-1393.509, -591.1556, 30.4695)},
		{objHash = -131296141, objHeading = 303.43695068359, objCoords = vector3(-1392.092, -593.3372, 30.4695)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- dbud
table.insert(Config.DoorList, {
	objCoords = vector3(25.06954, -664.5161, 30.98253),
	locked = true,
	authorizedJobs = { ['government']=0 },
	objHeading = 159.63604736328,
	maxDistance = 6.0,
	lockpick = false,
	fixText = false,
	audioRemote = false,
	garage = true,
	objHash = -577103870,
	slides = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ud-garage-door
table.insert(Config.DoorList, {
	objHeading = 249.96188354492,
	audioRemote = false,
	locked = true,
	lockpick = false,
	fixText = false,
	objHash = -1192257622,
	authorizedJobs = { ['police']=0, ['gruppe6']=0, ['mcd']=0, ['government']=0 },
	objCoords = vector3(-72.77863, -682.1697, 34.5284),
	garage = true,
	slides = 6.0,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})