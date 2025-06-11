Config = {}

----------- POLICEJOB -------
Config.Locale = 'en' -- en or de
Config.job = 'police' -- change if your job got another name
Config.JobMenuButton = 167 
-- 167 for F6
-- 214 for DELETE (if you use multiple menus)

--------- SCRIPT INTEGRATIONS --------


----------- PANICBUTTON (+ Dispatch) -----------
Config.PanicTime = 120 -- in sec
Config.DispatchScript = 'none'
-- 'none' for no special dispatch script
-- 'core' for default core dispatch
-- 'aty' for aty_dispatch
-- 'cd_dispatch' for cd_dispatch
-- 'qs-dispatch' for Quasar Dispatch
-- 'custom' for custom script

function OpenCustomDispatch(playerCoords)
    -- add custom dispatch script here if Config.DispatchScript = 'custom'
end
------------------------------

----------- BILLING -----------
Config.BillingScript = 'none'
-- 'none' to disable interactionmenu-billings
-- 'esx_billing' for default esx billing
-- 'vivum' for VivumBilling
-- 'custom' for custom script

function OpenCustomBilling(target, amount)
    -- add custom billing script here if Config.BillingScript = 'custom'
end
------------------------------

----------- MILEAGE -----------
Config.EnableIntegratedMileage = true -- (use our free resource: mfp_mileage)
Config.MileageScript = 'mfp'
-- 'mfp' for our free resource mfp_mileage
-- 'integrated' to enable the demo version of this feature
------------------------------

----------- VEHICLE REGISTER -----------
Config.VehicleRegisterScript = 'none'
-- 'lux' for default lux_vehiclepaper
-- 'none' to disable this feature
------------------------------


----------- PRISON -----------
Config.Prisonscript = 'custom' 
-- 'none' if you want to deactivate
-- 'myprison' for MyPrison
-- 'qalle' for esx-qalle-jail
-- 'custom' for custom script

function OpenCustomJailMenu(target)
    -- add custom jail script here if Config.Prisonscript = 'custom'
end
-----------------------------


----------- SPEEDCAMS -----------
Config.Speedcamsscript = 'custom' 
-- 'none' if you want to deactivate
-- 'myspeedcams' for MySpeedcams
-- 'custom' for custom script

function CreateCustomSpeedcams()
    -- add custom speedcam script here if Config.Speedcamsscript = 'custom'
end

function ManageCustomSpeedcams()
    -- add custom speedcam script here if Config.Speedcamsscript = 'custom'
end
-----------------------------

----------- WAFFENKAMMER ---------------
Config.WeaponArmory = {
    { x = 452.3664, y = -980.1047, z = 30.68959}, -- add more here
    --{ x = 452.3664, y = -980.1047, z = 30.68959}
}
----------- WAFFENKAMMER ---------------

----------- UMKLEIDE ---------------
Config.useWardrobe = true
Config.Wardrobe = {
    { x = 460.2656, y = -990.8373, z = 30.68958 - 1.4}
}
-- GO TO uniforms.lua to edit accessable uniforms --
----------- UMKLEIDE ---------------

----------- BLIPS
Config.Blips = {
    { x =-371.9647, y = -353.1033, z = 31.65463},
    { x = 1834.122, y = 3678.062, z = 34.18917},
    { x = -466.2986, y = 7086.193, z = 22.3836},
}
-- end of blips

----------- OBEJECTS
Config.MaxRotAmt = 15 -- max rotation speed of props
Config.ObjJobs = {
    ["police"] = {
        Label = "LSPD",
        Objects = {
            {jobgrade = 0, freezeposition = false, label = "Cone", model = `prop_roadcone02a`},
            {jobgrade = 0, freezeposition = false,  label = "Road Pole", model = `prop_roadpole_01a`},
            {jobgrade = 0, freezeposition = true,  label = "Barrier", model = `prop_barrier_work06a`},
            {jobgrade = 0, freezeposition = true,  label = "Road Barrier", model = `prop_mp_barrier_02b`},
            {jobgrade = 0, freezeposition = true,  label = "Work Light", model = `prop_worklight_02a`},
            {jobgrade = 0, freezeposition = true,  label = "Light", model = `prop_worklight_03b`},  
            {jobgrade = 0, freezeposition = true,  label = "Road Sign", model = `prop_sign_road_01b`},
            {jobgrade = 0, freezeposition = true,  label = "Tent", model = `prop_gazebo_03`},
            {jobgrade = 0, freezeposition = true,  label = "Nagelbänder", model = `p_ld_stinger_s`},
            {jobgrade = 0, freezeposition = true,  label = "Folding Table", model = `prop_ven_market_table1`}, 
        }
    }, -- add more if you want to use sherrif or fib to have other props
}

-------------------------

