Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
		DisplayAmmoThisFrame(currentWeapon)
	end
end)

RegisterNetEvent('ammunition:useAmmoItem')
AddEventHandler('ammunition:useAmmoItem', function(ammo)
	local playerPed = PlayerPedId()
	local weapon
	local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
	if found then
		for _, v in pairs(ammo.weapons) do
			local weaponHash = GetHashKey(v)
			if currentWeapon == weaponHash then
				weapon = v
				break
			end
		end
		if weapon ~= nil then
			local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
			local newAmmo = pedAmmo + ammo.count
			ClearPedTasks(playerPed)
			local found, maxAmmo = GetMaxAmmo(playerPed, weapon)
			--print(weapon)
			if newAmmo < maxAmmo then
				local hash = GetHashKey(weapon)
				--print(hash)
				ESX.TriggerServerCallback('ig-inventory:getAmmoCount', function(gunInfo)
					currentWepAttachs = gunInfo.attachments
				end, hash)
				ESX.TriggerServerCallback('ig-inventory:doesWeaponHas', function(hasWeaponId)
					if hasWeaponId then
						weaponKey = hasWeaponId
						--print(weaponKey)
					else
						weaponKey = GenerateWeapon()
						--print(weaponKey)
					end
				end, hash)
				while weaponKey == nil do
				Wait(0)
				end
				local wepInfo = { 
					count = newAmmo,
					attach = currentWepAttachs or '{}',
					weapon_id = weaponKey
				}
				--print(wepInfo.count)
				--print(wepInfo.attach)
				--print(wepInfo.weapon_id)
				TriggerServerEvent('ig-inventory:updateAmmoCount', hash, wepInfo)
				SetPedAmmo(playerPed, weapon, newAmmo)
				TriggerServerEvent('ammunition:removeAmmoItem', ammo)
				TaskReloadWeapon(playerPed)
				exports['mythic_notify']:SendAlert('inform', _U('reloaded'))
			else
				exports['mythic_notify']:SendAlert('error', _U('max_ammo'))
			end
		end
	end
end)

