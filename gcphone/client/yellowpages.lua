RegisterNetEvent("iG_Phone:yellow_getPosts")
AddEventHandler("iG_Phone:yellow_getPosts", function(posts)
  SendNUIMessage({event = 'yellow_posts', posts = posts})
end)

RegisterNetEvent("iG_Phone:yellow_getMyPosts")
AddEventHandler("iG_Phone:yellow_getMyPosts", function(posts)
  SendNUIMessage({event = 'yellow_getMyPosts', posts = posts})
end)

RegisterNetEvent("iG_Phone:yellow_sendNewPost")
AddEventHandler("iG_Phone:yellow_sendNewPost", function(msg)
  TriggerServerEvent('iG_Phone:yellow_postIlan', msg, '')
end)

RegisterNUICallback('yellow_getPosts', function(cb)
    TriggerServerEvent('iG_Phone:yellow_getPosts')
end)

RegisterNUICallback('yellow_getMyPosts', function(cb)
  TriggerServerEvent('iG_Phone:yellow_getMyPosts')
end)

RegisterNUICallback('yellow_toggleDeletePost', function(data, cb) 
  TriggerServerEvent('iG_Phone:yellow_toggleDeletePost', data.id)
end)

RegisterNUICallback('yellow_postIlan', function(data, cb)
    TriggerServerEvent('iG_Phone:yellow_postIlan', data.message, data.image)
end)

RegisterNetEvent("iG_Phone:yellow_newPost")
AddEventHandler("iG_Phone:yellow_newPost", function(post)
  SendNUIMessage({event = 'yellow_newPost', post = post})
end)