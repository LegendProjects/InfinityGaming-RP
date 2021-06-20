local shopData = nil
local Licenses                = {}
local LicensePrice = Config.LicensePrice

RegisterNetEvent('iG_weashop:loadLicenses')
AddEventHandler('iG_weashop:loadLicenses', function (licenses)
    for i = 1, #licenses, 1 do
       Licenses[licenses[i].type] = true
    end
end)


function OpenMainMenu()
    ESX.UI.Menu.CloseAll()
	local elements = {}
    if Licenses['weapon'] == nil then
        table.insert(elements, { label = "Firearms License (C:H): $5,000", value = 'firearms_license' })
    end
    if Licenses['weapontraining'] == nil then
        table.insert(elements, { label = "Advanced Firearms Training (C:AFT): $25,000", value = 'weapons_training' })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'wea_cat',
      {
        title = "Weapon Categories",
        align = 'right',
        elements = elements
      },
      function (data, menu)
        
        local value = data.current.value
        local rvalue = value
  
        if data.current.value == 'firearms_license' then
            OpenBuyLicenseMenu('firearms_license')
        elseif data.current.value == 'weapons_training' then
            OpenBuyLicenseMenu('weapons_training')
        end
        
        menu.close()
      end,
      function (data, menu)
        menu.close()
      end
    )
  end
  
