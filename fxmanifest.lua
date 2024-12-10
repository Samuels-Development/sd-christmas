fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Samuel#0008'
description 'Basic Candy Cane Script'
Version '1.0.1'

client_script 'client/*.lua'

server_script 'server/*.lua'

shared_scripts { '@sd_lib/init.lua', '@ox_lib/init.lua', 'config.lua' }

files { 'locales/*.json' }

file 'stream/bzzz_xmas_script_lollipop_a.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_xmas_script_lollipop_a.ytyp'
