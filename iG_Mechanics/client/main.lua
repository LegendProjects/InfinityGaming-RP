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

ESX = nil

local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isBusy = false

local PlayerData, CurrentActionData, currentTask = {}, {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined  = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg

local spawnedVehicles, isInShopMenu = {}, false
local LastZone = nil

local playerInService = false
local DragStatus = {}
local convoi
local onJob, popedTrailer, jobDone = false, false, false
local trailerPoped
isMechanic = false
local display = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'harwick' or PlayerData.job.name == 'sar' or PlayerData.job.name == 'dragonsjdm' or PlayerData.job.name == 'government' or PlayerData.job.name == 'sinsgarage' or PlayerData.job.name == 'beekers' then 
        isMechanic = true
        TriggerServerEvent('iG_Mechanics:requestImpoundData')
    else
        isMechanic = false
    end
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    PlayerData.job = job
    Citizen.Wait(500)
    if PlayerData.job.name == 'harwick' or PlayerData.job.name == 'sar' or PlayerData.job.name == 'dragonsjdm' or PlayerData.job.name == 'government' or PlayerData.job.name == 'sinsgarage' or PlayerData.job.name == 'beekers' then  
        isMechanic = true
        TriggerServerEvent('iG_Mechanics:requestImpoundData')
    else
        isMechanic = false
    end

end)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									CLOAKROOM	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function cleanPlayer(playerPed)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('iG_skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

		elseif skin.sex == 1 then
			if Config.Uniforms[job].female then
				TriggerEvent('iG_skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
    }

    if PlayerData.job.name == 'sar' then 
        if grade == 'sar_tow' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_tow'})
        elseif grade == 'sar_apprentice' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_apprentice'})
        elseif grade == 'sar_mechanic' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_mechanic'})
        elseif grade == 'sar_seniormechanic' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_seniormechanic'})
        elseif grade == 'sar_headmechanic' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_headmechanic'})
        elseif grade == 'sar_floormanager' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_floormanager'})
        elseif grade == 'sar_coowner' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'sar_coowner'})
        elseif grade == 'boss' then
            table.insert(elements, {label = "<strong>  - - - [ Solntservo Uniform ] - - - </strong>"})
            table.insert(elements, {label = "Employee Uniform", value = 'boss'})
        end
    end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = 'Mechanic Cloakroom',
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
            data.current.value == 'sar_tow' or
            data.current.value == 'sar_apprentice' or
            data.current.value == 'sar_mechanic' or
            data.current.value == 'sar_seniormechanic' or
            data.current.value == 'sar_headmechanic' or
            data.current.value == 'sar_floormanager' or
            data.current.value == 'sar_coowner' or
            data.current.value == 'boss'
		then
			setUniform(data.current.value, playerPed)
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
		CurrentActionMsg  = 'Mechanic Cloakroom'
		CurrentActionData = {}
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									JDM CLOAKROOM	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 							MECHANIC ACTIONS MENU	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- {label = _U('place_objects'), value = 'object_spawner'}

