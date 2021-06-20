--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							INITIALISATION	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ESX = nil
local Vehicles = {}

local PlayerData, CurrentActionData, currentTask = {}, {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined  = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
local spawnedVehicles, isInModMenu = {}, false
local LastZone = nil

local myCar = {}
local selfData = {}
local playerLoaded = false
local isMechanic = false
local isInVehicle = false
local AvailableExtras = {['VehicleExtras'] = {}}
local Items = {['Vehicle'] = {}}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 						PLAYER LOADING / DATA HANDLING
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	ESX.TriggerServerCallback('iG_MechModMenu:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
	
	ESX.TriggerServerCallback('iG_MechModMenu:getOtherPlayerData', function(data)	
		selfData = data
	end)

	if PlayerData.job.name == 'sar' or PlayerData.job.name == 'dragonsjdm' or PlayerData.job.name == 'government' or PlayerData.job.name == 'sinsgarage' or PlayerData.job.name == 'beekers' then 
        isMechanic = true
    else
        isMechanic = false
    end
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	playerLoaded = true

	Citizen.Wait(3000)

	ESX.TriggerServerCallback('iG_MechModMenu:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)

	ESX.TriggerServerCallback('iG_MechModMenu:getOtherPlayerData', function(data)	
		selfData = data
	end)
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(500)

	if PlayerData.job.name == 'sar' or PlayerData.job.name == 'dragonsjdm' or PlayerData.job.name == 'government' or PlayerData.job.name == 'sinsgarage' or PlayerData.job.name == 'beekers' then  
        isMechanic = true
    else
        isMechanic = false
    end
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 						MODIFICATION STATES / SETTING DATA	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RegisterNetEvent('iG_MechModMenu:installMod')
AddEventHandler('iG_MechModMenu:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('iG_MechModMenu:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('iG_MechModMenu:cancelInstallMod')
AddEventHandler('iG_MechModMenu:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if data.modType then
		local props = {}
		
		if data.wheelType then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		end

		props[data.modType] = data.modNum
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							MODIFICATION MENU	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function OpenModificationMenu(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'right',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod then
				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					exports['mythic_notify']:SendAlert('inform', _U('already_own', data.current.label))
					TriggerEvent('iG_MechModMenu:installMod')
				else
					local vehiclePrice = 50000

					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end

					if isRimMod then
						price = 0
						TriggerServerEvent('iG_MechModMenu:buyMod', price)
						TriggerServerEvent('vy_Logs:AddInLog', "mechanic", "[" .. PlayerData.job.label .. "] ".. selfData.name .. " (" .. GetPlayerName(PlayerId()) .. ") paid $" .. price .. " on wheel/tyre/rim modifications (modLabel: " .. v.label .. ") for (Plate: " .. vehicleData.plate .. ").")
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
						TriggerServerEvent('iG_MechModMenu:buyMod', price)
						TriggerServerEvent('vy_Logs:AddInLog', "mechanic", "[" .. PlayerData.job.label .. "] ".. selfData.name .. " (" .. GetPlayerName(PlayerId()) .. ") paid $" .. price .. " on performance modifications (modLabel: " .. v.label .. ") for (Plate: " .. vehicleData.plate .. ").")
					elseif v.modType == 17 then
						price = math.floor(vehiclePrice * v.price[1] / 100)
						TriggerServerEvent('iG_MechModMenu:buyMod', price)
						TriggerServerEvent('vy_Logs:AddInLog', "mechanic", "[" .. PlayerData.job.label .. "] ".. selfData.name .. " (" .. GetPlayerName(PlayerId()) .. ") paid $" .. price .. " on T:17 modifications (modLabel: " .. v.label .. ") for (Plate: " .. vehicleData.plate .. ").")
					elseif v.modType == 'extras' then
						print(data.current.modNum)
						if IsVehicleExtraTurnedOn(vehicle, data.current.modNum) then
							SetVehicleExtra(vehicle, data.current.modNum, 1)
							myCar = ESX.Game.GetVehicleProperties(vehicle)
						else
							SetVehicleExtra(vehicle, data.current.modNum, 0)
							myCar = ESX.Game.GetVehicleProperties(vehicle)
						end
					else
						price = 0
						TriggerServerEvent('iG_MechModMenu:buyMod', price)
						TriggerServerEvent('vy_Logs:AddInLog', "mechanic", "[" .. PlayerData.job.label .. "] ".. selfData.name .. " (" .. GetPlayerName(PlayerId()) .. ") paid $" .. price .. " on misc. modifications (modLabel: " .. v.label .. ") for (Plate: " .. vehicleData.plate .. ").")
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('iG_MechModMenu:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			-- local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			isInModMenu = false
			-- FreezeEntityPosition(PlayerPedId(), false)
			-- FreezeEntityPosition(vehicle, false)
			myCar = {}
			extras = {}
		end
	end, function(data, menu) -- on change
		if data.current.modType ~= "extras" then
			UpdateMods(data.current)
		end
	end)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								GetAction Menu
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function GetAction(data)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)
	local GotVehicleExtras = false

	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, 4, false)
		SetVehicleDoorOpen(vehicle, 5, false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, 0, false)
		SetVehicleDoorOpen(vehicle, 1, false)
		SetVehicleDoorOpen(vehicle, 2, false)
		SetVehicleDoorOpen(vehicle, 3, false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end

	local vehiclePrice = 50000

	for i=1, #Vehicles, 1 do
		if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
			vehiclePrice = Vehicles[i].price
			break
		end
	end

	for k,v in pairs(Config.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = v.label
			parent    = v.parent

			if v.modType then
				if v.modType == 'xenonColor' then
					ToggleVehicleMod(vehicle, 22, true)
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 0
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 0
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'xenonColor' then -- NEON
					local headlights = GetHeadlights()
					price = 0
					for j = 1, #headlights, 1 do
						local _label = ''
						price = 0
						_label = headlights[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = headlights[j].index})
					end
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = 0
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = 0
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = 0
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = 0
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 'extras' then

					for ExtraID = 0, 20 do
						if DoesExtraExist(vehicle, ExtraID) then
							AvailableExtras.VehicleExtras[ExtraID] = (IsVehicleExtraTurnedOn(vehicle, ExtraID) == 1)
							GotVehicleExtras = true
						end
					end

					if GotVehicleExtras then
						-- SetVehicleAutoRepairDisabled(vehicle, true)
						
						for Key, Value in pairs(AvailableExtras.VehicleExtras) do
							if AvailableExtras.VehicleExtras[Key] then
								local ExtraItem = 'Extra ' .. Key .. ' (<span style="color:green;">True</span>)'
								table.insert(elements, {label = ExtraItem, modType = k, modNum = Key})
							else
								local ExtraItem = 'Extra ' .. Key .. ' (<span style="color:red;">False</span>)'
								table.insert(elements, {label = ExtraItem, modType = k, modNum = Key})

							end
						end
		
					end
					

				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 10) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = 0
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenModificationMenu(elements, menuName, menuTitle, parent)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							CITIZEN THREAD (0)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isMechanic and isInVehicle then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Mechanics) do
                if PlayerData.job.name == v.Job_Auth or v.Job_Auth == 'shared' then 

                    for i=1, #v.ModAreas, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.ModAreas[i], true)
    
                        if distance < Config.DrawDistance then
                            -- DrawMarker(20, v.ModAreas[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end
    
                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ModMenu', i
                        end
					end
				end
			end
			
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
				(LastStation and LastPart and LastPartNum) and
						(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('iG_MechModMenu:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('iG_MechModMenu:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('iG_MechModMenu:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isMechanic then 
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, 38) and isMechanic then

					if CurrentAction == 'menu_modmenu' then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

						myCar = ESX.Game.GetVehicleProperties(vehicle)

						ESX.UI.Menu.CloseAll()
						GetAction({value = 'main'})
						isInModMenu = true
						-- FreezeEntityPosition(PlayerPedId(), true)
						-- FreezeEntityPosition(vehicle, true)
					end

					CurrentAction = nil
				end
			else
				Citizen.Wait(500)
			end

			if IsControlJustReleased(0, 38) and currentTask.busy then
				ESX.ClearTimeout(currentTask.task)
				ClearPedTasks(PlayerPedId())
				currentTask.busy = false
			end

			if isInModMenu then
				DisableControlAction(0, 75, true)  -- Disable exit vehicle
				DisableControlAction(27, 75, true) -- Disable exit vehicle
				Citizen.Wait(500)
			end
		end
	end
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							CITIZEN THREAD (1000)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		if isMechanic then 
			isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
		end
		Citizen.Wait(1000)
	end

end)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							MARKER EVENT HANDLERS
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
AddEventHandler('iG_MechModMenu:hasEnteredMarker', function(station, part, partNum)
    if part == 'ModMenu' then
		CurrentAction = 'menu_modmenu'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to open the Modification Menu.'
        CurrentActionData = {}
    end
end)

AddEventHandler('iG_MechModMenu:hasExitedMarker', function(zone)
	if not isInModMenu then
        ESX.UI.Menu.CloseAll()
	end
	
    CurrentActionMsg = {}
	CurrentAction = nil
end)




