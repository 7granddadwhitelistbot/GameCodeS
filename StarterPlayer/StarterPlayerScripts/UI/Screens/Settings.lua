local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local RunService_upv_1 = game:GetService("RunService")
local GuiService_upv_1 = game:GetService("GuiService")
local Keybinds_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_1 = {}
local tbl_2 = {title = "CAMERA"}
local tbl_3 = {fmt = 0, key = "sensitivity", label = "CAMERA SENSITIVITY", notPad = true, kind = "slider", step = 0.05, desc = "How fast the camera turns"}
function tbl_3.fmt(a1)
    --[[
      name: fmt
      line: 79
    ]]
    return string.format("%.2fx", a1)
end
local tbl_4 = {padOnly = true, key = "padSensitivity", label = "CONTROLLER SENSITIVITY", fmt = 0, kind = "slider", step = 0.05, desc = "How fast the right stick turns the camera"}
function tbl_4.fmt(a1)
    --[[
      name: fmt
      line: 82
    ]]
    return string.format("%.2fx", a1)
end
local tbl_5 = {padOnly = true, key = "padInvertY", label = "INVERT Y", kind = "switch", desc = "Push the stick up to look down"}
local tbl_6 = {fmt = 0, key = "fov", label = "FIELD OF VIEW", round = true, kind = "slider", step = 1, desc = "How much of the map you see"}
function tbl_6.fmt(a1)
    --[[
      name: fmt
      line: 86
    ]]
    return (tostring(math.floor(a1 + 0.5)))
end
local tbl_7 = {key = "aimSensitivity", label = "AIM SENSITIVITY", fmt = 0, kind = "slider", step = 0.05, desc = "How fast the camera turns while aiming"}
function tbl_7.fmt(a1)
    --[[
      name: fmt
      line: 92
    ]]
    return string.format("%.2fx", a1)
end
local function pct(a1)
    --[[
      name: pct
      line: 71
    ]]
    return string.format("%d%%", math.floor((a1 * 100) + 0.5))
