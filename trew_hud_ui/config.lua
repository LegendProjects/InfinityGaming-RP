Config = {}

Config.Locale = 'en'

Config.serverLogo = 'https://i.imgur.com/AcgDL9f.png'

Config.font = {
	name 	= 'Montserrat',
	url 	= 'https://fonts.googleapis.com/css?family=Montserrat:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'default',
	AmPm		= false
}

Config.voice = {

	levels = {
		default = 10.0,
		shout = 15.0,
		whisper = 3.0,
		current = 0
	},
	
	keys = {
		distance 	= 'z',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 400,

	keys = {
		seatbelt 	= 'B',
		cruiser		= 'M',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'DOWN',
	}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= false,

	showWalletMoney 	= false,
	showBankMoney 		= false,
	showBlackMoney 		= false,
	showSocietyMoney	= false,

	showDate 			= false,
	showLocation 		= false,
	showVoice	 		= false,

	showHealth			= false,
	showArmor	 		= false,
	showStamina	 		= false,
	showHunger 			= false,
	showThirst	 		= false,
	showStress			= false,

	showMinimap			= false,

	showWeapons			= true,
}