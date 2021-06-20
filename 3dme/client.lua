-- -- Settings
-- local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
-- local diceColor = { r = 10, g = 255, b = 255, alpha = 255 } -- Color of the text 
-- local font = 0 -- Font of the text
-- local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
-- local background = {
--     enable = true,
--     color = { r = 35, g = 35, b = 35, alpha = 200 },
-- }
-- local chatMessage = true
-- local dropShadow = false

-- -- Don't touch
-- local nbrDisplaying = 1

-- ESX = nil
-- local playerLoaded = false

-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
--         Citizen.Wait(0)
--     end
--     while ESX.GetPlayerData().job == nil do
--         Citizen.Wait(10)
--     end

--     ESX.PlayerData = ESX.GetPlayerData()
-- end)

-- RegisterNetEvent("iG:playerLoaded")
-- AddEventHandler('iG:playerLoaded', function()
--     playerLoaded = true
-- end)

-- RegisterCommand('me', function(source, args)
--     local text = '*' -- edit here if you want to change the language : EN: the person / FR: la personne
--     for i = 1,#args do
--         text = text .. ' ' .. args[i]
--     end
--     text = text .. ' *'
--     TriggerServerEvent('3dme:shareDisplay', text)
-- end)

-- RegisterNetEvent('3dme:triggerDisplay')
-- AddEventHandler('3dme:triggerDisplay', function(text, source)
--     local offset = 1 + (nbrDisplaying*0.14)
--     Display(GetPlayerFromServerId(source), text, offset)
-- end)

-- RegisterNetEvent('3dme:triggerDice')
-- AddEventHandler('3dme:triggerDice', function(text, source)
--     local offset = 1 + (nbrDisplaying*0.14)
--     DisplayDice(GetPlayerFromServerId(source), text, offset)
-- end)

-- function Display(mePlayer, text, offset)
--     local displaying = true

--     --[[ Chat message
--     if chatMessage then
--         local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
--         local coords = GetEntityCoords(PlayerPedId(), false)
--         local dist = Vdist2(coordsMe, coords)
--         if dist < 2500 then
--             TriggerEvent('chat:addMessage', {
--                 color = { color.r, color.g, color.b },
--                 multiline = true,
--                 args = { text}
--             })
--         end
--     end
--     ]]--

--     Citizen.CreateThread(function()
--         Wait(time)
--         displaying = false
--     end)
--     Citizen.CreateThread(function()
--         nbrDisplaying = nbrDisplaying + 1
--         print(nbrDisplaying)
--         while displaying do
--             Wait(0)
--             local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
--             local coords = GetEntityCoords(PlayerPedId(), false)
--             local dist = Vdist2(coordsMe, coords)
--             if dist < 2500 then
--                 DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
--             end
--         end
--         nbrDisplaying = nbrDisplaying - 1
--     end)
-- end

-- function DrawText3D(x,y,z, text)
--     local onScreen,_x,_y = World3dToScreen2d(x,y,z)
--     local px,py,pz = table.unpack(GetGameplayCamCoord())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

--     local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

--     if onScreen then

--         -- Formalize the text
--         SetTextColour(color.r, color.g, color.b, color.alpha)
--         SetTextScale(0.0*scale, 0.55*scale)
--         SetTextFont(font)
--         SetTextProportional(1)
--         SetTextCentre(true)
--         if dropShadow then
--             SetTextDropshadow(10, 100, 100, 100, 255)
--         end

--         -- Calculate width and height
--         BeginTextCommandWidth("STRING")
--         AddTextComponentString(text)
--         local height = GetTextScaleHeight(0.55*scale, font)
--         local width = EndTextCommandGetWidth(font)

--         -- Diplay the text
--         SetTextEntry("STRING")
--         AddTextComponentString(text)
--         EndTextCommandDisplayText(_x, _y)

--         -- if background.enable then
--         --     DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
--         -- end
--     end
-- end

-- function DisplayDice(mePlayer, text, offset)
--     local displaying = true

--     --[[ Chat message
--     if chatMessage then
--         local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
--         local coords = GetEntityCoords(PlayerPedId(), false)
--         local dist = Vdist2(coordsMe, coords)
--         if dist < 2500 then
--             TriggerEvent('chat:addMessage', {
--                 color = { color.r, color.g, color.b },
--                 multiline = true,
--                 args = { text}
--             })
--         end
--     end
--     ]]--

--     Citizen.CreateThread(function()
--         Wait(time)
--         displaying = false
--     end)
--     Citizen.CreateThread(function()
--         nbrDisplaying = nbrDisplaying + 1
--         print(nbrDisplaying)
--         while displaying do
--             Wait(0)
--             local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
--             local coords = GetEntityCoords(PlayerPedId(), false)
--             local dist = Vdist2(coordsMe, coords)
--             if dist < 2500 then
--                 DrawDiceText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
--             end
--         end
--         nbrDisplaying = nbrDisplaying - 1
--     end)
-- end

-- function DrawDiceText3D(x,y,z, text)
--     local onScreen,_x,_y = World3dToScreen2d(x,y,z)
--     local px,py,pz = table.unpack(GetGameplayCamCoord())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

--     local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

--     if onScreen then

--         -- Formalize the text
--         SetTextColour(diceColor.r, diceColor.g, diceColor.b, diceColor.alpha)
--         SetTextScale(0.0*scale, 0.55*scale)
--         SetTextFont(font)
--         SetTextProportional(1)
--         SetTextCentre(true)
--         if dropShadow then
--             SetTextDropshadow(10, 100, 100, 100, 255)
--         end

--         -- Calculate width and height
--         BeginTextCommandWidth("STRING")
--         AddTextComponentString(text)
--         local height = GetTextScaleHeight(0.55*scale, font)
--         local width = EndTextCommandGetWidth(font)

--         -- Diplay the text
--         SetTextEntry("STRING")
--         AddTextComponentString(text)
--         EndTextCommandDisplayText(_x, _y)
--         DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
--     end
-- end

-- ## 3dme : client side

-- ## Variables
local pedDisplaying = {}

-- ## Functions

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    local c = Config.visual.color
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextScale(0.0, Config.visual.scale * scale)
    SetTextFont(Config.visual.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- ## Events


RegisterNetEvent('3dme:triggerDice')
AddEventHandler('3dme:triggerDice', function(text, source)
    DisplayDice(GetPlayerFromServerId(source), text)
end)


-- Share the display of 3D text
RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)

local LANGUAGE = Config.language
TriggerEvent('chat:addSuggestion', '/' .. Languages[LANGUAGE].commandName, Languages[LANGUAGE].commandDescription, Languages[LANGUAGE].commandSuggestion)