function OpenBuyLicenseMenu(rvalue)
    
    local price = 0
    
    local wtype = nil
  
    if rvalue == 'firearms_license' then
        price = 5000
        wtype = 'weapon'
    elseif rvalue == 'weapons_training' then
        price = 25000
        wtype = 'weapontraining'
    end
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'shop_license',
      {
        title = 'Confirm Purchase',
        align = 'right',
        elements = {
          { label = 'Purchase', value = 'yes' },
          { label = 'Cancel', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
          TriggerServerEvent('iG_weashop:buyLicense', price, wtype)
        elseif data.current.value == 'no' then
            menu.close()
        end
        menu.close()
      end,
      function (data, menu)
        menu.close()
      end
    )
  
end

RegisterKey('keyboard', 'E', 
	function()
	end,
	-- on release
	function()
		player = PlayerPedId()
		coords = GetEntityCoords(player)
		if not IsPlayerDead(player) and playerLoaded then
			if 
				IsInMastersLounge(coords) or
				IsInSkillsShopZone(coords) or
				IsInRegularShopZone(coords) or
				IsInRobsLiquorZone(coords) or
				IsInHardWareZone(coords) or
				IsInPrisonShopZone(coords) or
				IsInWeaponShopZone(coords) or
				IsInPoliceShopZone(coords) or
				IsInLicenseShopZone(coords) or
				IsInBlackMarketShopZone(coords) or
				IsInBlackMarket2ShopZone(coords) or
				IsInBarShopZone(coords) or
				IsInPharmacyShopZone(coords) or
				IsInAmbulanceShopZone(coords) or
				IsInPoliceFoodShopZone(coords) or
				IsInGruppe6ShopZone(coords) 
			then

                if IsInRegularShopZone(coords) then
                    OpenShopInv("regular")
                    Citizen.Wait(1000)
                end

                if IsInSkillsShopZone(coords) then
                    OpenShopInv("skills")
                    Citizen.Wait(1000)
                end

                if IsInRobsLiquorZone(coords) then
                    OpenShopInv("robsliquor")
                    Citizen.Wait(1000)
                end

                if IsInHardWareZone(coords) then
                    OpenShopInv("hardware")
                    Citizen.Wait(1000)
                end

                if IsInPoliceFoodShopZone(coords) then
                    OpenShopInv("policefoodshop")
                    Citizen.Wait(1000)
                end

                if IsInPrisonShopZone(coords) then
                    OpenShopInv("prison")
                    Citizen.Wait(1000)
                end

                if IsInBlackMarketShopZone(coords) then
                    OpenShopInv("blackmarket")
                    Citizen.Wait(1000)
                end

                if IsInBlackMarket2ShopZone(coords) then
                    OpenShopInv("blackmarket2")
                    Citizen.Wait(1000)
                end

                if IsInPharmacyShopZone(coords) then
                    OpenShopInv("pharmacy")
                    Citizen.Wait(1000)
                end

				if IsInBarShopZone(coords) then	
					-- if PlayerData.job.name == 'government' or PlayerData.job.name == 'vanillaunicorn' or PlayerData.job.name == 'aquarius' or PlayerData.job.name == 'tequilala' or PlayerData.job.name == 'casino' then 
						OpenShopInv("bar")
						Citizen.Wait(1000)
					-- end
				end

				if IsInAmbulanceShopZone(coords) then
					if PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" then
						OpenShopInv("ambulance")
						Citizen.Wait(1000)
					end
				end

				if IsInGruppe6ShopZone(coords) then
					if PlayerData.job.name == "gruppe6" or PlayerData.job.name == "government" then
						OpenShopInv("gruppe6")
						Citizen.Wait(1000)
					end
				end

                if IsInLicenseShopZone(coords) then
                    if Licenses['weapon'] ~= nil and Licenses['weapontraining'] ~= nil then
						exports['mythic_notify']:SendAlert('error', 'You already have a firearms license.')
					else
						OpenMainMenu()
						Citizen.Wait(1000)
					end
                end

                if IsInWeaponShopZone(coords) then
                    if Licenses['weapon'] ~= nil or Licenses['weapontraining'] ~= nil then
						OpenShopInv("weaponshop")
						Citizen.Wait(1000)
					else
						exports['mythic_notify']:SendAlert('error', 'You need a firearms license before you can buy weapons.')
					end
                end

				
				if IsInPoliceShopZone(coords) then
					if PlayerData.job.name == "police" or PlayerData.job.name == "mcd" or PlayerData.job.name == "government" then
						OpenShopInv("policeshop")
						Citizen.Wait(1000)
					end
				end

                if isSkillMaster then 
                    if IsInMastersLounge(coords) then
                        OpenShopInv("masterslounge")
                        Citizen.Wait(1000)  
                    end
                end
            else
                Citizen.Wait(1500)
            end
		end
	end
)

function OpenShopInv(shoptype)
	text = _(tostring(shoptype .. "_vendor"))
	data = {text = text}
	inventory = {}
	ESX.TriggerServerCallback('ig-inventory:getShopItems', function(shopInv)
		for i = 1, #shopInv, 1 do
			table.insert(inventory, shopInv[i])
		end
		TriggerEvent('ig-inventory:openShopInventory', data, inventory)
	end, shoptype)
end

RegisterNetEvent('ig-inventory:OpenCustomShopInventory')
AddEventHandler('ig-inventory:OpenCustomShopInventory', function(type, shopinventory)
	text = _('store')
	data = {text = text}
	inventory = {}
	ESX.TriggerServerCallback('ig-inventory:getCustomShopItems', function(shopInv)
		for i = 1, #shopInv, 1 do
			table.insert(inventory, shopInv[i])
		end
		TriggerEvent('ig-inventory:openShopInventory', data, inventory)
	end, type, shopinventory)
end)

RegisterNetEvent('ig-inventory:openShopInventory')
AddEventHandler('ig-inventory:openShopInventory', function(data, inventory)
	setShopInventoryData(data, inventory, weapons)
	openShopInventory()
end)

function setShopInventoryData(data, inventory)
	shopData = data
	SendNUIMessage({
		action = 'setInfoText',
		text = data.text
	})
	items = {}
	SendNUIMessage({
		action = 'setShopInventoryItems',
		itemList = inventory
	})
end

function openShopInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = 'display',
		type = 'shop'
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback('TakeFromShop', function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		if exports['ig-inventory']:CanCarryItem(data.item.name, tonumber(data.number)) then
			TriggerServerEvent('ig-inventory:SellItemToPlayer', GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
			if PlayerData.job.name == 'police' or PlayerData.job.name == 'mcd' or PlayerData.job.name == 'government' then 
				if 
					data.item.name == 'WEAPON_STUNGUN' or 
					data.item.name == 'WEAPON_COMBATPISTOL' or 
					data.item.name == 'WEAPON_PUMPSHOTGUN' or 
					data.item.name == 'ammoshotgun' or 
					data.item.name == 'WEAPON_SMG' or 
					data.item.name == 'smgmag' or 
					data.item.name == 'WEAPON_CARBINERIFLE' or 
					data.item.name == 'scope' or 
					data.item.name == 'suppressor' or 
					data.item.name == 'grip' or 
					data.item.name == 'mag' or 
					data.item.name == 'flashlight' or 
					data.item.name == 'pistolmag' or 
					data.item.name == 'riflemag' or 
					data.item.name == 'armour2'
				then
					TriggerServerEvent('vy_Logs:armouryLog', data.item.name, tonumber(data.number))
				end	
			end
		else
			exports['mythic_notify']:SendAlert('error', 'Error: You can\'t carry this item.')
		end
	end
	Wait(150)
	loadPlayerInventory()
	cb('ok')
end)

RegisterNetEvent('ig-inventory:AddAmmoToWeapon')
AddEventHandler('ig-inventory:AddAmmoToWeapon', function(hash, amount)
	AddAmmoToPed(PlayerPedId(), hash, amount)
end)

function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInSkillsShopZone(coords)
    SkillsShop = Config.Shops.SkillsShop.Locations
    for i = 1, #SkillsShop, 1 do
        if GetDistanceBetweenCoords(coords, SkillsShop[i].x, SkillsShop[i].y, SkillsShop[i].z, true) < 2 then
            return true
        end
    end
    return false
end


function IsInRobsLiquorZone(coords)
    RobsLiquor = Config.Shops.RobsLiquor.Locations
    for i = 1, #RobsLiquor, 1 do
        if GetDistanceBetweenCoords(coords, RobsLiquor[i].x, RobsLiquor[i].y, RobsLiquor[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInHardWareZone(coords)
    HardWare = Config.Shops.HardWare.Locations
    for i = 1, #HardWare, 1 do
        if GetDistanceBetweenCoords(coords, HardWare[i].x, HardWare[i].y, HardWare[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInPrisonShopZone(coords)
    PrisonShop = Config.Shops.PrisonShop.Locations
    for i = 1, #PrisonShop, 1 do
        if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInBarShopZone(coords)
    Bar = Config.Shops.Bar.Locations
    for i = 1, #Bar, 1 do
        if GetDistanceBetweenCoords(coords, Bar[i].x, Bar[i].y, Bar[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInAmbulanceShopZone(coords)
	Ambulance = Config.Shops.Ambulance.Locations
	for i = 1, #Ambulance, 1 do
		if GetDistanceBetweenCoords(coords, Ambulance[i].x, Ambulance[i].y, Ambulance[i].z, true) < 2 then
			return true
		end
	end
	return false
end

function IsInPoliceShopZone(coords)
	PoliceShop = Config.Shops.PoliceShop.Locations
	for i = 1, #PoliceShop, 1 do
		if GetDistanceBetweenCoords(coords, PoliceShop[i].x, PoliceShop[i].y, PoliceShop[i].z, true) < 2 then
			return true
		end
	end
	return false
end

function IsInLicenseShopZone(coords)
    License = Config.Shops.License.Locations
    for i = 1, #License, 1 do
        if GetDistanceBetweenCoords(coords, License[i].x, License[i].y, License[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInBlackMarketShopZone(coords)
    BlackMarket = Config.Shops.BlackMarket.Locations
    for i = 1, #BlackMarket, 1 do
        if GetDistanceBetweenCoords(coords, BlackMarket[i].x, BlackMarket[i].y, BlackMarket[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInBlackMarket2ShopZone(coords)
    BlackMarket2 = Config.Shops.BlackMarket2.Locations
    for i = 1, #BlackMarket2, 1 do
        if GetDistanceBetweenCoords(coords, BlackMarket2[i].x, BlackMarket2[i].y, BlackMarket2[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInPharmacyShopZone(coords)
    Pharmacy = Config.Shops.Pharmacy.Locations
    for i = 1, #Pharmacy, 1 do
        if GetDistanceBetweenCoords(coords, Pharmacy[i].x, Pharmacy[i].y, Pharmacy[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInPoliceFoodShopZone(coords)
    PoliceFoodShop = Config.Shops.PoliceFoodShop.Locations
    for i = 1, #PoliceFoodShop, 1 do
        if GetDistanceBetweenCoords(coords, PoliceFoodShop[i].x, PoliceFoodShop[i].y, PoliceFoodShop[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInGruppe6ShopZone(coords)
    Gruppe6 = Config.Shops.Gruppe6.Locations
    for i = 1, #Gruppe6, 1 do
        if GetDistanceBetweenCoords(coords, Gruppe6[i].x, Gruppe6[i].y, Gruppe6[i].z, true) < 2 then
            return true
        end
    end
    return false
end

function IsInMastersLounge(coords)
    MastersLounge = Config.Shops.MastersLounge.Locations
    for i = 1, #MastersLounge, 1 do
        if GetDistanceBetweenCoords(coords, MastersLounge[i].x, MastersLounge[i].y, MastersLounge[i].z, true) < 2 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    player = PlayerPedId()
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), "Shop: Grocery Store", 3.0, 11, Config.ShopBlipID, 0.6)
    end

    for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
        CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), "Shop: Bottle-O", 3.0, 47, Config.LiquorBlipID, 0.6)
    end

    for k, v in pairs(Config.Shops.HardWare.Locations) do
        CreateBlip(vector3(Config.Shops.HardWare.Locations[k].x, Config.Shops.HardWare.Locations[k].y, Config.Shops.HardWare.Locations[k].z ), "Shop: Bunnings Warehouse", 3.0, 0, Config.HardWareBlipID, 0.8)
    end

    for k, v in pairs(Config.Shops.PrisonShop.Locations) do
        CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), "Shop: Prison Shop", 3.0, 75, Config.PrisonShopBlipID, 0.6)
    end

    for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), "Shop: Ammu-Nation", 3.0, 0, Config.WeaponShopBlipID, 0.6)
    end

    for k, v in pairs(Config.Shops.License.Locations) do
        CreateBlip(vector3(Config.Shops.License.Locations[k].x, Config.Shops.License.Locations[k].y, Config.Shops.License.Locations[k].z), "Government: Firearms Registry", 1.0, 26, 110, 0.6)
    end

    for k, v in pairs(Config.Shops.SkillsShop.Locations) do
        CreateBlip(vector3(Config.Shops.SkillsShop.Locations[k].x, Config.Shops.SkillsShop.Locations[k].y, Config.Shops.SkillsShop.Locations[k].z), "Skills System: Vendor", 3.0, 0, 387, 0.5)
    end
end)

Citizen.CreateThread(function()
	local sleep = 7
	while true do
		Citizen.Wait(sleep)
		player = PlayerPedId()
		coords = GetEntityCoords(player)
		if IsPedOnFoot(player) and playerLoaded then
			for k, v in pairs(Config.Shops.RegularShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z + 1), 'Press [~b~E~w~] to open the shop.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.SkillsShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.SkillsShop.Locations[k].x, Config.Shops.SkillsShop.Locations[k].y, Config.Shops.SkillsShop.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.SkillsShop.Locations[k].x, Config.Shops.SkillsShop.Locations[k].y, Config.Shops.SkillsShop.Locations[k].z + 1), 'Press [~b~E~w~] to open the shop.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.PoliceFoodShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.PoliceFoodShop.Locations[k].x, Config.Shops.PoliceFoodShop.Locations[k].y, Config.Shops.PoliceFoodShop.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.PoliceFoodShop.Locations[k].x, Config.Shops.PoliceFoodShop.Locations[k].y, Config.Shops.PoliceFoodShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.PoliceFoodShop.Locations[k].x, Config.Shops.PoliceFoodShop.Locations[k].y, Config.Shops.PoliceFoodShop.Locations[k].z + 1), 'Press [~b~E~w~] to open the shop.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.Pharmacy.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.Pharmacy.Locations[k].x, Config.Shops.Pharmacy.Locations[k].y, Config.Shops.Pharmacy.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.Pharmacy.Locations[k].x, Config.Shops.Pharmacy.Locations[k].y, Config.Shops.Pharmacy.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.Pharmacy.Locations[k].x, Config.Shops.Pharmacy.Locations[k].y, Config.Shops.Pharmacy.Locations[k].z + 1), 'Press [~b~E~w~] to open the Pharmacy.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z + 1), 'Press [~b~E~w~] to open the liquor store.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.HardWare.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.HardWare.Locations[k].x, Config.Shops.HardWare.Locations[k].y, Config.Shops.HardWare.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.HardWare.Locations[k].x, Config.Shops.HardWare.Locations[k].y, Config.Shops.HardWare.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.HardWare.Locations[k].x, Config.Shops.HardWare.Locations[k].y, Config.Shops.HardWare.Locations[k].z + 1), 'Press [~b~E~w~] to open the hardware store.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.PrisonShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then 
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z + 1), 'Press [~b~E~w~] to open the shop.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.WeaponShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(27, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z + 1), 'Press [~b~E~w~] to open the shop.', 0.4) 
						near = true
						break
					end
					near = true
				end
			end

			for k, v in pairs(Config.Shops.PoliceShop.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, true)
				if distance < 10 then
					if PlayerData.job.name == 'police' or PlayerData.job.name == 'mcd' or PlayerData.job.name == 'government' then 
						-- DrawMarker(27, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if distance < 3.0 then 
							ESX.Game.Utils.DrawText3D(vector3(Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z + 1), 'Press [~b~E~w~] to access the armoury.', 0.4) 
							near = true
							break
						end
						near = true

					end
				end
			end
			

			
			for k, v in pairs(Config.Shops.Ambulance.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.Ambulance.Locations[k].x, Config.Shops.Ambulance.Locations[k].y, Config.Shops.Ambulance.Locations[k].z, true)
				if distance < 10 then
					if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'government' then
						-- DrawMarker(27, Config.Shops.Ambulance.Locations[k].x, Config.Shops.Ambulance.Locations[k].y, Config.Shops.Ambulance.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if distance < 3.0 then 
							ESX.Game.Utils.DrawText3D(vector3(Config.Shops.Ambulance.Locations[k].x, Config.Shops.Ambulance.Locations[k].y, Config.Shops.Ambulance.Locations[k].z + 1), 'Press [~b~E~w~] to access medical equipment.', 0.4) 
							near = true
							break
						end
						near = true
					end
				end
			end

			for k, v in pairs(Config.Shops.Gruppe6.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.Gruppe6.Locations[k].x, Config.Shops.Gruppe6.Locations[k].y, Config.Shops.Gruppe6.Locations[k].z, true)
				if distance < 10 then
					if PlayerData.job.name == 'gruppe6' or PlayerData.job.name == 'government' then
						-- DrawMarker(27, Config.Shops.Gruppe6.Locations[k].x, Config.Shops.Gruppe6.Locations[k].y, Config.Shops.Gruppe6.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if distance < 3.0 then 
							ESX.Game.Utils.DrawText3D(vector3(Config.Shops.Gruppe6.Locations[k].x, Config.Shops.Gruppe6.Locations[k].y, Config.Shops.Gruppe6.Locations[k].z + 1), 'Press [~b~E~w~] to access the Armory.', 0.4) 
							near = true
							break
						end
						near = true
					end
				end
			end
			
			
			for k, v in pairs(Config.Shops.Bar.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.Bar.Locations[k].x, Config.Shops.Bar.Locations[k].y, Config.Shops.Bar.Locations[k].z, true)
				if distance < 10 then
					-- if PlayerData.job.name == 'vanillaunicorn' or PlayerData.job.name == 'aquarius' then 
						-- DrawMarker(27, Config.Shops.Bar.Locations[k].x, Config.Shops.Bar.Locations[k].y, Config.Shops.Bar.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if distance < 3.0 then 
							ESX.Game.Utils.DrawText3D(vector3(Config.Shops.Bar.Locations[k].x, Config.Shops.Bar.Locations[k].y, Config.Shops.Bar.Locations[k].z + 1), 'Press [~b~E~w~] to access the bar.', 0.4) 
							near = true
							break
						end
						near = true
					-- end
				end
			end


			for k, v in pairs(Config.Shops.License.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.License.Locations[k].x, Config.Shops.License.Locations[k].y, Config.Shops.License.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(-1, Config.Shops.License.Locations[k].x, Config.Shops.License.Locations[k].y, Config.Shops.License.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.License.Locations[k].x, Config.Shops.License.Locations[k].y, Config.Shops.License.Locations[k].z + 1), 'Press [~b~E~w~] to apply for a weapons license.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.BlackMarket.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(-1, Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z + 1), 'Press [~r~E~s~] to speak with the Weapons Dealer.', 0.4)
						near = true
						break
					end
					near = true
				end
			end
			for k, v in pairs(Config.Shops.BlackMarket2.Locations) do
				local distance = GetDistanceBetweenCoords(coords, Config.Shops.BlackMarket2.Locations[k].x, Config.Shops.BlackMarket2.Locations[k].y, Config.Shops.BlackMarket2.Locations[k].z, true)
				if distance < 10 then
					-- DrawMarker(-1, Config.Shops.BlackMarket2.Locations[k].x, Config.Shops.BlackMarket2.Locations[k].y, Config.Shops.BlackMarket2.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 3.0 then
						ESX.Game.Utils.DrawText3D(vector3(Config.Shops.BlackMarket2.Locations[k].x, Config.Shops.BlackMarket2.Locations[k].y, Config.Shops.BlackMarket2.Locations[k].z + 1), 'Press [~r~E~s~] to speak with the Tech Dealer.', 0.4)
						near = true
						break
					end
					near = true
				end
			end

			if isSkillMaster then 
				for k, v in pairs(Config.Shops.MastersLounge.Locations) do
					local distance = GetDistanceBetweenCoords(coords, Config.Shops.MastersLounge.Locations[k].x, Config.Shops.MastersLounge.Locations[k].y, Config.Shops.MastersLounge.Locations[k].z, true)
					if distance < 10 then
						if distance < 3.0 then
							ESX.Game.Utils.DrawText3D(vector3(Config.Shops.MastersLounge.Locations[k].x, Config.Shops.MastersLounge.Locations[k].y, Config.Shops.MastersLounge.Locations[k].z + 1), 'Press [~b~E~s~] to access the Masters Vendor.', 0.4)
							near = true
							break
						end
						near = true
					end
				end
			end

			if not near then 
				sleep = 1500
			else
				sleep = 7
			end
			near = false
		else
			Citizen.Wait(1500)
		end
	end
end)

-- if Config.UseLicense then
-- 	Citizen.CreateThread(function()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			License = Config.Shops.License.Locations
-- 			player = PlayerPedId()
-- 			coords = GetEntityCoords(player)
-- 			for i = 1, #License, 1 do
-- 				if GetDistanceBetweenCoords(coords, License[i].x, License[i].y, License[i].z, true) < 2.0 then
-- 					if currentAction then
-- 						if IsControlJustReleased(0, 38) then
-- 							OpenMainMenu()
-- 							Citizen.Wait(2000)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end)
-- end

Citizen.CreateThread(function()
	while true do
		Player = nil
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, false
		for k,v in pairs(Config.Shops) do
			for i = 1, #v.Locations, 1 do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, true)
				if distance <  1.5 then
					letSleep = false
					if distance < Config.MarkerSize.x then
						isInMarker  = true
						currentZone = k
						lastZone    = k
					end
				end
			end
		end
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('ig-inventory:hasEnteredMarker', currentZone)
		end
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('ig-inventory:hasExitedMarker', lastZone)
		end
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('ig-inventory:hasEnteredMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = _U('shop_press_menu')
	currentActionData = {zone = zone}
end)



function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(6)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function CreateBlip(coords, text, radius, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end
