
local safeblips = {
	-- BLUE ZONES
	{colour=74, id=9, radius = 65.0, x = 1087.92, y = -1980.44, z = 50.88}, -- Smithing
	{colour=74, id=9, radius = 45.0, x = 322.6, y = -596.32, z = 58.68}, -- PillBox Hospital
	{colour=74, id=9, radius = 65.0,x = 2953.56, y = 2788.88, z = 41.56}, -- Mining
	{colour=74, id=9, radius = 45.0,x = -573.76, y = 5351.28, z = 70.2}, -- Construction
	{colour=74, id=9, radius = 45.0,x = -1839.8, y = -1187.32, z = 14.32}, -- Fish Selling
	{colour=74, id=9, radius = 45.0,x = 451.56, y = -995.32, z = 43.68}, -- Police Station

	-- GREEN ZONES
	{colour=2, id=9, radius = 53.0, x = -538.52, y = -214.0, z = 37.64}, -- Office of Owen Err
	{colour=74, id=9, radius = 55.0, x = 956.32, y = 39.32, z = 123.12},
	-- RED ZONES
	{colour=1, id=9, radius = 10.0, x = 2532.16, y = 4817.68, z = 34.0}, -- Duel Arena
	{colour=1, id=9, radius = 175.0, x = 4240.92, y = 2765.28, z = 62.76}, -- Oil Rig
	{colour=1, id=9, radius = 200.0, x = 3059.0, y = -4690.28, z = 14.96}
}

Citizen.CreateThread(function()
	for _, info in pairs(safeblips) do
		info.blip = AddBlipForRadius(info.x, info.y, info.z, info.radius)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 8)
		SetBlipAlpha(info.blip, 150)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		SetBlipHiddenOnLegend(info.blip, true)
	end
end)