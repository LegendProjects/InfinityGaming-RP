---------------------------------------------------
------- Red Zone Map Blip
---------------------------------------------------

Citizen.CreateThread(function()
    ZoneBlip = AddBlipForRadius(Config.Blips.Zone.Coords.x, Config.Blips.Zone.Coords.y, Config.Blips.Zone.Coords.z, Config.Blips.Zone.Radius)
    SetBlipSprite(ZoneBlip, Config.Blips.Zone.Sprite)
    SetBlipDisplay(ZoneBlip, 8)
    SetBlipAlpha(ZoneBlip, 100)
    SetBlipColour(ZoneBlip, Config.Blips.Zone.Colour)
    SetBlipAsShortRange(ZoneBlip, true)
	SetBlipHiddenOnLegend(ZoneBlip, true)
end)

Citizen.CreateThread(function()
    MarkerBlip = AddBlipForCoord(Config.Blips.Marker.Coords.x, Config.Blips.Marker.Coords.y, Config.Blips.Marker.Coords.z)
    SetBlipSprite(MarkerBlip, Config.Blips.Marker.Sprite)
    SetBlipDisplay(MarkerBlip, 4)
    SetBlipScale(MarkerBlip, 0.5)
    SetBlipAsShortRange(MarkerBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blips.Marker.Title)
    EndTextCommandSetBlipName(MarkerBlip)
end)


---------------------------------------------------
------- isInZone
---------------------------------------------------
-- isInZone = false
-- function ig.cayo:isInZone()

--     local dist = #(GetEntityCoords(playerPedId) - vector3(Config.Blips.Zone.Coords.x, Config.Blips.Zone.Coords.y, Config.Blips.Zone.Coords.z))

--     if dist < 1450 then
--         isInZone = true
--     else
--         isInZone = false
--     end

-- end

