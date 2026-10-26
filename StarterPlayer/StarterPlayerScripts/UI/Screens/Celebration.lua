local Lighting_upv_1 = game:GetService("Lighting")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_1 = {}
local u1 = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local tbl_upv_2 = {}
tbl_upv_2.ace = {word = "ACE", style = "stamp", named = true, headS = 2.05, lead = 0}
tbl_upv_2.teamace = {word = "TEAM ACE", style = "stamp", named = false, headS = 1.5, lead = 4}
tbl_upv_2.flawless = {word = "FLAWLESS", style = "shine", named = false, headS = 1.5, lead = 0}
tbl_upv_2.clutch = {word = "CLUTCH", style = "hold", named = true, headS = 1.8, lead = 0}
local v1, v2 = nil, nil
for _, value_1 in tbl_upv_2 do
    local tbl_3 = {}
    v1 = 0
    v2 = 0
    local tbl_4 = {}
    local tbl_5 = {}
    value_1.centres = tbl_4
    value_1.ends = tbl_5
    for n_1 = 1, #value_1.word do
        local v3 = string.sub(value_1.word, n_1, n_1)
        if v3 == " " then
            table.insert(tbl_3, "   ")
            v1 = v1 + 3
            v2 = v2 + 72
            continue
        end
        if (n_1 > 1) and string.sub(value_1.word, n_1 - 1, n_1 - 1) ~= " " then
            table.insert(tbl_3, " ")
            v1 = v1 + 1
            v2 = v2 + 24
        end
        table.insert(tbl_3, v3)
        v1 = v1 + 1
        table.insert(value_1.ends, v1)
        table.insert(value_1.centres, v2 + 21.5)
        v2 = v2 + 43
    end
    value_1.text = table.concat(tbl_3)
    value_1.width = v2
