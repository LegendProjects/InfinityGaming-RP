ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("iG:playerLoaded")
AddEventHandler('iG:playerLoaded', function()
    playerLoaded = true
end)

RegisterNetEvent("vy_Rewards:claimRewards")
AddEventHandler('vy_Rewards:claimRewards', function()
   RewardsMenu()
end)

function RewardsMenu()
    ESX.UI.Menu.CloseAll()
    local elements = {}

    ESX.TriggerServerCallback('vy_Rewards:getPlayerRewards', function(data)
        if data.amount ~= 0 then
            if data.item == 'xpbomb' and data.amount ~= 0 then
                table.insert(elements, {label = data.amount .. 'x Double Exp. Bomb', item = data.item, amount = data.amount})
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reward_menu', {
                title    = 'vy_Rewards: Claim Rewards',
                align    = 'right',
                elements = elements
            }, function(data, menu)
                exports['mythic_progbar']:Progress({
                    name = "claiming_rewards",
                    duration = 4000,
                    label = "vy_Rewards: Claiming Reward..",
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }
                }, function(status)
                    if not status then
                        menu.close()
                        TriggerServerEvent('vy_Rewards:withdrawReward', data.current.item, data.current.amount)
                        exports['mythic_notify']:SendAlert('inform', 'vy_Rewards: You have claimed your reward, thank you for supporting our server!')        
                    end
                end)
        
            end, function(data, menu)
                menu.close()
            end)
        else
            exports['mythic_notify']:SendAlert('inform', 'vy_Rewards: You do not have any rewards to claim.')        
        end

    end)

    
    
end