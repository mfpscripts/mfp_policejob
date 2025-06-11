ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----------- WAFFENKAMMER ---------------
RegisterServerEvent('mfp_policejob_waffenkammer:syncStock')
AddEventHandler('mfp_policejob_waffenkammer:syncStock', function(buy, menge, weapon)
	local xPlayer = ESX.GetPlayerFromId(source)
	local stockamount = MySQL.Sync.fetchScalar("SELECT amount FROM mfp_stocks WHERE typ = '" .. weapon .. "'")

	if not buy then
		MySQL.Async.execute("UPDATE mfp_stocks SET amount = @amount WHERE typ = @typ",
			{
				["@amount"] = stockamount+1,
				["@typ"] = weapon
			}
		)
	elseif buy then
		MySQL.Async.execute("UPDATE mfp_stocks SET amount = @amount WHERE typ = @typ",
			{
				["@amount"] = stockamount-1,
				["@typ"] = weapon
			}
		)
	else
		print "ERROR 541 - Contact Support"
	end
end)

ESX.RegisterServerCallback('mfp_policejob_waffenkammer:getStock', function(source, cb, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    weapon = weapon:match("^%s*(.-)%s*$")
    weapon = tostring(weapon)

    MySQL.Async.fetchScalar("SELECT amount FROM mfp_stocks WHERE typ = @typ", {["@typ"] = weapon}, function(stockamount)
        if stockamount then
            cb(stockamount)
        else
            cb(0)
        end
    end,
    function(error)
    end)
end)

function getWeaponStock(weapon)

    weapon = weapon:match("^%s*(.-)%s*$")
    weapon = tostring(weapon)

    MySQL.Async.fetchScalar("SELECT amount FROM mfp_stocks WHERE typ = @typ", {["@typ"] = weapon}, function(stockamount)
        if stockamount then
            return(stockamount)
        else
            return(0)
        end
    end,
    function(error)
    end)
end

----------- WAFFENKAMMER ---------------

------------ DISCORD LOGGING --------------
function sendLogs (message,webhook)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('mfp_policejob:discordlog')
AddEventHandler('mfp_policejob:discordlog', function(message, webhook)
sendLogs(message , webhook)
end)
------------ DISCORD LOGGING --------------



  -------- VEHICLESHOP ----------
ESX.RegisterServerCallback('mfp_policejob:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('mfp_policejob:setVehicleOwned')
AddEventHandler('mfp_policejob:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
	end)
end)
-------- VEHICLESHOP ----------



----------- GARAGE ---------------
RegisterServerEvent('mfp_policejob:storeVehicle')
AddEventHandler('mfp_policejob:storeVehicle', function(vehicleData)
    local xPlayer = ESX.GetPlayerFromId(source)
	--print "DATENSERVERSIDE ÜBERGEBEN"
    local ownerId = xPlayer.identifier
    --print("Kennzeichen: "..vehicleData.plate)
    --print("Spawn: "..vehicleData.spawn_name)
    vehicleData.mileage = GetCarMileage(vehicleData.plate)
    --print("Mileage: "..vehicleData.mileage)
	
	vehicleData.plate = vehicleData.plate:upper()
    local trimmedPlate = Trim(vehicleData.plate)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)', {
        ['@plate'] = vehicleData.plate,
        ["@trimmedPlate"]   = trimmedPlate
    }, function(result)
		if (#result > 1) then
		print "SELECT: ERORR: #result > 1"
		end
		if (#result < 1) then
			print "SELECT: ERORR: result < 1 also 0"
		end
        if (#result > 0) then
            -- Das Kennzeichen existiert in owned_vehicles
            local vehicleModel = vehicleData.spawn_name
            local plate = vehicleData.plate
            local mileage = vehicleData.mileage

            -- Übertragen der Fahrzeugdaten in mfp_policecars
            MySQL.Async.execute('INSERT INTO mfp_policecars (owner_id, vehicle_model, plate, mileage, vehicle) VALUES (@owner_id, @vehicle_model, @plate, @mileage, @vehicle)', {
                ['@owner_id'] = ownerId,
                ['@vehicle_model'] = vehicleModel,
                ['@plate'] = plate,
                ['@mileage'] = mileage,
                ['@vehicle'] = result[1].vehicle,
            }, function(rowsChanged)
				if rowsChanged > 1 then
					print "INSERT: ERORR: rowsChanged > 1"
				end
				if rowsChanged < 1 then
					print "INSERT: ERORR: rowsChanged < 1 also 0"
				end
                if rowsChanged > 0 then
					print "rowsChanged > 0"
                    -- Löschen des Fahrzeugs aus owned_vehicles
                    MySQL.Async.execute(
                        'DELETE FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                        {
                            ['@plate'] = plate,
							["@trimmedPlate"]   = trimmedPlate
                        },
                        function(rowsDeleted)
                            if rowsDeleted > 0 then
							print "rowsDeleted > 0"
                                TriggerClientEvent('esx:showNotification', xPlayer.source, Translation['vehicle_stored'])
                            else
                                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Fehler beim Löschen des Fahrzeugs aus owned_vehicles. Serveradmin informieren.")
                            end
                        end
                    )
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, "Not possible to store. Contact Admin.")
                end
            end)
        else
            -- Das Kennzeichen existiert nicht in owned_vehicles
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Not possible to store.")
        end
    end)