end
local function readMoment(a1)
    --[[
      name: readMoment
      line: 94
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if type(a1) == "table" and type(a1.kind) == "string" and tbl_upv_2[a1.kind] then
        local num_1 = tonumber(a1.team)
        if num_1 ~= 1 and num_1 ~= 2 then
            return nil
        end
        local tbl_6 = {name = 0, vs = 0, id = 0, team = 0}
        tbl_6.kind = a1.kind
        local v4
        if type(a1.id) ~= "string" then
            v4 = nil
        else
            v4 = a1.id
        end
        tbl_6.id = v4
        if type(a1.name) ~= "string" or a1.name == "" then
            v4 = nil
        else
            v4 = string.sub(a1.name, 1, 32)
        end
        tbl_6.name = v4
        tbl_6.team = num_1
        v4 = ((type(a1.vs) ~= "number") and 0) or (math.clamp(math.floor(a1.vs), 0, 9))
        tbl_6.vs = v4
        return tbl_6
    end
    return nil
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 111
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
        Lighting_upv_1 (copy, index: 4)
        RunService_upv_1 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        readMoment (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local v5 = UI_upv_1.Assets.Fx or {}
    local Sfx_upv_1 = ReplicatedStorage_upv_1:WaitForChild("Shared"):FindFirstChild("Sfx")
    local success_1, v6 = pcall(
        function()
            --[[
              line: 120
              upvalues:
                Sfx_upv_1 (copy, index: 1)
            ]]
            if Sfx_upv_1 then
                return (require(Sfx_upv_1))
            end
            return nil
        end
    )
    local u2 = not (success_1) or type(v6) ~= "table" or v6
    local function playSfx(a2, a3)
        --[[
          name: playSfx
          line: 125
          upvalues:
            u2 (ref, index: 1)
        ]]
        if not u2 then
            return
        end
        pcall(u2.Play, a2, nil, a3)
    end
    if u2 and u2.Preload then
        pcall(u2.Preload, {"Match/Elimination", "Kill_Triple", "Kill_Ally", "Match/Final_Round", "Match/Final_Heartbeat", "UI/Card_Reveal"})
    end
    local u3 = 1
    local function tw(a4, a5, a6, a7, a8, a9)
        --[[
          name: tw
          line: 136
          upvalues:
            TweenService_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v7 = a5 * u3
        local v8 = a7 or (Enum.EasingStyle.Quint)
        local v9 = TweenService_upv_1:Create(a4, TweenInfo.new(v7, v8, a8 or (Enum.EasingDirection.Out), 0, false, (a9 or 0) * u3), a6)
        v9:Play()
        return v9
    end
    local function after(a10, a11)
        --[[
          name: after
          line: 141
          upvalues:
            u3 (ref, index: 1)
        ]]
        task.delay(a10 * u3, a11)
    end
    local u4 = UI_upv_1.new("Frame", {Visible = false, Name = "Celebration", ZIndex = 5, Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Overlay})
    local u5 = UI_upv_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = u4})
    local u6 = UI_upv_1.new("Frame", {Name = "Flash", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Ally, Parent = u4})
    local u7 = UI_upv_1.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Image = v5.Vignette or "", ScaleType = Enum.ScaleType.Stretch, Parent = u4})
    local u8 = UI_upv_1.new("Frame", {Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.36), Size = UDim2.fromOffset(0, 0), Parent = u4})
    local u9 = UI_upv_1.new("UIScale", {Name = "StageScale", Parent = u8})
    local u10 = UI_upv_1.new("Frame", {Name = "Shaker", Size = UDim2.fromOffset(0, 0), Parent = u8})
    local u11 = UI_upv_1.new("ImageLabel", {Name = "Glow", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1000, 340), Image = UI_upv_1.Assets.Icons.Glow, Parent = u10})
    local u12 = UI_upv_1.new("ImageLabel", {Name = "Ring", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(100, 100), Image = v5.Ring or "", Parent = u10})
    local u13 = UI_upv_1.new("ImageLabel", {Name = "Band", ImageTransparency = 0.1, ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(0, 150), Image = v5.Band or "", ScaleType = Enum.ScaleType.Stretch, Parent = u10})
    local u14 = UI_upv_1.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.14, 0.04), NumberSequenceKeypoint.new(0.86, 0.04), NumberSequenceKeypoint.new(1, 1)}), Parent = u13})
    local u15 = UI_upv_1.new("ImageLabel", {Name = "GhostBand", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 230), Image = v5.Band or "", ScaleType = Enum.ScaleType.Stretch, Parent = u10})
    UI_upv_1.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.2), NumberSequenceKeypoint.new(0.75, 0.2), NumberSequenceKeypoint.new(1, 1)}), Parent = u15})
    local u16 = UI_upv_1.new("Frame", {Name = "Edge", ZIndex = 3, BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(0, 5), Parent = u10})
    UI_upv_1.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0), NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = u16})
    local function headlineLabel(a12, a13)
        --[[
          name: headlineLabel
          line: 251
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u10 (copy, index: 4)
        ]]
        return UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", TextSize = 100, Name = a12, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1400, 120), FontFace = u1, TextColor3 = Colors_upv_1.Text, ZIndex = a13, Parent = u10})
    end
    local u17 = headlineLabel("Aura", 4)
    local u18 = UI_upv_1.new("UIScale", {Name = "HeadScale", Parent = u17})
    local u19 = headlineLabel("Headline", 5)
    local u20 = UI_upv_1.new("UIScale", {Name = "HeadScale", Parent = u19})
    local u21 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = u19})
    local u22 = headlineLabel("Shadow", 4)
    u22.TextColor3 = Colors_upv_1.Void
    local u23 = UI_upv_1.new("UIScale", {Name = "HeadScale", Parent = u22})
    local u24 = headlineLabel("Sweep", 6)
    local u25 = UI_upv_1.new("UIScale", {Name = "HeadScale", Parent = u24})
    local u26 = UI_upv_1.new("UIGradient", {Rotation = 18, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.44, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.56, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = u24})
    local u27 = UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", Name = "Caption", ZIndex = 6, TextSize = 26, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(700, 32), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u10})
    local u28 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.5)
    u28.Parent = u27
    local u29 = UI_upv_1.new("Frame", {Name = "Score", AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(300, 80), Parent = u10})
    local u30 = UI_upv_1.new("UIScale", {Parent = u29})
    local function digitSlot(a14)
        --[[
          name: digitSlot
          line: 312
          upvalues:
            UI_upv_1 (copy, index: 1)
            u29 (copy, index: 2)
            u1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local u31 = UI_upv_1.new("Frame", {ZIndex = 6, ClipsDescendants = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, a14, 0.5, 0), Size = UDim2.fromOffset(90, 80), Parent = u29})
        local v10 = UI_upv_1.new("UIScale", {Parent = u31})
        local function digit_1()
            --[[
              name: digit
              line: 322
              upvalues:
                UI_upv_1 (copy, index: 1)
                u1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                u31 (copy, index: 4)
            ]]
            return (UI_upv_1.new("TextLabel", {ZIndex = 6, Text = "0", TextSize = 72, Size = UDim2.fromScale(1, 1), FontFace = u1, TextColor3 = Colors_upv_1.Text, Parent = u31}))
        end
        return u31, digit_1(), digit_1(), v10
    end
    local u32, u33, u34, u35 = digitSlot(-76)
    local u36, u37, u38, u39 = digitSlot(76)
    local u40 = UI_upv_1.new("Frame", {Name = "Dash", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(34, 6), BackgroundColor3 = Colors_upv_1.TextDim, ZIndex = 6, [1] = UI_upv_1.Corner(3), Parent = u29})
    local u41 = UI_upv_1.new("Frame", {Name = "Team", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(480, 170), Parent = u10})
    local tbl_upv_7 = {}
    for n_2 = 1, 3 do
        local v11 = UI_upv_1.new("Frame", {ZIndex = 6, Name = "P" .. n_2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, (n_2 - 2) * 150, 0, 0), Size = UDim2.fromOffset(124, 168), Parent = u41})
        local v12 = UI_upv_1.new("ImageLabel", {Name = "Img", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(112, 112), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.1, ScaleType = Enum.ScaleType.Crop, ZIndex = 6, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v11})
        local v13 = UI_upv_1.Stroke(Colors_upv_1.Ally, 3, 0)
        v13.Parent = v12
        local v14 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", ZIndex = 6, TextSize = 20, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 120), Size = UDim2.fromOffset(150, 26), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v11})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = v14
        tbl_upv_7[n_2] = {frame = v11, img = v12, name = v14, star = UI_upv_1.Image(UI_upv_1.Assets.Icons.Star, {Visible = false, Name = "Star", ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 44, 0, 10), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Gold, Parent = v11}), stroke = v13}
        local u42 = n_2
    end
    local u43 = UI_upv_1.new("ImageLabel", {Name = "CeremonyFlare", ImageTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(820, 56), Image = v5.Flare or "", Parent = u10})
    local u44 = UI_upv_1.new("Frame", {Name = "CeremonyPlate", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 66), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 1, Visible = false, ZIndex = 5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u10})
    local u42 = UI_upv_1.Padding(0, 22, 0, 5)
    u42.Parent = u44
    local u45 = UI_upv_1.Stroke(Colors_upv_1.Ally, 2, 1)
    u45.Parent = u44
    UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 14), Parent = u44})
    local tbl_upv_8 = {}
    local function face(a15, a16, a17)
        --[[
          name: face
          line: 449
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
        ]]
        local v15 = UI_upv_1.new("Frame", {ZIndex = 6, Name = "Face" .. a17, Size = UDim2.fromOffset(a16, a16), LayoutOrder = a17, Parent = a15})
        local tbl_9 = {}
        tbl_9.Name = "Img"
        tbl_9.Size = UDim2.fromScale(1, 1)
        tbl_9.BackgroundColor3 = Colors_upv_1.Panel
        tbl_9.BackgroundTransparency = 0.1
        tbl_9.ScaleType = Enum.ScaleType.Crop
        tbl_9.ZIndex = 6
        tbl_9[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_9.Parent = v15
        local v16 = UI_upv_1.new("ImageLabel", tbl_9)
        local v17 = UI_upv_1.Stroke(Colors_upv_1.Ally, 3, 0)
        v17.Parent = v16
        local tbl_10 = {}
        tbl_10.holder = v15
        tbl_10.img = v16
        tbl_10.stroke = v17
        tbl_10.scale = UI_upv_1.new("UIScale", {Parent = v15})
        return tbl_10
    end
    tbl_upv_8[1] = face(u44, 56, 1)
    tbl_upv_8[2] = face(u44, 56, 2)
    tbl_upv_8[3] = face(u44, 56, 3)
    local function vsPill(a18, a19, a20, a21)
        --[[
          name: vsPill
          line: 488
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u1 (copy, index: 4)
        ]]
        local tbl_11 = {}
        tbl_11.Name = "Vs"
        tbl_11.AutomaticSize = Enum.AutomaticSize.X
        tbl_11.Size = UDim2.fromOffset(0, a19)
        tbl_11.BackgroundColor3 = Colors_upv_1.Ally
        tbl_11.BackgroundTransparency = 1
        tbl_11.LayoutOrder = a21
        tbl_11.ZIndex = 6
        tbl_11[1], tbl_11[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 12, 0, 12)
        tbl_11.Parent = a18
        local v18 = UI_upv_1.new("Frame", tbl_11)
        return v18, UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", Name = "Text", ZIndex = 7, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = u1, TextSize = a20, TextColor3 = Colors_upv_1.Text, Parent = v18}), UI_upv_1.new("UIScale", {Parent = v18})
    end
    local function nameLabel(a22, a23, a24)
        --[[
          name: nameLabel
          line: 469
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v19 = UI_upv_1.new("TextLabel", {AutoLocalize = false, TextTransparency = 1, Text = "", Name = "Name", ZIndex = 6, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a23 + 8), FontFace = Fonts_upv_1.Heavy, TextSize = a23, TextColor3 = Colors_upv_1.Text, LayoutOrder = a24, Parent = a22})
        local v20 = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 1)
        v20.Parent = v19
        return v19, v20
    end
    local u46, u47 = nameLabel(u44, 36, 4)
    local u48, u49, u50 = vsPill(u44, 34, 26, 5)
    local u51 = UI_upv_1.new("ImageLabel", {Name = "CeremonyRibbon", ImageTransparency = 1, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 92), Image = v5.Band or "", ScaleType = Enum.ScaleType.Stretch, Parent = u10})
    UI_upv_1.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.16, 0), NumberSequenceKeypoint.new(0.84, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = u51})
    local u52 = UI_upv_1.new("Frame", {Name = "CeremonyAccolade", ZIndex = 6, Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(900, 84), Parent = u10})
    local u53 = UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 20), Parent = u52})
    local u54 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, AutoLocalize = false, TextTransparency = 1, Text = "", Name = "Word", TextSize = 80, ZIndex = 6, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 84), FontFace = u1, TextColor3 = Colors_upv_1.Text, Parent = u52})
    local u55 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = u54})
    local u56 = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 1)
    u56.Parent = u54
    local u57 = UI_upv_1.new("Frame", {Name = "Bar", Size = UDim2.fromOffset(4, 46), BackgroundColor3 = Colors_upv_1.Ally, BackgroundTransparency = 1, LayoutOrder = 2, ZIndex = 6, [1] = UI_upv_1.Corner(2), Parent = u52})
    local u58 = face(u52, 58, 3)
    local u59, u60 = nameLabel(u52, 38, 4)
    local u61, u62, u63 = vsPill(u52, 34, 26, 5)
    local v21 = UI_upv_1.new("Frame", {ZIndex = 7, Name = "Particles", Size = UDim2.fromOffset(0, 0), Parent = u10})
    local u64 = require(script.Parent.Parent.Fx).Pool(v21, 72, 7)
    local u65 = Random.new()
    local function burst(a25, a26, a27, a28, a29, a30)
        --[[
          name: burst
          line: 593
          upvalues:
            u64 (copy, index: 1)
            u3 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v22 = a30 or {}
        u64.Pace = u3
        u64:Burst(a25, {whiteChance = 0.35, mode = "box", box = Vector2.new(a27, a28), speed = a29, color = a26, white = Colors_upv_1.Text, sparkChance = v22.sparkChance or 0.55, grav = v22.grav, drag = v22.drag, base = v22.base, lifeMult = v22.lifeMult})
    end
    local function clearParticles()
        --[[
          name: clearParticles
          line: 610
          upvalues:
            u64 (copy, index: 1)
        ]]
        u64:Clear()
    end
    local u66 = nil
    local u67 = nil
    local function screenFx(a31, a32)
        --[[
          name: screenFx
          line: 617
          upvalues:
            u66 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Lighting_upv_1 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
            u3 (ref,  index: 5)
            u67 (ref,  index: 6)
        ]]
        if not (u66) then
            local v23 = UI_upv_1.new("ColorCorrectionEffect", {Name = "TR_CelebrateCC", Parent = Lighting_upv_1})
            u66 = v23
        end
        local v24 = u66
        v24.Enabled = true
        local v25 = Color3.new(1, 1, 1)
        v24.Brightness = 0
        v24.Contrast = 0
        v24.Saturation = 0
        v24.TintColor = v25
        if a31 == "win" then
            local tbl_12 = {Saturation = 0.18, Contrast = 0.12}
            tbl_12.TintColor = Color3.fromRGB(236, 244, 255)
            TweenService_upv_1:Create(v24, TweenInfo.new(u3 * 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_12):Play()
        elseif a31 ~= "lose" then
            local tbl_13 = {Saturation = -0.3, Brightness = -0.02}
            TweenService_upv_1:Create(v24, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_13):Play()
        else
            local tbl_14 = {Brightness = -0.05, Saturation = -0.65, Contrast = 0.05}
            tbl_14.TintColor = Color3.fromRGB(255, 232, 232)
            TweenService_upv_1:Create(v24, TweenInfo.new(u3 * 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_14):Play()
        end
        if a32 then
            if not (u67) then
                local v26 = UI_upv_1.new("BlurEffect", {Name = "TR_CelebrateBlur", Size = 0, Parent = Lighting_upv_1})
                u67 = v26
            end
            local v27 = u67
            v27.Enabled = true
            v27.Size = 0
            local tbl_15 = {Size = 10}
            TweenService_upv_1:Create(v27, TweenInfo.new(u3 * 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_15):Play()
        end
    end
    local function screenFxOut(a33)
        --[[
          name: screenFxOut
          line: 642
          upvalues:
            u66 (ref,  index: 1)
            TweenService_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            u67 (ref,  index: 4)
        ]]
        if u66 then
            local tbl_16 = {Brightness = 0, Saturation = 0, Contrast = 0}
            tbl_16.TintColor = Color3.new(1, 1, 1)
            TweenService_upv_1:Create(u66, TweenInfo.new(a33 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_16):Play()
        end
        if u67 then
            local tbl_17 = {Size = 0}
            TweenService_upv_1:Create(u67, TweenInfo.new(a33 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_17):Play()
        end
    end
    local function screenFxOff()
        --[[
          name: screenFxOff
          line: 650
          upvalues:
            u66 (ref, index: 1)
            u67 (ref, index: 2)
        ]]
        if u66 then
            u66:Destroy()
            u66 = nil
        end
        if not u67 then
            return
        end
        u67:Destroy()
        u67 = nil
    end
    local u68 = 0
    local u69 = false
    local u70 = false
    local function setDigits(a34, a35, a36, a37)
        --[[
          name: setDigits
          line: 666
        ]]
        a34.Text = tostring(a36)
        a34.Position = UDim2.new()
        a34.TextColor3 = a37
        a34.TextTransparency = 0
        a35.Visible = false
    end
    local function rollDigit(a38, a39, a40, a41, a42, a43)
        --[[
          name: rollDigit
          line: 674
          upvalues:
            TweenService_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        a40.Text = tostring(a42)
        a40.TextColor3 = a43
        a40.Visible = true
        a40.TextTransparency = 0
        a40.Position = UDim2.fromScale(0, 1)
        local tbl_18 = {}
        tbl_18.Position = UDim2.fromScale(0, -1)
        TweenService_upv_1:Create(a39, TweenInfo.new(u3 * 0.28, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_18):Play()
        local tbl_19 = {}
        tbl_19.Position = UDim2.new()
        TweenService_upv_1:Create(a40, TweenInfo.new(u3 * 0.34, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.08 * u3), tbl_19):Play()
        task.delay(
            u3 * 0.42,
            function()
                --[[
                  line: 682
                  upvalues:
                    a39 (copy, index: 1)
                    a42 (copy, index: 2)
                    a43 (copy, index: 3)
                    a40 (copy, index: 4)
                    a41 (copy, index: 5)
                    TweenService_upv_1 (copy, index: 6)
                    u3 (ref,  index: 7)
                ]]
                a39.Text = tostring(a42)
                a39.TextColor3 = a43
                a39.Position = UDim2.new()
                a40.Visible = false
                a41.Scale = 1.35
                local tbl_20 = {Scale = 1}
                TweenService_upv_1:Create(a41, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_20):Play()
            end
        )
    end
    local function shake(a44, a45)
        --[[
          name: shake
          line: 694
          upvalues:
            u68 (ref, index: 1)
        ]]
        local _ = u68
        task.spawn(function() end)
    end
    local function ceremonyOff()
        --[[
          name: ceremonyOff
          line: 708
          upvalues:
            u44 (copy, index: 1)
            u52 (copy, index: 2)
            u43 (copy, index: 3)
            u51 (copy, index: 4)
            u19 (copy, index: 5)
            u22 (copy, index: 6)
            u24 (copy, index: 7)
            u17 (copy, index: 8)
        ]]
        u44.Visible = false
        u52.Visible = false
        u43.ImageTransparency = 1
        u51.ImageTransparency = 1
        for _, value_2 in {u19, u22, u24, u17} do
            value_2.MaxVisibleGraphemes = -1
        end
    end
    local function ceremonyFade(a46)
        --[[
          name: ceremonyFade
          line: 718
          upvalues:
            u46 (copy, index: 1)
            u49 (copy, index: 2)
            u54 (copy, index: 3)
            u59 (copy, index: 4)
            u62 (copy, index: 5)
            TweenService_upv_1 (copy, index: 6)
            u3 (ref,  index: 7)
            u47 (copy, index: 8)
            u56 (copy, index: 9)
            u60 (copy, index: 10)
            u48 (copy, index: 11)
            u61 (copy, index: 12)
            u57 (copy, index: 13)
            u44 (copy, index: 14)
            u45 (copy, index: 15)
            tbl_upv_8 (copy, index: 16)
            u58 (copy, index: 17)
            u43 (copy, index: 18)
            u51 (copy, index: 19)
        ]]
        for _, value_3 in {u46, u49, u54, u59, u62} do
            local tbl_21 = {TextTransparency = 1}
            TweenService_upv_1:Create(value_3, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_21):Play()
        end
        for _, value_4 in {u47, u56, u60} do
            local tbl_22 = {Transparency = 1}
            TweenService_upv_1:Create(value_4, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_22):Play()
        end
        for _, value_5 in {u48, u61} do
            local tbl_23 = {BackgroundTransparency = 1}
            TweenService_upv_1:Create(value_5, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_23):Play()
        end
        local tbl_24 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(u57, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_24):Play()
        tbl_24 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(u44, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_24):Play()
        tbl_24 = {Transparency = 1}
        TweenService_upv_1:Create(u45, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_24):Play()
        for _, value_6 in {tbl_upv_8[1], tbl_upv_8[2], tbl_upv_8[3], u58} do
            local tbl_25 = {Scale = 0}
            TweenService_upv_1:Create(value_6.scale, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_25):Play()
        end
        local tbl_26 = {ImageTransparency = 1}
        TweenService_upv_1:Create(u43, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_26):Play()
        tbl_26 = {ImageTransparency = 1}
        TweenService_upv_1:Create(u51, TweenInfo.new(a46 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_26):Play()
    end
    local function stop(a47)
        --[[
          name: stop
          line: 738
          upvalues:
            u69 (ref,  index: 1)
            u68 (ref,  index: 2)
            u70 (ref,  index: 3)
            a1 (copy, index: 4)
            u64 (copy, index: 5)
            u44 (copy, index: 6)
            u52 (copy, index: 7)
            u43 (copy, index: 8)
            u51 (copy, index: 9)
            u19 (copy, index: 10)
            u22 (copy, index: 11)
            u24 (copy, index: 12)
            u17 (copy, index: 13)
            u4 (copy, index: 14)
            u66 (ref,  index: 15)
            u67 (ref,  index: 16)
            u27 (copy, index: 17)
            TweenService_upv_1 (copy, index: 18)
            u3 (ref,  index: 19)
            u28 (copy, index: 20)
            u13 (copy, index: 21)
            u15 (copy, index: 22)
            u7 (copy, index: 23)
            u5 (copy, index: 24)
            ceremonyFade (copy, index: 25)
            screenFxOut (copy, index: 26)
        ]]
        if not u69 then
            return
        end
        u68 = u68 + 1
        local u71 = u68
        u69 = false
        if u70 then
            a1.SetHudHidden("Celebrate", false)
        end
        u70 = false
        if a47 then
            u64:Clear()
            u44.Visible = false
            u52.Visible = false
            u43.ImageTransparency = 1
            u51.ImageTransparency = 1
            for _, value_7 in {u19, u22, u24, u17} do
                value_7.MaxVisibleGraphemes = -1
            end
            u4.Visible = false
            if u66 then
                u66:Destroy()
                u66 = nil
            end
            if not u67 then
                return
            end
            u67:Destroy()
            u67 = nil
        else
            for _, value_8 in {u19, u22, u24, u27, u17} do
                local tbl_27 = {TextTransparency = 1}
                TweenService_upv_1:Create(value_8, TweenInfo.new(u3 * 0.15, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_27):Play()
            end
            local tbl_28 = {Transparency = 1}
            TweenService_upv_1:Create(u28, TweenInfo.new(u3 * 0.15, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_28):Play()
            tbl_28 = {ImageTransparency = 1}
            TweenService_upv_1:Create(u13, TweenInfo.new(u3 * 0.15, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_28):Play()
            tbl_28 = {ImageTransparency = 1}
            TweenService_upv_1:Create(u15, TweenInfo.new(u3 * 0.15, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_28):Play()
            tbl_28 = {ImageTransparency = 1}
            TweenService_upv_1:Create(u7, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_28):Play()
            tbl_28 = {BackgroundTransparency = 1}
            TweenService_upv_1:Create(u5, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_28):Play()
            ceremonyFade(0.15)
            screenFxOut(0.2)
            task.delay(
                u3 * 0.22,
                function()
                    --[[
                      line: 767
                      upvalues:
                        u71 (copy, index: 1)
                        u68 (ref,  index: 2)
                        u64 (copy, index: 3)
                        u44 (copy, index: 4)
                        u52 (copy, index: 5)
                        u43 (copy, index: 6)
                        u51 (copy, index: 7)
                        u19 (copy, index: 8)
                        u22 (copy, index: 9)
                        u24 (copy, index: 10)
                        u17 (copy, index: 11)
                        u4 (copy, index: 12)
                        u66 (ref,  index: 13)
                        u67 (ref,  index: 14)
                    ]]
                    if u71 ~= u68 then
                        return
                    end
                    u64:Clear()
                    u44.Visible = false
                    u52.Visible = false
                    u43.ImageTransparency = 1
                    u51.ImageTransparency = 1
                    for _, value_9 in {u19, u22, u24, u17} do
                        value_9.MaxVisibleGraphemes = -1
                    end
                    u4.Visible = false
                    if u66 then
                        u66:Destroy()
                        u66 = nil
                    end
                    if not u67 then
                        return
                    end
                    u67:Destroy()
                    u67 = nil
                end
            )
        end
    end
    local function momentMember(a48)
        --[[
          name: momentMember
          line: 778
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v28
        if a48.id then
            v28 = State_upv_1.FindMember(a48.id)
        else
            v28 = nil
        end
        local v29
        if v28 then
            v29 = v28
        else
            v29 = {userId = false}
            v29.id = a48.id or ""
            v29.name = a48.name or ""
        end
        return v29
    end
    local function teamMembers(a49)
        --[[
          name: teamMembers
          line: 782
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local Match_1 = State_upv_1.Match
        local v30 = Match_1 and (Match_1.teams and (Match_1.teams[a49]))
        local v31 = v30 and v30.members or {}
        return v31
    end
    local function letterX(a50, a51, a52, a53)
        --[[
          name: letterX
          line: 788
        ]]
        return ((((a50.centres[a51] or 0) + (a50.centres[a52] or (a50.width))) / 2) - (a50.width / 2)) * a53
    end
    local function portraitWhenGrown(a54, a55, a56, a57, a58)
        --[[
          name: portraitWhenGrown
          line: 796
          upvalues:
            Portraits_upv_1 (copy, index: 1)
            u68 (ref,  index: 2)
            u3 (ref,  index: 3)
        ]]
        local function apply_upv_1()
            --[[
              name: apply
              line: 797
              upvalues:
                a54 (copy, index: 1)
                Portraits_upv_1 (copy, index: 2)
                a55 (copy, index: 3)
                a56 (copy, index: 4)
            ]]
            for _, value_10 in {"RigHead", "RigBack"} do
                local v32 = a54:FindFirstChild(value_10)
                if v32 then
                    v32:Destroy()
                end
            end
            Portraits_upv_1.Apply(a54, a55, 150)
            Portraits_upv_1.SetTint(a54, a56, 0)
        end
        apply_upv_1()
        if Portraits_upv_1.ThumbFor(a55, 150) ~= "" then
            return
        end
        task.delay(
            a57 * u3,
            function()
                --[[
                  line: 809
                  upvalues:
                    a58 (copy, index: 1)
                    u68 (ref,  index: 2)
                    apply_upv_1 (copy, index: 3)
                ]]
                if a58 ~= u68 then
                    return
                end
                apply_upv_1()
            end
        )
    end
    local function pointBurst(a59, a60, a61, a62, a63, a64)
        --[[
          name: pointBurst
          line: 816
          upvalues:
            u64 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v33 = a64 or {}
        u64.Pace = u3
        u64:Burst(a59, {mode = "point", at = Vector2.new(a61, a62), jitter = v33.jitter or 30, speed = a63, color = a60, white = v33.white, whiteChance = v33.whiteChance or 0.3, sparkChance = v33.sparkChance or 0.75, kind = v33.kind, size = v33.size, grav = v33.grav, drag = v33.drag, lifeMult = v33.lifeMult})
    end
    local function play(a65, a66, a67, a68, a69, a70, a71, a72, a73)
        --[[
          name: play
          line: 837
          upvalues:
            u69 (ref,  index: 1)
            u68 (ref,  index: 2)
            u70 (ref,  index: 3)
            a1 (copy, index: 4)
            u64 (copy, index: 5)
            u44 (copy, index: 6)
            u52 (copy, index: 7)
            u43 (copy, index: 8)
            u51 (copy, index: 9)
            u19 (copy, index: 10)
            u22 (copy, index: 11)
            u24 (copy, index: 12)
            u17 (copy, index: 13)
            u4 (copy, index: 14)
            u66 (ref,  index: 15)
            u67 (ref,  index: 16)
            tbl_upv_2 (copy, index: 17)
            Colors_upv_1 (copy, index: 18)
            UI_upv_1 (copy, index: 19)
            u9 (copy, index: 20)
            u8 (copy, index: 21)
            u10 (copy, index: 22)
            u5 (copy, index: 23)
            TweenService_upv_1 (copy, index: 24)
            u3 (ref,  index: 25)
            u6 (copy, index: 26)
            u7 (copy, index: 27)
            screenFx (copy, index: 28)
            u13 (copy, index: 29)
            u14 (copy, index: 30)
            u15 (copy, index: 31)
            u16 (copy, index: 32)
            Theme_upv_1 (copy, index: 33)
            u21 (copy, index: 34)
            u26 (copy, index: 35)
            u18 (copy, index: 36)
            u12 (copy, index: 37)
            u20 (copy, index: 38)
            u23 (copy, index: 39)
            u25 (copy, index: 40)
            tw (copy, index: 41)
            u65 (copy, index: 42)
            RunService_upv_1 (copy, index: 43)
            burst (copy, index: 44)
            u11 (copy, index: 45)
            u2 (ref,  index: 46)
            pointBurst (copy, index: 47)
            u27 (copy, index: 48)
            u28 (copy, index: 49)
            State_upv_1 (copy, index: 50)
            tbl_upv_8 (copy, index: 51)
            portraitWhenGrown (copy, index: 52)
            u46 (copy, index: 53)
            u47 (copy, index: 54)
            u48 (copy, index: 55)
            u49 (copy, index: 56)
            u50 (copy, index: 57)
            u42 (copy, index: 58)
            u45 (copy, index: 59)
            u29 (copy, index: 60)
            u30 (copy, index: 61)
            u33 (copy, index: 62)
            u34 (copy, index: 63)
            u37 (copy, index: 64)
            u38 (copy, index: 65)
            u40 (copy, index: 66)
            rollDigit (copy, index: 67)
            u32 (copy, index: 68)
            u35 (copy, index: 69)
            u36 (copy, index: 70)
            u39 (copy, index: 71)
            u41 (copy, index: 72)
            tbl_upv_7 (copy, index: 73)
            u54 (copy, index: 74)
            u55 (copy, index: 75)
            u56 (copy, index: 76)
            u57 (copy, index: 77)
            u58 (copy, index: 78)
            u59 (copy, index: 79)
            u61 (copy, index: 80)
            u60 (copy, index: 81)
            u62 (copy, index: 82)
            u63 (copy, index: 83)
            u53 (copy, index: 84)
            ceremonyFade (copy, index: 85)
            screenFxOut (copy, index: 86)
        ]]
        if u69 then
            u68 = u68 + 1
            u69 = false
            if u70 then
                a1.SetHudHidden("Celebrate", false)
            end
            u70 = false
            u64:Clear()
            u44.Visible = false
            u52.Visible = false
            u43.ImageTransparency = 1
            u51.ImageTransparency = 1
            for _, value_11 in {u19, u22, u24, u17} do
                value_11.MaxVisibleGraphemes = -1
            end
            u4.Visible = false
            if u66 then
                u66:Destroy()
                u66 = nil
            end
            if u67 then
                u67:Destroy()
                u67 = nil
            end
        end
        u68 = u68 + 1
        local u72 = u68
        u69 = true
        u70 = a66
        local v34
        if a65 == "win" then
            v34 = true
        else
            v34 = false
        end
        local u73 = a65 == "lose"
        if not (v34) and not (u73) then
            a73 = nil
        end
        local u74 = not (a73) or a66 or tbl_upv_2[a73.kind]
        local u75 = not (a73) or not (a66) or tbl_upv_2[a73.kind]
        local u76
        if v34 then
            u76 = Colors_upv_1.Ally
        elseif u73 then
            u76 = Colors_upv_1.Enemy
        else
            u76 = Colors_upv_1.Bone
        end
        local u77 = u76:Lerp(Colors_upv_1.Void, (u73 and 0.55) or 0.4)
        local Compact_1 = UI_upv_1.Compact
        u9.Scale = ((not Compact_1) and 1) or ((u74 and 0.7) or 0.74)
        local u78
        if a66 then
            if Compact_1 then
                u78 = (u75 and 0.36) or 0.33
            else
                u78 = (u75 and 0.385) or 0.36
            end
        elseif u74 then
            u78 = (Compact_1 and 0.2867) or 0.265
        else
            u78 = (Compact_1 and 0.27) or 0.29
        end
        u8.Position = UDim2.fromScale(0.5, u78)
        u10.Position = UDim2.new()
        u44.Visible = false
        u52.Visible = false
        u43.ImageTransparency = 1
        u51.ImageTransparency = 1
        for _, value_12 in {u19, u22, u24, u17} do
            value_12.MaxVisibleGraphemes = -1
        end
        u4.Visible = true
        if a66 then
            a1.SetHudHidden("Celebrate", true)
        end
        u78 = (a66 and 2000) or ((u74 and 1600) or 1500)
        local u79 = (a66 and 210) or (((not u74) and 150) or ((Compact_1 and 156) or 172))
        local u80 = (a66 and 2.35) or (((not u74) and 1.55) or (u74.headS))
        local u81
        if u74 then
            u81 = u74.text
        elseif a66 then
            u81 = (v34 and "VICTORY") or ((u73 and "DEFEAT") or "DRAW")
        else
            u81 = (v34 and "ROUND WON") or ((u73 and "ROUND LOST") or "DRAW")
        end
        local v35
        if u74 then
            v35 = u74.style
        else
            v35 = nil
        end
        local u82 = (u73 and 0.6) or 1
        u5.BackgroundTransparency = 1
        if a66 then
            local tbl_29 = {BackgroundTransparency = 0}
            tbl_29.BackgroundTransparency = (u73 and 0.4) or 0.5
            TweenService_upv_1:Create(u5, TweenInfo.new(u3 * 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_29):Play()
        end
        u6.BackgroundColor3 = u76
        u6.BackgroundTransparency = (u73 and 0.84) or 0.6
        local v36 = (u73 and 0.6) or 0.45
        local v37 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(u6, TweenInfo.new(v36 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), v37):Play()
        local u83 = (u73 and 0.2) or 0.3
        local v38
        if u73 then
            v38 = u76:Lerp(Colors_upv_1.Void, 0.78)
        else
            v38 = u76:Lerp(Colors_upv_1.Void, 0.25)
        end
        u7.ImageColor3 = v38
        u7.ImageTransparency = 1
        local tbl_30 = {}
        tbl_30.ImageTransparency = u83
        TweenService_upv_1:Create(u7, TweenInfo.new(u3 * 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_30):Play()
        screenFx(a65, a66)
        u13.ImageColor3 = Color3.new(1, 1, 1)
        local v39 = ColorSequenceKeypoint.new(0, u77)
        u14.Color = ColorSequence.new({v39, ColorSequenceKeypoint.new(0.35, u76:Lerp(Colors_upv_1.Void, (u73 and 0.4) or 0.18)), ColorSequenceKeypoint.new(0.65, u77), ColorSequenceKeypoint.new(1, u77:Lerp(Colors_upv_1.Void, 0.3))})
        u13.ImageTransparency = (u73 and 0.18) or 0.04
        u15.ImageColor3 = u77
        u15.Size = UDim2.fromOffset(u78 * 0.6, u79 * 1.55)
        u15.ImageTransparency = 1
        local tbl_31 = {ImageTransparency = 0}
        tbl_31.Size = UDim2.fromOffset(u78 * 1.15, u79 * 1.55)
        tbl_31.ImageTransparency = (u73 and 0.7) or 0.55
        TweenService_upv_1:Create(u15, TweenInfo.new(u3 * 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_31):Play()
        u13.AnchorPoint = Vector2.new(0, 0.5)
        u13.Position = UDim2.fromOffset(-u78 / 2, 0)
        u13.Size = UDim2.fromOffset(0, u79)
        local v40
        if u73 or v35 == "hold" then
            v40 = 0.45
        else
            v40 = 0.3
        end
        local tbl_32 = {}
        tbl_32.Size = UDim2.fromOffset(u78, u79)
        TweenService_upv_1:Create(u13, TweenInfo.new(v40 * u3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_32):Play()
        u16.BackgroundColor3 = Theme_upv_1.Lighten(u76, 0.25)
        u16.AnchorPoint = Vector2.new(1, 0.5)
        u16.Position = UDim2.fromOffset((u78 / 2) - 60, (u79 / 2) - 2)
        u16.Size = UDim2.fromOffset(0, (a66 and 6) or 5)
        u16.BackgroundTransparency = 0
        local tbl_33 = {Size = 0}
        tbl_33.Size = UDim2.fromOffset(u78 * 0.8, (a66 and 6) or 5)
        TweenService_upv_1:Create(u16, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u3), tbl_33):Play()
        local Play_1 = a1.Sounds.Play
        local tbl_34 = {pitch = 0, volume = 0.35}
        tbl_34.pitch = (u73 and 0.85) or 1
        Play_1("Whoosh", tbl_34)
        for _, value_13 in {u19, u22, u24, u17} do
            value_13.AutoLocalize = u74 == nil
            value_13.Text = u81
            value_13.TextTransparency = 1
            value_13.Position = UDim2.fromOffset(0, 0)
        end
        u17.TextColor3 = Theme_upv_1.Lighten(u76, 0.35)
        u22.Position = UDim2.fromOffset(0, 7)
        u21.Color = ColorSequence.new(Colors_upv_1.Text, Theme_upv_1.Lighten(u76, (v34 and 0.55) or 0.7))
        u26.Offset = Vector2.new(-1, 0)
        u18.Scale = u80
        u12.Position = UDim2.new()
        local v41, v42 = nil, nil
        local v65
        if u74 then
            v65 = a73
            local u85 = not u73
            local function ceremonyImpact_upv_1(a74)
                --[[
                  name: ceremonyImpact
                  line: 1001
                  upvalues:
                    v65 (copy, index: 1)
                    u20 (copy, index: 2)
                    u23 (copy, index: 3)
                    u25 (copy, index: 4)
                    u80 (copy, index: 5)
                    u85 (copy, index: 6)
                    TweenService_upv_1 (copy, index: 7)
                    u3 (ref,  index: 8)
                    u68 (ref,  index: 9)
                    u17 (copy, index: 13)
                    u18 (copy, index: 14)
                    u74 (copy, index: 15)
                    u64 (copy, index: 16)
                    Theme_upv_1 (copy, index: 17)
                    u76 (copy, index: 18)
                    burst (copy, index: 19)
                    Colors_upv_1 (copy, index: 20)
                    u12 (copy, index: 21)
                    u11 (copy, index: 22)
                    u78 (copy, index: 23)
                    u79 (copy, index: 24)
                    u82 (copy, index: 25)
                    u2 (ref,  index: 26)
                ]]
                local kind_1 = v65.kind
                for _, value_14 in {u20, u23, u25} do
                    value_14.Scale = u80 * (((kind_1 == "flawless") and 1.03) or ((u85 and 1.1) or 1.05))
                    local tbl_35 = {}
                    tbl_35.Scale = u80
                    TweenService_upv_1:Create(value_14, TweenInfo.new(u3 * 0.26, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_35):Play()
                end
                if kind_1 ~= "flawless" then
                    local _ = ((not u85) and 3) or (((kind_1 ~= "clutch") and 10) or 13)
                    local v47 = ((kind_1 ~= "clutch") and 0.24) or 0.32
                    local v48 = u68
                    task.spawn(function() end)
                end
                u17.MaxVisibleGraphemes = -1
                u17.TextTransparency = (u85 and 0.2) or 0.55
                u18.Scale = u80 * 1.02
                local tbl_36 = {Scale = 0}
                tbl_36.Scale = u80 * ((u85 and 1.32) or 1.18)
                TweenService_upv_1:Create(u18, TweenInfo.new(u3 * 0.6, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_36):Play()
                tbl_36 = {TextTransparency = 1}
                TweenService_upv_1:Create(u17, TweenInfo.new(u3 * 0.6, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_36):Play()
                local v43 = u74.width * u80
                local v46 = nil
                if kind_1 ~= "flawless" then
                    local v44 = ((not u85) and 14) or (((kind_1 ~= "clutch") and 44) or 50)
                    if u85 then
                        v46 = Theme_upv_1.Lighten(u76, 0.25)
                    else
                        v46 = u76:Lerp(Colors_upv_1.Void, 0.3)
                    end
                    burst(v44, v46, v43, 80 * u80, (u85 and 1500) or 700)
                else
                    u64.Pace = u3
                    u64:Burst((u85 and 28) or 12, {lifeMult = 1.7, drag = 1.5, whiteChance = 0.45, kind = "sparkle", speed = 240, mode = "box", grav = -60, size = 32, box = Vector2.new(v43, 70 * u80), color = Theme_upv_1.Lighten(u76, 0.45), white = Theme_upv_1.Lighten(u76, 0.72)})
                end
                u12.ImageColor3 = Theme_upv_1.Lighten(u76, 0.3)
                local fromOffset_1 = UDim2.fromOffset
                if kind_1 == "flawless" or kind_1 == "clutch" then
                    v46 = 0
                else
                    v46 = a74
                end
                u12.Position = fromOffset_1(v46, 0)
                u12.Size = UDim2.fromOffset(120, 120)
                u12.ImageTransparency = (u85 and 0.2) or 0.55
                local tbl_37 = {ImageTransparency = 1}
                tbl_37.Size = UDim2.fromOffset(1500, 1500)
                TweenService_upv_1:Create(u12, TweenInfo.new(u3 * 0.65, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_37):Play()
                u11.ImageColor3 = u76
                u11.Size = UDim2.fromOffset(u78 * 0.45, u79 * 1.6)
                u11.ImageTransparency = (u85 and 0.3) or 0.6
                local tbl_38 = {ImageTransparency = 1}
                tbl_38.Size = UDim2.fromOffset(u78 * 0.7, u79 * 2.4)
                TweenService_upv_1:Create(u11, TweenInfo.new(u3 * 0.8, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_38):Play()
                if kind_1 == "ace" then
                    local tbl_39 = {pitch = 1.16}
                    tbl_39.volume = u82
                    if u2 then
                        pcall(u2.Play, "Match/Elimination", nil, tbl_39)
                    end
                    local tbl_40 = {}
                    tbl_40.volume = u82
                    if not u2 then
                        return
                    end
                    pcall(u2.Play, "Kill_Triple", nil, tbl_40)
                elseif kind_1 == "teamace" then
                    local tbl_41 = {pitch = 1.2}
                    tbl_41.volume = u82
                    if u2 then
                        pcall(u2.Play, "Kill_Ally", nil, tbl_41)
                    end
                    local tbl_42 = {}
                    tbl_42.volume = u82
                    if not u2 then
                        return
                    end
                    pcall(u2.Play, "Kill_Triple", nil, tbl_42)
                elseif kind_1 ~= "clutch" then
                    local tbl_43 = {}
                    tbl_43.volume = u82
                    if not u2 then
                        return
                    end
                    pcall(u2.Play, "UI/Card_Reveal", nil, tbl_43)
                else
                    local tbl_44 = {}
                    tbl_44.volume = u82
                    if not u2 then
                        return
                    end
                    pcall(u2.Play, "Match/Final_Round", nil, tbl_44)
                end
            end
            if u74.style == "stamp" then
                local tbl_45 = {}
                for n_3 = math.max(u74.lead, 1), #u74.ends do
                    table.insert(tbl_45, n_3)
                end
                local v47 = 0.1
                for _, value_15 in {u20, u23, u25} do
                    value_15.Scale = u80
                end
                for _, value_16 in {u19, u22, u24, u17} do
                    value_16.MaxVisibleGraphemes = 0
                end
                local v48 = 0
                local u86, v49
                u86, v49, v41 = v48, v47, v47
                for key_upv_1, value_upv_17 in tbl_45 do
                    local u87 = u74.ends[value_upv_17]
                    local u88 = (key_upv_1 == 1) and (value_upv_17 > 1)
                    local u89 = key_upv_1 == #tbl_45
                    task.delay(
                        v49 * u3,
                        function()
                            --[[
                              line: 1087
                              upvalues:
                                u72 (copy, index: 1)
                                u68 (ref,  index: 2)
                                u19 (copy, index: 3)
                                u22 (copy, index: 4)
                                u24 (copy, index: 5)
                                u87 (copy, index: 6)
                                u74 (copy, index: 7)
                                u86 (copy, index: 8)
                                value_upv_17 (copy, index: 9)
                                u80 (copy, index: 10)
                                u88 (copy, index: 11)
                                TweenService_upv_1 (copy, index: 12)
                                u3 (ref,  index: 13)
                                u20 (copy, index: 14)
                                u23 (copy, index: 15)
                                u89 (copy, index: 16)
                                ceremonyImpact_upv_1 (copy, index: 17)
                                u85 (copy, index: 18)
                                pointBurst (copy, index: 22)
                                Theme_upv_1 (copy, index: 23)
                                u76 (copy, index: 24)
                                Colors_upv_1 (copy, index: 25)
                                u12 (copy, index: 26)
                                v65 (copy, index: 27)
                                u82 (copy, index: 28)
                                key_upv_1 (copy, index: 29)
                                u2 (ref,  index: 30)
                            ]]
                            if u72 ~= u68 then
                                return
                            end
                            for _, value_18 in {u19, u22, u24} do
                                value_18.MaxVisibleGraphemes = u87
                            end
                            local v50 = ((((u74.centres[u86 + 1] or 0) + (u74.centres[value_upv_17] or (u74.width))) / 2) - (u74.width / 2)) * u80
                            if u88 then
                                u19.TextTransparency = 1
                                u22.TextTransparency = 1
                                local tbl_46 = {TextTransparency = 0}
                                TweenService_upv_1:Create(u19, TweenInfo.new(u3 * 0.12, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_46):Play()
                                tbl_46 = {TextTransparency = 0.55}
                                TweenService_upv_1:Create(u22, TweenInfo.new(u3 * 0.18, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_46):Play()
                                for _, value_19 in {u20, u23} do
                                    value_19.Scale = u80 * 1.12
                                    local tbl_47 = {}
                                    tbl_47.Scale = u80
                                    TweenService_upv_1:Create(value_19, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_47):Play()
                                end
                            else
                                u19.TextTransparency = 0
                                u22.TextTransparency = 0.55
                                if u89 then
                                    ceremonyImpact_upv_1(v50)
                                else
                                    for _, value_20 in {u20, u23} do
                                        value_20.Scale = u80 * 1.06
                                        local tbl_48 = {}
                                        tbl_48.Scale = u80
                                        TweenService_upv_1:Create(value_20, TweenInfo.new(u3 * 0.14, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_48):Play()
                                    end
                                    local _ = (u85 and 5) or 2
                                    local v54 = u68
                                    local v55 = 0.12
                                    task.spawn(function() end)
                                    local v51 = (u85 and 12) or 5
                                    local v52
                                    if u85 then
                                        v52 = Theme_upv_1.Lighten(u76, 0.3)
                                    else
                                        v52 = u76:Lerp(Colors_upv_1.Void, 0.3)
                                    end
                                    pointBurst(v51, v52, v50, 0, (u85 and 950) or 500, {jitter = 34 * u80, white = Theme_upv_1.Lighten(u76, 0.7)})
                                    u12.ImageColor3 = Theme_upv_1.Lighten(u76, 0.35)
                                    u12.Position = UDim2.fromOffset(v50, 0)
                                    u12.Size = UDim2.fromOffset(60, 60)
                                    u12.ImageTransparency = (u85 and 0.3) or 0.6
                                    local tbl_49 = {ImageTransparency = 1}
                                    tbl_49.Size = UDim2.fromOffset(380, 380)
                                    TweenService_upv_1:Create(u12, TweenInfo.new(u3 * 0.32, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_49):Play()
                                    local v53 = ((u84.kind ~= "teamace") and "Match/Elimination") or "Kill_Ally"
                                    local tbl_50 = {}
                                    tbl_50.volume = u82 * 0.9
                                    tbl_50.pitch = 0.9 + (0.08 * key_upv_1)
                                    if not u2 then
                                        return
                                    end
                                    pcall(u2.Play, v53, nil, tbl_50)
                                end
                            end
                        end
                    )
                    local v54 = value_upv_17
                    u86, v49, v41 = v54, v49 + ((u88 and 0.2) or 0.15), v49
                end
                v42 = v47
            elseif u74.style ~= "hold" then
                local v55 = 0.08
                for _, value_21 in {u20, u23, u25} do
                    value_21.Scale = u80 * 1.28
                    local tbl_51 = {}
                    tbl_51.Scale = u80
                    local v56 = u3 * 0.42
                    TweenService_upv_1:Create(value_21, TweenInfo.new(v56, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v55 or 0) * u3), tbl_51):Play()
                end
                local tbl_52 = {TextTransparency = 0}
                TweenService_upv_1:Create(u19, TweenInfo.new(u3 * 0.22, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v55 or 0) * u3), tbl_52):Play()
                local tbl_53 = {TextTransparency = 0.55}
                TweenService_upv_1:Create(u22, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v55 or 0) * u3), tbl_53):Play()
                v37 = v55 + 0.24
                task.delay(
                    v37 * u3,
                    function()
                        --[[
                          line: 1179
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            ceremonyImpact_upv_1 (copy, index: 3)
                            u43 (copy, index: 4)
                            Theme_upv_1 (copy, index: 5)
                            u76 (copy, index: 6)
                            u78 (copy, index: 7)
                            u79 (copy, index: 8)
                            u85 (copy, index: 9)
                            TweenService_upv_1 (copy, index: 10)
                            u3 (ref,  index: 11)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        ceremonyImpact_upv_1(0)
                        u43.ImageColor3 = Theme_upv_1.Lighten(u76, 0.55)
                        u43.Position = UDim2.fromOffset(-u78 * 0.32, (-u79 / 2) + 4)
                        u43.ImageTransparency = (u85 and 0.25) or 0.6
                        local tbl_54 = {}
                        tbl_54.Position = UDim2.fromOffset(u78 * 0.32, (-u79 / 2) + 4)
                        TweenService_upv_1:Create(u43, TweenInfo.new(u3 * 0.75, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.InOut or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_54):Play()
                        local tbl_55 = {ImageTransparency = 1}
                        TweenService_upv_1:Create(u43, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0.5 * u3), tbl_55):Play()
                    end
                )
                v42 = v55
            else
                local v57 = 0.02
                for _, value_22 in {u20, u23, u25} do
                    value_22.Scale = u80 * 2.1
                    local tbl_56 = {}
                    tbl_56.Scale = u80 * 1.45
                    TweenService_upv_1:Create(value_22, TweenInfo.new(u3 * 0.34, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v57 or 0) * u3), tbl_56):Play()
                end
                local tbl_57 = {TextTransparency = 0.62}
                TweenService_upv_1:Create(u19, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v57 or 0) * u3), tbl_57):Play()
                u5.BackgroundTransparency = 1
                tbl_57 = {BackgroundTransparency = 0}
                tbl_57.BackgroundTransparency = (u85 and 0.72) or 0.8
                TweenService_upv_1:Create(u5, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_57):Play()
                local tbl_58 = {}
                tbl_58.volume = u82
                if u2 then
                    pcall(u2.Play, "Match/Final_Heartbeat", nil, tbl_58)
                end
                for _, value_upv_23 in {{0.04, 0.02}, {0.26, 0.08}} do
                    task.delay(
                        value_upv_23[1] * u3,
                        function()
                            --[[
                              line: 1143
                              upvalues:
                                u72 (copy, index: 1)
                                u68 (ref,  index: 2)
                                u7 (copy, index: 3)
                                value_upv_23 (copy, index: 4)
                                u83 (copy, index: 5)
                                TweenService_upv_1 (copy, index: 6)
                                u3 (ref,  index: 7)
                            ]]
                            if u72 == u68 then
                                u7.ImageTransparency = value_upv_23[2]
                                local tbl_59 = {}
                                tbl_59.ImageTransparency = u83
                                TweenService_upv_1:Create(u7, TweenInfo.new(u3 * 0.18, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_59):Play()
                            end
                        end
                    )
                end
                task.delay(
                    u3 * 0.42,
                    function()
                        --[[
                          line: 1152
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            u20 (copy, index: 3)
                            u23 (copy, index: 4)
                            u25 (copy, index: 5)
                            u80 (copy, index: 6)
                            TweenService_upv_1 (copy, index: 7)
                            u3 (ref,  index: 8)
                            u19 (copy, index: 9)
                            u22 (copy, index: 10)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        for _, value_24 in {u20, u23, u25} do
                            local tbl_60 = {}
                            tbl_60.Scale = u80
                            TweenService_upv_1:Create(value_24, TweenInfo.new(u3 * 0.12, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_60):Play()
                        end
                        local tbl_61 = {TextTransparency = 0}
                        TweenService_upv_1:Create(u19, TweenInfo.new(u3 * 0.1, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_61):Play()
                        local tbl_62 = {TextTransparency = 0.55}
                        TweenService_upv_1:Create(u22, TweenInfo.new(u3 * 0.12, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_62):Play()
                    end
                )
                v41 = 0.54
                task.delay(
                    v41 * u3,
                    function()
                        --[[
                          line: 1163
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            u5 (copy, index: 3)
                            TweenService_upv_1 (copy, index: 4)
                            u3 (ref,  index: 5)
                            ceremonyImpact_upv_1 (copy, index: 6)
                        ]]
                        if u72 == u68 then
                            local tbl_63 = {BackgroundTransparency = 1}
                            TweenService_upv_1:Create(u5, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_63):Play()
                            ceremonyImpact_upv_1(0)
                        end
                    end
                )
                v42 = v57
            end
        else
            v65 = u73 and 1.12 or 1.75
            u20.Scale = u80 * v65
            u23.Scale = u80 * v65
            u25.Scale = u80 * v65
            v65 = (u73 and 0.5) or 0.26
            local v59
            if u73 then
                v59 = Enum.EasingStyle.Quint
            else
                v59 = Enum.EasingStyle.Back
            end
            v42 = (u73 and 0.1) or 0.08
            for _, value_25 in {u20, u23, u25} do
                tw(value_25, v65, {Scale = u80}, v59, Enum.EasingDirection.Out, v42)
            end
            local tbl_64 = {TextTransparency = 0}
            local v60 = u3 * 0.12
            TweenService_upv_1:Create(u19, TweenInfo.new(v60, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v42 or 0) * u3), tbl_64):Play()
            local tbl_65 = {TextTransparency = 0.55}
            TweenService_upv_1:Create(u22, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v42 or 0) * u3), tbl_65):Play()
            v37 = v42 + ((u73 and 0.3) or 0.2)
            task.delay(
                v37 * u3,
                function()
                    --[[
                      line: 957
                      upvalues:
                        u72 (copy, index: 1)
                        u68 (ref,  index: 2)
                        u73 (copy, index: 3)
                        u20 (copy, index: 4)
                        u23 (copy, index: 5)
                        u25 (copy, index: 6)
                        u80 (copy, index: 7)
                        TweenService_upv_1 (copy, index: 8)
                        u3 (ref,  index: 9)
                        a66 (copy, index: 10)
                        u10 (copy, index: 11)
                        u65 (copy, index: 12)
                        RunService_upv_1 (copy, index: 13)
                        u17 (copy, index: 14)
                        u18 (copy, index: 15)
                        u81 (copy, index: 16)
                        burst (copy, index: 17)
                        Theme_upv_1 (copy, index: 18)
                        u76 (copy, index: 19)
                        u12 (copy, index: 20)
                        u11 (copy, index: 21)
                        u78 (copy, index: 22)
                        u79 (copy, index: 23)
                        Colors_upv_1 (copy, index: 24)
                    ]]
                    if u72 ~= u68 then
                        return
                    end
                    if u73 then
                        u11.ImageColor3 = u76:Lerp(Colors_upv_1.Void, 0.4)
                        u11.Size = UDim2.fromOffset(u78 * 0.5, u79 * 1.8)
                        u11.ImageTransparency = 0.6
                        local tbl_66 = {ImageTransparency = 1}
                        TweenService_upv_1:Create(u11, TweenInfo.new(u3 * 1.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_66):Play()
                        if a66 then
                            local tbl_67 = {sparkChance = 0, lifeMult = 1.6, drag = 1.2, grav = 520, base = 0.35}
                            burst(10, u76:Lerp(Colors_upv_1.Void, 0.3), 700, 80, 260, tbl_67)
                        end
                    else
                        for _, value_26 in {u20, u23, u25} do
                            value_26.Scale = u80 * 1.07
                            local tbl_68 = {}
                            tbl_68.Scale = u80
                            TweenService_upv_1:Create(value_26, TweenInfo.new(u3 * 0.22, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_68):Play()
                        end
                        local u90 = (a66 and 9) or 6
                        local u91 = u68
                        local u92 = 0.22
                        task.spawn(
                            function()
                                --[[
                                  line: 696
                                  upvalues:
                                    u92 (copy, index: 1)
                                    u3 (ref,  index: 2)
                                    u91 (copy, index: 3)
                                    u68 (ref,  index: 4)
                                    u10 (copy, index: 5)
                                    u65 (copy, index: 6)
                                    u90 (copy, index: 7)
                                    RunService_upv_1 (copy, index: 8)
                                ]]
                                local v61 = os.clock()
                                while os.clock() - v61 < u92 * u3 and u91 == u68 do
                                    local v62 = 1 - (os.clock() - v61) / (u92 * u3)
                                    u10.Position = UDim2.fromOffset((u65:NextNumber(-1, 1) * u90) * v62, (u65:NextNumber(-1, 1) * u90) * v62)
                                    RunService_upv_1.RenderStepped:Wait()
                                end
                                u10.Position = UDim2.new()
                            end
                        )
                        u17.TextTransparency = 0.25
                        u18.Scale = u80 * 1.02
                        local tbl_69 = {}
                        tbl_69.Scale = u80 * 1.28
                        TweenService_upv_1:Create(u18, TweenInfo.new(u3 * 0.55, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_69):Play()
                        local tbl_70 = {TextTransparency = 1}
                        TweenService_upv_1:Create(u17, TweenInfo.new(u3 * 0.55, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_70):Play()
                        local v63 = (a66 and 48) or 34
                        local v64 = Theme_upv_1.Lighten(u76, 0.25)
                        burst(v63, v64, (#u81 * 43) * u80, 80 * u80, (a66 and 1400) or 1150)
                        u12.ImageColor3 = Theme_upv_1.Lighten(u76, 0.3)
                        u12.Size = UDim2.fromOffset(120, 120)
                        u12.ImageTransparency = 0.25
                        local tbl_71 = {ImageTransparency = 1, Size = 0}
                        tbl_71.Size = UDim2.fromOffset((a66 and 1700) or 1200, (a66 and 1700) or 1200)
                        TweenService_upv_1:Create(u12, TweenInfo.new(u3 * 0.6, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_71):Play()
                        u11.ImageColor3 = u76
                        u11.Size = UDim2.fromOffset(u78 * 0.45, u79 * 1.6)
                        u11.ImageTransparency = 0.35
                        tbl_71 = {ImageTransparency = 1}
                        tbl_71.Size = UDim2.fromOffset(u78 * 0.7, u79 * 2.4)
                        TweenService_upv_1:Create(u11, TweenInfo.new(u3 * 0.7, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_71):Play()
                    end
                end
            )
        end
        if u74 then
            v65 = v41 + 0.08
        else
            v65 = v42 + ((u73 and 0.55) or 0.34)
        end
        local u93 = ((v35 == "shine") and 0.85) or ((u73 and 0.9) or 0.55)
        task.delay(
            v65 * u3,
            function()
                --[[
                  line: 1197
                  upvalues:
                    u72 (copy, index: 1)
                    u68 (ref,  index: 2)
                    u24 (copy, index: 3)
                    u73 (copy, index: 4)
                    u26 (copy, index: 5)
                    u93 (copy, index: 6)
                    TweenService_upv_1 (copy, index: 7)
                    u3 (ref,  index: 8)
                ]]
                if u72 ~= u68 then
                    return
                end
                u24.MaxVisibleGraphemes = -1
                u24.TextTransparency = (u73 and 0.55) or 0
                u26.Offset = Vector2.new(-1, 0)
                local tbl_72 = {}
                tbl_72.Offset = Vector2.new(1, 0)
                TweenService_upv_1:Create(u26, TweenInfo.new(u93 * u3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.InOut or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_72):Play()
                task.delay(
                    (u93 + 0.05) * u3,
                    function()
                        --[[
                          line: 1205
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            u24 (copy, index: 3)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        u24.TextTransparency = 1
                    end
                )
            end
        )
        local v66 = -u79 / 2 - 8
        local u94
        if a66 then
            u94 = (v34 and "MATCH WON") or ((u73 and "MATCH LOST") or "MATCH DRAWN")
        elseif u74 then
            u94 = (v34 and "ROUND WON") or "ROUND LOST"
        else
            u94 = string.format("ROUND %d", a71 or 1)
        end
        u27.Text = u94
        if v34 then
            u94 = Theme_upv_1.Lighten(u76, 0.45)
        else
            u94 = Colors_upv_1.TextDim
        end
        u27.TextColor3 = u94
        u27.Position = UDim2.fromOffset(0, v66 + 14)
        u27.TextTransparency = 1
        u27.Visible = (u75 == nil) and (a66 or (not Compact_1))
        u94 = {TextTransparency = 0}
        u94.Position = UDim2.fromOffset(0, v66)
        TweenService_upv_1:Create(u27, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, ((v42 + 0.3) or 0) * u3), u94):Play()
        u28.Transparency = 1
        u94 = {Transparency = 0.5}
        TweenService_upv_1:Create(u28, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, ((v42 + 0.3) or 0) * u3), u94):Play()
        local v67 = u79 / 2 + ((Compact_1 and 8) or 10)
        if u74 then
            local v68 = nil
            if a73 then
                local v69 = v41 + 0.12
                v68 = u74.named
                local v70
                if v68 then
                    local tbl_73 = {}
                    local v71
                    if a73.id then
                        v71 = State_upv_1.FindMember(a73.id)
                    else
                        v71 = nil
                    end
                    local v72
                    if v71 then
                        v72 = v71
                    else
                        local tbl_74 = {userId = false}
                        tbl_74.id = a73.id or ""
                        tbl_74.name = a73.name or ""
                        v72 = tbl_74
                    end
                    tbl_73[1] = v72
                    v70 = tbl_73
                else
                    local v73 = State_upv_1.Match
                    local v74 = v73 and (v73.teams and (v73.teams[a73.team]))
                    local v75 = nil
                    if v74 then
                        v75 = v74.members
                        if v75 then
                            v70 = v75
                        else
                            local tbl_75 = {}
                            v70 = tbl_75
                        end
                    else
                        local tbl_75 = {}
                        v70 = tbl_75
                    end
                end
                local v76 = nil
                local v77 = nil
                for key_2, value_27 in tbl_upv_8 do
                    local v78 = v70[key_2]
                    value_27.holder.Visible = v78 ~= nil
                    value_27.scale.Scale = 0
                    if not (v78) then
                        continue
                    end
                    local stroke_1 = value_27.stroke
                    if u73 then
                        v76 = u76:Lerp(Colors_upv_1.Void, 0.2)
                    else
                        v76 = u76
                    end
                    stroke_1.Color = v76
                    local v79 = v69 + (key_2 - 1) * 0.06
                    local tbl_76 = {Scale = 1}
                    local v80 = nil
                    TweenService_upv_1:Create(v80.scale, TweenInfo.new(u3 * 0.4, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v79 or 0) * u3), tbl_76):Play()
                    local img_1 = v80.img
                    if u73 then
                        v77 = Color3.fromRGB(200, 200, 200)
                    else
                        v77 = Color3.new(1, 1, 1)
                    end
                    portraitWhenGrown(img_1, v78, v77, v79 + 0.42, u72)
                end
                u46.Visible = v68
                local _, v73
                if v68 then
                    _ = a73.name
                    v73 = a73.name or tostring(v70[1] and v70[1].name or "")
                else
                    v73 = ""
                end
                u46.Text = v73
                u46.TextTransparency = 1
                u47.Transparency = 1
                local tbl_77 = {TextTransparency = 0}
                TweenService_upv_1:Create(u46, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 + 0.06 or 0) * u3), tbl_77):Play()
                local tbl_78 = {Transparency = 0.35}
                TweenService_upv_1:Create(u47, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 + 0.06 or 0) * u3), tbl_78):Play()
                u48.Visible = (a73.kind == "clutch") and (a73.vs >= 2)
                u49.Text = "1v" .. tostring(a73.vs)
                u48.BackgroundColor3 = u76:Lerp(Colors_upv_1.Void, (u73 and 0.45) or 0.15)
                u48.BackgroundTransparency = 1
                u49.TextTransparency = 1
                u50.Scale = 0.6
                local tbl_79 = {BackgroundTransparency = 0.05}
                TweenService_upv_1:Create(u48, TweenInfo.new(u3 * 0.22, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 + 0.18 or 0) * u3), tbl_79):Play()
                local tbl_80 = {TextTransparency = 0}
                TweenService_upv_1:Create(u49, TweenInfo.new(u3 * 0.22, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 + 0.18 or 0) * u3), tbl_80):Play()
                local tbl_81 = {Scale = 1}
                TweenService_upv_1:Create(u50, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 + 0.18 or 0) * u3), tbl_81):Play()
                u42.PaddingRight = UDim.new(0, (v68 and 24) or 6)
                u42.PaddingLeft = UDim.new(0, 6)
                u44.BackgroundTransparency = 1
                u45.Color = u76
                u45.Transparency = 1
                local tbl_82 = {BackgroundTransparency = 0}
                tbl_82.BackgroundTransparency = (u73 and 0.3) or 0.35
                TweenService_upv_1:Create(u44, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 or 0) * u3), tbl_82):Play()
                local tbl_83 = {Transparency = 0}
                tbl_83.Transparency = (u73 and 0.75) or 0.55
                TweenService_upv_1:Create(u45, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 or 0) * u3), tbl_83):Play()
                u44.Position = UDim2.fromOffset(0, v67 + 14)
                u44.Visible = true
                local tbl_84 = {}
                tbl_84.Position = UDim2.fromOffset(0, v67)
                TweenService_upv_1:Create(u44, TweenInfo.new(u3 * 0.4, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v69 or 0) * u3), tbl_84):Play()
            end
        end
        u29.Visible = not u74 or not Compact_1
        if u74 then
            u94 = v67 + 60 + 8
        else
            local v81 = u79 / 2
            local v68
            if not (Compact_1) or a66 then
                v68 = 6
            else
                v68 = 0
            end
            u94 = v81 + v68
        end
        local v82 = (u74 and (v41 + 0.24)) or (v42 + 0.38)
        u30.Scale = (a66 and 1.3) or 1
        u29.Position = UDim2.fromOffset(0, u94 + 16)
        u33.Text = tostring(a69)
        u33.Position = UDim2.new()
        u33.TextColor3 = Colors_upv_1.Ally
        u33.TextTransparency = 0
        u34.Visible = false
        u37.Text = tostring(a70)
        u37.Position = UDim2.new()
        u37.TextColor3 = Colors_upv_1.Enemy
        u37.TextTransparency = 0
        u38.Visible = false
        for _, value_28 in {u33, u37} do
            value_28.TextTransparency = 1
            local tbl_85 = {TextTransparency = 0}
            local v83 = u3 * 0.3
            TweenService_upv_1:Create(value_28, TweenInfo.new(v83, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (v82 or 0) * u3), tbl_85):Play()
        end
        u40.BackgroundTransparency = 1
        local tbl_86 = {BackgroundTransparency = 0.2}
        local v84 = u3 * 0.3
        local v85 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
        local v86 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
        TweenService_upv_1:Create(u40, TweenInfo.new(v84, v85, v86, 0, false, (v82 or 0) * u3), tbl_86):Play()
        local tbl_87 = {}
        tbl_87.Position = UDim2.fromOffset(0, u94)
        local v87 = u3 * 0.34
        local v88 = Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint)
        local v89 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
        TweenService_upv_1:Create(u29, TweenInfo.new(v87, v88, v89, 0, false, (v82 or 0) * u3), tbl_87):Play()
        task.delay(
            (v82 + 0.24) * u3,
            function()
                --[[
                  line: 1293
                  upvalues:
                    u72 (copy, index: 1)
                    u68 (ref,  index: 2)
                    a67 (copy, index: 3)
                    a69 (copy, index: 4)
                    rollDigit (copy, index: 5)
                    u32 (copy, index: 6)
                    u33 (copy, index: 7)
                    u34 (copy, index: 8)
                    u35 (copy, index: 9)
                    Colors_upv_1 (copy, index: 10)
                    a68 (copy, index: 11)
                    a70 (copy, index: 12)
                    u36 (copy, index: 13)
                    u37 (copy, index: 14)
                    u38 (copy, index: 15)
                    u39 (copy, index: 16)
                ]]
                if u72 ~= u68 then
                    return
                end
                if a67 ~= a69 then
                    rollDigit(u32, u33, u34, u35, a67, Colors_upv_1.Ally)
                end
                if a68 ~= a70 then
                    rollDigit(u36, u37, u38, u39, a68, Colors_upv_1.Enemy)
                end
            end
        )
        u41.Visible = a66
        if a66 then
            u41.Position = UDim2.fromOffset(0, u94 + 116)
            v82 = State_upv_1.Match
            local v90 = v82 and (v82.teams and (v82.teams[State_upv_1.MyTeam()]))
            local v91 = nil
            if v90 then
                v91 = v90.members
                if v91 then
                    v82 = v91
                else
                    local tbl_88 = {}
                    v82 = tbl_88
                end
            else
                local tbl_88 = {}
                v82 = tbl_88
            end
            local v92 = math.min(#v82, #tbl_upv_7)
            local v93 = nil
            local v94 = nil
            local _ = nil
            local v95 = nil
            for key_3, value_29 in tbl_upv_7 do
                local v96 = v82[key_3]
                value_29.frame.Visible = v96 ~= nil
                if not (v96) then
                    continue
                end
                value_29.name.Text = tostring(v96.name or "?")
                local name_1 = value_29.name
                if v96.id ~= State_upv_1.MyId() then
                    v94 = Colors_upv_1.Text
                else
                    v94 = Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.2)
                end
                name_1.TextColor3 = v94
                local stroke_2 = value_29.stroke
                if u73 then
                    v94 = Colors_upv_1.TextMuted
                else
                    v94 = u76
                end
                stroke_2.Color = v94
                local star_1 = value_29.star
                v93 = false
                if a72 ~= nil then
                    v93 = (v96.id == a72) and (not u73)
                end
                star_1.Visible = v93
                local v97 = nil
                local v98 = UDim2.new(0.5, (v97 - ((v92 + 1) / 2)) * 150, 0, 0)
                value_29.frame.Position = v98 + UDim2.fromOffset(0, 60)
                UI_upv_1.GetScaleObj(value_29.frame).Scale = 0
                local tbl_89 = {}
                tbl_89.Position = v98
                TweenService_upv_1:Create(value_29.frame, TweenInfo.new(u3 * 0.5, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (((v42 + 0.75) + (v97 * 0.09)) or 0) * u3), tbl_89):Play()
                v94 = UI_upv_1.GetScaleObj(value_29.frame)
                local tbl_90 = {Scale = 1}
                TweenService_upv_1:Create(v94, TweenInfo.new(u3 * 0.5, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, (((v42 + 0.75) + (v97 * 0.09)) or 0) * u3), tbl_90):Play()
                local img_2 = value_29.img
                if u73 then
                    v95 = Color3.fromRGB(170, 170, 170)
                else
                    v95 = Color3.new(1, 1, 1)
                end
                portraitWhenGrown(img_2, v96, v95, ((v42 + 0.75) + (v97 * 0.09)) + 0.52, u72)
            end
            if v34 then
                task.delay(
                    u3 * 1.05,
                    function()
                        --[[
                          line: 1331
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            burst (copy, index: 3)
                            Colors_upv_1 (copy, index: 4)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        burst(22, Colors_upv_1.Gold, 900, 120, 700, {drag = 1.6, sparkChance = 0.3, grav = 620, lifeMult = 1.5})
                    end
                )
            end
        end
        if u75 then
            local v99, v100, v101 = nil, nil, nil
            if a73 then
                u94 = a73
                local u95 = -u79 / 2 - 6
                u54.Text = u75.text
                u55.Color = ColorSequence.new(Colors_upv_1.Text, Theme_upv_1.Lighten(u76, (v34 and 0.5) or 0.7))
                u54.TextTransparency = 1
                u56.Transparency = 1
                local tbl_91 = {TextTransparency = 0}
                local v102 = u3 * 0.25
                local v103 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                v99 = Enum.EasingDirection.Out
                if not (v99) then
                    local _ = Enum.EasingDirection.Out
                end
                TweenService_upv_1:Create(u54, TweenInfo.new(v102, v103, v99, 0, false, 0.7 * u3), tbl_91):Play()
                tbl_91 = {Transparency = 0.4}
                local v104 = u3 * 0.25
                local v105 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                v100 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                TweenService_upv_1:Create(u56, TweenInfo.new(v104, v105, v100, 0, false, 0.7 * u3), tbl_91):Play()
                local named_upv_1 = u75.named
                u57.Visible = named_upv_1
                u58.holder.Visible = named_upv_1
                u59.Visible = named_upv_1
                u61.Visible = named_upv_1 and ((u94.kind == "clutch") and (u94.vs >= 2))
                local v106, v107, v108, v109, v110, v111, v112, v113 = nil, nil, nil, nil, nil, nil, nil, nil
                if named_upv_1 then
                    u57.BackgroundColor3 = u76
                    u57.BackgroundTransparency = 1
                    local tbl_92 = {BackgroundTransparency = 0.15}
                    local v114 = u3 * 0.25
                    local v115 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                    v106 = Enum.EasingDirection.Out
                    if not (v106) then
                        local _ = Enum.EasingDirection.Out
                    end
                    TweenService_upv_1:Create(u57, TweenInfo.new(v114, v115, v106, 0, false, 0.7799999999999999 * u3), tbl_92):Play()
                    if u94.id then
                        v107 = State_upv_1.FindMember(u94.id)
                    else
                        v107 = nil
                    end
                    local v116
                    if v107 then
                        v116 = v107
                    else
                        local tbl_93 = {userId = false}
                        tbl_93.id = u94.id or ""
                        tbl_93.name = u94.name or ""
                        v116 = tbl_93
                    end
                    local stroke_3 = u58.stroke
                    local v117
                    if u73 then
                        v117 = u76:Lerp(Colors_upv_1.Void, 0.2)
                    else
                        v117 = u76
                    end
                    stroke_3.Color = v117
                    u58.scale.Scale = 0
                    local scale_1 = u58.scale
                    local tbl_94 = {Scale = 1}
                    local v118 = u3 * 0.4
                    local v119 = Enum.EasingStyle.Back or (Enum.EasingStyle.Quint)
                    v108 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(scale_1, TweenInfo.new(v118, v119, v108, 0, false, 0.7999999999999999 * u3), tbl_94):Play()
                    local img_3 = u58.img
                    local v120
                    if u73 then
                        v120 = Color3.fromRGB(200, 200, 200)
                    else
                        v120 = Color3.new(1, 1, 1)
                    end
                    portraitWhenGrown(img_3, v116, v120, 1.22, u72)
                    u59.Text = u94.name or tostring(v116.name or "")
                    u59.TextTransparency = 1
                    u60.Transparency = 1
                    local tbl_95 = {TextTransparency = 0}
                    local v122 = u3 * 0.3
                    local v123 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                    v109 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(u59, TweenInfo.new(v122, v123, v109, 0, false, 0.84 * u3), tbl_95):Play()
                    local tbl_96 = {Transparency = 0.35}
                    local v124 = u3 * 0.3
                    local v125 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                    v110 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(u60, TweenInfo.new(v124, v125, v110, 0, false, 0.84 * u3), tbl_96):Play()
                    u62.Text = "1v" .. tostring(u94.vs)
                    u61.BackgroundColor3 = u76:Lerp(Colors_upv_1.Void, (u73 and 0.45) or 0.15)
                    u61.BackgroundTransparency = 1
                    u62.TextTransparency = 1
                    u63.Scale = 0.6
                    local tbl_97 = {BackgroundTransparency = 0.05}
                    local v126 = u3 * 0.22
                    local v127 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                    v111 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(u61, TweenInfo.new(v126, v127, v111, 0, false, 0.8999999999999999 * u3), tbl_97):Play()
                    local tbl_98 = {TextTransparency = 0}
                    local v128 = u3 * 0.22
                    local v129 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
                    v112 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(u62, TweenInfo.new(v128, v129, v112, 0, false, 0.8999999999999999 * u3), tbl_98):Play()
                    local tbl_99 = {Scale = 1}
                    local v130 = u3 * 0.35
                    local v131 = Enum.EasingStyle.Back or (Enum.EasingStyle.Quint)
                    v113 = Enum.EasingDirection.Out or Enum.EasingDirection.Out
                    TweenService_upv_1:Create(u63, TweenInfo.new(v130, v131, v113, 0, false, 0.8999999999999999 * u3), tbl_99):Play()
                end
                u52.Position = UDim2.fromOffset(0, u95 + 16)
                u52.Visible = true
                v107 = {}
                v107.Position = UDim2.fromOffset(0, u95)
                local v132 = u3 * 0.4
                local v133 = Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint)
                v101 = Enum.EasingDirection.Out
                if not (v101) then
                    local _ = Enum.EasingDirection.Out
                end
                TweenService_upv_1:Create(u52, TweenInfo.new(v132, v133, v101, 0, false, 0.7 * u3), v107):Play()
                task.delay(
                    u3 * 0.7,
                    function()
                        --[[
                          line: 1381
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            u52 (copy, index: 3)
                            u53 (copy, index: 4)
                            u51 (copy, index: 5)
                            u77 (copy, index: 6)
                            u76 (copy, index: 7)
                            u95 (copy, index: 8)
                            u73 (copy, index: 9)
                            TweenService_upv_1 (copy, index: 10)
                            u3 (ref,  index: 11)
                            u75 (copy, index: 12)
                            named_upv_1 (copy, index: 13)
                            burst (copy, index: 14)
                            Colors_upv_1 (copy, index: 15)
                            Theme_upv_1 (copy, index: 16)
                            u94 (copy, index: 17)
                            u82 (copy, index: 18)
                            u2 (ref,  index: 19)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        local v134 = u52.AbsoluteSize.X / 900
                        local v135 = ((v134 > 0) and (u53.AbsoluteContentSize.X / v134)) or 420
                        u51.ImageColor3 = u77:Lerp(u76, 0.25)
                        u51.Position = UDim2.fromOffset(0, u95 - 42)
                        u51.Size = UDim2.fromOffset(v135 * 0.5, 92)
                        u51.ImageTransparency = 1
                        local tbl_100 = {ImageTransparency = 0}
                        tbl_100.Size = UDim2.fromOffset(v135 + 260, 92)
                        tbl_100.ImageTransparency = (u73 and 0.3) or 0.15
                        TweenService_upv_1:Create(u51, TweenInfo.new(u3 * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_100):Play()
                        local v136 = (named_upv_1 and 260) or 0
                        local v137 = (u73 and 6) or 16
                        local v138
                        if u73 then
                            v138 = u76:Lerp(Colors_upv_1.Void, 0.3)
                        else
                            v138 = Theme_upv_1.Lighten(u76, 0.3)
                        end
                        burst(v137, v138, (u75.width * 0.58) + v136, 50, (u73 and 360) or 800, {sparkChance = 0.7})
                        local kind_2 = u94.kind
                        local v139 = u82 * 0.75
                        if kind_2 ~= "ace" and kind_2 ~= "teamace" then
                            if kind_2 ~= "clutch" then
                                local tbl_101 = {}
                                tbl_101.volume = v139
                                if u2 then
                                    pcall(u2.Play, "UI/Card_Reveal", nil, tbl_101)
                                end
                            else
                                local tbl_102 = {}
                                tbl_102.volume = v139 * 0.8
                                if u2 then
                                    pcall(u2.Play, "Match/Final_Round", nil, tbl_102)
                                end
                            end
                            return
                        end
                        local tbl_103 = {}
                        tbl_103.volume = v139
                        if not u2 then
                            return
                        end
                        pcall(u2.Play, "Kill_Triple", nil, tbl_103)
                    end
                )
            end
        end
        local v140
        if a66 then
            v140 = 3.35
        elseif u74 then
            v140 = (u73 and 2.95) or 2.85
        else
            v140 = (u73 and 2.05) or 1.95
        end
        task.delay(
            v140 * u3,
            function()
                --[[
                  line: 1410
                  upvalues:
                    u72 (copy, index: 1)
                    u68 (ref,  index: 2)
                    u13 (copy, index: 3)
                    u78 (copy, index: 4)
                    u79 (copy, index: 5)
                    TweenService_upv_1 (copy, index: 6)
                    u3 (ref,  index: 7)
                    u16 (copy, index: 8)
                    u15 (copy, index: 9)
                    u19 (copy, index: 10)
                    u22 (copy, index: 11)
                    u27 (copy, index: 12)
                    u28 (copy, index: 13)
                    u33 (copy, index: 14)
                    u37 (copy, index: 15)
                    u40 (copy, index: 16)
                    u74 (copy, index: 17)
                    u44 (copy, index: 18)
                    u75 (copy, index: 19)
                    ceremonyFade (copy, index: 20)
                    a66 (copy, index: 21)
                    tbl_upv_7 (copy, index: 22)
                    UI_upv_1 (copy, index: 23)
                    u5 (copy, index: 24)
                    u7 (copy, index: 25)
                    screenFxOut (copy, index: 26)
                    u69 (ref,  index: 27)
                    u70 (ref,  index: 28)
                    a1 (copy, index: 29)
                    u64 (copy, index: 30)
                    u52 (copy, index: 31)
                    u43 (copy, index: 32)
                    u51 (copy, index: 33)
                    u24 (copy, index: 34)
                    u17 (copy, index: 35)
                    u4 (copy, index: 36)
                    u66 (ref,  index: 37)
                    u67 (ref,  index: 38)
                ]]
                if u72 ~= u68 then
                    return
                end
                u13.AnchorPoint = Vector2.new(1, 0.5)
                u13.Position = UDim2.fromOffset(u78 / 2, 0)
                local tbl_104 = {ImageTransparency = 0.6}
                tbl_104.Size = UDim2.fromOffset(0, u79)
                TweenService_upv_1:Create(u13, TweenInfo.new(u3 * 0.28, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_104):Play()
                local tbl_105 = {BackgroundTransparency = 1}
                TweenService_upv_1:Create(u16, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_105):Play()
                local tbl_106 = {ImageTransparency = 1}
                tbl_106.Size = UDim2.fromOffset(u78 * 1.3, u79 * 1.2)
                TweenService_upv_1:Create(u15, TweenInfo.new(u3 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_106):Play()
                for _, value_30 in {u19, u22} do
                    local tbl_107 = {TextTransparency = 1}
                    tbl_107.Position = value_30.Position - UDim2.fromOffset(0, 18)
                    TweenService_upv_1:Create(value_30, TweenInfo.new(u3 * 0.24, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_107):Play()
                end
                local tbl_108 = {TextTransparency = 1}
                TweenService_upv_1:Create(u27, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_108):Play()
                tbl_108 = {Transparency = 1}
                TweenService_upv_1:Create(u28, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_108):Play()
                for _, value_31 in {u33, u37} do
                    local tbl_109 = {TextTransparency = 1}
                    TweenService_upv_1:Create(value_31, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_109):Play()
                end
                local tbl_110 = {BackgroundTransparency = 1}
                TweenService_upv_1:Create(u40, TweenInfo.new(u3 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_110):Play()
                if u74 then
                    tbl_110 = {}
                    tbl_110.Position = u44.Position + UDim2.fromOffset(0, -10)
                    TweenService_upv_1:Create(u44, TweenInfo.new(u3 * 0.25, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_110):Play()
                end
                if u74 or u75 then
                    ceremonyFade(0.25)
                end
                if a66 then
                    for _, value_32 in tbl_upv_7 do
                        local tbl_111 = {}
                        tbl_111.Position = value_32.frame.Position + UDim2.fromOffset(0, 40)
                        TweenService_upv_1:Create(value_32.frame, TweenInfo.new(u3 * 0.25, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_111):Play()
                        local tbl_112 = {Scale = 0}
                        local v141 = UI_upv_1.GetScaleObj(value_32.frame)
                        TweenService_upv_1:Create(v141, TweenInfo.new(u3 * 0.25, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u3), tbl_112):Play()
                    end
                    local tbl_113 = {BackgroundTransparency = 1}
                    TweenService_upv_1:Create(u5, TweenInfo.new(u3 * 0.4, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_113):Play()
                end
                tbl_110 = {ImageTransparency = 1}
                TweenService_upv_1:Create(u7, TweenInfo.new(u3 * 0.45, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u3), tbl_110):Play()
                screenFxOut(0.45)
                task.delay(
                    u3 * 0.48,
                    function()
                        --[[
                          line: 1443
                          upvalues:
                            u72 (copy, index: 1)
                            u68 (ref,  index: 2)
                            u69 (ref,  index: 3)
                            u70 (ref,  index: 4)
                            a1 (copy, index: 5)
                            u64 (copy, index: 6)
                            u44 (copy, index: 7)
                            u52 (copy, index: 8)
                            u43 (copy, index: 9)
                            u51 (copy, index: 10)
                            u19 (copy, index: 11)
                            u22 (copy, index: 12)
                            u24 (copy, index: 13)
                            u17 (copy, index: 14)
                            u4 (copy, index: 15)
                            u66 (ref,  index: 16)
                            u67 (ref,  index: 17)
                        ]]
                        if u72 ~= u68 then
                            return
                        end
                        u69 = false
                        if u70 then
                            a1.SetHudHidden("Celebrate", false)
                        end
                        u70 = false
                        u64:Clear()
                        u44.Visible = false
                        u52.Visible = false
                        u43.ImageTransparency = 1
                        u51.ImageTransparency = 1
                        for _, value_33 in {u19, u22, u24, u17} do
                            value_33.MaxVisibleGraphemes = -1
                        end
                        u4.Visible = false
                        if u66 then
                            u66:Destroy()
                            u66 = nil
                        end
                        if not u67 then
                            return
                        end
                        u67:Destroy()
                        u67 = nil
                    end
                )
            end
        )
    end
    a1.OnMatchEvent(
        function(a75, a76)
            --[[
              line: 1460
              upvalues:
                State_upv_1 (copy, index: 1)
                u3 (ref,  index: 2)
                play (copy, index: 3)
                readMoment (copy, index: 4)
                stop (copy, index: 5)
            ]]
            if type(a76) ~= "table" then
                local tbl_114 = {}
                a76 = tbl_114
            end
            local v142, v143 = nil, nil
            if a75 == "RoundEnd" then
                local v144 = a76.winnerTeam
                v142 = State_upv_1.Match
                local v145 = State_upv_1.MyTeam()
                local v146 = v142 and v142.teams and v142.teams[v145] and v142.teams[v145].score or 0
                local v147 = v142 and v142.teams and v142.teams[3 - v145] and v142.teams[3 - v145].score or 0
                local v148, v149
                if v142 and v142.phase ~= "RoundEnd" and (v144 == 1 or v144 == 2) then
                    if v144 ~= v145 then
                        v147 = v147 + 1
                    else
                        v146 = v146 + 1
                    end
                    v148, v149 = v146, v147
                elseif v144 == v145 then
                    v148, v149 = math.max(0, v146 - 1), v147
                elseif v144 ~= 3 - v145 then
                    v148, v149 = v146, v147
                else
                    v148, v149 = v146, math.max(0, v147 - 1)
                end
                local v150
                if v144 == 0 or v144 == nil then
                    v150 = "draw"
                else
                    v150 = ((v144 ~= v145) and "lose") or "win"
                end
                v143 = State_upv_1.RoundsToWin()
                v144 = true
                if not (v143 <= v146) then
                    v144 = v143 <= v147
                end
                u3 = 1
                play(v150, v144, v146, v147, v148, v149, a76.round or (v142 and (v142.round)), a76.mvpId, (readMoment(a76.moment)))
            elseif a75 == "PlayOfTheGame" or a75 == "MatchEnd" or a75 == "MatchStart" or a75 == "RoundStart" then
                stop(false)
            end
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function(a77)
            --[[
              line: 1492
              upvalues:
                u69 (ref,  index: 1)
                u68 (ref,  index: 2)
                u70 (ref,  index: 3)
                a1 (copy, index: 4)
                u64 (copy, index: 5)
                u44 (copy, index: 6)
                u52 (copy, index: 7)
                u43 (copy, index: 8)
                u51 (copy, index: 9)
                u19 (copy, index: 10)
                u22 (copy, index: 11)
                u24 (copy, index: 12)
                u17 (copy, index: 13)
                u4 (copy, index: 14)
                u66 (ref,  index: 15)
                u67 (ref,  index: 16)
            ]]
            if a77 == "Match" or not u69 then
                return
            end
            u68 = u68 + 1
            u69 = false
            if u70 then
                a1.SetHudHidden("Celebrate", false)
            end
            u70 = false
            u64:Clear()
            u44.Visible = false
            u52.Visible = false
            u43.ImageTransparency = 1
            u51.ImageTransparency = 1
            for _, value_34 in {u19, u22, u24, u17} do
                value_34.MaxVisibleGraphemes = -1
            end
            u4.Visible = false
            if u66 then
                u66:Destroy()
                u66 = nil
            end
            if u67 then
                u67:Destroy()
                u67 = nil
            end
        end
    )
    a1.Debug.celebrate = function(a78, a79, a80, a81, a82)
        --[[
          line: 1499
          upvalues:
            u3 (ref,  index: 1)
            play (copy, index: 2)
            State_upv_1 (copy, index: 3)
        ]]
        local v151
        if type(a82) == "number" and (a82 > 0) then
            v151 = a82
        else
            v151 = 1
        end
        u3 = v151
        if a78 == "lose" or a78 == "draw" then
            v151 = a78
        else
            v151 = "win"
        end
        local v152 = tonumber(a80) or (((v151 ~= "win") and 0) or 1)
        local v153 = tonumber(a81) or (((v151 ~= "lose") and 0) or 1)
        local v154
        if v151 ~= "win" then
            v154 = v152
        else
            v154 = math.max(0, v152 - 1)
        end
        local v155
        if v151 ~= "lose" then
            v155 = v153
        else
            v155 = math.max(0, v153 - 1)
        end
        play(v151, a79 == true, v152, v153, v154, v155, 1, State_upv_1.MyId())
        return true
    end
    a1.Debug.celebrateStop = function()
        --[[
          line: 1509
          upvalues:
            u69 (ref,  index: 1)
            u68 (ref,  index: 2)
            u70 (ref,  index: 3)
            a1 (copy, index: 4)
            u64 (copy, index: 5)
            u44 (copy, index: 6)
            u52 (copy, index: 7)
            u43 (copy, index: 8)
            u51 (copy, index: 9)
            u19 (copy, index: 10)
            u22 (copy, index: 11)
            u24 (copy, index: 12)
            u17 (copy, index: 13)
            u4 (copy, index: 14)
            u66 (ref,  index: 15)
            u67 (ref,  index: 16)
        ]]
        if u69 then
            u68 = u68 + 1
            u69 = false
            if u70 then
                a1.SetHudHidden("Celebrate", false)
            end
            u70 = false
            u64:Clear()
            u44.Visible = false
            u52.Visible = false
            u43.ImageTransparency = 1
            u51.ImageTransparency = 1
            for _, value_35 in {u19, u22, u24, u17} do
                value_35.MaxVisibleGraphemes = -1
            end
            u4.Visible = false
            if u66 then
                u66:Destroy()
                u66 = nil
            end
            if u67 then
                u67:Destroy()
                u67 = nil
            end
        end
        return true
    end
    a1.Debug.ceremony = function(a83, a84, a85, a86)
        --[[
          line: 1516
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_2 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            readMoment (copy, index: 4)
            play (copy, index: 5)
        ]]
        local v156
        if type(a86) == "number" and (a86 > 0) then
            v156 = a86
        else
            v156 = 1
        end
        u3 = v156
        if type(a83) == "string" and (tbl_upv_2[a83]) then
            v156 = a83
        else
            v156 = "ace"
        end
        local v157 = State_upv_1.MyTeam()
        local v158
        if a84 ~= "enemy" then
            v158 = v157
        else
            v158 = 3 - v157
        end
        local v159 = nil
        local v160 = State_upv_1.Match
        local v161 = v160 and (v160.teams and (v160.teams[v158]))
        local v162 = v161 and v161.members or {}
        for _, value_36 in v162 do
            if v159 == nil or value_36.id == State_upv_1.MyId() then
                v159 = value_36
            end
        end
        local Match_2 = State_upv_1.Match
        local v163 = (Match_2 and (Match_2.round)) or 2
        local v164 = State_upv_1.RoundsToWin()
        local v165 = v158 == v157
        if (a85) and (v165) then
            v157 = v164
        else
            v157 = 1
        end
        if not (a85) or v165 then
            v160 = 1
        else
            v160 = v164
        end
        local tbl_115 = {name = 0, vs = 0, id = 0, team = 0}
        tbl_115.kind = v156
        local v166
        if v159 then
            v166 = v159.id
        else
            v166 = false
        end
        tbl_115.id = v166
        tbl_115.name = ((not v159) and "Player") or (v159.name)
        tbl_115.team = v158
        tbl_115.vs = ((v156 ~= "clutch") and 0) or 2
        local v167 = readMoment(tbl_115)
        tbl_115 = (v165 and "win") or "lose"
        v166 = a85 == true
        local v168
        if v165 then
            v168 = v157 - 1
        else
            v168 = v157
        end
        local v169
        if v165 then
            v169 = v160
        else
            v169 = v160 - 1
        end
        play(tbl_115, v166, v157, v160, v168, v169, v163, nil, v167)
        return true
    end
    a1.Debug.ceremonyState = function()
        --[[
          line: 1544
          upvalues:
            u69 (ref,  index: 1)
            u4 (copy, index: 2)
            u19 (copy, index: 3)
            u27 (copy, index: 4)
            u44 (copy, index: 5)
            u46 (copy, index: 6)
            u48 (copy, index: 7)
            u49 (copy, index: 8)
            u52 (copy, index: 9)
            u54 (copy, index: 10)
            u59 (copy, index: 11)
        ]]
        local tbl_116 = {vs = 0, accolade = 0, accoladeName = 0, caption = 0, plate = 0, plateName = 0, headline = 0}
        tbl_116.active = u69
        local v170
        if u4.Visible then
            v170 = u19.Text
        else
            v170 = false
        end
        tbl_116.headline = v170
        if (u4.Visible) and (u27.Visible) then
            v170 = u27.Text
        else
            v170 = false
        end
        tbl_116.caption = v170
        tbl_116.plate = u44.Visible
        if (u44.Visible) and (u46.Visible) then
            v170 = u46.Text
        else
            v170 = false
        end
        tbl_116.plateName = v170
        if (u44.Visible) and (u48.Visible) then
            v170 = u49.Text
        else
            v170 = false
        end
        tbl_116.vs = v170
        if u52.Visible then
            v170 = u54.Text
        else
            v170 = false
        end
        tbl_116.accolade = v170
        if (u52.Visible) and (u59.Visible) then
            v170 = u59.Text
        else
            v170 = false
        end
        tbl_116.accoladeName = v170
        return tbl_116
    end
end
return tbl_1