RegisterNetEvent("iG_Phone:tchat_receive")
AddEventHandler("iG_Phone:tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("iG_Phone:tchat_channel")
AddEventHandler("iG_Phone:tchat_channel", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('iG_Phone:tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('iG_Phone:tchat_channel', data.channel)
end)
