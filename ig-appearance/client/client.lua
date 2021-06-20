ESX = nil 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local enabled = false
local player = false
local firstChar = false
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local isService = false;


function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair()
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal()
    })
    SendNUIMessage({
        type = "barbermenu",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData()
    })
    SendNUIMessage({
        type = "clothesmenudata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoomenu",
        totals = tatCategory,
        values = GetTats()
    })
end

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == GetHashKey('mp_f_freemode_01') or model == GetHashKey('mp_m_freemode_01')) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(
            player,
            i-1,
            propZ,
            propTextures[i][2], true)
    end
end

function GetSkinTotal()
    -- print(#frm_skins)
	return {
        #frm_skins,
        #fr_skins
    }
end

local toggleClothing = {}
function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

function LoadPed(data)
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    return
end

function GetCurrentPed()
    player = GetPlayerPed(-1)
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
    }
end

function PlayerModel(data)
    local skins = nil
    if (data['name'] == 'skin_male') then
        skins = frm_skins
    else
        skins = fr_skins
    end
    local skin = skins[tonumber(data['value'])]
    rotation(180.0)
    SetSkin(GetHashKey(skin), true)
    Citizen.Wait(1)
    rotation(180.0)
end

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = GetPlayerPed(-1)
        FreezePedCameraRotation(player, true)
        if setDefault and model ~= nil and not isCustomSkin(model) then
            if (model ~= GetHashKey('mp_f_freemode_01') and model ~= GetHashKey('mp_m_freemode_01')) then
                SetPedRandomComponentVariation(GetPlayerPed(-1), true)
            else
                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 1, 2, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
            end
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
end


RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(
                player,
                tonumber(selectedValue),
                tonumber(data["value"]),
                tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins() then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(GetHashKey(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
end)


------------------------------------------------------------------------------------------
-- Barber

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    SetPedHeadBlendData(player,
        tonumber(data['shapeFirst']),
        tonumber(data['shapeSecond']),
        tonumber(data['shapeThird']),
        tonumber(data['skinFirst']),
        tonumber(data['skinSecond']),
        tonumber(data['skinThird']),
        tonumber(data['shapeMix']),
        tonumber(data['skinMix']),
        tonumber(data['thirdMix']),
        false)
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end


RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    tonumber(data.shapeThird),
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    tonumber(data.thirdMix) / 100, false)
    cb('ok')
end)

RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    local index = has_value(face_features, data["name"])
    if (index <= -1) then return end
    local scale = tonumber(data["scale"]) / 100
    SetPedFaceFeature(player, index, scale)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlay', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)


