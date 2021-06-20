RegisterNetEvent("ig-inventory:openBusinessStorageInventory")
AddEventHandler("ig-inventory:openBusinessStorageInventory", function(data)
    setBusinessStorageData(data)
    openBusinessStorageInventory() 
end)

function refreshBusinessStorageInventory()
    ESX.TriggerServerCallback("iG_BusinessStorage:getBusinessStorageInventory", function(inventory)
        setBusinessStorageData(inventory)
    end)
end

function setBusinessStorageData(data)
    items = {}

    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = "Storage Inventory"
                }
            )

    -- local blackMoney = data.blackMoney
	-- local money = data.money
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    -- if blackMoney ~= nil and blackMoney > 0 then
    --     accountData = {
    --         label = _U("black_money"),
    --         count = blackMoney,
    --         type = "item_account",
    --         name = "black_money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end

    -- if money ~= nil and money > 0 then
    --     accountData = {
    --         label = _U("cash"),
    --         count = money,
    --         type = "item_account",
    --         name = "money",
    --         usable = false,
    --         rare = false,
    --         weight = -1,
    --         canRemove = false
    --     }
    --     table.insert(items, accountData)
    -- end
	
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.weight = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    weight = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openBusinessStorageInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "businessstorage"
        }
    )

    SetNuiFocus(true, true)
end


RegisterNUICallback(
    "PutIntoBusinessStorage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("iG_BusinessStorage:putItem", ESX.GetPlayerData().job.name, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshBusinessStorageInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromBusinessStorage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("iG_BusinessStorage:getItem", ESX.GetPlayerData().job.name, data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(150)
        refreshBusinessStorageInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
