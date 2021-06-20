local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

scanId = 0
cityRobbery = false
local myspawns = {}
CCTVCamLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Store Camera 1', ["recent"] = false },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Store Camera 2', ["recent"] = false },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Store Camera 3', ["recent"] = false },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' Store Camera 4', ["recent"] = false },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Store Camera 5', ["recent"] = false },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = ' Store Camera 6', ["recent"] = false },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' Store Camera 7', ["recent"] = false },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = ' Store Camera 8', ["recent"] = false },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Store Camera 9', ["recent"] = false },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Store Camera 10', ["recent"] = false },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Store Camera 11', ["recent"] = false },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = ' Store Camera 12', ["recent"] = false },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Store Camera 13', ["recent"] = false },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Store Camera 14', ["recent"] = false },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Store Camera 15', ["recent"] = false },
	[16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ['info'] = ' Store Camera 16', ["recent"] = false },
	[17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Store Camera 17', ["recent"] = false },
	[18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' Store Camera 18', ["recent"] = false },
	[19] =  { ['x'] = 733.45,['y'] = 127.58,['z'] = 80.69,['h'] = 285.51, ['info'] = ' Cam Power' },
	[20] =  { ['x'] = 1846.32,['y'] = 2597.93,['z'] = 45.64,['h'] = 311.88, ['info'] = ' Cam Jail Front' },
	[21] =  { ['x'] = 1807.71,['y'] = 2590.62,['z'] = 45.64,['h'] = 143.41, ['info'] = ' Cam Jail Prisoner Drop Off' },
	[22] =  { ['x'] = -644.24,['y'] = -241.11,['z'] = 37.97,['h'] = 282.81, ['info'] = ' Cam Jewelry Store' },
	[23] =  { ['x'] = -115.3,['y'] = 6441.41,['z'] = 31.53,['h'] = 341.95, ['info'] = ' Cam Paleto Bank Outside' },
	[24] =  { ['x'] = 240.07,['y'] = 218.97,['z'] = 106.29,['h'] = 276.14, ['info'] = ' Cam Main Bank 1' },
	[25] =  { ['x'] = -1313.08,['y'] = -835.28,['z'] = 18.16,['h'] = 351.96, ['info'] = ' Gruppe6 Building (Inside) ' },
	[26] =  { ['x'] = -1298.44,['y'] = -824.76,['z'] = 18.16,['h'] = 92.84, ['info'] = ' Gruppe6 Building (Inside) ' },
	[27] =  { ['x'] = -1310.96,['y'] = -817.68,['z'] = 18.08,['h'] = 97.28, ['info'] = ' Gruppe6 Building (Outside) ' },
	[28] =  { ['x'] = 7.64,['y'] = -692.4,['z'] = 33.32,['h'] = 73.68, ['info'] = ' Union Depository (Inside) ' },
	[29] =  { ['x'] = -9.64,['y'] = -655.8,['z'] = 33.44,['h'] = 276.68, ['info'] = ' Union Depository (Inside) ' },
	[30] =  { ['x'] = 18.16,['y'] = -659.96,['z'] = 33.76,['h'] = 291.96, ['info'] = ' Union Depository (Outside) ' },
	[31] =  { ['x'] = 3628.6,['y'] = 3741.28,['z'] = 31.68,['h'] = 121.64, ['info'] = ' Humane Labs (Inside) ' },
	[32] =  { ['x'] = 3419.64,['y'] = 3768.56,['z'] = 33.52,['h'] = 142.76, ['info'] = ' Humane Labs (Outside) ' },
	[33] =  { ['x'] = 3632.4,['y'] = 3746.48,['z'] = 30.52,['h'] = 14.32, ['info'] = ' Humane Labs (Outside) ' },
	[34] =  { ['x'] = 449.16,['y'] = -988.36,['z'] = 31.16,['h'] = 51.52, ['info'] = ' Mission Row PD (Inside) ' },
	[35] =  { ['x'] = 433.88,['y'] = -978.16,['z'] = 31.72,['h'] = 89.32, ['info'] = ' Mission Row PD (Outside) ' },
	[36] =  { ['x'] = 458.88,['y'] = -1022.12,['z'] = 29.24,['h'] = 91.4, ['info'] = ' Mission Row PD (Outside) ' },
	[37] =  { ['x'] = 301.36,['y'] = -581.76,['z'] = 43.96,['h'] = 213.36, ['info'] = ' Pillbox Hospital (Inside) ' },
	[38] =  { ['x'] = 290.32,['y'] = -615.96,['z'] = 44.2,['h'] = 10.44, ['info'] = ' Pillbox Hospital (Outside) ' },
	[39] =  { ['x'] = 301.12,['y'] = -574.88,['z'] = 44.28,['h'] = 132.44, ['info'] = ' Pillbox Hospital (Outside) ' },
	[40] =  { ['x'] = 1828.12,['y'] = 3673.32,['z'] = 35.28,['h'] = 281.8, ['info'] = ' Sandy Shores Hospital (Inside) ' },
	[41] =  { ['x'] = 1836.08,['y'] = 3672.12,['z'] = 34.28,['h'] = 212.12, ['info'] = ' Sandy Shores Hospital (Outside) ' },
	[42] =  { ['x'] = 1830.84,['y'] = 3692.96,['z'] = 34.24,['h'] = 36.64, ['info'] = ' Sandy Shores Hospital (Outside) ' },
	[43] =  { ['x'] = -252.64,['y'] = 6337.56,['z'] = 33.44,['h'] = 175.36, ['info'] = ' Paleto Bay Hospital (Inside) ' },
	[44] =  { ['x'] = -272.12,['y'] = 6321.12,['z'] = 33.44,['h'] = 329.96, ['info'] = ' Paleto Bay Hospital (Outside) ' },
	[45] =  { ['x'] = -239.6,['y'] = 6321.04,['z'] = 33.44,['h'] = 316.96, ['info'] = ' Paleto Bay Hospital (Outside) ' },


	[22] =  { ['x'] = -644.24,['y'] = -241.11,['z'] = 37.97,['h'] = 282.81, ['info'] = 'Vangelico Entrance (1)' },
	[46] =  { ['x'] = -662.24,['y'] = -234.11,['z'] = 44.97,['h'] = 208.24, ['info'] = 'Vangelico Entrance (2)' },
	[47] =  { ['x'] = -632.24,['y'] = -260.11,['z'] = 44.97,['h'] = 313.4, ['info'] = 'Vangelico Entrance (3)' },
	[48] =  { ['x'] = -629.24,['y'] = -229.11,['z'] = 57.97,['h'] = 92.88, ['info'] = 'Vangelico Roof (1)' },
	[49] =  { ['x'] = -632.24,['y'] = -233.11,['z'] = 38.97,['h'] = 248.88, ['info'] = 'Vangelico Interior (1)' },
	[50] =  { ['x'] = -617.24,['y'] = -233.11,['z'] = 39.97,['h'] = 83.88, ['info'] = 'Vangelico Interior (2)' },
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	  PlayerData = ESX.GetPlayerData()
	end
  end)

