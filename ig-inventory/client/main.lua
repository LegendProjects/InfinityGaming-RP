isInInventory = false
maxWeight = 24000
ESX = nil
playerLoaded = false
PlayerData = {}
local playerWeight = 0
-- weight = 0
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
	[4] = nil,
	[5] = nil
}

local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false

Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end
	while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end
	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(3000)
	if Config.Debug then
		if ESX.IsPlayerLoaded() then
			playerLoaded = true
			TriggerServerEvent('iG_weashop:syncLicenses')
			GetItems()
		end
	end
end)

isSkillMaster = false

-- if Config.Debug then
-- 	AddEventHandler("onResourceStart", function()
-- 		PlayerData = xPlayer
-- 		TriggerServerEvent("ig-inventory-trunk:getOwnedVehicle")
-- 		lastChecked = GetGameTimer()
-- 	end)
-- end

RegisterNetEvent("vy_Base:UpdateSkillData")
AddEventHandler('vy_Base:UpdateSkillData', function()
    Citizen.Wait(10000)
    TriggerEvent('vy_Base:checkMasterStatus')
end)

RegisterNetEvent('vy_Base:returnMasterStatus')
AddEventHandler('vy_Base:returnMasterStatus', function(boolean)
    isSkillMaster = boolean
end)

RegisterNetEvent("iG:playerLoaded")
AddEventHandler("iG:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
	-- TriggerServerEvent("ig-inventory-trunk:getOwnedVehicle")
	-- TriggerServerEvent("ig-inventory-glovebox:getOwnedVehicle")
	TriggerServerEvent('iG_weashop:syncLicenses')
	GetItems()
	lastChecked = GetGameTimer()
	playerLoaded = true
end)

