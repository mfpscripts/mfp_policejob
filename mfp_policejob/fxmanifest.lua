fx_version 'bodacious'
game 'gta5'
version '0.2'
author 'MFPSCRIPTS.com'
description 'PoliceJob for ESX'
  
client_scripts {
  '@NativeUI/NativeUI.lua',
  'config/config.lua',
  'config/translations.lua',
  'client/client.lua',
  'client/client_encrypted.lua',
  'config/uniforms.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config/config.lua',
  'config/translations.lua',
  'config/webhook.lua',
  'server/server.lua'
}
description 'mfp_policejob | Native UI'
author 'MFPSCRIPTS'
version 'ALPHA'

ui_page "html/index.html"
 

files {
	"html/index.html",
	"html/*.ogg"
}

exports {
  'getWeaponStock',
  'GetCarMileage',
  'Handcuff',
  'getVehicleInfos',
  'getPlayerData',
  'openInteractionMenu',
  'openWardrobeMenu',
  'SetUniform'
}

-- visit mfpscripts.com for more! --