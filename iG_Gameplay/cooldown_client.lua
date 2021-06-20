local cooldown = 0
local ispriority = false
local ishold = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(100)
    end

    TriggerServerEvent("iG-Cooldown:checkEvents")
end)

-- RegisterCommand("resetpcd", function()
--     TriggerServerEvent("cancelcooldown")
-- end, false)

RegisterNetEvent('UpdateCooldown')
AddEventHandler('UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterNetEvent('UpdatePriority')
AddEventHandler('UpdatePriority', function(newispriority)
    ispriority = newispriority
end)

RegisterNetEvent('UpdateHold')
AddEventHandler('UpdateHold', function(newishold)
    ishold = newishold
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1500
		if ishold == true then
			DrawText2("Priority Cooldown: ~b~Priorities Are On Hold")
            sleep = 0
        elseif ispriority == false and cooldown > 0 then
            DrawText2("Priority Cooldown: ~r~".. cooldown .." ~w~Min(s)")
            sleep = 0
		elseif ispriority == true then
            DrawText2("Priority Cooldown: ~g~Priority In Progress")
            sleep = 0
        end
        Citizen.Wait(sleep)
	end
end)

function DrawText2(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.20)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.157, 0.9785)
end

RegisterNetEvent('iG-Cooldown:registerEvent')
AddEventHandler('iG-Cooldown:registerEvent', function(cooldown_s, ispriority_s, ishold_s)
    cooldown = cooldown_s
    ispriority = ispriority_s
    ishold = ishold_s
end)