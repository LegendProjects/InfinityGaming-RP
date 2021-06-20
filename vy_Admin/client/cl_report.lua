
--template for message
local formatOfRepot = '📍 ^1[{0}] ^3{1}'
local formatOfAdminChat = '🌐 ^6[{0}] {1}'
local ESX = nil
local playerLoaded = false
isAuthorised = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('iG:getSharedObject', function(obj) 
            ESX = obj 
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    Citizen.Wait(100)
    ESX.TriggerServerCallback('igAnticheat:Authorisation:UserGroup', function(xGroup)
        if xGroup == 'Moderator' then
            isAuthorised = true
        elseif xGroup == 'SeniorMod' then
            isAuthorised = true
        elseif xGroup == 'Admin' then
            isAuthorised = true
        elseif xGroup == 'SeniorAdmin' then
            isAuthorised = true
        elseif xGroup == 'HeadAdmin' then
            isAuthorised = true
        elseif xGroup == 'Manager' then
            isAuthorised = true
        elseif xGroup == 'Developer' then
            isAuthorised = true
        elseif xGroup == 'Owner' then
            isAuthorised = true
        else
            isAuthorised = false
        end
    end)

    if ESX.IsPlayerLoaded() then
        playerLoaded = true
    end

    TriggerEvent('chat:addSuggestion', '/reply', "Reply to a report that was given", {
        { name="id", help= "ID of the player that you want to reply to." },
        { name="msg", help= "Message you want to send to the player" }
    })
end)

RegisterNetEvent('iG:playerLoaded')
AddEventHandler('iG:playerLoaded', function()
    playerLoaded = true
end)


RegisterNetEvent("iG_report:textmsg")
AddEventHandler('iG_report:textmsg', function(source, textmsg, names2, names3 )
    local message = names3 ..": " .. textmsg
    local name = "Reply"
    TriggerEvent('chat:addMessage', {
        template = formatOfRepot, 
        args = { name, message }
    })
end)


RegisterNetEvent('iG_report:sendReply')
AddEventHandler('iG_report:sendReply', function(source, textmsg, names2, names3 )
    if isAuthorised then
        local message = names3 .." -> " .. names2 ..": " .. textmsg
        local name = "Reply"
            
        TriggerEvent('chat:addMessage', {
            template = formatOfRepot,
            args = { name, message }
        })
    end
end)

RegisterNetEvent('iG_report:sendReport')
AddEventHandler('iG_report:sendReport', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        local name = "Report"

        TriggerEvent('chat:addMessage', {
            template = formatOfRepot,
            args = { name, "Report sent to the admins online!" }
        })
    end

    if isAuthorised then
        local message =  "[".. id .."] " .. name .. ": " .. message
        local name = "Report"

        TriggerEvent('chat:addMessage', {
            template = formatOfRepot,
            args = { name, message }
        })
    end

end)

RegisterNetEvent('iG_report:sendAdminChat')
AddEventHandler('iG_report:sendAdminChat', function(id, name, message)
    if isAuthorised then
        local myId = PlayerId()
        local pid = GetPlayerFromServerId(id)
        local message =  "[".. id .."] " .. name .. ": " .. message
        local name = "Staff"

        TriggerEvent('chat:addMessage', {
            template = formatOfAdminChat,
            args = { name, message }
        })
    end
end)
