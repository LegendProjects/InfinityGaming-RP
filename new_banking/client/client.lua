--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX				= nil
inMenu			= true
local showblips	= true
local atbank	= false
local bankMenu	= true
local banks = {
	{name="ANZ Bank (Legion)", id=76, x=150.266, y=-1040.203, z=29.374},
	{name="ANZ Bank (Rockford Hills)", id=76, x=-1212.980, y=-330.841, z=37.787},
	{name="ANZ Bank (Highway)", id=76, x=-2962.582, y=482.627, z=15.703},
	{name="Blane County Savings", id=76, x=-112.202, y=6469.295, z=31.626},
	{name="ANZ Bank (Alta)", id=76, x=314.187, y=-278.621, z=54.170},
	{name="ANZ Bank (West Vinewood)", id=76, x=-351.534, y=-49.529, z=49.042},
	{name="Pacific Standard Public Deposit", id=76, x=241.727, y=220.706, z=106.286, principal = true},
	{name="ANZ Bank (Route 68)", id=76, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}	

local atms = {
	{name="ATM", id=277, x=-386.733, y=6045.953, z=31.501},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-135.165, y=6365.738, z=31.101},
	{name="ATM", id=277, x=-110.753, y=6467.703, z=31.784},
	{name="ATM", id=277, x=-94.9690, y=6455.301, z=31.784},
	{name="ATM", id=277, x=155.4300, y=6641.991, z=31.784},
	{name="ATM", id=277, x=174.6720, y=6637.218, z=31.784},
	{name="ATM", id=277, x=1703.138, y=6426.783, z=32.730},
	-- {name="ATM", id=277, x=1735.114, y=6411.035, z=35.164},
	-- {name="ATM", id=277, x=1702.842, y=4933.593, z=42.051},
	-- {name="ATM", id=277, x=1967.333, y=3744.293, z=32.272},
	{name="ATM", id=277, x=1821.917, y=3683.483, z=34.244},
	{name="ATM", id=277, x=1174.532, y=2705.278, z=38.027},
	-- {name="ATM", id=277, x=540.0420, y=2671.007, z=42.177},
	{name="ATM", id=277, x=2564.399, y=2585.100, z=38.016},
	{name="ATM", id=277, x=2558.683, y=349.6010, z=108.050},
	-- {name="ATM", id=277, x=2558.051, y=389.4817, z=108.660},
	{name="ATM", id=277, x=1077.692, y=-775.796, z=58.218},
	{name="ATM", id=277, x=1139.018, y=-469.886, z=66.789},
	{name="ATM", id=277, x=1168.975, y=-457.241, z=66.641},
	-- {name="ATM", id=277, x=1153.884, y=-326.540, z=69.245},
	-- {name="ATM", id=277, x=381.2827, y=323.2518, z=103.270},
	{name="ATM", id=277, x=236.4638, y=217.4718, z=106.840},
	{name="ATM", id=277, x=265.0043, y=212.1717, z=106.780},
	{name="ATM", id=277, x=285.2029, y=143.5690, z=104.970},
	{name="ATM", id=277, x=157.7698, y=233.5450, z=106.450},
	{name="ATM", id=277, x=-164.568, y=233.5066, z=94.919},
	-- {name="ATM", id=277, x=-1827.04, y=785.5159, z=138.020},
	{name="ATM", id=277, x=-1409.39, y=-99.2603, z=52.473},
	{name="ATM", id=277, x=-1205.35, y=-325.579, z=37.870},
	{name="ATM", id=277, x=-1215.64, y=-332.231, z=37.881},
	{name="ATM", id=277, x=-2072.41, y=-316.959, z=13.345},
	{name="ATM", id=277, x=-2975.72, y=379.7737, z=14.992},
	{name="ATM", id=277, x=-2962.60, y=482.1914, z=15.762},
	{name="ATM", id=277, x=-2955.70, y=488.7218, z=15.486},
	-- {name="ATM", id=277, x=-3044.22, y=595.2429, z=7.595},
	{name="ATM", id=277, x=-3144.13, y=1127.415, z=20.868},
	-- {name="ATM", id=277, x=-3241.10, y=996.6881, z=12.500},
	{name="ATM", id=277, x=-3241.11, y=1009.152, z=12.877},
	{name="ATM", id=277, x=-1305.40, y=-706.240, z=25.352},
	{name="ATM", id=277, x=-538.225, y=-854.423, z=29.234},
	{name="ATM", id=277, x=-711.156, y=-818.958, z=23.768},
	-- {name="ATM", id=277, x=-717.614, y=-915.880, z=19.268},
	{name="ATM", id=277, x=-526.566, y=-1222.90, z=18.434},
	{name="ATM", id=277, x=-256.831, y=-719.646, z=33.444},
	{name="ATM", id=277, x=-203.548, y=-861.588, z=30.205},
	{name="ATM", id=277, x=112.4102, y=-776.162, z=31.427},
	{name="ATM", id=277, x=112.9290, y=-818.710, z=31.386},
	{name="ATM", id=277, x=119.9000, y=-883.826, z=31.191},
	{name="ATM", id=277, x=149.4551, y=-1038.95, z=29.366},
	{name="ATM", id=277, x=-846.304, y=-340.402, z=38.687},
	{name="ATM", id=277, x=-1204.35, y=-324.391, z=37.877},
	{name="ATM", id=277, x=-1216.27, y=-331.461, z=37.773},
	-- {name="ATM", id=277, x=-56.1935, y=-1752.53, z=29.452},
	{name="ATM", id=277, x=-261.692, y=-2012.64, z=30.121},
	{name="ATM", id=277, x=-273.001, y=-2025.60, z=30.197},
	{name="ATM", id=277, x=314.187, y=-278.621, z=54.170},
	{name="ATM", id=277, x=-351.534, y=-49.529, z=49.042},
	{name="ATM", id=277, x=24.589, y=-946.056, z=29.357},
	{name="ATM", id=277, x=-254.112, y=-692.483, z=33.616},
	{name="ATM", id=277, x=-1570.197, y=-546.651, z=34.955},
	{name="ATM", id=277, x=-1415.909, y=-211.825, z=46.500},
	{name="ATM", id=277, x=-1430.112, y=-211.014, z=46.500},
	-- {name="ATM", id=277, x=33.232, y=-1347.849, z=29.497},
	{name="ATM", id=277, x = 126.44, y = -1296.68, z = 29.28},
	{name="ATM", id=277, x=287.645, y=-1282.646, z=29.659},
	{name="ATM", id=277, x=289.012, y=-1256.545, z=29.440},
	{name="ATM", id=277, x=295.839, y=-895.640, z=29.217},
	{name="ATM", id=277, x=1686.753, y=4815.809, z=42.008},
	{name="ATM", id=277, x=-302.408, y=-829.945, z=32.417},
	{name="ATM", id=277, x=5.134, y=-919.949, z=29.557},
	{name="ATM", id=277, x=527.26, y=-160.76, z=57.09},

	{name="ATM", id=277, x=-867.19, y=-186.99, z=37.84},
	{name="ATM", id=277, x=-821.62, y=-1081.88, z=11.13},
	{name="ATM", id=277, x=-1315.32, y=-835.96, z=16.96},
	{name="ATM", id=277, x=-660.71, y=-854.06, z=24.48},
	{name="ATM", id=277, x=-1109.73, y=-1690.81, z=4.37},
	{name="ATM", id=277, x=-1091.5, y=2708.66, z=18.95},
	{name="ATM", id=277, x=1171.98, y=2702.55, z=38.18},
	-- {name="ATM", id=277, x=2683.09, y=3286.53, z=55.24},
	{name="ATM", id=277, x=89.61, y=2.37, z=68.31},
	{name="ATM", id=277, x=-30.3, y=-723.76, z=44.23},
	{name="ATM", id=277, x=-28.07, y=-724.61, z=44.23},
	{name="ATM", id=277, x=-613.24, y=-704.84, z=31.24},
	{name="ATM", id=277, x=-618.84, y=-707.9, z=30.5},
	{name="ATM", id=277, x=-1289.23, y=-226.77, z=42.45},
	{name="ATM", id=277, x=-1285.6, y=-224.28, z=42.45},
	{name="ATM", id=277, x=-1286.24, y=-213.39, z=42.45},
	{name="ATM", id=277, x=-1282.54, y=-210.45, z=42.45},
	{name="ATM", id=277, x= -2058.3071289062, y= -1024.7697753906, z= 11.907521247864 },


	{name="ATM", id=277, x = 942.72,  y = 44.52,  z = 80.28},
	{name="ATM", id=277, x = 408.39,  y = -1623.91,  z = 29.29},
	{name="ATM", id=277, x = 433.58,  y = -978.42,  z = 30.70},
	{name="ATM", id=277, x = 1646.09,  y = 3806.48,  z = 35.12},
--	{name="ATM", id=277, x = 934.48,  y = 31.52,  z = 80.28},
	{name="ATM", id=277, x = -1390.92, y = -590.44, z = 30.32},
	{name="ATM", id=277, x = 349.84, y = -594.52, z = 28.8},
	{name="ATM", id=277, x = 315.08, y = -593.68, z = 43.28},

	{name="ATM", id=277, x = 472.4, y = -1001.56, z = 30.68},
	{name="ATM", id=277, x = 468.52, y = -990.56, z = 26.28},
	{name="ATM", id=277, x = -196.27, y = -1169.57, z = 23.16},
	{name="ATM", id=277, x = -1431.04, y = -448.0, z = 35.91},
	{name="ATM", id=277, x = 920.44, y = 35.92, z = 72.28},
	{name="ATM", id=277, x = 918.28, y = 36.76, z = 72.28}
}
--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