-- RegisterCommand("cctv", function (source, args, rawCommand)

-- 	local cam = args[1]

-- 	local xPlayer = ESX.GetPlayerData()
-- 	local job = xPlayer.job
-- 	local jobname = xPlayer.job.name
-- 	if job and jobname == 'police' or  then
-- 		TriggerEvent('cctv:camera', cam)
-- 	end

-- end)

inCam = false
cctvCam = 0
RegisterNetEvent("cctv:camera")
AddEventHandler("cctv:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		TriggerEvent('cctv:exitcamera')
	else
		if camNumber > 0 and camNumber < #CCTVCamLocations+1 then
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			TriggerEvent("cctv:startcamera",camNumber)
		else
			exports['mythic_notify']:SendAlert('error', "This camera appears to be faulty")
		end
	end
end)

RegisterNetEvent("cctv:exitcamera")
AddEventHandler("cctv:exitcamera", function()
	inCam = false
	PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
	Wait(250)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent("cctv:startcamera")
AddEventHandler("cctv:startcamera", function(camNumber)
	local camNumber = tonumber(camNumber)
	local x = CCTVCamLocations[camNumber]["x"]
	local y = CCTVCamLocations[camNumber]["y"]
	local z = CCTVCamLocations[camNumber]["z"]
	local h = CCTVCamLocations[camNumber]["h"]

	print("starting cam")
	inCam = true

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)
	local scaleform = RequestScaleformMovie("TRAFFIC_CAM")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	local lPed = GetPlayerPed(-1)
	cctvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cctvCam,x,y,z+1.2)						
	SetCamRot(cctvCam, -15.0,0.0,h)
	SetCamFov(cctvCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	PushScaleformMovieFunction(scaleform, "PLAY_CAM_MOVIE")
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	PopScaleformMovieFunctionVoid()

	while inCam do
		SetCamCoord(cctvCam,x,y,z+1.2)						
		PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
		PushScaleformMovieFunctionParameterFloat(GetEntityCoords(h).z)
		PushScaleformMovieFunctionParameterFloat(1.0)
		PushScaleformMovieFunctionParameterFloat(GetCamRot(cctvCam, 2).z)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(1)
	end
	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0)
	SetScaleformMovieAsNoLongerNeeded(scaleform)
	DestroyCam(cctvCam, false)
	SetNightvision(false)
	SetSeethrough(false)	

