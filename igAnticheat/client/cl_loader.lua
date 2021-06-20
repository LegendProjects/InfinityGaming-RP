local ProhibitedVariables = { -- Add as many as you want from mod menus you find! (Remove war menu if you use it!)
    "fESX", "Plane", "TiagoMenu", "Outcasts666", "dexMenu", "Cience", "LynxEvo", "zzzt", "AKTeam",
    "gaybuild", "ariesMenu", "SwagMenu", "Dopamine", "Gatekeeper", "MIOddhwuie"
}

local Enabled = true -- Change this to enable client mod menu checks!
function CheckVariables()
    for i, v in pairs(ProhibitedVariables) do
        if _G[v] ~= nil then
           local reason = '🛡️ 𝗶𝗴𝗔𝗻𝘁𝗶𝗰𝗵𝗲𝗮𝘁 | You are banned from this server ( 𝗨𝘀𝗲𝗿𝗻𝗮𝗺𝗲: ' .. GetPlayerName(PlayerId()).. ' ) (T:9' .. i .. ')';
	       TriggerServerEvent("igAnticheat:Ban:ExecuteBanhammer", PlayerPedId(), reason);
        end
    end
end

if Enabled then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(30000)
            CheckVariables()
        end
    end)
else
    return "Nil"
end