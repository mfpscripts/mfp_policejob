local PlayerData = {}
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerData.job = xPlayer.job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
  PlayerData.job = job
end)

-------- NATIVEUIs --------
_menuPool = NativeUI.CreatePool()
local mainMenu
local carDealerMenu
-------- NATIVEUIs --------

------------ LOCATIONS -----------
Citizen.CreateThread(function()
    while true do

        _menuPool:ProcessMenus()

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        ----- WEAPON ARMORY -------
        for k,v in pairs(Config.WeaponArmory) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 1.5 then
                ShowInputNotification(Translation[Config.Locale]['open_armory'])
            end
            if IsControlJustReleased(0, 38) then
                if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 1.5 then
                    print("JOBNAME: "..ESX.PlayerData.job.name.. " und Grade: "..ESX.PlayerData.job.grade_name)
                    
                    if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") then
                        openMenu()
                    else
                        TriggerEvent('esx:showAdvancedNotification', "Waffenkammer", "Nope", Translation[Config.Locale]['no_permission'], 'CHAR_CALL911', 7 )
                    end
                end
            end 
        end
        ----- WEAPON ARMORY -------
        ------- UMKLEIDE --------
        for k,v in pairs(Config.Wardrobe) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_wardrobe'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "E gedrückt"
                    openWardrobeMenu()
                end
            end
        end
        ---------- UMKLEIDE --------
        ------- GARAGE --------
        for k,v in pairs(Config.GaragePoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_garage'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "E gedrückt"
                    openGarageMenu()
                end
            end
        end
        ---------- GARAGE --------
        ------- HELIGARAGE --------
        for k,v in pairs(Config.HeliGaragePoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_heli_garage'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "E gedrückt"
                    openHeliGarageMenu()
                end
            end
        end
        ---------- HELIGARAGE --------
        ------- BOATGARAGE --------
        for k,v in pairs(Config.BoatGaragePoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_boat_garage'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "E gedrückt"
                    openBoatGarageMenu()
                end
            end
        end
        ---------- BOATGARAGE --------
        ---------- VEHICLESHOP --------
        for k,v in pairs(Config.VehicleShopPoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_vehicle_shop'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "gedrückt"
                    openBuyVehicle()
                end
            end
        end
        ---------- VEHICLESHOP --------
        ---------- HELISHOP --------
        for k,v in pairs(Config.HeliShopPoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_heli_shop'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "gedrückt"
                    openBuyHeli()
                end
            end
        end
        ---------- HELISHOP --------
         ---------- BOATSHOP --------
         for k,v in pairs(Config.BoatShopPoint) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 2.5 then
                ShowInputNotification(Translation[Config.Locale]['open_boat_shop'])
                if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, 38) then
                    print "gedrückt"
                    openBuyBoat()
                end
            end
        end
        ---------- BOATSHOP --------
        ----------- Interaktionen -------
        if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == "police") and IsControlJustReleased(0, Config.JobMenuButton) then
            openInteractionMenu()
        end
        ----------- Interaktionen -------

        Citizen.Wait(1)

    end
    
end)
------------ LOCATIONS -----------

-------- VEHICLESHOP ----------
function openBuyVehicle()
    carDealerMenu = NativeUI.CreateMenu(Translation[Config.Locale]['buy_vehicle'], "")
    _menuPool:Add(carDealerMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    carDealerMenu:SetBannerSprite(backround, true)

    for _, vehicleData in pairs(Config.Buyvehicles) do
        local citem = NativeUI.CreateItem(vehicleData.label, "Model: "..vehicleData.model)
        carDealerMenu:AddItem(citem)
    
        citem.Activated = function(sender, item)
            if ESX.PlayerData.job.grade_name == 'boss' then
                local model = vehicleData.model
                local label = vehicleData.label
                TriggerEvent('mfp_policejob:buyVehicle', model, label)
            else
                TriggerEvent('esx:showAdvancedNotification', "LSPD Shop", "LSPD", Translation[Config.Locale]['only_chief_can_order'], 'CHAR_CALL911', 7 )
            end
            carDealerMenu:Visible(false)
        end
    end

    carDealerMenu:Visible(true)

    _menuPool:MouseControlsEnabled(false)
	_menuPool:MouseEdgeEnabled(false)
	_menuPool:ControlDisablingEnabled(false)
end

function openBuyHeli()
    HeliShopMenu = NativeUI.CreateMenu(Translation[Config.Locale]['buy_heli'], "")
    _menuPool:Add(HeliShopMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    HeliShopMenu:SetBannerSprite(backround, true)

    for _, vehicleData in pairs(Config.BuyHeli) do
        local citem = NativeUI.CreateItem(vehicleData.label, "Model: "..vehicleData.model)
        HeliShopMenu:AddItem(citem)
    
        citem.Activated = function(sender, item)
            if ESX.PlayerData.job.grade_name == 'boss' then
                local model = vehicleData.model
                local label = vehicleData.label
                TriggerEvent('mfp_policejob:buyHeli', model, label)
            else
                TriggerEvent('esx:showAdvancedNotification', "LSPD Shop", "LSPD", Translation[Config.Locale]['only_chief_can_order'], 'CHAR_CALL911', 7 )
            end
            HeliShopMenu:Visible(false)
        end
    end

    HeliShopMenu:Visible(true)

    _menuPool:MouseControlsEnabled(false)
	_menuPool:MouseEdgeEnabled(false)
	_menuPool:ControlDisablingEnabled(false)
end

function openBuyBoat()
    BoatShopMenu = NativeUI.CreateMenu(Translation[Config.Locale]['buy_boat'], "")
    _menuPool:Add(BoatShopMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    BoatShopMenu:SetBannerSprite(backround, true)

    for _, vehicleData in pairs(Config.BuyBoat) do
        local citem = NativeUI.CreateItem(vehicleData.label, "Model: "..vehicleData.model)
        BoatShopMenu:AddItem(citem)
    
        citem.Activated = function(sender, item)
            if ESX.PlayerData.job.grade_name == 'boss' then
                local model = vehicleData.model
                local label = vehicleData.label
                TriggerEvent('mfp_policejob:buyBoat', model, label)
            else
                TriggerEvent('esx:showAdvancedNotification', "LSPD Shop", "LSPD", Translation[Config.Locale]['only_chief_can_order'], 'CHAR_CALL911', 7 )
            end
            BoatShopMenu:Visible(false)
        end
    end

    BoatShopMenu:Visible(true)

    _menuPool:MouseControlsEnabled(false)
	_menuPool:MouseEdgeEnabled(false)
	_menuPool:ControlDisablingEnabled(false)
end

RegisterNetEvent("mfp_policejob:buyVehicle")
AddEventHandler("mfp_policejob:buyVehicle", function(model, label)
    
    ESX.Game.SpawnVehicle(model, Config.SpawnLocation.spawnlocation, Config.SpawnLocation.heading, function (vehicle)
        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('mfp_policejob:setVehicleOwned', vehicleProps)

        ESX.ShowNotification(Translation[Config.Locale]['new_service_vehicle'] .. label)
    end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)

RegisterNetEvent("mfp_policejob:buyHeli")
AddEventHandler("mfp_policejob:buyHeli", function(model, label)
    
    ESX.Game.SpawnVehicle(model, Config.HeliSpawnLocation.spawnlocation, Config.HeliSpawnLocation.heading, function (vehicle)
        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('mfp_policejob:setVehicleOwned', vehicleProps)

        ESX.ShowNotification(Translation[Config.Locale]['new_service_vehicle'] .. label)
    end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)

RegisterNetEvent("mfp_policejob:buyBoat")
AddEventHandler("mfp_policejob:buyBoat", function(model, label)
    
    ESX.Game.SpawnVehicle(model, Config.BoatSpawnLocation.spawnlocation, Config.BoatSpawnLocation.heading, function (vehicle)
        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('mfp_policejob:setVehicleOwned', vehicleProps)

        ESX.ShowNotification(Translation[Config.Locale]['new_service_vehicle'] .. label)
    end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)


local NumberCharset = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
local Charset = {}

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper('LSPD ' .. GetRandomNumber(3))

		ESX.TriggerServerCallback('mfp_policejob:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GetRandomNumber(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

-------- VEHICLESHOP ----------


----------------- WAFFENKAMMER ------------
function openMenu()
    mainMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['weapons'])
    _menuPool:Add(mainMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    mainMenu:SetBannerSprite(backround, true)

    ----- SCHLAGSTOCK --------
    local schlagstock = NativeUI.CreateItem(Translation[Config.Locale]['nightstick'],'') 
    mainMenu:AddItem(schlagstock)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        schlagstock:RightLabel('~p~'..stock)
    end, 'WEAPON_NIGHTSTICK')
    
    schlagstock.Activated = function(sender, index)
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_NIGHTSTICK', Translation[Config.Locale]['nightstick'])
    end
    ----- SCHLAGSTOCK --------

    ----- TASCHENLAMPE --------
    local taschenlampe = NativeUI.CreateItem(Translation[Config.Locale]['flashlight'],'') 
    mainMenu:AddItem(taschenlampe)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        taschenlampe:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_FLASHLIGHT')
    
    taschenlampe.Activated = function(sender, index)
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_FLASHLIGHT', Translation[Config.Locale]['flashlight'])
    end
    ----- TASCHENLAMPE --------

    ----- TASER --------
    local taser = NativeUI.CreateItem(Translation[Config.Locale]['taser'],'') 
    mainMenu:AddItem(taser)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        taser:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_STUNGUN')
    
    taser.Activated = function(sender, index)
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_STUNGUN', Translation[Config.Locale]['taser'])
    end
    ----- TASER --------

    ----- 50ER --------
    local fuenfziger = NativeUI.CreateItem(Translation[Config.Locale]['pistol_50'],'') 
    mainMenu:AddItem(fuenfziger)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        fuenfziger:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_PISTOL50')
    
    fuenfziger.Activated = function(sender, index)
		if not (ESX.PlayerData.job.grade_name == 'recruit') then
            TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_PISTOL50', Translation[Config.Locale]['pistol_50'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- 50ER --------

    ----- Glock Pistole 19 Gen5 --------
    local glock = NativeUI.CreateItem(Translation[Config.Locale]['glock_19'],'')
    mainMenu:AddItem(glock)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        glock:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_COMBATPISTOL')
    
    glock.Activated = function(sender, index)
		if not (ESX.PlayerData.job.grade_name == 'recruit') then
            TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_COMBATPISTOL', Translation[Config.Locale]['glock_19'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- Glock Pistole 19 Gen5 --------

    ----- PUMP --------
    local pumpshotgun = NativeUI.CreateItem(Translation[Config.Locale]['pump_shotgun'],'')
    mainMenu:AddItem(pumpshotgun)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        pumpshotgun:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_PUMPSHOTGUN')
    
    pumpshotgun.Activated = function(sender, index)
		if not (ESX.PlayerData.job.grade_name == 'recruit') or (ESX.PlayerData.job.grade_name == 'officer') then
            TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_PUMPSHOTGUN', Translation[Config.Locale]['pump_shotgun'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- PUMP --------
    
    ----- COMBATPDW --------
    local pdw = NativeUI.CreateItem(Translation[Config.Locale]['pdw'], '') 
    mainMenu:AddItem(pdw)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        pdw:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_COMBATPDW')
    
    pdw.Activated = function(sender, index)
        if (ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job.grade_name == 'swatofficer') then
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_COMBATPDW', Translation[Config.Locale]['pdw'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- COMBATPDW --------
    
    ----- SNIPER --------
    local sniper = NativeUI.CreateItem(Translation[Config.Locale]['sniper'], '') 
    mainMenu:AddItem(sniper)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        sniper:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_SNIPERRIFLE')
    
    sniper.Activated = function(sender, index)
        if (ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job.grade_name == 'swatofficer') then
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_SNIPERRIFLE', Translation[Config.Locale]['sniper'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- SNIPER --------
    
    ----- KARABINER --------
    local karabiner = NativeUI.CreateItem(Translation[Config.Locale]['carbine_rifle'], '') 
    mainMenu:AddItem(karabiner)

    ESX.TriggerServerCallback('mfp_policejob_waffenkammer:getStock', function(stock)
        karabiner:RightLabel('~p~' ..stock.. '')
    end, 'WEAPON_CARBINERIFLE')
    
    karabiner.Activated = function(sender, index)
        if (ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job.grade_name == 'swatofficer') then
		    TriggerServerEvent('mfp_policejob_waffenkammer:reinraus', 'WEAPON_CARBINERIFLE', Translation[Config.Locale]['carbine_rifle'])
        else
            TriggerEvent('esx:showAdvancedNotification', Translation[Config.Locale]['weapons'], "Nope", Translation[Config.Locale]['no_access'], 'CHAR_CALL911', 7 )
        end
    end
    ----- KARABINER --------

    mainMenu:Visible(true)

    _menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(false)
end
----------------- WAFFENKAMMER ------------


-------------- MILEAGE ------------
if Config.MileageScript == 'integrated' then
    local CurrentVehicle = nil
    local PlayerIsDriver = false
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(240)
            local playerPed = PlayerPedId()
            local isInVehicle = IsPedInAnyVehicle(playerPed)
    
            if PlayerIsDriver and not isInVehicle then
                PlayerIsDriver = false
                CurrentVehicle = nil
            elseif not PlayerIsDriver and isInVehicle then
               CurrentVehicle = GetVehiclePedIsIn(playerPed, false)
                local VehicleDriver = GetPedInVehicleSeat(CurrentVehicle, -1)
            
                if VehicleDriver == playerPed and not NotSaveForVehicleClasses[GetVehicleClass(CurrentVehicle)] then
                    PlayerIsDriver = true
                end
            end
        end
    end)
    NotSaveForVehicleClasses = {
         [13] = "Bicycles"
        ,[14] = "Boats"
        ,[15] = "Helicopters"
        ,[16] = "Planes"
        ,[17] = "Service"
        ,[21] = "Trains"
    }
    
    Citizen.CreateThread(function()
        local saveInterval = math.max(1, 1000)
    
        while true do
            Citizen.Wait(50)
            
            if PlayerIsDriver and CurrentVehicle then
                local playerPed = PlayerPedId()
                local lastPosition = GetEntityCoords(playerPed)
                Citizen.Wait(saveInterval)
                local currentPosition = GetEntityCoords(playerPed)
            
                if IsVehicleOnAllWheels(CurrentVehicle) then
                    local distance = #(currentPosition - lastPosition)
                
                    if distance > 0 then
                        TriggerServerEvent('mfp_policejob_mileage:update', GetVehicleNumberPlateText(CurrentVehicle), distance / 1000)
                    end
                end
            end
        end
    end)
    
    end -- end of Config.DisableIntegratedMileage

-------------- Mileage -------------


----------------- GARAGE ----------------
local hasPoliceJob = false

local storedVehicles = {}
local hasLoadedStoredVehicles = false
local GarageMenu

function openGarageMenu()

    GarageMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['lspd_garage'])
    _menuPool:Add(GarageMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    GarageMenu:SetBannerSprite(backround, true)
    
    --local backround = Sprite.New('cardealertxt', 'cardealer_bg_sprite', 0, 0, 512, 128)
    --GarageMenu:SetBannerSprite(backround, true)
    
    local storeButton = NativeUI.CreateItem(Translation[Config.Locale]['parkin'], Translation[Config.Locale]['parkin_disc'])
    GarageMenu:AddItem(storeButton)
    
    ESX.TriggerServerCallback('mfp_policejob:getStoredVehicles', function(storedVehicles)
        for _, vehicleData in pairs(storedVehicles) do
            local citem = NativeUI.CreateItem(vehicleData.plate, "Model" .. ": " .. vehicleData.vehicle_model .. "\n" .. "Mileage" .. ": " .. vehicleData.mileage)
            GarageMenu:AddItem(citem)
    
            citem.Activated = function(sender, item)
                local selectedPlate = vehicleData.plate
                TriggerServerEvent('mfp_policejob:takeOutVehicle', selectedPlate)
                GarageMenu:Visible(false)
            end
        end
    end)
    
        storeButton.Activated = function(sender, index)    
            local playerPed = PlayerId()
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local vehicleToStore = ESX.Game.GetClosestVehicle(coords)

            --local vehicleToStore = GetClosestVehicle(coords.x, coords.y, coords.z, 15.0, 0, 70)
            print("Nächstes AUTO: "..GetEntityModel(vehicleToStore))
    
            if DoesEntityExist(vehicleToStore) and not IsEntityDead(vehicleToStore) then
                local cplate = GetVehicleNumberPlateText(vehicleToStore)
                cplate = cplate:upper()
                local vehicleModel = GetEntityModel(vehicleToStore)
                local spawnName = GetDisplayNameFromVehicleModel(vehicleModel)
                print(vehicleModel.. " - "..cplate.. " - "..spawnName)
    
                TriggerServerEvent('mfp_policejob:storeVehicle', {
                    plate = cplate,
                    vehicle_model = vehicleModel,
                    spawn_name = spawnName
                })
                Citizen.Wait(100)
                ESX.Game.DeleteVehicle(vehicleToStore)
            else
                ESX.ShowNotification(Translation[Config.Locale]['nocars'])
            end
            GarageMenu:Visible(false)
        end
    
    
    GarageMenu:Visible(true)
    _menuPool:MouseControlsEnabled (false)
    _menuPool:MouseEdgeEnabled (false)
    _menuPool:ControlDisablingEnabled(false)
end

-- Reload from db
function LoadStoredVehiclesFromDB()
    TriggerServerEvent('mfp_policejob:getStoredVehicles', function(result)
        if result then
            storedVehicles = result
            RefreshCarDealerMenu()
            hasLoadedStoredVehicles = true
        else
            print("CHECK DATABASE CONNECTION")
        end
    end)
    end
    
    local PlayerData = {}
    -- Loading all from db
    Citizen.CreateThread(function()
    Citizen.Wait(500)
    if not hasLoadedStoredVehicles then
        LoadStoredVehiclesFromDB()
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    end)


    function checkJob()
        while true do
            Citizen.Wait(1000)
        
            local playerPed = PlayerPedId()
        
            if PlayerData.job ~= nil and PlayerData.job.name == Config.job then
                hasPoliceJob = true
            else
                hasPoliceJob = false
            end
        end
end
        
Citizen.CreateThread(checkJob) -- old function

RegisterNetEvent("mfp_policejob_spawn:spawn")
AddEventHandler("mfp_policejob_spawn:spawn", function(model, plate, mods) 
    local vehicle = GetHashKey(model)
    local playerPed = PlayerPedId()
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    
    ESX.Game.SpawnVehicle(vehicle, Config.SpawnGarage.spawnlocation, Config.SpawnGarage.heading, function (vehicle)
        --TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        ESX.Game.SetVehicleProperties(vehicle, mods)
        --ESX.ShowNotification("Fahrzeug wurde ausgeparkt.")
    end)
    
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)
----------------- GARAGE ----------------
----------------- HELI GARAGE -----------
local HeliGarageMenu
function openHeliGarageMenu()

    HeliGarageMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['lspd_garage2'])
    _menuPool:Add(HeliGarageMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    HeliGarageMenu:SetBannerSprite(backround, true)
    
    --local backround = Sprite.New('cardealertxt', 'cardealer_bg_sprite', 0, 0, 512, 128)
    --GarageMenu:SetBannerSprite(backround, true)
    
    local storeButton = NativeUI.CreateItem(Translation[Config.Locale]['parkin'], Translation[Config.Locale]['parkin_disc'])
    HeliGarageMenu:AddItem(storeButton)
    
    ESX.TriggerServerCallback('mfp_policejob:getStoredHelis', function(storedVehicles)
        for _, vehicleData in pairs(storedVehicles) do
            local citem = NativeUI.CreateItem(vehicleData.plate, "Model" .. ": " .. vehicleData.vehicle_model .. "\n" .. "Mileage" .. ": " .. vehicleData.mileage)
            HeliGarageMenu:AddItem(citem)
    
            citem.Activated = function(sender, item)
                local selectedPlate = vehicleData.plate
                TriggerServerEvent('mfp_policejob:takeHeli', selectedPlate)
                HeliGarageMenu:Visible(false)
            end
        end
    end)
    
        storeButton.Activated = function(sender, index)    
            local playerPed = PlayerId()
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local vehicleToStore = ESX.Game.GetClosestVehicle(coords)

            --local vehicleToStore = GetClosestVehicle(coords.x, coords.y, coords.z, 15.0, 0, 70)
            print("Nächster Heli: "..GetEntityModel(vehicleToStore))
    
            if DoesEntityExist(vehicleToStore) and not IsEntityDead(vehicleToStore) then
                local cplate = GetVehicleNumberPlateText(vehicleToStore)
                cplate = cplate:upper()
                local vehicleModel = GetEntityModel(vehicleToStore)
                local spawnName = GetDisplayNameFromVehicleModel(vehicleModel)
                print(vehicleModel.. " - "..cplate.. " - "..spawnName)
    
                TriggerServerEvent('mfp_policejob:storeHeli', {
                    plate = cplate,
                    vehicle_model = vehicleModel,
                    spawn_name = spawnName
                })
                Citizen.Wait(100)
                ESX.Game.DeleteVehicle(vehicleToStore)
            else
                ESX.ShowNotification(Translation[Config.Locale]['nocars'])
            end
            HeliGarageMenu:Visible(false)
        end
    
    
    HeliGarageMenu:Visible(true)
    _menuPool:MouseControlsEnabled (false)
    _menuPool:MouseEdgeEnabled (false)
    _menuPool:ControlDisablingEnabled(false)
end

RegisterNetEvent("mfp_policejob_spawn:helispawn")
AddEventHandler("mfp_policejob_spawn:helispawn", function(model, plate, mods) 
    local vehicle = GetHashKey(model)
    local playerPed = PlayerPedId()
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    
    ESX.Game.SpawnVehicle(vehicle, Config.HeliSpawnGarage.spawnlocation, Config.HeliSpawnGarage.heading, function (vehicle)
        --TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        ESX.Game.SetVehicleProperties(vehicle, mods)
        --ESX.ShowNotification("Helicopter wurde ausgeparkt.")
    end)
    
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)
----------------- HELI GARAGE -----------

--- BOAT GARAGE
local BoatGarageMenu
function openBoatGarageMenu()

    BoatGarageMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['lspd_garage3'])
    _menuPool:Add(BoatGarageMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    BoatGarageMenu:SetBannerSprite(backround, true)
    
    --local backround = Sprite.New('cardealertxt', 'cardealer_bg_sprite', 0, 0, 512, 128)
    --GarageMenu:SetBannerSprite(backround, true)
    
    local storeButton = NativeUI.CreateItem(Translation[Config.Locale]['parkin'], Translation[Config.Locale]['parkin_disc'])
    BoatGarageMenu:AddItem(storeButton)
    
    ESX.TriggerServerCallback('mfp_policejob:getStoredBoats', function(storedVehicles)
        for _, vehicleData in pairs(storedVehicles) do
            local citem = NativeUI.CreateItem(vehicleData.plate, "Model" .. ": " .. vehicleData.vehicle_model .. "\n" .. "Mileage" .. ": " .. vehicleData.mileage)
            BoatGarageMenu:AddItem(citem)
    
            citem.Activated = function(sender, item)
                local selectedPlate = vehicleData.plate
                TriggerServerEvent('mfp_policejob:takeBoat', selectedPlate)
                BoatGarageMenu:Visible(false)
            end
        end
    end)
    
        storeButton.Activated = function(sender, index)    
            local playerPed = PlayerId()
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local vehicleToStore = ESX.Game.GetClosestVehicle(coords)

            --local vehicleToStore = GetClosestVehicle(coords.x, coords.y, coords.z, 15.0, 0, 70)
            print("Nächstes Boot: "..GetEntityModel(vehicleToStore))
    
            if DoesEntityExist(vehicleToStore) and not IsEntityDead(vehicleToStore) then
                local cplate = GetVehicleNumberPlateText(vehicleToStore)
                cplate = cplate:upper()
                local vehicleModel = GetEntityModel(vehicleToStore)
                local spawnName = GetDisplayNameFromVehicleModel(vehicleModel)
                print(vehicleModel.. " - "..cplate.. " - "..spawnName)
    
                TriggerServerEvent('mfp_policejob:storeBoat', {
                    plate = cplate,
                    vehicle_model = vehicleModel,
                    spawn_name = spawnName
                })
                Citizen.Wait(100)
                ESX.Game.DeleteVehicle(vehicleToStore)
            else
                ESX.ShowNotification(Translation[Config.Locale]['nocars'])
            end
            BoatGarageMenu:Visible(false)
        end
    
    
    BoatGarageMenu:Visible(true)
    _menuPool:MouseControlsEnabled (false)
    _menuPool:MouseEdgeEnabled (false)
    _menuPool:ControlDisablingEnabled(false)
end

RegisterNetEvent("mfp_policejob_spawn:boatspawn")
AddEventHandler("mfp_policejob_spawn:boatspawn", function(model, plate, mods) 
    local vehicle = GetHashKey(model)
    local playerPed = PlayerPedId()
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    
    ESX.Game.SpawnVehicle(vehicle, Config.BoatSpawnGarage.spawnlocation, Config.BoatSpawnGarage.heading, function (vehicle)
        --TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        ESX.Game.SetVehicleProperties(vehicle, mods)
        --ESX.ShowNotification("Boot wurde ausgeparkt.")
    end)
    
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)
--- BOAT GARAGE

----------------- NOTIFICATION ------------
function ShowInputNotification(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end
----------------- NOTIFICATION ------------

----------------- NPC ------------
Citizen.CreateThread(function()

    RequestStreamedTextureDict("lspdjob", 1)
    while not HasStreamedTextureDictLoaded("lspdjob") do
	    Wait(0)
    end

    for k in pairs(Config.Npc) do
       RequestModel(GetHashKey("s_f_y_cop_01")) 
       while not HasModelLoaded(GetHashKey("s_f_y_cop_01")) do
         Citizen.Wait(1)
       end
       local ped =  CreatePed(4, GetHashKey("s_f_y_cop_01"), Config.Npc[k].x, Config.Npc[k].y, Config.Npc[k].z, Config.Npc[k].h, false, true)
       FreezeEntityPosition(ped, true)
       SetEntityHeading(ped, Config.Npc[k].h, true)
       SetEntityInvincible(ped, true)
       SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)
----------------- NPC ------------



---------------- F6 MENU ----------
local interactionMenu
local personinteraktionMenu
function openInteractionMenu()

    interactionMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['interaction_menu'])
    _menuPool:Add(interactionMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
	interactionMenu:SetBannerSprite(backround, true)
    
    local personinteraktion = NativeUI.CreateItem(Translation[Config.Locale]['person_interaction'], "")
    interactionMenu:AddItem(personinteraktion)
    
    personinteraktion.Activated = function(sender, item)
        interactionMenu:Visible(false)
        openPersonInteraktionMenu()
    end
    
    local vehinteraktion = NativeUI.CreateItem(Translation[Config.Locale]['vehicle_interaction'], "")
    interactionMenu:AddItem(vehinteraktion)
    
    vehinteraktion.Activated = function(sender, item)
        openvehicleinfos()
        interactionMenu:Visible(false)
    end

    local object = NativeUI.CreateItem(Translation[Config.Locale]['object_interaction'], "")
    interactionMenu:AddItem(object)
     
    object.Activated = function(sender, item)
        openObjectMenu()
        interactionMenu:Visible(false)
    end
    
    local tenninenine = NativeUI.CreateItem(Translation[Config.Locale]['ten_ninety_nine'], Translation[Config.Locale]['press_panic_button'])
    interactionMenu:AddItem(tenninenine)

    tenninenine.Activated = function(sender, item)
        interactionMenu:Visible(false)
        TriggerEvent('panicbutton:mfppanic')
    end
    
    interactionMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

local ObjektMenu
function openObjectMenu()

    ObjektMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['object_interaction'])
    _menuPool:Add(ObjektMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
	ObjektMenu:SetBannerSprite(backround, true)

    if Config.Speedcamsscript ~= 'none'  then
        local setubblitzer = NativeUI.CreateItem(Translation[Config.Locale]['setup_speedcam'], Translation[Config.Locale]['place_speedcam'])
        ObjektMenu:AddItem(setubblitzer)

        local verwalteblitzer = NativeUI.CreateItem(Translation[Config.Locale]['manage_speedcam'], Translation[Config.Locale]['manage_speedcam_desc'])
        ObjektMenu:AddItem(verwalteblitzer)

        local objects = NativeUI.CreateItem(Translation[Config.Locale]['place_object'], Translation[Config.Locale]['place_object_desc'])
        ObjektMenu:AddItem(objects)

        objects.Activated = function(sender, item)
            ObjektMenu:Visible(false)
            TriggerEvent('mfp_policejob:checkPlacingObjects')
        end

        setubblitzer.Activated = function(sender, item)
            ObjektMenu:Visible(false)
            if Config.Speedcamsscript == 'myspeedcams' then
                TriggerEvent('myRadarcontrol:createRadar')
            elseif Config.Speedcamsscript == 'custom' then
                CreateCustomSpeedcams()
            end
        end

        verwalteblitzer.Activated = function(sender, item)
            ObjektMenu:Visible(false)
            if Config.Speedcamsscript == 'myspeedcams' then
                TriggerEvent('myRadarcontrol:openBossmenu')
            elseif Config.Speedcamsscript == 'custom' then
                ManageCustomSpeedcams()
            end
        end
    end

    ObjektMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end


function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
    AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
    DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local displayResult = GetOnscreenKeyboardResult()
        return displayResult
    end
end

local cuffedaspolice = false

function openPersonInteraktionMenu()

    personinteraktionMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['interaction_menu'])
    _menuPool:Add(personinteraktionMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
	personinteraktionMenu:SetBannerSprite(backround, true)
    
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local player = GetPlayerServerId(closestPlayer)
    
    local persosuchen = NativeUI.CreateItem(Translation[Config.Locale]['identify_person'], Translation[Config.Locale]['identify_person_desc'])
    personinteraktionMenu:AddItem(persosuchen)

    if not Config.BillingScript == "none" then
        local rechnung = NativeUI.CreateItem(Translation[Config.Locale]['issue_bill'], Translation[Config.Locale]['issue_bill_desc'])
        personinteraktionMenu:AddItem(rechnung)
    end

    local durchsuchen = NativeUI.CreateItem(Translation[Config.Locale]['search_person'], Translation[Config.Locale]['search_person_desc'])
    personinteraktionMenu:AddItem(durchsuchen)

    durchsuchen.Activated = function(sender, item)
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            OpenBodySearchMenu(player)
            personinteraktionMenu:Visible(false)
        else
            ESX.ShowNotification(Translation[Config.Locale]['no_one_nearby'])
        end
    end
    
    persosuchen.Activated = function(sender, item)
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            openIdentityCardMenu(player)
            personinteraktionMenu:Visible(false)
        else
            ESX.ShowNotification(Translation[Config.Locale]['no_one_nearby'])
        end
    end

    if not Config.BillingScript == "none" then
        rechnung.Activated = function(sender, item)
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                local Result_billing = CreateDialog(Translation[Config.Locale]['bill_amount_prompt'])
                if tonumber(Result_billing) then
                    local amount = tonumber(Result_billing)
                    if Config.BillingScript == 'vivum' then
                        TriggerServerEvent("mfp_policejob:sendVivumBilling", player, amount)
                    elseif Config.BillingScript == 'esx_billing' then
                        TriggerServerEvent('esx_billing:sendBill', player, 'society_police', "siehe Akte", amount)
                    elseif Config.BillingScript == 'custom' then
                        OpenCustomBilling(player, amount)
                    end
                end
                personinteraktionMenu:Visible(false)
            else
                ESX.ShowNotification(Translation[Config.Locale]['no_one_nearby'])
            end
        end
    end
    
    local cuff = NativeUI.CreateItem(Translation[Config.Locale]['cuff_player'], Translation[Config.Locale]['cuff_player_desc'])
    personinteraktionMenu:AddItem(cuff)
    
    cuff.Activated = function(sender, item)
        TriggerServerEvent('mfp_policejob:handcuff', player)
    end

    local cuff2 = NativeUI.CreateItem(Translation[Config.Locale]['arrest_player'], Translation[Config.Locale]['arrest_player_desc'])
    personinteraktionMenu:AddItem(cuff2)
    
    cuff2.Activated = function(sender, item)
        if not cuffedaspolice then
            TriggerServerEvent('mfp_policejob:startArrest', GetPlayerServerId(closestPlayer))
            cuffedaspolice = true
            Citizen.Wait(3100)
            TriggerServerEvent('mfp_policejob:handcuff2', player)
        elseif cuffedaspolice then
            TriggerServerEvent('mfp_policejob:handcuff2', player)
            cuffedaspolice = false
        end
    end
    
    if Config.Prisonscript ~= 'none' then
        local prison = NativeUI.CreateItem(Translation[Config.Locale]['send_to_prison'], Translation[Config.Locale]['send_to_prison_desc'])
        personinteraktionMenu:AddItem(prison)

        prison.Activated = function(sender, item)
            personinteraktionMenu:Visible(false)
            if Config.Prisonscript == 'myprison'  then
                TriggerEvent('myPrison:open')
            elseif Config.Prisonscript == 'qalle' then
                TriggerEvent("esx-qalle-jail:openJailMenu")
            elseif Config.Prisonscript == 'custom' then
                OpenCustomJailMenu(player)
            end
        end
    end
    
    personinteraktionMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

RegisterNetEvent('mfp_policejob:arrested')
AddEventHandler('mfp_policejob:arrested', function(target)
    arrested = true

    local playerPed = GetPlayerPed(-1)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

    RequestAnimDict('mp_arrest_paired')

    while not HasAnimDictLoaded('mp_arrest_paired') do
        Citizen.Wait(10)
    end

    AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
    TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)

    Citizen.Wait(950)
    DetachEntity(GetPlayerPed(-1), true, false)

    arrested = false
end)


RegisterNetEvent('mfp_policejob:arrest')
AddEventHandler('mfp_policejob:arrest', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict('mp_arrest_paired')

	while not HasAnimDictLoaded('mp_arrest_paired') do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	--arreste = false

end)

--- animation

local InformationMenu
function openIdentityCardMenu(player)
    InformationMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['open_identity_card'])
    _menuPool:Add(InformationMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    InformationMenu:SetBannerSprite(backround, true)
    print("Übergebe clientside an serverside closestPlayer!")

    ESX.TriggerServerCallback('mfp_policejob:getOtherPlayerData', function(data)
        local name = NativeUI.CreateItem(data.firstname.." "..data.name, "")
        InformationMenu:AddItem(name)

        local beruf = NativeUI.CreateItem(Translation[Config.Locale]['job'], data.grade.."")
        InformationMenu:AddItem(beruf)
        beruf:RightLabel(data.job.."")

        local sex = NativeUI.CreateItem(Translation[Config.Locale]['gender'], "")
        InformationMenu:AddItem(sex)
        sex:RightLabel(data.sex.."")

        local dob = NativeUI.CreateItem(Translation[Config.Locale]['dob'], "")
        InformationMenu:AddItem(dob)
        dob:RightLabel(data.dob.."")

        local height = NativeUI.CreateItem(Translation[Config.Locale]['height'], "")
        InformationMenu:AddItem(height)
        height:RightLabel(data.height.."cm")

        local labellicences = NativeUI.CreateItem(Translation[Config.Locale]['licenses'], "")
        InformationMenu:AddItem(labellicences)

        for i=1, #data.licenses, 1 do
            local licenses = NativeUI.CreateItem(data.licenses[i].label, "~r~Durch auswählen entziehst du der Person diese Lizenz")
            InformationMenu:AddItem(licenses)

            licenses.Activated = function(sender, item)
                InformationMenu:Visible(false)
                TriggerServerEvent('esx_license:removeLicense', player, data.licenses[i].type)
                ESX.ShowNotification(string.format(Translation[Config.Locale]['confiscated_black_money'], data.licenses[i].label))
                openIdentityCardMenu(player)
            end
        end

        local addlicense = NativeUI.CreateItem(Translation[Config.Locale]['add_license'], "")
        InformationMenu:AddItem(addlicense)

        addlicense.Activated = function(sender, item)
            InformationMenu:Visible(false)
            openAddLicenseMenu(player)
        end
    end, player)

    InformationMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

function openAddLicenseMenu(player)
    LicenseAddMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['add_license_confirmation'])
    _menuPool:Add(LicenseAddMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    LicenseAddMenu:SetBannerSprite(backround, true)
    print("Übergebe clientside an serverside closestPlayer!")

    ESX.TriggerServerCallback('mfp_policejob:getOtherPlayerData', function(data)
        local labellicences = NativeUI.CreateItem(Translation[Config.Locale]['add_license_confirmation'], "")
        LicenseAddMenu:AddItem(labellicences)

        ------ drive
        local drive1 = NativeUI.CreateItem(Translation[Config.Locale]['drive_test'], "")
        LicenseAddMenu:AddItem(drive1)

        drive1.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'dmv')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['drive_test']))
            openIdentityCardMenu(player)
        end

        local drive = NativeUI.CreateItem(Translation[Config.Locale]['drive_class_b'], "")
        LicenseAddMenu:AddItem(drive)
        drive:RightLabel("B")

        drive.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'drive')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['drive_class_b']))
            openIdentityCardMenu(player)
        end
        ------ drive

        ------ drive_bike
        local drive_bike = NativeUI.CreateItem(Translation[Config.Locale]['drive_bike_class_a'], "")
        LicenseAddMenu:AddItem(drive_bike)
        drive_bike:RightLabel("A")

        drive_bike.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'drive_bike')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['drive_bike_class_a']))
            openIdentityCardMenu(player)
        end
        ------ drive_bike

        ------ drive_truck
        local drive_truck = NativeUI.CreateItem(Translation[Config.Locale]['drive_truck_class_c'], "")
        LicenseAddMenu:AddItem(drive_truck)
        drive_truck:RightLabel("C")

        drive_truck.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'drive_truck')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['drive_truck_class_c']))
            openIdentityCardMenu(player)
        end
        ------ drive_truck

        ------ aircraft
        local aircraft = NativeUI.CreateItem(Translation[Config.Locale]['aircraft_license'], "")
        LicenseAddMenu:AddItem(aircraft)

        aircraft.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'aircraft')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['aircraft_license']))
            openIdentityCardMenu(player)
        end
        ------ aircraft

        ------ boating
        local boating = NativeUI.CreateItem(Translation[Config.Locale]['boating_license'], "")
        LicenseAddMenu:AddItem(boating)

        boating.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            TriggerServerEvent('esx_license:addLicense', player, 'boating')
            ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['boating_license']))
            openIdentityCardMenu(player)
        end
        ------ boating

        ------ weapon
        local weapon = NativeUI.CreateItem(Translation[Config.Locale]['weapon_license'], "")
        LicenseAddMenu:AddItem(weapon)

        weapon.Activated = function(sender, item)
            LicenseAddMenu:Visible(false)
            if (ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job.grade_name == 'swatofficer') then
                TriggerServerEvent('esx_license:addLicense', player, 'weapon')
                ESX.ShowNotification(string.format(Translation[Config.Locale]['license_issued'], Translation[Config.Locale]['weapon_license']))
            else
                ESX.ShowNotification(Translation[Config.Locale]['no_permission'])
            end
            openIdentityCardMenu(player)
        end
        ------ weapon

        local current_licenses = NativeUI.CreateItem(Translation[Config.Locale]['current_licenses'], "")
        LicenseAddMenu:AddItem(current_licenses)

        for i=1, #data.licenses, 1 do
            local licenses = NativeUI.CreateItem(data.licenses[i].label, "")
            LicenseAddMenu:AddItem(licenses)
        end
    end, player)

    LicenseAddMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

