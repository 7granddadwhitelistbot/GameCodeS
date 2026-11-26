local v1 = function()
    --[[
      line: 57
    ]]
    return false
end

local timestamp = os.clock()
local players = game:GetService("Players")
local starterGui = game:GetService("StarterGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local proximityPromptService = game:GetService("ProximityPromptService")
local guiService = game:GetService("GuiService")
local workspace = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
pcall(
    function()
        --[[
          line: 16
          upvalues:
            playerGui (copy, index: 1)
        ]]
        playerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
    end
)
local parent = script.Parent
local shared = replicatedStorage:WaitForChild("Shared")
local Signal = require(shared:WaitForChild("Signal"))
local Loc = require(shared:WaitForChild("Loc"))
Loc.Install()
local Theme = require(parent.Theme)
local UI = require(parent.UI)
local Sounds = require(parent.Sounds)
local Remotes = require(parent.Remotes)
local State = require(parent.State)
local MenuManager = require(parent.MenuManager)
local WeaponInfo = require(parent.WeaponInfo)
local WeaponIcon = require(parent.WeaponIcon)
local Portraits = require(parent.Portraits)
local Fighters = require(parent.Fighters)
WeaponIcon.Init(UI, WeaponInfo)
Portraits.Init(UI, Fighters)
pcall(
    function()
        --[[
          line: 44
          upvalues:
            guiService (copy, index: 1)
        ]]
        guiService.AutoSelectGuiEnabled = false
    end
)
UI.SelectionRing(playerGui)
local v26 = false
local v27 = v1

local function applyPlayerList()
    --[[
      name: applyPlayerList
      line: 60
      upvalues:
        v26 (ref,  index: 1)
        starterGui (copy, index: 2)
        State (copy, index: 3)
        v27 (ref,  index: 4)
    ]]
    if not v26 then
        return
    end

    pcall(
        function()
            --[[
              line: 64
              upvalues:
                starterGui (copy, index: 1)
                State (copy, index: 2)
                v27 (ref,  index: 3)
            ]]
            local playerList = Enum.CoreGuiType.PlayerList
            local enabled = not State.InMatch() and not v27()
            starterGui:SetCoreGuiEnabled(playerList, enabled)
        end
    )

    pcall(
        function()
            --[[
              line: 68
              upvalues:
                starterGui (copy, index: 1)
                State (copy, index: 2)
            ]]
            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, not State.InMatch())
        end
    )
end

task.spawn(
    function()
        --[[
          line: 72
          upvalues:
            starterGui (copy, index: 1)
            State (copy, index: 2)
            v27 (ref,  index: 3)
            v26 (ref,  index: 4)
            applyPlayerList (copy, index: 5)
        ]]
        for _ = 1, 20 do
            if pcall(
                function()
                    --[[
                      line: 74
                      upvalues:
                        starterGui (copy, index: 1)
                        State (copy, index: 2)
                        v27 (ref,  index: 3)
                    ]]
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
                    local playerList = Enum.CoreGuiType.PlayerList
                    local enabled = not State.InMatch() and not v27()
                    starterGui:SetCoreGuiEnabled(playerList, enabled)
                end
            ) then
                v26 = true
                applyPlayerList()

                return
            end

            task.wait(0.5)
        end
    end
)

local _, hud = UI.Screen("TR_HUD", 5, playerGui)
local _, v37 = UI.Screen("TR_Backdrop", 9, playerGui, {fullBleed = true})
UI.BackdropCanvas = v37
local _, menus = UI.Screen("TR_Menus", 10, playerGui)
local _, overlay = UI.Screen("TR_Overlay", 20, playerGui, {fullBleed = true})
local _, top = UI.Screen("TR_Top", 40, playerGui, {fullBleed = true})
local v44 = {
    HudHidden = false,
    UI = UI,
    Theme = Theme,
    Sounds = Sounds,
    Remotes = Remotes,
    State = State,
    MenuManager = MenuManager,
    WeaponInfo = WeaponInfo,
    WeaponIcon = WeaponIcon,
    Portraits = Portraits,
    Fighters = Fighters,
    Loc = Loc,
    Player = localPlayer,
    PlayerGui = playerGui,
    Canvas = {HUD = hud, Backdrop = v37, Menus = menus, Overlay = overlay, Top = top},
    HudHiddenChanged = Signal.new(),
    HeldWeaponChanged = Signal.new(),
    Debug = {},
    Toast = (function(a45, a46, a47)
        --[[
          name: Toast
          line: 117
        ]]
        print("[UI toast]", a45, a46)
    end)
}
local v48 = {}

function v44.SetHudHidden(key, a50)
    --[[
      name: SetHudHidden
      line: 124
      upvalues:
        v48 (copy, index: 1)
        v44 (copy, index: 2)
    ]]
    v48[key] = a50 and true or nil
    local hudHidden = next(v48) ~= nil

    if v44._refreshMenuOpen then
        task.defer(v44._refreshMenuOpen)
    end

    if hudHidden ~= v44.HudHidden then
        v44.HudHidden = hudHidden
        v44.HudHiddenChanged:Fire(hudHidden)
    end
