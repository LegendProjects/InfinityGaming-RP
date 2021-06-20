local PlayerData = {}
ESX = nil
local hasBodycam = false
local daner, job 

Citizen.CreateThread(function()
    
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    
end)

RegisterNetEvent("ig_Bodycam:show")
AddEventHandler("ig_Bodycam:show", function(incdaner, incjob)
    daner = incdaner
    job = incjob
    hasBodycam = true
end)

RegisterNetEvent("ig_Bodycam:close")
AddEventHandler("ig_Bodycam:close", function()
    hasBodycam = false
    SendNUIMessage({
        open = false
    })
end)

Citizen.CreateThread(function()
    while true do
        if hasBodycam then 
            local year , month, day , hour , minute , second  = GetLocalTime()

            if string.len(tostring(minute)) < 2 then
                minute = '0' .. minute
            end
            if string.len(tostring(second)) < 2 then
                second = '0' .. second
            end

            SendNUIMessage({
                date = day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second,
                daneosoby = job .. ' ' .. daner,
                open = true,
            })
        end
        Citizen.Wait(5000)
    end
end)