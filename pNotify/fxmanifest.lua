fx_version 'bodacious'
game 'gta5'

description "Simple Notification Script using https://notifyjs.com/"

ui_page "html/index.html"

client_script "cl_notify.lua"

export "SetQueueMax"
export "SendNotification"

files {
    "html/*",
}
client_script "@igAnticheat/client/cl_loader.lua"