-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1200

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == 60 then
						TriggerEvent("chatMessage", "[WARNING]", {255, 0, 0}, "You'll be kicked in " .. time .. " seconds for being AFK!")
					end

					if kickWarning and time == 120 then
						TriggerEvent("chatMessage", "[WARNING]", {255, 0, 0}, "You'll be kicked in " .. time .. " seconds for being AFK!")
					end

					if kickWarning and time == 300 then
						TriggerEvent("chatMessage", "[WARNING]", {255, 0, 0}, "You'll be kicked in 5 minutes for being AFK!")
					end

					if kickWarning and time == 600 then
						TriggerEvent("chatMessage", "[WARNING]", {255, 0, 0}, "You'll be kicked in 10 minutes for being AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)