end)

function GetCarMileage(plate)
    --plate = plate:upper()
    if Config.MileageScript ~= '' then
	    plate = plate:upper()
        local trimmedPlate = Trim(plate)


        local Query = "SELECT milage FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)"
        local result = MySQL.Sync.fetchAll(Query, {["@plate"] = plate, ['@trimmedPlate'] = trimmedPlate})

        if result ~= nil then
            if #result > 0 then
                return result[1].milage
            else
                return 1 -- Wenn das Fahrzeug nicht gefunden wurde null, 1 default
            end
        else
            print("Hier ist etwas falsch gelaufen.")
            return nil
        end

    else
        return 0 -- wenn nicht integriert
    end
end

function Trim2(text)
    return text:gsub("^%s*(.-)%s*$", "%1")
end

RegisterServerEvent('mfp_policejob:takeOutVehicle')
AddEventHandler('mfp_policejob:takeOutVehicle', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier
	--print "takeout angefordert"
	plate = plate:upper()
    local trimmedPlate = Trim2(plate)

    MySQL.Async.fetchAll(
        'SELECT * FROM mfp_policecars WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
        {
        ['@plate'] = plate,
        ["@trimmedPlate"]   = trimmedPlate
        },
        function(result)
            if #result then
                local vehicleData = result[1]
				
                MySQL.Async.fetchScalar(
                    'SELECT COUNT(*) FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                    {
                        ['@plate'] = vehicleData.plate,
						["@trimmedPlate"]   = trimmedPlate
                    },
                    function(count)
                        if count < 0 then
                            -- Das Kennzeichen existiert bereits in owned_vehicles, generiere ein neues Kennzeichen
                            vehicleData.plate = exports['esx_vehicleshop']:GeneratePlate() -- neues generieren
							--print "Kennzeichen vorhanden"
							local vehicle = json.decode(vehicleData.vehicle)
							vehicle.plate = vehicleData.plate
							vehicleData.vehicle = json.encode(vehicle)
                        else
						--print "Fahrzeug gefunden in DB. Kennzeichen nicht bereits in owned_vehicles"
						end

							local fahrzeugmods = json.decode(vehicleData.vehicle)
							
							--print("Vor übergabe an clientspawn: "..vehicleData.vehicle_model.." & "..vehicleData.plate.." Mods: "..vehicleData.vehicle)
							TriggerClientEvent('mfp_policejob_spawn:spawn', xPlayer.source, vehicleData.vehicle_model, vehicleData.plate, fahrzeugmods)

                            MySQL.Async.execute(
                                'INSERT INTO owned_vehicles (owner, plate, vehicle, stored, milage) VALUES (@owner, @plate, @vehicle, @stored, @milage)',
                                {
                                    ['@owner'] = xPlayer.identifier,
                                    ['@plate'] = vehicleData.plate,
                                    ['@vehicle'] = vehicleData.vehicle, -- als JSON
                                    ['@stored'] = 0,
									['@milage'] = vehicleData.mileage -- milage
                                },
                                function(rowsInserted)
                                    if rowsInserted > 0 then
                                        -- Erfolgreich
										TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['vehicle_parkedout'])
                                    else
                                        TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                    end
                                end
                            )

                        -- Löschen aus mfp_policecars
                        MySQL.Async.execute(
                            'DELETE FROM mfp_policecars WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                            {
                                ['@plate'] = vehicleData.plate,
								["@trimmedPlate"]   = trimmedPlate
                            },
                            function(rowsDeleted)
                                if rowsDeleted > 0 then
                                    -- gelöscht
                                else
                                    TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                end
                            end
                        )
                    end
                )
            else
                -- nicht in mfp_policecars gefunden
                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Es gibt noch keine Fahrzeuge auszuparken.")
            end
        end
    )