end

function v44.IsHudHiddenFor(key)
    --[[
      name: IsHudHiddenFor
      line: 135
      upvalues:
        v48 (copy, index: 1)
    ]]
    return v48[key] == true
end

local contentProvider = game:GetService("ContentProvider")
local v54 = {}

function v44.PreloadThumb(key, a56)
    --[[
      name: PreloadThumb
      line: 143
      upvalues:
        v54 (copy, index: 1)
        contentProvider (copy, index: 2)
    ]]
    if type(key) ~= "string" or key == "" then
        return
    end
    if v54[key] ~= nil and not a56 then
        return
    end

    if v54[key] == nil then
        v54[key] = false
        pcall(
            function()
                --[[
                  line: 152
                  upvalues:
                    contentProvider (copy, index: 1)
                    key (copy, index: 2)
                ]]
                contentProvider:PreloadAsync({key})
            end
        )
        v54[key] = true

        return
    end

    local timestamp = os.clock()

    while v54[key] == false and os.clock() - timestamp < 8 do
        task.wait(0.1)
    end
end

State.MatchChanged:Connect(
    function(a58)
        --[[
          line: 163
          upvalues:
            v54 (copy, index: 1)
            v44 (copy, index: 2)
        ]]
        if a58 and type(a58.mapThumb) == "string" and v54[a58.mapThumb] == nil then
            task.spawn(v44.PreloadThumb, a58.mapThumb)
        end
    end
)

State.MatchEvent:Connect(
    function(a59, a60)
        --[[
          line: 168
          upvalues:
            v44 (copy, index: 1)
        ]]
        if a59 == "MatchStart" and type(a60) == "table" then
            task.spawn(v44.PreloadThumb, a60.mapThumb)
        end
    end
)

function v44.ProfileAction(a61, ...)
    --[[
      name: ProfileAction
      line: 176
      upvalues:
        State (copy, index: 1)
        v44 (copy, index: 2)
        Remotes (copy, index: 3)
    ]]
    if State.Mock then
        return v44.Debug._mockProfileAction(a61, ...)
    end

    local v62, v63, v64, v65 = Remotes.Invoke("ProfileAction", a61, ...)
    if not v62 then
        v44.Toast(tostring((v63 or "Server unavailable")), "error")
        return false, (tostring(v63))
    end

    if v63 ~= true then
        v44.Toast(tostring((v64 or "Couldn't do that")), "error")
        return false, v64
    end

    task.delay(0.6, State.Refresh)

    return true, nil, v65
end

function v44.QueueAction(a66, a67, a68, a69)
    --[[
      name: QueueAction
      line: 196
      upvalues:
        State (copy, index: 1)
        v44 (copy, index: 2)
        Remotes (copy, index: 3)
    ]]
    if State.Mock then
        if v44.Debug._mockQueueAction then
            return v44.Debug._mockQueueAction(a66, a69)
        end

        v44.Toast("(mock) " .. a66, "info")

        return true, nil
    end

    local v70, v71, v72 = Remotes.Invoke("QueueAction", a66, a67 or "menu", a68, a69)
    if not v70 then
        v44.Toast(tostring((v71 or "Server unavailable")), "error")
        return false, (tostring(v71))
    end

    if v71 == true then
        return true, nil
    end

    if v72 then
        v44.Toast(tostring(v72), "error")
    end

    return false, v72
end

State.Start()
require(parent.SettingsStore).Init(v44)
require(parent.Economy).Init(v44)
require(parent.Custom).Init(v44)
require(parent.Tribes).Init(v44)
MenuManager.Changed:Connect(
    function(a73)
        --[[
          line: 225
          upvalues:
            proximityPromptService (copy, index: 1)
        ]]
        proximityPromptService.Enabled = a73 == nil
    end
)
local v74 = false

local function refreshMenuOpen()
    --[[
      name: refreshMenuOpen
      line: 233
      upvalues:
        MenuManager (copy, index: 1)
        v48 (copy, index: 2)
        localPlayer (copy, index: 3)
        UI (copy, index: 4)
        v74 (ref,  index: 5)
        guiService (copy, index: 6)
    ]]
    local v76 = MenuManager.IsOpen()
        or v48.MatchEnd == true
        or v48.Intro == true
        or v48.Celebrate == true
        or v48.Reveal == true
        or v48.RankUp == true

    if localPlayer:GetAttribute("MenuOpen") ~= v76 then
        localPlayer:SetAttribute("MenuOpen", v76)
    end

    if UI.Touch then
        local v77 = v76 or localPlayer:GetAttribute("TouchControlsReady") == false
        v74 = v77
        pcall(
            function()
                --[[
                  line: 246
                  upvalues:
                    guiService (copy, index: 1)
                    v77 (copy, index: 2)
                ]]
                guiService.TouchControlsEnabled = not v77
            end
        )

        return
    end

    if v74 then
        v74 = false
        pcall(
            function()
                --[[
                  line: 251
                  upvalues:
                    guiService (copy, index: 1)
                ]]
                guiService.TouchControlsEnabled = true
            end
        )
    end
