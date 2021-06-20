
ESX = nil
local jobGrade = ''
local job = ''

local Discord = {}
local firstSpawn = true
Discord.Buttons = {
    {index = 0,name = '➡️ Connect via FiveM',url = 'fivem://connect/cfx.re/join/le5367'},
    {index = 1,name = '📢 Discord',url = 'https://discord.gg/ig'},
}



-- ESX Stuff----
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('iG:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('iG:setJob')
AddEventHandler('iG:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        if ESX ~= nil and ESX.PlayerData ~= nil then 
            --This is the Application ID (Replace this with you own)
            SetDiscordAppId(713695305069101056)

            --Here you will have to put the image name for the "large" icon.
            SetDiscordRichPresenceAsset('logo_name')
            if ESX.PlayerData.job then
                job = ESX.PlayerData.job.label
                jobGrade = ESX.PlayerData.job.grade_label
            else			
                Citizen.Wait(500)
            end	
                    
            --(11-11-2018) New Natives:

            --Here you can add hover text for the "large" icon.
            SetDiscordRichPresenceAssetText('Infinity Gaming Roleplay (FiveM) | discord.gg/ig | InfinityGaming.CO.NZ')
            SetDiscordRichPresenceAssetSmallText('Infinity Gaming Roleplay (FiveM) | discord.gg/ig | InfinityGaming.CO.NZ')
            --Here you will have to put the image name for the "small" icon.
            SetDiscordRichPresenceAssetSmall('logo_small')

        

            -- Sets the string with variables as RichPresence (Don't touch)
            SetRichPresence('[' .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. '] ' .. GetPlayerName(PlayerId()) .. ' | ' .. jobGrade .. " - " .. job .. ' | discord.gg/ig')
            
            if firstSpawn then
                for _, v in pairs(Discord.Buttons) do
                    SetDiscordRichPresenceAction(v.index, v.name, v.url)
                end
                firstSpawn = false
            end
            -- It updates every one minute just in case.
            Citizen.Wait(60000)

        else
            Citizen.Wait(5000)
        end
	end
end)