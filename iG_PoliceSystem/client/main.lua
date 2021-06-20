local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService  = false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
local spawnedVehicles, isInShopMenu = {}, false
dragStatus.isDragged = false
ESX = nil
donator = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
	Citizen.Wait(3000)
	TriggerEvent('iG_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('iG_policejob:spawned')
	end
	hasAlreadyJoined = true
	TriggerServerEvent('vy_Admin:Donator', GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('vy_Admin:DonatorReturn')
AddEventHandler('vy_Admin:DonatorReturn', function(donatorStatus)
	donator = donatorStatus
	if donator == true then
		print ('[vy_Admin] Donator Status: true.')
		donator = true
	else
		print ('[vy_Admin] Donator Status: false.')
		donator = false
	end
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(1000)
	TriggerServerEvent('iG_policejob:forceBlip')
	if (PlayerData.job and PlayerData.job.name == 'police') or (PlayerData.job and PlayerData.job.name == 'mcd') or (PlayerData.job and PlayerData.job.name == 'government') then 
		exports['ig-keybinds']:RegisterKeybind('TogglePoliceActions', '[NSWPF] Police Actions Menu', 'F6', OpenPoliceActionsMenu)
		exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
	else
		exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
	end 
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(value, playerPed)
	TriggerEvent('iG_skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[value].male then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[value].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

		elseif skin.sex == 1 then
			if Config.Uniforms[value].female then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[value].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end

		if value == 'polofficer_vest' then
			SetPedArmour(playerPed, 35)
		end

		if value == 'polsgt_vest' then
			SetPedArmour(playerPed, 50)
		end

		if value == 'poladmin_vest' then
			SetPedArmour(playerPed, 60)
		end

		if value == 'polcabinet_vest' then
			SetPedArmour(playerPed, 70)
		end

		if value == 'polco_vest' then
			SetPedArmour(playerPed, 70)
		end

		if value == 'hwy_vest' then
			SetPedArmour(playerPed, 45)
		end
		
		if value == 'afp_vest' then
			SetPedArmour(playerPed, 75)
		end
		
		if value == 'spg_vest' then
			SetPedArmour(playerPed, 80)
		end

		if value == 'spg_co_vest' then
			SetPedArmour(playerPed, 80)
		end

	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
	}

	if grade == 'pconstable' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_pconstable'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_pconstable'})

	elseif grade == 'constable' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_constable'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_constable'})

	elseif grade == 'sconstable' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_sconstable'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_sconstable'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Officer)", value = 'polofficer_vest'})

	elseif grade == 'isconstable' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_isconstable'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_isconstable'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Officer)", value = 'polofficer_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'lsconstable' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_lsconstable'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_lsconstable'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Officer)", value = 'polofficer_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})


		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'sergeant' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_sergeant'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_sergeant'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (SGT)", value = 'polsgt_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'isergeant' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_isergeant'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_isergeant'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (SGT)", value = 'polsgt_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'ssergeant' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_ssergeant'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_ssergeant'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (SGT)", value = 'polsgt_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'inspector' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_inspector'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_inspector'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_inspector'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Admin)", value = 'poladmin_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end
	elseif grade == 'cinspector' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_cinspector'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_cinspector'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_cinspector'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Admin)", value = 'poladmin_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'superintendent' then
		
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_superintendent'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_superintendent'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_superintendent'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Admin)", value = 'poladmin_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'csuperintendent' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_csuperintendent'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_csuperintendent'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_csuperintendent'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Admin)", value = 'poladmin_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})

		table.insert(elements, {label = "<strong>  - - - [ Highway Patrol ] - - - </strong>"})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'acommissioner' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_acommissioner'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_acommissioner'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_acommissioner'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Cabinet)", value = 'polcabinet_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'dcommissioner' then
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_dcommissioner'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_dcommissioner'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_dcommissioner'})
		table.insert(elements, {label = "GD Soft-Shell Jacket", value = 'nswpf_softshelljacket'})
		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Cabinet)", value = 'polcabinet_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end

	elseif grade == 'boss' then
		print(donator)
		table.insert(elements, {label = "<strong>  - - - [ General Duties ] - - - </strong>"})
		table.insert(elements, {label = "GD Police Hat", value = 'polofficer_hat'})
		table.insert(elements, {label = "GD Police Admin Hat", value = 'poladmin_hat'})
		table.insert(elements, {label = "GD Uniform (Short Sleeve)", value = 'short_commissioner'})
		table.insert(elements, {label = "GD Uniform (Long Sleeve)", value = 'long_commissioner'})
		table.insert(elements, {label = "GD Formal Uniform", value = 'formal_commissioner'})

		table.insert(elements, {label = "<strong>  - - - [ Bulletproof Vests ] - - - </strong>"})
		table.insert(elements, {label = "Bulletproof Vest (Cabinet)", value = 'polcabinet_vest'})
		table.insert(elements, {label = "Bulletproof Vest (CO)", value = 'polco_vest'})
		table.insert(elements, {label = "High-Visability Vest (HWY)", value = 'hwy_vest'})

		table.insert(elements, {label = "<strong>  - - - [ State Protection Group ] - - - </strong>"})
		table.insert(elements, {label = "SPG Bulletproof Vest", value = 'spg_vest'})
		table.insert(elements, {label = "SPG Bulletproof Vest (CO)", value = 'spg_co_vest'})
		table.insert(elements, {label = "SPG Standard Uniform", value = 'spg_light_wear'})
		table.insert(elements, {label = "SPG Operations Helmet", value = 'spg_helmet'})
		table.insert(elements, {label = "SPG Operations Uniform", value = 'spg_tactical_wear'})
		table.insert(elements, {label = "SPG Gas Mask", value = 'spg_gasmask'})
		
		table.insert(elements, {label = "<strong>  - - - [ Major Crimes Division ] - - - </strong>"})
		table.insert(elements, {label = "MCD Bulletproof Vest", value = 'afp_vest'})
		table.insert(elements, {label = "MCD Standard Uniform", value = 'afp_light_wear'})
		table.insert(elements, {label = "MCD Operations Helmet", value = 'afp_helmet'})
		table.insert(elements, {label = "MCD Operations Uniform", value = 'afp_tactical_wear'})

		if donator == true then
			table.insert(elements, {label = "<strong>  - - - [ Donator ] - - - </strong>"})
			table.insert(elements, {label = "SHP General Duties Uniform", value = 'shp_wear'})
		end
	end

	--table.insert(elements, {label = "Uniform Extras", value = 'extra_menu'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('iG_skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
							TriggerEvent('iG_skinchanger:loadSkin', skin)
							TriggerEvent('iG:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
					TriggerEvent('iG_skinchanger:loadSkin', skin)
				end)
			end
		end

		if
			data.current.value == 'short_pconstable' or
			data.current.value == 'short_constable' or
			data.current.value == 'short_sconstable' or
			data.current.value == 'short_isconstable' or
			data.current.value == 'short_lsconstable' or
			data.current.value == 'short_sergeant' or
			data.current.value == 'short_isergeant' or
			data.current.value == 'short_ssergeant' or
			data.current.value == 'short_inspector' or
			data.current.value == 'short_cinspector' or
			data.current.value == 'short_superintendent' or
			data.current.value == 'short_csuperintendent' or
			data.current.value == 'short_acommissioner' or
			data.current.value == 'short_dcommissioner' or
			data.current.value == 'short_commissioner' or
			data.current.value == 'long_pconstable' or
			data.current.value == 'long_constable' or
			data.current.value == 'long_sconstable' or
			data.current.value == 'long_isconstable' or
			data.current.value == 'long_lsconstable' or
			data.current.value == 'long_sergeant' or
			data.current.value == 'long_isergeant' or
			data.current.value == 'long_ssergeant' or
			data.current.value == 'long_inspector' or
			data.current.value == 'long_cinspector' or
			data.current.value == 'long_superintendent' or
			data.current.value == 'long_csuperintendent' or
			data.current.value == 'long_acommissioner' or
			data.current.value == 'long_dcommissioner' or
			data.current.value == 'long_commissioner' or
			data.current.value == 'formal_inspector' or
			data.current.value == 'formal_cinspector' or
			data.current.value == 'formal_superintendent' or
			data.current.value == 'formal_csuperintendent' or
			data.current.value == 'formal_acommissioner' or
			data.current.value == 'formal_dcommissioner' or
			data.current.value == 'formal_commissioner' or
			data.current.value == 'shp_wear' or
			data.current.value == 'polofficer_hat' or
			data.current.value == 'poladmin_hat' or
			data.current.value == 'polofficer_vest' or
			data.current.value == 'polsgt_vest' or
			data.current.value == 'poladmin_vest' or
			data.current.value == 'polcabinet_vest' or
			data.current.value == 'polco_vest' or
			data.current.value == 'hwy_vest' or
			data.current.value == 'nswpf_softshelljacket' or
			
			-- Australian Federal Police
			data.current.value == 'afp_helmet' or
			data.current.value == 'afp_light_wear' or
			data.current.value == 'afp_tactical_wear' or
			data.current.value == 'afp_vest' or

			-- State Protection Group
			data.current.value == 'spg_helmet' or
			data.current.value == 'spg_gasmask' or
			data.current.value == 'spg_light_wear' or
			data.current.value == 'spg_tactical_wear' or
			data.current.value == 'spg_vest' or
			data.current.value == 'spg_co_vest'
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'extra_menu' then
			OpenUniformExtras()
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('iG:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function JailPlayer(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_menu', {
		title = _U('jail_menu_info'),
	}, function (data2, menu)
		local jailTime = tonumber(data2.value)
		if jailTime == nil then
			ESX.ShowNotification('invalid number!')
		else
			TriggerServerEvent("iG_jail:sendToJail", player, jailTime * 60)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu(type, station, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'shop_categories'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'shop_categories' then
			local elements = {}
			table.insert(elements, {label = "General Duties Vehicles", action = 'buy_gd'})
			-- table.insert(elements, {label = "Australian Federal Police Vehicles", action = 'buy_afp'})
			table.insert(elements, {label = "Highway Patrol Vehicles", action = 'buy_hwy'})
			table.insert(elements, {label = "State Protection Group Vehicles", action = 'buy_spg'})

			-- if donator == true then
			-- 	table.insert(elements, {label = "Donator Vehicles", action = 'buy_donator'})
			-- end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_categories', {
				title    = _U('garage_title'),
				align    = 'right',
				elements = elements
			}, function(category_data, category_menu)
				local shopElements = {}
				local foundSpawn, shopPoint = GetAvailableVehicleShopPoint(station, part, partNum)

				if category_data.current.action == 'buy_gd' then
					for k, vehicle in ipairs(Config.GD_AuthorizedVehicles[PlayerData.job.grade_name]) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type = 'car'
						})

					end

				-- elseif category_data.current.action == 'buy_um' then
				-- 	if #Config.UM_AuthorizedVehicles[PlayerData.job.grade_name] > 0 then
				-- 		for k, vehicle in ipairs(Config.UM_AuthorizedVehicles[PlayerData.job.grade_name]) do
				-- 			table.insert(shopElements, {
				-- 				label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
				-- 				name = vehicle.label,
				-- 				model = vehicle.model,
				-- 				price = vehicle.price,
				-- 				type = 'car'
				-- 			})
				-- 		end
				-- 	end

				elseif category_data.current.action == 'buy_hwy' then
					if #Config.HWY_AuthorizedVehicles[PlayerData.job.grade_name] > 0 then
						for k, vehicle in ipairs(Config.HWY_AuthorizedVehicles[PlayerData.job.grade_name]) do
							table.insert(shopElements, {
								label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
								name = vehicle.label,
								model = vehicle.model,
								price = vehicle.price,
								type = 'car'
							})
						end
					end

				elseif category_data.current.action == 'buy_spg' then
					if #Config.SPG_AuthorizedVehicles[PlayerData.job.grade_name] > 0 then
						for k, vehicle in ipairs(Config.SPG_AuthorizedVehicles[PlayerData.job.grade_name]) do
							table.insert(shopElements, {
								label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
								name = vehicle.label,
								model = vehicle.model,
								price = vehicle.price,
								type = 'car'
							})
						end
					end

				-- elseif category_data.current.action == 'buy_afp' then
				-- 	if #Config.AFP_AuthorizedVehicles[PlayerData.job.grade_name] > 0 then
				-- 		for k, vehicle in ipairs(Config.AFP_AuthorizedVehicles[PlayerData.job.grade_name]) do
				-- 			table.insert(shopElements, {
				-- 				label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
				-- 				name = vehicle.label,
				-- 				model = vehicle.model,
				-- 				price = vehicle.price,
				-- 				type = 'car'
				-- 			})
				-- 		end
				-- 	end

				-- elseif category_data.current.action == 'buy_donator' then
				-- 	if #Config.Donator_AuthorizedVehicles[PlayerData.job.grade_name] > 0 then
				-- 		for k, vehicle in ipairs(Config.Donator_AuthorizedVehicles[PlayerData.job.grade_name]) do
				-- 			table.insert(shopElements, {
				-- 				label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
				-- 				name = vehicle.label,
				-- 				model = vehicle.model,
				-- 				price = vehicle.price,
				-- 				type = 'car'
				-- 			})
				-- 		end
				-- 	end

				end

				OpenShopMenu(shopElements, playerCoords, shopPoint.coords, shopPoint.heading)
			end, function(category_data, category_menu)
				category_menu.close()
			end)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local hashVehicule = props.model
						print(props.model)
						local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
						local vehicleName = aheadVehName
						-- local hashVehicule = props.model
						-- local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
						-- local vehicleName = GetLabelText(aheadVehName)
						local plate = props.plate
						local vehDamage	= tostring(math.floor(props.engineHealth/10) .. "%")
						local labelvehicle
						local labelvehicle2 = ('<span style="font-size:12px;"><span style="color:rgb(0, 204, 255);">%s</span><br></span>'):format(vehicleName)
						local labelvehicle3 = ('<span style="color:rgb(0, 204, 255);">%s</span><br>'):format(vehicleName)

						if v.striked then
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_striked'))
						elseif v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(0, 255, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_available'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="font-size: 10px;"><span style="color:rgb(255, 204, 0);">(%s)</span> - (Health: %s) - <span style="color:rgb(255, 51, 0);">%s</span></span>'):format(plate, vehDamage, _U('veh_impound'))
						end	
						-- local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						-- if v.stored then
						-- 	label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						-- else
						-- 	label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						-- end

						table.insert(garage, {
							label = labelvehicle,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									SetVehicleMaxMods(vehicle)
									exports["LegacyFuel"]:SetFuel(vehicle, 100)
									-- SetVehicleFuelLevel(vehicle, 100)
									TriggerServerEvent('iG_VehicleShop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenHelicopterSpawnerMenu(type, station, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'shop_categories'}

	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'shop_categories' then
			local elements = {
				{label = 'General Duties Helicopters', action = 'buy_gd'},
				{label = 'State Protection Group Helicopters', action = 'buy_spg'},
			}

			-- if donator == true then
			-- 	table.insert(elements, {label = 'Donator Helicopters', action = 'buy_donator'})
			-- end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_categories', {
				title    = _U('garage_title'),
				align    = 'right',
				elements = elements
			}, function(category_data, category_menu)
				local shopElements = {}
				local foundSpawn, shopPoint = GetAvailableVehicleShopPoint(station, part, partNum)


				if category_data.current.action == 'buy_gd' then
					for k, vehicle in ipairs(Config.GD_AuthorizedHelicopters[PlayerData.job.grade_name]) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type = 'helicopter'
						})

					end
				elseif category_data.current.action == 'buy_spg' then
					if #Config.SPG_AuthorizedHelicopters[PlayerData.job.grade_name] > 0 then
						for k, vehicle in ipairs(Config.SPG_AuthorizedHelicopters[PlayerData.job.grade_name]) do
							table.insert(shopElements, {
								label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
								name = vehicle.label,
								model = vehicle.model,
								price = vehicle.price,
								type = 'helicopter'
							})
						end
					end

				-- elseif category_data.current.action == 'buy_afp' then
				-- 	if #Config.AFP_AuthorizedHelicopters[PlayerData.job.grade_name] > 0 then
				-- 		for k, vehicle in ipairs(Config.AFP_AuthorizedHelicopters[PlayerData.job.grade_name]) do
				-- 			table.insert(shopElements, {
				-- 				label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
				-- 				name = vehicle.label,
				-- 				model = vehicle.model,
				-- 				price = vehicle.price,
				-- 				type = 'helicopter'
				-- 			})
				-- 		end
				-- 	end

				-- elseif category_data.current.action == 'buy_donator' then
				-- 	if #Config.Donator_AuthorizedHelicopters[PlayerData.job.grade_name] > 0 then
				-- 		for k, vehicle in ipairs(Config.Donator_AuthorizedHelicopters[PlayerData.job.grade_name]) do
				-- 			table.insert(shopElements, {
				-- 				label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
				-- 				name = vehicle.label,
				-- 				model = vehicle.model,
				-- 				price = vehicle.price,
				-- 				type = 'helicopter'
				-- 			})
				-- 		end
				-- 	end

				end

				OpenShopMenu(shopElements, playerCoords, shopPoint.coords, shopPoint.heading)
			end, function(category_data, category_menu)
				category_menu.close()
			end)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetDisplayNameFromVehicleModel(props.model)
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									SetVehicleMaxMods(vehicle)
									TriggerServerEvent('iG_VehicleGarage:setVehicleState', data2.current.vehicleProps.plate, false)
							
									ESX.ShowNotification(_U('garage_released'))
									-- exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(data2.current.vehicleProps.plate))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end