function OpenBodySearchMenu(player)
    SeachMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['search_menu'])
    _menuPool:Add(SeachMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    SeachMenu:SetBannerSprite(backround, true)

    ESX.TriggerServerCallback('mfp_policejob:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                local darkmoney = NativeUI.CreateItem(Translation[Config.Locale]['black_money'], "")
                SeachMenu:AddItem(darkmoney)
                darkmoney:RightLabel(""..ESX.Math.Round(data.accounts[i].money))

                darkmoney.Activated = function(sender, item)
                    TriggerServerEvent('mfp_policejob:confiscatePlayerItem', player, 'item_account', 'black_money', data.accounts[i].money)
                    ESX.ShowNotification(string.format(Translation[Config.Locale]['confiscated_black_money'], data.accounts[i].money))
                    SeachMenu:Visible(false)
                    OpenBodySearchMenu(player)
                end
                break
            end
        end

        local weaponlabel = NativeUI.CreateItem(Translation[Config.Locale]['weapon_section'], "")
        SeachMenu:AddItem(weaponlabel)

        for i=1, #data.weapons, 1 do
            local weapon = NativeUI.CreateItem(""..ESX.GetWeaponLabel(data.weapons[i].name), Translation[Config.Locale]['weapon'])
            SeachMenu:AddItem(weapon)
            weapon:RightLabel(""..data.weapons[i].ammo)

            weapon.Activated = function(sender, item)
                TriggerServerEvent('mfp_policejob:confiscatePlayerItem', player, 'item_weapon', data.weapons[i].name, data.weapons[i].ammo)
                ESX.ShowNotification(string.format(Translation[Config.Locale]['confiscated_weapon'], data.weapons[i].name))
                SeachMenu:Visible(false)
                OpenBodySearchMenu(player)
            end
        end

        local itemlabel = NativeUI.CreateItem(Translation[Config.Locale]['item_section'], "")
        SeachMenu:AddItem(itemlabel)

        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                local item = NativeUI.CreateItem(""..data.inventory[i].label, Translation[Config.Locale]['item'])
                SeachMenu:AddItem(item)
                item:RightLabel(""..data.inventory[i].count)

                item.Activated = function(sender, item)
                    TriggerServerEvent('mfp_policejob:confiscatePlayerItem', player, 'item_standard', data.inventory[i].name, data.inventory[i].count)
                    ESX.ShowNotification(string.format(Translation[Config.Locale]['confiscated_item'], data.inventory[i].count, data.inventory[i].label))
                    SeachMenu:Visible(false)
                    OpenBodySearchMenu(player)
                end
            end
        end
    end, player)

    SeachMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end
-- end of ai


------ cuff -------
local isHandcuffed = false
RegisterNetEvent('mfp_policejob:handcuff')
AddEventHandler('mfp_policejob:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(false)
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
		print "Handcuffed 1"
	end
end)

local isHandcuffedFest = false
RegisterNetEvent('mfp_policejob:handcufffest')
AddEventHandler('mfp_policejob:handcufffest', function()
	isHandcuffedFest = not isHandcuffedFest
	local playerPed = PlayerPedId()

	if isHandcuffedFest then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
		print "Handcuffed 2"
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			--DisableControlAction(0, 0, true) -- Disable changing view
			--DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			--DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			--DisableControlAction(0, 75, true)  -- Disable exit vehicle
			--DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
		--
		if isHandcuffedFest then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			--DisableControlAction(0, 32, true) -- W
			--DisableControlAction(0, 34, true) -- A
			--DisableControlAction(0, 31, true) -- S
			--DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			--DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			--DisableControlAction(0, 0, true) -- Disable changing view
			--DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			--DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			--DisableControlAction(0, 75, true)  -- Disable exit vehicle
			--DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- vehicle infos
local VehicleAbfrageMenu
function openVehicleInfos()
    local playerPed = PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()

    VehicleAbfrageMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['vehicle_interactions'])
    _menuPool:Add(VehicleAbfrageMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    VehicleAbfrageMenu:SetBannerSprite(backround, true)

    local getVehicleInfoQuestion = NativeUI.CreateItem(Translation[Config.Locale]['query_plate'], Translation[Config.Locale]['query_plate_description'])
    VehicleAbfrageMenu:AddItem(getVehicleInfoQuestion)

    getVehicleInfoQuestion.Activated = function(sender, item)
        VehicleAbfrageMenu:Visible(false)
        questionWhichVehiclePlate()
    end

    if DoesEntityExist(vehicle) then
        local getVehicleInfo = NativeUI.CreateItem(Translation[Config.Locale]['check_vehicle'], Translation[Config.Locale]['check_vehicle_description'])
        VehicleAbfrageMenu:AddItem(getVehicleInfo)

        getVehicleInfo.Activated = function(sender, item)
            VehicleAbfrageMenu:Visible(false)
            local coords = GetEntityCoords(playerPed)
            vehicle = ESX.Game.GetVehicleInDirection()
            local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

            OpenVehicleInfosMenu(vehicleData)
        end
    end

    VehicleAbfrageMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

function questionWhichVehiclePlate()
    local plate = KeyboardInput(Translation[Config.Locale]['plate_input'], "", "", 8)

    if plate ~= nil then
        vehicleData = {}
        vehicleData.plate = string.upper(plate)
        OpenVehicleInfosMenu(vehicleData)
    end
end

local VehicleAbfragenMenu
function OpenVehicleInfosMenu(vehicleData)
    VehicleAbfragenMenu = NativeUI.CreateMenu("", Translation[Config.Locale]['vehicle_interactions'])
    _menuPool:Add(VehicleAbfragenMenu)

    local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
    VehicleAbfragenMenu:SetBannerSprite(backround, true)

    ESX.TriggerServerCallback('mfp_policejob:getVehicleInfos', function(retrivedInfo)
        local plate = NativeUI.CreateItem(Translation[Config.Locale]['plate'], "")
        VehicleAbfragenMenu:AddItem(plate)
        plate:RightLabel('~p~'..retrivedInfo.plate)

        local owner = NativeUI.CreateItem(Translation[Config.Locale]['owner'], "")
        VehicleAbfragenMenu:AddItem(owner)

        if not retrivedInfo.owner then
            owner:RightLabel('~p~'..Translation[Config.Locale]['owner_unknown'])
        else
            owner:RightLabel('~p~' ..retrivedInfo.owner)
            if Config.VehicleRegisterScript == 'lux' then
                local isregistered = NativeUI.CreateItem(Translation[Config.Locale]['registered'], "")
                VehicleAbfragenMenu:AddItem(isregistered)
                if retrivedInfo.registered >= 1 then
                    isregistered:RightLabel('~p~'..Translation[Config.Locale]['yes'])

                    local firstregisterdate = NativeUI.CreateItem(Translation[Config.Locale]['first_registration'], "")
                    VehicleAbfragenMenu:AddItem(firstregisterdate)
                    firstregisterdate:RightLabel('~p~'..retrivedInfo.first_registration)

                else
                    isregistered:RightLabel('~p~'..Translation[Config.Locale]['no'])
                end
            end
        end
    end, vehicleData.plate)

    VehicleAbfragenMenu:Visible(true)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

---------- UMKLEIDE ------------
if Config.useWardrobe then
    local umkleideMenu
    function openWardrobeMenu()
        local playerPed = PlayerPedId()
        local grade = ESX.PlayerData.job.grade_name
    
        umkleideMenu = NativeUI.CreateMenu(Translation[Config.Locale]['wardrobe_menu_title'], Translation[Config.Locale]['wardrobe_menu_description'])
        _menuPool:Add(umkleideMenu)
    
        local backround = Sprite.New('lspdjob', 'highorlow', 0, 0, 512, 128)
        umkleideMenu:SetBannerSprite(backround, true)
    
        SetPedArmour(playerPed, 0)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
        ResetPedMovementClipset(playerPed, 0)
    
        local dienstkleidungsitem = NativeUI.CreateItem(Translation[Config.Locale]['service_clothing'], Translation[Config.Locale]['service_clothing_description'])
        umkleideMenu:AddItem(dienstkleidungsitem)
    
        local zivilkleidungsitem = NativeUI.CreateItem(Translation[Config.Locale]['civilian_clothing'], Translation[Config.Locale]['civilian_clothing_description'])
        umkleideMenu:AddItem(zivilkleidungsitem)
    
        zivilkleidungsitem.Activated = function(sender, index)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        end
			--welcomeMenu:Visible(false)
		    dienstkleidungsitem.Activated = function(sender, index)
			    local playerPed = PlayerPedId()
	            local grade = ESX.PlayerData.job.grade_name
                local isWeste = false
		    if grade then
			    setUniform(grade, playerPed, isWeste)
		    elseif data.current.value == 'freemode_ped' then
			    local modelHash

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
					SetPedDefaultComponentVariation(PlayerPedId())

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
	      end
	    end

		umkleideMenu:Visible(true)
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
end

function setUniform(grade, playerPed, isWeste)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Uniforms[grade].m
		else
			uniformObject = Uniforms[grade].f
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
            if isWeste then
                SetPedArmour(playerPed, 100)
            end
		end
	end)
end
end -- end of Config.useWardrobe
---------- UMKLEIDE ------------
---------- PANICBUTTON ---------

RegisterNetEvent('panicbutton:mfppanic')
AddEventHandler('panicbutton:mfppanic', function()
    local ped = PlayerPedId()
    RequestAnimDict("random@arrests")
    while (not HasAnimDictLoaded("random@arrests")) do
        Wait(100)
    end
    TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
    SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
    local playerCoords = GetEntityCoords(PlayerPedId())

    if Config.DispatchScript == 'core' then
        TriggerServerEvent("core_dispatch:addCall",
            "10-99",
            Translation[Config.Locale]['panic_button_triggered'],
            {
                {icon = "fa-bullhorn", info = Translation[Config.Locale]['panic_button_message']}
            },
            { playerCoords.x, playerCoords.y, playerCoords.z },
            'police',
            5000,
            60,
            1
        )
    elseif Config.DispatchScript == 'aty' then
        TriggerEvent("aty_dispatch:SendDispatch", Translation[Config.Locale]['panic_button_message'], "10-99", 60, {"police"})
    elseif Config.DispatchScript == 'cd_dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-99 - Panicbutton',
            message = Translation[Config.Locale]['panic_button_message'],
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Panicbutton',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.DispatchScript == 'qs-dispatch' then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police' },
            callLocation = playerData.coords,
            callCode = { code = '911 - Panicbutton', snippet = 'PANIC' },
            message = " street_1: ".. playerData.street_1.. " street_2: ".. playerData.street_2.. " sex: ".. playerData.sex.."",
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 488,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = '911 - Panikknopf',
                time = (20 * 1000),     --20 secs
            }
        })
    elseif Config.DispatchScript == 'custom' then
        OpenCustomDispatch(playerCoords)
    end

    TriggerServerEvent('panicButton:syncPosition', playerCoords)
    Wait(1000)
    ClearPedTasks(ped)
