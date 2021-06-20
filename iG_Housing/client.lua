ESX	= nil
local timer, drawRange, timeInd = 0, 0, -1
local HasAlreadyEnteredMarker, isDead, isInMarker, canUpdate, atShop, inShop, inAuction, shouldDelete, inHome, isUnfurnishing, blinking = false, false, false, false, false, false, false, false, false, false, false
local LastZone, CurrentAction, currentZone, spawnedFurn, homeID, dor2Update, returnPos
local CurrentActionMsg, currentHouseID = '', ''
local CurrentActionData, PlayerData, Houses, ParkedCars, SpawnedHome, FrontDoor, spawnedHouseSpots, scriptBlips, validObjects, spawnedProps, persFurn, ticks = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local Blips, Markers = Config.Blips, Config.Markers

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Strings.trigEv, function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	if Config.MonthlyContracts then
		TriggerServerEvent('iG_Housing:checkOwnedDates')
	end
	-- local blip = AddBlipForCoord(Config.Furnishing.Store.enter)

	-- SetBlipSprite (blip, Blips.Furniture.Sprite)
	-- SetBlipScale  (blip, 0.8)
	-- SetBlipAsShortRange(blip, true)
	-- SetBlipColour (blip, Blips.Furniture.Color)
	-- SetBlipDisplay(blip, Blips.Furniture.Display)

	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentString(Config.Furnishing.Store.name)
	-- EndTextCommandSetBlipName(blip)
	-- table.insert(scriptBlips, blip)
	ESX.TriggerServerCallback('iG_Housing:getHousing', function(houses)
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			Houses[v.id] = v
		end
		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then
				local blip = AddBlipForCoord(v.door)

				SetBlipScale  (blip, 0.5)
				SetBlipAsShortRange(blip, true)
				if PlayerData.identifier == v.owner then
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, 0.5)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
				elseif v.owner == 'nil' then
					SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
					SetBlipColour (blip, Blips.UnOwnedHome.Color)
					SetBlipScale  (blip, 0.5)
					SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
				else
					SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
					SetBlipColour (blip, Blips.OtherOwnedHome.Color)
					SetBlipScale  (blip, 0.5)
					SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
				end

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Housing: " .. k)
				EndTextCommandSetBlipName(blip)
				table.insert(scriptBlips, blip)
			end
			for g,f in pairs(v.furniture.outside) do
				table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
			end
			-- for j,k in pairs(v.furniture.inside) do
			-- 	table.insert(persFurn, {model = k.prop, pos = vector3(k.x, k.y, k.z), head = k.heading})
			-- end
		end
	end)
	TriggerServerEvent('iG_Housing:refreshVehicles', true)
	local sleep
	while true do
		sleep = 500
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		isInMarker, canUpdate = false, false
		while inAuction do
			Citizen.Wait(0)
			DisableControlAction(0, 51)
			if IsDisabledControlJustPressed(0, 51) then
				timer = timer + Config.Auction.MaxTime
			end
		end
		for k,v in pairs(Houses) do
			local dis = #(pos - v.door)
			if dis <= v.draw then
				sleep = 5
				if dis <= 1.25 then
					isInMarker  = true
					currentZone = v
					if IsControlJustReleased(0, 51) then
						HouseMenu()
					end
				end
				if PlayerData.identifier == v.owner then
					if Markers.OwnedMarkers then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
					end
				elseif v.owner == 'nil' then
					if Markers.UnOwnedMarks then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
					end
				else
					if Markers.OtherMarkers then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, false, false, false, false)
					end
				end
				if Config.DisableMLOMarkersUntilUnlocked then
					if IsHouseUnlocked(v) then
						if Markers.IntMarkers then
							DrawMarker(1, v.storage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						if type(v.storage) == 'vector3' then
							dis = #(pos - v.storage)
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									-- local dict = 'amb@prop_human_bum_bin@base'
									-- RequestAnimDict(dict)
									-- while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
									-- TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
									TriggerEvent(Config.InventoryHudEvent, v.id)
								end
							end
						end
					end
					if Markers.IntMarkers then
						DrawMarker(1, v.wardrobe, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
					end
					if type(v.wardrobe) == 'vector3' then
						dis = #(pos - v.wardrobe)
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								WardrobeMenu()
							end
						end
					end
				else
					if Markers.IntMarkers then
						DrawMarker(1, v.storage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						DrawMarker(1, v.wardrobe, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
					end
					dis = #(pos - v.storage)
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							local dict = 'amb@prop_human_bum_bin@base'
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
							TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
							TriggerEvent(Config.InventoryHudEvent, v.id)
						end
					end
					dis = #(pos - v.wardrobe)
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							WardrobeMenu()
						end
					end
				end
				for i = 1,#v.doors do
					if v.doors[i] ~= nil then
						if type(v.doors[i].pos) ~= 'vector3' then
							v.doors[i].pos = vector3(ESX.Math.Round(v.doors[i].pos.x, 2), ESX.Math.Round(v.doors[i].pos.y, 2), ESX.Math.Round(v.doors[i].pos.z, 2))
						end
						if not v.doors[i].object then
							v.doors[i].object = GetClosestObjectOfType(v.doors[i].pos, 2.0, v.doors[i].prop, false, false, false)
						end
						if not DoesEntityExist(v.doors[i].object) then
							v.doors[i].object = GetClosestObjectOfType(v.doors[i].pos, 2.0, v.doors[i].prop, false, false, false)
						end
						if v.owner == 'nil' then
							v.doors[i].locked = false
						end
						local dis = #(pos - v.doors[i].pos)
						if dis <= 2.5 then
							FreezeEntityPosition(v.doors[i].object, v.doors[i].locked)
							DrawDoorText(v.doors[i].pos, v.doors[i].locked)
							if v.owner == PlayerData.identifier or HasKeys(v) then
								canUpdate = true
								dor2Update = v.doors[i]
								currentZone = v
								if Markers.OwnedMarkers then
									DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
								end
							else
								if v.owner == 'nil' then
									if Markers.UnOwnedMarks then
										DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
									end
								else
									if Markers.OtherMarkers then
										DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, false, false, false, false)
									end
								end
							end
						end
						if v.doors[i].locked == true then
							SetEntityHeading(v.doors[i].object, v.doors[i].head)
						end
					end
				end
				for i = 1,#v.garages do
					if v.garages[i] ~= nil then
						if type(v.garages[i].pos) ~= 'vector3' then
							v.garages[i].pos = vector3(ESX.Math.Round(v.garages[i].pos.x, 2), ESX.Math.Round(v.garages[i].pos.y, 2), ESX.Math.Round(v.garages[i].pos.z, 2))
						end
						if not v.garages[i].object then
							v.garages[i].object = GetClosestObjectOfType(v.garages[i].pos, 2.0, v.garages[i].prop, false, false, false)
						end
						if not DoesEntityExist(v.garages[i].object) then
							v.garages[i].object = GetClosestObjectOfType(v.garages[i].pos, 2.0, v.garages[i].prop, false, false, false)
						end
						if v.owner == 'nil' then
							v.garages[i].locked = false
						end
						local dis = #(pos - v.garages[i].pos)
						if dis <= v.garages[i].draw * 2.0 then
							FreezeEntityPosition(v.garages[i].object, v.garages[i].locked)
							if dis <= v.garages[i].draw then
								DrawDoorText(v.garages[i].pos, v.garages[i].locked)
								if v.owner == PlayerData.identifier or HasKeys(v) then
									canUpdate = true
									dor2Update = v.garages[i]
									currentZone = v
								end
							end
						end
					end
				end
				if Config.UseScriptParking then
					if v.owner ~= 'nil' then
						if IsPedInAnyVehicle(ped, true) then
							for i = 1,#v.parkings do
								vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
								dis = #(pos - vec)
								if PlayerData.identifier == v.owner then
									if Markers.OwnedMarkers then
										DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 100, false, false, 2, false, false, false, false)
									end
								else
									if Markers.OtherMarkers then
										DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 100, false, false, 2, false, false, false, false)
									end
								end
								if dis <= 1.25 then
									DrawPrompt(vec, Config.Strings.parkCar)
									if IsControlJustReleased(0, 51) then
										if Config.BlinkOnRefresh then
											if not blinking then
												blinking = true
												if timeInd ~= 270 then
													timeInd = GetTimecycleModifierIndex()
													SetTimecycleModifier('Glasses_BlackOut')
												end
											end
										end
										local veh = GetVehiclePedIsIn(ped, true)
										if DoesEntityExist(veh) then
											local vehProps  = ESX.Game.GetVehicleProperties(veh)
											local livery = GetVehicleLivery(veh)
											local damages	= {
												eng = GetVehicleEngineHealth(veh),
												bod = GetVehicleBodyHealth(veh),
												tnk = GetVehiclePetrolTankHealth(veh),
												drt = GetVehicleDirtLevel(veh),
												oil = GetVehicleOilLevel(veh),
												lok = GetVehicleDoorLockStatus(veh),
												drvlyt = GetIsLeftVehicleHeadlightDamaged(veh),
												paslyt = GetIsRightVehicleHeadlightDamaged(veh),
												dor = {},
												win = {},
												tyr = {}
											}
											local vehPos    = GetEntityCoords(veh)
											local vehHead   = GetEntityHeading(veh)
											for i = 0,5 do
												table.insert(damages.dor, i)
												damages.dor[i] = false
												if not DoesVehicleHaveDoor(veh, i) then
													damages.dor[i] = true
												end
											end
											for i = 0,8 do
												table.insert(damages.win, i)
												damages.win[i] = false
												if not IsVehicleWindowIntact(veh, i) then
													damages.win[i] = true
												end
											end
											for i = 0,7 do
												table.insert(damages.tyr, i)
												damages.tyr[i] = false
												if IsVehicleTyreBurst(veh, i, false) then
													damages.tyr[i] = 'popped'
												elseif IsVehicleTyreBurst(veh, i, true) then
													damages.tyr[i] = 'gone'
												end
											end
											LastPlate = vehProps.plate
											DeleteEntity(veh)
											TriggerServerEvent('iG_Housing:parkUnpark', {
												location = {x = vehPos.x, y = vehPos.y, z = vehPos.z, h = vehHead},
												props    = vehProps,
												parking  = parkName,
												livery   = livery,
												damages   = damages
											})
										else
											Notify(Config.Strings.mstBNCr)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		local dis = #(pos - Config.Furnishing.Store.enter)
		if dis <= Config.Furnishing.Store.range then
			if not Config.Furnishing.Store.isMLO then
				sleep = 5
				if Markers.FurnMarkers then
					DrawMarker(1, Config.Furnishing.Store.enter, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
				end
				if dis < 1.25 then
					DrawPrompt(Config.Furnishing.Store.enter, Config.Strings.ntrFurn)
					if IsControlJustReleased(0, 51) then
						OpenFurnStore()
					end
				end
			else
				if not atShop then
					atShop = true
					for k,v in pairs(Config.Furnishing.Props) do
						validObjects[k] = {}
						validObjects[k].pos = v.pos
						validObjects[k].hed = v.hed
						validObjects[k].items = {}
						for i = 1,#v.items do
							if IsModelInCdimage(GetHashKey(v.items[i].prop)) then
								table.insert(validObjects[k].items, v.items[i])
							end
						end
					end
					local ped = PlayerPedId()
					for k,v in pairs(validObjects) do
						local prop = CreateObjectNoOffset(v.items[1].prop, v.pos, false, false, false)
						SetEntityAsMissionEntity(prop, true, true)
						SetEntityHeading(prop, v.hed)
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedProps[k] = prop
					end
					Citizen.CreateThread(function()
						while atShop do
							local pos = GetEntityCoords(ped)
							local dis
							for k,v in pairs(Config.Furnishing.Props) do
								DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.5, k)
								dis = #(pos - v.pos)
								if dis <= 2.5 then
									DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.0, Config.Strings.mnuScll)
									if IsControlJustReleased(0, 51) then
										OpenFurnMenu(k,v)
										Citizen.CreateThread(function()
											while spawnedProps[k] ~= nil do
												Citizen.Wait(10)
												local pos = GetEntityCoords(PlayerPedId())
												local distance = #(pos - v.pos)
												if distance > 2.5 then
													break
												end
												DisableControlAction(0, 174)
												DisableControlAction(0, 175)
												if IsDisabledControlPressed(0, 174) then
													SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) - 0.5)
												end
												if IsDisabledControlPressed(0, 175) then
													SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) + 0.5)
												end
											end
										end)
									end
								end
							end
							Citizen.Wait(5)
						end
					end)
				end
			end
		elseif atShop then
			if Config.Furnishing.Store.isMLO then
				atShop = false
				for k,v in pairs(spawnedProps) do
					DeleteEntity(v)
				end
			end
		end
		dis = #(pos - Config.Furnishing.Store.exitt)
		if Markers.FurnMarkers then
			if dis <= Config.Furnishing.Store.range then
				sleep = 5
				DrawMarker(1, Config.Furnishing.Store.exitt.x, Config.Furnishing.Store.exitt.y, Config.Furnishing.Store.exitt.z-1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
			end
		end
		if dis <= 1.25 then
			DrawPrompt(Config.Furnishing.Store.exitt, Config.Strings.xitFurn)
			if IsControlJustReleased(0, 51) then
				for k,v in pairs(spawnedProps) do
					DeleteEntity(v)
				end
				SetEntityCoords(ped, Config.Furnishing.Store.enter)
				SetEntityHeading(ped, Config.Furnishing.Store.exthead)
				atShop = false
				inShop = false
			end
		end
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('iG_Housing:hasEnteredMarker', currentZone)
			Notify(CurrentActionMsg)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('iG_Housing:hasExitedMarker', LastZone)
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local pos = GetEntityCoords(PlayerPedId())
		for k,v in pairs(ParkedCars) do
			local dis = #(pos - v.pos)
			if dis < 75.0 then
				if not ParkedCars[k].entity then
					Citizen.CreateThread(function()
						while not HasModelLoaded(v.props.model) do
							RequestModel(v.props.model)
							Citizen.Wait(1)
						end
						ParkedCars[k].entity = CreateVehicle(v.props.model, v.pos.x, v.pos.y, v.pos.z, v.location.h, false)
						while not DoesEntityExist(ParkedCars[k].entity) do Citizen.Wait(10) end
						ESX.Game.SetVehicleProperties(ParkedCars[k].entity, v.props)
						SetVehicleOnGroundProperly(ParkedCars[k].entity)
						SetEntityAsMissionEntity(ParkedCars[k].entity, true, true)
						SetModelAsNoLongerNeeded(v.props.model)
						SetEntityInvincible(ParkedCars[k].entity, true)
						SetVehicleLivery(ParkedCars[k].entity, v.livery)
						SetVehicleEngineHealth(ParkedCars[k].entity, v.damages.eng)
						SetVehicleOilLevel(ParkedCars[k].entity, v.damages.oil)
						SetVehicleBodyHealth(ParkedCars[k].entity, v.damages.bod)
						SetVehicleDoorsLocked(ParkedCars[k].entity, v.damages.lok)
						SetVehiclePetrolTankHealth(ParkedCars[k].entity, v.damages.tnk)
						for i = 0,5 do
							if v.damages.dor[i] then
								SetVehicleDoorBroken(ParkedCars[k].entity, i, true)
							end
						end
						for i = 0,13 do
							if v.damages.win[i] then
								SmashVehicleWindow(ParkedCars[k].entity, i)
							end
						end
						for i = 0,7 do
							if v.damages.tyr[i] == 'popped' then
								SetVehicleTyreBurst(ParkedCars[k].entity, i, false, 850.0)
							elseif v.damages.tyr[i] == 'gone' then
								SetVehicleTyreBurst(ParkedCars[k].entity, i, true, 1000.0)
							end
						end
						while not HasCollisionLoadedAroundEntity(ParkedCars[k].entity) do
							Citizen.Wait(10)
						end
						SetVehicleOnGroundProperly(ParkedCars[k].entity)
						FreezeEntityPosition(ParkedCars[k].entity, true)
					end)
				end
			elseif ParkedCars[k].entity ~= nil then
				DeleteEntity(ParkedCars[k].entity)
				ParkedCars[k].entity = nil
			end
		end
		if not isUnfurnishing then
			for k,v in pairs(persFurn) do
				local dis = #(pos - v.pos)
				if dis < 75.0 then
					if not persFurn[k].entity then
						Citizen.CreateThread(function()
							local model = v.model
							while not HasModelLoaded(model) do
								RequestModel(model)
								Citizen.Wait(1)
							end
							persFurn[k].entity = CreateObjectNoOffset(model, v.pos.x, v.pos.y, v.pos.z, false, false, false)
							while not DoesEntityExist(persFurn[k].entity) do Citizen.Wait(10) end
							SetEntityAsMissionEntity(persFurn[k].entity, true, true)
							SetEntityHeading(persFurn[k].entity, v.head)
							SetModelAsNoLongerNeeded(model)
							SetEntityInvincible(persFurn[k].entity, true)
							FreezeEntityPosition(persFurn[k].entity, true)
							while not HasCollisionLoadedAroundEntity(persFurn[k].entity) do
								Citizen.Wait(10)
							end
						end)
					end
				elseif persFurn[k].entity ~= nil then
					DeleteEntity(persFurn[k].entity)
					persFurn[k].entity = nil
				end
			end
		end
	end
end)

