Citizen.CreateThread(function()
    local bones1 = {
        "door_dside_f",
        "door_pside_f",
        "bonnet"
    }

    exports["bt-target"]:AddTargetBone(bones1, {
        options = {
            {
                event = "iG_Mechanics:repairEngine",
                icon = "fas fa-car",
                label = "Repair Engine",
            },
            {
                event = "iG_Mechanics:repairBodywork",
                icon = "fas fa-car-crash",
                label = "Repair Bodywork",
            },
            {
                event = "iG_Mechanics:cleanVehicle",
                icon = "fas fa-hand-sparkles",
                label = "Clean Vehicle",
            },
            {
                event = "iG_Mechanics:decodeVehicle",
                icon = "fas fa-unlock-alt",
                label = "Decode Vehicle Locks",
            },
            {
                event = "iG_Mechanics:assignImpound",
                icon = "fas fa-snowplow",
                label = "Assign Vehicle Impound",
            },
        },
        job = {'government', 'sar', 'dragonsjdm', 'sinsgarage', 'beekers', 'harwick'},
        distance = 1.5
    })
end)