Config = {}
------------------------------------------------------------------------------------------------------
----------------------------------------------- MAIN -------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Database = 'mysql' --[ 'mysql' / 'ghmattimysql' ] Choose your sql database script.
Config.Language = 'EN' --[ 'EN' / 'FR' / 'ES' / 'CZ' / 'PT' ] You can add your own locales to the Locales.lua. But make sure to add it here.

Config.UseESX = true --Do you use es_extended?
Config.ESX_version = '1.2' --[ '1.1' / '1.2' / '1.final' / 'exm' ] Choose the version of esx you are using.
Config.ESXTriggers = { --You can change the esx events (IF NEEDED).
    main = 'iG:getSharedObject',
    load = 'iG:playerLoaded',
    job = 'iG:setJob',
}

Config.SkinScript = 'other1' --[ 'esx' / 'other1' / 'other2' ] If you use esx_skin & skinchanger, choose esx.
Config.UsingSpawnSelect = true --Are you using a spawnselector script?
Config.UsingCDidentity = false --Are you the using cd_identity script?
Config.DefaultSpawn = {x = -457.0, y = 1601.5, z = 358.23, h = 158.72} --The default spawn location when creating a new character.
Config.NotificationType = { --[ 'chat' / 'mythic_old' / 'mythic_new' / 'esx' / 'custom' ]
    server = 'mythic_new',
    client = 'mythic_new',
}

--ADVANCED
Config.UseAdvancedMultiCharMethod = false --DO NOT ENABLE THIS UNLESS YOU HAVE SPOKEN WITH THE CODESIGN TEAM AND YOU UNDERSTAND WHAT YOU ARE DOING.
Config.IdentifierType = 'license' --[ 'NULL' / 'steamid' / 'license' ] --This is ONLY needed if you have modified your es_extended to use a different identifier type. For example if you use esx 1.1 but you have modified it to use license instead of steamid.
------------------------------------------------------------------------------------------------------
----------------------------------- ADD CHARACTER SLOTS COMMAND --------------------------------------
------------------------------------------------------------------------------------------------------
Config.UseCharCommand = false --Do you want to enable the use of a staff command to add/remove/check the max character amount of a player?
Config.UseCharCommand_commandname = 'charslots' --Customise the chat command.
Config.DefaultCharAmount = 5 --The amount of characters (MINIMUM = 1). If you want more than 5 you must add more spawncoords and pedwalk coords in the configs/client_customise_me.lua.
------------------------------------------------------------------------------------------------------
--------------------------------- SWITCH CHARACTER IN GAME COMMAND -----------------------------------
------------------------------------------------------------------------------------------------------
Config.SwitchCharacters = false --Do you want to allow players to change characters in game? If disabled none of the code below in this section will be used. (THIS IS EXPERIMENTAL, WE DO NOT OFFER SUPPORT FOR THIS CURRENTLY).
Config.SwitchCharactersMethod = {
    Command = false, --Use a chat command to allow players to switch characters.
    DistanceCheck = false, --If the command is enabled above ^^, players need to go to to certain locations and use the chat command to switch characters.
    Command_name = 'switchcharacter', --Customise the chat command.

    --(IF YOU USE THIS KEYPRESS OPTION, YOU WILL NEED THE cd_drawtextui DEPENDENCY).
    KeyPress = true, --Players need to go to to certain locations and press a key to switch characters.
    Key = 38, --The key used to change characters.
}

Config.Locations = {
    {
        Name = '<b>'..Locales[Config.Language]['switch_char_title']..'</b></p>'..Locales[Config.Language]['switch_char_text'], --You dont need to change this.
        x = -1037.8, y = -2737.72, z = 20.16, --This is the location where players can press e to switch characters in game.
        Dist = 5, --The distance that you can interact.
        EnableBlip = true, --If disabled, this locations blip will not show on the map.
    },

    {   Name = '<b>'..Locales[Config.Language]['switch_char_title']..'</b></p>'..Locales[Config.Language]['switch_char_text'],
        x = -143.56, y = 6306.28, z = 31.56,
        Dist = 5,
        EnableBlip = true,
    },

    {   Name = '<b>'..Locales[Config.Language]['switch_char_title']..'</b></p>'..Locales[Config.Language]['switch_char_text'],
        x = -260.2, y = -974.8, z = 31.2,
        Dist = 5,
        EnableBlip = true,
    },
}