end
tbl_2.items = {
    tbl_3,
    tbl_4,
    tbl_5,
    tbl_6,
    {key = "aimZoom", label = "AIM ZOOM", kind = "slider", step = 0.05, desc = "How far aiming zooms in", fmt = pct},
    tbl_7,
    {key = "aimAssist", label = "AIM ASSIST", kind = "switch", assistOnly = true, desc = "Helps your aim stay on enemies"},
    {key = "firstPerson", label = "FIRST PERSON", kind = "switch", capAction = "View", desc = "Start in first person", pad = Enum.KeyCode.DPadUp},
    {desc = "Camera bounce as you walk in first person", kind = "switch", key = "viewBobbing", label = "VIEW BOBBING"}
}
local tbl_upv_8 = {
    tbl_2,
    {title = "AUDIO", items = {{key = "music", label = "MUSIC", kind = "slider", step = 0.05, desc = "Lobby and match music", fmt = pct}, {key = "sfx", label = "SOUND EFFECTS", kind = "slider", step = 0.05, desc = "Combat, menus and ambience", fmt = pct}}},
    {title = "PARTY", items = {{desc = "Only your Roblox friends can invite you to a party", kind = "switch", key = "friendsOnlyInvites", label = "FRIENDS-ONLY INVITES"}}},
    {title = "CONTROLS", touchOnly = true, items = {{kind = "action", desc = "Move and resize your on-screen buttons", label = "BUTTON LAYOUT"}, {desc = "Drag the attack button to turn the camera", kind = "switch", key = "attackAim", label = "AIM WITH ATTACK BUTTON"}}},
    {keyboardOnly = true, title = "CONTROLS", keybinds = true, items = {}},
    {padbinds = true, title = "CONTROLLER", items = {}},
    {
        title = "STAGING",
        staging = true,
        items = {
            {label = "REPLAY NEW-PLAYER FLOW", button = "REPLAY", kind = "action", run = "replayNewPlayer", desc = "Welcome card, first match and starter loadouts again"},
            {label = "REPLAY WITH A FULL HUB", button = "REPLAY", kind = "action", run = "replayFullHub", desc = "New player again; FIGHT sends you to a match server"},
            {label = "SHOW NEWS POPUP", button = "SHOW", kind = "action", run = "showNews", desc = "What returning players see when they join"},
            {key = "moveDebug", label = "MOVEMENT DEBUG", kind = "switch", session = true, desc = "Overlay: fps, rollbacks, corrections per stop"},
            {key = "bodySmoothing", label = "BODY SMOOTHING", kind = "switch", session = true, desc = "On: a smooth visual copy; off: your character at 60 Hz steps"},
            {key = "premiumTest", label = "PREMIUM QUEUE ACCESS", kind = "switch", session = true, desc = "Count as a paying player with an old account (test)"}
        }
    }
}
local u1 = {sectionGap = 18, chipW = 124, label = 19, titleGap = 8, kbRowH = 52, pad = 18, trackH = 8, cap = 22, trackW = 236, value = 19, footerBtn = 52, kbHeader = 34, itemGap = 6, chipGap = 8, rowH = 64, chipH = 36, desc = 16, winW = 720, switchW = 58, title = 16, footerTop = 16, button = 20, knob = 22, valueW = 64, chipText = 16}
local tbl_upv_9 = {sectionGap = 18, chipW = 136, label = 22, titleGap = 8, kbRowH = 60, pad = 20, trackH = 10, cap = 24, trackW = 272, value = 22, footerBtn = 58, kbHeader = 38, itemGap = 6, chipGap = 8, rowH = 74, chipH = 42, desc = 17, winW = 880, switchW = 70, title = 18, footerTop = 14, button = 22, knob = 28, valueW = 78, chipText = 18}
local u2 = Color3.fromRGB(58, 63, 78)
local u3 = Color3.fromRGB(142, 149, 166)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 168
      upvalues:
        u1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        GuiService_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        u3 (copy, index: 5)
        u2 (copy, index: 6)
        Keybinds_upv_1 (copy, index: 7)
        tbl_upv_9 (copy, index: 8)
        tbl_upv_8 (copy, index: 9)
        RunService_upv_1 (copy, index: 10)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local SettingsStore_upv_1 = require(script.Parent.Parent.SettingsStore)
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 178
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("Settings")
    end
    local u4 = UI_upv_1.Window({Name = "Settings", Title = "SETTINGS", Size = UDim2.fromOffset(u1.winW, 640), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_upv_1 = u4.Content
    local u5 = {}
    local u6 = {}
    local u7 = {}
    local u8 = {}
    local u9 = nil
    local u10 = nil
    local u11 = nil
    local u12 = nil
    local u13 = nil
    local u14 = 640
    local u15 = nil
    local u16 = 0
    local u17 = false
    local u18 = 0
    local u19 = {}
    local u20 = {}
    local tbl_upv_10 = nil
    local function addNav(a2, a3)
        --[[
          name: addNav
          line: 208
          upvalues:
            u19 (ref, index: 1)
        ]]
        local tbl_11 = {land = 0}
        tbl_11.items = a2
        tbl_11.land = a3 or (a2[1])
        table.insert(u19, tbl_11)
        for key_upv_1, value_upv_1 in a2 do
            pcall(
                function()
                    --[[
                      line: 211
                      upvalues:
                        value_upv_1 (copy, index: 1)
                        key_upv_1 (copy, index: 2)
                        a2 (copy, index: 3)
                    ]]
                    if key_upv_1 == 1 then
                        value_upv_1.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                    end
                    if key_upv_1 ~= #a2 then
                        return
                    end
                    value_upv_1.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                end
            )
        end
    end
    local tbl_upv_12 = nil
    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 254
          upvalues:
            tbl_upv_12 (ref, index: 1)
        ]]
        if not tbl_upv_12 then
            return
        end
        tbl_upv_12.layer.Visible = false
    end
    local function leaveCost()
        --[[
          name: leaveCost
          line: 226
          upvalues:
            State_upv_1 (copy, index: 1)
            Players_upv_1 (copy, index: 2)
        ]]
        local Match_1 = State_upv_1.Match
        local v1 = Match_1 and (Match_1.phase)
        if workspace:GetAttribute("CustomServer") == true then
            return "You'll wait in this server's lobby until the next match.", false
        elseif v1 == "MatchEnd" then
            return "The match is over. Your result and rewards are kept.", false
        elseif v1 == "RoundEnd" and Match_1 then
            if type(Match_1.teams) ~= "table" then
                if Match_1 == "Intro" and (tonumber(Match_1 and (Match_1.round)) or 1) <= 1 then
                    return "The match hasn't started yet. Nothing is recorded.", false
                end
                local v2 = "You'll forfeit: it counts as a loss with no XP, and a bot takes your place."
                local v3 = tonumber(Players_upv_1.LocalPlayer:GetAttribute("Streak")) or 0
                local v4 = ((v3 >= 2) and (v2 .. string.format("\nYour \240\159\148\165 %d win streak ends.", v3))) or v2
                return v4, true
            else
                for _, value_2 in Match_1.teams do
                    if type(value_2) ~= "table" then
                        continue
                    end
                    local v5 = tonumber(value_2.score) or 0
                    if not (State_upv_1.RoundsToWin() <= v5) then
                        continue
                    end
                    return "The match is decided. Your result and rewards are kept.", false
                end
                if Match_1 == "Intro" and (tonumber(Match_1 and (Match_1.round)) or 1) <= 1 then
                    return "The match hasn't started yet. Nothing is recorded.", false
                end
                local v2 = "You'll forfeit: it counts as a loss with no XP, and a bot takes your place."
                local v3 = tonumber(Players_upv_1.LocalPlayer:GetAttribute("Streak")) or 0
                local v4 = ((v3 >= 2) and (v2 .. string.format("\nYour \240\159\148\165 %d win streak ends.", v3))) or v2
                return v4, true
            end
        else
            if Match_1 == "Intro" and (tonumber(Match_1 and (Match_1.round)) or 1) <= 1 then
                return "The match hasn't started yet. Nothing is recorded.", false
            end
            local v2 = "You'll forfeit: it counts as a loss with no XP, and a bot takes your place."
            local v3 = tonumber(Players_upv_1.LocalPlayer:GetAttribute("Streak")) or 0
            local v4 = ((v3 >= 2) and (v2 .. string.format("\nYour \240\159\148\165 %d win streak ends.", v3))) or v2
            return v4, true
        end
    end
    local function openConfirm()
        --[[
          name: openConfirm
          line: 259
          upvalues:
            tbl_upv_12 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            u4 (copy, index: 5)
            closeConfirm (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
            leaveCost (copy, index: 9)
            GuiService_upv_1 (copy, index: 10)
        ]]
        if not (tbl_upv_12) then
            local new_1 = UI_upv_1.new
            local tbl_13 = {}
            tbl_13.Name = "LeaveConfirm"
            tbl_13.Size = UDim2.fromScale(1, 1)
            tbl_13.BackgroundColor3 = Colors_upv_1.Void
            tbl_13.BackgroundTransparency = 0.3
            tbl_13.Text = ""
            tbl_13.AutoButtonColor = false
            tbl_13.Selectable = false
            tbl_13.ZIndex = 40
            local Corner_1 = UI_upv_1.Corner
            local v6 = Theme_upv_1.Radius.Window or (UDim.new(0, 18))
            tbl_13[1] = Corner_1(v6)
            tbl_13.Parent = u4.Holder
            local v7 = new_1("TextButton", tbl_13)
            v7.Activated:Connect(closeConfirm)
            local u21 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(470, 250), Radius = UDim.new(0, 16), Parent = v7})
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 41, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = u21})
            pcall(
                function()
                    --[[
                      line: 285
                      upvalues:
                        u21 (copy, index: 1)
                    ]]
                    u21.SelectionGroup = true
                    u21.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
                    u21.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                    u21.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                    u21.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                end
            )
            UI_upv_1.DisplayText({ZIndex = 42, Name = "Title", Text = "LEAVE MATCH?", TextSize = 36, Position = UDim2.fromOffset(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = Colors_upv_1.Text, Parent = u21})
            local v8 = UI_upv_1.new("TextLabel", {Text = "", Name = "Body", TextWrapped = true, ZIndex = 42, TextSize = 19, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 70), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = u21})
            local v9 = UI_upv_1.Button({Text = "STAY", Name = "Stay", Style = "Dark", ZIndex = 43, TextSize = 22, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = UDim2.fromOffset(196, 58), Parent = u21, OnClick = closeConfirm})
            local tbl_14 = {Text = "LEAVE", Name = "Leave", Style = "Danger", ZIndex = 43, TextSize = 22}
            tbl_14.AnchorPoint = Vector2.new(1, 1)
            tbl_14.Position = UDim2.new(1, -28, 1, -24)
            tbl_14.Size = UDim2.fromOffset(196, 58)
            tbl_14.Parent = u21
            function tbl_14.OnClick()
                --[[
                  name: OnClick
                  line: 336
                  upvalues:
                    tbl_upv_12 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if tbl_upv_12 then
                    tbl_upv_12.layer.Visible = false
                end
                a1.MenuManager.Close("Settings")
                a1.QueueAction("LeaveMatch")
            end
            local v10 = UI_upv_1.Button(tbl_14)
            tbl_upv_12 = {layer = v7, card = u21, body = v8, stay = v9, go = v10}
        end
        local v11 = tbl_upv_12
        local v12, v13 = leaveCost()
        v11.body.Text = v12
        local body_1 = v11.body
        local v14
        if v13 then
            v14 = Colors_upv_1.Text
        else
            v14 = Colors_upv_1.TextDim
        end
        body_1.TextColor3 = v14
        v11.layer.Visible = true
        UI_upv_1.Enter(v11.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = v11.stay.Instance
    end
    local function showControls()
        --[[
          name: showControls
          line: 355
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        return UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)
    end
    local function lastIsGamepad()
        --[[
          name: lastIsGamepad
          line: 358
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        return UI_upv_1.Gamepad
    end
    local function showKeybinds()
        --[[
          name: showKeybinds
          line: 362
          upvalues:
            UI_upv_1 (copy, index: 1)
            UserInputService_upv_1 (copy, index: 2)
        ]]
        return not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))
    end
    local u22 = false
    local function showAssist()
        --[[
          name: showAssist
          line: 367
          upvalues:
            UI_upv_1 (copy, index: 1)
            u22 (ref,  index: 2)
        ]]
        local v15 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        return v15
    end
    local function modeKey()
        --[[
          name: modeKey
          line: 370
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            UserInputService_upv_1 (copy, index: 3)
            u22 (ref,  index: 4)
        ]]
        local v16 = ((UI_upv_1.Compact) and "c") or "d"
        local v17 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
        local v18 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
        local v19 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        local v20
        if v19 then
            v20 = "a"
        else
            v20 = ""
        end
        return v16 .. v17 .. v18 .. v20 .. (((UI_upv_1.Gamepad) and "p") or "")
    end
    local u23 = UI_upv_1.new("Frame", {Name = "SettingsSelection", Size = UDim2.fromScale(1, 1), UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)})
    local function setHighlight(a4, a5)
        --[[
          name: setHighlight
          line: 384
          upvalues:
            UI_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
        ]]
        UI_upv_1.Tween(a4, Theme_upv_1.Tween.Fast, {BackgroundTransparency = a5})
    end
    local u24 = nil
    local function hookRowFeedback(a6, a7)
        --[[
          name: hookRowFeedback
          line: 389
          upvalues:
            UI_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
            u24 (ref,  index: 3)
        ]]
        local u25 = false
        a6.MouseEnter:Connect(
            function()
                --[[
                  line: 391
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u25 (ref,  index: 2)
                    a7 (copy, index: 3)
                    Theme_upv_1 (copy, index: 4)
                ]]
                if (UI_upv_1.Touch) then
                    return
                end
                u25 = true
                UI_upv_1.Tween(a7, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.955})
            end
        )
        a6.MouseLeave:Connect(
            function()
                --[[
                  line: 397
                  upvalues:
                    u25 (ref,  index: 1)
                    a7 (copy, index: 2)
                    u24 (ref,  index: 3)
                    UI_upv_1 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                ]]
                u25 = false
                UI_upv_1.Tween(a7, Theme_upv_1.Tween.Fast, {BackgroundTransparency = ((u24 ~= a7) and 1) or 0.94})
            end
        )
        if not a6:IsA("GuiButton") then
            return
        end
        a6.MouseButton1Down:Connect(
            function()
                --[[
                  line: 402
                  upvalues:
                    a7 (copy, index: 1)
                    UI_upv_1 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                ]]
                UI_upv_1.Tween(a7, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.93})
            end
        )
        a6.MouseButton1Up:Connect(
            function()
                --[[
                  line: 405
                  upvalues:
                    a7 (copy, index: 1)
                    u25 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    Theme_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(a7, Theme_upv_1.Tween.Fast, {BackgroundTransparency = (u25 and 0.955) or 1})
            end
        )
    end
    local function tick(a8)
        --[[
          name: tick
          line: 411
          upvalues:
            u16 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if not (os.clock() - u16 > 0.06) then
            return
        end
        u16 = os.clock()
        a1.Sounds.Play("Tick", {volume = 0.2, pitch = (a8 * 0.6) + 0.8})
    end
    local function textBlock(a9, a10, a11)
        --[[
          name: textBlock
          line: 431
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            Fonts_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u3 (copy, index: 5)
        ]]
        local v21 = UI_upv_1.new("Frame", {Name = "Text", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, u1.pad, 0.5, 0), Size = UDim2.new(1, -(((u1.pad * 2) + a11) + 16), 0, u1.label + 4 + u1.desc), Parent = a9})
        local v22 = UI_upv_1.new("Frame", {Name = "Line", Size = UDim2.new(1, 0, 0, u1.label), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v21})
        UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Label", Text = a10.label, FontFace = Fonts_upv_1.Heavy, TextSize = u1.label, TextColor3 = Colors_upv_1.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Parent = v22})
        if a10.capAction then
            UI_upv_1.ActionCap(a10.capAction, {LayoutOrder = 2, Height = u1.cap, TextSize = u1.cap - 8, Gamepad = a10.pad, Parent = v22})
        elseif a10.cap then
            UI_upv_1.KeyCap(a10.cap, {LayoutOrder = 2, Height = u1.cap, TextSize = u1.cap - 8, Gamepad = a10.pad, Parent = v22})
        end
        UI_upv_1.new("TextLabel", {Name = "Desc", Text = a10.desc, FontFace = Fonts_upv_1.SemiBold, TextSize = u1.desc, TextColor3 = u3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(0, u1.label + 4), Size = UDim2.new(1, 0, 0, u1.desc), Parent = v21})
    end
    local function rowBase(a12, a13, a14, a15)
        --[[
          name: rowBase
          line: 476
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            u23 (copy, index: 4)
            u8 (ref,  index: 5)
            addNav (copy, index: 6)
        ]]
        local new_2 = UI_upv_1.new
        local tbl_15 = {LayoutOrder = 0, Parent = 0, Name = 0, Size = 0}
        tbl_15.Name = a15.key or (a15.label)
        tbl_15.Size = UDim2.new(1, 0, 0, u1.rowH)
        tbl_15.LayoutOrder = a14
        tbl_15.Parent = a13
        local v23 = new_2(a12, tbl_15)
        if a14 > 1 then
            UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = Colors_upv_1.Stroke, Position = UDim2.fromOffset(u1.pad, 0), Size = UDim2.new(1, -u1.pad * 2, 0, 1), Parent = v23})
        end
        local v24 = UI_upv_1.new("Frame", {Name = "Highlight", BackgroundColor3 = Colors_upv_1.White, BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), [1] = UI_upv_1.Corner(9), Parent = v23})
        v23.SelectionImageObject = u23
        u8[v23] = v24
        addNav({v23})
        return v23, v24
    end
    local function sliderRow(a16, a17, a18)
        --[[
          name: sliderRow
          line: 508
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            rowBase (copy, index: 3)
            textBlock (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            u2 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            u7 (ref,  index: 10)
            hookRowFeedback (copy, index: 11)
            u9 (ref,  index: 12)
            u5 (ref,  index: 13)
            u15 (ref,  index: 14)
            u10 (ref,  index: 15)
        ]]
        local key_2 = a18.key
        local u26 = SettingsStore_upv_1.RANGES[key_2]
        local v25 = u1.trackW + 16 + u1.valueW
        local u27, v26 = rowBase("Frame", a16, a17, a18)
        textBlock(u27, a18, v25)
        local v27 = UI_upv_1.new("Frame", {Name = "Control", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -u1.pad, 0, 0), Size = UDim2.new(0, v25, 1, 0), Parent = u27})
        local u28 = UI_upv_1.new("TextLabel", {Text = "", Name = "Value", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(u1.valueW, u1.value + 4), FontFace = Fonts_upv_1.Heavy, TextSize = u1.value, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = v27})
        local tbl_upv_16 = {}
        tbl_upv_16.Name = "Track"
        tbl_upv_16.AnchorPoint = Vector2.new(0, 0.5)
        tbl_upv_16.Position = UDim2.fromScale(0, 0.5)
        tbl_upv_16.Size = UDim2.fromOffset(u1.trackW, u1.trackH)
        tbl_upv_16.BackgroundColor3 = u2
        tbl_upv_16[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_upv_16.Parent = v27
        local u29 = UI_upv_1.new("Frame", tbl_upv_16)
        local tbl_17 = {}
        tbl_17.Name = "Fill"
        tbl_17.Size = UDim2.fromScale(0, 1)
        tbl_17.BackgroundColor3 = Colors_upv_1.Accent
        tbl_17[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_17.Parent = u29
        local u30 = UI_upv_1.new("Frame", tbl_17)
        local tbl_18 = {}
        tbl_18.Name = "Knob"
        tbl_18.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_18.Position = UDim2.fromScale(0, 0.5)
        tbl_18.Size = UDim2.fromOffset(u1.knob, u1.knob)
        tbl_18.BackgroundColor3 = Colors_upv_1.Bone
        tbl_18.ZIndex = 2
        tbl_18[1], tbl_18[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.AccentDark, 2, 0.1)
        tbl_18.Parent = u29
        tbl_upv_16 = UI_upv_1.new("Frame", tbl_18)
        tbl_17 = UI_upv_1.new("TextButton", {Name = "Hit", Selectable = false, ZIndex = 5, Position = UDim2.fromOffset(-14, 0), Size = UDim2.new(1, 14 + u1.pad, 1, 0), Parent = v27})
        u27.Selectable = true
        pcall(
            function()
                --[[
                  line: 571
                  upvalues:
                    u27 (copy, index: 1)
                ]]
                u27.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                u27.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
            end
        )
        u7[u27] = a18
        hookRowFeedback(tbl_17, v26)
        u9 = u9 or u27
        u5[key_2] = function(a19, a20)
            --[[
              line: 578
              upvalues:
                u26 (copy, index: 1)
                u28 (copy, index: 2)
                a18 (copy, index: 3)
                u30 (copy, index: 4)
                tbl_upv_16 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
                Theme_upv_1 (copy, index: 7)
            ]]
            local v28 = math.clamp((a19 - u26[1]) / (u26[2] - u26[1]), 0, 1)
            u28.Text = a18.fmt(a19)
            if a20 then
                u30.Size = UDim2.fromScale(v28, 1)
                tbl_upv_16.Position = UDim2.fromScale(v28, 0.5)
            else
                UI_upv_1.Tween(u30, Theme_upv_1.Tween.Fast, {Size = UDim2.fromScale(v28, 1)})
                UI_upv_1.Tween(tbl_upv_16, Theme_upv_1.Tween.Fast, {Position = UDim2.fromScale(v28, 0.5)})
            end
        end
        tbl_17.MouseButton1Down:Connect(
            function()
                --[[
                  line: 589
                  upvalues:
                    u15 (ref,  index: 1)
                    a18 (copy, index: 2)
                    u29 (copy, index: 3)
                    tbl_upv_16 (copy, index: 4)
                    u10 (ref,  index: 5)
                    UI_upv_1 (copy, index: 6)
                    Theme_upv_1 (copy, index: 7)
                ]]
                u15 = {item = a18, track = u29, knob = tbl_upv_16}
                if u10 then
                    u10.ScrollingEnabled = false
                end
                UI_upv_1.Tween(UI_upv_1.GetScaleObj(tbl_upv_16), Theme_upv_1.Tween.PopSmall, {Scale = 1.2})
            end
        )
    end
    local function sessionSwitch(a21)
        --[[
          name: sessionSwitch
          line: 599
          upvalues:
            a1 (copy, index: 1)
        ]]
        if a21 ~= "moveDebug" then
            if a21 ~= "bodySmoothing" then
                if a21 ~= "premiumTest" then
                    return nil, nil
                end
                return a1.PremiumTestOn, a1.PremiumTestToggle
            end
            return a1.BodySmoothingOn, a1.BodySmoothingToggle
        end
        return a1.MoveDebugShown, a1.MoveDebugToggle
    end
    local function switchRow(a22, a23, a24)
        --[[
          name: switchRow
          line: 610
          upvalues:
            rowBase (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u1 (ref,  index: 3)
            textBlock (copy, index: 4)
            hookRowFeedback (copy, index: 5)
            u9 (ref,  index: 6)
            u5 (ref,  index: 7)
            a1 (copy, index: 8)
            SettingsStore_upv_1 (copy, index: 9)
            u6 (ref,  index: 10)
        ]]
        local key_upv_3 = a24.key
        local v29, v30 = rowBase("TextButton", a22, a23, a24)
        local u31 = UI_upv_1.Switch({Width = u1.switchW, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -u1.pad, 0.5, 0), Parent = v29})
        textBlock(v29, a24, u1.switchW)
        hookRowFeedback(v29, v30)
        u9 = u9 or v29
        u5[key_upv_3] = function(a25, a26)
            --[[
              line: 623
              upvalues:
                a24 (copy, index: 1)
                key_upv_3 (copy, index: 2)
                a1 (copy, index: 3)
                u31 (copy, index: 4)
            ]]
            if a24.session then
                local v31
                if key_upv_3 == "moveDebug" then
                    v31 = a1.MoveDebugShown
                elseif key_upv_3 == "bodySmoothing" then
                    v31 = a1.BodySmoothingOn
                elseif key_upv_3 ~= "premiumTest" then
                    v31 = nil
                else
                    v31 = a1.PremiumTestOn
                end
                local v32 = false
                if v31 ~= nil then
                    v32 = v31() == true
                end
                u31:Set(v32, a26)
            else
                u31:Set(a25 >= 0.5, a26)
            end
        end
        local function flip_1()
            --[[
              name: flip
              line: 631
              upvalues:
                a24 (copy, index: 1)
                key_upv_3 (copy, index: 2)
                a1 (copy, index: 3)
                u31 (copy, index: 4)
                SettingsStore_upv_1 (copy, index: 5)
            ]]
            if a24.session then
                local v33, v34
                if key_upv_3 == "moveDebug" then
                    v34 = a1.MoveDebugShown
                    v33 = a1.MoveDebugToggle
                elseif key_upv_3 == "bodySmoothing" then
                    local BodySmoothingOn_1 = a1.BodySmoothingOn
                    v33, v34 = a1.BodySmoothingToggle, BodySmoothingOn_1
                elseif key_upv_3 ~= "premiumTest" then
                    v33, v34 = nil, nil
                else
                    local PremiumTestOn_1 = a1.PremiumTestOn
                    v33, v34 = a1.PremiumTestToggle, PremiumTestOn_1
                end
                if v33 then
                    v33()
                end
                v33 = (v34 ~= nil) and (v34() == true)
                u31:Set(v33, false)
                local Play_1 = a1.Sounds.Play
                local tbl_19 = {pitch = 0}
                local v35
                if v33 then
                    v35 = 1.08
                else
                    v35 = 0.94
                end
                tbl_19.pitch = v35
                Play_1("Click", tbl_19)
            else
                local v36 = SettingsStore_upv_1.Get(key_upv_3) < 0.5
                local Set_1 = SettingsStore_upv_1.Set
                local v37
                if v36 then
                    v37 = 1
                else
                    v37 = 0
                end
                Set_1(key_upv_3, v37, true)
                local Play_2 = a1.Sounds.Play
                local tbl_20 = {pitch = 0}
                tbl_20.pitch = (v36 and 1.08) or 0.94
                Play_2("Click", tbl_20)
            end
        end
        u6[key_upv_3] = flip_1
        v29.Activated:Connect(flip_1)
    end
    local function actionRow(a27, a28, a29)
        --[[
          name: actionRow
          line: 650
          upvalues:
            rowBase (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u1 (ref,  index: 3)
            Fonts_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            textBlock (copy, index: 6)
            hookRowFeedback (copy, index: 7)
            u9 (ref,  index: 8)
            a1 (copy, index: 9)
        ]]
        local v38, v39 = rowBase("TextButton", a27, a28, a29)
        local v40 = ((a29.button) and 120) or 90
        local v41 = UI_upv_1.new("Frame", {Name = "Edit", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -u1.pad, 0.5, 0), Size = UDim2.fromOffset(v40, u1.label + 8), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v38})
        UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Text", Text = a29.button or "EDIT", FontFace = Fonts_upv_1.Heavy, TextSize = u1.value, TextColor3 = Colors_upv_1.Accent, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Parent = v41})
        UI_upv_1.Icon("chevRight", u1.value, Colors_upv_1.Accent, {LayoutOrder = 2, Parent = v41})
        textBlock(v38, a29, v40)
        hookRowFeedback(v38, v39)
        u9 = u9 or v38
        v38.Activated:Connect(
            function()
                --[[
                  line: 676
                  upvalues:
                    a1 (copy, index: 1)
                    a29 (copy, index: 2)
                ]]
                a1.Sounds.Play("Click")
                if a29.run ~= "replayNewPlayer" and a29.run ~= "replayFullHub" then
                    if a29.run == "showNews" then
                        a1.MenuManager.Open("News")
                    elseif a1.OpenTouchEditor then
                        a1.OpenTouchEditor()
                    end
                    return
                end
                if not a1.ReplayNewPlayer then
                    return
                end
                task.spawn(a1.ReplayNewPlayer, a29.run == "replayFullHub")
            end
        )
    end
    local tbl_upv_21 = {}
    local v42 = nil
    for _, value_3 in Keybinds_upv_1.ACTIONS do
        if value_3.group ~= "items" or value_3.max ~= 1 then
            table.insert(tbl_upv_21, {items = false, label = value_3.label, ids = {value_3.id}})
            continue
        end
        if not (v42) then
            local tbl_22 = {items = true, label = "ITEMS", ids = {}}
            table.insert(tbl_upv_21, tbl_22)
            v42 = tbl_22
        end
        table.insert(v42.ids, value_3.id)
    end
    local tbl_upv_23 = {}
    local u32 = nil
    local u33 = nil
    local u34 = 0
    local Void_upv_1 = Colors_upv_1.Void
    local u35 = nil
    local function paintChip(a30)
        --[[
          name: paintChip
          line: 716
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            u35 (ref,  index: 3)
        ]]
        local v43 = Keybinds_upv_1.Get(a30.id)[a30.slot]
        local label_1 = a30.label
        local v44
        if v43 then
            if a30.items then
                v44 = Keybinds_upv_1.CapFor(v43) or "?"
            else
                v44 = Keybinds_upv_1.Display(v43)
            end
        else
            v44 = "\226\128\148"
        end
        label_1.Text = v44
        local label_2 = a30.label
        local v45
        if v43 then
            v45 = Colors_upv_1.Text
        else
            v45 = Colors_upv_1.TextMuted
        end
        label_2.TextColor3 = v45
        a30.button.BackgroundTransparency = (v43 and 0.35) or 0.72
        if u35 == a30.button then
            return
        end
        a30.stroke.Color = Colors_upv_1.Stroke
        a30.stroke.Transparency = (v43 and 0.8) or 0.9
    end
    local function paintKeybinds()
        --[[
          name: paintKeybinds
          line: 726
          upvalues:
            tbl_upv_23 (ref,  index: 1)
            paintChip (copy, index: 2)
            u32 (ref,  index: 3)
            Keybinds_upv_1 (copy, index: 4)
        ]]
        for _, value_4 in tbl_upv_23 do
            for v1, value_5 in value_4 do
                paintChip(value_5)
            end
        end
        if not u32 then
            return
        end
        u32:SetEnabled(not Keybinds_upv_1.AllDefault())
    end
    local function flashChips(a31)
        --[[
          name: flashChips
          line: 736
          upvalues:
            tbl_upv_23 (ref,  index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Void_upv_1 (copy, index: 4)
            paintChip (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v46 = tbl_upv_23[a31] or {}
        for _, value_upv_6 in v46 do
            value_upv_6.button.BackgroundColor3 = Colors_upv_1.AccentDark
            value_upv_6.button.BackgroundTransparency = 0.05
            UI_upv_1.Tween(value_upv_6.button, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Void_upv_1})
            task.delay(
                0.7,
                function()
                    --[[
                      line: 741
                      upvalues:
                        value_upv_6 (copy, index: 1)
                        paintChip (copy, index: 2)
                    ]]
                    if not value_upv_6.button.Parent then
                        return
                    end
                    paintChip(value_upv_6)
                end
            )
            UI_upv_1.Pop(value_upv_6.button, 0.25, Theme_upv_1.Tween.PopSmall)
        end
    end
    local function notice(a32)
        --[[
          name: notice
          line: 749
          upvalues:
            u33 (ref, index: 1)
            u34 (ref, index: 2)
        ]]
        local v47 = u33
        if not v47 then
            return
        end
        u34 = u34 + 1
        local _ = u34
        v47.Text = a32
        v47.TextTransparency = 0
        task.delay(4, function() end)
    end
    local function actionLabel(a33)
        --[[
          name: actionLabel
          line: 764
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
        ]]
        local v48 = Keybinds_upv_1.Action(a33)
        if v48 then
            return v48.label
        end
        return a33
    end
    local u36 = nil
    local u37 = nil
    local u38 = 0
    local u39 = nil
    local u40 = 0
    local function releaseSink()
        --[[
          name: releaseSink
          line: 786
          upvalues:
            u36 (ref, index: 1)
        ]]
        if not u36 or not u36.box:IsFocused() then
            return
        end
        u36.box:ReleaseFocus()
    end
    local function closeCapture()
        --[[
          name: closeCapture
          line: 792
          upvalues:
            u37 (ref,  index: 1)
            u38 (ref,  index: 2)
            a1 (copy, index: 3)
            u36 (ref,  index: 4)
            u40 (ref,  index: 5)
            u39 (ref,  index: 6)
            u4 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            GuiService_upv_1 (copy, index: 9)
        ]]
        u37 = nil
        u38 = u38 + 1
        a1.PadCapturing = false
        if u36 then
            u36.layer.Visible = false
        end
        if u36 and u36.box:IsFocused() then
            u36.box:ReleaseFocus()
        end
        if not u37 then
            return
        end
        if u37.pad then
            u40 = os.clock() + 0.25
            local sel_1 = u37.sel
            u39 = sel_1
            if not sel_1 or not u4.IsOpen or not UI_upv_1.Gamepad or not sel_1.Parent or GuiService_upv_1.SelectedObject ~= nil then
                return
            end
            GuiService_upv_1.SelectedObject = sel_1
        end
    end
    local function padIdle()
        --[[
          name: padIdle
          line: 811
          upvalues:
            u36 (ref,  index: 1)
            u37 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v49 = (u37 ~= nil) and (u37.pad == true)
        local line1_1 = u36.line1
        local v50
        if v49 then
            v50 = "PRESS A BUTTON"
        else
            v50 = "PRESS A KEY"
        end
        line1_1.Text = v50
        u36.line1.TextColor3 = Colors_upv_1.Text
        u36.line2.Text = "or click here with a mouse button"
        u36.line2.Visible = not v49
        u36.holdHint.Visible = v49
        u36.padStroke.Color = Colors_upv_1.Accent
    end
    local function refuse(a34)
        --[[
          name: refuse
          line: 821
          upvalues:
            u36 (ref,  index: 1)
            u38 (ref,  index: 2)
            u37 (ref,  index: 3)
            Colors_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
        ]]
        u38 = u38 + 1
        local u41 = u38
        local v51 = (u37 ~= nil) and (u37.pad == true)
        u36.line1.Text = string.upper(a34)
        u36.line1.TextColor3 = Colors_upv_1.Danger
        local line2_1 = u36.line2
        local v52
        if v51 then
            v52 = "Pick another button"
        else
            v52 = "Pick another key"
        end
        line2_1.Text = v52
        u36.line2.Visible = true
        u36.holdHint.Visible = false
        u36.padStroke.Color = Colors_upv_1.Danger
        UI_upv_1.Shake(u36.pad, 6)
        a1.Sounds.Play("Error")
        task.delay(
            1.8,
            function()
                --[[
                  line: 834
                  upvalues:
                    u41 (copy, index: 1)
                    u38 (ref,  index: 2)
                    u37 (ref,  index: 3)
                    u36 (ref,  index: 4)
                    Colors_upv_1 (copy, index: 5)
                ]]
                if u41 ~= u38 then
                    return
                end
                if u37 then
                    local v53 = u36
                    local v54 = (u37 ~= nil) and (u37.pad == true)
                    local line1_2 = v53.line1
                    local v55
                    if v54 then
                        v55 = "PRESS A BUTTON"
                    else
                        v55 = "PRESS A KEY"
                    end
                    line1_2.Text = v55
                    v53.line1.TextColor3 = Colors_upv_1.Text
                    v53.line2.Text = "or click here with a mouse button"
                    v53.line2.Visible = not v54
                    v53.holdHint.Visible = v54
                    v53.padStroke.Color = Colors_upv_1.Accent
                end
            end
        )
    end
    local function commit(a35)
        --[[
          name: commit
          line: 840
          upvalues:
            u37 (ref,  index: 1)
            closeCapture (copy, index: 2)
            Keybinds_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            SettingsStore_upv_1 (copy, index: 5)
            flashChips (copy, index: 6)
            u33 (ref,  index: 7)
            u34 (ref,  index: 8)
        ]]
        if not u37 then
            return
        end
        closeCapture()
        local v56, v57, v58 = Keybinds_upv_1.Assign(u37.id, u37.slot, a35)
        if #v56 ~= 0 then
            SettingsStore_upv_1.SaveKeybinds(v56)
            a1.Sounds.Play("Select")
            flashChips(u37.id)
            if v57 then
                flashChips(v57)
                v56 = v58 or {}
                local v59, v60, v61, v62 = nil, nil, nil, nil
                if #v56 ~= 0 then
                    v59 = Keybinds_upv_1.Action(v57)
                    local v63
                    if v59 then
                        v63 = v59.label
                    else
                        v63 = v57
                    end
                    local v64 = string.format("SWAPPED \194\183 %s NOW USES %s", v63, Keybinds_upv_1.Display(v56[1]))
                    v60 = u33
                    if not v60 then
                        return
                    end
                    u34 = u34 + 1
                    local _ = u34
                    v60.Text = v64
                    v60.TextTransparency = 0
                    task.delay(4, function() end)
                else
                    v61 = Keybinds_upv_1.Action(v57)
                    local v63
                    if v61 then
                        v63 = v61.label
                    else
                        v63 = v57
                    end
                    local v65 = string.format("%s IS NOW UNBOUND", v63)
                    v62 = u33
                    if not v62 then
                        return
                    end
                    u34 = u34 + 1
                    local _ = u34
                    v62.Text = v65
                    v62.TextTransparency = 0
                    task.delay(4, function() end)
                end
            end
        else
            a1.Sounds.Play("Click")
        end
    end
    local function buildCapture()
        --[[
          name: buildCapture
          line: 864
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u4 (copy, index: 4)
            closeCapture (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            u37 (ref,  index: 7)
            Keybinds_upv_1 (copy, index: 8)
            SettingsStore_upv_1 (copy, index: 9)
            flashChips (copy, index: 10)
        ]]
        local new_3 = UI_upv_1.new
        local tbl_24 = {}
        tbl_24.Name = "KeyCapture"
        tbl_24.Size = UDim2.fromScale(1, 1)
        tbl_24.BackgroundColor3 = Colors_upv_1.Void
        tbl_24.BackgroundTransparency = 0.3
        tbl_24.Text = ""
        tbl_24.AutoButtonColor = false
        tbl_24.Selectable = false
        tbl_24.Visible = false
        tbl_24.ZIndex = 50
        local Corner_2 = UI_upv_1.Corner
        local v66 = Theme_upv_1.Radius.Window or (UDim.new(0, 18))
        tbl_24[1] = Corner_2(v66)
        tbl_24.Parent = u4.Holder
        local u42 = new_3("TextButton", tbl_24)
        u42.Activated:Connect(closeCapture)
        local v67 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(480, 330), Radius = UDim.new(0, 16), Parent = u42})
        UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 51, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v67})
        local v68 = UI_upv_1.new("TextLabel", {Text = "REBIND", Name = "Eyebrow", ZIndex = 52, TextSize = 15, Position = UDim2.fromOffset(0, 22), Size = UDim2.new(1, 0, 0, 18), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, Parent = v67})
        local v69 = UI_upv_1.DisplayText({ZIndex = 52, Name = "Title", Text = "", TextSize = 34, Position = UDim2.fromOffset(0, 42), Size = UDim2.new(1, 0, 0, 38), TextColor3 = Colors_upv_1.Text, Parent = v67})
        local v70 = UI_upv_1.new("TextLabel", {Text = "", Name = "Now", RichText = true, ZIndex = 52, TextSize = 16, Position = UDim2.fromOffset(0, 82), Size = UDim2.new(1, 0, 0, 20), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = v67})
        local v71 = UI_upv_1.new("Frame", {Name = "NowPad", Position = UDim2.fromOffset(0, 80), Size = UDim2.new(1, 0, 0, 24), Visible = false, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v67})
        UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "NOW", Name = "Label", ZIndex = 52, TextSize = 16, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Parent = v71})
        local v72 = UI_upv_1.PadCap(Enum.KeyCode.ButtonA, {Height = 24, ZIndex = 52, LayoutOrder = 2, Parent = v71})
        local v73 = UI_upv_1.new("Frame", {Name = "Pad", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 114), Size = UDim2.new(1, -56, 0, 112), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.4, ZIndex = 52, [1] = UI_upv_1.Corner(14), Parent = v67})
        local u43 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0.1)
        u43.Parent = v73
        local v74 = UI_upv_1.DisplayText({Text = "PRESS A KEY", Name = "Line1", TextScaled = true, ZIndex = 53, TextSize = 28, Position = UDim2.fromOffset(12, 26), Size = UDim2.new(1, -24, 0, 32), TextColor3 = Colors_upv_1.Text, Parent = v73})
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 12, Parent = v74})
        local v75 = UI_upv_1.new("TextLabel", {Text = "", Name = "Line2", ZIndex = 53, TextSize = 17, Position = UDim2.fromOffset(12, 64), Size = UDim2.new(1, -24, 0, 20), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, Parent = v73})
        local u44 = UI_upv_1.new("Frame", {Name = "HoldHint", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 62), Size = UDim2.new(1, -24, 0, 26), Visible = false, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v73})
        local function hintText_1(a36, a37)
            --[[
              name: hintText
              line: 990
              upvalues:
                UI_upv_1 (copy, index: 1)
                Fonts_upv_1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                u44 (copy, index: 4)
            ]]
            UI_upv_1.new("TextLabel", {ZIndex = 53, TextSize = 17, Name = "T" .. a37, Text = a36, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), LayoutOrder = a37, Parent = u44})
        end
        hintText_1("Hold", 1)
        local v76 = UI_upv_1.PadCap(Enum.KeyCode.ButtonB, {Height = 24, ZIndex = 53, LayoutOrder = 2, Parent = u44})
        hintText_1("to cancel", 3)
        local v77 = UI_upv_1.new("Frame", {Name = "Hold", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -40, 0, 4), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.5, Visible = false, ZIndex = 53, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v73})
        local v78 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Danger, ZIndex = 54, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v77})
        local tbl_25 = {Text = "CLEAR", Name = "Clear", Style = "Dark", ZIndex = 53, TextSize = 20}
        tbl_25.AnchorPoint = Vector2.new(0, 1)
        tbl_25.Position = UDim2.new(0, 28, 1, -24)
        tbl_25.Size = UDim2.fromOffset(200, 54)
        tbl_25.Parent = v67
        function tbl_25.OnClick()
            --[[
              name: OnClick
              line: 1037
              upvalues:
                u37 (ref,  index: 1)
                closeCapture (copy, index: 2)
                Keybinds_upv_1 (copy, index: 3)
                SettingsStore_upv_1 (copy, index: 4)
                flashChips (copy, index: 5)
            ]]
            if not u37 then
                return
            end
            closeCapture()
            if Keybinds_upv_1.Get(u37.id)[u37.slot] then
                Keybinds_upv_1.Clear(u37.id, u37.slot)
                SettingsStore_upv_1.SaveKeybinds({u37.id})
                flashChips(u37.id)
            end
        end
        local v79 = UI_upv_1.Button(tbl_25)
        tbl_25 = UI_upv_1.Button({Text = "CANCEL", Name = "Cancel", Style = "Dark", ZIndex = 53, TextSize = 20, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = UDim2.fromOffset(200, 54), Parent = v67, OnClick = closeCapture})
        local u45 = UI_upv_1.new("TextBox", {TextTransparency = 1, Text = "", Name = "KeySink", ZIndex = 50, Selectable = false, ClearTextOnFocus = true, BackgroundTransparency = 1, Size = UDim2.fromOffset(1, 1), Parent = u42})
        u45.FocusLost:Connect(
            function()
                --[[
                  line: 1075
                  upvalues:
                    u37 (ref,  index: 1)
                    u42 (copy, index: 2)
                    u45 (copy, index: 3)
                ]]
                task.defer(
                    function()
                        --[[
                          line: 1076
                          upvalues:
                            u37 (ref,  index: 1)
                            u42 (copy, index: 2)
                            u45 (copy, index: 3)
                        ]]
                        if not u37 or (u37.pad) or not u42.Visible or (u45:IsFocused()) then
                            return
                        end
                        u45:CaptureFocus()
                    end
                )
            end
        )
        u45:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 1082
                  upvalues:
                    u45 (copy, index: 1)
                ]]
                if u45.Text == "" then
                    return
                end
                u45.Text = ""
            end
        )
        UI_upv_1.Every(
            u42,
            0.03333333333333333,
            function()
                --[[
                  line: 1087
                  upvalues:
                    u42 (copy, index: 1)
                    u37 (ref,  index: 2)
                    u43 (copy, index: 3)
                ]]
                if not u42.Visible or not u37 then
                    return
                end
                u43.Transparency = (((math.sin(os.clock() * 5) * 0.5) + 0.5) * 0.35) + 0.15
            end
        )
        local tbl_26 = {}
        tbl_26.layer = u42
        tbl_26.card = v67
        tbl_26.eyebrow = v68
        tbl_26.title = v69
        tbl_26.now = v70
        tbl_26.pad = v73
        tbl_26.padStroke = u43
        tbl_26.line1 = v74
        tbl_26.line2 = v75
        tbl_26.clear = v79
        tbl_26.cancel = tbl_25
        tbl_26.box = u45
        tbl_26.nowPad = v71
        tbl_26.nowCap = v72
        tbl_26.holdHint = u44
        tbl_26.holdCap = v76
        tbl_26.hold = v77
        tbl_26.holdFill = v78
        return tbl_26
    end
    local function openCapture(a38, a39)
        --[[
          name: openCapture
          line: 1098
          upvalues:
            u36 (ref,  index: 1)
            buildCapture (copy, index: 2)
            Keybinds_upv_1 (copy, index: 3)
            u37 (ref,  index: 4)
            u38 (ref,  index: 5)
            a1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
        ]]
        if not (u36) then
            u36 = buildCapture()
        end
        local u46 = u36
        local v80 = Keybinds_upv_1.Get(a38)
        local v81 = math.clamp(a39, 1, #v80 + 1)
        local tbl_27 = {}
        tbl_27.id = a38
        tbl_27.slot = v81
        tbl_27.at = os.clock()
        u37 = tbl_27
        u38 = u38 + 1
        local v82 = Keybinds_upv_1.Action(a38)
        u46.eyebrow.Text = ((v81 > 1) and "SECOND KEY FOR") or "REBIND"
        local title_1 = u46.title
        local v83
        if v82 then
            v83 = v82.label
        else
            v83 = a38
        end
        title_1.Text = v83
        local v84 = v80[v81]
        local Rich_1 = a1.Loc.Rich
        local now_1 = u46.now
        local v85 = ((not v84) and "NOT BOUND") or (string.format("NOW  <font color=\"#FFFFFF\">%s</font>", Keybinds_upv_1.Display(v84)))
        Rich_1(now_1, v85)
        u46.now.Visible = true
        u46.nowPad.Visible = false
        u46.hold.Visible = false
        u46.cancel.Instance.Visible = true
        u46.card.Size = UDim2.fromOffset(480, 330)
        local v86 = (u37 ~= nil) and (u37.pad == true)
        local line1_3 = u36.line1
        if v86 then
            v85 = "PRESS A BUTTON"
        else
            v85 = "PRESS A KEY"
        end
        line1_3.Text = v85
        u36.line1.TextColor3 = Colors_upv_1.Text
        u36.line2.Text = "or click here with a mouse button"
        u36.line2.Visible = not v86
        u36.holdHint.Visible = v86
        u36.padStroke.Color = Colors_upv_1.Accent
        local v87 = v84 ~= nil
        u46.clear.Instance.Visible = v87
        local Instance_1 = u46.cancel.Instance
        if v87 then
            v85 = Vector2.new(1, 1)
        else
            v85 = Vector2.new(0.5, 1)
        end
        Instance_1.AnchorPoint = v85
        local Instance_2 = u46.cancel.Instance
        if v87 then
            v85 = UDim2.new(1, -28, 1, -24)
        else
            v85 = UDim2.new(0.5, 0, 1, -24)
        end
        Instance_2.Position = v85
        u46.layer.Visible = true
        UI_upv_1.Enter(u46.card, Vector2.new(0, 14), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Click")
        task.defer(
            function()
                --[[
                  line: 1125
                  upvalues:
                    u37 (ref,  index: 1)
                    u46 (copy, index: 2)
                ]]
                if not u37 or (u46.box:IsFocused()) then
                    return
                end
                u46.box:CaptureFocus()
            end
        )
    end
    local function inside(a40, a41)
        --[[
          name: inside
          line: 1131
        ]]
        if not a40.Visible then
            return false
        end
        local AbsolutePosition_1 = a40.AbsolutePosition
        local AbsoluteSize_1 = a40.AbsoluteSize
        return (AbsolutePosition_1.X <= a41.X) and ((AbsolutePosition_1.Y <= a41.Y) and ((a41.X <= AbsolutePosition_1.X + AbsoluteSize_1.X) and (a41.Y <= AbsolutePosition_1.Y + AbsoluteSize_1.Y)))
    end
    UserInputService_upv_1.InputBegan:Connect(
        function(a42)
            --[[
              line: 1138
              upvalues:
                u36 (ref,  index: 1)
                u37 (ref,  index: 2)
                Keybinds_upv_1 (copy, index: 3)
                commit (copy, index: 4)
                refuse (copy, index: 5)
                closeCapture (copy, index: 6)
            ]]
            local v91
            local v88 = u36
            if not u37 or not v88 then
                return
            end
            if not (u37.pad) then
                local UserInputType_1 = a42.UserInputType
                local v89 = nil
                if UserInputType_1 ~= Enum.UserInputType.Keyboard then
                    local v90 = nil
                    if UserInputType_1 == Enum.UserInputType.MouseButton1 or UserInputType_1 == Enum.UserInputType.MouseButton2 or UserInputType_1 == Enum.UserInputType.MouseButton3 then
                        v91 = Vector2.new(a42.Position.X, a42.Position.Y)
                        v89 = u36.pad
                        if v89.Visible then
                            local _ = v89.AbsolutePosition
                            local v94 = v89.AbsoluteSize
                            v90 = v89.AbsolutePosition.X <= v91.X and v89.AbsolutePosition.Y <= v91.Y and v91.X <= v89.AbsolutePosition.X + v89.AbsoluteSize.X and v91.Y <= v89.AbsolutePosition.Y + v89.AbsoluteSize.Y
                        else
                            v90 = false
                        end
                    end
                    if v90 then
                        commit(UserInputType_1.Name)
                    else
                        local card_1 = u36.card
                        if card_1.Visible then
                            local _ = card_1.AbsolutePosition
                            local v95 = card_1.AbsoluteSize
                            v90 = card_1.AbsolutePosition.X <= v91.X and card_1.AbsolutePosition.Y <= v91.Y and v91.X <= card_1.AbsolutePosition.X + card_1.AbsoluteSize.X and v91.Y <= card_1.AbsolutePosition.Y + card_1.AbsoluteSize.Y
                        else
                            v90 = false
                        end
                        if v90 then
                            return
                        end
                        if UserInputType_1 ~= Enum.UserInputType.MouseButton1 then
                            closeCapture()
                        end
                    end
                elseif a42.KeyCode ~= Enum.KeyCode.Unknown then
                    local Name_1 = a42.KeyCode.Name
                    local v92, v93 = Keybinds_upv_1.Bindable(Name_1)
                    if v92 then
                        commit(Name_1)
                    else
                        refuse(v93 or "That key can't be used")
                    end
                end
            end
        end
    )
    local function keyChip(a43, a44, a45, a46, a47, a48)
        --[[
          name: keyChip
          line: 1168
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            Void_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            u35 (ref,  index: 6)
            Theme_upv_1 (copy, index: 7)
            Keybinds_upv_1 (copy, index: 8)
            openCapture (copy, index: 9)
            tbl_upv_23 (ref,  index: 10)
            paintChip (copy, index: 11)
        ]]
        local u47 = UI_upv_1.new("TextButton", {Name = a44 .. "_" .. a45, Size = UDim2.fromOffset(a46, u1.chipH), BackgroundColor3 = Void_upv_1, BackgroundTransparency = 0.35, AutoButtonColor = false, Text = "", Selectable = false, LayoutOrder = a48, [1] = UI_upv_1.Corner(8), Parent = a43})
        local u48 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.8)
        u48.Parent = u47
        local v94 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Key", TextScaled = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -10, 0, u1.chipText + 2), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = u47})
        UI_upv_1.new("UITextSizeConstraint", {MinTextSize = 9, MaxTextSize = u1.chipText, Parent = v94})
        local tbl_28 = {}
        tbl_28.button = u47
        tbl_28.label = v94
        tbl_28.stroke = u48
        tbl_28.id = a44
        tbl_28.slot = a45
        tbl_28.items = a47
        u47.MouseEnter:Connect(
            function()
                --[[
                  line: 1197
                  upvalues:
                    u35 (ref,  index: 1)
                    u47 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                    u48 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                    Colors_upv_1 (copy, index: 6)
                ]]
                u35 = u47
                UI_upv_1.Tween(u48, Theme_upv_1.Tween.Fast, {Transparency = 0.1, Color = Colors_upv_1.Accent})
            end
        )
        u47.MouseLeave:Connect(
            function()
                --[[
                  line: 1201
                  upvalues:
                    u35 (ref,  index: 1)
                    u47 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                    u48 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                    Colors_upv_1 (copy, index: 6)
                    Keybinds_upv_1 (copy, index: 7)
                    a44 (copy, index: 8)
                    a45 (copy, index: 9)
                ]]
                if u35 == u47 then
                    u35 = nil
                end
                local Tween_1 = UI_upv_1.Tween
                local Fast_1 = Theme_upv_1.Tween.Fast
                local tbl_29 = {Transparency = 0}
                tbl_29.Color = Colors_upv_1.Stroke
                tbl_29.Transparency = Keybinds_upv_1.Get(a44)[a45] and 0.8 or 0.9
                Tween_1(u48, Fast_1, tbl_29)
            end
        )
        u47.Activated:Connect(
            function()
                --[[
                  line: 1207
                  upvalues:
                    openCapture (copy, index: 1)
                    a44 (copy, index: 2)
                    a45 (copy, index: 3)
                ]]
                openCapture(a44, a45)
            end
        )
        tbl_upv_23[a44] = tbl_upv_23[a44] or {}
        table.insert(tbl_upv_23[a44], tbl_28)
        paintChip(tbl_28)
        return tbl_28
    end
    local function keybindSection(a49, a50)
        --[[
          name: keybindSection
          line: 1216
          upvalues:
            tbl_upv_23 (ref,  index: 1)
            u1 (ref,  index: 2)
            tbl_upv_21 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u32 (ref,  index: 5)
            closeCapture (copy, index: 6)
            Keybinds_upv_1 (copy, index: 7)
            SettingsStore_upv_1 (copy, index: 8)
            flashChips (copy, index: 9)
            u33 (ref,  index: 10)
            u34 (ref,  index: 11)
            Theme_upv_1 (copy, index: 12)
            Fonts_upv_1 (copy, index: 13)
            Colors_upv_1 (copy, index: 14)
            keyChip (copy, index: 15)
            paintKeybinds (copy, index: 16)
        ]]
        tbl_upv_23 = {}
        local kbHeader_1 = u1.kbHeader
        local v97 = #tbl_upv_21 * u1.kbRowH
        local v98 = UI_upv_1.new("Frame", {Name = "KEYBINDS", Size = UDim2.new(1, 0, 0, (kbHeader_1 + u1.titleGap) + v97), LayoutOrder = a50, Parent = a49})
        local v99 = u1.title + 8
        UI_upv_1.SectionTitle("CONTROLS", {Position = UDim2.fromOffset(0, kbHeader_1 - v99), Size = UDim2.new(1, 0, 0, v99), TextSize = u1.title, Parent = v98})
        local Button_1 = UI_upv_1.Button
        local tbl_30 = {Radius = 9, Parent = 0, Text = "RESET TO DEFAULTS", AnchorPoint = 0, Name = "ResetKeys", Position = 0, OnClick = 0, Style = "Dark", TextSize = 0, Size = 0}
        tbl_30.TextSize = ((UI_upv_1.Compact) and 16) or 14
        tbl_30.AnchorPoint = Vector2.new(1, 1)
        tbl_30.Position = UDim2.new(1, 0, 0, kbHeader_1)
        tbl_30.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 214) or 186, kbHeader_1 - 2)
        tbl_30.Parent = v98
        function tbl_30.OnClick()
            --[[
              name: OnClick
              line: 1243
              upvalues:
                closeCapture (copy, index: 1)
                Keybinds_upv_1 (copy, index: 2)
                SettingsStore_upv_1 (copy, index: 3)
                flashChips (copy, index: 4)
                u33 (ref,  index: 5)
                u34 (ref,  index: 6)
                UI_upv_1 (copy, index: 7)
                Theme_upv_1 (copy, index: 8)
            ]]
            closeCapture()
            local v100 = Keybinds_upv_1.ResetAll()
            if not (#v100 > 0) then
                return
            end
            SettingsStore_upv_1.SaveKeybinds(v100)
            for _, value_7 in v100 do
                flashChips(value_7)
            end
            local u49 = u33
            if not u49 then
                return
            end
            u34 = u34 + 1
            local u50 = u34
            u49.Text = "EVERY KEY IS BACK TO ITS DEFAULT"
            u49.TextTransparency = 0
            task.delay(
                4,
                function()
                    --[[
                      line: 758
                      upvalues:
                        u50 (copy, index: 1)
                        u34 (ref,  index: 2)
                        u49 (copy, index: 3)
                        UI_upv_1 (copy, index: 4)
                        Theme_upv_1 (copy, index: 5)
                    ]]
                    if u50 ~= u34 or not u49.Parent then
                        return
                    end
                    UI_upv_1.Tween(u49, Theme_upv_1.Tween.Smooth, {TextTransparency = 1})
                end
            )
        end
        u32 = Button_1(tbl_30)
        local new_4 = UI_upv_1.new
        local tbl_31 = {FontFace = 0, TextColor3 = 0, TextTransparency = 1, Text = "", Parent = 0, Name = "Notice", Position = 0, TextTruncate = 0, TextXAlignment = 0, TextSize = 0, Size = 0}
        tbl_31.AnchorPoint = Vector2.new(1, 1)
        tbl_31.Position = UDim2.new(1, -((((UI_upv_1.Compact) and 214) or 186) + 12), 0, kbHeader_1 - 4)
        tbl_31.Size = UDim2.new(1, -(((((UI_upv_1.Compact) and 214) or 186) + 12) + 150), 0, v99)
        tbl_31.FontFace = Fonts_upv_1.Heavy
        tbl_31.TextSize = ((UI_upv_1.Compact) and 15) or 13
        tbl_31.TextColor3 = Colors_upv_1.Warning
        tbl_31.TextXAlignment = Enum.TextXAlignment.Right
        tbl_31.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_31.Parent = v98
        u33 = new_4("TextLabel", tbl_31)
        local tbl_32 = {}
        tbl_32.Name = "Card"
        tbl_32.Position = UDim2.fromOffset(0, kbHeader_1 + u1.titleGap)
        tbl_32.Size = UDim2.new(1, 0, 0, v97)
        tbl_32.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_32.BackgroundTransparency = 0.3
        tbl_32[1], tbl_32[2], tbl_32[3] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92), UI_upv_1.List(Enum.FillDirection.Vertical, 0)
        tbl_32.Parent = v98
        local v101 = UI_upv_1.new("Frame", tbl_32)
        v97 = u1.chipW * 2 + u1.chipGap
        local v102 = nil
        for key_4, value_8 in tbl_upv_21 do
            local v103 = UI_upv_1.new("Frame", {Name = value_8.ids[1], Size = UDim2.new(1, 0, 0, u1.kbRowH), LayoutOrder = key_4, Parent = v101})
            if key_4 > 1 then
                UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = Colors_upv_1.Stroke, Position = UDim2.fromOffset(u1.pad, 0), Size = UDim2.new(1, -u1.pad * 2, 0, 1), Parent = v103})
            end
            UI_upv_1.new("TextLabel", {Name = "Label", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, u1.pad, 0.5, 0), Size = UDim2.new(1, -(((u1.pad * 2) + v97) + 12), 0, u1.label + 4), Text = value_8.label, FontFace = Fonts_upv_1.Heavy, TextSize = u1.label, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v103})
            local new_5 = UI_upv_1.new
            local tbl_33 = {}
            tbl_33.Name = "Keys"
            tbl_33.AnchorPoint = Vector2.new(1, 0.5)
            tbl_33.Position = UDim2.new(1, -u1.pad, 0.5, 0)
            tbl_33.Size = UDim2.fromOffset(v97, u1.chipH)
            local List_1 = UI_upv_1.List
            local Horizontal_1 = Enum.FillDirection.Horizontal
            if value_8.items then
                v102 = u1.itemGap
            else
                v102 = u1.chipGap
            end
            tbl_33[1] = List_1(Horizontal_1, v102, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
            tbl_33.Parent = v103
            local v104 = new_5("Frame", tbl_33)
            if value_8.items then
                local v105 = #value_8.ids
                local v106 = math.floor((v97 - ((v105 - 1) * u1.itemGap)) / v105)
                for key_5, value_9 in value_8.ids do
                    keyChip(v104, value_9, 1, v106, true, key_5)
                end
            else
                local v107 = Keybinds_upv_1.Action(value_8.ids[1])
                for n_1 = 1, v107.max do
                    keyChip(v104, v107.id, n_1, u1.chipW, false, n_1)
                end
            end
        end
        paintKeybinds()
        return v98
    end
    Keybinds_upv_1.Changed:Connect(paintKeybinds)
    local u51 = {}
    local u52 = {}
    local u53 = nil
    local u54 = nil
    local u55 = nil
    local u56 = nil
    local u57 = 0
    local u58 = UI_upv_1.new("Frame", {Name = "ChipSelection", Position = UDim2.fromOffset(-4, -4), Size = UDim2.new(1, 8, 1, 8), BackgroundTransparency = 1, UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)})
    local function padCode(a51)
        --[[
          name: padCode
          line: 1357
        ]]
        if not a51 then
            return nil
        end
        local success_1, v108 = pcall(function() end)
        if success_1 then
            return v108
        end
        return nil
    end
    local function padLabel(a52)
        --[[
          name: padLabel
          line: 1366
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
        ]]
        local v109 = Keybinds_upv_1.PadAction(a52)
        if v109 then
            return v109.label
        end
        return a52
    end
    local function paintPadChip(a53)
        --[[
          name: paintPadChip
          line: 1370
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v110 = Keybinds_upv_1.PadGet(a53.id)[a53.slot]
        local SetCapPad_1 = UI_upv_1.SetCapPad
        local cap_1 = a53.cap
        local v111
        if v110 then
            local success_2, v112 = pcall(function() end)
            if success_2 then
                v111 = v112
            else
                v111 = nil
            end
        else
            v111 = nil
        end
        SetCapPad_1(cap_1, v111)
        a53.dash.Visible = v110 == nil
        a53.button.BackgroundTransparency = (v110 and 0.35) or 0.72
        a53.stroke.Transparency = (v110 and 0.8) or 0.9
    end
    local function firstPadChip()
        --[[
          name: firstPadChip
          line: 1377
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            u51 (ref,  index: 2)
        ]]
        local v113 = Keybinds_upv_1.PAD_ACTIONS[1]
        local v114 = v113 and (u51[v113.id])
        if v114 and #v114 > 0 then
            return v114[#v114].button
        end
        return nil
    end
    local function paintPadBinds()
        --[[
          name: paintPadBinds
          line: 1382
          upvalues:
            u51 (ref,  index: 1)
            Keybinds_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u53 (ref,  index: 4)
            GuiService_upv_1 (copy, index: 5)
            u9 (ref,  index: 6)
        ]]
        local v115 = nil
        local v116 = nil
        for _, value_10 in u51 do
            for v122, value_11 in value_10 do
                v116 = Keybinds_upv_1.PadGet(value_11.id)[value_11.slot]
                local SetCapPad_2 = UI_upv_1.SetCapPad
                local cap_2 = value_11.cap
                if not (v116) then
                    v115 = nil
                    SetCapPad_2(cap_2, v115)
                    value_11.dash.Visible = v116 == nil
                    value_11.button.BackgroundTransparency = (v116 and 0.35) or 0.72
                    value_11.stroke.Transparency = (v116 and 0.8) or 0.9
                    continue
                end
                local success_3, v117 = pcall(function() end)
                if success_3 then
                    v115 = v117
                else
                    v115 = nil
                end
                SetCapPad_2(cap_2, v115)
                value_11.dash.Visible = v116 == nil
                value_11.button.BackgroundTransparency = (v116 and 0.35) or 0.72
                value_11.stroke.Transparency = (v116 and 0.8) or 0.9
            end
        end
        if u53 then
            local v118 = not Keybinds_upv_1.PadAllDefault()
            u53:SetEnabled(v118)
            u53.Instance.Selectable = v118
            if (v118) then
                return
            end
            if GuiService_upv_1.SelectedObject == u53.Instance then
                local v119 = Keybinds_upv_1.PAD_ACTIONS[1]
                local v120 = v119 and (u51[v119.id])
                GuiService_upv_1.SelectedObject = not (v120) or not (#v120 > 0) or v120[#v120].button or u9
            end
        end
    end
    local function flashPadChips(a54)
        --[[
          name: flashPadChips
          line: 1398
          upvalues:
            u51 (ref,  index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Void_upv_1 (copy, index: 4)
            Keybinds_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v122 = u51[a54] or {}
        for _, value_upv_12 in v122 do
            value_upv_12.button.BackgroundColor3 = Colors_upv_1.AccentDark
            value_upv_12.button.BackgroundTransparency = 0.05
            UI_upv_1.Tween(value_upv_12.button, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Void_upv_1})
            task.delay(
                0.7,
                function()
                    --[[
                      line: 1403
                      upvalues:
                        value_upv_12 (copy, index: 1)
                        Keybinds_upv_1 (copy, index: 2)
                        UI_upv_1 (copy, index: 3)
                    ]]
                    if value_upv_12.button.Parent then
                        local v123 = Keybinds_upv_1.PadGet(value_upv_12.id)[value_upv_12.slot]
                        local SetCapPad_3 = UI_upv_1.SetCapPad
                        local cap_3 = value_upv_12.cap
                        local v124
                        if v123 then
                            local success_4, v125 = pcall(function() end)
                            if success_4 then
                                v124 = v125
                            else
                                v124 = nil
                            end
                        else
                            v124 = nil
                        end
                        SetCapPad_3(cap_3, v124)
                        value_upv_12.dash.Visible = v123 == nil
                        value_upv_12.button.BackgroundTransparency = (v123 and 0.35) or 0.72
                        value_upv_12.stroke.Transparency = (v123 and 0.8) or 0.9
                    end
                end
            )
            UI_upv_1.Pop(value_upv_12.button, 0.25, Theme_upv_1.Tween.PopSmall)
        end
    end
    local function padNote(a55, a56)
        --[[
          name: padNote
          line: 1412
          upvalues:
            u54 (ref,  index: 1)
            u55 (ref,  index: 2)
            u56 (ref,  index: 3)
            u57 (ref,  index: 4)
            UI_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local u59 = u54
        local u60 = u55
        local u61 = u56
        if not u59 or not u60 then
            return
        end
        if u61 then
            u57 = u57 + 1
            local u62 = u57
            u60.Text = a55
            u60.TextTransparency = 0
            UI_upv_1.SetCapFade(u61, 0)
            UI_upv_1.SetCapPad(u61, a56)
            u59.Visible = true
            u59.BackgroundTransparency = 0.1
            UI_upv_1.Pop(u59, 0.85, Theme_upv_1.Tween.PopSmall)
            task.delay(
                4,
                function()
                    --[[
                      line: 1426
                      upvalues:
                        u62 (copy, index: 1)
                        u57 (ref,  index: 2)
                        u59 (copy, index: 3)
                        UI_upv_1 (copy, index: 4)
                        u60 (copy, index: 5)
                        Theme_upv_1 (copy, index: 6)
                        u61 (copy, index: 7)
                    ]]
                    if u62 ~= u57 or not u59.Parent then
                        return
                    end
                    UI_upv_1.Tween(u60, Theme_upv_1.Tween.Smooth, {TextTransparency = 1})
                    UI_upv_1.Tween(u59, Theme_upv_1.Tween.Smooth, {BackgroundTransparency = 1})
                    UI_upv_1.SetCapFade(u61, 0.6)
                    task.delay(
                        0.35,
                        function()
                            --[[
                              line: 1431
                              upvalues:
                                u62 (copy, index: 1)
                                u57 (ref,  index: 2)
                                u59 (copy, index: 3)
                            ]]
                            if u62 ~= u57 or not u59.Parent then
                                return
                            end
                            u59.Visible = false
                        end
                    )
                end
            )
        end
    end
    local function openPadCapture(a57, a58, a59)
        --[[
          name: openPadCapture
          line: 1465
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            u36 (ref,  index: 2)
            buildCapture (copy, index: 3)
            u37 (ref,  index: 4)
            GuiService_upv_1 (copy, index: 5)
            u38 (ref,  index: 6)
            a1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            u39 (ref,  index: 10)
        ]]
        local v126 = Keybinds_upv_1.PadAction(a57)
        if not v126 then
            return
        end
        if not (u36) then
            u36 = buildCapture()
        end
        local v127 = u36
        local v128 = Keybinds_upv_1.PadGet(a57)
        local v129 = math.clamp(a58, 1, math.min(v126.max, #v128 + 1))
        local tbl_34 = {pad = true, at = 0, sel = 0}
        tbl_34.id = a57
        tbl_34.slot = v129
        tbl_34.sel = a59 or (GuiService_upv_1.SelectedObject)
        tbl_34.at = os.clock()
        u37 = tbl_34
        u38 = u38 + 1
        a1.PadCapturing = true
        v127.eyebrow.Text = ((v129 > 1) and "SECOND BUTTON FOR") or "REBIND"
        v127.title.Text = v126.label
        local v130 = v128[v129]
        a1.Loc.Rich(v127.now, "NOT BOUND")
        v127.now.Visible = v130 == nil
        v127.nowPad.Visible = v130 ~= nil
        local SetCapPad_4 = UI_upv_1.SetCapPad
        local nowCap_1 = v127.nowCap
        local v131
        if v130 then
            local success_5, v132 = pcall(function() end)
            if success_5 then
                v131 = v132
            else
                v131 = nil
            end
        else
            v131 = nil
        end
        SetCapPad_4(nowCap_1, v131)
        UI_upv_1.SetCapPad(v127.holdCap, Enum.KeyCode.ButtonB)
        v127.hold.Visible = false
        v127.holdFill.Size = UDim2.fromScale(0, 1)
        v127.clear.Instance.Visible = false
        v127.cancel.Instance.Visible = false
        v127.card.Size = UDim2.fromOffset(480, 262)
        local v133 = false
        if u37 ~= nil then
            if u37.pad == true then
                local _ = true
            else
                local _ = false
            end
        end
        local line1_4 = u36.line1
        line1_4.Text = (v133 and "PRESS A BUTTON") or "PRESS A KEY"
        u36.line1.TextColor3 = Colors_upv_1.Text
        u36.line2.Text = "or click here with a mouse button"
        u36.line2.Visible = not v133
        u36.holdHint.Visible = v133
        u36.padStroke.Color = Colors_upv_1.Accent
        v127.layer.Visible = true
        UI_upv_1.Enter(v127.card, Vector2.new(0, 14), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Click")
        u39 = nil
        GuiService_upv_1.SelectedObject = nil
    end
    local function noteMoves(a60)
        --[[
          name: noteMoves
          line: 1441
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            padNote (copy, index: 2)
        ]]
        if #a60 == 0 then
            return
        end
        local v134 = a60[1].now[1]
        local tbl_35 = {}
        local id_1 = a60[1].id
        local v135 = Keybinds_upv_1.PadAction(id_1)
        local v136
        if v135 then
            v136 = v135.label
        else
            v136 = id_1
        end
        tbl_35[1] = v136
        local v137 = 0
        v136 = v137
        for n_2 = 2, #a60 do
            if a60[n_2].now[1] ~= v134 then
                v136 = v136 + 1
                continue
            end
            local id_2 = a60[n_2].id
            local v138 = Keybinds_upv_1.PadAction(id_2)
            local v139
            if v138 then
                v139 = v138.label
            else
                v139 = id_2
            end
            table.insert(tbl_35, v139)
        end
        local v140 = table.concat(tbl_35, " AND ")
        local v141 = ((not (v136 > 0)) and "") or (string.format(" (+%d)", v136))
        local v142 = v140 .. v141
        v136 = #tbl_35 > 1
        if v134 ~= nil then
            local v143 = string.format("SWAPPED \194\183 %s NOW %s", v142, (v136 and "USE") or "USES")
            local v144
            if v134 then
                local success_6, v145 = pcall(function() end)
                if success_6 then
                    v144 = v145
                else
                    v144 = nil
                end
            else
                v144 = nil
            end
            padNote(v143, v144)
        else
            padNote(string.format("%s %s NOW UNBOUND", v142, (v136 and "ARE") or "IS"), nil)
        end
    end
    local function padCommit(a61)
        --[[
          name: padCommit
          line: 1501
          upvalues:
            u37 (ref,  index: 1)
            closeCapture (copy, index: 2)
            Keybinds_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            SettingsStore_upv_1 (copy, index: 5)
            flashPadChips (copy, index: 6)
            noteMoves (copy, index: 7)
        ]]
        if not u37 or not u37.pad then
            return
        end
        closeCapture()
        local v146, v147 = Keybinds_upv_1.PadAssign(u37.id, u37.slot, a61)
        if #v146 ~= 0 then
            SettingsStore_upv_1.SavePadBinds(v146)
            a1.Sounds.Play("Select")
            for _, value_13 in v146 do
                flashPadChips(value_13)
            end
            noteMoves(v147)
        else
            a1.Sounds.Play("Click")
        end
    end
    local function padUnbind(a62)
        --[[
          name: padUnbind
          line: 1520
          upvalues:
            Keybinds_upv_1 (copy, index: 1)
            SettingsStore_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            flashPadChips (copy, index: 4)
            padNote (copy, index: 5)
        ]]
        if not Keybinds_upv_1.PadGet(a62.id)[a62.slot] then
            return
        end
        Keybinds_upv_1.PadClear(a62.id, a62.slot)
        SettingsStore_upv_1.SavePadBinds({a62.id})
        a1.Sounds.Play("Click", {pitch = 0.9})
        flashPadChips(a62.id)
        local v148 = Keybinds_upv_1.PadGet(a62.id)
        local v149, v150 = nil, nil
        if #v148 ~= 0 then
            local format_1 = string.format
            local id_3 = a62.id
            v149 = Keybinds_upv_1.PadAction(id_3)
            local v151
            if v149 then
                v151 = v149.label
            else
                v151 = id_3
            end
            format_1 = format_1("%s NOW USES", v151)
            local v152 = v148[1]
            local v153
            if v152 then
                local id_3, v154 = pcall(function() end)
                if id_3 then
                    v153 = v154
                else
                    v153 = nil
                end
            else
                v153 = nil
            end
            padNote(format_1, v153)
        else
            local format_2 = string.format
            local id_4 = a62.id
            v150 = Keybinds_upv_1.PadAction(id_4)
            local v151
            if v150 then
                v151 = v150.label
            else
                v151 = id_4
            end
            padNote(format_2("%s IS NOW UNBOUND", v151), nil)
        end
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a63)
            --[[
              line: 1538
              upvalues:
                u37 (ref,  index: 1)
                u4 (copy, index: 2)
                UI_upv_1 (copy, index: 3)
                GuiService_upv_1 (copy, index: 4)
                u52 (ref,  index: 5)
                padUnbind (copy, index: 6)
                closeCapture (copy, index: 7)
                u36 (ref,  index: 8)
                a1 (copy, index: 9)
                Keybinds_upv_1 (copy, index: 10)
                refuse (copy, index: 11)
                Colors_upv_1 (copy, index: 12)
            ]]
            local UserInputType_2 = a63.UserInputType
            local KeyCode_1 = a63.KeyCode
            local v155 = string.sub(UserInputType_2.Name, 1, 7) == "Gamepad"
            local u63 = u37
            if u63 then
                if u63.pad and u4.IsOpen then
                    if UserInputType_2 ~= Enum.UserInputType.Keyboard then
                        if v155 and KeyCode_1 ~= Enum.KeyCode.Unknown and string.sub(KeyCode_1.Name, 1, 10) ~= "Thumbstick" then
                            if not (os.clock() - u63.at < 0.15) and not (u63.down) then
                                local Name_2 = KeyCode_1.Name
                                local u64 = u36
                                if Name_2 ~= "ButtonB" then
                                    local v156, v157 = Keybinds_upv_1.PadBindable(Name_2)
                                    if v156 then
                                        u63.down = Name_2
                                        u64.padStroke.Color = Colors_upv_1.Text
                                    else
                                        refuse(v157 or "That button can't be used")
                                    end
                                else
                                    local v158 = os.clock()
                                    u63.down = Name_2
                                    u63.bAt = v158
                                    u64.hold.Visible = true
                                    task.spawn(
                                        function()
                                            --[[
                                              line: 1575
                                              upvalues:
                                                u37 (ref,  index: 1)
                                                u63 (copy, index: 2)
                                                u64 (copy, index: 3)
                                                a1 (copy, index: 4)
                                                closeCapture (copy, index: 5)
                                            ]]
                                            while u37 == u63 and (u63.bAt) do
                                                local v159 = (os.clock() - u63.bAt) / 0.6
                                                u64.holdFill.Size = UDim2.fromScale(math.clamp(v159, 0, 1), 1)
                                                if not (v159 >= 1) then
                                                    task.wait()
                                                    continue
                                                end
                                                a1.Sounds.Play("Close")
                                                closeCapture()
                                                return
                                            end
                                        end
                                    )
                                end
                                return
                            end
                            return
                        end
                    elseif KeyCode_1 ~= Enum.KeyCode.Unknown then
                        closeCapture()
                    end
                    return
                end
            elseif v155 and KeyCode_1 == Enum.KeyCode.ButtonX and u4.IsOpen and UI_upv_1.Gamepad then
                local SelectedObject_1 = GuiService_upv_1.SelectedObject
                local v160 = SelectedObject_1 and (u52[SelectedObject_1])
                if v160 then
                    padUnbind(v160)
                end
            end
        end
    )
    Keybinds_upv_1.OnInput(
        "Ended",
        function(a64)
            --[[
              line: 1597
              upvalues:
                u37 (ref,  index: 1)
                padCommit (copy, index: 2)
            ]]
            local Name_3 = a64.KeyCode.Name
            if not u37 or not u37.pad or u37.down ~= Name_3 then
                return
            end
            if Name_3 == "ButtonB" then
                local v161 = os.clock()
                local v162 = u37.bAt or (os.clock())
                u37.bAt = nil
                if v161 - v162 >= 0.6 then
                    return
                end
            end
            padCommit(Name_3)
        end
    )
    local function padChip(a65, a66, a67, a68)
        --[[
          name: padChip
          line: 1613
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            Void_upv_1 (copy, index: 3)
            u58 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            Keybinds_upv_1 (copy, index: 8)
            u37 (ref,  index: 9)
            u40 (ref,  index: 10)
            openPadCapture (copy, index: 11)
            u51 (ref,  index: 12)
            u52 (ref,  index: 13)
        ]]
        local u65 = UI_upv_1.new("TextButton", {Name = a66 .. "_" .. a67, Size = UDim2.fromOffset(u1.chipW, u1.chipH), BackgroundColor3 = Void_upv_1, BackgroundTransparency = 0.35, AutoButtonColor = false, Text = "", Selectable = true, SelectionImageObject = u58, LayoutOrder = a68, [1] = UI_upv_1.Corner(8), Parent = a65})
        local u66 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.8)
        u66.Parent = u65
        local tbl_36 = {}
        tbl_36.button = u65
        tbl_36.cap = UI_upv_1.PadCap(Enum.KeyCode.ButtonA, {ZIndex = 2, Height = u1.chipH - 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u65})
        tbl_36.dash = UI_upv_1.new("TextLabel", {Visible = false, Text = "\226\128\148", Name = "Empty", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -10, 0, u1.chipText + 2), FontFace = Fonts_upv_1.Heavy, TextSize = u1.chipText, TextColor3 = Colors_upv_1.TextMuted, Parent = u65})
        tbl_36.stroke = u66
        tbl_36.id = a66
        tbl_36.slot = a67
        u65.MouseEnter:Connect(
            function()
                --[[
                  line: 1649
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u66 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(u66, Theme_upv_1.Tween.Fast, {Transparency = 0.1, Color = Colors_upv_1.Accent})
            end
        )
        u65.MouseLeave:Connect(
            function()
                --[[
                  line: 1652
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u66 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                    Keybinds_upv_1 (copy, index: 5)
                    a66 (copy, index: 6)
                    a67 (copy, index: 7)
                ]]
                local Tween_2 = UI_upv_1.Tween
                local Fast_2 = Theme_upv_1.Tween.Fast
                local tbl_37 = {Transparency = 0}
                tbl_37.Color = Colors_upv_1.Stroke
                tbl_37.Transparency = Keybinds_upv_1.PadGet(a66)[a67] and 0.8 or 0.9
                Tween_2(u66, Fast_2, tbl_37)
            end
        )
        u65.Activated:Connect(
            function()
                --[[
                  line: 1655
                  upvalues:
                    u37 (ref,  index: 1)
                    u40 (ref,  index: 2)
                    openPadCapture (copy, index: 3)
                    a66 (copy, index: 4)
                    a67 (copy, index: 5)
                    u65 (copy, index: 6)
                ]]
                if (u37) or (os.clock() < u40) then
                    return
                end
                openPadCapture(a66, a67, u65)
            end
        )
        u51[a66] = u51[a66] or {}
        table.insert(u51[a66], tbl_36)
        u52[u65] = tbl_36
        local u67 = Keybinds_upv_1.PadGet(tbl_36.id)[tbl_36.slot]
        local SetCapPad_5 = UI_upv_1.SetCapPad
        local cap_4 = tbl_36.cap
        local v165
        if u67 then
            local success_7, v166 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        u67 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[u67]
                end
            )
            if success_7 then
                v165 = v166
            else
                v165 = nil
            end
        else
            v165 = nil
        end
        SetCapPad_5(cap_4, v165)
        tbl_36.dash.Visible = u67 == nil
        tbl_36.button.BackgroundTransparency = (u67 and 0.35) or 0.72
        tbl_36.stroke.Transparency = (u67 and 0.8) or 0.9
        return tbl_36
    end
    local function padSection(a69, a70)
        --[[
          name: padSection
          line: 1668
          upvalues:
            u51 (ref,  index: 1)
            u52 (ref,  index: 2)
            u1 (ref,  index: 3)
            Keybinds_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u53 (ref,  index: 6)
            u37 (ref,  index: 7)
            closeCapture (copy, index: 8)
            SettingsStore_upv_1 (copy, index: 9)
            flashPadChips (copy, index: 10)
            padNote (copy, index: 11)
            addNav (copy, index: 12)
            u20 (ref,  index: 13)
            textBlock (copy, index: 15)
            padChip (copy, index: 16)
            u8 (ref,  index: 17)
            Fonts_upv_1 (copy, index: 18)
            u3 (copy, index: 19)
            paintPadBinds (copy, index: 20)
        ]]
        local tbl_38 = {}
        local tbl_39 = {}
        u51 = tbl_38
        u52 = tbl_39
        local kbHeader_2 = u1.kbHeader
        local v167 = #Keybinds_upv_1.PAD_ACTIONS * u1.rowH
        local v168 = UI_upv_1.new("Frame", {Name = "CONTROLLER", Size = UDim2.new(1, 0, 0, ((kbHeader_2 + u1.titleGap) + v167) + (u1.desc + 22)), LayoutOrder = a70, Parent = a69})
        local v169 = u1.title + 8
        UI_upv_1.SectionTitle("CONTROLLER", {Position = UDim2.fromOffset(0, kbHeader_2 - v169), Size = UDim2.new(1, 0, 0, v169), TextSize = u1.title, Parent = v168})
        local v170 = ((UI_upv_1.Compact) and 214) or 186
        local Button_2 = UI_upv_1.Button
        local tbl_40 = {Radius = 9, Parent = 0, Text = "RESET TO DEFAULTS", AnchorPoint = 0, Name = "ResetPad", Position = 0, OnClick = 0, Style = "Dark", TextSize = 0, Size = 0}
        tbl_40.TextSize = ((UI_upv_1.Compact) and 16) or 14
        tbl_40.AnchorPoint = Vector2.new(1, 1)
        tbl_40.Position = UDim2.new(1, 0, 0, kbHeader_2)
        tbl_40.Size = UDim2.fromOffset(v170, kbHeader_2 - 2)
        tbl_40.Parent = v168
        function tbl_40.OnClick()
            --[[
              name: OnClick
              line: 1697
              upvalues:
                u37 (ref,  index: 1)
                closeCapture (copy, index: 2)
                Keybinds_upv_1 (copy, index: 3)
                SettingsStore_upv_1 (copy, index: 4)
                flashPadChips (copy, index: 5)
                padNote (copy, index: 6)
            ]]
            if u37 then
                closeCapture()
            end
            local v171 = Keybinds_upv_1.PadResetAll()
            if not (#v171 > 0) then
                return
            end
            SettingsStore_upv_1.SavePadBinds(v171)
            for _, value_14 in v171 do
                flashPadChips(value_14)
            end
            padNote("EVERY BUTTON IS BACK TO ITS DEFAULT", nil)
        end
        u53 = Button_2(tbl_40)
        addNav({u53.Instance})
        u20[u53.Instance] = v168
        local tbl_41 = {}
        tbl_41.Name = "Card"
        tbl_41.Position = UDim2.fromOffset(0, kbHeader_2 + u1.titleGap)
        tbl_41.Size = UDim2.new(1, 0, 0, v167)
        tbl_41.BackgroundColor3 = legendText_1.PanelHi
        tbl_41.BackgroundTransparency = 0.3
        tbl_41[1], tbl_41[2], tbl_41[3] = UI_upv_1.Corner(12), UI_upv_1.Stroke(legendText_1.Stroke, 1, 0.92), UI_upv_1.List(Enum.FillDirection.Vertical, 0)
        tbl_41.Parent = v168
        local v172 = UI_upv_1.new("Frame", tbl_41)
        local v173 = u1.chipW * 2 + u1.chipGap
        for key_6, value_15 in Keybinds_upv_1.PAD_ACTIONS do
            local v174 = UI_upv_1.new("Frame", {Name = value_15.id, Size = UDim2.new(1, 0, 0, u1.rowH), LayoutOrder = key_6, Parent = v172})
            if key_6 > 1 then
                UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = legendText_1.Stroke, Position = UDim2.fromOffset(u1.pad, 0), Size = UDim2.new(1, -u1.pad * 2, 0, 1), Parent = v174})
            end
            local v175 = UI_upv_1.new("Frame", {Name = "Highlight", BackgroundColor3 = legendText_1.White, BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), [1] = UI_upv_1.Corner(9), Parent = v174})
            textBlock(v174, {kind = "padbind", label = value_15.label, desc = value_15.desc}, v173)
            local v176 = UI_upv_1.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -u1.pad, 0.5, 0), Size = UDim2.fromOffset(v173, u1.chipH), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, u1.chipGap, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v174})
            local tbl_42 = {}
            for n_3 = 1, value_15.max do
                local v177 = padChip(v176, value_15.id, n_3, n_3)
                u8[v177.button] = v175
                table.insert(tbl_42, v177.button)
            end
            addNav(tbl_42, tbl_42[#tbl_42])
            if key_6 == 1 then
                u20[tbl_42[#tbl_42]] = v168
            end
        end
        local u68 = UI_upv_1.new("Frame", {Name = "Legend", Position = UDim2.fromOffset(u1.pad, ((kbHeader_2 + u1.titleGap) + v167) + 10), Size = UDim2.new(1, -u1.pad * 2, 0, u1.desc + 6), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v168})
        local function legendText_1(a71, a72, a73)
            --[[
              name: legendText
              line: 1780
              upvalues:
                UI_upv_1 (copy, index: 1)
                Fonts_upv_1 (copy, index: 2)
                u1 (ref,  index: 3)
                u3 (copy, index: 5)
                u68 (copy, index: 6)
            ]]
            local new_6 = UI_upv_1.new
            local v178 = "TextLabel"
            local tbl_43 = {LayoutOrder = 0, FontFace = 0, TextColor3 = 0, Parent = 0, AutomaticSize = 0, TextSize = 0, Size = 0}
            tbl_43.Name = "T" .. a72
            tbl_43.Text = a71
            local v179
            if a73 then
                v179 = Fonts_upv_1.Heavy
            else
                v179 = Fonts_upv_1.SemiBold
            end
            tbl_43.FontFace = v179
            tbl_43.TextSize = u1.desc
            local v180
            if a73 then
                v180 = Colors_upv_1.TextDim
            else
                v180 = u3
            end
            tbl_43.TextColor3 = v180
            tbl_43.AutomaticSize = Enum.AutomaticSize.X
            tbl_43.Size = UDim2.fromOffset(0, u1.desc + 4)
            tbl_43.LayoutOrder = a72
            tbl_43.Parent = u68
            new_6(v178, tbl_43)
        end
        UI_upv_1.PadCap(Enum.KeyCode.ButtonA, {LayoutOrder = 1, Height = u1.desc + 6, Parent = u68})
        legendText_1("CHANGE", 2, true)
        legendText_1("  ", 3, false)
        UI_upv_1.PadCap(Enum.KeyCode.ButtonX, {LayoutOrder = 4, Height = u1.desc + 6, Parent = u68})
        legendText_1("UNBIND", 5, true)
        legendText_1("   \194\183   Menu buttons can't be changed", 6, false)
        paintPadBinds()
        return v168
    end
    Keybinds_upv_1.PadChanged:Connect(paintPadBinds)
    local function updateFade()
        --[[
          name: updateFade
          line: 1805
          upvalues:
            u10 (ref, index: 1)
            u11 (ref, index: 2)
        ]]
        local v181 = u11
        if not u10 or not v181 then
            return
        end
        u11.Visible = (u10.AbsoluteCanvasSize.Y - (u10.CanvasPosition.Y + u10.AbsoluteWindowSize.Y)) > 2
    end
    local function build()
        --[[
          name: build
          line: 1814
          upvalues:
            Content_upv_1 (copy, index: 1)
            u5 (ref,  index: 2)
            u6 (ref,  index: 3)
            u7 (ref,  index: 4)
            u8 (ref,  index: 5)
            u9 (ref,  index: 6)
            u24 (ref,  index: 7)
            u15 (ref,  index: 8)
            u19 (ref,  index: 9)
            u20 (ref,  index: 10)
            tbl_upv_10 (ref,  index: 11)
            u39 (ref,  index: 12)
            closeCapture (copy, index: 13)
            u36 (ref,  index: 14)
            tbl_upv_23 (ref,  index: 15)
            u32 (ref,  index: 16)
            u33 (ref,  index: 17)
            u51 (ref,  index: 18)
            u52 (ref,  index: 19)
            u53 (ref,  index: 20)
            u54 (ref,  index: 21)
            u55 (ref,  index: 22)
            u56 (ref,  index: 23)
            u1 (ref,  index: 24)
            UI_upv_1 (copy, index: 25)
            tbl_upv_9 (copy, index: 26)
            u1 (copy, index: 27)
            u13 (ref,  index: 28)
            a1 (copy, index: 29)
            UserInputService_upv_1 (copy, index: 30)
            u22 (ref,  index: 31)
            u10 (ref,  index: 32)
            tbl_upv_8 (copy, index: 33)
            keybindSection (copy, index: 34)
            padSection (copy, index: 35)
            Colors_upv_1 (copy, index: 36)
            sliderRow (copy, index: 37)
            switchRow (copy, index: 38)
            actionRow (copy, index: 39)
            u14 (ref,  index: 40)
            u11 (ref,  index: 41)
            updateFade (copy, index: 42)
            SettingsStore_upv_1 (copy, index: 43)
            u12 (ref,  index: 44)
            State_upv_1 (copy, index: 45)
            u17 (ref,  index: 46)
            openConfirm (copy, index: 47)
            Theme_upv_1 (copy, index: 48)
            Fonts_upv_1 (copy, index: 49)
            tbl_upv_12 (ref,  index: 50)
        ]]
        for _, value_16 in Content_upv_1:GetChildren() do
            if not (value_16:IsA("UIPadding")) then
                value_16:Destroy()
            end
        end
        local tbl_44 = {}
        local tbl_45 = {}
        local tbl_46 = {}
        local tbl_47 = {}
        u5 = tbl_44
        u6 = tbl_45
        u7 = tbl_46
        u8 = tbl_47
        u9 = nil
        u24 = nil
        u15 = nil
        local tbl_48 = {}
        local tbl_49 = {}
        u19 = tbl_48
        u20 = tbl_49
        tbl_upv_10 = nil
        u39 = nil
        closeCapture()
        if u36 then
            u36.layer:Destroy()
            u36 = nil
        end
        tbl_upv_23 = {}
        u32 = nil
        u33 = nil
        local tbl_50 = {}
        local tbl_51 = {}
        u51 = tbl_50
        u52 = tbl_51
        u53 = nil
        u54 = nil
        u55 = nil
        u56 = nil
        local v182
        if UI_upv_1.Compact then
            v182 = tbl_upv_9
        else
            v182 = u1
        end
        u1 = v182
        local v183 = ((UI_upv_1.Compact) and "c") or "d"
        local v184 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
        local v185 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
        local v186 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        local v187
        if v186 then
            v187 = "a"
        else
            v187 = ""
        end
        u13 = v183 .. v184 .. v185 .. v187 .. (((UI_upv_1.Gamepad) and "p") or "")
        local v188 = UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)
        local v189 = not UI_upv_1.Touch
        local _ = v189 and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))
        local v190 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        local v191 = v182.footerTop + v182.footerBtn
        local v192 = UI_upv_1.new("ScrollingFrame", {Name = "Scroll", ScrollBarThickness = 5, Selectable = false, Size = UDim2.new(1, 14, 1, -(v191 + 14)), AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = Content_upv_1})
        u10 = v192
        local v193 = UI_upv_1.new("Frame", {Name = "List", Size = UDim2.new(1, -14, 1, 0), [1] = UI_upv_1.List(Enum.FillDirection.Vertical, v182.sectionGap), Parent = v192})
        local u69 = 0
        local v194 = 0
        for key_7, value_17 in tbl_upv_8 do
            if value_17.touchOnly and (v188) and value_17.keyboardOnly and (v189) and value_17.staging and (a1.ReplayNewPlayer) or value_17.touchOnly and (v188) and value_17.keyboardOnly and (v189) and not value_17.staging or value_17.touchOnly and (v188) and not value_17.keyboardOnly and value_17.staging and (a1.ReplayNewPlayer) or value_17.touchOnly and (v188) and not value_17.keyboardOnly and not value_17.staging
                or not value_17.touchOnly and value_17.keyboardOnly and (v189) and value_17.staging and (a1.ReplayNewPlayer) or not value_17.touchOnly and value_17.keyboardOnly and (v189) and not value_17.staging or not value_17.touchOnly and not value_17.keyboardOnly and value_17.staging and (a1.ReplayNewPlayer) or not value_17.touchOnly and not value_17.keyboardOnly and not value_17.staging then
                if value_17.keybinds then
                    u69, v194 = u69 + keybindSection(v193, key_7).Size.Y.Offset, v194 + 1
                    continue
                end
                if value_17.padbinds then
                    if UI_upv_1.Gamepad then
                        u69, v194 = u69 + padSection(v193, key_7).Size.Y.Offset, v194 + 1
                    end
                else
                    local tbl_52 = {}
                    local Gamepad_1 = UI_upv_1.Gamepad
                    for v203, value_18 in value_17.items do
                        if (v190 or not (value_18.assistOnly)) and (Gamepad_1 or not (value_18.padOnly)) and (not (Gamepad_1) or not (value_18.notPad)) then
                            table.insert(tbl_52, value_18)
                        end
                    end
                    local v195 = #tbl_52 * v182.rowH
                    local v196 = v182.title + 8
                    local v197 = UI_upv_1.new("Frame", {Name = value_17.title, Size = UDim2.new(1, 0, 0, (v196 + v182.titleGap) + v195), LayoutOrder = key_7, Parent = v193})
                    UI_upv_1.SectionTitle(value_17.title, {Size = UDim2.new(1, 0, 0, v196), TextSize = v182.title, Parent = v197})
                    local tbl_53 = {}
                    tbl_53.Name = "Card"
                    tbl_53.Position = UDim2.fromOffset(0, v196 + v182.titleGap)
                    tbl_53.Size = UDim2.new(1, 0, 0, v195)
                    tbl_53.BackgroundColor3 = Colors_upv_1.PanelHi
                    tbl_53.BackgroundTransparency = 0.3
                    tbl_53[1], tbl_53[2], tbl_53[3] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92), UI_upv_1.List(Enum.FillDirection.Vertical, 0)
                    tbl_53.Parent = v197
                    local v198 = UI_upv_1.new("Frame", tbl_53)
                    v196 = #u19
                    for key_8, value_19 in tbl_52 do
                        if value_19.kind == "slider" then
                            sliderRow(v198, key_8, value_19)
                            continue
                        end
                        if value_19.kind ~= "switch" then
                            actionRow(v198, key_8, value_19)
                        else
                            switchRow(v198, key_8, value_19)
                        end
                    end
                    v198 = u19[v196 + 1]
                    if v198 then
                        u20[v198.land] = v197
                    end
                    u69, v194 = u69 + v197.Size.Y.Offset, v194 + 1
                end
            end
        end
        local v199 = u69 + ((math.max(0, v194 - 1) * v182.sectionGap) + 4)
        v192.CanvasSize = UDim2.fromOffset(0, v199)
        u14 = (((v199 + 92) + 14) + v191) + 18
        v194 = UI_upv_1.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -(v191 + 14)), Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Colors_upv_1.PanelLo, ZIndex = 4, Visible = false, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05)), Parent = Content_upv_1})
        u11 = v194
        v192:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
        v192:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
        v192:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
        v194 = UI_upv_1.new("Frame", {Name = "Footer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, v191), Parent = Content_upv_1})
        UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.92, BackgroundColor3 = Colors_upv_1.Stroke, Size = UDim2.new(1, 0, 0, 1), Parent = v194})
        local Button_3 = UI_upv_1.Button
        local tbl_54 = {Parent = 0, Text = "DEFAULTS", Name = "Reset", OnClick = 0, Style = "Dark", Size = 0}
        tbl_54.TextSize = v182.button
        tbl_54.AnchorPoint = Vector2.new(0, 1)
        tbl_54.Position = UDim2.fromScale(0, 1)
        tbl_54.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 210) or 190, v182.footerBtn)
        tbl_54.Parent = v194
        function tbl_54.OnClick()
            --[[
              name: OnClick
              line: 1968
              upvalues:
                SettingsStore_upv_1 (copy, index: 1)
            ]]
            for key_9, value_20 in SettingsStore_upv_1.DEFAULTS do
                if not (SettingsStore_upv_1.MEMORY[key_9]) then
                    SettingsStore_upv_1.Set(key_9, value_20, true)
                end
            end
        end
        u69 = Button_3(tbl_54)
        local Button_4 = UI_upv_1.Button
        tbl_54 = {Visible = 0, Parent = 0, Text = "LEAVE MATCH", Name = "LeaveMatch", Style = "Danger", Size = 0}
        tbl_54.TextSize = v182.button
        tbl_54.AnchorPoint = Vector2.new(1, 1)
        tbl_54.Position = UDim2.fromScale(1, 1)
        tbl_54.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 250) or 230, v182.footerBtn)
        tbl_54.Visible = State_upv_1.InMatch()
        tbl_54.Parent = v194
        u12 = Button_4(tbl_54)
        u17 = false
        u12.Activated:Connect(openConfirm)
        tbl_upv_10 = {items = {u69.Instance, u12.Instance}, land = u69.Instance}
        if UI_upv_1.Gamepad then
            local v200 = UI_upv_1.Compact and 36 or 32
            local tbl_55 = {}
            tbl_55.Name = "PadNotice"
            tbl_55.AnchorPoint = Vector2.new(0.5, 1)
            tbl_55.Position = UDim2.new(0.5, 0, 1, -((v191 + 14) + 8))
            tbl_55.Size = UDim2.fromOffset(0, v200)
            tbl_55.AutomaticSize = Enum.AutomaticSize.X
            tbl_55.BackgroundColor3 = Colors_upv_1.Void
            tbl_55.BackgroundTransparency = 0.1
            tbl_55.Visible = false
            tbl_55.ZIndex = 8
            tbl_55[1], tbl_55[2], tbl_55[3], tbl_55[4] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Warning, 1, 0.55), UI_upv_1.Padding(0, 16, 0, 16), UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
            tbl_55.Parent = Content_upv_1
            local v201 = UI_upv_1.new("Frame", tbl_55)
            local new_7 = UI_upv_1.new
            local tbl_56 = {LayoutOrder = 1, TextColor3 = 0, Parent = 0, Text = "", Name = "Text", AutomaticSize = 0, ZIndex = 9, TextSize = 0, Size = 0}
            tbl_56.FontFace = Fonts_upv_1.Heavy
            tbl_56.TextSize = ((UI_upv_1.Compact) and 16) or 14
            tbl_56.TextColor3 = Colors_upv_1.Warning
            tbl_56.AutomaticSize = Enum.AutomaticSize.X
            tbl_56.Size = UDim2.fromOffset(0, v200)
            tbl_56.Parent = v201
            u55 = new_7("TextLabel", tbl_56)
            local v202 = UI_upv_1.PadCap(Enum.KeyCode.ButtonA, {ZIndex = 9, LayoutOrder = 2, Height = v200 - 8, Parent = v201})
            u56 = v202
            u54 = v201
        end
        pcall(
            function()
                --[[
                  line: 2025
                  upvalues:
                    u69 (copy, index: 1)
                    u12 (ref,  index: 2)
                ]]
                local Instance_3 = u69.Instance
                local Instance_4 = u12.Instance
                Instance_3.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                Instance_4.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                Instance_3.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                Instance_4.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            end
        )
        a1.Debug.leaveConfirm = function()
            --[[
              line: 2033
              upvalues:
                openConfirm (copy, index: 1)
                tbl_upv_12 (ref,  index: 2)
            ]]
            openConfirm()
            local tbl_57 = {visible = 0, body = 0}
            tbl_57.visible = tbl_upv_12 and (tbl_upv_12.layer.Visible)
            tbl_57.body = tbl_upv_12 and (tbl_upv_12.body.Text)
            return tbl_57
        end
        for key_10, value_21 in u5 do
            value_21(SettingsStore_upv_1.Get(key_10), true)
        end
    end
    local function resize()
        --[[
          name: resize
          line: 2045
          upvalues:
            UI_upv_1 (copy, index: 1)
            u14 (ref,  index: 2)
            u1 (ref,  index: 3)
            u4 (copy, index: 4)
            updateFade (copy, index: 5)
        ]]
        local v203 = UI_upv_1.CanvasSize()
        local v204 = v203.Y - UI_upv_1.TopInset() - 12
        local v205 = math.max(math.min(u14, v204), math.min(u14, 360))
        u4.Holder.Size = UDim2.fromOffset(math.min(u1.winW, v203.X - 24), v205)
        u4.Refit()
        task.defer(updateFade)
    end
    local function relayout()
        --[[
          name: relayout
          line: 2055
          upvalues:
            u4 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            UserInputService_upv_1 (copy, index: 4)
            u22 (ref,  index: 5)
            u13 (ref,  index: 6)
            build (copy, index: 7)
            resize (copy, index: 8)
        ]]
        if not u4.IsOpen then
            return
        end
        local v206 = ((UI_upv_1.Compact) and "c") or "d"
        local v207 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
        local v208 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
        local v209 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        local v210
        if v209 then
            v210 = "a"
        else
            v210 = ""
        end
        if v206 .. v207 .. v208 .. v210 .. (((UI_upv_1.Gamepad) and "p") or "") ~= u13 then
            build()
        end
        resize()
    end
    UI_upv_1.ScaleChanged:Connect(relayout)
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.TouchChanged:Connect(relayout)
    UI_upv_1.TopInsetChanged:Connect(relayout)
    UI_upv_1.GamepadChanged:Connect(
        function()
            --[[
              line: 2069
              upvalues:
                u4 (copy, index: 1)
                u37 (ref,  index: 2)
                UI_upv_1 (copy, index: 3)
                a1 (copy, index: 4)
                UserInputService_upv_1 (copy, index: 5)
                u22 (ref,  index: 6)
                u13 (ref,  index: 7)
                build (copy, index: 8)
                resize (copy, index: 9)
            ]]
            if not u4.IsOpen then
                return
            end
            if not (u37) then
                local v211 = ((UI_upv_1.Compact) and "c") or "d"
                local v212 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
                local v213 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
                local v214 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
                local v215
                if v214 then
                    v215 = "a"
                else
                    v215 = ""
                end
                if v211 .. v212 .. v213 .. v215 .. (((UI_upv_1.Gamepad) and "p") or "") ~= u13 and u4.IsOpen then
                    local v216 = ((UI_upv_1.Compact) and "c") or "d"
                    local v217 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
                    local v218 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
                    local v219 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
                    if v219 then
                        v215 = "a"
                    else
                        v215 = ""
                    end
                    if v216 .. v217 .. v218 .. v215 .. (((UI_upv_1.Gamepad) and "p") or "") ~= u13 then
                        build()
                    end
                    resize()
                end
            end
        end
    )
    SettingsStore_upv_1.Changed:Connect(
        function(a74, a75)
            --[[
              line: 2076
              upvalues:
                u5 (ref,  index: 1)
                u4 (copy, index: 2)
                u15 (ref,  index: 3)
            ]]
            local v220 = u5[a74]
            if not v220 then
                return
            end
            v220(a75, not u4.IsOpen or ((u15 ~= nil) and (u15.item.key == a74)))
        end
    )
    local function endDrag()
        --[[
          name: endDrag
          line: 2083
          upvalues:
            u15 (ref,  index: 1)
            u10 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
        ]]
        if not u15 then
            return
        end
        u15 = nil
        if u10 then
            u10.ScrollingEnabled = true
        end
        UI_upv_1.Tween(UI_upv_1.GetScaleObj(u15.knob), Theme_upv_1.Tween.PopSmall, {Scale = 1})
    end
    UserInputService_upv_1.InputEnded:Connect(
        function(a76)
            --[[
              line: 2094
              upvalues:
                u15 (ref,  index: 1)
                u10 (ref,  index: 2)
                UI_upv_1 (copy, index: 3)
                Theme_upv_1 (copy, index: 4)
            ]]
            if not u15 or a76.UserInputType ~= Enum.UserInputType.MouseButton1 and a76.UserInputType ~= Enum.UserInputType.Touch or not u15 then
                return
            end
            u15 = nil
            if u10 then
                u10.ScrollingEnabled = true
            end
            UI_upv_1.Tween(UI_upv_1.GetScaleObj(u15.knob), Theme_upv_1.Tween.PopSmall, {Scale = 1})
        end
    )
    RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 2099
              upvalues:
                u15 (ref,  index: 1)
                u4 (copy, index: 2)
                u10 (ref,  index: 3)
                UI_upv_1 (copy, index: 4)
                Theme_upv_1 (copy, index: 5)
                SettingsStore_upv_1 (copy, index: 6)
                tick (copy, index: 7)
            ]]
            if not u15 then
                return
            end
            if u4.IsOpen then
                local key_11 = u15.item.key
                local v221 = SettingsStore_upv_1.RANGES[key_11]
                local v222 = math.clamp((UI_upv_1.PointerAbs().X - u15.track.AbsolutePosition.X) / math.max(1, u15.track.AbsoluteSize.X), 0, 1)
                local v223 = v221[1] + v222 * (v221[2] - v221[1])
                if u15.item.round then
                    v223 = math.floor(v223 + 0.5)
                end
                if v223 ~= SettingsStore_upv_1.Get(key_11) then
                    SettingsStore_upv_1.Set(key_11, v223, true)
                    tick(v222)
                end
            elseif u15 then
                u15 = nil
                if u10 then
                    u10.ScrollingEnabled = true
                end
                UI_upv_1.Tween(UI_upv_1.GetScaleObj(u15.knob), Theme_upv_1.Tween.PopSmall, {Scale = 1})
            end
        end
    )
    local tbl_upv_58 = {steps = 0, token = 0, dir = 0}
    local function stopNudge(a77)
        --[[
          name: stopNudge
          line: 2129
          upvalues:
            tbl_upv_58 (copy, index: 1)
        ]]
        if a77 ~= nil and tbl_upv_58.source ~= a77 then
            return
        end
        tbl_upv_58.token = tbl_upv_58.token + 1
        tbl_upv_58.dir = 0
        tbl_upv_58.source = nil
    end
    local function setSlider(a78, a79)
        --[[
          name: setSlider
          line: 418
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
            tick (copy, index: 2)
        ]]
        local key_12 = a78.key
        local v224 = SettingsStore_upv_1.RANGES[key_12]
        if a78.round then
            a79 = math.floor(a79 + 0.5)
        else
            a79 = ((a78.step) and (math.floor((a79 / a78.step) + 0.5) * a78.step)) or a79
        end
        SettingsStore_upv_1.Set(key_12, a79, true)
        tick((SettingsStore_upv_1.Get(key_12) - v224[1]) / (v224[2] - v224[1]))
    end
    local function startNudge(a80, a81)
        --[[
          name: startNudge
          line: 2135
          upvalues:
            GuiService_upv_1 (copy, index: 1)
            u7 (ref,  index: 2)
            u4 (copy, index: 3)
            u37 (ref,  index: 4)
            tbl_upv_58 (copy, index: 5)
            setSlider (copy, index: 6)
            SettingsStore_upv_1 (copy, index: 7)
        ]]
        local SelectedObject_upv_2 = GuiService_upv_1.SelectedObject
        local u70 = SelectedObject_upv_2 and (u7[SelectedObject_upv_2])
        if u70 and u4.IsOpen and not (u37) then
            if tbl_upv_58.dir == a80 and tbl_upv_58.source == a81 then
                return true
            end
            tbl_upv_58.token = tbl_upv_58.token + 1
            local token_upv_1 = tbl_upv_58.token
            tbl_upv_58.dir = a80
            tbl_upv_58.source = a81
            local key_upv_13 = u70.key
            local u71 = u70.step or 0.05
            setSlider(u70, SettingsStore_upv_1.Get(key_upv_13) + (a80 * u71))
            tbl_upv_58.steps = tbl_upv_58.steps + 1
            task.spawn(
                function()
                    --[[
                      line: 2151
                      upvalues:
                        token_upv_1 (copy, index: 1)
                        tbl_upv_58 (copy, index: 2)
                        u4 (copy, index: 3)
                        GuiService_upv_1 (copy, index: 4)
                        SelectedObject_upv_2 (copy, index: 5)
                        setSlider (copy, index: 6)
                        u70 (copy, index: 7)
                        SettingsStore_upv_1 (copy, index: 8)
                        key_upv_13 (copy, index: 9)
                        a80 (copy, index: 10)
                        u71 (copy, index: 11)
                    ]]
                    task.wait(0.35)
                    local v225 = os.clock()
                    while token_upv_1 == tbl_upv_58.token and (u4.IsOpen) and GuiService_upv_1.SelectedObject == SelectedObject_upv_2 do
                        setSlider(u70, SettingsStore_upv_1.Get(key_upv_13) + (a80 * u71))
                        tbl_upv_58.steps = tbl_upv_58.steps + 1
                        task.wait((math.clamp((os.clock() - v225) / 1, 0, 1) * -0.06) + 0.09)
                    end
                end
            )
            return true
        end
        return false
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a82)
            --[[
              line: 2163
              upvalues:
                u4 (copy, index: 1)
                startNudge (copy, index: 2)
            ]]
            local v226 = ((a82.KeyCode == Enum.KeyCode.DPadLeft) and -1) or (((a82.KeyCode ~= Enum.KeyCode.DPadRight) and 0) or 1)
            if v226 == 0 or not u4.IsOpen then
                return
            end
            startNudge(v226, "dpad")
        end
    )
    Keybinds_upv_1.OnInput(
        "Ended",
        function(a83)
            --[[
              line: 2169
              upvalues:
                tbl_upv_58 (copy, index: 1)
            ]]
            if a83.KeyCode ~= Enum.KeyCode.DPadLeft and a83.KeyCode ~= Enum.KeyCode.DPadRight then
                if a83.KeyCode == Enum.KeyCode.Thumbstick1 and tbl_upv_58.source == "stick" then
                    tbl_upv_58.token = tbl_upv_58.token + 1
                    tbl_upv_58.dir = 0
                    tbl_upv_58.source = nil
                end
                return
            end
            if tbl_upv_58.source ~= "dpad" then
                return
            end
            tbl_upv_58.token = tbl_upv_58.token + 1
            tbl_upv_58.dir = 0
            tbl_upv_58.source = nil
        end
    )
    Keybinds_upv_1.OnInput(
        "Changed",
        function(a84)
            --[[
              line: 2176
              upvalues:
                u4 (copy, index: 1)
                startNudge (copy, index: 2)
                tbl_upv_58 (copy, index: 3)
            ]]
            if a84.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end
            local X_1 = a84.Position.X
            local Y_1 = a84.Position.Y
            local v227 = math.abs(X_1)
            if v227 >= 0.5 and math.abs(Y_1) < v227 then
                if u4.IsOpen and startNudge(((X_1 > 0) and 1) or -1, "stick") or tbl_upv_58.source ~= "stick" then
                    return
                end
                tbl_upv_58.token = tbl_upv_58.token + 1
                tbl_upv_58.dir = 0
                tbl_upv_58.source = nil
                return
            end
            if ((v227 < 0.35) or (v227 < math.abs(Y_1))) and tbl_upv_58.source == "stick" then
                tbl_upv_58.token = tbl_upv_58.token + 1
                tbl_upv_58.dir = 0
                tbl_upv_58.source = nil
            end
        end
    )
    local function navUsable(a85)
        --[[
          name: navUsable
          line: 2193
        ]]
        if not a85 or not a85.Parent or not a85.Selectable then
            return false
        end
        local v228 = a85
        while v228 and not v228:IsA("LayerCollector") do
            if not (v228:IsA("GuiObject")) or v228.Visible then
                v228 = v228.Parent
                continue
            end
            return false
        end
        return v228 ~= nil
    end
    local function navChain()
        --[[
          name: navChain
          line: 2207
          upvalues:
            navUsable (copy, index: 1)
            u4 (copy, index: 2)
            u19 (ref,  index: 3)
            tbl_upv_10 (ref,  index: 4)
        ]]
        local tbl_upv_59 = {}
        local function add_1(a86)
            --[[
              name: add
              line: 2209
              upvalues:
                navUsable (copy, index: 1)
                tbl_upv_59 (copy, index: 2)
            ]]
            local tbl_60 = {}
            for _, value_22 in a86.items do
                if navUsable(value_22) then
                    table.insert(tbl_60, value_22)
                end
            end
            if #tbl_60 > 0 then
                local tbl_61 = {land = 0}
                tbl_61.items = tbl_60
                local v229
                if table.find(tbl_60, a86.land) then
                    v229 = a86.land
                else
                    v229 = tbl_60[#tbl_60]
                end
                tbl_61.land = v229
                table.insert(tbl_upv_59, tbl_61)
            end
        end
        add_1({items = {u4.CloseButton}, land = u4.CloseButton})
        for _, value_23 in u19 do
            add_1(value_23)
        end
        if tbl_upv_10 then
            add_1(tbl_upv_10)
        end
        return tbl_upv_59
    end
    local function revealSelected(a87)
        --[[
          name: revealSelected
          line: 2251
          upvalues:
            u10 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            u20 (ref,  index: 3)
            Theme_upv_1 (copy, index: 4)
        ]]
        if not u10 then
            return
        end
        if a87:IsDescendantOf(u10) then
            local Y_2 = u10.AbsoluteWindowSize.Y
            local v230
            if (a87.Size.Y.Offset > 0) and a87.Size.Y.Scale == 0 then
                v230 = a87.AbsoluteSize.Y / a87.Size.Y.Offset
            else
                v230 = UI_upv_1.Scale
            end
            local v231 = a87.AbsolutePosition.Y - u10.AbsolutePosition.Y
            local v232 = v231 + a87.AbsoluteSize.Y
            local v233 = u20[a87]
            if v233 then
                v231 = math.min(v231, v233.AbsolutePosition.Y - u10.AbsolutePosition.Y)
            end
            local Y_3 = u10.CanvasPosition.Y
            local v234
            if v231 < 6 * v230 then
                v234 = Y_3 + v231 - 6 * v230
            else
                v234 = ((Y_2 - (48 * v230) < v232) and (Y_3 + v232 - (Y_2 - (48 * v230)))) or (u10.CanvasPosition.Y)
            end
            local v235 = math.clamp(v234, 0, math.max(0, u10.AbsoluteCanvasSize.Y - Y_2))
            if math.abs(v235 - Y_3) > 1 then
                UI_upv_1.Tween(u10, Theme_upv_1.Tween.Fast, {CanvasPosition = Vector2.new(0, v235)})
            end
        end
    end
    local function wireNav(a88)
        --[[
          name: wireNav
          line: 2231
          upvalues:
            navChain (copy, index: 1)
        ]]
        local v236 = navChain()
        local u72
        for key_14, value_upv_24 in v236 do
            u72 = table.find(value_upv_24.items, a88)
            if not (u72) then
                continue
            end
            local u73 = v236[key_14 - 1]
            local u74 = v236[key_14 + 1]
            pcall(
                function()
                    --[[
                      line: 2237
                      upvalues:
                        a88 (copy, index: 1)
                        u73 (copy, index: 2)
                        u74 (copy, index: 3)
                        value_upv_24 (copy, index: 4)
                        u72 (copy, index: 5)
                    ]]
                    local v237
                    if u73 then
                        v237 = u73.land
                    else
                        v237 = nil
                    end
                    a88.NextSelectionUp = v237
                    local v238
                    if u74 then
                        v238 = u74.land
                    else
                        v238 = nil
                    end
                    a88.NextSelectionDown = v238
                    a88.NextSelectionLeft = value_upv_24.items[u72 - 1]
                    a88.NextSelectionRight = value_upv_24.items[u72 + 1]
                end
            )
            return true
        end
        return false
    end
    GuiService_upv_1:GetPropertyChangedSignal("SelectedObject"):Connect(
        function()
            --[[
              line: 2277
              upvalues:
                GuiService_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                u24 (ref,  index: 3)
                UI_upv_1 (copy, index: 4)
                Theme_upv_1 (copy, index: 5)
                u4 (copy, index: 6)
                wireNav (copy, index: 7)
                revealSelected (copy, index: 8)
            ]]
            local SelectedObject_3 = GuiService_upv_1.SelectedObject
            local v239 = SelectedObject_3 and (u8[SelectedObject_3])
            if u24 and u24 ~= v239 then
                UI_upv_1.Tween(u24, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 1})
            end
            u24 = SelectedObject_3
            if SelectedObject_3 then
                UI_upv_1.Tween(SelectedObject_3, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.94})
            end
            if not SelectedObject_3 or not u4.IsOpen or not SelectedObject_3:IsDescendantOf(u4.Root) then
                return
            end
            wireNav(SelectedObject_3)
            revealSelected(SelectedObject_3)
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 2293
              upvalues:
                u12 (ref,  index: 1)
                State_upv_1 (copy, index: 2)
            ]]
            if u12 then
                local Instance_5 = u12.Instance
                Instance_5.Visible = State_upv_1.InMatch()
            end
        end
    )
    a1.Debug.aimAssistRow = function(a89, a90)
        --[[
          line: 2302
          upvalues:
            u6 (ref,  index: 1)
            u22 (ref,  index: 2)
            u4 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            UserInputService_upv_1 (copy, index: 6)
            u13 (ref,  index: 7)
            build (copy, index: 8)
            resize (copy, index: 9)
            Content_upv_1 (copy, index: 10)
            SettingsStore_upv_1 (copy, index: 11)
        ]]
        local v240 = nil
        local v241 = nil
        local v251 = nil
        if a89 == "flip" then
            v240 = u6.aimAssist
            if v240 then
                v240()
            end
        elseif a89 == "show" then
            u22 = a90 == true
            if u4.IsOpen then
                v241 = ((UI_upv_1.Compact) and "c") or "d"
                v251 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
                local v243 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
                local v244 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
                if v244 then
                    v241 = "a"
                else
                    v241 = ""
                end
                if v241 .. v251 .. v243 .. v241 .. (((UI_upv_1.Gamepad) and "p") or "") ~= u13 then
                    build()
                end
                resize()
            end
        end
        local v246 = Content_upv_1:FindFirstChild("aimAssist", true)
        local v247 = false
        if v246 then
            v251 = v246:IsA("GuiObject")
            if v251 and u4.IsOpen then
                local _ = true
                v251 = v246
                while v251 and v251 ~= Content_upv_1 do
                    local v249 = v251:IsA("GuiObject")
                    _ = not (v249) or v251.Visible or false
                    v251 = v251.Parent
                end
            else
                v241 = v247
            end
        else
            v241 = v247
        end
        local success_8, v250 = pcall(require, game:GetService("ReplicatedStorage").Shared:FindFirstChild("Camera"))
        if success_8 and type(v250) == "table" and type(v250.GetAimAssistEnabled) == "function" then
            v251 = v250.GetAimAssistEnabled()
        else
            v251 = nil
        end
        local tbl_62 = {camera = 0, touch = 0, row = 0, value = 0}
        tbl_62.shown = v241
        tbl_62.row = v246 ~= nil
        tbl_62.value = SettingsStore_upv_1.Get("aimAssist")
        tbl_62.camera = v251
        tbl_62.touch = UI_upv_1.Touch
        return tbl_62
    end
    a1.Debug.keybinds = function(a91, a92, a93)
        --[[
          line: 2332
          upvalues:
            openCapture (copy, index: 1)
            closeCapture (copy, index: 2)
            Keybinds_upv_1 (copy, index: 3)
            SettingsStore_upv_1 (copy, index: 4)
            u36 (ref,  index: 5)
            u37 (ref,  index: 6)
            u33 (ref,  index: 7)
            tbl_upv_23 (ref,  index: 8)
        ]]
        if a91 == "capture" and type(a92) == "string" then
            openCapture(a92, a93 or 1)
        elseif a91 == "cancel" then
            closeCapture()
        elseif a91 == "reset" then
            local v252 = Keybinds_upv_1.ResetAll()
            SettingsStore_upv_1.SaveKeybinds(v252)
            return v252
        end
        local tbl_63 = {}
        for _, value_25 in Keybinds_upv_1.ACTIONS do
            tbl_63[value_25.id] = table.concat(Keybinds_upv_1.Get(value_25.id), ",")
        end
        local v253 = u36
        tbl_63._capturing = u37 and u37.id .. "#" .. u37.slot or false
        tbl_63._card = v253 ~= nil and u36.layer.Visible
        local v256
        if u36 then
            v256 = u36.line1.Text
        else
            v256 = nil
        end
        tbl_63._pad = v256
        v256 = (v253 ~= nil) and (u36.box:IsFocused())
        tbl_63._focus = v256
        local v257
        if u33 then
            v257 = u33.Text
        else
            v257 = nil
        end
        tbl_63._notice = v257
        v257 = next(tbl_upv_23) ~= nil
        tbl_63._section = v257
        return tbl_63
    end
    local function guiName(a94)
        --[[
          name: guiName
          line: 2363
          upvalues:
            u52 (ref, index: 1)
        ]]
        if not a94 then
            return nil
        end
        local v258 = u52[a94]
        if v258 then
            return "chip:" .. v258.id .. "#" .. v258.slot
        end
        return a94.Name
    end
    a1.Debug.padSettings = function(a95, a96, a97)
        --[[
          line: 2373
          upvalues:
            u51 (ref,  index: 1)
            GuiService_upv_1 (copy, index: 2)
            u10 (ref,  index: 3)
            openPadCapture (copy, index: 4)
            u53 (ref,  index: 5)
            Keybinds_upv_1 (copy, index: 6)
            SettingsStore_upv_1 (copy, index: 7)
            paintPadBinds (copy, index: 8)
            u4 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            u52 (ref,  index: 11)
            u7 (ref,  index: 12)
            tbl_upv_58 (copy, index: 13)
            navChain (copy, index: 14)
            u36 (ref,  index: 15)
            u37 (ref,  index: 16)
            u54 (ref,  index: 17)
            u55 (ref,  index: 18)
            a1 (copy, index: 19)
        ]]
        if a95 == "select" and type(a96) == "string" then
            local v259 = u51[a96]
            local v260 = v259 and (v259[math.clamp(a97 or 1, 1, #v259)])
            if v260 then
                GuiService_upv_1.SelectedObject = v260.button
            end
        elseif a95 == "row" and type(a96) == "string" then
            local v261 = u10 and (u10:FindFirstChild(a96, true))
            if v261 and v261:IsA("GuiObject") then
                GuiService_upv_1.SelectedObject = v261
            end
        elseif a95 == "nav" and type(a96) == "string" then
            local SelectedObject_4 = GuiService_upv_1.SelectedObject
            local v262 = SelectedObject_4 and (SelectedObject_4["NextSelection" .. a96])
            if v262 then
                GuiService_upv_1.SelectedObject = v262
            end
        elseif a95 == "capture" and type(a96) == "string" then
            local v263 = u51[a96]
            local v264 = v263 and (v263[math.clamp(a97 or 1, 1, math.max(1, #v263))])
            openPadCapture(a96, a97 or 1, v264 and (v264.button))
        elseif a95 == "reset" and u53 then
            SettingsStore_upv_1.SavePadBinds((Keybinds_upv_1.PadResetAll()))
            paintPadBinds()
        end
        local SelectedObject_5 = GuiService_upv_1.SelectedObject
        local tbl_64 = {}
        tbl_64.open = u4.IsOpen
        tbl_64.gamepad = UI_upv_1.Gamepad
        local v265
        if SelectedObject_5 then
            local _ = u52[SelectedObject_5]
            v265 = u52[SelectedObject_5] and "chip:" .. u52[SelectedObject_5].id .. "#" .. u52[SelectedObject_5].slot or SelectedObject_5.Name
        else
            v265 = nil
        end
        tbl_64.selected = v265 or false
        local v266 = SelectedObject_5 and (u7[SelectedObject_5])
        if v266 then
            v265 = {}
            v265.key = v266.key
            v265.value = SettingsStore_upv_1.Get(v266.key)
        else
            v265 = false
        end
        tbl_64.slider = v265
        tbl_64.nudgeSteps = tbl_upv_58.steps
        local tbl_65 = {}
        local v267 = nil
        for _, value_26 in navChain() do
            local tbl_66 = {}
            for v272, value_27 in value_26.items do
                if value_27 then
                    local v273 = u52[value_27]
                    v267 = u52[value_27] and "chip:" .. u52[value_27].id .. "#" .. u52[value_27].slot or value_27.Name
                else
                    v267 = nil
                end
                table.insert(tbl_66, v267)
            end
            table.insert(tbl_65, table.concat(tbl_66, "|"))
        end
        tbl_64.chain = tbl_65
        if u10 then
            tbl_64.canvasY = math.floor(u10.CanvasPosition.Y + 0.5)
            tbl_64.view = math.floor(u10.AbsoluteWindowSize.Y + 0.5)
            tbl_64.canvasH = math.floor(u10.AbsoluteCanvasSize.Y + 0.5)
            if SelectedObject_5 and SelectedObject_5:IsDescendantOf(u10) then
                local v268 = SelectedObject_5.AbsolutePosition.Y - u10.AbsolutePosition.Y
                v265 = math.floor(v268 + 0.5)
                local v269 = math.floor((v268 + SelectedObject_5.AbsoluteSize.Y) + 0.5)
                tbl_64.selTop = v265
                tbl_64.selBottom = v269
            end
        end
        local v270 = u36
        if u37 then
            local _ = u37.id
            local v274 = u37.slot
            local v275 = u37.pad and " pad" or " kb"
            v265 = u37.id .. "#" .. u37.slot .. (u37.pad and " pad" or " kb")
        else
            v265 = false
        end
        tbl_64._capturing = v265
        v265 = (v270 ~= nil) and (u36.layer.Visible)
        tbl_64._card = v265
        if u36 then
            v265 = u36.line1.Text
        else
            v265 = nil
        end
        tbl_64._pad = v265
        if u36 then
            v265 = ((u36.holdHint.Visible) and "hold B to cancel") or (u36.line2.Text)
        else
            v265 = nil
        end
        tbl_64._hint = v265
        if u54 and u54.Visible and u55 then
            v265 = u55.Text
        else
            v265 = false
        end
        tbl_64._notice = v265
        v265 = next(u51) ~= nil
        tbl_64._section = v265
        if u53 then
            v265 = u53.Instance.Selectable
        else
            v265 = nil
        end
        tbl_64._resetEnabled = v265
        tbl_64._padCapturing = a1.PadCapturing == true
        local tbl_67 = {}
        local v271 = nil
        for key_15, value_28 in u51 do
            local tbl_68 = {}
            for _, value_29 in value_28 do
                local Glyph_1 = value_29.cap:FindFirstChild("Glyph")
                if value_29.dash.Visible then
                    v271 = "-"
                    table.insert(tbl_68, v271)
                    continue
                end
                if not (Glyph_1) then
                    v271 = value_29.cap:FindFirstChild("Key").Text
                    table.insert(tbl_68, v271)
                    continue
                end
                if Glyph_1.Visible then
                    v271 = "img"
                else
                    v271 = value_29.cap:FindFirstChild("Key").Text
                end
                table.insert(tbl_68, v271)
            end
            tbl_67[key_15] = table.concat(Keybinds_upv_1.PadGet(key_15), ",") .. " [" .. table.concat(tbl_68, ",") .. "]"
        end
        tbl_64.rows = tbl_67
        return tbl_64
    end
    local tbl_69 = {}
    function tbl_69.open()
        --[[
          name: open
          line: 2449
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            UserInputService_upv_1 (copy, index: 3)
            u22 (ref,  index: 4)
            u13 (ref,  index: 5)
            build (copy, index: 6)
            u5 (ref,  index: 7)
            SettingsStore_upv_1 (copy, index: 8)
            u12 (ref,  index: 9)
            State_upv_1 (copy, index: 10)
            tbl_upv_12 (ref,  index: 11)
            u17 (ref,  index: 12)
            u18 (ref,  index: 13)
            u10 (ref,  index: 14)
            resize (copy, index: 15)
            u4 (copy, index: 16)
            u9 (ref,  index: 17)
            GuiService_upv_1 (copy, index: 18)
        ]]
        local v272 = ((UI_upv_1.Compact) and "c") or "d"
        local v273 = ((UI_upv_1.Touch and (a1.OpenTouchEditor ~= nil)) and "t") or ""
        local v274 = ((not UI_upv_1.Touch and (UserInputService_upv_1.KeyboardEnabled and (not UI_upv_1.Gamepad))) and "k") or ""
        local v275 = UI_upv_1.Touch or (UI_upv_1.Gamepad or u22)
        local v276
        if v275 then
            v276 = "a"
        else
            v276 = ""
        end
        if v272 .. v273 .. v274 .. v276 .. (((UI_upv_1.Gamepad) and "p") or "") ~= u13 then
            build()
        end
        for key_16, value_30 in u5 do
            value_30(SettingsStore_upv_1.Get(key_16), true)
        end
        local Instance_6 = u12.Instance
        Instance_6.Visible = State_upv_1.InMatch()
        if tbl_upv_12 then
            tbl_upv_12.layer.Visible = false
        end
        u17 = false
        u18 = u18 + 1
        u12:SetText("LEAVE MATCH")
        if u10 then
            u10.CanvasPosition = Vector2.zero
        end
        resize()
        u4:Open()
        if not u9 or not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = u9
    end
    function tbl_69.close(a98)
        --[[
          name: close
          line: 2470
          upvalues:
            tbl_upv_12 (ref,  index: 1)
            closeCapture (copy, index: 2)
            u39 (ref,  index: 3)
            tbl_upv_58 (copy, index: 4)
            u15 (ref,  index: 5)
            u10 (ref,  index: 6)
            UI_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            GuiService_upv_1 (copy, index: 9)
            u4 (copy, index: 10)
        ]]
        if tbl_upv_12 then
            tbl_upv_12.layer.Visible = false
        end
        closeCapture()
        u39 = nil
        tbl_upv_58.token = tbl_upv_58.token + 1
        tbl_upv_58.dir = 0
        tbl_upv_58.source = nil
        local v277 = u15
        if v277 then
            u15 = nil
            if u10 then
                u10.ScrollingEnabled = true
            end
            UI_upv_1.Tween(UI_upv_1.GetScaleObj(v277.knob), Theme_upv_1.Tween.PopSmall, {Scale = 1})
        end
        local SelectedObject_6 = GuiService_upv_1.SelectedObject
        if SelectedObject_6 and SelectedObject_6:IsDescendantOf(u4.Root) then
            GuiService_upv_1.SelectedObject = nil
        end
        u4:Close(a98)
    end
    function tbl_69.select()
        --[[
          name: select
          line: 2482
          upvalues:
            u37 (ref,  index: 1)
            u39 (ref,  index: 2)
            navUsable (copy, index: 3)
            u9 (ref,  index: 4)
        ]]
        if u37 and u37.pad then
            return nil
        elseif u39 and navUsable(u39) then
            return u39
        else
            return u9
        end
    end
    function tbl_69.back()
        --[[
          name: back
          line: 2493
          upvalues:
            u37 (ref,  index: 1)
            closeCapture (copy, index: 2)
            tbl_upv_12 (ref,  index: 3)
            u12 (ref,  index: 4)
            UI_upv_1 (copy, index: 5)
            GuiService_upv_1 (copy, index: 6)
        ]]
        if u37 then
            if not (u37.pad) then
                closeCapture()
            end
            return true
        elseif tbl_upv_12 and tbl_upv_12.layer.Visible then
            if tbl_upv_12 then
                tbl_upv_12.layer.Visible = false
            end
            if u12 and UI_upv_1.Gamepad then
                GuiService_upv_1.SelectedObject = u12.Instance
            end
            return true
        else
            return false
        end
    end
    a1.MenuManager.Register("Settings", tbl_69)
end
return tbl_1