end

MenuManager.Changed:Connect(refreshMenuOpen)

v27 = function()
    --[[
      line: 258
      upvalues:
        MenuManager (copy, index: 1)
        v44 (copy, index: 2)
    ]]
    return MenuManager.IsOpen() or v44.HudHidden == true
end

MenuManager.Changed:Connect(applyPlayerList)
v44.HudHiddenChanged:Connect(applyPlayerList)
UI.TouchChanged:Connect(refreshMenuOpen)
localPlayer:GetAttributeChangedSignal("TouchControlsReady"):Connect(refreshMenuOpen)
v44._refreshMenuOpen = refreshMenuOpen
task.defer(refreshMenuOpen)
v44.PendingEvent = nil

function v44.OnMatchEvent(a78)
    --[[
      name: OnMatchEvent
      line: 272
      upvalues:
        State (copy, index: 1)
        v44 (copy, index: 2)
    ]]
    State.MatchEvent:Connect(a78)

    if const pendingEvent = v44.PendingEvent then
        task.spawn(a78, pendingEvent.kind, pendingEvent.data)
    end
end

local v80 = {"Notifications", "LobbyHud", "MatchSettings", "RankedSwitch", "Hotbar", "ActionHints", "Nameplates", "TouchLayout", "Economy", "Party", "Joining", "DropReveal", "ChatTags", "CustomLobby", "Onboarding", "Moderation", "CheaterBanned"}
local v81 = {"MatchHud", "TabList", "KillFeed", "Decider", "Banners", "Celebration", "Spectate", "LoadoutSwap", "TeamChat"}
local v82 = {"Leaderboards", "CustomLive", "MoveDebug", "TribeHall", "News", "GoldenOffer"}
local v83 = {Mode = "ModeSelect", Ranks = "RankRoad", Loadout = "Loadout", Settings = "Settings", Collection = "Collection", Letter = "Letter", PlayerCard = "PlayerCard", CustomMatches = "CustomMatches", CustomHost = "CustomHost", Tribe = "Tribe", News = "News", GoldenOffer = "GoldenOffer"}
local screens = parent:WaitForChild("Screens")
local v85 = {}
local v86 = {}
local v87 = false

local function ensureScreen(childName)
    --[[
      name: ensureScreen
      line: 290
      upvalues:
        v86 (copy, index: 1)
        screens (copy, index: 2)
        v44 (copy, index: 3)
        v85 (copy, index: 4)
        v87 (ref,  index: 5)
        runService (copy, index: 6)
    ]]
    if v86[childName] then
        return true
    end

    v86[childName] = true
    local child = screens:FindFirstChild(childName) or screens:WaitForChild(childName, 5)
    if not child then
        warn("[UI] missing screen module " .. childName)
        return false
    end

    local timestamp = os.clock()
    local success, result = xpcall(
        function()
            --[[
              line: 301
              upvalues:
                child (copy, index: 1)
                v44 (copy, index: 2)
            ]]
            require(child).Init(v44)
        end,
        debug.traceback
    )
    local v94 = (os.clock() - timestamp) * 1000
    v85[childName] = v94

    if success then
        if v87 and runService:IsStudio() then
            print(string.format("[UI] built %s on demand in %.1f ms", childName, v94))
        end
    else
        warn("[UI] screen " .. childName .. " failed to init: " .. tostring(result))
    end

    return success
end

v44.EnsureScreen = ensureScreen

v44.IsScreenLoaded = function(key)
    --[[
      line: 314
      upvalues:
        v86 (copy, index: 1)
    ]]
    return v86[key] == true
end

MenuManager.SetLoader(
    function(key)
        --[[
          line: 318
          upvalues:
            v83 (copy, index: 1)
            ensureScreen (copy, index: 2)
        ]]
        if const childName = v83[key] then
            ensureScreen(childName)
        end
    end
)

v44.BuildMatchScreens = function()
    --[[
      name: buildMatchScreens
      line: 326
      upvalues:
        v81 (copy, index: 1)
        ensureScreen (copy, index: 2)
    ]]
    for _, childName in v81 do
        ensureScreen(childName)
    end
end

for _, childName in v80 do
    ensureScreen(childName)
end

local timestamp2 = os.clock()
v87 = true

State.PlayerStateChanged:Connect(
    function(a103)
        --[[
          line: 339
          upvalues:
            applyPlayerList (copy, index: 1)
            v81 (copy, index: 2)
            ensureScreen (copy, index: 3)
        ]]
        applyPlayerList()

        if a103 == "Match" then
            for _, childName in v81 do
                ensureScreen(childName)
            end
        end
    end
)

State.WatchChanged:Connect(
    function(a106)
        --[[
          line: 346
          upvalues:
            v81 (copy, index: 1)
            ensureScreen (copy, index: 2)
        ]]
        if a106 then
            for _, childName in v81 do
                ensureScreen(childName)
            end
        end
    end
)

if State.Watching() then
    for _, childName in v81 do
        ensureScreen(childName)
    end
end