end)

ESX.RegisterServerCallback('mfp_policejob:getStoredVehicles', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier

    MySQL.Async.fetchAll(
    'SELECT * FROM mfp_policecars',
    {},
    function(result)
            if result then
                cb(result)
            else
                cb({}) --leeres Array zurück
            end
        end
    )
end)

----------- GARAGE ---------------
----------- HELIGARAGE ------------
RegisterServerEvent('mfp_policejob:storeHeli')
AddEventHandler('mfp_policejob:storeHeli', function(vehicleData)
    local xPlayer = ESX.GetPlayerFromId(source)
	--print "DATENSERVERSIDE ÜBERGEBEN"
    local ownerId = xPlayer.identifier
    --print("Kennzeichen: "..vehicleData.plate)
    --print("Spawn: "..vehicleData.spawn_name)
    vehicleData.mileage = GetCarMileage(vehicleData.plate)
    --print("Mileage: "..vehicleData.mileage)
	
	vehicleData.plate = vehicleData.plate:upper()
    local trimmedPlate = Trim(vehicleData.plate)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)', {
        ['@plate'] = vehicleData.plate,
        ["@trimmedPlate"]   = trimmedPlate
    }, function(result)
		if (#result > 1) then
		print "SELECT: ERORR: #result > 1"
		end
		if (#result < 1) then
			print "SELECT: ERORR: result < 1 also 0"
		end
        if (#result > 0) then
            -- Das Kennzeichen existiert in owned_vehicles
            local vehicleModel = vehicleData.spawn_name
            local plate = vehicleData.plate
            local mileage = vehicleData.mileage

            -- Übertragen der Fahrzeugdaten in mfp_policecars
            MySQL.Async.execute('INSERT INTO mfp_policehelis (owner_id, vehicle_model, plate, mileage, vehicle) VALUES (@owner_id, @vehicle_model, @plate, @mileage, @vehicle)', {
                ['@owner_id'] = ownerId,
                ['@vehicle_model'] = vehicleModel,
                ['@plate'] = plate,
                ['@mileage'] = mileage,
                ['@vehicle'] = result[1].vehicle,
            }, function(rowsChanged)
				if rowsChanged > 1 then
					print "INSERT: ERORR: rowsChanged > 1"
				end
				if rowsChanged < 1 then
					print "INSERT: ERORR: rowsChanged < 1 also 0"
				end
                if rowsChanged > 0 then
					print "rowsChanged > 0"
                    -- Löschen des Fahrzeugs aus owned_vehicles
                    MySQL.Async.execute(
                        'DELETE FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                        {
                            ['@plate'] = plate,
							["@trimmedPlate"]   = trimmedPlate
                        },
                        function(rowsDeleted)
                            if rowsDeleted > 0 then
							print "rowsDeleted > 0"
                                TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['success_retrieve'])
                            else
                                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Fehler beim Löschen des Fahrzeugs aus owned_vehicles. Serveradmin informieren.")
                            end
                        end
                    )
                else
                    --TriggerClientEvent('esx:showNotification', xPlayer.source, "Fehler beim Einfügen des Fahrzeugs in mfp_policehelis.")
                end
            end)
        else
            -- Das Kennzeichen existiert nicht in owned_vehicles
            --TriggerClientEvent('esx:showNotification', xPlayer.source, "Kennzeichen existiert nicht in OWNED VEHICLES")
        end
    end)
