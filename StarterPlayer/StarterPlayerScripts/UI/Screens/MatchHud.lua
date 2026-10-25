local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 19
      upvalues:
        Players_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        GuiService_upv_1 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = UI_upv_1.new("Frame", {Visible = false, Name = "MatchHud", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u2 = Color3.fromRGB(255, 146, 52)
    local u3 = UI_upv_1.new("Frame", {Name = "Scoreboard", AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(700, 96), Parent = u1})
    a1.Scoreboard = u3
    local v1 = UI_upv_1.Panel({Name = "Center", BackgroundTransparency = 0.2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(150, 74), Radius = UDim.new(0, 12), Trim = Colors_upv_1.Accent, Parent = u3})
    local u4 = UI_upv_1.DisplayText({Name = "Timer", Text = "1:15", TextSize = 42, Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0, 44), TextColor3 = Colors_upv_1.Text, Parent = v1})
    local u5 = UI_upv_1.new("TextLabel", {Name = "Round", Text = "ROUND 1", TextSize = 15, Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 0, 20), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v1})
    local tbl_upv_2 = {}
    local function makeSide(a2)
        --[[
          name: makeSide
          line: 80
          upvalues:
            Colors_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u3 (copy, index: 3)
            u2 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
        ]]
        local v2
        if a2 then
            v2 = Colors_upv_1.Ally
        else
            v2 = Colors_upv_1.Enemy
        end
        local new_1 = UI_upv_1.new
        local tbl_3 = {AnchorPoint = 0, Name = 0, Position = 0, Parent = 0, Size = 0}
        tbl_3.Name = (a2 and "Left") or "Right"
        tbl_3.AnchorPoint = Vector2.new((a2 and 1) or 0, 0)
        tbl_3.Position = UDim2.new(0.5, (a2 and -80) or 80, 0, 0)
        tbl_3.Size = UDim2.fromOffset(270, 96)
        tbl_3.Parent = u3
        local v3 = new_1("Frame", tbl_3)
        local new_2 = UI_upv_1.new
        local tbl_4 = {ImageColor3 = 0, ImageTransparency = 1, Parent = 0, Image = 0, Name = "FinalGlow", Position = 0, ZIndex = 0, Size = 0}
        tbl_4.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_4.Position = UDim2.new((a2 and 1) or 0, (a2 and -33) or 33, 0, 30)
        tbl_4.Size = UDim2.fromOffset(150, 136)
        tbl_4.Image = UI_upv_1.Assets.Icons.Glow
        tbl_4.ImageColor3 = u2
        tbl_4.Parent = v3
        local v4 = new_2("ImageLabel", tbl_4)
        local v5 = UI_upv_1.Stroke(Theme_upv_1.Lighten(v2, 0.4), 2, 0.3)
        local new_3 = UI_upv_1.new
        local tbl_5 = {}
        tbl_5.Name = "ScoreBox"
        tbl_5.AnchorPoint = Vector2.new((a2 and 1) or 0, 0)
        tbl_5.Position = UDim2.fromScale((a2 and 1) or 0, 0)
        tbl_5.Size = UDim2.fromOffset(66, 60)
        tbl_5.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_5.BackgroundTransparency = 0.05
        tbl_5[1], tbl_5[2], tbl_5[3] = UI_upv_1.Corner(12), UI_upv_1.Gradient(Theme_upv_1.Lighten(v2, 0.1), Theme_upv_1.Darken(v2, 0.35), 90), v5
        tbl_5.Parent = v3
        local v6 = new_3("Frame", tbl_5)
        local v7 = UI_upv_1.DisplayText({StrokeThickness = 2.5, Text = "0", Name = "Score", TextSize = 44, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), TextColor3 = Colors_upv_1.Text, StrokeColor = Theme_upv_1.Darken(v2, 0.7), Parent = v6})
        local v8 = UI_upv_1.new
        local tbl_6 = {}
        tbl_6.Name = "Pips"
        tbl_6.AnchorPoint = Vector2.new(0.5, 0)
        local v9 = (a2 and 1) or 0
        tbl_6.Position = UDim2.new(v9, (a2 and -33) or 33, 0, 64)
        tbl_6.Size = UDim2.fromOffset(66, 10)
        tbl_6[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        tbl_6.Parent = v3
        v6 = v8("Frame", tbl_6)
        local new_4 = UI_upv_1.new
        local v10 = "Frame"
        local tbl_7 = {}
        tbl_7.Name = "Portraits"
        tbl_7.AnchorPoint = Vector2.new((a2 and 1) or 0, 0)
        local v11 = (a2 and 1) or 0
        tbl_7.Position = UDim2.new(v11, (a2 and -74) or 74, 0, 2)
        tbl_7.Size = UDim2.fromOffset(174, 54)
        local List_1 = UI_upv_1.List
        local Horizontal_1 = Enum.FillDirection.Horizontal
        local v12
        if a2 then
            v12 = Enum.HorizontalAlignment.Right
        else
            v12 = Enum.HorizontalAlignment.Left
        end
        tbl_7[1] = List_1(Horizontal_1, 6, v12, Enum.VerticalAlignment.Top)
        tbl_7.Parent = v3
        v8 = new_4(v10, tbl_7)
        local new_5 = UI_upv_1.new
        local v13 = "TextLabel"
        local tbl_8 = {Visible = false, FontFace = 0, TextColor3 = 0, Parent = 0, Text = "WOLF", AnchorPoint = 0, Name = "Tribe", Position = 0, TextXAlignment = 0, TextSize = 16, Size = 0}
        tbl_8.AnchorPoint = Vector2.new((a2 and 1) or 0, 0)
        local v14 = (a2 and 1) or 0
        tbl_8.Position = UDim2.new(v14, (a2 and -74) or 74, 0, 60)
        tbl_8.Size = UDim2.fromOffset(174, 18)
        tbl_8.FontFace = Fonts_upv_1.Heavy
        tbl_8.TextColor3 = Theme_upv_1.Lighten(v2, 0.45)
        local v15
        if a2 then
            v15 = Enum.TextXAlignment.Right
        else
            v15 = Enum.TextXAlignment.Left
        end
        tbl_8.TextXAlignment = v15
        tbl_8.Parent = v3
        v10 = new_5(v13, tbl_8)
        local tbl_9 = {}
        local v16 = tbl_9
        for n_1 = 1, 3 do
            local new_6 = UI_upv_1.new
            local tbl_10 = {}
            tbl_10.Name = "P" .. n_1
            tbl_10.Size = UDim2.fromOffset(54, 54)
            tbl_10.BackgroundColor3 = Theme_upv_1.Darken(v2, 0.55)
            tbl_10.BackgroundTransparency = 0.1
            local v17
            if a2 then
                v17 = 4 - n_1
            else
                v17 = n_1
            end
            tbl_10.LayoutOrder = v17
            tbl_10.ClipsDescendants = false
            tbl_10[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
            tbl_10.Parent = v8
            local v18 = new_6("Frame", tbl_10)
            local v19 = UI_upv_1.Stroke(v2, 2.5, 0)
            v19.Parent = v18
            local v20 = UI_upv_1.new("ImageLabel", {Name = "Img", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v18})
            local v21 = UI_upv_1.new("Frame", {Name = "Dim", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.35, Visible = false, ZIndex = 2, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v18})
            local v22 = UI_upv_1.Icon("cross", 40, Colors_upv_1.Danger, {ZIndex = 3, Thickness = 5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v18})
            v22.Visible = false
            v16[n_1] = {holder = v18, img = v20, stroke = v19, x = v22, dim = v21}
        end
        local tbl_11 = {}
        tbl_11.frame = v3
        tbl_11.score = v7
        tbl_11.boxStroke = v5
        tbl_11.glow = v4
        tbl_11.name = v10
        tbl_11.pips = v6
        tbl_11.portraits = v16
        return tbl_11
    end
    tbl_upv_2[1] = makeSide(true)
    tbl_upv_2[2] = makeSide(false)
    local function setPips(a3, a4, a5, a6)
        --[[
          name: setPips
          line: 207
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        local tbl_12 = {}
        for _, value_1 in a3.pips:GetChildren() do
            if value_1:IsA("Frame") then
                table.insert(tbl_12, value_1)
            end
        end
        for n_2 = #tbl_12 + 1, a5 do
            table.insert(tbl_12, UI_upv_1.new("Frame", {Size = UDim2.fromOffset(12, 8), BackgroundColor3 = a6, LayoutOrder = n_2, [1] = UI_upv_1.Corner(3), Parent = a3.pips}))
        end
        local v23 = math.clamp(math.floor(66 / math.max(a5, 1)) - 3, 4, 14)
        local v24, v24 = nil, nil
        for key_1, value_2 in tbl_12 do
            value_2.Visible = key_1 <= a5
            value_2.Size = UDim2.fromOffset(v23, 8)
            if key_1 <= a4 then
                v24 = a6
            else
                v24 = Color3.fromRGB(52, 56, 68)
            end
            value_2.BackgroundColor3 = v24
            if key_1 <= a4 then
                v24 = 0
            else
                v24 = 0.25
            end
            value_2.BackgroundTransparency = v24
        end
    end
    local u6 = -1
    local u7 = false
    local u8 = false
    local u9 = v1:FindFirstChildOfClass("UIStroke")
    local u10 = u9 and {u9.Color, u9.Transparency, u9.Thickness}
    local function paintFinal(a7)
        --[[
          name: paintFinal
          line: 275
          upvalues:
            u8 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            u5 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            u9 (copy, index: 7)
            u10 (copy, index: 8)
            u2 (copy, index: 9)
        ]]
        if a7 ~= u8 then
            u8 = a7
            if a7 then
                UI_upv_1.Bump(u5, 0.25)
            else
                local v25 = nil
                for key_2, value_3 in tbl_upv_2 do
                    value_3.glow.ImageTransparency = 1
                    local boxStroke_1 = value_3.boxStroke
                    local Lighten_1 = Theme_upv_1.Lighten
                    if key_2 ~= 1 then
                        v25 = Colors_upv_1.Enemy
                    else
                        v25 = Colors_upv_1.Ally
                    end
                    boxStroke_1.Color = Lighten_1(v25, 0.4)
                    value_3.boxStroke.Transparency = 0.3
                end
                if u9 and u10 then
                    u9.Color = u10[1]
                    u9.Transparency = u10[2]
                    u9.Thickness = u10[3]
                end
            end
        end
        if not a7 then
            return
        end
        local v26 = math.sin(os.clock() * 2.4) * 0.5 + 0.5
        local v27 = nil
        for key_3, value_4 in tbl_upv_2 do
            value_4.glow.ImageTransparency = 0.7 - (v26 * 0.24)
            local boxStroke_2 = value_4.boxStroke
            local Lighten_2 = Theme_upv_1.Lighten
            if key_3 ~= 1 then
                v27 = Colors_upv_1.Enemy
            else
                v27 = Colors_upv_1.Ally
            end
            boxStroke_2.Color = Lighten_2(v27, 0.4):Lerp(u2, (v26 * 0.35) + 0.35)
            value_4.boxStroke.Transparency = 0.25 - (v26 * 0.15)
        end
        if not u9 then
            return
        end
        u9.Color = u2
        u9.Thickness = 1.5
        u9.Transparency = 0.6 - (v26 * 0.3)
    end
    local u11 = UI_upv_1.new("TextLabel", {Visible = false, Text = "OVERTIME", Name = "Overtime", TextSize = 17, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 78), Size = UDim2.fromOffset(200, 20), FontFace = Fonts_upv_1.Title, TextColor3 = Colors_upv_1.Danger, Parent = u3})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.1).Parent = u11
    local function phaseText(a8)
        --[[
          name: phaseText
          line: 306
          upvalues:
            State_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v28 = a8 and (a8.phase)
        local v29 = State_upv_1.PhaseTimeLeft()
        if v28 == "Overtime" then
            local v30 = ((not (v29 > 0)) and "OVERTIME") or (UI_upv_1.FormatTime(v29))
            return v30, Colors_upv_1.Danger
        elseif v28 ~= "Live" then
            if v28 ~= "PreRound" and v28 ~= "Intro" then
                if v28 ~= "RoundEnd" and v28 ~= "MatchEnd" then
                    return UI_upv_1.FormatTime(v29), Colors_upv_1.Text
                end
                return "0:00", Colors_upv_1.TextDim
            end
            return UI_upv_1.FormatTime(State_upv_1.RoundTime()), Colors_upv_1.TextDim
        else
            local v31 = UI_upv_1.FormatTime(v29)
            if v29 <= 10 then
                return v31, Colors_upv_1.Danger
            end
            return v31, Colors_upv_1.Text
        end
    end
    local function tickTimer()
        --[[
          name: tickTimer
          line: 335
          upvalues:
            State_upv_1 (copy, index: 1)
            phaseText (copy, index: 2)
            u4 (copy, index: 3)
            a1 (copy, index: 4)
            u5 (copy, index: 5)
            u2 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            paintFinal (copy, index: 8)
            u7 (ref,  index: 9)
            u11 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            u6 (ref,  index: 12)
        ]]
        local Match_1 = State_upv_1.Match
        local v32, v33 = phaseText(Match_1)
        u4.Text = v32
        u4.TextColor3 = v33
        v33 = (a1.Decider ~= nil) and (a1.Decider.Active())
        local v34
        if v33 then
            v34 = "FINAL ROUND"
        else
            v34 = "ROUND " .. tostring((Match_1 and (Match_1.round)) or 1)
        end
        u5.Text = v34
        local v35
        if v33 then
            v35 = u2
        else
            v35 = Colors_upv_1.TextDim
        end
        u5.TextColor3 = v35
        paintFinal(v33)
        local v36 = (Match_1 and (Match_1.phase)) == "Overtime"
        if v36 ~= u7 then
            u7 = v36
            u11.Visible = v36
            if v36 then
                UI_upv_1.Pop(u11, 1.5)
            end
        end
        if v36 then
            u11.TextTransparency = (math.sin(os.clock() * 6) * 0.25) + 0.25
        end
        if Match_1 == "Live" or Match_1 == "Overtime" then
            local v37 = math.ceil(State_upv_1.PhaseTimeLeft())
            if v37 == u6 then
                return
            end
            u6 = v37
            if not (v37 <= 10) or not (v37 > 0) then
                return
            end
            UI_upv_1.Bump(u4, 0.12)
        end
    end
    local u12 = UI_upv_1.new("Frame", {Name = "Health", AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(372, 40), Parent = u1})
    local u13 = UI_upv_1.DisplayText({StrokeThickness = 2.5, Text = "100", Name = "Number", TextSize = 40, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 2), Size = UDim2.fromOffset(72, 40), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Colors_upv_1.Text, Parent = u12})
    local tbl_upv_13 = {}
    tbl_upv_13.Name = "Bar"
    tbl_upv_13.AnchorPoint = Vector2.new(1, 1)
    tbl_upv_13.Position = UDim2.new(1, 0, 1, -4)
    tbl_upv_13.Size = UDim2.new(1, -80, 0, 20)
    tbl_upv_13.BackgroundColor3 = Colors_upv_1.Void
    tbl_upv_13.BackgroundTransparency = 0.3
    tbl_upv_13.ClipsDescendants = true
    tbl_upv_13[1], tbl_upv_13[2] = UI_upv_1.Corner(6), UI_upv_1.Stroke(Colors_upv_1.Stroke, 2, 0.6)
    tbl_upv_13.Parent = u12
    local v38 = UI_upv_1.new("Frame", tbl_upv_13)
    local u14 = UI_upv_1.new("Frame", {Name = "Trail", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.HealthTrail, BackgroundTransparency = 0.15, [1] = UI_upv_1.Corner(6), Parent = v38})
    tbl_upv_13 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(6), Parent = v38})
    local u15 = UI_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Health, 0.2), Theme_upv_1.Darken(Colors_upv_1.Health, 0.15), 90)
    u15.Parent = tbl_upv_13
    for n_3 = 1, 3 do
        UI_upv_1.new("Frame", {BackgroundTransparency = 0.55, ZIndex = 2, Position = UDim2.new(n_3 * 0.25, -1, 0, 3), Size = UDim2.new(0, 2, 1, -6), BackgroundColor3 = Colors_upv_1.Void, Parent = v38})
        local u16 = n_3
    end
    local u17 = UI_upv_1.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 3, [1] = UI_upv_1.Corner(6), Parent = v38})
    local Armor_upv_1 = Colors_upv_1.Armor
    local u18 = UI_upv_1.new("Frame", {Name = "Armor", Visible = false, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 0, -2), Size = UDim2.new(1, -80, 0, 12), Parent = u12})
    local u16 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Shield, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0, -6, 0.5, 0), Size = UDim2.fromOffset(16, 16), ImageColor3 = Armor_upv_1, Parent = u18})
    local u19 = UI_upv_1.DisplayText({StrokeThickness = 1.5, Text = "0", TextSize = 16, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0, -26, 0.5, 1), Size = UDim2.fromOffset(40, 16), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = Armor_upv_1, Parent = u18})
    local tbl_upv_14 = {}
    tbl_upv_14.Size = UDim2.fromScale(1, 1)
    tbl_upv_14.BackgroundColor3 = Colors_upv_1.Void
    tbl_upv_14.BackgroundTransparency = 0.3
    tbl_upv_14.ClipsDescendants = true
    tbl_upv_14[1], tbl_upv_14[2] = UI_upv_1.Corner(4), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.7)
    tbl_upv_14.Parent = u18
    local paintArmor = UI_upv_1.new("Frame", tbl_upv_14)
    local u20 = UI_upv_1.Gradient(Theme_upv_1.Lighten(Armor_upv_1, 0.2), Theme_upv_1.Darken(Armor_upv_1, 0.15), 90)
    tbl_upv_14 = UI_upv_1.new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(4), Parent = paintArmor})
    u20.Parent = tbl_upv_14
    local u21 = 0
    local u22 = nil
    local u23 = false
    local u24 = 0
    paintArmor = function(a9)
        --[[
          name: paintArmor
          line: 488
          upvalues:
            u22 (ref,  index: 1)
            u18 (copy, index: 2)
            u21 (ref,  index: 3)
            u23 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            Armor_upv_1 (copy, index: 6)
            u20 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            u16 (copy, index: 9)
            u19 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            u24 (ref,  index: 12)
            tbl_upv_14 (copy, index: 13)
        ]]
        local v39 = u22
        local v40 = v39 and (u22:GetAttribute("MaxArmor"))
        local v41 = u22
        local v42 = v41 and (u22:GetAttribute("Armor"))
        local v43
        if type(u22) ~= "number" then
            v43 = 0
        else
            v43 = v40
        end
        local v44 = ((type(v42) ~= "number") and 0) or (math.clamp(u22, 0, v43))
        u18.Visible = v43 > 0
        if v43 <= 0 then
            u21 = 0
        else
            local v45 = u22 and (u22:GetAttribute("BonusArmor"))
            local v46 = false
            if type(v45) == "number" then
                v46 = v45 > 0
            end
            if v46 ~= u23 then
                u23 = v46
                local v47
                if v46 then
                    v47 = Colors_upv_1.Gold
                else
                    v47 = Armor_upv_1
                end
                u20.Color = ColorSequence.new(Theme_upv_1.Lighten(v47, 0.2), Theme_upv_1.Darken(v47, 0.15))
                u16.ImageColor3 = v47
                u19.TextColor3 = v47
                if v46 then
                    UI_upv_1.Bump(u16, 0.3)
                end
            end
            u19.Text = tostring(math.ceil(v44))
            local v48 = v44 / v43
            local v49 = workspace:GetServerTimeNow()
            local v50 = (u24 > 0) and ((u24 - 0.3 < v49) and (v49 < u24 + 1.5))
            if a9 then
                tbl_upv_14.Size = UDim2.fromScale(v48, 1)
            else
                local Tween_1 = UI_upv_1.Tween
                local v51
                if v44 < u21 then
                    v51 = Theme_upv_1.Tween.Fast
                else
                    v51 = Theme_upv_1.Tween.Smooth
                end
                Tween_1(tbl_upv_14, v51, {Size = UDim2.fromScale(v48, 1)})
                if v44 < u21 and not (v50) then
                    UI_upv_1.Bump(u16, 0.25)
                    if v44 <= 0 then
                        UI_upv_1.Shake(u18, 6)
                    end
                end
            end
            tbl_upv_14.BackgroundTransparency = ((v44 <= 0) and 1) or 0
            u21 = v44
        end
    end
    local u25 = nil
    local Health_upv_1 = 100
    local u26 = 0
    local u27 = false
    local function paintHealth(a10)
        --[[
          name: paintHealth
          line: 534
          upvalues:
            u25 (ref,  index: 1)
            u13 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u15 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            u27 (ref,  index: 6)
            tbl_upv_13 (copy, index: 7)
            u14 (copy, index: 8)
            Health_upv_1 (ref,  index: 9)
            u17 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            u12 (copy, index: 12)
            u26 (ref,  index: 13)
        ]]
        if not u25 then
            return
        end
        local v52 = ((not (u25.MaxHealth > 0)) and 100) or (u25.MaxHealth)
        local v53 = math.clamp(u25.Health, 0, v52)
        local u28 = v53 / v52
        u13.Text = tostring(math.ceil(v53))
        local v54
        if u28 <= 0.3 then
            v54 = Colors_upv_1.HealthLow
        elseif u28 <= 0.6 then
            v54 = Color3.fromRGB(240, 196, 70)
        else
            v54 = Colors_upv_1.Health
        end
        u15.Color = ColorSequence.new(Theme_upv_1.Lighten(v54, 0.2), Theme_upv_1.Darken(v54, 0.15))
        u27 = (u28 <= 0.3) and (v53 > 0)
        if a10 then
            tbl_upv_13.Size = UDim2.fromScale(u28, 1)
            u14.Size = UDim2.fromScale(u28, 1)
        elseif v53 < Health_upv_1 then
            tbl_upv_13.Size = UDim2.fromScale(u28, 1)
            u17.BackgroundTransparency = 0.35
            local tbl_15 = {BackgroundTransparency = 1}
            UI_upv_1.Tween(u17, TweenInfo.new(0.25), tbl_15)
            UI_upv_1.Bump(u13, (math.clamp((Health_upv_1 - v53) / 60, 0.08, 0.3)))
            if Health_upv_1 - v53 >= 8 then
                UI_upv_1.Shake(u12, (math.clamp((Health_upv_1 - v53) / 5, 3, 9)))
            end
            u26 = u26 + 1
            local u29 = u26
            task.delay(
                0.35,
                function()
                    --[[
                      line: 561
                      upvalues:
                        u29 (copy, index: 1)
                        u26 (ref,  index: 2)
                        UI_upv_1 (copy, index: 3)
                        u14 (copy, index: 4)
                        u28 (copy, index: 5)
                    ]]
                    if u29 ~= u26 then
                        return
                    end
                    UI_upv_1.Tween(u14, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(u28, 1)})
                end
            )
        else
            UI_upv_1.Tween(tbl_upv_13, Theme_upv_1.Tween.Smooth, {Size = UDim2.fromScale(u28, 1)})
            UI_upv_1.Tween(u14, Theme_upv_1.Tween.Smooth, {Size = UDim2.fromScale(u28, 1)})
            if Health_upv_1 + 1 < v53 then
                u13.TextColor3 = Colors_upv_1.Health
                task.delay(
                    0.4,
                    function()
                        --[[
                          line: 572
                          upvalues:
                            u13 (copy, index: 1)
                            Colors_upv_1 (copy, index: 2)
                        ]]
                        u13.TextColor3 = Colors_upv_1.Text
                    end
                )
            end
        end
        Health_upv_1 = v53
    end
    local tbl_upv_16 = {}
    local u30 = nil
    local function hookCharacter(a11)
        --[[
          name: hookCharacter
          line: 585
          upvalues:
            tbl_upv_16 (copy, index: 1)
            u25 (ref,  index: 2)
            u22 (ref,  index: 3)
            u21 (ref,  index: 4)
            u24 (ref,  index: 5)
            paintArmor (copy, index: 6)
            LocalPlayer_upv_1 (copy, index: 7)
            u30 (ref,  index: 8)
            Health_upv_1 (ref,  index: 9)
            paintHealth (copy, index: 10)
        ]]
        for _, value_5 in tbl_upv_16 do
            value_5:Disconnect()
        end
        table.clear(tbl_upv_16)
        u25 = nil
        u22 = a11
        u21 = 0
        u24 = 0
        paintArmor(true)
        if not a11 then
            return
        end
        table.insert(
            tbl_upv_16,
            a11:GetAttributeChangedSignal("Armor"):Connect(
                function()
                    --[[
                      line: 598
                      upvalues:
                        paintArmor (copy, index: 1)
                    ]]
                    paintArmor(false)
                end
            )
        )
        table.insert(
            tbl_upv_16,
            a11:GetAttributeChangedSignal("BonusArmor"):Connect(
                function()
                    --[[
                      line: 601
                      upvalues:
                        paintArmor (copy, index: 1)
                    ]]
                    paintArmor(false)
                end
            )
        )
        table.insert(
            tbl_upv_16,
            a11:GetAttributeChangedSignal("BonusArmorUntil"):Connect(
                function()
                    --[[
                      line: 604
                      upvalues:
                        a11 (copy, index: 1)
                        u24 (ref,  index: 2)
                    ]]
                    local v55 = a11:GetAttribute("BonusArmorUntil")
                    if type(v55) ~= "number" then
                        return
                    end
                    u24 = v55
                end
            )
        )
        table.insert(
            tbl_upv_16,
            a11:GetAttributeChangedSignal("MaxArmor"):Connect(
                function()
                    --[[
                      line: 610
                      upvalues:
                        paintArmor (copy, index: 1)
                    ]]
                    paintArmor(true)
                end
            )
        )
        local v56 = a11:FindFirstChildOfClass("Humanoid") or (a11:WaitForChild("Humanoid", 10))
        if not v56 then
            return
        end
        if v56:IsA("Humanoid") and (LocalPlayer_upv_1.Character == a11 or u30 == a11) then
            u25 = v56
            Health_upv_1 = v56.Health
            paintHealth(true)
            table.insert(
                tbl_upv_16,
                v56.HealthChanged:Connect(
                    function()
                        --[[
                          line: 620
                          upvalues:
                            paintHealth (copy, index: 1)
                        ]]
                        paintHealth(false)
                    end
                )
            )
            table.insert(
                tbl_upv_16,
                v56:GetPropertyChangedSignal("MaxHealth"):Connect(
                    function()
                        --[[
                          line: 623
                          upvalues:
                            paintHealth (copy, index: 1)
                        ]]
                        paintHealth(true)
                    end
                )
            )
        end
    end
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a12)
            --[[
              line: 627
              upvalues:
                u30 (ref,  index: 1)
                hookCharacter (copy, index: 2)
            ]]
            if (u30) then
                return
            end
            hookCharacter(a12)
        end
    )
    task.spawn(hookCharacter, LocalPlayer_upv_1.Character)
    local u31 = UDim2.new(0.5, 0, 0, 0)
    local u32 = 0
    local u33 = nil
    local u34 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local function boardHomeRect()
        --[[
          name: boardHomeRect
          line: 646
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            u3 (copy, index: 3)
            u31 (ref,  index: 4)
        ]]
        local v57 = math.max(UI_upv_1.Scale, 0.01)
        local v58 = u1.AbsoluteSize / v57
        local v59 = u3.AbsoluteSize / v57
        local v60 = (u31.X.Scale * v58.X) + u31.X.Offset - u3.AnchorPoint.X * v59.X
        local v61 = u31.Y.Scale * v58.Y + u31.Y.Offset
        return Rect.new(v60, v61, v60 + v59.X, v61 + v59.Y), v58
    end
    local function applyBoard(a13)
        --[[
          name: applyBoard
          line: 669
          upvalues:
            u31 (ref,  index: 1)
            u32 (ref,  index: 2)
            u33 (ref,  index: 3)
            u1 (copy, index: 4)
            u3 (copy, index: 5)
            TweenService_upv_1 (copy, index: 6)
            u34 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        local v62 = u31 + UDim2.fromOffset(u32, 0)
        if u33 then
            u33:Cancel()
            u33 = nil
        end
        if a13 and u1.Visible and u3.Visible then
            local v63 = TweenService_upv_1:Create(u3, u34, {Position = v62})
            u33 = v63
            u33:Play()
        else
            u3.Position = v62
        end
        if not a1.KillFeedRelayout then
            return
        end
        a1.KillFeedRelayout()
    end
    local function computeBoardShift()
        --[[
          name: computeBoardShift
          line: 655
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            u3 (copy, index: 3)
            boardHomeRect (copy, index: 4)
        ]]
        local v64 = UI_upv_1.ChatRectIn(u1)
        if v64 and u1.Visible and u3.Visible and not (UI_upv_1.Compact) then
            local v65, v66 = boardHomeRect()
            if not (v64.Max.X + 12 <= v65.Min.X) and not (v65.Max.X <= v64.Min.X) and not (v64.Max.Y <= v65.Min.Y) and not (v65.Max.Y <= v64.Min.Y) then
                return (math.max(0, math.min((v64.Max.X + 12) - v65.Min.X, (v66.X - 12) - v65.Max.X)))
            end
            return 0
        end
        return 0
    end
    local function redodgeBoard(a14)
        --[[
          name: redodgeBoard
          line: 686
          upvalues:
            computeBoardShift (copy, index: 1)
            u32 (ref,  index: 2)
            applyBoard (copy, index: 3)
        ]]
        local v67 = computeBoardShift()
        if not (math.abs(v67 - u32) > 1) then
            return
        end
        u32 = v67
        applyBoard(a14)
    end
    UI_upv_1.ChatChanged:Connect(
        function()
            --[[
              line: 693
              upvalues:
                redodgeBoard (copy, index: 1)
            ]]
            task.defer(redodgeBoard, true)
        end
    )
    u1:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 696
              upvalues:
                redodgeBoard (copy, index: 1)
            ]]
            task.defer(redodgeBoard, false)
        end
    )
    u3:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 699
              upvalues:
                redodgeBoard (copy, index: 1)
            ]]
            task.defer(redodgeBoard, false)
        end
    )
    local function boardW()
        --[[
          name: boardW
          line: 712
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v68 = math.clamp(State_upv_1.TeamSize(), 1, 3)
        if v68 >= 3 then
            return 700
        end
        return ((((v68 * 54) + 154) + ((v68 - 1) * 6)) * 2) + 24
    end
    local u35 = UI_upv_1.new("UIScale", {Name = "FitScale", Parent = u3})
    local function phoneBoardHome()
        --[[
          name: phoneBoardHome
          line: 720
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            a1 (copy, index: 3)
            GuiService_upv_1 (copy, index: 4)
            State_upv_1 (copy, index: 5)
        ]]
        local v69 = math.max(UI_upv_1.Scale, 0.01)
        local AbsolutePosition_1 = u1.AbsolutePosition
        local v70 = u1.AbsoluteSize / v69
        local TopbarSettings_1 = a1.TopbarSettings and (a1.TopbarSettings.Button)
        local v71 = TopbarSettings_1 and (TopbarSettings_1:FindFirstAncestorOfClass("ScreenGui"))
        local v72, v73
        if not UI_upv_1.DebugDevice and TopbarSettings_1 and v71 then
            if TopbarSettings_1.AbsoluteSize.X < 1 then
                local v74 = (UI_upv_1.TopInset() - 4) * 6
                local v75
                v72, v73, v75 = v70.X - 16, v74, 6
            else
                v73 = (TopbarSettings_1.AbsolutePosition.X + TopbarSettings_1.AbsoluteSize.X - AbsolutePosition_1.X) / v69 + 12
                local v75 = (TopbarSettings_1.AbsolutePosition.Y - AbsolutePosition_1.Y) / v69
                local _ = GuiService_upv_1.TopbarInset
                v72 = GuiService_upv_1.TopbarInset.Width > 0 and (v71.AbsolutePosition.X + GuiService_upv_1.TopbarInset.Max.X - AbsolutePosition_1.X) / v69 - 8 or v70.X - 16
            end
        else
            local v74 = (UI_upv_1.TopInset() - 4) * 6
            local v75
            v72, v73, v75 = v70.X - 16, v74, 6
        end
        local v76 = math.min(v72, v70.X - 16)
        local v77 = math.clamp(State_upv_1.TeamSize(), 1, 3)
        local v78 = ((v77 >= 3) and 700) or ((((v77 * 54) + 154) + ((v77 - 1) * 6)) * 2 + 24)
        local v79 = (v76 - v73) / v78
        if v79 < 0.55 then
            local v80 = math.min(1, (v70.X - 32) / v78)
            return UDim2.new(0.5, 0, 0, UI_upv_1.TopInset()), v80
        else
            local v81 = math.min(v79, 1)
            local v82 = v78 * v81
            v71 = v70.X / 2
            local v83 = ((v71 - (v82 / 2) < v73) and (v73 + v82 / 2)) or v71
            if v76 < v83 + (v82 / 2) then
                v71 = math.max(v73 + (v82 / 2), v76 - (v82 / 2))
            else
                v71 = v83
            end
            local v75 = nil
            return UDim2.fromOffset(math.floor(v71), math.floor(math.max(2, v75))), v81
        end
    end
    local function layout()
        --[[
          name: layout
          line: 757
          upvalues:
            UI_upv_1 (copy, index: 1)
            phoneBoardHome (copy, index: 2)
            u31 (ref,  index: 3)
            u35 (copy, index: 4)
            u32 (ref,  index: 5)
            u33 (ref,  index: 6)
            u3 (copy, index: 7)
            a1 (copy, index: 8)
            redodgeBoard (copy, index: 9)
            u12 (copy, index: 10)
        ]]
        local v84 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            local v85, v86 = phoneBoardHome()
            u31 = v85
            u35.Scale = v86
        else
            u31 = UDim2.new(0.5, 0, 0, v84)
            u35.Scale = 1
        end
        local v87 = u31 + UDim2.fromOffset(u32, 0)
        if u33 then
            u33:Cancel()
            u33 = nil
        end
        u3.Position = v87
        local v88 = nil
        if v88.KillFeedRelayout then
            v88.KillFeedRelayout()
        end
        task.defer(redodgeBoard, false)
        local v89 = ((not (a1.HotbarWidth)) and 372) or (v88.HotbarWidth())
        u12.Size = UDim2.fromOffset(v89, 40)
        local v90 = ((not (a1.HotbarTop)) and 110) or (a1.HotbarTop())
        u12.Position = UDim2.new(0.5, 0, 1, -(v90 + 8))
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    UI_upv_1.TopInsetChanged:Connect(layout)
    local u36 = false
    local function queueLayout()
        --[[
          name: queueLayout
          line: 779
          upvalues:
            u36 (ref, index: 1)
        ]]
        if u36 then
            return
        end
        u36 = true
        task.defer(function() end)
    end
    UI_upv_1.ScaleChanged:Connect(queueLayout)
    u1:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)
    if a1.TopbarSettings and a1.TopbarSettings.Button then
        a1.TopbarSettings.Button:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
    end
    if a1.HotbarChanged then
        a1.HotbarChanged.Event:Connect(layout)
    end
    if a1.ToastAvoid then
        a1.ToastAvoid("Scoreboard", u3)
    end
    local u37 = nil
    local function refreshVisible()
        --[[
          name: refreshVisible
          line: 803
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u30 (ref,  index: 3)
            u1 (copy, index: 4)
            u12 (copy, index: 5)
            u3 (copy, index: 6)
            u37 (ref,  index: 7)
            RunService_upv_1 (copy, index: 8)
            tickTimer (copy, index: 9)
            u27 (ref,  index: 10)
            tbl_upv_13 (copy, index: 11)
        ]]
        local v91 = (State_upv_1.SeesMatch() and (not a1.HudHidden)) or (u30 ~= nil)
        if State_upv_1.Match == nil or State_upv_1.Match.phase == "Loading" then
            v91 = false
        end
        u1.Visible = v91
        local v92 = State_upv_1.IsAlive() and (not State_upv_1.Watching())
        u12.Visible = v92 or u30 ~= nil
        u3.Visible = u30 == nil
        if a1.TopbarSettings then
            a1.TopbarSettings.SetHidden("Replay", u30 ~= nil)
        end
        if v91 and not (u37) then
            local v95 = RunService_upv_1.Heartbeat:Connect(
                function()
                    --[[
                      line: 816
                      upvalues:
                        tickTimer (copy, index: 1)
                        u27 (ref,  index: 2)
                        tbl_upv_13 (copy, index: 3)
                    ]]
                    tickTimer()
                    if u27 then
                        tbl_upv_13.BackgroundTransparency = (math.sin(os.clock() * 8) * 0.25) + 0.25
                    elseif tbl_upv_13.BackgroundTransparency ~= 0 then
                        tbl_upv_13.BackgroundTransparency = 0
                    end
                end
            )
            u37 = v95
            return
        end
        if (v91) or not u37 then
            return
        end
        u37:Disconnect()
        u37 = nil
    end
    local u38 = State_upv_1.TeamSize()
    local function paintBoard(a15)
        --[[
          name: paintBoard
          line: 232
          upvalues:
            State_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            setPips (copy, index: 5)
            Portraits_upv_1 (copy, index: 6)
        ]]
        if not a15 then
            return
        end
        local v96 = State_upv_1.MyTeam()
        local v97 = nil
        local v98 = nil
        local v99 = nil
        local v100 = nil
        local _ = nil
        for key_4, value_6 in {v96, 3 - v96} do
            local v101 = tbl_upv_2[key_4]
            local v102 = a15.teams[value_6]
            if key_4 ~= 1 then
                v98 = Colors_upv_1.Enemy
            else
                v98 = Colors_upv_1.Ally
            end
            v101.name.Text = ""
            local v103 = v102.score or 0
            v101.score.Text = tostring(v103)
            if v101.lastScore and v101.lastScore < v103 then
                UI_upv_1.Pop(v101.score, 1.6)
            end
            v101.lastScore = v103
            local v104 = a15.roundsToWin or (State_upv_1.RoundsToWin())
            setPips(v101, v103, v104, v98)
            v97 = nil
            v99 = nil
            v100 = nil
            for key_5, value_7 in v101.portraits do
                v103 = v102.members[key_5]
                value_7.holder.Visible = v103 ~= nil
                if not (v103) then
                    continue
                end
                Portraits_upv_1.Apply(value_7.img, v103, 60)
                local v105 = v103.alive == false
                v97 = v103.connected == false
                value_7.x.Visible = v105
                value_7.dim.Visible = v105 or v97
                local SetTint_1 = Portraits_upv_1.SetTint
                v100 = value_7.img
                if v105 then
                    v99 = Color3.fromRGB(150, 150, 150)
                else
                    v99 = Color3.new(1, 1, 1)
                end
                SetTint_1(v100, v99, (v105 and 0.35) or 0)
                local stroke_1 = value_7.stroke
                if v105 then
                    v100 = Color3.fromRGB(90, 84, 78)
                else
                    v100 = v98
                end
                stroke_1.Color = v100
                if v103.id == State_upv_1.MyId() then
                    v97 = true
                else
                    v97 = false
                end
                local stroke_2 = value_7.stroke
                if v97 then
                    v100 = 3.5
                else
                    v100 = 2.5
                end
                stroke_2.Thickness = v100
            end
        end
    end
    State_upv_1.MatchChanged:Connect(
        function(a16)
            --[[
              line: 830
              upvalues:
                paintBoard (copy, index: 1)
                refreshVisible (copy, index: 2)
                State_upv_1 (copy, index: 3)
                u38 (ref,  index: 4)
                u36 (ref,  index: 5)
                layout (copy, index: 6)
            ]]
            paintBoard(a16)
            refreshVisible()
            local v106 = State_upv_1.TeamSize()
            if v106 == u38 then
                return
            end
            u38 = v106
            if u36 then
                return
            end
            u36 = true
            task.defer(
                function()
                    --[[
                      line: 784
                      upvalues:
                        u36 (ref,  index: 1)
                        layout (copy, index: 2)
                    ]]
                    u36 = false
                    layout()
                end
            )
        end
    )
    State_upv_1.PlayerStateChanged:Connect(refreshVisible)
    State_upv_1.WatchChanged:Connect(
        function()
            --[[
              line: 841
              upvalues:
                paintBoard (copy, index: 1)
                State_upv_1 (copy, index: 2)
                refreshVisible (copy, index: 3)
            ]]
            paintBoard(State_upv_1.Match)
            refreshVisible()
        end
    )
    State_upv_1.AttrChanged:Connect(
        function(a17)
            --[[
              line: 845
              upvalues:
                refreshVisible (copy, index: 1)
                paintBoard (copy, index: 2)
                State_upv_1 (copy, index: 3)
            ]]
            if a17 ~= "Alive" and a17 ~= "Team" then
                return
            end
            refreshVisible()
            paintBoard(State_upv_1.Match)
        end
    )
    a1.HudHiddenChanged:Connect(refreshVisible)
    paintBoard(State_upv_1.Match)
    refreshVisible()
    a1.MatchHud = {Root = u1, Board = u3, Health = u12}
    function a1.MatchHud.KillFeedTop()
        --[[
          name: KillFeedTop
          line: 858
          upvalues:
            UI_upv_1 (copy, index: 1)
            u3 (copy, index: 2)
            u1 (copy, index: 3)
            u32 (ref,  index: 4)
            boardHomeRect (copy, index: 5)
        ]]
        if UI_upv_1.Compact and u3.Visible then
            local v107 = math.max(UI_upv_1.Scale, 0.01)
            local AbsolutePosition_2 = u1.AbsolutePosition
            local v108 = ((u3.AbsolutePosition.Y + u3.AbsoluteSize.Y) - AbsolutePosition_2.Y) / v107
            if (u1.AbsoluteSize / v107).X - 340 < ((u3.AbsolutePosition.X + u3.AbsoluteSize.X) - AbsolutePosition_2.X) / v107 and UI_upv_1.TopInset() < v108 + 8 then
                return v108 + 8
            end
            return nil
        elseif u32 <= 0 then
            return nil
        else
            return boardHomeRect().Max.Y + 8
        end
    end
    function a1.MatchHud.SetReplaySource(a18)
        --[[
          name: SetReplaySource
          line: 877
          upvalues:
            u30 (ref,  index: 1)
            hookCharacter (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            refreshVisible (copy, index: 4)
        ]]
        u30 = a18
        local v109 = a18 or LocalPlayer_upv_1.Character
        hookCharacter(v109)
        refreshVisible()
    end
end
return tbl_1