end)

RegisterNetEvent('panicButton:alarm')
AddEventHandler('panicButton:alarm', function(playername, pos)
    ESX.ShowNotification(Translation[Config.Locale]['panic_button_notification'])
    Wait(1000)
    ClearPedTasks(ped)

    ESX.ShowNotification(playername, Translation[Config.Locale]['panic_button_help'])

    SendNUIMessage({
        PayloadType = {"Panic", "ExternalPanic"},
        Payload = PlayerId()
    })

    if Config.DispatchScript == 'none' then
        local Blip = AddBlipForRadius(pos.x, pos.y, pos.z, 160.0)
        SetBlipRoute(Blip, true)
        CreateThread(function()
            while Blip do
                SetBlipRouteColour(Blip, 1)
                Wait(150)
                SetBlipRouteColour(Blip, 6)
                Wait(150)
                SetBlipRouteColour(Blip, 35)
                Wait(150)
                SetBlipRouteColour(Blip, 6)
            end
        end)
        SetBlipAlpha(Blip, 60)
        SetBlipColour(Blip, 1)
        SetBlipFlashes(Blip, true)
        SetBlipFlashInterval(Blip, 200)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Translation[Config.Locale]['panic_button_blip_name'])
        EndTextCommandSetBlipName(Blip)

        Wait(Config.PanicTime * 1000)

        RemoveBlip(Blip)
        Blip = nil
    end

    Wait(Config.PanicTime * 1000)
