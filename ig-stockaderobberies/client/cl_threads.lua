
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

    if Config.Debug then 
        if ESX.IsPlayerLoaded() then
            playerLoaded = true
			InitialiseTarget()
        end
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)
		if createBag and DoesEntityExist(nveh) then
			bagMoney_hash = GetHashKey('prop_money_bag_01')
			loadModel(bagMoney_hash)

			local putIN = GetOffsetFromEntityInWorldCoords(nveh,0.0,0.0,-5.0)
	
			bagMoney = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney,nveh,0.0,-0.45,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney, false, true)

			bagMoney2 = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney2,nveh,0.0,0.0,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney2, false, true)

			bagMoney3 = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney3,nveh,0.0,0.45,-3.0,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney3, false, true)

			bagMoney4 = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney4,nveh,0.0,-0.45,-2.9,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney4, false, true)

			bagMoney5 = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney5,nveh,0.0,0.0,-2.9,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney5, false, true)

			bagMoney6 = CreateObject(GetHashKey("prop_money_bag_01"),putIN.x,putIN.y,putIN.z,true,true,true)
			AttachEntityToEntity(bagMoney6,nveh,0.0,0.45,-2.9,0.48,0.0,0.0,0.0,false,false,true,false,2,true)
			SetEntityCollision(bagMoney6, false, true)

			createBag = false
		end
	end
end)


