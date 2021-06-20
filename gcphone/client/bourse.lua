function setCrypto(mevcut)
    SendNUIMessage({event = 'updateCrypto', mevcut = mevcut})
end

RegisterNUICallback('buyCrypto', function(data)
  TriggerServerEvent('iG_Phone:buyCrypto', data.islem, data.id, data.adet, data.fiyat)
end)

RegisterNUICallback('getCrypto', function(data)
    ESX.TriggerServerCallback('iG_Phone:getCrypto', function(data)
        setCrypto(data)
    end, data.id)
end)

RegisterNetEvent('updateCrypto')
AddEventHandler('updateCrypto', function(coin)
    ESX.TriggerServerCallback('iG_Phone:getCrypto', function(data)
        setCrypto(data)
    end, coin)
end)