function MobileMechanicActionsMenu()

	ESX.UI.Menu.CloseAll()
    local elements = {
        {label = 'Customer Interaction Menu', value = 'customer_interaction_menu'},
        -- {label = 'Vehicle Interaction Menu', value = 'vehicle_interaction_menu'},
        {label = 'Assigned Impound Menu', value = 'assigned_impound_menu'},
        {label = 'Requested Impound Menu', value = 'requested_impound_menu'}
        -- {label = 'Vehicle Towing Menu', value = 'vehicle_towing_menu'}
    }
    
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = 'Mechanic Interaction Menu',
		align    = 'right',
		elements = elements
	}, function(data, menu)
        if isBusy then return end
        
        if data.current.value == 'customer_interaction_menu' then
            local elements = {
                {label = 'Issue Customer Invoice', value = 'billing'},
                {label = 'Issue Vehicle Permits', value = 'permits'},
                {label = 'Fill-out Transfer Papers', value = 'tranfer_vehicle'},
                {label = 'Assign Custom Numberplate', value = 'assign_numberplate'}
            }
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'customer_interaction_menu', {
                title    = 'Mechanic Interaction Menu',
                align    = 'right',
                elements = elements
            }, function(data2, menu2)
                local action = data2.current.value
                
                if action == 'billing' then 
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                        title = _U('invoice_amount')
                    }, function(data, menu)
                        local amount = tonumber(data.value)
        
                        if amount == nil or amount < 0 then
                            ESX.ShowNotification(_U('amount_invalid'))
                        else
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification(_U('no_players_nearby'))
                            else
                                menu.close()
                                TriggerServerEvent('iG_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_' .. PlayerData.job.name,PlayerData.job.name, amount)
                            end
                        end
                    end, function(data, menu)
                        menu.close()
                    end)

                elseif action == 'permits' then
                    exports['mythic_notify']:SendAlert('inform', 'Coming soon..')

                elseif action == 'transfer_vehicle' then
                    exports['mythic_notify']:SendAlert('inform', 'Coming soon..')

                elseif action == 'assign_numberplate' then  
                    exports['mythic_notify']:SendAlert('inform', 'Coming soon..')

                end

            end, function(data2, menu2)
                menu2.close()
            end)

		elseif data.current.value == 'vehicle_interaction_menu' then
            local elements = {
                {label = 'Perform Engine Repairs',  value = 'fix_engine'},
                {label = 'Perform Bodywork Repairs',    value = 'fix_bodywork'},
                {label = 'Perform Vehicle Detailing',   value = 'clean_vehicle'},
                {label = 'Impound Nearby Vehicle',   value = 'del_vehicle'},
                {label = 'Perform Lock Decoding',   value = 'hijack_vehicle'},
            }
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction_menu', {
                title    = "Vehicle Interaction Menu",
                align    = 'right',
                elements = elements
            }, function(data2, menu2)
                local action = data2.current.value 

                if action == 'hijack_vehicle' then
                    if IsNearRepairVehicle() then
                        local playerPed = PlayerPedId()
                        local vehicle   = ESX.Game.GetVehicleInDirection()
                        local coords    = GetEntityCoords(playerPed)
            
                        if IsPedSittingInAnyVehicle(playerPed) then
                            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
                            return
                        end
            
                        if DoesEntityExist(vehicle) then
                            TriggerServerEvent('iG_Mechanics:getMechanicItems', 'lockpick', 'hijack_vehicle')
                        else
                            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
                    end

                elseif action == 'fix_engine' then
                    if IsNearRepairVehicle() then
                        local playerPed = PlayerPedId()
                        local vehicle   = ESX.Game.GetVehicleInDirection()
                        local coords    = GetEntityCoords(playerPed)
            
                        if IsPedSittingInAnyVehicle(playerPed) then
                            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
                            return
                        end
            
                        if DoesEntityExist(vehicle) then
                            mech_repairEngine(vehicle)
                        else
                            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
                    end

                elseif action == 'fix_bodywork' then
                    if IsNearRepairVehicle() then
                        local playerPed = PlayerPedId()
                        local vehicle   = ESX.Game.GetVehicleInDirection()
                        local coords    = GetEntityCoords(playerPed)
            
                        if IsPedSittingInAnyVehicle(playerPed) then
                            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
                            return
                        end
            
                        if DoesEntityExist(vehicle) then
                            mech_repairBodywork(vehicle)
                        else
                            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
                    end
        
                elseif action == 'clean_vehicle' then
                    if IsNearRepairVehicle() then
                        local playerPed = PlayerPedId()
                        local vehicle   = ESX.Game.GetVehicleInDirection()
                        local coords    = GetEntityCoords(playerPed)
            
                        if IsPedSittingInAnyVehicle(playerPed) then
                            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
                            return
                        end
            
                        if DoesEntityExist(vehicle) then
                            mech_cleanVehicle(vehicle)
                        else
                            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
                    end
        
        
                elseif action == 'del_vehicle' then
                    if IsNearRepairVehicle() then
                        local playerPed = PlayerPedId()
            
                        if IsPedSittingInAnyVehicle(playerPed) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
            
                            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                exports['mythic_notify']:SendAlert('inform', _U('vehicle_impounded'))
                                ESX.Game.DeleteVehicle(vehicle)
                            else
                                exports['mythic_notify']:SendAlert('inform', _U('must_seat_driver'))
                            end
                        else
                            local vehicle = ESX.Game.GetVehicleInDirection()
            
                            if DoesEntityExist(vehicle) then
                                exports['mythic_notify']:SendAlert('inform', _U('vehicle_impounded'))
                                ESX.Game.DeleteVehicle(vehicle)
                                -- if Config.EnableJobLogs == true then
                                --     TriggerServerEvent('igLogs:AddInLog', "sar", "del_vehicle", GetPlayerName(PlayerId()))
                                -- end
                            else
                                exports['mythic_notify']:SendAlert('inform', _U('must_near'))
                            end
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
                    end

                end
            end, function(data2, menu2)
                menu2.close()
            end)

        elseif data.current.value == 'vehicle_towing_menu' then
            local elements = {
                {label = _U('flat_bed'),      value = 'dep_vehicle'}
            }
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_towing_menu', {
                title    = "Vehicle Towing Menu",
                align    = 'right',
                elements = elements
            }, function(data2, menu2)
                local action = data2.current.value 
                
                if action == 'dep_vehicle' then 
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, true)

                    local towmodel = GetHashKey('nrma_flatbed')
                    local isVehicleTow = IsVehicleModel(vehicle, towmodel)

                    if isVehicleTow then
                        local targetVehicle = ESX.Game.GetVehicleInDirection()

                        if CurrentlyTowedVehicle == nil then
                            if targetVehicle ~= 0 then
                                if not IsPedInAnyVehicle(playerPed, true) then
                                    if vehicle ~= targetVehicle then
                                        AttachEntityToEntity(targetVehicle, vehicle, 20, 0.0, -6.1, 0.95, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        CurrentlyTowedVehicle = targetVehicle
                                        exports['mythic_notify']:SendAlert('inform', _U('vehicle_success_attached'))
                                        -- if Config.EnableJobLogs == true then
                                        --     TriggerServerEvent('igLogs:AddInLog', "sar", "dep_vehicle", GetPlayerName(PlayerId()))
                                        -- end
                                        -- if NPCOnJob then
                                        --     if NPCTargetTowable == targetVehicle then
                                        --         exports['mythic_notify']:SendAlert('inform', _U('please_drop_off'))
                                        --         Config.Zones.VehicleDelivery.Type = 1

                                        --         if Blips['NPCTargetTowableZone'] then
                                        --             RemoveBlip(Blips['NPCTargetTowableZone'])
                                        --             Blips['NPCTargetTowableZone'] = nil
                                        --         end

                                        --         Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
                                        --         SetBlipRoute(Blips['NPCDelivery'], true)
                                        --     end
                                        -- end
                                    else
                                        exports['mythic_notify']:SendAlert('inform', _U('cant_attach_own_tt'))
                                    end
                                end
                            else
                                exports['mythic_notify']:SendAlert('inform', _U('no_veh_att'))
                            end
                        else

                            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                            DetachEntity(CurrentlyTowedVehicle, true, true)

                            -- if NPCOnJob then
                            --     if NPCTargetDeleterZone then

                            --         if CurrentlyTowedVehicle == NPCTargetTowable then
                            --             ESX.Game.DeleteVehicle(NPCTargetTowable)
                            --             TriggerServerEvent('vy_Solntservo:onNPCJobMissionCompleted')
                            --             StopNPCJob()
                            --             NPCTargetDeleterZone = false
                            --         else
                            --             exports['mythic_notify']:SendAlert('inform', _U('not_right_veh'))
                            --         end

                            --     else
                            --         exports['mythic_notify']:SendAlert('inform', _U('not_right_place'))
                            --     end
                            -- end

                            CurrentlyTowedVehicle = nil
                            exports['mythic_notify']:SendAlert('inform', _U('veh_det_succ'))

                        end
                    else
                        exports['mythic_notify']:SendAlert('inform', _U('imp_flatbed'))
                    end

                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == 'requested_impound_menu' then
            VehicleRequestedImpoundMenu()
        elseif data.current.value == 'assigned_impound_menu' then
            VehicleAssignedImpoundMenu()
        end
	end, function(data, menu)
		menu.close()
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								BOSS ACTIONS MENU	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function BossActionsMenu()
    ESX.UI.Menu.CloseAll()
    local elements = {}

    if PlayerData.job.grade_name == 'boss' then
        table.insert(elements, { label = _U('boss_actions'), value = 'boss_actions' })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), PlayerData.job.name, {
        css = 'unknownstory',
        title = "Boss Actions Menu",
        align = 'right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'boss_actions' then
            TriggerEvent('iG_society:openBossMenu', PlayerData.job.name, function(data2, menu2)
                menu.close()
            end)
        end
    end, function(data, menu)
        menu.close()
        CurrentAction = 'boss_actions_menu'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to access the Management Menu.'
        CurrentActionData = {}
    end)