end)

RegisterServerEvent('mfp_policejob:takeHeli')
AddEventHandler('mfp_policejob:takeHeli', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier
	--print "takeout angefordert"
	plate = plate:upper()
    local trimmedPlate = Trim2(plate)

    MySQL.Async.fetchAll(
        'SELECT * FROM mfp_policehelis WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
        {
        ['@plate'] = plate,
        ["@trimmedPlate"]   = trimmedPlate
        },
        function(result)
            if #result then
                local vehicleData = result[1]
				
                MySQL.Async.fetchScalar(
                    'SELECT COUNT(*) FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                    {
                        ['@plate'] = vehicleData.plate,
						["@trimmedPlate"]   = trimmedPlate
                    },
                    function(count)
                        if count < 0 then
                            -- Das Kennzeichen existiert bereits in owned_vehicles, generiere ein neues Kennzeichen
                            vehicleData.plate = exports['esx_vehicleshop']:GeneratePlate() -- neues generieren
							--print "Kennzeichen vorhanden"
							local vehicle = json.decode(vehicleData.vehicle)
							vehicle.plate = vehicleData.plate
							vehicleData.vehicle = json.encode(vehicle)
                        else
						--print "Fahrzeug gefunden in DB. Kennzeichen nicht bereits in owned_vehicles"
						end

							local fahrzeugmods = json.decode(vehicleData.vehicle)
							
							--print("Vor übergabe an clientspawn: "..vehicleData.vehicle_model.." & "..vehicleData.plate.." Mods: "..vehicleData.vehicle)
							TriggerClientEvent('mfp_policejob_spawn:helispawn', xPlayer.source, vehicleData.vehicle_model, vehicleData.plate, fahrzeugmods)

                            MySQL.Async.execute(
                                'INSERT INTO owned_vehicles (owner, plate, vehicle, stored, milage) VALUES (@owner, @plate, @vehicle, @stored, @milage)',
                                {
                                    ['@owner'] = xPlayer.identifier,
                                    ['@plate'] = vehicleData.plate,
                                    ['@vehicle'] = vehicleData.vehicle, -- als JSON
                                    ['@stored'] = 0,
									['@milage'] = vehicleData.mileage -- milage
                                },
                                function(rowsInserted)
                                    if rowsInserted > 0 then
                                        -- Erfolgreich
										TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['heli_parkedout']) -- parkedout
                                    else
                                        TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                    end
                                end
                            )

                        -- Löschen aus mfp_policecars
                        MySQL.Async.execute(
                            'DELETE FROM mfp_policehelis WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                            {
                                ['@plate'] = vehicleData.plate,
								["@trimmedPlate"]   = trimmedPlate
                            },
                            function(rowsDeleted)
                                if rowsDeleted > 0 then
                                    -- gelöscht
                                else
                                    TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                end
                            end
                        )
                    end
                )
            else
                -- nicht in mfp_policecars gefunden
                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Es gibt noch keine Fahrzeuge auszuparken.")
            end
        end
    )
end)

ESX.RegisterServerCallback('mfp_policejob:getStoredHelis', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier

    MySQL.Async.fetchAll(
    'SELECT * FROM mfp_policehelis',
    {},
    function(result)
            if result then
                cb(result)
            else
                cb({}) --leeres Array zurück
            end
        end
    )
end)
------------ HELIGARAGE ------------

