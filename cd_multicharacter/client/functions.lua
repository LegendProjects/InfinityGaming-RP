RegisterNetEvent('cd_multicharacter:ToggleNUIFocus')
AddEventHandler('cd_multicharacter:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status ~= false do
        Citizen.Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

function HandleCam(action, ped)
    if action == 'main' then
        SetFocusArea(Config.Cam.posX, Config.Cam.posY, Config.Cam.posZ, 0.0, 0.0, 0.0)
        if Config.CameraType == 'FIXED' then
            cam = CreateCamWithParams(Config.Cam.camName, Config.Cam.posX, Config.Cam.posY, Config.Cam.posZ, Config.Cam.rotX, Config.Cam.rotY, Config.Cam.rotZ, Config.Cam.fov, Config.Cam.p8, Config.Cam.p9)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 1, true, true)
        elseif Config.CameraType == 'FOCUS' then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
        end
    elseif action == 'focus' then
        SetCamCoord(cam, Config.Cam.posX, Config.Cam.posY, Config.Cam.posZ)
        PointCamAtEntity(cam, ped)
    end
end

function CheckModel(model)
    local model = math.floor(model)
    if IsModelInCdimage(model) and IsModelValid(model) then
        return true
    else
        return false
    end
end

function LoadPedModel(model, coords, heading)
    local model = math.floor(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    return CreatePed(4, model, coords.x, coords.y, coords.z, heading, false, true)
end

function LoadCollision(ped, coords)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        Citizen.Wait(1)
    end
end

function FadeOut()
    DoScreenFadeIn(3000)
end

function DrawSpotlight(pos)
    local lightPos = vector3(pos.x,pos.y,pos.z + Config.Spotlight_Size)
    local direction = pos - lightPos
    local normal = Normalize(direction)
    DrawSpotLight(lightPos.x,lightPos.y,lightPos.z, normal.x,normal.y,normal.z, 255,255,255, 100.0, Config.Spotlight_Brightness, 0.0, 25.0, 1.0)
end

function Normalize(v)
    local len = Length(v)
    return vector3(v.x / len, v.y / len, v.z / len)
end

function Length(v)
    return math.sqrt( (v.x * v.x)+(v.y * v.y)+(v.z * v.z) )
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function ScreenFade(state)
    if state == 1 then
        DoScreenFadeOut(0)
    elseif state == 2 then
        DoScreenFadeIn(20000)
    elseif state == 3 then
        DoScreenFadeIn(1000)
    elseif state == 4 then
        DoScreenFadeOut(4000)
    elseif state == 5 then
        DoScreenFadeOut(2000)
    end
end

function PlayAnimation(ped, animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

if Config.SwitchCharacters and Config.SwitchCharactersMethod.Command then
    RegisterCommand(Config.SwitchCharactersMethod.Command_name, function()
        while not IsAuthorised do Wait(0) end
        if not hasChosen then
            if Config.SwitchCharactersMethod.DistanceCheck then
                local Data = SwitchCharacter_DistanceCheck()
                if Data.InDistance then
                    SwitchCharacters()
                else
                    Notif(3, 'distance_check')
                end
            else
                SwitchCharacters()
            end
        end
    end)
end

if Config.SwitchCharacters and Config.SwitchCharactersMethod.KeyPress then
    local pausemenuopen = false
    Citizen.CreateThread(function()
        local alreadyEnteredZone = false
        local GlobalText = nil
        while true do
            wait = 5
            local inZone = false
            local Data = SwitchCharacter_DistanceCheck()
            if Data.InDistance then
                wait = 5
                inZone = true
                GlobalText = Data.Name
                if not hasChosen then
                    if IsControlJustReleased(0, Config.SwitchCharactersMethod.Key) then
                        SwitchCharacters()
                        Wait(5000)
                    end
                end
                if not pausemenuopen and IsPauseMenuActive() then
                    pausemenuopen = true
                    TriggerEvent('cd_drawtextui:HideUI')
                elseif pausemenuopen and not IsPauseMenuActive() then
                    pausemenuopen = false
                    TriggerEvent('cd_drawtextui:ShowUI', 'show', GlobalText)
                end
            else
                wait = 1000
            end
            if not pausemenuopen then
                if inZone and not alreadyEnteredZone then
                    alreadyEnteredZone = true
                    TriggerEvent('cd_drawtextui:ShowUI', 'show', GlobalText)
                end
                if not inZone and alreadyEnteredZone then
                    alreadyEnteredZone = false
                    TriggerEvent('cd_drawtextui:HideUI')
                end
                GlobalText_last = GlobalText
            end
            Citizen.Wait(wait)
        end
    end)
end

function SwitchCharacter_DistanceCheck()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local inZone = false
    for cd = 1, #Config.Locations do
        local dist = #(coords-vector3(Config.Locations[cd].x, Config.Locations[cd].y, Config.Locations[cd].z))
        if dist <= Config.Locations[cd].Dist then
            return {InDistance = true, Name = Config.Locations[cd].Name}
        end
    end
    return {InDistance = false}
end

if Config.SwitchCharacters and (Config.SwitchCharactersMethod.KeyPress or (Config.SwitchCharactersMethod.Command and Config.SwitchCharactersMethod.DistanceCheck)) then
    Citizen.CreateThread(function()
        Wait(1000)
        for k, v in pairs (Config.Locations) do
            if v.EnableBlip then
                local blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(blip, Config.Blip.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, Config.Blip.scale)
                SetBlipColour(blip, Config.Blip.colour)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(Config.Blip.name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end)
end

function L(l)
    return Locales[Config.Language][l]
end