IsAddressHidden = function(address)
	local blacklisted = false
	for i = 1,#Config.HiddenProperty do
		if address == Config.HiddenProperty[i] then
			blacklisted = true
		end
	end
	return blacklisted
end

IsParkingTooClose = function(pos)
	local tooClose = false
	for k,v in pairs(Houses) do
		for i = 1,#v.parkings do
			local vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
			local dis = #(vec - pos)
			if dis <= 2.5 then
				tooClose = true
			end
		end
	end
	return tooClose
end

GetSafeSpot = function()
	for i = 1,#Config.Defaults.SpawnSpots do
		if not IsHomeTouchingHome(Config.Defaults.SpawnSpots[i].x, Config.Defaults.SpawnSpots[i].y, Config.Defaults.SpawnSpots[i].z) then
			return Config.Defaults.SpawnSpots[i]
		end
	end
	return vector3(560.84, 1284.6, 122.68)
end

CreateRandomAddress = function()
	math.randomseed(GetGameTimer())
	local streetName, streetNum = '', math.random(1000, 99999)
	for i = 1, 5 do
		streetName = streetName..string.char(math.random(97,122))
	end
	streetName = streetName..' '
	for i = 1, 10 do
		streetName = streetName..string.char(math.random(97,122))
	end
	return streetNum..' '..streetName..' Drive'
end

IsHouseUnlocked = function(home)
	unLocked = false
	if PlayerData.identifier == home.owner then
		unLocked = true
	end
	for i = 1,#home.doors do
		if home.doors[i] ~= nil then
			if home.doors[i].locked == false then
				unLocked = true
			end
		end
	end
	for i = 1,#home.garages do
		if home.garages[i] ~= nil then
			if home.garages[i].locked == false then
				unLocked = true
			end
		end
	end
	return unLocked
end

Notify = function(text, timer)
	if timer == nil then
		timer = 5000
	end
	-- exports['mythic_notify']:DoCustomHudText('inform', text, timer)
	-- exports.pNotify:SendNotification({layout = 'centerLeft', text = text, type = 'error', timeout = timer})
	ESX.ShowNotification(text)
end

HelpText1 = function(msg, beep)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 200)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(Config.HelpText.X, Config.HelpText.Y)
end

HelpText2 = function(msg, beep)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 200)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(Config.HelpText.X, Config.HelpText.Y + 0.09)
end

CanRaid = function()
	local hasJob = false
	for k,v in pairs(Config.Raids.Jobs) do
		if PlayerData.job.name == k then
			if PlayerData.job.grade >= v then
				hasJob = true
			end
		end
	end
	return hasJob
end

HasKeys = function(house)
	local hasKey = false
	for i = 1,#house.keys do
		if PlayerData.identifier == house.keys[i] then
			hasKey = true
		end
	end
	return hasKey
end

IsUnlocked = function(house)
	return house.locked == 'false'
end

IsHouseSpawned = function(house)
	local isSpawned, owner = false
	for k,v in pairs(spawnedHouseSpots) do
		if v.id == house.id then
			isSpawned = true
			owner = v.owner
		end
	end
	return isSpawned, owner
end

