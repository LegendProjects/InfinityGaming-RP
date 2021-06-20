local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local prevJob = nil

--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

  ESX.PlayerData = ESX.GetPlayerData()
  prevJob = ESX.GetPlayerData().job.name
  -- print(prevJob)
end)


RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
    ESX.PlayerData.job = job

    if (prevJob ~= 'police' and ESX.PlayerData.job.name == 'police') or (prevJob ~= 'mcd' and ESX.PlayerData.job.name == 'mcd') then
      TriggerServerEvent("vy_Duty:dutyChange", "police", true)
    elseif prevJob ~= 'ambulance' and ESX.PlayerData.job.name == 'ambulance' then
      TriggerServerEvent("vy_Duty:dutyChange", "ambulance", true)
    elseif (prevJob == 'police' and ESX.PlayerData.job.name ~= 'police') or (prevJob == 'mcd' and ESX.PlayerData.job.name ~= 'mcd') then 
      TriggerServerEvent("vy_Duty:dutyChange", "police", false)
    elseif prevJob == 'ambulance' and ESX.PlayerData.job.name ~= 'ambulance' then 
      TriggerServerEvent("vy_Duty:dutyChange", "ambulance", false)
    end

    prevJob = ESX.PlayerData.job.name
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

----markers
AddEventHandler('vy_Duty:hasEnteredMarker', function (zone)
  if zone ~= nil then
    CurrentAction     = 'onoff'
    CurrentActionMsg = _U('duty')
  end
end)

AddEventHandler('vy_Duty:hasExitedMarker', function (zone)
  CurrentAction = nil
end)



-- Display markers
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local playerPed = GetPlayerPed(-1)
    local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true
    for k,v in ipairs(Config.Zones) do
      local distance
      
      local isAuthorized = IsAuthorized(v)
      local maxDistance, size, displayText = 1.25, 0.4, '[~b~E]~w~ Sign ~g~on~w~/~r~off~w~ duty.'
      
      if v.Pos then
				distance = #(playerCoords - v.Pos)
      end
      
      if distance < 10 then
        letSleep = false
      end

      if distance < maxDistance then
        if isAuthorized then
          for _,job in pairs(v.Job) do
            if ('off' ..job) == ESX.PlayerData.job.name then
              ESX.Game.Utils.DrawText3D(v.Pos, 'Press [~b~E~w~] to sign ~g~on~w~-duty.', size)
              SetTextComponentFormat('STRING')
              AddTextComponentString(CurrentActionMsg)
              DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      
              if IsControlJustPressed(0, Keys['E']) then
                if ESX.PlayerData.job.name == 'offpolice' or ESX.PlayerData.job.name == 'offmcd' then
                  TriggerServerEvent("vy_Duty:dutyChange", "police", true)
                  TriggerServerEvent('vy_Duty:onDuty')
                elseif ESX.PlayerData.job.name == 'offambulance' then
                  TriggerServerEvent("vy_Duty:dutyChange", "ambulance", true)
                  TriggerServerEvent('vy_Duty:onDuty')
                else
                  TriggerServerEvent('vy_Duty:onDuty')
                end
              end
            elseif ESX.PlayerData.job.name == job then
              ESX.Game.Utils.DrawText3D(v.Pos, 'Press [~b~E~w~] to sign ~r~off~w~-duty.', size)
              SetTextComponentFormat('STRING')
              AddTextComponentString(CurrentActionMsg)
              DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      
              if IsControlJustPressed(0, Keys['E']) then
                if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'offmcd' then
                  TriggerServerEvent("vy_Duty:dutyChange", "police", false)
                  TriggerServerEvent('vy_Duty:offDuty')
                elseif ESX.PlayerData.job.name == 'ambulance' then
                  TriggerServerEvent("vy_Duty:dutyChange", "ambulance", false)
                  TriggerServerEvent('vy_Duty:offDuty')
                else
                  TriggerServerEvent('vy_Duty:offDuty')
                end
              end
            end
          end
        end
      end
    end

    if letSleep then
      Citizen.Wait(500)
    end
    
  end
end)

function IsAuthorized(v)
	if ESX.PlayerData.job == nil then
		return false
	end

	for _,job in pairs(v.Job) do
		if ESX.PlayerData.job.name == job or ('off' ..job) == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

-- -- Enter / Exit marker events
-- Citizen.CreateThread(function ()
--   while true do
--     Wait(0)

--     local coords      = GetEntityCoords(GetPlayerPed(-1))
--     local isInMarker  = false
--     local currentZone = nil

--     for k,v in pairs(Config.Zones) do
--       if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
--         isInMarker  = true
--         currentZone = k
--       end
--     end

--     if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
--       HasAlreadyEnteredMarker = true
--       LastZone                = currentZone
--       TriggerEvent('iG_duty:hasEnteredMarker', currentZone)
--     end

--     if not isInMarker and HasAlreadyEnteredMarker then
--       HasAlreadyEnteredMarker = false
--       TriggerEvent('iG_duty:hasExitedMarker', LastZone)
--     end
--   end
-- end)