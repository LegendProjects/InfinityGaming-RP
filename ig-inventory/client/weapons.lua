-----TRUNK WEAPONS-------
local weaponsLarge = {
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_CARBINERIFLE",
	"WEAPON_SMG",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_MG",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_COMBATPDW",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_MUSKET",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SMG_MK2",
	"WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_KATANA",
    "WEAPON_ARMADYL",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_KIRITOSWORDBLACK",
    "WEAPON_KIRITOSWORDBLUE",
    "WEAPON_DRAGONAXE",
    "WEAPON_DRAGONPICKAXE",
    "WEAPON_DRAGONDAGGER", 
    "WEAPON_DRAGONEXCALIBUR"
}

local SETTINGS = {
	back_bone = 24816,
	x = 0.3,  --- Neagtive up; positive down
	y = -0.15,   --- negative is away from body   - positive is in body 
	z = -0.10,   -- positive left --- negative right
	x_rotation = 180.0,
	y_rotation = 145.0,
	z_rotation = 0.0,
	compatable_weapons = {
		-- assault rifles:
        ["w_sg_pumpshotgunmk2"] = "WEAPON_PUMPSHOTGUN_MK2",
        ["w_ar_carbineriflemk2"] = "WEAPON_CARBINERIFLE_MK2",
        ["w_ar_assaultrifle"] = "WEAPON_ASSAULTRIFLE",
        ["w_sg_pumpshotgun"] = "WEAPON_PUMPSHOTGUN",
        ["w_ar_carbinerifle"] = "WEAPON_CARBINERIFLE",
        ["w_sb_smg"] = "WEAPON_SMG",
        ["w_sb_pdw"] = "WEAPON_COMBATPDW",
        ["w_mg_mg"] = "WEAPON_MG",
        ["w_sb_gusenberg"] = "WEAPON_GUSENBERG",
        ["w_ar_advancedrifle"] = "WEAPON_ADVANCEDRIFLE",
        ["w_sr_sniperrifle"] = "WEAPON_SNIPERRIFLE",
        ["w_ar_assaultriflemk2"] = "WEAPON_ASSAULTRIFLE_MK2",
        ["w_mg_combatmgmk2"] = "WEAPON_COMBATMG_MK2",
        ["w_ar_musket"] = "WEAPON_MUSKET",
        ["w_ar_specialcarbine"] = "WEAPON_SPECIALCARBINE",
        ["w_sb_smgmk2"] = "WEAPON_SMG_MK2",
        ["w_ar_specialcarbinemk2"] = "WEAPON_SPECIALCARBINE_MK2",
        ["w_sg_sawnoff"] = "WEAPON_SAWNOFFSHOTGUN",
        ["w_ar_assaultrifle_smg"] = "WEAPON_COMPACTRIFLE",
	}
}

local SPECIAL = {
    {
        back_bone = 24816,
        Model = "w_me_armadyl",
        Name = "WEAPON_ARMADYL",
        x = 0.55,  --- Neagtive up; positive down
        y = -0.09,   --- negative is away from body   - positive is in body 
        z = 0.17,   -- positive left --- negative right
        x_rotation = -878.0,
        y_rotation = -732.0,
        z_rotation = -96.0,
    },
    {
        back_bone = 24816,
        Model = "w_me_dragonaxe",
        Name = "WEAPON_DRAGONAXE",
        x = 0.545,  --- Neagtive up; positive down
        y = -0.16,   --- negative is away from body   - positive is in body 
        z = -0.22,   -- positive left --- negative right
        x_rotation = 180.0,
        y_rotation = -117.0,
        z_rotation = 0.0,
    },
    {
        back_bone = 24816,
        Model = "w_me_dragonpickaxe",
        Name = "WEAPON_DRAGONPICKAXE",
        x = 0.545,  --- Neagtive up; positive down
        y = -0.16,   --- negative is away from body   - positive is in body 
        z = -0.22,   -- positive left --- negative right
        x_rotation = 180.0,
        y_rotation = -117.0,
        z_rotation = 0.0,
    },
    {
        back_bone = 11816,
        Model = "w_me_dragondagger",
        Name = "WEAPON_DRAGONDAGGER",
        x = 0.0,  --- Neagtive up; positive down
        y = 0.0,   --- negative is away from body   - positive is in body 
        z = -0.2,   -- positive left --- negative right
        x_rotation = 97.0,
        y_rotation = -20.0,
        z_rotation = 90.0,
    },
    {
        back_bone = 24816,
        Model = "w_me_dragonexcalibur",
        Name = "WEAPON_DRAGONEXCALIBUR",
        x = 0.545,  --- Neagtive up; positive down
        y = -0.16,   --- negative is away from body   - positive is in body 
        z = -0.22,   -- positive left --- negative right
        x_rotation = 180.0,
        y_rotation = -117.0,
        z_rotation = 0.0,
    },
}