applyPlayerList()

if State.InMatch() then
    for _, childName in v81 do
        ensureScreen(childName)
    end
end

State.MatchEvent:Connect(
    function(kind, data)
        --[[
          line: 360
          upvalues:
            v86 (copy, index: 1)
            Portraits (copy, index: 2)
            v44 (copy, index: 3)
            v81 (copy, index: 4)
            ensureScreen (copy, index: 5)
        ]]
        if kind == "MatchStart" and v86.MatchHud then
            Portraits.Reset()
        end

        local v115 = not v86.MatchHud
        local v116 = kind == "MatchEnd" and not v86.MatchEnd

        if not v115 and not v116 then
            return
        end

        v44.PendingEvent = {kind = kind, data = data}

        if kind == "MatchStart" then
            Portraits.Reset()
        end

        if v115 then
            for _, childName in v81 do
                ensureScreen(childName)
            end
        end

        if v116 then
            ensureScreen("MatchEnd")
        end

        v44.PendingEvent = nil
    end
)

local userInputService = game:GetService("UserInputService")
local Keybinds = require(replicatedStorage.Shared:WaitForChild("Keybinds"))

Keybinds.OnInput(
    "Began",
    function(a121, a122)
        --[[
          line: 387
          upvalues:
            userInputService (copy, index: 1)
            v44 (copy, index: 2)
            MenuManager (copy, index: 3)
        ]]
        if userInputService:GetFocusedTextBox() then
            return
        end

        if a121.KeyCode == Enum.KeyCode.M and not a122
            or a121.KeyCode == Enum.KeyCode.ButtonSelect and not v44.PadCapturing
        then
            MenuManager.Toggle("Settings")
        end
    end
)

local loadoutKeys = {kb = Enum.KeyCode.E, pad = Enum.KeyCode.ButtonX}
local timestamp3 = -math.huge
v44.LoadoutKeys = loadoutKeys
local v125 = {LoadoutPrompt = "Loadout", ContractPrompt = "Collection", LetterPrompt = "Letter", CustomMatchesPrompt = "CustomMatches", TribePrompt = "Tribe", TribeBoardPrompt = "Tribe"}
local v126 = {TribeBoardPrompt = "Leaderboard"}
local v127 = {Loadout = true, Collection = true, Letter = true, CustomMatches = true, Tribe = true}

MenuManager.Changed:Connect(
    function(key)
        --[[
          line: 414
          upvalues:
            v127 (copy, index: 1)
            timestamp3 (ref,  index: 2)
        ]]
        if key and v127[key] then
            timestamp3 = os.clock()
        end
    end
)

proximityPromptService.PromptTriggered:Connect(
    function(prompt: ProximityPrompt)
        --[[
          line: 419
          upvalues:
            v125 (copy, index: 1)
            loadoutKeys (copy, index: 2)
            MenuManager (copy, index: 3)
            v126 (copy, index: 4)
            timestamp3 (ref,  index: 5)
        ]]
        if const v130 = v125[prompt.Name] then
            loadoutKeys.kb = prompt.KeyboardKeyCode
            loadoutKeys.pad = prompt.GamepadKeyCode
            MenuManager.Open(v130, v126[prompt.Name])
            timestamp3 = os.clock()
        end
    end
)

userInputService.InputBegan:Connect(
    function(input: InputObject)
        --[[
          line: 428
          upvalues:
            MenuManager (copy, index: 1)
            v127 (copy, index: 2)
            userInputService (copy, index: 3)
            loadoutKeys (copy, index: 4)
            timestamp3 (ref,  index: 5)
        ]]
        local v132 = MenuManager.Current()

        if not v132 or not v127[v132] or userInputService:GetFocusedTextBox() then
            return
        end
        if input.KeyCode ~= loadoutKeys.kb and input.KeyCode ~= loadoutKeys.pad then
            return
        end
        if os.clock() - timestamp3 < 0.3 then
            return
        end

        MenuManager.Close(v132)
    end
)

task.spawn(
    function()
        --[[
          line: 442
          upvalues:
            localPlayer (copy, index: 1)
            v82 (copy, index: 2)
            ensureScreen (copy, index: 3)
        ]]
        if not localPlayer.Character then
            localPlayer.CharacterAdded:Wait()
        end

        task.wait(1)

        for _, childName in v82 do
            ensureScreen(childName)
        end
    end
)

