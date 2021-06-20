
Citizen.CreateThread(function()
    Ores = {
        {x = -595.92,  y = 2084.52,  z = 131.48, amount = 100, label = "Copper Ore", data = "copper_ore", max = 100, exp = 17, levelRequired = 1},
        {x = -588.76,  y = 2066.6,  z = 131.04, amount = 100, label = "Copper Ore", data = "copper_ore", max = 100, exp = 17, levelRequired = 1},
        {x = 2972.36, y = 2775.44, z = 39.24, amount = 100, label = "Copper Ore", data = "copper_ore", max = 100, exp = 17, levelRequired = 1},
        {x = 2969.08,  y = 2783.92,  z = 39.45, amount = 100, label = "Copper Ore", data = "copper_ore", max = 100, exp = 17, levelRequired = 1},


        {x = -587.08,  y = 2044.08,  z = 129.64, amount = 100, label = "Tin Ore", data = "tin_ore", max = 100, exp = 17, levelRequired = 1},
        {x = -577.32,  y = 2032.92,  z = 128.4, amount = 100, label = "Tin Ore", data = "tin_ore", max = 100, exp = 17, levelRequired = 1},
        {x = 2968.64, y = 2775.64, z = 39.48, amount = 100, label = "Tin Ore", data = "tin_ore", max = 100, exp = 17, levelRequired = 1},
        {x = 2962.42,  y = 2790.68,  z = 40.04, amount = 100, label = "Tin Ore", data = "tin_ore", max = 100, exp = 17, levelRequired = 1},


        {x = 2952.22, y = 2780.16, z = 40.4, amount = 50, label = "Iron Ore", data = "iron_ore", max = 50, exp = 35, levelRequired = 15},
        {x = 2943.19, y = 2784.1, z = 39.88, amount = 50, label = "Iron Ore", data = "iron_ore", max = 50, exp = 35, levelRequired = 15},
        {x = 2999.16,  y = 2757.56,  z = 43.08, amount = 50, label = "Iron Ore", data = "iron_ore", max = 50, exp = 35, levelRequired = 15},
        {x = -563.56,  y = 2013.68,  z = 127.32, amount = 50, label = "Iron Ore", data = "iron_ore", max = 50, exp = 35, levelRequired = 15},
        {x = -549.48,  y = 1996.48,  z = 127.04, amount = 50, label = "Iron Ore", data = "iron_ore", max = 50, exp = 35, levelRequired = 15},

        {x = 2936.2, y = 2791.66, z = 40.38, amount = 35, label = "Silver Ore", data = "silver_ore", max = 35, exp = 40, levelRequired = 20},
        {x = 2946.06,  y = 2792.32,  z = 40.42, amount = 35, label = "Silver Ore", data = "silver_ore", max = 35, exp = 40, levelRequired = 20},
        {x = -539.72,  y = 1958.24,  z = 126.56, amount = 35, label = "Silver Ore", data = "silver_ore", max = 35, exp = 40, levelRequired = 20},
        {x = -536.16,  y = 1928.96,  z = 124.72, amount = 35, label = "Silver Ore", data = "silver_ore", max = 35, exp = 40, levelRequired = 20},

        {x = 2928.98, y = 2801.49, z = 41.7, amount = 30, label = "Coal Ore", data = "coal_ore", max = 30, exp = 50, levelRequired = 30},
        {x = 2940.97, y = 2801.28, z = 41.16, amount = 30, label = "Coal Ore", data = "coal_ore", max = 30, exp = 50, levelRequired = 30},
        {x = -542.72,  y = 1901.16,  z = 123.04, amount = 30, label = "Coal Ore", data = "coal_ore", max = 30, exp = 50, levelRequired = 30},
        {x = -555.0,  y = 1890.28,  z = 123.0, amount = 30, label = "Coal Ore", data = "coal_ore", max = 30, exp = 50, levelRequired = 30},

        {x = 2941.62, y = 2812.31, z = 42.58, amount = 15, label = "Gold Ore", data = "gold_ore", max = 15, exp = 65, levelRequired = 40},
        {x = 2972.29, y = 2792.97, z = 40.78, amount = 15, label = "Gold Ore", data = "gold_ore", max = 15, exp = 65, levelRequired = 40},
        {x = -460.36,  y = 2050.48,  z = 122.44, amount = 15, label = "Gold Ore", data = "gold_ore", max = 15, exp = 65, levelRequired = 40},
        {x = -522.44,  y = 1895.64,  z = 122.4, amount = 15, label = "Gold Ore", data = "gold_ore", max = 15, exp = 65, levelRequired = 40},

        {x = 2921.44, y = 2799.32, z = 42.16, amount = 15, label = "Mithril Ore", data = "mithril_ore", max = 15, exp = 80, levelRequired = 55},
        {x = 2938.52, y = 2812.64, z = 43.4, amount = 15, label = "Mithril Ore", data = "mithril_ore", max = 15, exp = 80, levelRequired = 55},
        {x = -426.12,  y = 2065.44,  z = 120.24, amount = 15, label = "Mithril Ore", data = "mithril_ore", max = 15, exp = 80, levelRequired = 55},

        {x = 2951.32, y = 2816.32, z = 42.92, amount = 2, label = "Adamantite Ore", data = "adamantite_ore", max = 2, exp = 95, levelRequired = 70},
        {x = -485.12,  y = 1896.08,  z = 119.92, amount = 2, label = "Adamantite Ore", data = "adamantite_ore", max = 2, exp = 95, levelRequired = 70},

        {x = 2971.96, y = 2798.68, z = 42.16, amount = 1, label = "Runite Ore", data = "runite_ore", max = 1, exp = 125, levelRequired = 85},
        {x = -473.64,  y = 2087.84,  z = 120.04, amount = 1, label = "Runite Ore", data = "runite_ore", max = 1, exp = 125, levelRequired = 85},

        {x = -449.68,  y = 2030.84,  z = 123.52, amount = 1, label = "Gem Rock", data = "gem_stone", max = 5, exp = 65, levelRequired = 40},
        {x = -469.72,  y = 2082.4,  z = 120.28, amount = 1, label = "Gem Rock", data = "gem_stone", max = 5, exp = 65, levelRequired = 40},
    }
end)
---------------------------------------------------
------- ESX Intialisation
---------------------------------------------------
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData() 

    if ESX.IsPlayerLoaded() then
        playerLoaded = true
        Citizen.Wait(5000)
        -- ESX.TriggerServerCallback('vy_Base:getPlayerSkills', function(data)
        --     mining_Level = data.mining_Level
        -- end)
    end
