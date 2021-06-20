------------------------------------------------------------------
-- Need to be changed to your framework, for now default is ESX --
------------------------------------------------------------------
PlayerData = {}
ESX = nil

CreateThread(function()
	local breakMe = 0
    while ESX == nil do
        Wait(100)
		breakMe = breakMe + 1
        TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		if breakMe > 10 then
			break
		end
    end
	if ESX then
		if ESX.IsPlayerLoaded() then
			PlayerData = ESX.GetPlayerData()
		end
	end
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    PlayerData.job = job
end)

function isAtJob(name)
	if ESX then
		return PlayerData.job.name == name
	end
	return false
end

------------------------
-- Optional to change --
------------------------

function showNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

-- display custom marker/Text whatever
--- @pos vector3
--- @name string
-- Will be called every tick if close.
function DisplayMarker(pos, name)
	DrawMarker(31, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, false, false, false, false)
	DrawMarker(20, pos.x, pos.y, pos.z - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, true, false, false, false)
	DrawMarker(25, pos.x, pos.y, pos.z - 0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end
