ESX = nil
onAlcoholic = false

local targetVehicle = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("vy_UsableItems:Armour1")
AddEventHandler("vy_UsableItems:Armour1", function()
	local playerPed = GetPlayerPed(-1)
	exports['mythic_progbar']:Progress({
		name = "applying-armour",
		duration = 6000,
		label = "Applying Armour...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			TriggerServerEvent('vy_UsableItems:removeItemArmour1')
			SetPedArmour(playerPed, 35)
		end
	end)
end)

RegisterNetEvent("vy_UsableItems:Armour2")
AddEventHandler("vy_UsableItems:Armour2", function()
	local playerPed = GetPlayerPed(-1)
	exports['mythic_progbar']:Progress({
		name = "applying-armour",
		duration = 8000,
		label = "Applying Armour...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			TriggerServerEvent('vy_UsableItems:removeItemArmour2')
			SetPedArmour(playerPed, 65)
		end
	end)
end)

RegisterNetEvent("vy_UsableItems:Armour3")
AddEventHandler("vy_UsableItems:Armour3", function()
	local playerPed = GetPlayerPed(-1)
	exports['mythic_progbar']:Progress({
		name = "applying-armour",
		duration = 10000,
		label = "Applying Armour...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			TriggerServerEvent('vy_UsableItems:removeItemArmour3')
			SetPedArmour(playerPed, 85)
		end
	end)
end)

RegisterNetEvent('vy_UsableItems:RS-Armour')
AddEventHandler('vy_UsableItems:RS-Armour', function(var)  
  local playerPed = GetPlayerPed(-1)
	exports['mythic_progbar']:Progress({
		name = "applying-armour",
		duration = 4500,
		label = "Applying Armour..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			if var == 1 then 
				SetPedArmour(playerPed, 5)
			elseif var == 2 then
				SetPedArmour(playerPed, 10)
			elseif var == 3 then
				SetPedArmour(playerPed, 15)
			elseif var == 4 then
				SetPedArmour(playerPed, 20)
			elseif var == 5 then
				SetPedArmour(playerPed, 25)
			elseif var == 6 then
				SetPedArmour(playerPed, 30)
			elseif var == 7 then
				SetPedArmour(playerPed, 35)
			elseif var == 8 then
				SetPedArmour(playerPed, 45)
			elseif var == 9 then
				SetPedArmour(playerPed, 60)
			elseif var == 10 then
				SetPedArmour(playerPed, 75)
			elseif var == 11 then
				SetPedArmour(playerPed, 85)
			elseif var == 12 then
				SetPedArmour(playerPed, 100)
			end
		end
	end)

end)


RegisterNetEvent('vy_UsableItems:useRadio')
AddEventHandler('vy_UsableItems:useRadio', function()  
  exports["rp-radio"]:SetRadio(true)
end)

RegisterNetEvent('iG:removeInventoryItem')
AddEventHandler('iG:removeInventoryItem', function(name, count)
    local plyPed = GetPlayerPed(-1)
    if name == 'radio' then
      exports["rp-radio"]:SetRadio(false)
	elseif name == 'bodycam' then
		TriggerEvent('ig_Bodycam:close')
	end
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								     MISC
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- RegisterNetEvent("iG_DrunkEffect:useItemKatanaBlueprint")
-- AddEventHandler("iG_DrunkEffect:useItemKatanaBlueprint", function()
-- 	local playerPed = GetPlayerPed(-1)
-- 	-- local x,y,z = table.unpack(GetEntityCoords(playerPed))
-- 	-- katanablueprint = CreateObject(1762685852, 0, 0, 0, true, true, true)		
-- 	-- AttachEntityToEntity(katanablueprint, playerPed, GetPedBoneIndex(playerPed, 6286), 0.15, 0.03, -0.065, 0.0, 180.0, 90.0, true, true, false, true, 1, true)
-- 	exports['mythic_progbar']:Progress({
-- 		name = "reading_blueprint",
-- 		duration = 5000,
-- 		label = "Reading Blueprint..",
-- 		useWhileDead = false,
-- 		canCancel = true,
-- 		controlDisables = {
-- 			disableMovement = true,
-- 			disableCarMovement = true,
-- 			disableMouse = false,
-- 			disableCombat = true,
-- 		},
-- 		animation = {
-- 			animDict = "missheistdockssetup1clipboard@base",
-- 			anim = "base",
-- 			flags = 49,
-- 		},
-- 		prop = {
-- 			model = "katanablueprint",
-- 			bone = 18905,
-- 			coords = { x = 0.10, y = 0.02, z = 0.08 },
-- 			rotation = { x = -80.0, y = 0.0, z = 0.0 },
-- 		}
-- 	}, function(status)
-- 		if not status then
-- 			TriggerServerEvent('vy_UsableItems:removeItemKatanaBlueprint')
-- 		end
-- 	end)
-- end)

RegisterNetEvent("iG_DrunkEffect:useItemMarlboro")
AddEventHandler("iG_DrunkEffect:useItemMarlboro", function()
	local playerPed = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	marlboro = CreateObject(GetHashKey("prop_cs_ciggy_01"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(marlboro, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "smoking_marlboro",
		duration = 5000,
		label = "Smoking Cigarette..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "amb@world_human_aa_smoke@male@idle_a",
			anim = "idle_c",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(marlboro)
		TriggerServerEvent('vy_UsableItems:removeItemMarlboro')
		end
	end)
	if DoesEntityExist(marlboro) then
		Citizen.Wait(5500)
		DeleteObject(marlboro)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemJoint")
AddEventHandler("iG_DrunkEffect:useItemJoint", function()
	local playerPed = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	joint = CreateObject(GetHashKey("p_cs_joint_01"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(joint, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "smoking_joint",
		duration = 5000,
		label = "Smoking Joint..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "amb@world_human_aa_smoke@male@idle_a",
			anim = "idle_c",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(joint)
		TriggerServerEvent('vy_UsableItems:removeItemJoint')
		end
	end)
	if DoesEntityExist(joint) then
		Citizen.Wait(5500)
		DeleteObject(joint)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemZiplock")
AddEventHandler("iG_DrunkEffect:useItemZiplock", function()
	exports['mythic_progbar']:Progress({
		name = "making_pouch",
		duration = 5000,
		label = "Making Weed Pouch..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			TriggerServerEvent('vy_UsableItems:addItemWeedPouch')
		end
	end)
end)

RegisterNetEvent("iG_DrunkEffect:useItemRollingpapers")
AddEventHandler("iG_DrunkEffect:useItemRollingpapers", function()
	exports['mythic_progbar']:Progress({
		name = "making_joint",
		duration = 5000,
		label = "Making Joint..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			TriggerServerEvent('vy_UsableItems:addItemJoint')
		end
	end)
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								    DRINKS
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RegisterNetEvent("iG_DrunkEffect:useItemTequila")
AddEventHandler("iG_DrunkEffect:useItemTequila", function()
	local playerPed = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	tequila = CreateObject(GetHashKey("prop_plastic_cup_02"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(tequila, playerPed, GetPedBoneIndex(playerPed, 18905), 0.14, 0.04, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_tequila",
		duration = 3000,
		label = "Drinking Tequila...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(tequila)
		TriggerServerEvent('vy_UsableItems:removeItemTequila')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(tequila) then
		Citizen.Wait(3500)
		DeleteObject(tequila)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemBloodymary")
AddEventHandler("iG_DrunkEffect:useItemBloodymary", function()
	local playerPed = GetPlayerPed(-1)
	bloodymary = CreateObject(GetHashKey("prop_plastic_cup_02"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(bloodymary, playerPed, GetPedBoneIndex(playerPed, 18905), 0.14, 0.04, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_bloodymary",
		duration = 3000,
		label = "Drinking Bloodymary...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(bloodymary)
		TriggerServerEvent('vy_UsableItems:removeItemBloodymary')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(bloodymary) then
		Citizen.Wait(3500)
		DeleteObject(bloodymary)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemVodka")
AddEventHandler("iG_DrunkEffect:useItemVodka", function()
	local playerPed = GetPlayerPed(-1)
	vodka = CreateObject(GetHashKey("prop_plastic_cup_02"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(vodka, playerPed, GetPedBoneIndex(playerPed, 18905), 0.14, 0.04, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_vodka",
		duration = 3000,
		label = "Drinking Vodka...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(vodka)
		TriggerServerEvent('vy_UsableItems:removeItemVodka')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(vodka) then
		Citizen.Wait(3500)
		DeleteObject(vodka)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemWhisky")
AddEventHandler("iG_DrunkEffect:useItemWhisky", function()
	local playerPed = GetPlayerPed(-1)
	whisky = CreateObject(GetHashKey("prop_drink_whisky"), 0, 0, 0, true, true, true)			
	AttachEntityToEntity(whisky, playerPed, GetPedBoneIndex(playerPed, 18905), 0.10, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_whisky",
		duration = 3000,
		label = "Drinking Whisky...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		
		ClearPedSecondaryTask(playerPed)
		DeleteObject(whisky)
		TriggerServerEvent('vy_UsableItems:removeItemWhisky')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(whisky) then
		Citizen.Wait(3500)
		DeleteObject(whisky)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemMoonshine")
AddEventHandler("iG_DrunkEffect:useItemMoonshine", function()	
	local playerPed = GetPlayerPed(-1)
	Moonshine = CreateObject(GetHashKey("prop_amb_beer_bottle"), 0, 0, 0, true, true, true)			
	AttachEntityToEntity(Moonshine, playerPed, GetPedBoneIndex(playerPed, 18905), 0.15, 0.008, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_moonshine",
		duration = 3000,
		label = "Drinking Moonshine...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		

		ClearPedSecondaryTask(playerPed)
		DeleteObject(Moonshine)
		TriggerServerEvent('vy_UsableItems:removeItemMoonshine')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(Moonshine) then
		Citizen.Wait(3500)
		DeleteObject(Moonshine)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemBeer")
AddEventHandler("iG_DrunkEffect:useItemBeer", function()	
	local playerPed = GetPlayerPed(-1)
	beer = CreateObject(GetHashKey("prop_amb_beer_bottle"), 0, 0, 0, true, true, true)	
	AttachEntityToEntity(beer, playerPed, GetPedBoneIndex(playerPed, 18905), 0.15, 0.008, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_beer",
		duration = 3000,
		label = "Drinking Beer...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
			

		ClearPedSecondaryTask(playerPed)
		DeleteObject(beer)
		TriggerServerEvent('vy_UsableItems:removeItemBeer')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(beer) then
		Citizen.Wait(3500)
		DeleteObject(beer)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemCorona")
AddEventHandler("iG_DrunkEffect:useItemCorona", function()	
	local playerPed = GetPlayerPed(-1)
	corona = CreateObject(GetHashKey("prop_amb_beer_bottle"), 0, 0, 0, true, true, true)	
	AttachEntityToEntity(corona, playerPed, GetPedBoneIndex(playerPed, 18905), 0.15, 0.008, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_corona",
		duration = 3000,
		label = "Drinking Corona...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
			

		ClearPedSecondaryTask(playerPed)
		DeleteObject(corona)
		TriggerServerEvent('vy_UsableItems:removeItemCorona')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(corona) then
		Citizen.Wait(3500)
		DeleteObject(corona)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemWine")
AddEventHandler("iG_DrunkEffect:useItemWine", function()	
	local playerPed = GetPlayerPed(-1)	
	wine = CreateObject(GetHashKey("prop_drink_redwine"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(wine, playerPed, GetPedBoneIndex(playerPed, 18905), 0.135, -0.08, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_wine",
		duration = 3000,
		label = "Drinking Red Wine...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
		

		ClearPedSecondaryTask(playerPed)
		DeleteObject(wine)
		TriggerServerEvent('vy_UsableItems:removeItemWine')
		TriggerEvent('iG_DrunkEffect:Drunk')
		end
	end)
	if DoesEntityExist(wine) then
		Citizen.Wait(3500)
		DeleteObject(wine)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemFanta")
AddEventHandler("iG_DrunkEffect:useItemFanta", function()
	local playerPed = GetPlayerPed(-1)
	fanta = CreateObject(GetHashKey("prop_ecola_can"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(fanta, playerPed, GetPedBoneIndex(playerPed, 18905), 0.125, -0.002, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_fanta",
		duration = 3000,
		label = "Drinking Fanta...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(fanta)
			TriggerServerEvent('vy_UsableItems:removeItemFanta')
		end
	end)
	if DoesEntityExist(fanta) then
		Citizen.Wait(3500)
		DeleteObject(fanta)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemCocacola")
AddEventHandler("iG_DrunkEffect:useItemCocacola", function()		
	local playerPed = GetPlayerPed(-1)
	cocacola = CreateObject(GetHashKey("prop_ecola_can"), 0, 0, 0, true, true, true)	
	AttachEntityToEntity(cocacola, playerPed, GetPedBoneIndex(playerPed, 18905), 0.125, -0.002, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_cocacola",
		duration = 3000,
		label = "Drinking Cocacola..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(cocacola)
			TriggerServerEvent('vy_UsableItems:removeItemCocacola')
		end
	end)
	if DoesEntityExist(cocacola) then
		Citizen.Wait(3500)
		DeleteObject(cocacola)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemPepsi")
AddEventHandler("iG_DrunkEffect:useItemPepsi", function()		
	local playerPed = GetPlayerPed(-1)	
	pepsi = CreateObject(GetHashKey("prop_ecola_can"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(pepsi, playerPed, GetPedBoneIndex(playerPed, 18905), 0.125, -0.002, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_pepsi",
		duration = 3000,
		label = "Drinking Pepsi..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(pepsi)
			TriggerServerEvent('vy_UsableItems:removeItemPepsi')
		end
	end)
	if DoesEntityExist(pepsi) then
		Citizen.Wait(3500)
		DeleteObject(pepsi)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemSprite")
AddEventHandler("iG_DrunkEffect:useItemSprite", function()	
	local playerPed = GetPlayerPed(-1)
	sprite = CreateObject(GetHashKey("prop_ecola_can"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(sprite, playerPed, GetPedBoneIndex(playerPed, 18905), 0.125, -0.002, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_sprite",
		duration = 3000,
		label = "Drinking Sprite..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(sprite)
			TriggerServerEvent('vy_UsableItems:removeItemSprite')
		end
	end)
	if DoesEntityExist(sprite) then
		Citizen.Wait(3500)
		DeleteObject(sprite)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemWater")
AddEventHandler("iG_DrunkEffect:useItemWater", function()
	local playerPed = GetPlayerPed(-1)
	water = CreateObject(GetHashKey("prop_ld_flow_bottle"), 0, 0, 0, true, true, true)			
	AttachEntityToEntity(water, playerPed, GetPedBoneIndex(playerPed, 18905), 0.10, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "drinking_water",
		duration = 3000,
		label = "Drinking Water...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_intdrink",
			anim = "loop",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(water)
			TriggerServerEvent('vy_UsableItems:removeItemWater')
		end
	end)
	if DoesEntityExist(water) then
		Citizen.Wait(3500)
		DeleteObject(water)
	end	
end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								    FOOD
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RegisterNetEvent("iG_DrunkEffect:useItemBurger")
AddEventHandler("iG_DrunkEffect:useItemBurger", function()		
	local playerPed = GetPlayerPed(-1)
	burger = CreateObject(GetHashKey("prop_cs_burger_01"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(burger, playerPed, GetPedBoneIndex(playerPed, 18905), 0.13, 0.05, 0.02, 10.0, 145.0, 60.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "eating_burger",
		duration = 3000,
		label = "Eating Burger...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(burger)
			TriggerServerEvent('vy_UsableItems:removeItemBurger')
		end
	end)
	if DoesEntityExist(burger) then
		Citizen.Wait(3500)
		DeleteObject(burger)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemSandwich")
AddEventHandler("iG_DrunkEffect:useItemSandwich", function()		
	local playerPed = GetPlayerPed(-1)
	sandwich = CreateObject(GetHashKey("prop_sandwich_01"), 0, 0, 0, true, true, true)	
	AttachEntityToEntity(sandwich, playerPed, GetPedBoneIndex(playerPed, 18905), 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "eating_sandwich",
		duration = 3000,
		label = "Eating Sandwich...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(sandwich)
			TriggerServerEvent('vy_UsableItems:removeItemSandwich')
		end
	end)
	if DoesEntityExist(sandwich) then
		Citizen.Wait(3500)
		DeleteObject(sandwich)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemPizza")
AddEventHandler("iG_DrunkEffect:useItemPizza", function()		
	local playerPed = GetPlayerPed(-1)
	pizza = CreateObject(GetHashKey("prop_sandwich_01"), 0, 0, 0, true, true, true)		
	AttachEntityToEntity(pizza, playerPed, GetPedBoneIndex(playerPed, 18905), 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "eating_sandwich",
		duration = 3000,
		label = "Eating a Pizza Sandwich...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(pizza)
			TriggerServerEvent('vy_UsableItems:removeItemPizza')
		end
	end)
	if DoesEntityExist(pizza) then
		Citizen.Wait(3500)
		DeleteObject(pizza)
	end	
end)

RegisterNetEvent("iG_DrunkEffect:useItemDonut")
AddEventHandler("iG_DrunkEffect:useItemDonut", function()		
	local playerPed = GetPlayerPed(-1)	
	donut = CreateObject(GetHashKey("prop_amb_donut"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(donut, playerPed, GetPedBoneIndex(playerPed, 18905), 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
	exports['mythic_progbar']:Progress({
		name = "eating_donut",
		duration = 3000,
		label = "Eating Donut...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flags = 49,
		},
	}, function(cancelled)
		if not cancelled then
	
			ClearPedSecondaryTask(playerPed)
			DeleteObject(donut)
			TriggerServerEvent('vy_UsableItems:removeItemDonut')
		end
	end)
	if DoesEntityExist(donut) then
		Citizen.Wait(3500)
		DeleteObject(donut)
	end	
end)

-- RegisterNetEvent('iG_DrunkEffect:Drunk')
-- AddEventHandler('iG_DrunkEffect:Drunk', function()
--     RequestAnimSet("move_m@drunk@verydrunk")
--     while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
--         Citizen.Wait(0)
--     end
--     onAlcoholic = true
-- 	count = 0
--     DoScreenFadeOut(500)
--     Citizen.Wait(500)
--     SetPedMotionBlur(GetPlayerPed(-1), true)
--     SetTimecycleModifier("spectator5")
--     SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@verydrunk", true)
--     DoScreenFadeIn(1000)
-- 	repeat
-- 		ShakeGameplayCam('DRUNK_SHAKE', 0.1)
-- 		Citizen.Wait(120000)
-- 		count = count + 1
-- 	until count == 1
--     DoScreenFadeOut(500)
--     Citizen.Wait(500)
--     DoScreenFadeIn(500)
--     ClearTimecycleModifier()
--     ResetPedMovementClipset(GetPlayerPed(-1), 0)
--     ClearAllPedProps(GetPlayerPed(-1), true)
--     SetPedMotionBlur(GetPlayerPed(-1), false)
--     ESX.ShowNotification('You feel the effect fading away...')
--     onAlcoholic = false
-- end)

RegisterNetEvent('iG_Mechanics:item:repairEngine')
AddEventHandler('iG_Mechanics:item:repairEngine', function()
	-- if isNearEngine() then
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
				exports['mythic_progbar']:Progress({
					name = "repair_engine",
					duration = 25000,
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
						TriggerServerEvent('vy_UsableItems:removeItemEngine')
						exports['mythic_notify']:SendAlert('inform', 'You have repaired the vehicles engine.')
						SetVehicleDoorShut(vehicle, 4, false, false)
					end
				end)
			end
		end
	-- else
	-- 	exports['mythic_notify']:SendAlert('error', 'You need to be at the vehicles engine to repair this.')
	-- end
end)

function isNearEngine()
	local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	if DoesEntityExist(targetVehicle) and IsEntityAVehicle(targetVehicle) then
		local fbumperpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "bumper_f"))
		local bonnetpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "bonnet"))
		local playerpos = GetEntityCoords(PlayerPedId(), 1)
		local distanceTofbumper = GetDistanceBetweenCoords(fbumperpos, playerpos, 1)
		local distanceToBonnet = GetDistanceBetweenCoords(bonnetpos, playerpos, 1)
		if distanceTofbumper < 2.5 or distanceToBonnet < 2.5 then
			SetVehicleDoorOpen(targetVehicle, 4, false, false)
			return true
		else
			return
		end
	end
end

RegisterNetEvent('iG_Mechanics:item:cleanVehicle')
AddEventHandler('iG_Mechanics:item:cleanVehicle', function(vehicle)
	if isNearWindow() then
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
				
				carcleaner = CreateObject(GetHashKey("prop_sponge_01"), 0, 0, 0, true, true, true)		
				AttachEntityToEntity(carcleaner, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, -0.01, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
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
						DeleteObject(carcleaner)
						SetVehicleDirtLevel(vehicle, 0)
						TriggerServerEvent('vy_UsableItems:removeItemCarcleaner')
						exports['mythic_notify']:SendAlert('inform', 'You have completed detailing the vehicle.')
					end
				end)
				if DoesEntityExist(carcleaner) then
					Citizen.Wait(15000)
					DeleteObject(carcleaner)
				end	
			end
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You need to be at the vehicles window to clean this.')
	end
end)

function isNearWindow()
	local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	if DoesEntityExist(targetVehicle) and IsEntityAVehicle(targetVehicle) then
		local fddoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_dside_f"))
		local fpdoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_pside_f"))
		local playerpos = GetEntityCoords(PlayerPedId(), 1)
		local distanceToFddoor = GetDistanceBetweenCoords(fddoorpos, playerpos, 1)
		local distanceToFpdoor = GetDistanceBetweenCoords(fpdoorpos, playerpos, 1)
		if distanceToFddoor < 1.4 then
			return true
		elseif distanceToFpdoor < 1.4 then
			return true
		else
			return
		end
	end
end

RegisterNetEvent('iG_Mechanics:item:repairBodykit')
AddEventHandler('iG_Mechanics:item:repairBodykit', function()
	if isNearVehicle() then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local engineHealth = GetVehicleEngineHealth(targetVehicle)
		exports['mythic_progbar']:Progress({
			name = "repair_body",
			duration = 25000,
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
				TriggerServerEvent('vy_UsableItems:removeItemBodywork')
				exports['mythic_notify']:SendAlert('inform', 'You have repaired the vehicles body.')
				targetVehicle = nil
			end
		end)
	else
		exports['mythic_notify']:SendAlert('error', 'You need to be near the vehicles fender or door to repair this.')
	end
end)

function isNearVehicle()
	local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	targetVehicle = getVehicleInDirection(coordA, coordB)
	if DoesEntityExist(targetVehicle) and IsEntityAVehicle(targetVehicle) then
		local fddoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_dside_f"))
		local fpdoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_pside_f"))
		local rddoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_dside_r"))
		local rpdoorpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "door_pside_r"))
		local lfwheelpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "wheel_lf"))
		local rfwheelpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "wheel_rf"))
		local lrwheelpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "wheel_lr"))
		local rrwheelpos = GetWorldPositionOfEntityBone(targetVehicle, GetEntityBoneIndexByName(targetVehicle, "wheel_rr"))
		local playerpos = GetEntityCoords(PlayerPedId(), 1)
		local distanceToFddoor = GetDistanceBetweenCoords(fddoorpos, playerpos, 1)
		local distanceToFpdoor = GetDistanceBetweenCoords(fpdoorpos, playerpos, 1)
		local distanceTorddoorpos = GetDistanceBetweenCoords(rddoorpos, playerpos, 1)
		local distanceTorpdoorpos = GetDistanceBetweenCoords(rpdoorpos, playerpos, 1)
		local distanceTolfwheelpos = GetDistanceBetweenCoords(lfwheelpos, playerpos, 1)
		local distanceTorfwheelpos = GetDistanceBetweenCoords(rfwheelpos, playerpos, 1)
		local distanceTolrwheelpos = GetDistanceBetweenCoords(lrwheelpos, playerpos, 1)
		local distanceTorrwheelpos = GetDistanceBetweenCoords(rrwheelpos, playerpos, 1)
		if distanceToFddoor < 1.4 or distanceToFpdoor < 1.4 or distanceTorddoorpos < 1.4 or distanceTorpdoorpos < 1.4 or distanceTolfwheelpos < 1.4 or distanceTorfwheelpos < 1.4 or distanceTolrwheelpos < 1.4 or distanceTorrwheelpos < 1.4 then
			return true
		else
			return
		end
	end
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end