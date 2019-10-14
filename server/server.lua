local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdupbank:toofar')
AddEventHandler('esx_holdupbank:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('esx_holdupbank:toofarhack')
AddEventHandler('esx_holdupbank:toofarhack', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('esx_holdupbank:rob')
AddEventHandler('esx_holdupbank:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end


		if rob == false then
		
			if xPlayer.getInventoryItem('blowtorch').count >= 1 then
				xPlayer.removeInventoryItem('blowtorch', 1)

				if(cops >= Config.NumberOfCopsRequired)then

					rob = true
					for i=1, #xPlayers, 1 do
						local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						if xPlayer.job.name == 'police' then
								TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery in progress at ^2" .. bank.nameofbank)
								TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
								TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])							
								TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
						end
					end

					TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. bank.nameofbank .. _U('do_not_move'))
					TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
					TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
					TriggerClientEvent('esx_holdupbank:currentlyrobbing', source, robb)
					TriggerClientEvent('esx_blowtorch:startblowtorch', source)
					Banks[robb].lastrobbed = os.time()
					robbers[source] = robb
					local savedSource = source
					SetTimeout(300000, function()

						if(robbers[savedSource])then

							rob = false
							TriggerClientEvent('esx_holdupbank:robberycomplete', savedSource, job)
							if(xPlayer)then

								--Updated to choose between cash or black money
								if Config.moneyType == 'cash' then
									xPlayer.addMoney(bank.reward)
								elseif Config.moneyType == 'black' then
									xPlayer.addAccountMoney('black_money',bank.reward)
								end

								local xPlayers = ESX.GetPlayers()
								for i=1, #xPlayers, 1 do
									local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
									if xPlayer.job.name == 'police' then
											TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank)
											TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
									end
								end
							end
						end
					end)
				else
					TriggerClientEvent('esx:showNotification', source, _U('min_two_police')..Config.NumberOfCopsRequired)
				end
			else
				TriggerClientEvent('esx:showNotification', source, _U('blowtorch_needed'))
			end

		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_holdupbank:hack')
AddEventHandler('esx_holdupbank:hack', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end



			if(cops >= Config.NumberOfCopsRequired)then

				if xPlayer.getInventoryItem('raspberry').count >= 1 then
					xPlayer.removeInventoryItem('raspberry', 1)

					TriggerClientEvent('esx:showNotification', source, _U('started_to_hack') .. bank.nameofbank .. _U('do_not_move'))
					TriggerClientEvent('esx:showNotification', source, _U('hold_pos_hack'))
					TriggerClientEvent('esx_holdupbank:currentlyhacking', source, robb, Banks[robb])



				else
					TriggerClientEvent('esx:showNotification', source, _U('raspberry_needed'))
				end
			else
				TriggerClientEvent('esx:showNotification', source, _U('min_two_police'))
			end
	end
end)

-- Plant a bomb

RegisterServerEvent('esx_holdupbank:plantbomb')
AddEventHandler('esx_holdupbank:plantbomb', function(robb)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if Banks[robb] then

        local bank = Banks[robb]

        if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

            TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
            return
        end


        local cops = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end


        if(cops >= Config.NumberOfCopsRequired)then

			if xPlayer.getInventoryItem('c4_bank').count >= 1 then
				xPlayer.removeInventoryItem('c4_bank', 1)
				for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
						TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery in progress at ^2" .. bank.nameofbank)
						TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
						TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end

				TriggerClientEvent('esx:showNotification', source, _U('started_to_plantbomb') .. bank.nameofbank .. _U('do_not_move'))

				TriggerClientEvent('esx:showNotification', source, _U('hold_pos_plantbomb'))
				TriggerClientEvent('esx_holdupbank:plantingbomb', source, robb, Banks[robb])

				robbers[source] = robb
				local savedSource = source

				SetTimeout(20000, function()

					if(robbers[savedSource])then

						rob = false
						TriggerClientEvent('esx_holdupbank:plantbombcomplete', savedSource, Banks[robb])
						if(xPlayer)then

							TriggerClientEvent('esx:showNotification', xPlayer, _U('bombplanted_run'))
							local xPlayers = ESX.GetPlayers()
							for i=1, #xPlayers, 1 do
								local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
								if xPlayer.job.name == 'police' then
									TriggerClientEvent('esx:showNotification', xPlayers[i], _U('bombplanted_at') .. bank.nameofbank)

								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', source, _U('c4_needed'))
			end
        else
            TriggerClientEvent('esx:showNotification', source, _U('min_two_police'))
        end

    end
end)

RegisterServerEvent('esx_holdupbank:clearweld')
AddEventHandler('esx_holdupbank:clearweld', function(x,y,z)

	TriggerClientEvent('esx_blowtorch:clearweld', -1, x,y,z)
end)

RegisterServerEvent('esx_holdupbank:opendoor')
AddEventHandler('esx_holdupbank:opendoor', function(x,y,z, doortype)

	TriggerClientEvent('esx_holdupbank:opendoors', -1, x,y,z, doortype)
end)

RegisterServerEvent('esx_holdupbank:plantbombtoall')
AddEventHandler('esx_holdupbank:plantbombtoall', function(x,y,z, doortype)
    SetTimeout(20000, function()
        TriggerClientEvent('esx_holdupbank:plantedbomb', -1, x,y,z, doortype)
    end)
end)

RegisterServerEvent('esx_holdupbank:finishclear')
AddEventHandler('esx_holdupbank:finishclear', function()
	TriggerClientEvent('esx_blowtorch:finishclear', -1)
end)

RegisterServerEvent('esx_holdupbank:closedoor')
AddEventHandler('esx_holdupbank:closedoor', function()

	TriggerClientEvent('esx_holdupbank:closedoor', -1)
end)

RegisterServerEvent('esx_holdupbank:plantbomb')
AddEventHandler('esx_holdupbank:plantbomb', function()
    TriggerClientEvent('esx_holdupbank:plantbomb', -1)
end)