RegisterNetEvent("iG:setJob")
AddEventHandler("iG:setJob", function(job)
	PlayerData = ESX.GetPlayerData()
	while PlayerData == nil do
		Citizen.Wait(10)
	end
	PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HudForceWeaponWheel(false)
		HudWeaponWheelIgnoreSelection()
		DisableControlAction(1, 37, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(2, 157, true)-- disable changing weapon
		DisableControlAction(2, 158, true)-- disable changing weapon
		DisableControlAction(2, 159, true)-- disable changing weapon
		DisableControlAction(2, 160, true)-- disable changing weapon
		DisableControlAction(2, 161, true)-- disable changing weapon
		DisableControlAction(2, 162, true)-- disable changing weapon
		DisableControlAction(2, 163, true)-- disable changing weapon
		DisableControlAction(2, 164, true)-- disable changing weapon
		DisableControlAction(2, 165, true)-- disable changing weapon
	end
end)

--[[Citizen.CreateThread(function()
	while ESX == nil do Citizen.Wait(10) end
	while true do
		Citizen.Wait(7)
		if not IsPlayerDead(PlayerId()) then
			DisableControlAction(0, 37, true)
			if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
				openInventory()
			elseif IsControlJustReleased(0, Config.CloseControl) and IsInputDisabled(0) then
				closeInventory()
			elseif  IsDisabledControlJustReleased(1, 157) and canFire then
				if fastWeapons[1] ~= nil then
					TriggerServerEvent("iG:useItem", fastWeapons[1])
					TriggerEvent('ig-inventory:notification', fastWeapons[1], _U("item_used"), 1, false)
				end
			elseif IsDisabledControlJustReleased(1, 158) and canFire then
				if fastWeapons[2] ~= nil then
					TriggerServerEvent("iG:useItem", fastWeapons[2])
					TriggerEvent('ig-inventory:notification', fastWeapons[2], _U("item_used"), 1, false)
				end
			elseif IsDisabledControlJustReleased(1, 160) and canFire then
				if fastWeapons[3] ~= nil then
					TriggerServerEvent("iG:useItem", fastWeapons[3])
					TriggerEvent('ig-inventory:notification', fastWeapons[3], _U("item_used"), 1, false)
				end
			elseif IsDisabledControlJustReleased(1, 164) and canFire then
				if fastWeapons[4] ~= nil then
					TriggerServerEvent("iG:useItem", fastWeapons[4])
					TriggerEvent('ig-inventory:notification', fastWeapons[4], _U("item_used"), 1, false)
				end
			elseif IsDisabledControlJustReleased(1, 165) and canFire then
				if fastWeapons[5] ~= nil then
					TriggerServerEvent("iG:useItem", fastWeapons[5])
					TriggerEvent('ig-inventory:notification', fastWeapons[5], _U("item_used"), 1, false)
				end
			elseif IsDisabledControlJustReleased(1, 37) then
				HudForceWeaponWheel(false)
				showHotbar()
			end
		else
			Citizen.Wait(1000)
		end
	end
end)]]

RegisterKey('keyboard', 'TAB', 
	function()
	end,
	-- on release
	function()
	if not IsPlayerDead(PlayerId()) then
		if IsInputDisabled(0) then
			openInventory()
		end
	end
end)

RegisterKey('keyboard', 'LMENU', function()
	if not IsPlayerDead(PlayerId()) then
		HudForceWeaponWheel(false)
		showHotbar()
	end
end)

RegisterKey('keyboard', '1', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[1] ~= nil then
			TriggerServerEvent('iG:useItem', fastWeapons[1])
			TriggerEvent('ig-inventory:notification', fastWeapons[1], _U('item_used'), 1, false)
		end
	end
end)

RegisterKey('keyboard', '2', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[2] ~= nil then
			TriggerServerEvent('iG:useItem', fastWeapons[2])
			TriggerEvent('ig-inventory:notification', fastWeapons[2], _U('item_used'), 1, false)
		end
	end
end)

RegisterKey('keyboard', '3', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[3] ~= nil then
			TriggerServerEvent('iG:useItem', fastWeapons[3])
			TriggerEvent('ig-inventory:notification', fastWeapons[3], _U('item_used'), 1, false)
		end
	end
end)

RegisterKey('keyboard', '4', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[4] ~= nil then
			TriggerServerEvent('iG:useItem', fastWeapons[4])
			TriggerEvent('ig-inventory:notification', fastWeapons[4], _U('item_used'), 1, false)
		end
	end
end)

RegisterKey('keyboard', '5', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[5] ~= nil then
			TriggerServerEvent('iG:useItem', fastWeapons[5])
			TriggerEvent('ig-inventory:notification', fastWeapons[5], _U('item_used'), 1, false)
		end
	end
end)

function lockinv()
	Citizen.CreateThread(function()
		while isInInventory do
			Citizen.Wait(10)
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 166, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2,199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true) -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function getPlayerWeight()
	playerWeight = exports['ig-inventory']:GetCurrentWeight()
	SendNUIMessage({
		action = "setWeightText",
		text =  "<strong>         "..tostring(ESX.Math.GroupDigits(playerWeight)).." / "..tostring(ESX.Math.GroupDigits(maxWeight)).."G<strong>"
	})
	-- Citizen.Wait(50)
	WeightLoaded = true
end

function loadItems()
	PlayerData = ESX.GetPlayerData()
	Citizen.CreateThread(function()
		-- ESX.TriggerServerCallback("ig-inventory:getPlayerInventory", function(data)
			items = {}
			fastItems = {}
			-- slotes = fastWeapons
			-- if slotes ~= nil then
			-- 	if slotes ~= false then
			-- 		for index=1, #slotes do
			-- 			fastWeapons[slotes[index].slot] = slotes[index].item
			-- 		end
			-- 	end
			-- end
			inventory = PlayerData.inventory
			accounts = PlayerData.accounts
			-- money = accounts[key].name == "money"
			-- weapons = data.weapons

			-- if Config.IncludeCash and money ~= nil and money > 0 then
			-- 	moneyData = {
			-- 		label = _U("cash"),
			-- 		name = "cash",
			-- 		type = "item_money",
			-- 		count = money,
			-- 		usable = false,
			-- 		rare = false,
			-- 		weight = 0,
			-- 		canRemove = true
			-- 	}
			-- 	table.insert(items, moneyData)
			-- end

			if Config.IncludeAccounts and accounts ~= nil then
				for key, value in pairs(accounts) do
					if accounts[key].name == "money" then
						money = accounts[key].money
						if money ~= nil and money > 0 then
							moneyData = {
								label = _U("cash"),
								name = "cash",
								type = "item_money",
								count = money,
								usable = false,
								rare = false,
								weight = 0,
								canRemove = true
							}
							table.insert(items, moneyData) 
						end
					else
						if not shouldSkipAccount(accounts[key].name) then
							local canDrop = accounts[key].name ~= "bank"
							if accounts[key].money > 0 then
								accountData = {
									label = accounts[key].label,
									count = accounts[key].money,
									type = "item_account",
									name = accounts[key].name,
									usable = false,
									rare = false,
									weight = 0,
									canRemove = canDrop
								}
								table.insert(items, accountData)
							end
						end
					end
				end
			end

			if inventory ~= nil then
				for key, value in pairs(inventory) do
					if inventory[key].count <= 0 then
						inventory[key] = nil
					else
						inventory[key].type = "item_standard"
						local founditem = false
						for slot, item in pairs(fastWeapons) do
							if item == inventory[key].name then
								table.insert(fastItems, {
									label = inventory[key].label,
									count = inventory[key].count,
									weight = 0,
									type = "item_standard",
									name = inventory[key].name,
									usable = inventory[key].usable,
									rare = inventory[key].rare,
									canRemove = inventory[key].can_remove,
									slot = slot
								})
								founditem = true
								break
							end
						end
						if founditem == false then
							table.insert(items, inventory[key])
						end
					end
				end
			end

			if weapons ~= nil then
				for key, value in pairs(weapons) do
					local weaponHash = GetHashKey(weapons[key].name)
					local playerPed = PlayerPedId()
					if weapons[key].name ~= "WEAPON_UNARMED" then
						local found = false
						for slot, weapon in pairs(fastWeapons) do
							if weapon == weapons[key].name then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(fastItems, {
									label = weapons[key].label,
									count = ammo,
									limit = -1,
									type = "item_weapon",
									name = weapons[key].name,
									usable = false,
									rare = false,
									canRemove = true,
									slot = slot
								})
								found = true
								break
							end
						end
						if found == false then
							local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
							table.insert(items, {
								label = weapons[key].label,
								count = ammo,
								weight = 0,
								type = "item_weapon",
								name = weapons[key].name,
								usable = false,
								rare = false,
								canRemove = true
							})
						end
					end
				end
			end
			fastItemsHotbar =  fastItems
			SendNUIMessage({
				action = "setItems",
				itemList = items,
				fastItems = fastItems,
				weight = playerWeight
			})
			ItemsLoaded = true
		-- end, GetPlayerServerId(PlayerId()))
	end)
end

function openInventory()
	-- TriggerEvent('trew_hud_ui:toggleUit')
	if Config.CameraAnimationPocket == true then
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			DeleteSkinCam()
			loadCamera(0, 3)
		end
	end
	isInInventory = true
	lockinv()
	SetNuiFocus(true, true)
	loadPlayerInventory()
	SendNUIMessage({
		action = "display",
		type = "normal",
		weight = playerWeight
	})
	-- TransitionToBlurred(1000)
end

function closeInventory()
	DeleteSkinCam()
	isInInventory = false
	ClearPedSecondaryTask(PlayerPedId())
	SendNUIMessage({
		action = "hide"
	})
	-- TransitionFromBlurred(1000)
	SetNuiFocus(false, false)
	-- TriggerEvent('trew_hud_ui:toggleAan')
end

function shouldCloseInventory(itemName)
	for index, value in ipairs(Config.CloseUiItems) do
		if value == itemName then
			return true
		end
	end
	return false
end

function shouldSkipAccount(accountName)
	for index, value in ipairs(Config.ExcludeAccountsList) do
		if value == accountName then
			return true
		end
	end
	return false
end

function loadPlayerInventory()
	WeightLoaded = false
	ItemsLoaded = false
	getPlayerWeight()
	while not WeightLoaded do
		Citizen.Wait(100)
	end
	loadItems()
	while not ItemsLoaded do
		Citizen.Wait(100)
	end
end

function showHotbar()
	if not isHotbar then
		isHotbar = true
		SendNUIMessage({
			action = "showhotbar",
			fastItems = fastItemsHotbar,
			itemList = itemslist
		})
		Citizen.Wait(1500)
		isHotbar = false
	end
end

RegisterNUICallback("NUIFocusOff", function()
	if isInInventory then
		closeInventory()
	end
end)

RegisterNUICallback("GetNearPlayers", function(data, cb)
	local playerPed = PlayerPedId()
	local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)
	local foundPlayers = false
	local elements = {}

	for i = 1, #players, 1 do
		if players[i] ~= PlayerId() then
			foundPlayers = true
			ESX.TriggerServerCallback('GetCharacterNameServer', function(playerss)
				foundPlayers = true
					table.insert(elements, {
						label = playerss,
						player = GetPlayerServerId(players[i])
					})

					SendNUIMessage({
						action = "nearPlayers",
						foundAny = foundPlayers,
						players = elements,
						item = data.item
					})
			end, GetPlayerServerId(players[i]))
		end
	end
	cb("ok")
end)

