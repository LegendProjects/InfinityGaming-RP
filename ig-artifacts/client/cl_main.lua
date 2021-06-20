ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent("ig-artifacts:use:katanablueprint")
AddEventHandler("ig-artifacts:use:katanablueprint", function()
	local playerPed = GetPlayerPed(-1)
	-- print(IsModelInCdimage("katanablueprint"))
	-- RequestModel("katanablueprint")
	-- while not HasModelLoaded("katanablueprint") do
    --     Citizen.Wait(50)
    -- end
	exports['mythic_progbar']:Progress({
		name = "reading_blueprint",
		duration = 5000,
		label = "Reading Blueprint..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "cellphone@",
			anim = "cellphone_text_read_base",
			flags = 49,
		},
		prop = {
			model = "katanablueprint",
			bone = 6286,
			coords = { x = -0.05, y = 0.009, z = -0.065 },
			rotation = { x = 0.0, y = 165.0, z = 90.0 },
		}
	}, function(status)
		if not status then
			TriggerServerEvent('ig-artifacts:remove:katanablueprint')
		end
	end)
end)