if runService:IsStudio() then
    local debug = v44.Debug

    debug.open = function(a136, ...)
        --[[
          line: 455
          upvalues:
            MenuManager (copy, index: 1)
        ]]
        MenuManager.Open(a136, ...)
        return true
    end

    debug.close = function()
        --[[
          line: 459
          upvalues:
            MenuManager (copy, index: 1)
        ]]
        MenuManager.CloseAll()
        return true
    end

    debug.notify = function(a137, a138)
        --[[
          line: 463
          upvalues:
            v44 (copy, index: 1)
        ]]
        v44.Toast(a137, a138)
        return true
    end

    debug.event = function(a139, a140)
        --[[
          line: 467
          upvalues:
            State (copy, index: 1)
        ]]
        State.InjectEvent(a139, a140)
        return true
    end

    debug.snapshot = function(a141)
        --[[
          line: 471
          upvalues:
            State (copy, index: 1)
        ]]
        State.InjectSnapshot(a141)
        return true
    end

    debug.attr = function(a142, a143)
        --[[
          line: 475
          upvalues:
            State (copy, index: 1)
        ]]
        State.SetMockAttr(a142, a143)
        return true
    end

    debug.profile = function(a144)
        --[[
          line: 479
          upvalues:
            State (copy, index: 1)
        ]]
        State.SetProfile(a144, true)
        return true
    end

    debug.setting = function(a145, a146)
        --[[
          line: 484
        ]]
        local SettingsStore = require(script.Parent:WaitForChild("SettingsStore"))
        SettingsStore.Set(a145, a146, true)

        return SettingsStore.Get(a145)
    end

    debug.screens = function()
        --[[
          line: 489
          upvalues:
            v86 (copy, index: 1)
        ]]
        local parts = {}

        for v149 in v86 do
            table.insert(parts, v149)
        end

        table.sort(parts)

        return table.concat(parts, ",")
    end

    debug.loc = function(a150)
        --[[
          line: 499
          upvalues:
            Loc (copy, index: 1)
            playerGui (copy, index: 2)
        ]]
        local parts = {"lang " .. Loc.Lang()}

        if a150 ~= "clip" then
            for _, v153 in Loc.Missing(playerGui) do
                table.insert(parts, v153[1] .. " | " .. v153[2])
            end

            return table.concat(parts, "\n")
        end

        for _, descendant in playerGui:GetDescendants() do
            if not descendant:IsA("TextLabel") and not descendant:IsA("TextButton") then
                continue
            end

            if descendant.Visible then
                if descendant.Text ~= "" and not descendant.TextFits then
                    table.insert(parts, descendant:GetFullName() .. " | " .. descendant.Text)
                end
            end
        end

        return table.concat(parts, "\n")
    end

    debug.instances = function()
        --[[
          line: 514
          upvalues:
            playerGui (copy, index: 1)
        ]]
        local count = 0

        for _, v158 in playerGui:GetDescendants() do
            count += 1
        end

        return count
    end

    debug.device = function(a159, x: number, y: number)
        --[[
          line: 522
          upvalues:
            workspace (copy, index: 1)
            UI (copy, index: 2)
        ]]
        local v162
        local camera = workspace.CurrentCamera
        local v164 = camera and camera.ViewportSize or Vector2.new(1920, 1080)

        if type(x) ~= "number" or type(y) ~= "number" then
            v162 = v164
        else
            v162 = Vector2.new(x, y)
        end

        if a159 == "desktop1080" then
            local v165 = math.min(v162.X / 1920, v162.Y / 1080)
            local rect = Vector2.new(math.floor(v165 * 1920), (math.floor(v165 * 1080)))
            UI.SetDebugDevice({compact = false, topInset = 48.333333333333336, rect = rect, scale = rect.X / 1600, topLeft = v162 ~= v164}, false)

            return {rect = rect}
        end

        local v167 = ({iphone14 = {bar = 44, safe = Vector2.new(750, 390), full = Vector2.new(844, 390)}, iphone13promax = {bar = 44, safe = Vector2.new(832, 407), full = Vector2.new(926, 428)}, galaxya06 = {bar = 40, safe = Vector2.new(705, 338), full = Vector2.new(800, 360)}, ipad = {bar = 44, tablet = true, safe = Vector2.new(1180, 800), full = Vector2.new(1180, 820)}})[a159
            or ""]
        if not v167 then
            UI.SetDebugDevice(nil)
            return "reset"
        end

        local v168 = math.min(v167.full.X / 1280, v167.full.Y / 600)
        local v169 = math.min(v162.X / v167.safe.X, v162.Y / v167.safe.Y)
        local rect = Vector2.new(math.floor(v167.safe.X * v169), (math.floor(v167.safe.Y * v169)))
        UI.SetDebugDevice({rect = rect, scale = v168 * v169, topLeft = v162 ~= v164, tablet = v167.tablet, topInset = v167.bar / v168}, true)

        return {rect = rect, canvas = rect / (v168 * v169)}
    end

    debug.screen = function(a171, a172, a173)
        --[[
          line: 553
          upvalues:
            UI (copy, index: 1)
            workspace (copy, index: 2)
            Theme (copy, index: 3)
        ]]
        if type(a171) ~= "number" or type(a172) ~= "number" then
            UI.SetDebugDevice(nil)
            return "reset"
        end

        local v174
        local camera = workspace.CurrentCamera
        local v176 = camera and camera.ViewportSize or Vector2.new(1920, 1080)
        local v177 = math.min(v176.X / a171, v176.Y / a172)
        local rect = Vector2.new(math.floor(a171 * v177), (math.floor(a172 * v177)))

        if a173 ~= true then
            v174 = math.min(a171 / 1600, a172 / 900)
        else
            v174 = math.clamp(math.min(a171 / Theme.DesignSize.X, a172 / Theme.DesignSize.Y), 0.4, 1.6)
        end

        UI.SetDebugDevice({topLeft = false, rect = rect, scale = v174 * v177, compact = a172 < 560, topInset = 58 / v174}, false)

        return {rect = rect, canvas = rect / (v174 * v177)}
    end

    debug.chat = function()
        --[[
          line: 569
          upvalues:
            UI (copy, index: 1)
            v44 (copy, index: 2)
        ]]
        local v179 = UI.ChatRect()
        local v180 = v44.LobbyColumn and v44.LobbyColumn.Shift() or Vector2.zero
        local v181 = {rect = if v179 then string.format("%d,%d %d,%d", v179.Min.X, v179.Min.Y, v179.Max.X, v179.Max.Y) else "closed"}
        v181.shift = string.format("%d,%d", v180.X, v180.Y)
        return v181
    end

    debug.gamepad = function(a182, a183)
        --[[
          line: 579
          upvalues:
            UI (copy, index: 1)
            MenuManager (copy, index: 2)
            guiService (copy, index: 3)
        ]]
        if a182 ~= "tv" then
            if a182 == true or a182 == false then
                UI.SetDebugGamepad(a182)
            elseif a182 ~= "auto" then
                if a182 == "hud" then
                    return MenuManager.HudFocus(a183)
                end
                if a182 == "back" then
                    return MenuManager.Back()
                end
            else
                UI.SetDebugGamepad(nil)
            end
        else
            UI.SetDebugTenFoot(a183 == true)
        end

        local selectedObject = guiService.SelectedObject
        local v185 = {gamepad = UI.Gamepad, tv = UI.TenFoot, selected = if selectedObject then selectedObject:GetFullName() else false}
        v185.menu = MenuManager.Current() or false
        v185.hudFocus = MenuManager.HudFocused()
        v185.screenFocus = MenuManager.HasFocus()
        v185.padBlocked = MenuManager.PadBlocked()
        return v185
    end

    debug.padInput = function(stick: string, a187, a188)
        --[[
          line: 611
          upvalues:
            Keybinds (copy, index: 1)
        ]]
        local success, result = pcall(
            function()
                --[[
                  line: 612
                  upvalues:
                    stick (copy, index: 1)
                ]]
                return Enum.KeyCode[stick]
            end
        )

        if not success or not result then
            return "unknown KeyCode " .. tostring(stick)
        end

        local function fire(a192, userInputState, position)
            --[[
              name: fire
              line: 618
              upvalues:
                result (copy, index: 1)
                Keybinds (copy, index: 2)
            ]]
            Keybinds.FakeInput:Fire(a192, {Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = userInputState, Position = position}, false)
        end

        if string.sub(stick, 1, 10) == "Thumbstick" then
            local number = tonumber(a187) or 0
            local number2 = tonumber(a188) or 0
            local change = Enum.UserInputState.Change
            local position = Vector3.new(number, number2, 0)
            Keybinds.FakeInput:Fire("Changed", {Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = change, Position = position}, false)

            if number == 0 and number2 == 0 then
                local endValue = Enum.UserInputState.End
                Keybinds.FakeInput:Fire("Ended", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = endValue}, false)
            end

            return {stick = stick, x = number, y = number2}
        end

        if a187 == "down" then
            local begin = Enum.UserInputState.Begin
            Keybinds.FakeInput:Fire("Began", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = begin}, false)
        elseif a187 == "up" then
            local endValue = Enum.UserInputState.End
            local v202 = {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = endValue}
            Keybinds.FakeInput:Fire("Ended", v202, false)
        else
            local v203 = Enum.UserInputState.Begin
            local v204 = {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = v203}
            Keybinds.FakeInput:Fire("Began", v204, false)
            v203 = task.wait
            local v205 = a187 ~= "hold" and 0.05 or tonumber(a188) or 0.8
            v203(v205)
            local endValue = Enum.UserInputState.End
            local v207 = {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = result, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = endValue}
            Keybinds.FakeInput:Fire("Ended", v207, false)
        end

        return true
    end

    debug.padBind = function(a208, a209, a210)
        --[[
          line: 647
          upvalues:
            Keybinds (copy, index: 1)
        ]]
        local SettingsStore = require(script.Parent:WaitForChild("SettingsStore"))

        if a208 == "reset" then
            local changed = Keybinds.PadResetAll()
            SettingsStore.SavePadBinds(changed)

            return {changed = changed}
        end

        if a209 == "-" then
            Keybinds.PadClear(a208, a210 or 1)
            SettingsStore.SavePadBinds({a208})

            return {changed = {a208}, now = Keybinds.PadGet(a208)}
        end

        local changed, v214 = Keybinds.PadAssign(a208, a210 or 1, a209 or "")

        if 0 < #changed then
            SettingsStore.SavePadBinds(changed)
        end

        local moved = {}

        for _, v217 in v214 do
            moved[v217.id] = table.concat(v217.now, ",")
        end

        return {changed = changed, moved = moved, now = Keybinds.PadGet(a208)}
    end

    debug.padState = function()
        --[[
          line: 669
          upvalues:
            Keybinds (copy, index: 1)
            MenuManager (copy, index: 2)
            v44 (copy, index: 3)
            localPlayer (copy, index: 4)
            State (copy, index: 5)
            debug (copy, index: 6)
        ]]
        local success
        local unsaved
        local v220 = {}
        local binds = {}

        for _, padAction in Keybinds.PAD_ACTIONS do
            binds[padAction.id] = table.concat(Keybinds.PadGet(padAction.id), ",")
        end

        v220.binds = binds
        v220.allDefault = Keybinds.PadAllDefault()
        v220.padBlocked = Keybinds.PadBlocked()
        v220.menuPadBlocked = MenuManager.PadBlocked()
        local padCapturing = v44.PadCapturing == true
        v220.padCapturing = padCapturing
        local ias = {}
        local tribesInputs = localPlayer:FindFirstChild("TribesInputs")

        for _, childName in {"Jump", "Slide"} do
            local child2 = tribesInputs and tribesInputs:FindFirstChild(childName)
            local parts = {}

            if child2 then
                for _, child in child2:GetChildren() do
                    if child:IsA("InputBinding") and child.Name ~= "Script" then
                        table.insert(parts, child.Name .. "=" .. child.KeyCode.Name)
                    end
                end

                table.sort(parts)
            end

            ias[childName] = table.concat(parts, " ")
        end

        v220.ias = ias
        local cas = {}
        local contextActionService = game:GetService("ContextActionService")

        for _, actionName in {"TribesFirstPerson", "TribesShoulderSwap", "TribesSpectateCycle", "TribesFreeCursor"} do
            local boundActionInfo = contextActionService:GetBoundActionInfo(actionName)
            local parts = {}

            if type(boundActionInfo) == "table" and type(boundActionInfo.inputTypes) == "table" then
                for _, inputType in boundActionInfo.inputTypes do
                    table.insert(parts, (tostring(inputType.Name)))
                end
            end

            cas[actionName] = if 0 < #parts then table.concat(parts, ",") else false
        end

        v220.cas = cas
        local profileGp = {}
        local profile = State.Profile

        if type(profile) == "table" and type(profile.settings) == "table" then
            for text, setting in profile.settings do
                if type(text) == "string" then
                    local substring = string.sub(text, 1, 3)

                    if substring ~= Keybinds.PAD_PREFIX then
                        continue
                    end

                    profileGp[text] = setting
                end
            end
        end

        v220.profileGp = profileGp
        local success2, result = pcall(require, script.Parent:WaitForChild("SettingsStore"))

        if success2 then
            unsaved = result.PendingKeys()
        else
            unsaved = false
        end

        v220.unsaved = unsaved

        if debug.padSettings then
            local v248
            local result2
            success, result2 = pcall(debug.padSettings)

            if success then
                v248 = result2
            else
                v248 = tostring(result2)
            end

            v220.settings = v248
        end

        return v220
    end

    debug.padCaps = function(pattern: string)
        --[[
          line: 727
          upvalues:
            playerGui (copy, index: 1)
            UI (copy, index: 2)
        ]]
        local v251 = {}

        for _, descendant in playerGui:GetDescendants() do
            if descendant:IsA("Frame") then
                local visible

                if descendant.Name ~= "KeyCap"
                    and descendant.Name ~= "PadPrev"
                    and descendant.Name ~= "PadNext"
                then
                    continue
                end

                local v255 = UI.CapInfo(descendant)
                if not v255 then
                    continue
                end
                if not v255.pad then
                    continue
                end

                local fullName = descendant:GetFullName()
                local text = string.gsub(fullName, "^.-PlayerGui%.", "")

                if pattern and not string.find(text, pattern, 1, true) then
                    continue
                end

                local visible2 = v255.visible
                local parent = descendant.Parent
                visible = visible2

                while visible and parent do
                    if parent:IsA("LayerCollector") then
                        break
                    end

                    if not parent:IsA("GuiObject") or parent.Visible then
                        parent = parent.Parent
                    else
                        visible = false
                        parent = parent.Parent
                    end
                end

                local stringFormat = string.format
                local pad = v255.pad
                local v262 = v255.padUnbound and " (unbound)" or ""
                local v263 = visible and " shown" or ""
                v251[text] = stringFormat("%s%s%s", pad, v262, v263)
            end
        end

        return v251
    end

    debug.platform = function()
        --[[
          line: 751
          upvalues:
            UI (copy, index: 1)
        ]]
        local v264 = UI.CanvasSize()
        return {touch = UI.Touch, gamepad = UI.Gamepad, tv = UI.TenFoot, compact = UI.Compact, tablet = UI.Tablet, scale = math.floor((UI.Scale * 1000) + 0.5) / 1000, canvas = string.format("%dx%d", v264.X, v264.Y), topInset = UI.TopInset()}
    end

    local v265 = {killfeed = "KillFeed", banner = "Banners", matchEnd = "MatchEnd", finalRound = "Decider", loadoutSwap = "LoadoutSwap", ranks = "RankRoad", rankUp = "RankUp", playerCard = "PlayerCard"}

    local function onInvoke(key, ...)
        --[[
          name: onInvoke
          line: 765
          upvalues:
            v265 (copy, index: 1)
            ensureScreen (copy, index: 2)
            debug (copy, index: 3)
        ]]
        if v265[key] then
            ensureScreen(v265[key])
        end

        local v268 = debug[key]
        if not v268 then
            return "unknown command " .. tostring(key)
        end

        local success, result = pcall(v268, ...)
        if not success then
            return "error: " .. tostring(result)
        end
        if result == nil then
            return true
        end

        return result
    end

    local function makeHook()
        --[[
          name: makeHook
          line: 776
          upvalues:
            onInvoke (copy, index: 1)
            playerGui (copy, index: 2)
        ]]
        local trDebug = Instance.new("BindableFunction")
        trDebug.Name = "TR_Debug"
        trDebug.OnInvoke = onInvoke
        trDebug.Parent = playerGui
    end

    local trDebug = Instance.new("BindableFunction")
    trDebug.Name = "TR_Debug"
    trDebug.OnInvoke = onInvoke
    trDebug.Parent = playerGui

    playerGui.ChildRemoved:Connect(
        function(child: Instance)
            --[[
              line: 783
              upvalues:
                playerGui (copy, index: 1)
                onInvoke (copy, index: 2)
            ]]
            if child.Name == "TR_Debug" then
                task.defer(
                    function()
                        --[[
                          line: 785
                          upvalues:
                            playerGui (copy, index: 1)
                            onInvoke (copy, index: 2)
                        ]]
                        if not playerGui:FindFirstChild("TR_Debug") then
                            local trDebug = Instance.new("BindableFunction")
                            trDebug.Name = "TR_Debug"
                            trDebug.OnInvoke = onInvoke
                            trDebug.Parent = playerGui
                        end
                    end
                )
            end
        end
    )

    local success, result = pcall(
        function()
            --[[
              line: 793
              upvalues:
                parent (copy, index: 1)
                v44 (copy, index: 2)
            ]]
            require(parent.Mock).Init(v44)
        end
    )
    if not success then
        warn("[UI] mock init failed: " .. tostring(result))
    end
