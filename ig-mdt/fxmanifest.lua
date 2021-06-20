-- Made by distritic
-- Do not sell, redistribute or claim this code as your own without my permission, thank you. <3
fx_version 'adamant'
game 'gta5'


ui_page "ui/index.html"

files {
    "ui/whitneymedium.otf",
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/main.css",
    "ui/police.css",
    "ui/images/*",
    "ui/footer.png",
    "ui/mugshot.png"
}

server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    "sv_mdt.lua",
    "sv_vehcolors.lua"
}
client_script "config.lua"
client_script "cl_mdt.lua"

client_script "@igAnticheat/client/cl_loader.lua"