RegisterNUICallback("DropItem",function(data, cb)
	print(data.item.canRemove)
	if data.item.canRemove then 
		if IsPedSittingInAnyVehicle(playerPed) then
			return
		end
		if type(data.number) == "number" and math.floor(data.number) == data.number then
			if data.item.type == "item_money" then
				TriggerServerEvent("iG:removeInventoryItem", "item_account", "money", data.number)
				TriggerServerEvent('3dme:shareText', 'Destroyed $' .. ESX.Math.GroupDigits(data.number))
			else
				-- if data.item.name == 'bag' then
				-- 	TriggerEvent('iG_skinchanger:change', "bags_1", 0)
				-- 	TriggerEvent('iG_skinchanger:change', "bags_2", 0)
				-- 	TriggerEvent('iG_skinchanger:getSkin', function(skin)
				-- 		TriggerServerEvent('iG_skin:save', skin)
				-- 		hasBag = false
				-- 	end)
				-- end
				if data.item.name == 'idcard' then
					local coords = GetEntityCoords(PlayerPedId())
					local forward = GetEntityForwardVector(PlayerPedId())
					coords = coords + forward*1.0
					-- TriggerServerEvent('license_menu:idCardLocation', coords)
				end
				TriggerServerEvent("iG:removeInventoryItem", data.item.type, data.item.name, data.number)
				TriggerServerEvent('3dme:shareText', 'Destroyed ' .. data.number .. 'x ' .. data.item.label)
			end
		end
		Wait(150)
		loadPlayerInventory()
		cb("ok")
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Item cannot be destroyed.')
	end
end)

