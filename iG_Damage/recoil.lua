local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}
local HASH_FIRSTPERSONAIMING = GetHashKey("FirstPersonAiming")
local HASH_DEFAULT = GetHashKey("Default")
--==========================================================================================
--==                            	WEAPON INITIALISATION            	                  ==
--==========================================================================================
-- PISTOLS
local WeaponInfo = {
	{ weaponHash = `WEAPON_STUNGUN`, weaponDmg = 0.0, weaponRecoil = 0.6, weaponShake = 0.01 },
	{ weaponHash = `WEAPON_FLAREGUN`, weaponDmg = 0.0, weaponRecoil = 0.6, weaponShake = 0.01 },
	{ weaponHash = `WEAPON_SNSPISTOL`, weaponDmg = 0.32, weaponRecoil = 0.6, weaponShake = 0.02 },
	{ weaponHash = `WEAPON_SNSPISTOL_MK2`, weaponDmg = 0.36, weaponRecoil = 0.6, weaponShake = 0.025 },
	{ weaponHash = `WEAPON_PISTOL`, weaponDmg = 0.42, weaponRecoil = 0.6, weaponShake = 0.025 },
	{ weaponHash = `WEAPON_PISTOL_MK2`, weaponDmg = 0.52, weaponRecoil = 0.6, weaponShake = 0.03 },
	{ weaponHash = `WEAPON_APPISTOL`, weaponDmg = 0.4, weaponRecoil = 0.9, weaponShake = 0.085 },
	{ weaponHash = `WEAPON_COMBATPISTOL`, weaponDmg = 0.42, weaponRecoil = 0.6, weaponShake = 0.03 },
	{ weaponHash = `WEAPON_PISTOL50`, weaponDmg = 0.55, weaponRecoil = 0.6, weaponShake = 0.05 },
	{ weaponHash = `WEAPON_HEAVYPISTOL`, weaponDmg = 0.44, weaponRecoil = 0.6, weaponShake = 0.03 },
	{ weaponHash = `WEAPON_VINTAGEPISTOL`, weaponDmg = 0.32, weaponRecoil = 0.6, weaponShake = 0.025 },
	{ weaponHash = `WEAPON_MARKSMANPISTOL`, weaponDmg = 0.25, weaponRecoil = 0.6, weaponShake = 0.03 },
	{ weaponHash = `WEAPON_REVOLVER`, weaponDmg = 0.36, weaponRecoil = 0.6, weaponShake = 0.045 },
	{ weaponHash = `WEAPON_REVOLVER_MK2`, weaponDmg = 0.36, weaponRecoil = 0.6, weaponShake = 0.055 },
	{ weaponHash = `WEAPON_DOUBLEACTION`, weaponDmg = 0.35, weaponRecoil = 0.6, weaponShake = 0.025 },
	-- SMGS
	{ weaponHash = `WEAPON_MICROSMG`, weaponDmg = 0.6, weaponRecoil = 0.5, weaponShake = 0.035 },
	{ weaponHash = `WEAPON_COMBATPDW`, weaponDmg = 0.45, weaponRecoil = 0.1, weaponShake = 0.045 },
	{ weaponHash = `WEAPON_SMG`, weaponDmg = 0.44, weaponRecoil = 0.7, weaponShake = 0.045 },
	{ weaponHash = `WEAPON_SMG_MK2`, weaponDmg = 0.5, weaponRecoil = 0.1, weaponShake = 0.055 },
	{ weaponHash = `WEAPON_ASSAULTSMG`, weaponDmg = 0.6, weaponRecoil = 0.1, weaponShake = 0.050 },
	{ weaponHash = `WEAPON_MACHINEPISTOL`, weaponDmg = 0.45, weaponRecoil = 0.5, weaponShake = 0.035 },
	{ weaponHash = `WEAPON_MINISMG`, weaponDmg = 0.6, weaponRecoil = 0.5, weaponShake = 0.035 },
	-- MACHINE GUNS
	{ weaponHash = `WEAPON_MG`, weaponDmg = 0.78, weaponRecoil = 0.2, weaponShake = 0.07 },
	{ weaponHash = `WEAPON_COMBATMG`, weaponDmg = 0.78, weaponRecoil = 0.2, weaponShake = 0.08 },
	{ weaponHash = `WEAPON_COMBATMG_MK2`, weaponDmg = 0.8, weaponRecoil = 0.2, weaponShake = 0.085 },
	-- RIFLES
	{ weaponHash = `WEAPON_ASSAULTRIFLE`, weaponDmg = 0.78, weaponRecoil = 0.2, weaponShake = 0.07 },
	{ weaponHash = `WEAPON_ASSAULTRIFLE_MK2`, weaponDmg = 0.7, weaponRecoil = 0.2, weaponShake = 0.075 },
	{ weaponHash = `WEAPON_CARBINERIFLE`, weaponDmg = 0.68, weaponRecoil = 0.1, weaponShake = 0.06 },
	{ weaponHash = `WEAPON_CARBINERIFLE_MK2`, weaponDmg = 0.78, weaponRecoil = 0.1, weaponShake = 0.065 },
	{ weaponHash = `WEAPON_ADVANCEDRIFLE`, weaponDmg = 0.78, weaponRecoil = 0.0, weaponShake = 0.06 },
	{ weaponHash = `WEAPON_GUSENBERG`, weaponDmg = 0.55, weaponRecoil = 0.1, weaponShake = 0.05 },
	{ weaponHash = `WEAPON_SPECIALCARBINE`, weaponDmg = 0.7, weaponRecoil = 0.2, weaponShake = 0.06 },
	{ weaponHash = `WEAPON_SPECIALCARBINE_MK2`, weaponDmg = 0.78, weaponRecoil = 0.25, weaponShake = 0.075 },
	{ weaponHash = `WEAPON_BULLPUPRIFLE`, weaponDmg = 0.45, weaponRecoil = 0.2, weaponShake = 0.05 },
	{ weaponHash = `WEAPON_BULLPUPRIFLE_MK2`, weaponDmg = 0.58, weaponRecoil = 0.25, weaponShake = 0.065 },
	{ weaponHash = `WEAPON_COMPACTRIFLE`, weaponDmg = 0.58, weaponRecoil = 0.3, weaponShake = 0.05 },
	-- SHOTGUNS
	{ weaponHash = `WEAPON_PUMPSHOTGUN`, weaponDmg = 0.4, weaponRecoil = 0.4, weaponShake = 0.07 },
	{ weaponHash = `WEAPON_PUMPSHOTGUN_MK2`, weaponDmg = 0.4, weaponRecoil = 0.4, weaponShake = 0.085 },
	{ weaponHash = `WEAPON_SAWNOFFSHOTGUN`, weaponDmg = 0.55, weaponRecoil = 0.4, weaponShake = 0.06 },
	{ weaponHash = `WEAPON_ASSAULTSHOTGUN`, weaponDmg = 0.78, weaponRecoil = 0.4, weaponShake = 0.12 },
	{ weaponHash = `WEAPON_BULLPUPSHOTGUN`, weaponDmg = 0.5, weaponRecoil = 0.4, weaponShake = 0.08 },
	{ weaponHash = `WEAPON_DBSHOTGUN`, weaponDmg = 0.92, weaponRecoil = 0.4, weaponShake = 0.05 },
	{ weaponHash = `WEAPON_AUTOSHOTGUN`, weaponDmg = 0.0, weaponRecoil = 0.4, weaponShake = 0.08 }, 
	{ weaponHash = `WEAPON_MUSKET`, weaponDmg = 0.38, weaponRecoil = 0.4, weaponShake = 0.04 },
	{ weaponHash = `WEAPON_HEAVYSHOTGUN`, weaponDmg = 0.62, weaponRecoil = 0.4, weaponShake = 0.13 },
	-- SNIPER RIFLES
	{ weaponHash = `WEAPON_SNIPERRIFLE`, weaponDmg = 1.0, weaponRecoil = 0.5, weaponShake = 0.2 },
	{ weaponHash = `WEAPON_HEAVYSNIPER`, weaponDmg = 1.0, weaponRecoil = 0.7, weaponShake = 0.3 },
	{ weaponHash = `WEAPON_HEAVYSNIPER_MK2`, weaponDmg = 1.0, weaponRecoil = 0.7, weaponShake = 0.35 },
	{ weaponHash = `WEAPON_MARKSMANRIFLE`, weaponDmg = 0.6, weaponRecoil = 0.5, weaponShake = 0.1 },
	{ weaponHash = `WEAPON_MARKSMANRIFLE_MK2`, weaponDmg = 0.6, weaponRecoil = 0.5, weaponShake = 0.1 },
	-- MISC
	{ weaponHash = `WEAPON_UNARMED`, weaponDmg = 0.05, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_FIREEXTINGUISHER`, weaponDmg = 0.10, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_BATTLEAXE`, weaponDmg = 0.0, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_FLASHLIGHT`, weaponDmg = 0.10, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_CROWBAR`, weaponDmg = 0.15, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_DAGGER`, weaponDmg = 0.35, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_GOLFCLUB`, weaponDmg = 0.15, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_HATCHET`, weaponDmg = 0.5, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_KNIFE`, weaponDmg = 0.34, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_KNUCKLE`, weaponDmg = 0.35, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_MACHETE`, weaponDmg = 0.42, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_NIGHTSTICK`, weaponDmg = 0.14, weaponRecoil = 0.0, weaponShake = 0.0 },
	{ weaponHash = `WEAPON_SWITCHBLADE`, weaponDmg = 0.34, weaponRecoil = 0.0, weaponShake = 0.0 },
}

--==========================================================================================
--==                            	GET PLAYER LOOP              	                  ==
--==========================================================================================
local playerPed 
local isArmed = false
local hasWeapon 
local letSleep = false
local cameraMode
Citizen.CreateThread(function() -- 500 MS Loop
	while true do
		playerPed 			= GetPlayerPed(-1)
		playerPedId			= PlayerPedId()
		hasWeapon = GetSelectedPedWeapon(playerPed) 
		cameraMode = GetFollowPedCamViewMode()
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		
		Citizen.Wait(0)

			
		for i=1, #WeaponInfo, 1 do
			if hasWeapon == WeaponInfo[i].weaponHash then
				SetPlayerHealthRechargeMultiplier(playerPedId, 0.0)
				N_0x4757f00bc6323cfe(WeaponInfo[i].weaponHash, WeaponInfo[i].weaponDmg)
				if IsPedShooting(playerPedId) and not IsPedDoingDriveby(playerPedId) then
					if WeaponInfo[i].weaponRecoil and WeaponInfo[i].weaponRecoil ~= 0 then
	
						tv = 0
							
						if cameraMode ~= 4 then
							repeat 
								Wait(0)
								SetWeaponAnimationOverride(playerPedId, HASH_DEFAULT)
								p = GetGameplayCamRelativePitch()
								SetGameplayCamRelativePitch(p+0.1, 0.2)
								tv = tv+0.1
							until tv >= WeaponInfo[i].weaponRecoil
						else
							repeat 
								Wait(0)
								SetWeaponAnimationOverride(playerPedId, HASH_FIRSTPERSONAIMING)
								p = GetGameplayCamRelativePitch()
								if WeaponInfo[i].weaponRecoil > 0.1 then
									SetGameplayCamRelativePitch(p+0.6, 1.2)
									tv = tv+0.6
								else
									SetGameplayCamRelativePitch(p+0.016, 0.333)
									tv = tv+0.1
								end
							until tv >= WeaponInfo[i].weaponRecoil
						end
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', WeaponInfo[i].weaponShake)
					end
					
				end
	
			end
			
		end
		

	end

end)



function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 