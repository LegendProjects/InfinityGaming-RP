ESX = nil
local HasAlreadyEnteredMarker = false
local playerLoaded = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("iG:playerLoaded")
AddEventHandler('iG:playerLoaded', function()
    playerLoaded = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped, false)
        local isInMarker, hasExited, letSleep = false, false, true
        local canSleep = true
        for k,v in pairs(Config.SaleLocations) do
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.Coords.x, v.Coords.y, v.Coords.z, false)
            if distance <= 5 then
                canSleep = false
            end
            if distance <= 1.5 then
                ESX.Game.Utils.DrawText3D(v.Coords, 'Press [~b~E~w~] to use the ~y~Grand Exchange~w~.', 0.4)
                if not IsPedInAnyVehicle(ped, true) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
                    if CurrentAction == 'exchange_menu' then
                        if IsControlJustPressed(0, 38) then
                            OpenShopMenu(v.Type) 
                        end
                    end
                end
            end
        end

        for k,v in pairs(Config.VendorLocations) do
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.Coords.x, v.Coords.y, v.Coords.z, false)
            if distance <= 5 then
                canSleep = false
            end
            if distance <= 1.5 then
                ESX.Game.Utils.DrawText3D(v.Coords, 'Press [~b~E~w~] to access ~y~' .. v.Name .. '~w~.', 0.4)
                if not IsPedInAnyVehicle(ped, true) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
                    if CurrentAction == 'vendor_menu' then
                        if IsControlJustPressed(0, 38) then
                            OpenVendorMenu(v.Type) 
                        end
                    end
                end
            end
        end
        if canSleep then
            Citizen.Wait(500)
        end
    end
end)


function OpenShopMenu(shop)
    ESX.UI.Menu.CloseAll()
    local _shop = shop
    local elements = {
        {label = "Sell", value = 'sell'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'grandexchange', {
        title    = 'Grand Exchange: ' .. _shop,
        align    = 'right',
        elements = elements
    }, function(data, menu)
   if data.current.value == 'sell' then
           OpenSellMenu(_shop)
        end
    end, function (data, menu)
        menu.close()
    end)
end

function OpenSellMenu(shop)
    ESX.UI.Menu.CloseAll()
    local _shop = shop
    local elements = {}
    for k,v in pairs(Config.SaleLocations) do
        if v.Type == _shop then 
            for i=1, #v.SellItems, 1 do
                table.insert(elements, {label = v.SellItems[i].label .. ': <span style="color:green;">$' .. ESX.Math.Round(v.SellItems[i].price) .. '</span>', value = v.SellItems[i].item, price = ESX.Math.Round(v.SellItems[i].price)})
            end     
        end      
    end  

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_menu', {
        title    = 'Grand Exchange: ' .. _shop,
        align    = 'right',
        elements = elements
    }, function(data, menu)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_quantity', {
            title = 'How much would you like to sell?',
        }, function (data2, menu2)
            local quantity = tonumber(data2.value)
            if quantity == nil then
                exports['mythic_notify']:SendAlert('inform', 'Invalid quantity.')
            else
                exports['mythic_progbar']:Progress({
                    name = "process_sale",
                    duration = 3000,
                    label = "Processing sale..",
                    useWhileDead = true,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard@base",
                        anim = "base",
                        flags = 49,
                    },
                    prop = {
                        model = "p_amb_clipboard_01",
                        bone = 18905,
                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                    },
                    propTwo = {
                        model = "prop_pencil_01",
                        bone = 58866,
                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                    },
                }, function(status)
                    if not status then
                        TriggerServerEvent('iG_Vendors:sellItems', data.current.value, quantity, data.current.price)
                    end
                end)
                menu2.close()
            end
        end, function (data2, menu2)
            menu2.close()
        end)
    end, function (data, menu)
        menu.close()
    end)
end

function OpenVendorMenu(vendor)
    ESX.UI.Menu.CloseAll()
    local _vendor = vendor
    local elements = {
        { label = 'Purchase Items', value = 'buy' },
        { label = 'Sell Items', value = 'sell' }
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vendor_menu', {
        title    = 'Vendor: ' .. _vendor,
        align    = 'right',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'buy' then
            OpenVendorBuyMenu(_vendor)
        elseif data.current.value == 'sell' then
            OpenVendorSellMenu(_vendor)
        end
    end, function (data, menu)
        menu.close()
    end)
end