DrawDoorText = function(pos, text)
	if text == true then
		text = Config.Strings.l0ckTxt
	else
		text = Config.Strings.unlkTxt
	end
	local onScreen,_x,_y=World3dToScreen2d(pos.x, pos.y, pos.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

DrawPrompt = function(pos, text)
	local onScreen,_x,_y=World3dToScreen2d(pos.x, pos.y, pos.z+1.0)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

HouseMenu = function()
	local ped = PlayerPedId()
	local elements = {}
	local house = CurrentActionData
	local isMLO = house.shell == 'mlo'
	if house.owner == 'nil' then
		table.insert(elements, {label = Config.Strings.buyText:format(house.price), value = 'buy'})
		if not isMLO then
			table.insert(elements, {label = Config.Strings.viewTxt, value = 'view'})
		end
	elseif PlayerData.identifier == house.owner then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'enter'})
		else
			table.insert(elements, {label = Config.Strings.lockTxt, value = 'lock'})
		end
		-- table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		-- table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		table.insert(elements, {label = Config.Strings.sellTxt, value = 'sell'})
		table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
	elseif HasKeys(house) then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'usekey'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	elseif IsUnlocked(house) then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'usekey'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	elseif CanRaid() then
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
		if not isMLO then
			table.insert(elements, {label = Config.Strings.raidTxt, value = 'raid'})
		end
	else
		if Config.BandE.Allow then
			table.insert(elements, {label = Config.Strings.bneText, value = 'breakin'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'front_door',
	{
		title    = house.id,
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'buy' then
			if  PlayerData.identifier == house.prevowner then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('iG_Housing:purchaseHome', house)
			else
				local elements2 = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
				if Config.FurnishedHouses[house.shell] ~= nil then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_full',
					{
						title = Config.Strings.autoFrn,
						align = 'right',
						elements = elements2
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							ESX.UI.Menu.CloseAll()
							TriggerServerEvent('iG_Housing:purchaseHome', house, true)
						else
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_furnd',
							{
								title = Config.Strings.prevFrn,
								align = 'right',
								elements = elements2
							}, function(data3, menu3)
								if data3.current.value == 'yes' then
									ESX.UI.Menu.CloseAll()
									TriggerServerEvent('iG_Housing:purchaseHome', house)
								else
									ESX.UI.Menu.CloseAll()
									TriggerServerEvent('iG_Housing:purchaseHome', house, false)
								end
							end, function(data3, menu3)
								menu3.close()
							end)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_furnd',
					{
						title = Config.Strings.prevFrn,
						align = 'right',
						elements = elements2
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							ESX.UI.Menu.CloseAll()
							TriggerServerEvent('iG_Housing:purchaseHome', house)
						else
							ESX.UI.Menu.CloseAll()
							TriggerServerEvent('iG_Housing:purchaseHome', house, false)
						end
					end, function(data3, menu3)
						menu3.close()
					end)
				end
			end
		elseif action == 'view' then
			ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerEvent('iG_Housing:spawnHome', house, 'visit')
				shouldDelete = true
			end)
		elseif action == 'enter' then
			ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				spawnedHouseSpots = spots
				local houseSpawned, houseOwner = IsHouseSpawned(house)
				if not houseSpawned then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('iG_Housing:spawnHome', house, 'owned')
					shouldDelete = true
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('iG_Housing:doorKnock', house, 'true')
				end
			end)
		elseif action == 'lock' then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('iG_Housing:lockHouse', house)
		elseif action == 'furnish' then
			ESX.UI.Menu.CloseAll()
			-- FurnishOutHome(house)
		elseif action == 'unfurnish' then
			ESX.UI.Menu.CloseAll()
			-- UnFurnishOutHome(house)
		elseif action == 'sell' then
			ESX.UI.Menu.CloseAll()
			VerifySell(house)
		elseif action == 'knock' then
			ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('iG_Housing:doorKnock', house)
			end)
		elseif action == 'raid' then
			ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('iG_Housing:doorKnock', house, 'true')
			end)
		-- elseif action == 'breakin' then
			-- ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				-- spawnedHouseSpots = spots
				-- ESX.UI.Menu.CloseAll()
				-- TriggerServerEvent('iG_Housing:doorKnock', house, 'true')
			-- end)
		elseif action == 'givekey' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'givekey'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title = Config.Strings.giveKey,
				align = 'right',
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'givekey' then
					TriggerServerEvent('iG_Housing:giveKey', GetPlayerServerId(player), house)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'usekey' then
			ESX.TriggerServerCallback('iG_Housing:getSpots', function(spots)
				spawnedHouseSpots = spots
				local houseSpawned, houseOwner = IsHouseSpawned(house)
				if not houseSpawned then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('iG_Housing:spawnHome', house, 'owned')
					shouldDelete = true
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('iG_Housing:doorKnock', house, 'false')
				end
			end)
		elseif action == 'exit' then
			ESX.UI.Menu.CloseAll()
		end
	end, function(data, menu)
		menu.close()
	end)
end

ExitMenu = function(house)
	local ped = PlayerPedId()
	local elements = {{label = Config.Strings.leavTxt, value = 'exit'}}
	if PlayerData.identifier == house.owner then
		table.insert(elements, {label = Config.Strings.letNTxt, value = 'letin'})
		table.insert(elements, {label = Config.Strings.lockTxt, value = 'lock'})
		-- table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		-- table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
	elseif HasKeys(house) then
		if Config.KeyOptions.LetIn then
			table.insert(elements, {label = Config.Strings.letNTxt, value = 'letin'})
		end
		if Config.KeyOptions.SetLock then
			table.insert(elements, {label = Config.Strings.lockTxt, value = 'lock'})
		end
		if Config.KeyOptions.GiveKeys then
			table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
		end
		if Config.KeyOptions.Furnish then
			-- table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		end
		if Config.KeyOptions.Unfurnish then
			-- table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'front_door',
	{
		title    = house.id,
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'furnish' then
			ESX.UI.Menu.CloseAll()
			-- FurnishHome(house)
		elseif action == 'unfurnish' then
			ESX.UI.Menu.CloseAll()
			-- UnFurnishHome(house)
		elseif action == 'lock' then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('iG_Housing:lockHouse', house)
		elseif action == 'letin' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local door = house.door
			local vec = vector3(door.x, door.y, door.z)
			local player, distance = ESX.Game.GetClosestPlayer(vec)
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'letin'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'let_in',
			{
				title = 'Let In',
				align = 'right',
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'letin' then
					TriggerServerEvent('iG_Housing:knockAccept', GetPlayerServerId(player), GetEntityCoords(PlayerPedId()), house, homeID)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'givekey' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'givekey'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title = Config.Strings.giveKey,
				align = 'right',
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'givekey' then
					TriggerServerEvent('iG_Housing:giveKey', GetPlayerServerId(player), house)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'exit' then
			ESX.UI.Menu.CloseAll()
			if Config.BlinkOnRefresh then
				if not blinking then
					blinking = true
					if timeInd ~= 270 then
						timeInd = GetTimecycleModifierIndex()
						SetTimecycleModifier('Glasses_BlackOut')
					end
				end
			end
			Notify(Config.Strings.amExitt)
			SetEntityCoords(ped, house.door)
			FreezeEntityPosition(ped, true)
			while not HasCollisionLoadedAroundEntity(ped) do
				Citizen.Wait(1)
				SetEntityCoords(ped, house.door)
				DisableAllControlActions(0)
			end
			Notify(Config.Strings.amClose)
			Citizen.Wait(1000)
			if Config.BlinkOnRefresh then
				if timeInd ~= -1 then
					SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
				else
					timeInd = -1
					ClearTimecycleModifier()
				end
				blinking = false
			end
			FreezeEntityPosition(ped, false)
			if shouldDelete then
				TriggerServerEvent('iG_Housing:removeGuests', house.id)
				local pos = GetEntityCoords(SpawnedHome[1])
				TriggerServerEvent('iG_Housing:regSpot', 'remove', pos)
				for i = 1,#SpawnedHome do
					DeleteEntity(SpawnedHome[i])
				end
			else
				TriggerServerEvent('iG_Housing:removeGuest', house.id)
			end
			inHome = false
			FrontDoor = {}
			SpawnedHome = {}
		end
	end, function(data, menu)
		menu.close()
	end)
end

DrawShopText = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

OpenFurnMenu = function(k,v) -- ADD AMOUNT TO BUY
	local elements = {}
	for g,f in pairs(validObjects[k].items) do
		table.insert(elements, {label = f.label..':'..Config.CurrencyIcon..f.price, value = f, prop = f.prop})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_item',
	{
		title    = Config.Strings.frnMenu,
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if GetEntityModel(spawnedProps[k]) == GetHashKey(data.current.prop) then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_buy',
			{
				title    = Config.Strings.frnMenu,
				align    = 'right',
				elements = {{label = Config.Strings.prchTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
			}, function(data2, menu2)
				if data2.current.value == 'yes' then
					TriggerServerEvent('iG_Housing:purchaseFurn', data.current.value)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end, function(data, menu)
		Citizen.CreateThread(function()
			while atShop do
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local spot = GetEntityCoords(spawnedProps[k])
				local dis = #(pos - spot)
				if dis > 2.5 then
					ESX.UI.Menu.CloseAll()
					break
				end
				Citizen.Wait(10)
			end
		end)
		local oldProp = spawnedProps[k]
		local model = data.current.prop
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(1)
		end
		local prop = CreateObjectNoOffset(model, v.pos, false, false, false)
		spawnedProps[k] = prop
		DeleteEntity(oldProp)
		SetEntityAsMissionEntity(prop, true, true)
		PlaceObjectOnGroundProperly(prop)
		FreezeEntityPosition(prop, true)
	end)
end

OpenFurnStore = function()
	for k,v in pairs(Config.Furnishing.Props) do
		validObjects[k] = {}
		validObjects[k].pos = v.pos
		validObjects[k].hed = v.hed
		validObjects[k].items = {}
		for i = 1,#v.items do
			if IsModelInCdimage(GetHashKey(v.items[i].prop)) then
				table.insert(validObjects[k].items, v.items[i])
			end
		end
	end
	local ped = PlayerPedId()
	atShop = true
	inShop = true
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	SetEntityCoords(ped, Config.Furnishing.Store.exitt)
	FreezeEntityPosition(ped, true)
	SetEntityHeading(ped, Config.Furnishing.Store.enthead)
	while not HasCollisionLoadedAroundEntity(ped) do Citizen.Wait(1) end
	for k,v in pairs(validObjects) do
		local prop = CreateObjectNoOffset(v.items[1].prop, v.pos, false, false, false)
		SetEntityAsMissionEntity(prop, true, true)
		SetEntityHeading(prop, v.hed)
		PlaceObjectOnGroundProperly(prop)
		FreezeEntityPosition(prop, true)
		spawnedProps[k] = prop
	end
	FreezeEntityPosition(ped, false)
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
	Citizen.CreateThread(function()
		while atShop do
			local pos = GetEntityCoords(ped)
			local dis
			for k,v in pairs(Config.Furnishing.Props) do
				dis = #(pos - v.pos)
				if dis <= 10.0 then
					DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.5, k)
				end
				if dis <= 2.5 then
					DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.0, Config.Strings.mnuScll)
					if IsControlJustReleased(0, 51) then
						OpenFurnMenu(k,v)
						Citizen.CreateThread(function()
							while spawnedProps[k] ~= nil do
								Citizen.Wait(10)
								DisableControlAction(0, 174)
								DisableControlAction(0, 175)
								if IsDisabledControlPressed(0, 174) then
									SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) - 0.5)
								end
								if IsDisabledControlPressed(0, 175) then
									SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) + 0.5)
								end
							end
						end)
					end
				end
			end
			Citizen.Wait(5)
		end
	end)
