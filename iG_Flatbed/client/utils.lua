-- if Config.ESXJobs then
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end

        PlayerLoaded = true
        ESX.PlayerData = ESX.GetPlayerData()
    end)

    RegisterNetEvent('iG:playerLoaded')
    AddEventHandler('iG:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
    end)

    RegisterNetEvent('iG:setJob')
    AddEventHandler('iG:setJob', function(job)
        ESX.PlayerData.job = job
    end)
-- end

--allowed() is the function that determines if the player is allowed to use the dyno. DO NOT RENAME THE FUNCTION
--Place whatever job check code you want in here, return true if allowed, false if not
function allowed()

    if (Config.ESXJobs and has_value(Config.Jobs,ESX.PlayerData.job.name)) or (not Config.ESXJobs) then
        return true
    else
        return false
    end

end