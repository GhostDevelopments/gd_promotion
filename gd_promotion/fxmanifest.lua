fx_version "cerulean"
game "gta5"

author "Ghost Developments"
description "Business Promotions"
version "1.0.0"

ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/style.css",
    "html/script.js"
}

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua"
}

client_scripts {
    "client/main.lua"
}

server_scripts {
    "server/main.lua"
}