end

SetHomeWeather = function()
	SetRainFxIntensity(0.0) -- May not be needed, just doing it in-case
	ClearOverrideWeather()
	ClearWeatherTypePersist()
	SetWeatherTypePersist('EXTRASUNNY')
	SetWeatherTypeNow('EXTRASUNNY')
	SetWeatherTypeNowPersist('EXTRASUNNY')
	NetworkOverrideClockTime(12, 0, 0)
end

VerifySell = function(house)
	local elements = {
		{label = Config.Strings.sellMrk, value = 'market'},
		{label = Config.Strings.sellBnk, value = 'byback'},
		{label = Config.Strings.sellAuc, value = 'auction'},
		{label = Config.Strings.decText, value = 'no'}
	}
	if house.failBuy == 'true' then
		for k,v in pairs(elements) do
			if v.value == 'byback' then
				table.remove(elements, k)
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell',
	{
		title    = Config.Strings.sellTtl,
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'market' then
			ESX.UI.Menu.CloseAll()
			SelectPrice(house)
		elseif action == 'byback' then
			ESX.UI.Menu.CloseAll()
			AttemptBuyBack(house)
		elseif action == 'auction' then
			ESX.UI.Menu.CloseAll()
			RunAuction(house)
		elseif action == 'no' then
			ESX.UI.Menu.CloseAll()
		end
	end, function(data, menu)
		menu.close()
	end)
end

SelectPrice = function(house)
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	local chosePrice = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_price',
		{
			title = Config.Strings.setPryc
		},
	function(data, menu)
		local price = tonumber(data.value)
		if price == nil then
			Notify(Config.Strings.needNum)
		elseif price > Config.MaxSellPrice then
			Notify(Config.Strings.lowPryc:format(Config.MaxSellPrice))
		else
			chosePrice = price
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
	while true do
		Citizen.Wait(5)
		if chosePrice ~= nil then
			break
		end
	end
	if chosePrice ~= nil then
		TriggerServerEvent('iG_Housing:sellHouse', house, chosePrice, 'market')
	else
		Notify(Config.Strings.noPrice)
	end
	Citizen.Wait(1500)
	ClearPedTasks(ped)
	Notify(Config.Strings.onMarkt:format(house.id,chosePrice))
end

RollCheck = function(roll, market)
	local didWin = false
	if market == 'byback' then
		for i = 1,#Config.BuyBack.Win do
			if roll == Config.BuyBack.Win[i] then
				didWin = true
			end
		end
	else
		for i = 1,#Config.Auction.Win do
			if roll == Config.Auction.Win[i] then
				didWin = true
			end
		end
	end
	return didWin
end

AttemptBuyBack = function(house)
	local ped = PlayerPedId()
	Notify(Config.Strings.buyBack:format(house.id))
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	math.randomseed(GetGameTimer())
	local roll = math.random(Config.BuyBack.Roll)
	Citizen.Wait(2500)
	local didWin = RollCheck(roll, 'byback')
	if didWin then
		TriggerServerEvent('iG_Housing:sellHouse', house, house.price, 'byback')
		Notify(Config.Strings.bawtBack:format(house.id,house.price))
	else
		Notify(Config.Strings.dntWant)
		TriggerServerEvent('iG_Housing:buyBackFail', house)
	end
	ClearPedTasks(ped)
end

GetNames = function()
	local names, configFirsts, configLasts = {}, Config.Auction.FirstNames, Config.Auction.LastNames
	math.randomseed(GetGameTimer())
	for i = 1,#configLasts do
		local firstName = math.random(#configFirsts)
		local lastName = math.random(#configLasts)
		table.insert(names, configFirsts[firstName]..' '..configLasts[lastName])
		table.remove(configFirsts, firstName)
		table.remove(configLasts, lastName)
	end
	return names
end

DoesNPCWantHome = function(price)
	local doesWant, newPrice, buyer = false, price
	local fullNames = GetNames()
	math.randomseed(GetGameTimer())
	for i = 1,#fullNames do
		local roll = math.random(Config.Auction.Roll)
		local didWin = RollCheck(roll, 'auction')
		if didWin then
			doesWant = true
			newPrice = price + math.random(ESX.Math.Round(price/25), ESX.Math.Round(price/10))
			buyer = fullNames[math.random(#fullNames)]
			return doesWant, newPrice, buyer
		end
	end
	return doesWant, newPrice, buyer
end

CheckAcceptsOffer = function(house, price, buyer)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'accept_offer',
	{
		title    = Config.Strings.acptTtl:format(price,Config.Auction.DeclineFee),
		align    = 'right',
		elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
	}, function(data2, menu2)
		if data2.current.value == 'yes' then
			ESX.UI.Menu.CloseAll()
			Notify(Config.Strings.npcBawt:format(buyer,house.id,price))
			TriggerServerEvent('iG_Housing:sellHouse', house, price, 'auction')
		else
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('iG_Housing:declineAuction')
		end
	end, function(data2, menu2)
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent('iG_Housing:declineAuction')
	end)
end

RunAuction = function(house)
	local ped, purchaser = PlayerPedId()
	local price = house.price/(100/Config.Auction.StartPercent)
	local wantsIt, newPrice, buyer = DoesNPCWantHome(price)
	math.randomseed(GetGameTimer())
	local wait = math.random(5000, 10000)
	inAuction = true
	Notify(Config.Strings.strtAuc:format(house.id,price), wait)
	Notify(Config.Strings.cancAuc)
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	Citizen.Wait(wait)
	timer = timer + wait
	if wantsIt then
		if (timer < Config.Auction.MaxTime) and (newPrice < house.price/(100/Config.Auction.MaxPercent)) then
			repeat
				price = newPrice
				purchaser = buyer
				Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
				wantsIt, newPrice, buyer = DoesNPCWantHome(price)
				wait = math.random(5000, 10000)
				Citizen.Wait(wait)
				timer = timer + wait
			until (newPrice >= house.price/(100/Config.Auction.MaxPercent)) or (timer >= Config.Auction.MaxTime) or (not wantsIt)
			if wantsIt then
				Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
			end
		else
			Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
		end
		if purchaser ~= nil then
			CheckAcceptsOffer(house, newPrice, purchaser)
		else
			CheckAcceptsOffer(house, newPrice, buyer)
		end
	else
		Notify(Config.Strings.notWant)
	end
	timer = 0
	inAuction = false
	ClearPedTasks(ped)
end

FurnishOutHome = function(house)
	spawnedFurn = nil
	local ped = PlayerPedId()
	local elements = {}
	ESX.TriggerServerCallback('iG_Housing:getBoughtFurniture', function(ownedFurn)
		for k,v in pairs(ownedFurn) do
			if IsModelInCdimage(GetHashKey(v.prop)) then
				table.insert(elements, {label = k, value = v.prop})
			end
		end
		ESX.UI.Menu.CloseAll()
		if #elements > 0 then
			local model = elements[1].value
			local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
			local prop = CreateObjectNoOffset(GetHashKey(model), offset, false, false, false)
			local moveSpeed = 0.001
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
			spawnedFurn = prop
			Citizen.CreateThread(function()
				while spawnedFurn ~= nil do
					Citizen.Wait(1)
					HelpText1(Config.Strings.frnHelp1)
					HelpText2(Config.Strings.frnHelp2)
					DisableControlAction(0, 51)
					DisableControlAction(0, 96)
					DisableControlAction(0, 97)
					for i = 108, 112 do
						DisableControlAction(0, i)
					end
					DisableControlAction(0, 117)
					DisableControlAction(0, 118)
					DisableControlAction(0, 171)
					DisableControlAction(0, 254)
					if IsDisabledControlPressed(0, 171) then
						moveSpeed = moveSpeed + 0.001
					end
					if IsDisabledControlPressed(0, 254) then
						moveSpeed = moveSpeed - 0.001
					end
					if moveSpeed > 1.0 or moveSpeed < 0.001 then
						moveSpeed = 0.001
					end
					HudWeaponWheelIgnoreSelection()
					for i = 123, 128 do
						DisableControlAction(0, i)
					end
					if IsDisabledControlJustPressed(0, 51) then
						PlaceObjectOnGroundProperly(spawnedFurn)
					end
					if IsDisabledControlPressed(0, 96) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, moveSpeed))
					end
					if IsDisabledControlPressed(0, 97) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, -moveSpeed))
					end
					if IsDisabledControlPressed(0, 108) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) + 0.5)
					end
					if IsDisabledControlPressed(0, 109) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) - 0.5)
					end
					if IsDisabledControlPressed(0, 111) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, -moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 110) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 117) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, moveSpeed, 0.0, 0.0))
					end
					if IsDisabledControlPressed(0, 118) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, -moveSpeed, 0.0, 0.0))
					end
				end
			end)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
			{
				title = Config.Strings.frnMenu,
				align = 'bottom-left',
				elements = elements
			}, function(data, menu)
				model = data.current.value
				if spawnedFurn ~= nil then
					if GetEntityModel(spawnedFurn) == GetHashKey(model) then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
						{
							title    = Config.Strings.confPlc,
							align    = 'right',
							elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
						}, function(data2, menu2)
							if data2.current.value == 'yes' then
								local itemSpot = GetEntityCoords(spawnedFurn)
								local dis = #(itemSpot - house.door)
								if dis > house.draw then
									Notify(Config.Strings.uTooFar)
								else
									local itemHead = GetEntityHeading(spawnedFurn)
									local furn = house.furniture
									table.insert(furn.outside, {x = ESX.Math.Round(itemSpot.x, 2), y = ESX.Math.Round(itemSpot.y, 2), z = ESX.Math.Round(itemSpot.z, 2), heading = ESX.Math.Round(itemHead, 2), prop = model, label = data.current.label})
									TriggerServerEvent('iG_Housing:placeOutFurniture', house, itemSpot.x, itemSpot.y, itemSpot.z, itemHead, model, data.current.label)
									ESX.UI.Menu.CloseAll()
									house.furniture = furn
									Citizen.Wait(500)
									FurnishOutHome(house)
								end
							else
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
				end
				model = GetHashKey(data.current.value)
				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						-- ticks[model] = 0
						while not HasModelLoaded(model) do
							-- ESX.ShowHelpNotification('Requesting model, please wait')
							-- DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							-- ticks[model] = ticks[model] + 1
							-- if ticks[model] >= 500 then
							-- 	ticks[model] = 0
								-- ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
								-- return
							-- end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							DeleteEntity(spawnedFurn)
						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end, function(data, menu)
				DeleteEntity(spawnedFurn)
				spawnedFurn = nil
				menu.close()
			end, function(data, menu)
				model = GetHashKey(data.current.value)
				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						-- ticks[model] = 0
						while not HasModelLoaded(model) do
							-- ESX.ShowHelpNotification('Requesting model, please wait')
							-- DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							-- ticks[model] = ticks[model] + 1
							-- if ticks[model] >= 500 then
							-- 	ticks[model] = 0
								-- ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
								-- return
							-- end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							DeleteEntity(spawnedFurn)
						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end)
		else
			Notify(Config.Strings.failFnd)
		end
	end)