local SPECIAL2 = {
    back_bone = 24816,
	x = 0.5,  --- Neagtive up; positive down
	y = -0.16,   --- negative is away from body   - positive is in body 
	z = -0.23,   -- positive left --- negative right
	x_rotation = 180.0,
	y_rotation = -297.0 - 360.0,
	z_rotation = 0.0,
    special_weapon_hashes = {
        ["w_me_kiritoswordblack"] = "WEAPON_KIRITOSWORDBLACK",
    }
}
 -- 0.023
local SPECIAL3 = {
    back_bone = 24816,
	x = 0.477,  --- Neagtive up; positive down
	y = -0.16,   --- negative is away from body   - positive is in body 
	z = 0.14,   -- positive left --- negative right
	x_rotation = 180.0,
	y_rotation = 293.0 + 180.0,
	z_rotation = 0.0,
    special_weapon_hashes = {
        ["w_me_kiritoswordblue"] = "WEAPON_KIRITOSWORDBLUE",
    }
}

local currentWeapon
local currentWeaponSlot
local currentWepAttachs = {}
local firsttime = true
local weaponKey = nil
local NumberCharset = {}
local Charset = {}
canFire = true

local hasWeaponL = false
local weaponL ="WEAPON_UNARMED"
local has_weapon_on_back = false
local isRacking = false
local attached_weapons = {}

local weaponBlack = false
local weaponBlue = false

local isVyve = false
RegisterNetEvent('ig-inventory:debug:VyveWeaps')
AddEventHandler('ig-inventory:debug:VyveWeaps', function()
    isVyve = true
    weaponBlack = exports['ig-inventory']:HasItem("WEAPON_KIRITOSWORDBLACK", 1)
    weaponBlue = exports['ig-inventory']:HasItem("WEAPON_KIRITOSWORDBLUE", 1)
end)

RegisterNetEvent('ig-inventory:itemPopUp')
AddEventHandler('ig-inventory:itemPopUp', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    if checkWeaponLarge(weapon) then 
        if not hasWeaponL then 
            if isNearTrunk() then
                startAnim("mini@repair", "fixing_a_ped")
                
                local coordA = GetEntityCoords(ped, 1)
                local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
                local vehicle = getVehicleInDirection(coordA, coordB)
                if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
                    SetVehicleDoorShut(vehicle, 5, false, false)
                end
                weaponL = weapon
                hasWeaponL = true
                has_weapon_on_back = false
                currentWeapon = weapon
                GiveWeapon(currentWeapon, true)
                TriggerEvent('ig-inventory:notification', weapon,"Equipped", 1, false)
            else
                exports['mythic_notify']:SendAlert('error', 'Error: You need to be at a trunk to draw that weapon!')
            end
        else
            currentWeapon = weapon
            GiveWeapon(currentWeapon, true)
            TriggerEvent('ig-inventory:notification', weapon,"Equipped", 1, false)
        end
    else
        currentWeapon = weapon
        GiveWeapon(currentWeapon, false)
        TriggerEvent('ig-inventory:notification', weapon,"Equipped", 1, false)
    end
end)

