local isDead = false
local ShouldPlayDeathAnimation = false
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
    end
    
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('iG-death:onPlayerDeath')
RegisterNetEvent('iG-death:onPlayerRevive')

AddEventHandler('iG-death:onPlayerRevive', function(data)
    ShouldPlayDeathAnimation = false
    isDead = false
end)
    
RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(data)
    ESX.TriggerServerCallback('iG-death:getDead', function(dead)
        isDead = dead
    end)
end)

RegisterNetEvent('iG:onPlayerDeath')
AddEventHandler('iG:onPlayerDeath', function(data)
	local playerPed = PlayerPedId()

	ESX.Streaming.RequestAnimDict('move_fall', function()
        TaskPlayAnim(playerPed, 'move_fall', 'land_fall', 8.0, 8.0, -1, 1, 0, 0, 0, 0)
    end)

    Citizen.Wait(3000)

    ShouldPlayDeathAnimation = true
    isDead = true

end)

RegisterNetEvent('iG-death:stopAnim')
AddEventHandler('iG-death:stopAnim', function()
    ShouldPlayDeathAnimation = false
end)
RegisterNetEvent('iG-death:startAnim')
AddEventHandler('iG-death:startAnim', function()
    ShouldPlayDeathAnimation = true
end)

local isBeingCarried = false

RegisterNetEvent('iG-death:beingCarried')
AddEventHandler('iG-death:beingCarried', function(boolean)
    isBeingCarried = boolean
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        if isDead == true then
            ShouldPlayDeathAnimation = true
            TriggerEvent('iG-death:onPlayerDeath')
            TriggerServerEvent('iG-death:setDead', true)
            ClearPedTasksImmediately(playerPed)
            FreezeEntityPosition(playerPed, true)
            SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))

            while isDead == true do
                DisableAllControlActions(0)
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 2, true)
                EnableControlAction(0, 51, true)
                EnableControlAction(0, 245, true)
                EnableControlAction(0, 200, true)
                EnableControlAction(0, 178, true)
                
                if GetEntityHealth(playerPed) <= 0 then
                    DisableControlAction(0, 249)
                elseif GetEntityHealth(playerPed) >= 1 then
                    EnableControlAction(0, 249)
                end
                if not isBeingCarried then 
                    if not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) and ShouldPlayDeathAnimation == true then
                        ESX.Streaming.RequestAnimDict('dead', function()
                            TaskPlayAnim(playerPed, 'dead', 'dead_a', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
                        end)
                    elseif ShouldPlayDeathAnimation == false then
                        ClearPedSecondaryTask(playerPed)
                        Citizen.Wait(0)
                    end
                end
                Citizen.Wait(0)
            end          
        end
    end
end)

function Revive(playerPed)
    local playerPed = PlayerPedId()
    local formattedCoords = {x = 305.28, y = -592.68, z = 43.28}

    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('mythic_hospital:server:RequestBed')

    
    TriggerServerEvent('iG:updateLastPosition', formattedCoords)
    SetEntityCoordsNoOffset(playerPed, 305.28, -592.68, 43.28, false, false, false, true)
	NetworkResurrectLocalPlayer(305.28, -592.68, 43.28, 340.76, true, false)
    TriggerServerEvent('iG-death:setDead', false)
    TriggerEvent('iG-death:onPlayerRevive')

    isDead = false
    ShouldPlayDeathAnimation = false
    SetEntityInvincible(playerPed, false)
    SetEntityAlpha(playerPed, 255)
    SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))
    ClearPedBloodDamage(playerPed)
    
    TriggerEvent('iG_Status:set', 'hunger', 1000000)
    TriggerEvent('iG_Status:set', 'thirst', 1000000)
    TriggerEvent('iG_Status:set', 'stress', 0)
	TriggerEvent('mythic_hospital:client:ResetLimbs', playerPed)
    TriggerEvent('mythic_hospital:client:RemoveBleed', playerPed)
    
    RemoveItemsAfterRPDeath()
    
    DoScreenFadeIn(3000)

    ESX.Streaming.RequestAnimDict('get_up@directional@movement@from_knees@action', function()
        TaskPlayAnim(playerPed, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    end)
    while IsScreenFadingIn() do
        Citizen.Wait(100)
    end
    ClearPedTasksImmediately(playerPed)
    ClearPedSecondaryTask(playerPed)
    ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('iG-death:revive')
AddEventHandler('iG-death:revive', function()
    local playerPed = PlayerPedId()
    DoScreenFadeOut(200)
    while IsScreenFadingOut() do
        Citizen.Wait(100)
    end
    Revive(playerPed)
end)

RegisterNetEvent('iG-death:heal')
AddEventHandler('iG-death:heal', function()
    local playerPed = PlayerPedId()
    Heal(playerPed)
end)

function Heal(playerPed)
    local playerPed = PlayerPedId()

    isDead = false
    ShouldPlayDeathAnimation = false
    SetEntityAlpha(playerPed, 255)

    SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))

    ClearPedBloodDamage(playerPed)
    
    TriggerEvent('iG_Status:set', 'hunger', 1000000)
    TriggerEvent('iG_Status:set', 'thirst', 1000000)
    TriggerEvent('iG_Status:set', 'stress', 0)
	TriggerEvent('mythic_hospital:client:ResetLimbs', playerPed)
    TriggerEvent('mythic_hospital:client:RemoveBleed', playerPed)

    ClearPedTasksImmediately(playerPed)
    ClearPedSecondaryTask(playerPed)
    ESX.UI.Menu.CloseAll()
end


function RemoveItemsAfterRPDeath()
	TriggerServerEvent('iG-ambulancejob:setDeathStatus', false)
	Citizen.CreateThread(function()
		ESX.TriggerServerCallback('iG-ambulancejob:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('loadout', {})
		end)
	end)
end