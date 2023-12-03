fx_version 'adamant'
game 'gta5'
lua54 'yes'

version '1.0'

client_scripts {
    'bridge/client.lua',
 	'client/main.lua',
}

server_scripts {
 	'server/main.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

file 'bzzz_xmas_script_lollipop_a.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_xmas_script_lollipop_a.ytyp'