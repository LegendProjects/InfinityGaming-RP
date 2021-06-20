ESX = nil

local currentPlayerJobName  = 'none'
local PlayerData = {}
local jobTitle = 'mcdonalds'

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(100)
	end

    if ESX.GetPlayerData().job2.name ~= nil then
        currentPlayerJobName = ESX.GetPlayerData().job2.name
    end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

local hasLoadedCar = true
local isInMarker = false
local menuIsOpen = false
local vehcileMenuIsOpen = false
local hintToDisplay = _U('NoHintError')
local displayHint = false
local currentZone = 'none'
local currentJob = 'none'
local playerPed = PlayerPedId(-1)

local invDrink = 0
local invBurger = 0
local invFries = 0
local invMeal = 0

local payBonus = 0
local bonus = 1.25

local mealsMade = 0
local customersServed = 0
local ordersDelivered = 0

local paidDeposit = 0

local lastDelivery = 'none'

local showingBlips = false
local hasTakenOrder = false
local hasOrder = false
local isDelivering = false
local isDriveDelivering = false

local dHasTakenOrder = false
local dHasOrder = false
local dIsDelivering = false
local driverHasCar = false

local taskPoints = {}
local Blips = {}
local deliveryCoords
local dDeliveryCoords

local blipM
local blipJ

local playerBusy = false

local hasStartedBlips = false

local mealInvent = 0

local trayProp
local bagProp
local drinkProp
local currentRegister = 0

local currentPed
local lastPed
local delivered = false
local cobber
local badPoints = 0
local isFired = false

--Press [E] Buttons
Citizen.CreateThread(function()
	while true do																
		Citizen.Wait(2)					
		if not menuIsOpen then
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
            if currentPlayerJobName ~= nil and currentPlayerJobName == 'mcdonalds' and playerBusy == false and Config.EnablePlayerJobs == true then														
			    if  playerIsInside(playerCoords, Config.JobMenuCoords, Config.JobMarkerDistance) then 				
			        isInMarker = true
			        displayHint = true																
			        hintToDisplay = _U('JobListMarker')									
			        currentZone = 'JobList'	
                elseif  playerIsInside(playerCoords, Config.CookBurgerCoords, Config.JobMarkerDistance) and currentJob == 'cook' and invBurger <= 1 then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('CookBurger')									
			    	currentZone = 'Burger'																
			    elseif  playerIsInside(playerCoords, Config.CookFriesCoords, Config.JobMarkerDistance) and currentJob == 'cook' and invFries <= 1 then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('CookFries')									
			    	currentZone = 'Fries'																
			    elseif  playerIsInside(playerCoords, Config.CookDrinkCoords, Config.JobMarkerDistance) and currentJob == 'cook' and invDrink <= 1 then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('GetDrink')									
			    	currentZone = 'Drink'																
			    elseif  playerIsInside(playerCoords, Config.CookPrepareCoords, Config.JobMarkerDistance) and currentJob == 'cook' and invBurger >= 1 and invDrink >= 1 and invFries >= 1 then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('MakeMeal')									
			    	currentZone = 'Prepare'		    
			    elseif  playerIsInside(playerCoords, Config.CashTakeOrder, Config.JobMarkerDistance) and currentJob == 'cashier' and hasTakenOrder == false and Config.EnableNPCOrders == true then 				
                    isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('TakeOrder')									
			    	currentZone = 'cOrder'
                    currentRegister = 1
                elseif  playerIsInside(playerCoords, Config.CashTakeOrder1, Config.JobMarkerDistance) and currentJob == 'cashier' and hasTakenOrder == false and Config.EnableNPCOrders == true  then 				
                    isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('TakeOrder')									
			    	currentZone = 'cOrder'
                    currentRegister = 2
                elseif  playerIsInside(playerCoords, Config.CashTakeOrder2, Config.JobMarkerDistance) and currentJob == 'cashier' and hasTakenOrder == false and Config.EnableNPCOrders == true  then 				
                    isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('TakeOrder')									
			    	currentZone = 'cOrder'
                    currentRegister = 3
			    elseif  playerIsInside(playerCoords, Config.CashCollectMeal, Config.JobMarkerDistance) and currentJob == 'cashier' and hasOrder == false then 				
                    if Config.EnableNPCOrders == true then
                        if hasTakenOrder == true then
                            isInMarker = true
			    	        displayHint = true																
			    	        hintToDisplay = _U('GrabOrder')								
			    	        currentZone = 'cCollect'
                        end
                    else
                        isInMarker = true
			    	    displayHint = true																
			    	    hintToDisplay = _U('GrabOrder')								
			    	    currentZone = 'cCollect'
                    end
                elseif  deliveryCoords ~= nil and playerIsInside(playerCoords, deliveryCoords, Config.JobExtendedDistance) and currentJob == 'cashier' and isDelivering then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('GiveOrder')									
			    	currentZone = 'cDeliver'
                elseif  playerIsInside(playerCoords, Config.CashCollectMeal, Config.JobMarkerDistance) and currentJob == 'deliv' then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('TakeDeliv')									
			    	currentZone = 'dCollect'
                elseif  dDeliveryCoords ~= nil and playerIsInside(playerCoords, dDeliveryCoords, Config.JobExtendedDistance) and currentJob == 'deliv' then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('GiveDeliv')									
			    	currentZone = 'dDeliver'
                elseif  dDeliveryCoords == nil and currentJob == 'deliv' and dHasOrder then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('DelivError')								
			    	currentZone = 'dDeliver'
                elseif  playerIsInside(playerCoords, Config.DeliveryCarSpawnMarker, Config.JobMarkerDistance) and currentJob == 'deliv' and hasLoadedCar == true then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('GetCar')									
			    	currentZone = 'dCarSpawn'
                elseif  playerIsInside(playerCoords, Config.DeliveryCarSpawnMarker, Config.JobMarkerDistance) and currentJob == 'deliv' and hasLoadedCar == false then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('LoadingCar')
                    currentZone = 'none'
                elseif  playerIsInside(playerCoords, Config.DeliveryCarDespawn, Config.JobExtendedDistance) and currentJob == 'deliv' and driverHasCar then 				
			    	isInMarker = true
			    	displayHint = true																
			    	hintToDisplay = _U('ReturnCar')									
			    	currentZone = 'dCarDespawn'
                else
			    	isInMarker = false
			    	displayHint = false
			    	hintToDisplay = _U('NoHintError')
			    	currentZone = 'none'
                    currentRegister = 0
			    end
			    if IsControlJustReleased(0, 38) and isInMarker then
			    	taskTrigger(currentZone)													
			    	Citizen.Wait(500)
			    end
            end
		end
	end
end)
--Start Blips
Citizen.CreateThread(function()
    if currentPlayerJobName ~= 'none' then
        if showingBlips == false then
            if Config.EnableBlips == true then
                refreshBlips()
            else
                deleteBlips()
            end
        else
            deleteBlips()
            if Config.EnableBlips == true then
                refreshBlips()
            end
        end
    end
end)
--Hint to Display
Citizen.CreateThread(function()
    while true do										
    Citizen.Wait(1)
        if displayHint and playerBusy == false then							
            SetTextComponentFormat("STRING")				
            AddTextComponentString(hintToDisplay)			
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)	
        end
    end
