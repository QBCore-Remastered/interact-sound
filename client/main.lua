local standardVolumeOutput = 0.3;
local hasPlayerLoaded = LocalPlayer.state.isLoggedIn

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    hasPlayerLoaded = value
end)

RegisterNetEvent('InteractSound_CL:PlayOnOne', function(soundFile, soundVolume)
    if hasPlayerLoaded and soundFile then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = soundFile,
            transactionVolume = soundVolume or 1.0
        })
    end
end)

RegisterNetEvent('InteractSound_CL:PlayOnAll', function(soundFile, soundVolume)
    if hasPlayerLoaded and soundFile then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = soundFile,
            transactionVolume = soundVolume or standardVolumeOutput
        })
    end
end)

RegisterNetEvent('InteractSound_CL:PlayWithinDistance', function(otherPlayerCoords, maxDistance, soundFile, soundVolume)
	if hasPlayerLoaded and soundFile then
		local myCoords = GetEntityCoords(PlayerPedId())
		local distance = #(myCoords - otherPlayerCoords)

		if distance < maxDistance then
			SendNUIMessage({
				transactionType = 'playSound',
				transactionFile = soundFile,
				transactionVolume = soundVolume or standardVolumeOutput
			})
		end
	end
end)
