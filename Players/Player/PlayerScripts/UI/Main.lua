local v1 = os.clock()
local Players_1 = game:GetService("Players")
local StarterGui_upv_1 = game:GetService("StarterGui")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local ProximityPromptService_upv_1 = game:GetService("ProximityPromptService")
local GuiService_upv_1 = game:GetService("GuiService")
local Workspace_upv_1 = game:GetService("Workspace")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local PlayerGui_upv_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
pcall(
    function()
        --[[
          line: 16
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
        ]]
        PlayerGui_upv_1.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
    end
)
local Parent_upv_1 = script.Parent
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Signal_1 = require(Shared_1:WaitForChild("Signal"))
local Loc_upv_1 = require(Shared_1:WaitForChild("Loc"))
Loc_upv_1.Install()
local Theme_upv_1 = require(Parent_upv_1.Theme)
local UI_upv_1 = require(Parent_upv_1.UI)
local Sounds_1 = require(Parent_upv_1.Sounds)
local Remotes_upv_1 = require(Parent_upv_1.Remotes)
local State_upv_1 = require(Parent_upv_1.State)
local MenuManager_upv_1 = require(Parent_upv_1.MenuManager)
local WeaponInfo_1 = require(Parent_upv_1.WeaponInfo)
local WeaponIcon_1 = require(Parent_upv_1.WeaponIcon)
local Portraits_upv_1 = require(Parent_upv_1.Portraits)
local Fighters_1 = require(Parent_upv_1.Fighters)
WeaponIcon_1.Init(UI_upv_1, WeaponInfo_1)
Portraits_upv_1.Init(UI_upv_1, Fighters_1)
pcall(
    function()
        --[[
          line: 44
          upvalues:
            GuiService_upv_1 (copy, index: 1)
        ]]
        GuiService_upv_1.AutoSelectGuiEnabled = false
    end
)
UI_upv_1.SelectionRing(PlayerGui_upv_1)
local u1 = false
local u2 = function()
    --[[
      line: 57
    ]]
    return false
end
local function applyPlayerList()
    --[[
      name: applyPlayerList
      line: 60
      upvalues:
        u1 (ref,  index: 1)
        StarterGui_upv_1 (copy, index: 2)
        State_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if not u1 then
        return
    end
    pcall(
        function()
            --[[
              line: 64
              upvalues:
                StarterGui_upv_1 (copy, index: 1)
                State_upv_1 (copy, index: 2)
                u2 (ref,  index: 3)
            ]]
            local v2 = not State_upv_1.InMatch() and (not u2())
            StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, v2)
        end
    )
    pcall(
        function()
            --[[
              line: 68
              upvalues:
                StarterGui_upv_1 (copy, index: 1)
                State_upv_1 (copy, index: 2)
            ]]
            StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, not State_upv_1.InMatch())
        end
    )
end
task.spawn(
    function()
        --[[
          line: 72
          upvalues:
            StarterGui_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            u2 (ref,  index: 3)
            u1 (ref,  index: 4)
            applyPlayerList (copy, index: 5)
        ]]
        for _ = 1, 20 do
            if not (pcall(
                function()
                    --[[
                      line: 74
                      upvalues:
                        StarterGui_upv_1 (copy, index: 1)
                        State_upv_1 (copy, index: 2)
                        u2 (ref,  index: 3)
                    ]]
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
                    local v3 = not State_upv_1.InMatch() and (not u2())
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, v3)
                end
            )) then
                task.wait(0.5)
                continue
            end
            u1 = true
            applyPlayerList()
            return
        end
    end
)
local _, u3 = UI_upv_1.Screen("TR_HUD", 5, PlayerGui_upv_1)
local v73, v4 = UI_upv_1.Screen("TR_Backdrop", 9, PlayerGui_upv_1, {fullBleed = true})
UI_upv_1.BackdropCanvas = v4
local v74, v5 = UI_upv_1.Screen("TR_Menus", 10, PlayerGui_upv_1)
local v75, v6 = UI_upv_1.Screen("TR_Overlay", 20, PlayerGui_upv_1, {fullBleed = true})
local v76, v7 = UI_upv_1.Screen("TR_Top", 40, PlayerGui_upv_1, {fullBleed = true})
local tbl_upv_1 = {HudHidden = false, Toast = 0}
tbl_upv_1.UI = UI_upv_1
tbl_upv_1.Theme = Theme_upv_1
tbl_upv_1.Sounds = Sounds_1
tbl_upv_1.Remotes = Remotes_upv_1
tbl_upv_1.State = State_upv_1
tbl_upv_1.MenuManager = MenuManager_upv_1
tbl_upv_1.WeaponInfo = WeaponInfo_1
tbl_upv_1.WeaponIcon = WeaponIcon_1
tbl_upv_1.Portraits = Portraits_upv_1
tbl_upv_1.Fighters = Fighters_1
tbl_upv_1.Loc = Loc_upv_1
tbl_upv_1.Player = LocalPlayer_upv_1
tbl_upv_1.PlayerGui = PlayerGui_upv_1
tbl_upv_1.Canvas = {HUD = u3, Backdrop = v4, Menus = v5, Overlay = v6, Top = v7}
tbl_upv_1.HudHiddenChanged = Signal_1.new()
tbl_upv_1.HeldWeaponChanged = Signal_1.new()
tbl_upv_1.Debug = {}
function tbl_upv_1.Toast(a1, a2, a3)
    --[[
      name: Toast
      line: 117
    ]]
    print("[UI toast]", a1, a2)