RegisterCommand("outfitadd", function(source, args, rawCommand)
    if (IsNearShop(clothingShops) < 9.0) or (IsNearShop(cloakrooms) < 9.0) then
        if args[1] and args[2] then
            TriggerEvent('ig-appearance:outfits', 1, tonumber(args[1]), args[2])
        else
           exports['mythic_notify']:SendAlert('inform', 'You need to do something like /outfitadd 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
        end
    else
       exports['mythic_notify']:SendAlert('error', "Error: You're not close enough to a changeroom.")
    end
end, false)

RegisterCommand("outfituse", function(source, args, rawCommand)
    if (IsNearShop(clothingShops) < 9.0) or (IsNearShop(cloakrooms) < 9.0) then
        if args[1] then
            TriggerEvent('ig-appearance:outfits', 3, tonumber(args[1]))

        --  TriggerEvent("facewear:adjust",5,false)
         TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)

        else
            exports['mythic_notify']:SendAlert('inform', 'You need to do something like /oufituse 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
        end
    else
        TriggerServerEvent("ig-appearance:list_outfits")
        exports['mythic_notify']:SendAlert('error', "Error: You're not close enough to a changeroom.")
    end
end, false) 

RegisterCommand("removeoutfit", function(source, args, rawCommand)
    if (IsNearShop(clothingShops) < 9.0) or (IsNearShop(cloakrooms) < 9.0)then
        if args[1] then
            TriggerEvent('ig-appearance:outfits', 2, tonumber(args[1]))
        else
            exports['mythic_notify']:SendAlert('inform', 'You need to do something like /removeoutfit 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
        end
    else
        exports['mythic_notify']:SendAlert('error', "Error: You're not close enough to a changeroom.")
    end
end, false) 




RegisterCommand('outfits', function(source, args, raw)
    -- local nearcloth = IsNearShop(clothingShops)
    -- local coord = GetEntityCoords(source)
    if (IsNearShop(clothingShops) < 9.0) or (IsNearShop(cloakrooms) < 9.0) then
        TriggerServerEvent("ig-appearance:list_outfits")
    else
        exports['mythic_notify']:SendAlert('error', "Error: You're not close enough to a changeroom.")
    end

end, false)

-- RegisterCommand('dev_createChar', function(source, args, raw)
--    TriggerEvent("ig-appearance:createCharacter")
-- end, false)

-- RegisterCommand('dev_ClothesMenu', function(source, args, raw)
--    OpenMenu("clothesmenu")
-- end, false)

-- RegisterCommand('dev_BarberMenu', function(source, args, raw)
--    OpenMenu("barbermenu")
-- end, false)

RegisterCommand('debug_loadSkin', function(source, args, raw)
   TriggerServerEvent("ig-appearance:get_character_current")
end, false)
RegisterCommand('debug_saveSkin', function(source, args, raw)
   TriggerServerEvent('iG_skin:save', GetCurrentPed())
end, false)
-- TriggerServerEvent('iG_skin:save', GetCurrentPed())


-- RegisterNetEvent('ig-appearance:openClothingMenu')
-- AddEventHandler('ig-appearance:openClothingMenu', function()
--     OpenMenu("clothesmenu")
-- end)
----------------------------------------------------------------------------------
-- UTIL SHIT


function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu)
    enabled = enable
    SetNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableclothesmenu",
        enable = enable,
        menu = menu,
        isService = isService,
    })

    if (not enable) then
        SaveToggleProps()
        oldPed = {}
    end
end

function CustomCamera(position)
    if customCam or position == "torso" then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        RenderScriptCams(false,  false,  0,  true,  true)
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        local pos = GetEntityCoords(player, true)
        SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, player)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        SwitchCam(position)
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    SetCamRot(cam, 0.0, 0.0, 180.0)
end

RegisterNetEvent("ig-appearance:close")
AddEventHandler("ig-appearance:close", function()
    EnableGUI(false, false)
end)

RegisterNUICallback('escape', function(data, cb)
    -- TriggerServerEvent("Police:getMeta")
    Save(data['save'])
    EnableGUI(false, false)
    cb('ok')
end)

RegisterNUICallback('togglecursor', function(data, cb)
    CustomCamera("torso")
    -- SetNuiFocus(false, false)
    FreezePedCameraRotation(player, false)
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)


------------------------------------------------------------------------
-- Tattooooooos


-- currentTats [[collectionHash, tatHash], [collectionHash, tatHash]]
-- loop tattooHashList [categ] find [tatHash, collectionHash]

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    currentTats = {}
    for k, v in pairs(data) do
        for categ in pairs(tattooHashList) do
            if k == categ then
                local something = tattooHashList[categ][tonumber(v)]
                if something ~= nil then
                    table.insert(currentTats, {something[2], something[1]})
                end
            end
        end
    end
    ClearPedDecorations(PlayerPedId())
    for i = 1, #currentTats do
        ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    end
end

RegisterNUICallback('settats', function(data, cb)
    SetTats(data["tats"])
    cb('ok')
end)


--------------------------------------------------------------------
-- Main menu

function OpenMenu(name)
    player = GetPlayerPed(-1)
    oldPed = GetCurrentPed()
    FreezePedCameraRotation(player, true)
    RefreshUI()
    EnableGUI(true, name)
end

function Save(save)
    if save then
        data = GetCurrentPed()
        TriggerServerEvent("ig-appearance:insert_character_current", data)
        if data.model == GetHashKey('mp_f_freemode_01') or data.model == GetHashKey('mp_m_freemode_01') then
            TriggerServerEvent("ig-appearance:insert_character_face", data)
        end
    else
        LoadPed(oldPed)
    end
    CustomCamera('torso')
