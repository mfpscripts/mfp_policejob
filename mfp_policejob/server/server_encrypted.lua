ESX.RegisterServerCallback('mfp_policejob:getOtherPlayerData', function(source, cb, target)
    local _target = target
    local xPlayer = ESX.GetPlayerFromId(_target)
    --print("xPlayer: "..xPlayer)
    print("target: ".._target)
    --print("xplayer: "..xPlayer.."")

    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM `users` WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        })
        
        local vorname = result[1].firstname
        local nachname = result[1].lastname
        local data = {
            firstname = vorname,
            name = nachname,
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            dob = xPlayer.get('dateofbirth'),
            height = xPlayer.get('height')
        }

        if xPlayer.get('sex') == 'm' then 
            data.sex = 'männlich' 
        else 
            data.sex = 'weiblich' 
        end

        TriggerEvent('esx_license:getLicenses', _target, function(licenses)
            data.licenses = licenses
            cb(data)
        end)
    else
        print("Spieler nicht gefunden oder nicht online")
    end
end)
-- objects
RegisterServerEvent('mfp_policejob:DeleteObject')
AddEventHandler('mfp_policejob:DeleteObject', function(id)
    local entity = NetworkGetEntityFromNetworkId(id)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
end)

-- waffenkammer
RegisterNetEvent('mfp_policejob_waffenkammer:reinraus')
AddEventHandler('mfp_policejob_waffenkammer:reinraus', function(weapon, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local weapon2buy = weapon:upper()
    local weaponlabel = label
    local stockamount = MySQL.Sync.fetchScalar("SELECT amount FROM mfp_stocks WHERE typ = @typ",
    {
        ["@typ"] = weapon2buy
    })

    if xPlayer.hasWeapon(weapon2buy) then
        xPlayer.removeWeapon(weapon2buy)
        local buy = false
        TriggerEvent('mfp_policejob_waffenkammer:syncStock', buy, 1, weapon2buy)
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, Translation[Config.Locale]['weapon_storage'], Translation[Config.Locale]['success_store'], Translation[Config.Locale]['success_store_message']:format(weaponlabel), 'CHAR_CALL911', 9)
        if Dicordlogging then
            TriggerEvent('mfp_policejob:discordlog', Translation[Config.Locale]['discord_log_store']:format(xPlayer.name, weaponlabel), DiscordWebhook['webhook'])
        end
    else
        if stockamount >= 1 then
            local buy = true
            TriggerEvent('mfp_policejob_waffenkammer:syncStock', buy, amount, weapon2buy)
            xPlayer.addWeapon(weapon2buy, 450)
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, Translation[Config.Locale]['weapon_storage'], Translation[Config.Locale]['success_retrieve'], Translation[Config.Locale]['success_retrieve_message']:format(weaponlabel), 'CHAR_CALL911', 9)
            if Dicordlogging then
                TriggerEvent('mfp_policejob:discordlog', Translation[Config.Locale]['discord_log_retrieve']:format(xPlayer.name, weaponlabel), DiscordWebhook['webhook'])
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, Translation[Config.Locale]['weapon_storage'], Translation[Config.Locale]['error_not_available'], Translation[Config.Locale]['error_not_available_message'], 'CHAR_CALL911', 7)
        end
    end
end)

-------- WERBUNG ------------
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print(" _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ")
    print("|     |   __|  _  |   __|     | __  |     |  _  |_   _|   __|")
    print("| | | |   __|   __|__   |   --|    -|-   -|   __| | | |__   |")
    print("|_|_|_|__|  |__|  |_____|_____|__|__|_____|__|    |_| |_____|")
    print("The resource " .. resourceName .. " has been started")
  end)
  
  AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('The resource ' .. resourceName .. ' was stopped. Created by mfpscripts.com!')
  end)
  -------- WERBUNG ------------




  --------- EXPORTS ---------------

  -- vehicle
function getVehicleInfos(plate)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        local retrivedInfo = {plate = plate}

        if result[1] then
            local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

            if Config.VehicleRegisterScript == 'lux' then
                retrivedInfo.registered = result[1].registered
                retrivedInfo.first_registration = result[1].first_registration
            end

            if xPlayer then
                retrivedInfo.owner = xPlayer.getName()
                return(retrivedInfo)
            else
                return(retrivedInfo)
            end
        else
            return(retrivedInfo)
        end
    end)
end

function getPlayerData(target)
    local _target = target
    local xPlayer = ESX.GetPlayerFromId(_target)
    --print("xPlayer: "..xPlayer)
    print("target: ".._target)
    --print("xplayer: "..xPlayer.."")

    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM `users` WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        })
        
        local vorname = result[1].firstname
        local nachname = result[1].lastname
        local data = {
            firstname = vorname,
            name = nachname,
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            dob = xPlayer.get('dateofbirth'),
            height = xPlayer.get('height')
        }

        if xPlayer.get('sex') == 'm' then 
            data.sex = 'männlich' 
        else 
            data.sex = 'weiblich' 
        end

        TriggerEvent('esx_license:getLicenses', _target, function(licenses)
            data.licenses = licenses
            return(data)
        end)
    else
        print("Spieler nicht gefunden oder nicht online")
    end
end