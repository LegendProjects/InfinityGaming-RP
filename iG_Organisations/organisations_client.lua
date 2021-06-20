local CurrentActionData, currentTask, spawnedVehicles = {}, {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().org == nil do
		Citizen.Wait(10)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('iG:setOrg')
AddEventHandler('iG:setOrg', function(org)
    ESX.PlayerData.org = org
end)


function OpenOrganisationInventoryMenu(storage, org)
	ESX.TriggerServerCallback("iG_Organisations:getStorageInventory", function(inventory)
			TriggerEvent("ig-inventory:openStorageInventory", inventory)
	end, org)
end




AddEventHandler('iG_Organisations:hasEnteredMarker', function(station, part, partNum)
	if part == 'Storage' then
		CurrentAction     = 'menu_storage'
		CurrentActionMsg  = _U('open_storage')
		CurrentActionData = {station = station}
	end
end)

AddEventHandler('iG_Organisations:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)



-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.IsPlayerLoaded() and ESX.PlayerData.org.name  ~= 'unassigned' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Organisations) do
                if ESX.PlayerData.org.name == v.Org_Auth then 

                    for i=1, #v.Storage, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.Storage[i], true)

                        if distance < Config.DrawDistance then
                            DrawMarker(21, v.Storage[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                            letSleep = false
                        end

                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Storage', i
                        end
                    end
                end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('iG_Organisations:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('iG_Organisations:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('iG_Organisations:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

local open = false

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.IsPlayerLoaded() and ESX.PlayerData.org and ESX.PlayerData.org.name ~= 'unassigned' then
				
				if CurrentAction == 'menu_storage' then
					OpenOrganisationInventoryMenu()
				end
				CurrentAction = nil
			end	

		end -- CurrentAction end
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end

	end
end)