end)
--------- PANIC BUTTON -----------------------------
---------- BASICS ---------------
function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end
---------- BASICS ---------------

---------- MAP BLIPS ------------
Citizen.CreateThread(function()    
    RequestStreamedTextureDict("lspdjob", 1)
    while not HasStreamedTextureDictLoaded("lspdjob") do
        Wait(0)
    end

    for _, Blips in pairs(Config.Blips) do
        local blip = AddBlipForCoord(Blips.x, Blips.y, Blips.z)

        SetBlipSprite(blip, 60)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 29)
        SetBlipAsShortRange(blip, true)
            
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Translation[Config.Locale]['blip_name'])
        EndTextCommandSetBlipName(blip)
        
        exports['mfp_blips']:SetBlipInfoTitle(blip, Translation[Config.Locale]['blip_name'], false)
        exports['mfp_blips']:SetBlipInfoImage(blip, "lspdjob", "lspd")
        exports['mfp_blips']:AddBlipInfoText(blip, Translation[Config.Locale]['blip_hours'])
        exports['mfp_blips']:AddBlipInfoText(blip, Translation[Config.Locale]['blip_affiliation'])
        exports['mfp_blips']:AddBlipInfoText(blip, Translation[Config.Locale]['blip_phone'])
        exports['mfp_blips']:AddBlipInfoText(blip, Translation[Config.Locale]['blip_information'])
        exports['mfp_blips']:AddBlipInfoHeader(blip, "") -- Empty header adds the header line
        exports['mfp_blips']:AddBlipInfoText(blip, Translation[Config.Locale]['blip_description'])
    end
end)

---------- MAP BLIPS ------------
