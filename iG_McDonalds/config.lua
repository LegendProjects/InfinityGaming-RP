Config = {}
--			General
Config.Locale				= 'en'

--You can toggle these to false to turn off all error/hint related Notifications, However having both as true will show also show no notifications
Config.EnablePNotify		= false		--This uses pNotify as the Notify System
Config.EnableMythic			= true		--This uses Mythic Notify as the Notify System

Config.EnableESXNotif		= true		--This uses ESX Notifications for Payouts (if you disable, no replacement is available so you will not be notified when you get paid)

--			Settings					
--			  Jobs
Config.EnablePlayerJobs		= true		--Enables Jobs for Players to use. *Disabling hides the job selector, meaning no player job can be selected
Config.EnablePlayerCook		= true		--Cook gets drinks, makes burgers and fries and gives to clerk both for NPC orders and Player orders.
Config.EnablePlayerClerk	= true		--Clerk receives orders, gives to cook, receives orders from cook, and gives to customer. 				
Config.EnablePlayerDriver	= true		--Driver delivers orders marked for delivery.

Config.EnableNPCOrders		= true		--If False only players can RP Orders and Pay with F6 billing, if true gives RP/'Fake' NPC orders for cashiers and delivery drivers to undertake

Config.SpawnPeds			= true		--This Spawns Peds at the tables for the cashier to give the order to (only aesthetics)

Config.NPCDespawnTime		= 3			--Seconds until NPC gets deleted **DONT MAKE IT TO LONG AS IT HANGS THE CASHIER AND WONT LET THEM DO ANYTHING**

Config.NPCNames	= {
	--Female Peds
	[1] = {name = 'a_f_o_salton_01'},
	[2] = {name = 'a_f_y_eastsa_03'},
	[3] = {name = 'a_f_y_tourist_02'},
	[4] = {name = 'a_f_y_bevhills_02'},
	[5] = {name = 'a_f_m_soucentmc_01'},
	--Male Peds
	[6] = {name = 'a_m_m_bevhills_01'},
	[7] = {name = 'a_m_m_afriamer_01'},
	[8] = {name = 'a_m_m_genfat_01'},
	[9] = {name = 'a_m_m_hillbilly_01'},
	[10] = {name = 'a_m_m_trampbeac_01'}
}

Config.CookJobPay			= 50		--The amount the cook is paid per meal made.
Config.CashJobPay			= 40		--The amount the cashier is paid per meal delivered to table.
Config.DelivJobPay			= 75		--The amount the delivery driver is paid per delivery.

Config.PayDeposit			= true		--If true the below cost will take effect when taking out a work vehicle
Config.VanDepositAmount		= 300		--The amount that it cost to take out the van work vehicle
Config.BikeDepositAmount	= 150		--The amount that it cost to take out the bike work vehicle
Config.CarToSpawn			= 'ruiner'
Config.BikeToSpawn			= 'faggio'

Config.EnableMoreWorkMorePay	= false	--Each Customer/Meal you serve, that number is used as a multiplier **Cashier  ie 10 customers served = 40 x 10 = 400** CAUTION This has no limit and can keep rising until the player logs or server restarts

--			Blips
Config.EnableBlips			= true
--		McDonalds Blip	
Config.blipLocationM		= vector2(273.2, -966.08)	--Location
Config.blipIDM				= 124						--ID
Config.blipColorM			= 0							--Color
Config.blipScaleM			= 0.8						--Size
--	  McDonalds Job Blip	
Config.EnableJobBlip		= false						--true means show to all players, false only shows to players who have Mcdonalds Job Title and off alltogether if EnableBlips = false.

Config.blipLocationJ		= vector2(273.2, -966.08)	--Location
Config.blipIDJ				= 500						--ID
Config.blipColorJ			= 69						--Color
Config.blipScaleJ			= 0.65						--Size

