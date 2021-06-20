-- local isPlayerSafe = false

-- RegisterNetEvent("ig-inventory:openPropertyInventory")
-- AddEventHandler("ig-inventory:openPropertyInventory", function(data, playerSafe)
-- 	if playerSafe then isPlayerSafe = playerSafe; else isPlayerSafe = false; end
-- 	setPropertyInventoryData(data)
-- 	openPropertyInventory()
-- end)

-- function refreshPropertyInventory()
-- 	if isPlayerSafe then
-- 		ESX.TriggerServerCallback('MF_PlayerSafes:GetSafeInventory', function(inventory)
-- 			setPropertyInventoryData(inventory);
-- 		end,isPlayerSafe.safeid)
-- 	else
-- 		ESX.TriggerServerCallback("iG_property:getPropertyInventory",function(inventory)
-- 			setPropertyInventoryData(inventory)
-- 		end,ESX.GetPlayerData().identifier)
-- 	end
-- end

-- function setPropertyInventoryData(data)
-- 	SendNUIMessage({
-- 		action = "setInfoText",
-- 		text = _("propertyinv")
-- 	})
-- 	items = {}

-- 	local blackMoney = data.blackMoney
-- 	local money = data.money
-- 	local propertyItems = data.items
-- 	local propertyWeapons = data.weapons

-- 	if money > 0 then
-- 		accountData = {
-- 			label = _U("cash"),
-- 			count = money,
-- 			type = "item_money",
-- 			name = "cash",
-- 			usable = false,
-- 			rare = false,
-- 			weight = 0,
-- 			canRemove = false
-- 		}
-- 		table.insert(items, accountData)
-- 	end

-- 	if blackMoney > 0 then
-- 		accountData = {
-- 			label = _U("black_money"),
-- 			count = blackMoney,
-- 			type = "item_account",
-- 			name = "black_money",
-- 			usable = false,
-- 			rare = false,
-- 			weight = 0,
-- 			canRemove = false
-- 		}
-- 		table.insert(items, accountData)
-- 	end

-- 	for i = 1, #propertyItems, 1 do
-- 		local item = propertyItems[i]
-- 		if item.count > 0 then
-- 			item.type = "item_standard"
-- 			item.usable = false
-- 			item.rare = false
-- 			item.weight = 0
-- 			item.canRemove = false
-- 			table.insert(items, item)
-- 		end
-- 	end
-- 	SendNUIMessage({
-- 		action = "setSecondInventoryItems",
-- 		itemList = items,
-- 	})
-- end

-- function openPropertyInventory()
-- 	loadPlayerInventory()
-- 	isInInventory = true
-- 	SendNUIMessage({
-- 		action = "display",
-- 		type = "property"
-- 	})
-- 	SetNuiFocus(true, true)
-- end

-- RegisterNUICallback("PutIntoProperty", function(data, cb)
-- 	if IsPedSittingInAnyVehicle(playerPed) then
-- 		return
-- 	end
-- 	for k,v in pairs(data) do print(k,v); end
-- 	if type(data.number) == "number" and math.floor(data.number) == data.number then
-- 		local count = tonumber(data.number)
-- 		local isWeapon = false
-- 		if data.item.type == "item_weapon" then
-- 			isWeapon = true
-- 			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
-- 		end
-- 		if isPlayerSafe then
-- 			print("DOPUTSAFE")
-- 			TriggerServerEvent("MF_PlayerSafes:PutItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, isPlayerSafe.safeid, isWeapon)
-- 		else
-- 			if data.item.name == 'cash' then
-- 				TriggerServerEvent("iG_property:putItem", ESX.GetPlayerData().identifier, 'item_account', 'money', count)
-- 			else
-- 				TriggerServerEvent("iG_property:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
-- 			end
-- 		end
-- 	end
-- 	Wait(0)
-- 	refreshPropertyInventory()
-- 	Wait(0)
-- 	loadPlayerInventory()
-- 	cb("ok")
-- end)

-- RegisterNUICallback("TakeFromProperty", function(data, cb)
-- 	if IsPedSittingInAnyVehicle(playerPed) then
-- 		return
-- 	end
-- 	if type(data.number) == "number" and math.floor(data.number) == data.number then
-- 		if isPlayerSafe then
-- 			TriggerServerEvent("MF_PlayerSafes:GetItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), isPlayerSafe.safeid)
-- 		else
-- 			if data.item.name == 'cash' then
-- 				TriggerServerEvent("iG_property:getItem", ESX.GetPlayerData().identifier, 'item_account', 'money', tonumber(data.number))
-- 			else
-- 				TriggerServerEvent("iG_property:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
-- 			end
-- 		end
-- 	end
-- 	Wait(0)
-- 	refreshPropertyInventory()
-- 	Wait(0)
-- 	loadPlayerInventory()
-- 	cb("ok")
-- end)

local currentHouse

RegisterNetEvent("ig-inventory:openPropertyInventory")
AddEventHandler("ig-inventory:openPropertyInventory", function(id)
	currentHouse = id
	ESX.TriggerServerCallback('iG_Housing:getInv', function(data)
		setPropertyInventory(data)
		openPropertyInventory()
	end, 'property', id)
end)

function refreshPropertyInventory(property)
	ESX.TriggerServerCallback('iG_Housing:getInv', function(data)
		setPropertyInventory(data)
		openPropertyInventory()
	end, 'property', property)
end

function setPropertyInventory(data)
    items = {}

    if data.blackMoney > 0 then
        blackData = {
            label = _U('black_money'),
            count = data.blackMoney,
            type = 'item_account',
            name = 'black_money',
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, blackData)
    end
	
	if data.cash > 0 then
        cashData = {
            label = 'cash',
            count = data.cash,
            type = 'item_account',
            name = 'money',
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, cashData)
    end

    if data.items ~= nil then
        for key, value in pairs(data.items) do
			data.items[key][1].name = key
			data.items[key][1].label = value[1].label
			data.items[key][1].type = 'item_standard'
			data.items[key][1].usable = false
			data.items[key][1].rare = false
			data.items[key][1].limit = -1
			data.items[key][1].canRemove = false
			table.insert(items, data.items[key][1])
        end
    end

    if data.weapons ~= nil then
        for key, value in pairs(data.weapons) do
            if data.weapons[key][1] ~= 'WEAPON_UNARMED' then
                table.insert(
                    items,
                    {
                        label = data.weapons[key][1].label,
                        count = data.weapons[key][1].count,
                        limit = -1,
                        type = 'item_weapon',
                        name = key,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = 'setSecondInventoryItems',
            itemList = items
        }
    )
end

function openPropertyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "property"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback('PutIntoProperty', function(data, cb)
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		return
	end
	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		local count = tonumber(data.number)

		if data.item.type == 'item_weapon' then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		if count == 0 then
			count = 1
		end
		TriggerServerEvent('iG_Housing:putItem', 'property', currentHouse, data, count)
	end
	Wait(250)
	loadPlayerInventory()
	ESX.TriggerServerCallback('iG_Housing:getInv', function(data)
		setPropertyInventory(data)
		openPropertyInventory()
	end, 'property', currentHouse)

	cb('ok')
end)

RegisterNUICallback('TakeFromProperty', function(data, cb)
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		return
	end

	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		TriggerServerEvent('iG_Housing:getItem', 'property', currentHouse, data, tonumber(data.number))
	end
	Wait(250)
	loadPlayerInventory()
	ESX.TriggerServerCallback('iG_Housing:getInv', function(data)
		setPropertyInventory(data)
		openPropertyInventory()
	end, 'property', currentHouse)

	cb('ok')
end)