end

FurnishHome = function(house)
	spawnedFurn = nil
	local ped = PlayerPedId()
	local elements = {}
	ESX.TriggerServerCallback('iG_Housing:getBoughtFurniture', function(ownedFurn)
		for k,v in pairs(ownedFurn) do
			table.insert(elements, {label = k, value = v.prop})
		end
		ESX.UI.Menu.CloseAll()
		if #elements > 0 then
			local model = elements[1].value
			local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
			local prop = CreateObjectNoOffset(GetHashKey(model), offset, false, false, false)
			local moveSpeed = 0.001
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
			spawnedFurn = prop
			Citizen.CreateThread(function()
				while spawnedFurn ~= nil do
					Citizen.Wait(1)
					HelpText1(Config.Strings.frnHelp1)
					HelpText2(Config.Strings.frnHelp2)
					DisableControlAction(0, 51)
					DisableControlAction(0, 96)
					DisableControlAction(0, 97)
					for i = 108, 112 do
						DisableControlAction(0, i)
					end
					DisableControlAction(0, 117)
					DisableControlAction(0, 118)
					DisableControlAction(0, 171)
					DisableControlAction(0, 254)
					if IsDisabledControlPressed(0, 171) then
						moveSpeed = moveSpeed + 0.001
					end
					if IsDisabledControlPressed(0, 254) then
						moveSpeed = moveSpeed - 0.001
					end
					if moveSpeed > 1.0 or moveSpeed < 0.001 then
						moveSpeed = 0.001
					end
					HudWeaponWheelIgnoreSelection()
					for i = 123, 128 do
						DisableControlAction(0, i)
					end
					if IsDisabledControlJustPressed(0, 51) then
						PlaceObjectOnGroundProperly(spawnedFurn)
					end
					if IsDisabledControlPressed(0, 96) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, moveSpeed))
					end
					if IsDisabledControlPressed(0, 97) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, -moveSpeed))
					end
					if IsDisabledControlPressed(0, 108) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) + 0.5)
					end
					if IsDisabledControlPressed(0, 109) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) - 0.5)
					end
					if IsDisabledControlPressed(0, 111) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, -moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 110) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 117) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, moveSpeed, 0.0, 0.0))
					end
					if IsDisabledControlPressed(0, 118) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, -moveSpeed, 0.0, 0.0))
					end
				end
			end)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
			{
				title = Config.Strings.frnMenu,
				align = 'bottom-left',
				elements = elements
			}, function(data, menu)
				model = data.current.value
				if spawnedFurn ~= nil then
					if GetEntityModel(spawnedFurn) == GetHashKey(model) then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
						{
							title    = Config.Strings.confPlc,
							align    = 'right',
							elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
						}, function(data2, menu2)
							if data2.current.value == 'yes' then
								local itemSpot = GetEntityCoords(spawnedFurn)
								offset = GetOffsetFromEntityGivenWorldCoords(SpawnedHome[1], itemSpot)
								local itemHead = GetEntityHeading(spawnedFurn)
								local furn = house.furniture
								table.insert(furn.inside, {x = ESX.Math.Round(offset.x, 2), y = ESX.Math.Round(offset.y, 2), z = ESX.Math.Round(offset.z, 2), heading = ESX.Math.Round(itemHead, 2), prop = model, label = data.current.label})
								table.insert(SpawnedHome, spawnedFurn)
								local mLo = house.shell == 'mlo'
								TriggerServerEvent('iG_Housing:placeFurniture', house, offset.x, offset.y, offset.z, itemHead, model, data.current.label, mLo)
								ESX.UI.Menu.CloseAll()
								house.furniture = furn
								Citizen.Wait(500)
								FurnishHome(house)
							else
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
				end
				model = GetHashKey(data.current.value)
				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						-- ticks[model] = 0
						while not HasModelLoaded(model) do
							-- Notify('Requesting model, please wait')
							-- DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							-- ticks[model] = ticks[model] + 1
							-- if ticks[model] >= 1000 then
							-- 	ticks[model] = 0
							-- 	Notify('Model '..data.current.value..' failed to load')
							-- 	return
							-- end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							DeleteEntity(spawnedFurn)
						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end, function(data, menu)
				DeleteEntity(spawnedFurn)
				spawnedFurn = nil
				menu.close()
			end, function(data, menu)
				model = GetHashKey(data.current.value)
				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						-- ticks[model] = 0
						while not HasModelLoaded(model) do
							-- Notify('Requesting model, please wait')
							-- DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							-- ticks[model] = ticks[model] + 1
							-- if ticks[model] >= 1000 then
							-- 	ticks[model] = 0
							-- 	Notify('Model '..data.current.value..' failed to load')
							-- 	return
							-- end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							DeleteEntity(spawnedFurn)
						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end)
		else
			Notify(Config.Strings.failFnd)
		end
	end)
end

UnFurnishOutHome = function(house)
	print('function UnFurnishOutHome')
	isUnfurnishing = true
	local elements, spawnedCams = {}, {}
	FreezeEntityPosition(PlayerPedId(), true)
	local selFurn, selLabel
	local furni = house.furniture
	for k,v in ipairs(furni.outside) do
		table.insert(elements, {label = v.label, value = v.prop, pos = {x = v.x, y = v.y, z = v.z}})
		print('elements ' ..  v.label)
	end
	if #elements > 0 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
		{
			title = Config.Strings.frnMenu,
			align = 'right',
			elements = elements
		}, function(data, menu)
			local model = data.current.value
			selFurn = data.current.value
			selLabel = data.current.label
			print('model ' .. model)
			if selFurn ~= nil then
				print('selFurn ~= nil')
				if data.current.label == selLabel then
					print(selLabel)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
					{
						title    = Config.Strings.confRem,
						align    = 'right',
						elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							for k,v in pairs(persFurn) do
								if v.model == selFurn then
									Citizen.CreateThread(function()
										repeat
											Citizen.Wait(100)
											local prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, model, false, false, false)
											DeleteEntity(prop)
											prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, model, false, false, false)
										until not DoesEntityExist(prop)
									end)
									v.entity = nil
									table.remove(persFurn, k)
									for a, b in ipairs(furni.outside) do
										if b.x == data.current.pos.x and b.y == data.current.pos.y and b.z == data.current.pos.z then
											table.remove(furni.outside, a)
										end
									end
									house.furniture = furni
									TriggerServerEvent('iG_Housing:removeOutFurniture', house, data.current.pos, model, data.current.label)
									RenderScriptCams(false, false, 0, false, false)
									for i = 1,#spawnedCams do
										DestroyCam(spawnedCams[i], false)
									end
									ESX.UI.Menu.CloseAll()
								end
							end
							UnFurnishOutHome(house)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
			if (GetEntityModel(selFurn) ~= GetHashKey(model)) or (selLabel ~= data.current.label) then
				local prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, GetHashKey(model), false, false, false)
				if DoesEntityExist(prop) then
					offSet = GetOffsetFromEntityInWorldCoords(prop, 0.0, 1.0, 1.0)
					local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
					table.insert(spawnedCams, cam)
					SetCamCoord(cam, offSet.x, offSet.y, offSet.z)
					PointCamAtEntity(cam, prop)
					RenderScriptCams(true, false, 0, 0, 0)
					selFurn = prop
					selLabel = data.current.label
				end
			end
		end, function(data, menu)
			RenderScriptCams(false, false, 0, false, false)
			for i = 1,#spawnedCams do
				DestroyCam(spawnedCams[i], false)
			end
			menu.close()
			FreezeEntityPosition(PlayerPedId(), false)
			isUnfurnishing = false
		end)
	else
		Notify(Config.Strings.failFnd)
		FreezeEntityPosition(PlayerPedId(), false)
		isUnfurnishing = false
	end
end