Config.JobMarkerColor			= {r = 255, g = 255, b = 50, a = 75}	--Job Marker Color Default Cyan
Config.DeliveryMarkerColor		= {r = 255, g = 255, b = 50, a = 75}	--Marker Color Default Green
Config.CarDespawnMarkerColor	= {r = 255, g = 50, b = 50, a = 75}
Config.JobMarkerDistance		= 0.75									--The distance from the center of the marker to enable menu/text
Config.JobExtendedDistance		= 2.25
--		Cook Times
Config.CookDrinkTime		= 4 * 1000		--The time that it takes to make a drink.
Config.CookFriesTime		= 4 * 1000		--The time that it takes to make fries.
Config.CookBurgerTime		= 12 * 1000		--The time that it takes to make a burger.
Config.CookPrepareTime		= 12 * 1000		--The time that it takes to prepare the meal.
--	   Cashier Times
Config.CashOrderTime		= 10 * 1000		--The time that it takes to take an order.
Config.CashMealTime			= 15 * 1000		--The time that it takes to get a prepared meal. (Both Delivery Driver and Cashier)
Config.CashDelivTime		= 5 * 1000		--The time that it takes to give the customer the meal. (Both Delivery Driver and Cashier)

Config.EnableDowntownDeliveries		= true
Config.EnableBeachSideDeliveries	= false	--Coming Soon
Config.EnableHighEndDeliveries		= false	--Coming Soon

-- Player Fines for Consuming Items ECT

Config.PlayerFines = {
	ConsumedDrink = {
		Description = "You were fined for consuming work property without paying! Fine Amount: ",
		Amount = 500
	},
	ConsumedFries = {
		Description = "You were fined for consuming work property without paying! Fine Amount: ",
		Amount = 500
	},
	ConsumedBurger = {
		Description = "You were fined for consuming work property without paying! Fine Amount: ",
		Amount = 500
	},
	ConsumedMeal = {
		Description = "You were fined for consuming work property without paying! Fine Amount: ",
		Amount = 2000
	}
}

-- Player Bad Points is a flag system that if a worker breaks too many rules (Consuming Items, attacking customers ect) after gaining the below set amount of 'bad points' they will be fired as a McDonalds Worker
-- Enable Player Bad Points System - true/false
Config.EnablePlayerBadPoints = true
-- Points before the player gets Fired/Banned
Config.BadPointLimit = 3
-- true = Player will be permanatly banned (until server restart) - false = Player will be banned/fired for a limited time
Config.BadEggPermOrTime = false
-- Time (In Minutes) that the player is Banned/Fired from McDonalds
Config.BadEggTimer = 10

--	   List of Coords

Config.JobMenuCoords		= vector3(275.64, -973.64, 29.36)

Config.CookBurgerCoords		= vector3(281.16, -980.16, 29.36) -- Position that the Marker is Displayed
Config.PlrCookBurgerCoords	= {x = 281.16, y = -979.56, z = 28.46, h = 175.4} -- Position that the player gets moved to

Config.CookFriesCoords		= vector3(279.6, -978.56, 29.36)
Config.PlrCookFriesCoords	= {x = 279.6, y = -978.56, z = 28.46, h = 356.32}

Config.CookDrinkCoords		= vector3(283.2, -978.56, 29.36)
Config.PlrCookDrinkCoords	= {x = 283.2, y = -978.56, z = 28.46, h = 266.52}

Config.CookPrepareCoords	= vector3(280.76, -976.48, 29.36)
Config.PlrCookPrepCoords	= {x = 281.36, y = -976.48, z = 28.46, h = 86.8}

Config.CashTakeOrder		= vector3(187.96,-904.47,30.6)
Config.PlrCashTOCoords		= {x = 187.96, y = -904.47, z = 28.46, h = 146.41}

Config.CashTakeOrder1		= vector3(279.0, -973.32, 29.36)
Config.PlrCashTO1Coords		= {x = 279.0, y = -973.32, z = 28.46, h = 0.32}

Config.CashTakeOrder2		= vector3(280.4, -973.32, 29.36)
Config.PlrCashTO2Coords		= {x = 280.4, y = -973.32, z = 28.46, h = 0.32}