end)
--Display Markers
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        if not playerBusy then
		    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		    if currentPlayerJobName == 'mcdonalds' and playerIsInside(playerCoords, Config.JobMenuCoords, 20) and Config.EnablePlayerJobs == true then 
			    displayMarker(Config.JobMenuCoords)
		    end
		    if onDuty and currentJob == 'cook' and playerIsInside(playerCoords, Config.JobMenuCoords, 100) then			
			    if invBurger < 2 then
                    displayMarker(Config.CookBurgerCoords)
                end
                if invDrink < 2 then
                    displayMarker(Config.CookDrinkCoords)
                end
                if invFries < 2 then
                    displayMarker(Config.CookFriesCoords)
                end
                if invBurger > 0 and invDrink > 0 and invFries > 0 then
                    displayMarker(Config.CookPrepareCoords)
                end
		    end
		    if onDuty and currentJob == 'cashier' and playerIsInside(playerCoords, Config.JobMenuCoords, 100) then 			
			    if Config.EnableNPCOrders == true then
                    if hasTakenOrder == false and hasOrder == false then
                        displayMarker(Config.CashTakeOrder)
                        displayMarker(Config.CashTakeOrder1)
                        displayMarker(Config.CashTakeOrder2)
                    elseif hasTakenOrder == true and hasOrder == false then
                        displayMarker(Config.CashCollectMeal)
                    end
                    if isDelivering == true then
                        local temp = vector3(deliveryCoords.x,deliveryCoords.y,deliveryCoords.z)
                        deliveryMarker(temp)
                    end
                else
                    displayMarker(Config.CashCollectMeal)
                end
		    end
            if onDuty and currentJob == 'deliv' and playerIsInside(playerCoords, Config.JobMenuCoords, 10000) then
                if Config.EnableNPCOrders == true then
                    if dHasOrder == false then
                        displayMarker(Config.CashCollectMeal)
                    end
                    if isDriveDelivering == true then
                        if dDeliveryCoords ~= nil then
                            local temp = vector3(dDeliveryCoords.x,dDeliveryCoords.y,dDeliveryCoords.z - 1)
                            deliveryDMarker(temp)
                        else
                            print(Config.Prefix.."^2dDeliveryCoords are NIL! Cannot create Marker!")
                        end
                    end
                    displayMarker(Config.DeliveryCarSpawnMarker)
                    if driverHasCar == true then
                        destroyMarker(Config.DeliveryCarDespawn)
                    end
                else
                    displayMarker(Config.CashCollectMeal)
                    displayMarker(Config.DeliveryCarSpawnMarker)
                    if driverHasCar == true then
                        destroyMarker(Config.DeliveryCarDespawn)
                    end
                end
            end
        end
	end
end)
--Zones
function taskTrigger(zone)
	if zone == 'JobList' then				
		openMenu()
	elseif zone == 'Burger' then				
		getBurger()
	elseif zone == 'Fries' then	
		getFries()
	elseif zone == 'Drink' then
        getDrink()
    elseif zone == 'Prepare' then
        prepareMeal()
    elseif zone == 'cOrder' then
        takeOrder()
    elseif zone == 'cCollect' then
        pickupOrder()
    elseif zone == 'cDeliver' then
        deliverOrder()
    elseif zone == 'dCollect' then
        pickupDelivery()
    elseif zone == 'dDeliver' then
        driveFromDelivery()
    elseif zone == 'dCarSpawn' then
        openWorkVehicleMenu()
    elseif zone == 'dCarDespawn' then
        deleteCar()
    end
end
--Check if Inside work Vehicle
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if IsPedInAnyVehicle(playerPed, false) then
           if isMyCar() then
                if currentJob == 'deliv' and onDuty and isDriveDelivering then
                    if dDeliveryCoords ~= nil then
                        setGPS(dDeliveryCoords)
                    else
                        dPrint("Delivery Cords are NIL unable to re-assign GPS Blip")
                    end
                end
            else
                if currentJob == 'deliv' and onDuty and isDriveDelivering then
                    RemoveBlip(Blips['deliver'])
                end
            end 
        else
            RemoveBlip(Blips['deliver'])
        end
    end
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)		
    playerData = xPlayer
    currentPlayerData = xPlayer
    if Config == nil then
        print(Config.Prefix.."Couldnt Load Config")
    else
        if Config.EnableBlips == true then
            while currentPlayerData.job2 == jobTitle and jBlipsCreated == 0 do
                refreshBlips()
                Citizen.Wait(100)
            end
        end
    end								
end)