function OpenVendorBuyMenu(vendor)
    ESX.UI.Menu.CloseAll()
    local _vendor = vendor
    local elements = {}
    for k,v in pairs(Config.VendorLocations) do
        if v.Type == _vendor then 
            for i=1, #v.BuyItems, 1 do
                table.insert(elements, {label = v.BuyItems[i].label .. ': <span style="color:green;">$' .. v.BuyItems[i].price .. '</span>', value = v.BuyItems[i].item, price = ESX.Math.Round(v.BuyItems[i].price)})
            end     
        end      
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vendor_menu', {
        title    = 'Vendor: ' .. _vendor .. ' (Buy)',
        align    = 'right',
        elements = elements
    }, function(data, menu)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_quantity', {
            title = 'How much would you like to buy?',
        }, function (data2, menu2)
            local quantity = tonumber(data2.value)
            if quantity == nil then
                exports['mythic_notify']:SendAlert('inform', 'Invalid quantity.')
            else
                exports['mythic_progbar']:Progress({
                    name = "process_sale",
                    duration = 3000,
                    label = "Processing purchase..",
                    useWhileDead = true,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard@base",
                        anim = "base",
                        flags = 49,
                    },
                    prop = {
                        model = "p_amb_clipboard_01",
                        bone = 18905,
                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                    },
                    propTwo = {
                        model = "prop_pencil_01",
                        bone = 58866,
                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                    },
                }, function(status)
                    if not status then
                        TriggerServerEvent('iG_Vendors:buyItems', data.current.value, quantity, data.current.price)
                    end
                end)
                menu2.close()
            end
        end, function (data2, menu2)
            menu2.close()
        end)
    end, function (data, menu)
        menu.close()
    end)
end

function OpenVendorSellMenu(vendor)
    ESX.UI.Menu.CloseAll()
    local _vendor = vendor
    local elements = {}
    local vendorName 
    for k,v in pairs(Config.VendorLocations) do
        if v.Type == _vendor then 
            for i=1, #v.SellItems, 1 do
                table.insert(elements, {name = v.SellItems[i].label, label = v.SellItems[i].label .. ': <span style="color:green;">$' .. v.SellItems[i].price .. '</span>', value = v.SellItems[i].item, price = v.SellItems[i].price})
                vendorName = v.Name
            end     
        end      
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vendor_menu', {
        title    = 'Vendor: ' .. _vendor .. ' (Sell)',
        align    = 'right',
        elements = elements
    }, function(data, menu)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_quantity', {
            title = 'How much would you like to sell?',
        }, function (data2, menu2)
            local quantity = tonumber(data2.value)
            if quantity == nil then
                exports['mythic_notify']:SendAlert('inform', 'Invalid quantity.')
            else
                exports['mythic_progbar']:Progress({
                    name = "process_sale",
                    duration = 3000,
                    label = "Processing sale..",
                    useWhileDead = true,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard@base",
                        anim = "base",
                        flags = 49,
                    },
                    prop = {
                        model = "p_amb_clipboard_01",
                        bone = 18905,
                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                    },
                    propTwo = {
                        model = "prop_pencil_01",
                        bone = 58866,
                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                    },
                }, function(status)
                    if not status then
                        if vendor == 'GoldCurrency' or vendor == 'Jewelcrafting' then
                            TriggerServerEvent('iG_Vendors:sellItems:Tracked', data.current.value, quantity, data.current.price, data.current.name)
                        else
                            TriggerServerEvent('iG_Vendors:sellItems', data.current.value, quantity, data.current.price)
                        end
                    end
                end)
                menu2.close()
            end
        end, function (data2, menu2)
            menu2.close()
        end)
    end, function (data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    for _, v in pairs(Config.SaleLocations) do
        v.blip = AddBlipForCoord(v.Coords)
        SetBlipSprite(v.blip, 387)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.5)
        SetBlipColour(v.blip, 0)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Name)
        EndTextCommandSetBlipName(v.blip)
    end

    for _, v in pairs(Config.VendorLocations) do
        v.blip = AddBlipForCoord(v.Coords)
        SetBlipSprite(v.blip, 387)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.5)
        SetBlipColour(v.blip, 0)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Name)
        EndTextCommandSetBlipName(v.blip)
    end
end)


-- Entered Marker
AddEventHandler('iG_Vendors:hasEnteredMarker', function(zone)
	if zone == 'Mining' or zone == 'Woodcutting' or zone == 'Smithing' or zone == 'Fishing' or zone == 'Construction' then
		CurrentAction     = 'exchange_menu'
		CurrentActionData = {}
    elseif zone == 'PawnShop' or zone == 'Gold' or zone == 'Jewelcrafting' or zone == 'Casino' then
        CurrentAction     = 'vendor_menu'
		CurrentActionData = {}
    end
end)


-- Exited Marker
AddEventHandler('iG_Vendors:hasExitedMarker', function(zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end
	
	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.SaleLocations) do
			if(GetDistanceBetweenCoords(coords, v.Coords, true) < 1.0) then
				isInMarker  = true
				currentZone = k
			end
        end

        for k,v in pairs(Config.VendorLocations) do
			if(GetDistanceBetweenCoords(coords, v.Coords, true) < 1.0) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('iG_Vendors:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('iG_Vendors:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
	end
end)

