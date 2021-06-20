local Items = {}
local maxWeight = 24000
local dbg = false
RegisterNetEvent("iG:Debug:Weight")
AddEventHandler('iG:Debug:Weight', function()
    dbg = not dbg
end)
-- RegisterNetEvent('iG:addInventoryItem')
-- AddEventHandler('iG:addInventoryItem', function(item, count)
--     for k,v in ipairs(PlayerData.inventory) do
-- 		if v.name == item then
-- 			PlayerData.inventory[k].count = count
-- 			break
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('iG:removeInventoryItem')
-- AddEventHandler('iG:removeInventoryItem', function(item, count)
--     for k,v in ipairs(PlayerData.inventory) do
-- 		if v.name == item then
-- 			PlayerData.inventory[k].count = count
-- 			break
-- 		end
-- 	end
-- end)


function GetItems()
    local encodedData = LoadResourceFile(GetCurrentResourceName(), "items.json")
    local decodedData = json.decode(encodedData)
    for i=1, #decodedData do
        -- print()
        Items[decodedData[i].name] = {
            name = decodedData[i].name,
            label = decodedData[i].label,
            weight = decodedData[i].weight,
            -- limit = decodedData[i].limit,
            rare = decodedData[i].rare,
            can_remove = decodedData[i].can_remove
        }
    end
    -- print('GetItems()')
end

function GetCurrentWeight()
    local inventoryWeight = 0
    PlayerData = ESX.GetPlayerData()
    for k,v in ipairs(PlayerData.inventory) do
        if PlayerData.inventory[k].count >= 1 then
            inventoryWeight = inventoryWeight + (PlayerData.inventory[k].count * Items[v.name].weight)
        end
    end
    -- for i=1, #PlayerData.inventory, 1 do
	-- 	if PlayerData.inventory[i].count >= 1 then
	-- 		inventoryWeight = inventoryWeight + (PlayerData.inventory[i].count * Items[PlayerData.inventory[i].name].weight)
	-- 	end
	-- end
    -- print(inventoryWeight)
    return inventoryWeight
end

function CanCarryItem(item, quantity)
    if not dbg then 
        if item ~= nil and quantity ~= nil and Items[item] ~= nil then 
            local currentWeight = GetCurrentWeight()
            local itemWeight = Items[item].weight
            local newWeight = currentWeight + (itemWeight * quantity)

            return newWeight <= maxWeight
        end
    elseif dbg then
        return true
    end
end

function HasItem(item, quantity)
    PlayerData = ESX.GetPlayerData()
    if item ~= nil and quantity ~= nil then 
        for i=1, #PlayerData.inventory, 1 do
            if PlayerData.inventory[i].name == item then 
                if PlayerData.inventory[i].count >= quantity then 
                    return true
                else
                    return false
                end
            end
        end
    end
end

exports('GetCurrentWeight', GetCurrentWeight)
exports('CanCarryItem', CanCarryItem)
exports('HasItem', HasItem)