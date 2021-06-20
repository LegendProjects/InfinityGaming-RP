AddEventHandler('iG:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end