Config.CashCollectMeal		= vector3(279.56, -974.44, 29.36) --Cashier and Delivery Meal Pickup Location
Config.PlrCashCollectCoords	= {x = 279.56, y = -974.44, z = 28.46, h = 183.12}

Config.DeliveryCarSpawn			= {x = 340.24, y = -950.88, z = 29.44,h = 69.3}
Config.DeliveryCarSpawnMarker	= vector3(333.88, -951.56, 29.6)
Config.DeliveryCarDespawn		= vector3(340.24, -950.88, 29.44)

--MINI ADVANCED MODE
Config.EnableMealInventory		= true --This means the cook WILL HAVE TO provide meals for the cashier and delivery driver to collect, if no cook is making meals, the cashier and delivery driver cannot collect

Config.EnableStuckCommand		= true --This will unfreeze the player if they happen to get stuck using /mcstuck
Config.EnableCookCommand		= true --This will set you as a cook using /mccook
Config.EnableCashCommand		= true --This will set you as a cashier using /mccash
Config.EnableDelivCommand		= true --This will set you as a delivery driver using /mcdeliv

Config.TrayName			= 'prop_food_bs_tray_01'
Config.MealName			= 'ng_proc_food_bag01a'
Config.DrinkName		= 'prop_food_bs_juice01'
Config.CashTrayName		= 'prop_food_bs_tray_02'
Config.CashName			= 'prop_cash_pile_02'
Config.Cash1Name		= 'prop_cash_note_01'

Config.BurgerNames		= {a = 'prop_cs_burger_01', b = 'prop_food_bs_burg1', c = 'prop_food_bs_burg3'}
Config.FriesName		= 'prop_food_bs_chips'

--Prop Positons

Config.TrayPosition			= {x = 178.833, y = -909.116, z = 31.597}
Config.TrayDonePosition		= {x = 180.715, y = -909.724, z = 31.597}
Config.BagPosition			= {x = 178.928, y = -909.147, z = 31.596}
Config.BagDonePosition		= {x = 180.810, y = -909.754, z = 31.596}
Config.DrinkPosition		= {x = 178.728, y = -909.031, z = 31.602}
Config.DrinkDonePosition	= {x = 180.609, y = -909.639, z = 31.602}

Config.minDistance = 1
--	List of Cashier Deliver Points
Config.cashDeliveryPoints = {
	[1] = {x = 275.92, y = -965.28, z = 28.36},
	[2] = {x = 271.32, y = -968.52, z = 29.36},
	[3] = {x = 283.68, y = -970.88, z = 29.36},
	[4] = {x = 280.24, y = -965.32, z = 29.4}
}

--Downtown Delivery Locations
Config.driveDeliveryPoints = {
	[1] = {x = 288.96, y = -1792.33, z = 28},
	[2] = {x = 299.79, y = -1784.21, z = 28},
	[3] = {x = 304.44, y = -1775.45, z = 29},
	[4] = {x = 332.85, y = -1741.05, z = 28},
	[5] = {x = 405.67, y = -1751.25, z = 28.71},
	[6] = {x = 431.22, y = -1725.63, z = 28},
	[7] = {x = 443.23, y = -1707.17, z = 28.1},
	[8] = {x = 412.74, y = -1855.71, z = 27.5},
	[9] = {x = 385.26, y = -1881.84, z = 26},
	[10] = {x = 368.55, y = -1896.02, z = 25},
	[11] = {x = 324.29, y = -1937.81, z = 25},
	[12] = {x = 295.98, y = -1972.00, z = 23},
	[13] = {x = 279.37, y = -1993.46, z = 20.2},
	[14] = {x = 256.55, y = -2023.67, z = 19.20},
	[15] = {x = 286.91, y = -2034.94, z = 19.77},
	[16] = {x = 312.62, y = -2053.89, z = 21},
	[17] = {x = 332.56, y = -2070.61, z = 21},
	[18] = {x = 302.63, y = -2080.1, z = 17.7},
	[19] = {x = 321.55, y = -2099.77, z = 18.2}
}

Config.Prefix = "" -- Prefix that gets added to any errors that get printed