----------- BOAT GARAGE
RegisterServerEvent('mfp_policejob:storeBoat')
AddEventHandler('mfp_policejob:storeBoat', function(vehicleData)
    local xPlayer = ESX.GetPlayerFromId(source)
	--print "DATENSERVERSIDE ÜBERGEBEN"
    local ownerId = xPlayer.identifier
    --print("Kennzeichen: "..vehicleData.plate)
    --print("Spawn: "..vehicleData.spawn_name)
    vehicleData.mileage = GetCarMileage(vehicleData.plate)
    --print("Mileage: "..vehicleData.mileage)
	
	vehicleData.plate = vehicleData.plate:upper()
    local trimmedPlate = Trim(vehicleData.plate)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)', {
        ['@plate'] = vehicleData.plate,
        ["@trimmedPlate"]   = trimmedPlate
    }, function(result)
		if (#result > 1) then
		print "SELECT: ERORR: #result > 1"
		end
		if (#result < 1) then
			print "SELECT: ERORR: result < 1 also 0"
		end
        if (#result > 0) then
            -- Das Kennzeichen existiert in owned_vehicles
            local vehicleModel = vehicleData.spawn_name
            local plate = vehicleData.plate
            local mileage = vehicleData.mileage

            -- Übertragen der Fahrzeugdaten in mfp_policecars
            MySQL.Async.execute('INSERT INTO mfp_policeboats (owner_id, vehicle_model, plate, mileage, vehicle) VALUES (@owner_id, @vehicle_model, @plate, @mileage, @vehicle)', {
                ['@owner_id'] = ownerId,
                ['@vehicle_model'] = vehicleModel,
                ['@plate'] = plate,
                ['@mileage'] = mileage,
                ['@vehicle'] = result[1].vehicle,
            }, function(rowsChanged)
				if rowsChanged > 1 then
					print "INSERT: ERORR: rowsChanged > 1"
				end
				if rowsChanged < 1 then
					print "INSERT: ERORR: rowsChanged < 1 also 0"
				end
                if rowsChanged > 0 then
					print "rowsChanged > 0"
                    -- Löschen des Fahrzeugs aus owned_vehicles
                    MySQL.Async.execute(
                        'DELETE FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                        {
                            ['@plate'] = plate,
							["@trimmedPlate"]   = trimmedPlate
                        },
                        function(rowsDeleted)
                            if rowsDeleted > 0 then
							print "rowsDeleted > 0"
                                TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['vehicle_stored'])
                            else
                                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Fehler beim Löschen des Fahrzeugs aus owned_vehicles. Serveradmin informieren.")
                            end
                        end
                    )
                else
                    --TriggerClientEvent('esx:showNotification', xPlayer.source, "Fehler beim Einfügen des Fahrzeugs in mfp_policeboats.")
                end
            end)
        else
            -- Das Kennzeichen existiert nicht in owned_vehicles
            --TriggerClientEvent('esx:showNotification', xPlayer.source, "Kennzeichen existiert nicht in OWNED VEHICLES")
        end
    end)
end)

