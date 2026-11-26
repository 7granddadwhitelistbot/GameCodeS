local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local guiService = game:GetService("GuiService")
local Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local v6 = {}

local function pct(a8)
    --[[
      name: pct
      line: 71
    ]]
    return string.format("%d%%", (math.floor((a8 * 100) + 0.5)))
end

local v9 = {
    {
        title = "CAMERA",
        items = {
            {
                key = "sensitivity",
                kind = "slider",
                label = "CAMERA SENSITIVITY",
                desc = "How fast the camera turns",
                step = 0.05,
                notPad = true,
                fmt = (function(a10: number)
                    --[[
                      name: fmt
                      line: 79
                    ]]
                    return string.format("%.2fx", a10)
                end)
            },
            {
                key = "padSensitivity",
                kind = "slider",
                label = "CONTROLLER SENSITIVITY",
                desc = "How fast the right stick turns the camera",
                step = 0.05,
                padOnly = true,
                fmt = (function(a11: number)
                    --[[
                      name: fmt
                      line: 82
                    ]]
                    return string.format("%.2fx", a11)
                end)
            },
            {key = "padInvertY", kind = "switch", label = "INVERT Y", desc = "Push the stick up to look down", padOnly = true},
            {
                key = "fov",
                kind = "slider",
                label = "FIELD OF VIEW",
                desc = "How much of the map you see",
                step = 1,
                round = true,
                fmt = (function(a12)
                    --[[
                      name: fmt
                      line: 86
                    ]]
                    return (tostring((math.floor(a12 + 0.5))))
                end)
            },
            {key = "aimZoom", kind = "slider", label = "AIM ZOOM", desc = "How far aiming zooms in", step = 0.05, fmt = pct},
            {
                key = "aimSensitivity",
                kind = "slider",
                label = "AIM SENSITIVITY",
                desc = "How fast the camera turns while aiming",
                step = 0.05,
                fmt = (function(a13: number)
                    --[[
                      name: fmt
                      line: 92
                    ]]
                    return string.format("%.2fx", a13)
                end)
            },
            {key = "aimAssist", kind = "switch", label = "AIM ASSIST", desc = "Helps your aim stay on enemies", assistOnly = true},
            {key = "firstPerson", kind = "switch", label = "FIRST PERSON", desc = "Start in first person", capAction = "View", pad = Enum.KeyCode.DPadUp},
            {key = "viewBobbing", kind = "switch", label = "VIEW BOBBING", desc = "Camera bounce as you walk in first person"}
        }
    },
    {title = "AUDIO", items = {{key = "music", kind = "slider", label = "MUSIC", desc = "Lobby and match music", step = 0.05, fmt = pct}, {key = "sfx", kind = "slider", label = "SOUND EFFECTS", desc = "Combat, menus and ambience", step = 0.05, fmt = pct}}},
    {title = "PARTY", items = {{key = "friendsOnlyInvites", kind = "switch", label = "FRIENDS-ONLY INVITES", desc = "Only your Roblox friends can invite you to a party"}}},
    {title = "CONTROLS", touchOnly = true, items = {{kind = "action", label = "BUTTON LAYOUT", desc = "Move and resize your on-screen buttons"}, {key = "attackAim", kind = "switch", label = "AIM WITH ATTACK BUTTON", desc = "Drag the attack button to turn the camera"}}},
    {title = "CONTROLS", keyboardOnly = true, keybinds = true, items = {}},
    {title = "CONTROLLER", padbinds = true, items = {}},
    {
        title = "STAGING",
        staging = true,
        items = {
            {kind = "action", run = "replayNewPlayer", button = "REPLAY", label = "REPLAY NEW-PLAYER FLOW", desc = "Welcome card, first match and starter loadouts again"},
            {kind = "action", run = "replayFullHub", button = "REPLAY", label = "REPLAY WITH A FULL HUB", desc = "New player again; FIGHT sends you to a match server"},
            {kind = "action", run = "showNews", button = "SHOW", label = "SHOW NEWS POPUP", desc = "What returning players see when they join"},
            {key = "moveDebug", kind = "switch", session = true, label = "MOVEMENT DEBUG", desc = "Overlay: fps, rollbacks, corrections per stop"},
            {key = "bodySmoothing", kind = "switch", session = true, label = "BODY SMOOTHING", desc = "On: a smooth visual copy; off: your character at 60 Hz steps"},
            {key = "premiumTest", kind = "switch", session = true, label = "PREMIUM QUEUE ACCESS", desc = "Count as a paying player with an old account (test)"}
        }
    }
}
local v14 = {winW = 720, rowH = 64, pad = 18, label = 19, desc = 16, title = 16, cap = 22, switchW = 58, trackW = 236, trackH = 8, knob = 22, valueW = 64, value = 19, sectionGap = 18, titleGap = 8, footerBtn = 52, footerTop = 16, button = 20, kbRowH = 52, chipW = 124, chipH = 36, chipText = 16, chipGap = 8, itemGap = 6, kbHeader = 34}
local v15 = {winW = 880, rowH = 74, pad = 20, label = 22, desc = 17, title = 18, cap = 24, switchW = 70, trackW = 272, trackH = 10, knob = 28, valueW = 78, value = 22, sectionGap = 18, titleGap = 8, footerBtn = 58, footerTop = 14, button = 22, kbRowH = 60, chipW = 136, chipH = 42, chipText = 18, chipGap = 8, itemGap = 6, kbHeader = 38}
local backgroundColor3 = Color3.fromRGB(58, 63, 78)
local textColor3 = Color3.fromRGB(142, 149, 166)

