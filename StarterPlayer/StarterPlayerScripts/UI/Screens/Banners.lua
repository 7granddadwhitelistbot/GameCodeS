local _ = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Tribes_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local tbl_1 = {}
local Tips_upv_1 = require(script.Parent.Parent.Tips)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 25
      upvalues:
        Tribes_upv_1 (copy, index: 2)
        Tips_upv_1 (copy, index: 3)
        ReplicatedStorage_upv_1 (copy, index: 4)
        RunService_upv_1 (copy, index: 5)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local u1 = UI_upv_1.new("Frame", {Name = "Banners", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Overlay})
    local u2 = UI_upv_1.DisplayText({StrokeThickness = 5, Text = "", Name = "Slam", Visible = false, TextSize = 100, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.36), Size = UDim2.fromOffset(900, 140), TextColor3 = Colors_upv_1.Text, Parent = u1})
    local u3 = u2:FindFirstChildOfClass("UIStroke")
    local u4 = UI_upv_1.new("UIScale", {Name = "Scale", Parent = u2})
    local u5 = UI_upv_1.new("TextLabel", {Visible = false, Text = "", Name = "SlamSub", TextSize = 30, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.36, 66), Size = UDim2.fromOffset(900, 40), FontFace = Fonts_upv_1.Title, TextColor3 = Colors_upv_1.TextDim, Parent = u1})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2.5, 0.1).Parent = u5
    local u6 = 0
    local function slamY()
        --[[
          name: slamY
          line: 67
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 0.3
        end
        return 0.36
    end
    local function subPos()
        --[[
          name: subPos
          line: 70
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return (UDim2.new(0.5, 0, 0.3, 52))
        end
        return (UDim2.new(0.5, 0, 0.36, 66))
    end
    local u7 = false
    local u8 = 0
    local u9 = u5:FindFirstChildOfClass("UIStroke")
    local tbl_upv_2 = {}
    local function stopFades(...)
        --[[
          name: stopFades
          line: 89
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local tbl_3 = {...}
        for _, value_1 in tbl_3 do
            local v1 = tbl_upv_2[value_1]
            if not (v1) then
                continue
            end
            for v2, value_2 in v1 do
                value_2:Cancel()
            end
            table.clear(v1)
        end
    end
    local function fadeTo(a2, a3, a4, a5)
        --[[
          name: fadeTo
          line: 81
          upvalues:
            tbl_upv_2 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v2 = tbl_upv_2[a2]
        if not (v2) then
            v2 = {}
            tbl_upv_2[a2] = v2
        end
        table.insert(v2, UI_upv_1.Tween(a2, TweenInfo.new(a5), {[a3] = a4}))
    end
    local function pinSub(a6, a7)
        --[[
          name: pinSub
          line: 100
          upvalues:
            u8 (ref,  index: 1)
            u5 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u7 (ref,  index: 4)
            stopFades (copy, index: 5)
            u9 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            fadeTo (copy, index: 9)
        ]]
        u8 = u8 + 1
        local _ = u8
        if a6 then
            u5.TextColor3 = a7 or (Colors_upv_1.TextDim)
            if not (u7) or not (u5.Visible) or u5.Text ~= a6 then
                stopFades(u5, u9)
                u5.Text = a6
                u5.TextTransparency = 0
                u9.Transparency = 0.1
                u5.Visible = true
                local SlideIn_1 = UI_upv_1.SlideIn
                local v3 = Vector2.new(0, 16)
                local Smooth_1 = Theme_upv_1.Tween.Smooth
                local v4
                if UI_upv_1.Compact then
                    v4 = UDim2.new(0.5, 0, 0.3, 52)
                else
                    v4 = UDim2.new(0.5, 0, 0.36, 66)
                end
                SlideIn_1(u5, v3, Smooth_1, v4)
            end
            u7 = true
        elseif u7 then
            u7 = false
            fadeTo(u5, "TextTransparency", 1, 0.2)
            fadeTo(u9, "Transparency", 1, 0.2)
            task.delay(0.21, function() end)
        end
    end
    local function showSlam(a8, a9, a10, a11, a12)
        --[[
          name: showSlam
          line: 125
          upvalues:
            u6 (ref,  index: 1)
            stopFades (copy, index: 2)
            u2 (copy, index: 3)
            u3 (copy, index: 4)
            u5 (copy, index: 5)
            u9 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u4 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            u7 (ref,  index: 10)
            Colors_upv_1 (copy, index: 11)
            fadeTo (copy, index: 12)
        ]]
        u6 = u6 + 1
        local u10 = u6
        stopFades(u2, u3, u5, u9)
        u2.Text = a8
        u2.TextColor3 = a9
        u2.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.3) or 0.36)
        local v5 = ((a12 ~= false) and 1.2) or 0.84
        u2.TextTransparency = 0
        u3.Transparency = 0
        u2.Visible = true
        u4.Scale = v5 * 1.8
        UI_upv_1.Tween(u4, Theme_upv_1.Tween.Slam, {Scale = v5})
        if not (u7) then
            u5.Visible = a10 ~= nil
            if a10 then
                u5.Text = a10
                u5.TextColor3 = Colors_upv_1.TextDim
                u5.TextTransparency = 0
                u9.Transparency = 0.1
                local SlideIn_2 = UI_upv_1.SlideIn
                local v6 = Vector2.new(0, 16)
                local Smooth_2 = Theme_upv_1.Tween.Smooth
                local v7
                if UI_upv_1.Compact then
                    v7 = UDim2.new(0.5, 0, 0.3, 52)
                else
                    v7 = UDim2.new(0.5, 0, 0.36, 66)
                end
                SlideIn_2(u5, v6, Smooth_2, v7)
            end
        end
        task.delay(
            a11 or 0.8,
            function()
                --[[
                  line: 148
                  upvalues:
                    u10 (copy, index: 1)
                    u6 (ref,  index: 2)
                    fadeTo (copy, index: 3)
                    u2 (copy, index: 4)
                    u3 (copy, index: 5)
                    u7 (ref,  index: 6)
                    u5 (copy, index: 7)
                    u9 (copy, index: 8)
                ]]
                if u10 ~= u6 then
                    return
                end
                fadeTo(u2, "TextTransparency", 1, 0.25)
                fadeTo(u3, "Transparency", 1, 0.25)
                if not (u7) then
                    fadeTo(u5, "TextTransparency", 1, 0.25)
                    fadeTo(u9, "Transparency", 1, 0.25)
                end
                task.delay(
                    0.26,
                    function()
                        --[[
                          line: 158
                          upvalues:
                            u10 (copy, index: 1)
                            u6 (ref,  index: 2)
                            u2 (copy, index: 3)
                            u7 (ref,  index: 4)
                            u5 (copy, index: 5)
                        ]]
                        if u10 ~= u6 then
                            return
                        end
                        u2.Visible = false
                        if (u7) then
                            return
                        end
                        u5.Visible = false
                    end
                )
            end
        )
    end
    local function hideSlam()
        --[[
          name: hideSlam
          line: 168
          upvalues:
            u6 (ref,  index: 1)
            stopFades (copy, index: 2)
            u2 (copy, index: 3)
            u3 (copy, index: 4)
            u7 (ref,  index: 5)
            u5 (copy, index: 6)
        ]]
        u6 = u6 + 1
        stopFades(u2, u3)
        u2.Visible = false
        if (u7) then
            return
        end
        u5.Visible = false
    end
    local u11 = nil
    local u12 = 0
    local tbl_upv_4 = {}
    local function setFade(a13, a14)
        --[[
          name: setFade
          line: 206
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        for key_1, value_3 in tbl_upv_4[a13] or {} do
            for key_2, value_4 in value_3 do
                key_1[key_2] = value_4 + ((1 - value_4) * a14)
            end
        end
    end
    local TribeEmblem_upv_1 = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem_upv_1.Init(UI_upv_1)
    local u13 = {}
    local _ = Color3.fromRGB(255, 214, 110)
    local function recordLook(a15)
        --[[
          name: recordLook
          line: 183
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        local tbl_5 = {}
        local v8 = a15:GetDescendants()
        table.insert(v8, a15)
        for _, value_5 in v8 do
            local tbl_6 = {}
            if value_5:IsA("GuiObject") and value_5.BackgroundTransparency < 1 then
                tbl_6.BackgroundTransparency = value_5.BackgroundTransparency
            end
            if not (value_5:IsA("TextLabel")) and not (value_5:IsA("TextButton")) or not (value_5.TextTransparency < 1) then
                if not (value_5:IsA("ImageLabel")) and not (value_5:IsA("ViewportFrame")) or not (value_5.ImageTransparency < 1) then
                    if value_5:IsA("UIStroke") and value_5.Transparency < 1 then
                        tbl_6.Transparency = value_5.Transparency
                    end
                    if next(tbl_6) then
                        tbl_5[value_5] = tbl_6
                        continue
                    end
                end
                tbl_6.ImageTransparency = value_5.ImageTransparency
                if next(tbl_6) then
                    tbl_5[value_5] = tbl_6
                    continue
                end
            end
            tbl_6.TextTransparency = value_5.TextTransparency
            if next(tbl_6) then
                tbl_5[value_5] = tbl_6
            end
        end
        tbl_upv_4[a15] = tbl_5
    end
    local function buildIntro()
        --[[
          name: buildIntro
          line: 219
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            TribeEmblem_upv_1 (copy, index: 6)
            u13 (ref,  index: 7)
            recordLook (copy, index: 8)
        ]]
        local v9 = UI_upv_1.new("Frame", {Visible = false, Name = "Intro", Size = UDim2.fromScale(1, 1), Parent = u1})
        for n_1 = 1, 2 do
            local v10
            if n_1 ~= 1 then
                v10 = Colors_upv_1.Enemy
            else
                v10 = Colors_upv_1.Ally
            end
            local new_1 = UI_upv_1.new
            local tbl_7 = {}
            tbl_7.Name = ((n_1 ~= 1) and "Right") or "Left"
            tbl_7.AnchorPoint = Vector2.new(((n_1 ~= 1) and 1) or 0, 0)
            tbl_7.Position = UDim2.fromScale(((n_1 ~= 1) and 1) or 0, 0)
            tbl_7.Size = UDim2.fromScale(0.5, 1)
            tbl_7.BackgroundColor3 = Color3.new(1, 1, 1)
            tbl_7.BackgroundTransparency = 0.08
            tbl_7.ClipsDescendants = true
            local Gradient_1 = UI_upv_1.Gradient
            local v11 = Theme_upv_1.Darken(v10, 0.45)
            local v12 = Theme_upv_1.Darken(v10, 0.82)
            tbl_7[1] = Gradient_1(v11, v12, ((n_1 ~= 1) and 180) or 0)
            tbl_7.Parent = v9
            local v13 = new_1("Frame", tbl_7)
            local v14 = UI_upv_1.new("Frame", {Name = "Content", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromOffset(560, 380), Parent = v13})
            v13 = UI_upv_1.DisplayText({StrokeThickness = 4, Name = "Tribe", Text = "WOLF", TextSize = 76, Size = UDim2.new(1, 0, 0, 80), TextColor3 = Theme_upv_1.Lighten(v10, 0.3), Parent = v14})
            v13 = UI_upv_1.new("TextLabel", {Name = "Tag", Text = "3 V 3", TextSize = 22, Position = UDim2.fromOffset(0, 80), Size = UDim2.new(1, 0, 0, 30), FontFace = Fonts_upv_1.Title, TextColor3 = Colors_upv_1.TextDim, Parent = v14})
            UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.3).Parent = v13
            v13 = UI_upv_1.new("Frame", {Name = "Fighters", Position = UDim2.fromOffset(0, 130), Size = UDim2.new(1, 0, 0, 220), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 18, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top), Parent = v14})
            for n_2 = 1, 3 do
                local v15 = UI_upv_1.new("Frame", {Name = "F" .. n_2, Size = UDim2.fromOffset(150, 210), LayoutOrder = n_2, Parent = v13})
                local v16 = UI_upv_1.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), Parent = v15})
                local tbl_8 = {}
                tbl_8.Name = "Img"
                tbl_8.Size = UDim2.fromOffset(150, 150)
                tbl_8.BackgroundColor3 = Theme_upv_1.Darken(v10, 0.6)
                tbl_8.BackgroundTransparency = 0.1
                tbl_8.ScaleType = Enum.ScaleType.Crop
                tbl_8[1], tbl_8[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(v10, 3, 0)
                tbl_8.Parent = v16
                v15 = UI_upv_1.new("ImageLabel", tbl_8)
                local v17 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", TextSize = 21, Position = UDim2.fromOffset(-10, 156), Size = UDim2.new(1, 20, 0, 26), FontFace = Fonts_upv_1.Heavy, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v16})
                UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.2).Parent = v17
                local _ = UI_upv_1.new("TextLabel", {Name = "Sub", Text = "", TextSize = 15, Position = UDim2.fromOffset(0, 182), Size = UDim2.new(1, 0, 0, 20), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = v16})
            end
        end
        local _ = UI_upv_1.DisplayText({StrokeThickness = 6, Text = "VS", Name = "VS", ZIndex = 3, TextSize = 110, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Size = UDim2.fromOffset(240, 140), TextColor3 = Colors_upv_1.Text, Parent = v9})
        local tbl_9 = {}
        tbl_9.Name = "Map"
        tbl_9.AnchorPoint = Vector2.new(0.5, 1)
        tbl_9.Position = UDim2.new(0.5, 0, 1, -40)
        tbl_9.Size = UDim2.fromOffset(760, 176)
        tbl_9.BackgroundColor3 = Colors_upv_1.Void
        tbl_9.BackgroundTransparency = 0.2
        tbl_9.ZIndex = 3
        tbl_9[1], tbl_9[2] = UI_upv_1.Corner(14), UI_upv_1.Stroke(Colors_upv_1.Stroke, 2, 0.6)
        tbl_9.Parent = v9
        local v18 = UI_upv_1.new("Frame", tbl_9)
        UI_upv_1.new("ImageLabel", {Name = "Thumb", Position = UDim2.fromOffset(9, 9), Size = UDim2.fromOffset(280, 158), BackgroundColor3 = Colors_upv_1.Raised, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 1, ZIndex = 3, [1] = UI_upv_1.Corner(10), Parent = v18})
        local v19 = UI_upv_1.new("TextLabel", {Text = "", Name = "MapName", ZIndex = 3, TextSize = 38, Position = UDim2.fromOffset(306, 14), Size = UDim2.new(1, -322, 0, 40), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = v18})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = v19
        UI_upv_1.new("TextLabel", {Text = "3V3 \194\183 FIRST TO 5 ROUNDS", Name = "Mode", ZIndex = 3, TextSize = 18, Position = UDim2.fromOffset(306, 56), Size = UDim2.new(1, -322, 0, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = v18})
        UI_upv_1.new("TextLabel", {Text = "", ZIndex = 3, TextWrapped = true, Name = "Tip", TextSize = 19, Position = UDim2.fromOffset(306, 88), Size = UDim2.new(1, -322, 0, 70), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v18})
        local v20 = UI_upv_1.new("Frame", {Visible = false, Name = "Clash", ZIndex = 4, Size = UDim2.fromScale(1, 1), Parent = v9})
        v18 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Rays, {ImageTransparency = 1, Name = "Rays", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(620, 620), ImageColor3 = Color3.fromRGB(255, 205, 110), Parent = v20})
        tbl_9 = {}
        for n_3 = 1, 2 do
            tbl_9[n_3] = TribeEmblem_upv_1.new(140, {ZIndex = 5, Parent = UI_upv_1.new("Frame", {Name = "Crest" .. n_3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(140, 151), ZIndex = 5, [1] = UI_upv_1.new("UIScale", {Name = "Fit"}), Parent = v20})})
        end
        local v23 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Flare, {ImageTransparency = 1, Name = "Flare", ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(1100, 120), ImageColor3 = Color3.fromRGB(255, 220, 150), Parent = v20})
        local v24 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Ring, {ImageTransparency = 1, Name = "Ring", ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(60, 60), ImageColor3 = Color3.fromRGB(255, 214, 140), Parent = v20})
        for n_4 = 1, 8 do
            UI_upv_1.Image(UI_upv_1.Assets.Fx.Spark, {ImageTransparency = 1, ZIndex = 6, Name = "Spark" .. n_4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(96, 18), ImageColor3 = Color3.fromRGB(255, 226, 160), Parent = v20})
        end
        local v21 = UI_upv_1.DisplayText({StrokeThickness = 5, Text = "TRIBE CLASH", Name = "Title", ZIndex = 7, TextSize = 84, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromOffset(900, 100), TextColor3 = Color3.fromRGB(255, 214, 110), Parent = v20})
        UI_upv_1.Gradient(Color3.fromRGB(255, 236, 170), Color3.fromRGB(240, 170, 50), 90).Parent = v21
        local v22 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", ZIndex = 7, TextSize = 22, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.1, 50), Size = UDim2.fromOffset(900, 26), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v20})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.25).Parent = v22
        UI_upv_1.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 8, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(255, 206, 120), Parent = v20})
        u13 = tbl_9
        recordLook((v20:FindFirstChild("Crest" .. 1)))
        recordLook((v20:FindFirstChild("Crest" .. 2)))
        recordLook(v21)
        recordLook((v9:FindFirstChild("VS")))
        recordLook((v9:FindFirstChild("Map")))
        local tbl_10 = {v9:FindFirstChild("Left"), v9:FindFirstChild("Right")}
        for v25, value_6 in tbl_10 do
            for n_5 = 1, 3 do
                recordLook((value_6:FindFirstChild("Content"):FindFirstChild("Fighters"):FindFirstChild("F" .. n_5):FindFirstChild("Inner")))
            end
        end
        return v9
    end
    local function teamTribe(a16)
        --[[
          name: teamTribe
          line: 432
        ]]
        local tbl_11 = {}
        local v23 = nil
        local v24
        if type(a16) == "table" and type(a16.members) == "table" then
            v24 = a16.members
        else
            v24 = {}
        end
        for _, value_7 in v24 do
            local tribe_1 = value_7.tribe
            if type(tribe_1) ~= "table" or type(tribe_1.id) ~= "number" then
                continue
            end
            tbl_11[tribe_1.id] = (tbl_11[tribe_1.id] or 0) + 1
            if tbl_11[tribe_1.id] >= 2 then
                v23 = tribe_1
            end
        end
        return v23
    end
    local function fillIntro(a17, a18)
        --[[
          name: fillIntro
          line: 447
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            teamTribe (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Tribes_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            Portraits_upv_1 (copy, index: 8)
            Tips_upv_1 (copy, index: 9)
            u13 (ref,  index: 10)
        ]]
        local v25 = ((type(a18.teams) == "table") and (a18.teams)) or (((State_upv_1.Match) and (State_upv_1.Match.teams)) or {})
        local v26 = State_upv_1.MyTeam()
        local v27 = State_upv_1.TeamSize(v25)
        local v28 = v27 == 1
        local v29, v30 = nil, nil
        if v28 then
            v29 = State_upv_1.IsDuel()
            if v29 then
                v30 = v29
            else
                local v31 = true
                if a18.mode == "1v1" then
                    v30 = v31
                else
                    local v32 = a1.Custom and a1.Custom.IsServer and a1.Custom.IsServer()
                    v30 = not v32
                end
            end
        else
            v30 = v28
        end
        local Map_1 = ((not v28) and 150) or (((UI_upv_1.Compact) and 160) or 204)
        local tbl_12 = {teamTribe(v25[v26]), teamTribe(v25[3 - v26])}
        local v33 = (tbl_12[1] ~= nil) and ((tbl_12[2] ~= nil) and (tbl_12[1].id ~= tbl_12[2].id))
        a17:SetAttribute("Clash", v33)
        local v34 = nil
        local v35 = nil
        local v36 = nil
        local v37 = nil
        local _ = nil
        local v52 = nil
        local v38 = nil
        local v39 = nil
        local v53 = nil
        for key_3, value_8 in {v26, 3 - v26} do
            v34 = a17:FindFirstChild(((key_3 ~= 1) and "Right") or "Left")
            local Content_1 = v34:FindFirstChild("Content")
            local v40 = v25[value_8] or {}
            local Tribe_1 = Content_1:FindFirstChild("Tribe")
            if key_3 ~= 1 then
                v35 = Colors_upv_1.Enemy
            else
                v35 = Colors_upv_1.Ally
            end
            if v33 then
                v36 = Tribes_upv_1.Color(tbl_12[key_3].color1)
            else
                v36 = v35
            end
            local v41 = v34:FindFirstChildOfClass("UIGradient")
            if v41 then
                v41.Color = ColorSequence.new(Theme_upv_1.Darken(v36, 0.45), Theme_upv_1.Darken(v36, 0.82))
            end
            Tribe_1.AutoLocalize = not v33
            if v33 then
                v37 = string.upper(tostring(tbl_12[key_3].name or (tbl_12[key_3].tag)))
            elseif v30 then
                v37 = ((key_3 ~= 1) and "OPPONENT") or "YOU"
            else
                v37 = ((key_3 ~= 1) and "ENEMY TEAM") or "YOUR TEAM"
            end
            Tribe_1.Text = v37
            Tribe_1.TextColor3 = Theme_upv_1.Lighten(v36, 0.3)
            local Tag_1 = Content_1:FindFirstChild("Tag")
            if Tag_1 then
                if Tag_1:GetAttribute("Default") == nil then
                    Tag_1:SetAttribute("Default", Tag_1.Text)
                end
                v36 = tbl_12[key_3]
                if v33 then
                    local str_1 = tostring(v36.tag)
                    Tag_1.Text = "[" .. str_1 .. "]  \194\183  " .. (((key_3 ~= 1) and "ENEMY TRIBE") or "YOUR TRIBE")
                    Tag_1.TextColor3 = Theme_upv_1.Lighten(v35, 0.35)
                else
                    if v36 then
                        v37 = "TRIBE  [" .. tostring(v36.tag) .. "]"
                    elseif v27 == 3 then
                        v37 = tostring(Tag_1:GetAttribute("Default"))
                    else
                        v37 = string.format("%d V %d", v27, v27)
                    end
                    Tag_1.Text = v37
                    if v36 then
                        v37 = Tribes_upv_1.TextColor(v36.color1)
                    else
                        v37 = Colors_upv_1.TextDim
                    end
                    Tag_1.TextColor3 = v37
                end
            end
            local Fighters_1 = Content_1:FindFirstChild("Fighters")
            Map_1 = nil
            for n_6 = 1, 3 do
                local v42 = Fighters_1:FindFirstChild("F" .. n_6)
                local Inner_1 = v42:FindFirstChild("Inner")
                Content_1 = ((type(v40.members) == "table") and (v40.members[n_6])) or nil
                if Content_1 ~= nil then
                    v38 = true
                else
                    v38 = false
                end
                v42.Visible = v38
                v42.Size = UDim2.fromOffset(Map_1, Map_1 + 60)
                local Img_1 = Inner_1:FindFirstChild("Img")
                Img_1.Size = UDim2.fromOffset(Map_1, Map_1)
                v34 = Img_1:FindFirstChildOfClass("UIStroke")
                if v34 then
                    v34.Thickness = (v28 and 4) or 3
                end
                v34 = Inner_1:FindFirstChild("Name")
                v34.Position = UDim2.fromOffset(-10, Map_1 + 6)
                v34.TextSize = (v28 and 25) or 21
                v34.Size = UDim2.new(1, 20, 0, (v28 and 30) or 26)
                v34 = Inner_1:FindFirstChild("Sub")
                v34.Position = UDim2.fromOffset(0, Map_1 + ((v28 and 36) or 32))
                v34.TextSize = (v28 and 16) or 15
                if not (Content_1) then
                    continue
                end
                Portraits_upv_1.Apply(Img_1, Content_1, (v28 and 420) or 150)
                v34 = Inner_1:FindFirstChild("Name")
                if type(Content_1.tribe) ~= "table" or type(Content_1.tribe.tag) ~= "string" then
                    v39 = ""
                    v34.Text = v39 .. tostring(Content_1.name or "?")
                    if Content_1.id ~= State_upv_1.MyId() then
                        v38 = Colors_upv_1.Text
                    else
                        v38 = Colors_upv_1.Accent
                    end
                    v34.TextColor3 = v38
                    v34 = Inner_1:FindFirstChild("Sub")
                    v34.Text = "LEVEL " .. tostring(Content_1.level or 1)
                end
                v39 = "[" .. Content_1.tribe.tag .. "] "
                v34.Text = v39 .. tostring(Content_1.name or "?")
                if Content_1.id ~= State_upv_1.MyId() then
                    v38 = Colors_upv_1.Text
                else
                    v38 = Colors_upv_1.Accent
                end
                v34.TextColor3 = v38
                v34 = Inner_1:FindFirstChild("Sub")
                v34.Text = "LEVEL " .. tostring(Content_1.level or 1)
            end
        end
        Map_1 = a17:FindFirstChild("Map")
        local MapName_1 = Map_1:FindFirstChild("MapName")
        MapName_1.Text = string.upper(tostring(a18.mapName or (((State_upv_1.Match) and (State_upv_1.Match.mapName)) or "ARENA")))
        local Thumb_upv_1 = Map_1:FindFirstChild("Thumb")
        v28 = a18.mapThumb or (State_upv_1.Match and (State_upv_1.Match.mapThumb))
        local v43 = UI_upv_1.Compact
        MapName_1 = (v43 and 200) or 280
        local v44 = (v43 and 112) or 158
        Map_1.Size = UDim2.fromOffset((v43 and 640) or 760, v44 + 18)
        Map_1.Position = UDim2.new(0.5, 0, 1, (v43 and -14) or -40)
        Thumb_upv_1.Size = UDim2.fromOffset(MapName_1, v44)
        local v45
        if type(v28) ~= "string" then
            v45 = ""
        else
            v45 = v28
        end
        Thumb_upv_1.Image = v45
        Thumb_upv_1.Visible = Thumb_upv_1.Image ~= ""
        if Thumb_upv_1.Visible then
            if Thumb_upv_1.IsLoaded then
                Thumb_upv_1.ImageTransparency = 0
            else
                Thumb_upv_1.ImageTransparency = 1
                task.spawn(
                    function()
                        --[[
                          line: 543
                          upvalues:
                            a1 (copy, index: 1)
                            Thumb_upv_1 (copy, index: 2)
                            UI_upv_1 (copy, index: 3)
                            Theme_upv_1 (copy, index: 4)
                        ]]
                        a1.PreloadThumb(Thumb_upv_1.Image, true)
                        if Thumb_upv_1.Image == "" then
                            return
                        end
                        UI_upv_1.Tween(Thumb_upv_1, Theme_upv_1.Tween.Smooth, {ImageTransparency = 0})
                    end
                )
            end
        end
        local Visible_1 = Thumb_upv_1.Visible
        v25 = (Visible_1 and (MapName_1 + 26)) or 16
        local v46 = nil
        for v54, value_9 in {"MapName", "Mode", "Tip"} do
            local v47 = Map_1:FindFirstChild(value_9)
            v47.Position = UDim2.fromOffset(v25, v47.Position.Y.Offset)
            v47.Size = UDim2.new(1, -(v25 + 16), 0, v47.Size.Y.Offset)
            if Visible_1 then
                v46 = Enum.TextXAlignment.Left
            else
                v46 = Enum.TextXAlignment.Center
            end
            v47.TextXAlignment = v46
        end
        local Tip_1 = Map_1:FindFirstChild("Tip")
        Tip_1.Text = "TIP  \194\183  " .. Tips_upv_1.Next()
        Tip_1.Size = UDim2.new(1, -(v25 + 16), 0, v44 - 80)
        Tip_1.TextSize = (v43 and 17) or 19
        local v48 = tonumber(a18 and (a18.roundsToWin)) or (State_upv_1.RoundsToWin())
        v28 = a18 and (a18.holder)
        if type(v28) == "table" and type(v28.tag) == "string" then
            v43 = "  \194\183  HELD BY [" .. v28.tag .. "]"
        else
            v43 = ""
        end
        local Mode_1 = Map_1:FindFirstChild("Mode")
        Mode_1.Text = string.format("%dV%d  \194\183  BEST OF %d%s", v27, v27, (v48 * 2) - 1, v43)
        local Clash_1 = a17:FindFirstChild("Clash")
        Clash_1.Visible = v33
        if v33 then
            Map_1 = tbl_12[1]
            u13[1]:Set(Map_1.icon, Map_1.color1, Map_1.color2, Map_1.tag)
            local v49 = tbl_12[2]
            u13[2]:Set(v49.icon, v49.color1, v49.color2, v49.tag)
            local v50 = string.upper(tostring(a18.mapName or (((State_upv_1.Match) and (State_upv_1.Match.mapName)) or "this map")))
            local Sub_1 = Clash_1:FindFirstChild("Sub")
            local v51 = a1.Custom and (a1.Custom.IsServer and (a1.Custom.IsServer()))
            if v51 then
                Sub_1.Text = "CUSTOM MATCH  \194\183  NO GLORY AT STAKE"
            else
                if type(a18) == "table" and (a18.id == tbl_12[1].id or a18.id == tbl_12[2].id) then
                    Sub_1.Text = ("[%*] DEFENDS %*"):format(a18.tag, v50)
                    return
                end
                if type(a18) ~= "table" then
                    Sub_1.Text = ("GLORY DECIDES WHO HOLDS %*"):format(v50)
                else
                    Sub_1.Text = ("%*  \194\183  HELD BY [%*]"):format(v50, a18.tag)
                end
            end
        end
    end
    local u14 = nil
    local function lookLock(a19)
        --[[
          name: lookLock
          line: 597
          upvalues:
            u14 (ref,  index: 1)
            ReplicatedStorage_upv_1 (copy, index: 2)
        ]]
        if u14 == nil then
            local Camera_upv_1 = ReplicatedStorage_upv_1:WaitForChild("Shared"):FindFirstChild("Camera")
            local success_1, v52 = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        Camera_upv_1 (copy, index: 1)
                    ]]
                    if Camera_upv_1 then
                        return (require(Camera_upv_1))
                    end
                    return nil
                end
            )
            local v53
            if (success_1) and type(v52) == "table" then
                v53 = v52
            else
                v53 = false
            end
            u14 = v53
        end
        if not u14 or not u14.PushLookLock then
            return
        end
        if a19 then
            u14.PushLookLock("Intro")
        else
            u14.PopLookLock("Intro")
        end
    end
    local function c01(a20)
        --[[
          name: c01
          line: 622
        ]]
        return (math.clamp(a20, 0, 1))
    end
    local function quadIn(a21)
        --[[
          name: quadIn
          line: 625
        ]]
        return a21 * a21
    end
    local function quadOut(a22)
        --[[
          name: quadOut
          line: 628
        ]]
        return 1 - ((1 - a22) * (1 - a22))
    end
    local function quartOut(a23)
        --[[
          name: quartOut
          line: 631
        ]]
        return 1 - ((1 - a23) ^ 4)
    end
    local function quintOut(a24)
        --[[
          name: quintOut
          line: 634
        ]]
        return 1 - ((1 - a24) ^ 5)
    end
    local function backOut(a25)
        --[[
          name: backOut
          line: 637
        ]]
        local v54 = a25 - 1
        return ((((v54 * 2.70158) * v54) * v54) + 1) + ((v54 * 1.70158) * v54)
    end
    local function lerp(a26, a27, a28)
        --[[
          name: lerp
          line: 641
        ]]
        return a26 + ((a27 - a26) * a28)
    end
    local function clashLook(a29, a30, a31, a32)
        --[[
          name: clashLook
          line: 655
          upvalues:
            UI_upv_1 (copy, index: 1)
            u13 (ref,  index: 2)
            setFade (copy, index: 3)
        ]]
        local Clash_2 = a29:FindFirstChild("Clash")
        local Compact_1 = UI_upv_1.Compact
        local v55 = (Compact_1 and 0.085) or 0.4
        local v56 = (Compact_1 and 28) or 56
        local v57 = (Compact_1 and 232) or 80
        local function vis_1(a33)
            --[[
              name: vis
              line: 660
              upvalues:
                a31 (copy, index: 1)
            ]]
            return 1 - ((1 - a33) * (1 - a31))
        end
        local v58 = a30 - 0.45
        local v59 = nil
        for n_7 = 1, 2 do
            local v60 = Clash_2:FindFirstChild("Crest" .. n_7)
            local v61 = ((n_7 ~= 1) and 1) or -1
            local v62 = UDim2.new((v61 * 0.62) + 0.5, 0, v55, 0)
            local v63 = UDim2.new(0.5, v61 * v56, v55, 0)
            local v64 = UDim2.new(0.5, v61 * v57, v55, 0)
            if v58 < 0 then
                v59 = math.clamp((a30 - 0.09) / 0.36, 0, 1)
                local v65 = v59 * v59
                v60.Position = v62:Lerp(v63, v65)
                v60.Rotation = (v61 * 18) * (1 - v65)
            else
                v60.Position = v63:Lerp(v64, 1 - ((1 - math.clamp(v58 / 0.45, 0, 1)) ^ 5))
                v60.Rotation = 0
            end
            local Fit_1 = v60:FindFirstChild("Fit")
            Fit_1.Scale = (Compact_1 and 0.5) or 1
            local v66 = UI_upv_1.GetScaleObj(u13[n_7].Instance)
            if v58 < 0 then
                v59 = 1
            else
                local v67 = math.clamp(v58 / 0.35, 0, 1) - 1
                v59 = (((((v67 * 2.70158) * v67) * v67) + 1) + ((v67 * 1.70158) * v67)) * -0.17999999999999994 + 1.18
            end
            v66.Scale = v59
            setFade(v60, a31)
        end
        local Flash_1 = Clash_2:FindFirstChild("Flash")
        local v68
        if v58 < 0 then
            v68 = 1
        else
            local v69 = math.clamp(v58 / 0.32, 0, 1)
            v68 = 1 - (1 - (((1 - ((1 - v69) * (1 - v69))) * 0.5) + 0.5)) * (1 - a31)
        end
        Flash_1.BackgroundTransparency = v68
        local Ring_1 = Clash_2:FindFirstChild("Ring")
        local v70 = 1 - (1 - math.clamp(v58 / 0.55, 0, 1)) ^ 4
        v68 = (Compact_1 and 380) or 640
        Ring_1.Position = UDim2.fromScale(0.5, v55)
        Ring_1.Size = UDim2.fromOffset(((v68 - 60) * v70) + 60, ((v68 - 60) * v70) + 60)
        Ring_1.ImageTransparency = ((v58 < 0) and 1) or (1 - (1 - ((v70 * 0.95) + 0.05)) * (1 - a31))
        v68 = Clash_2:FindFirstChild("Flare")
        local v71 = 1 - (1 - math.clamp(v58 / 0.5, 0, 1)) ^ 4
        v68.Position = UDim2.fromScale(0.5, v55)
        v68.Size = UDim2.fromOffset((v71 * 1060) + 240, (v71 * 40) + 90)
        v68.ImageTransparency = ((v58 < 0) and 1) or (1 - (1 - v71) * (1 - a31))
        for key_4, value_10 in a32.sparks do
            v68 = Clash_2:FindFirstChild("Spark" .. key_4)
            v71 = 1 - (1 - math.clamp(v58 / value_10.dur, 0, 1)) ^ 4
            local v72 = value_10.d * ((Compact_1 and 0.6) or 1) * v71
            v68.Rotation = math.deg(value_10.a)
            v68.Position = UDim2.new(0.5, math.cos(value_10.a) * v72, v55, math.sin(value_10.a) * v72)
            v68.Size = UDim2.fromOffset((v71 * -70) + 110, (v71 * -10) + 18)
            v68.ImageTransparency = ((v58 < 0) and 1) or (1 - (1 - v71) * (1 - a31))
        end
        local v73 = Vector2.zero
        if v58 >= 0 and v58 < 0.14 then
            local v74 = {Vector2.new(10, -6), Vector2.new(-8, 5), Vector2.new(5, 3), Vector2.new(-3, -2)}
            v73 = v74[math.floor(v58 / 0.035) + 1]
        end
        a29.Position = UDim2.fromOffset(v73.X, v73.Y)
        v73 = Clash_2:FindFirstChild("Rays")
        v73.Position = UDim2.fromScale(0.5, v55)
        local v74, v74
        if Compact_1 then
            v74 = UDim2.fromOffset(380, 380)
        else
            v74 = UDim2.fromOffset(620, 620)
        end
        v73.Size = v74
        if v58 < 0 then
            v74 = 1
        else
            local v75 = math.clamp(v58 / 0.6, 0, 1)
            v74 = 1 - (1 - (((1 - ((1 - v75) * (1 - v75))) * 0.20000000000000007) + 0.35)) * (1 - a31)
        end
        v73.ImageTransparency = v74
        v73.Rotation = math.clamp(v58 / 6, 0, 1) * 40
        v73 = Clash_2:FindFirstChild("Title")
        if v58 >= 0 then
            v74 = true
        else
            v74 = false
        end
        v73.Visible = v74
        v73.Position = UDim2.fromScale(0.5, (Compact_1 and 0.085) or 0.1)
        v73.TextSize = (Compact_1 and 54) or 84
        v74 = UI_upv_1.GetScaleObj(v73)
        local v76 = math.clamp(v58 / 0.28, 0, 1) - 1
        v74.Scale = ((((((v76 * 2.70158) * v76) * v76) + 1) + ((v76 * 1.70158) * v76)) * -1.2000000000000002) + 2.2
        setFade(v73, a31)
        v73 = Clash_2:FindFirstChild("Sub")
        v73.Visible = not Compact_1
        v74 = math.clamp((v58 - 0.15) / 0.3, 0, 1)
        local v77 = 1 - (1 - v74) * (1 - v74)
        v73.TextTransparency = 1 - ((1 - (1 - v77)) * (1 - a31))
        local v78 = v73:FindFirstChildOfClass("UIStroke")
        if not v78 then
            return
        end
        v78.Transparency = 1 - ((1 - ((v77 * -0.75) + 1)) * (1 - a31))
    end
    local u15 = nil
    local function stopClash()
        --[[
          name: stopClash
          line: 735
          upvalues:
            u15 (ref, index: 1)
        ]]
        if not u15 then
            return
        end
        u15.conn:Disconnect()
        u15 = nil
    end
    local function newClashState(a34)
        --[[
          name: newClashState
          line: 645
        ]]
        local v79 = a34 or (os.clock() * 1000)
        local v80 = Random.new(v79)
        local tbl_13 = {}
        for n_8 = 1, 8 do
            tbl_13[n_8] = {a = ((((n_8 - 1) / 8) * math.pi) * 2) + v80:NextNumber(-0.25, 0.25), d = v80:NextNumber(170, 260), dur = v80:NextNumber(0.35, 0.5)}
        end
        local tbl_14 = {}
        tbl_14.sparks = tbl_13
        return tbl_14
    end
    local function playClash(a35)
        --[[
          name: playClash
          line: 741
          upvalues:
            u15 (ref,  index: 1)
            newClashState (copy, index: 2)
            a1 (copy, index: 3)
            RunService_upv_1 (copy, index: 4)
            clashLook (copy, index: 5)
        ]]
        if u15 then
            u15.conn:Disconnect()
            u15 = nil
        end
        local u16 = newClashState()
        local u17 = os.clock()
        local u18 = false
        a1.Sounds.Play("UI/Whoosh")
        local tbl_upv_15 = {}
        tbl_upv_15.conn = RunService_upv_1.RenderStepped:Connect(
            function()
                --[[
                  line: 748
                  upvalues:
                    u17 (copy, index: 1)
                    u18 (ref,  index: 2)
                    a1 (copy, index: 3)
                    tbl_upv_15 (copy, index: 4)
                    clashLook (copy, index: 5)
                    a35 (copy, index: 6)
                    u16 (copy, index: 7)
                    u15 (ref,  index: 8)
                ]]
                local v81 = os.clock()
                local v82 = v81 - u17
                if not (u18) and v82 >= 0.45 then
                    u18 = true
                    a1.Sounds.Play("Match/Tribe_Clash")
                end
                local v83 = ((not (tbl_upv_15.outAt)) and 0) or (math.clamp((v81 - tbl_upv_15.outAt) / 0.2, 0, 1))
                clashLook(a35, v82, v83, u16)
                if not (v83 >= 1) or not u15 then
                    return
                end
                u15.conn:Disconnect()
                u15 = nil
            end
        )
        u15 = tbl_upv_15
        clashLook(a35, 0, 0, u16)
    end
    local function hideIntro(a36)
        --[[
          name: hideIntro
          line: 765
          upvalues:
            u12 (ref,  index: 1)
            lookLock (copy, index: 2)
            u11 (ref,  index: 3)
            a1 (copy, index: 4)
            u15 (ref,  index: 5)
            UI_upv_1 (copy, index: 6)
        ]]
        u12 = u12 + 1
        lookLock(false)
        local u19 = u11
        if not u19 or not u19.Visible then
            return
        end
        a1.SetHudHidden("Intro", false)
        if a36 then
            if u15 then
                u15.conn:Disconnect()
                u15 = nil
            end
            u19.Visible = false
        else
            local u20 = u12
            local Left_1 = u19:FindFirstChild("Left")
            local Right_1 = u19:FindFirstChild("Right")
            UI_upv_1.Tween(Left_1, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.fromScale(-0.55, 0)})
            UI_upv_1.Tween(Right_1, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.fromScale(1.55, 0)})
            UI_upv_1.FadeOut(u19:FindFirstChild("VS"), TweenInfo.new(0.2))
            UI_upv_1.FadeOut(u19:FindFirstChild("Map"), TweenInfo.new(0.2))
            if u15 then
                u15.outAt = os.clock()
            end
            task.delay(
                0.36,
                function()
                    --[[
                      line: 788
                      upvalues:
                        u20 (copy, index: 1)
                        u12 (ref,  index: 2)
                        u19 (copy, index: 3)
                    ]]
                    if u20 ~= u12 then
                        return
                    end
                    u19.Visible = false
                end
            )
        end
    end
    local function showIntro(a37)
        --[[
          name: showIntro
          line: 795
          upvalues:
            u11 (ref,  index: 1)
            buildIntro (copy, index: 2)
            fillIntro (copy, index: 3)
            u12 (ref,  index: 4)
            a1 (copy, index: 5)
            lookLock (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            playClash (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            State_upv_1 (copy, index: 10)
            hideIntro (copy, index: 11)
        ]]
        local v84 = u11 or (buildIntro())
        u11 = v84
        local v85 = u11
        fillIntro(v85, a37)
        u12 = u12 + 1
        local u21 = u12
        v85.Visible = true
        a1.SetHudHidden("Intro", true)
        lookLock(true)
        local v86 = v85:FindFirstChild("Left")
        local Right_2 = v85:FindFirstChild("Right")
        v86.Position = UDim2.fromScale(-0.55, 0)
        Right_2.Position = UDim2.fromScale(1.55, 0)
        UI_upv_1.Tween(v86, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(0, 0)})
        UI_upv_1.Tween(Right_2, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(1, 0)})
        local VS_upv_1 = v85:FindFirstChild("VS")
        UI_upv_1.Unfade(VS_upv_1)
        VS_upv_1.Visible = false
        if v85:GetAttribute("Clash") ~= true then
            task.delay(
                0.35,
                function()
                    --[[
                      line: 816
                      upvalues:
                        u21 (copy, index: 1)
                        u12 (ref,  index: 2)
                        VS_upv_1 (copy, index: 3)
                        UI_upv_1 (copy, index: 4)
                        Theme_upv_1 (copy, index: 5)
                    ]]
                    if u21 ~= u12 then
                        return
                    end
                    VS_upv_1.Visible = true
                    UI_upv_1.Pop(VS_upv_1, 2.4, Theme_upv_1.Tween.Slam)
                end
            )
        else
            playClash(v85)
        end
        local v87 = v85:FindFirstChild("Map")
        UI_upv_1.Unfade(v87)
        UI_upv_1.Enter(v87, Vector2.new(0, 40), 0.5)
        for n_9 = 1, 2 do
            if n_9 ~= 1 then
                v87 = Right_2
            else
                v87 = v86
            end
            local Fighters_2 = v87:FindFirstChild("Content"):FindFirstChild("Fighters")
            for n_10 = 1, 3 do
                local Inner_2 = Fighters_2:FindFirstChild("F" .. n_10):FindFirstChild("Inner")
                UI_upv_1.Unfade(Inner_2)
                UI_upv_1.Enter(Inner_2, Vector2.new(0, 30), (n_10 * 0.08) + 0.2, UDim2.new())
            end
        end
        local v88 = (((State_upv_1.Match) and (State_upv_1.Match.phase == "Intro")) and (State_upv_1.Match.phaseEndsAt)) or 0
        if v88 > 0 then
            v86 = math.clamp(v88 - State_upv_1.Now(), 1.5, 6)
        else
            v86 = 4
        end
        task.delay(
            v86 - 0.3,
            function()
                --[[
                  line: 840
                  upvalues:
                    u21 (copy, index: 1)
                    u12 (ref,  index: 2)
                    hideIntro (copy, index: 3)
                ]]
                if u21 ~= u12 then
                    return
                end
                hideIntro()
            end
        )
    end
    local u22 = nil
    a1.Debug.introScrub = function(a38, a39, a40)
        --[[
          line: 852
          upvalues:
            u15 (ref,  index: 1)
            u12 (ref,  index: 2)
            u11 (ref,  index: 3)
            buildIntro (copy, index: 4)
            fillIntro (copy, index: 5)
            u22 (ref,  index: 6)
            newClashState (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            setFade (copy, index: 9)
            clashLook (copy, index: 10)
            a1 (copy, index: 11)
        ]]
        if type(a38) == "table" then
            if u15 then
                u15.conn:Disconnect()
                u15 = nil
            end
            u12 = u12 + 1
            local v89 = u11 or (buildIntro())
            u11 = v89
            fillIntro(u11, a38)
            u11.Visible = true
            u22 = newClashState(7)
        end
        if not u11 or type(a39) ~= "number" then
            return false
        end
        local v90
        if type(a40) ~= "number" then
            v90 = 3
        else
            v90 = a40
        end
        local v91 = v90 - 0.3
        local v92 = u11:GetAttribute("Clash") == true
        local v93 = 1 - (1 - math.clamp(a39 / 0.45, 0, 1)) ^ 5
        local v94 = math.clamp((a39 - v91) / 0.35, 0, 1)
        local v95 = v94 * v94
        local Left_2 = u11:FindFirstChild("Left")
        Left_2.Position = UDim2.fromScale(((v93 * 0.55) + -0.55) - (v95 * 0.55), 0)
        local Right_3 = u11:FindFirstChild("Right")
        Right_3.Position = UDim2.fromScale(((v93 * -0.55) + 1.55) + (v95 * 0.55), 0)
        v95 = math.clamp((a39 - v91) / 0.2, 0, 1)
        v93 = u11:FindFirstChild("VS")
        v93.Visible = not v92 and (a39 >= 0.35)
        local v96 = UI_upv_1.GetScaleObj(v93)
        local v97 = math.clamp((a39 - 0.35) / 0.28, 0, 1) - 1
        v96.Scale = ((((((v97 * 2.70158) * v97) * v97) + 1) + ((v97 * 1.70158) * v97)) * -1.4) + 2.4
        setFade(v93, v95)
        v93 = u11:FindFirstChild("Map")
        local v98 = ((UI_upv_1.Compact) and -14) or -40
        local v99 = math.clamp((a39 - 0.5) / 0.36, 0, 1) - 1
        v93.Position = UDim2.new(0.5, 0, 1, v98 + ((1 - (((((v99 * 2.70158) * v99) * v99) + 1) + ((v99 * 1.70158) * v99))) * 40))
        local v100 = math.clamp((a39 - 0.5) / 0.2, 0, 1)
        local v101 = math.max(1 - (1 - (1 - v100) * (1 - v100)), v95)
        setFade(v93, v101)
        v95 = v93:FindFirstChild("Thumb")
        if v95.Image ~= "" then
            v95.ImageTransparency = v101
        end
        for n_11 = 1, 2 do
            v95 = u11:FindFirstChild(((n_11 ~= 1) and "Right") or "Left"):FindFirstChild("Content"):FindFirstChild("Fighters")
            for n_12 = 1, 3 do
                local Inner_3 = v95:FindFirstChild("F" .. n_12):FindFirstChild("Inner")
                local v102 = n_12 * 0.08 + 0.2
                local v103 = math.clamp((a39 - v102) / 0.36, 0, 1) - 1
                Inner_3.Position = UDim2.fromOffset(0, (1 - (((((v103 * 2.70158) * v103) * v103) + 1) + ((v103 * 1.70158) * v103))) * 30)
                local v104 = math.clamp((a39 - v102) / 0.2, 0, 1)
                setFade(Inner_3, 1 - (1 - ((1 - v104) * (1 - v104))))
            end
        end
        if (v92) and (u22) then
            clashLook(u11, a39, math.clamp((a39 - v91) / 0.2, 0, 1), u22)
        else
            u11.Position = UDim2.new()
        end
        u11.Visible = a39 < (v90 + 0.06)
        a1.SetHudHidden("Intro", a39 < v91)
        return true
    end
    local u23 = 8
    local u24 = ReplicatedStorage_upv_1:FindFirstChild("Shared") and (ReplicatedStorage_upv_1.Shared:FindFirstChild("Config"))
    local success_2, v105 = pcall(
        function()
            --[[
              line: 918
              upvalues:
                u24 (copy, index: 1)
            ]]
            if u24 then
                return (require(u24))
            end
            return nil
        end
    )
    if success_2 and type(v105) == "table" and type(v105.PRE_ROUND_TIME) == "number" then
        u23 = math.clamp(math.floor(v105.PRE_ROUND_TIME), 3, 9)
    end
    local new_upv_2 = UI_upv_1.new
    local tbl_16 = {Name = "Countdown", Position = 0, Parent = 0, Visible = false, Size = 0}
    tbl_16.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_16.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.3) or 0.36)
    tbl_16.Size = UDim2.fromOffset(700, 200)
    tbl_16.Parent = u1
    new_upv_2 = new_upv_2("Frame", tbl_16)
    local function cdLabel(a41, a42)
        --[[
          name: cdLabel
          line: 934
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            new_upv_2 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local v106 = UI_upv_1.new("TextLabel", {Visible = false, TextTransparency = 1, Text = "", TextSize = 100, Name = a41, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(700, 130), FontFace = Fonts_upv_1.Display, TextColor3 = a42, Parent = new_upv_2})
        local v107 = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 1)
        v107.Parent = v106
        local tbl_17 = {a = 0, y = 0, s = 1, on = false, text = ""}
        tbl_17.label = v106
        tbl_17.stroke = v107
        tbl_17.scale = UI_upv_1.new("UIScale", {Name = "Scale", Parent = v106})
        return tbl_17
    end
    local u25 = cdLabel("DigitOdd", Colors_upv_1.Bone)
    local u26 = cdLabel("DigitEven", Colors_upv_1.Bone)
    local tbl_upv_18 = {}
    tbl_upv_18[1] = tostring(1)
    tbl_upv_18[2] = tostring(2)
    tbl_upv_18[3] = tostring(3)
    tbl_upv_18[4] = tostring(4)
    tbl_upv_18[5] = tostring(5)
    tbl_upv_18[6] = tostring(6)
    tbl_upv_18[7] = tostring(7)
    tbl_upv_18[8] = tostring(8)
    tbl_upv_18[9] = tostring(9)
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 958
              upvalues:
                new_upv_2 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
            ]]
            new_upv_2.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.3) or 0.36)
        end
    )
    local u27 = cdLabel("Fight", Colors_upv_1.Accent)
    u27.label.Text = "FIGHT!"
    u27.text = "FIGHT!"
    local function cdBase()
        --[[
          name: cdBase
          line: 995
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 1.5
        end
        return 1.8
    end
    local function outBack(a43)
        --[[
          name: outBack
          line: 998
        ]]
        local v108 = a43 - 1
        return ((((v108 * 2.5) * v108) * v108) + 1) + ((v108 * 1.5) * v108)
    end
    local function outCubic(a44)
        --[[
          name: outCubic
          line: 1003
        ]]
        local v109 = 1 - a44
        return 1 - ((v109 * v109) * v109)
    end
    local function fightLook(a45)
        --[[
          name: fightLook
          line: 1023
        ]]
        if not (a45 < 0) and not (a45 >= 1) then
            if a45 < 0.2 then
                local v110 = a45 / 0.2 - 1
                return math.min(1, a45 / 0.05), 1.6 - ((((((v110 * 2.5) * v110) * v110) + 1) + ((v110 * 1.5) * v110)) * 0.6), 0
            else
                if a45 < 0.72 then
                    return 1, 1, 0
                end
                local v111 = (a45 - 0.72) / 0.28
                local v112 = 1 - v111
                return 1 - (v111 * v111), ((1 - ((v112 * v112) * v112)) * 0.12) + 1, 0
            end
        end
        return 0, 1, 0
    end
    local function digitStyle(a46)
        --[[
          name: digitStyle
          line: 1035
        ]]
        if a46 > 3 then
            return 0.8, 0.82
        end
        return 1, 1
    end
    local u28 = nil
    local u29 = 0
    local u30 = 1
    local u31 = false
    local u32 = 0
    local u33 = 0
    local u34 = false
    local function cdClear()
        --[[
          name: cdClear
          line: 1049
          upvalues:
            u25 (copy, index: 1)
            u26 (copy, index: 2)
            u27 (copy, index: 3)
            new_upv_2 (copy, index: 4)
        ]]
        if u25.on then
            u25.on = false
            u25.label.Visible = false
        end
        if u26.on then
            u26.on = false
            u26.label.Visible = false
        end
        if u27.on then
            u27.on = false
            u27.label.Visible = false
        end
        new_upv_2.Visible = false
    end
    local function cdStop(a47)
        --[[
          name: cdStop
          line: 1055
          upvalues:
            u28 (ref,  index: 1)
            u31 (ref,  index: 2)
            u34 (ref,  index: 3)
            a1 (copy, index: 4)
            u25 (copy, index: 5)
            u26 (copy, index: 6)
            u27 (copy, index: 7)
            new_upv_2 (copy, index: 8)
            u7 (ref,  index: 9)
            u8 (ref,  index: 10)
            stopFades (copy, index: 11)
            u5 (copy, index: 12)
            u9 (copy, index: 13)
            fadeTo (copy, index: 14)
        ]]
        if u28 and u31 and not (u34) and a1.Decider then
            a1.Decider.Stop(false)
        end
        u28 = nil
        if u25.on then
            u25.on = false
            u25.label.Visible = false
        end
        if u26.on then
            u26.on = false
            u26.label.Visible = false
        end
        if u27.on then
            u27.on = false
            u27.label.Visible = false
        end
        new_upv_2.Visible = false
        if a47 then
            u7 = false
            u8 = u8 + 1
            stopFades(u5, u9)
            u5.Visible = false
        else
            u8 = u8 + 1
            local _ = u8
            if u7 then
                u7 = false
                fadeTo(u5, "TextTransparency", 1, 0.2)
                fadeTo(u9, "Transparency", 1, 0.2)
                task.delay(0.21, function() end)
            end
        end
    end
    local function cdBegin(a48, a49, a50)
        --[[
          name: cdBegin
          line: 1070
          upvalues:
            u28 (ref,  index: 1)
            u29 (ref,  index: 2)
            u30 (ref,  index: 3)
            u32 (ref,  index: 4)
            u33 (ref,  index: 5)
            u34 (ref,  index: 6)
            u31 (ref,  index: 7)
            a1 (copy, index: 8)
            State_upv_1 (copy, index: 9)
            u6 (ref,  index: 10)
            stopFades (copy, index: 11)
            u2 (copy, index: 12)
            u3 (copy, index: 13)
            u7 (ref,  index: 14)
            u5 (copy, index: 15)
            u25 (copy, index: 16)
            u26 (copy, index: 17)
            u27 (copy, index: 18)
            new_upv_2 (copy, index: 19)
        ]]
        u28 = a48
        u29 = a50
        u30 = a49
        u32 = 0
        u33 = 0
        u34 = false
        local v113 = (a1.Decider ~= nil) and (a1.Decider.IsDecider(State_upv_1.Match))
        u31 = v113
        u6 = u6 + 1
        stopFades(u2, u3)
        u2.Visible = false
        if not (u7) then
            u5.Visible = false
        end
        if u25.on then
            u25.on = false
            u25.label.Visible = false
        end
        if u26.on then
            u26.on = false
            u26.label.Visible = false
        end
        if u27.on then
            u27.on = false
            u27.label.Visible = false
        end
        new_upv_2.Visible = false
    end
    local function cdOnShow()
        --[[
          name: cdOnShow
          line: 1082
          upvalues:
            u31 (ref,  index: 1)
            a1 (copy, index: 2)
            u30 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            pinSub (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
        ]]
        if u31 then
            a1.Decider.Intro(u30)
        else
            local Match_1 = State_upv_1.Match
            local v114 = State_upv_1.RoundsToWin()
            local v115 = false
            if Match_1 then
                v115 = ((v114 - 1 <= (Match_1.teams[2].score or 0)) and true) or (v114 - 1 <= (Match_1.teams[1].score or 0)) and true
            end
            local v116
            if v115 then
                v116 = "MATCH POINT"
            else
                v116 = "ROUND " .. u30
            end
            local v117
            if v115 then
                v117 = Colors_upv_1.Warning
            else
                v117 = Colors_upv_1.TextDim
            end
            pinSub(v116, v117)
        end
    end
    local function digitLook(a51)
        --[[
          name: digitLook
          line: 1011
        ]]
        if a51 < 0 then
            return 0, 1, 0
        elseif a51 < 0.2 then
            local v118 = a51 / 0.2 - 1
            return math.min(1, a51 / 0.06), 1.4 - ((((((v118 * 2.5) * v118) * v118) + 1) + ((v118 * 1.5) * v118)) * 0.4), 0
        else
            if a51 < 0.84 then
                return 1, 1 - (((a51 - 0.2) * 0.03) / 0.6399999999999999), 0
            end
            local v119 = math.min(1, (a51 - 0.84) / 0.22)
            local v120 = 1 - v119
            local v121 = 1 - v119
            return 1 - (v119 * v119), 0.97 - ((1 - ((v120 * v120) * v120)) * 0.2), (1 - ((v121 * v121) * v121)) * -14
        end
    end
    local function put(a52, a53, a54, a55, a56)
        --[[
          name: put
          line: 964
        ]]
        local v122 = nil
        if a54 <= 0.004 then
            if a52.on then
                a52.on = false
                a52.label.Visible = false
            end
        else
            if a52.text ~= a53 then
                a52.text = a53
                a52.label.Text = a53
            end
            if math.abs(a52.a - a54) > 0.003 or not (a52.on) then
                a52.a = a54
                a52.label.TextTransparency = 1 - a54
                a52.stroke.Transparency = 1 - (a54 * 0.85)
            end
            if math.abs(a52.s - a55) > 8e-04 or not (a52.on) then
                a52.s = a55
                a52.scale.Scale = a55
            end
            v122 = math.floor(a56 + 0.5)
            if a52.y ~= v122 or not (a52.on) then
                a52.y = v122
                a52.label.Position = UDim2.new(0.5, 0, 0.5, v122)
            end
            if not (a52.on) then
                a52.on = true
                a52.label.Visible = true
            end
        end
    end
    local function cdFrame()
        --[[
          name: cdFrame
          line: 1099
          upvalues:
            State_upv_1 (copy, index: 1)
            u28 (ref,  index: 2)
            u30 (ref,  index: 3)
            u29 (ref,  index: 4)
            u32 (ref,  index: 5)
            u33 (ref,  index: 6)
            u34 (ref,  index: 7)
            u31 (ref,  index: 8)
            a1 (copy, index: 9)
            u6 (ref,  index: 10)
            stopFades (copy, index: 11)
            u2 (copy, index: 12)
            u3 (copy, index: 13)
            u7 (ref,  index: 14)
            u5 (copy, index: 15)
            u25 (copy, index: 16)
            u26 (copy, index: 17)
            u27 (copy, index: 18)
            new_upv_2 (copy, index: 19)
            cdStop (copy, index: 20)
            u11 (ref,  index: 21)
            cdOnShow (copy, index: 22)
            u23 (ref,  index: 23)
            u8 (ref,  index: 24)
            fadeTo (copy, index: 25)
            u9 (copy, index: 26)
            UI_upv_1 (copy, index: 27)
            digitLook (copy, index: 28)
            put (copy, index: 29)
            tbl_upv_18 (copy, index: 30)
        ]]
        local v123, v124, v125 = State_upv_1.PhaseClock()
        if v123 == "PreRound" then
            local v126 = nil
            if v124 > 0 then
                v126 = State_upv_1.Get("MatchId") or "?"
                if v126 ~= u28 or v125 ~= u30 or math.abs(v124 - u29) > 0.05 then
                    u28 = v126
                    u29 = v124
                    u30 = v125
                    u32 = 0
                    u33 = 0
                    u34 = false
                    local v127 = (a1.Decider ~= nil) and (a1.Decider.IsDecider(State_upv_1.Match))
                    u31 = v127
                    u6 = u6 + 1
                    stopFades(u2, u3)
                    u2.Visible = false
                    if not (u7) then
                        u5.Visible = false
                    end
                    if u25.on then
                        u25.on = false
                        u25.label.Visible = false
                    end
                    if u26.on then
                        u26.on = false
                        u26.label.Visible = false
                    end
                    if u27.on then
                        u27.on = false
                        u27.label.Visible = false
                    end
                    new_upv_2.Visible = false
                end
            end
        end
        if not u28 then
            return
        end
        local v128 = u29 - State_upv_1.Now()
        if v123 ~= "PreRound" and v123 ~= "Live" then
            cdStop()
            return
        end
        if v128 < -1.05 then
            cdStop()
        else
            if u11 and u11.Visible then
                u32 = 0
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                return
            end
            if u32 == 0 then
                u32 = os.clock()
                cdOnShow()
            end
            v124 = math.min(1, (os.clock() - u32) / 0.15)
            local v129 = ((not (v128 > 0)) and 0) or (math.ceil(v128))
            if v129 ~= u33 and v129 >= 1 and v129 <= u23 then
                u33 = v129
                if u31 then
                    a1.Decider.Digit(v129)
                end
            end
            if v128 <= 0 and not (u34) then
                u34 = true
                u8 = u8 + 1
                local u35 = u8
                if u7 then
                    u7 = false
                    fadeTo(u5, "TextTransparency", 1, 0.2)
                    fadeTo(u9, "Transparency", 1, 0.2)
                    task.delay(
                        0.21,
                        function()
                            --[[
                              line: 118
                              upvalues:
                                u35 (copy, index: 1)
                                u8 (ref,  index: 2)
                                u7 (ref,  index: 3)
                                u5 (copy, index: 4)
                            ]]
                            if u35 ~= u8 or (u7) then
                                return
                            end
                            u5.Visible = false
                        end
                    )
                end
                if u31 then
                    a1.Decider.Fight()
                end
            end
            local v130 = nil
            if u31 then
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
            else
                if not (new_upv_2.Visible) then
                    new_upv_2.Visible = true
                end
                local v131 = ((UI_upv_1.Compact) and 1.5) or 1.8
                for n_13 = v129, v129 + 1 do
                    local v132
                    if n_13 % 2 ~= 1 then
                        v132 = u26
                    else
                        v132 = u25
                    end
                    if (not (n_13 >= 1) or not (n_13 <= u23)) and v132.on then
                        v132.on = false
                        v132.label.Visible = false
                    end
                    local v133, v134, v135 = digitLook(n_13 - v128)
                    local v136, v137
                    if n_13 > 3 then
                        v137 = 0.8
                        v136 = 0.82
                    else
                        v136, v137 = 1, 1
                    end
                    put(v132, tbl_upv_18[n_13], (v133 * v136) * v124, (v131 * v137) * v134, v135 * v131)
                end
                v130 = -v128
                local v138, v139, v140
                if v130 < 0 or v130 >= 1 then
                    v138, v139, v140 = 0, 1, 0
                elseif v130 < 0.2 then
                    local v141 = math.min(1, v130 / 0.05)
                    local v142 = v130 / 0.2 - 1
                    v138, v139, v140 = v141, 1.6 - (((((v142 * 2.5) * v142) * v142) + 1) + ((v142 * 1.5) * v142)) * 0.6, 0
                elseif v130 < 0.72 then
                    v138, v139, v140 = 1, 1, 0
                else
                    local v143 = (v130 - 0.72) / 0.28
                    local v144 = 1 - v143 * v143
                    local v145 = 1 - v143
                    v138, v139, v140 = v144, (1 - ((v145 * v145) * v145)) * 0.12 + 1, 0
                end
                put(u27, "FIGHT!", v138 * v124, ((((UI_upv_1.Compact) and 0.9) or 1) * 1.2) * v139, v140)
            end
        end
    end
    local u36 = nil
    local function cdWatch()
        --[[
          name: cdWatch
          line: 1165
          upvalues:
            State_upv_1 (copy, index: 1)
            u36 (ref,  index: 2)
            RunService_upv_1 (copy, index: 3)
            cdFrame (copy, index: 4)
            u28 (ref,  index: 5)
            u31 (ref,  index: 6)
            u34 (ref,  index: 7)
            a1 (copy, index: 8)
            u25 (copy, index: 9)
            u26 (copy, index: 10)
            u27 (copy, index: 11)
            new_upv_2 (copy, index: 12)
            u7 (ref,  index: 13)
            u8 (ref,  index: 14)
            stopFades (copy, index: 15)
            u5 (copy, index: 16)
            u9 (copy, index: 17)
        ]]
        local v146 = State_upv_1.SeesMatch()
        if v146 and not (u36) then
            u36 = RunService_upv_1.RenderStepped:Connect(cdFrame)
            return
        end
        if (v146) then
            return
        end
        if u36 then
            u36:Disconnect()
            u36 = nil
            if u28 and u31 and not (u34) and a1.Decider then
                a1.Decider.Stop(false)
            end
            u28 = nil
            if u25.on then
                u25.on = false
                u25.label.Visible = false
            end
            if u26.on then
                u26.on = false
                u26.label.Visible = false
            end
            if u27.on then
                u27.on = false
                u27.label.Visible = false
            end
            new_upv_2.Visible = false
            u7 = false
            u8 = u8 + 1
            stopFades(u5, u9)
            u5.Visible = false
        end
    end
    local v147 = State_upv_1.SeesMatch()
    if not (v147) or u36 then
        if not (v147) and u36 then
            u36:Disconnect()
            u36 = nil
            if u28 and u31 and not (u34) and a1.Decider then
                a1.Decider.Stop(false)
            end
            u28 = nil
            if u25.on then
                u25.on = false
                u25.label.Visible = false
            end
            if u26.on then
                u26.on = false
                u26.label.Visible = false
            end
            if u27.on then
                u27.on = false
                u27.label.Visible = false
            end
            new_upv_2.Visible = false
            u7 = false
            u8 = u8 + 1
            stopFades(u5, u9)
            u5.Visible = false
        end
    else
        u36 = RunService_upv_1.RenderStepped:Connect(cdFrame)
    end
    local u37 = UI_upv_1.new("Frame", {Name = "Elimination", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromOffset(600, 90), Parent = u1})
    local u38 = UI_upv_1.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), Parent = u37})
    local u39 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Skull, {Name = "Skull", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Enemy, Parent = u38})
    local u40 = UI_upv_1.DisplayText({StrokeThickness = 2.5, Name = "Title", Text = "ELIMINATED", TextSize = 32, Position = UDim2.fromOffset(0, 34), Size = UDim2.new(1, 0, 0, 34), TextColor3 = Colors_upv_1.Enemy, Parent = u38})
    local u41 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Victim", TextSize = 22, Position = UDim2.fromOffset(0, 66), Size = UDim2.new(1, 0, 0, 24), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = u38})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = u41
    local u42 = 0
    local u43 = 0
    local u44 = 0
    local tbl_upv_19 = {}
    tbl_upv_19[2] = "DOUBLE ELIMINATION"
    tbl_upv_19[3] = "TRIPLE ELIMINATION"
    local function showElim(a57, a58)
        --[[
          name: showElim
          line: 1221
          upvalues:
            u42 (ref,  index: 1)
            u44 (ref,  index: 2)
            u43 (ref,  index: 3)
            u40 (copy, index: 4)
            tbl_upv_19 (copy, index: 5)
            u41 (copy, index: 6)
            a1 (copy, index: 7)
            u37 (copy, index: 8)
            UI_upv_1 (copy, index: 9)
            u38 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            u39 (copy, index: 12)
        ]]
        u42 = u42 + 1
        local u45 = u42
        local v148 = os.clock()
        local v149 = ((v148 - u43 <= 4) and (u44 + 1)) or 1
        u44 = v149
        u43 = v148
        u40.Text = tbl_upv_19[u44] or (((u44 >= 3) and "TRIPLE ELIMINATION") or "ELIMINATED")
        local v150 = string.upper(a57)
        local v151 = (a58 and ("  \194\183  " .. a1.Loc.T("HEADSHOT"))) or ""
        u41.Text = v150 .. v151
        u37.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.54) or 0.6)
        u37.Visible = true
        UI_upv_1.Unfade(u38)
        UI_upv_1.SlideIn(u38, Vector2.new(0, 14), Theme_upv_1.Tween.PopSmall, UDim2.new())
        UI_upv_1.Pop(u39, 1.6)
        task.delay(
            1.8,
            function()
                --[[
                  line: 1234
                  upvalues:
                    u45 (copy, index: 1)
                    u42 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u38 (copy, index: 4)
                    u37 (copy, index: 5)
                ]]
                if u45 ~= u42 then
                    return
                end
                UI_upv_1.FadeOut(u38, TweenInfo.new(0.3))
                task.delay(
                    0.32,
                    function()
                        --[[
                          line: 1239
                          upvalues:
                            u45 (copy, index: 1)
                            u42 (ref,  index: 2)
                            u37 (copy, index: 3)
                        ]]
                        if u45 ~= u42 then
                            return
                        end
                        u37.Visible = false
                    end
                )
            end
        )
    end
    a1.OnMatchEvent(
        function(a59, a60)
            --[[
              line: 1248
              upvalues:
                u28 (ref,  index: 1)
                u31 (ref,  index: 2)
                u34 (ref,  index: 3)
                a1 (copy, index: 4)
                u25 (copy, index: 5)
                u26 (copy, index: 6)
                u27 (copy, index: 7)
                new_upv_2 (copy, index: 8)
                u7 (ref,  index: 9)
                u8 (ref,  index: 10)
                stopFades (copy, index: 11)
                u5 (copy, index: 12)
                u9 (copy, index: 13)
                showIntro (copy, index: 14)
                hideIntro (copy, index: 15)
                u6 (ref,  index: 16)
                u2 (copy, index: 17)
                u3 (copy, index: 18)
                showSlam (copy, index: 19)
                Colors_upv_1 (copy, index: 20)
                State_upv_1 (copy, index: 21)
                showElim (copy, index: 22)
                u12 (ref,  index: 23)
                lookLock (copy, index: 24)
                u11 (ref,  index: 25)
                u15 (ref,  index: 26)
            ]]
            if type(a60) ~= "table" then
                local tbl_20 = {}
                a60 = tbl_20
            end
            if a59 == "MatchStart" then
                if u28 and u31 and not (u34) and a1.Decider then
                    a1.Decider.Stop(false)
                end
                u28 = nil
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                u7 = false
                u8 = u8 + 1
                stopFades(u5, u9)
                u5.Visible = false
                showIntro(a60)
            elseif a59 == "RoundStart" then
                hideIntro()
            elseif a59 == "RoundEnd" then
                if u28 and u31 and not (u34) and a1.Decider then
                    a1.Decider.Stop(false)
                end
                u28 = nil
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                u7 = false
                u8 = u8 + 1
                stopFades(u5, u9)
                u5.Visible = false
                u6 = u6 + 1
                stopFades(u2, u3)
                u2.Visible = false
                if not (u7) then
                    u5.Visible = false
                    return
                end
            elseif a59 == "Overtime" then
                showSlam("OVERTIME", Colors_upv_1.Danger, "THE RING OF FIRE IS CLOSING", 2.2, false)
                return
            elseif a59 == "Elimination" then
                local v152 = a1.PlayerGui:FindFirstChild("CombatHUD") ~= nil
                if a60.killerId == State_upv_1.MyId() and a60.victimId ~= State_upv_1.MyId() and not (v152) then
                    local str_2 = tostring(a60.victimName or "?")
                    showElim(str_2, a60.headshot == true)
                    return
                end
            elseif a59 == "Replaced" then
                a1.Toast(string.format("%s left \194\183 %s joined", tostring(a60.name or "A fighter"), tostring(a60.botName or "a new fighter")), "info")
                return
            elseif a59 == "MatchEnd" then
                if u28 and u31 and not (u34) and a1.Decider then
                    a1.Decider.Stop(false)
                end
                u28 = nil
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                u7 = false
                u8 = u8 + 1
                stopFades(u5, u9)
                u5.Visible = false
                u12 = u12 + 1
                lookLock(false)
                local v153 = u11
                if v153 and v153.Visible then
                    a1.SetHudHidden("Intro", false)
                    if u15 then
                        u15.conn:Disconnect()
                        u15 = nil
                    end
                    u11.Visible = false
                end
            end
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function(a61)
            --[[
              line: 1274
              upvalues:
                State_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                lookLock (copy, index: 3)
                u11 (ref,  index: 4)
                a1 (copy, index: 5)
                u15 (ref,  index: 6)
                u6 (ref,  index: 7)
                stopFades (copy, index: 8)
                u2 (copy, index: 9)
                u3 (copy, index: 10)
                u7 (ref,  index: 11)
                u5 (copy, index: 12)
                u36 (ref,  index: 13)
                RunService_upv_1 (copy, index: 14)
                cdFrame (copy, index: 15)
                u28 (ref,  index: 16)
                u31 (ref,  index: 17)
                u34 (ref,  index: 18)
                u25 (copy, index: 19)
                u26 (copy, index: 20)
                u27 (copy, index: 21)
                new_upv_2 (copy, index: 22)
                u8 (ref,  index: 23)
                u9 (copy, index: 24)
            ]]
            if a61 ~= "Match" then
                local v154 = State_upv_1.Watching()
                local v155 = nil
                if not (v154) then
                    u12 = u12 + 1
                    lookLock(false)
                    v155 = u11
                    if v155 and v155.Visible then
                        a1.SetHudHidden("Intro", false)
                        if u15 then
                            u15.conn:Disconnect()
                            u15 = nil
                        end
                        v155.Visible = false
                    end
                    u6 = u6 + 1
                    stopFades(u2, u3)
                    u2.Visible = false
                    if not (u7) then
                        u5.Visible = false
                    end
                end
            end
            local v156 = State_upv_1.SeesMatch()
            if v156 and not (u36) then
                u36 = RunService_upv_1.RenderStepped:Connect(cdFrame)
                return
            end
            if (v156) then
                return
            end
            if u36 then
                u36:Disconnect()
                u36 = nil
                if u28 and u31 and not (u34) and a1.Decider then
                    a1.Decider.Stop(false)
                end
                u28 = nil
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                u7 = false
                u8 = u8 + 1
                stopFades(u5, u9)
                u5.Visible = false
            end
        end
    )
    State_upv_1.WatchChanged:Connect(
        function(a62)
            --[[
              line: 1281
              upvalues:
                State_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                lookLock (copy, index: 3)
                u11 (ref,  index: 4)
                a1 (copy, index: 5)
                u15 (ref,  index: 6)
                u6 (ref,  index: 7)
                stopFades (copy, index: 8)
                u2 (copy, index: 9)
                u3 (copy, index: 10)
                u7 (ref,  index: 11)
                u5 (copy, index: 12)
                u36 (ref,  index: 13)
                RunService_upv_1 (copy, index: 14)
                cdFrame (copy, index: 15)
                u28 (ref,  index: 16)
                u31 (ref,  index: 17)
                u34 (ref,  index: 18)
                u25 (copy, index: 19)
                u26 (copy, index: 20)
                u27 (copy, index: 21)
                new_upv_2 (copy, index: 22)
                u8 (ref,  index: 23)
                u9 (copy, index: 24)
            ]]
            if not (a62) then
                local v157 = State_upv_1.InMatch()
                local v158 = nil
                if not (v157) then
                    u12 = u12 + 1
                    lookLock(false)
                    v158 = u11
                    if v158 and v158.Visible then
                        a1.SetHudHidden("Intro", false)
                        if u15 then
                            u15.conn:Disconnect()
                            u15 = nil
                        end
                        v158.Visible = false
                    end
                    u6 = u6 + 1
                    stopFades(u2, u3)
                    u2.Visible = false
                    if not (u7) then
                        u5.Visible = false
                    end
                end
            end
            local v159 = State_upv_1.SeesMatch()
            if v159 and not (u36) then
                u36 = RunService_upv_1.RenderStepped:Connect(cdFrame)
                return
            end
            if (v159) then
                return
            end
            if u36 then
                u36:Disconnect()
                u36 = nil
                if u28 and u31 and not (u34) and a1.Decider then
                    a1.Decider.Stop(false)
                end
                u28 = nil
                if u25.on then
                    u25.on = false
                    u25.label.Visible = false
                end
                if u26.on then
                    u26.on = false
                    u26.label.Visible = false
                end
                if u27.on then
                    u27.on = false
                    u27.label.Visible = false
                end
                new_upv_2.Visible = false
                u7 = false
                u8 = u8 + 1
                stopFades(u5, u9)
                u5.Visible = false
            end
        end
    )
    a1.Debug.banner = function(a63, a64)
        --[[
          line: 1289
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        State_upv_1.MatchEvent:Fire(a63, a64 or {})
        return true
    end
    a1.Debug.countdown = function(a65)
        --[[
          line: 1295
          upvalues:
            u28 (ref,  index: 1)
            u31 (ref,  index: 2)
            u34 (ref,  index: 3)
            a1 (copy, index: 4)
            u25 (copy, index: 5)
            u26 (copy, index: 6)
            u27 (copy, index: 7)
            new_upv_2 (copy, index: 8)
            u7 (ref,  index: 9)
            u8 (ref,  index: 10)
            stopFades (copy, index: 11)
            u5 (copy, index: 12)
            u9 (copy, index: 13)
            State_upv_1 (copy, index: 14)
            u33 (ref,  index: 15)
        ]]
        if a65 == "restart" then
            if u28 and u31 and not (u34) and a1.Decider then
                a1.Decider.Stop(false)
            end
            u28 = nil
            if u25.on then
                u25.on = false
                u25.label.Visible = false
            end
            if u26.on then
                u26.on = false
                u26.label.Visible = false
            end
            if u27.on then
                u27.on = false
                u27.label.Visible = false
            end
            new_upv_2.Visible = false
            u7 = false
            u8 = u8 + 1
            stopFades(u5, u9)
            u5.Visible = false
        end
        local v160, v161 = State_upv_1.PhaseClock()
        local tbl_21 = {sub = 0, left = 0, digit = 0, running = 0, fight = 0, even = 0, odd = 0, fought = 0, decider = 0}
        tbl_21.phase = v160
        tbl_21.left = v161 > 0 and v161 - State_upv_1.Now() or 0
        tbl_21.running = u28 ~= nil
        tbl_21.digit = u33
        tbl_21.decider = u31
        tbl_21.fought = u34
        local v164
        if u25.on then
            v164 = u25.text
        else
            v164 = false
        end
        tbl_21.odd = v164
        local v165
        if u26.on then
            v165 = u26.text
        else
            v165 = false
        end
        tbl_21.even = v165
        tbl_21.fight = u27.on
        local v166
        if u5.Visible then
            v166 = u5.Text
        else
            v166 = false
        end
        tbl_21.sub = v166
        return tbl_21
    end
end
return tbl_1