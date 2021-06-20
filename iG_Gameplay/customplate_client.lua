-- --- IMAGE CONFIG HERE ---
-- imageUrl = "https://media.discordapp.net/attachments/645251419808727072/720224997594890261/plate.png" -- Paste your image URL here (doesn't have to be from imgur)


-- -- The actual script --
-- local textureDic = CreateRuntimeTxd('duiTxd')
-- for i = 1, 10 do

--     local object = CreateDui(imageUrl, 540, 300)
--     _G.object = object

--     local handle = GetDuiHandle(object)
--     local tx = CreateRuntimeTextureFromDuiHandle(textureDic, 'duiTex', handle)

--     AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')

-- end


-- local textureDic = CreateRuntimeTxd('duiTxd')
-- for i = 1, 10 do

--     local object = CreateDui('https://i.imgur.com/Q3uw6V7.png', 540, 300)-- this URL doesn't need to be edited, its just the 2d model for the plate
--     _G.object = object

--     local handle = GetDuiHandle(object)
--     local tx = CreateRuntimeTextureFromDuiHandle(textureDic, 'duiTex', handle)

--     AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex')

-- end

plates = {
    {"plate01","https://cdn.discordapp.com/attachments/645251419808727072/724236714322952222/vicplate.png",370,188},
    {"plate01_n","https://i.imgur.com/Q3uw6V7.png",370,189},
    -- {"plate02","https://cdn.discordapp.com/attachments/645251419808727072/724238585246646352/yellowplate.png",368,189},
    -- {"plate02_n","https://i.imgur.com/Q3uw6V7.png",300,160},
    {"plate03","https://cdn.discordapp.com/attachments/645251419808727072/724238599385776219/blueplate.png",500,262},
    {"plate03_n","https://i.imgur.com/Q3uw6V7.png",300,160},
    {"plate04_n","https://i.imgur.com/Q3uw6V7.png",300,154},
    {"plate04","https://cdn.discordapp.com/attachments/645251419808727072/724238564648288287/exemptplate.png",370,188},
    {"plate05","https://cdn.discordapp.com/attachments/645251419808727072/724239158469591060/otherplate.png",370,187},
    {"plate05_n","https://i.imgur.com/Q3uw6V7.png",370,187}
    -- {"yankton_plate","https://i.imgur.com/AaYnMK9.png",734,361},
    -- {"yankton_plate_n","https://i.imgur.com/Q3uw6V7.png",256,128},
}
for l, p in pairs(plates) do
    local txd = CreateRuntimeTxd("testing")
    local duiObj = CreateDui(p[2], p[3], p[4])
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, "test", dui)
    AddReplaceTexture("vehshare", p[1], "testing", "test")
end