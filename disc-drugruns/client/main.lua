ESX = nil
PlayerData = nil

isHidingRun = false

isRunActive = false

local currentDrugTask = {
    pointIndex = 0,
    runsLeft = 0,
    drugsIndex = 0
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

--Register Points
Citizen.CreateThread(function()
    for k, v in pairs(Config.DeliveryPoints) do
        local marker = {
            name = v.name .. '_drug_dp',
            type = 2,
            coords = v.coords,
            colour = { r = 255, b = 55, g = 55 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Press ~INPUT_CONTEXT~ to deliver at ' .. v.name,
            action = DeliverDrugs,
            deliveryPointIndex = k,
            shouldDraw = function()
                return Config.DeliveryPoints[k].isDeliveryPointActive and not isHidingRun
            end
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end

    for k, v in pairs(Config.StartingPoints) do
        local marker = {
            name = v.name .. '_drug_sp',
            type = 29,
            coords = v.coords,
            colour = { r = 255, b = 55, g = 55 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Press ~INPUT_CONTEXT~ to start drug run at ' .. v.name .. ' for $2000',
            action = StartNewRun,
            shouldDraw = function()
                return true
            end
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)

function disableAllPoints()
    for k, v in pairs(Config.DeliveryPoints) do
        Config.DeliveryPoints[k].isDeliveryPointActive = false
    end
end

local Cooldown = 0 
function DeliverDrugs()
    if Cooldown < 2 then 
        Cooldown = 10
        local oxyItem = exports['ig-inventory']:HasItem('oxy', 1)
        if oxyItem then
            -- local price = math.random(Config.Drugs[currentDrugTask.drugsIndex].price[1], Config.Drugs[currentDrugTask.drugsIndex].price[2])
            Config.DeliveryPoints[currentDrugTask.drugsIndex].isDeliveryPointActive = false
            TriggerServerEvent('ig-oxyruns:runComplete')
            GotoNextRun()
        else
            exports['mythic_notify']:SendAlert('error', 'Druggo: You don\'t have the drugs? Where is it?')
            EndRuns()
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming keys.<br>(Cooldown: ' .. Cooldown .. ' seconds)')
    end
end

function StartNewRun()
    if Cooldown < 2 then 
        TriggerServerEvent('ig-oxyruns:buyOxy')
        Cooldown = 45
    else
        exports['mythic_notify']:SendAlert('error', 'Error: Please refrain from spamming keys.<br>(Cooldown: ' .. Cooldown .. ' seconds)')
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if Cooldown >= 2 then 
            Cooldown = Cooldown - 1
        elseif Cooldown == 1 then
            Cooldown = 0
        end
    end
end)

RegisterNetEvent('ig-oxyruns:startRun')
AddEventHandler('ig-oxyruns:startRun', function()
    -- if not took then
    --         exports['mythic_notify']:SendAlert('error', 'Sassy: "You don\'t have enough money, you need $' .. Config.StartPrice .. '".')
    --         return
    --     end
    isRunActive = true
    isHidingRun = true
    drugIndex = math.random(#Config.Drugs)
    currentDrugTask = {
        pointIndex = math.random(#Config.DeliveryPoints),
        runsLeft = 3,
        drugsIndex = drugIndex
    }
    exports['mythic_notify']:SendAlert('success', 'Sassy: Done deal, I\'ll flick ya the location in a min\'.')
    Config.DeliveryPoints[currentDrugTask.pointIndex].isDeliveryPointActive = true
end)

function GotoNextRun()
    disableAllPoints()
    if currentDrugTask.runsLeft == 0 then
        EndRuns()
    else
        isHidingRun = true
        currentDrugTask = {
            pointIndex = math.random(#Config.DeliveryPoints),
            runsLeft = currentDrugTask.runsLeft - 1,
            drugsIndex = math.random(#Config.Drugs)
        }
        Config.DeliveryPoints[currentDrugTask.pointIndex].isDeliveryPointActive = true
    end
end

function EndRuns()
    isRunActive = false
    disableAllPoints()
end


--Hiding Run
Citizen.CreateThread(function()
    while true do
        if isHidingRun then
            Citizen.Wait(1000)
            isHidingRun = false
            serverId = GetPlayerServerId(PlayerId())
            ESX.TriggerServerCallback('iG-gcphone:getNumber', function(number)
                coords = Config.DeliveryPoints[currentDrugTask.pointIndex].coords
                message = 'GPS: ' .. coords.x .. ', ' .. coords.y
                TriggerServerEvent('iG-gcphone:sendMessageFrom', 'Sassy', number, message, serverId)
            end)
        end
        Citizen.Wait(5000)
    end
end)
