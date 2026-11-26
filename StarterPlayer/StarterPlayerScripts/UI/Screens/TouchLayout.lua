local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")
local textChatService = game:GetService("TextChatService")
local userInputService = game:GetService("UserInputService")
local v7 = {}
local v8 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 33
      upvalues:
        v8 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    if v8 then
        return
    end

    local v10 = {}

    pcall(
        function()
            --[[
              line: 38
              upvalues:
                textChatService (copy, index: 1)
                v10 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration then
                v10.window = chatWindowConfiguration.Enabled
                chatWindowConfiguration.Enabled = false
            end

            if chatInputBarConfiguration then
                v10.bar = chatInputBarConfiguration.Enabled
                chatInputBarConfiguration.Enabled = false
            end

            v10.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    )

    v8 = v10
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 54
      upvalues:
        v8 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    local v14 = v8
    if not v14 then
        return
    end

    v8 = nil

    pcall(
        function()
            --[[
              line: 60
              upvalues:
                textChatService (copy, index: 1)
                v14 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v14.window ~= nil then
                chatWindowConfiguration.Enabled = v14.window
            end

            if chatInputBarConfiguration and v14.bar ~= nil then
                chatInputBarConfiguration.Enabled = v14.bar
            end

            if v14.core ~= nil then
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v14.core)
            end
        end
    )
end

local v17 = {{name = "Attack", gui = "CombatTouch", root = "Root", label = "ATTACK"}, {name = "Secondary", gui = "CombatTouch", root = "Root", label = "ALT"}, {name = "Reload", gui = "CombatTouch", root = "Root", label = "RELOAD"}, {name = "Jump", gui = "CharacterTouch", root = "Buttons", label = "JUMP"}, {name = "Slide", gui = "CharacterTouch", root = "Buttons", label = "SLIDE"}, {name = "View", gui = "CharacterTouch", root = "Buttons", label = "1P / 3P"}}

function v7.Init(a18)
    --[[
      name: Init
      line: 89
      upvalues:
        players (copy, index: 1)
        v17 (copy, index: 2)
        guiService (copy, index: 3)
        v8 (ref,  index: 4)
        textChatService (copy, index: 5)
        starterGui (copy, index: 6)
        runService (copy, index: 7)
        userInputService (copy, index: 8)
    ]]
    local ui = a18.UI
    local theme = a18.Theme
    local state = a18.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local _ = players.LocalPlayer
    local playerGui = a18.PlayerGui

    local function guiOf(a27)
        --[[
          name: guiOf
          line: 95
          upvalues:
            playerGui (copy, index: 1)
        ]]
        local v28 = playerGui:FindFirstChild(a27.gui)

        if v28 and v28:IsA("ScreenGui") then
            return v28
        end

        return nil
    end

    local function buttonOf(a30)
        --[[
          name: buttonOf
          line: 99
          upvalues:
            playerGui (copy, index: 1)
        ]]
        local v31 = playerGui:FindFirstChild(a30.gui)
        local v32 = if v31 and v31:IsA("ScreenGui") then v31 else nil
        local v33 = v32 and v32:FindFirstChild(a30.root)
        local v34 = v33 and v33:FindFirstChild(a30.name)

        if v34 and v34:IsA("GuiObject") then
            return v34
        end

        return nil
    end

    local editing = false

    local function savedValue(a37)
        --[[
          name: savedValue
          line: 108
          upvalues:
            state (copy, index: 1)
        ]]
        local settings = state.Profile and state.Profile.settings
        local setting = type(settings) == "table" and settings["touch_" .. a37]

        if type(setting) ~= "string" then
            return ""
        end

        return setting
    end

    local function applySaved()
        --[[
          name: applySaved
          line: 113
          upvalues:
            editing (ref,  index: 1)
            v17 (copy, index: 2)
            playerGui (copy, index: 3)
            state (copy, index: 4)
        ]]
        if editing then
            return
        end

        for _, v42 in v17 do
            local v43 = playerGui:FindFirstChild(v42.gui)

            if not v43 or not v43:IsA("ScreenGui") then
                v43 = nil
            end

            if v43 then
                local setting
                local name = v42.name
                local settings = state.Profile and state.Profile.settings
                local setting2 = type(settings) == "table" and settings["touch_" .. name]

                if type(setting2) == "string" then
                    setting = setting2
                else
                    setting = ""
                end

                local v48 = if setting ~= "" then setting else nil

                if v43:GetAttribute("Override_" .. v42.name) == v48 then
                    continue
                end

                v43:SetAttribute("Override_" .. v42.name, v48)
            end
        end
    end

    state.ProfileChanged:Connect(applySaved)

    playerGui.ChildAdded:Connect(
        function(a49)
            --[[
              line: 129
              upvalues:
                applySaved (copy, index: 1)
            ]]
            if a49.Name == "CombatTouch" or a49.Name == "CharacterTouch" then
                task.defer(applySaved)
            end
        end
    )

    task.defer(applySaved)
    local screenGui = nil
    local ui2 = nil
    local v52 = {}
    local v53 = {}
    local v54 = {}
    local name2 = nil
    local ui3 = nil
    local text = ""
    local v58 = 0

    local function rootSize()
        --[[
          name: rootSize
          line: 148
          upvalues:
            ui2 (ref, index: 1)
        ]]
        return ui2.AbsoluteSize
    end

    local function encode(a61, a62)
        --[[
          name: encode
          line: 154
          upvalues:
            ui2 (ref, index: 1)
        ]]
        local absoluteSize = ui2.AbsoluteSize
        return string.format("%d,%d,%d", math.floor(((a61.x / absoluteSize.X) * 1000) + 0.5), math.floor(((a61.y / absoluteSize.Y) * 1000) + 0.5), (math.floor(((a61.d / math.max(a62, 1)) * 1000) + 0.5)))
    end

    local function push(a65)
        --[[
          name: push
          line: 158
          upvalues:
            v53 (copy, index: 1)
            v17 (copy, index: 2)
            playerGui (copy, index: 3)
            encode (copy, index: 4)
        ]]
        local v66 = v53[a65]

        for _, v68 in v17 do
            if v68.name == a65 then
                local v69 = playerGui:FindFirstChild(v68.gui)

                if not v69 or not v69:IsA("ScreenGui") then
                    v69 = nil
                end

                local v70 = playerGui:FindFirstChild(v68.gui)

                if not v70 or not v70:IsA("ScreenGui") then
                    v70 = nil
                end

                local v71 = v70 and v70:FindFirstChild(v68.root)
                local v72 = v71 and v71:FindFirstChild(v68.name)
                local v73 = if v72 and v72:IsA("GuiObject") then v72 else nil

                if not v69 then
                    continue
                end
                if not v73 then
                    continue
                end
                if not v66 then
                    continue
                end

                local v74 = v73:GetAttribute("DefaultSize")
                local v75 = "Override_" .. a65

                if type(v74) ~= "number" then
                    v74 = v66.d
                end

                v69:SetAttribute(v75, encode(v66, v74))
            end
        end
    end

    local function readLive()
        --[[
          name: readLive
          line: 172
          upvalues:
            ui2 (ref,  index: 1)
            v17 (copy, index: 2)
            playerGui (copy, index: 3)
            v53 (copy, index: 4)
        ]]
        local ui = ui2

        for _, v79 in v17 do
            local v80 = playerGui:FindFirstChild(v79.gui)

            if not v80 or not v80:IsA("ScreenGui") then
                v80 = nil
            end

            local v81 = v80 and v80:FindFirstChild(v79.root)
            local v82 = v81 and v81:FindFirstChild(v79.name)
            local v83 = if v82 and v82:IsA("GuiObject") then v82 else nil

            if v83 and 4 < v83.AbsoluteSize.X then
                local v84 = v83.AbsolutePosition + (v83.AbsoluteSize / 2) - ui.AbsolutePosition
                v53[v79.name] = {x = v84.X, y = v84.Y, d = v83.AbsoluteSize.X}
            end
        end
    end

    local ui4 = nil
    local v86 = 0

    local function hotbarRect()
        --[[
          name: hotbarRect
          line: 185
          upvalues:
            ui2 (ref,  index: 1)
            a18 (copy, index: 2)
            ui (copy, index: 3)
        ]]
        local absoluteSize = ui2.AbsoluteSize
        local v89 = not a18.HotbarWidth and 404 or a18.HotbarWidth()
        local x = v89 * ui.Scale + 16
        local v91 = not a18.HotbarTop and 84 or a18.HotbarTop()
        local y = (v91 + 58) * ui.Scale

        return Vector2.new((absoluteSize.X / 2) - (x / 2), absoluteSize.Y - y), Vector2.new(x, y)
    end

    local function hitsBox(a94, a95, a96)
        --[[
          name: hitsBox
          line: 191
        ]]
        local x = math.clamp(a94.x, a95.X, a95.X + a96.X)
        local y = math.clamp(a94.y, a95.Y, a95.Y + a96.Y)

        return (Vector2.new(x, y) - Vector2.new(a94.x, a94.y)).Magnitude < a94.d / 2
    end

    local function valid(a100, a101)
        --[[
          name: valid
          line: 196
          upvalues:
            ui2 (ref,  index: 1)
            ui4 (ref,  index: 2)
            hitsBox (copy, index: 3)
            hotbarRect (copy, index: 4)
            guiService (copy, index: 5)
            v86 (ref,  index: 6)
            v53 (copy, index: 7)
            v52 (copy, index: 8)
        ]]
        local absoluteSize = ui2.AbsoluteSize
        local v103 = a101.d / 2

        if not (a101.x - v103 < 0) and not (a101.y - v103 < 0) then
            local v104 = a101.x + v103

            if not (absoluteSize.X < v104) then
                local v105 = a101.y + v103

                if not (absoluteSize.Y < v105) then
                    local ui = ui4

                    if ui
                        and ui2
                        and hitsBox(a101, ui.AbsolutePosition - ui2.AbsolutePosition, ui.AbsoluteSize)
                    then
                        return false
                    end

                    local vector2, v108 = hotbarRect()

                    if hitsBox(a101, vector2, v108) then
                        return false
                    end

                    local topbarInset = guiService.TopbarInset
                    v86 = math.max(v86, topbarInset.Min.X)

                    if 0 < topbarInset.Height
                        and hitsBox(a101, Vector2.zero, Vector2.new(v86, topbarInset.Max.Y))
                    then
                        return false
                    end

                    for v110, v111 in v53 do
                        if v110 ~= a100
                            and v52[v110]
                            and v52[v110].frame.Visible
                            and (Vector2.new(a101.x, a101.y) - Vector2.new(v111.x, v111.y)).Magnitude < (v103 + (v111.d / 2)) + 6
                        then
                            return false
                        end
                    end

                    return true
                end
            end
        end

        return false
    end

    local function clampInside(a113)
        --[[
          name: clampInside
          line: 228
          upvalues:
            ui2 (ref, index: 1)
        ]]
        local absoluteSize = ui2.AbsoluteSize
        local minValue = a113.d / 2

        return {x = math.clamp(a113.x, minValue, absoluteSize.X - minValue), y = math.clamp(a113.y, minValue, absoluteSize.Y - minValue), d = a113.d}
    end

    local function snap(a117)
        --[[
          name: snap
          line: 233
        ]]
        return math.floor((a117 / 8) + 0.5) * 8
    end

    local function paintHandles()
        --[[
          name: paintHandles
          line: 237
          upvalues:
            v52 (copy, index: 1)
            v53 (copy, index: 2)
            name2 (ref,  index: 3)
            colors (copy, index: 4)
            ui3 (ref,  index: 5)
            v58 (ref,  index: 6)
            text (ref,  index: 7)
        ]]
        for v119, v120 in v52 do
            local v121 = v53[v119]
            v120.frame.Visible = v121 ~= nil

            if v121 then
                v120.frame.Position = UDim2.fromOffset(v121.x, v121.y)
                v120.frame.Size = UDim2.fromOffset(v121.d, v121.d)
            end

            local visible = v119 == name2
            v120.stroke.Color = if visible then colors.Accent else colors.Text
            v120.stroke.Transparency = visible and 0 or 0.35
            v120.stroke.Thickness = visible and 3 or 2
            v120.knob.Visible = visible
            v120.frame.BackgroundTransparency = visible and 0.8 or 0.9
        end

        if ui3 then
            local v123 = name2 and v53[name2]

            if os.clock() < v58 then
                ui3.Text = text
                ui3.TextColor3 = colors.Danger

                return
            end

            ui3.Text = not v123 and "TAP A BUTTON"
                or string.format("%s  ·  %d", v52[name2].spec.label, (math.floor(v123.d)))
            ui3.TextColor3 = if v123 then colors.Text else colors.TextDim
        end
    end

    local function flash(a125)
        --[[
          name: flash
          line: 264
          upvalues:
            text (ref,  index: 1)
            v58 (ref,  index: 2)
            paintHandles (copy, index: 3)
        ]]
        local v126 = os.clock() + 1.2
        text = a125
        v58 = v126
        paintHandles()
    end

    local function tryMove(a128, a129)
        --[[
          name: tryMove
          line: 269
          upvalues:
            clampInside (copy, index: 1)
            valid (copy, index: 2)
            text (ref,  index: 3)
            v58 (ref,  index: 4)
            paintHandles (copy, index: 5)
            v53 (copy, index: 6)
            push (copy, index: 7)
        ]]
        a129 = clampInside({x = math.floor((a129.x / 8) + 0.5) * 8, y = math.floor((a129.y / 8) + 0.5) * 8, d = a129.d})

        if valid(a128, a129) then
            v53[a128] = a129
            push(a128)
            v58 = 0
            paintHandles()

            return true
        end

        local v130 = os.clock() + 1.2
        text = "TOO CLOSE"
        v58 = v130
        paintHandles()

        return false
    end

    local function tryResize(a132, a133)
        --[[
          name: tryResize
          line: 281
          upvalues:
            v53 (copy, index: 1)
            clampInside (copy, index: 2)
            valid (copy, index: 3)
            text (ref,  index: 4)
            v58 (ref,  index: 5)
            paintHandles (copy, index: 6)
            push (copy, index: 7)
        ]]
        local v134 = v53[a132]
        if not v134 then
            return false
        end

        local d = math.clamp(math.floor((a133 / 4) + 0.5) * 4, 52, 170)
        local v136 = clampInside({x = v134.x, y = v134.y, d = d})

        if valid(a132, v136) then
            v53[a132] = v136
            push(a132)
            paintHandles()

            return true
        end

        local v137 = os.clock() + 1.2
        text = "NO ROOM"
        v58 = v137
        paintHandles()

        return false
    end

    local v138 = nil

    local function pointerOf(a140)
        --[[
          name: pointerOf
          line: 300
          upvalues:
            ui2 (ref,  index: 1)
            ui (copy, index: 2)
        ]]
        local ui3 = ui2

        if a140.UserInputType == Enum.UserInputType.Touch then
            return Vector2.new(a140.Position.X, a140.Position.Y) - ui3.AbsolutePosition
        end

        return ui.PointerAbs() - ui3.AbsolutePosition
    end

    local function hideOthers(a143)
        --[[
          name: hideOthers
          line: 309
          upvalues:
            a18 (copy, index: 1)
            v8 (ref,  index: 2)
            textChatService (copy, index: 3)
            starterGui (copy, index: 4)
        ]]
        a18.SetHudHidden("TouchEditor", a143)

        if a18.TopbarSettings and a18.TopbarSettings.SetHidden then
            a18.TopbarSettings.SetHidden("TouchEditor", a143)
        end

        if a143 then
            if v8 then
                return
            end

            local v144 = {}

            pcall(
                function()
                    --[[
                      line: 38
                      upvalues:
                        textChatService (copy, index: 1)
                        v144 (copy, index: 2)
                        starterGui (copy, index: 3)
                    ]]
                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                    if chatWindowConfiguration then
                        v144.window = chatWindowConfiguration.Enabled
                        chatWindowConfiguration.Enabled = false
                    end

                    if chatInputBarConfiguration then
                        v144.bar = chatInputBarConfiguration.Enabled
                        chatInputBarConfiguration.Enabled = false
                    end

                    v144.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                end
            )

            v8 = v144

            return
        end

        local v147 = v8
        if not v147 then
            return
        end

        v8 = nil

        pcall(
            function()
                --[[
                  line: 60
                  upvalues:
                    textChatService (copy, index: 1)
                    v147 (copy, index: 2)
                    starterGui (copy, index: 3)
                ]]
                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                if chatWindowConfiguration and v147.window ~= nil then
                    chatWindowConfiguration.Enabled = v147.window
                end

                if chatInputBarConfiguration and v147.bar ~= nil then
                    chatInputBarConfiguration.Enabled = v147.bar
                end

                if v147.core ~= nil then
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v147.core)
                end
            end
        )
    end

    local v150 = nil

    local function build()
        --[[
          name: build
          line: 322
          upvalues:
            playerGui (copy, index: 1)
            screenGui (ref,  index: 2)
            ui (copy, index: 3)
            colors (copy, index: 4)
            ui2 (ref,  index: 5)
            name2 (ref,  index: 6)
            paintHandles (copy, index: 7)
            fonts (copy, index: 8)
            runService (copy, index: 9)
            editing (ref,  index: 10)
            hotbarRect (copy, index: 11)
            v17 (copy, index: 12)
            theme (copy, index: 13)
            v52 (copy, index: 14)
            v138 (ref,  index: 15)
            v53 (copy, index: 16)
            a18 (copy, index: 17)
            ui4 (ref,  index: 18)
            guiService (copy, index: 19)
            ui3 (ref,  index: 20)
            tryResize (copy, index: 21)
            readLive (copy, index: 22)
            v150 (ref,  index: 23)
            userInputService (copy, index: 24)
            tryMove (copy, index: 25)
        ]]
        local trTouchEditor = Instance.new("ScreenGui")
        trTouchEditor.Name = "TR_TouchEditor"
        trTouchEditor.ResetOnSpawn = false
        trTouchEditor.IgnoreGuiInset = true
        trTouchEditor.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        trTouchEditor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        trTouchEditor.DisplayOrder = 60
        trTouchEditor.Enabled = false
        trTouchEditor.Parent = playerGui
        screenGui = trTouchEditor
        local parent = ui.new("TextButton", {Name = "Root", BackgroundTransparency = 0.72, Text = "", AutoButtonColor = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = trTouchEditor})
        ui2 = parent
        local parent2 = ui.new("Frame", {Name = "Grid", ClipsDescendants = true, Size = UDim2.fromScale(1, 1), Parent = parent})

        for index = 1, 60 do
            ui.new("Frame", {BackgroundTransparency = 0.94, BorderSizePixel = 0, Position = UDim2.fromOffset((index * 8) * 4, 0), Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = colors.Text, Parent = parent2})
            ui.new("Frame", {BackgroundTransparency = 0.94, BorderSizePixel = 0, Position = UDim2.fromOffset(0, (index * 8) * 4), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = colors.Text, Parent = parent2})
        end

        parent.Activated:Connect(
            function()
                --[[
                  line: 349
                  upvalues:
                    name2 (ref,  index: 1)
                    paintHandles (copy, index: 2)
                ]]
                name2 = nil
                paintHandles()
            end
        )

        local parent3 = ui.new("Frame", {Name = "HotbarZone", BackgroundColor3 = colors.Text, BackgroundTransparency = 0.9, ZIndex = 2, ui.Corner(10), (ui.Stroke(colors.Text, 1, 0.7)), Parent = parent})
        ui.new("TextLabel", {Text = "HOTBAR", TextSize = 13, ZIndex = 2, Size = UDim2.fromScale(1, 1), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent3})

        runService.Heartbeat:Connect(
            function()
                --[[
                  line: 371
                  upvalues:
                    editing (ref,  index: 1)
                    hotbarRect (copy, index: 2)
                    parent3 (copy, index: 3)
                ]]
                if editing then
                    local vector2, v158 = hotbarRect()
                    parent3.Position = UDim2.fromOffset(vector2.X, vector2.Y)
                    parent3.Size = UDim2.fromOffset(v158.X, v158.Y)
                end
            end
        )

        for _, spec in v17 do
            local ui5 = ui.new("TextButton", {Name = spec.name, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = colors.Accent, BackgroundTransparency = 0.9, Text = "", AutoButtonColor = false, ZIndex = 5, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            local stroke = ui.Stroke(colors.Text, 2, 0.35)
            stroke.Parent = ui5
            local ui6 = ui.new("TextLabel", {TextSize = 12, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 4), Size = UDim2.fromOffset(120, 16), Text = spec.label, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = ui5})
            ui.TextStroke(colors.Void, 1, 0.3).Parent = ui6
            local knob = ui.new("TextButton", {Name = "Resize", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.854, 0.854), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = colors.Accent, Text = "", AutoButtonColor = false, Visible = false, ZIndex = 7, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Text, 2, 0)), Parent = ui5})
            v52[spec.name] = {spec = spec, frame = ui5, stroke = stroke, label = ui6, knob = knob}

            local function begin(input, mode: string)
                --[[
                  name: begin
                  line: 420
                  upvalues:
                    v138 (ref,  index: 1)
                    v53 (copy, index: 2)
                    spec (copy, index: 3)
                    name2 (ref,  index: 4)
                    ui2 (ref,  index: 5)
                    ui (copy, index: 6)
                    paintHandles (copy, index: 7)
                    a18 (copy, index: 8)
                ]]
                local userInputType = input.UserInputType

                if userInputType ~= Enum.UserInputType.Touch and userInputType ~= Enum.UserInputType.MouseButton1
                    or input.UserInputState ~= Enum.UserInputState.Begin
                    or v138
                then
                    return
                end

                local v169 = v53[spec.name]
                if not v169 then
                    return
                end

                name2 = spec.name
                local ui3 = ui2
                local v171 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) - ui3.AbsolutePosition else ui.PointerAbs() - ui3.AbsolutePosition
                local offset = v171 - Vector2.new(v169.x, v169.y)
                v138 = {input = input, name = spec.name, mode = mode, offset = offset, d0 = v169.d, dist0 = math.max(offset.Magnitude, 8)}
                paintHandles()
                a18.Sounds.Play("Select")
            end

            ui5.InputBegan:Connect(
                function(input)
                    --[[
                      line: 436
                      upvalues:
                        begin (copy, index: 1)
                    ]]
                    begin(input, "move")
                end
            )
            knob.InputBegan:Connect(
                function(input)
                    --[[
                      line: 439
                      upvalues:
                        begin (copy, index: 1)
                    ]]
                    begin(input, "resize")
                end
            )
        end

        local parent4 = ui.new("Frame", {Name = "Toolbar", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(476, 44), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.08, ZIndex = 10, ui.Corner(14), ui.Stroke(colors.Stroke, 1, 0.88), ui.Padding(0, 4), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
        ui4 = parent4
        local ui7 = ui.new("UIScale", {Parent = parent4})

        local function placeBar()
            --[[
              name: placeBar
              line: 461
              upvalues:
                parent (copy, index: 1)
                guiService (copy, index: 2)
                ui7 (copy, index: 3)
                parent4 (copy, index: 4)
            ]]
            local v178
            local absoluteSize = parent.AbsoluteSize
            local topbarInset = guiService.TopbarInset

            if not (1000 <= absoluteSize.X) then
                v178 = 1
            else
                v178 = 1.15
            end

            local v181 = 12
            local v182 = (v178 * 44) / 2 + 8
            local v183 = absoluteSize.X - 12

            if 0 < topbarInset.Height then
                v181 = topbarInset.Min.X + 8
                v182 = topbarInset.Min.Y + topbarInset.Height / 2
                v183 = math.min(v183, topbarInset.Max.X - 8)
            end

            local scale = math.min(v178, (v183 - v181) / 476)

            if 0.8 <= scale then
                ui7.Scale = scale
                parent4.Position = UDim2.fromOffset(v181, v182)

                return
            end

            local scale2 = math.min(v178, (absoluteSize.X - 24) / 476)
            ui7.Scale = scale2
            parent4.Position = UDim2.fromOffset((absoluteSize.X - (scale2 * 476)) / 2, math.max(v182 + 22, 44) + 6 + ((scale2 * 44) / 2))
        end

        placeBar()
        parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeBar)
        guiService:GetPropertyChangedSignal("TopbarInset"):Connect(placeBar)
        ui3 = ui.new("TextLabel", {Name = "Selected", Text = "", TextSize = 14, LayoutOrder = 1, ZIndex = 10, Size = UDim2.fromOffset(116, 36), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent4})

        local function stepBtn(name: string, iconName: string, layoutOrder: number, a190: number)
            --[[
              name: stepBtn
              line: 496
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                parent4 (copy, index: 3)
                name2 (ref,  index: 4)
                v53 (copy, index: 5)
                tryResize (copy, index: 6)
                a18 (copy, index: 7)
            ]]
            local v191 = ui.IconButton({IconScale = 0.42, Transparency = 0.1, ZIndex = 10, Name = name, IconName = iconName, Size = UDim2.fromOffset(36, 36), Color = colors.Raised, LayoutOrder = layoutOrder, Parent = parent4})

            v191.Activated:Connect(
                function()
                    --[[
                      line: 508
                      upvalues:
                        name2 (ref,  index: 1)
                        v53 (copy, index: 2)
                        tryResize (copy, index: 3)
                        a190 (copy, index: 4)
                        a18 (copy, index: 5)
                    ]]
                    if name2 and v53[name2] then
                        if tryResize(name2, v53[name2].d + a190) then
                            local pitch
                            local play = a18.Sounds.Play
                            local v194 = {}

                            if not (0 < a190) then
                                pitch = 0.9
                            else
                                pitch = 1.15
                            end

                            v194.pitch = pitch
                            play("Tick", v194)
                        else
                            a18.Sounds.Play("Error")
                        end
                    end
                end
            )
        end

        stepBtn("Smaller", "minus", 2, -8)
        stepBtn("Bigger", "plus", 3, 8)
        ui.new("Frame", {Name = "Gap", LayoutOrder = 4, Size = UDim2.fromOffset(6, 1), Parent = parent4})

        local function action(name: string, text: string, style: string, a199: number, layoutOrder: number, a201)
            --[[
              name: action
              line: 521
              upvalues:
                ui (copy, index: 1)
                parent4 (copy, index: 2)
            ]]
            local v202 = ui.Button({TextSize = 15, Radius = 10, ZIndex = 10, Name = name, Text = text, Style = style, Size = UDim2.fromOffset(a199, 36), LayoutOrder = layoutOrder, Parent = parent4})
            v202.Activated:Connect(a201)
        end

        action(
            "Reset",
            "RESET",
            "Dark",
            80,
            5,
            function()
                --[[
                  line: 525
                  upvalues:
                    v17 (copy, index: 1)
                    playerGui (copy, index: 2)
                    readLive (copy, index: 3)
                    v53 (copy, index: 4)
                    paintHandles (copy, index: 5)
                ]]
                for _, v204 in v17 do
                    local v205 = playerGui:FindFirstChild(v204.gui)

                    if not v205 or not v205:IsA("ScreenGui") then
                        v205 = nil
                    end

                    if v205 then
                        v205:SetAttribute("Override_" .. v204.name, nil)
                    end
                end

                task.wait()
                task.wait()
                readLive()

                for v206 in v53 do
                    v53[v206].x = math.floor((v53[v206].x / 8) + 0.5) * 8
                    v53[v206].y = math.floor((v53[v206].y / 8) + 0.5) * 8
                end

                paintHandles()
            end
        )

        action(
            "Cancel",
            "CANCEL",
            "Dark",
            90,
            6,
            function()
                --[[
                  line: 541
                  upvalues:
                    v150 (ref, index: 1)
                ]]
                v150(false)
            end
        )
        action(
            "Save",
            "SAVE",
            "Primary",
            80,
            7,
            function()
                --[[
                  line: 544
                  upvalues:
                    v150 (ref, index: 1)
                ]]
                v150(true)
            end
        )

        userInputService.InputChanged:Connect(
            function(input2: InputObject)
                --[[
                  line: 549
                  upvalues:
                    v138 (ref,  index: 1)
                    ui2 (ref,  index: 2)
                    ui (copy, index: 3)
                    v53 (copy, index: 4)
                    tryMove (copy, index: 5)
                    tryResize (copy, index: 6)
                ]]
                local v208 = v138
                if not v208 then
                    return
                end

                if v208.input.UserInputType ~= Enum.UserInputType.Touch then
                    if input2.UserInputType ~= Enum.UserInputType.MouseMovement then
                        return
                    end
                elseif input2 ~= v208.input then
                    return
                end

                local input = v208.input
                local ui3 = ui2
                local v211 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) - ui3.AbsolutePosition else ui.PointerAbs() - ui3.AbsolutePosition
                local v212 = v53[v208.name]
                if not v212 then
                    return
                end

                if v208.mode == "move" then
                    tryMove(v208.name, {x = v211.X - v208.offset.X, y = v211.Y - v208.offset.Y, d = v212.d})
                    return
                end

                local magnitude = (v211 - Vector2.new(v212.x, v212.y)).Magnitude
                tryResize(v208.name, v208.d0 * magnitude / v208.dist0)
            end
        )

        local function ended(inputObject: InputObject)
            --[[
              name: ended
              line: 574
              upvalues:
                v138 (ref, index: 1)
            ]]
            local v216 = v138
            if not v216 then
                return
            end

            if v216.input.UserInputType ~= Enum.UserInputType.Touch then
                if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
            elseif inputObject ~= v216.input then
                return
            end

            v138 = nil
        end

        userInputService.InputEnded:Connect(ended)
        userInputService.TouchEnded:Connect(ended)

        runService.Heartbeat:Connect(
            function()
                --[[
                  line: 593
                  upvalues:
                    editing (ref,  index: 1)
                    v138 (ref,  index: 2)
                    v53 (copy, index: 3)
                    readLive (copy, index: 4)
                    paintHandles (copy, index: 5)
                ]]
                if not editing then
                    return
                end

                local name = v138 and v138.name
                local v218 = name and v53[name]
                readLive()

                if name and v218 then
                    v53[name] = v218
                end

                paintHandles()
            end
        )
    end

    local function open()
        --[[
          name: open
          line: 607
          upvalues:
            editing (ref,  index: 1)
            screenGui (ref,  index: 2)
            build (copy, index: 3)
            v86 (ref,  index: 4)
            guiService (copy, index: 5)
            a18 (copy, index: 6)
            v8 (ref,  index: 7)
            textChatService (copy, index: 8)
            starterGui (copy, index: 9)
            v54 (copy, index: 10)
            v17 (copy, index: 11)
            playerGui (copy, index: 12)
            name2 (ref,  index: 13)
            v58 (ref,  index: 14)
            v53 (copy, index: 15)
            readLive (copy, index: 16)
            paintHandles (copy, index: 17)
        ]]
        if editing then
            return
        end

        if not screenGui then
            build()
        end

        editing = true
        v86 = guiService.TopbarInset.Min.X
        a18.MenuManager.CloseAll(true)
        a18.MenuManager.PushMouse("TouchEditor")
        a18.SetHudHidden("TouchEditor", true)

        if a18.TopbarSettings and a18.TopbarSettings.SetHidden then
            a18.TopbarSettings.SetHidden("TouchEditor", true)
        end

        if not v8 then
            local v220 = {}

            pcall(
                function()
                    --[[
                      line: 38
                      upvalues:
                        textChatService (copy, index: 1)
                        v220 (copy, index: 2)
                        starterGui (copy, index: 3)
                    ]]
                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                    if chatWindowConfiguration then
                        v220.window = chatWindowConfiguration.Enabled
                        chatWindowConfiguration.Enabled = false
                    end

                    if chatInputBarConfiguration then
                        v220.bar = chatInputBarConfiguration.Enabled
                        chatInputBarConfiguration.Enabled = false
                    end

                    v220.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                end
            )

            v8 = v220
        end

        table.clear(v54)

        for _, v224 in v17 do
            local v225 = playerGui:FindFirstChild(v224.gui)

            if not v225 or not v225:IsA("ScreenGui") then
                v225 = nil
            end

            if v225 then
                v54[v224.name] = v225:GetAttribute("Override_" .. v224.name)
                v225:SetAttribute("EditPreview", true)
            end
        end

        name2 = nil
        v58 = 0
        screenGui.Enabled = true
        task.wait()
        task.wait()
        table.clear(v53)
        readLive()
        paintHandles()
        a18.Sounds.Play("Open")
    end

    v150 = function(a226)
        --[[
          line: 638
          upvalues:
            editing (ref,  index: 1)
            v138 (ref,  index: 2)
            v17 (copy, index: 3)
            playerGui (copy, index: 4)
            v54 (copy, index: 5)
            screenGui (ref,  index: 6)
            a18 (copy, index: 7)
            v8 (ref,  index: 8)
            textChatService (copy, index: 9)
            starterGui (copy, index: 10)
            state (copy, index: 11)
            applySaved (copy, index: 12)
        ]]
        if not editing then
            return
        end

        v138 = nil
        local v227 = {}

        for _, v229 in v17 do
            local v230 = playerGui:FindFirstChild(v229.gui)

            if not v230 or not v230:IsA("ScreenGui") then
                v230 = nil
            end

            if v230 then
                local v231 = v230:GetAttribute("Override_" .. v229.name)
                local name = v229.name

                if type(v231) ~= "string" then
                    v231 = ""
                end

                v227[name] = v231

                if not a226 then
                    v230:SetAttribute("Override_" .. v229.name, v54[v229.name])
                end

                v230:SetAttribute("EditPreview", nil)
            end
        end

        screenGui.Enabled = false
        editing = false
        a18.MenuManager.PopMouse("TouchEditor")
        a18.SetHudHidden("TouchEditor", false)

        if a18.TopbarSettings and a18.TopbarSettings.SetHidden then
            a18.TopbarSettings.SetHidden("TouchEditor", false)
        end

        if const v233 = v8 then
            v8 = nil

            pcall(
                function()
                    --[[
                      line: 60
                      upvalues:
                        textChatService (copy, index: 1)
                        v233 (copy, index: 2)
                        starterGui (copy, index: 3)
                    ]]
                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                    if chatWindowConfiguration and v233.window ~= nil then
                        chatWindowConfiguration.Enabled = v233.window
                    end

                    if chatInputBarConfiguration and v233.bar ~= nil then
                        chatInputBarConfiguration.Enabled = v233.bar
                    end

                    if v233.core ~= nil then
                        starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v233.core)
                    end
                end
            )
        end

        if not a226 then
            a18.Sounds.Play("Close")
            return
        end

        local v236
        a18.Sounds.Play("Equip")
        local settings = state.Profile.settings

        if type(settings) == "table" then
            v236 = settings
        else
            local settings2 = {}
            state.Profile.settings = settings2
            v236 = settings2
        end

        task.spawn(
            function()
                --[[
                  line: 666
                  upvalues:
                    v17 (copy, index: 1)
                    v227 (copy, index: 2)
                    state (copy, index: 3)
                    a18 (copy, index: 4)
                    v236 (ref,  index: 5)
                    applySaved (copy, index: 6)
                ]]
                local v239 = true

                for _, v241 in v17 do
                    local setting
                    local v243 = v227[v241.name] or ""
                    local name = v241.name
                    local settings = state.Profile and state.Profile.settings
                    local setting2 = type(settings) == "table" and settings["touch_" .. name]

                    if type(setting2) == "string" then
                        setting = setting2
                    else
                        setting = ""
                    end

                    if setting ~= v243 then
                        if a18.ProfileAction("SetSetting", "touch_" .. v241.name, v243) then
                            v236["touch_" .. v241.name] = v243
                        else
                            v239 = false
                        end
                    end
                end

                local toast = a18.Toast
                local v248 = v239 and "Controls saved" or "Couldn't save every button"
                local v249 = v239 and "info" or "error"
                toast(v248, v249)
                applySaved()
            end
        )
    end

    state.PlayerStateChanged:Connect(
        function()
            --[[
              line: 688
              upvalues:
                editing (ref, index: 1)
                v150 (ref, index: 2)
            ]]
            if editing then
                v150(false)
            end
        end
    )

    a18.OpenTouchEditor = function()
        --[[
          line: 694
          upvalues:
            open (copy, index: 1)
        ]]
        task.spawn(open)
    end

    a18.Debug.touchEditor = function(a250, key, a252, a253)
        --[[
          line: 697
          upvalues:
            open (copy, index: 1)
            v150 (ref,  index: 2)
            v53 (copy, index: 3)
            tryMove (copy, index: 4)
            tryResize (copy, index: 5)
            ui4 (ref,  index: 6)
            guiService (copy, index: 7)
            editing (ref,  index: 8)
            name2 (ref,  index: 9)
            ui3 (ref,  index: 10)
        ]]
        if a250 == "open" then
            task.spawn(open)
        elseif a250 == "save" then
            v150(true)
        elseif a250 == "cancel" then
            v150(false)
        elseif a250 == "move" and type(key) == "string" and v53[key] then
            local v254 = {}
            local v255 = tonumber(a252) or v53[key].x
            v254.x = v255
            local v256 = tonumber(a253) or v53[key].y
            v254.y = v256
            v254.d = v53[key].d
            tryMove(key, v254)
        elseif a250 == "size" and type(key) == "string" then
            tryResize(key, (tonumber(a252) or 80))
        end

        local rects = {}

        for v258, v259 in v53 do
            rects[v258] = string.format("%d,%d,%d", v259.x, v259.y, v259.d)
        end

        local bar = if const ui = ui4 then {x = ui.AbsolutePosition.X, y = ui.AbsolutePosition.Y, w = ui.AbsoluteSize.X, h = ui.AbsoluteSize.Y} else nil
        local topbarInset = guiService.TopbarInset
        local v263 = {editing = editing, rects = rects, selected = name2, bar = bar, inset = {topbarInset.Min.X, topbarInset.Min.Y, topbarInset.Max.X, topbarInset.Max.Y}}
        v263.label = ui3 and ui3.Text
        return v263
    end
end

return v7