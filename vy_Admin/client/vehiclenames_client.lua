local ESX = nil
EGYT = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    
    Citizen.Wait(5000)  
    
    ESX.TriggerServerCallback('egyt_setvehname:getVehicles', function(vehicles)
        EGYT.LoadVehicleNames(vehicles)
    end)

end)

EGYT.LoadVehicleNames = function (vehicles)
    for k,vehicle in ipairs(vehicles) do
        AddTextEntryByHash(GetHashKey(vehicle.model), vehicle.name)
    end
end

local otherVehicles = {
        { model = "ems_as350", name = "NSWA | AS350 Helicopter"},
		{ model = "westpac_as350", name = "Westpac | AS350 Helicopter"},
		{ model = "ems_aw139", name = "NSWA | AW139 Helicopter"},
		{ model = "westpac_aw139", name = "Westpac | AW139 Helicopter"},
		{ model = "westpac_bell412", name = "Westpac | Bell-412 Helicopter"},
		{ model = "westpac_mh65c", name = "Westpac | MH-65c Helicopter"},

        { model = "ems_13ambo", name = "NSWA | Mercedes Sprinter"},
		{ model = "ems_zbwagon", name = "NSWA | Holden ZB Wagon"},
		{ model = "ems_ter", name = "NSWA | Ford Territory"},
		{ model = "ems_iload", name = "NSWA | Hyundai iLoad"},
		{ model = "ems_1200rt", name = "NSWA | BMW 1200RT"},
		{ model = "ems_colorado", name = "NSWA | Holden Colorado"},
		{ model = "ems_sor", name = "NSWA | Kia Sorento"},
		{ model = "ems_lc", name = "NSWA | Toyota Landcruiser"},
		{ model = "ems_santafe", name = "NSWA | Hyundai Santa Fe"},
		{ model = "ems_300c", name = "NSWA | Chrysler 300C"},
		{ model = "ems_mustang", name = "NSWA | Ford Mustang"},
		{ model = "ems_gts", name = "NSWA | Holden GTS"},
		{ model = "ems_patrol", name = "NSWA | Nissan Patrol"},

		{ model = "fire_hilux", name = "FRNSW | Toyota Hilux"},
		{ model = "fire_tanker2", name = "FRNSW | Isuzu Tanker"},
		{ model = "fire_pumper2", name = "FRNSW | Scania Pumper"},
		{ model = "fire_ranger", name = "FRNSW | Ford Ranger"},
		{ model = "fire_trescue", name = "FRNSW | Scania Rescue"},
		{ model = "fire_vfsw", name = "FRNSW | Holden VF Wagon"},
		{ model = "fire_htrescue", name = "FRNSW | Scania Heavy Rescue"},
		{ model = "fire_pajero", name = "FRNSW | Mitsubishi Pajero"},
		{ model = "fire_xr6", name = "FRNSW | Ford XR6"},

        -- General Duties Vehicles
		{ model = "polgd_iload", name = "GD Hyundai iLoad"},
		{ model = "polgd_omega", name = "GD Holden Omega"},
		{ model = "polgd_camry", name = "GD Toyota Camry"},
		{ model = "polgd_colorado", name = "GD Holden Colorado"},
		{ model = "polgd_fgute", name = "GD Ford FG Ute"},
		{ model = "polgd_evoke", name = "GD Holden Evoke"},
		{ model = "polgd_sonata", name = "GD Holden Evoke"},
		{ model = "polgd_hiluxp", name = "GD Toyota Hilux"},
		{ model = "polgd_hilux", name = "GD Toyota Hilux (Dog)"},
		{ model = "polgd_coloradop", name = "GD Holden Colorado (Pod)"},
		{ model = "polgd_patrol", name = "GD Nissan Patrol"},
		{ model = "polgd_1200rt", name = "GD BMW 1200RT"},
		{ model = "polgd_ter", name = "GD Ford Territory"},
		{ model = "polgd_lancer", name = "GD Mitsubishi Lancer"},
		{ model = "polgd_falcon", name = "GD Ford Falcon"},
		{ model = "polgd_sportswagon", name = "GD Holden Sportswagon"},
		{ model = "polgd_sor", name = "GD Kia Sorento"},
		{ model = "polgd_ranger", name = "GD Ford Ranger"},
		{ model = "polgd_kluger", name = "GD Toyota Kluger"},
		{ model = "polgd_zbwagon", name = "GD Holden ZB Wagon"},
		{ model = "polgd_lc", name = "GD Toyota Landcruiser"},
		{ model = "polgd_stinger", name = "GD Kia Stinger"},

        -- General Duties Helicopters
		{ model = "polgd_as350", name = "GD AS350"},
		{ model = "polgd_bell412", name = "GD Bell-412"},	

        -- State Protection Group Helicopters
		{ model = "polspg_as350", name = "SPG AS-350"},
		{ model = "polspg_aw139", name = "SPG AW-139"},
		{ model = "polshp_as365", name = "SPG AS-365"},

        -- Victora Police Highway Vehicles
		{ model = "polhwy_passat", name = "VHWY Volkswagon Passat"},
		{ model = "polhwy_vicbmw", name = "VHWY BMW 530D"},

		-- State Highway Patrol Vehicles
		{ model = "polshp_bmw", name = "SHP BMW 530D"},

        -- Donator Helicopters
		{ model = "polspg_valkyrie", name = "SPG Valkyrie"},
		{ model = "polshp_aw139", name = "SHP AW-139"},

        -- Highway Patrol Vehicles
		{ model = "polhwy_xr6", name = "HWY Ford FG XR6"},
		{ model = "polhwy_fgxr6", name = "HWY Ford FGX XR6"},
		-- { model = "polhwy_vess", name = "HWY Holden VESS"},
		{ model = "polhwy_vfii", name = "HWY Holden VFII"},
		{ model = "polhwy_xr8", name = "HWY Ford FGX XR8"},
		{ model = "polhwy_x5", name = "HWY BMW X5"},
		{ model = "polhwy_f6", name = "HWY Ford F6 (Pursuit)"},
		{ model = "polhwy_300c", name = "HWY Crysler 300C"},
		{ model = "polhwy_bmw", name = "HWY BMW 530D"},
		{ model = "polhwy_gts", name = "HWY Holden GTS (Pursuit)"},
		{ model = "polhwy_mustang", name = "HWY Ford Mustang (Pursuit)"},

		-- Unmarked Police Vehicles
		{ model = "polum_camry", name = "UM Toyota Camry"},
		-- { model = "polum_vess", name = "UM Holden VESS"},
		{ model = "polum_falcon", name = "UM Ford Falcon FGX"},
		{ model = "polum_sor", name = "UM Kia Sorento"},
		{ model = "polum_vfii", name = "UM Holden VFII"},
		{ model = "polum_xr6", name = "UM Ford XR6"},
		{ model = "polum_lancer", name = "UM Mitsubishi Lancer"},
		{ model = "polum_ranger", name = "UM Ford Ranger"},
		{ model = "polum_xr8", name = "UM Ford XR8"},
		{ model = "polum_300c", name = "UM Crysler 300C"},
		{ model = "polum_bmw", name = "UM BMW 530D"},

    		-- State Protection Group Vehicles
		{ model = "polgd_ter", name = "SPG Ford Territory"},
		{ model = "polpor_vito", name = "SPG Mercedes Vito"},
		{ model = "polspg_colorado", name = "SPG Holden Colorado"},
		{ model = "polgd_stinger", name = "SPG Kia Stinger"},
		{ model = "polspg_bearcat", name = "SPG Lenco Bearcat"},
		{ model = "polspg_merc", name = "SPG Mercedes Sprinter"},
		{ model = "polspg_lc", name = "SPG Toyota Landcruiser"},

		-- Unmarked Police Vehicles
		{ model = "polum_pajero", name = "UM Mitsubishi Pajero"},
		{ model = "polum_zb", name = "UM Holden ZB"},
		{ model = "polum_sor", name = "UM Kia Sorento"},
		{ model = "polum_iload", name = "UM Hyundai iLoad"},
		{ model = "polum_colorado", name = "UM Holden Colorado"},
		{ model = "polum_vfii", name = "UM Holden VFII"},
		{ model = "polum_xr6", name = "UM Ford Falcon XR6"},
		{ model = "polum_xr8", name = "UM Ford Falcon XR8"},
		{ model = "polum_stinger", name = "UM Kia Stinger"},
		{ model = "polum_vicbmw", name = "UM BMW 530D"},
		{ model = "polum_lc", name = "UM Toyota Landcruiser"},
		{ model = "polum_kluger", name = "UM Toyota Kluger"},

        { model = "stockade", name = "Gruppe6: Stockade"},
        { model = "g6_camry", name = "Gruppe6: Toyota Camry"},
        { model = "g6_xr6", name = "Gruppe6: Ford XR6"},
        { model = "g6_evoke", name = "Gruppe6: Holden Evoke"},
        { model = "g6_patrol", name = "Gruppe6: Nissan Patrol"},
        { model = "g6_lc", name = "Gruppe6: Toyota Landcruiser"},
        { model = "g6_hilux", name = "Gruppe6: Toyota Hilux"},
        { model = "g6_vfii", name = "Gruppe6: Holden VFII"},
        { model = "g6_lancer", name = "Gruppe6: Mitsubishi Lancer"},
        { model = "g6_300c", name = "Gruppe6: Chrysler 300c"},
        { model = "g6_stinger", name = "Gruppe6: Kia Stinger"},
        { model = "g6_x5", name = "Gruppe6: BMW X5"},
        { model = "g6_gts", name = "Gruppe6: Holden GTS"},
        { model = "g6_iload", name = "Gruppe6: ILoad"},
        { model = "g6_bmw", name = "Gruppe6: BMW 530D"}

}

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    for k,v in ipairs(otherVehicles) do
        AddTextEntryByHash(GetHashKey(v.model), v.name)
    end
end)