RegisterNUICallback("UseItem", function(data, cb)
	TriggerServerEvent("iG:useItem", data.item.name)
    TriggerEvent('ig-inventory:notification', data.item.name, _U("item_used"), 1, false)
	if shouldCloseInventory(data.item.name) then
		closeInventory()
	else
	Wait(150)
	loadPlayerInventory()
	end
	--print("Made with love in the Netherlands for " .. Config.ServerName)
	cb("ok")
end)

RegisterNUICallback("GiveItem", function(data, cb)
	-- print(data.item.canRemove)
	if data.item.canRemove then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance < 3.0 then
			local count = tonumber(data.number)
			if data.item.type == "item_weapon" then
				count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
			end
			canPlayAnim = false
			ClearPedSecondaryTask(PlayerPedId())
			RequestAnimDict("mp_common")
			while (not HasAnimDictLoaded("mp_common")) do
				Citizen.Wait(10)
			end
			TaskPlayAnim(PlayerPedId(),"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
			if (Config.PropList[data.item.name] ~= nil) then
				attachModel = GetHashKey(Config.PropList[data.item.name].model)
				local bone = GetPedBoneIndex(PlayerPedId(), Config.PropList[data.item.name].bone)
				RequestModel(attachModel)
				while not HasModelLoaded(attachModel) do
					Citizen.Wait(10)
				end
				closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
				AttachEntityToEntity(closestEntity, PlayerPedId(), bone, Config.PropList[data.item.name].x, Config.PropList[data.item.name].y, Config.PropList[data.item.name].z,
				Config.PropList[data.item.name].xR, Config.PropList[data.item.name].yR, Config.PropList[data.item.name].zR, 1, 1, 0, true, 2, 1)
				Citizen.Wait(1500)
				if DoesEntityExist(closestEntity) then
					DeleteEntity(closestEntity)
				end
			end
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
			canPlayAnim = true
			if data.item.type == "item_money" then
				TriggerServerEvent("iG:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_account", "money", count)
			elseif data.item.name == 'WEAPON_PISTOL' or data.item.name == 'WEAPON_FLASHLIGHT' or data.item.name == 'WEAPON_STUNGUN' or data.item.name == 'WEAPON_KNIFE'
			or data.item.name == 'WEAPON_BAT' or data.item.name == 'WEAPON_ADVANCEDRIFLE' or data.item.name == 'WEAPON_APPISTOL' or data.item.name == 'WEAPON_ASSAULTRIFLE'
			or data.item.name == 'WEAPON_ASSAULTSHOTGUN' or data.item.name == 'WEAPON_ASSAULTSMG' or data.item.name == 'WEAPON_AUTOSHOTGUN' or data.item.name == 'WEAPON_CARBINERIFLE'
			or data.item.name == 'WEAPON_COMBATPISTOL' or data.item.name == 'WEAPON_PUMPSHOTGUN' or data.item.name == 'WEAPON_SMG' then
				ESX.TriggerServerCallback('ig-inventory:giveWeapon', function(callback)
					if callback then
						TriggerServerEvent("iG:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
					end
				end,GetPlayerServerId(closestPlayer), data.item.name)
			else
				-- if data.item.name == 'idcard' then
				-- 	TriggerServerEvent('license_menu:idCardGiven', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
				-- end
				TriggerServerEvent("iG:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
			end
			Wait(150)
			loadPlayerInventory()
		end
		cb("ok")
	else 
		exports['mythic_notify']:SendAlert('error', 'Error: Item cannot be transferred.')
	end
end)

RegisterNUICallback("PutIntoFast", function(data, cb)
	-- print('PutIntoFast ' .. data.item.name)
	-- print('PutIntoFast ' .. data.slot)

	if data.item.slot ~= nil then
		fastWeapons[data.item.slot] = nil
	end
	-- TriggerServerEvent('ig-inventory:putInToSlot', data.item.name, data.slot)
	fastWeapons[data.slot] = data.item.name
		-- print('PutIntoFast' .. data.slot)
	Wait(150)
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	-- print('TakeFromFast ' .. data.item.name)
	-- print('TakeFromFast ' .. data.item.slot)
	-- TriggerServerEvent('ig-inventory:removeFromSlot',data.item.name, data.item.slot)
	fastWeapons[data.item.slot] = nil
	if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
		TriggerEvent('ig-inventory:closeinventory', source)
		RemoveWeapon(data.item.name)
	end
	Wait(150)
	loadPlayerInventory()
	cb("ok")
end)

RegisterNetEvent('ig-inventory:disablenumbers')
AddEventHandler('ig-inventory:disablenumbers', function(disabled)
	canFire = disabled
end)

RegisterNetEvent('ig-inventory:notification')
AddEventHandler('ig-inventory:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
	SendNUIMessage({
		action = "notification",
		itemname = sourceitemname,
		itemlabel = sourceitemlabel,
		itemcount = sourceitemcount,
		itemremove = sourceitemremove
	})
end)

RegisterNetEvent('ig-inventory:closeinventory')
AddEventHandler('ig-inventory:closeinventory', function()
	closeInventory()
end)

RegisterNetEvent('ig-inventory:clearfastitems')
AddEventHandler('ig-inventory:clearfastitems', function()
	fastWeapons = {
		[1] = nil,
		[2] = nil,
		[3] = nil,
		[4] = nil,
		[5] = nil
	}
	RemoveAllPedWeapons(PlayerPedId(), true)
end)

RegisterNetEvent('ig-inventory:doClose')
AddEventHandler('ig-inventory:doClose', function(...)
	closeInventory(...);
end)