end

function IsNearShop(shops)
    local dstchecked = 1000
    local plyPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	for i = 1, #shops do
		shop = shops[i]
		local comparedst = Vdist(plyPos.x, plyPos.y, plyPos.z,shop[1], shop[2], shop[3])
		if comparedst < dstchecked then
			dstchecked = comparedst
		end

		if comparedst < 5.0 then
			DrawMarker(27,shop[1], shop[2], shop[3], 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.7001, 0, 55, 240, 20, 0, 0, 0, 0)
		end
	end
	return dstchecked
end

-- local showBarberShopBlips = true

-- RegisterNetEvent('hairDresser:ToggleHair')
-- AddEventHandler('hairDresser:ToggleHair', function()
--     showBarberShopBlips = not showBarberShopBlips
--    for _, item in pairs(barberShops) do
--         if not showBarberShopBlips then
--             if item.blip ~= nil then
--                 RemoveBlip(item.blip)
--             end
--         else
--             item.blip = AddBlipForCoord(item[1], item[2], item[2])
--             SetBlipSprite(item.blip, 71)
--             SetBlipColour(item.blip, 1)
--             SetBlipAsShortRange(item.blip, true)
--             BeginTextCommandSetBlipName("STRING")
--             AddTextComponentString("Cosmetics: Barbershop")
--             EndTextCommandSetBlipName(item.blip)
--         end
--     end
-- end)


Citizen.CreateThread(function()
    for _, item in pairs(barberShops) do
        item.blip = AddBlipForCoord(item[1], item[2], item[2])
        SetBlipSprite (item.blip, 71)
		SetBlipColour (item.blip, 51)
		SetBlipAsShortRange(item.blip, true)
		SetBlipScale(item.blip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cosmetics: Barbershop")
        EndTextCommandSetBlipName(item.blip)
    end
    for _, item in pairs(clothingShops) do
        item.blip = AddBlipForCoord(item[1], item[2], item[2])
        SetBlipSprite (item.blip, 73)
		SetBlipColour (item.blip, 47)
		SetBlipAsShortRange(item.blip, true)
		SetBlipScale(item.blip, 0.7)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cosmetics: Clothing Store")
        EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
    -- addBlips()
	while true do
		Citizen.Wait(1)
        InvalidateIdleCam()
        local nearcloth = IsNearShop(clothingShops)
        local nearcloak = IsNearShop(cloakrooms)
        -- local nearheal = IsNearShop(healingShops)
        -- local neartat = IsNearShop(tattoosShops)
        local nearbarber = IsNearShop(barberShops)
        -- local jailcheck = GetInteriorFromEntity(GetPlayerPed(PlayerId()))

        local StoreCost = 400;

        local menu = nil

        if nearcloth < 5.0 then
            menu = {"clothesmenu", "Press ~INPUT_CONTEXT~ to access the clothing store."}
        elseif nearcloak < 2.5 then
            menu = {"clothesmenu", "Press ~INPUT_CONTEXT~ to access the cloakroom."}
        elseif nearbarber < 5.0 then
            menu = {"barbermenu", "Press ~INPUT_CONTEXT~ to access the barbershop."}
        elseif startingMenu then
            menu = "clothesmenu"
        end

        if (menu ~= nil) then

            if menu[1] == "healmenu" then
                if IsControlJustPressed(1, 188) then
                    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
                end
            end

            if (not enabled) then
                DisplayHelpText(menu[2])

                if IsControlJustPressed(1, 51) then
                    OpenMenu(menu[1])
                end
            else
                if (IsControlJustReleased(1, 25)) then
                    SetNuiFocus(true, true)
                    FreezePedCameraRotation(player, true)
                end
                InvalidateIdleCam()
            end
        else
            local dist = math.min(nearcloth, nearcloak, nearbarber)
            if dist > 10 then
                Citizen.Wait(math.ceil(dist * 10))
            end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if enabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("ig-appearance:inService")
AddEventHandler("ig-appearance:inService", function(service)
    isService = service
end)


RegisterNetEvent("ig-appearance:hasEnough")
AddEventHandler("ig-appearance:hasEnough", function(menu)
    if menu == "tattoomenu" then
        TriggerServerEvent("ig-appearance:retrieve_tats")
        while currentTats == nil do
            Citizen.Wait(1)
        end
    end

    OpenMenu(menu)
end)

RegisterNetEvent("ig-appearance:setclothes")
AddEventHandler("ig-appearance:setclothes", function(data,alreadyExist)
    player = GetPlayerPed(-1)
    local function setDefault()
        Citizen.CreateThread(function()
            firstChar = true
            Citizen.Wait(5000)
            TriggerEvent('iG_skinchanger:getSkin', function(skin)
                if skin.sex ~= 0 then
                    SetSkin(GetHashKey('mp_f_freemode_01'), true)
                else
                    SetSkin(GetHashKey('mp_m_freemode_01'), true)
                end
            end)
            OpenMenu("clothesmenu")
            startingMenu = true
            SetEntityCoords(PlayerPedId(),-1038.2766113281 + (math.random(200) / 100),-2738.2648925781 + (math.random(200) / 100),20.169269561768)
            SetEntityHeading(PlayerPedId(),328.30828857422)
            DoScreenFadeIn(50)
            -- TriggerServerEvent("server-request-update",exports["isPed"]:isPed("cid"))
            -- Wait(5000)
            -- if not exports["np-inventory"]:hasEnoughOfItem("idcard",1,false) then
            --     TriggerEvent("player:receiveItem","idcard",1,true)
            -- end
            -- if not exports["np-inventory"]:hasEnoughOfItem("mobilephone",1,false)then
            --     TriggerEvent("player:receiveItem","mobilephone",1)
            -- end
            -- TriggerEvent("tokovoip:onPlayerLoggedIn", true)
            -- TriggerEvent("customNotification","Looks like you picked a character, nice job! You have a Hotel booked in the city, type /phone or press P to call a Taxi, Or, if you see one, hit F to jump inside it(this works anywhere). Once in the Taxi, mark the location on the map where you want to go for free! (Hotel 1).")
            SetNewWaypoint(312.96966552734,-218.2705078125)
            local dstHt = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(312.96966552734,-218.2705078125,54.221797943115))

            while dstHt > 50.0 do
                dstHt = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(312.96966552734,-218.2705078125,54.221797943115))
                Citizen.Wait(1)
            end
        end)
    end

	if not data.model and alreadyExist <= 0 then setDefault() return end
    if not data.model and alreadyExist >= 1 then return end
    model = data.model
    model = model ~= nil and tonumber(model) or false

	if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
    SetSkin(model, false)
    Citizen.Wait(500)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
    TriggerServerEvent("ig-appearance:get_character_face")
end)

