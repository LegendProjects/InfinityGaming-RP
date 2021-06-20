RegisterNetEvent("iG_Phone:twitter_getTweets")
AddEventHandler("iG_Phone:twitter_getTweets", function(tweets)
  SendNUIMessage({event = 'twitter_tweets', tweets = tweets})
end)

RegisterNetEvent("iG_Phone:twitter_getFavoriteTweets")
AddEventHandler("iG_Phone:twitter_getFavoriteTweets", function(tweets)
  SendNUIMessage({event = 'twitter_favoritetweets', tweets = tweets})
end)

RegisterNetEvent("iG_Phone:twitter_newTweets")
AddEventHandler("iG_Phone:twitter_newTweets", function(tweet)
  SendNUIMessage({event = 'twitter_newTweet', tweet = tweet})
end)

RegisterNetEvent("iG_Phone:twitter_updateTweetLikes")
AddEventHandler("iG_Phone:twitter_updateTweetLikes", function(tweetId, likes)
  SendNUIMessage({event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes})
end)

RegisterNetEvent("iG_Phone:twitter_setAccount")
AddEventHandler("iG_Phone:twitter_setAccount", function(username, avatarUrl)
  SendNUIMessage({event = 'twitter_setAccount', username = username, avatarUrl = avatarUrl})
end)

RegisterNetEvent("iG_Phone:twitter_showError")
AddEventHandler("iG_Phone:twitter_showError", function(title, message)
  SendNUIMessage({event = 'twitter_showError', message = message, title = title})
end)

RegisterNetEvent("iG_Phone:twitter_showSuccess")
AddEventHandler("iG_Phone:twitter_showSuccess", function(title, message)
  SendNUIMessage({event = 'twitter_showSuccess', message = message, title = title})
end)

RegisterNetEvent("iG_Phone:twitter_setTweetLikes")
AddEventHandler("iG_Phone:twitter_setTweetLikes", function(tweetId, isLikes)
  SendNUIMessage({event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes})
end)

RegisterNetEvent("iG_Phone:twitter_sendNewTweet")
AddEventHandler("iG_Phone:twitter_sendNewTweet", function(msg)
  TriggerServerEvent('iG_Phone:twitter_postTweets', msg, '')
end)

RegisterNUICallback('twitter_getTweets', function(cb)
  TriggerServerEvent('iG_Phone:twitter_getTweets')
end)

RegisterNUICallback('twitter_getFavoriteTweets', function()
  TriggerServerEvent('iG_Phone:twitter_getFavoriteTweets')
end)

RegisterNUICallback('twitter_postTweet', function(data, cb)
  TriggerServerEvent('iG_Phone:twitter_postTweets', data.message, data.image)
end)

RegisterNUICallback('twitter_toggleLikeTweet', function(data, cb)
  TriggerServerEvent('iG_Phone:twitter_toogleLikeTweet', data.tweetId)
end)

RegisterNUICallback('twitter_toggleDeleteTweet', function(data, cb) 
  TriggerServerEvent('iG_Phone:twitter_toggleDeleteTweet', data.tweetId)
end)

RegisterNUICallback('twitter_setAvatarUrl', function(data, cb)
  TriggerServerEvent('iG_Phone:twitter_setAvatarUrl', data.avatarUrl)
end)

RegisterNUICallback('twitter_changeUsername', function(data, cb)
  TriggerServerEvent('iG_Phone:twitter_changeUsername', data.newUsername)
end)