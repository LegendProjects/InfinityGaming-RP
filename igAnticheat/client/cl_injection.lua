--==========================================================================================
--==                               LUA INJECTION DETECTION                             ==
--==========================================================================================
AddEventHandler('esx_society:openBossMenu', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:1)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:2)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)

AddEventHandler('esx_basicneeds:healPlayer', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:3)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)

AddEventHandler('esx_ambulancejob:revive', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:4)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)

AddEventHandler('esx_status:set', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:5)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)

RegisterNetEvent('esx:getSharedObject')
AddEventHandler('esx:getSharedObject', function()
	local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:144)'
	TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason)
end)