Config.Npc = { -- coords to add more npc's dealers you want
   { x= 120.6021, y= -1112.61,  z= 29.2, h= 162.32},
    {x=-419.9271, y=-380.6265, z=25.09882-0.9, h = 79.33177}, -- waffenkammer
    {x=-403.4632, y=-379.6298, z=25.09881-0.9, h=347.2763}, -- waffenkammer 2
    {x=-395.9233, y=-364.8147, z=25.09881-0.9, h=80.25219}, -- umkleide
    {x=-408.1449, y=-342.7083, z=70.95486-0.9, h=262.7765},
    {x=1855.682, y=3714.475, z=33.97462-0.9, h=125.2301},
    {x=351.8873, y=-589.9402, z=92.90539-0.9, h=63.38662}, -- SAFD
    {x=-387.2493, y=-374.4031, z=24.59882-0.9, h=355.644}, -- garage
    {x=-374.6445, y=-376.4098, z=24.59882-0.9, h=1.821712}, -- autokauf
    { x= -401.5601, y= -350.5667, z= 70.95494-0.9, h= 313.7285 }, -- helikauf
}

----------- VEHICLESHOP ---------------
Config.VehicleShopPoint = { -- coords to add more npc's dealers you want
   {x=-374.6445, y=-376.4098, z=25.09882}, -- vector4(458.5031, -1024.415, 28.36797, 94.6502)
}

Config.Buyvehicles = {
    {label = 'Policecar 1', model = 'police'},
    {label = 'Policecar 2', model = 'police2'},
    {label = 'Policecar 3', model = 'police3'},
    {label = 'Undercover Policecar', model = 'police4'},
    {label = 'Policebus', model = 'pbus'},
    {label = 'Policevan', model = 'policet'},
    {label = 'Riot', model = 'riot'},
    {label = 'Anti-Demonstration', model = 'riot2'},
    {label = 'Sherrifcar', model = 'sheriff'},
    {label = 'Sherrifcar 2', model = 'sheriff2'},
    {label = 'FIB 1', model = 'fbi'},
    {label = 'FIB', model = 'fbi2'},
}
Config.SpawnLocation = {
    spawnlocation = { x = -374.869, y = -366.9563, z = 25.09882}, -- vector4(449.4391, -1019.73, 28.48152, 87.98547)
    heading = 262.7523
}
--- end of veh
--- heli

Config.HeliShopPoint = { -- coords to add more npc's dealers you want
   { x= -407.4844, y= -342.6887, z= 70.95486}, -- vector4(459.2958, -972.2529, 43.69169, 72.77843)
}
Config.BuyHeli = {
    {label = 'Policeheli', model = 'polmav'},
    {label = 'Buzzard', model = 'buzzard2'},
}
Config.HeliSpawnLocation = {
    spawnlocation = { x= -393.9622, y= -337.3011, z= 72.84016}, -- vector4(449.6695, -981.64, 43.69165, 122.8213)
    heading = 327.4502
}

--- boat

Config.BoatShopPoint = { -- coords to add more npc's dealers you want
   { x= -766.314, y= -1472.75, z= 5.000},
}
Config.BuyBoat = {
    {label = 'Policeboot', model = 'predator'},
    {label = 'Dinghy', model = 'dinghy2'},
}
Config.BoatSpawnLocation = {
    spawnlocation = { x= -796.1558, y= -1500.56,  z= 0.495 }, -- vector4(449.6695, -981.64, 43.69165, 122.8213)
    heading = 113.80
}
--------------------------------------

---- GARAGE ------
Config.GaragePoint = { -- coords to add more npc's dealers you want
   { x=-387.2493, y=-374.4031, z=25.09882}, -- vector4(458.2484, -1008.462, 28.28386, 150.9301)
}
Config.distanceToPark = 10.0 -- max distance to park
Config.SpawnGarage = {
    spawnlocation = { x=-374.869, y=-366.9563, z=25.09882}, -- vector4(449.4391, -1019.73, 28.48152, 87.98547)
    heading = 262.7523
}


Config.HeliGaragePoint = { -- coords to add more npc's dealers you want
   { x= -401.5601, y= -350.5667, z= 70.95494}, -- vector4(459.0266, -978.1691, 43.69183, 273.8596)
}
Config.HelidistanceToPark = 30.0 -- max distance to park
Config.HeliSpawnGarage = {
    spawnlocation = { x= -393.9622, y= -337.3011, z= 72.84016}, -- vector4(449.6695, -981.64, 43.69165, 122.8213)
    heading = 327.4502
}

Config.BoatGaragePoint = { -- coords to add more npc's dealers you want
    { x= -798.0648, y= -1493.52,  z= 1.59527}, -- vector4(-796.1558, -1500.561, 0.4951866, 113.8025)
}
Config.BoatdistanceToPark = 30.0 -- max distance to park
Config.BoatSpawnGarage = {
    spawnlocation = { x= -796.1558, y= -1500.56,  z= 0.495 }, -- vector4(449.6695, -981.64, 43.69165, 122.8213)
    heading = 113.80
}