function v6.Init(a18)
    --[[
      name: Init
      line: 168
      upvalues:
        v14 (copy, index: 1)
        players (copy, index: 2)
        guiService (copy, index: 3)
        userInputService (copy, index: 4)
        textColor3 (copy, index: 5)
        backgroundColor3 (copy, index: 6)
        Keybinds (copy, index: 7)
        v15 (copy, index: 8)
        v9 (copy, index: 9)
        runService (copy, index: 10)
    ]]
    local ui = a18.UI
    local theme = a18.Theme
    local state = a18.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local SettingsStore = require(script.Parent.Parent.SettingsStore)
    local v25 = ui.Window(
        {
            Name = "Settings",
            Title = "SETTINGS",
            Size = UDim2.fromOffset(v14.winW, 640),
            Parent = a18.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 178
                  upvalues:
                    a18 (copy, index: 1)
                ]]
                a18.MenuManager.Close("Settings")
            end)
        }
    )
    local content = v25.Content
    local v27 = {}
    local v28 = {}
    local v29 = {}
    local v30 = {}
    local selectedObject = nil
    local ui2 = nil
    local ui3 = nil
    local v34 = nil
    local v35 = nil
    local v36 = 640
    local v37 = v14
    local v38 = nil
    local timestamp = 0
    local v40 = false
    local count = 0
    local v42 = {}
    local v43 = {}
    local v44 = nil

    local function addNav(items, a47)
        --[[
          name: addNav
          line: 208
          upvalues:
            v42 (ref, index: 1)
        ]]
        table.insert(v42, {items = items, land = a47 or items[1]})

        for v48, v49 in items do
            pcall(
                function()
                    --[[
                      line: 211
                      upvalues:
                        v49 (copy, index: 1)
                        v48 (copy, index: 2)
                        items (copy, index: 3)
                    ]]
                    if v48 == 1 then
                        v49.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                    end

                    if v48 == #items then
                        v49.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                    end
                end
            )
        end
    end

    local function leaveCost()
        --[[
          name: leaveCost
          line: 226
          upvalues:
            state (copy, index: 1)
            players (copy, index: 2)
        ]]
        local match = state.Match
        local phase = match and match.phase

        if workspace:GetAttribute("CustomServer") == true then
            return "You'll wait in this server's lobby until the next match.", false
        end
        if phase == "MatchEnd" then
            return "The match is over. Your result and rewards are kept.", false
        end

        if phase == "RoundEnd" and match and type(match.teams) == "table" then
            for _, team in match.teams do
                if type(team) == "table" then
                    local number = tonumber(team.score) or 0

                    if not (state.RoundsToWin() <= number) then
                        continue
                    end

                    return "The match is decided. Your result and rewards are kept.", false
                end
            end
        end

        if phase == "Intro" then
            local round = match and match.round

            if (tonumber(round) or 1) <= 1 then
                return "The match hasn't started yet. Nothing is recorded.", false
            end
        end

        local v57 = "You'll forfeit: it counts as a loss with no XP, and a bot takes your place."
        local number = tonumber(players.LocalPlayer:GetAttribute("Streak")) or 0

        if 2 <= number then
            v57 ..= string.format("\nYour 🔥 %d win streak ends.", number)
        end

        return v57, true
    end

    local v59 = nil

    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 254
          upvalues:
            v59 (ref, index: 1)
        ]]
        if v59 then
            v59.layer.Visible = false
        end
    end

    local function openConfirm()
        --[[
          name: openConfirm
          line: 259
          upvalues:
            v59 (ref,  index: 1)
            ui (copy, index: 2)
            colors (copy, index: 3)
            theme (copy, index: 4)
            v25 (copy, index: 5)
            closeConfirm (copy, index: 6)
            fonts (copy, index: 7)
            a18 (copy, index: 8)
            leaveCost (copy, index: 9)
            guiService (copy, index: 10)
        ]]
        if not v59 then
            local newUi = ui.new
            local v63 = {Name = "LeaveConfirm", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, [1] = (ui.Corner((theme.Radius.Window
                or UDim.new(0, 18)))), Parent = v25.Holder}
            local ui2 = newUi("TextButton", v63)
            ui2.Activated:Connect(closeConfirm)
            local v65 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(470, 250), Radius = UDim.new(0, 16), Parent = ui2})
            ui.new("TextButton", {Name = "Sink", BackgroundTransparency = 1, Text = "", Selectable = false, ZIndex = 41, Size = UDim2.fromScale(1, 1), Parent = v65})

            pcall(
                function()
                    --[[
                      line: 285
                      upvalues:
                        v65 (copy, index: 1)
                    ]]
                    v65.SelectionGroup = true
                    v65.SelectionBehaviorUp, v65.SelectionBehaviorDown = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
                    v65.SelectionBehaviorLeft, v65.SelectionBehaviorRight = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
                end
            )

            ui.DisplayText({Name = "Title", Text = "LEAVE MATCH?", TextSize = 36, ZIndex = 42, Position = UDim2.fromOffset(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = colors.Text, Parent = v65})

            v59 = {
                layer = ui2,
                card = v65,
                body = ui.new("TextLabel", {Name = "Body", Text = "", TextSize = 19, TextWrapped = true, ZIndex = 42, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 70), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = v65}),
                stay = ui.Button({Name = "Stay", Text = "STAY", TextSize = 22, Style = "Dark", ZIndex = 43, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = UDim2.fromOffset(196, 58), Parent = v65, OnClick = closeConfirm}),
                go = ui.Button(
                    {
                        Name = "Leave",
                        Text = "LEAVE",
                        TextSize = 22,
                        Style = "Danger",
                        ZIndex = 43,
                        AnchorPoint = Vector2.new(1, 1),
                        Position = UDim2.new(1, -28, 1, -24),
                        Size = UDim2.fromOffset(196, 58),
                        Parent = v65,
                        OnClick = (function()
                            --[[
                              name: OnClick
                              line: 336
                              upvalues:
                                v59 (ref,  index: 1)
                                a18 (copy, index: 2)
                            ]]
                            if v59 then
                                v59.layer.Visible = false
                            end

                            a18.MenuManager.Close("Settings")
                            a18.QueueAction("LeaveMatch")
                        end)
                    }
                )
            }
        end

        local v66 = v59
        local text, v68 = leaveCost()
        v66.body.Text = text
        v66.body.TextColor3 = if v68 then colors.Text else colors.TextDim
        v66.layer.Visible = true
        ui.Enter(v66.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))

        if ui.Gamepad then
            guiService.SelectedObject = v66.stay.Instance
        end
    end

    local function showControls()
        --[[
          name: showControls
          line: 355
          upvalues:
            ui (copy, index: 1)
            a18 (copy, index: 2)
        ]]
        return ui.Touch and (a18.OpenTouchEditor ~= nil)
    end

    local function lastIsGamepad()
        --[[
          name: lastIsGamepad
          line: 358
          upvalues:
            ui (copy, index: 1)
        ]]
        return ui.Gamepad
    end

    local function showKeybinds()
        --[[
          name: showKeybinds
          line: 362
          upvalues:
            ui (copy, index: 1)
            userInputService (copy, index: 2)
        ]]
        return not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
    end

    local v72 = false

    local function showAssist()
        --[[
          name: showAssist
          line: 367
          upvalues:
            ui (copy, index: 1)
            v72 (ref,  index: 2)
        ]]
        return ui.Touch or ui.Gamepad or v72
    end

    local function modeKey()
        --[[
          name: modeKey
          line: 370
          upvalues:
            ui (copy, index: 1)
            a18 (copy, index: 2)
            userInputService (copy, index: 3)
            v72 (ref,  index: 4)
        ]]
        local v75 = ui.Compact and "c" or "d"
        local v76 = ui.Touch and a18.OpenTouchEditor ~= nil
        local v77 = v76 and "t" or ""
        local v78 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
        local v79 = v78 and "k" or ""
        local v80 = ui.Touch or ui.Gamepad or v72
        local v81 = v80 and "a" or ""
        local v82 = ui.Gamepad and "p" or ""

        return v75 .. v77 .. v79 .. v81 .. v82
    end

    local selectionImageObject = ui.new("Frame", {Name = "SettingsSelection", Size = UDim2.fromScale(1, 1), ui.Corner(12), ui.Stroke(colors.Accent, 2, 0)})

    local function setHighlight(a85, backgroundTransparency)
        --[[
          name: setHighlight
          line: 384
          upvalues:
            ui (copy, index: 1)
            theme (copy, index: 2)
        ]]
        ui.Tween(a85, theme.Tween.Fast, {BackgroundTransparency = backgroundTransparency})
    end

    local v87 = nil

    local function hookRowFeedback(a89, a90)
        --[[
          name: hookRowFeedback
          line: 389
          upvalues:
            ui (copy, index: 1)
            theme (copy, index: 2)
            v87 (ref,  index: 3)
        ]]
        local v91 = false

        a89.MouseEnter:Connect(
            function()
                --[[
                  line: 391
                  upvalues:
                    ui (copy, index: 1)
                    v91 (ref,  index: 2)
                    a90 (copy, index: 3)
                    theme (copy, index: 4)
                ]]
                if not ui.Touch then
                    v91 = true
                    ui.Tween(a90, theme.Tween.Fast, {BackgroundTransparency = 0.955})
                end
            end
        )

        a89.MouseLeave:Connect(
            function()
                --[[
                  line: 397
                  upvalues:
                    v91 (ref,  index: 1)
                    a90 (copy, index: 2)
                    v87 (ref,  index: 3)
                    ui (copy, index: 4)
                    theme (copy, index: 5)
                ]]
                v91 = false
                local backgroundTransparency = v87 ~= a90 and 1 or 0.94
                ui.Tween(a90, theme.Tween.Fast, {BackgroundTransparency = backgroundTransparency})
            end
        )

        if a89:IsA("GuiButton") then
            a89.MouseButton1Down:Connect(
                function()
                    --[[
                      line: 402
                      upvalues:
                        a90 (copy, index: 1)
                        ui (copy, index: 2)
                        theme (copy, index: 3)
                    ]]
                    local v93 = a90
                    ui.Tween(v93, theme.Tween.Fast, {BackgroundTransparency = 0.93})
                end
            )

            a89.MouseButton1Up:Connect(
                function()
                    --[[
                      line: 405
                      upvalues:
                        a90 (copy, index: 1)
                        v91 (ref,  index: 2)
                        ui (copy, index: 3)
                        theme (copy, index: 4)
                    ]]
                    local backgroundTransparency = v91 and 0.955 or 1
                    ui.Tween(a90, theme.Tween.Fast, {BackgroundTransparency = backgroundTransparency})
                end
            )
        end
    end

    local function tick(a96)
        --[[
          name: tick
          line: 411
          upvalues:
            timestamp (ref,  index: 1)
            a18 (copy, index: 2)
        ]]
        if 0.06 < os.clock() - timestamp then
            timestamp = os.clock()
            a18.Sounds.Play("Tick", {volume = 0.2, pitch = (a96 * 0.6) + 0.8})
        end
    end

    local function setSlider(slider, a99)
        --[[
          name: setSlider
          line: 418
          upvalues:
            SettingsStore (copy, index: 1)
            tick (copy, index: 2)
        ]]
        local key = slider.key
        local range = SettingsStore.RANGES[key]

        if slider.round then
            a99 = math.floor(a99 + 0.5)
        elseif slider.step then
            a99 = math.floor((a99 / slider.step) + 0.5) * slider.step
        end

        SettingsStore.Set(key, a99, true)
        tick((SettingsStore.Get(key) - range[1]) / (range[2] - range[1]))
    end

    local function textBlock(parent, a104, a105)
        --[[
          name: textBlock
          line: 431
          upvalues:
            ui (copy, index: 1)
            v37 (ref,  index: 2)
            fonts (copy, index: 3)
            colors (copy, index: 4)
            textColor3 (copy, index: 5)
        ]]
        local parent2 = ui.new("Frame", {Name = "Text", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, v37.pad, 0.5, 0), Size = UDim2.new(1, -(((v37.pad * 2) + a105) + 16), 0, v37.label + 4 + v37.desc), Parent = parent})
        local parent3 = ui.new("Frame", {Name = "Line", Size = UDim2.new(1, 0, 0, v37.label), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent2})
        ui.new("TextLabel", {Name = "Label", LayoutOrder = 1, Text = a104.label, FontFace = fonts.Heavy, TextSize = v37.label, TextColor3 = colors.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})

        if a104.capAction then
            ui.ActionCap(a104.capAction, {LayoutOrder = 2, Height = v37.cap, TextSize = v37.cap - 8, Gamepad = a104.pad, Parent = parent3})
        elseif a104.cap then
            ui.KeyCap(a104.cap, {LayoutOrder = 2, Height = v37.cap, TextSize = v37.cap - 8, Gamepad = a104.pad, Parent = parent3})
        end

        ui.new("TextLabel", {Name = "Desc", Text = a104.desc, FontFace = fonts.SemiBold, TextSize = v37.desc, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(0, v37.label + 4), Size = UDim2.new(1, 0, 0, v37.desc), Parent = parent2})
    end

    local function rowBase(a109: string, parent, layoutOrder, item)
        --[[
          name: rowBase
          line: 476
          upvalues:
            ui (copy, index: 1)
            v37 (ref,  index: 2)
            colors (copy, index: 3)
            selectionImageObject (copy, index: 4)
            v30 (ref,  index: 5)
            addNav (copy, index: 6)
        ]]
        local newUi = ui.new
        local v114 = {Name = item.key or item.label, Size = UDim2.new(1, 0, 0, v37.rowH), LayoutOrder = layoutOrder, Parent = parent}
        local parent2 = newUi(a109, v114)

        if 1 < layoutOrder then
            ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = colors.Stroke, Position = UDim2.fromOffset(v37.pad, 0), Size = UDim2.new(1, -v37.pad * 2, 0, 1), Parent = parent2})
        end

        local ui2 = ui.new("Frame", {Name = "Highlight", BackgroundColor3 = colors.White, BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), (ui.Corner(9)), Parent = parent2})
        parent2.SelectionImageObject = selectionImageObject
        v30[parent2] = ui2
        addNav({parent2})

        return parent2, ui2
    end

    local function sliderRow(ui3, layoutOrder, item)
        --[[
          name: sliderRow
          line: 508
          upvalues:
            SettingsStore (copy, index: 1)
            v37 (ref,  index: 2)
            rowBase (copy, index: 3)
            textBlock (copy, index: 4)
            ui (copy, index: 5)
            fonts (copy, index: 6)
            colors (copy, index: 7)
            backgroundColor3 (copy, index: 8)
            theme (copy, index: 9)
            v29 (ref,  index: 10)
            hookRowFeedback (copy, index: 11)
            selectedObject (ref,  index: 12)
            v27 (ref,  index: 13)
            v38 (ref,  index: 14)
            ui2 (ref,  index: 15)
        ]]
        local key = item.key
        local range = SettingsStore.RANGES[key]
        local v123 = v37.trackW + 16 + v37.valueW
        local parent, v125 = rowBase("Frame", ui3, layoutOrder, item)
        textBlock(parent, item, v123)
        local parent2 = ui.new("Frame", {Name = "Control", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -v37.pad, 0, 0), Size = UDim2.new(0, v123, 1, 0), Parent = parent})
        local ui4 = ui.new("TextLabel", {Name = "Value", Text = "", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(v37.valueW, v37.value + 4), FontFace = fonts.Heavy, TextSize = v37.value, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent2})
        local ui5 = ui.new("Frame", {Name = "Track", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(v37.trackW, v37.trackH), BackgroundColor3 = backgroundColor3, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
        local ui6 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Accent, (ui.Corner(theme.Radius.Pill)), Parent = ui5})
        local knob = ui.new("Frame", {Name = "Knob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(v37.knob, v37.knob), BackgroundColor3 = colors.Bone, ZIndex = 2, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.AccentDark, 2, 0.1)), Parent = ui5})
        local ui7 = ui.new("TextButton", {Name = "Hit", ZIndex = 5, Selectable = false, Position = UDim2.fromOffset(-14, 0), Size = UDim2.new(1, 14 + v37.pad, 1, 0), Parent = parent2})
        parent.Selectable = true

        pcall(
            function()
                --[[
                  line: 571
                  upvalues:
                    parent (copy, index: 1)
                ]]
                parent.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                parent.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
            end
        )

        v29[parent] = item
        hookRowFeedback(ui7, v125)
        selectedObject = selectedObject or parent

        v27[key] = function(a132, a133)
            --[[
              line: 578
              upvalues:
                range (copy, index: 1)
                ui4 (copy, index: 2)
                item (copy, index: 3)
                ui6 (copy, index: 4)
                knob (copy, index: 5)
                ui (copy, index: 6)
                theme (copy, index: 7)
            ]]
            local clampedValue = math.clamp((a132 - range[1]) / (range[2] - range[1]), 0, 1)
            ui4.Text = item.fmt(a132)

            if a133 then
                ui6.Size = UDim2.fromScale(clampedValue, 1)
                knob.Position = UDim2.fromScale(clampedValue, 0.5)

                return
            end

            ui.Tween(ui6, theme.Tween.Fast, {Size = UDim2.fromScale(clampedValue, 1)})
            ui.Tween(knob, theme.Tween.Fast, {Position = UDim2.fromScale(clampedValue, 0.5)})
        end

        ui7.MouseButton1Down:Connect(
            function()
                --[[
                  line: 589
                  upvalues:
                    v38 (ref,  index: 1)
                    item (copy, index: 2)
                    ui5 (copy, index: 3)
                    knob (copy, index: 4)
                    ui2 (ref,  index: 5)
                    ui (copy, index: 6)
                    theme (copy, index: 7)
                ]]
                v38 = {item = item, track = ui5, knob = knob}

                if ui2 then
                    ui2.ScrollingEnabled = false
                end

                ui.Tween(ui.GetScaleObj(knob), theme.Tween.PopSmall, {Scale = 1.2})
            end
        )
    end

    local function sessionSwitch(a136)
        --[[
          name: sessionSwitch
          line: 599
          upvalues:
            a18 (copy, index: 1)
        ]]
        if a136 == "moveDebug" then
            return a18.MoveDebugShown, a18.MoveDebugToggle
        end
        if a136 == "bodySmoothing" then
            return a18.BodySmoothingOn, a18.BodySmoothingToggle
        end
        if a136 == "premiumTest" then
            return a18.PremiumTestOn, a18.PremiumTestToggle
        end

        return nil, nil
    end

    local function switchRow(ui2, layoutOrder, item)
        --[[
          name: switchRow
          line: 610
          upvalues:
            rowBase (copy, index: 1)
            ui (copy, index: 2)
            v37 (ref,  index: 3)
            textBlock (copy, index: 4)
            hookRowFeedback (copy, index: 5)
            selectedObject (ref,  index: 6)
            v27 (ref,  index: 7)
            a18 (copy, index: 8)
            SettingsStore (copy, index: 9)
            v28 (ref,  index: 10)
        ]]
        local key = item.key
        local parent, v143 = rowBase("TextButton", ui2, layoutOrder, item)
        local v144 = ui.Switch({Width = v37.switchW, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -v37.pad, 0.5, 0), Parent = parent})
        textBlock(parent, item, v37.switchW)
        hookRowFeedback(parent, v143)
        selectedObject = selectedObject or parent

        v27[key] = function(a145, a146)
            --[[
              line: 623
              upvalues:
                item (copy, index: 1)
                key (copy, index: 2)
                a18 (copy, index: 3)
                v144 (copy, index: 4)
            ]]
            local v147

            if not item.session then
                v144:Set(0.5 <= a145, a146)
                return
            end

            local key2 = key

            if key2 == "moveDebug" then
                v147 = a18.MoveDebugShown
                local _ = a18.MoveDebugToggle
            elseif key2 == "bodySmoothing" then
                v147 = a18.BodySmoothingOn
                local _ = a18.BodySmoothingToggle
            elseif key2 == "premiumTest" then
                v147 = a18.PremiumTestOn
                local _ = a18.PremiumTestToggle
            else
                v147 = nil
            end

            local v152 = v147 ~= nil and v147() == true
            v144:Set(v152, a146)
        end

        local function flip()
            --[[
              name: flip
              line: 631
              upvalues:
                item (copy, index: 1)
                key (copy, index: 2)
                a18 (copy, index: 3)
                v144 (copy, index: 4)
                SettingsStore (copy, index: 5)
            ]]
            if not item.session then
                local pitch
                local v155 = SettingsStore.Get(key) < 0.5
                local set = SettingsStore.Set
                local v157 = v155 and 1 or 0
                set(key, v157, true)
                local play = a18.Sounds.Play
                local v159 = {}

                if v155 then
                    pitch = 1.08
                else
                    pitch = 0.94
                end

                v159.pitch = pitch
                play("Click", v159)

                return
            end

            local v160, v161
            local pitch
            local key2 = key

            if key2 == "moveDebug" then
                v161 = a18.MoveDebugShown
                v160 = a18.MoveDebugToggle
            elseif key2 == "bodySmoothing" then
                v161 = a18.BodySmoothingOn
                v160 = a18.BodySmoothingToggle
            elseif key2 == "premiumTest" then
                v161 = a18.PremiumTestOn
                v160 = a18.PremiumTestToggle
            else
                v160, v161 = nil, nil
            end

            if v160 then
                v160()
            end

            local v164 = false

            if v161 == nil then
                v164 = a18
            else
                v164 = v161() == true
                v164 = a18
            end

            v144:Set(v164, false)
            local play = v164.Sounds.Play
            local v166 = {}

            if v164 then
                pitch = 1.08
            else
                pitch = 0.94
            end

            v166.pitch = pitch
            play("Click", v166)
        end

        v28[key] = flip
        parent.Activated:Connect(flip)
    end

    local function actionRow(ui2, layoutOrder, item)
        --[[
          name: actionRow
          line: 650
          upvalues:
            rowBase (copy, index: 1)
            ui (copy, index: 2)
            v37 (ref,  index: 3)
            fonts (copy, index: 4)
            colors (copy, index: 5)
            textBlock (copy, index: 6)
            hookRowFeedback (copy, index: 7)
            selectedObject (ref,  index: 8)
            a18 (copy, index: 9)
        ]]
        local parent, v172 = rowBase("TextButton", ui2, layoutOrder, item)
        local v173 = item.button and 120 or 90
        local parent2 = ui.new("Frame", {Name = "Edit", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -v37.pad, 0.5, 0), Size = UDim2.fromOffset(v173, v37.label + 8), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})
        ui.new("TextLabel", {Name = "Text", LayoutOrder = 1, Text = item.button or "EDIT", FontFace = fonts.Heavy, TextSize = v37.value, TextColor3 = colors.Accent, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Parent = parent2})
        ui.Icon("chevRight", v37.value, colors.Accent, {LayoutOrder = 2, Parent = parent2})
        textBlock(parent, item, v173)
        hookRowFeedback(parent, v172)
        selectedObject = selectedObject or parent

        parent.Activated:Connect(
            function()
                --[[
                  line: 676
                  upvalues:
                    a18 (copy, index: 1)
                    item (copy, index: 2)
                ]]
                a18.Sounds.Play("Click")

                if item.run ~= "replayNewPlayer" and item.run ~= "replayFullHub" then
                    if item.run == "showNews" then
                        a18.MenuManager.Open("News")
                        return
                    end

                    if a18.OpenTouchEditor then
                        a18.OpenTouchEditor()
                    end

                    return
                end

                if a18.ReplayNewPlayer then
                    task.spawn(a18.ReplayNewPlayer, item.run == "replayFullHub")
                end
            end
        )
    end

    local v175 = {}
    local v176 = nil

    for _, action in Keybinds.ACTIONS do
        if action.group ~= "items" or action.max ~= 1 then
            table.insert(v175, {items = false, label = action.label, ids = {action.id}})
        else
            if not v176 then
                v176 = {label = "ITEMS", items = true, ids = {}}
                table.insert(v175, v176)
            end

            table.insert(v176.ids, action.id)
        end
    end

    local v179 = {}
    local v180 = nil
    local ui4 = nil
    local count2 = 0
    local void = colors.Void
    local ui5 = nil

    local function paintChip(a186)
        --[[
          name: paintChip
          line: 716
          upvalues:
            Keybinds (copy, index: 1)
            colors (copy, index: 2)
            ui5 (ref,  index: 3)
        ]]
        local v187 = Keybinds.Get(a186.id)
        local v188 = v187[a186.slot]
        a186.label.Text = not v188 and "—"
            or (if a186.items then Keybinds.CapFor(v188) or "?" else Keybinds.Display(v188))
        a186.label.TextColor3 = if v188 then colors.Text else colors.TextMuted
        a186.button.BackgroundTransparency = v188 and 0.35 or 0.72

        if ui5 ~= a186.button then
            a186.stroke.Color = colors.Stroke
            a186.stroke.Transparency = v188 and 0.8 or 0.9
        end
    end

    local function paintKeybinds()
        --[[
          name: paintKeybinds
          line: 726
          upvalues:
            v179 (ref,  index: 1)
            paintChip (copy, index: 2)
            v180 (ref,  index: 3)
            Keybinds (copy, index: 4)
        ]]
        for _, v191 in v179 do
            for _, v193 in v191 do
                paintChip(v193)
            end
        end

        if v180 then
            v180:SetEnabled(not Keybinds.AllDefault())
        end
    end

    local function flashChips(a195)
        --[[
          name: flashChips
          line: 736
          upvalues:
            v179 (ref,  index: 1)
            colors (copy, index: 2)
            ui (copy, index: 3)
            void (copy, index: 4)
            paintChip (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local v196 = v179[a195] or {}

        for _, v198 in v196 do
            v198.button.BackgroundColor3 = colors.AccentDark
            v198.button.BackgroundTransparency = 0.05
            ui.Tween(v198.button, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = void})

            task.delay(
                0.7,
                function()
                    --[[
                      line: 741
                      upvalues:
                        v198 (copy, index: 1)
                        paintChip (copy, index: 2)
                    ]]
                    if v198.button.Parent then
                        paintChip(v198)
                    end
                end
            )

            ui.Pop(v198.button, 0.25, theme.Tween.PopSmall)
        end
    end

    local function notice(text)
        --[[
          name: notice
          line: 749
          upvalues:
            ui4 (ref,  index: 1)
            count2 (ref,  index: 2)
            ui (copy, index: 3)
            theme (copy, index: 4)
        ]]
        local ui2 = ui4
        if not ui2 then
            return
        end

        count2 += 1
        local v202 = count2
        ui2.Text = text
        ui2.TextTransparency = 0

        task.delay(
            4,
            function()
                --[[
                  line: 758
                  upvalues:
                    v202 (copy, index: 1)
                    count2 (ref,  index: 2)
                    ui2 (copy, index: 3)
                    ui (copy, index: 4)
                    theme (copy, index: 5)
                ]]
                if v202 == count2 and ui2.Parent then
                    ui.Tween(ui2, theme.Tween.Smooth, {TextTransparency = 1})
                end
            end
        )
    end

    local function actionLabel(a204)
        --[[
          name: actionLabel
          line: 764
          upvalues:
            Keybinds (copy, index: 1)
        ]]
        return if const v205 = Keybinds.Action(a204) then v205.label else a204
    end

    local v206 = nil
    local v207 = nil
    local count3 = 0
    local sel = nil
    local v210 = 0

    local function releaseSink()
        --[[
          name: releaseSink
          line: 786
          upvalues:
            v206 (ref, index: 1)
        ]]
        local v212 = v206

        if v212 and v212.box:IsFocused() then
            v212.box:ReleaseFocus()
        end
    end

    local function closeCapture()
        --[[
          name: closeCapture
          line: 792
          upvalues:
            v207 (ref,  index: 1)
            count3 (ref,  index: 2)
            a18 (copy, index: 3)
            v206 (ref,  index: 4)
            v210 (ref,  index: 5)
            sel (ref,  index: 6)
            v25 (copy, index: 7)
            ui (copy, index: 8)
            guiService (copy, index: 9)
        ]]
        local v214 = v207
        v207 = nil
        count3 += 1
        a18.PadCapturing = false

        if v206 then
            v206.layer.Visible = false
        end

        local v215 = v206

        if v215 and v215.box:IsFocused() then
            v215.box:ReleaseFocus()
        end

        if v214 and v214.pad then
            v210 = os.clock() + 0.25
            local sel2 = v214.sel
            sel = sel2

            if sel2 and v25.IsOpen and ui.Gamepad and sel2.Parent and guiService.SelectedObject == nil then
                guiService.SelectedObject = sel2
            end
        end
    end

    local function padIdle()
        --[[
          name: padIdle
          line: 811
          upvalues:
            v206 (ref,  index: 1)
            v207 (ref,  index: 2)
            colors (copy, index: 3)
        ]]
        local v218 = v206
        local pad = v207 ~= nil and v207.pad == true
        v218.line1.Text = pad and "PRESS A BUTTON" or "PRESS A KEY"
        v218.line1.TextColor3 = colors.Text
        v218.line2.Text = "or click here with a mouse button"
        v218.line2.Visible = not pad
        v218.holdHint.Visible = pad
        v218.padStroke.Color = colors.Accent
    end

    local function refuse(text)
        --[[
          name: refuse
          line: 821
          upvalues:
            v206 (ref,  index: 1)
            count3 (ref,  index: 2)
            v207 (ref,  index: 3)
            colors (copy, index: 4)
            ui (copy, index: 5)
            a18 (copy, index: 6)
        ]]
        local v222 = v206
        count3 += 1
        local v223 = count3
        local pad = v207 ~= nil and v207.pad == true
        v222.line1.Text = string.upper(text)
        v222.line1.TextColor3 = colors.Danger
        v222.line2.Text = pad and "Pick another button" or "Pick another key"
        v222.line2.Visible = true
        v222.holdHint.Visible = false
        v222.padStroke.Color = colors.Danger
        ui.Shake(v222.pad, 6)
        a18.Sounds.Play("Error")

        task.delay(
            1.8,
            function()
                --[[
                  line: 834
                  upvalues:
                    v223 (copy, index: 1)
                    count3 (ref,  index: 2)
                    v207 (ref,  index: 3)
                    v206 (ref,  index: 4)
                    colors (copy, index: 5)
                ]]
                if v223 == count3 and v207 then
                    local v225 = v206
                    local pad = v207 ~= nil and v207.pad == true
                    v225.line1.Text = pad and "PRESS A BUTTON" or "PRESS A KEY"
                    v225.line1.TextColor3 = colors.Text
                    v225.line2.Text = "or click here with a mouse button"
                    v225.line2.Visible = not pad
                    v225.holdHint.Visible = pad
                    v225.padStroke.Color = colors.Accent
                end
            end
        )
    end

    local function commit(name: string)
        --[[
          name: commit
          line: 840
          upvalues:
            v207 (ref,  index: 1)
            closeCapture (copy, index: 2)
            Keybinds (copy, index: 3)
            a18 (copy, index: 4)
            SettingsStore (copy, index: 5)
            flashChips (copy, index: 6)
            ui4 (ref,  index: 7)
            count2 (ref,  index: 8)
            ui (copy, index: 9)
            theme (copy, index: 10)
        ]]
        local v229 = v207
        if not v229 then
            return
        end

        closeCapture()
        local v230, v231, v232 = Keybinds.Assign(v229.id, v229.slot, name)

        if #v230 == 0 then
            a18.Sounds.Play("Click")
            return
        end

        SettingsStore.SaveKeybinds(v230)
        a18.Sounds.Play("Select")
        flashChips(v229.id)

        if v231 then
            flashChips(v231)
            local v233 = v232 or {}

            if #v233 == 0 then
                local stringFormat = string.format
                local v236 = if const v235 = Keybinds.Action(v231) then v235.label else v231
                local text = stringFormat("%s IS NOW UNBOUND", v236)
                local ui2 = ui4
                if not ui2 then
                    return
                end

                count2 += 1
                local v239 = count2
                ui2.Text = text
                ui2.TextTransparency = 0

                task.delay(
                    4,
                    function()
                        --[[
                          line: 758
                          upvalues:
                            v239 (copy, index: 1)
                            count2 (ref,  index: 2)
                            ui2 (copy, index: 3)
                            ui (copy, index: 4)
                            theme (copy, index: 5)
                        ]]
                        if v239 == count2 and ui2.Parent then
                            ui.Tween(ui2, theme.Tween.Smooth, {TextTransparency = 1})
                        end
                    end
                )

                return
            end

            local stringFormat = string.format
            local v242 = if const v241 = Keybinds.Action(v231) then v241.label else v231
            local text = stringFormat("SWAPPED · %s NOW USES %s", v242, Keybinds.Display(v233[1]))
            local ui3 = ui4
            if not ui3 then
                return
            end

            count2 += 1
            local v245 = count2
            ui3.Text = text
            ui3.TextTransparency = 0

            task.delay(
                4,
                function()
                    --[[
                      line: 758
                      upvalues:
                        v245 (copy, index: 1)
                        count2 (ref,  index: 2)
                        ui3 (copy, index: 3)
                        ui (copy, index: 4)
                        theme (copy, index: 5)
                    ]]
                    if v245 == count2 and ui3.Parent then
                        ui.Tween(ui3, theme.Tween.Smooth, {TextTransparency = 1})
                    end
                end
            )
        end
    end

    local function buildCapture()
        --[[
          name: buildCapture
          line: 864
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            theme (copy, index: 3)
            v25 (copy, index: 4)
            closeCapture (copy, index: 5)
            fonts (copy, index: 6)
            v207 (ref,  index: 7)
            Keybinds (copy, index: 8)
            SettingsStore (copy, index: 9)
            flashChips (copy, index: 10)
        ]]
        local newUi = ui.new
        local v248 = {Name = "KeyCapture", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, Visible = false, ZIndex = 50, [1] = (ui.Corner((theme.Radius.Window
            or UDim.new(0, 18)))), Parent = v25.Holder}
        local ui2 = newUi("TextButton", v248)
        ui2.Activated:Connect(closeCapture)
        local v250 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(480, 330), Radius = UDim.new(0, 16), Parent = ui2})
        ui.new("TextButton", {Name = "Sink", BackgroundTransparency = 1, Text = "", Selectable = false, ZIndex = 51, Size = UDim2.fromScale(1, 1), Parent = v250})
        local eyebrow = ui.new("TextLabel", {Name = "Eyebrow", Text = "REBIND", TextSize = 15, ZIndex = 52, Position = UDim2.fromOffset(0, 22), Size = UDim2.new(1, 0, 0, 18), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, Parent = v250})
        local title = ui.DisplayText({Name = "Title", Text = "", TextSize = 34, ZIndex = 52, Position = UDim2.fromOffset(0, 42), Size = UDim2.new(1, 0, 0, 38), TextColor3 = colors.Text, Parent = v250})
        local now = ui.new("TextLabel", {Name = "Now", Text = "", TextSize = 16, RichText = true, ZIndex = 52, Position = UDim2.fromOffset(0, 82), Size = UDim2.new(1, 0, 0, 20), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = v250})
        local ui3 = ui.new("Frame", {Name = "NowPad", Position = UDim2.fromOffset(0, 80), Size = UDim2.new(1, 0, 0, 24), Visible = false, (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = v250})
        ui.new("TextLabel", {Name = "Label", Text = "NOW", TextSize = 16, LayoutOrder = 1, ZIndex = 52, FontFace = fonts.Bold, TextColor3 = colors.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Parent = ui3})
        local nowCap = ui.PadCap(Enum.KeyCode.ButtonA, {Height = 24, LayoutOrder = 2, ZIndex = 52, Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Pad", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 114), Size = UDim2.new(1, -56, 0, 112), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.4, ZIndex = 52, (ui.Corner(14)), Parent = v250})
        local padStroke = ui.Stroke(colors.Accent, 2, 0.1)
        padStroke.Parent = ui4
        local v258 = ui.DisplayText({Name = "Line1", Text = "PRESS A KEY", TextSize = 28, TextScaled = true, ZIndex = 53, Position = UDim2.fromOffset(12, 26), Size = UDim2.new(1, -24, 0, 32), TextColor3 = colors.Text, Parent = ui4})
        ui.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 12, Parent = v258})
        local line2 = ui.new("TextLabel", {Name = "Line2", Text = "", TextSize = 17, ZIndex = 53, Position = UDim2.fromOffset(12, 64), Size = UDim2.new(1, -24, 0, 20), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "HoldHint", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 62), Size = UDim2.new(1, -24, 0, 26), Visible = false, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = ui4})

        local function hintText(text: string, layoutOrder: number)
            --[[
              name: hintText
              line: 990
              upvalues:
                ui (copy, index: 1)
                fonts (copy, index: 2)
                colors (copy, index: 3)
                ui5 (copy, index: 4)
            ]]
            ui.new("TextLabel", {TextSize = 17, ZIndex = 53, Name = "T" .. layoutOrder, Text = text, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), LayoutOrder = layoutOrder, Parent = ui5})
        end

        hintText("Hold", 1)
        local holdCap = ui.PadCap(Enum.KeyCode.ButtonB, {Height = 24, LayoutOrder = 2, ZIndex = 53, Parent = ui5})
        hintText("to cancel", 3)
        local ui6 = ui.new("Frame", {Name = "Hold", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -40, 0, 4), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.5, Visible = false, ZIndex = 53, (ui.Corner(theme.Radius.Pill)), Parent = ui4})
        local holdFill = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Danger, ZIndex = 54, (ui.Corner(theme.Radius.Pill)), Parent = ui6})

        local clear = ui.Button(
            {
                Name = "Clear",
                Text = "CLEAR",
                TextSize = 20,
                Style = "Dark",
                ZIndex = 53,
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 28, 1, -24),
                Size = UDim2.fromOffset(200, 54),
                Parent = v250,
                OnClick = (function()
                    --[[
                      name: OnClick
                      line: 1037
                      upvalues:
                        v207 (ref,  index: 1)
                        closeCapture (copy, index: 2)
                        Keybinds (copy, index: 3)
                        SettingsStore (copy, index: 4)
                        flashChips (copy, index: 5)
                    ]]
                    local v268 = v207
                    if not v268 then
                        return
                    end

                    closeCapture()
                    local v269 = Keybinds.Get(v268.id)

                    if v269[v268.slot] then
                        Keybinds.Clear(v268.id, v268.slot)
                        SettingsStore.SaveKeybinds({v268.id})
                        flashChips(v268.id)
                    end
                end)
            }
        )

        local cancel = ui.Button({Name = "Cancel", Text = "CANCEL", TextSize = 20, Style = "Dark", ZIndex = 53, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = UDim2.fromOffset(200, 54), Parent = v250, OnClick = closeCapture})
        local box = ui.new("TextBox", {Name = "KeySink", BackgroundTransparency = 1, TextTransparency = 1, Text = "", ClearTextOnFocus = true, Selectable = false, ZIndex = 50, Size = UDim2.fromOffset(1, 1), Parent = ui2})
        box.FocusLost:Connect(
            function()
                --[[
                  line: 1075
                  upvalues:
                    v207 (ref,  index: 1)
                    ui2 (copy, index: 2)
                    box (copy, index: 3)
                ]]
                task.defer(
                    function()
                        --[[
                          line: 1076
                          upvalues:
                            v207 (ref,  index: 1)
                            ui2 (copy, index: 2)
                            box (copy, index: 3)
                        ]]
                        if v207 and not v207.pad and ui2.Visible and not box:IsFocused() then
                            box:CaptureFocus()
                        end
                    end
                )
            end
        )

        box:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 1082
                  upvalues:
                    box (copy, index: 1)
                ]]
                if box.Text ~= "" then
                    box.Text = ""
                end
            end
        )

        ui.Every(
            ui2,
            0.03333333333333333,
            function()
                --[[
                  line: 1087
                  upvalues:
                    ui2 (copy, index: 1)
                    v207 (ref,  index: 2)
                    padStroke (copy, index: 3)
                ]]
                if ui2.Visible and v207 then
                    padStroke.Transparency = (((math.sin(os.clock() * 5) * 0.5) + 0.5) * 0.35) + 0.15
                end
            end
        )

        return {layer = ui2, card = v250, eyebrow = eyebrow, title = title, now = now, pad = ui4, padStroke = padStroke, line1 = v258, line2 = line2, clear = clear, cancel = cancel, box = box, nowPad = ui3, nowCap = nowCap, holdHint = ui5, holdCap = holdCap, hold = ui6, holdFill = holdFill}
    end

    local function openCapture(id, a274)
        --[[
          name: openCapture
          line: 1098
          upvalues:
            v206 (ref,  index: 1)
            buildCapture (copy, index: 2)
            Keybinds (copy, index: 3)
            v207 (ref,  index: 4)
            count3 (ref,  index: 5)
            a18 (copy, index: 6)
            colors (copy, index: 7)
            ui (copy, index: 8)
        ]]
        local text
        v206 = v206 or buildCapture()
        local v276 = v206
        local v277 = Keybinds.Get(id)
        local slot = math.clamp(a274, 1, #v277 + 1)
        v207 = {id = id, slot = slot, at = os.clock()}
        count3 += 1
        local v279 = Keybinds.Action(id)
        local eyebrow = v276.eyebrow

        if not (1 < slot) then
            text = "REBIND"
        else
            text = "SECOND KEY FOR"
        end

        eyebrow.Text = text
        v276.title.Text = if v279 then v279.label else id
        local v281 = v277[slot]
        local rich = a18.Loc.Rich
        local now = v276.now
        local v284 = not v281 and "NOT BOUND"
            or string.format("NOW  <font color=\"#FFFFFF\">%s</font>", Keybinds.Display(v281))
        rich(now, v284)
        v276.now.Visible = true
        v276.nowPad.Visible = false
        v276.hold.Visible = false
        v276.cancel.Instance.Visible = true
        v276.card.Size = UDim2.fromOffset(480, 330)
        local v285 = v206
        local pad = v207 ~= nil and v207.pad == true
        v285.line1.Text = pad and "PRESS A BUTTON" or "PRESS A KEY"
        v285.line1.TextColor3 = colors.Text
        v285.line2.Text = "or click here with a mouse button"
        v285.line2.Visible = not pad
        v285.holdHint.Visible = pad
        v285.padStroke.Color = colors.Accent
        local visible = v281 ~= nil
        v276.clear.Instance.Visible = visible
        v276.cancel.Instance.AnchorPoint = if visible then Vector2.new(1, 1) else Vector2.new(0.5, 1)
        v276.cancel.Instance.Position = if visible then UDim2.new(1, -28, 1, -24) else UDim2.new(0.5, 0, 1, -24)
        v276.layer.Visible = true
        ui.Enter(v276.card, Vector2.new(0, 14), 0, UDim2.fromScale(0.5, 0.5))
        a18.Sounds.Play("Click")

        task.defer(
            function()
                --[[
                  line: 1125
                  upvalues:
                    v207 (ref,  index: 1)
                    v276 (copy, index: 2)
                ]]
                if v207 and not v276.box:IsFocused() then
                    v276.box:CaptureFocus()
                end
            end
        )
    end

    local function inside(a289, vector2: Vector2)
        --[[
          name: inside
          line: 1131
        ]]
        if not a289.Visible then
            return false
        end

        local absolutePosition = a289.AbsolutePosition
        local absoluteSize = a289.AbsoluteSize
        local v293 = false
        local x = vector2.X

        if absolutePosition.X <= x then
            v293 = false
            local y = vector2.Y

            if absolutePosition.Y <= y then
                return vector2.X <= absolutePosition.X + absoluteSize.X
                    and vector2.Y <= absolutePosition.Y + absoluteSize.Y
            end
        end

        return v293
    end

    userInputService.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 1138
              upvalues:
                v206 (ref,  index: 1)
                v207 (ref,  index: 2)
                Keybinds (copy, index: 3)
                commit (copy, index: 4)
                refuse (copy, index: 5)
                closeCapture (copy, index: 6)
                inside (copy, index: 7)
            ]]
            local v297 = v206

            if not v207 or not v297 or v207.pad then
                return
            end

            local userInputType = input.UserInputType

            if userInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Unknown then
                    return
                end

                local name = input.KeyCode.Name
                local v300, v301 = Keybinds.Bindable(name)
                if v300 then
                    commit(name)
                    return
                end

                refuse((v301 or "That key can't be used"))

                return
            end

            if userInputType == Enum.UserInputType.MouseButton1
                or userInputType == Enum.UserInputType.MouseButton2
                or userInputType == Enum.UserInputType.MouseButton3
            then
                local vector2 = Vector2.new(input.Position.X, input.Position.Y)

                if inside(v297.pad, vector2) then
                    commit(userInputType.Name)
                    return
                end

                if inside(v297.card, vector2) then
                    return
                end

                if userInputType ~= Enum.UserInputType.MouseButton1 then
                    closeCapture()
                end
            end
        end
    )

    local function keyChip(parent, id, slot: number, a307, items: boolean, layoutOrder)
        --[[
          name: keyChip
          line: 1168
          upvalues:
            ui (copy, index: 1)
            v37 (ref,  index: 2)
            void (copy, index: 3)
            colors (copy, index: 4)
            fonts (copy, index: 5)
            ui5 (ref,  index: 6)
            theme (copy, index: 7)
            Keybinds (copy, index: 8)
            openCapture (copy, index: 9)
            v179 (ref,  index: 10)
            paintChip (copy, index: 11)
        ]]
        local ui2 = ui.new("TextButton", {Name = id .. "_" .. slot, Size = UDim2.fromOffset(a307, v37.chipH), BackgroundColor3 = void, BackgroundTransparency = 0.35, AutoButtonColor = false, Text = "", Selectable = false, LayoutOrder = layoutOrder, (ui.Corner(8)), Parent = parent})
        local stroke = ui.Stroke(colors.Stroke, 1, 0.8)
        stroke.Parent = ui2
        local ui3 = ui.new("TextLabel", {Name = "Key", AutoLocalize = false, Text = "", TextScaled = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -10, 0, v37.chipText + 2), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = ui2})
        ui.new("UITextSizeConstraint", {MinTextSize = 9, MaxTextSize = v37.chipText, Parent = ui3})
        local v313 = {button = ui2, label = ui3, stroke = stroke, id = id, slot = slot, items = items}

        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 1197
                  upvalues:
                    ui5 (ref,  index: 1)
                    ui2 (copy, index: 2)
                    ui (copy, index: 3)
                    stroke (copy, index: 4)
                    theme (copy, index: 5)
                    colors (copy, index: 6)
                ]]
                ui5 = ui2
                ui.Tween(stroke, theme.Tween.Fast, {Transparency = 0.1, Color = colors.Accent})
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 1201
                  upvalues:
                    ui5 (ref,  index: 1)
                    ui2 (copy, index: 2)
                    ui (copy, index: 3)
                    stroke (copy, index: 4)
                    theme (copy, index: 5)
                    colors (copy, index: 6)
                    Keybinds (copy, index: 7)
                    id (copy, index: 8)
                    slot (copy, index: 9)
                ]]
                local transparency

                if ui5 == ui2 then
                    ui5 = nil
                end

                local tween = ui.Tween
                local fast = theme.Tween.Fast
                local v317 = {Color = colors.Stroke}

                if Keybinds.Get(id)[slot] then
                    transparency = 0.8
                else
                    transparency = 0.9
                end

                v317.Transparency = transparency
                tween(stroke, fast, v317)
            end
        )

        ui2.Activated:Connect(
            function()
                --[[
                  line: 1207
                  upvalues:
                    openCapture (copy, index: 1)
                    id (copy, index: 2)
                    slot (copy, index: 3)
                ]]
                openCapture(id, slot)
            end
        )
        local v318 = v179
        local v319 = v179[id] or {}
        v318[id] = v319
        table.insert(v179[id], v313)
        paintChip(v313)

        return v313
    end

    local function keybindSection(parent, layoutOrder: number)
        --[[
          name: keybindSection
          line: 1216
          upvalues:
            v179 (ref,  index: 1)
            v37 (ref,  index: 2)
            v175 (copy, index: 3)
            ui (copy, index: 4)
            v180 (ref,  index: 5)
            closeCapture (copy, index: 6)
            Keybinds (copy, index: 7)
            SettingsStore (copy, index: 8)
            flashChips (copy, index: 9)
            ui4 (ref,  index: 10)
            count2 (ref,  index: 11)
            theme (copy, index: 12)
            fonts (copy, index: 13)
            colors (copy, index: 14)
            keyChip (copy, index: 15)
            paintKeybinds (copy, index: 16)
        ]]
        local textSize
        v179 = {}
        local kbHeader = v37.kbHeader
        local v325 = #v175 * v37.kbRowH
        local parent2 = ui.new("Frame", {Name = "KEYBINDS", Size = UDim2.new(1, 0, 0, (kbHeader + v37.titleGap) + v325), LayoutOrder = layoutOrder, Parent = parent})
        local v327 = v37.title + 8
        ui.SectionTitle("CONTROLS", {Position = UDim2.fromOffset(0, kbHeader - v327), Size = UDim2.new(1, 0, 0, v327), TextSize = v37.title, Parent = parent2})
        local button = ui.Button
        local v329 = {Name = "ResetKeys", Text = "RESET TO DEFAULTS", Style = "Dark", Radius = 9}

        if ui.Compact then
            textSize = 16
        else
            textSize = 14
        end

        v329.TextSize = textSize
        v329.AnchorPoint = Vector2.new(1, 1)
        v329.Position = UDim2.new(1, 0, 0, kbHeader)
        local udim2FromOffset = UDim2.fromOffset
        local v331 = ui.Compact and 214 or 186
        v329.Size = udim2FromOffset(v331, kbHeader - 2)
        v329.Parent = parent2

        function v329.OnClick()
            --[[
              name: OnClick
              line: 1243
              upvalues:
                closeCapture (copy, index: 1)
                Keybinds (copy, index: 2)
                SettingsStore (copy, index: 3)
                flashChips (copy, index: 4)
                ui4 (ref,  index: 5)
                count2 (ref,  index: 6)
                ui (copy, index: 7)
                theme (copy, index: 8)
            ]]
            closeCapture()
            local v332 = Keybinds.ResetAll()

            if 0 < #v332 then
                SettingsStore.SaveKeybinds(v332)

                for _, v334 in v332 do
                    flashChips(v334)
                end

                local ui2 = ui4
                if not ui2 then
                    return
                end

                count2 += 1
                local v336 = count2
                ui2.Text = "EVERY KEY IS BACK TO ITS DEFAULT"
                ui2.TextTransparency = 0

                task.delay(
                    4,
                    function()
                        --[[
                          line: 758
                          upvalues:
                            v336 (copy, index: 1)
                            count2 (ref,  index: 2)
                            ui2 (copy, index: 3)
                            ui (copy, index: 4)
                            theme (copy, index: 5)
                        ]]
                        if v336 == count2 and ui2.Parent then
                            ui.Tween(ui2, theme.Tween.Smooth, {TextTransparency = 1})
                        end
                    end
                )
            end
        end

        v180 = button(v329)
        local newUi = ui.new
        local v338 = {Name = "Notice", Text = "", TextTransparency = 1, AnchorPoint = Vector2.new(1, 1)}
        local newUDim2 = UDim2.new
        local v340 = ui.Compact and 214 or 186
        v338.Position = newUDim2(1, -(v340 + 12), 0, kbHeader - 4)
        newUDim2 = UDim2.new
        local v341 = ui.Compact and 214 or 186
        v338.Size = newUDim2(1, -((v341 + 12) + 150), 0, v327)
        v338.FontFace = fonts.Heavy
        v338.TextSize = ui.Compact and 15 or 13
        v338.TextColor3 = colors.Warning
        v338.TextXAlignment = Enum.TextXAlignment.Right
        v338.TextTruncate = Enum.TextTruncate.AtEnd
        v338.Parent = parent2
        ui4 = newUi("TextLabel", v338)
        local newUi2 = ui.new
        local v343 = {Name = "Card", Position = UDim2.fromOffset(0, kbHeader + v37.titleGap), Size = UDim2.new(1, 0, 0, v325), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3}
        v343[1], v343[2], v343[3] = ui.Corner(12), ui.Stroke(colors.Stroke, 1, 0.92), (ui.List(Enum.FillDirection.Vertical, 0))
        v343.Parent = parent2
        local parent3 = newUi2("Frame", v343)
        local v345 = v37.chipW * 2 + v37.chipGap

        for layoutOrder2, v347 in v175 do
            local parent4 = ui.new("Frame", {Name = v347.ids[1], Size = UDim2.new(1, 0, 0, v37.kbRowH), LayoutOrder = layoutOrder2, Parent = parent3})

            if 1 < layoutOrder2 then
                ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = colors.Stroke, Position = UDim2.fromOffset(v37.pad, 0), Size = UDim2.new(1, -v37.pad * 2, 0, 1), Parent = parent4})
            end

            ui.new("TextLabel", {Name = "Label", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, v37.pad, 0.5, 0), Size = UDim2.new(1, -(((v37.pad * 2) + v345) + 12), 0, v37.label + 4), Text = v347.label, FontFace = fonts.Heavy, TextSize = v37.label, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent4})
            local newUi3 = ui.new
            local v350 = {Name = "Keys", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -v37.pad, 0.5, 0), Size = UDim2.fromOffset(v345, v37.chipH)}
            local list = ui.List
            local horizontal = Enum.FillDirection.Horizontal
            local v353 = if v347.items then v37.itemGap else v37.chipGap
            v350[1] = (list(horizontal, v353, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center))
            v350.Parent = parent4
            local ui2 = newUi3("Frame", v350)

            if v347.items then
                local idsLength = #v347.ids
                local flooredValue = math.floor((v345 - ((idsLength - 1) * v37.itemGap)) / idsLength)

                for layoutOrder3, id in v347.ids do
                    keyChip(ui2, id, 1, flooredValue, true, layoutOrder3)
                end
            else
                local v359 = Keybinds.Action(v347.ids[1])

                for index = 1, v359.max do
                    keyChip(ui2, v359.id, index, v37.chipW, false, index)
                end
            end
        end

        paintKeybinds()

        return parent2
    end

    Keybinds.Changed:Connect(paintKeybinds)
    local v361 = {}
    local v362 = {}
    local v363 = nil
    local ui6 = nil
    local ui7 = nil
    local v366 = nil
    local count4 = 0
    local selectionImageObject2 = ui.new("Frame", {Name = "ChipSelection", Position = UDim2.fromOffset(-4, -4), Size = UDim2.new(1, 8, 1, 8), BackgroundTransparency = 1, ui.Corner(12), ui.Stroke(colors.Accent, 2, 0)})

    local function padCode(key)
        --[[
          name: padCode
          line: 1357
        ]]
        if not key then
            return nil
        end

        local success, result = pcall(
            function()
                --[[
                  line: 1361
                  upvalues:
                    key (copy, index: 1)
                ]]
                return Enum.KeyCode[key]
            end
        )
        if success then
            return result
        end

        return nil
    end

    local function padLabel(a374)
        --[[
          name: padLabel
          line: 1366
          upvalues:
            Keybinds (copy, index: 1)
        ]]
        return if const v375 = Keybinds.PadAction(a374) then v375.label else a374
    end

    local function paintPadChip(a377)
        --[[
          name: paintPadChip
          line: 1370
          upvalues:
            Keybinds (copy, index: 1)
            ui (copy, index: 2)
        ]]
        local result
        local v379 = Keybinds.PadGet(a377.id)
        local v380 = v379[a377.slot]
        local setCapPad = ui.SetCapPad
        local cap = a377.cap

        if v380 then
            local success, result2 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        v380 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v380]
                end
            )

            if success then
                result = result2
            else
                result = nil
            end
        else
            result = nil
        end

        setCapPad(cap, result)
        a377.dash.Visible = v380 == nil
        a377.button.BackgroundTransparency = v380 and 0.35 or 0.72
        a377.stroke.Transparency = v380 and 0.8 or 0.9
    end

    local function firstPadChip()
        --[[
          name: firstPadChip
          line: 1377
          upvalues:
            Keybinds (copy, index: 1)
            v361 (ref,  index: 2)
        ]]
        local padAction = Keybinds.PAD_ACTIONS[1]
        local v387 = padAction and v361[padAction.id]

        if v387 and 0 < #v387 then
            return v387[#v387].button
        end

        return nil
    end

    local function paintPadBinds()
        --[[
          name: paintPadBinds
          line: 1382
          upvalues:
            v361 (ref,  index: 1)
            Keybinds (copy, index: 2)
            ui (copy, index: 3)
            v363 (ref,  index: 4)
            guiService (copy, index: 5)
            selectedObject (ref,  index: 6)
        ]]
        for _, v390 in v361 do
            for _, v392 in v390 do
                local result
                local v394 = Keybinds.PadGet(v392.id)
                local v395 = v394[v392.slot]
                local setCapPad = ui.SetCapPad
                local cap = v392.cap

                if v395 then
                    local success, result2 = pcall(
                        function()
                            --[[
                              line: 1361
                              upvalues:
                                v395 (copy, index: 1)
                            ]]
                            return Enum.KeyCode[v395]
                        end
                    )

                    if success then
                        result = result2
                    else
                        result = nil
                    end
                else
                    result = nil
                end

                setCapPad(cap, result)
                v392.dash.Visible = v395 == nil
                v392.button.BackgroundTransparency = v395 and 0.35 or 0.72
                v392.stroke.Transparency = v395 and 0.8 or 0.9
            end
        end

        if v363 then
            local enabled = not Keybinds.PadAllDefault()
            v363:SetEnabled(enabled)
            v363.Instance.Selectable = enabled

            if not enabled and guiService.SelectedObject == v363.Instance then
                local padAction = Keybinds.PAD_ACTIONS[1]
                local v402 = padAction and v361[padAction.id]
                local v403 = if v402 and 0 < #v402 then v402[#v402].button else nil
                guiService.SelectedObject = v403 or selectedObject
            end
        end
    end

    local function flashPadChips(a405)
        --[[
          name: flashPadChips
          line: 1398
          upvalues:
            v361 (ref,  index: 1)
            colors (copy, index: 2)
            ui (copy, index: 3)
            void (copy, index: 4)
            Keybinds (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local v406 = v361[a405] or {}

        for _, v408 in v406 do
            v408.button.BackgroundColor3 = colors.AccentDark
            v408.button.BackgroundTransparency = 0.05
            ui.Tween(v408.button, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = void})

            task.delay(
                0.7,
                function()
                    --[[
                      line: 1403
                      upvalues:
                        v408 (copy, index: 1)
                        Keybinds (copy, index: 2)
                        ui (copy, index: 3)
                    ]]
                    if v408.button.Parent then
                        local result
                        local v410 = v408
                        local v411 = Keybinds.PadGet(v410.id)
                        local v412 = v411[v410.slot]
                        local setCapPad = ui.SetCapPad
                        local cap = v410.cap

                        if v412 then
                            local success, result2 = pcall(
                                function()
                                    --[[
                                      line: 1361
                                      upvalues:
                                        v412 (copy, index: 1)
                                    ]]
                                    return Enum.KeyCode[v412]
                                end
                            )

                            if success then
                                result = result2
                            else
                                result = nil
                            end
                        else
                            result = nil
                        end

                        setCapPad(cap, result)
                        v410.dash.Visible = v412 == nil
                        v410.button.BackgroundTransparency = v412 and 0.35 or 0.72
                        v410.stroke.Transparency = v412 and 0.8 or 0.9
                    end
                end
            )

            ui.Pop(v408.button, 0.25, theme.Tween.PopSmall)
        end
    end

    local function padNote(text, a419)
        --[[
          name: padNote
          line: 1412
          upvalues:
            ui6 (ref,  index: 1)
            ui7 (ref,  index: 2)
            v366 (ref,  index: 3)
            count4 (ref,  index: 4)
            ui (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local ui2 = ui6
        local ui3 = ui7
        local v422 = v366

        if not ui2 or not ui3 or not v422 then
            return
        end

        count4 += 1
        local v423 = count4
        ui3.Text = text
        ui3.TextTransparency = 0
        ui.SetCapFade(v422, 0)
        ui.SetCapPad(v422, a419)
        ui2.Visible = true
        ui2.BackgroundTransparency = 0.1
        ui.Pop(ui2, 0.85, theme.Tween.PopSmall)

        task.delay(
            4,
            function()
                --[[
                  line: 1426
                  upvalues:
                    v423 (copy, index: 1)
                    count4 (ref,  index: 2)
                    ui2 (copy, index: 3)
                    ui (copy, index: 4)
                    ui3 (copy, index: 5)
                    theme (copy, index: 6)
                    v422 (copy, index: 7)
                ]]
                if v423 == count4 and ui2.Parent then
                    ui.Tween(ui3, theme.Tween.Smooth, {TextTransparency = 1})
                    ui.Tween(ui2, theme.Tween.Smooth, {BackgroundTransparency = 1})
                    ui.SetCapFade(v422, 0.6)

                    task.delay(
                        0.35,
                        function()
                            --[[
                              line: 1431
                              upvalues:
                                v423 (copy, index: 1)
                                count4 (ref,  index: 2)
                                ui2 (copy, index: 3)
                            ]]
                            if v423 == count4 and ui2.Parent then
                                ui2.Visible = false
                            end
                        end
                    )
                end
            end
        )
    end

    local function noteMoves(a425)
        --[[
          name: noteMoves
          line: 1441
          upvalues:
            Keybinds (copy, index: 1)
            padNote (copy, index: 2)
        ]]
        if #a425 == 0 then
            return
        end

        local v426 = a425[1].now[1]
        local parts = {}
        local id = a425[1].id
        local v429 = Keybinds.PadAction(id)
        parts[1] = if v429 then v429.label else id
        local count = 0

        for index = 2, #a425 do
            if a425[index].now[1] == v426 then
                local v432 = a425[index].id

                if const v433 = Keybinds.PadAction(v432) then
                    v432 = v433.label
                end

                table.insert(parts, v432)
            else
                count += 1
            end
        end

        local text = table.concat(parts, " AND ")
        local v435 = not (0 < count) and "" or string.format(" (+%d)", count)
        local v436 = text .. v435
        local v437 = 1 < #parts

        if v426 == nil then
            local stringFormat = string.format
            local v439 = v437 and "ARE" or "IS"
            padNote(stringFormat("%s %s NOW UNBOUND", v436, v439), nil)

            return
        end

        local result
        local stringFormat = string.format
        local v442 = v437 and "USE" or "USES"
        local formattedText = stringFormat("SWAPPED · %s NOW %s", v436, v442)

        if v426 then
            local success, result2 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        v426 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v426]
                end
            )

            if success then
                result = result2
            else
                result = nil
            end
        else
            result = nil
        end

        padNote(formattedText, result)
    end

    local function openPadCapture(id, a448, a449)
        --[[
          name: openPadCapture
          line: 1465
          upvalues:
            Keybinds (copy, index: 1)
            v206 (ref,  index: 2)
            buildCapture (copy, index: 3)
            v207 (ref,  index: 4)
            guiService (copy, index: 5)
            count3 (ref,  index: 6)
            a18 (copy, index: 7)
            ui (copy, index: 8)
            colors (copy, index: 9)
            sel (ref,  index: 10)
        ]]
        local result
        local v451 = Keybinds.PadAction(id)
        if not v451 then
            return
        end

        v206 = v206 or buildCapture()
        local v452 = v206
        local v453 = Keybinds.PadGet(id)
        local slot = math.clamp(a448, 1, (math.min(v451.max, #v453 + 1)))
        v207 = {pad = true, id = id, slot = slot, sel = a449 or guiService.SelectedObject, at = os.clock()}
        count3 += 1
        a18.PadCapturing = true
        v452.eyebrow.Text = not (1 < slot) and "REBIND" or "SECOND BUTTON FOR"
        v452.title.Text = v451.label
        local v455 = v453[slot]
        a18.Loc.Rich(v452.now, "NOT BOUND")
        v452.now.Visible = v455 == nil
        v452.nowPad.Visible = v455 ~= nil
        local setCapPad = ui.SetCapPad
        local nowCap = v452.nowCap

        if v455 then
            local success, result2 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        v455 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v455]
                end
            )

            if success then
                result = result2
            else
                result = nil
            end
        else
            result = nil
        end

        setCapPad(nowCap, result)
        ui.SetCapPad(v452.holdCap, Enum.KeyCode.ButtonB)
        v452.hold.Visible = false
        v452.holdFill.Size = UDim2.fromScale(0, 1)
        v452.clear.Instance.Visible = false
        v452.cancel.Instance.Visible = false
        v452.card.Size = UDim2.fromOffset(480, 262)
        local v460 = v206
        local pad = v207 ~= nil and v207.pad == true
        v460.line1.Text = pad and "PRESS A BUTTON" or "PRESS A KEY"
        v460.line1.TextColor3 = colors.Text
        v460.line2.Text = "or click here with a mouse button"
        v460.line2.Visible = not pad
        v460.holdHint.Visible = pad
        v460.padStroke.Color = colors.Accent
        v452.layer.Visible = true
        ui.Enter(v452.card, Vector2.new(0, 14), 0, UDim2.fromScale(0.5, 0.5))
        a18.Sounds.Play("Click")
        sel = nil
        guiService.SelectedObject = nil
    end

    local function padCommit(name)
        --[[
          name: padCommit
          line: 1501
          upvalues:
            v207 (ref,  index: 1)
            closeCapture (copy, index: 2)
            Keybinds (copy, index: 3)
            a18 (copy, index: 4)
            SettingsStore (copy, index: 5)
            flashPadChips (copy, index: 6)
            noteMoves (copy, index: 7)
        ]]
        local v464 = v207

        if not v464 or not v464.pad then
            return
        end

        closeCapture()
        local v465, v466 = Keybinds.PadAssign(v464.id, v464.slot, name)

        if #v465 == 0 then
            a18.Sounds.Play("Click")
            return
        end

        SettingsStore.SavePadBinds(v465)
        a18.Sounds.Play("Select")

        for _, v468 in v465 do
            flashPadChips(v468)
        end

        noteMoves(v466)
    end

    local function padUnbind(a470)
        --[[
          name: padUnbind
          line: 1520
          upvalues:
            Keybinds (copy, index: 1)
            SettingsStore (copy, index: 2)
            a18 (copy, index: 3)
            flashPadChips (copy, index: 4)
            padNote (copy, index: 5)
        ]]
        local v471 = Keybinds.PadGet(a470.id)

        if not v471[a470.slot] then
            return
        end

        Keybinds.PadClear(a470.id, a470.slot)
        SettingsStore.SavePadBinds({a470.id})
        a18.Sounds.Play("Click", {pitch = 0.9})
        flashPadChips(a470.id)
        local v472 = Keybinds.PadGet(a470.id)

        if #v472 == 0 then
            local stringFormat = string.format
            local id = a470.id
            local v476 = if const v475 = Keybinds.PadAction(id) then v475.label else id
            padNote(stringFormat("%s IS NOW UNBOUND", v476), nil)

            return
        end

        local result
        local v478 = string.format
        local id = a470.id
        local v481 = if const v480 = Keybinds.PadAction(id) then v480.label else id
        v478 = v478("%s NOW USES", v481)

        if const v482 = v472[1] then
            local success, result2 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        v482 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v482]
                end
            )

            if success then
                result = result2
            else
                result = nil
            end
        else
            result = nil
        end

        padNote(v478, result)
    end

    Keybinds.OnInput(
        "Began",
        function(a485)
            --[[
              line: 1538
              upvalues:
                v207 (ref,  index: 1)
                v25 (copy, index: 2)
                ui (copy, index: 3)
                guiService (copy, index: 4)
                v362 (ref,  index: 5)
                padUnbind (copy, index: 6)
                closeCapture (copy, index: 7)
                v206 (ref,  index: 8)
                a18 (copy, index: 9)
                Keybinds (copy, index: 10)
                refuse (copy, index: 11)
                colors (copy, index: 12)
            ]]
            local userInputType = a485.UserInputType
            local keyCode = a485.KeyCode
            local v488 = string.sub(userInputType.Name, 1, 7) == "Gamepad"
            local v489 = v207
            if not v489 then
                if v488 and keyCode == Enum.KeyCode.ButtonX and v25.IsOpen and ui.Gamepad then
                    local selectedObject = guiService.SelectedObject

                    if const v491 = selectedObject and v362[selectedObject] then
                        padUnbind(v491)
                    end
                end

                return
            end

            if v489.pad and v25.IsOpen then
                if userInputType ~= Enum.UserInputType.Keyboard then
                    if v488
                        and keyCode ~= Enum.KeyCode.Unknown
                        and string.sub(keyCode.Name, 1, 10) ~= "Thumbstick"
                        and not (os.clock() - v489.at < 0.15)
                        and not v489.down
                    then
                        local name = keyCode.Name
                        local v493 = v206

                        if name == "ButtonB" then
                            v489.down, v489.bAt = name, os.clock()
                            v493.hold.Visible = true

                            task.spawn(
                                function()
                                    --[[
                                      line: 1575
                                      upvalues:
                                        v207 (ref,  index: 1)
                                        v489 (copy, index: 2)
                                        v493 (copy, index: 3)
                                        a18 (copy, index: 4)
                                        closeCapture (copy, index: 5)
                                    ]]
                                    while v207 == v489 and v489.bAt do
                                        local v494 = (os.clock() - v489.bAt) / 0.6
                                        v493.holdFill.Size = UDim2.fromScale(math.clamp(v494, 0, 1), 1)

                                        if 1 <= v494 then
                                            a18.Sounds.Play("Close")
                                            closeCapture()

                                            return
                                        end

                                        task.wait()
                                    end
                                end
                            )

                            return
                        end

                        local v495, v496 = Keybinds.PadBindable(name)

                        if v495 then
                            v489.down = name
                            v493.padStroke.Color = colors.Text
                        else
                            refuse((v496 or "That button can't be used"))
                        end
                    end
                elseif keyCode ~= Enum.KeyCode.Unknown then
                    closeCapture()
                end
            end
        end
    )

    Keybinds.OnInput(
        "Ended",
        function(a497)
            --[[
              line: 1597
              upvalues:
                v207 (ref,  index: 1)
                padCommit (copy, index: 2)
            ]]
            local v498 = v207
            local name = a497.KeyCode.Name

            if not v498 or not v498.pad or v498.down ~= name then
                return
            end

            if name == "ButtonB" then
                local timestamp = os.clock()
                local v501 = v498.bAt or os.clock()
                local v502 = timestamp - v501
                v498.bAt = nil

                if 0.6 <= v502 then
                    return
                end
            end

            padCommit(name)
        end
    )

    local function padChip(parent, id, slot: number, layoutOrder: number)
        --[[
          name: padChip
          line: 1613
          upvalues:
            ui (copy, index: 1)
            v37 (ref,  index: 2)
            void (copy, index: 3)
            selectionImageObject2 (copy, index: 4)
            colors (copy, index: 5)
            fonts (copy, index: 6)
            theme (copy, index: 7)
            Keybinds (copy, index: 8)
            v207 (ref,  index: 9)
            v210 (ref,  index: 10)
            openPadCapture (copy, index: 11)
            v361 (ref,  index: 12)
            v362 (ref,  index: 13)
        ]]
        local result
        local ui2 = ui.new("TextButton", {Name = id .. "_" .. slot, Size = UDim2.fromOffset(v37.chipW, v37.chipH), BackgroundColor3 = void, BackgroundTransparency = 0.35, AutoButtonColor = false, Text = "", Selectable = true, SelectionImageObject = selectionImageObject2, LayoutOrder = layoutOrder, (ui.Corner(8)), Parent = parent})
        local stroke = ui.Stroke(colors.Stroke, 1, 0.8)
        stroke.Parent = ui2
        local v511 = {
            button = ui2,
            cap = ui.PadCap(Enum.KeyCode.ButtonA, {ZIndex = 2, Height = v37.chipH - 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui2}),
            dash = ui.new("TextLabel", {Name = "Empty", Text = "—", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -10, 0, v37.chipText + 2), FontFace = fonts.Heavy, TextSize = v37.chipText, TextColor3 = colors.TextMuted, Parent = ui2}),
            stroke = stroke,
            id = id,
            slot = slot
        }
        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 1649
                  upvalues:
                    ui (copy, index: 1)
                    stroke (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                ]]
                ui.Tween(stroke, theme.Tween.Fast, {Transparency = 0.1, Color = colors.Accent})
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 1652
                  upvalues:
                    ui (copy, index: 1)
                    stroke (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                    Keybinds (copy, index: 5)
                    id (copy, index: 6)
                    slot (copy, index: 7)
                ]]
                local transparency
                local tween = ui.Tween
                local fast = theme.Tween.Fast
                local v515 = {Color = colors.Stroke}

                if Keybinds.PadGet(id)[slot] then
                    transparency = 0.8
                else
                    transparency = 0.9
                end

                v515.Transparency = transparency
                tween(stroke, fast, v515)
            end
        )

        ui2.Activated:Connect(
            function()
                --[[
                  line: 1655
                  upvalues:
                    v207 (ref,  index: 1)
                    v210 (ref,  index: 2)
                    openPadCapture (copy, index: 3)
                    id (copy, index: 4)
                    slot (copy, index: 5)
                    ui2 (copy, index: 6)
                ]]
                if v207 or os.clock() < v210 then
                    return
                end

                openPadCapture(id, slot, ui2)
            end
        )

        local v516 = v361
        local v517 = v361[id] or {}
        v516[id] = v517
        table.insert(v361[id], v511)
        v362[ui2] = v511
        local v518 = Keybinds.PadGet(v511.id)
        local v519 = v518[v511.slot]
        local setCapPad = ui.SetCapPad
        local cap = v511.cap

        if v519 then
            local success, result2 = pcall(
                function()
                    --[[
                      line: 1361
                      upvalues:
                        v519 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v519]
                end
            )

            if success then
                result = result2
            else
                result = nil
            end
        else
            result = nil
        end

        setCapPad(cap, result)
        v511.dash.Visible = v519 == nil
        v511.button.BackgroundTransparency = v519 and 0.35 or 0.72
        v511.stroke.Transparency = v519 and 0.8 or 0.9

        return v511
    end

    local function padSection(parent, layoutOrder: number)
        --[[
          name: padSection
          line: 1668
          upvalues:
            v361 (ref,  index: 1)
            v362 (ref,  index: 2)
            v37 (ref,  index: 3)
            Keybinds (copy, index: 4)
            ui (copy, index: 5)
            v363 (ref,  index: 6)
            v207 (ref,  index: 7)
            closeCapture (copy, index: 8)
            SettingsStore (copy, index: 9)
            flashPadChips (copy, index: 10)
            padNote (copy, index: 11)
            addNav (copy, index: 12)
            v43 (ref,  index: 13)
            colors (copy, index: 14)
            textBlock (copy, index: 15)
            padChip (copy, index: 16)
            v30 (ref,  index: 17)
            fonts (copy, index: 18)
            textColor3 (copy, index: 19)
            paintPadBinds (copy, index: 20)
        ]]
        local textSize
        local v528 = {}
        local v529 = {}
        v361 = v528
        v362 = v529
        local kbHeader = v37.kbHeader
        local v531 = #Keybinds.PAD_ACTIONS * v37.rowH
        local v532 = v37.desc + 22
        local parent2 = ui.new("Frame", {Name = "CONTROLLER", Size = UDim2.new(1, 0, 0, ((kbHeader + v37.titleGap) + v531) + v532), LayoutOrder = layoutOrder, Parent = parent})
        local v534 = v37.title + 8
        ui.SectionTitle("CONTROLLER", {Position = UDim2.fromOffset(0, kbHeader - v534), Size = UDim2.new(1, 0, 0, v534), TextSize = v37.title, Parent = parent2})
        local v535 = ui.Compact and 214 or 186
        local button = ui.Button
        local v537 = {Name = "ResetPad", Text = "RESET TO DEFAULTS", Style = "Dark", Radius = 9}

        if ui.Compact then
            textSize = 16
        else
            textSize = 14
        end

        v537.TextSize = textSize
        v537.AnchorPoint = Vector2.new(1, 1)
        v537.Position = UDim2.new(1, 0, 0, kbHeader)
        v537.Size = UDim2.fromOffset(v535, kbHeader - 2)
        v537.Parent = parent2

        function v537.OnClick()
            --[[
              name: OnClick
              line: 1697
              upvalues:
                v207 (ref,  index: 1)
                closeCapture (copy, index: 2)
                Keybinds (copy, index: 3)
                SettingsStore (copy, index: 4)
                flashPadChips (copy, index: 5)
                padNote (copy, index: 6)
            ]]
            if v207 then
                closeCapture()
            end

            local v538 = Keybinds.PadResetAll()

            if 0 < #v538 then
                SettingsStore.SavePadBinds(v538)

                for _, v540 in v538 do
                    flashPadChips(v540)
                end

                padNote("EVERY BUTTON IS BACK TO ITS DEFAULT", nil)
            end
        end

        v363 = button(v537)
        addNav({v363.Instance})
        v43[v363.Instance] = parent2
        local v541 = ui.new
        local v542 = {Name = "Card", Position = UDim2.fromOffset(0, kbHeader + v37.titleGap), Size = UDim2.new(1, 0, 0, v531), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3}
        v542[1], v542[2], v542[3] = ui.Corner(12), ui.Stroke(colors.Stroke, 1, 0.92), (ui.List(Enum.FillDirection.Vertical, 0))
        v542.Parent = parent2
        local parent3 = v541("Frame", v542)
        local v544 = v37.chipW * 2 + v37.chipGap

        for layoutOrder2, padAction in Keybinds.PAD_ACTIONS do
            local parent4 = ui.new("Frame", {Name = padAction.id, Size = UDim2.new(1, 0, 0, v37.rowH), LayoutOrder = layoutOrder2, Parent = parent3})

            if 1 < layoutOrder2 then
                ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = colors.Stroke, Position = UDim2.fromOffset(v37.pad, 0), Size = UDim2.new(1, -v37.pad * 2, 0, 1), Parent = parent4})
            end

            local ui2 = ui.new("Frame", {Name = "Highlight", BackgroundColor3 = colors.White, BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), (ui.Corner(9)), Parent = parent4})
            textBlock(parent4, {kind = "padbind", label = padAction.label, desc = padAction.desc}, v544)
            local ui3 = ui.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -v37.pad, 0.5, 0), Size = UDim2.fromOffset(v544, v37.chipH), (ui.List(Enum.FillDirection.Horizontal, v37.chipGap, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent4})
            local items = {}

            for index = 1, padAction.max do
                local v552 = padChip(ui3, padAction.id, index, index)
                v30[v552.button] = ui2
                table.insert(items, v552.button)
            end

            addNav(items, items[#items])

            if layoutOrder2 == 1 then
                v43[items[#items]] = parent2
            end
        end

        v541 = ui.new("Frame", {Name = "Legend", Position = UDim2.fromOffset(v37.pad, ((kbHeader + v37.titleGap) + v531) + 10), Size = UDim2.new(1, -v37.pad * 2, 0, v37.desc + 6), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent2})

        local function legendText(text: string, layoutOrder: number, a556: boolean)
            --[[
              name: legendText
              line: 1780
              upvalues:
                ui (copy, index: 1)
                fonts (copy, index: 2)
                v37 (ref,  index: 3)
                colors (copy, index: 4)
                textColor3 (copy, index: 5)
                v541 (copy, index: 6)
            ]]
            local newUi = ui.new
            local v558 = {Name = "T" .. layoutOrder, Text = text, FontFace = if a556 then fonts.Heavy else fonts.SemiBold}
            v558.TextSize = v37.desc
            v558.TextColor3 = if a556 then colors.TextDim else textColor3
            v558.AutomaticSize = Enum.AutomaticSize.X
            v558.Size = UDim2.fromOffset(0, v37.desc + 4)
            v558.LayoutOrder = layoutOrder
            v558.Parent = v541
            newUi("TextLabel", v558)
        end

        ui.PadCap(Enum.KeyCode.ButtonA, {LayoutOrder = 1, Height = v37.desc + 6, Parent = v541})
        legendText("CHANGE", 2, true)
        legendText("  ", 3, false)
        ui.PadCap(Enum.KeyCode.ButtonX, {LayoutOrder = 4, Height = v37.desc + 6, Parent = v541})
        legendText("UNBIND", 5, true)
        legendText("   ·   Menu buttons can't be changed", 6, false)
        paintPadBinds()

        return parent2
    end

    Keybinds.PadChanged:Connect(paintPadBinds)

    local function updateFade()
        --[[
          name: updateFade
          line: 1805
          upvalues:
            ui2 (ref, index: 1)
            ui3 (ref, index: 2)
        ]]
        local ui = ui2
        local ui4 = ui3

        if not ui or not ui4 then
            return
        end

        ui4.Visible = 2 < (ui.AbsoluteCanvasSize.Y - (ui.CanvasPosition.Y + ui.AbsoluteWindowSize.Y))
    end

    local function build()
        --[[
          name: build
          line: 1814
          upvalues:
            content (copy, index: 1)
            v27 (ref,  index: 2)
            v28 (ref,  index: 3)
            v29 (ref,  index: 4)
            v30 (ref,  index: 5)
            selectedObject (ref,  index: 6)
            v87 (ref,  index: 7)
            v38 (ref,  index: 8)
            v42 (ref,  index: 9)
            v43 (ref,  index: 10)
            v44 (ref,  index: 11)
            sel (ref,  index: 12)
            closeCapture (copy, index: 13)
            v206 (ref,  index: 14)
            v179 (ref,  index: 15)
            v180 (ref,  index: 16)
            ui4 (ref,  index: 17)
            v361 (ref,  index: 18)
            v362 (ref,  index: 19)
            v363 (ref,  index: 20)
            ui6 (ref,  index: 21)
            ui7 (ref,  index: 22)
            v366 (ref,  index: 23)
            v37 (ref,  index: 24)
            ui (copy, index: 25)
            v15 (copy, index: 26)
            v14 (copy, index: 27)
            v35 (ref,  index: 28)
            a18 (copy, index: 29)
            userInputService (copy, index: 30)
            v72 (ref,  index: 31)
            ui2 (ref,  index: 32)
            v9 (copy, index: 33)
            keybindSection (copy, index: 34)
            padSection (copy, index: 35)
            colors (copy, index: 36)
            sliderRow (copy, index: 37)
            switchRow (copy, index: 38)
            actionRow (copy, index: 39)
            v36 (ref,  index: 40)
            ui3 (ref,  index: 41)
            updateFade (copy, index: 42)
            SettingsStore (copy, index: 43)
            v34 (ref,  index: 44)
            state (copy, index: 45)
            v40 (ref,  index: 46)
            openConfirm (copy, index: 47)
            theme (copy, index: 48)
            fonts (copy, index: 49)
            v59 (ref,  index: 50)
        ]]
        local v563

        for _, child in content:GetChildren() do
            if not child:IsA("UIPadding") then
                child:Destroy()
            end
        end

        local v566 = {}
        local v567 = {}
        local v568 = {}
        local v569 = {}
        v27 = v566
        v28 = v567
        v29 = v568
        v30 = v569
        selectedObject = nil
        v87 = nil
        v38 = nil
        local v570 = {}
        local v571 = {}
        v42 = v570
        v43 = v571
        v44 = nil
        sel = nil
        closeCapture()

        if v206 then
            v206.layer:Destroy()
            v206 = nil
        end

        v179 = {}
        v180 = nil
        ui4 = nil
        local v572 = {}
        local v573 = {}
        v361 = v572
        v362 = v573
        v363 = nil
        ui6 = nil
        ui7 = nil
        v366 = nil
        v37 = if ui.Compact then v15 else v14
        local v574 = ui.Compact and "c" or "d"
        local v575 = ui.Touch and a18.OpenTouchEditor ~= nil
        local v576 = v575 and "t" or ""
        local v577 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
        local v578 = v577 and "k" or ""
        local v579 = ui.Touch or ui.Gamepad or v72
        local v580 = v579 and "a" or ""
        local v581 = ui.Gamepad and "p" or ""
        v35 = v574 .. v576 .. v578 .. v580 .. v581
        local v582 = ui.Touch and a18.OpenTouchEditor ~= nil
        local v583 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
        local v584 = ui.Touch or ui.Gamepad or v72
        local v585 = v37.footerTop + v37.footerBtn
        local parent = ui.new("ScrollingFrame", {Name = "Scroll", ScrollBarThickness = 5, Selectable = false, Size = UDim2.new(1, 14, 1, -(v585 + 14)), AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = content})
        ui2 = parent
        local parent2 = ui.new("Frame", {Name = "List", Size = UDim2.new(1, -14, 1, 0), (ui.List(Enum.FillDirection.Vertical, v37.sectionGap)), Parent = parent})
        local total = 0
        local count = 0

        for layoutOrder, v591 in v9 do
            if v591.touchOnly and not v582 then
                continue
            end
            if v591.keyboardOnly and not v583 then
                continue
            end
            if v591.staging and not a18.ReplayNewPlayer then
                continue
            end

            if v591.keybinds then
                total += keybindSection(parent2, layoutOrder).Size.Y.Offset
                count += 1
            elseif v591.padbinds then
                if ui.Gamepad then
                    total += padSection(parent2, layoutOrder).Size.Y.Offset
                    count += 1
                end
            else
                local v592 = {}
                local gamepad = ui.Gamepad

                for _, item in v591.items do
                    if not v584 and item.assistOnly then
                        continue
                    end
                    if not gamepad and item.padOnly then
                        continue
                    end

                    if not gamepad or not item.notPad then
                        table.insert(v592, item)
                    end
                end

                local v596 = #v592 * v37.rowH
                local v597 = v37.title + 8
                local parent3 = ui.new("Frame", {Name = v591.title, Size = UDim2.new(1, 0, 0, (v597 + v37.titleGap) + v596), LayoutOrder = layoutOrder, Parent = parent2})
                ui.SectionTitle(v591.title, {Size = UDim2.new(1, 0, 0, v597), TextSize = v37.title, Parent = parent3})
                local ui5 = ui.new("Frame", {Name = "Card", Position = UDim2.fromOffset(0, v597 + v37.titleGap), Size = UDim2.new(1, 0, 0, v596), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3, ui.Corner(12), ui.Stroke(colors.Stroke, 1, 0.92), (ui.List(Enum.FillDirection.Vertical, 0)), Parent = parent3})
                local length = #v42

                for layoutOrder2, item in v592 do
                    if item.kind == "slider" then
                        sliderRow(ui5, layoutOrder2, item)
                    elseif item.kind ~= "switch" then
                        actionRow(ui5, layoutOrder2, item)
                    else
                        switchRow(ui5, layoutOrder2, item)
                    end
                end

                if const v603 = v42[length + 1] then
                    v43[v603.land] = parent3
                end

                total += parent3.Size.Y.Offset
                count += 1
            end
        end

        local v604 = total + ((math.max(0, count - 1) * v37.sectionGap) + 4)
        parent.CanvasSize = UDim2.fromOffset(0, v604)
        v36 = (((v604 + 92) + 14) + v585) + 18
        ui3 = ui.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -(v585 + 14)), Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = colors.PanelLo, ZIndex = 4, Visible = false, (ui.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05))), Parent = content})
        parent:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
        parent:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
        parent:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
        local parent4 = ui.new("Frame", {Name = "Footer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, v585), Parent = content})
        ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.92, BackgroundColor3 = colors.Stroke, Size = UDim2.new(1, 0, 0, 1), Parent = parent4})
        local button = ui.Button
        local v607 = {Name = "Reset", Text = "DEFAULTS", Style = "Dark", TextSize = v37.button, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1)}
        local udim2FromOffset = UDim2.fromOffset

        if ui.Compact then
            v563 = 210
        else
            v563 = 190
        end

        v607.Size = udim2FromOffset(v563, v37.footerBtn)
        v607.Parent = parent4

        function v607.OnClick()
            --[[
              name: OnClick
              line: 1968
              upvalues:
                SettingsStore (copy, index: 1)
            ]]
            for v609, default in SettingsStore.DEFAULTS do
                if not SettingsStore.MEMORY[v609] then
                    SettingsStore.Set(v609, default, true)
                end
            end
        end

        local v611 = button(v607)
        local button2 = ui.Button
        local v613 = {Name = "LeaveMatch", Text = "LEAVE MATCH", Style = "Danger", TextSize = v37.button, AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1)}
        udim2FromOffset = UDim2.fromOffset
        local v614 = ui.Compact and 250 or 230
        v613.Size = udim2FromOffset(v614, v37.footerBtn)
        v613.Visible = state.InMatch()
        v613.Parent = parent4
        v34 = button2(v613)
        v40 = false
        v34.Activated:Connect(openConfirm)
        v44 = {items = {v611.Instance, v34.Instance}, land = v611.Instance}

        if ui.Gamepad then
            local textSize
            local v616 = ui.Compact and 36 or 32
            local parent5 = ui.new(
                "Frame",
                {
                    Name = "PadNotice",
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 1, -((v585 + 14) + 8)),
                    Size = UDim2.fromOffset(0, v616),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = colors.Void,
                    BackgroundTransparency = 0.1,
                    Visible = false,
                    ZIndex = 8,
                    ui.Corner(theme.Radius.Pill),
                    ui.Stroke(colors.Warning, 1, 0.55),
                    ui.Padding(0, 16, 0, 16),
                    (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)),
                    Parent = content
                }
            )
            local newUi = ui.new
            local v619 = {Name = "Text", Text = "", LayoutOrder = 1, ZIndex = 9, FontFace = fonts.Heavy}

            if ui.Compact then
                textSize = 16
            else
                textSize = 14
            end

            v619.TextSize = textSize
            v619.TextColor3 = colors.Warning
            v619.AutomaticSize = Enum.AutomaticSize.X
            v619.Size = UDim2.fromOffset(0, v616)
            v619.Parent = parent5
            ui7 = newUi("TextLabel", v619)
            v366 = ui.PadCap(Enum.KeyCode.ButtonA, {LayoutOrder = 2, ZIndex = 9, Height = v616 - 8, Parent = parent5})
            ui6 = parent5
        end

        pcall(
            function()
                --[[
                  line: 2025
                  upvalues:
                    v611 (copy, index: 1)
                    v34 (ref,  index: 2)
                ]]
                local instance = v611.Instance
                local instance2 = v34.Instance
                instance.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                instance2.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                instance.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                instance2.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            end
        )

        a18.Debug.leaveConfirm = function()
            --[[
              line: 2033
              upvalues:
                openConfirm (copy, index: 1)
                v59 (ref,  index: 2)
            ]]
            openConfirm()
            local v622 = v59

            return {visible = v622 and v622.layer.Visible, body = v622 and v622.body.Text}
        end

        for v623, v624 in v27 do
            v624(SettingsStore.Get(v623), true)
        end
    end

    local function resize()
        --[[
          name: resize
          line: 2045
          upvalues:
            ui (copy, index: 1)
            v36 (ref,  index: 2)
            v37 (ref,  index: 3)
            v25 (copy, index: 4)
            updateFade (copy, index: 5)
        ]]
        local v626 = ui.CanvasSize()
        local v627 = v626.Y - ui.TopInset() - 12
        local v628 = math.max(math.min(v36, v627), (math.min(v36, 360)))
        local v629 = math.min(v37.winW, v626.X - 24)
        v25.Holder.Size = UDim2.fromOffset(v629, v628)
        v25.Refit()
        task.defer(updateFade)
    end

    local function relayout()
        --[[
          name: relayout
          line: 2055
          upvalues:
            v25 (copy, index: 1)
            ui (copy, index: 2)
            a18 (copy, index: 3)
            userInputService (copy, index: 4)
            v72 (ref,  index: 5)
            v35 (ref,  index: 6)
            build (copy, index: 7)
            resize (copy, index: 8)
        ]]
        if not v25.IsOpen then
            return
        end

        local v631 = ui.Compact and "c" or "d"
        local v632 = ui.Touch and a18.OpenTouchEditor ~= nil
        local v633 = v632 and "t" or ""
        local v634 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
        local v635 = v634 and "k" or ""
        local v636 = ui.Touch or ui.Gamepad or v72
        local v637 = v636 and "a" or ""
        local v638 = ui.Gamepad and "p" or ""

        if v631 .. v633 .. v635 .. v637 .. v638 ~= v35 then
            build()
        end

        resize()
    end

    ui.ScaleChanged:Connect(relayout)
    ui.LayoutChanged:Connect(relayout)
    ui.TouchChanged:Connect(relayout)
    ui.TopInsetChanged:Connect(relayout)

    ui.GamepadChanged:Connect(
        function()
            --[[
              line: 2069
              upvalues:
                v25 (copy, index: 1)
                v207 (ref,  index: 2)
                ui (copy, index: 3)
                a18 (copy, index: 4)
                userInputService (copy, index: 5)
                v72 (ref,  index: 6)
                v35 (ref,  index: 7)
                build (copy, index: 8)
                resize (copy, index: 9)
            ]]
            if v25.IsOpen and not v207 then
                local v639 = ui.Compact and "c" or "d"
                local v640 = ui.Touch and a18.OpenTouchEditor ~= nil
                local v641 = v640 and "t" or ""
                local v642 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
                local v643 = v642 and "k" or ""
                local v644 = ui.Touch or ui.Gamepad or v72
                local v645 = v644 and "a" or ""
                local v646 = ui.Gamepad and "p" or ""

                if v639 .. v641 .. v643 .. v645 .. v646 ~= v35 then
                    if not v25.IsOpen then
                        return
                    end

                    local v647 = ui.Compact and "c" or "d"
                    local v648 = ui.Touch and a18.OpenTouchEditor ~= nil
                    local v649 = v648 and "t" or ""
                    local v650 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
                    local v651 = v650 and "k" or ""
                    local v652 = ui.Touch or ui.Gamepad or v72
                    local v653 = v652 and "a" or ""
                    local v654 = ui.Gamepad and "p" or ""

                    if v647 .. v649 .. v651 .. v653 .. v654 ~= v35 then
                        build()
                    end

                    resize()
                end
            end
        end
    )

    SettingsStore.Changed:Connect(
        function(key, a656)
            --[[
              line: 2076
              upvalues:
                v27 (ref,  index: 1)
                v25 (copy, index: 2)
                v38 (ref,  index: 3)
            ]]
            if const v657 = v27[key] then
                v657(a656, not v25.IsOpen or v38 ~= nil and v38.item.key == key)
            end
        end
    )

    local function endDrag()
        --[[
          name: endDrag
          line: 2083
          upvalues:
            v38 (ref,  index: 1)
            ui2 (ref,  index: 2)
            ui (copy, index: 3)
            theme (copy, index: 4)
        ]]
        local v659 = v38
        if not v659 then
            return
        end

        v38 = nil

        if ui2 then
            ui2.ScrollingEnabled = true
        end

        ui.Tween(ui.GetScaleObj(v659.knob), theme.Tween.PopSmall, {Scale = 1})
    end

    userInputService.InputEnded:Connect(
        function(input: InputObject)
            --[[
              line: 2094
              upvalues:
                v38 (ref,  index: 1)
                ui2 (ref,  index: 2)
                ui (copy, index: 3)
                theme (copy, index: 4)
            ]]
            if v38 then
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch
                then
                    local v661 = v38
                    if not v661 then
                        return
                    end

                    v38 = nil

                    if ui2 then
                        ui2.ScrollingEnabled = true
                    end

                    ui.Tween(ui.GetScaleObj(v661.knob), theme.Tween.PopSmall, {Scale = 1})
                end
            end
        end
    )

    runService.RenderStepped:Connect(
        function()
            --[[
              line: 2099
              upvalues:
                v38 (ref,  index: 1)
                v25 (copy, index: 2)
                ui2 (ref,  index: 3)
                ui (copy, index: 4)
                theme (copy, index: 5)
                SettingsStore (copy, index: 6)
                tick (copy, index: 7)
            ]]
            local v662 = v38
            if not v662 then
                return
            end

            if not v25.IsOpen then
                local v663 = v38
                if not v663 then
                    return
                end

                v38 = nil

                if ui2 then
                    ui2.ScrollingEnabled = true
                end

                ui.Tween(ui.GetScaleObj(v663.knob), theme.Tween.PopSmall, {Scale = 1})

                return
            end

            local key = v662.item.key
            local range = SettingsStore.RANGES[key]
            local v666 = ui.PointerAbs()
            local clampedValue = math.clamp((v666.X - v662.track.AbsolutePosition.X) / math.max(1, v662.track.AbsoluteSize.X), 0, 1)
            local v668 = range[1] + clampedValue * (range[2] - range[1])

            if v662.item.round then
                v668 = math.floor(v668 + 0.5)
            end

            if v668 ~= SettingsStore.Get(key) then
                SettingsStore.Set(key, v668, true)
                tick(clampedValue)
            end
        end
    )

    local v669 = {token = 0, dir = 0, source = nil, steps = 0}

    local function stopNudge(a671)
        --[[
          name: stopNudge
          line: 2129
          upvalues:
            v669 (copy, index: 1)
        ]]
        if a671 == nil or v669.source == a671 then
            v669.token += 1
            v669.dir = 0
            v669.source = nil
        end
    end

    local function startNudge(dir, source: string)
        --[[
          name: startNudge
          line: 2135
          upvalues:
            guiService (copy, index: 1)
            v29 (ref,  index: 2)
            v25 (copy, index: 3)
            v207 (ref,  index: 4)
            v669 (copy, index: 5)
            setSlider (copy, index: 6)
            SettingsStore (copy, index: 7)
        ]]
        local selectedObject = guiService.SelectedObject
        local slider = selectedObject and v29[selectedObject]

        if not slider or not v25.IsOpen or v207 then
            return false
        end
        if v669.dir == dir and v669.source == source then
            return true
        end

        v669.token += 1
        local token = v669.token
        v669.dir = dir
        v669.source = source
        local key = slider.key
        local step = slider.step or 0.05
        setSlider(slider, SettingsStore.Get(key) + (dir * step))
        v669.steps += 1

        task.spawn(
            function()
                --[[
                  line: 2151
                  upvalues:
                    token (copy, index: 1)
                    v669 (copy, index: 2)
                    v25 (copy, index: 3)
                    guiService (copy, index: 4)
                    selectedObject (copy, index: 5)
                    setSlider (copy, index: 6)
                    slider (copy, index: 7)
                    SettingsStore (copy, index: 8)
                    key (copy, index: 9)
                    dir (copy, index: 10)
                    step (copy, index: 11)
                ]]
                task.wait(0.35)
                local timestamp = os.clock()

                while token == v669.token and v25.IsOpen do
                    if guiService.SelectedObject ~= selectedObject then
                        break
                    end

                    setSlider(slider, SettingsStore.Get(key) + (dir * step))
                    v669.steps += 1
                    local clampedValue = math.clamp((os.clock() - timestamp) / 1, 0, 1)
                    task.wait((clampedValue * -0.06) + 0.09)
                end
            end
        )

        return true
    end

    Keybinds.OnInput(
        "Began",
        function(a682)
            --[[
              line: 2163
              upvalues:
                v25 (copy, index: 1)
                startNudge (copy, index: 2)
            ]]
            local dir = a682.KeyCode ~= Enum.KeyCode.DPadLeft
                and (a682.KeyCode ~= Enum.KeyCode.DPadRight and 0 or 1)
                or -1

            if dir ~= 0 and v25.IsOpen then
                startNudge(dir, "dpad")
            end
        end
    )

    Keybinds.OnInput(
        "Ended",
        function(a684)
            --[[
              line: 2169
              upvalues:
                v669 (copy, index: 1)
            ]]
            if a684.KeyCode == Enum.KeyCode.DPadLeft or a684.KeyCode == Enum.KeyCode.DPadRight then
                if v669.source == "dpad" then
                    v669.token += 1
                    v669.dir = 0
                    v669.source = nil
                end
            elseif a684.KeyCode == Enum.KeyCode.Thumbstick1 and v669.source == "stick" then
                v669.token += 1
                v669.dir = 0
                v669.source = nil
            end
        end
    )

    Keybinds.OnInput(
        "Changed",
        function(a685)
            --[[
              line: 2176
              upvalues:
                v25 (copy, index: 1)
                startNudge (copy, index: 2)
                v669 (copy, index: 3)
            ]]
            if a685.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end

            local x = a685.Position.X
            local y = a685.Position.Y
            local absoluteValue = math.abs(x)

            if not (0.5 <= absoluteValue) or not (math.abs(y) < absoluteValue) then
                if (absoluteValue < 0.35 or absoluteValue < math.abs(y)) and v669.source == "stick" then
                    v669.token += 1
                    v669.dir = 0
                    v669.source = nil
                end
            else
                if v25.IsOpen then
                    local dir = not (0 < x) and -1 or 1

                    if startNudge(dir, "stick") then
                        return
                    end
                end

                if v669.source == "stick" then
                    v669.token += 1
                    v669.dir = 0
                    v669.source = nil
                end
            end
        end
    )

    local function navUsable(a691)
        --[[
          name: navUsable
          line: 2193
        ]]
        if not a691 or not a691.Parent or not a691.Selectable then
            return false
        end

        local v692
        v692 = a691

        while v692 and not v692:IsA("LayerCollector") do
            if v692:IsA("GuiObject") and not v692.Visible then
                return false
            end

            v692 = v692.Parent
        end

        local v693 = v692 ~= nil
        return v693
    end

    local function navChain()
        --[[
          name: navChain
          line: 2207
          upvalues:
            navUsable (copy, index: 1)
            v25 (copy, index: 2)
            v42 (ref,  index: 3)
            v44 (ref,  index: 4)
        ]]
        local v695 = {}

        local function add(a697)
            --[[
              name: add
              line: 2209
              upvalues:
                navUsable (copy, index: 1)
                v695 (copy, index: 2)
            ]]
            local items = {}

            for _, item in a697.items do
                if navUsable(item) then
                    table.insert(items, item)
                end
            end

            if 0 < #items then
                local v701 = {items = items, land = if table.find(items, a697.land) then a697.land else items[#items]}
                table.insert(v695, v701)
            end
        end

        add({items = {v25.CloseButton}, land = v25.CloseButton})

        for _, v703 in v42 do
            add(v703)
        end

        if v44 then
            add(v44)
        end

        return v695
    end

    local function wireNav(selectedObject: GuiObject?)
        --[[
          name: wireNav
          line: 2231
          upvalues:
            navChain (copy, index: 1)
        ]]
        local v706 = navChain()
        local index

        for v708, v709 in v706 do
            index = table.find(v709.items, selectedObject)

            if index then
                local v710 = v706[v708 - 1]
                local v711 = v706[v708 + 1]

                pcall(
                    function()
                        --[[
                          line: 2237
                          upvalues:
                            selectedObject (copy, index: 1)
                            v710 (copy, index: 2)
                            v711 (copy, index: 3)
                            v709 (copy, index: 4)
                            index (copy, index: 5)
                        ]]
                        local land
                        local selectedObject2 = selectedObject

                        if v710 then
                            land = v710.land
                        else
                            land = nil
                        end

                        selectedObject2.NextSelectionUp = land
                        selectedObject2.NextSelectionDown = if v711 then v711.land else nil
                        selectedObject2.NextSelectionLeft = v709.items[index - 1]
                        selectedObject2.NextSelectionRight = v709.items[index + 1]
                    end
                )

                return true
            end
        end

        return false
    end

    local function revealSelected(selectedObject: GuiObject?)
        --[[
          name: revealSelected
          line: 2251
          upvalues:
            ui2 (ref,  index: 1)
            ui (copy, index: 2)
            v43 (ref,  index: 3)
            theme (copy, index: 4)
        ]]
        local ancestor = ui2

        if not ancestor or not selectedObject:IsDescendantOf(ancestor) then
            return
        end

        local v717
        local y = ancestor.AbsoluteWindowSize.Y
        local v719 = if 0 < selectedObject.Size.Y.Offset and selectedObject.Size.Y.Scale == 0 then selectedObject.AbsoluteSize.Y / selectedObject.Size.Y.Offset else ui.Scale
        local v720 = selectedObject.AbsolutePosition.Y - ancestor.AbsolutePosition.Y
        local v721 = v720 + selectedObject.AbsoluteSize.Y

        if const v722 = v43[selectedObject] then
            v720 = math.min(v720, v722.AbsolutePosition.Y - ancestor.AbsolutePosition.Y)
        end

        local y2 = ancestor.CanvasPosition.Y

        if v720 < 6 * v719 then
            v717 = y2 + v720 - 6 * v719
        else
            v717 = if y - (48 * v719) < v721 then y2 + v721 - (y - (48 * v719)) else y2
        end

        local y3 = math.clamp(v717, 0, (math.max(0, ancestor.AbsoluteCanvasSize.Y - y)))

        if 1 < math.abs(y3 - y2) then
            ui.Tween(ancestor, theme.Tween.Fast, {CanvasPosition = Vector2.new(0, y3)})
        end
    end

    guiService:GetPropertyChangedSignal("SelectedObject"):Connect(
        function()
            --[[
              line: 2277
              upvalues:
                guiService (copy, index: 1)
                v30 (ref,  index: 2)
                v87 (ref,  index: 3)
                ui (copy, index: 4)
                theme (copy, index: 5)
                v25 (copy, index: 6)
                wireNav (copy, index: 7)
                revealSelected (copy, index: 8)
            ]]
            local selectedObject = guiService.SelectedObject
            local v726 = selectedObject and v30[selectedObject]

            if v87 and v87 ~= v726 then
                ui.Tween(v87, theme.Tween.Fast, {BackgroundTransparency = 1})
            end

            v87 = v726

            if v726 then
                ui.Tween(v726, theme.Tween.Fast, {BackgroundTransparency = 0.94})
            end

            if selectedObject and v25.IsOpen and selectedObject:IsDescendantOf(v25.Root) then
                wireNav(selectedObject)
                revealSelected(selectedObject)
            end
        end
    )

    state.PlayerStateChanged:Connect(
        function()
            --[[
              line: 2293
              upvalues:
                v34 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            if v34 then
                v34.Instance.Visible = state.InMatch()
            end
        end
    )

    a18.Debug.aimAssistRow = function(a727, a728)
        --[[
          line: 2302
          upvalues:
            v28 (ref,  index: 1)
            v72 (ref,  index: 2)
            v25 (copy, index: 3)
            ui (copy, index: 4)
            a18 (copy, index: 5)
            userInputService (copy, index: 6)
            v35 (ref,  index: 7)
            build (copy, index: 8)
            resize (copy, index: 9)
            content (copy, index: 10)
            SettingsStore (copy, index: 11)
        ]]
        local camera

        if a727 == "flip" then
            if const aimAssist = v28.aimAssist then
                aimAssist()
            end
        elseif a727 == "show" then
            v72 = a728 == true

            if v25.IsOpen then
                local v731 = ui.Compact and "c" or "d"
                local v732 = ui.Touch and a18.OpenTouchEditor ~= nil
                local v733 = v732 and "t" or ""
                local v734 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
                local v735 = v734 and "k" or ""
                local v736 = ui.Touch or ui.Gamepad or v72
                local v737 = v736 and "a" or ""
                local v738 = ui.Gamepad and "p" or ""

                if v731 .. v733 .. v735 .. v737 .. v738 ~= v35 then
                    build()
                end

                resize()
            end
        end

        local aimAssist = content:FindFirstChild("aimAssist", true)
        local shown = false

        if aimAssist and aimAssist:IsA("GuiObject") and v25.IsOpen then
            local v741
            shown = true
            v741 = aimAssist

            while v741 do
                if v741 ~= content then
                    if v741:IsA("GuiObject") and not v741.Visible then
                        shown = false
                    end

                    v741 = v741.Parent
                    continue
                end

                local success, result = pcall(require, (game:GetService("ReplicatedStorage").Shared:FindFirstChild("Camera")))

                if success then
                    if type(result) == "table" and type(result.GetAimAssistEnabled) == "function" then
                        camera = result.GetAimAssistEnabled()
                    end
                else
                    camera = nil
                end

                return {shown = shown, row = aimAssist ~= nil, value = SettingsStore.Get("aimAssist"), camera = camera, touch = ui.Touch}
            end
        end

        local success, result = pcall(require, (game:GetService("ReplicatedStorage").Shared:FindFirstChild("Camera")))

        if success then
            if type(result) == "table" and type(result.GetAimAssistEnabled) == "function" then
                camera = result.GetAimAssistEnabled()
            end
        else
            camera = nil
        end

        return {shown = shown, row = aimAssist ~= nil, value = SettingsStore.Get("aimAssist"), camera = camera, touch = ui.Touch}
    end

    a18.Debug.keybinds = function(a744, id, a746)
        --[[
          line: 2332
          upvalues:
            openCapture (copy, index: 1)
            closeCapture (copy, index: 2)
            Keybinds (copy, index: 3)
            SettingsStore (copy, index: 4)
            v206 (ref,  index: 5)
            v207 (ref,  index: 6)
            ui4 (ref,  index: 7)
            v179 (ref,  index: 8)
        ]]
        if a744 == "capture" and type(id) == "string" then
            openCapture(id, (a746 or 1))
        elseif a744 == "cancel" then
            closeCapture()
        elseif a744 == "reset" then
            local v747 = Keybinds.ResetAll()
            SettingsStore.SaveKeybinds(v747)

            return v747
        end

        local v748 = {}

        for _, action in Keybinds.ACTIONS do
            v748[action.id] = table.concat(Keybinds.Get(action.id), ",")
        end

        local v751 = v206
        v748._capturing = if v207 then v207.id .. "#" .. v207.slot else false
        v748._card = v751 ~= nil and v751.layer.Visible
        v748._pad = if v751 then v751.line1.Text else nil
        v748._focus = v751 ~= nil and v751.box:IsFocused()
        v748._notice = if ui4 then ui4.Text else nil
        local section = next(v179) ~= nil
        v748._section = section

        return v748
    end

    local function guiName(key)
        --[[
          name: guiName
          line: 2363
          upvalues:
            v362 (ref, index: 1)
        ]]
        return if not key then nil elseif const v755 = v362[key] then "chip:" .. v755.id .. "#" .. v755.slot else key.Name
    end

    a18.Debug.padSettings = function(a756, key, a758)
        --[[
          line: 2373
          upvalues:
            v361 (ref,  index: 1)
            guiService (copy, index: 2)
            ui2 (ref,  index: 3)
            openPadCapture (copy, index: 4)
            v363 (ref,  index: 5)
            Keybinds (copy, index: 6)
            SettingsStore (copy, index: 7)
            paintPadBinds (copy, index: 8)
            v25 (copy, index: 9)
            ui (copy, index: 10)
            v362 (ref,  index: 11)
            v29 (ref,  index: 12)
            v669 (copy, index: 13)
            navChain (copy, index: 14)
            v206 (ref,  index: 15)
            v207 (ref,  index: 16)
            ui6 (ref,  index: 17)
            ui7 (ref,  index: 18)
            a18 (copy, index: 19)
        ]]
        local v759
        local capturing
        local v761

        if a756 == "select" and type(key) == "string" then
            local v762 = v361[key]

            if const v763 = v762 and v762[math.clamp((a758 or 1), 1, #v762)] then
                guiService.SelectedObject = v763.button
            end
        elseif a756 == "row" and type(key) == "string" then
            local selectedObject = ui2 and ui2:FindFirstChild(key, true)

            if selectedObject and selectedObject:IsA("GuiObject") then
                guiService.SelectedObject = selectedObject
            end
        elseif a756 == "nav" and type(key) == "string" then
            local selectedObject = guiService.SelectedObject

            if const selectedObject2 = selectedObject and selectedObject["NextSelection" .. key] then
                guiService.SelectedObject = selectedObject2
            end
        elseif a756 == "capture" and type(key) == "string" then
            local v767 = v361[key]
            local v768 = v767 and v767[math.clamp((a758 or 1), 1, (math.max(1, #v767)))]
            openPadCapture(key, (a758 or 1), (v768 and v768.button))
        elseif a756 == "reset" and v363 then
            local v769 = Keybinds.PadResetAll()
            SettingsStore.SavePadBinds(v769)
            paintPadBinds()
        end

        local selectedObject = guiService.SelectedObject
        local v771 = {open = v25.IsOpen, gamepad = ui.Gamepad}

        if selectedObject then
            v759 = if const v772 = v362[selectedObject] then "chip:" .. v772.id .. "#" .. v772.slot else selectedObject.Name
        else
            v759 = nil
        end

        v771.selected = v759 or false
        local v773 = selectedObject and v29[selectedObject]
        v771.slider = v773 and {key = v773.key, value = SettingsStore.Get(v773.key)} or false
        v771.nudgeSteps = v669.steps
        local chain = {}

        for _, v776 in navChain() do
            local parts = {}

            for _, item in v776.items do
                local v780

                if item then
                    v780 = if const v781 = v362[item] then "chip:" .. v781.id .. "#" .. v781.slot else item.Name
                else
                    v780 = nil
                end

                table.insert(parts, v780)
            end

            table.insert(chain, table.concat(parts, "|"))
        end

        v771.chain = chain

        if ui2 then
            v771.canvasY = math.floor(ui2.CanvasPosition.Y + 0.5)
            v771.view = math.floor(ui2.AbsoluteWindowSize.Y + 0.5)
            v771.canvasH = math.floor(ui2.AbsoluteCanvasSize.Y + 0.5)

            if selectedObject and selectedObject:IsDescendantOf(ui2) then
                local v782 = selectedObject.AbsolutePosition.Y - ui2.AbsolutePosition.Y
                v771.selTop, v771.selBottom = math.floor(v782 + 0.5), math.floor((v782 + selectedObject.AbsoluteSize.Y) + 0.5)
            end
        end

        local v783 = v206

        if v207 then
            local id = v207.id
            local slot = v207.slot
            local v786 = v207.pad and " pad" or " kb"
            capturing = id .. "#" .. slot .. v786
        else
            capturing = false
        end

        v771._capturing = capturing
        v771._card = v783 ~= nil and v783.layer.Visible
        v771._pad = if v783 then v783.line1.Text else nil

        if v783 then
            v761 = v783.holdHint.Visible and "hold B to cancel" or v783.line2.Text
        else
            v761 = nil
        end

        v771._hint = v761
        v771._notice = if ui6 and ui6.Visible and ui7 then ui7.Text else false
        local section = next(v361) ~= nil
        v771._section = section
        v771._resetEnabled = if v363 then v363.Instance.Selectable else nil
        v771._padCapturing = a18.PadCapturing == true
        local rows = {}

        for v789, v790 in v361 do
            local parts = {}

            for _, v793 in v790 do
                local glyph = v793.cap:FindFirstChild("Glyph")
                local v795 = v793.dash.Visible and "-"
                    or glyph and glyph.Visible and "img"
                    or v793.cap:FindFirstChild("Key").Text
                table.insert(parts, v795)
            end

            rows[v789] = table.concat(Keybinds.PadGet(v789), ",") .. " [" .. table.concat(parts, ",") .. "]"
        end

        v771.rows = rows

        return v771
    end

    a18.MenuManager.Register(
        "Settings",
        {
            open = (function()
                --[[
                  name: open
                  line: 2449
                  upvalues:
                    ui (copy, index: 1)
                    a18 (copy, index: 2)
                    userInputService (copy, index: 3)
                    v72 (ref,  index: 4)
                    v35 (ref,  index: 5)
                    build (copy, index: 6)
                    v27 (ref,  index: 7)
                    SettingsStore (copy, index: 8)
                    v34 (ref,  index: 9)
                    state (copy, index: 10)
                    v59 (ref,  index: 11)
                    v40 (ref,  index: 12)
                    count (ref,  index: 13)
                    ui2 (ref,  index: 14)
                    resize (copy, index: 15)
                    v25 (copy, index: 16)
                    selectedObject (ref,  index: 17)
                    guiService (copy, index: 18)
                ]]
                local v796 = ui.Compact and "c" or "d"
                local v797 = ui.Touch and a18.OpenTouchEditor ~= nil
                local v798 = v797 and "t" or ""
                local v799 = not ui.Touch and userInputService.KeyboardEnabled and not ui.Gamepad
                local v800 = v799 and "k" or ""
                local v801 = ui.Touch or ui.Gamepad or v72
                local v802 = v801 and "a" or ""
                local v803 = ui.Gamepad and "p" or ""

                if v796 .. v798 .. v800 .. v802 .. v803 ~= v35 then
                    build()
                end

                for v804, v805 in v27 do
                    v805(SettingsStore.Get(v804), true)
                end

                v34.Instance.Visible = state.InMatch()

                if v59 then
                    v59.layer.Visible = false
                end

                v40 = false
                count += 1
                v34:SetText("LEAVE MATCH")

                if ui2 then
                    ui2.CanvasPosition = Vector2.zero
                end

                resize()
                v25:Open()

                if selectedObject and ui.Gamepad then
                    guiService.SelectedObject = selectedObject
                end
            end),
            close = (function(a806)
                --[[
                  name: close
                  line: 2470
                  upvalues:
                    v59 (ref,  index: 1)
                    closeCapture (copy, index: 2)
                    sel (ref,  index: 3)
                    v669 (copy, index: 4)
                    v38 (ref,  index: 5)
                    ui2 (ref,  index: 6)
                    ui (copy, index: 7)
                    theme (copy, index: 8)
                    guiService (copy, index: 9)
                    v25 (copy, index: 10)
                ]]
                if v59 then
                    v59.layer.Visible = false
                end

                closeCapture()
                sel = nil
                v669.token += 1
                v669.dir = 0
                v669.source = nil

                if const v807 = v38 then
                    v38 = nil

                    if ui2 then
                        ui2.ScrollingEnabled = true
                    end

                    ui.Tween(ui.GetScaleObj(v807.knob), theme.Tween.PopSmall, {Scale = 1})
                end

                local selectedObject = guiService.SelectedObject

                if selectedObject and selectedObject:IsDescendantOf(v25.Root) then
                    guiService.SelectedObject = nil
                end

                v25:Close(a806)
            end),
            select = (function()
                --[[
                  name: select
                  line: 2482
                  upvalues:
                    v207 (ref,  index: 1)
                    sel (ref,  index: 2)
                    navUsable (copy, index: 3)
                    selectedObject (ref,  index: 4)
                ]]
                if v207 and v207.pad then
                    return nil
                end
                if sel and navUsable(sel) then
                    return sel
                end

                return selectedObject
            end),
            back = (function()
                --[[
                  name: back
                  line: 2493
                  upvalues:
                    v207 (ref,  index: 1)
                    closeCapture (copy, index: 2)
                    v59 (ref,  index: 3)
                    v34 (ref,  index: 4)
                    ui (copy, index: 5)
                    guiService (copy, index: 6)
                ]]
                if v207 then
                    if not v207.pad then
                        closeCapture()
                    end

                    return true
                end

                if not v59 or not v59.layer.Visible then
                    return false
                end

                if v59 then
                    v59.layer.Visible = false
                end

                if v34 and ui.Gamepad then
                    guiService.SelectedObject = v34.Instance
                end

                return true
            end)
        }
    )
end

return v6