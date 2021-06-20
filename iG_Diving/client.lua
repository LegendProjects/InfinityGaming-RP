ESX = nil
GUI = {}
GUI.Time = 0
local isWearingSuit = false
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

------------- Light Diving suit
RegisterNetEvent('iG_Diving:setlightdiving')
AddEventHandler('iG_Diving:setlightdiving', function()
	if not isWearingSuit then

		TriggerEvent('iG_skinchanger:getSkin', function(skin)

			if skin.sex == 0 then
				exports['mythic_progbar']:Progress({
					name = "divingsuit",
					duration = 10000,
					label = "Putting on Diving suit...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "clothingtie",
						anim = "try_tie_positive_a",
						flags = 49,
					},
				}, function(cancelled)
					if not cancelled then
						TriggerServerEvent('iG_Diving:removeItemLight')
						local clothesSkin = {
							['tshirt_1'] = 151, ['tshirt_2'] = 0,
							['ears_1'] = -1, ['ears_2'] = 0,
							['torso_1'] = 15, ['torso_2'] = 0,
							['decals_1'] = 0,  ['decals_2'] = 0,
							['mask_1'] = 0, ['mask_2'] = 0,
							['arms'] = 15,
							['pants_1'] = 16, ['pants_2'] = 3,
							['shoes_1'] = 67, ['shoes_2'] = 0,
							['helmet_1'] = 11, ['helmet_2'] = 0,
							['bags_1'] = 0, ['bags_2'] = 0,
							['glasses_1'] = 0, ['glasses_2'] = 0,
							['chain_1'] = 0, ['chain_2'] = 0,
							['bproof_1'] = 0,  ['bproof_2'] = 0
						}
						TriggerEvent('iG_skinchanger:loadClothes', skin, clothesSkin)
					end
					local playerPed = GetPlayerPed(-1)
					SetEnableScuba(GetPlayerPed(-1),true)
					SetPedMaxTimeUnderwater(GetPlayerPed(-1), 400.00)
				end)
			end
		end)
	end
end)

RegisterCommand('takeoff', function()
	TriggerEvent('iG_skinchanger:getSkin', function(skin)
		ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin, hasSkin)
			exports['mythic_progbar']:Progress({
				duration = 10000,
				label = "Taking Diving suit off...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "clothingtie",
					anim = "try_tie_positive_a",
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					if hasSkin then
						TriggerEvent('iG_skinchanger:loadSkin', skin)
						TriggerEvent('iG:restoreLoadout')
					end
				end
			end)
		end)
	end)
end)

------------- Diving suit
RegisterNetEvent('iG_Diving:setgooddiving')
AddEventHandler('iG_Diving:setgooddiving', function()
	if not isWearingSuit then

		TriggerEvent('iG_skinchanger:getSkin', function(skin)

			if skin.sex == 0 then
				exports['mythic_progbar']:Progress({
					name = "divingsuit",
					duration = 15000,
					label = "Putting on Diving suit...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "clothingtie",
						anim = "try_tie_positive_a",
						flags = 49,
					},
				}, function(cancelled)
					if not cancelled then
						TriggerServerEvent('iG_Diving:removeItemGood')
						local clothesSkin = {
							['tshirt_1'] = 151, ['tshirt_2'] = 0,
							['ears_1'] = -1, ['ears_2'] = 0,
							['torso_1'] = 247, ['torso_2'] = 0,
							['decals_1'] = 0,  ['decals_2'] = 0,
							['mask_1'] = 0, ['mask_2'] = 0,
							['arms'] = 179,
							['pants_1'] = 94, ['pants_2'] = 0,
							['shoes_1'] = 67, ['shoes_2'] = 0,
							['helmet_1'] = 11, ['helmet_2'] = 0,
							['bags_1'] = 0, ['bags_2'] = 0,
							['glasses_1'] = 0, ['glasses_2'] = 0,
							['chain_1'] = 0, ['chain_2'] = 0,
							['bproof_1'] = 0,  ['bproof_2'] = 0
						}
						TriggerEvent('iG_skinchanger:loadClothes', skin, clothesSkin)
					end
					local playerPed = GetPlayerPed(-1)
					SetEnableScuba(GetPlayerPed(-1),true)
					SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1500.00)
				end)
			end
		end)
	end
end)