function OpenWatercraftSpawnerMenu(type, station, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'shop_categories'}

	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'shop_categories' then
			local elements = {
				{label = 'General Duties Watercraft', action = 'buy_gd'}
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_categories', {
				title    = _U('garage_title'),
				align    = 'right',
				elements = elements
			}, function(category_data, category_menu)
				local shopElements = {}
				local foundSpawn, shopPoint = GetAvailableVehicleShopPoint(station, part, partNum)


				if category_data.current.action == 'buy_gd' then
					for k, vehicle in ipairs(Config.AuthorizedWatercraft[PlayerData.job.grade_name]) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type = 'boat'
						})

					end
				end

				OpenShopMenu(shopElements, playerCoords, shopPoint.coords, shopPoint.heading)
			end, function(category_data, category_menu)
				category_menu.close()
			end)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobSocietyVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetDisplayNameFromVehicleModel(props.model)
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									SetVehicleMaxMods(vehicle)
									TriggerServerEvent('iG_VehicleGarage:setVehicleState', data2.current.vehicleProps.plate, false)
							
									ESX.ShowNotification(_U('garage_released'))
									-- exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(data2.current.vehicleProps.plate))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'boat')
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('iG_policejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				BeginTextCommandBusyString('STRING')
				AddTextComponentSubstringPlayerName(_U('garage_storing'))
				EndTextCommandBusyString(4)

				while IsBusy do
					Citizen.Wait(100)
				end

				RemoveLoadingPrompt()
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			TriggerServerEvent('iG_VehicleGarage:setVehicleState', vehicleId.plate, true)
			IsBusy = false

			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(station, part, partNum)
	local spawnPoints = Config.PoliceStations[station][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function GetAvailableVehicleShopPoint(station, part, partNum)
	local shopPoints = Config.PoliceStations[station][part][partNum].ShopPoints
	local found, foundShopPoint = false, nil

	for i=1, #shopPoints, 1 do
		if ESX.Game.IsSpawnPointClear(shopPoints[i].coords, shopPoints[i].radius) then
			found, foundShopPoint = true, shopPoints[i]
			break
		end
	end

	if found then
		return true, foundShopPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function OpenShopMenu(elements, restoreCoords, shopCoords, shopHeading)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		css = 'unknownstory',
		title = _U('vehicleshop_title'),
		align = 'right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm',
				{
					css = 'unknownstory',
					title = _U('vehicleshop_confirm', data.current.name, data.current.price),
					align = 'right',
					elements = {
						{ label = _U('confirm_no'), value = 'no' },
						{ label = _U('confirm_yes'), value = 'yes' }
					}
				}, function(data2, menu2)

					if data2.current.value == 'yes' then
						local newPlate = exports['iG_VehicleShop']:GeneratePlate()

						local vehicle = GetVehiclePedIsIn(playerPed, false)

						SetVehicleColours(vehicle, 0, 0)
						local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
						SetVehicleExtraColours(vehicle, 0, wheelColor)

						local props = ESX.Game.GetVehicleProperties(vehicle)
						props.plate = newPlate

						ESX.TriggerServerCallback('iG_policejob:buyJobVehicle', function(bought)
							if bought then
								ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))
								isInShopMenu = false
								ESX.UI.Menu.CloseAll()
								DeleteSpawnedVehicles()
								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
								ESX.Game.Teleport(playerPed, restoreCoords)
							else
								ESX.ShowNotification(_U('vehicleshop_money'))
								menu2.close()
							end
						end, props, data.current.type)
					else
						menu2.close()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
	end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()
		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()
		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, shopHeading, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			if data.current.livery then
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, data.current.livery)
			end
		end)
	end)
	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, shopHeading, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)

		if elements[1].livery then
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, elements[1].livery)
		end
	end)
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText("Vehicle loading, please wait...", 255, 255, 255, 255)
		end
	end
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function OpenPoliceActionsMenu()
	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'mcd' or PlayerData.job and PlayerData.job.name == 'government' then
		ESX.UI.Menu.CloseAll()

		local elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			-- {label = _U('object_spawner'), value = 'object_spawner'}
		}

		if (IsInVehicle()) then
			table.insert(elements, { label = 'Police Computer', value = 'police_computer' })
			table.insert(elements, { label = 'Vehicle Setup', value = 'vehicle_settings' })
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
			title    = 'Police',
			align    = 'right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'citizen_interaction' then
				local elements = {
					{label = "Check Identification", value = 'identity_card'},
					{label = "Conduct Full-Body Search", value = 'body_search'},
					{label = "Handcuff the Suspect", value = 'handcuff'},
					{label = "Escort the Suspect", value = 'drag'},
					{label = "Place Suspect in Vehicle", value = 'put_in_vehicle'},
					{label = "Remove Suspect from Vehicle", value = 'out_the_vehicle'},
					-- {label = "Issue Citation", value = 'fine'},
					{label = "View Outstanding Invoices", value = 'unpaid_bills'},
					-- {label = "Community Service",	value = 'communityservice'},
					{label = "Jail Menu",               value = 'jail_menu'},
				}

				if Config.EnableLicenses then
					table.insert(elements, { label = _U('license_check'), value = 'license' })
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
					title    = _U('citizen_interaction'),
					align    = 'right',
					elements = elements
				}, function(data2, menu2)
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						local action = data2.current.value

						if action == 'identity_card' then
							if Config.EnableJobLogs == true then
								TriggerServerEvent('igLogs:AddInLog',"police" ,"id_card" ,GetPlayerName(PlayerId()) , GetPlayerName(closestPlayer))
							end
							OpenIdentityCardMenu(closestPlayer)
						elseif action == 'body_search' then
							if Config.EnableJobLogs == true then
								TriggerServerEvent('igLogs:AddInLog',"police" ,"being_searched" ,GetPlayerName(PlayerId()) , GetPlayerName(closestPlayer))
							end
							TriggerServerEvent('iG_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
							OpenBodySearchMenu(closestPlayer)
						elseif action == 'handcuff' then
							TriggerServerEvent("cuff_item:itemCheck")
							TriggerServerEvent('iG_policejob:handcuff', GetPlayerServerId(closestPlayer))
						elseif action == 'drag' then
							TriggerServerEvent('iG_policejob:drag', GetPlayerServerId(closestPlayer))
						elseif action == 'put_in_vehicle' then
							TriggerServerEvent('iG_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
						elseif action == 'out_the_vehicle' then
							TriggerServerEvent('iG_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
						elseif action == 'license' then
							ShowPlayerLicense(closestPlayer)
						elseif action == 'unpaid_bills' then
							OpenUnpaidBillsMenu(closestPlayer)
						elseif action == 'jail_menu' then
							TriggerEvent("iG_pol_jail:openJailMenu")
						end
					else
						ESX.ShowNotification(_U('no_players_nearby'))
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'vehicle_interaction' then
				local elements  = {}
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					table.insert(elements, {label = 'Request Vehicle Impound', value = 'request_impound'})
					-- table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
					-- table.insert(elements, {label = _U('impound'), value = 'impound'})
				end

				-- table.insert(elements, {label = _U('search_database'), value = 'search_database'})

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
					title    = _U('vehicle_interaction'),
					align    = 'right',
					elements = elements
				}, function(data2, menu2)
					local coords  = GetEntityCoords(playerPed)
					vehicle = ESX.Game.GetVehicleInDirection()
					action  = data2.current.value

					if action == 'request_impound' then
						TriggerEvent('iG_Mechanics:requestImpound')
					end

				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'object_spawner' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
					title    = _U('traffic_interaction'),
					align    = 'right',
					elements = {
						{label = _U('cone'), model = 'prop_roadcone02a'},
						{label = _U('barrier'), model = 'prop_barrier_work05'},
					}}, function(data2, menu2)
					local playerPed = PlayerPedId()
					local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
					local objectCoords = (coords + forward * 1.0)

					ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'police_computer' then
				local elements = {
					{label = 'Log into MDT', value = 'access_mdt'},
					{label = 'Access CCTV Cameras', value = 'access_cctv'},
					{label = 'Manage Prisoners', value = 'manage_jail'},
				}

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
					title    = 'Police Computer',
					align    = 'right',
					elements = elements
				}, function(data2, menu2)
					local action = data2.current.value

					if action == 'access_mdt' then
						TriggerEvent('iG-mdt:toggleMDT')
						Citizen.Wait(500)
					elseif action == 'access_cctv' then
						TriggerEvent('cctv:Menu')
					elseif action == "manage_jail" then

						local elements = {}

						ESX.TriggerServerCallback("iG_pol_jail:retrieveJailedPlayers", function(playerArray)

							if #playerArray == 0 then
								exports['mythic_notify']:SendAlert('inform', 'There are currently no prisoners.')
								return
							end

							for i = 1, #playerArray, 1 do
								table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
							end

							ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'jail_unjail_menu',
									{
										title = "Release prisoner",
										align = "right",
										elements = elements
									},
									function(data2, menu2)

										local action = data2.current.value

										TriggerServerEvent("iG_pol_jail:unJailPlayer", action)

										menu2.close()

									end, function(data2, menu2)
										menu2.close()
									end)
						end)
					end

				end, function(data2, menu2)
					menu2.close()
				end)
			
			elseif data.current.value == 'vehicle_settings' then
				menu.close()
				TriggerEvent('vehicleui:toggleMenu')
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('iG_policejob:getOtherPlayerData', function(data)
		local elements = {}
		local nameLabel = _U('name', data.name)
		local sexLabel, dobLabel, heightLabel, idLabel


		if Config.EnableESXIdentity then
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

			if data.sex then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end

			if data.dob then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end

			if data.height then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end

			if data.name then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
		end

		local elements = {
			{label = nameLabel},
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel})
			table.insert(elements, {label = dobLabel})
			table.insert(elements, {label = heightLabel})
			table.insert(elements, {label = idLabel})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	TriggerEvent("ig-inventory:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
		}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('iG_policejob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('iG_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('iG_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
			{
				title = _U('search_database_title'),
			}, function(data, menu)
				local length = string.len(data.value)
				if data.value == nil or length < 2 or length > 13 then
					ESX.ShowNotification(_U('search_database_error_invalid'))
				else
					ESX.TriggerServerCallback('iG_policejob:getVehicleFromPlate', function(owner, found)
						if found then
							ESX.ShowNotification(_U('search_database_found', owner))
						else
							ESX.ShowNotification(_U('search_database_error_not_found'))
						end
					end, data.value)
					menu.close()
				end
			end, function(data, menu)
				menu.close()
			end)
end

function ShowPlayerLicense(player)
	local elements, targetName = {}

	ESX.TriggerServerCallback('iG_policejob:getOtherPlayerData', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end

		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('iG_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('iG_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('iG_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('iG_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end


RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('iG_policejob:forceBlip')
end)

RegisterNetEvent('iG_phone:loaded')
AddEventHandler('iG_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('iG_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('iG_phone:cancelMessage', function(dispatchNumber)
	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government' then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('iG_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Watercraft' then
		CurrentAction     = 'Watercraft'
		CurrentActionMsg  = _U('watercraft_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif part == 'EvidenceLockers' then
		CurrentAction     = 'menu_evidence_lockers'
		CurrentActionMsg  = _U('open_evidence_locker')
		CurrentActionData = {}
	end
end)

AddEventHandler('iG_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('iG_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('iG_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('iG_policejob:handcuff')
AddEventHandler('iG_policejob:handcuff', function()
	isHandcuffed = not isHandcuffed
	-- local playerPed = PlayerPedId()

	-- Citizen.CreateThread(function()
	-- 	if isHandcuffed then

	-- 		RequestAnimDict('mp_arresting')
	-- 		while not HasAnimDictLoaded('mp_arresting') do
	-- 			Citizen.Wait(100)
	-- 		end

	-- 		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

	-- 		SetEnableHandcuffs(playerPed, true)
	-- 		DisablePlayerFiring(playerPed, true)
	-- 		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	-- 		SetPedCanPlayGestureAnims(playerPed, false)
	-- 		FreezeEntityPosition(playerPed, true)
	-- 		DisplayRadar(false)

	-- 		if Config.EnableHandcuffTimer then
	-- 			if handcuffTimer.active then
	-- 				ESX.ClearTimeout(handcuffTimer.task)
	-- 			end

	-- 			StartHandcuffTimer()
	-- 		end
	-- 	else
	-- 		if Config.EnableHandcuffTimer and handcuffTimer.active then
	-- 			ESX.ClearTimeout(handcuffTimer.task)
	-- 		end

	-- 		ClearPedSecondaryTask(playerPed)
	-- 		SetEnableHandcuffs(playerPed, false)
	-- 		DisablePlayerFiring(playerPed, false)
	-- 		SetPedCanPlayGestureAnims(playerPed, true)
	-- 		FreezeEntityPosition(playerPed, false)
	-- 		DisplayRadar(true)
	-- 	end
	-- end)
end)

RegisterNetEvent('iG_policejob:unrestrain')
AddEventHandler('iG_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		-- ClearPedSecondaryTask(playerPed)
		-- SetEnableHandcuffs(playerPed, false)
		-- DisablePlayerFiring(playerPed, false)
		-- SetPedCanPlayGestureAnims(playerPed, true)
		-- FreezeEntityPosition(playerPed, false)
		-- DisplayRadar(true)

		-- -- end timer
		-- if Config.EnableHandcuffTimer and handcuffTimer.active then
		-- 	ESX.ClearTimeout(handcuffTimer.task)
		-- end
	end
end)

RegisterNetEvent('iG_policejob:drag')
AddEventHandler('iG_policejob:drag', function(copId)
	if not isHandcuffed then
		return
	end

	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if isHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('iG_policejob:putInVehicle')
AddEventHandler('iG_policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not isHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('iG_policejob:OutVehicle')
AddEventHandler('iG_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- -- Handcuff
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()

-- 		if isHandcuffed then
-- 			-- DisableControlAction(0, 1, true) -- Disable pan
-- 			-- DisableControlAction(0, 2, true) -- Disable tilt
-- 			-- DisableControlAction(0, 24, true) -- Attack
-- 			-- DisableControlAction(0, 257, true) -- Attack 2
-- 			-- DisableControlAction(0, 25, true) -- Aim
-- 			-- DisableControlAction(0, 263, true) -- Melee Attack 1
-- 			-- DisableControlAction(0, 32, true) -- W
-- 			-- DisableControlAction(0, 34, true) -- A
-- 			-- DisableControlAction(0, 31, true) -- S
-- 			-- DisableControlAction(0, 30, true) -- D

-- 			-- DisableControlAction(0, 45, true) -- Reload
-- 			-- DisableControlAction(0, 22, true) -- Jump
-- 			-- DisableControlAction(0, 44, true) -- Cover
-- 			-- DisableControlAction(0, 37, true) -- Select Weapon
-- 			-- DisableControlAction(0, 23, true) -- Also 'enter'?

-- 			DisableControlAction(0, 288,  true) -- Disable phone
-- 			DisableControlAction(0, 289, true) -- Inventory
-- 			DisableControlAction(0, 170, true) -- Animations
-- 			DisableControlAction(0, 167, true) -- Job

-- 			-- DisableControlAction(0, 0, true) -- Disable changing view
-- 			-- DisableControlAction(0, 26, true) -- Disable looking behind
-- 			-- DisableControlAction(0, 73, true) -- Disable clearing animation
-- 			-- DisableControlAction(2, 199, true) -- Disable pause screen

-- 			DisableControlAction(0, 59, true) -- Disable steering in vehicle
-- 			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
-- 			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

-- 			DisableControlAction(2, 36, true) -- Disable going stealth

-- 			-- DisableControlAction(0, 47, true)  -- Disable weapon
-- 			-- DisableControlAction(0, 264, true) -- Disable melee
-- 			-- DisableControlAction(0, 257, true) -- Disable melee
-- 			-- DisableControlAction(0, 140, true) -- Disable melee
-- 			-- DisableControlAction(0, 141, true) -- Disable melee
-- 			-- DisableControlAction(0, 142, true) -- Disable melee
-- 			-- DisableControlAction(0, 143, true) -- Disable melee
-- 			-- DisableControlAction(0, 75, true)  -- Disable exit vehicle
-- 			-- DisableControlAction(27, 75, true) -- Disable exit vehicle

-- 			-- if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
-- 			-- 	ESX.Streaming.RequestAnimDict('mp_arresting', function()
-- 			-- 		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
-- 			-- 	end)
-- 			-- end
-- 		else
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("NSWPF: Police Station")
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do

				-- for i=1, #v.Cloakrooms, 1 do
				-- 	local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

				-- 	if distance < Config.DrawDistance then
				-- 		DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				-- 		letSleep = false
				-- 	end

				-- 	if distance < Config.MarkerSize.x then
				-- 		isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
				-- 	end
				-- end

				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end

				for i=1, #v.Helicopters, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					end
				end

				for i=1, #v.Watercraft, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Watercraft[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(35, v.Watercraft[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Watercraft', i
					end
				end

				for i=1, #v.EvidenceLockers, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.EvidenceLockers[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(20, v.EvidenceLockers[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'EvidenceLockers', i
					end
				end


				if PlayerData.job and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

						if distance < Config.DrawDistance then
							DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false
						end

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
				(LastStation and LastPart and LastPartNum) and
						(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('iG_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('iG_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('iG_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('iG_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('iG_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and (PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'afp' or PlayerData.job and PlayerData.job.name == 'government') then

				-- if CurrentAction == 'menu_cloakroom' then
				-- 	OpenCloakroomMenu()
				-- else
				if CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'Watercraft' then
					OpenWatercraftSpawnerMenu('watercraft', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_evidence_lockers' then
					OpenPoliceEvidenceLocker()
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('iG_society:openBossMenu', 'police', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end

		else
			Citizen.Wait(500)
		end -- CurrentAction end
			

	end
end)
-- Create blip for colleagues
function createPoliceBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)

		SetBlipScale(blip, 0.6) -- set scale
		SetBlipAsShortRange(blip, true)
		SetBlipColour (blip, 63)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("👮 AVL | NSWPOL")
		EndTextCommandSetBlipName(blip)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

function createEMSBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)

		SetBlipScale(blip, 0.6) -- set scale
		SetBlipAsShortRange(blip, true)
		SetBlipColour (blip, 69)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("👨‍⚕️ AVL | NSWA")
		EndTextCommandSetBlipName(blip)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

function createFireBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)

		SetBlipScale(blip, 0.6) -- set scale
		SetBlipAsShortRange(blip, true)
		SetBlipColour (blip, 59)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("👨‍🚒 AVL | FRNSW")
		EndTextCommandSetBlipName(blip)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end


-- RegisterNetEvent('iG_policejob:updateBlip')
-- AddEventHandler('iG_policejob:updateBlip', function()

-- 	-- Refresh all blips
-- 	for k, existingBlip in pairs(blipsCops) do
-- 		RemoveBlip(existingBlip)
-- 	end

-- 	-- Clean the blip table
-- 	blipsCops = {}

-- 	-- Enable blip?
-- 	if Config.MaxInService ~= -1 and not playerInService then
-- 		return
-- 	end

-- 	if not Config.EnableJobBlip then
-- 		return
-- 	end

-- 	-- Is the player a cop? In that case show all the blips for other cops
-- 	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'government' or PlayerData.job and PlayerData.job.name == 'ambulance' or PlayerData.job and PlayerData.job.name == 'afp' then
-- 		print('DEBUG')
-- 		-- ESX.TriggerServerCallback('iG_society:getOnlinePlayers', function(players)
-- 		-- 	for i=1, #players, 1 do
-- 		-- 		if players[i].job.name == 'police' or players[i].job.name == 'afp' then
-- 		-- 			local id = GetPlayerFromServerId(players[i].source)
-- 		-- 			if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
-- 		-- 				createPoliceBlip(id)
-- 		-- 			end
-- 		-- 		end

-- 		-- 		if players[i].job.name == 'ambulance' then
-- 		-- 			local id = GetPlayerFromServerId(players[i].source)
-- 		-- 			if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
-- 		-- 				createEMSBlip(id)
-- 		-- 			end
-- 		-- 		end
-- 		-- 	end
-- 		-- end)
-- 	end

-- end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('iG_policejob:unrestrain')
		TriggerEvent('iG_phone:removeSpecialContact', 'police')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('iG_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('iG_policejob:unrestrain')
		handcuffTimer.active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end

function OpenItemStoreMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ItemStore', {
		title = "Police Item Store",
		align = 'right',
		elements = {
			{ label = "Handcuffs", item = 'cuffs', type = 'slider', value = 1, min = 1, max = 2 },
			{ label = "Handcuff Keys", item = 'cuff_keys', type = 'slider', value = 1, min = 1, max = 2 },
			{ label = "Body Camera", item = 'bodycam', type = 'slider', value = 1, min = 1, max = 1 },
		}
	}, function(data, menu)
		TriggerServerEvent('iG_policejob:giveItem', data.current.item, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

-- Commands Start
RegisterCommand('livery', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 0) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('livery1', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 1) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('livery2', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 2) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('livery3', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 3) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('livery4', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 4) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('livery5', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleLivery(Veh, 5) 
		exports['mythic_notify']:SendAlert('inform', 'Livery Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)

RegisterCommand('policepaint', function(source, rawCommand)
	if ESX.GetPlayerData().job.name == "police" or ESX.GetPlayerData().job.name == "afp" then
		local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		SetVehicleColours(Veh, 111, 0)
		exports['mythic_notify']:SendAlert('inform', 'Color Added')
	else
		exports['mythic_notify']:SendAlert('error', 'Need to be police')
	end
end)
-- Commands End




function OpenPoliceEvidenceLocker()
	ESX.TriggerServerCallback("iG_PoliceSystem:getStorageInventory", function(inventory)
		TriggerEvent("ig-inventory:openEvidenceInventory", inventory)
	end)
end