end

task.spawn(
    function()
        --[[
          line: 803
          upvalues:
            parent (copy, index: 1)
            v81 (copy, index: 2)
            ensureScreen (copy, index: 3)
            v44 (copy, index: 4)
            hud (copy, index: 5)
        ]]
        local replay = parent.Parent:WaitForChild("Replay", 30)
        local hudBridge = replay and replay:WaitForChild("HudBridge", 10)

        if not hudBridge or not hudBridge:IsA("ModuleScript") then
            return
        end

        local success, result = pcall(require, hudBridge)

        if not success or type(result) ~= "table" then
            return
        end

        local v282 = {}
        result.ui = {
            Enter = (function(a283)
                --[[
                  name: Enter
                  line: 815
                  upvalues:
                    v81 (copy, index: 1)
                    ensureScreen (copy, index: 2)
                    v44 (copy, index: 3)
                    hud (copy, index: 4)
                    v282 (copy, index: 5)
                ]]
                for _, childName in v81 do
                    ensureScreen(childName)
                end

                local hotbarRoot = v44.HotbarRoot
                local root = v44.MatchHud and v44.MatchHud.Root

                for _, child in hud:GetChildren() do
                    if child:IsA("GuiObject") then
                        if not child.Visible then
                            continue
                        end

                        if child ~= hotbarRoot and child ~= root then
                            child.Visible = false
                            table.insert(v282, child)
                        end
                    end
                end

                if v44.Hotbar and v44.Hotbar.SetReplaySource then
                    v44.Hotbar.SetReplaySource(a283)
                end

                if v44.MatchHud and v44.MatchHud.SetReplaySource then
                    v44.MatchHud.SetReplaySource(a283.model)
                end
            end),
            Leave = (function()
                --[[
                  name: Leave
                  line: 832
                  upvalues:
                    v44 (copy, index: 1)
                    v282 (copy, index: 2)
                ]]
                if v44.Hotbar and v44.Hotbar.SetReplaySource then
                    v44.Hotbar.SetReplaySource(nil)
                end

                if v44.MatchHud and v44.MatchHud.SetReplaySource then
                    v44.MatchHud.SetReplaySource(nil)
                end

                for _, v291 in v282 do
                    if v291.Parent then
                        v291.Visible = true
                    end
                end

                table.clear(v282)
            end)
        }
    end
)

localPlayer:SetAttribute("UIReady", true)
local parts = {}

for v293, v294 in v85 do
    table.insert(parts, string.format("%s=%.1f", v293, v294))
end

table.sort(parts)
local uiStartup = string.format("total=%.1fms | %s", (timestamp2 - timestamp) * 1000, table.concat(parts, " "))
localPlayer:SetAttribute("UIStartup", uiStartup)

if runService:IsStudio() then
    print("[UI] startup " .. uiStartup)
end