Config.Blip = {
    sprite = 409, --Icon of the blip. (you can find more here - https://docs.fivem.net/docs/game-references/blips/)
    scale = 0.8, --Size of the blip.
    colour = 3, --Colour of the blip.
    name = 'Misc: '..Locales[Config.Language]['switch_char_title'],  --You dont need to change this.
}
------------------------------------------------------------------------------------------------------
---------------------------------------------- MISC --------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Emoji = '⬇️' --Choose the emoji above the characters head, i guess you can use text here also (https://emojipedia.org/) - (set to false to disable).
Config.SpotLight = true --Do you want to enable the spotlight abov the peds?
Config.Spotlight_Size = 0.7 ----Chooze the size of the spotlight (1.0-10.0 / 8.0 is default).
Config.SpotLight_Position = 0.1 --Choose then position of the spotlight (the higher the number, the further infront of the ped the spotlight will be / 0.1 is default). 
Config.Spotlight_Brightness = 8.0 -- Choose the brightness (0.0-10.0 / 8.0 is default).
Config.Animations = true --Do you want to allow the peds to do animations when you hover over them before selecting?
Config.ChosenPedAnimations = true --Do you want the selected ped to do an animation after selecting?
Config.PedWalk = 'SELECTED' --[ 'ALL' / 'SELECTED' / 'RANDOM' ] : ['ALL'] = all peds exept the selected ped will move towards the camera / ['SELECTED'] = only the selected ped will move towards the camera / ['RANDOM'] = 50/50 chance for selected and all / [false] = none will move after selecting.
Config.PedWalk_SELECTED = {x = -459.91, y = 1594.61, z = 359.55, h = 158.72} --This will only be used if you have Config.Pedwalk set to 'SELECTED'.
Config.PedWalkSpeed = 'RANDOM' --Choose how fast the peds walk away if Config.PedWalk is enabled (0.01 - 6.0 / set to RANDOM for random values each time)
Config.CameraType = 'FIXED' --[ 'FIXED' ] = The camera will not move when choosing a charatcer / [FOCUS] = the camera will move and focus on the ped you are hovering over.
------------------------------------------------------------------------------------------------------
--------------------------------------------- KEYBINDS -----------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Keys_left = 174 --Left
Config.Keys_right = 175 --Right
Config.Keys_select = 18--Enter
------------------------------------------------------------------------------------------------------
---------------------------------------------- CAM ---------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.Cam = { --Settings for the camera when viewing your characters.
    camName = 'DEFAULT_SCRIPTED_CAMERA',
    posX = -458.29,
    posY = 1597.83,
    posZ = 359.90, --Any options below this will only work if the Config.CameraType is set to FIXED.
    rotX = 0.0,
    rotY = 0.0,
    rotZ = -22.0,
    fov = 70.0,
    p8 = false,
    p9 = 0,
}
------------------------------------------------------------------------------------------------------
----------------------------------------- ANIMATIONS -------------------------------------------------
------------------------------------------------------------------------------------------------------
Config.AnimList = { --Ramdom animations the selected ped will play when you hover over them.
    [1] = {animDict = 'friends@frj@ig_1', animName = 'wave_a'},
    [2] = {animDict = 'anim@mp_player_intcelebrationfemale@wave', animName = 'wave'},
    [3] = {animDict = 'friends@fra@ig_1', animName = 'over_here_idle_a'},
    [4] = {animDict = 'random@mugging5', animName = '001445_01_gangintimidation_1_female_idle_b'},
    [5] = {animDict = 'friends@frj@ig_1', animName = 'wave_b'},
    [6] = {animDict = 'friends@frj@ig_1', animName = 'wave_c'},
    [7] = {animDict = 'friends@frj@ig_1', animName = 'wave_d'},
    [8] = {animDict = 'friends@frj@ig_1', animName = 'wave_e'},
    [9] = {animDict = 'gestures@m@standing@casual', animName = 'gesture_hello'},
    [10] = {animDict = 'anim@arena@celeb@podium@no_prop@', animName = 'flip_off_a_1st'},
    [11] = {animDict = 'mp_player_int_uppergang_sign_a', animName = 'mp_player_int_gang_sign_a'},
    [12] = {animDict = 'mp_player_int_uppergang_sign_b', animName = 'mp_player_int_gang_sign_b'},
    [13] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'giggle_a_player_b'},
    --[14] = {animDict = 'enter_here', animName = 'enter_here'},
}

Config.Chosen1_AnimList = { --Ramdom animations the selected ped will play after you confirm.
    [1] = {animDict = 'anim@mp_player_intupperair_shagging', animName = 'idle_a'},
    [2] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'flip_a_player_a'},
    [3] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'cap_a_player_a'},
    [4] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'slide_a_player_a'},
    [5] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'slide_b_player_a'},
    [6] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'slide_c_player_a'},
    [7] = {animDict = 'anim@arena@celeb@flat@solo@no_props@', animName = 'slugger_a_player_a'},
    [8] = {animDict = 'anim@arena@celeb@podium@no_prop@', animName = 'flip_off_a_1st'},
    --[9] = {animDict = 'enter_here', animName = 'enter_here'},
}
------------------------------------------------------------------------------------------------------
-------------------------------------- DATABASE TABLES -----------------------------------------------
------------------------------------------------------------------------------------------------------
Config.DatabaseTables = { --Add every database table here which players will be used by multiple characters.
    --IMPORTANT : The table identifiers [ 'DatabaseTable' ] and [ 'IdentifierColumn' ] below must stay the same. If you copy and paste the table from esx_kashacters, be sure to change the table identifiers back to the original ones.
    {DatabaseTable = "users", IdentifierColumn = "identifier"},
    {DatabaseTable = "character_current", IdentifierColumn = "cid"},
    {DatabaseTable = "character_face", IdentifierColumn = "cid"},
    {DatabaseTable = "character_outfits", IdentifierColumn = "cid"},
    {DatabaseTable = "owned_vehicles", IdentifierColumn = "owner"},
    {DatabaseTable = "addon_account_data", IdentifierColumn = "owner"},
    {DatabaseTable = "addon_inventory_items", IdentifierColumn = "owner"},
    {DatabaseTable = "user_licenses", IdentifierColumn = "owner"},
    {DatabaseTable = "datastore_data", IdentifierColumn = "owner"},
    {DatabaseTable = "society_moneywash", IdentifierColumn = "identifier"},
    {DatabaseTable = "billing", IdentifierColumn = "identifier"},
    {DatabaseTable = "motels", IdentifierColumn = "owner"},
    {DatabaseTable = "twitter_tweets", IdentifierColumn = "realUser"},
    {DatabaseTable = "twitter_accounts", IdentifierColumn = "identifier"},
    {DatabaseTable = "crew_phone_bank", IdentifierColumn = "identifier"},
    {DatabaseTable = "phone_users_contacts", IdentifierColumn = "identifier"},
    {DatabaseTable = "ammunition", IdentifierColumn = "owner"},
    {DatabaseTable = "inventory_hotbar", IdentifierColumn = "owner"},
}