local inVehicle = false
--===============================================
--==             Core Threading                ==
--===============================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		inVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	end
end)

local Cooldown = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Cooldown >= 2 then 
			Cooldown = Cooldown - 1
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not inVehicle then 
			if nearBank() or nearATM() then
				DisplayHelpText("Press ~INPUT_PICKUP~ to access your accounts. ~b~")
				
				if IsControlJustPressed(1, 38) then
					if Cooldown <= 1 then 
						Cooldown = 10
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'openGeneral'})
						TriggerServerEvent('iG_bank:balance')
						local ped = GetPlayerPed(-1)
					else 
						exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming keys. (Cooldown: ' .. Cooldown .. ' seconds)')
					end
				end
			end
						
			if IsControlJustPressed(1, 322) then
				inMenu = false
				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('ig-framework:openATM', function()
	if Cooldown <= 1 then
		Cooldown = 10 
		inMenu = true
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'openGeneral'})
		TriggerServerEvent('iG_bank:balance')
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming keys. (Cooldown: ' .. Cooldown .. ' seconds)')
	end
end)

--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
		for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 76)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Utilities: ANZ Bank")
		EndTextCommandSetBlipName(blip)
		end
	end
end)



--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('iG_bank:deposit', tonumber(data.amount))
	TriggerServerEvent('iG_bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('iG_bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('iG_bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('iG_bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('iG_bank:transfer', data.to, data.amountt)
	TriggerServerEvent('iG_bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('iG_bank:result')
AddEventHandler('iG_bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	if not inVehicle then
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		for _, search in pairs(banks) do
			local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

			if distance <= 3 then
				return true
			end
		end
	end
end

function nearATM()
	
	if not inVehicle then
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		for _, search in pairs(atms) do
			local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

			if distance <= 1.5 then
				return true
			end
		end
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end