end

RegisterNetEvent('iG_Mechanics:admin_repairEngine')
AddEventHandler('iG_Mechanics:admin_repairEngine', function(vehicle)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleDirtLevel(vehicle, 0)
            SetVehicleFuelLevel(vehicle, 100.0)
            exports['mythic_notify']:SendAlert('inform', 'You have repaired the vehicles engine.')
		end
	end
end)

RegisterNetEvent('iG_Mechanics:admin_MaxMod')
AddEventHandler('iG_Mechanics:admin_MaxMod', function(vehicle)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 1.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
            if DoesEntityExist(vehicle) then
                local props = {
                    modEngine       = 3,
                    modBrakes       = 2,
                    modTransmission = 2,
                    modSuspension   = 3,
                    modTurbo        = true,
                }
            
                ESX.Game.SetVehicleProperties(vehicle, props)
                exports['mythic_notify']:SendAlert('inform', 'You have maxed this vehicle.')
            end
		end
	end
end)

-- DisableControlAction
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isInShopMenu then
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Citizen.Wait(500)
        end
    end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if PlayerData.job ~= nil and isMechanic then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Mechanics) do
                if PlayerData.job.name == v.Job_Auth then 

                    for i=1, #v.Cloakroom, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.Cloakroom[i], true)
    
                        if distance < Config.DrawDistance then
                            DrawMarker(20, v.Cloakroom[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end
    
                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
                        end
                    end
    
                    for i=1, #v.StorageDepot, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.StorageDepot[i], true)
    
                        if distance < Config.DrawDistance then
                            DrawMarker(20, v.StorageDepot[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end
    
                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'StorageDepot', i
                        end
                    end
                    
                    if PlayerData.job.grade_name == 'boss' then
                        for i=1, #v.BossActions, 1 do
                            local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)
        
                            if distance < Config.DrawDistance then
                                DrawMarker(20, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                                letSleep = false
                            end
        
                            if distance < Config.MarkerSize.x then
                                isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
                            end
                        end
                    end
    
                    for i=1, #v.Vehicles, 1 do
                        local distSpawner = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)
                        local distStore = GetDistanceBetweenCoords(coords, v.Vehicles[i].StorePoint, true)

                        if distSpawner < Config.DrawDistance then
                            DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end

                        if distStore < Config.DrawDistance then
    						DrawMarker(25, v.Vehicles[i].StorePoint, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
                            letSleep = false
                        end

						if distSpawner < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'CarGarage', i
						end

                        if distStore < Config.DeleteMarker.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'car_store_point', i
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
				(LastStation and LastPart and LastPartNum) and
						(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('iG_Mechanics:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('iG_Mechanics:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('iG_Mechanics:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
    end
end)


AddEventHandler('iG_Mechanics:hasEnteredMarker', function(station, part, partNum)
    if part == 'Cloakroom' then
		CurrentAction = 'menu_cloakroom'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to open Cloakroom'
        CurrentActionData = {}
    elseif part == 'CarGarage' then
        CurrentAction = 'garage'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to open Garage'
        CurrentActionData = {station = station, part = part, partNum = partNum}
    elseif part == 'BossActions' then
        CurrentAction = 'boss_actions_menu'
        CurrentActionMsg = "Press ~INPUT_CONTEXT~ to access the Management Menu."
        CurrentActionData = {}
    elseif part == 'StorageDepot' then
        CurrentAction = 'storage_depot'
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to access the Storage.'
        CurrentActionData = {}
    elseif part == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to store vehicle.'
		CurrentActionData = {}
    end
end)

AddEventHandler('iG_Mechanics:hasExitedMarker', function(zone)
	if not isInShopMenu then
        ESX.UI.Menu.CloseAll()
	end
	
    CurrentActionMsg = {}
	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and isMechanic then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'storage_depot' then
					OpenMechanicStorage()
				elseif CurrentAction == 'garage' then
					OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
                elseif CurrentAction == 'car_store_point' then
                    local playerPed = GetPlayerPed(-1)
                    local playerVeh = GetVehiclePedIsIn(playerPed, false)
                    local model = GetEntityModel(playerVeh)
                    if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
                        if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
                            StoreOwnedCarsMenu()
                        else
                            ESX.ShowNotification(_U('driver_seat'))
                        end
                    else
                        ESX.ShowNotification(_U('not_correct_veh'))
                    end
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'boss_actions_menu' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('iG_society:openBossMenu', PlayerData.job.name, function(data, menu)
						menu.close()

						CurrentAction     = 'boss_actions_menu'
						CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to access the Management Menu'
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				end

				CurrentAction = nil
            end
        end

        if IsControlJustReleased(0, 167) and isMechanic then
			MobileMechanicActionsMenu()
        end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())
			currentTask.busy = false
		end
	end
end)


RegisterNetEvent('iG_phone:loaded')
AddEventHandler('iG_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = PlayerData.job.name,
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('iG_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)


-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				exports['mythic_notify']:SendAlert('inform', _U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Mechanics) do    
        local blip = AddBlipForCoord(v.Blip.Coords)

        SetBlipSprite (blip, v.Blip.Sprite)
        SetBlipDisplay(blip, v.Blip.Display)
        SetBlipScale  (blip, v.Blip.Scale)
        SetBlipColour (blip, v.Blip.Colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.Blip.Name)
        EndTextCommandSetBlipName(blip)
	end
end)

-- --------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								VEHICLE GARAGE	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function OpenVehicleSpawnerMenu(type)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local elements = {
        { label = "Vehicle Garage", action = 'garage' },
        -- { label = _U('garage_storeitem'), action = 'store_garage' }
    }

    -- if PlayerData.job.grade_name == 'boss' then
    --     table.insert(elements, { label = 'Buy Company Vehicles', action = 'buy_vehicle' })
    -- end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
        css = 'unknownstory',
        title = 'Vehicle Garage',
        align = 'right',
        elements = elements
    }, function(data, menu)
        if data.current.action == 'buy_vehicle' then
            local shopElements, shopCoords = {}
            shopCoords = Config.Zones.CarGarage.InsideShop
            if #Config.AuthorizedVehicles['Shared'] > 0 then
                for k, vehicle in ipairs(Config.AuthorizedVehicles['Shared']) do
                    table.insert(shopElements, {
                        label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
                        name = vehicle.label,
                        model = vehicle.model,
                        price = vehicle.price,
                        type = 'car'
                    })
                end
            end
            OpenShopMenu(shopElements, playerCoords, shopCoords)
        elseif data.current.action == 'garage' then
            local garage = {}

            ESX.TriggerServerCallback('iG_VehicleShop:retrieveJobSocietyVehicles', function(jobVehicles)
                if #jobVehicles > 0 then
                    for k, v in ipairs(jobVehicles) do
                        local props = json.decode(v.vehicle)
                        local hashVehicule = props.model
						local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
						local vehicleName = GetLabelText(aheadVehName)
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

                        table.insert(garage, {
                            label = labelvehicle,
                            stored = v.stored,
                            model = props.model,
                            vehicleProps = props
                        })
                    end
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
                        css = 'unknownstory',
                        title = _U('garage_title'),
                        align = 'right',
                        elements = garage
                    }, function(data2, menu2)
                        if data2.current.stored then
                            local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint()

                            if foundSpawn then
                                menu2.close()

                                ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
                                    ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

                                    TriggerServerEvent('iG_VehicleShop:setJobVehicleState', data2.current.vehicleProps.plate, false)
                                    -- exports["gl_Locksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
                                    
                                    exports['mythic_notify']:SendAlert('inform', _U('garage_released'))
                                end)
                            end
                        else
                            exports['mythic_notify']:SendAlert('inform', _U('garage_notavailable'))
                        end
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                else
                    exports['mythic_notify']:SendAlert('inform', _U('garage_empty'))

                end
            end, 'car')
		end

    end, function(data, menu)
        menu.close()
    end)
end

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('iG_Mechanics:storeVehicle', function(valid)
			if valid then
				StoreVehicle(vehicle, vehicleProps)	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps.plate)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

-- Store Vehicles
function StoreVehicle(vehicle, vehicleProps)
	DeleteEntity(vehicle)
	TriggerServerEvent('iG_VehicleGarage:setVehicleState', vehicleProps.plate, true)
	ESX.ShowNotification(_U('vehicle_in_garage'))
end


function GetAvailableVehicleSpawnPoint()
    local spawnPoints
    local found, foundSpawnPoint = false, nil

    for k,v in pairs(Config.Mechanics) do
        if PlayerData.job.name == v.Job_Auth then 
            for i=1, #v.Vehicles, 1 do
                spawnPoints = v.Vehicles[i].SpawnPoints
            end
        end
    end

    for i = 1, #spawnPoints, 1 do
        if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
            found, foundSpawnPoint = true, spawnPoints[i]
            break
        end
    end

    if found then
        return true, foundSpawnPoint
    else
        exports['mythic_notify']:SendAlert('inform', _U('vehicle_blocked'))
        return false
    end
end


function OpenShopMenu(elements, restoreCoords, shopCoords)
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

                        ESX.TriggerServerCallback('iG_Mechanics:buyJobVehicle', function(bought)
                            if bought then
                                exports['mythic_notify']:SendAlert('inform', _U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))
                                isInShopMenu = false
                                ESX.UI.Menu.CloseAll()
                                DeleteSpawnedVehicles()
                                FreezeEntityPosition(playerPed, false)
                                SetEntityVisible(playerPed, true)
                                ESX.Game.Teleport(playerPed, restoreCoords)
                            else
                                exports['mythic_notify']:SendAlert('inform', _U('vehicleshop_money'))
                                menu2.close()
                            end
                        end, props, data.current.type)
                        menu2.close()
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
        ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
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
    ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
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

            drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
        end
    end
end

AddEventHandler('iG:onPlayerSpawn', function(spawn)
	isDead = false
end)

function OpenMechanicStorage()
    ESX.TriggerServerCallback("iG_BusinessStorage:getBusinessStorageInventory", function(inventory)
            TriggerEvent("ig-inventory:openBusinessStorageInventory", inventory)
    end, PlayerData.job.name)
end



RegisterNetEvent('iG_Mechanics:Mech:cleanVehicle')
AddEventHandler('iG_Mechanics:Mech:cleanVehicle', function(vehicle)
	-- if isNearWindow() then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = nil

			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			else
				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			end

			if DoesEntityExist(vehicle) then
				
				-- carcleaner = CreateObject(GetHashKey("prop_sponge_01"), 0, 0, 0, true, true, true)		
				-- AttachEntityToEntity(carcleaner, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, -0.01, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
				exports['mythic_progbar']:Progress({
					name = "clean_vehicle",
					duration = 15000,
					label = "Performing vehicle detailing..",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "timetable@floyd@clean_kitchen@base",
						anim = "base",
						flags = 49,
					},
				}, function(status)
					if not status then
				
						ClearPedSecondaryTask(playerPed)
						-- DeleteObject(carcleaner)
						SetVehicleDirtLevel(vehicle, 0)
						-- TriggerServerEvent('vy_UsableItems:removeItemCarcleaner')
						exports['mythic_notify']:SendAlert('inform', 'You have completed detailing the vehicle.')
					end
				end)
				-- if DoesEntityExist(carcleaner) then
				-- 	Citizen.Wait(15000)
				-- 	DeleteObject(carcleaner)
				-- end	
			end
		end
	-- else
	-- 	exports['mythic_notify']:SendAlert('error', 'You need to be at the vehicles window to clean this.')
	-- end
end)



RegisterNetEvent('iG_Mechanics:Mech:repairBodykit')
AddEventHandler('iG_Mechanics:Mech:repairBodykit', function()
	-- if isNearVehicle() then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
	-- else
	-- 	exports['mythic_notify']:SendAlert('error', 'You need to be near the vehicles fender or door to repair this.')
	-- end
end)


function mech_repairEngine(vehicle)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
    SetVehicleDoorOpen(vehicle, 4, false, false)
	exports['mythic_progbar']:Progress({
        name = "repair_engine",
        duration = 17500,
        label = "Performing engine repairs..",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
    }, function(status)
        if not status then
            SetVehicleEngineHealth(vehicle, 1000.0) 
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            SetVehicleUndriveable(vehicle, false)
            -- TriggerServerEvent('vy_UsableItems:removeItemEngine')
            exports['mythic_notify']:SendAlert('inform', 'You have repaired the vehicles engine.')
            SetVehicleDoorShut(vehicle, 4, false, false)
        end
    end)
end

function mech_repairBodywork(targetVehicle)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local engineHealth = GetVehicleEngineHealth(targetVehicle)
    exports['mythic_progbar']:Progress({
        name = "repair_body",
        duration = 17500,
        label = "Performing bodywork repairs..",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
    }, function(status)
        if not status then
            SetVehicleFixed(targetVehicle)
            SetVehicleDeformationFixed(targetVehicle)
            SetVehicleEngineHealth(targetVehicle, engineHealth)
            SetVehicleBodyHealth(targetVehicle, 1000.0)
            SetVehiclePetrolTankHealth(targetVehicle, 1000.0)
            -- TriggerServerEvent('vy_UsableItems:removeItemBodywork')
            exports['mythic_notify']:SendAlert('inform', 'You have repaired the vehicles body.')
            targetVehicle = nil
        end
    end)
end

function mech_cleanVehicle(vehicle)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	carcleaner = CreateObject(GetHashKey("prop_sponge_01"), 0, 0, 0, true, true, true)		
    AttachEntityToEntity(carcleaner, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, -0.01, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
    exports['mythic_progbar']:Progress({
        name = "clean_vehicle",
        duration = 12500,
        label = "Performing vehicle detailing..",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "timetable@floyd@clean_kitchen@base",
            anim = "base",
            flags = 49,
        },
    }, function(status)
        if not status then
    
            ClearPedSecondaryTask(playerPed)
            DeleteObject(carcleaner)
            SetVehicleDirtLevel(vehicle, 0)
            -- TriggerServerEvent('vy_UsableItems:removeItemCarcleaner')
            exports['mythic_notify']:SendAlert('inform', 'You have completed detailing the vehicle.')
        end
    end)
    if DoesEntityExist(carcleaner) then
        Citizen.Wait(15000)
        DeleteObject(carcleaner)
    end	
end

local isLockpicking = false
local lockpickingVehicle = nil

function mech_decodeVehicle(vehicle)
    local playerPed = PlayerPedId()
    exports['bt-target']:CloseUI()
    isLockpicking = true
    lockpickingVehicle = vehicle
    TriggerServerEvent('iG_Lockpicking:openhtml')
end

RegisterNetEvent('iG_Lockpicking:cl_result')
AddEventHandler('iG_Lockpicking:cl_result', function(boolean)
    if isLockpicking then 
        if boolean then
            isLockpicking = false
            LockpickingSuccess()
        elseif not boolean then
            isLockpicking = false
             exports['mythic_notify']:SendAlert('error', 'Error: You\'ve failed to decode the vehicle locks.')
        end
    end
end)

function LockpickingSuccess() 
    SetVehicleDoorsLocked(lockpickingVehicle, 1)
    exports['mythic_notify']:SendAlert('inform', 'You\'ve successfully decoded the vehicle locks.')
    -- PlayVehicleDoorOpenSound(lockpickingVehicle, 1)
    lockpickingVehicle = nil
end

RegisterNetEvent('iG_Mechanics:repairEngine')
AddEventHandler('iG_Mechanics:repairEngine', function()
    if IsNearRepairVehicle() then
        local playerPed = PlayerPedId()
        local vehicle   = ESX.Game.GetVehicleInDirection()
        local coords    = GetEntityCoords(playerPed)

        if IsPedSittingInAnyVehicle(playerPed) then
            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
            return
        end

        if DoesEntityExist(vehicle) then
            mech_repairEngine(vehicle)
        else
            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
    end
end)

RegisterNetEvent('iG_Mechanics:repairBodywork')
AddEventHandler('iG_Mechanics:repairBodywork', function()
    if IsNearRepairVehicle() then
        local playerPed = PlayerPedId()
        local vehicle   = ESX.Game.GetVehicleInDirection()
        local coords    = GetEntityCoords(playerPed)

        if IsPedSittingInAnyVehicle(playerPed) then
            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
            return
        end

        if DoesEntityExist(vehicle) then
            mech_repairBodywork(vehicle)
        else
            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
    end
end)

RegisterNetEvent('iG_Mechanics:cleanVehicle')
AddEventHandler('iG_Mechanics:cleanVehicle', function()
    if IsNearRepairVehicle() then
        local playerPed = PlayerPedId()
        local vehicle   = ESX.Game.GetVehicleInDirection()
        local coords    = GetEntityCoords(playerPed)

        if IsPedSittingInAnyVehicle(playerPed) then
            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
            return
        end

        if DoesEntityExist(vehicle) then
            mech_cleanVehicle(vehicle)
        else
            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
    end
end)

RegisterNetEvent('iG_Mechanics:decodeVehicle')
AddEventHandler('iG_Mechanics:decodeVehicle', function()
    if IsNearRepairVehicle() then
        local playerPed = PlayerPedId()
        local vehicle   = ESX.Game.GetVehicleInDirection()
        local coords    = GetEntityCoords(playerPed)

        if IsPedSittingInAnyVehicle(playerPed) then
            exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'))
            return
        end

        if DoesEntityExist(vehicle) then
            mech_decodeVehicle(vehicle)
        else
            exports['mythic_notify']:SendAlert('inform', _U('no_vehicle_nearby'))
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You need to be closer to your NRMA vehicle.')
    end
end)