RegisterNetEvent('iG:setJob2')
AddEventHandler('iG:setJob2', function(job2)
    currentPlayerJobName = job2.name
    if job2.name == jobTitle then 
        onDuty = true
    else
        onDuty = false
    end
    if currentJob == 'clean' then
        onDuty = false
    end
    refreshBlips()						
end)

RegisterNetEvent('iG_McDonalds:consumedItem')
AddEventHandler('iG_McDonalds:consumedItem', function(item)
    if Config.EnablePlayerBadPoints then
        if ESX.GetPlayerData().job.name == "mcdonalds" and item == 1 then --Drink
            if onDuty then
                dPrint("Woah! your on duty and drinking an object that only a cook can get?")
                if invDrink > 0 then
                    dPrint("Aye!?!? according to the iG_McDonalds Script you gained a drink by pouring yourself one! This just will not do!")
                    invDrink = invDrink - 1
                    Citizen.Wait(1000)
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedDrink.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedDrink.Description.."$"..Config.PlayerFines.ConsumedDrink.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedDrink.Description.."$"..Config.PlayerFines.ConsumedDrink.Amount)
                    end
                else
                    dPrint("It seems as though you didn't pour yourself a drink, so you might have paid for it, please change to Cleaner/Off Duty next time your having a break!")
                end
            else
                dPrint("We suspect that your are good! thanks for being off-duty while consuming food/drink")
                if invDrink > 0 then
                    dPrint("Although We can see here that you did indeed pour yourself a drink from the machine! This just will not do!")
                    invDrink = invDrink - 1
                    Citizen.Wait(1000)
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedDrink.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedDrink.Description.."$"..Config.PlayerFines.ConsumedDrink.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedDrink.Description.."$"..Config.PlayerFines.ConsumedDrink.Amount)
                    end
                end
            end
        elseif ESX.GetPlayerData().job.name == "mcdonalds" and item == 2 then --Fries
            if onDuty then
                dPrint("Woah! your on duty and eating an object that only a cook can get?")
                if invFries > 0 then
                    dPrint("Aye!?!? according to the iG_McDonalds Script you gained fries by cooking youself some! This just will not do!")
                    invFries = invFries - 1
                    Citizen.Wait(1000)
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedFries.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedFries.Description.."$"..Config.PlayerFines.ConsumedFries.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedFries.Description.."$"..Config.PlayerFines.ConsumedFries.Amount)
                    end
                else
                    dPrint("It seems as though you didn't cook these fries, so you might have paid for them, please change to Cleaner/Off Duty next time your having a break!")
                end
            else
                dPrint("We suspect that your are good! thanks for being off-duty while consuming food/drink")
                if invFries > 0 then
                    Citizen.Wait(1000)
                    dPrint("Although We can see here that you did indeed cook these fries! This just will not do!")
                    invFries = invFries - 1
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedFries.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedFries.Description.."$"..Config.PlayerFines.ConsumedFries.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedFries.Description.."$"..Config.PlayerFines.ConsumedFries.Amount)
                    end
                end
            end
        elseif ESX.GetPlayerData().job.name == "mcdonalds" and item == 3 then --Burger
            if onDuty then
                dPrint("Woah! your on duty and eating an object that only a cook can get?")
                if invBurger > 0 then
                    dPrint("Aye!?!? according to the iG_McDonalds Script you gained a Burger by cooking yourself one! This just will not do!")
                    invBurger = invBurger - 1
                    Citizen.Wait(1000)
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedBurger.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedBurger.Description.."$"..Config.PlayerFines.ConsumedBurger.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedBurger.Description.."$"..Config.PlayerFines.ConsumedBurger.Amount)
                    end
                else
                    dPrint("It seems as though you didn't cook this Burger, so you might have paid for it, please change to Cleaner/Off Duty next time your having a break!")
                end
            else
                dPrint("We suspect that your are good! thanks for being off-duty while consuming food/drink")
                if invBurger > 0 then
                    Citizen.Wait(1000)
                    dPrint("Although We can see here that you did indeed cook this Burger! This just will not do!")
                    invBurger = invBurger - 1
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedBurger.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedBurger.Description.."$"..Config.PlayerFines.ConsumedBurger.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedBurger.Description.."$"..Config.PlayerFines.ConsumedBurger.Amount)
                    end
                end
            end
        elseif ESX.GetPlayerData().job.name == "mcdonalds" and item == 4 then --Meal
            if onDuty then
                dPrint("Woah! Ang' on just a minit!")
                if invMeal > 0 then
                    Citizen.Wait(1000)
                    dPrint("Aye!?!? according to the iG_McDonalds Script you gained a Meal by grabbing yourself one! This just will not do!")
                    invMeal = invMeal - 1
                    cancelCurrentOrder()
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedMeal.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedMeal.Description.."$"..Config.PlayerFines.ConsumedMeal.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedMeal.Description.."$"..Config.PlayerFines.ConsumedMeal.Amount)
                    end
                else
                    dPrint("It seems as though you didn't cook this Burger, so you might have paid for it, please change to Cleaner/Off Duty next time your having a break!")
                end
            else
                dPrint("We suspect that your are good! thanks for being off-duty while consuming food/drink")
                if invMeal > 0 and hasOrder and hasTakenOrder and isDelivering or invMeal > 0 and dHasOrder and isDriveDelivering then
                    Citizen.Wait(1000)
                    dPrint("Although We can see here that you did indeed grab this meal from the counter! This just will not do!")
                    invMeal = invMeal - 1
                    cancelCurrentOrder()
                    TriggerServerEvent('iG_McDonalds:payDeposit', Config.PlayerFines.ConsumedMeal.Amount)
                    if Config.EnablePNotify then
                        exports.pNotify:SendNotification({text = Config.PlayerFines.ConsumedMeal.Description.."$"..Config.PlayerFines.ConsumedMeal.Amount, type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnableMythic then
                        exports['mythic_notify']:SendAlert('error', Config.PlayerFines.ConsumedMeal.Description.."$"..Config.PlayerFines.ConsumedMeal.Amount)
                    end
                end
            end
        end

        Citizen.Wait(1000)

        if Config.EnablePlayerBadPoints then
            if badPoints < Config.BadPointLimit then
                badPoints = badPoints + 1
                if Config.EnablePNotify then
                    exports.pNotify:SendNotification({text = "You have gained a Bad Point you now have "..badPoints.."/"..Config.BadPointLimit..". Continuing to break the rules will result in your instant dismissal!", type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnableMythic then
                    exports['mythic_notify']:SendAlert('error', "You have gained a Bad Point you now have "..badPoints.."/"..Config.BadPointLimit..". Continuing to break the rules will result in your instant dismissal!")
                end
                if badPoints >= Config.BadPointLimit then
                    fireWorker()
                end
            else
                fireWorker()
            end
        end
    end
end)

function fireWorker()
    currentJob = nil

    if Config.EnablePNotify then
        exports.pNotify:SendNotification({text = "You have been FIRED from McDonalds for breaking too many rules!", type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    elseif Config.EnableMythic then
        exports['mythic_notify']:SendAlert('error', "You have been FIRED from McDonalds for breaking too many rules!")
    end
    TriggerServerEvent('iG_McDonalds:fireWorker')
end

function cancelCurrentOrder()
    if currentJob == 'cashier' then
        playerIsBusy(false)
        hasOrder = false
        hasTakenOrder = false
        isDelivering = false
        deliveryCoords = nil
        deletePed()
        delivered = true
    elseif currentJob == 'deliv' then
        dHasOrder = false
        isDriveDelivering = false
        dDeliveryCoords = nil
        RemoveBlip(Blips['deliver'])
    end
end

function setJobName(jobName)
    if ESX ~= nil then
        if jobName ~= nil then
            if jobName == 'cashier' then
                TriggerServerEvent('iG_McDonalds:setCashierJob')
            elseif jobName == 'deliv' then
                TriggerServerEvent('iG_McDonalds:setDelivJob')
            elseif jobName == 'cook' then
                TriggerServerEvent('iG_McDonalds:setCookJob')
            elseif jobName == 'clean' then
                TriggerServerEvent('iG_McDonalds:setCleanJob')
            else
                dPrint("Something went Wrong Setting McDonalds Job")
            end
        else
            dPrint("jobName returned NIL unable to Set McDonalds Job")
        end
    else
        dPrint("ESX is NIL unable to set Job Name")
    end
end

function playerIsInside(playerCoords, coords, distance) 	
	local vecDiffrence = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, false)
	return vecDiffrence < distance		
end

function getBurger()
    if invBurger >= 2 then
        if Config.EnablePNotify == true then
        exports.pNotify:SendNotification({text = _U('BurgerError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('error', _U('BurgerError'))
        end
    else
        playerIsBusy(true)
        exports['mythic_progbar']:Progress({
			name = "cook_burger",
			duration = Config.CookBurgerTime,
			label = _U('BurgerBar'),
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "misscarsteal2fixer",
				anim = "confused_a",
				flags = 49,
			},
		}, function(status)
			if not status then
                TriggerServerEvent("iG_McDonalds:addItem", 'mcdonalds_burger')
                invBurger = invBurger + 1
                
			end
		end)
        playerIsBusy(false)
    end
end

function getFries()
    if invFries >= 2 then
        exports['mythic_notify']:SendAlert('error', _U('FriesError'))
    else
        playerIsBusy(true)
        exports['mythic_progbar']:Progress({
			name = "cook_fries",
			duration = Config.CookFriesTime,
			label = _U('FriesBar'),
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mp_common",
				anim = "givetake1_a",
				flags = 49,
			},
		}, function(status)
			if not status then
                TriggerServerEvent("iG_McDonalds:addItem", 'mcdonalds_fries')
                invFries = invFries + 1  
			end
        end)
        playerIsBusy(false)
    end
end

function getDrink()
    if invDrink >= 2 then
        exports['mythic_notify']:SendAlert('error', _U('DrinkError'))
    else
        playerIsBusy(true)
        exports['mythic_progbar']:Progress({
			name = "pour_drink",
			duration = Config.CookDrinkTime,
			label = _U('DrinkBar'),
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mp_common",
				anim = "givetake1_a",
				flags = 49,
			},
		}, function(status)
			if not status then
                TriggerServerEvent("iG_McDonalds:addItem", 'mcdonalds_drink')
                invDrink = invDrink + 1
			end
        end)
        playerIsBusy(false)
    end
end

RegisterNetEvent("iG_McDonalds:setInvent")
AddEventHandler("iG_McDonalds:setInvent", function(amount)
    mealInvent = amount
end)

function prepareMeal()
    if Config.EnableMealInventory == true then
        if invBurger > 0 and invDrink > 0 and invFries > 0 then
            playerIsBusy(true)
            exports['mythic_progbar']:Progress({
                name = "prepare_meal",
                duration = Config.CookDrinkTime,
                label = _U('MealBar'),
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "misscarsteal2fixer",
                    anim = "confused_a",
                    flags = 49,
                },
            }, function(status)
                if not status then
                    invBurger = invBurger - 1
                    invDrink = invDrink - 1
                    invFries = invFries - 1
                    mealsMade = mealsMade + 1
                    TriggerServerEvent("iG_McDonalds:removeItem", 'mcdonalds_burger')
                    TriggerServerEvent("iG_McDonalds:removeItem", 'mcdonalds_drink')
                    TriggerServerEvent("iG_McDonalds:removeItem", 'mcdonalds_fries')
                    TriggerServerEvent("iG_McDonalds:addToMealInvent")
                    if Config.EnableNPCOrders == true then
                        if Config.EnableMoreWorkMorePay == true then
                            bonus = 1 * mealsMade
                            payBonus = Config.CashJobPay * bonus
                            TriggerServerEvent("iG_McDonalds:getPaid", payBonus)
                            if mealsMade > 1 then
                                if Config.EnableESXNotif == true then
                                    ESX.ShowNotification('~b~You received a ~g~bonus~b~ for consecutive work. keep it up! Bonus: ~g~x'..bonus)
                                end
                            end
                            if Config.EnableESXNotif == true then
                                ESX.ShowNotification('~b~You were paid ~g~+$'..payBonus..'~b~.')
                            end
                        else
                            TriggerServerEvent("iG_McDonalds:getPaid", Config.CookJobPay)
                            if Config.EnableESXNotif == true then
                                ESX.ShowNotification('~b~You were paid ~g~+$'..Config.CookJobPay..'~b~.')
                            end
                        end
                    end
                end
            end)
            
            playerIsBusy(false)
        else
            exports['mythic_notify']:SendAlert('error', _U('MealError'))
            exports['mythic_notify']:SendAlert('error', 'You Currently have x'..invBurger..' Fresh Burger(s), x'..invDrink..' Fresh Drink(s) and x'..invFries..' Fresh Fries')
        end
    end
end

function takeOrder()
    if hasTakenOrder == false then
        playerIsBusy(true)
        if currentRegister == 1 then
            SetEntityHeading(playerPed, Config.PlrCashTOCoords.h)
            SetEntityCoords(playerPed, Config.PlrCashTOCoords.x, Config.PlrCashTOCoords.y, Config.PlrCashTOCoords.z)
        elseif currentRegister == 2 then
            SetEntityHeading(playerPed, Config.PlrCashTO1Coords.h)
            SetEntityCoords(playerPed, Config.PlrCashTO1Coords.x, Config.PlrCashTO1Coords.y, Config.PlrCashTO1Coords.z)
        elseif currentRegister == 3 then
            SetEntityHeading(playerPed, Config.PlrCashTO2Coords.h)
            SetEntityCoords(playerPed, Config.PlrCashTO2Coords.x, Config.PlrCashTO2Coords.y, Config.PlrCashTO2Coords.z)
        else
            dPrint("The Current Register Number Could NOT be Determined! Unable to set Player Position and Heading")
        end
        exports['mythic_progbar']:Progress({
            name = "customer_order",
            duration = Config.CashOrderTime,
            label = _U('CashBar'),
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_take_money_mg",
                anim = "stand_cash_in_bag_loop",
                flags = 49,
            },
        }, function(status)
            if not status then
                hasTakenOrder = true
            end
        end)
        playerIsBusy(false)
    else
        exports['mythic_notify']:SendAlert('error', _U('CashError'))
    end    
end

function pickupOrder()
    if Config.EnableMealInventory == true then
        if Config.EnableNPCOrders == true then
            if hasOrder == false and hasTakenOrder == true then
                if mealInvent > 0 then
                    playerIsBusy(true)

                    exports['mythic_progbar']:Progress({
                        name = "customer_order",
                        duration = Config.CashMealTime,
                        label = _U('PickupBar'),
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_am_hold_up",
                            anim = "purchase_beerbox_shopkeeper",
                            flags = 49,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("iG_McDonalds:removeFromMealInvent")
                            TriggerServerEvent("iG_McDonalds:addItem", 'mcdonalds_meal')
                            invMeal = invMeal + 1
                            hasOrder = true
                            setDelivery()
                        end
                    end)
                    playerIsBusy(false)

                    
                else
                    exports['mythic_notify']:SendAlert('error', _U('PickupError3'))
                end
            elseif hasOrder == true and hasTakenOrder == true then
                exports['mythic_notify']:SendAlert('error', _U('PickupError'))
            elseif hasTakenOrder == false and hasOrder == false then
                exports['mythic_notify']:SendAlert('error', _U('PickupError1'))
            else
                exports['mythic_notify']:SendAlert('error', _U('PickupError2'))
            end
        end
    end
end

function setDelivery()
    repeat
        deliveryPoint = math.random(1, #Config.cashDeliveryPoints)
	until deliveryPoint ~= lastDelivery
    deliveryCoords = Config.cashDeliveryPoints[deliveryPoint]
  	taskPoints['delivery'] = { x = deliveryCoords.x, y = deliveryCoords.y, z = deliveryCoords.z}
	lastDelivery = deliveryPoint
    isDelivering = true
    setGPS(deliveryCoords)
    if Config.EnablePNotify == true and Config.EnableMythic == false then
        exports.pNotify:SendNotification({text = _U('Table')..deliveryPoint, type = "success", timeout = 5000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
        exports['mythic_notify']:SendAlert('success', _U('Table')..deliveryPoint)
    end
    if Config.SpawnPeds == true then
        spawnPed()
    end
end

function spawnPed()
    repeat
        currentPed = math.random(1, #Config.NPCNames)
    until currentPed ~= lastPed
    RequestModel(Config.NPCNames[currentPed].name)
    while not HasModelLoaded(Config.NPCNames[currentPed].name) do
        Wait(1)
    end
    deliveryCoords = Config.cashDeliveryPoints[deliveryPoint]
    cobber = CreatePed(1, Config.NPCNames[currentPed].name, deliveryCoords.x - 0.6, deliveryCoords.y - 0.1, deliveryCoords.z + 0.1, 237.39, false, true)
    SetBlockingOfNonTemporaryEvents(cobber, true)
    SetPedDiesWhenInjured(cobber, false)
    SetPedCanPlayAmbientAnims(cobber, false)
    SetPedCanRagdollFromPlayerImpact(cobber, false)
    SetEntityInvincible(cobber, true)
    FreezeEntityPosition(cobber, true)
    TaskStartScenarioInPlace(cobber, "amb@code_human_in_bus_passenger_idles@female@sit@base", 0, true);
    delivered = false
end

function deletePed()
    Citizen.Wait(Config.NPCDespawnTime * 1000)
    DeletePed(cobber)
end

function deliverOrder()
    playerIsBusy(true)

    exports['mythic_progbar']:Progress({
        name = "customer_order",
        duration = Config.CashDelivTime,
        label = _U('GiveBar'),
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_am_hold_up",
            anim = "purchase_beerbox_shopkeeper",
            flags = 49,
        },
    }, function(status)
        if not status then
            customersServed = customersServed + 1
            RemoveBlip(Blips['deliver'])
            delivered = true
            TriggerServerEvent("iG_McDonalds:removeItem", 'mcdonalds_meal')
            if Config.EnableMoreWorkMorePay == true then
                bonus = 1 * customersServed
                payBonus = Config.CashJobPay * bonus
                TriggerServerEvent("iG_McDonalds:getPaid", payBonus)
                if customersServed > 1 then
                    if Config.EnableESXNotif == true then
                        ESX.ShowNotification('~b~You received a ~g~bonus~b~ for consecutive work. keep it up! Bonus: ~g~x'..bonus)
                    end
                end
                if Config.EnableESXNotif == true then
                    ESX.ShowNotification('~b~You were paid ~g~+$'..payBonus..'~b~.')
                end
            else
                TriggerServerEvent("iG_McDonalds:getPaid", Config.CashJobPay)
                if Config.EnableESXNotif == true then
                    ESX.ShowNotification('~b~You were paid ~g~+$'..Config.CashJobPay..'~b~.')
                end
            end
            hasOrder = false
            hasTakenOrder = false
            isDelivering = false
            deliveryCoords = nil
            deletePed()
        end
    end)
    playerIsBusy(false)
end

function pickupDelivery()
    if Config.EnableNPCOrders == true then
        if Config.EnableMealInventory == true then
            if mealInvent > 0 then
                if dHasOrder == false then
                    playerIsBusy(true)
                    exports['mythic_progbar']:Progress({
                        name = "customer_order",
                        duration = Config.CashDelivTime,
                        label = _U('GiveBar'),
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "misscarsteal2fixer",
                            anim = "confused_a",
                            flags = 49,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("iG_McDonalds:removeFromMealInvent")
                            TriggerServerEvent("iG_McDonalds:addItem", 'mcdonalds_meal')
                            invMeal = invMeal + 1
                            dHasOrder = true
                            setDriveDelivery()
                        end
                    end)
                    playerIsBusy(false)
                   
                elseif dHasOrder == true then
                    exports['mythic_notify']:SendAlert('error', _U('PickupError'))
                else
                    exports['mythic_notify']:SendAlert('error', _U('PickupError2'))
                end
            else
                exports['mythic_notify']:SendAlert('error', _U('PickupError3'))
            end
        end
    end
end

function setDriveDelivery()
    repeat
    deliveryPoint = math.random(1, #Config.driveDeliveryPoints)
	until deliveryPoint ~= lastDelivery
	dDeliveryCoords = Config.driveDeliveryPoints[deliveryPoint]
	lastDelivery = deliveryPoint
    isDriveDelivering = true
    --setGPS(dDeliveryCoords)
    if Config.EnablePNotify == true and Config.EnableMythic == false then
        if driverHasCar then
            exports.pNotify:SendNotification({text = _U('DelivNotif'), type = "info", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            exports.pNotify:SendNotification({text = _U('DelivNotif1'), type = "info", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
        if driverHasCar then
            exports['mythic_notify']:SendAlert('inform', _U('DelivNotif'))
        else
            exports['mythic_notify']:SendAlert('inform', _U('DelivNotif1'))
        end
    end
end

function isMyCar()
	return currentPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function openWorkVehicleMenu()
    if driverHasCar == true then
        replaceLostCar(true)
        if Config.EnablePNotify == true and Config.EnableMythic == false then
            exports.pNotify:SendNotification({text = _U('CarError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('error', _U('CarError'))
        end
    else
        openVehicleMenu()
        if Config.EnablePNotify == true and Config.EnableMythic == false then
            exports.pNotify:SendNotification({text = _U('CarChoose'), type = "info", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('inform', _U('CarChoose'))
        end
    end
end

function replaceLostCar(bool)
    if bool == true then
        ESX.Game.DeleteVehicle(currentCar)			
        driverHasCar = false
        if Config.EnablePNotify == true and Config.EnableMythic == false then
            exports.pNotify:SendNotification({text = _U('CarError1'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('error', _U('CarError1'))
        end
    else
        ESX.UI.CloseAll()
    end
end

function openVehicleMenu()
    vehicleMenuIsOpen = true
    playerIsBusy(true)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'VehicleList',			
        {
        title    = _U('CarTitle'),	
        align = 'right',
        elements = {
            {label = _U('CarVan')..Config.VanDepositAmount, value = 'van'},		
            {label = _U('CarBike')..Config.BikeDepositAmount, value = 'bike'}
        }
    },
    function(data, menu)									
        if data.current.value == 'van' then	
            menu.close()
	        vehicleMenuIsOpen = false
            playerIsBusy(false)
            driverHasCar = true
            spawnVehicle(Config.CarToSpawn, Config.VanDepositAmount)  
            if Config.PayDeposit == true then
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('DepositNotif'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                     exports['mythic_notify']:SendAlert('success', _U('DepositNotif'))
                end
                paidDeposit = Config.VanDepositAmount
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('SpawnedNotif'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                     exports['mythic_notify']:SendAlert('success', _U('SpawnedNotif'))
                end
            end

        end
        if data.current.value == 'bike' then
            menu.close()
	        vehicleMenuIsOpen = false
            playerIsBusy(false)
            driverHasCar = true
            spawnVehicle(Config.BikeToSpawn, Config.BikeDepositAmount)  
            if Config.PayDeposit == true then
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('DepositNotif'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                     exports['mythic_notify']:SendAlert('success', _U('DepositNotif'))
                end
                paidDeposit = Config.BikeDepositAmount
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('SpawnedNotif'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                     exports['mythic_notify']:SendAlert('success', _U('SpawnedNotif'))
                end 
            end
        end
        menu.close()
	    vehicleMenuIsOpen = false
        playerIsBusy(false)
    end,
        function(data, menu)
        menu.close()
	    vehicleMenuIsOpen = false
        playerIsBusy(false)
    end)
end

function loadCarEvent()
    isInMarker = false
	displayHint = false
	hintToDisplay = _U('NoHintError')
	currentZone = 'none'
end

function spawnVehicle(carToSpawn, depositAmount)
    if Config.PayDeposit == true then
        TriggerServerEvent("iG_McDonalds:payDeposit", depositAmount)
    end
	local vehicleModel = GetHashKey(carToSpawn)	
	RequestModel(vehicleModel)				
	while not HasModelLoaded(vehicleModel) do	
		Citizen.Wait(0)
        hasLoadedCar = false
	end
    hasLoadedCar = true
    loadCarEvent()
	currentCar = CreateVehicle(vehicleModel, Config.DeliveryCarSpawn.x, Config.DeliveryCarSpawn.y, Config.DeliveryCarSpawn.z, Config.DeliveryCarSpawn.h, true, false)
	SetVehicleHasBeenOwnedByPlayer(currentCar,  true)														
	SetEntityAsMissionEntity(currentCar,  true,  true)														
	SetVehicleNumberPlateText(currentCar, "MACCAS")								
	local id = NetworkGetNetworkIdFromEntity(currentCar)													
	SetNetworkIdCanMigrate(id, true)																																																
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), currentCar, -1)
    driverHasCar = true
	local props = {																							
		modEngine       = 0,
		modTransmission = 0,
		modSuspension   = 3,
		modTurbo        = true,																				
	}
	ESX.Game.SetVehicleProperties(currentCar, props)
	Wait(1000)																							
	currentPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function deleteCar()
    if isMyCar() == true then
        if Config.PayDeposit == true then
            TriggerServerEvent("iG_McDonalds:returnDeposit", paidDeposit)
            if Config.EnableESXNotif == true then
                ESX.ShowNotification('~b~Your deposit has been returned ~g~+$'..paidDeposit..'~b~.')
            end
            paidDeposit = 0
        end
    	local entity = GetVehiclePedIsIn(GetPlayerPed(-1), false)	
	    ESX.Game.DeleteVehicle(entity)			
        driverHasCar = false
        if Config.EnablePNotify == true and Config.EnableMythic == false then
            exports.pNotify:SendNotification({text = _U('DespawnedNotif'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('success', _U('DespawnedNotif'))
        end
    else
        if Config.EnablePNotify == true and Config.EnableMythic == false then
            exports.pNotify:SendNotification({text = _U('ReturnError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        elseif Config.EnablePNotify == false and Config.EnableMythic == true then
            exports['mythic_notify']:SendAlert('error', _U('ReturnError'))
        end
    end
end

function setGPS(coords)
	if Blips['deliver'] ~= nil then 	
		RemoveBlip(Blips['deliver'])	
		Blips['deliver'] = nil			
	end
	if coords ~= 0 then
		Blips['deliver'] = AddBlipForCoord(coords.x, coords.y, coords.z)		
		SetBlipRoute(Blips['deliver'], true)								
	end
end

function driveFromDelivery()
    exports['mythic_progbar']:Progress({
        name = "drive_delivery",
        duration = Config.CashDelivTime,
        label = _U('GiveBar'),
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_am_hold_up",
            anim = "purchase_beerbox_shopkeeper",
            flags = 49,
        },
    }, function(status)
        if not status then
            ordersDelivered = ordersDelivered + 1
            RemoveBlip(Blips['deliver'])
            TriggerServerEvent("iG_McDonalds:removeItem", 'mcdonalds_meal')
            if Config.EnableMoreWorkMorePay == true then
                bonus = 1 * ordersDelivered
                payBonus = Config.DelivJobPay * bonus
                TriggerServerEvent("iG_McDonalds:getPaid", payBonus)
                if customersServed > 1 then
                    if Config.EnableESXNotif == true then
                        ESX.ShowNotification('You received a bonus for consecutive work. keep it up! Bonus: x'..bonus)
                    end
                end
                if Config.EnableESXNotif == true then
                    ESX.ShowNotification('You were paid $'..payBonus..'.')
                end
            else
                TriggerServerEvent("iG_McDonalds:getPaid", Config.DelivJobPay)
                if Config.EnableESXNotif == true then
                    ESX.ShowNotification('You were paid $'..Config.DelivJobPay..'.')
                end
            end
        
            dHasOrder = false
            isDriveDelivering = false
            dDeliveryCoords = nil
        end
    end)
end

function deleteBlips()
    RemoveBlip(blipM)
    RemoveBlip(blipJ)
    showingBlips = false
    if Config.EnableBlips == true and showingBlips == false then
        refreshBlips()
    elseif showingBlips == false and Config.EnableBlips == false then
        deleteBlips()
    end
end

function refreshBlips()
    if showingBlips == false then
        blipM = AddBlipForCoord(Config.blipLocationM.x, Config.blipLocationM.y)
        SetBlipSprite(blipM, Config.blipIDM)
        SetBlipDisplay(blipM, 4)
        SetBlipScale(blipM, 0.6)
        SetBlipColour(blipM, Config.blipColorM)
        SetBlipAsShortRange(blipM, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(_U('McDonaldsBlip'))
        EndTextCommandSetBlipName(blipM)
        showingBlips = true
    else
        deleteBlips()
    end
end

function playerIsBusy(bool)
    if bool == true then
        FreezeEntityPosition(playerPed, true)
        playerBusy = true
    else
        FreezeEntityPosition(playerPed, false)
        playerBusy = false
    end
end

function displayMarker(coords)
    if playerBusy == false then
        DrawMarker(20, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.JobMarkerColor.r, Config.JobMarkerColor.g, Config.JobMarkerColor.b, Config.JobMarkerColor.a, true, true, 2, false, false, false, false) 
    end
end

function deliveryMarker(coords)
    if playerBusy == false then
        DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.JobMarkerColor.r, Config.JobMarkerColor.g, Config.JobMarkerColor.b, Config.JobMarkerColor.a, true, true, 2, false, false, false, false)
        DrawMarker(29, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.DeliveryMarkerColor.r, Config.DeliveryMarkerColor.g, Config.DeliveryMarkerColor.b, Config.JobMarkerColor.a, true, true, 2, false, false, false, false)
    end
end

function deliveryDMarker(coords)
    if playerBusy == false then
        DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.JobMarkerColor.r, Config.JobMarkerColor.g, Config.JobMarkerColor.b, Config.JobMarkerColor.a, true, true, 2, false, false, false, false)
        DrawMarker(29, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.DeliveryMarkerColor.r, Config.DeliveryMarkerColor.g, Config.DeliveryMarkerColor.b, Config.JobMarkerColor.a, true, true, 2, false, false, false, false)
    end
end

function destroyMarker(coords)
    if playerBusy == false then
        -- DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 0, 0, 200, true, true, 2, false, false, false, false)
        DrawMarker(36, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.CarDespawnMarkerColor.r, Config.CarDespawnMarkerColor.g, Config.CarDespawnMarkerColor.b, Config.CarDespawnMarkerColor.a, true, true, 2, false, false, false, false)
    end
end

--Select McDonalds Job
function openMenu()									
    menuIsOpen = true
    playerIsBusy(true)
    ESX.UI.Menu.CloseAll()										
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'JobList',			
        {
        title    = _U('ListingTitle'),	
        align = 'right',
        elements = {
            {label = _U('Cashier'), value = 'cashier'},		
            {label = _U('Cook'), value = 'cook'},
            {label = _U('Deliv'), value = 'deliv'},
            {label = "Off-Duty", value = 'clean'}
        }
    },
    function(data, menu)
        if data.current.value == 'clean' then
            if Config.EnablePlayerClerk == true then
                if currentJob == 'clean' then
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = "You are already a Cleaner/Off Duty", type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', "You're already off-duty.")
                    end
                else
                    currentJob = 'clean'
                    setJobName(currentJob)
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = "You are now a Cleaner / Off Duty", type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', "You have signed off-duty.")
                    end 
                    onDuty = false
                    isDelivering = false
                    hasOrder = false
                    hasTakenOrder = false
                end
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('CashierError1'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                    exports['mythic_notify']:SendAlert('error', _U('CashierError1'))
                end
            end
        end
        if data.current.value == 'cashier' then
            if Config.EnablePlayerClerk == true then
                if currentJob == 'cashier' then
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('CashierError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', _U('CashierError'))
                    end
                else
                    currentJob = 'cashier'
                    setJobName(currentJob)
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('CashierSuccess'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('success', _U('CashierSuccess'))
                    end 
                    onDuty = true
                    isDelivering = false
                    invMeal = 0
                    invBurger = 0
                    invDrink = 0
                    invFries = 0
                    hasOrder = false
                    hasTakenOrder = false
                end
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('CashierError1'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                    exports['mythic_notify']:SendAlert('error', _U('CashierError1'))
                end
            end
        end
        if data.current.value == 'cook' then
            if Config.EnablePlayerCook == true then
                if currentJob == 'cook' then
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('CookError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', _U('CookError'))
                    end
                else
                    currentJob = 'cook'
                    setJobName(currentJob)
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('CookSuccess'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('success', _U('CookSuccess'))
                    end 
                    onDuty = true
                    isDelivering = false
                    invMeal = 0
                    invBurger = 0
                    invDrink = 0
                    invFries = 0
                    hasOrder = false
                    hasTakenOrder = false
                end 
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                    exports.pNotify:SendNotification({text = _U('CookError1'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                    exports['mythic_notify']:SendAlert('error', _U('CookError1'))
                end 
            end
        end
        if data.current.value == 'deliv' then
            if Config.EnablePlayerDriver == true then
                if currentJob == 'deliv' then
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('DriverError'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', _U('DriverError'))
                    end
                else
                    currentJob = 'deliv'
                    setJobName(currentJob)
                    if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('DriverSuccess'), type = "success", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('success', _U('DriverSuccess'))
                    end 
                    onDuty = true
                    isDelivering = false
                    invMeal = 0
                    invBurger = 0
                    invDrink = 0
                    invFries = 0
                    hasOrder = false
                    hasTakenOrder = false
                end
            else
                if Config.EnablePNotify == true and Config.EnableMythic == false then
                        exports.pNotify:SendNotification({text = _U('DriverError1'), type = "error", timeout = 2000, layout = "centerLeft", queue = "left", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    elseif Config.EnablePNotify == false and Config.EnableMythic == true then
                        exports['mythic_notify']:SendAlert('error', _U('DriverError1'))
                    end 
            end
        end
        menu.close()
	    menuIsOpen = false
        playerIsBusy(false)
    end,
        function(data, menu)
        menu.close()
	    menuIsOpen = false
        playerIsBusy(false)
    end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

function ShowJob(text,colour,coordsx,coordsy,scalex,scaley)
	SetTextFont(7)
	SetTextProportional(7)
	SetTextScale(scalex, scaley)
	local colourr,colourg,colourb,coloura = table.unpack(colour)
	SetTextColour(colourr,colourg,colourb, coloura)
	SetTextDropshadow(0, 0, 0, 0, coloura)
	SetTextEdge(1, 0, 0, 0, coloura)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	EndTextCommandDisplayText(coordsx,coordsy)
end
	--Testing Commands
	-- RegisterCommand("addMeal", function()
	-- 	Citizen.CreateThread(function()
	-- 		TriggerServerEvent("iG_McDonalds:addToMealInvent")
	-- 		TriggerEvent("chat:addMessage", {args={Config.Prefix.."Adding Meal to Kitchen Invetory"}}) 
	-- 	end)
	-- end)

function dPrint(msg)
    print(""..Config.Prefix..""..msg..".")
end