UnFurnishHome = function(house)
	local elements, spawnedCams = {}, {}
	local selFurn, selLabel
	local furni = house.furniture
	FreezeEntityPosition(PlayerPedId(), true)
	for k,v in ipairs(furni.inside) do
		table.insert(elements, {label = v.label, value = v.prop, pos = {x = v.x, y = v.y, z = v.z}})
	end
	if #elements > 0 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
		{
			title = Config.Strings.frnMenu,
			align = 'right',
			elements = elements
		}, function(data, menu)
			local model = data.current.value
			selFurn = data.current.value
			selLabel = data.current.label
			if selFurn ~= nil then
				if data.current.label == selLabel then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
					{
						title    = Config.Strings.confRem,
						align    = 'right',
						elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then

							for k,v in pairs(SpawnedHome) do
								print(v)
								print(GetEntityModel(v))
								print('selFurn = ' .. selFurn)
								if GetEntityModel(v) == selFurn then
									print('v == selFurn')
									DeleteEntity(v)
									table.remove(SpawnedHome, k)
									local mLo = house.shell == 'mlo'
									for a, b in ipairs(furni.inside) do
										if b.x == data.current.pos.x and b.y == data.current.pos.y and b.z == data.current.pos.z then
											table.remove(furni.inside, a)
										end
									end
									house.furniture = furni
									TriggerServerEvent('iG_Housing:removeFurniture', house, data.current.pos, model, data.current.label, mLo)
									RenderScriptCams(false, false, 0, false, false)
									for i = 1,#spawnedCams do
										DestroyCam(spawnedCams[i], false)
									end
									ESX.UI.Menu.CloseAll()
								end
							end
							
							-- house.furniture = furni
							ESX.UI.Menu.CloseAll()
							UnFurnishHome(house)


							-- for k,v in pairs(persFurn) do
							-- 	if v.model == selFurn then
							-- 		Citizen.CreateThread(function()
							-- 			repeat
							-- 				Citizen.Wait(100)
							-- 				local prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, model, false, false, false)
							-- 				DeleteEntity(prop)
							-- 				prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, model, false, false, false)
							-- 			until not DoesEntityExist(prop)
							-- 		end)
							-- 		v.entity = nil
							-- 		table.remove(persFurn, k)
							-- 		for k,v in ipairs(furni.outside) do
							-- 			if v.x == data.current.pos.x and v.y == data.current.pos.y and v.z == data.current.pos.z then
							-- 				table.remove(furni.outside, k)
							-- 			end
							-- 		end
							-- 		house.furniture = furni
							-- 		TriggerServerEvent('iG_Housing:removeOutFurniture', house, data.current.pos, model, data.current.label)
							-- 		RenderScriptCams(false, false, 0, false, false)
							-- 		for i = 1,#spawnedCams do
							-- 			DestroyCam(spawnedCams[i], false)
							-- 		end
							-- 		ESX.UI.Menu.CloseAll()
							-- 	end
							-- end
							-- UnFurnishOutHome(house)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
			if (selFurn ~= model) or (selLabel ~= data.current.label) then
				local offSet = GetOffsetFromEntityInWorldCoords(SpawnedHome[1], data.current.pos.x, data.current.pos.y, data.current.pos.z)
				local prop = GetClosestObjectOfType(offSet, 1.0, model, false, false, false)
				if prop == 0 then
					prop = GetClosestObjectOfType(offSet, 5.0, model, false, false, false)
				end
				offSet = GetOffsetFromEntityInWorldCoords(prop, 0.0, 1.0, 1.0)
				local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
				table.insert(spawnedCams, cam)
				SetCamCoord(cam, offSet.x, offSet.y, offSet.z)
				PointCamAtEntity(cam, prop)
				RenderScriptCams(true, false, 0, 0, 0)
				selFurn = prop
				selLabel = data.current.label
			end
		end, function(data, menu)
			RenderScriptCams(false, false, 0, false, false)
			for i = 1,#spawnedCams do
				DestroyCam(spawnedCams[i], false)
			end
			menu.close()
			FreezeEntityPosition(PlayerPedId(), false)
		end)
	else
		Notify(Config.Strings.failFnd)
		FreezeEntityPosition(PlayerPedId(), false)
	end
end

IsHomeTouchingHome = function(x, y, z)
	local touching = false
	local pos = vector3(x, y, z)
	for i = 1,#spawnedHouseSpots do
		local dis = #(pos - spawnedHouseSpots[i].spot)
		if dis <= spawnedHouseSpots[i].size then
			touching = true
		end
	end
	return touching
end

WardrobeMenu = function()
	ESX.UI.Menu.CloseAll()
	Citizen.Wait(500)
	local elements = {{label = Config.Strings.storOut, value = 'store'}}
	ESX.TriggerServerCallback('iG_Housing:getClothes', function(clothing)
		for k,v in pairs(clothing) do
			table.insert(elements, {label = v.label, value = v.value})
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wardrobe',
		{
			title = Config.Strings.warMenu,
			align = 'right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'store' then
				ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
					TriggerEvent('iG_Housing:createName', skin)
				end)
			else
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'war_remove',
				{
					title = Config.Strings.wearRem,
					align = 'right',
					elements = {{label = Config.Strings.wearTxt, value = 'wear'},{label = Config.Strings.remText, value = 'remove'}}
				}, function(data2, menu2)
					if data2.current.value == 'wear' then
						TriggerEvent('iG_skinchanger:loadSkin', data.current.value)
						TriggerEvent('iG_skinchanger:getSkin', function(skin)
							TriggerServerEvent('iG_skin:save', skin)
						end)
						WardrobeMenu()
					else
						TriggerServerEvent('iG_Housing:saveOutfit', data.current.label, data.current.value, 'rem')
						WardrobeMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

IsHomeTouchingWater = function(x, y, z, model)
	local minDim, maxDim = GetModelDimensions(model)
	if GetWaterHeight(x, y, z) then
		return true
	end
	-- for x2 = math.floor(x-minDim.x),math.floor(x+maxDim.x) do
	-- 	for y2 = math.floor(y-minDim.y),math.floor(y+maxDim.y) do
	-- 		for z2 = math.floor(z-minDim.z),math.floor(z+maxDim.z) do
	-- 			if GetWaterHeight(x2,y2,z2) then
	-- 				return true
	-- 			end
	-- 		end
	-- 	end
	-- end
	return false
end

RegisterNetEvent('iG_Housing:getIsInHouse')
AddEventHandler('iG_Housing:getIsInHouse', function(cb)
	cb(inHome)
end)

RegisterNetEvent('iG_Housing:spawnHome')
AddEventHandler('iG_Housing:spawnHome', function(house, spawnType)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	while not HasModelLoaded(house.shell) do
		RequestModel(house.shell)
		Citizen.Wait(10)
	end
	local x, y, z = pos.x, pos.y, pos.z - 20.0
	local tooClose = IsHomeTouchingHome(x, y, z)
	if tooClose then
		z = z - 10.0
	end
	local inWater = IsHomeTouchingWater(x, y, z, house.shell)
	if inWater then
		spot = GetSafeSpot()
	else
		spot = vector3(x, y, z)
	end
	local home = CreateObjectNoOffset(house.shell, spot, true, false, false)
	homeID = ObjToNet(home)
	TriggerServerEvent('iG_Housing:regSpot', 'insert', spot, house.id, Config.Shells[house.shell].shellsize)
	if DoesEntityExist(home) then
		currentHouseID = house.id
		inHome = true
		FrontDoor = house.door
		FreezeEntityPosition(home, true)
		table.insert(SpawnedHome, home)
		local furni = house.furniture
		for k,v in pairs(furni.inside) do
			local spot = GetOffsetFromEntityInWorldCoords(home, v.x, v.y, v.z)
			Citizen.CreateThread(function()
				while not HasModelLoaded(v.prop) do
					RequestModel(v.prop)
					Citizen.Wait(1)
				end
				local prop = CreateObjectNoOffset(v.prop, spot, true, false, false)
				print(prop)
				print(v.prop)
				if v.heading ~= nil then
					SetEntityHeading(prop, v.heading)
				end
				FreezeEntityPosition(prop, true)
				table.insert(SpawnedHome, prop)
			end)
		end
		if Config.BlinkOnRefresh then
			if not blinking then
				blinking = true
				if timeInd ~= 270 then
					timeInd = GetTimecycleModifierIndex()
					SetTimecycleModifier('Glasses_BlackOut')
				end
			end
		end
		Notify(Config.Strings.amEnter)
		local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
		SetEntityCoords(ped, offset)
		TaskTurnPedToFaceEntity(ped, home, 1000)
		Citizen.Wait(1000)
		FreezeEntityPosition(ped, true)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
			SetEntityCoords(ped, offset)
			DisableAllControlActions(0)
		end
		Notify(Config.Strings.amClose)
		Citizen.Wait(1000)
		if Config.BlinkOnRefresh then
			if timeInd ~= -1 then
				SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
			else
				timeInd = -1
				ClearTimecycleModifier()
			end
			blinking = false
		end
		FreezeEntityPosition(ped, false)
		inHome = true
		while inHome do
			Citizen.Wait(0)
			pos = GetEntityCoords(ped)
			SetHomeWeather()
			for k,v in pairs(Config.Shells) do
				if house.shell == k then
					local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
					local dis = #(pos - offset)
					if Markers.ExitMarkers then
						DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
					end
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							ExitMenu(house)
						end
					end
					if spawnType == 'owned' then
						offset = GetOffsetFromEntityInWorldCoords(home, house.storage)
						if Markers.IntMarkers then
							DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						dis = #(pos - offset)
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								-- local dict = 'amb@prop_human_bum_bin@base'
								-- RequestAnimDict(dict)
								-- while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
								-- TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
								TriggerEvent(Config.InventoryHudEvent, house.id)
							end
						end
						offset = GetOffsetFromEntityInWorldCoords(home, house.wardrobe)
						if Markers.IntMarkers then
							DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						dis = #(pos - offset)
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								WardrobeMenu()
							end
						end
					end
				end
			end
		end
	else
		Notify(Config.Strings.wntRong)
	end
end)

RegisterNetEvent('iG_Housing:ownerLeft')
AddEventHandler('iG_Housing:ownerLeft', function()
	local ped = PlayerPedId()
	ESX.UI.Menu.CloseAll()
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	Notify(Config.Strings.amExitt)
	SetEntityCoords(ped, FrontDoor)
	Citizen.Wait(1000)
	FreezeEntityPosition(ped, true)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(1)
		SetEntityCoords(ped, FrontDoor)
		DisableAllControlActions(0)
	end
	Notify(Config.Strings.amClose)
	Citizen.Wait(1000)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
	FreezeEntityPosition(ped, false)
	inHome = false
end)

RegisterNetEvent('iG_Housing:createName')
AddEventHandler('iG_Housing:createName', function(skin)
	local genName = nil
	local doBreak = false
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'choose_name_text',
		{
			title = Config.Strings.nameSel
		},
	function(data, menu)
		local name = tostring(data.value)
		local length = string.len(name)
		if length == nil then
			Notify(Config.Strings.needNam)
		elseif length > 55 then
			Notify(Config.Strings.nameLng:format('1','55'))
		else
			genName = name
			menu.close()
		end
	end, function(data, menu)
	end)
	while true do
		Citizen.Wait(2)
		if genName ~= nil then
			doBreak = true
			if doBreak then
				break
			end
		end
	end
	TriggerServerEvent('iG_Housing:saveOutfit', genName, skin, 'add')
	WardrobeMenu()
end)

RegisterNetEvent('iG_Housing:getHouse')
AddEventHandler('iG_Housing:getHouse', function(house, cop, usedKey)
	if inHome then
		local home = NetToObj(homeID)
		for k,v in pairs(Config.Shells) do
			if house.shell == k then
				local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
				if usedKey == nil then
					TriggerServerEvent('iG_Housing:startRaid', cop, house, offset, homeID)
				else
					TriggerServerEvent('iG_Housing:openWKey', cop, house, offset, homeID)
				end
			end
		end
	else
		if usedKey == nil then
			TriggerServerEvent('iG_Housing:startRaid', cop, house)
		else
			TriggerServerEvent('iG_Housing:openWKey', cop, house)
		end
	end
end)