Citizen.CreateThread(function()
	while true do

		local idle = 500
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(nveh))
		local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(nveh,0.0,-4.0,0.5))
		local coords = GetEntityCoords(ped)
		local dst = GetDistanceBetweenCoords(coords, x,y,z, true)

		if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and IsPedDeadOrDying(pveh03) and IsPedDeadOrDying(pveh04) and not DoesEntityExist(c4) then
			if not explodiu then
				SetVehicleDoorShut(nveh,2,true)
				SetVehicleDoorShut(nveh,3,true)
			end

			if dst <= 10 then
				idle = 4

				if dst <= 5.0 and GetClosestVehicle(x,y,z, 4, 1747439474, 16384) and hackeado and not plantando then
					drawTxt("PRESS [~b~E~w~] PLANT THE C4 ON THE VEHICLE.",4,0.5,0.87,0.50,255,255,255,180)

					if IsControlJustReleased(0,38) then
						if exports['ig-inventory']:HasItem('mini_c4', 1)  then
							exports['vy_Base_v2']:AddSkillExperience('thieving', 175)
							TaskTurnPedToFaceCoord(GetPlayerPed(-1), x,y,z, 500)
							SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
							TriggerServerEvent('ig-stockaderobberies:plantedExplosives')
							plantando = true
							FreezeEntityPosition(GetPlayerPed(-1), true)
							local c4_hash = GetHashKey("prop_bomb_01")
							local bag_hash = GetHashKey('p_ld_heist_bag_s_pro_o')
							loadModel(c4_hash)
							Wait(10)
							loadModel(bag_hash)
							Wait(10)
							local object = GetClosestObjectOfType(x,y,z,0.7,GetHashKey("door_dside_r"),0,0,0)
							local a2,b2,c2 = table.unpack(GetEntityCoords(object))
							c4 = CreateObject(c4_hash, (a2+b2+c2-20), true, true)
							local bag = CreateObject(bag_hash, coords-20, true, false)
							SetEntityAsMissionEntity(c4, true, true)
							SetEntityAsMissionEntity(bag, true, true)
							local boneIndexf1 = GetPedBoneIndex(PlayerPedId(), 28422)
							local bagIndex1 = GetPedBoneIndex(PlayerPedId(), 57005)
							PlayAnimation(GetPlayerPed(-1), 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 5000)
							Citizen.Wait(500)
							SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
							AttachEntityToEntity(c4, PlayerPedId(), boneIndexf1, 0.0,0.0,-0.18,0.0,0.0,-90.0, 0, 1, 1, 0, 1, 1, 1)
							AttachEntityToEntity(bag, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							Wait(1700)
							DetachEntity(bag, 1, 1)
							FreezeEntityPosition(bag, true)
							Wait(1500)
							DetachEntity(c4, 1, 1)
							FreezeEntityPosition(c4, true)
							
							Wait(1000)
							FreezeEntityPosition(bag, false)
							AttachEntityToEntity(bag, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							Wait(150)
							ESX.Game.DeleteObject(bag)
							SetPedComponentVariation(PlayerPedId(), 5, 46, 0, 0)
							FreezeEntityPosition(GetPlayerPed(-1), false)
							ClearPedTasks(GetPlayerPed(-1))
							-- vRP._stopAnim(false)
							Wait(100)
							local a1,b1,c1 = table.unpack(GetEntityCoords(c4))
							TriggerEvent('iG_Alert:stockadeRobbery')
							local particleDictionary = "scr_adversary"
							local particleName = "scr_emp_prop_light"		
							RequestNamedPtfxAsset(particleDictionary)

							while not HasNamedPtfxAssetLoaded(particleDictionary) do
								Citizen.Wait(0)
							end					 
							beepSound = GetSoundId()

							PlaySoundFromEntity(beepSound, "Timer_10s", c4, "DLC_HALLOWEEN_FVJ_Sounds", 1, 0)
									
							SetPtfxAssetNextCall(particleDictionary)
							effect = StartParticleFxLoopedOnEntity(particleName, c4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.20, 0, 0, 0)
							
							SetTimeout(10000,function()
								explodiu = true
								FreezeEntityPosition(c4, false)
								ESX.Game.DeleteObject(c4)
								SetVehicleDoorOpen(nveh,2,0,0)
								SetVehicleDoorOpen(nveh,3,0,0)
								NetworkExplodeVehicle(nveh,1,1,1)
								StopParticleFxLooped(effect, 0)
								StopSound(beepSound)
								ReleaseSoundId(beepSound)
								DetachEntity(bagMoney, false, false)
								SetEntityCollision(bagMoney, true, true)
								FreezeEntityPosition(bagMoney,false)

								DetachEntity(bagMoney2, false, false)
								SetEntityCollision(bagMoney2, true, true)
								FreezeEntityPosition(bagMoney2,false)

								DetachEntity(bagMoney3, false, false)
								SetEntityCollision(bagMoney3, true, true)
								FreezeEntityPosition(bagMoney3,false)

								DetachEntity(bagMoney4, false, false)
								SetEntityCollision(bagMoney4, true, true)
								FreezeEntityPosition(bagMoney4,false)

								DetachEntity(bagMoney5, false, false)
								SetEntityCollision(bagMoney5, true, true)
								FreezeEntityPosition(bagMoney5,false)

								DetachEntity(bagMoney6, false, false)
								SetEntityCollision(bagMoney6, true, true)
								FreezeEntityPosition(bagMoney6,false)

								RemoveBlip(blip)
								pveh01 = nil
								pveh02 = nil
								pveh03 = nil
								pveh04 = nil
								plantando = false
								hackeado = false
								final = true
								quantidade = 6
							end)
						else		
							exports['mythic_notify']:SendAlert('error', 'Error: Missing item required. (1x Mini C4 Charge)')	
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		idle = 500
		local ped = PlayerPedId()
		local myCoords = GetEntityCoords(PlayerPedId())
		local nmbag = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.25, GetHashKey('prop_money_bag_01'), false, false)
		local mbagCoords = GetEntityCoords(nmbag)
		local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, mbagCoords.x,mbagCoords.y,mbagCoords.z, true)
			
		if distance <= 4 then
			idle = 4
		end

		if distance <= 1.7 and final then
			ESX.Game.Utils.DrawText3D(vector3(mbagCoords.x,mbagCoords.y,mbagCoords.z+0.5), "Press [~b~E~w~] to pick-up bag.", 0.4)
				if IsControlJustPressed(0,38) then
					final = false
					if quantidade == 6 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(1300)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney)
						bagMoney = nil
						quantidade = 5
						final = true
					end

					if quantidade == 5 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(1300)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney2)
						bagMoney2 = nil
						quantidade = 4
						final = true
					end

					if quantidade == 4 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(1300)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney3)
						bagMoney3 = nil
						quantidade = 3
						final = true
					end

					if quantidade == 3 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(1300)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney4)
						bagMoney4 = nil
						quantidade = 2
						final = true
					end

					if quantidade == 2 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(1300)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney5)
						bagMoney5 = nil
						quantidade = 1
						final = true
					end

					if quantidade == 1 then
						PlayAnimation(GetPlayerPed(-1), 'pickup_object', 'pickup_low', 1300)
						Wait(2000)
						TriggerServerEvent('ig-stockaderobberies:lootBag')
						exports['vy_Base_v2']:AddSkillExperience('thieving', 25)
						ESX.Game.DeleteObject(bagMoney6)
						bagMoney6 = nil
						quantidade = 0
						final = false
					end

				end
			end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	  -- Citizen.Wait(1000)
    local s
	local s2
   while true do
		--print("hey")
        Citizen.Wait(0)
		if MISSIONSHOWRESULT then
			
			if s == nil then 
			

				if string.len(MISSIONSHOWTEXT) > 0 and MISSIONSHOWTEXT ~="WASTED" then
				-- print("hey")
					-- local starttime= GetGameTimer()
					-- while not MISSIONSHAREMONEYAMOUNT do
					-- 	Wait(1)
						
					-- 	if GetGameTimer() - starttime >= 1000 then
					-- 		--print("break")
					-- 		break
					-- 	end
						
					-- end
					--MISSIONSHOWMESSAGE = MISSIONSHOWMESSAGE .. MISSIONSHAREMONEYAMOUNT	
					--MISSIONSHAREMONEYAMOUNT=nil
					-- Wait(1000)
					MISSIONSHOWMESSAGE = MISSIONSHOWMESSAGE
					-- MISSIONSHAREMONEYAMOUNT=nil
				end
				
					
				
				
				--print("hey3")
				s = Scaleform.Request("mp_big_message_freemode")
				s:CallScaleFunction("normal","SHOW_SHARD_WASTED_MP_MESSAGE", MISSIONSHOWTEXT, MISSIONSHOWMESSAGE, 5)	
				
				--USING THIS FOR COOL SOUNDS ONLY ATM: 
				s2 = Scaleform.Request("mp_celebration")
				s2:CallScaleFunction("normal","CLEANUP","MR")
				s2:CallScaleFunction("normal","CREATE_STAT_WALL","MR","HUD_COLOR_BLACK")
				s2:CallScaleFunction("normal","SET_PAUSE_DURATION",5)
				s2:CallScaleFunction("normal","ADD_MISSION_RESULT_TO_WALL", "MR","TEST MISSION","Mission Passed","DID WELL",
				true,true,true,0,"HUD_COLOR_GREEN")
				s2:CallScaleFunction("normal","ADD_BACKGROUND_TO_WALL","MR",75,1)
				s2:CallScaleFunction("normal","SHOW_STAT_WALL","MR")
				
			end
			s:Draw2D()
			s2:Draw2D()
			if not BLDIDTIMEOUT then
				
				BLDIDTIMEOUT = true
				SetTimeout(5000,function()MISSIONSHOWRESULT = false;end)
			end
		else
			if s then 
				s:Dispose()
				s=nil
				s2:Dispose()
				s2=nil
			end
		
		end
   end
end)