RegisterServerEvent('mfp_policejob:takeBoat')
AddEventHandler('mfp_policejob:takeBoat', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier
	--print "takeout angefordert"
	plate = plate:upper()
    local trimmedPlate = Trim2(plate)

    MySQL.Async.fetchAll(
        'SELECT * FROM mfp_policeboats WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
        {
        ['@plate'] = plate,
        ["@trimmedPlate"]   = trimmedPlate
        },
        function(result)
            if #result then
                local vehicleData = result[1]
				
                MySQL.Async.fetchScalar(
                    'SELECT COUNT(*) FROM owned_vehicles WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                    {
                        ['@plate'] = vehicleData.plate,
						["@trimmedPlate"]   = trimmedPlate
                    },
                    function(count)
                        if count < 0 then
                            -- Das Kennzeichen existiert bereits in owned_vehicles, generiere ein neues Kennzeichen
                            vehicleData.plate = exports['esx_vehicleshop']:GeneratePlate() -- neues generieren
							--print "Kennzeichen vorhanden"
							local vehicle = json.decode(vehicleData.vehicle)
							vehicle.plate = vehicleData.plate
							vehicleData.vehicle = json.encode(vehicle)
                        else
						--print "Fahrzeug gefunden in DB. Kennzeichen nicht bereits in owned_vehicles"
						end

							local fahrzeugmods = json.decode(vehicleData.vehicle)
							
							--print("Vor übergabe an clientspawn: "..vehicleData.vehicle_model.." & "..vehicleData.plate.." Mods: "..vehicleData.vehicle)
							TriggerClientEvent('mfp_policejob_spawn:boatspawn', xPlayer.source, vehicleData.vehicle_model, vehicleData.plate, fahrzeugmods)

                            MySQL.Async.execute(
                                'INSERT INTO owned_vehicles (owner, plate, vehicle, stored, milage) VALUES (@owner, @plate, @vehicle, @stored, @milage)',
                                {
                                    ['@owner'] = xPlayer.identifier,
                                    ['@plate'] = vehicleData.plate,
                                    ['@vehicle'] = vehicleData.vehicle, -- als JSON
                                    ['@stored'] = 0,
									['@milage'] = vehicleData.mileage -- milage
                                },
                                function(rowsInserted)
                                    if rowsInserted > 0 then
                                        -- Erfolgreich
										TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['boat_parkedout']) -- parkedout
                                    else
                                        TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                    end
                                end
                            )

                        -- Löschen aus mfp_policecars
                        MySQL.Async.execute(
                            'DELETE FROM mfp_policeboats WHERE (`plate` = @plate OR `plate` = @trimmedPlate)',
                            {
                                ['@plate'] = vehicleData.plate,
								["@trimmedPlate"]   = trimmedPlate
                            },
                            function(rowsDeleted)
                                if rowsDeleted > 0 then
                                    -- gelöscht
                                else
                                    TriggerClientEvent('esx:showNotification', xPlayer.source, "ERROR: 892 - Contact Serveradmin")
                                end
                            end
                        )
                    end
                )
            else
                -- nicht in mfp_policecars gefunden
                --TriggerClientEvent('esx:showNotification', xPlayer.source, "Es gibt noch keine Fahrzeuge auszuparken.")
            end
        end
    )
end)

ESX.RegisterServerCallback('mfp_policejob:getStoredBoats', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownerId = xPlayer.identifier

    MySQL.Async.fetchAll(
    'SELECT * FROM mfp_policeboats',
    {},
    function(result)
            if result then
                cb(result)
            else
                cb({}) --leeres Array zurück
            end
        end
    )
end)
----------- BOAT GARAGE

----------- MILEAGE ---------------
function Trim(text)
    return text:gsub("^%s*(.-)%s*$", "%1")
end

if Config.MileageScript == 'integrated' then
    RegisterServerEvent('mfp_policejob_mileage:update')
    AddEventHandler('mfp_policejob_mileage:update', function(plate, milage)
	    plate = plate:upper()
        local trimmedPlate = Trim(plate)
        MySQL.Async.execute("UPDATE owned_vehicles SET `milage` = milage + @milage WHERE (`plate` = @plate OR `plate` = @trimmedPlate)", {['@plate'] = plate, ['@milage'] = milage, ["@trimmedPlate"]   = trimmedPlate})
    end)


    ESX.RegisterServerCallback('mfp_policejob_mileage:getcarmileage', function(source, cb, plate)
	
    	--print('check for ' .. plate)
    	plate = plate:upper()
        local trimmedPlate = Trim(plate)
    	local Query = "SELECT plate, milage from owned_vehicles where (`plate` = @plate OR `plate` = @trimmedPlate)"
    	MySQL.Async.fetchAll(Query, {["@plate"] = plate, ["@trimmedPlate"] = trimmedPlate}, function(result)
    		if result ~= nil then 
    			if #result > 0 then 
    				cb(result[1].milage, true)
    			else
    				cb(0, false)
    			end 
    		else 
    			print("here is something wrong.. Contact Admin; for advanced docs visit: mfpscripts.com/docs")
    		end 
    	end)
    end)
