ESX = nil
local PlayerData = {}
local playerLoaded = false
local isAuthorised = false

local CurrentActionData, currentTask = {}, {}
local HasAlreadyEnteredMarker, hasAlreadyJoined = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().org == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(3000)
	if PlayerData.org and PlayerData.org.name == 'bratva' then
        isAuthorised = true
	end
end)


RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	playerLoaded = true
end)

RegisterNetEvent('iG:setOrg')
AddEventHandler('iG:setOrg', function(org)
	PlayerData.org = org
	Citizen.Wait(3000)
	if PlayerData.org and PlayerData.org.name == 'bratva' then
        isAuthorised = true
    else
        isAuthorised = false
    end
end)



-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isAuthorised then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Bratva) do
                if PlayerData.org.name == 'bratva' then 

                    for i=1, #v.Storage, 1 do
                        local distance = GetDistanceBetweenCoords(coords, v.Storage[i], true)
                        if distance < 5 then
                            ESX.Game.Utils.DrawText3D(v.Storage[i], 'Press [~b~E~w~] to access storage.', 0.4)
                            letSleep = false
                        end
                        if distance < 1.5 then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Storage', i
                        end
                    end

                    -- for i=1, #v.Cloakrooms, 1 do
                    --     local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)
                    --     if distance < 5 then
                    --         ESX.Game.Utils.DrawText3D(v.Cloakrooms[i], 'Press [~b~E~w~] to access the cloakroom.', 0.4)
                    --         letSleep = false
                    --     end
                    --     if distance < 5 then
                    --         isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakrooms', i
                    --     end
                    -- end

                    -- for i=1, #v.Cameras, 1 do
                    --     local distance = GetDistanceBetweenCoords(coords, v.Cameras[i], true)
                    --     if distance < 5 then
                    --         ESX.Game.Utils.DrawText3D(v.Cameras[i], 'Press [~b~E~w~] to access the cameras.', 0.4)
                    --         letSleep = false
                    --     end
                    --     if distance < 5 then
                    --         isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cameras', i
                    --     end
                    -- end

                end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('ig-x:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('ig-x:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('ig-x:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(3000)
		end
	end
end)

local open = false

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if isAuthorised then
            if CurrentAction then
                ESX.ShowHelpNotification(CurrentActionMsg)

                if IsControlJustReleased(0, 38) then
                    
                    if CurrentAction == 'menu_storage' then
                        OpenInventoryMenu()
                    -- elseif CurrentAction == 'menu_cloakroom' then
                    --     OpenCloakroom()
                    -- elseif CurrentAction == 'menu_cameras' then
                    --     OpenCameras()
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
        else
            Citizen.Wait(3000)
        end
	end
end)


function OpenInventoryMenu(storage, org)
	ESX.TriggerServerCallback("iG_Organisations:getStorageInventory", function(inventory)
			TriggerEvent("ig-inventory:openStorageInventory", inventory)
	end, org)
end


AddEventHandler('ig-x:hasEnteredMarker', function(station, part, partNum)
	if part == 'Storage' then
		CurrentAction     = 'menu_storage'
		CurrentActionMsg  = "Press ~INPUT_CONTEXT~ to access storage."
		CurrentActionData = {station = station}
    -- elseif part == 'Cloakroom' then
	-- 	CurrentAction     = 'menu_cloakroom'
	-- 	CurrentActionMsg  = _U('open_cloakroom')
	-- 	CurrentActionData = {station = station}
    -- elseif part == 'Cameras' then
	-- 	CurrentAction     = 'menu_cameras'
	-- 	CurrentActionMsg  = _U('open_cameras')
	-- 	CurrentActionData = {station = station}
	end
end)

AddEventHandler('ig-x:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- function OpenCloakroom()
--     TriggerEvent('ig-appearance:openClothingMenu')
-- end

Citizen.CreateThread(function()
    while true do
        local sleepThread = 500
        if isAuthorised then 
            local Ped = PlayerPedId()
            local PedCoords = GetEntityCoords(Ped)
            -- local isInVehicle = IsPedInAnyVehicle(Ped, true)
            for k, v in pairs(Config.Teleports) do
                local DistanceCheck = #(PedCoords - v["coords"])
                if DistanceCheck <= v["radius"] then
                    sleepThread = 5
                    ESX.Game.Utils.DrawText3D(v["coords"], "Press [~b~E~w~] to enter.", 0.4)
                    if DistanceCheck <= v["radius"] then
                        if IsControlJustPressed(0, 38) then
                            TeleportPlayer(v)
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

function TeleportPlayer(pos)
    local Values = pos
    local playerPedId = PlayerPedId()
	if not IsPedInAnyVehicle(playerPedId, true) then 
        local position = Config.Teleports[Values["goto"][1]]
        DoScreenFadeOut(100)
        Citizen.Wait(250)
        SetEntityCoords(playerPedId, position["coords"])
        -- SetEntityCoords(GetVehiclePedIsUsing(playerPedId), position)
        -- SetEntityHeading(GetVehiclePedIsUsing(playerPedId), position["h"])
        Citizen.Wait(250)
        DoScreenFadeIn(100)
    else
        local position = Config.Teleports[Values["goto"][1]]
        DoScreenFadeOut(100)
        Citizen.Wait(250)
        -- SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
        SetEntityCoords(GetVehiclePedIsUsing(playerPedId), position["coords"])
        -- SetEntityHeading(GetVehiclePedIsUsing(playerPedId), position["h"])
        Citizen.Wait(250)
        DoScreenFadeIn(100)
    end
end