end)
---------------------------------------------------
------- Get Player Thread
---------------------------------------------------
Citizen.CreateThread(function() -- 500 MS Loop
	while true do
		playerPed 			= GetPlayerPed(-1)
		playerPedId 		= PlayerPedId()
        playerCoords        = GetEntityCoords(playerPed)
        isInVehicle         = IsPedInAnyVehicle(playerPedId, true)
		Citizen.Wait(1500)
	end
end)
---------------------------------------------------
------- Entity Location Thread
---------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not isInVehicle then 
            for i=1, #Ores, 1 do
                if mining_Level ~= nil then
                    local dist = #(playerCoords - vector3(Ores[i].x, Ores[i].y, Ores[i].z))
                    if dist <= 75 then
                        letSleep = false
                        local levelColour = ''
                        local levelScale = (mining_Level/Ores[i].levelRequired)*100 
                        local oreColour = ''
                        local oreScale = (Ores[i].amount/Ores[i].max)*100 

                        if levelScale <= 50.99 then
                            levelColour = '~r~'
                        elseif levelScale >= 51.0 and levelScale <= 74.99 then
                            levelColour = '~o~'
                        elseif levelScale > 75 then 
                            levelColour = '~g~'
                        end 
                        
                        if oreScale >= 66 then
                            oreColour = '~g~'
                        elseif oreScale >= 33 and oreScale <= 65 then
                            oreColour = '~o~'
                        elseif oreScale <= 32 then 
                            oreColour = '~r~'
                        end 

                        if dist <= 15 then 
                            ESX.Game.Utils.DrawText3D(vector3(Ores[i].x, Ores[i].y, Ores[i].z + 0.2), "~b~"..Ores[i].label.."~w~ ["..oreColour..Ores[i].amount.."~w~/"..oreColour..Ores[i].max.."~w~]<br>~h~"..levelColour.."(Level: " .. Ores[i].levelRequired .. ")", 0.6)
                            if dist <= 2.5 and mining_Level >= Ores[i].levelRequired then
                                if GetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_BATTLEAXE"), true) then

                                   if cooldown >= 2 then 
                                        displayText = cooldownText .. cooldown .. ' seconds..'
                                    elseif cooldown == 1 then
                                        displayText = cooldownText .. cooldown .. ' second..'
                                    else
                                        displayText = 'Press [~b~MOUSE1~w~] to mine the ore.'
                                    end
                                    
                                    ESX.Game.Utils.DrawText3D(Ores[i], displayText, 0.4)

                                    if IsControlJustReleased(1, 24) and not isBusy and isPossible and not letSleep then
                                        ore = i
                                        canMineOre(Ores[i].data)
                                        Citizen.Wait(1450)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            letSleep = true
        end

        if letSleep then 
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if not isPossible and cooldown > 0 then
            cooldown = cooldown - 1
            Citizen.Wait(1000)
        elseif not isPossible and cooldown == 0 then
            isBusy = false
            isPossible = true
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i=1, #Ores, 1 do
            if Ores[i].amount < Ores[i].max then
                Ores[i].amount = Ores[i].amount + 1
            end
        end
        Citizen.Wait(12500)
    end
end)