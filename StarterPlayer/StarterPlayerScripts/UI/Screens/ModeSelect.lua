local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local GuiService_upv_1 = game:GetService("GuiService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Keybinds_upv_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_1 = {}
local fromRGB_upv_1 = Color3.fromRGB
local tbl_upv_2 = {{key = "1", name = "3V3", id = "3v3", kicker = "TEAM BATTLE", play = "PLAY 3V3", desc = "Team up with two allies. Last team standing takes the round.", keyCode = Enum.KeyCode.One}, {key = "2", name = "1V1", id = "1v1", kicker = "DUEL", play = "PLAY 1V1", desc = "Just you and one rival. No teammates, no excuses.", keyCode = Enum.KeyCode.Two}}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 52
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        fromRGB_upv_1 (copy, index: 3)
        GuiService_upv_1 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        Keybinds_upv_1 (copy, index: 6)
        UserInputService_upv_1 (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local MenuManager_upv_1 = a1.MenuManager
    local fromOffset_upv_1 = UDim2.fromOffset
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local SettingsStore_upv_1 = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local RankArt_upv_1 = require(script.Parent.Parent:WaitForChild("RankArt"))
    local Config_upv_1 = nil
    pcall(
        function()
            --[[
              line: 63
              upvalues:
                Config_upv_1 (ref,  index: 1)
                ReplicatedStorage_upv_1 (copy, index: 2)
            ]]
            Config_upv_1 = require(ReplicatedStorage_upv_1.Shared:WaitForChild("Config"))
        end
    )
    local function modeConfig(a2)
        --[[
          name: modeConfig
          line: 66
          upvalues:
            Config_upv_1 (ref, index: 1)
        ]]
        local v1
        if type(Config_upv_1) ~= "table" then
            v1 = nil
        else
            v1 = Config_upv_1.MODES
        end
        local v2
        if type(v1) ~= "table" then
            v2 = nil
        else
            v2 = v1[a2]
        end
        if type(v2) ~= "table" then
            return nil
        end
        return v2
    end
    local function roundsToWin(a3)
        --[[
          name: roundsToWin
          line: 71
          upvalues:
            Config_upv_1 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        local v3
        if type(Config_upv_1) ~= "table" then
            v3 = nil
        else
            v3 = Config_upv_1.MODES
        end
        local v4
        if type(v3) ~= "table" then
            v4 = nil
        else
            v4 = v3[a3]
        end
        local v5
        if type(v4) ~= "table" then
            v5 = nil
        else
            v5 = v4
        end
        local v6 = tonumber(v5 and (v5.roundsToWin)) or (State_upv_1.DEFAULT_ROUNDS_TO_WIN)
        return (math.clamp(math.floor(v6), 1, 9))
    end
    local function ranked()
        --[[
          name: ranked
          line: 75
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
        ]]
        local v7 = SettingsStore_upv_1.Get("mmRanked") > 0.5
        return v7
    end
    local function memBits()
        --[[
          name: memBits
          line: 81
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
        ]]
        return (math.floor(SettingsStore_upv_1.Get("modeSel")))
    end
    local function setBits(a4)
        --[[
          name: setBits
          line: 84
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
        ]]
        if a4 == math.floor(SettingsStore_upv_1.Get("modeSel")) then
            return
        end
        SettingsStore_upv_1.Set("modeSel", a4, true)
    end
    local function lastMode()
        --[[
          name: lastMode
          line: 89
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
        ]]
        if bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1) then
            return "1v1"
        end
        return "3v3"
    end
    local function lockReason(a5)
        --[[
          name: lockReason
          line: 94
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        if a5 == "1v1" then
            if State_upv_1.Get("Duel") == true then
                local v8
                if (a1.Party) and (a1.Party.Size) then
                    v8 = a1.Party.Size()
                else
                    v8 = 1
                end
                if v8 >= 2 then
                    return "LEAVE YOUR PARTY TO PLAY 1V1"
                end
                return nil
            end
            return "PLAY 3 MATCHES FIRST"
        end
        return nil
    end
    local u1 = nil
    local u2 = nil
    local u3 = nil
    local u4 = nil
    local u5 = nil
    local u6 = nil
    local u7 = nil
    local u8 = nil
    local u9 = nil
    local u10 = nil
    local u11 = nil
    local u12 = nil
    local tbl_upv_3 = {}
    local u13 = 1
    local u14 = false
    local u15 = false
    local u16 = 0
    local u17 = false
    local ButtonStyles_upv_1 = UI_upv_1.ButtonStyles
    local function geo()
        --[[
          name: geo
          line: 110
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            local tbl_4 = {nameSize = 76, ctaText = 26, kickerSize = 16, gap = 26, art = 232, W = 470, chipH = 32, pad = 10, H = 438, cta = 62, chipText = 15, headGap = 18, descSize = 18, titleSize = 34}
            tbl_4.headH = UI_upv_1.WindowCloseSize()
            return tbl_4
        else
            local tbl_5 = {nameSize = 92, ctaText = 26, kickerSize = 17, gap = 32, art = 300, W = 450, chipH = 32, pad = 10, H = 520, cta = 64, chipText = 15, headGap = 18, descSize = 18, titleSize = 40}
            tbl_5.headH = UI_upv_1.WindowCloseSize()
            return tbl_5
        end
    end
    local function chip(a6, a7, a8, a9, a10)
        --[[
          name: chip
          line: 187
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
        ]]
        local tbl_6 = {}
        tbl_6.Name = "Chip" .. a7
        tbl_6.AutomaticSize = Enum.AutomaticSize.X
        tbl_6.Size = UDim2.fromOffset(0, a10.chipH)
        tbl_6.BackgroundColor3 = Colors_upv_1.Inset
        tbl_6.BackgroundTransparency = 0.25
        tbl_6.LayoutOrder = a7
        tbl_6[1], tbl_6[2], tbl_6[3], tbl_6[4] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88), UI_upv_1.Padding(0, 13, 0, 9), UI_upv_1.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_6.Parent = a6
        local v9 = UI_upv_1.new("Frame", tbl_6)
        a8.LayoutOrder = 1
        a8.Parent = v9
        return v9, (UI_upv_1.new("TextLabel", {LayoutOrder = 2, Name = "Text", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Text = a9, FontFace = Fonts_upv_1.Heavy, TextSize = a10.chipText, TextColor3 = Colors_upv_1.TextDim, Parent = v9}))
    end
    local function makeCard(a11, a12, a13)
        --[[
          name: makeCard
          line: 217
          upvalues:
            geo (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            u12 (ref,  index: 4)
            fromRGB_upv_1 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            chip (copy, index: 9)
            ButtonStyles_upv_1 (copy, index: 10)
        ]]
        local v10 = geo()
        local v11 = a11.id == "1v1"
        local v12 = UI_upv_1.new("TextButton", {Selectable = true, Name = "Mode_" .. a11.id, Size = fromOffset_upv_1(v10.W, v10.H), SelectionImageObject = u12, Parent = a13})
        local v13 = UI_upv_1.new("Frame", {Name = "Lift", Size = UDim2.fromScale(1, 1), Parent = v12})
        local Image_1 = UI_upv_1.Image
        local Glow_1 = UI_upv_1.Assets.Icons.Glow
        local tbl_7 = {ImageColor3 = 0, ScaleType = 0, ImageTransparency = 1, Parent = 0, Name = "Glow", ZIndex = 0}
        tbl_7.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_7.Position = UDim2.fromScale(0.5, 0.56)
        tbl_7.Size = UDim2.fromScale(1.45, 1.3)
        local v14
        if v11 then
            v14 = fromRGB_upv_1(255, 120, 110)
        else
            v14 = Colors_upv_1.Accent
        end
        tbl_7.ImageColor3 = v14
        tbl_7.ScaleType = Enum.ScaleType.Stretch
        tbl_7.Parent = v13
        local v15 = Image_1(Glow_1, tbl_7)
        UI_upv_1.DropShadow(v13, 20, 10, 0.55)
        local v16 = UI_upv_1.Panel({StrokeTransparency = 0.86, Name = "Body", ZIndex = 2, BackgroundTransparency = 0.03, Size = UDim2.fromScale(1, 1), TopColor = Colors_upv_1.PanelHi, BottomColor = Colors_upv_1.Panel, Radius = UDim.new(0, 20), Parent = v13})
        local v17 = UI_upv_1.new("Frame", {Name = "Art", Position = fromOffset_upv_1(v10.pad, v10.pad), Size = UDim2.new(1, v10.pad * -2, 0, v10.art), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, [1] = UI_upv_1.Corner(14), Parent = v16})
        local v18 = UI_upv_1.Gradient(ColorSequence.new(Colors_upv_1.Panel), nil, 90)
        v18.Parent = v17
        local tbl_8 = {}
        if v11 then
            v18.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, fromRGB_upv_1(14, 52, 112)), ColorSequenceKeypoint.new(0.47, fromRGB_upv_1(28, 92, 178)), ColorSequenceKeypoint.new(0.5, fromRGB_upv_1(18, 22, 34)), ColorSequenceKeypoint.new(0.53, fromRGB_upv_1(170, 36, 48)), ColorSequenceKeypoint.new(1, fromRGB_upv_1(92, 16, 26))})
            v18.Rotation = 14
            table.insert(tbl_8, UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "GlowL", ImageTransparency = 0.6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.25, 0.42), Size = UDim2.fromScale(0.75, 1.1), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = fromRGB_upv_1(90, 170, 255), Parent = v17}))
            table.insert(tbl_8, UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "GlowR", ImageTransparency = 0.62, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.75, 0.42), Size = UDim2.fromScale(0.75, 1.1), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = fromRGB_upv_1(255, 96, 90), Parent = v17}))
            table.insert(tbl_8, UI_upv_1.Image(UI_upv_1.Assets.Fx.Flare, {ImageTransparency = 0.45, Name = "Streak", Rotation = 104, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.new(0, 560, 0, 52), ImageColor3 = fromRGB_upv_1(255, 214, 170), Parent = v17}))
        else
            v18.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, fromRGB_upv_1(30, 104, 196)), ColorSequenceKeypoint.new(0.55, fromRGB_upv_1(16, 58, 124)), ColorSequenceKeypoint.new(1, fromRGB_upv_1(10, 30, 70))})
            v18.Rotation = 90
            table.insert(tbl_8, UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "GlowC", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.38), Size = UDim2.fromScale(1.05, 1.15), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = fromRGB_upv_1(110, 190, 255), Parent = v17}))
            for key_1, value_1 in {0.22, 0.5, 0.78} do
                local Image_2 = UI_upv_1.Image
                local Beam_1 = UI_upv_1.Assets.Fx.Beam
                local tbl_9 = {ImageColor3 = 0, ScaleType = 0, ImageTransparency = 0, Parent = 0, Rotation = 180, Size = 0}
                tbl_9.Name = "Beam" .. key_1
                tbl_9.AnchorPoint = Vector2.new(0.5, 0)
                tbl_9.Position = UDim2.fromScale(value_1, 0)
                tbl_9.Size = UDim2.new(0, ((key_1 ~= 2) and 120) or 150, 1, 0)
                tbl_9.ScaleType = Enum.ScaleType.Stretch
                tbl_9.ImageColor3 = fromRGB_upv_1(160, 210, 255)
                tbl_9.ImageTransparency = ((key_1 ~= 2) and 0.8) or 0.72
                tbl_9.Parent = v17
                table.insert(tbl_8, Image_2(Beam_1, tbl_9))
            end
        end
        for _, value_2 in tbl_8 do
            if value_2:IsA("ImageLabel") then
                value_2:SetAttribute("Tint", value_2.ImageColor3)
                value_2:SetAttribute("BaseT", value_2.ImageTransparency)
            end
        end
        local v19 = UI_upv_1.new("ViewportFrame", {Name = "Scene", Size = UDim2.fromScale(1, 1), Ambient = fromRGB_upv_1(140, 146, 160), LightColor = fromRGB_upv_1(255, 246, 232), LightDirection = Vector3.new(-0.550000011920929, -0.699999988079071, 0.44999998807907104), ZIndex = 2, [1] = UI_upv_1.Corner(14), Parent = v17})
        local v20 = UI_upv_1.new("Frame", {Name = "Veil", Size = UDim2.fromScale(1, 1), BackgroundColor3 = fromRGB_upv_1(16, 18, 24), BackgroundTransparency = 0.3, Visible = false, ZIndex = 3, [1] = UI_upv_1.Corner(14), Parent = v17})
        local v21 = UI_upv_1.new("Frame", {Name = "Scrim", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.62), BackgroundColor3 = Colors_upv_1.Void, ZIndex = 3, [1] = UI_upv_1.Gradient(Colors_upv_1.Void, Colors_upv_1.Void, 90, NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.55), NumberSequenceKeypoint.new(1, 0.12)})), Parent = v17})
        local v22 = UI_upv_1.new("TextLabel", {ZIndex = 4, Name = "ModeName", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 22, 1, 6), Size = UDim2.new(1, -44, 0, v10.nameSize), Text = a11.name, FontFace = Fonts_upv_1.Display, TextSize = v10.nameSize, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Parent = v17})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.55).Parent = v22
        local new_1 = UI_upv_1.new
        local tbl_10 = {TextColor3 = 0, Parent = 0, Name = "Kicker", TextXAlignment = 0, ZIndex = 4}
        tbl_10.AnchorPoint = Vector2.new(0, 1)
        tbl_10.Position = UDim2.new(0, 25, 1, -v10.nameSize + 8)
        tbl_10.Size = UDim2.new(1, -50, 0, v10.kickerSize + 4)
        tbl_10.Text = a11.kicker
        tbl_10.FontFace = Fonts_upv_1.Heavy
        tbl_10.TextSize = v10.kickerSize
        local v23
        if v11 then
            v23 = fromRGB_upv_1(255, 178, 170)
        else
            v23 = fromRGB_upv_1(150, 206, 255)
        end
        tbl_10.TextColor3 = v23
        tbl_10.TextXAlignment = Enum.TextXAlignment.Left
        tbl_10.Parent = v17
        local v24 = new_1("TextLabel", tbl_10)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.5).Parent = v24
        local v25 = UI_upv_1.Pill("NEW", Colors_upv_1.Gold, {Name = "New", Height = 26, ZIndex = 5, TextSize = 15, TextColor = Colors_upv_1.TextDark, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Parent = v17})
        v25.Visible = false
        if not (v11) then
            local tbl_11 = {}
            tbl_11.Name = "Recommended"
            tbl_11.AnchorPoint = Vector2.new(1, 0)
            tbl_11.Position = UDim2.new(1, -12, 0, 12)
            tbl_11.Size = fromOffset_upv_1(0, 26)
            tbl_11.AutomaticSize = Enum.AutomaticSize.X
            tbl_11.BackgroundColor3 = Colors_upv_1.SuccessDark
            tbl_11.BackgroundTransparency = 0.05
            tbl_11.ZIndex = 5
            tbl_11[1], tbl_11[2], tbl_11[3], tbl_11[4] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Success, 1, 0.35), UI_upv_1.Padding(0, 11, 0, 8), UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
            tbl_11.Parent = v17
            local v26 = UI_upv_1.new("Frame", tbl_11)
            UI_upv_1.Icon("check", 15, Colors_upv_1.Text, {LayoutOrder = 1, ZIndex = 5, Parent = v26})
            UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "RECOMMENDED", Name = "Text", TextSize = 14, ZIndex = 5, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v26})
        end
        local v27 = v10.pad + v10.art + 16
        local v28 = UI_upv_1.new("TextLabel", {TextWrapped = true, Name = "Desc", Position = fromOffset_upv_1(24, v27), Size = UDim2.new(1, -48, 0, (v10.descSize * 2) + 6), Text = a11.desc, FontFace = Fonts_upv_1.SemiBold, TextSize = v10.descSize, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v16})
        local v29 = UI_upv_1.new("Frame", {Name = "Chips", Position = fromOffset_upv_1(22, (v27 + (v10.descSize * 2)) + 16), Size = UDim2.new(1, -44, 0, v10.chipH), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v16})
        local _, v30 = chip(v29, 1, UI_upv_1.Image(UI_upv_1.Assets.Icons.CrossedArrows, {Size = fromOffset_upv_1(18, 17), ImageColor3 = Colors_upv_1.TextDim}), "", v10)
        local v31 = UI_upv_1.new("Frame", {Name = "Play", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -v10.pad), Size = UDim2.new(1, v10.pad * -2, 0, v10.cta), Parent = v16})
        v27 = UI_upv_1.new("Frame", {Name = "Lip", Position = fromOffset_upv_1(0, 3), Size = UDim2.new(1, 0, 1, -3), BackgroundColor3 = ButtonStyles_upv_1.Dark.lip, [1] = UI_upv_1.Corner(14), Parent = v31})
        local v32 = UI_upv_1.new("Frame", {Name = "Face", Size = UDim2.new(1, 0, 1, -3), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(14), Parent = v31})
        local v33 = UI_upv_1.Gradient(ButtonStyles_upv_1.Dark.top, ButtonStyles_upv_1.Dark.bottom, 90)
        v33.Parent = v32
        local v34 = UI_upv_1.Stroke(ButtonStyles_upv_1.Dark.stroke, 1, 0.6)
        v34.Parent = v32
        local v35 = UI_upv_1.new("Frame", {Name = "Glow", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 3, [1] = UI_upv_1.Corner(14), Parent = v32})
        local v36 = UI_upv_1.new("TextLabel", {ZIndex = 2, Name = "Label", Size = UDim2.fromScale(1, 1), Text = a11.play, FontFace = Fonts_upv_1.Display, TextSize = v10.ctaText, TextColor3 = Colors_upv_1.Text, Parent = v32})
        local v37 = UI_upv_1.KeyCap(a11.key, {Height = 28, ZIndex = 2, TextSize = 17, Managed = true, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = v32})
        local v38 = UI_upv_1.new("Frame", {Visible = false, Name = "Pad", ZIndex = 2, Size = UDim2.fromScale(1, 1), Parent = v32})
        UI_upv_1.PadCap(Enum.KeyCode.ButtonA, {Height = 30, ZIndex = 2, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = v38})
        local v39 = UI_upv_1.new("Frame", {Name = "Locked", Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v32})
        UI_upv_1.Image(UI_upv_1.Assets.Icons.Lock, {Name = "Lock", ZIndex = 2, LayoutOrder = 1, Size = fromOffset_upv_1(22, 22), ImageColor3 = Colors_upv_1.TextDim, Parent = v39})
        v32 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "", Name = "Reason", TextSize = 17, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v39})
        local v40 = UI_upv_1.new("Frame", {Name = "Ring", Size = UDim2.fromScale(1, 1), ZIndex = 3, [1] = UI_upv_1.Corner(20), Parent = v13})
        local v41 = UI_upv_1.Stroke(Colors_upv_1.Accent, 3, 1)
        v41.Parent = v40
        local v42 = UI_upv_1.Pill("LAST PLAYED", Colors_upv_1.Accent, {Name = "Last", Height = 26, ZIndex = 6, TextSize = 14, PadX = 12, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0), Parent = v13})
        v42.Visible = false
        local tbl_12 = {}
        tbl_12.def = a11
        tbl_12.index = a12
        tbl_12.btn = v12
        tbl_12.lift = v13
        tbl_12.body = v16
        tbl_12.glow = v15
        tbl_12.ring = v41
        tbl_12.art = v17
        tbl_12.bg = v18
        tbl_12.deco = tbl_8
        tbl_12.vpf = v19
        tbl_12.veil = v20
        tbl_12.scrim = v21
        tbl_12.kicker = v24
        tbl_12.name = v22
        tbl_12.desc = v28
        tbl_12.chips = v29
        tbl_12.roundsText = v30
        tbl_12.cta = v31
        tbl_12.ctaGrad = v33
        tbl_12.ctaLip = v27
        tbl_12.ctaStroke = v34
        tbl_12.ctaGlow = v35
        tbl_12.ctaLabel = v36
        tbl_12.ctaKey = v37
        tbl_12.ctaPad = v38
        tbl_12.lockRow = v39
        tbl_12.lockText = v32
        tbl_12.topPill = v42
        tbl_12.topPillText = v42:FindFirstChild("Text")
        tbl_12.newPill = v25
        tbl_12.scene = nil
        tbl_12.foc = 0
        tbl_12.up = 0
        tbl_12.hover = false
        return tbl_12
    end
    local tbl_upv_13 = {ProximityPrompt = true, ForceField = true, SelectionBox = true, Smoke = true, AngularVelocity = true, BillboardGui = true, BodyVelocity = true, Sound = true, ClickDetector = true, LinearVelocity = true, AlignPosition = true, BodyPosition = true, VectorForce = true, AlignOrientation = true, SurfaceGui = true, Sparkles = true, Fire = true, Highlight = true, BodyGyro = true}
    local function silhouette(a14, a15)
        --[[
          name: silhouette
          line: 600
        ]]
        for _, value_3 in a14:GetDescendants() do
            if value_3:IsA("Accessory") or value_3:IsA("Clothing") or value_3:IsA("ShirtGraphic") or value_3:IsA("Decal") or value_3:IsA("SurfaceAppearance") or value_3:IsA("BodyColors") or value_3:IsA("WrapLayer") then
                value_3:Destroy()
            end
        end
        for _, value_upv_4 in a14:GetDescendants() do
            if value_upv_4:IsA("BasePart") then
                value_upv_4.Color = a15
                value_upv_4.Material = Enum.Material.SmoothPlastic
                if value_upv_4:IsA("MeshPart") then
                    pcall(
                        function()
                            --[[
                              line: 611
                              upvalues:
                                value_upv_4 (copy, index: 1)
                            ]]
                            value_upv_4.TextureID = ""
                        end
                    )
                end
            elseif value_upv_4:IsA("SpecialMesh") then
                value_upv_4.TextureId = ""
            end
        end
    end
    local function hold(a16, a17, a18)
        --[[
          name: hold
          line: 684
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
        ]]
        local v43 = ReplicatedStorage_upv_1:FindFirstChild("Assets") and (ReplicatedStorage_upv_1.Assets:FindFirstChild("Animations"))
        local u18 = v43 and (v43:FindFirstChild(a17))
        local v44 = a16:FindFirstChildOfClass("Humanoid")
        if not u18 or not u18:IsA("Animation") then
            return
        end
        if v44 then
            local u19 = v44:FindFirstChildOfClass("Animator") or (Instance.new("Animator"))
            u19.Parent = v44
            pcall(
                function()
                    --[[
                      line: 693
                      upvalues:
                        u19 (copy, index: 1)
                        u18 (copy, index: 2)
                        a18 (copy, index: 3)
                    ]]
                    local v45 = u19:LoadAnimation(u18)
                    v45.Looped = true
                    v45:Play(0)
                    table.insert(a18, v45)
                end
            )
        end
    end
    local tbl_upv_14 = {}
    tbl_upv_14["3v3"] = {
        eye = Vector3.new(0.800000011920929, 3.0999999046325684, -15.5),
        target = Vector3.new(0, 3.75, 1.399999976158142),
        fov = 30,
        fighters = {{at = Vector3.new(3.9000000953674316, 3, 3.4000000953674316), item = "spear", yaw = -24, anim = "Hold_Spear", look = fromRGB_upv_1(38, 86, 160)}, {at = Vector3.new(-3.9000000953674316, 3, 3.200000047683716), item = "battle_axe", yaw = 28, anim = "Hold_Heavy", look = fromRGB_upv_1(38, 86, 160)}, {at = Vector3.new(0, 3, 0), item = "bronze_sword", yaw = 12, look = "you", anim = "Hold_Sword"}}
    }
    tbl_upv_14["1v1"] = {eye = Vector3.new(0, 3.299999952316284, -15.600000381469727), target = Vector3.new(0, 3.799999952316284, 0.5), fov = 30, fighters = {{at = Vector3.new(-2.549999952316284, 3, 1), item = "battle_axe", yaw = -32, anim = "Hold_Heavy", look = fromRGB_upv_1(84, 18, 28)}, {at = Vector3.new(2.700000047683716, 3, 0), item = "bronze_sword", yaw = 40, look = "you", anim = "Hold_Sword"}}}
    local u20 = nil
    local u21 = false
    local function snapshotCharacter()
        --[[
          name: snapshotCharacter
          line: 526
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
        ]]
        local Character_upv_1 = LocalPlayer_upv_1.Character
        if not Character_upv_1 or not Character_upv_1.Parent or not Character_upv_1:FindFirstChildOfClass("Humanoid") or not Character_upv_1:FindFirstChild("HumanoidRootPart") or not Character_upv_1:FindFirstChild("Head") then
            return nil
        end
        local v46 = Character_upv_1.Archivable
        Character_upv_1.Archivable = true
        local v47, v48 = pcall(
            function()
                --[[
                  line: 533
                  upvalues:
                    Character_upv_1 (copy, index: 1)
                ]]
                return Character_upv_1:Clone()
            end
        )
        Character_upv_1.Archivable = v46
        if not v47 or not v48 then
            return nil
        end
        for _, value_5 in v48:GetTags() do
            v48:RemoveTag(value_5)
        end
        for key_2 in v48:GetAttributes() do
            v48:SetAttribute(key_2, nil)
        end
        for _, value_6 in v48:GetDescendants() do
            if value_6:IsA("ParticleEmitter") or value_6:IsA("Trail") or value_6:IsA("Beam") then
                v47 = value_6:FindFirstAncestorOfClass("Accessory") == nil
            else
                v47 = value_6:IsA("Light")
                v47 = v47 and value_6:FindFirstAncestorOfClass("Accessory") == nil
            end
            if value_6:IsA("LuaSourceContainer") or value_6:IsA("Tool") or tbl_upv_13[value_6.ClassName] or v47 then
                value_6:Destroy()
                continue
            end
            for v53, value_7 in value_6:GetTags() do
                value_6:RemoveTag(value_7)
            end
            if value_6:IsA("BasePart") then
                value_6.CanCollide = false
                value_6.CanQuery = false
                value_6.CanTouch = false
                value_6.CastShadow = false
                value_6.LocalTransparencyModifier = 0
                continue
            end
            if value_6:IsA("Decal") then
                value_6.LocalTransparencyModifier = 0
            end
        end
        for _, value_8 in v48:GetDescendants() do
            if value_8:IsA("AnimationConstraint") or value_8:IsA("RigidConstraint") then
                local Attachment0_1 = value_8.Attachment0
                local Attachment1_1 = value_8.Attachment1
                local v49 = Attachment1_1 and (Attachment1_1.Parent)
                if not (Attachment0_1) then
                    value_8:Destroy()
                    continue
                end
                if not (Attachment1_1) then
                    value_8:Destroy()
                    continue
                end
                if not (Attachment0_1) then
                    value_8:Destroy()
                    continue
                end
                if not (v49) then
                    value_8:Destroy()
                    continue
                end
                local v50 = Attachment0_1:IsA("BasePart")
                if not (v50) then
                    value_8:Destroy()
                    continue
                end
                local v51 = v49:IsA("BasePart")
                if not (v51) then
                    value_8:Destroy()
                    continue
                end
                if value_8:IsA("AnimationConstraint") then
                    v46 = Instance.new("Motor6D")
                else
                    v46 = Instance.new("Weld")
                end
                v46.Name = value_8.Name
                v46.Part0 = Attachment0_1
                v46.Part1 = Attachment1_1
                v46.C0 = Attachment0_1.CFrame
                v46.C1 = Attachment1_1.CFrame
                v46.Parent = Attachment1_1
                value_8:Destroy()
            end
            if value_8:IsA("BallSocketConstraint") or value_8:IsA("HingeConstraint") or value_8:IsA("NoCollisionConstraint") then
                value_8:Destroy()
                continue
            end
            if value_8:IsA("Motor6D") then
                value_8.Transform = CFrame.identity
            end
        end
        local u22 = v48:FindFirstChildOfClass("Humanoid")
        pcall(
            function()
                --[[
                  line: 583
                  upvalues:
                    u22 (copy, index: 1)
                ]]
                u22.EvaluateStateMachine = false
            end
        )
        u22.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        u22.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        u22.BreakJointsOnDeath = false
        local v52 = v48:FindFirstChild("HumanoidRootPart")
        v52.Anchored = true
        v52.Transparency = 1
        v52 = v48:FindFirstChild("TribesHull")
        if v52 then
            v52:Destroy()
        end
        v48.Name = "Fighter"
        return v48
    end
    local function clearScene(a19)
        --[[
          name: clearScene
          line: 728
        ]]
        local scene_1 = a19.scene
        if not scene_1 then
            return
        end
        for _, value_upv_9 in scene_1.tracks do
            pcall(
                function()
                    --[[
                      line: 732
                      upvalues:
                        value_upv_9 (copy, index: 1)
                    ]]
                    value_upv_9:Stop(0)
                end
            )
        end
        scene_1.wm:Destroy()
        scene_1.cam:Destroy()
        a19.scene = nil
    end
    local function weapon(a20, a21, a22)
        --[[
          name: weapon
          line: 621
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
        ]]
        local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v53 = Assets_1 and (Assets_1:FindFirstChild("Weapons"))
        local _ = v53 and (v53:FindFirstChild(a21))
        local v54 = a20:FindFirstChild("RightHand") or (a20:FindFirstChild("Right Arm"))
        if not v53 or not v54 or not v54:IsA("BasePart") then
            return
        end
        local v55 = v53:Clone()
        local Handle_1 = v55:FindFirstChild("Handle")
        if Handle_1 and Handle_1:IsA("BasePart") then
            for v60, value_upv_10 in v55:GetDescendants() do
                if value_upv_10:IsA("LuaSourceContainer") or value_upv_10:IsA("Sound") or value_upv_10:IsA("ParticleEmitter") or value_upv_10:IsA("Light") then
                    value_upv_10:Destroy()
                    continue
                end
                if value_upv_10:IsA("BasePart") then
                    value_upv_10.Anchored = false
                    value_upv_10.CanCollide = false
                    value_upv_10.CanQuery = false
                    value_upv_10.CanTouch = false
                    value_upv_10.Massless = true
                    value_upv_10.CastShadow = false
                    if not (a22) then
                        continue
                    end
                    value_upv_10.Color = a22
                    value_upv_10.Material = Enum.Material.SmoothPlastic
                    if value_upv_10:IsA("MeshPart") then
                        pcall(
                            function()
                                --[[
                                  line: 644
                                  upvalues:
                                    value_upv_10 (copy, index: 1)
                                ]]
                                value_upv_10.TextureID = ""
                            end
                        )
                    end
                else
                    if not (a22) or not (value_upv_10:IsA("SpecialMesh")) then
                        if a22 and (value_upv_10:IsA("Decal") or value_upv_10:IsA("Texture") or value_upv_10:IsA("SurfaceAppearance")) then
                            value_upv_10:Destroy()
                        end
                        continue
                    end
                    value_upv_10.TextureId = ""
                    value_upv_10.VertexColor = Vector3.new(a22.R, a22.G, a22.B)
                end
            end
            for v61, value_11 in v55:GetDescendants() do
                if not (value_11:IsA("WeldConstraint")) then
                    continue
                end
                local Part0_1 = value_11.Part0
                local Part1_1 = value_11.Part1
                if not (Part0_1) then
                    value_11:Destroy()
                    continue
                end
                if Part1_1 then
                    local v56 = Instance.new("Weld")
                    v56.Part0 = Part0_1
                    v56.Part1 = Part1_1
                    v56.C0 = Part0_1.CFrame:ToObjectSpace(Part1_1.CFrame)
                    v56.C1 = CFrame.identity
                    v56.Parent = Part1_1
                end
                value_11:Destroy()
            end
            local v57 = Instance.new("Weld")
            v57.Name = "Grip"
            v57.Part0 = v54
            v57.Part1 = Handle_1
            local RightGripAttachment_1 = v54:FindFirstChild("RightGripAttachment")
            local v58 = Handle_1:FindFirstChild("RightGripAttachment")
            local v59
            if (RightGripAttachment_1) and (RightGripAttachment_1:IsA("Attachment")) then
                v59 = RightGripAttachment_1.CFrame
            else
                v59 = CFrame.new(0, -v54.Size.Y / 2, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            end
            v57.C0 = v59
            if (v58) and (v58:IsA("Attachment")) then
                v59 = v58.CFrame
            else
                v59 = CFrame.identity
            end
            v57.C1 = v59
            v57.Parent = Handle_1
            v55.Name = "Weapon"
            v55.Parent = a20
        else
            v55:Destroy()
        end
    end
    local function buildScene(a23)
        --[[
          name: buildScene
          line: 741
          upvalues:
            clearScene (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            snapshotCharacter (copy, index: 3)
            silhouette (copy, index: 4)
            weapon (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            hold (copy, index: 7)
        ]]
        clearScene(a23)
        local v60 = tbl_upv_14[a23.def.id]
        if not v60 then
            return false
        end
        local v61 = Instance.new("WorldModel")
        v61.Parent = a23.vpf
        local tbl_15 = {}
        local v62 = false
        local v63 = nil
        for _, value_12 in v60.fighters do
            local v64 = snapshotCharacter()
            if not (v64) then
                continue
            end
            v62 = true
            if value_12.look ~= "you" then
                silhouette(v64, value_12.look)
            end
            local item_1 = value_12.item
            if value_12.look == "you" then
                v63 = nil
            else
                v63 = Theme_upv_1.Lighten(value_12.look, 0.12)
            end
            weapon(v64, item_1, v63)
            v64:PivotTo(CFrame.new(value_12.at) * CFrame.Angles(0, math.rad(value_12.yaw), 0))
            v64.Parent = v61
            hold(v64, value_12.anim, tbl_15)
        end
        local v65 = Instance.new("Camera")
        v65.FieldOfView = v60.fov
        v65.CFrame = CFrame.lookAt(v60.eye, v60.target)
        v65.Parent = a23.vpf
        a23.vpf.CurrentCamera = v65
        a23.scene = {built = true, vpf = a23.vpf, wm = v61, cam = v65, target = v60.target, eye = v60.eye, phase = a23.index * 1.7, tracks = tbl_15}
        return v62
    end
    local function ensureScenes()
        --[[
          name: ensureScenes
          line: 773
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u20 (ref,  index: 2)
            u21 (ref,  index: 3)
            tbl_upv_3 (copy, index: 4)
            buildScene (copy, index: 5)
        ]]
        local Character_2 = LocalPlayer_upv_1.Character
        local v66 = LocalPlayer_upv_1:HasAppearanceLoaded()
        if Character_2 ~= u20 or not u21 and v66 then
            if not Character_2 then
                return
            end
            u20 = Character_2
            u21 = v66
            for _, value_13 in tbl_upv_3 do
                buildScene(value_13)
            end
        elseif tbl_upv_3[1] then
            if tbl_upv_3[1].scene then
                for _, value_14 in tbl_upv_3 do
                    if not (value_14.scene) then
                        continue
                    end
                    for v67, value_15 in value_14.scene.tracks do
                        if not (value_15.IsPlaying) then
                            value_15:Play(0)
                        end
                    end
                end
            elseif Character_2 then
                u20 = Character_2
                u21 = v66
                for _, value_13 in tbl_upv_3 do
                    buildScene(value_13)
                end
            end
        elseif Character_2 then
            u20 = Character_2
            u21 = v66
            for _, value_13 in tbl_upv_3 do
                buildScene(value_13)
            end
        end
    end
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function()
            --[[
              line: 797
              upvalues:
                u20 (ref, index: 1)
            ]]
            u20 = nil
        end
    )
    local function paintCta(a24, a25, a26)
        --[[
          name: paintCta
          line: 802
          upvalues:
            ButtonStyles_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v67
        if a26 then
            v67 = ButtonStyles_upv_1.Disabled
        elseif a25 then
            v67 = ButtonStyles_upv_1.Primary
        else
            v67 = ButtonStyles_upv_1.Dark
        end
        a24.ctaGrad.Color = ColorSequence.new(v67.top, v67.bottom)
        a24.ctaLip.BackgroundColor3 = v67.lip
        a24.ctaStroke.Color = v67.stroke
        a24.ctaLabel.TextColor3 = v67.text
        a24.ctaLabel.Visible = not a26
        a24.ctaKey.Visible = not a26 and (not UI_upv_1.Touch and (not UI_upv_1.Gamepad))
        a24.ctaPad.Visible = a25 and (not a26)
        a24.lockRow.Visible = a26
    end
    local function paint()
        --[[
          name: paint
          line: 814
          upvalues:
            u1 (ref,  index: 1)
            SettingsStore_upv_1 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
            State_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            u13 (ref,  index: 6)
            Config_upv_1 (ref,  index: 7)
            paintCta (copy, index: 8)
            fromRGB_upv_1 (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            u8 (ref,  index: 11)
            u9 (ref,  index: 12)
            u10 (ref,  index: 13)
            u11 (ref,  index: 14)
        ]]
        if not u1 then
            return
        end
        local v68 = ((bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1)) and "1v1") or "3v3"
        local v69 = bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 4)
        local v70, _, v71, v72 = nil, nil, nil, nil
        local v73 = nil
        local v74 = nil
        local v75 = nil
        local v76 = nil
        local v84 = nil
        local v85 = nil
        for v86, value_16 in tbl_upv_3 do
            local id_1 = value_16.def.id
            if id_1 == "1v1" then
                if State_upv_1.Get("Duel") == true then
                    if (a1.Party) and (a1.Party.Size) then
                        v73 = a1.Party.Size()
                    else
                        v73 = 1
                    end
                    if v73 >= 2 then
                        v70 = "LEAVE YOUR PARTY TO PLAY 1V1"
                    else
                        v70 = nil
                    end
                else
                    v70 = "PLAY 3 MATCHES FIRST"
                end
            else
                v70 = nil
            end
            if v70 ~= nil then
                v74 = true
            else
                v74 = false
            end
            local v77 = value_16.index == u13
            local roundsText_1 = value_16.roundsText
            if type(Config_upv_1) ~= "table" then
                v76 = nil
            else
                v76 = Config_upv_1.MODES
            end
            if type(v76) ~= "table" then
                v71 = nil
            else
                v71 = v76[id_1]
            end
            if type(v71) ~= "table" then
                v72 = nil
            else
                v72 = v71
            end
            local v78 = tonumber(v72 and (v72.roundsToWin)) or (State_upv_1.DEFAULT_ROUNDS_TO_WIN)
            roundsText_1.Text = string.format("FIRST TO %d", math.clamp(math.floor(v78), 1, 9))
            value_16.lockText.Text = v70 or ""
            paintCta(value_16, v77, v74)
            local vpf_1 = value_16.vpf
            if v74 then
                v75 = fromRGB_upv_1(150, 154, 164)
            else
                v75 = Color3.new(1, 1, 1)
            end
            vpf_1.ImageColor3 = v75
            value_16.veil.Visible = v74
            for v87, value_17 in value_16.deco do
                if not (value_17:IsA("ImageLabel")) then
                    continue
                end
                if v74 then
                    v76 = fromRGB_upv_1(120, 124, 136)
                else
                    v76 = value_17:GetAttribute("Tint") or (value_17.ImageColor3)
                end
                v72.ImageColor3 = v76
            end
            local name_1 = value_16.name
            if v74 then
                v75 = Colors_upv_1.TextDim
            else
                v75 = Colors_upv_1.Text
            end
            name_1.TextColor3 = v75
            value_16.topPill.Visible = (id_1 == v68) and (not v74)
            value_16.newPill.Visible = (id_1 == "1v1") and (not v69 and (not v74))
            local ring_1 = value_16.ring
            if v74 then
                v75 = Colors_upv_1.TextMuted
            else
                v75 = Colors_upv_1.Accent
            end
            ring_1.Color = v75
        end
        if not u8 then
            return
        end
        if u9 and u10 then
            v69 = SettingsStore_upv_1.Get("mmRanked") > 0.5
            local v79
            if v69 then
                v79 = "RANKED"
            else
                v79 = "UNRANKED"
            end
            u9.Text = v79
            local v80 = u9
            local v81
            if v69 then
                v81 = Colors_upv_1.Text
            else
                v81 = Colors_upv_1.TextDim
            end
            v80.TextColor3 = v81
            u10:Set(v69)
            if u11 and u11:IsA("ImageLabel") then
                u11.ImageTransparency = (v69 and 0) or 0.6
            end
            local v82 = u8:FindFirstChildOfClass("UIStroke")
            if v82 then
                local v83
                if v69 then
                    v83 = Colors_upv_1.Accent
                else
                    v83 = Colors_upv_1.Stroke
                end
                v82.Color = v83
                v82.Transparency = (v69 and 0.55) or 0.86
            end
        end
    end
    local function setFocus(a27, a28)
        --[[
          name: setFocus
          line: 857
          upvalues:
            tbl_upv_3 (copy, index: 1)
            u13 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            paint (copy, index: 5)
            u15 (ref,  index: 6)
            GuiService_upv_1 (copy, index: 7)
        ]]
        local v84 = math.clamp(a27, 1, #tbl_upv_3)
        if v84 == u13 then
            return
        end
        u13 = v84
        if not (UI_upv_1.Touch) then
            a1.Sounds.Play("Hover")
        end
        paint()
        if UI_upv_1.Gamepad and not (a28) and u15 and tbl_upv_3[v84] and GuiService_upv_1.SelectedObject ~= tbl_upv_3[v84].btn then
            GuiService_upv_1.SelectedObject = tbl_upv_3[v84].btn
        end
    end
    local function layout()
        --[[
          name: layout
          line: 874
          upvalues:
            u1 (ref,  index: 1)
            u3 (ref,  index: 2)
            u5 (ref,  index: 3)
            u4 (ref,  index: 4)
            geo (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u6 (ref,  index: 8)
            tbl_upv_3 (copy, index: 9)
        ]]
        if not u1 or not u3 or not u5 or not u4 then
            return
        end
        local v85 = geo()
        local v86 = v85.W * 2 + v85.gap
        local v87 = v85.headH + v85.headGap + v85.H
        u3.Size = fromOffset_upv_1(v86, v87)
        local v88 = UI_upv_1.CanvasSize()
        local v89 = UI_upv_1.TopInset()
        local v90 = math.min(1, (v88.X - 32) / v86, ((v88.Y - v89) - 16) / (v87 + 14))
        u4.Scale = v90
        local v91 = math.max(v88.Y / 2, (v89 + 8) + ((v87 * v90) / 2))
        u3.Position = UDim2.new(0.5, 0, 0, math.floor(v91))
        u5.Size = UDim2.new(1, 0, 0, v85.headH)
        if u6 then
            u6.TextSize = v85.titleSize
        end
        for key_3, value_18 in tbl_upv_3 do
            value_18.btn.Size = fromOffset_upv_1(v85.W, v85.H)
            value_18.btn.Position = fromOffset_upv_1((key_3 - 1) * (v85.W + v85.gap), v85.headH + v85.headGap)
        end
    end
    local function pick(a29)
        --[[
          name: pick
          line: 903
          upvalues:
            tbl_upv_3 (copy, index: 1)
            u17 (ref,  index: 2)
            u15 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            setFocus (copy, index: 7)
            SettingsStore_upv_1 (copy, index: 8)
            fromOffset_upv_1 (copy, index: 9)
            MenuManager_upv_1 (copy, index: 10)
        ]]
        local v92 = tbl_upv_3[a29]
        if not v92 or (u17) then
            return
        end
        if u15 then
            local id_upv_2 = v92.def.id
            local v93
            if id_upv_2 == "1v1" then
                if State_upv_1.Get("Duel") == true then
                    local v94
                    if (a1.Party) and (a1.Party.Size) then
                        v94 = a1.Party.Size()
                    else
                        v94 = 1
                    end
                    if v94 >= 2 then
                        v93 = "LEAVE YOUR PARTY TO PLAY 1V1"
                    else
                        v93 = nil
                    end
                else
                    v93 = "PLAY 3 MATCHES FIRST"
                end
            else
                v93 = nil
            end
            if v93 then
                a1.Sounds.Play("Error")
                UI_upv_1.Shake(v92.lift, 7)
                UI_upv_1.Bump(v92.lockRow, 0.08)
            elseif a1.LobbyHud and a1.LobbyHud.Queue then
                u17 = true
                setFocus(a29)
                v93 = math.floor(SettingsStore_upv_1.Get("modeSel"))
                if id_upv_2 ~= "1v1" then
                    v93 = bit32.band(v93, 4294967294)
                else
                    v93 = bit32.bor(v93, 1, 4)
                end
                if v93 ~= math.floor(SettingsStore_upv_1.Get("modeSel")) then
                    SettingsStore_upv_1.Set("modeSel", v93, true)
                end
                v93 = UDim2.new()
                UI_upv_1.Tween(v92.lift, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = v93 + fromOffset_upv_1(0, 5)})
                v92.ctaGlow.BackgroundTransparency = 0.55
                local tbl_16 = {BackgroundTransparency = 1}
                UI_upv_1.Tween(v92.ctaGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), tbl_16)
                task.delay(
                    0.11,
                    function()
                        --[[
                          line: 929
                          upvalues:
                            u17 (ref,  index: 1)
                            u15 (ref,  index: 2)
                            MenuManager_upv_1 (copy, index: 3)
                            a1 (copy, index: 4)
                            id_upv_2 (copy, index: 5)
                        ]]
                        u17 = false
                        if u15 then
                            MenuManager_upv_1.Close("Mode")
                        end
                        if a1.LobbyHud.CanPlay ~= nil and not a1.LobbyHud.CanPlay() then
                            return
                        end
                        a1.LobbyHud.Queue(id_upv_2)
                    end
                )
                return
            end
        end
    end
    local function close()
        --[[
          name: close
          line: 899
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("Mode")
    end
    local function build()
        --[[
          name: build
          line: 941
          upvalues:
            geo (copy, index: 1)
            u1 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            u2 (ref,  index: 5)
            Colors_upv_1 (copy, index: 6)
            u12 (ref,  index: 7)
            u3 (ref,  index: 8)
            fromOffset_upv_1 (copy, index: 9)
            u4 (ref,  index: 10)
            u5 (ref,  index: 11)
            u6 (ref,  index: 12)
            Fonts_upv_1 (copy, index: 13)
            close (copy, index: 14)
            u7 (ref,  index: 15)
            u8 (ref,  index: 16)
            Theme_upv_1 (copy, index: 17)
            u11 (ref,  index: 18)
            RankArt_upv_1 (copy, index: 19)
            u9 (ref,  index: 20)
            u10 (ref,  index: 21)
            SettingsStore_upv_1 (copy, index: 22)
            paint (copy, index: 23)
            tbl_upv_2 (copy, index: 24)
            makeCard (copy, index: 25)
            tbl_upv_3 (copy, index: 26)
            setFocus (copy, index: 27)
            u17 (ref,  index: 28)
            State_upv_1 (copy, index: 29)
            pick (copy, index: 30)
            u16 (ref,  index: 31)
            MenuManager_upv_1 (copy, index: 32)
            GuiService_upv_1 (copy, index: 33)
            u14 (ref,  index: 34)
            layout (copy, index: 35)
        ]]
        local v95 = geo()
        local v96 = UI_upv_1.new("Frame", {Visible = false, Name = "ModeSelect", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Menus})
        u1 = v96
        local v97 = u1
        local v98 = UI_upv_1.new("TextButton", {Visible = false, Name = "ModeSelectBackdrop", Modal = true, Selectable = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = UI_upv_1.BackdropCanvas or v97})
        u2 = v98
        local v99 = UI_upv_1.new("Frame", {BackgroundTransparency = 1, Name = "NoRing", Size = UDim2.fromScale(1, 1)})
        u12 = v99
        local v100 = UI_upv_1.new("Frame", {Name = "Holder", Active = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1((v95.W * 2) + v95.gap, (v95.headH + v95.headGap) + v95.H), Parent = v97})
        u3 = v100
        local u23 = u3
        u4 = UI_upv_1.GetScaleObj(u23, "FitScale")
        pcall(
            function()
                --[[
                  line: 966
                  upvalues:
                    u23 (copy, index: 1)
                ]]
                u23.SelectionGroup = true
                u23.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
                u23.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                u23.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                u23.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
            end
        )
        local v101 = UI_upv_1.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, v95.headH), Parent = u23})
        u5 = v101
        local u24 = u5
        local v102 = UI_upv_1.new("TextLabel", {Text = "SELECT MODE", Name = "Title", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(0.5, 0, 1, 0), FontFace = Fonts_upv_1.Display, TextSize = v95.titleSize, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u24})
        u6 = v102
        local v103 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.5)
        v103.Parent = u6
        local u25 = UI_upv_1.WindowCloseSize()
        local function makeClose_upv_1()
            --[[
              name: makeClose
              line: 989
              upvalues:
                UI_upv_1 (copy, index: 1)
                fromOffset_upv_1 (copy, index: 2)
                u25 (ref,  index: 3)
                Colors_upv_1 (copy, index: 4)
                u24 (copy, index: 5)
                close (copy, index: 6)
            ]]
            return UI_upv_1.IconButton({IconName = "cross", Name = "Close", Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = fromOffset_upv_1(u25, u25), Color = Colors_upv_1.Raised, HoverColor = Colors_upv_1.Danger, Parent = u24, OnClick = close})
        end
        u7 = makeClose_upv_1()
        UI_upv_1.TouchChanged:Connect(
            function()
                --[[
                  line: 1004
                  upvalues:
                    u7 (ref,  index: 1)
                    u25 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    makeClose_upv_1 (copy, index: 4)
                ]]
                if u7 then
                    u7:Destroy()
                end
                u25 = UI_upv_1.WindowCloseSize()
                u7 = makeClose_upv_1()
            end
        )
        local tbl_17 = {}
        tbl_17.Name = "Ranked"
        tbl_17.AnchorPoint = Vector2.new(1, 0.5)
        tbl_17.Position = UDim2.new(1, -(u25 + 14), 0.5, 0)
        tbl_17.Size = fromOffset_upv_1(0, math.min(u25, 52))
        tbl_17.AutomaticSize = Enum.AutomaticSize.X
        tbl_17.BackgroundColor3 = Colors_upv_1.Panel
        tbl_17.BackgroundTransparency = 0.15
        tbl_17.Selectable = true
        tbl_17[1], tbl_17[2], tbl_17[3], tbl_17[4] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.86), UI_upv_1.Padding(0, 10, 0, 14), UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_17.Parent = u24
        u8 = UI_upv_1.new("TextButton", tbl_17)
        local v104 = RankArt_upv_1.Trophy(24, {LayoutOrder = 1, Parent = u8})
        u11 = v104
        local v105 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "RANKED", Name = "Title", TextSize = 18, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = u8})
        u9 = v105
        local v106 = UI_upv_1.Switch({LayoutOrder = 3, Width = 50, Parent = u8})
        u10 = v106
        u8.Activated:Connect(
            function()
                --[[
                  line: 1041
                  upvalues:
                    a1 (copy, index: 1)
                    SettingsStore_upv_1 (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                a1.Sounds.Play("Click")
                local Set_1 = SettingsStore_upv_1.Set
                local v107 = "mmRanked"
                local v108 = SettingsStore_upv_1.Get("mmRanked") > 0.5
                local v109
                if v108 then
                    v109 = 0
                else
                    v109 = 1
                end
                Set_1(v107, v109, "now")
                paint()
            end
        )
        for key_upv_4, value_upv_19 in tbl_upv_2 do
            local u26 = makeCard(value_upv_19, key_upv_4, u23)
            tbl_upv_3[key_upv_4] = u26
            u26.btn.MouseEnter:Connect(
                function()
                    --[[
                      line: 1050
                      upvalues:
                        u26 (copy, index: 1)
                        UI_upv_1 (copy, index: 2)
                        setFocus (copy, index: 3)
                        key_upv_4 (copy, index: 4)
                    ]]
                    u26.hover = true
                    if (UI_upv_1.Touch) then
                        return
                    end
                    setFocus(key_upv_4)
                end
            )
            u26.btn.MouseLeave:Connect(
                function()
                    --[[
                      line: 1056
                      upvalues:
                        u26 (copy, index: 1)
                    ]]
                    u26.hover = false
                end
            )
            u26.btn.MouseButton1Down:Connect(
                function()
                    --[[
                      line: 1059
                      upvalues:
                        u17 (ref,  index: 1)
                        value_upv_19 (copy, index: 2)
                        State_upv_1 (copy, index: 3)
                        a1 (copy, index: 4)
                        UI_upv_1 (copy, index: 5)
                        u26 (copy, index: 6)
                        fromOffset_upv_1 (copy, index: 7)
                    ]]
                    if not (u17) then
                        local v110
                        if value_upv_19.id == "1v1" then
                            if State_upv_1.Get("Duel") == true then
                                local v111
                                if (a1.Party) and (a1.Party.Size) then
                                    v111 = a1.Party.Size()
                                else
                                    v111 = 1
                                end
                                if v111 >= 2 then
                                    v110 = "LEAVE YOUR PARTY TO PLAY 1V1"
                                else
                                    v110 = nil
                                end
                            else
                                v110 = "PLAY 3 MATCHES FIRST"
                            end
                        else
                            v110 = nil
                        end
                        if (v110) then
                            return
                        end
                        UI_upv_1.Tween(u26.lift, TweenInfo.new(0.06, Enum.EasingStyle.Quad), {Position = fromOffset_upv_1(0, 3)})
                    end
                end
            )
            u26.btn.MouseButton1Up:Connect(
                function()
                    --[[
                      line: 1064
                      upvalues:
                        u17 (ref,  index: 1)
                        UI_upv_1 (copy, index: 2)
                        u26 (copy, index: 3)
                        Theme_upv_1 (copy, index: 4)
                    ]]
                    if (u17) then
                        return
                    end
                    UI_upv_1.Tween(u26.lift, Theme_upv_1.Tween.PopSmall, {Position = UDim2.new()})
                end
            )
            u26.btn.Activated:Connect(
                function()
                    --[[
                      line: 1069
                      upvalues:
                        pick (copy, index: 1)
                        key_upv_4 (copy, index: 2)
                    ]]
                    pick(key_upv_4)
                end
            )
        end
        local u27 = false
        u2.InputBegan:Connect(
            function(a30)
                --[[
                  line: 1076
                  upvalues:
                    u27 (ref, index: 1)
                ]]
                local UserInputType_1 = a30.UserInputType
                if UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.Touch then
                    return
                end
                u27 = true
            end
        )
        u2.Activated:Connect(
            function()
                --[[
                  line: 1082
                  upvalues:
                    u16 (ref,  index: 1)
                    u27 (ref,  index: 2)
                    a1 (copy, index: 3)
                    MenuManager_upv_1 (copy, index: 4)
                ]]
                if (os.clock() - u16 < 0.4) or not u27 then
                    return
                end
                a1.Sounds.Play("Close")
                MenuManager_upv_1.Close("Mode")
            end
        )
        GuiService_upv_1:GetPropertyChangedSignal("SelectedObject"):Connect(
            function()
                --[[
                  line: 1090
                  upvalues:
                    GuiService_upv_1 (copy, index: 1)
                    tbl_upv_3 (copy, index: 2)
                    u14 (ref,  index: 3)
                    setFocus (copy, index: 4)
                ]]
                local SelectedObject_1 = GuiService_upv_1.SelectedObject
                for key_5, value_20 in tbl_upv_3 do
                    if SelectedObject_1 == value_20.btn then
                        u14 = true
                        setFocus(key_5, true)
                    end
                end
            end
        )
        layout()
    end
    local tbl_upv_18 = {TR_Backdrop = true, TR_TopbarSettings = true, TR_ReplayHud = true, TR_Teleport = true, CombatTouch = true, TR_RevealSafe = true, TouchGui = true, TR_Reveal = true, TR_Menus = true, TR_Loading = true, TR_RankUp = true, CharacterTouch = true, BubbleChat = true, Chat = true, CombatHUD = true, TR_ReplayFrame = true, TR_Replay = true}
    local tbl_upv_19 = {}
    local tbl_upv_20 = {}
    local u28 = false
    local function hideOne(a31)
        --[[
          name: hideOne
          line: 1119
          upvalues:
            tbl_upv_18 (copy, index: 1)
            a1 (copy, index: 2)
            tbl_upv_19 (copy, index: 3)
            tbl_upv_20 (copy, index: 4)
        ]]
        if tbl_upv_18[a31.Name] then
            return
        end
        local v112 = a31:FindFirstAncestorWhichIsA("ScreenGui")
        if not v112 or not tbl_upv_18[v112.Name] then
            if a31:IsA("ScreenGui") then
                if a31.Parent == a1.PlayerGui and a31.Enabled then
                    a31.Enabled = false
                    tbl_upv_19[a31] = true
                end
            elseif (a31:IsA("BillboardGui") or a31:IsA("SurfaceGui")) and tbl_upv_20[a31] == nil then
                pcall(
                    function()
                        --[[
                          line: 1133
                          upvalues:
                            a31 (copy, index: 1)
                            tbl_upv_20 (copy, index: 2)
                        ]]
                        local MaxDistance_1 = a31.MaxDistance
                        a31.MaxDistance = 0.001
                        tbl_upv_20[a31] = MaxDistance_1
                    end
                )
            end
        end
    end
    local function sweepOthers()
        --[[
          name: sweepOthers
          line: 1140
          upvalues:
            a1 (copy, index: 1)
            hideOne (copy, index: 2)
        ]]
        for _, value_21 in a1.PlayerGui:GetDescendants() do
            if value_21:IsA("LayerCollector") then
                hideOne(value_21)
            end
        end
        local TR_ContractDisplay_1 = workspace:FindFirstChild("TR_ContractDisplay")
        if not TR_ContractDisplay_1 then
            return
        end
        for _, value_22 in TR_ContractDisplay_1:GetDescendants() do
            if value_22:IsA("LayerCollector") then
                hideOne(value_22)
            end
        end
    end
    local function hideOthers(a32)
        --[[
          name: hideOthers
          line: 1155
          upvalues:
            u28 (ref,  index: 1)
            a1 (copy, index: 2)
            sweepOthers (copy, index: 3)
            tbl_upv_19 (copy, index: 4)
            tbl_upv_20 (copy, index: 5)
        ]]
        if u28 == a32 then
            return
        end
        u28 = a32
        a1.SetHudHidden("ModeSelect", a32)
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "ModeSelect", a32)
        end
        if a32 then
            sweepOthers()
        else
            for key_6 in tbl_upv_19 do
                if key_6.Parent then
                    key_6.Enabled = true
                end
            end
            table.clear(tbl_upv_19)
            for key_upv_7, value_upv_23 in tbl_upv_20 do
                if key_upv_7.Parent then
                    pcall(
                        function()
                            --[[
                              line: 1176
                              upvalues:
                                key_upv_7 (copy, index: 1)
                                value_upv_23 (copy, index: 2)
                            ]]
                            key_upv_7.MaxDistance = value_upv_23
                        end
                    )
                end
            end
            table.clear(tbl_upv_20)
        end
    end
    local u29 = 0
    local u30 = nil
    local u31 = false
    local u32 = 0
    local function quintOut(a33)
        --[[
          name: quintOut
          line: 1192
        ]]
        return 1 - ((1 - a33) ^ 5)
    end
    local function cardDelay(a34)
        --[[
          name: cardDelay
          line: 1195
        ]]
        return ((a34 - 1) * 0.07) + 0.05
    end
    local function step(a35)
        --[[
          name: step
          line: 1198
          upvalues:
            u28 (ref,  index: 1)
            u29 (ref,  index: 2)
            sweepOthers (copy, index: 3)
            u16 (ref,  index: 4)
            u31 (ref,  index: 5)
            u32 (ref,  index: 6)
            tbl_upv_3 (copy, index: 7)
            u13 (ref,  index: 8)
            u14 (ref,  index: 9)
            UI_upv_1 (copy, index: 10)
            u17 (ref,  index: 11)
        ]]
        local v113 = os.clock()
        if u28 and v113 - u29 > 0.5 then
            u29 = v113
            sweepOthers()
        end
        local v114 = v113 - u16
        local v115 = 1 - (1 - ((1 - math.clamp(v114 / 0.9, 0, 1)) ^ 5))
        local v116 = ((not u31) and 0) or (math.clamp((v113 - u32) / 0.12, 0, 1))
        local _, _
        local v117 = nil
        local v118 = nil
        for v123, value_24 in tbl_upv_3 do
            local v119 = math.clamp((v114 - (((value_24.index - 1) * 0.07) + 0.05)) / 0.24, 0, 1) * (1 - v116)
            if value_24.index ~= u13 or u31 then
                v117 = 0
            else
                v117 = 1
            end
            value_24.foc = value_24.foc + ((v117 - value_24.foc) * math.min(1, a35 * 14))
            v117 = value_24.foc
            if value_24.index == u13 and not u31 and (value_24.hover or u14 or UI_upv_1.Gamepad) then
                v118 = 1
            else
                v118 = 0
            end
            value_24.up = value_24.up + ((v118 - value_24.up) * math.min(1, a35 * 16))
            if not (u17) and not (u31) then
                value_24.lift.Position = UDim2.fromOffset(0, value_24.up * -7)
            end
            value_24.glow.ImageTransparency = 1 - ((v117 * 0.42) * v119)
            value_24.ring.Transparency = 1 - (v117 * v119)
            v118 = value_24.scene
            if v118 then
                local v120 = math.sin((v113 * 0.45) + v118.phase) * 0.045
                local v121 = math.sin((v113 * 0.7) + v118.phase) * 0.06
                v118.cam.CFrame = CFrame.lookAt((v118.target + CFrame.Angles(0, v120, 0):VectorToWorldSpace((v118.eye - v118.target) * (((v115 * 0.16) + 1) - (v117 * 0.045)))) + Vector3.new(0, v121, 0), v118.target)
            end
            for key_8, value_25 in value_24.deco do
                local v122 = value_25:IsA("ImageLabel")
                if not (v122) then
                    continue
                end
                v118 = value_25:GetAttribute("BaseT")
                if type(v118) ~= "number" then
                    v117 = 0.5
                else
                    v117 = v118
                end
                if string.sub(value_25.Name, 1, 4) == "Beam" then
                    value_25.Rotation = (math.sin((v113 * 0.55) + (key_8 * 1.9)) * 5) + 180
                    v117 = v117 + math.sin((v113 * 0.9) + key_8) * 0.05
                    value_25.ImageTransparency = 1 - ((1 - v117) * v119)
                    continue
                end
                if value_25.Name == "Streak" then
                    v117 = v117 + math.sin(v113 * 1.6) * 0.08
                end
                value_25.ImageTransparency = 1 - ((1 - v117) * v119)
            end
        end
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a36, a37)
            --[[
              line: 1248
              upvalues:
                u15 (ref,  index: 1)
                UserInputService_upv_1 (copy, index: 2)
                tbl_upv_2 (copy, index: 3)
                pick (copy, index: 4)
                u14 (ref,  index: 5)
                setFocus (copy, index: 6)
                u13 (ref,  index: 7)
            ]]
            if not u15 or a37 or UserInputService_upv_1:GetFocusedTextBox() then
                return
            end
            local KeyCode_1 = a36.KeyCode
            for key_9, value_26 in tbl_upv_2 do
                if KeyCode_1 ~= value_26.keyCode and (key_9 ~= 1 or KeyCode_1 ~= Enum.KeyCode.KeypadOne) and (key_9 ~= 2 or KeyCode_1 ~= Enum.KeyCode.KeypadTwo) then
                    continue
                end
                pick(key_9)
                return
            end
            if KeyCode_1 == Enum.KeyCode.Left then
                u14 = true
                setFocus(u13 - 1)
            elseif KeyCode_1 == Enum.KeyCode.Right then
                u14 = true
                setFocus(u13 + 1)
            elseif KeyCode_1 == Enum.KeyCode.Return or KeyCode_1 == Enum.KeyCode.KeypadEnter then
                pick(u13)
            end
        end
    )
    local u33 = 0
    local function open()
        --[[
          name: open
          line: 1272
          upvalues:
            u1 (ref,  index: 1)
            build (copy, index: 2)
            u33 (ref,  index: 3)
            u15 (ref,  index: 4)
            u31 (ref,  index: 5)
            u17 (ref,  index: 6)
            u16 (ref,  index: 7)
            SettingsStore_upv_1 (copy, index: 8)
            u13 (ref,  index: 9)
            State_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u14 (ref,  index: 12)
            tbl_upv_3 (copy, index: 13)
            UI_upv_1 (copy, index: 14)
            u5 (ref,  index: 15)
            u28 (ref,  index: 16)
            sweepOthers (copy, index: 17)
            layout (copy, index: 18)
            paint (copy, index: 19)
            ensureScenes (copy, index: 20)
            u2 (ref,  index: 21)
            Theme_upv_1 (copy, index: 22)
            fromOffset_upv_1 (copy, index: 23)
            u30 (ref,  index: 24)
            RunService_upv_1 (copy, index: 25)
            step (copy, index: 26)
        ]]
        if not (u1) then
            build()
        end
        u33 = u33 + 1
        u15 = true
        u31 = false
        u17 = false
        local v123 = os.clock()
        u16 = v123
        local v124 = ((bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1)) and "1v1") or "3v3"
        local v125
        if v124 ~= "1v1" then
            v125 = 1
        else
            local v126
            if State_upv_1.Get("Duel") == true then
                local v127
                if (a1.Party) and (a1.Party.Size) then
                    v127 = a1.Party.Size()
                else
                    v127 = 1
                end
                if v127 >= 2 then
                    v126 = "LEAVE YOUR PARTY TO PLAY 1V1"
                else
                    v126 = nil
                end
            else
                v126 = "PLAY 3 MATCHES FIRST"
            end
            if v126 then
                v125 = 1
            else
                v125 = 2
            end
        end
        u13 = v125
        u14 = false
        for _, value_27 in tbl_upv_3 do
            UI_upv_1.Unfade(value_27.body)
            value_27.foc = value_27.index ~= u13 and 0 or 1
            value_27.up = 0
            value_27.hover = false
        end
        UI_upv_1.Unfade(u5)
        if u28 ~= true then
            u28 = true
            a1.SetHudHidden("ModeSelect", true)
            if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
                pcall(a1.TopbarSettings.SetHidden, "ModeSelect", true)
            end
            sweepOthers()
        end
        layout()
        paint()
        ensureScenes()
        u1.Visible = true
        u2.Visible = true
        u2.BackgroundTransparency = 1
        UI_upv_1.Tween(u2, Theme_upv_1.Tween.Smooth, {BackgroundTransparency = 0.42})
        UI_upv_1.ResetFade(u5)
        UI_upv_1.Enter(u5, Vector2.new(0, -18), 0, UDim2.new())
        local v129, v130 = nil, nil
        local v131 = nil
        for key_10, value_upv_28 in tbl_upv_3 do
            local v132 = (key_10 - 1) * 0.07 + 0.05
            value_upv_28.glow.ImageTransparency = 1
            value_upv_28.ring.Transparency = 1
            for _, value_29 in value_upv_28.deco do
                if value_29:IsA("ImageLabel") then
                    value_29.ImageTransparency = 1
                end
            end
            value_upv_28.lift.Position = UDim2.new()
            UI_upv_1.ResetFade(value_upv_28.body)
            UI_upv_1.FadeIn(value_upv_28.body, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v132))
            local Position_1 = value_upv_28.btn.Position
            value_upv_28.btn.Position = Position_1 + fromOffset_upv_1(0, 56)
            UI_upv_1.Tween(value_upv_28.btn, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v132), {Position = Position_1})
            for _, value_30 in value_upv_28.lift:GetChildren() do
                if not (value_30:IsA("Frame")) or string.sub(value_30.Name, 1, 6) ~= "Shadow" then
                    continue
                end
                v129 = value_30:GetAttribute("BaseT")
                if v129 == nil then
                    value_30:SetAttribute("BaseT", value_30.BackgroundTransparency)
                    v129 = value_30.BackgroundTransparency
                end
                value_30.BackgroundTransparency = 1
                UI_upv_1.Tween(value_30, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v132), {BackgroundTransparency = v129})
            end
            value_upv_28.topPill.Visible = false
            v130 = value_upv_28.def.id
            local v133 = ((bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1)) and "1v1") or "3v3"
            if v130 ~= v133 then
                continue
            end
            if value_upv_28.def.id == "1v1" then
                if State_upv_1.Get("Duel") == true then
                    if not (a1.Party) or not (a1.Party.Size) then
                        v131 = 1
                        if v131 >= 2 then
                            v130 = "LEAVE YOUR PARTY TO PLAY 1V1"
                        else
                            v130 = nil
                        end
                        if not (v130) then
                            local u34 = u33
                            task.delay(
                                v132 + 0.32,
                                function()
                                    --[[
                                      line: 1335
                                      upvalues:
                                        u15 (ref,  index: 1)
                                        u34 (copy, index: 2)
                                        u33 (ref,  index: 3)
                                        SettingsStore_upv_1 (copy, index: 4)
                                        value_upv_28 (copy, index: 5)
                                        State_upv_1 (copy, index: 6)
                                        a1 (copy, index: 7)
                                        UI_upv_1 (copy, index: 8)
                                    ]]
                                    if not u15 then
                                        return
                                    end
                                    if u34 == u33 then
                                        local v134 = ((bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1)) and "1v1") or "3v3"
                                        if v134 ~= value_upv_28.def.id then
                                            return
                                        end
                                        if value_upv_28.def.id == "1v1" then
                                            if State_upv_1.Get("Duel") == true then
                                                local v135
                                                if (a1.Party) and (a1.Party.Size) then
                                                    v135 = a1.Party.Size()
                                                else
                                                    v135 = 1
                                                end
                                                if v135 >= 2 then
                                                    v134 = "LEAVE YOUR PARTY TO PLAY 1V1"
                                                else
                                                    v134 = nil
                                                end
                                            else
                                                v134 = "PLAY 3 MATCHES FIRST"
                                            end
                                        else
                                            v134 = nil
                                        end
                                        if (v134) then
                                            return
                                        end
                                        value_upv_28.topPill.Visible = true
                                        UI_upv_1.Pop(value_upv_28.topPill, 0.6)
                                    end
                                end
                            )
                            continue
                        end
                    end
                    v131 = a1.Party.Size()
                    if v131 >= 2 then
                        v130 = "LEAVE YOUR PARTY TO PLAY 1V1"
                    else
                        v130 = nil
                    end
                else
                    v130 = "PLAY 3 MATCHES FIRST"
                end
            else
                v130 = nil
            end
            if not (v130) then
                local u34 = u33
                task.delay(
                    v132 + 0.32,
                    function()
                        --[[
                          line: 1335
                          upvalues:
                            u15 (ref,  index: 1)
                            u34 (copy, index: 2)
                            u33 (ref,  index: 3)
                            SettingsStore_upv_1 (copy, index: 4)
                            value_upv_28 (copy, index: 5)
                            State_upv_1 (copy, index: 6)
                            a1 (copy, index: 7)
                            UI_upv_1 (copy, index: 8)
                        ]]
                        if not u15 then
                            return
                        end
                        if u34 == u33 then
                            local v134 = ((bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1)) and "1v1") or "3v3"
                            if v134 ~= value_upv_28.def.id then
                                return
                            end
                            if value_upv_28.def.id == "1v1" then
                                if State_upv_1.Get("Duel") == true then
                                    local v135
                                    if (a1.Party) and (a1.Party.Size) then
                                        v135 = a1.Party.Size()
                                    else
                                        v135 = 1
                                    end
                                    if v135 >= 2 then
                                        v134 = "LEAVE YOUR PARTY TO PLAY 1V1"
                                    else
                                        v134 = nil
                                    end
                                else
                                    v134 = "PLAY 3 MATCHES FIRST"
                                end
                            else
                                v134 = nil
                            end
                            if (v134) then
                                return
                            end
                            value_upv_28.topPill.Visible = true
                            UI_upv_1.Pop(value_upv_28.topPill, 0.6)
                        end
                    end
                )
            end
        end
        if not (u30) then
            u30 = RunService_upv_1.RenderStepped:Connect(step)
        end
        a1.Sounds.Play("Open")
    end
    local function closeMenu(a38)
        --[[
          name: closeMenu
          line: 1349
          upvalues:
            u15 (ref,  index: 1)
            u31 (ref,  index: 2)
            u32 (ref,  index: 3)
            hideOthers (copy, index: 4)
            u33 (ref,  index: 5)
            u1 (ref,  index: 6)
            u2 (ref,  index: 7)
            u30 (ref,  index: 8)
            tbl_upv_3 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            u5 (ref,  index: 11)
            layout (copy, index: 12)
            Theme_upv_1 (copy, index: 13)
            fromOffset_upv_1 (copy, index: 14)
        ]]
        if not u15 then
            return
        end
        u15 = false
        local v136 = os.clock()
        u31 = true
        u32 = v136
        hideOthers(false)
        u33 = u33 + 1
        local u35 = u33
        local u36 = u1
        local u37 = u2
        local function done_1()
            --[[
              name: done
              line: 1360
              upvalues:
                u35 (copy, index: 1)
                u33 (ref,  index: 2)
                u31 (ref,  index: 3)
                u36 (copy, index: 4)
                u37 (copy, index: 5)
                u30 (ref,  index: 6)
                tbl_upv_3 (copy, index: 7)
                UI_upv_1 (copy, index: 8)
                u5 (ref,  index: 9)
                layout (copy, index: 10)
            ]]
            if u35 ~= u33 then
                return
            end
            u31 = false
            u36.Visible = false
            u37.Visible = false
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
            for _, value_31 in tbl_upv_3 do
                UI_upv_1.Unfade(value_31.body)
                if not (value_31.scene) then
                    continue
                end
                for v1, value_upv_32 in value_31.scene.tracks do
                    pcall(
                        function()
                            --[[
                              line: 1375
                              upvalues:
                                value_upv_32 (copy, index: 1)
                            ]]
                            value_upv_32:Stop(0)
                        end
                    )
                end
            end
            UI_upv_1.Unfade(u5)
            layout()
        end
        if a38 then
            done_1()
        else
            UI_upv_1.Tween(u37, Theme_upv_1.Tween.Close, {BackgroundTransparency = 1})
            UI_upv_1.FadeOut(u5, Theme_upv_1.Tween.Close)
            for _, value_33 in tbl_upv_3 do
                UI_upv_1.FadeOut(value_33.body, Theme_upv_1.Tween.Close)
                UI_upv_1.Tween(value_33.btn, Theme_upv_1.Tween.Close, {Position = value_33.btn.Position + fromOffset_upv_1(0, 26)})
                for v138, value_34 in value_33.lift:GetChildren() do
                    local v137 = value_34:IsA("Frame")
                    if not (v137) then
                        continue
                    end
                    if string.sub(value_34.Name, 1, 6) == "Shadow" then
                        UI_upv_1.Tween(value_34, Theme_upv_1.Tween.Close, {BackgroundTransparency = 1})
                    end
                end
                value_33.topPill.Visible = false
            end
            task.delay(0.16, done_1)
        end
    end
    local function select()
        --[[
          name: select
          line: 1406
          upvalues:
            tbl_upv_3 (copy, index: 1)
            u13 (ref,  index: 2)
        ]]
        local v138 = tbl_upv_3[u13]
        if v138 then
            return v138.btn
        end
        return nil
    end
    MenuManager_upv_1.Register("Mode", {open = open, close = closeMenu, select = select})
    local function repaint()
        --[[
          name: repaint
          line: 1413
          upvalues:
            u15 (ref,  index: 1)
            paint (copy, index: 2)
        ]]
        if not u15 then
            return
        end
        paint()
    end
    State_upv_1.AttrChanged:Connect(
        function(a39)
            --[[
              line: 1418
              upvalues:
                u15 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if a39 ~= "Duel" or not u15 then
                return
            end
            paint()
        end
    )
    SettingsStore_upv_1.Changed:Connect(
        function(a40)
            --[[
              line: 1423
              upvalues:
                u15 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if (a40 == "mmRanked" or a40 == "modeSel") and (u15) then
                paint()
            end
        end
    )
    if a1.Party and a1.Party.Changed then
        a1.Party.Changed:Connect(repaint)
    end
    UI_upv_1.GamepadChanged:Connect(repaint)
    local function relayout()
        --[[
          name: relayout
          line: 1432
          upvalues:
            u1 (ref,  index: 1)
            layout (copy, index: 2)
        ]]
        if not u1 then
            return
        end
        layout()
    end
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 1437
              upvalues:
                u1 (ref,  index: 1)
                u15 (ref,  index: 2)
                MenuManager_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                clearScene (copy, index: 5)
                u2 (ref,  index: 6)
                u3 (ref,  index: 7)
                u5 (ref,  index: 8)
                u20 (ref,  index: 9)
            ]]
            if not u1 then
                return
            end
            if u15 then
                MenuManager_upv_1.Close("Mode", true)
            end
            for _, value_35 in tbl_upv_3 do
                clearScene(value_35)
                value_35.btn:Destroy()
            end
            table.clear(tbl_upv_3)
            u1:Destroy()
            if u2 then
                u2:Destroy()
            end
            u1 = nil
            u2 = nil
            u3 = nil
            u5 = nil
            u20 = nil
        end
    )
    UI_upv_1.OnResize(relayout)
    a1.Debug.modeSelect = function(a41, a42, a43)
        --[[
          line: 1460
          upvalues:
            setFocus (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            pick (copy, index: 3)
            tbl_upv_14 (copy, index: 4)
            u20 (ref,  index: 5)
            u15 (ref,  index: 6)
            ensureScenes (copy, index: 7)
            tbl_upv_3 (copy, index: 8)
            u13 (ref,  index: 9)
            SettingsStore_upv_1 (copy, index: 10)
            State_upv_1 (copy, index: 11)
            a1 (copy, index: 12)
        ]]
        if a41 == "focus" and type(a42) == "number" then
            setFocus(a42)
        elseif a41 == "pick" then
            for key_11, value_36 in tbl_upv_2 do
                if value_36.id == a42 then
                    pick(key_11)
                end
            end
        elseif a41 == "hover" and type(a42) == "number" then
            setFocus(a42)
        elseif a41 == "scene" and type(a42) == "string" and tbl_upv_14[a42] and type(a43) == "table" then
            for key_12, value_37 in a43 do
                tbl_upv_14[a42][key_12] = value_37
            end
            u20 = nil
            if u15 then
                ensureScenes()
            end
        elseif a41 == "light" and type(a42) == "table" then
            for _, value_38 in tbl_upv_3 do
                value_38.vpf.Ambient = a42.ambient or (value_38.vpf.Ambient)
                value_38.vpf.LightColor = a42.color or (value_38.vpf.LightColor)
                value_38.vpf.LightDirection = a42.dir or (value_38.vpf.LightDirection)
            end
        end
        local tbl_21 = {last = 0, ranked = 0, bits = 0}
        tbl_21.open = u15
        tbl_21.focus = u13
        tbl_21.last = bit32.btest(math.floor(SettingsStore_upv_1.Get("modeSel")), 1) and "1v1" or "3v3"
        tbl_21.bits = math.floor(SettingsStore_upv_1.Get("modeSel"))
        tbl_21.ranked = SettingsStore_upv_1.Get("mmRanked") > 0.5
        local v141 = nil
        local v142 = nil
        for _, value_39 in tbl_upv_3 do
            local id_3 = value_39.def.id
            local tbl_22 = {locked = 0, fighters = 0, scene = 0, tracks = 0}
            if value_39.def.id ~= "1v1" then
                v141 = nil
                tbl_22.locked = v141 or false
                tbl_22.scene = value_39.scene ~= nil
                local v143 = ((value_39.scene) and (#value_39.scene.wm:GetChildren())) or 0
                tbl_22.fighters = v143
                tbl_22.tracks = ((value_39.scene) and (#value_39.scene.tracks)) or 0
                tbl_21[id_3] = tbl_22
                continue
            end
            if State_upv_1.Get("Duel") ~= true then
                v141 = "PLAY 3 MATCHES FIRST"
                tbl_22.locked = v141 or false
                tbl_22.scene = value_39.scene ~= nil
                local v143 = ((value_39.scene) and (#value_39.scene.wm:GetChildren())) or 0
                tbl_22.fighters = v143
                tbl_22.tracks = ((value_39.scene) and (#value_39.scene.tracks)) or 0
                tbl_21[id_3] = tbl_22
                continue
            end
            if not (a1.Party) or not (a1.Party.Size) then
                v142 = 1
                if v142 >= 2 then
                    v141 = "LEAVE YOUR PARTY TO PLAY 1V1"
                else
                    v141 = nil
                end
                tbl_22.locked = v141 or false
                tbl_22.scene = value_39.scene ~= nil
                local v143 = ((value_39.scene) and (#value_39.scene.wm:GetChildren())) or 0
                tbl_22.fighters = v143
                tbl_22.tracks = ((value_39.scene) and (#value_39.scene.tracks)) or 0
                tbl_21[id_3] = tbl_22
            end
            v142 = a1.Party.Size()
            if v142 >= 2 then
                v141 = "LEAVE YOUR PARTY TO PLAY 1V1"
            else
                v141 = nil
            end
            tbl_22.locked = v141 or false
            tbl_22.scene = value_39.scene ~= nil
            local v143 = ((value_39.scene) and (#value_39.scene.wm:GetChildren())) or 0
            tbl_22.fighters = v143
            tbl_22.tracks = ((value_39.scene) and (#value_39.scene.tracks)) or 0
            tbl_21[id_3] = tbl_22
        end
        return tbl_21
    end
end
return tbl_1