RegisterNetEvent("ig-appearance:AdminSetModel")
AddEventHandler("ig-appearance:AdminSetModel", function(model)
    local hashedModel = GetHashKey(model)
    if not IsModelInCdimage(hashedModel) or not IsModelValid(hashedModel) then return end
    SetSkin(hashedModel, true)
end)


RegisterNetEvent("ig-appearance:defaultReset")
AddEventHandler("ig-appearance:defaultReset", function()
    local gender = 0
    TriggerEvent('iG_skinchanger:getSkin', function(skin)
        gender = skin.sex
    end)
    Citizen.Wait(1000)
    if gender ~= 0 then
        SetSkin(GetHashKey('mp_f_freemode_01'), true)
    else
        SetSkin(GetHashKey('mp_m_freemode_01'), true)
    end
    SetPedHeadBlendData(PlayerPedId(), 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
    OpenMenu("clothesmenu")
    startingMenu = true
end)

RegisterNetEvent("ig-appearance:createCharacter")
AddEventHandler("ig-appearance:createCharacter", function(gender)
    if gender ~= "m" then
        SetSkin(GetHashKey('mp_f_freemode_01'), true)
    else
        SetSkin(GetHashKey('mp_m_freemode_01'), true)
    end
    Citizen.Wait(1000)
    SetPedHeadBlendData(PlayerPedId(), 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
    --menu = "clothesmenu"
    OpenMenu("barbermenu")
    -- startingMenu = true
    TriggerServerEvent('iG_skin:save', GetCurrentPed())
end)

RegisterNetEvent('hotel:list')
AddEventHandler('hotel:list', function(skincheck)
    for i = 1, #skincheck do
        exports['mythic_notify']:SendAlert('inform', skincheck[i].slot.."  |  "..skincheck[i].name)
	end
end)


RegisterNetEvent("ig-appearance:settattoos")
AddEventHandler("ig-appearance:settattoos", function(playerTattoosList)
    currentTats = playerTattoosList
    SetTats(GetTats())
end)

RegisterNetEvent("ig-appearance:setpedfeatures")
AddEventHandler("ig-appearance:setpedfeatures", function(data)
    player = GetPlayerPed(-1)
    if data == false then
        SetSkin(GetEntityModel(PlayerPedId()), true)
        return
    end
    local head = data.headBlend
    local haircolor = data.hairColor

    SetPedHeadBlendData(player,
        tonumber(head['shapeFirst']),
        tonumber(head['shapeSecond']),
        tonumber(head['shapeThird']),
        tonumber(head['skinFirst']),
        tonumber(head['skinSecond']),
        tonumber(head['skinThird']),
        tonumber(head['shapeMix']),
        tonumber(head['skinMix']),
        tonumber(head['thirdMix']),
        false)
    SetHeadStructure(data.headStructure)
    SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
    SetHeadOverlayData(data.headOverlay)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


RegisterNetEvent('ig-appearance:outfits')
AddEventHandler('ig-appearance:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("ig-appearance:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("ig-appearance:remove_outfit",pId)
    elseif pAction == 3 then 
        -- TriggerEvent('item:deleteClothesDna')
        TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
        TriggerServerEvent("ig-appearance:get_outfit", pId)
    else
        TriggerServerEvent("ig-appearance:list_outfits")
    end
end)


-- LoadPed(data) Sets clothing based on the data structure given, the same structure that GetCurrentPed() returns
-- GetCurrentPed() Gives you the data structure of the currently worn clothes

RegisterNetEvent('ig-appearance:loadSkinchanger')
AddEventHandler('ig-appearance:loadSkinchanger', function()
     ESX.TriggerServerCallback('iG_skin:getPlayerSkin', function(skin)
        if skin ~= nil then
            TriggerEvent('iG_skinchanger:loadSkin', skin)
        else
            print('skin nil')
        end
    end)
end)

RegisterNetEvent('ig-appearance:MultiCharSkin')
AddEventHandler('ig-appearance:MultiCharSkin', function(ped, skin)
         -----SKIN-------
        if ped then
            if skin then
                if skin['skin'] ~= nil then
                    for i = 1, #drawable_names do
                        if skin['skin'].drawables[0] == nil then
                            if drawable_names[i] == "undershirts" and skin['skin'].drawables[tostring(i-1)][2] == -1 then
                                SetPedComponentVariation(ped, i-1, 15, 0, 2)
                            else
                                SetPedComponentVariation(ped, i-1, skin['skin'].drawables[tostring(i-1)][2], skin['skin'].drawtextures[i][2], 2)
                            end
                        else
                            if drawable_names[i] == "undershirts" and skin['skin'].drawables[i-1][2] == -1 then
                                SetPedComponentVariation(ped, i-1, 15, 0, 2)
                            else
                                SetPedComponentVariation(ped, i-1, skin['skin'].drawables[i-1][2], skin['skin'].drawtextures[i][2], 2)
                            end
                        end
                    end
                for i = 1, #prop_names do
                    local propZ = (skin['skin'].drawables[0] == nil and skin['skin'].props[tostring(i-1)][2] or skin['skin'].props[i-1][2])
                    ClearPedProp(ped, i-1)
                    SetPedPropIndex(ped,i-1,propZ,skin['skin'].proptextures[i][2], true)
                end
                Citizen.Wait(500)
                if skin['skin'].model == 1885233650 or skin['skin'].model == -1667301416 then
                    -----FACE-------
                    if skin['face'] ~= nil then
                        SetPedHairColor(ped, tonumber(skin['face'].hairColor[1]), tonumber(skin['face'].hairColor[2]))
                        SetPedHeadBlendData(ped,
                            tonumber(skin['face'].headBlend['shapeFirst']),
                            tonumber(skin['face'].headBlend['shapeSecond']),
                            tonumber(skin['face'].headBlend['shapeThird']),
                            tonumber(skin['face'].headBlend['skinFirst']),
                            tonumber(skin['face'].headBlend['skinSecond']),
                            tonumber(skin['face'].headBlend['skinThird']),
                            tonumber(skin['face'].headBlend['shapeMix']),
                            tonumber(skin['face'].headBlend['skinMix']),
                            tonumber(skin['face'].headBlend['thirdMix']),
                        false)

                        for i = 1, #face_features do
                            SetPedFaceFeature(ped, i-1, skin['face'].headStructure[i])
                        end
                        if json.encode(skin['face'].headOverlay) ~= "[]" then
                            for i = 1, #head_overlays do
                                if skin['face'].headOverlay[i].name == "eyecolor" then
                                    SetPedEyeColor(ped, tonumber(skin['face'].headOverlay[i].val))
                                else
                                    SetPedHeadOverlay(ped,  i-1, tonumber(skin['face'].headOverlay[i].overlayValue),  tonumber(skin['face'].headOverlay[i].overlayOpacity))
                                end
                            end

                            SetPedHeadOverlayColor(ped, 0, 0, tonumber(skin['face'].headOverlay[1].firstColour), tonumber(skin['face'].headOverlay[1].secondColour))
                            SetPedHeadOverlayColor(ped, 1, 1, tonumber(skin['face'].headOverlay[2].firstColour), tonumber(skin['face'].headOverlay[2].secondColour))
                            SetPedHeadOverlayColor(ped, 2, 1, tonumber(skin['face'].headOverlay[3].firstColour), tonumber(skin['face'].headOverlay[3].secondColour))
                            SetPedHeadOverlayColor(ped, 3, 0, tonumber(skin['face'].headOverlay[4].firstColour), tonumber(skin['face'].headOverlay[4].secondColour))
                            SetPedHeadOverlayColor(ped, 4, 2, tonumber(skin['face'].headOverlay[5].firstColour), tonumber(skin['face'].headOverlay[5].secondColour))
                            SetPedHeadOverlayColor(ped, 5, 2, tonumber(skin['face'].headOverlay[6].firstColour), tonumber(skin['face'].headOverlay[6].secondColour))
                            SetPedHeadOverlayColor(ped, 6, 0, tonumber(skin['face'].headOverlay[7].firstColour), tonumber(skin['face'].headOverlay[7].secondColour))
                            SetPedHeadOverlayColor(ped, 7, 0, tonumber(skin['face'].headOverlay[8].firstColour), tonumber(skin['face'].headOverlay[8].secondColour))
                            SetPedHeadOverlayColor(ped, 8, 2, tonumber(skin['face'].headOverlay[9].firstColour), tonumber(skin['face'].headOverlay[9].secondColour))
                            SetPedHeadOverlayColor(ped, 9, 0, tonumber(skin['face'].headOverlay[10].firstColour), tonumber(skin['face'].headOverlay[10].secondColour))
                            SetPedHeadOverlayColor(ped, 10, 1, tonumber(skin['face'].headOverlay[11].firstColour), tonumber(skin['face'].headOverlay[11].secondColour))
                            SetPedHeadOverlayColor(ped, 11, 0, tonumber(skin['face'].headOverlay[12].firstColour), tonumber(skin['face'].headOverlay[12].secondColour))
                        end
                    else
                        print('skin[face] is nil')
                    end

                    -----TATTOOS-------
                    if skin['tattoo'] ~= nil then
                        ClearPedDecorations(ped)
                        for i = 1, #skin['tattoo'] do
                            ApplyPedOverlay(ped, skin['tattoo'][i][1], skin['tattoo'][i][2])
                        end
                    else
                        print('skin[tattoo] is nil')
                    end
                end
            else
                print('skin[skin] is nil')
            end
        else
            print('skin is nil')
        end
    else
        print('ped is nil')
    end
end)