end
local tbl_upv_2 = {}
function tbl_upv_1.SetHudHidden(a1, a2)
    --[[
      name: SetHudHidden
      line: 124
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    tbl_upv_2[a1] = (a2 and true) or nil
    local v8 = next(tbl_upv_2) ~= nil
    if tbl_upv_1._refreshMenuOpen then
        task.defer(tbl_upv_1._refreshMenuOpen)
    end
    if v8 == tbl_upv_1.HudHidden then
        return
    end
    tbl_upv_1.HudHidden = v8
    tbl_upv_1.HudHiddenChanged:Fire(v8)
end
function tbl_upv_1.IsHudHiddenFor(a1)
    --[[
      name: IsHudHiddenFor
      line: 135
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2[a1] == true
end
local ContentProvider_upv_1 = game:GetService("ContentProvider")
local tbl_upv_3 = {}
function tbl_upv_1.PreloadThumb(a1, a2)
    --[[
      name: PreloadThumb
      line: 143
      upvalues:
        tbl_upv_3 (copy, index: 1)
        ContentProvider_upv_1 (copy, index: 2)
    ]]
    if type(a1) ~= "string" or a1 == "" then
        return
    end
    if tbl_upv_3[a1] == nil or (a2) then
        if tbl_upv_3[a1] ~= nil then
            local v9 = os.clock()
            while tbl_upv_3[a1] == false do
                if os.clock() - v9 < 8 then
                    task.wait(0.1)
                    continue
                else
                    break
                end
            end
        else
            tbl_upv_3[a1] = false
            pcall(
                function()
                    --[[
                      line: 152
                      upvalues:
                        ContentProvider_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    ContentProvider_upv_1:PreloadAsync({a1})
                end
            )
            tbl_upv_3[a1] = true
        end
    end
end
State_upv_1.MatchChanged:Connect(
    function(a1)
        --[[
          line: 163
          upvalues:
            tbl_upv_3 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        if not a1 or type(a1.mapThumb) ~= "string" or tbl_upv_3[a1.mapThumb] ~= nil then
            return
        end
        task.spawn(tbl_upv_1.PreloadThumb, a1.mapThumb)
    end
)
State_upv_1.MatchEvent:Connect(
    function(a1, a2)
        --[[
          line: 168
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        if a1 ~= "MatchStart" or type(a2) ~= "table" then
            return
        end
        task.spawn(tbl_upv_1.PreloadThumb, a2.mapThumb)
    end
)
function tbl_upv_1.ProfileAction(a1, ...)
    --[[
      name: ProfileAction
      line: 176
      upvalues:
        State_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Remotes_upv_1 (copy, index: 3)
    ]]
    if State_upv_1.Mock then
        return tbl_upv_1.Debug._mockProfileAction(a1, ...)
    end
    local v10, v11, v12, v13 = Remotes_upv_1.Invoke("ProfileAction", a1, ...)
    if v10 then
        if v11 == true then
            task.delay(0.6, State_upv_1.Refresh)
            return true, nil, v13
        end
        tbl_upv_1.Toast(tostring(v12 or "Couldn't do that"), "error")
        return false, v12
    end
    tbl_upv_1.Toast(tostring(v11 or "Server unavailable"), "error")
    return false, (tostring(v11))
end
function tbl_upv_1.QueueAction(a1, a2, a3, a4)
    --[[
      name: QueueAction
      line: 196
      upvalues:
        State_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Remotes_upv_1 (copy, index: 3)
    ]]
    if State_upv_1.Mock then
        if tbl_upv_1.Debug._mockQueueAction then
            return tbl_upv_1.Debug._mockQueueAction(a1, a4)
        end
        tbl_upv_1.Toast("(mock) " .. a1, "info")
        return true, nil
    else
        local v14, v15, v16 = Remotes_upv_1.Invoke("QueueAction", a1, a2 or "menu", a3, a4)
        if v14 then
            if v15 == true then
                return true, nil
            end
            if v16 then
                tbl_upv_1.Toast(tostring(v16), "error")
            end
            return false, v16
        end
        tbl_upv_1.Toast(tostring(v15 or "Server unavailable"), "error")
        return false, (tostring(v15))
    end
end
State_upv_1.Start()
require(Parent_upv_1.SettingsStore).Init(tbl_upv_1)
require(Parent_upv_1.Economy).Init(tbl_upv_1)
require(Parent_upv_1.Custom).Init(tbl_upv_1)
require(Parent_upv_1.Tribes).Init(tbl_upv_1)
MenuManager_upv_1.Changed:Connect(
    function(a1)
        --[[
          line: 225
          upvalues:
            ProximityPromptService_upv_1 (copy, index: 1)
        ]]
        ProximityPromptService_upv_1.Enabled = a1 == nil
    end
)
local u4 = false
local function refreshMenuOpen()
    --[[
      name: refreshMenuOpen
      line: 233
      upvalues:
        MenuManager_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        UI_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
        GuiService_upv_1 (copy, index: 6)
    ]]
    local v17 = MenuManager_upv_1.IsOpen()
    if not (v17) then
        v17 = true
        if tbl_upv_2.MatchEnd ~= true then
            v17 = true
            if tbl_upv_2.Intro ~= true then
                v17 = true
                if tbl_upv_2.Celebrate ~= true then
                    v17 = true
                    if tbl_upv_2.Reveal ~= true then
                        v17 = tbl_upv_2.RankUp == true
                    end
                end
            end
        end
    end
    if LocalPlayer_upv_1:GetAttribute("MenuOpen") ~= v17 then
        LocalPlayer_upv_1:SetAttribute("MenuOpen", v17)
    end
    if UI_upv_1.Touch then
        local u5 = v17 or (LocalPlayer_upv_1:GetAttribute("TouchControlsReady") == false)
        u4 = u5
        pcall(
            function()
                --[[
                  line: 246
                  upvalues:
                    GuiService_upv_1 (copy, index: 1)
                    u5 (copy, index: 2)
                ]]
                GuiService_upv_1.TouchControlsEnabled = not u5
            end
        )
    elseif u4 then
        u4 = false
        pcall(
            function()
                --[[
                  line: 251
                  upvalues:
                    GuiService_upv_1 (copy, index: 1)
                ]]
                GuiService_upv_1.TouchControlsEnabled = true
            end
        )
    end
end
MenuManager_upv_1.Changed:Connect(refreshMenuOpen)
u2 = function()
    --[[
      line: 258
      upvalues:
        MenuManager_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v18 = MenuManager_upv_1.IsOpen() or (tbl_upv_1.HudHidden == true)
    return v18
end
MenuManager_upv_1.Changed:Connect(applyPlayerList)
tbl_upv_1.HudHiddenChanged:Connect(applyPlayerList)
UI_upv_1.TouchChanged:Connect(refreshMenuOpen)
LocalPlayer_upv_1:GetAttributeChangedSignal("TouchControlsReady"):Connect(refreshMenuOpen)
tbl_upv_1._refreshMenuOpen = refreshMenuOpen
task.defer(refreshMenuOpen)
tbl_upv_1.PendingEvent = nil
function tbl_upv_1.OnMatchEvent(a1)
    --[[
      name: OnMatchEvent
      line: 272
      upvalues:
        State_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    State_upv_1.MatchEvent:Connect(a1)
    local PendingEvent_1 = tbl_upv_1.PendingEvent
    if not PendingEvent_1 then
        return
    end
    task.spawn(a1, PendingEvent_1.kind, PendingEvent_1.data)
end
local tbl_4 = {"Notifications", "LobbyHud", "MatchSettings", "RankedSwitch", "Hotbar", "ActionHints", "Nameplates", "TouchLayout", "Economy", "Party", "Joining", "DropReveal", "ChatTags", "CustomLobby", "Onboarding", "Moderation", "CheaterBanned"}
local tbl_upv_5 = {"MatchHud", "TabList", "KillFeed", "Decider", "Banners", "Celebration", "Spectate", "LoadoutSwap", "TeamChat"}
local tbl_upv_6 = {"Leaderboards", "CustomLive", "MoveDebug", "TribeHall", "News", "GoldenOffer"}
local tbl_upv_7 = {CustomHost = "CustomHost", Letter = "Letter", News = "News", Loadout = "Loadout", Ranks = "RankRoad", GoldenOffer = "GoldenOffer", Settings = "Settings", CustomMatches = "CustomMatches", Collection = "Collection", Mode = "ModeSelect", Tribe = "Tribe", PlayerCard = "PlayerCard"}
local Screens_upv_1 = Parent_upv_1:WaitForChild("Screens")
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local u6 = false
local function ensureScreen(a1)
    --[[
      name: ensureScreen
      line: 290
      upvalues:
        tbl_upv_9 (copy, index: 1)
        Screens_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        tbl_upv_8 (copy, index: 4)
        u6 (ref,  index: 5)
        RunService_upv_1 (copy, index: 6)
    ]]
    if tbl_upv_9[a1] then
        return true
    end
    tbl_upv_9[a1] = true
    local u7 = Screens_upv_1:FindFirstChild(a1) or (Screens_upv_1:WaitForChild(a1, 5))
    if u7 then
        local v19 = os.clock()
        local success_1, v20 = xpcall(
            function()
                --[[
                  line: 301
                  upvalues:
                    u7 (copy, index: 1)
                    tbl_upv_1 (copy, index: 2)
                ]]
                require(u7).Init(tbl_upv_1)
            end,
            debug.traceback
        )
        local v21 = (os.clock() - v19) * 1000
        tbl_upv_8[a1] = v21
        if success_1 then
            if u6 and RunService_upv_1:IsStudio() then
                print(string.format("[UI] built %s on demand in %.1f ms", a1, v21))
            end
        else
            warn("[UI] screen " .. a1 .. " failed to init: " .. tostring(v20))
        end
        return success_1
    end
    warn("[UI] missing screen module " .. a1)
    return false
end
tbl_upv_1.EnsureScreen = ensureScreen
tbl_upv_1.IsScreenLoaded = function(a1)
    --[[
      line: 314
      upvalues:
        tbl_upv_9 (copy, index: 1)
    ]]
    return tbl_upv_9[a1] == true
end
MenuManager_upv_1.SetLoader(
    function(a1)
        --[[
          line: 318
          upvalues:
            tbl_upv_7 (copy, index: 1)
            ensureScreen (copy, index: 2)
        ]]
        local v22 = tbl_upv_7[a1]
        if not v22 then
            return
        end
        ensureScreen(v22)
    end
)
tbl_upv_1.BuildMatchScreens = function()
    --[[
      name: buildMatchScreens
      line: 326
      upvalues:
        tbl_upv_5 (copy, index: 1)
        ensureScreen (copy, index: 2)
    ]]
    for _, value_1 in tbl_upv_5 do
        ensureScreen(value_1)
    end
end
for v77, value_2 in tbl_4 do
    ensureScreen(value_2)
end
local v23 = os.clock()
u6 = true
State_upv_1.PlayerStateChanged:Connect(
    function(a1)
        --[[
          line: 339
          upvalues:
            applyPlayerList (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            ensureScreen (copy, index: 3)
        ]]
        applyPlayerList()
        if a1 ~= "Match" then
            return
        end
        for _, value_3 in tbl_upv_5 do
            ensureScreen(value_3)
        end
    end
)
State_upv_1.WatchChanged:Connect(
    function(a1)
        --[[
          line: 346
          upvalues:
            tbl_upv_5 (copy, index: 1)
            ensureScreen (copy, index: 2)
        ]]
        if not a1 then
            return
        end
        for _, value_4 in tbl_upv_5 do
            ensureScreen(value_4)
        end
    end
)
if State_upv_1.Watching() then
    for v78, value_5 in tbl_upv_5 do
        ensureScreen(value_5)
    end
end
applyPlayerList()
if State_upv_1.InMatch() then
    for v79, value_6 in tbl_upv_5 do
        ensureScreen(value_6)
    end
end
State_upv_1.MatchEvent:Connect(
    function(a1, a2)
        --[[
          line: 360
          upvalues:
            tbl_upv_9 (copy, index: 1)
            Portraits_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            tbl_upv_5 (copy, index: 4)
            ensureScreen (copy, index: 5)
        ]]
        if a1 == "MatchStart" and tbl_upv_9.MatchHud then
            Portraits_upv_1.Reset()
        end
        local v24 = not tbl_upv_9.MatchHud
        local v25 = (a1 == "MatchEnd") and (not tbl_upv_9.MatchEnd)
        if (v24) or (v25) then
            tbl_upv_1.PendingEvent = {kind = a1, data = a2}
            if a1 == "MatchStart" then
                Portraits_upv_1.Reset()
            end
            if v24 then
                for _, value_7 in tbl_upv_5 do
                    ensureScreen(value_7)
                end
            end
            if v25 then
                ensureScreen("MatchEnd")
            end
            tbl_upv_1.PendingEvent = nil
        end
    end
)
local UserInputService_upv_1 = game:GetService("UserInputService")
local Keybinds_upv_1 = require(ReplicatedStorage_1.Shared:WaitForChild("Keybinds"))
Keybinds_upv_1.OnInput(
    "Began",
    function(a1, a2)
        --[[
          line: 387
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
            MenuManager_upv_1 (copy, index: 3)
        ]]
        if UserInputService_upv_1:GetFocusedTextBox() then
            return
        end
        if a1.KeyCode == Enum.KeyCode.M and not (a2) or a1.KeyCode == Enum.KeyCode.ButtonSelect and not (tbl_upv_1.PadCapturing) then
            MenuManager_upv_1.Toggle("Settings")
        end
    end
)
local tbl_upv_10 = {}
tbl_upv_10.kb = Enum.KeyCode.E
tbl_upv_10.pad = Enum.KeyCode.ButtonX
local u8 = -math.huge
tbl_upv_1.LoadoutKeys = tbl_upv_10
local tbl_upv_11 = {CustomMatchesPrompt = "CustomMatches", TribeBoardPrompt = "Tribe", LoadoutPrompt = "Loadout", LetterPrompt = "Letter", TribePrompt = "Tribe", ContractPrompt = "Collection"}
local tbl_upv_12 = {TribeBoardPrompt = "Leaderboard"}
local tbl_upv_13 = {CustomMatches = true, Collection = true, Letter = true, Loadout = true, Tribe = true}
MenuManager_upv_1.Changed:Connect(
    function(a1)
        --[[
          line: 414
          upvalues:
            tbl_upv_13 (copy, index: 1)
            u8 (ref,  index: 2)
        ]]
        if not a1 or not tbl_upv_13[a1] then
            return
        end
        u8 = os.clock()
    end
)
ProximityPromptService_upv_1.PromptTriggered:Connect(
    function(a1)
        --[[
          line: 419
          upvalues:
            tbl_upv_11 (copy, index: 1)
            tbl_upv_10 (copy, index: 2)
            MenuManager_upv_1 (copy, index: 3)
            tbl_upv_12 (copy, index: 4)
            u8 (ref,  index: 5)
        ]]
        local v26 = tbl_upv_11[a1.Name]
        if not v26 then
            return
        end
        tbl_upv_10.kb = a1.KeyboardKeyCode
        tbl_upv_10.pad = a1.GamepadKeyCode
        MenuManager_upv_1.Open(v26, tbl_upv_12[a1.Name])
        u8 = os.clock()
    end
)
UserInputService_upv_1.InputBegan:Connect(
    function(a1)
        --[[
          line: 428
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
            UserInputService_upv_1 (copy, index: 3)
            tbl_upv_10 (copy, index: 4)
            u8 (ref,  index: 5)
        ]]
        local v27 = MenuManager_upv_1.Current()
        if not v27 or not tbl_upv_13[v27] or (UserInputService_upv_1:GetFocusedTextBox()) then
            return
        end
        if (a1.KeyCode == tbl_upv_10.kb or a1.KeyCode == tbl_upv_10.pad) and not (os.clock() - u8 < 0.3) then
            MenuManager_upv_1.Close(v27)
        end
    end
)
task.spawn(
    function()
        --[[
          line: 442
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            tbl_upv_6 (copy, index: 2)
            ensureScreen (copy, index: 3)
        ]]
        if not (LocalPlayer_upv_1.Character) then
            LocalPlayer_upv_1.CharacterAdded:Wait()
        end
        task.wait(1)
        for _, value_8 in tbl_upv_6 do
            ensureScreen(value_8)
        end
    end
)
if RunService_upv_1:IsStudio() then
    local Debug_upv_1 = tbl_upv_1.Debug
    Debug_upv_1.open = function(a1, ...)
        --[[
          line: 455
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Open(a1, ...)
        return true
    end
    Debug_upv_1.close = function()
        --[[
          line: 459
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.CloseAll()
        return true
    end
    Debug_upv_1.notify = function(a1, a2)
        --[[
          line: 463
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.Toast(a1, a2)
        return true
    end
    Debug_upv_1.event = function(a1, a2)
        --[[
          line: 467
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.InjectEvent(a1, a2)
        return true
    end
    Debug_upv_1.snapshot = function(a1)
        --[[
          line: 471
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.InjectSnapshot(a1)
        return true
    end
    Debug_upv_1.attr = function(a1, a2)
        --[[
          line: 475
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.SetMockAttr(a1, a2)
        return true
    end
    Debug_upv_1.profile = function(a1)
        --[[
          line: 479
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.SetProfile(a1, true)
        return true
    end
    Debug_upv_1.setting = function(a1, a2)
        --[[
          line: 484
        ]]
        local SettingsStore_1 = require(script.Parent:WaitForChild("SettingsStore"))
        SettingsStore_1.Set(a1, a2, true)
        return SettingsStore_1.Get(a1)
    end
    Debug_upv_1.screens = function()
        --[[
          line: 489
          upvalues:
            tbl_upv_9 (copy, index: 1)
        ]]
        local tbl_14 = {}
        for key_1 in tbl_upv_9 do
            table.insert(tbl_14, key_1)
        end
        table.sort(tbl_14)
        return table.concat(tbl_14, ",")
    end
    Debug_upv_1.loc = function(a1)
        --[[
          line: 499
          upvalues:
            Loc_upv_1 (copy, index: 1)
            PlayerGui_upv_1 (copy, index: 2)
        ]]
        local tbl_15 = {"lang " .. Loc_upv_1.Lang()}
        if a1 ~= "clip" then
            for _, value_9 in Loc_upv_1.Missing(PlayerGui_upv_1) do
                table.insert(tbl_15, value_9[1] .. " | " .. value_9[2])
            end
        else
            for _, value_10 in PlayerGui_upv_1:GetDescendants() do
                if value_10:IsA("TextLabel") or value_10:IsA("TextButton") then
                    if not (value_10.Visible) or value_10.Text == "" then
                        continue
                    end
                    if not (value_10.TextFits) then
                        table.insert(tbl_15, value_10:GetFullName() .. " | " .. value_10.Text)
                    end
                end
            end
        end
        return table.concat(tbl_15, "\n")
    end
    Debug_upv_1.instances = function()
        --[[
          line: 514
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
        ]]
        local v28 = 0
        for _, v29 in PlayerGui_upv_1:GetDescendants() do
            v28 = v28 + 1
        end
        return v28
    end
    Debug_upv_1.device = function(a1, a2, a3)
        --[[
          line: 522
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v30 = Workspace_upv_1.CurrentCamera
        local v31 = (v30 and (v30.ViewportSize)) or (Vector2.new(1920, 1080))
        if type(a2) == "number" and type(a3) == "number" then
            v30 = Vector2.new(a2, a3)
        else
            v30 = v31
        end
        local v32 = nil
        if a1 ~= "desktop1080" then
            v32 = ({iphone14 = {bar = 44, safe = Vector2.new(750, 390), full = Vector2.new(844, 390)}, iphone13promax = {bar = 44, safe = Vector2.new(832, 407), full = Vector2.new(926, 428)}, galaxya06 = {bar = 40, safe = Vector2.new(705, 338), full = Vector2.new(800, 360)}, ipad = {tablet = true, bar = 44, safe = Vector2.new(1180, 800), full = Vector2.new(1180, 820)}})[a1 or ""]
            if v32 then
                local v33 = math.min(v32.full.X / 1280, v32.full.Y / 600)
                local v34 = math.min(v30.X / v32.safe.X, v30.Y / v32.safe.Y)
                local v35 = Vector2.new(math.floor(v32.safe.X * v34), math.floor(v32.safe.Y * v34))
                local SetDebugDevice_1 = UI_upv_1.SetDebugDevice
                local tbl_16 = {topLeft = 0, topInset = 0, tablet = 0}
                tbl_16.rect = v35
                tbl_16.scale = v33 * v34
                tbl_16.topLeft = v30 ~= v31
                tbl_16.tablet = v32.tablet
                tbl_16.topInset = v32.bar / v33
                SetDebugDevice_1(tbl_16, true)
                local tbl_17 = {}
                tbl_17.rect = v35
                tbl_17.canvas = v35 / (v33 * v34)
                return tbl_17
            end
            UI_upv_1.SetDebugDevice(nil)
            return "reset"
        else
            local v36 = math.min(v30.X / 1920, v30.Y / 1080)
            local v37 = Vector2.new(math.floor(v36 * 1920), math.floor(v36 * 1080))
            local SetDebugDevice_2 = UI_upv_1.SetDebugDevice
            local tbl_18 = {topLeft = 0, compact = false, topInset = 48.333333333333336}
            tbl_18.rect = v37
            tbl_18.scale = v37.X / 1600
            tbl_18.topLeft = v30 ~= v31
            SetDebugDevice_2(tbl_18, false)
            local tbl_19 = {}
            tbl_19.rect = v37
            return tbl_19
        end
    end
    Debug_upv_1.screen = function(a1, a2, a3)
        --[[
          line: 553
          upvalues:
            UI_upv_1 (copy, index: 1)
            Workspace_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
        ]]
        if type(a1) == "number" and type(a2) == "number" then
            local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
            local v38 = (CurrentCamera_1 and (CurrentCamera_1.ViewportSize)) or (Vector2.new(1920, 1080))
            local v39 = math.min(v38.X / a1, v38.Y / a2)
            local v40 = Vector2.new(math.floor(a1 * v39), math.floor(a2 * v39))
            local v41
            if a3 ~= true then
                v41 = math.min(a1 / 1600, a2 / 900)
            else
                v41 = math.clamp(math.min(a1 / Theme_upv_1.DesignSize.X, a2 / Theme_upv_1.DesignSize.Y), 0.4, 1.6)
            end
            local SetDebugDevice_3 = UI_upv_1.SetDebugDevice
            local tbl_20 = {topLeft = false, compact = 0, topInset = 0}
            tbl_20.rect = v40
            tbl_20.scale = v41 * v39
            tbl_20.compact = a2 < 560
            tbl_20.topInset = 58 / v41
            SetDebugDevice_3(tbl_20, false)
            local tbl_21 = {}
            tbl_21.rect = v40
            tbl_21.canvas = v40 / (v41 * v39)
            return tbl_21
        end
        UI_upv_1.SetDebugDevice(nil)
        return "reset"
    end
    Debug_upv_1.chat = function()
        --[[
          line: 569
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local v42 = UI_upv_1.ChatRect()
        local v43 = ((tbl_upv_1.LobbyColumn) and (tbl_upv_1.LobbyColumn.Shift())) or (Vector2.zero)
        local tbl_22 = {shift = 0, rect = 0}
        tbl_22.rect = not v42 and "closed" or string.format("%d,%d %d,%d", v42.Min.X, v42.Min.Y, v42.Max.X, v42.Max.Y)
        tbl_22.shift = string.format("%d,%d", v43.X, v43.Y)
        return tbl_22
    end
    Debug_upv_1.gamepad = function(a1, a2)
        --[[
          line: 579
          upvalues:
            UI_upv_1 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
            GuiService_upv_1 (copy, index: 3)
        ]]
        if a1 ~= "tv" then
            if a1 ~= true and a1 ~= false then
                if a1 ~= "auto" then
                    if a1 == "hud" then
                        return MenuManager_upv_1.HudFocus(a2)
                    end
                    if a1 == "back" then
                        return MenuManager_upv_1.Back()
                    end
                    local SelectedObject_1 = GuiService_upv_1.SelectedObject
                    local tbl_23 = {padBlocked = 0, menu = 0, hudFocus = 0, screenFocus = 0, selected = 0}
                    tbl_23.gamepad = UI_upv_1.Gamepad
                    tbl_23.tv = UI_upv_1.TenFoot
                    local v45
                    if SelectedObject_1 then
                        v45 = SelectedObject_1:GetFullName()
                    else
                        v45 = false
                    end
                    tbl_23.selected = v45
                    tbl_23.menu = MenuManager_upv_1.Current() or false
                    tbl_23.hudFocus = MenuManager_upv_1.HudFocused()
                    tbl_23.screenFocus = MenuManager_upv_1.HasFocus()
                    tbl_23.padBlocked = MenuManager_upv_1.PadBlocked()
                    return tbl_23
                else
                    UI_upv_1.SetDebugGamepad(nil)
                    local SelectedObject_1 = GuiService_upv_1.SelectedObject
                    local tbl_23 = {padBlocked = 0, menu = 0, hudFocus = 0, screenFocus = 0, selected = 0}
                    tbl_23.gamepad = UI_upv_1.Gamepad
                    tbl_23.tv = UI_upv_1.TenFoot
                    local v45
                    if SelectedObject_1 then
                        v45 = SelectedObject_1:GetFullName()
                    else
                        v45 = false
                    end
                    tbl_23.selected = v45
                    tbl_23.menu = MenuManager_upv_1.Current() or false
                    tbl_23.hudFocus = MenuManager_upv_1.HudFocused()
                    tbl_23.screenFocus = MenuManager_upv_1.HasFocus()
                    tbl_23.padBlocked = MenuManager_upv_1.PadBlocked()
                    return tbl_23
                end
            end
            UI_upv_1.SetDebugGamepad(a1)
        else
            UI_upv_1.SetDebugTenFoot(a2 == true)
        end
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        local tbl_23 = {padBlocked = 0, menu = 0, hudFocus = 0, screenFocus = 0, selected = 0}
        tbl_23.gamepad = UI_upv_1.Gamepad
        tbl_23.tv = UI_upv_1.TenFoot
        local v45
        if SelectedObject_1 then
            v45 = SelectedObject_1:GetFullName()
        else
            v45 = false
        end
        tbl_23.selected = v45
        tbl_23.menu = MenuManager_upv_1.Current() or false
        tbl_23.hudFocus = MenuManager_upv_1.HudFocused()
        tbl_23.screenFocus = MenuManager_upv_1.HasFocus()
        tbl_23.padBlocked = MenuManager_upv_1.PadBlocked()
        return tbl_23
    end
    Debug_upv_1.padInput = function(a1, a2, a3)
        --[[
          line: 611
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
        ]]
        local success_2, u9 = pcall(
            function()
                --[[
                  line: 612
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                return Enum.KeyCode[a1]
            end
        )
        if success_2 and u9 then
            local function fire(a4, a5, a6)
                --[[
                  name: fire
                  line: 618
                  upvalues:
                    u9 (copy, index: 1)
                    Keybinds_upv_1 (copy, index: 2)
                ]]
                Keybinds_upv_1.FakeInput:Fire(a4, {Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = a5, Position = a6}, false)
            end
            local v46 = nil
            if string.sub(a1, 1, 10) ~= "Thumbstick" then
                if a2 ~= "down" then
                    if a2 ~= "up" then
                        Keybinds_upv_1.FakeInput:Fire("Began", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = Enum.UserInputState.Begin}, false)
                        local v47 = ((a2 ~= "hold") and 0.05) or (tonumber(a3) or 0.8)
                        task.wait(v47)
                    end
                    Keybinds_upv_1.FakeInput:Fire("Ended", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = Enum.UserInputState.End}, false)
                else
                    Keybinds_upv_1.FakeInput:Fire("Began", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = Enum.UserInputState.Begin}, false)
                end
                return true
            else
                v46 = tonumber(a2) or 0
                local v48 = tonumber(a3) or 0
                Keybinds_upv_1.FakeInput:Fire("Changed", {Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = Enum.UserInputState.Change, Position = Vector3.new(v46, v48, 0)}, false)
                if v46 == 0 and v48 == 0 then
                    Keybinds_upv_1.FakeInput:Fire("Ended", {Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0), KeyCode = u9, UserInputType = Enum.UserInputType.Gamepad1, UserInputState = Enum.UserInputState.End}, false)
                end
                local tbl_24 = {}
                tbl_24.stick = a1
                tbl_24.x = v46
                tbl_24.y = v48
                return tbl_24
            end
        end
        return "unknown KeyCode " .. tostring(a1)
    end
    Debug_upv_1.padBind = function(a1, a2, a3)
        --[[
          line: 647
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
        ]]
        local SettingsStore_2 = require(script.Parent:WaitForChild("SettingsStore"))
        if a1 == "reset" then
            local v49 = Keybinds_upv_1.PadResetAll()
            SettingsStore_2.SavePadBinds(v49)
            local tbl_25 = {}
            tbl_25.changed = v49
            return tbl_25
        elseif a2 ~= "-" then
            local v50, v51 = Keybinds_upv_1.PadAssign(a1, a3 or 1, a2 or "")
            if #v50 > 0 then
                SettingsStore_2.SavePadBinds(v50)
            end
            local tbl_26 = {}
            for _, value_11 in v51 do
                tbl_26[value_11.id] = table.concat(value_11.now, ",")
            end
            local tbl_27 = {}
            tbl_27.changed = v50
            tbl_27.moved = tbl_26
            tbl_27.now = Keybinds_upv_1.PadGet(a1)
            return tbl_27
        else
            Keybinds_upv_1.PadClear(a1, a3 or 1)
            SettingsStore_2.SavePadBinds({a1})
            local tbl_28 = {}
            tbl_28.changed = {a1}
            tbl_28.now = Keybinds_upv_1.PadGet(a1)
            return tbl_28
        end
    end
    Debug_upv_1.padState = function()
        --[[
          line: 669
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            State_upv_1 (copy, index: 5)
            Debug_upv_1 (copy, index: 6)
        ]]
        local tbl_29 = {}
        local tbl_30 = {}
        for _, value_12 in Keybinds_upv_1.PAD_ACTIONS do
            tbl_30[value_12.id] = table.concat(Keybinds_upv_1.PadGet(value_12.id), ",")
        end
        tbl_29.binds = tbl_30
        tbl_29.allDefault = Keybinds_upv_1.PadAllDefault()
        tbl_29.padBlocked = Keybinds_upv_1.PadBlocked()
        tbl_29.menuPadBlocked = MenuManager_upv_1.PadBlocked()
        tbl_29.padCapturing = tbl_upv_1.PadCapturing == true
        local tbl_31 = {}
        local TribesInputs_1 = LocalPlayer_upv_1:FindFirstChild("TribesInputs")
        for _, value_13 in {"Jump", "Slide"} do
            local v52 = TribesInputs_1 and (TribesInputs_1:FindFirstChild(value_13))
            local tbl_32 = {}
            if not (v52) then
                tbl_31[value_13] = table.concat(tbl_32, " ")
                continue
            end
            for v59, value_14 in v52:GetChildren() do
                if not (value_14:IsA("InputBinding")) then
                    continue
                end
                if value_14.Name ~= "Script" then
                    table.insert(tbl_32, value_14.Name .. "=" .. value_14.KeyCode.Name)
                end
            end
            table.sort(tbl_32)
            tbl_31[value_13] = table.concat(tbl_32, " ")
        end
        tbl_29.ias = tbl_31
        local tbl_33 = {}
        local ContextActionService_1 = game:GetService("ContextActionService")
        local v53 = nil
        local v54 = nil
        for _, value_15 in {"TribesFirstPerson", "TribesShoulderSwap", "TribesSpectateCycle", "TribesFreeCursor"} do
            local v55 = ContextActionService_1:GetBoundActionInfo(value_15)
            local tbl_34 = {}
            if type(v55) == "table" and type(v55.inputTypes) == "table" then
                for v60, value_16 in v55.inputTypes do
                    table.insert(tbl_34, (tostring(value_16.Name)))
                end
            end
            if #tbl_34 > 0 then
                v53 = table.concat(tbl_34, ",")
            else
                v53 = false
            end
            tbl_33[v54] = v53
        end
        tbl_29.cas = tbl_33
        local tbl_35 = {}
        local Profile_1 = State_upv_1.Profile
        if type(Profile_1) == "table" and type(Profile_1.settings) == "table" then
            for key_2, value_17 in Profile_1.settings do
                if type(key_2) ~= "string" then
                    continue
                end
                if string.sub(key_2, 1, 3) == Keybinds_upv_1.PAD_PREFIX then
                    tbl_35[key_2] = value_17
                end
            end
        end
        tbl_29.profileGp = tbl_35
        local v56, v57 = pcall(require, script.Parent:WaitForChild("SettingsStore"))
        local success_3
        if v56 then
            success_3 = v57.PendingKeys()
        else
            success_3 = false
        end
        tbl_29.unsaved = success_3
        if Debug_upv_1.padSettings then
            local success_3, v58 = pcall(Debug_upv_1.padSettings)
            if success_3 then
                v54 = v58
            else
                v54 = tostring(v58)
            end
            tbl_29.settings = v54
        end
        return tbl_29
    end
    Debug_upv_1.padCaps = function(a1)
        --[[
          line: 727
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local tbl_36 = {}
        local v59 = nil
        for _, value_18 in PlayerGui_upv_1:GetDescendants() do
            if not (value_18:IsA("Frame")) then
                continue
            end
            if value_18.Name == "KeyCap" or value_18.Name ~= "KeyCap" and value_18.Name == "PadPrev" or value_18.Name ~= "KeyCap" and value_18.Name ~= "PadPrev" and value_18.Name == "PadNext" then
                local v60 = UI_upv_1.CapInfo(value_18)
                if not (v60) or not (v60.pad) then
                    continue
                end
                local v61 = string.gsub(value_18:GetFullName(), "^.-PlayerGui%.", "")
                if a1 and not (string.find(v61, a1, 1, true)) then
                    continue
                end
                local visible_1 = v60.visible
                v59 = value_18.Parent
                while visible_1 and (v59) and not v59:IsA("LayerCollector") do
                    if (v59:IsA("GuiObject")) and not v59.Visible then
                        local v62 = false
                    end
                    v59 = v59.Parent
                end
                tbl_36[v61] = string.format("%s%s%s", v60.pad, ((v60.padUnbound) and " (unbound)") or "", (visible_1 and " shown") or "")
            end
        end
        return tbl_36
    end
    Debug_upv_1.platform = function()
        --[[
          line: 751
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        local v62 = UI_upv_1.CanvasSize()
        local tbl_37 = {}
        tbl_37.touch = UI_upv_1.Touch
        tbl_37.gamepad = UI_upv_1.Gamepad
        tbl_37.tv = UI_upv_1.TenFoot
        tbl_37.compact = UI_upv_1.Compact
        tbl_37.tablet = UI_upv_1.Tablet
        tbl_37.scale = math.floor((UI_upv_1.Scale * 1000) + 0.5) / 1000
        tbl_37.canvas = string.format("%dx%d", v62.X, v62.Y)
        tbl_37.topInset = UI_upv_1.TopInset()
        return tbl_37
    end
    local tbl_upv_38 = {loadoutSwap = "LoadoutSwap", playerCard = "PlayerCard", rankUp = "RankUp", matchEnd = "MatchEnd", banner = "Banners", finalRound = "Decider", killfeed = "KillFeed", ranks = "RankRoad"}
    local function onInvoke(a1, ...)
        --[[
          name: onInvoke
          line: 765
          upvalues:
            tbl_upv_38 (copy, index: 1)
            ensureScreen (copy, index: 2)
            Debug_upv_1 (copy, index: 3)
        ]]
        if tbl_upv_38[a1] then
            ensureScreen(tbl_upv_38[a1])
        end
        local v63 = Debug_upv_1[a1]
        if not v63 then
            return "unknown command " .. tostring(a1)
        end
        local success_4, v64 = pcall(v63, ...)
        if success_4 then
            if v64 ~= nil then
                return v64
            end
            return true
        end
        return "error: " .. tostring(v64)
    end
    local function makeHook()
        --[[
          name: makeHook
          line: 776
          upvalues:
            onInvoke (copy, index: 1)
            PlayerGui_upv_1 (copy, index: 2)
        ]]
        local v65 = Instance.new("BindableFunction")
        v65.Name = "TR_Debug"
        v65.OnInvoke = onInvoke
        v65.Parent = PlayerGui_upv_1
    end
    local v66 = Instance.new("BindableFunction")
    v66.Name = "TR_Debug"
    v66.OnInvoke = onInvoke
    v66.Parent = PlayerGui_upv_1
    PlayerGui_upv_1.ChildRemoved:Connect(
        function(a1)
            --[[
              line: 783
              upvalues:
                PlayerGui_upv_1 (copy, index: 1)
                onInvoke (copy, index: 2)
            ]]
            if a1.Name ~= "TR_Debug" then
                return
            end
            task.defer(
                function()
                    --[[
                      line: 785
                      upvalues:
                        PlayerGui_upv_1 (copy, index: 1)
                        onInvoke (copy, index: 2)
                    ]]
                    if not (PlayerGui_upv_1:FindFirstChild("TR_Debug")) then
                        local v67 = Instance.new("BindableFunction")
                        v67.Name = "TR_Debug"
                        v67.OnInvoke = onInvoke
                        v67.Parent = PlayerGui_upv_1
                    end
                end
            )
        end
    )
    local success_5, v68 = pcall(
        function()
            --[[
              line: 793
              upvalues:
                Parent_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            require(Parent_upv_1.Mock).Init(tbl_upv_1)
        end
    )
    if not (success_5) then
        warn("[UI] mock init failed: " .. tostring(v68))
    end
end
task.spawn(
    function()
        --[[
          line: 803
          upvalues:
            Parent_upv_1 (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            ensureScreen (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            u3 (copy, index: 5)
        ]]
        local v69 = Parent_upv_1.Parent:WaitForChild("Replay", 30)
        local v70 = v69 and (v69:WaitForChild("HudBridge", 10))
        if not v70 then
            return
        end
        if v70:IsA("ModuleScript") then
            local success_6, v71 = pcall(require, v70)
            if not success_6 or type(v71) ~= "table" then
                return
            end
            local tbl_upv_39 = {}
            local tbl_40 = {}
            function tbl_40.Enter(a1)
                --[[
                  name: Enter
                  line: 815
                  upvalues:
                    tbl_upv_5 (copy, index: 1)
                    ensureScreen (copy, index: 2)
                    tbl_upv_1 (copy, index: 3)
                    u3 (copy, index: 4)
                    tbl_upv_39 (copy, index: 5)
                ]]
                for _, value_19 in tbl_upv_5 do
                    ensureScreen(value_19)
                end
                local HotbarRoot_1 = tbl_upv_1.HotbarRoot
                local MatchHud_1 = tbl_upv_1.MatchHud
                local _ = MatchHud_1 and (tbl_upv_1.MatchHud.Root)
                for v1, value_20 in u3:GetChildren() do
                    if not (value_20:IsA("GuiObject")) or not (value_20.Visible) or value_20 == HotbarRoot_1 then
                        continue
                    end
                    if value_20 ~= MatchHud_1 then
                        value_20.Visible = false
                        table.insert(tbl_upv_39, value_20)
                    end
                end
                if tbl_upv_1.Hotbar and tbl_upv_1.Hotbar.SetReplaySource then
                    tbl_upv_1.Hotbar.SetReplaySource(a1)
                end
                if not tbl_upv_1.MatchHud or not tbl_upv_1.MatchHud.SetReplaySource then
                    return
                end
                tbl_upv_1.MatchHud.SetReplaySource(a1.model)
            end
            function tbl_40.Leave()
                --[[
                  name: Leave
                  line: 832
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    tbl_upv_39 (copy, index: 2)
                ]]
                if tbl_upv_1.Hotbar and tbl_upv_1.Hotbar.SetReplaySource then
                    tbl_upv_1.Hotbar.SetReplaySource(nil)
                end
                if tbl_upv_1.MatchHud and tbl_upv_1.MatchHud.SetReplaySource then
                    tbl_upv_1.MatchHud.SetReplaySource(nil)
                end
                for _, value_21 in tbl_upv_39 do
                    if value_21.Parent then
                        value_21.Visible = true
                    end
                end
                table.clear(tbl_upv_39)
            end
            v71.ui = tbl_40
        end
    end
)
LocalPlayer_upv_1:SetAttribute("UIReady", true)
local tbl_41 = {}
for key_3, value_22 in tbl_upv_8 do
    table.insert(tbl_41, string.format("%s=%.1f", key_3, value_22))
end
table.sort(tbl_41)
local v72 = string.format("total=%.1fms | %s", (v23 - v1) * 1000, table.concat(tbl_41, " "))
LocalPlayer_upv_1:SetAttribute("UIStartup", v72)
if not RunService_upv_1:IsStudio() then
    return
end
print("[UI] startup " .. v72)