end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if inCam then

			local rota = GetCamRot(cctvCam, 2)

			if IsControlPressed(1, Keys['BACKSPACE']) then
				TriggerEvent('cctv:exitcamera')
			end

			if IsControlPressed(1, Keys['N4']) then
				SetCamRot(cctvCam, rota.x, 0.0, rota.z + 0.7, 2)
			end

			if IsControlPressed(1, Keys['N6']) then
				SetCamRot(cctvCam, rota.x, 0.0, rota.z - 0.7, 2)
			end

			if IsControlPressed(1, Keys['N8']) then
				SetCamRot(cctvCam, rota.x + 0.7, 0.0, rota.z, 2)
			end

			if IsControlPressed(1, Keys['N5']) then
				SetCamRot(cctvCam, rota.x - 0.7, 0.0, rota.z, 2)
			end
		end
	end
end)

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Core Thread Function
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5)
--         local pos = GetEntityCoords(GetPlayerPed(-1), false)
--         local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -2670.0, 1335.32, 144.24, false)
-- 		if distance <= 10.0 then
-- 			DrawMarker(25, -2670.0, 1335.32, 144.24, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, true, 2, true, false, false, false)
-- 		else
-- 			Citizen.Wait(500)
-- 		end
-- 		if distance <= 1.5 then
-- 			DrawText3Ds(-2670.0, 1335.32, pos.z, "Press ~g~[E]~s~ to use the ~y~Camera System~s~.")
-- 			if IsControlJustPressed(0, 38) then
-- 				OpenCCTVMenu()
-- 			end
-- 		end
--     end
-- end)

RegisterNetEvent('cctv:Menu')
AddEventHandler('cctv:Menu', function()
	OpenCCTVMenu()
end)	


function OpenCCTVMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = 'Pacific Standard Public Deposit', value = 'pacific'},
		{label = 'Blaine County Savings', value = 'blaine'},
		{label = 'Vangelico Fine Jewellery', value = 'vangelico'},
		{label = 'Boilingbroke Penitentiary', value = 'boilingbroke'},
		{label = '24/7 Supermarket', value = '24_7'},
		{label = 'LTD Gas Station', value = 'LTD'},
		{label = 'Gruppe6 Building', value = 'Gruppe6'},
		{label = 'Union Depository', value = 'union'},
		{label = 'Humane Labs', value = 'humane'},
		{label = 'Mission Row PD', value = 'mrpd'},
		{label = 'Pillbox Hospital', value = 'pillbox'},
		{label = 'Sandy Shores Hospital', value = 'ssh'},
		{label = 'Paleto Bay Hospital', value = 'pbh'},
		{label = 'Rob\'s Liquor Store', value = 'robs'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'camera_menu', {
		title    = 'CCTV Camera Menu',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == '24_7' then
			local elements = {
				{label = '24/7 - Innocence Blvd', value = 'store_camera_1'},
				{label = '24/7 - Clinton Ave', value = 'store_camera_6'},
				{label = '24/7 - Ineseno Rd', value = 'store_camera_9'},
				{label = '24/7 - Barbareno Rd', value = 'store_camera_10'},
				{label = '24/7 - Palomino Fwy', value = 'store_camera_11'},
				{label = '24/7 - Route 68', value = 'store_camera_13'},
				{label = '24/7 - Niland Ave & Alhambra Dr', value = 'store_camera_14'},
				{label = '24/7 - Senora Fwy (Sandy Shores)', value = 'store_camera_15'},
				{label = '24/7 - Senora Fwy (Paleto)', value = 'store_camera_18'}
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '24_7', {
				title    = '24/7 Supermarket',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_1' then
					TriggerEvent('cctv:camera', 1)
				elseif action == 'store_camera_6' then
					TriggerEvent('cctv:camera', 6)
				elseif action == 'store_camera_9' then
					TriggerEvent('cctv:camera', 9)
				elseif action == 'store_camera_10' then
					TriggerEvent('cctv:camera', 10)
				elseif action == 'store_camera_11' then
					TriggerEvent('cctv:camera', 11)
				elseif action == 'store_camera_13' then
					TriggerEvent('cctv:camera', 13)
				elseif action == 'store_camera_14' then
					TriggerEvent('cctv:camera', 14)
				elseif action == 'store_camera_15' then
					TriggerEvent('cctv:camera', 15)
				elseif action == 'store_camera_18' then
					TriggerEvent('cctv:camera', 18)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'pbh' then
			local elements = {
				{label = 'Paleto Bay Hospital - Inside', value = 'pbh_camera_1'},
				{label = 'Paleto Bay Hospital - Outside', value = 'pbh_camera_2'},
				{label = 'Paleto Bay Hospital - Outside', value = 'pbh_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pbh', {
				title    = 'Paleto Bay Hospital',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'pbh_camera_1' then
					TriggerEvent('cctv:camera', 43)
				elseif action == 'pbh_camera_2' then
					TriggerEvent('cctv:camera', 44)
				elseif action == 'pbh_camera_3' then
					TriggerEvent('cctv:camera', 45)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'ssh' then
			local elements = {
				{label = 'Sandy Shores Hospital - Inside', value = 'ssh_camera_1'},
				{label = 'Sandy Shores Hospital - Outside', value = 'ssh_camera_2'},
				{label = 'Sandy Shores Hospital - Outside', value = 'ssh_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ssh', {
				title    = 'Sandy Shores Hospital',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'ssh_camera_1' then
					TriggerEvent('cctv:camera', 40)
				elseif action == 'ssh_camera_2' then
					TriggerEvent('cctv:camera', 41)
				elseif action == 'ssh_camera_3' then
					TriggerEvent('cctv:camera', 42)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'pillbox' then
			local elements = {
				{label = 'Pillbox Hospital - Inside', value = 'pillbox_camera_1'},
				{label = 'Pillbox Hospital - Outside', value = 'pillbox_camera_2'},
				{label = 'Pillbox Hospital - Outside', value = 'pillbox_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pillbox', {
				title    = 'Pillbox Hospital',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'pillbox_camera_1' then
					TriggerEvent('cctv:camera', 37)
				elseif action == 'pillbox_camera_2' then
					TriggerEvent('cctv:camera', 38)
				elseif action == 'pillbox_camera_3' then
					TriggerEvent('cctv:camera', 39)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'mrpd' then
			local elements = {
				{label = 'Mission Row PD - Inside', value = 'mrpd_camera_1'},
				{label = 'Mission Row PD - Outside', value = 'mrpd_camera_2'},
				{label = 'Mission Row PD - Outside', value = 'mrpd_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mrpd', {
				title    = 'Mission Row PD',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'mrpd_camera_1' then
					TriggerEvent('cctv:camera', 34)
				elseif action == 'mrpd_camera_2' then
					TriggerEvent('cctv:camera', 35)
				elseif action == 'mrpd_camera_3' then
					TriggerEvent('cctv:camera', 36)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'humane' then
			local elements = {
				{label = 'Humane Labs - Inside', value = 'Humane_camera_1'},
				{label = 'Humane Labs - Outside', value = 'Humane_camera_2'},
				{label = 'Humane Labs - Outside', value = 'Humane_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'humane', {
				title    = 'Humane Labs',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'Humane_camera_1' then
					TriggerEvent('cctv:camera', 31)
				elseif action == 'Humane_camera_2' then
					TriggerEvent('cctv:camera', 32)
				elseif action == 'Humane_camera_3' then
					TriggerEvent('cctv:camera', 33)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'union' then
			local elements = {
				{label = 'Union Depository - Garage', value = 'Union_camera_1'},
				{label = 'Union Depository - Garage', value = 'Union_camera_2'},
				{label = 'Union Depository - Outside', value = 'Union_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'union', {
				title    = 'Union Depository',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'Union_camera_1' then
					TriggerEvent('cctv:camera', 28)
				elseif action == 'Union_camera_2' then
					TriggerEvent('cctv:camera', 29)
				elseif action == 'Union_camera_3' then
					TriggerEvent('cctv:camera', 30)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'Gruppe6' then
			local elements = {
				{label = 'Gruppe6 - Bay City Ave (inside)', value = 'gruppe6_camera_1'},
				{label = 'Gruppe6 - Bay City Ave (inside)', value = 'gruppe6_camera_2'},
				{label = 'Gruppe6 - Bay City Ave (Outside)', value = 'gruppe6_camera_3'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Gruppe6', {
				title    = 'Gruppe6 Building',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'gruppe6_camera_1' then
					TriggerEvent('cctv:camera', 25)
				elseif action == 'gruppe6_camera_2' then
					TriggerEvent('cctv:camera', 26)
				elseif action == 'gruppe6_camera_3' then
					TriggerEvent('cctv:camera', 27)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'LTD' then
			local elements = {
				{label = 'LTD - Davis Ave & Grove St', value = 'store_camera_2'},
				{label = 'LTD - Lindsay Circus & Palomino Ave', value = 'store_camera_3'},
				{label = 'LTD - West Mirror Drive', value = 'store_camera_5'},
				{label = 'LTD - Banham Canyon Dr', value = 'store_camera_7'},
				{label = 'LTD - Grapeseed Main St', value = 'store_camera_17'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'LTD', {
				title    = 'LTD Gas Station',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_2' then
					TriggerEvent('cctv:camera', 2)
				elseif action == 'store_camera_3' then
					TriggerEvent('cctv:camera', 3)
				elseif action == 'store_camera_5' then
					TriggerEvent('cctv:camera', 5)
				elseif action == 'store_camera_7' then
					TriggerEvent('cctv:camera', 7)
				elseif action== 'store_camera_17' then
					TriggerEvent('cctv:camera', 17)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'robs' then
			local elements = {
				{label = 'Rob\'s Liquor - San Andreas Ave', value = 'store_camera_4'},
				{label = 'Rob\'s Liquor - Great Ocean Hwy', value = 'store_camera_8'},
				{label = 'Rob\'s Liquor - Route 68', value = 'store_camera_12'},
				{label = 'Ace Liquor - Algonquin Blvd', value = 'store_camera_16'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'robs', {
				title    = 'Rob\'s Liquor',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_4' then
					TriggerEvent('cctv:camera', 4)
				elseif action == 'store_camera_8' then
					TriggerEvent('cctv:camera', 8)
				elseif action == 'store_camera_12' then
					TriggerEvent('cctv:camera', 12)
				elseif action == 'store_camera_16' then
					TriggerEvent('cctv:camera', 16)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'pacific' then
			local elements = {
				{label = 'Cashier\'s Desk', value = 'store_camera_24'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pacific', {
				title    = 'Pacific Standard Public Deposit',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_24' then
					TriggerEvent('cctv:camera', 24)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'blaine' then
			local elements = {
				{label = 'Entrance', value = 'store_camera_23'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'blaine', {
				title    = 'Blaine County Savings',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_23' then
					TriggerEvent('cctv:camera', 23)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vangelico' then
			local elements = {
				{label = 'Entrance', value = 'store_camera_22'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vangelico', {
				title    = 'Vangelico Fine Jewellery',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_22' then
					TriggerEvent('cctv:camera', 22)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'boilingbroke' then
			local elements = {
				{label = 'Main Gate', value = 'store_camera_20'},
				{label = 'Inner Ring', value = 'store_camera_21'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boilingbroke', {
				title    = 'Boilingbroke Penitentiary',
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				if action == 'store_camera_20' then
					TriggerEvent('cctv:camera', 20)
				elseif action == 'store_camera_21' then
					TriggerEvent('cctv:camera', 21)
				end
			end, function(data2, menu2)
				menu2.close()
			end)	
		end	
	end, function(data, menu)
		menu.close()
	end)
end
RegisterNetEvent('cctv:vangelicoCameras')
AddEventHandler('cctv:vangelicoCameras', function()
	OpenVangelicoCameras()
end)
function OpenVangelicoCameras()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = 'Entrance (1)', value = '22'},
		{label = 'Entrance (2)', value = '46'},
		{label = 'Entrance (3)', value = '47'},
		{label = 'Interior (1)', value = '49'},
		{label = 'Interior (2)', value = '50'},
		{label = 'Roof (1)', value = '48'},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vangelico', {
		title    = 'Vangelico Fine Jewellery',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		TriggerEvent('cctv:camera', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end