AddEventHandler('ig-inventory:addCurrentWeapon', function(waeponToAdd, attachments, addToSlote)
    currentWeapon = waeponToAdd
    currentWepAttachs = attachments.attach
    local doBreak = false
    if addToSlote then
        TriggerServerEvent('ig-inventory:slotPut', waeponToAdd)
    end
end)

RegisterNetEvent('ig-inventory:removeCurrentWeapon')
AddEventHandler('ig-inventory:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
end)

local weapons = {

    [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = { 
		['mag'] = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')
    },

    [tostring(GetHashKey('WEAPON_MG'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02'),
		['mag'] = GetHashKey('COMPONENT_MG_CLIP_02')
    },

    [tostring(GetHashKey('WEAPON_COMBATMG'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['mag'] = GetHashKey('COMPONENT_COMBATMG_CLIP_02')
    },

    [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['mag'] = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['mag'] = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['mag'] = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_PISTOL'))] = { 
		['mag'] = GetHashKey('COMPONENT_PISTOL_CLIP_02'),
		['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = { 
		['mag'] = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02'),
		['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = { 
		['mag'] = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03'),
		['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
    },

    [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = { 
		['mag'] = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02'),
		['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP')
    },

    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = { 
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MAX'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02')
    },

    [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = { 
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MAX')
    },

    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = { 
		['suppressor'] = GetHashKey('COMPONENT_AT_SR_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = { 
        ['mag'] = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = { 
        ['mag'] = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_COMBATPDW'))] = { 
        ['mag'] = GetHashKey('COMPONENT_COMBATPDW_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_COMBATPDW_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = { 
        ['mag'] = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = { 
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = { 
        ['mag'] = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_MICROSMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_MICROSMG_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_SMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_SMG_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_SMG_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },

    [tostring(GetHashKey('WEAPON_APPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_APPISTOL_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_PISTOL50'))] = { 
        ['mag'] = GetHashKey('COMPONENT_PISTOL50_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },

    [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02'),
    },
    
    [tostring(GetHashKey('WEAPON_MINISMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_MINISMG_CLIP_02'),
    },

    [tostring(GetHashKey('WEAPON_GUSENBERG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_GUSENBERG_CLIP_02'),
    },

    [tostring(GetHashKey('WEAPON_CERAMICPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_CERAMICPISTOL_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_CERAMICPISTOL_SUPP'),
    },

    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = { 
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL'),
        ['mag'] = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    }

}

RegisterNetEvent('ig-inventory:useAttach')
AddEventHandler('ig-inventory:useAttach', function(attach)
    local playerPed = PlayerPedId()
    local hasAttach = false
    if currentWeapon ~= nil then
        local hash = GetHashKey(currentWeapon)
        for i = 1, #currentWepAttachs do
            if currentWepAttachs[i] == attach then
                hasAttach = true
            end
        end
        if weapons[tostring(hash)] ~= nil and weapons[tostring(hash)][attach] ~= nil and not hasAttach then
            ESX.TriggerServerCallback('ig-inventory:removeItem', function(cb)
                if cb then
                    table.insert(currentWepAttachs, attach)
                    GiveWeaponComponentToPed(playerPed, hash, weapons[tostring(hash)][attach])
                end
            end, attach)
        elseif string.find(attach, 'skin') then
            local number = tonumber(string.match(attach, "%d+"))
            ESX.TriggerServerCallback('ig-inventory:removeItem', function(cb)
                if cb then
                    for k,v in pairs(currentWepAttachs) do
                        if v == 'skin' or v == 'skin1' or v == 'skin2' or v == 'skin3' or v == 'skin4' or v == 'skin5' or v == 'skin6' or v == 'skin7' then
                            table.remove(currentWepAttachs, k)
                        end
                    end
                    table.insert(currentWepAttachs, attach)
                    SetPedWeaponTintIndex(playerPed, hash, number)
                end
            end, attach)
        else
			exports['mythic_notify']:SendAlert('error', _U("not_compatible"))
        end
    else
		exports['mythic_notify']:SendAlert('error', _U("no_weapon_selected"))
    end
end)

RegisterKey('keyboard',"BACKSLASH",
	function()
	end,
	function()
        if not IsEntityDead(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) and not removingAttach then
            if currentWeapon ~= nil then
                removingAttach = true
                local playerPed = PlayerPedId()
                local hash = GetHashKey(currentWeapon)
                for i = 1, #currentWepAttachs do
                    if currentWepAttachs[i] ~= nil then
                        if string.find(currentWepAttachs[i], 'skin') == nil then
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "washing_gsr",
                                duration = 1500,
                                label = _U('waiting_remove'),
                                useWhileDead = false,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = false,
                                    disableCarMovement = false,
                                    disableMouse = false,
                                    disableCombat = false,
                                },
                            }, function(status)
                                if not status then
                                    RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring(hash)][currentWepAttachs[i]])
                                    DP.TriggerServerCallback('DP_Inventaris:addPlayerItem', function(cb)end, currentWepAttachs[i], 1)
                                    table.remove(currentWepAttachs, i)
                                    removingAttach = false
                                end
                            end)
                        end
                    end
                end
            else
				exports['mythic_notify']:SendAlert('error', _U("no_gun_in_hand"))
            end
		end
	end
)

function RemoveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    currentWeapon = nil
    ESX.TriggerServerCallback('ig-inventory:doesWeaponHas', function(hasWeaponId)
        if hasWeaponId then
            weaponKey = hasWeaponId
        else
            weaponKey = GenerateWeapon()
        end
        local wepInfo = { 
            count = GetAmmoInPedWeapon(playerPed, hash),
            attach = currentWepAttachs,
            weapon_id = weaponKey
        }
        TriggerServerEvent('ig-inventory:updateAmmoCount', hash, wepInfo)
        canFire = false
        disable()
        if checkh[weapon] == hash then
            if GetSelectedPedWeapon(playerPed) == hash then
                ESX.TriggerServerCallback('ig-inventory:addPlayerItem', function(cb)
                end, weapon, 1)
            end
        end
        if (PlayerData.job ~= nil) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'mcd' or PlayerData.job.name == 'gruppe6' or PlayerData.job.name == 'government') then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("reaction@intimidation@cop@unarmed") then
                loadAnimDict( "reaction@intimidation@cop@unarmed" )
            end
            TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
            Citizen.Wait(100)
        else
            if not HasAnimDictLoaded("reaction@intimidation@1h") then
                loadAnimDict( "reaction@intimidation@1h" )
            end
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "outro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
        end
        if checkWeaponLarge(weapon) and not isRacking then 
            has_weapon_on_back = true
        end
        RemoveWeaponFromPed(playerPed, hash)
        ClearPedTasks(playerPed)
        canFire = true
        TriggerEvent('ig-inventory:notification', weapon, "Unequipped", 1, false)
    end, hash)
end

function GiveWeapon(weapon, isWeaponLarge)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    if not HasAnimDictLoaded("reaction@intimidation@1h") then
        loadAnimDict( "reaction@intimidation@1h" )
    end
    if isWeaponLarge then 
        ESX.TriggerServerCallback('ig-inventory:getAmmoCount', function(gunInfo)
            currentWepAttachs = gunInfo.attachments
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0.325, 0, 0)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            for i = 1, #currentWepAttachs do
                if weapons[tostring( hash )] ~= nil then
                    GiveWeaponComponentToPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
                end
            end
            has_weapon_on_back = false
            Citizen.Wait(2000)
            if checkh[weapon] == hash then
                ESX.TriggerServerCallback('ig-inventory:takePlayerItem', function(cb)
                    SetPedAmmo(playerPed, hash, 1)
                end, weapon, 1)
            elseif Config.FuelCan == hash and gunInfo.ammoCount == nil then
                SetPedAmmo(playerPed, hash, 1000)
            else
                SetPedAmmo(playerPed, hash, gunInfo.ammoCount or 0)
            end
            ClearPedTasks(playerPed)
            canFire = true
        end, hash)
    elseif weapon == 'WEAPON_PETROLCAN' then
        local coords = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
            TriggerEvent('ig-inventory:removeCurrentWeapon')
            -- TriggerEvent('joca_fuel:useJerryCan')
        else
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            SetPedAmmo(playerPed, hash, 1000)
            ClearPedTasks(playerPed)
            canFire = true
        end
    else
      ESX.TriggerServerCallback('ig-inventory:getAmmoCount', function(gunInfo)
        currentWepAttachs = gunInfo.attachments
        canFire = false
        disable()
        if (PlayerData.job ~= nil) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'mcd' or PlayerData.job.name == 'gruppe6' or PlayerData.job.name == 'government') then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("rcmjosh4") then
                loadAnimDict( "rcmjosh4" )
            end
            TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(500)
        else
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)          
            Citizen.Wait(1600)
        end
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        for i = 1, #currentWepAttachs do
            if weapons[tostring(hash)] ~= nil then
                GiveWeaponComponentToPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
            end
            if currentWepAttachs[i] == 'skin1' then SetPedWeaponTintIndex(playerPed, hash, 1)
            elseif currentWepAttachs[i] == 'skin2' then SetPedWeaponTintIndex(playerPed, hash, 2)
            elseif currentWepAttachs[i] == 'skin3' then SetPedWeaponTintIndex(playerPed, hash, 3)
            elseif currentWepAttachs[i] == 'skin4' then SetPedWeaponTintIndex(playerPed, hash, 4)
            elseif currentWepAttachs[i] == 'skin5' then SetPedWeaponTintIndex(playerPed, hash, 5)
            elseif currentWepAttachs[i] == 'skin6' then SetPedWeaponTintIndex(playerPed, hash, 6)
            elseif currentWepAttachs[i] == 'skin7' then SetPedWeaponTintIndex(playerPed, hash, 7)
            end
        end
        if checkh[weapon] == hash then
            ESX.TriggerServerCallback('ig-inventory:takePlayerItem', function(cb)
                SetPedAmmo(playerPed, hash, 1)
            end, weapon, 1)
        elseif Config.FuelCan == hash and gunInfo.ammoCount == nil then
            SetPedAmmo(playerPed, hash, 1000)
        else
            SetPedAmmo(playerPed, hash, gunInfo.ammoCount or 0)
        end
        ClearPedTasks(playerPed)
        canFire = true
      end, hash)
    end
end

function disable()
	Citizen.CreateThread(function ()
		while not canFire do
			Citizen.Wait(10)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(player, true)
		end
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

--- Starts animation for trunk
function startAnim(lib, anim)
	RequestAnimDict(lib)
	while not HasAnimDictLoaded( lib) do
		Citizen.Wait(1)
	end

	TaskPlayAnim(PlayerPedId(), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )
	if (PlayerData.job ~= nil) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'mcd' or PlayerData.job.name == 'gruppe6' or PlayerData.job.name == 'government') then
		Citizen.Wait(2000)
	else
		Citizen.Wait(4000)
	end
	ClearPedTasksImmediately(ped)
end

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GenerateWeapon()
	local generatedWeapon
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedWeapon = GetRandomLetter(30) .. GetRandomNumber(30)

		ESX.TriggerServerCallback('ig-inventory:isWeaponNumberTaken', function(isWeaponTaken)
			if not isWeaponTaken then
				doBreak = true
			end
		end, generatedWeapon)

		if doBreak then
			break
		end
	end

	return generatedWeapon
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

--- Checks if large weapon
function checkWeaponLarge(newWeapon)
	for i = 1, #weaponsLarge do
		if weaponsLarge[i] == newWeapon then
			return true
		end
	end
	return false
end

--- Checks if large weapon
function checkWeaponSpecial(newWeapon)
	for i = 1, #weaponsSpecial do
		if weaponsSpecial[i] == newWeapon then
			return true
		end
	end
	return false
end

RegisterCommand("unequip", function(source, args, rawCommand)
    if currentWeapon ~= nil then
        local playerPed = PlayerPedId()
        local hash = GetHashKey(currentWeapon)
        if args[1] then
			local attach = args[1]
            for i = 1, #currentWepAttachs do
                if currentWepAttachs[i] == attach then
                    ESX.TriggerServerCallback('ig-inventory:addPlayerItem', function(cb)
                        if cb then
                            table.remove(currentWepAttachs, i)
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][attach])
                        else
                            exports['mythic_notify']:SendAlert('error', 'Error: Insufficient space.')
                        end          
                    end, currentWepAttachs[i], 1)
                    return
                end
            end
            exports['mythic_notify']:SendAlert('error', 'Error: This gun does not have this attachment.')
		else
			for i = 1, #currentWepAttachs do
				if currentWepAttachs[i] ~= nil then
					ESX.TriggerServerCallback('ig-inventory:addPlayerItem', function(cb)
                        if cb then
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
							table.remove(currentWepAttachs, i)
                        else
                            exports['mythic_notify']:SendAlert('error', 'Error: Insufficient space.')
                        end          
                    end, currentWepAttachs[i], 1)
				end
			end
		end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: You don\'t have a gun in your hand.')
    end
end)


--- Checks if player is near trunk
function isNearTrunk()
	local coordA = GetEntityCoords(PlayerPedId(), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
	local vehicle = getVehicleInDirection(coordA, coordB)
	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
		local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
		local lTail = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"))
		local rTail = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"))
		local playerpos = GetEntityCoords(PlayerPedId(), 1)
		local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
		local distanceToLeftT = GetDistanceBetweenCoords(lTail, playerpos, 1)
		local distanceToRightT = GetDistanceBetweenCoords(rTail, playerpos, 1)
		if distanceToTrunk < 1.5 then
			SetVehicleDoorOpen(vehicle, 5, false, false)
			return true
		elseif distanceToLeftT < 1.5 and distanceToRightT < 1.5 then
			SetVehicleDoorOpen(vehicle, 5, false, false)
			return true
		else
			return
		end
	end
end



-- Gets vehicle for trunk
function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, ped, 0)
	local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end


Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1)
        Citizen.Wait(10)
        -- print("current: " .. tostring(currentWeapon))
        -- print("weaponL: " .. tostring(weaponL))
        ---------------------------------------
        -- attach if player has large weapon --
        ---------------------------------------
        for weaponModel, weaponName in pairs(SETTINGS.compatable_weapons) do
            if weaponL == weaponName and has_weapon_on_back then
                if not attached_weapons[weaponModel] then
                    AttachWeapon(weaponModel, weaponName, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(weaponModel))
                end
            end
        end
        for i = 1, #SPECIAL do 
            if weaponL == SPECIAL[i].Name and has_weapon_on_back then
                if not attached_weapons[SPECIAL[i].Model] then
                    AttachWeapon(SPECIAL[i].Model,  SPECIAL[i].Name, SPECIAL[i].back_bone, SPECIAL[i].x, SPECIAL[i].y, SPECIAL[i].z, SPECIAL[i].x_rotation, SPECIAL[i].y_rotation, SPECIAL[i].z_rotation, false)
                end
            end
        end

        if isVyve then
            if weaponBlack and weaponBlue then 
                if currentWeapon ~= "WEAPON_KIRITOSWORDBLACK" and currentWeapon ~= "WEAPON_KIRITOSWORDBLUE" then
                    if not attached_weapons["holsterfullblack"] then
                        AttachWeapon("holsterfullblack", "WEAPON_KIRITOSWORDBLACK", SPECIAL2.back_bone, SPECIAL2.x, SPECIAL2.y, SPECIAL2.z, SPECIAL2.x_rotation, SPECIAL2.y_rotation, SPECIAL2.z_rotation, false)
                    end
                    if not attached_weapons["holsterfullblue"] then
                        AttachWeapon("holsterfullblue", "WEAPON_KIRITOSWORDBLUE", SPECIAL3.back_bone, SPECIAL3.x, SPECIAL3.y, SPECIAL3.z, SPECIAL3.x_rotation, SPECIAL3.y_rotation, SPECIAL3.z_rotation, false)
                    end 
                elseif currentWeapon == "WEAPON_KIRITOSWORDBLACK" and currentWeapon ~= "WEAPON_KIRITOSWORDBLUE" then
                    if not attached_weapons["holsterfullblue"] then
                        AttachWeapon("holsterfullblue", "WEAPON_KIRITOSWORDBLUE", SPECIAL3.back_bone, SPECIAL3.x, SPECIAL3.y, SPECIAL3.z, SPECIAL3.x_rotation, SPECIAL3.y_rotation, SPECIAL3.z_rotation, false)
                    end
                    if not attached_weapons["holsteremptyblack"] then
                        AttachWeapon("holsteremptyblack", "HOLSTERBLACK", SPECIAL2.back_bone, SPECIAL2.x, SPECIAL2.y, SPECIAL2.z, SPECIAL2.x_rotation, SPECIAL2.y_rotation, SPECIAL2.z_rotation, false)
                    end
                elseif currentWeapon == "WEAPON_KIRITOSWORDBLUE" and currentWeapon ~= "WEAPON_KIRITOSWORDBLACK" then
                    if not attached_weapons["holsterfullblack"] then
                        AttachWeapon("holsterfullblack", "WEAPON_KIRITOSWORDBLACK", SPECIAL2.back_bone, SPECIAL2.x, SPECIAL2.y, SPECIAL2.z, SPECIAL2.x_rotation, SPECIAL2.y_rotation, SPECIAL2.z_rotation, false)
                    end
                    if not attached_weapons["holsteremptyblue"] then
                        AttachWeapon("holsteremptyblue", "HOLSTERBLUE", SPECIAL3.back_bone, SPECIAL3.x, SPECIAL3.y, SPECIAL3.z, SPECIAL3.x_rotation, SPECIAL3.y_rotation, SPECIAL3.z_rotation, false)
                    end
                end
            elseif weaponBlack and not weaponBlue then 
                if currentWeapon ~= "WEAPON_KIRITOSWORDBLACK" then
                    if not attached_weapons["holsterfullblack"] then
                        AttachWeapon("holsterfullblack", "WEAPON_KIRITOSWORDBLACK", SPECIAL2.back_bone, SPECIAL2.x, SPECIAL2.y, SPECIAL2.z, SPECIAL2.x_rotation, SPECIAL2.y_rotation, SPECIAL2.z_rotation, false)
                    end
                elseif currentWeapon == "WEAPON_KIRITOSWORDBLACK" then 
                    if not attached_weapons["holsteremptyblack"] then
                        AttachWeapon("holsteremptyblack", "HOLSTERBLACK", SPECIAL2.back_bone, SPECIAL2.x, SPECIAL2.y, SPECIAL2.z, SPECIAL2.x_rotation, SPECIAL2.y_rotation, SPECIAL2.z_rotation, false)
                    end
                end
            elseif weaponBlue and not weaponBlack then 
                if currentWeapon ~= "WEAPON_KIRITOSWORDBLUE" then
                    if not attached_weapons["holsterfullblue"] then
                        AttachWeapon("holsterfullblue", "WEAPON_KIRITOSWORDBLUE", SPECIAL3.back_bone, SPECIAL3.x, SPECIAL3.y, SPECIAL3.z, SPECIAL3.x_rotation, SPECIAL3.y_rotation, SPECIAL3.z_rotation, false)
                    end
                elseif  currentWeapon == "WEAPON_KIRITOSWORDBLUE" then 
                    if not attached_weapons["holsteremptyblue"] then
                        AttachWeapon("holsteremptyblue", "HOLSTERBLUE", SPECIAL3.back_bone, SPECIAL3.x, SPECIAL3.y, SPECIAL3.z, SPECIAL3.x_rotation, SPECIAL3.y_rotation, SPECIAL3.z_rotation, false)
                    end
                end
            end
        end

        --------------------------------------------
        -- remove from back if equipped / dropped --
        --------------------------------------------
        for name, attached_object in pairs(attached_weapons) do
            -- equipped? delete it from back:
            if not has_weapon_on_back then -- equipped or not in weapon wheel
                if not isVyve then 
                    DeleteObject(attached_object.handle)
                    attached_weapons[name] = nil
                else
                    if weaponBlue and weaponBlack then
                        if currentWeapon == "WEAPON_KIRITOSWORDBLUE" and weaponBlack then
                            if (name ~= "holsterfullblack") and (name ~= "holsteremptyblue") then
                                DeleteObject(attached_object.handle)
                                attached_weapons[name] = nil
                            end
                        elseif currentWeapon == "WEAPON_KIRITOSWORDBLACK" and weaponBlue then
                            if (name ~= "holsterfullblue") and (name ~= "holsteremptyblack") then
                                DeleteObject(attached_object.handle)
                                attached_weapons[name] = nil
                            end
                        end
                    elseif weaponBlue and not weaponBlack then  
                        if currentWeapon == "WEAPON_KIRITOSWORDBLUE" and weaponBlue then
                            if (name ~= "holsteremptyblue") then
                                DeleteObject(attached_object.handle)
                                attached_weapons[name] = nil
                            end
                        end
                    elseif weaponBlack and not weaponBlue then  
                        if currentWeapon == "WEAPON_KIRITOSWORDBLACK" and weaponBlack then
                            if (name ~= "holsteremptyblack") then
                                DeleteObject(attached_object.handle)
                                attached_weapons[name] = nil
                            end
                        end
                    else
                        DeleteObject(attached_object.handle)
                        attached_weapons[name] = nil
                    end
                end
            end
        end
            
        
        Wait(0)
    end
end)

function AttachWeapon(attachModel,weaponName,boneNumber,x,y,z,xR,yR,zR, isMelee)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
    print(attachModel)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end
    print(GetHashKey(attachModel))
    attached_weapons[attachModel] = {
        hash = GetHashKey(weaponName),
        handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
    }

    if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
    if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end
	AttachEntityToEntity(attached_weapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 1, 2, 1)
end

function isMeleeWeapon(wep_name)
    if wep_name == "prop_golf_iron_01" then
        return true
    elseif wep_name == "w_me_bat" then
        return true
    elseif wep_name == "prop_ld_jerrycan_01" then
	  return true
	-- elseif wep_name == "w_me_katana" then
    --     return true
    -- elseif wep_name == "w_me_armadyl" then
	-- 	return true
    else
        return false
    end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for name, attached_object in pairs(attached_weapons) do
            DeleteObject(attached_object.handle)
            attached_weapons[name] = nil
        end
        has_weapon_on_back = false
	end
end)

--Command to rack weapon in vehicle
RegisterCommand('rack', function()
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    rackWeapon()
end, false)

function rackWeapon()
    isRacking = true
    if isNearTrunk() then
		has_weapon_on_back = false
        startAnim("mini@repair", "fixing_a_ped")
        
		local coordA = GetEntityCoords(PlayerPedId(), 1)
		local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
		local vehicle = getVehicleInDirection(coordA, coordB)
		if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
			SetVehicleDoorShut(vehicle, 5, false, false)
		end
		weaponL = "WEAPON_UNARMED"
        hasWeaponL = false
        if currentWeapon ~= nil then
            RemoveWeapon(currentWeapon)
            currentWeapon = nil
            currentWeaponSlot = nil
        end
	else
		exports['mythic_notify']:SendAlert('error', 'Error: You need to be at a trunk to put away your weapon!')
    end
    isRacking = false
end