end
----------- MILEAGE ---------------
----------- Interactionmenu ---------------
----------- Interactionmenu ---------------


if Config.BillingScript == 'vivum' then
RegisterServerEvent('mfp_policejob:sendVivumBilling')
AddEventHandler('mfp_policejob:sendVivumBilling', function(player, fine)
	local xPlayer = ESX.GetPlayerFromId(source)
    print("Serverside Blitzer aktiv")
        
	local invoiceData = {
   			sender = 'police',
    		sender_label = 'LSPD',
    		recipient = player,
    		recipient_label = 'Ich',
    		amount = fine,
    		payments_num = 1,
    		payments_period = 3, -- (in days)
    		summary = "LSPD Innvoice"
		}

	exports["vivum-billing"]:SendInvoice(source, invoiceData, function(res)
    		print(res.status) -- OK or FAILED
	end, true)
end)
end -- end of Config.BillingScript == 'vivum'

--- SEARCH -------

RegisterNetEvent('mfp_policejob:confiscatePlayerItem')
AddEventHandler('mfp_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		print(('mfp_policejob: %s attempted to confiscate!'):format(sourceXPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				--sourceXPlayer.showNotification("Du kofiszierst", amount, sourceItem.label, targetXPlayer.name))
				--targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			else
				--sourceXPlayer.showNotification("So viele hat er nicht.")
			end
		else
			--sourceXPlayer.showNotification("So viele hat er nicht.")
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		--sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		--targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		--sourceXPlayer.showNotification(_U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		--targetXPlayer.showNotification(_U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterNetEvent('mfp_policejob:handcuff')
AddEventHandler('mfp_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('mfp_policejob:handcuff', target)
	end
end)

RegisterNetEvent('mfp_policejob:handcuff2')
AddEventHandler('mfp_policejob:handcuff2', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('mfp_policejob:handcufffest', target)
	end
end)

function Handcuff(target, canmove)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
        if canmove then
            TriggerClientEvent('mfp_policejob:handcuff', target)
        else
		    TriggerClientEvent('mfp_policejob:handcufffest', target)
        end
	end
end

-- vehicle
ESX.RegisterServerCallback('mfp_policejob:getVehicleInfos', function(source, cb, plate)
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
                cb(retrivedInfo)
            else
                cb(retrivedInfo)
            end
        else
            cb(retrivedInfo)
        end
    end)
end)

--- animation
RegisterServerEvent('mfp_policejob:startArrest')
AddEventHandler('mfp_policejob:startArrest', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('mfp_policejob:arrested', targetPlayer.source, source)
	TriggerClientEvent('mfp_policejob:arrest', source)
end)
--- animation


-------- PANICBUTTON ---------
RegisterNetEvent('panicButton:syncPosition')
AddEventHandler('panicButton:syncPosition', function(position)
    local src = source

        local sourcePlayer = ESX.GetPlayerFromId(src)
        if not sourcePlayer then
            print("keine source")
            return
        end
        
        local firstname = sourcePlayer.get('firstName')
        local lastname = sourcePlayer.get('lastName') 
        local playerName = firstname .. ' ' .. lastname

        local targetPlayers = ESX.GetPlayers()
        for _, playerId in ipairs(targetPlayers) do
            local targetPlayer = ESX.GetPlayerFromId(playerId)
            if targetPlayer then
                local targetPlayerJob = targetPlayer.job and targetPlayer.job.name
                --for _, job in pairs(Config.Jobs) do
                    if targetPlayer.job.name == 'police' then
                        TriggerClientEvent('panicButton:alarm', playerId, playerName, position)
                    end
                --end
            end
        end
        return
end)
-------- PANICBUTTON ---------