RegisterNetEvent('iG_Housing:doorKnock')
AddEventHandler('iG_Housing:doorKnock', function(knocker)
	if knocker ~= nil then
		if inHome then
			Notify(Config.Strings.dorKnok)
		else
			TriggerServerEvent('iG_Housing:knockFail', knocker)
		end
	else
		Notify(Config.Strings.notHome)
	end
end)

RegisterNetEvent('iG_Housing:knockAccept')
AddEventHandler('iG_Housing:knockAccept', function(pos, house, id, isRaid)
	if isRaid ~= nil and isRaid == 'false' then
		local ped = PlayerPedId()
		local home = NetToObj(id)
		TriggerServerEvent('iG_Housing:addGuest', house)
		FrontDoor = house.door
		if Config.BlinkOnRefresh then
			if not blinking then
				blinking = true
				if timeInd ~= 270 then
					timeInd = GetTimecycleModifierIndex()
					SetTimecycleModifier('Glasses_BlackOut')
				end
			end
		end
		Notify(Config.Strings.amEnter)
		SetEntityCoords(ped, pos)
		Citizen.Wait(1000)
		FreezeEntityPosition(ped, true)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
			SetEntityCoords(ped, pos)
			DisableAllControlActions(0)
		end
		Notify(Config.Strings.amClose)
		Citizen.Wait(1000)
		if Config.BlinkOnRefresh then
			if timeInd ~= -1 then
				SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
			else
				timeInd = -1
				ClearTimecycleModifier()
			end
			blinking = false
		end
		FreezeEntityPosition(ped, false)
		inHome = true
		while inHome do
			Citizen.Wait(0)
			local pos = GetEntityCoords(ped)
			SetHomeWeather()
			for k,v in pairs(Config.Shells) do
				if house.shell == k then
					local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
					local dis = #(pos - offset)
					if Markers.ExitMarkers then
						DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
					end
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							ExitMenu(house)
						end
					end
					if Config.KeyOptions.Inventory then
						offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].storage)
						dis = #(pos - offset)
						if Markers.IntMarkers then
							DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								-- local dict = 'amb@prop_human_bum_bin@base'
								-- RequestAnimDict(dict)
								-- while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
								-- TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
								TriggerEvent(Config.InventoryHudEvent, house.id)
							end
						end
					end
				end
			end
		end
	else
		local title = Config.Strings.nokAcpt
		if isRaid~= nil then
			title = Config.Strings.conRaid
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'knock_accept',
		{
			title = title,
			align = 'right',
			elements = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
		}, function(data, menu)
			if data.current.value == 'yes' then
				local ped = PlayerPedId()
				local home = NetToObj(id)
				TriggerServerEvent('iG_Housing:addGuest', house)
				FrontDoor = house.door
				if Config.BlinkOnRefresh then
					if not blinking then
						blinking = true
						if timeInd ~= 270 then
							timeInd = GetTimecycleModifierIndex()
							SetTimecycleModifier('Glasses_BlackOut')
						end
					end
				end
				Notify(Config.Strings.amEnter)
				SetEntityCoords(ped, pos)
				Citizen.Wait(1000)
				FreezeEntityPosition(ped, true)
				while not HasCollisionLoadedAroundEntity(ped) do
					Citizen.Wait(1)
					SetEntityCoords(ped, pos)
					DisableAllControlActions(0)
				end
				Notify(Config.Strings.amClose)
				Citizen.Wait(1000)
				if Config.BlinkOnRefresh then
					if timeInd ~= -1 then
						SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
					else
						timeInd = -1
						ClearTimecycleModifier()
					end
					blinking = false
				end
				FreezeEntityPosition(ped, false)
				inHome = true
				while inHome do
					Citizen.Wait(0)
					local pos = GetEntityCoords(ped)
					SetHomeWeather()
					for k,v in pairs(Config.Shells) do
						if house.shell == k then
							local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
							local dis = #(pos - offset)
							if Markers.ExitMarkers then
								DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
							end
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									ExitMenu(house)
								end
							end
							if isRaid ~= nil then
								offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].storage)
								dis = #(pos - offset)
								if Markers.IntMarkers then
									DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
								end
								if dis <= 1.25 then
									if IsControlJustReleased(0, 51) then
										-- local dict = 'amb@prop_human_bum_bin@base'
										-- RequestAnimDict(dict)
										-- while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
										-- TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
										TriggerEvent(Config.InventoryHudEvent, house.id)
									end
								end
							end
						end
					end
				end
			else
				ESX.UI.Menu.CloseAll()
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end)

RegisterNetEvent('iG_Housing:updateHomes')
AddEventHandler('iG_Housing:updateHomes', function()
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				Notify(Config.Strings.amBlink)
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end
	Houses = {}
	ESX.TriggerServerCallback('iG_Housing:getHousing', function(houses)
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			Houses[v.id] = v
		end
		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then
				local blip = AddBlipForCoord(v.door)

				SetBlipScale  (blip, 1.0)
				SetBlipAsShortRange(blip, true)
				if PlayerData.identifier == v.owner then
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, Blips.OwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
				elseif v.owner == 'nil' then
					SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
					SetBlipColour (blip, Blips.UnOwnedHome.Color)
					SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
					SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
				else
					SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
					SetBlipColour (blip, Blips.OtherOwnedHome.Color)
					SetBlipScale  (blip, Blips.OtherOwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
				end

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(k)
				EndTextCommandSetBlipName(blip)
				table.insert(scriptBlips, blip)
			end
			for g,f in pairs(v.furniture.outside) do
				table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
			end
			-- for j,k in pairs(v.furniture.inside) do
			-- 	table.insert(persFurn, {model = k.prop, pos = vector3(k.x, k.y, k.z), head = k.heading})
			-- end
		end
	end)
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
end)

RegisterNetEvent("iG_Housing:refreshVehicles")
AddEventHandler("iG_Housing:refreshVehicles", function(vehicles)
	ParkedCars = {}
	for k,v in ipairs(vehicles) do
		ParkedCars[v.plate] = v.vehicle
		ParkedCars[v.plate].pos = vector3(v.vehicle.location.x, v.vehicle.location.y, v.vehicle.location.z)
	end
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
end)

RegisterNetEvent('iG_Housing:driveCar')
AddEventHandler('iG_Housing:driveCar', function(vehicle)
	-- while not HasModelLoaded(vehicle.props.model) do
	-- 	RequestModel(vehicle.props.model)
	-- 	Citizen.Wait(1)
	-- end
	-- local spawnedCar = CreateVehicle(vehicle.props.model, vehicle.location.x, vehicle.location.y, vehicle.location.z, vehicle.location.h, false)
	-- while not DoesEntityExist(spawnedCar) do Citizen.Wait(10) end
	-- ESX.Game.SetVehicleProperties(spawnedCar, vehicle.props)
	-- SetVehicleOnGroundProperly(spawnedCar)
	-- SetEntityAsMissionEntity(spawnedCar, true, true)
	-- SetModelAsNoLongerNeeded(vehicle.props.model)
	-- SetEntityInvincible(spawnedCar, true)
	-- SetVehicleLivery(spawnedCar, vehicle.livery)
	-- SetVehicleEngineHealth(spawnedCar, vehicle.damages.eng)
	-- SetVehicleOilLevel(spawnedCar, vehicle.damages.oil)
	-- SetVehicleBodyHealth(spawnedCar, vehicle.damages.bod)
	-- SetVehicleDoorsLocked(spawnedCar, vehicle.damages.lok)
	-- SetVehiclePetrolTankHealth(spawnedCar, vehicle.damages.tnk)
	-- for i = 0,5 do
	-- 	if vehicle.damages.dor[i] then
	-- 		SetVehicleDoorBroken(spawnedCar, i, true)
	-- 	end
	-- end
	-- for i = 0,13 do
	-- 	if vehicle.damages.win[i] then
	-- 		SmashVehicleWindow(spawnedCar, i)
	-- 	end
	-- end
	-- for i = 0,7 do
	-- 	if vehicle.damages.tyr[i] == 'popped' then
	-- 		SetVehicleTyreBurst(spawnedCar, i, false, 850.0)
	-- 	elseif vehicle.damages.tyr[i] == 'gone' then
	-- 		SetVehicleTyreBurst(spawnedCar, i, true, 1000.0)
	-- 	end
	-- end
	-- while not HasCollisionLoadedAroundEntity(spawnedCar) do
	-- 	Citizen.Wait(10)
	-- end
	-- SetVehicleOnGroundProperly(spawnedCar)
	-- TaskWarpPedIntoVehicle(PlayerPedId(), spawnedCar, -1)

	ESX.Game.SpawnVehicle(vehicle.props.model, vector3(vehicle.location.x, vehicle.location.y, vehicle.location.z), vehicle.location.h, function(spawnedCar)
		ESX.Game.SetVehicleProperties(spawnedCar, vehicle.props)
		TaskWarpPedIntoVehicle(PlayerPedId(), spawnedCar, -1)
	end)
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
    Citizen.Wait(200)
    PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('iG_Housing:hasEnteredMarker', function(house)
	CurrentAction     = 'front_door'
	CurrentActionMsg  = Config.Strings.dorOptn
	CurrentActionData = house
end)

AddEventHandler('iG_Housing:hasExitedMarker', function()
	if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'choose_item') then
		if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'confirm_furn_place') then
			ESX.UI.Menu.CloseAll()
		end
	end
	CurrentAction = nil
	CurrentActionMsg = ''
	CurrentActionData = {}
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('iG:onPlayerDeath', function()
	isDead = true
end)
	
AddEventHandler('onResourceStop', function(resource)
	local ped = PlayerPedId()
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
		if atShop then
			local ped = PlayerPedId()
			for k,v in pairs(spawnedProps) do
				DeleteEntity(v)
			end
			if inShop then
				SetEntityCoords(ped, Config.Furnishing.Store.enter)
				SetEntityHeading(ped, Config.Furnishing.Store.exthead)
			end
		end
		for k,v in pairs(persFurn) do
			DeleteEntity(v.model)
		end
		if inHome then
			if Config.BlinkOnRefresh then
				if not blinking then
					blinking = true
					if timeInd ~= 270 then
						timeInd = GetTimecycleModifierIndex()
						SetTimecycleModifier('Glasses_BlackOut')
					end
				end
			end
			SetEntityCoords(ped, FrontDoor)
			FreezeEntityPosition(ped, true)
			while not HasCollisionLoadedAroundEntity(ped) do
				Citizen.Wait(1)
			end
			FreezeEntityPosition(ped, false)
			if Config.BlinkOnRefresh then
				if timeInd ~= -1 then
					SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
				else
					timeInd = -1
					ClearTimecycleModifier()
				end
				blinking = false
			end
			for i = 1,#SpawnedHome do
				DeleteEntity(SpawnedHome[i])
			end
			SpawnedHome = {}
		end
	end
end)

RegisterCommand('createhouse', function(raw, args)
	local shell, price, draw = Config.Defaults.Shell, Config.Defaults.Price, Config.Defaults.Draw
	ESX.TriggerServerCallback('iG_Housing:canCreate', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_house',
			{
				title = Config.Strings.addAdrs
			},
			function(data, menu)
				local address = data.value
				
				if address == nil or address == '' then
					Notify(Config.Strings.noAddrs)
					address = CreateRandomAddress()
				end
				if string.len(address) > 55 then
					Notify(Config.Strings.add2Sht:format(string.len(address)))
				else
					menu.close()
					local elements = {}
					table.insert(elements, {label = 'MLO', value = 'mlo'})
					for k,v in pairs(Config.Shells) do
						table.insert(elements, {label = k, value = k})
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_shell',
						{
							title = Config.Strings.chsShll,
							align = 'right',
							elements = elements
						}, function(data2, menu2)
							shell = data2.current.value
							menu2.close()
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_price',
								{
									title = Config.Strings.setPryc
								}, function(data3, menu3)
									if data3.value ~= nil and tonumber(data3.value) > Config.MaxSellPrice then
										Notify(Config.Strings.lowPryc:format(Config.MaxSellPrice))
									else
										if data3.value == nil then
											Notify(Config.Strings.noPrice)
										else
											price = tonumber(data3.value)
										end
										menu3.close()
										local elms = {}
										for i = 1,#Config.LandSize do
											table.insert(elms, {label = Config.LandSize[i], value = Config.LandSize[i]})
										end
										drawRange = 5
										Citizen.CreateThread(function()
											while drawRange > 0 do
												Citizen.Wait(5)
												DrawMarker(2, GetOffsetFromEntityInWorldCoords(ped, 0.0, (drawRange * 1.0), 0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 255, true, true, 2, 0, 0, 0, 0)
											end
										end)
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_draw',
											{
												title = Config.Strings.lndSize,
												align = 'right',
												elements = elms
											}, function(data4, menu4)
												draw = data4.current.value * 1.0
												drawRange = 0
												menu4.close()
												TriggerServerEvent('iG_Housing:createHouse', address, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, shell, price, draw)
											end, function(data4, menu4)
											menu4.close()
											drawRange = 0
											end, function(data4, menu4)
											drawRange = data4.current.value
										end)
									end
								end, function(data3, menu3)
								menu3.close()
							end)
						end, function(data2, menu2)
						menu2.close()
					end)
				end
			end, function(data, menu)
			menu.close()
			end)
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)

RegisterCommand('createparking', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = 'right',
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if Config.UseScriptParking and not Config.UseMatifParking then
					local tooClose = IsParkingTooClose(pos)
					if not tooClose then
						TriggerServerEvent('iG_Housing:createParking', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
					else
						Notify(Config.Strings.prk2Cls)
					end
				elseif Config.UseMatifParking then
					TriggerEvent('matif_garage:addGarage', pos, data.current.value)
				else
					
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('delhouse', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = 'right',
		elements = elements
	},function(data, menu)
		local elements2 = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_delete',
		{
			title = 'Delete '..data.current.value,
			align = 'right',
			elements = elements2
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('iG_Housing:deleteHome', data.current.value)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('delparking', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local house, parkingSpot
	local elements = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
	for k,v in pairs(Houses) do
		for i = 1,#v.parkings do
			local vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
			local dis = #(vec - pos)
			if dis <= 2.5 then
				house = v.id
				parkingSpot = vec
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_delete',
	{
		title = Config.Strings.delPark,
		align = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'yes' then
			ESX.UI.Menu.CloseAll()
			if house ~= nil then
				TriggerServerEvent('iG_Housing:deleteParking', house, parkingSpot.x, parkingSpot.y, parkingSpot.z)
			end
		else
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('adddoor', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = 'right',
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 1.0 then
				Notify(Config.Strings.getClsr)
			else
				if DoesEntityExist(door) then
					local doorPos, rotation, propHash = GetEntityCoords(door), GetEntityHeading(door), GetEntityModel(door)
					TriggerServerEvent('iG_Housing:addDoorToHome', data.current.value, doorPos.x, doorPos.y, doorPos.z, rotation, propHash)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('addgarage', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = 'right',
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 2.5 then
				Notify(Config.Strings.getClsr)
				print(doorDis)
			else
				if DoesEntityExist(door) then
					local doorPos, rotation, propHash, draw = GetEntityCoords(door), GetEntityHeading(door), GetEntityModel(door)
					menu.close()
					local elms = {}
					for i = 1,#Config.LandSize do
						table.insert(elms, {label = Config.LandSize[i], value = Config.LandSize[i]})
					end
					drawRange = 5
					Citizen.CreateThread(function()
						while drawRange > 0 do
							Citizen.Wait(5)
							DrawMarker(2, GetOffsetFromEntityInWorldCoords(ped, 0.0, (drawRange * 1.0), 0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 255, true, true, 2, 0, 0, 0, 0)
						end
					end)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_draw',
					{
						title = Config.Strings.grgODis,
						align = 'right',
						elements = elms
					}, function(data2, menu2)
						draw = data2.current.value * 1.0
						drawRange = 0
						menu2.close()
						TriggerServerEvent('iG_Housing:addGarageToHome', data.current.value, doorPos.x, doorPos.y, doorPos.z, propHash, draw)
					end, function(data2, menu2)
						menu2.close()
						drawRange = 0
					end, function(data2, menu2)
						drawRange = data2.current.value
					end)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('deldoor', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = 'right',
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 2.5 then
				Notify(Config.Strings.getClsr)
			else
				if DoesEntityExist(door) then
					local doorPos, propHash = GetEntityCoords(door), GetEntityModel(door)
					TriggerServerEvent('iG_Housing:removeDoorFromHome', data.current.value, doorPos.x, doorPos.y, doorPos.z, propHash)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('setstorage', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = 'right',
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if SpawnedHome[1] == nil and dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if SpawnedHome[1] ~= nil then
					local home = SpawnedHome[1]
					local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
					pos = vector3(offset.x, offset.y, offset.z)
					TriggerServerEvent('iG_Housing:setHomeStorage', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, true)
				else
					TriggerServerEvent('iG_Housing:setHomeStorage', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, true)
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('setwardrobe', function(raw, args)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = 'right',
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if SpawnedHome[1] == nil and dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if SpawnedHome[1] ~= nil then
					local home = SpawnedHome[1]
					local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
					pos = vector3(offset.x, offset.y, offset.z)
					TriggerServerEvent('iG_Housing:setHomeStorage', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
				else
					TriggerServerEvent('iG_Housing:setHomeStorage', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('doorlock', function(raw)
	if canUpdate then
		TriggerServerEvent('iG_Housing:updateDoor', currentZone.id, dor2Update)
	else
		Notify(Config.Strings.frntDor)
	end
end)

RegisterKeyMapping('doorlock', Config.Strings.keyHelp, 'keyboard', Config.Keys.UnLock)

-- FOLLOWING COMMANDS FOR DEVELOPMENT ONLY (SETTING NEW SHELL DOOR LOCATIONS AND PRE-FURNISHED HOME FURNITURE) --

RegisterCommand('testshell', function(raw, args)
	ESX.TriggerServerCallback('iG_Housing:canCreate', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			returnPos = pos
			local shell = GetHashKey(args[1])
			if IsModelInCdimage(shell) then
				while not HasModelLoaded(shell) do
					RequestModel(shell)
					Citizen.Wait(10)
				end
				local x, y, z = pos.x, pos.y, pos.z - 20.0
				local height = GetWaterHeight(x,y,z)
				local spot
				if height == false then
					spot = vector3(x, y, z)
				else
					spot = GetSafeSpot()
				end
				local spot = vector3(x, y, z)
				local home = CreateObjectNoOffset(shell, spot, true, false, false)
				if DoesEntityExist(home) then
					FreezeEntityPosition(home, true)
					SpawnedHome = {}
					table.insert(SpawnedHome, home)
					DoScreenFadeOut(100)
					while not IsScreenFadedOut() do
						Citizen.Wait(1)
					end
					SetEntityCoords(ped, spot)
					Citizen.Wait(1000)
					FreezeEntityPosition(ped, true)
					while not HasCollisionLoadedAroundEntity(ped) do
						Citizen.Wait(1)
					end
					DoScreenFadeIn(100)
					FreezeEntityPosition(ped, false)
				else
					Notify(Config.Strings.wntRong)
				end
			else
				Notify(Config.Strings.modNtFd)
			end
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)

RegisterCommand('clearshell', function(raw)
	if returnPos ~= nil then
		ESX.TriggerServerCallback('iG_Housing:canCreate', function(canCreate)
			if canCreate then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				SetEntityCoords(ped, returnPos)
				for i = 1,#SpawnedHome do
					DeleteEntity(SpawnedHome[i])
				end
				SpawnedHome = {}
				returnPos = nil
			else
				Notify(Config.Strings.noPerms)
			end
		end)
	else
		Notify(Config.Strings.aftrTst)
	end
end)

RegisterCommand('offset', function(raw)
	if SpawnedHome[1] ~= nil then
		ESX.TriggerServerCallback('iG_Housing:canCreate', function(canCreate)
			if canCreate then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local home = SpawnedHome[1]
				local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
				local vec = vector3(offset.x, offset.y, offset.z - 1.0)
				print(vec)
			else
				Notify(Config.Strings.noPerms)
			end
		end)
	else
		Notify(Config.Strings.noShell)
	end
end)

RegisterCommand('spawnprop', function(raw, args)
	ESX.TriggerServerCallback('iG_Housing:canCreate', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
			local model = GetHashKey(args[1])
			if IsModelInCdimage(model) then
				while not HasModelLoaded(model) do
					Citizen.Wait(10)
					RequestModel(model)
				end
				local prop = CreateObjectNoOffset(model, pos, false, false, false)
				SetEntityHeading(prop, 0.0)
				Citizen.Wait(10000)
				DeleteEntity(prop)
				SetModelAsNoLongerNeeded(model)
			else
				Notify(Config.Strings.modNtFd)
			end
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)
RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function()
	PlayerData = ESX.GetPlayerData()
end)



Citizen.CreateThread(function()
	while true do
		if inHome then
			TriggerServerEvent("stress:remove", 2000)
			Citizen.Wait(20000)
		else
			Citizen.Wait(5000)
		end
	end
end)