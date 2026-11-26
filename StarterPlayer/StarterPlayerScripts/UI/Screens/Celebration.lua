local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local v5 = {}
local fontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local v7 = {ace = {word = "ACE", named = true, style = "stamp", headS = 2.05, lead = 0}, teamace = {word = "TEAM ACE", named = false, style = "stamp", headS = 1.5, lead = 4}, flawless = {word = "FLAWLESS", named = false, style = "shine", headS = 1.5, lead = 0}, clutch = {word = "CLUTCH", named = true, style = "hold", headS = 1.8, lead = 0}}

for _, v9 in v7 do
    local parts = {}
    local total = 0
    local total2 = 0
    v9.centres, v9.ends = {}, {}

    for index = 1, #v9.word do
        local substring = string.sub(v9.word, index, index)

        if substring == " " then
            table.insert(parts, "   ")
            total += 3
            total2 += 72
        else
            if 1 < index and string.sub(v9.word, index - 1, index - 1) ~= " " then
                table.insert(parts, " ")
                total += 1
                total2 += 24
            end

            table.insert(parts, substring)
            total += 1
            table.insert(v9.ends, total)
            table.insert(v9.centres, total2 + 21.5)
            total2 += 43
        end
    end

    v9.text = table.concat(parts)
    v9.width = total2
end

local function readMoment(a16)
    --[[
      name: readMoment
      line: 94
      upvalues:
        v7 (copy, index: 1)
    ]]
    if type(a16) ~= "table" or type(a16.kind) ~= "string" or not v7[a16.kind] then
        return nil
    end

    local id
    local name
    local vs
    local number = tonumber(a16.team)

    if number ~= 1 and number ~= 2 then
        return nil
    end

    local v21 = {kind = a16.kind}

    if type(a16.id) ~= "string" then
        id = nil
    else
        id = a16.id
    end

    v21.id = id

    if type(a16.name) == "string" and a16.name ~= "" then
        name = string.sub(a16.name, 1, 32)
    else
        name = nil
    end

    v21.name = name
    v21.team = number

    if type(a16.vs) ~= "number" then
        vs = 0
    else
        vs = math.clamp(math.floor(a16.vs), 0, 9)
    end

    v21.vs = vs

    return v21
end

function v5.Init(a22)
    --[[
      name: Init
      line: 111
      upvalues:
        replicatedStorage (copy, index: 1)
        tweenService (copy, index: 2)
        fontFace (copy, index: 3)
        lighting (copy, index: 4)
        runService (copy, index: 5)
        v7 (copy, index: 6)
        readMoment (copy, index: 7)
    ]]
    local result
    local ui = a22.UI
    local theme = a22.Theme
    local state = a22.State
    local portraits = a22.Portraits
    local colors = theme.Colors
    local fonts = theme.Fonts
    local v30 = ui.Assets.Fx or {}
    local sfx = replicatedStorage:WaitForChild("Shared"):FindFirstChild("Sfx")

    local success, result2 = pcall(
        function()
            --[[
              line: 120
              upvalues:
                sfx (copy, index: 1)
            ]]
            if sfx then
                return (require(sfx))
            end

            return nil
        end
    )

    if not success or type(result2) ~= "table" then
        result = nil
    else
        result = result2
    end

    local function playSfx(a35, a36)
        --[[
          name: playSfx
          line: 125
          upvalues:
            result (ref, index: 1)
        ]]
        if result then
            pcall(result.Play, a35, nil, a36)
        end
    end

    if result and result.Preload then
        pcall(result.Preload, {"Match/Elimination", "Kill_Triple", "Kill_Ally", "Match/Final_Round", "Match/Final_Heartbeat", "UI/Card_Reveal"})
    end

    local pace = 1

    local function tw(instance, a40, propertyTable, easingStyle: Enum.EasingStyle, out2: Enum.EasingDirection, a44)
        --[[
          name: tw
          line: 136
          upvalues:
            tweenService (copy, index: 1)
            pace (ref,  index: 2)
        ]]
        local newTweenInfo = TweenInfo.new
        local v46 = a40 * pace
        local easingStyle2 = easingStyle or Enum.EasingStyle.Quint
        local out = out2 or Enum.EasingDirection.Out
        local tween = tweenService:Create(instance, newTweenInfo(v46, easingStyle2, out, 0, false, (a44 or 0) * pace), propertyTable)
        tween:Play()

        return tween
    end

    local function after(a51, a52)
        --[[
          name: after
          line: 141
          upvalues:
            pace (ref, index: 1)
        ]]
        task.delay(a51 * pace, a52)
    end

    local parent = ui.new("Frame", {Name = "Celebration", ZIndex = 5, Visible = false, Size = UDim2.fromScale(1, 1), Parent = a22.Canvas.Overlay})
    local instance = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = parent})
    local instance2 = ui.new("Frame", {Name = "Flash", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Ally, Parent = parent})
    local instance3 = ui.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Image = v30.Vignette
        or "", ScaleType = Enum.ScaleType.Stretch, Parent = parent})
    local parent2 = ui.new("Frame", {Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.36), Size = UDim2.fromOffset(0, 0), Parent = parent})
    local ui2 = ui.new("UIScale", {Name = "StageScale", Parent = parent2})
    local parent3 = ui.new("Frame", {Name = "Shaker", Size = UDim2.fromOffset(0, 0), Parent = parent2})
    local instance4 = ui.new("ImageLabel", {Name = "Glow", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1000, 340), Image = ui.Assets.Icons.Glow, Parent = parent3})
    local instance5 = ui.new("ImageLabel", {Name = "Ring", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(100, 100), Image = v30.Ring
        or "", Parent = parent3})
    local instance6 = ui.new("ImageLabel", {Name = "Band", ImageTransparency = 0.1, ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(0, 150), Image = v30.Band
        or "", ScaleType = Enum.ScaleType.Stretch, Parent = parent3})
    local ui3 = ui.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.14, 0.04), NumberSequenceKeypoint.new(0.86, 0.04), NumberSequenceKeypoint.new(1, 1)}), Parent = instance6})
    local instance7 = ui.new("ImageLabel", {Name = "GhostBand", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 230), Image = v30.Band
        or "", ScaleType = Enum.ScaleType.Stretch, Parent = parent3})
    ui.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.2), NumberSequenceKeypoint.new(0.75, 0.2), NumberSequenceKeypoint.new(1, 1)}), Parent = instance7})
    local instance8 = ui.new("Frame", {Name = "Edge", BorderSizePixel = 0, ZIndex = 3, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(0, 5), Parent = parent3})
    ui.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0), NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = instance8})

    local function headlineLabel(name: string, zIndex: number)
        --[[
          name: headlineLabel
          line: 251
          upvalues:
            ui (copy, index: 1)
            fontFace (copy, index: 2)
            colors (copy, index: 3)
            parent3 (copy, index: 4)
        ]]
        return ui.new("TextLabel", {Text = "", TextSize = 100, TextTransparency = 1, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1400, 120), FontFace = fontFace, TextColor3 = colors.Text, ZIndex = zIndex, Parent = parent3})
    end

    local instance9 = headlineLabel("Aura", 4)
    local instance10 = ui.new("UIScale", {Name = "HeadScale", Parent = instance9})
    local instance11 = headlineLabel("Headline", 5)
    local ui4 = ui.new("UIScale", {Name = "HeadScale", Parent = instance11})
    local ui5 = ui.new("UIGradient", {Rotation = 90, Parent = instance11})
    local instance12 = headlineLabel("Shadow", 4)
    instance12.TextColor3 = colors.Void
    local ui6 = ui.new("UIScale", {Name = "HeadScale", Parent = instance12})
    local parent4 = headlineLabel("Sweep", 6)
    local ui7 = ui.new("UIScale", {Name = "HeadScale", Parent = parent4})
    local instance13 = ui.new("UIGradient", {Rotation = 18, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.44, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.56, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = parent4})
    local instance14 = ui.new("TextLabel", {Name = "Caption", Text = "", TextSize = 26, TextTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(700, 32), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent3})
    local instance15 = ui.TextStroke(colors.Void, 1.5, 0.5)
    instance15.Parent = instance14
    local instance16 = ui.new("Frame", {Name = "Score", AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(300, 80), Parent = parent3})
    local ui8 = ui.new("UIScale", {Parent = instance16})

    local function digitSlot(a84: number)
        --[[
          name: digitSlot
          line: 312
          upvalues:
            ui (copy, index: 1)
            instance16 (copy, index: 2)
            fontFace (copy, index: 3)
            colors (copy, index: 4)
        ]]
        local parent = ui.new("Frame", {ClipsDescendants = true, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, a84, 0.5, 0), Size = UDim2.fromOffset(90, 80), Parent = instance16})
        local ui2 = ui.new("UIScale", {Parent = parent})

        local function digit()
            --[[
              name: digit
              line: 322
              upvalues:
                ui (copy, index: 1)
                fontFace (copy, index: 2)
                colors (copy, index: 3)
                parent (copy, index: 4)
            ]]
            return (ui.new("TextLabel", {Text = "0", TextSize = 72, ZIndex = 6, Size = UDim2.fromScale(1, 1), FontFace = fontFace, TextColor3 = colors.Text, Parent = parent}))
        end

        return parent, digit(), digit(), ui2
    end

    local v88, instance40, instance41, instance42 = digitSlot(-76)
    local v92, instance43, instance44, instance45 = digitSlot(76)
    local instance17 = ui.new("Frame", {Name = "Dash", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(34, 6), BackgroundColor3 = colors.TextDim, ZIndex = 6, (ui.Corner(3)), Parent = instance16})
    local parent5 = ui.new("Frame", {Name = "Team", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(480, 170), Parent = parent3})
    local v98 = {}

    for index = 1, 3 do
        local ui9 = ui.new("Frame", {ZIndex = 6, Name = "P" .. index, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, (index - 2) * 150, 0, 0), Size = UDim2.fromOffset(124, 168), Parent = parent5})
        local ui10 = ui.new("ImageLabel", {Name = "Img", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(112, 112), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.1, ScaleType = Enum.ScaleType.Crop, ZIndex = 6, (ui.Corner(theme.Radius.Pill)), Parent = ui9})
        local stroke = ui.Stroke(colors.Ally, 3, 0)
        stroke.Parent = ui10
        local ui11 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextSize = 20, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 120), Size = UDim2.fromOffset(150, 26), FontFace = fonts.Bold, TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui9})
        ui.TextStroke(colors.Void, 1.5, 0.4).Parent = ui11
        v98[index] = {frame = ui9, img = ui10, name = ui11, star = ui.Image(ui.Assets.Icons.Star, {Name = "Star", Visible = false, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 44, 0, 10), Size = UDim2.fromOffset(34, 34), ImageColor3 = colors.Gold, Parent = ui9}), stroke = stroke}
    end

    local instance18 = ui.new("ImageLabel", {Name = "CeremonyFlare", ImageTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(820, 56), Image = v30.Flare
        or "", Parent = parent3})
    local instance19 = ui.new("Frame", {Name = "CeremonyPlate", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 66), BackgroundColor3 = colors.Panel, BackgroundTransparency = 1, Visible = false, ZIndex = 5, (ui.Corner(theme.Radius.Pill)), Parent = parent3})
    local v106 = ui.Padding(0, 22, 0, 5)
    v106.Parent = instance19

    local instance20 = ui.Stroke(colors.Ally, 2, 1)
    instance20.Parent = instance19
    ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 14), Parent = instance19})

    local function face(parent, a110: number, layoutOrder: number)
        --[[
          name: face
          line: 449
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            theme (copy, index: 3)
        ]]
        local ui2 = ui.new("Frame", {ZIndex = 6, Name = "Face" .. layoutOrder, Size = UDim2.fromOffset(a110, a110), LayoutOrder = layoutOrder, Parent = parent})
        local ui3 = ui.new("ImageLabel", {Name = "Img", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.1, ScaleType = Enum.ScaleType.Crop, ZIndex = 6, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local stroke = ui.Stroke(colors.Ally, 3, 0)
        stroke.Parent = ui3

        return {holder = ui2, img = ui3, stroke = stroke, scale = ui.new("UIScale", {Parent = ui2})}
    end

    local v115 = {[1] = face(instance19, 56, 1), [2] = face(instance19, 56, 2), [3] = face(instance19, 56, 3)}

    local function nameLabel(parent, textSize: number, layoutOrder: number)
        --[[
          name: nameLabel
          line: 469
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local parent2 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextTransparency = 1, ZIndex = 6, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, textSize + 8), FontFace = fonts.Heavy, TextSize = textSize, TextColor3 = colors.Text, LayoutOrder = layoutOrder, Parent = parent})
        local v121 = ui.TextStroke(colors.Void, 2, 1)
        v121.Parent = parent2

        return parent2, v121
    end

    local function vsPill(parent, a124: number, textSize: number, layoutOrder: number)
        --[[
          name: vsPill
          line: 488
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            theme (copy, index: 3)
            fontFace (copy, index: 4)
        ]]
        local parent2 = ui.new("Frame", {Name = "Vs", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a124), BackgroundColor3 = colors.Ally, BackgroundTransparency = 1, LayoutOrder = layoutOrder, ZIndex = 6, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 12, 0, 12)), Parent = parent})
        local ui2 = ui.new("TextLabel", {Name = "Text", Text = "", TextTransparency = 1, ZIndex = 7, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fontFace, TextSize = textSize, TextColor3 = colors.Text, Parent = parent2})
        local parent3 = parent2

        return parent3, ui2, ui.new("UIScale", {Parent = parent2})
    end

    local instance21, instance22 = nameLabel(instance19, 36, 4)
    local instance23, instance24, instance25 = vsPill(instance19, 34, 26, 5)
    local instance26 = ui.new("ImageLabel", {Name = "CeremonyRibbon", ImageTransparency = 1, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 92), Image = v30.Band
        or "", ScaleType = Enum.ScaleType.Stretch, Parent = parent3})
    ui.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.16, 0), NumberSequenceKeypoint.new(0.84, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = instance26})
    local instance27 = ui.new("Frame", {Name = "CeremonyAccolade", Visible = false, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(900, 84), Parent = parent3})
    local ui12 = ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 20), Parent = instance27})
    local instance28 = ui.new("TextLabel", {Name = "Word", AutoLocalize = false, Text = "", TextSize = 80, TextTransparency = 1, LayoutOrder = 1, ZIndex = 6, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 84), FontFace = fontFace, TextColor3 = colors.Text, Parent = instance27})
    local ui13 = ui.new("UIGradient", {Rotation = 90, Parent = instance28})
    local instance29 = ui.TextStroke(colors.Void, 2, 1)
    instance29.Parent = instance28
    local instance30 = ui.new("Frame", {Name = "Bar", Size = UDim2.fromOffset(4, 46), BackgroundColor3 = colors.Ally, BackgroundTransparency = 1, LayoutOrder = 2, ZIndex = 6, (ui.Corner(2)), Parent = instance27})
    local v142 = face(instance27, 58, 3)
    local instance31, instance32 = nameLabel(instance27, 38, 4)
    local instance33, instance34, instance35 = vsPill(instance27, 34, 26, 5)
    local ui14 = ui.new("Frame", {Name = "Particles", ZIndex = 7, Size = UDim2.fromOffset(0, 0), Parent = parent3})
    local v149 = require(script.Parent.Parent.Fx).Pool(ui14, 72, 7)
    local random = Random.new()

    local function burst(a152, color, x, y, speed, options)
        --[[
          name: burst
          line: 593
          upvalues:
            v149 (copy, index: 1)
            pace (ref,  index: 2)
            colors (copy, index: 3)
        ]]
        local v158 = options or {}
        v149.Pace = pace
        v149:Burst(a152, {mode = "box", whiteChance = 0.35, box = Vector2.new(x, y), speed = speed, color = color, white = colors.Text, sparkChance = v158.sparkChance
            or 0.55, grav = v158.grav, drag = v158.drag, base = v158.base, lifeMult = v158.lifeMult})
    end

    local function clearParticles()
        --[[
          name: clearParticles
          line: 610
          upvalues:
            v149 (copy, index: 1)
        ]]
        v149:Clear()
    end

    local ui15 = nil
    local ui16 = nil

    local function screenFx(a163, visible: boolean)
        --[[
          name: screenFx
          line: 617
          upvalues:
            ui15 (ref,  index: 1)
            ui (copy, index: 2)
            lighting (copy, index: 3)
            tweenService (copy, index: 4)
            pace (ref,  index: 5)
            ui16 (ref,  index: 6)
        ]]
        ui15 = ui15 or ui.new("ColorCorrectionEffect", {Name = "TR_CelebrateCC", Parent = lighting})
        local instance = ui15
        instance.Enabled = true
        instance.Brightness, instance.Contrast, instance.Saturation, instance.TintColor = 0, 0, 0, Color3.new(1, 1, 1)

        if a163 == "win" then
            local propertyTable = {Contrast = 0.12, Saturation = 0.18, TintColor = Color3.fromRGB(236, 244, 255)}
            tweenService:Create(instance, TweenInfo.new(pace * 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        elseif a163 == "lose" then
            local propertyTable = {Contrast = 0.05, Saturation = -0.65, Brightness = -0.05, TintColor = Color3.fromRGB(255, 232, 232)}
            tweenService:Create(instance, TweenInfo.new(pace * 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        else
            local propertyTable = {Saturation = -0.3, Brightness = -0.02}
            tweenService:Create(instance, TweenInfo.new(pace * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        if visible then
            ui16 = ui16 or ui.new("BlurEffect", {Name = "TR_CelebrateBlur", Size = 0, Parent = lighting})
            local instance2 = ui16
            instance2.Enabled = true
            instance2.Size = 0
            local propertyTable = {Size = 10}
            tweenService:Create(instance2, TweenInfo.new(pace * 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end
    end

    local function screenFxOut(a172: number)
        --[[
          name: screenFxOut
          line: 642
          upvalues:
            ui15 (ref,  index: 1)
            tweenService (copy, index: 2)
            pace (ref,  index: 3)
            ui16 (ref,  index: 4)
        ]]
        if ui15 then
            local instance = ui15
            local propertyTable = {Contrast = 0, Saturation = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1)}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v177 = a172 * pace
            local easingStyle = quad or Enum.EasingStyle.Quint
            local tween = tweenService:Create(instance, newTweenInfo(v177, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
            tween:Play()
        end

        if ui16 then
            local instance = ui16
            local propertyTable = {Size = 0}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v184 = a172 * pace
            local easingStyle = quad or Enum.EasingStyle.Quint
            local tween = tweenService:Create(instance, newTweenInfo(v184, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
            tween:Play()
        end
    end

    local function screenFxOff()
        --[[
          name: screenFxOff
          line: 650
          upvalues:
            ui15 (ref, index: 1)
            ui16 (ref, index: 2)
        ]]
        if ui15 then
            ui15:Destroy()
            ui15 = nil
        end

        if ui16 then
            ui16:Destroy()
            ui16 = nil
        end
    end

    local count = 0
    local active = false
    local v190 = false

    local function setDigits(digits, a193, a194, textColor3)
        --[[
          name: setDigits
          line: 666
        ]]
        digits.Text = tostring(a194)
        digits.Position = UDim2.new()
        digits.TextColor3 = textColor3
        digits.TextTransparency = 0
        a193.Visible = false
    end

    local function rollDigit(a197, instance, instance2, instance3, a201, textColor3)
        --[[
          name: rollDigit
          line: 674
          upvalues:
            tweenService (copy, index: 1)
            pace (ref,  index: 2)
        ]]
        instance2.Text = tostring(a201)
        instance2.TextColor3 = textColor3
        instance2.Visible = true
        instance2.TextTransparency = 0
        instance2.Position = UDim2.fromScale(0, 1)
        local propertyTable = {Position = UDim2.fromScale(0, -1)}
        local quint = Enum.EasingStyle.Quint
        local inValue = Enum.EasingDirection.In
        local newTweenInfo = TweenInfo.new
        local v207 = pace * 0.28
        local quint2 = quint or Enum.EasingStyle.Quint
        local easingDirection = inValue or Enum.EasingDirection.Out
        tweenService:Create(instance, newTweenInfo(v207, quint2, easingDirection, 0, false, 0 * pace), propertyTable):Play()
        local propertyTable2 = {Position = UDim2.new()}
        local back = Enum.EasingStyle.Back
        local out = Enum.EasingDirection.Out
        newTweenInfo = TweenInfo.new
        local v213 = pace * 0.34
        local easingStyle = back or Enum.EasingStyle.Quint
        local out2 = out or Enum.EasingDirection.Out
        tweenService:Create(instance2, newTweenInfo(v213, easingStyle, out2, 0, false, 0.08 * pace), propertyTable2):Play()

        local v216 = function()
            --[[
              line: 682
              upvalues:
                instance (copy, index: 1)
                a201 (copy, index: 2)
                textColor3 (copy, index: 3)
                instance2 (copy, index: 4)
                instance3 (copy, index: 5)
                tweenService (copy, index: 6)
                pace (ref,  index: 7)
            ]]
            instance.Text = tostring(a201)
            instance.TextColor3 = textColor3
            instance.Position = UDim2.new()
            instance2.Visible = false
            instance3.Scale = 1.35
            local propertyTable = {Scale = 1}
            local back = Enum.EasingStyle.Back
            local newTweenInfo = TweenInfo.new
            local v220 = pace * 0.35
            local easingStyle = back or Enum.EasingStyle.Quint
            tweenService:Create(instance3, newTweenInfo(v220, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        task.delay(pace * 0.42, v216)
    end

    local function shake(a223, a224)
        --[[
          name: shake
          line: 694
          upvalues:
            count (ref,  index: 1)
            pace (ref,  index: 2)
            parent3 (copy, index: 3)
            random (copy, index: 4)
            runService (copy, index: 5)
        ]]
        local v225 = count

        task.spawn(
            function()
                --[[
                  line: 696
                  upvalues:
                    a224 (copy, index: 1)
                    pace (ref,  index: 2)
                    v225 (copy, index: 3)
                    count (ref,  index: 4)
                    parent3 (copy, index: 5)
                    random (copy, index: 6)
                    a223 (copy, index: 7)
                    runService (copy, index: 8)
                ]]
                local timestamp = os.clock()

                while os.clock() - timestamp < a224 * pace and v225 == count do
                    local v227 = 1 - (os.clock() - timestamp) / (a224 * pace)
                    parent3.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * a223) * v227, (random:NextNumber(-1, 1) * a223) * v227)
                    runService.RenderStepped:Wait()
                end

                parent3.Position = UDim2.new()
            end
        )
    end

    local function ceremonyOff()
        --[[
          name: ceremonyOff
          line: 708
          upvalues:
            instance19 (copy, index: 1)
            instance27 (copy, index: 2)
            instance18 (copy, index: 3)
            instance26 (copy, index: 4)
            instance11 (copy, index: 5)
            instance12 (copy, index: 6)
            parent4 (copy, index: 7)
            instance9 (copy, index: 8)
        ]]
        instance19.Visible = false
        instance27.Visible = false
        instance18.ImageTransparency = 1
        instance26.ImageTransparency = 1

        for _, v230 in {instance11, instance12, parent4, instance9} do
            v230.MaxVisibleGraphemes = -1
        end
    end

    local function ceremonyFade(a232: number)
        --[[
          name: ceremonyFade
          line: 718
          upvalues:
            instance21 (copy, index: 1)
            instance24 (copy, index: 2)
            instance28 (copy, index: 3)
            instance31 (copy, index: 4)
            instance34 (copy, index: 5)
            tweenService (copy, index: 6)
            pace (ref,  index: 7)
            instance22 (copy, index: 8)
            instance29 (copy, index: 9)
            instance32 (copy, index: 10)
            instance23 (copy, index: 11)
            instance33 (copy, index: 12)
            instance30 (copy, index: 13)
            instance19 (copy, index: 14)
            instance20 (copy, index: 15)
            v115 (copy, index: 16)
            v142 (copy, index: 17)
            instance18 (copy, index: 18)
            instance26 (copy, index: 19)
        ]]
        for _, instance in {instance21, instance24, instance28, instance31, instance34} do
            local propertyTable = {TextTransparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v238 = a232 * pace
            local easingStyle = quad or Enum.EasingStyle.Quint
            tweenService:Create(instance, newTweenInfo(v238, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        for _, instance in {instance22, instance29, instance32} do
            local easingStyle
            local propertyTable = {Transparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v246 = a232 * pace
            easingStyle = if const quad2 = quad then quad2 else Enum.EasingStyle.Quint
            tweenService:Create(instance, newTweenInfo(v246, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        for _, instance in {instance23, instance33} do
            local easingStyle
            local propertyTable = {BackgroundTransparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v254 = a232 * pace
            easingStyle = if const quad3 = quad then quad3 else Enum.EasingStyle.Quint
            tweenService:Create(instance, newTweenInfo(v254, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        local propertyTable = {BackgroundTransparency = 1}
        local quad = Enum.EasingStyle.Quad
        local newTweenInfo = TweenInfo.new
        local v259 = a232 * pace
        local easingStyle = quad or Enum.EasingStyle.Quint
        tweenService:Create(instance30, newTweenInfo(v259, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        local propertyTable2 = {BackgroundTransparency = 1}
        local quad4 = Enum.EasingStyle.Quad
        local newTweenInfo2 = TweenInfo.new
        local v264 = a232 * pace
        local easingStyle2 = quad4 or Enum.EasingStyle.Quint
        tweenService:Create(instance19, newTweenInfo2(v264, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
        local propertyTable3 = {Transparency = 1}
        local quad5 = Enum.EasingStyle.Quad
        local newTweenInfo3 = TweenInfo.new
        local v269 = a232 * pace
        local easingStyle3 = quad5 or Enum.EasingStyle.Quint
        tweenService:Create(instance20, newTweenInfo3(v269, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()

        for _, v272 in {v115[1], v115[2], v115[3], v142} do
            local scale = v272.scale
            local propertyTable4 = {Scale = 0}
            local quint = Enum.EasingStyle.Quint
            local inValue = Enum.EasingDirection.In
            local newTweenInfo4 = TweenInfo.new
            local v278 = a232 * pace
            local quint2 = quint or Enum.EasingStyle.Quint
            local easingDirection = inValue or Enum.EasingDirection.Out
            local tween = tweenService:Create(scale, newTweenInfo4(v278, quint2, easingDirection, 0, false, 0 * pace), propertyTable4)
            tween:Play()
        end

        local propertyTable5 = {ImageTransparency = 1}
        local quad6 = Enum.EasingStyle.Quad
        local newTweenInfo5 = TweenInfo.new
        local v285 = a232 * pace
        local easingStyle4 = quad6 or Enum.EasingStyle.Quint
        tweenService:Create(instance18, newTweenInfo5(v285, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable5):Play()
        local propertyTable6 = {ImageTransparency = 1}
        local quad7 = Enum.EasingStyle.Quad
        local newTweenInfo6 = TweenInfo.new
        local v290 = a232 * pace
        local easingStyle5 = quad7 or Enum.EasingStyle.Quint
        tweenService:Create(instance26, newTweenInfo6(v290, easingStyle5, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable6):Play()
    end

    local function stop(a293: boolean)
        --[[
          name: stop
          line: 738
          upvalues:
            active (ref,  index: 1)
            count (ref,  index: 2)
            v190 (ref,  index: 3)
            a22 (copy, index: 4)
            v149 (copy, index: 5)
            instance19 (copy, index: 6)
            instance27 (copy, index: 7)
            instance18 (copy, index: 8)
            instance26 (copy, index: 9)
            instance11 (copy, index: 10)
            instance12 (copy, index: 11)
            parent4 (copy, index: 12)
            instance9 (copy, index: 13)
            parent (copy, index: 14)
            ui15 (ref,  index: 15)
            ui16 (ref,  index: 16)
            instance14 (copy, index: 17)
            tweenService (copy, index: 18)
            pace (ref,  index: 19)
            instance15 (copy, index: 20)
            instance6 (copy, index: 21)
            instance7 (copy, index: 22)
            instance3 (copy, index: 23)
            instance (copy, index: 24)
            ceremonyFade (copy, index: 25)
            screenFxOut (copy, index: 26)
        ]]
        if not active then
            return
        end

        count += 1
        local v294 = count
        active = false

        if v190 then
            a22.SetHudHidden("Celebrate", false)
        end

        v190 = false

        if a293 then
            v149:Clear()
            instance19.Visible = false
            instance27.Visible = false
            instance18.ImageTransparency = 1
            instance26.ImageTransparency = 1

            for _, v296 in {instance11, instance12, parent4, instance9} do
                v296.MaxVisibleGraphemes = -1
            end

            parent.Visible = false

            if ui15 then
                ui15:Destroy()
                ui15 = nil
            end

            if ui16 then
                ui16:Destroy()
                ui16 = nil
            end

            return
        end

        for _, instance2 in {instance11, instance12, parent4, instance14, instance9} do
            local propertyTable = {TextTransparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v302 = pace * 0.15
            local easingStyle = quad or Enum.EasingStyle.Quint
            tweenService:Create(instance2, newTweenInfo(v302, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        end

        local propertyTable = {Transparency = 1}
        local quad = Enum.EasingStyle.Quad
        local newTweenInfo = TweenInfo.new
        local v307 = pace * 0.15
        local easingStyle = quad or Enum.EasingStyle.Quint
        tweenService:Create(instance15, newTweenInfo(v307, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        local propertyTable2 = {ImageTransparency = 1}
        local quad2 = Enum.EasingStyle.Quad
        local newTweenInfo2 = TweenInfo.new
        local v312 = pace * 0.15
        local easingStyle2 = quad2 or Enum.EasingStyle.Quint
        tweenService:Create(instance6, newTweenInfo2(v312, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
        local propertyTable3 = {ImageTransparency = 1}
        local quad3 = Enum.EasingStyle.Quad
        local newTweenInfo3 = TweenInfo.new
        local v317 = pace * 0.15
        local easingStyle3 = quad3 or Enum.EasingStyle.Quint
        tweenService:Create(instance7, newTweenInfo3(v317, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()
        local propertyTable4 = {ImageTransparency = 1}
        local quad4 = Enum.EasingStyle.Quad
        local newTweenInfo4 = TweenInfo.new
        local v322 = pace * 0.2
        local easingStyle4 = quad4 or Enum.EasingStyle.Quint
        tweenService:Create(instance3, newTweenInfo4(v322, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable4):Play()
        local propertyTable5 = {BackgroundTransparency = 1}
        local quad5 = Enum.EasingStyle.Quad
        local newTweenInfo5 = TweenInfo.new
        local v327 = pace * 0.2
        local easingStyle5 = quad5 or Enum.EasingStyle.Quint
        tweenService:Create(instance, newTweenInfo5(v327, easingStyle5, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable5):Play()
        ceremonyFade(0.15)
        screenFxOut(0.2)

        local v329 = function()
            --[[
              line: 767
              upvalues:
                v294 (copy, index: 1)
                count (ref,  index: 2)
                v149 (copy, index: 3)
                instance19 (copy, index: 4)
                instance27 (copy, index: 5)
                instance18 (copy, index: 6)
                instance26 (copy, index: 7)
                instance11 (copy, index: 8)
                instance12 (copy, index: 9)
                parent4 (copy, index: 10)
                instance9 (copy, index: 11)
                parent (copy, index: 12)
                ui15 (ref,  index: 13)
                ui16 (ref,  index: 14)
            ]]
            if v294 == count then
                v149:Clear()
                instance19.Visible = false
                instance27.Visible = false
                instance18.ImageTransparency = 1
                instance26.ImageTransparency = 1

                for _, v331 in {instance11, instance12, parent4, instance9} do
                    v331.MaxVisibleGraphemes = -1
                end

                parent.Visible = false

                if ui15 then
                    ui15:Destroy()
                    ui15 = nil
                end

                if ui16 then
                    ui16:Destroy()
                    ui16 = nil
                end
            end
        end

        task.delay(pace * 0.22, v329)
    end

    local function momentMember(options)
        --[[
          name: momentMember
          line: 778
          upvalues:
            state (copy, index: 1)
        ]]
        local v334 = if options.id then state.FindMember(options.id) else nil
        return v334 or {userId = false, id = options.id or "", name = options.name or ""}
    end

    local function teamMembers(teamKey)
        --[[
          name: teamMembers
          line: 782
          upvalues:
            state (copy, index: 1)
        ]]
        local v337 = state.Match
        v337 = v337 and v337.teams and v337.teams[teamKey]

        return v337 and v337.members or {}
    end

    local function letterX(a339, centreKey, centreKey2, a342)
        --[[
          name: letterX
          line: 788
        ]]
        local centre = a339.centres[centreKey] or 0
        local v344 = a339.centres[centreKey2] or a339.width

        return ((centre + v344) / 2 - (a339.width / 2)) * a342
    end

    local function portraitWhenGrown(img, a347, color3: Color3, a349, a350: number)
        --[[
          name: portraitWhenGrown
          line: 796
          upvalues:
            portraits (copy, index: 1)
            count (ref,  index: 2)
            pace (ref,  index: 3)
        ]]
        local function apply()
            --[[
              name: apply
              line: 797
              upvalues:
                img (copy, index: 1)
                portraits (copy, index: 2)
                a347 (copy, index: 3)
                color3 (copy, index: 4)
            ]]
            for _, v353 in {"RigHead", "RigBack"} do
                if const v354 = img:FindFirstChild(v353) then
                    v354:Destroy()
                end
            end

            portraits.Apply(img, a347, 150)
            portraits.SetTint(img, color3, 0)
        end

        apply()

        if portraits.ThumbFor(a347, 150) == "" then
            local v355 = function()
                --[[
                  line: 809
                  upvalues:
                    a350 (copy, index: 1)
                    count (ref,  index: 2)
                    apply (copy, index: 3)
                ]]
                if a350 == count then
                    apply()
                end
            end

            task.delay(a349 * pace, v355)
        end
    end

    local function pointBurst(a357, color, x, y: number, speed, options)
        --[[
          name: pointBurst
          line: 816
          upvalues:
            v149 (copy, index: 1)
            pace (ref,  index: 2)
        ]]
        local v363 = options or {}
        v149.Pace = pace
        v149:Burst(a357, {mode = "point", at = Vector2.new(x, y), jitter = v363.jitter or 30, speed = speed, color = color, white = v363.white, whiteChance = v363.whiteChance
            or 0.3, sparkChance = v363.sparkChance or 0.75, kind = v363.kind, size = v363.size, grav = v363.grav, drag = v363.drag, lifeMult = v363.lifeMult})
    end

    local function play(a365, visible: boolean, a367, a368, a369, a370, a371, a372, options)
        --[[
          name: play
          line: 837
          upvalues:
            active (ref,  index: 1)
            count (ref,  index: 2)
            v190 (ref,  index: 3)
            a22 (copy, index: 4)
            v149 (copy, index: 5)
            instance19 (copy, index: 6)
            instance27 (copy, index: 7)
            instance18 (copy, index: 8)
            instance26 (copy, index: 9)
            instance11 (copy, index: 10)
            instance12 (copy, index: 11)
            parent4 (copy, index: 12)
            instance9 (copy, index: 13)
            parent (copy, index: 14)
            ui15 (ref,  index: 15)
            ui16 (ref,  index: 16)
            v7 (copy, index: 17)
            colors (copy, index: 18)
            ui (copy, index: 19)
            ui2 (copy, index: 20)
            parent2 (copy, index: 21)
            parent3 (copy, index: 22)
            instance (copy, index: 23)
            tweenService (copy, index: 24)
            pace (ref,  index: 25)
            instance2 (copy, index: 26)
            instance3 (copy, index: 27)
            screenFx (copy, index: 28)
            instance6 (copy, index: 29)
            ui3 (copy, index: 30)
            instance7 (copy, index: 31)
            instance8 (copy, index: 32)
            theme (copy, index: 33)
            ui5 (copy, index: 34)
            instance13 (copy, index: 35)
            instance10 (copy, index: 36)
            instance5 (copy, index: 37)
            ui4 (copy, index: 38)
            ui6 (copy, index: 39)
            ui7 (copy, index: 40)
            tw (copy, index: 41)
            random (copy, index: 42)
            runService (copy, index: 43)
            burst (copy, index: 44)
            instance4 (copy, index: 45)
            result (ref,  index: 46)
            pointBurst (copy, index: 47)
            instance14 (copy, index: 48)
            instance15 (copy, index: 49)
            state (copy, index: 50)
            v115 (copy, index: 51)
            portraitWhenGrown (copy, index: 52)
            instance21 (copy, index: 53)
            instance22 (copy, index: 54)
            instance23 (copy, index: 55)
            instance24 (copy, index: 56)
            instance25 (copy, index: 57)
            v106 (copy, index: 58)
            instance20 (copy, index: 59)
            instance16 (copy, index: 60)
            ui8 (copy, index: 61)
            instance40 (copy, index: 62)
            instance41 (copy, index: 63)
            instance43 (copy, index: 64)
            instance44 (copy, index: 65)
            instance17 (copy, index: 66)
            rollDigit (copy, index: 67)
            v88 (copy, index: 68)
            instance42 (copy, index: 69)
            v92 (copy, index: 70)
            instance45 (copy, index: 71)
            parent5 (copy, index: 72)
            v98 (copy, index: 73)
            instance28 (copy, index: 74)
            ui13 (copy, index: 75)
            instance29 (copy, index: 76)
            instance30 (copy, index: 77)
            v142 (copy, index: 78)
            instance31 (copy, index: 79)
            instance33 (copy, index: 80)
            instance32 (copy, index: 81)
            instance34 (copy, index: 82)
            instance35 (copy, index: 83)
            ui12 (copy, index: 84)
            ceremonyFade (copy, index: 85)
            screenFxOut (copy, index: 86)
        ]]
        local v374
        local v375
        local v376
        local imageTransparency
        local pitch
        local v379, v380
        local v381
        local text2
        local v383

        do
            local v384

            if active then
                count += 1
                active = false

                if v190 then
                    a22.SetHudHidden("Celebrate", false)
                end

                v190 = false
                v149:Clear()
                instance19.Visible = false
                instance27.Visible = false
                instance18.ImageTransparency = 1
                instance26.ImageTransparency = 1

                for _, v386 in {instance11, instance12, parent4, instance9} do
                    v386.MaxVisibleGraphemes = -1
                end

                parent.Visible = false

                if ui15 then
                    ui15:Destroy()
                    ui15 = nil
                end

                if ui16 then
                    ui16:Destroy()
                    ui16 = nil
                end
            end

            count += 1

            do
                local v387 = count
                active = true
                v190 = visible
                local v388 = a365 == "win"
                local v389 = a365 == "lose"

                if not v388 and not v389 then
                    options = nil
                end

                local v390 = if options and not visible then v7[options.kind] else nil
                local v391 = if options and visible then v7[options.kind] else nil

                if v388 then
                    v374 = colors.Ally
                else
                    v374 = if v389 then colors.Enemy else colors.Bone
                end

                local void = colors.Void
                local alpha = v389 and 0.55 or 0.4
                local startValue = v374:Lerp(void, alpha)
                local compact = ui.Compact
                ui2.Scale = (compact and (v390 and 0.7 or 0.74)) or 1

                if visible then
                    if compact then
                        v375 = v391 and 0.36 or 0.33
                    else
                        v375 = v391 and 0.385 or 0.36
                    end
                elseif v390 then
                    v375 = compact and 0.2867 or 0.265
                else
                    v375 = compact and 0.27 or 0.29
                end

                parent2.Position = UDim2.fromScale(0.5, v375)
                parent3.Position = UDim2.new()
                instance19.Visible = false
                instance27.Visible = false
                instance18.ImageTransparency = 1
                instance26.ImageTransparency = 1

                for _, v397 in {instance11, instance12, parent4, instance9} do
                    v397.MaxVisibleGraphemes = -1
                end

                parent.Visible = true

                if visible then
                    a22.SetHudHidden("Celebrate", true)
                end

                do
                    local v398 = visible and 2000 or v390 and 1600 or 1500

                    do
                        local v399 = visible and 210 or v390 and (compact and 156 or 172) or 150
                        local v400 = visible and 2.35 or not v390 and 1.55 or v390.headS

                        if v390 then
                            v376 = v390.text
                        else
                            v376 = if visible then v388 and "VICTORY" or v389 and "DEFEAT" or "DRAW" else v388
                                and "ROUND WON"
                                or v389 and "ROUND LOST"
                                or "DRAW"
                        end

                        local v401 = if v390 then v390.style else nil
                        local volume = v389 and 0.6 or 1
                        instance.BackgroundTransparency = 1

                        if visible then
                            local backgroundTransparency

                            do
                                local propertyTable = {}

                                if v389 then
                                    backgroundTransparency = 0.4
                                else
                                    backgroundTransparency = 0.5
                                end

                                propertyTable.BackgroundTransparency = backgroundTransparency
                                tweenService:Create(instance, TweenInfo.new(pace * 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                            end
                        end

                        instance2.BackgroundColor3 = v374
                        instance2.BackgroundTransparency = v389 and 0.84 or 0.6
                        local v405 = v389 and 0.6 or 0.45
                        local propertyTable = {BackgroundTransparency = 1}
                        local quad = Enum.EasingStyle.Quad
                        local newTweenInfo = TweenInfo.new
                        local v409 = v405 * pace
                        local easingStyle = quad or Enum.EasingStyle.Quint
                        tweenService:Create(instance2, newTweenInfo(v409, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                        local imageTransparency2 = v389 and 0.2 or 0.3
                        instance3.ImageColor3 = if v389 then v374:Lerp(colors.Void, 0.78) else v374:Lerp(colors.Void, 0.25)
                        instance3.ImageTransparency = 1

                        do
                            local v412 = {ImageTransparency = imageTransparency2}
                            tweenService:Create(instance3, TweenInfo.new(pace * 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), v412):Play()
                            screenFx(a365, visible)
                            instance6.ImageColor3 = Color3.new(1, 1, 1)
                            v412 = ColorSequence.new
                            local colorSequenceKeypoint = ColorSequenceKeypoint.new(0, startValue)
                            local newColorSequenceKeypoint = ColorSequenceKeypoint.new
                            local void2 = colors.Void
                            local alpha2 = v389 and 0.4 or 0.18
                            ui3.Color = v412({colorSequenceKeypoint, newColorSequenceKeypoint(0.35, v374:Lerp(void2, alpha2)), ColorSequenceKeypoint.new(0.65, startValue), ColorSequenceKeypoint.new(1, startValue:Lerp(colors.Void, 0.3))})
                            instance6.ImageTransparency = v389 and 0.18 or 0.04
                        end

                        instance7.ImageColor3 = startValue
                        instance7.Size = UDim2.fromOffset(v398 * 0.6, v399 * 1.55)
                        instance7.ImageTransparency = 1
                        local propertyTable2 = {Size = UDim2.fromOffset(v398 * 1.15, v399 * 1.55)}

                        if v389 then
                            imageTransparency = 0.7
                        else
                            imageTransparency = 0.55
                        end

                        propertyTable2.ImageTransparency = imageTransparency
                        tweenService:Create(instance7, TweenInfo.new(pace * 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
                        instance6.AnchorPoint = Vector2.new(0, 0.5)
                        instance6.Position = UDim2.fromOffset(-v398 / 2, 0)
                        instance6.Size = UDim2.fromOffset(0, v399)
                        local v418 = not v389 and v401 ~= "hold" and 0.3 or 0.45

                        do
                            local propertyTable3 = {Size = UDim2.fromOffset(v398, v399)}
                            tweenService:Create(instance6, TweenInfo.new(v418 * pace, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()
                        end

                        instance8.BackgroundColor3 = theme.Lighten(v374, 0.25)
                        instance8.AnchorPoint = Vector2.new(1, 0.5)
                        instance8.Position = UDim2.fromOffset((v398 / 2) - 60, (v399 / 2) - 2)

                        do
                            local udim2FromOffset = UDim2.fromOffset
                            local v421 = visible and 6 or 5
                            instance8.Size = udim2FromOffset(0, v421)
                            instance8.BackgroundTransparency = 0
                        end

                        do
                            local propertyTable4 = {}
                            local udim2FromOffset = UDim2.fromOffset
                            local v424 = v398 * 0.8
                            local v425 = visible and 6 or 5
                            propertyTable4.Size = udim2FromOffset(v424, v425)
                            local quint = Enum.EasingStyle.Quint

                            do
                                local out = Enum.EasingDirection.Out
                                local newTweenInfo2 = TweenInfo.new
                                local v429 = pace * 0.35
                                local quint2 = quint or Enum.EasingStyle.Quint
                                tweenService:Create(instance8, newTweenInfo2(v429, quint2, (out
                                    or Enum.EasingDirection.Out), 0, false, 0.06 * pace), propertyTable4):Play()
                            end
                        end

                        do
                            local play = a22.Sounds.Play
                            local v432 = {volume = 0.35}

                            if v389 then
                                pitch = 0.85
                            else
                                pitch = 1
                            end

                            v432.pitch = pitch
                            play("Whoosh", v432)

                            for _, v434 in {instance11, instance12, parent4, instance9} do
                                v434.AutoLocalize = v390 == nil
                                v434.Text = v376
                                v434.TextTransparency = 1
                                v434.Position = UDim2.fromOffset(0, 0)
                            end
                        end

                        instance9.TextColor3 = theme.Lighten(v374, 0.35)
                        instance12.Position = UDim2.fromOffset(0, 7)

                        do
                            local newColorSequence = ColorSequence.new
                            local text = colors.Text
                            local lighten = theme.Lighten
                            local v438 = v388 and 0.55 or 0.7
                            ui5.Color = newColorSequence(text, lighten(v374, v438))
                            instance13.Offset = Vector2.new(-1, 0)
                            instance10.Scale = v400
                            instance5.Position = UDim2.new()

                            if v390 then
                                do
                                    local v439 = options
                                    local v440 = not v389

                                    local function ceremonyImpact(a442)
                                        --[[
                                          name: ceremonyImpact
                                          line: 1001
                                          upvalues:
                                            v439 (copy, index: 1)
                                            ui4 (copy, index: 2)
                                            ui6 (copy, index: 3)
                                            ui7 (copy, index: 4)
                                            v400 (copy, index: 5)
                                            v440 (copy, index: 6)
                                            tweenService (copy, index: 7)
                                            pace (ref,  index: 8)
                                            count (ref,  index: 9)
                                            parent3 (copy, index: 10)
                                            random (copy, index: 11)
                                            runService (copy, index: 12)
                                            instance9 (copy, index: 13)
                                            instance10 (copy, index: 14)
                                            v390 (copy, index: 15)
                                            v149 (copy, index: 16)
                                            theme (copy, index: 17)
                                            v374 (copy, index: 18)
                                            burst (copy, index: 19)
                                            colors (copy, index: 20)
                                            instance5 (copy, index: 21)
                                            instance4 (copy, index: 22)
                                            v398 (copy, index: 23)
                                            v399 (copy, index: 24)
                                            volume (copy, index: 25)
                                            result (ref,  index: 26)
                                        ]]
                                        local kind = v439.kind

                                        for _, instance in {ui4, ui6, ui7} do
                                            instance.Scale = v400 * ((kind ~= "flawless" and (v440 and 1.1 or 1.05))
                                                or 1.03)
                                            local propertyTable = {Scale = v400}
                                            local back = Enum.EasingStyle.Back
                                            local newTweenInfo = TweenInfo.new
                                            local v449 = pace * 0.26
                                            local easingStyle = back or Enum.EasingStyle.Quint
                                            tweenService:Create(instance, newTweenInfo(v449, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                                        end

                                        if kind ~= "flawless" then
                                            local v451 = v440 and (kind ~= "clutch" and 10 or 13) or 3
                                            local v452 = kind ~= "clutch" and 0.24 or 0.32
                                            local v453 = count

                                            task.spawn(
                                                function()
                                                    --[[
                                                      line: 696
                                                      upvalues:
                                                        v452 (copy, index: 1)
                                                        pace (ref,  index: 2)
                                                        v453 (copy, index: 3)
                                                        count (ref,  index: 4)
                                                        parent3 (copy, index: 5)
                                                        random (copy, index: 6)
                                                        v451 (copy, index: 7)
                                                        runService (copy, index: 8)
                                                    ]]
                                                    local timestamp = os.clock()

                                                    while os.clock() - timestamp < v452 * pace and v453 == count do
                                                        local v455 = 1 - (os.clock() - timestamp) / (v452 * pace)
                                                        parent3.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v451) * v455, (random:NextNumber(-1, 1) * v451) * v455)
                                                        runService.RenderStepped:Wait()
                                                    end

                                                    parent3.Position = UDim2.new()
                                                end
                                            )
                                        end

                                        instance9.MaxVisibleGraphemes = -1
                                        instance9.TextTransparency = v440 and 0.2 or 0.55
                                        instance10.Scale = v400 * 1.02
                                        local propertyTable = {}
                                        local v457 = v440 and 1.32 or 1.18
                                        propertyTable.Scale = v400 * v457
                                        local quart = Enum.EasingStyle.Quart
                                        local newTweenInfo = TweenInfo.new
                                        local v460 = pace * 0.6
                                        local easingStyle = quart or Enum.EasingStyle.Quint
                                        tweenService:Create(instance10, newTweenInfo(v460, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                                        local propertyTable2 = {TextTransparency = 1}
                                        local v463 = Enum.EasingStyle.Quad
                                        local newTweenInfo2 = TweenInfo.new
                                        local v465 = pace * 0.6
                                        local v466 = v463 or Enum.EasingStyle.Quint
                                        tweenService:Create(instance9, newTweenInfo2(v465, v466, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
                                        local x = v390.width * v400

                                        if kind ~= "flawless" then
                                            local v468 = v440 and (kind ~= "clutch" and 44 or 50) or 14
                                            local v469 = if v440 then theme.Lighten(v374, 0.25) else v374:Lerp(colors.Void, 0.3)
                                            local y = 80 * v400
                                            local speed = v440 and 1500 or 700
                                            burst(v468, v469, x, y, speed)
                                        else
                                            v149.Pace = pace
                                            local v472 = v440 and 28 or 12
                                            v149:Burst(v472, {mode = "box", kind = "sparkle", size = 32, speed = 240, whiteChance = 0.45, grav = -60, drag = 1.5, lifeMult = 1.7, box = Vector2.new(x, 70 * v400), color = theme.Lighten(v374, 0.45), white = theme.Lighten(v374, 0.72)})
                                        end

                                        instance5.ImageColor3 = theme.Lighten(v374, 0.3)
                                        v463 = UDim2.fromOffset
                                        local v473 = if kind ~= "flawless" and kind ~= "clutch" then a442 else 0
                                        instance5.Position = v463(v473, 0)
                                        instance5.Size = UDim2.fromOffset(120, 120)
                                        instance5.ImageTransparency = v440 and 0.2 or 0.55
                                        local propertyTable3 = {ImageTransparency = 1, Size = UDim2.fromOffset(1500, 1500)}
                                        local quart2 = Enum.EasingStyle.Quart
                                        local newTweenInfo3 = TweenInfo.new
                                        local v477 = pace * 0.65
                                        local easingStyle2 = quart2 or Enum.EasingStyle.Quint
                                        tweenService:Create(instance5, newTweenInfo3(v477, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()
                                        instance4.ImageColor3 = v374
                                        instance4.Size = UDim2.fromOffset(v398 * 0.45, v399 * 1.6)
                                        instance4.ImageTransparency = v440 and 0.3 or 0.6
                                        local propertyTable4 = {ImageTransparency = 1, Size = UDim2.fromOffset(v398 * 0.7, v399 * 2.4)}
                                        local quad = Enum.EasingStyle.Quad
                                        local newTweenInfo4 = TweenInfo.new
                                        local v482 = pace * 0.8
                                        local easingStyle3 = quad or Enum.EasingStyle.Quint
                                        tweenService:Create(instance4, newTweenInfo4(v482, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable4):Play()

                                        if kind == "ace" then
                                            local v484 = {pitch = 1.16, volume = volume}

                                            if result then
                                                pcall(result.Play, "Match/Elimination", nil, v484)
                                            end

                                            local v485 = {volume = volume}

                                            if result then
                                                pcall(result.Play, "Kill_Triple", nil, v485)
                                            end
                                        elseif kind == "teamace" then
                                            local v486 = {pitch = 1.2, volume = volume}

                                            if result then
                                                pcall(result.Play, "Kill_Ally", nil, v486)
                                            end

                                            local v487 = {volume = volume}

                                            if result then
                                                pcall(result.Play, "Kill_Triple", nil, v487)
                                            end
                                        elseif kind == "clutch" then
                                            local v488 = {volume = volume}

                                            if result then
                                                pcall(result.Play, "Match/Final_Round", nil, v488)
                                            end
                                        else
                                            local v489 = {volume = volume}

                                            if result then
                                                pcall(result.Play, "UI/Card_Reveal", nil, v489)
                                            end
                                        end
                                    end

                                    if v390.style == "stamp" then
                                        do
                                            local v490 = {}

                                            for index = math.max(v390.lead, 1), #v390.ends do
                                                table.insert(v490, index)
                                            end

                                            v379 = 0.1

                                            for _, v493 in {ui4, ui6, ui7} do
                                                v493.Scale = v400
                                            end

                                            for _, v495 in {instance11, instance12, parent4, instance9} do
                                                v495.MaxVisibleGraphemes = 0
                                            end

                                            do
                                                local v496 = 0
                                                v380, v380 = v379, v379

                                                for v497, v498 in v490 do
                                                    local maxVisibleGraphemes = v390.ends[v498]
                                                    local v500 = v497 == 1 and 1 < v498
                                                    local v501 = v497 == #v490

                                                    do
                                                        local v502 = v496

                                                        local v503 = function()
                                                            --[[
                                                              line: 1087
                                                              upvalues:
                                                                v387 (copy, index: 1)
                                                                count (ref,  index: 2)
                                                                instance11 (copy, index: 3)
                                                                instance12 (copy, index: 4)
                                                                parent4 (copy, index: 5)
                                                                maxVisibleGraphemes (copy, index: 6)
                                                                v390 (copy, index: 7)
                                                                v502 (copy, index: 8)
                                                                v498 (copy, index: 9)
                                                                v400 (copy, index: 10)
                                                                v500 (copy, index: 11)
                                                                tweenService (copy, index: 12)
                                                                pace (ref,  index: 13)
                                                                ui4 (copy, index: 14)
                                                                ui6 (copy, index: 15)
                                                                v501 (copy, index: 16)
                                                                ceremonyImpact (copy, index: 17)
                                                                v440 (copy, index: 18)
                                                                parent3 (copy, index: 19)
                                                                random (copy, index: 20)
                                                                runService (copy, index: 21)
                                                                pointBurst (copy, index: 22)
                                                                theme (copy, index: 23)
                                                                v374 (copy, index: 24)
                                                                colors (copy, index: 25)
                                                                instance5 (copy, index: 26)
                                                                v439 (copy, index: 27)
                                                                volume (copy, index: 28)
                                                                v497 (copy, index: 29)
                                                                result (ref,  index: 30)
                                                            ]]
                                                            if v387 ~= count then
                                                                return
                                                            end

                                                            for _, v505 in {instance11, instance12, parent4} do
                                                                v505.MaxVisibleGraphemes = maxVisibleGraphemes
                                                            end

                                                            local v506 = v390
                                                            local centreKey = v502 + 1
                                                            local centre = v506.centres[centreKey] or 0
                                                            local v509 = v506.centres[v498] or v506.width
                                                            local x = ((centre + v509) / 2 - (v506.width / 2)) * v400

                                                            if v500 then
                                                                instance11.TextTransparency = 1
                                                                instance12.TextTransparency = 1
                                                                local propertyTable = {TextTransparency = 0}
                                                                local quad = Enum.EasingStyle.Quad
                                                                local newTweenInfo = TweenInfo.new
                                                                local v514 = pace * 0.12
                                                                local easingStyle = quad or Enum.EasingStyle.Quint
                                                                tweenService:Create(instance11, newTweenInfo(v514, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                                                                local propertyTable2 = {TextTransparency = 0.55}
                                                                local quad2 = Enum.EasingStyle.Quad
                                                                local newTweenInfo2 = TweenInfo.new
                                                                local v519 = pace * 0.18
                                                                local easingStyle2 = quad2 or Enum.EasingStyle.Quint
                                                                tweenService:Create(instance12, newTweenInfo2(v519, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()

                                                                for _, instance in {ui4, ui6} do
                                                                    instance.Scale = v400 * 1.12
                                                                    local propertyTable3 = {Scale = v400}
                                                                    local quint = Enum.EasingStyle.Quint
                                                                    local newTweenInfo3 = TweenInfo.new
                                                                    local v526 = pace * 0.2
                                                                    local quint2 = quint or Enum.EasingStyle.Quint
                                                                    local tween = tweenService:Create(instance, newTweenInfo3(v526, quint2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3)
                                                                    tween:Play()
                                                                end

                                                                return
                                                            end

                                                            instance11.TextTransparency = 0
                                                            instance12.TextTransparency = 0.55

                                                            if v501 then
                                                                ceremonyImpact(x)
                                                                return
                                                            end

                                                            for _, instance in {ui4, ui6} do
                                                                local easingStyle
                                                                instance.Scale = v400 * 1.06
                                                                local propertyTable = {Scale = v400}
                                                                local back = Enum.EasingStyle.Back
                                                                local newTweenInfo = TweenInfo.new
                                                                local v535 = pace * 0.14
                                                                easingStyle = if const back2 = back then back2 else Enum.EasingStyle.Quint
                                                                local tween = tweenService:Create(instance, newTweenInfo(v535, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                                                                tween:Play()
                                                            end

                                                            local v538 = v440 and 5 or 2
                                                            local v539 = count
                                                            local v540 = 0.12

                                                            task.spawn(
                                                                function()
                                                                    --[[
                                                                      line: 696
                                                                      upvalues:
                                                                        v540 (copy, index: 1)
                                                                        pace (ref,  index: 2)
                                                                        v539 (copy, index: 3)
                                                                        count (ref,  index: 4)
                                                                        parent3 (copy, index: 5)
                                                                        random (copy, index: 6)
                                                                        v538 (copy, index: 7)
                                                                        runService (copy, index: 8)
                                                                    ]]
                                                                    local timestamp = os.clock()

                                                                    while os.clock() - timestamp < v540 * pace
                                                                        and v539 == count
                                                                    do
                                                                        local v542 = 1 - (os.clock() - timestamp) / (v540 * pace)
                                                                        parent3.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v538) * v542, (random:NextNumber(-1, 1) * v538) * v542)
                                                                        runService.RenderStepped:Wait()
                                                                    end

                                                                    parent3.Position = UDim2.new()
                                                                end
                                                            )

                                                            local v543 = v440 and 12 or 5
                                                            local v544 = if v440 then theme.Lighten(v374, 0.3) else v374:Lerp(colors.Void, 0.3)
                                                            local speed = v440 and 950 or 500
                                                            pointBurst(v543, v544, x, 0, speed, {jitter = 34 * v400, white = theme.Lighten(v374, 0.7)})
                                                            instance5.ImageColor3 = theme.Lighten(v374, 0.35)
                                                            instance5.Position = UDim2.fromOffset(x, 0)
                                                            instance5.Size = UDim2.fromOffset(60, 60)
                                                            instance5.ImageTransparency = v440 and 0.3 or 0.6
                                                            local propertyTable = {ImageTransparency = 1, Size = UDim2.fromOffset(380, 380)}
                                                            local quart = Enum.EasingStyle.Quart
                                                            local newTweenInfo = TweenInfo.new
                                                            local v549 = pace * 0.32
                                                            local easingStyle = quart or Enum.EasingStyle.Quint
                                                            tweenService:Create(instance5, newTweenInfo(v549, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()

                                                            if v439.kind ~= "teamace" then
                                                                v538 = "Match/Elimination"
                                                            else
                                                                local _ = "Kill_Ally"
                                                            end

                                                            local v552 = {volume = volume * 0.9, pitch = 0.9 + (0.08 * v497)}

                                                            if result then
                                                                pcall(result.Play, v538, nil, v552)
                                                            end
                                                        end

                                                        task.delay(v380 * pace, v503)
                                                    end

                                                    v496 = v498
                                                    local v553 = v500 and 0.2 or 0.15

                                                    do
                                                        local v554 = v380 + v553
                                                        v380 = v554
                                                    end
                                                end
                                            end
                                        end
                                    elseif v390.style == "hold" then
                                        local backgroundTransparency
                                        v379 = 0.02

                                        do
                                            local scale = v400 * 1.45

                                            for _, instance36 in {ui4, ui6, ui7} do
                                                instance36.Scale = v400 * 2.1

                                                do
                                                    local propertyTable5 = {Scale = scale}
                                                    local quad2 = Enum.EasingStyle.Quad
                                                    local out = Enum.EasingDirection.Out
                                                    local newTweenInfo3 = TweenInfo.new
                                                    local v563 = pace * 0.34
                                                    local easingStyle2 = quad2 or Enum.EasingStyle.Quint
                                                    local out2 = out or Enum.EasingDirection.Out
                                                    tweenService:Create(instance36, newTweenInfo3(v563, easingStyle2, out2, 0, false, (v379
                                                        or 0) * pace), propertyTable5):Play()
                                                end
                                            end
                                        end

                                        do
                                            local propertyTable6 = {TextTransparency = 0.62}
                                            local quad3 = Enum.EasingStyle.Quad
                                            local out = Enum.EasingDirection.Out
                                            local newTweenInfo4 = TweenInfo.new
                                            local v570 = pace * 0.3
                                            local easingStyle3 = quad3 or Enum.EasingStyle.Quint
                                            local out3 = out or Enum.EasingDirection.Out
                                            tweenService:Create(instance11, newTweenInfo4(v570, easingStyle3, out3, 0, false, (v379
                                                or 0) * pace), propertyTable6):Play()
                                            instance.BackgroundTransparency = 1
                                        end

                                        do
                                            local propertyTable7 = {}

                                            if v440 then
                                                backgroundTransparency = 0.72
                                            else
                                                backgroundTransparency = 0.8
                                            end

                                            propertyTable7.BackgroundTransparency = backgroundTransparency
                                            local quad4 = Enum.EasingStyle.Quad

                                            do
                                                local newTweenInfo5 = TweenInfo.new
                                                local v576 = pace * 0.3
                                                local easingStyle4 = quad4 or Enum.EasingStyle.Quint
                                                tweenService:Create(instance, newTweenInfo5(v576, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable7):Play()

                                                do
                                                    local v578 = {volume = volume}

                                                    if result then
                                                        pcall(result.Play, "Match/Final_Heartbeat", nil, v578)
                                                    end
                                                end
                                            end
                                        end

                                        for _, v580 in {{0.04, 0.02}, {0.26, 0.08}} do
                                            do
                                                local v581 = v580[1]

                                                local v582 = function()
                                                    --[[
                                                      line: 1143
                                                      upvalues:
                                                        v387 (copy, index: 1)
                                                        count (ref,  index: 2)
                                                        instance3 (copy, index: 3)
                                                        v580 (copy, index: 4)
                                                        imageTransparency2 (copy, index: 5)
                                                        tweenService (copy, index: 6)
                                                        pace (ref,  index: 7)
                                                    ]]
                                                    if v387 == count then
                                                        instance3.ImageTransparency = v580[2]
                                                        local propertyTable = {ImageTransparency = imageTransparency2}
                                                        local quad = Enum.EasingStyle.Quad
                                                        local newTweenInfo = TweenInfo.new
                                                        local v586 = pace * 0.18
                                                        local easingStyle = quad or Enum.EasingStyle.Quint
                                                        local tween = tweenService:Create(instance3, newTweenInfo(v586, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                                                        tween:Play()
                                                    end
                                                end

                                                task.delay(v581 * pace, v582)
                                            end
                                        end

                                        do
                                            local v589 = function()
                                                --[[
                                                  line: 1152
                                                  upvalues:
                                                    v387 (copy, index: 1)
                                                    count (ref,  index: 2)
                                                    ui4 (copy, index: 3)
                                                    ui6 (copy, index: 4)
                                                    ui7 (copy, index: 5)
                                                    v400 (copy, index: 6)
                                                    tweenService (copy, index: 7)
                                                    pace (ref,  index: 8)
                                                    instance11 (copy, index: 9)
                                                    instance12 (copy, index: 10)
                                                ]]
                                                if v387 ~= count then
                                                    return
                                                end

                                                for _, instance in {ui4, ui6, ui7} do
                                                    local propertyTable = {Scale = v400}
                                                    local quint = Enum.EasingStyle.Quint
                                                    local inValue = Enum.EasingDirection.In
                                                    local newTweenInfo = TweenInfo.new
                                                    local v596 = pace * 0.12
                                                    local quint2 = quint or Enum.EasingStyle.Quint
                                                    local easingDirection = inValue or Enum.EasingDirection.Out
                                                    local tween = tweenService:Create(instance, newTweenInfo(v596, quint2, easingDirection, 0, false, 0 * pace), propertyTable)
                                                    tween:Play()
                                                end

                                                local propertyTable = {TextTransparency = 0}
                                                local quad = Enum.EasingStyle.Quad
                                                local inValue = Enum.EasingDirection.In
                                                local newTweenInfo = TweenInfo.new
                                                local v604 = pace * 0.1
                                                local easingStyle = quad or Enum.EasingStyle.Quint
                                                local easingDirection = inValue or Enum.EasingDirection.Out
                                                tweenService:Create(instance11, newTweenInfo(v604, easingStyle, easingDirection, 0, false, 0 * pace), propertyTable):Play()
                                                local propertyTable2 = {TextTransparency = 0.55}
                                                local quad2 = Enum.EasingStyle.Quad
                                                local inValue2 = Enum.EasingDirection.In
                                                newTweenInfo = TweenInfo.new
                                                local v610 = pace * 0.12
                                                local easingStyle2 = quad2 or Enum.EasingStyle.Quint
                                                local easingDirection2 = inValue2 or Enum.EasingDirection.Out
                                                tweenService:Create(instance12, newTweenInfo(v610, easingStyle2, easingDirection2, 0, false, 0 * pace), propertyTable2):Play()
                                            end

                                            task.delay(pace * 0.42, v589)
                                        end

                                        v380 = 0.54

                                        do
                                            local v613 = function()
                                                --[[
                                                  line: 1163
                                                  upvalues:
                                                    v387 (copy, index: 1)
                                                    count (ref,  index: 2)
                                                    instance (copy, index: 3)
                                                    tweenService (copy, index: 4)
                                                    pace (ref,  index: 5)
                                                    ceremonyImpact (copy, index: 6)
                                                ]]
                                                if v387 == count then
                                                    local propertyTable = {BackgroundTransparency = 1}
                                                    local quad = Enum.EasingStyle.Quad
                                                    local newTweenInfo = TweenInfo.new
                                                    local v617 = pace * 0.35
                                                    local easingStyle = quad or Enum.EasingStyle.Quint
                                                    local tween = tweenService:Create(instance, newTweenInfo(v617, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                                                    tween:Play()
                                                    ceremonyImpact(0)
                                                end
                                            end

                                            task.delay(v380 * pace, v613)
                                        end
                                    else
                                        v379 = 0.08

                                        for _, instance37 in {ui4, ui6, ui7} do
                                            instance37.Scale = v400 * 1.28

                                            do
                                                local propertyTable8 = {Scale = v400}
                                                local quint = Enum.EasingStyle.Quint
                                                local out = Enum.EasingDirection.Out
                                                local newTweenInfo6 = TweenInfo.new
                                                local v626 = pace * 0.42
                                                local quint3 = quint or Enum.EasingStyle.Quint
                                                local out4 = out or Enum.EasingDirection.Out
                                                tweenService:Create(instance37, newTweenInfo6(v626, quint3, out4, 0, false, (v379
                                                    or 0) * pace), propertyTable8):Play()
                                            end
                                        end

                                        local propertyTable9 = {TextTransparency = 0}
                                        local quad5 = Enum.EasingStyle.Quad
                                        local out = Enum.EasingDirection.Out

                                        do
                                            local newTweenInfo7 = TweenInfo.new
                                            local v633 = pace * 0.22
                                            local easingStyle5 = quad5 or Enum.EasingStyle.Quint
                                            local out5 = out or Enum.EasingDirection.Out
                                            tweenService:Create(instance11, newTweenInfo7(v633, easingStyle5, out5, 0, false, (v379
                                                or 0) * pace), propertyTable9):Play()

                                            do
                                                local propertyTable10 = {TextTransparency = 0.55}
                                                local quad6 = Enum.EasingStyle.Quad
                                                local out6 = Enum.EasingDirection.Out
                                                newTweenInfo7 = TweenInfo.new
                                                local v639 = pace * 0.3
                                                local easingStyle6 = quad6 or Enum.EasingStyle.Quint
                                                local out7 = out6 or Enum.EasingDirection.Out
                                                tweenService:Create(instance12, newTweenInfo7(v639, easingStyle6, out7, 0, false, (v379
                                                    or 0) * pace), propertyTable10):Play()
                                                v380 = v379 + 0.24

                                                do
                                                    local v642 = function()
                                                        --[[
                                                          line: 1179
                                                          upvalues:
                                                            v387 (copy, index: 1)
                                                            count (ref,  index: 2)
                                                            ceremonyImpact (copy, index: 3)
                                                            instance18 (copy, index: 4)
                                                            theme (copy, index: 5)
                                                            v374 (copy, index: 6)
                                                            v398 (copy, index: 7)
                                                            v399 (copy, index: 8)
                                                            v440 (copy, index: 9)
                                                            tweenService (copy, index: 10)
                                                            pace (ref,  index: 11)
                                                        ]]
                                                        if v387 ~= count then
                                                            return
                                                        end

                                                        ceremonyImpact(0)
                                                        instance18.ImageColor3 = theme.Lighten(v374, 0.55)
                                                        instance18.Position = UDim2.fromOffset(-v398 * 0.32, (-v399 / 2) + 4)
                                                        instance18.ImageTransparency = v440 and 0.25 or 0.6
                                                        local propertyTable = {Position = UDim2.fromOffset(v398 * 0.32, (-v399 / 2) + 4)}
                                                        local quad = Enum.EasingStyle.Quad
                                                        local inOut = Enum.EasingDirection.InOut
                                                        local newTweenInfo = TweenInfo.new
                                                        local v647 = pace * 0.75
                                                        local easingStyle = quad or Enum.EasingStyle.Quint
                                                        local easingDirection = inOut or Enum.EasingDirection.Out
                                                        tweenService:Create(instance18, newTweenInfo(v647, easingStyle, easingDirection, 0, false, 0 * pace), propertyTable):Play()
                                                        local propertyTable2 = {ImageTransparency = 1}
                                                        local quad2 = Enum.EasingStyle.Quad
                                                        local inValue = Enum.EasingDirection.In
                                                        local newTweenInfo2 = TweenInfo.new
                                                        local v654 = pace * 0.3
                                                        local easingStyle2 = quad2 or Enum.EasingStyle.Quint
                                                        local easingDirection2 = inValue or Enum.EasingDirection.Out
                                                        tweenService:Create(instance18, newTweenInfo2(v654, easingStyle2, easingDirection2, 0, false, 0.5 * pace), propertyTable2):Play()
                                                    end

                                                    task.delay(v380 * pace, v642)
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                do
                                    local v657 = v389 and 1.12 or 1.75
                                    ui4.Scale = v400 * v657
                                    ui6.Scale = v400 * v657
                                    ui7.Scale = v400 * v657
                                    local v658 = v389 and 0.5 or 0.26
                                    local easingStyle7 = if v389 then Enum.EasingStyle.Quint else Enum.EasingStyle.Back
                                    v379 = v389 and 0.1 or 0.08

                                    for _, instance46 in {ui4, ui6, ui7} do
                                        tw(instance46, v658, {Scale = v400}, easingStyle7, Enum.EasingDirection.Out, v379)
                                    end
                                end

                                local propertyTable11 = {TextTransparency = 0}
                                local quad7 = Enum.EasingStyle.Quad
                                local out = Enum.EasingDirection.Out
                                local newTweenInfo8 = TweenInfo.new

                                do
                                    local v666 = pace * 0.12
                                    local easingStyle8 = quad7 or Enum.EasingStyle.Quint
                                    local out8 = out or Enum.EasingDirection.Out
                                    tweenService:Create(instance11, newTweenInfo8(v666, easingStyle8, out8, 0, false, (v379
                                        or 0) * pace), propertyTable11):Play()
                                end

                                local propertyTable12 = {TextTransparency = 0.55}
                                local quad8 = Enum.EasingStyle.Quad
                                local out9 = Enum.EasingDirection.Out
                                newTweenInfo8 = TweenInfo.new
                                local v672 = pace * 0.2
                                local easingStyle9 = quad8 or Enum.EasingStyle.Quint

                                do
                                    local out10 = out9 or Enum.EasingDirection.Out
                                    tweenService:Create(instance12, newTweenInfo8(v672, easingStyle9, out10, 0, false, (v379
                                        or 0) * pace), propertyTable12):Play()
                                    local v675 = v389 and 0.3 or 0.2
                                    v380 = v379 + v675

                                    do
                                        local v676 = function()
                                            --[[
                                              line: 957
                                              upvalues:
                                                v387 (copy, index: 1)
                                                count (ref,  index: 2)
                                                v389 (copy, index: 3)
                                                ui4 (copy, index: 4)
                                                ui6 (copy, index: 5)
                                                ui7 (copy, index: 6)
                                                v400 (copy, index: 7)
                                                tweenService (copy, index: 8)
                                                pace (ref,  index: 9)
                                                visible (copy, index: 10)
                                                parent3 (copy, index: 11)
                                                random (copy, index: 12)
                                                runService (copy, index: 13)
                                                instance9 (copy, index: 14)
                                                instance10 (copy, index: 15)
                                                v376 (copy, index: 16)
                                                burst (copy, index: 17)
                                                theme (copy, index: 18)
                                                v374 (copy, index: 19)
                                                instance5 (copy, index: 20)
                                                instance4 (copy, index: 21)
                                                v398 (copy, index: 22)
                                                v399 (copy, index: 23)
                                                colors (copy, index: 24)
                                            ]]
                                            if v387 ~= count then
                                                return
                                            end

                                            if v389 then
                                                instance4.ImageColor3 = v374:Lerp(colors.Void, 0.4)
                                                instance4.Size = UDim2.fromOffset(v398 * 0.5, v399 * 1.8)
                                                instance4.ImageTransparency = 0.6
                                                local propertyTable = {ImageTransparency = 1}
                                                local quad = Enum.EasingStyle.Quad
                                                local newTweenInfo = TweenInfo.new
                                                local v680 = pace * 1.2
                                                local easingStyle = quad or Enum.EasingStyle.Quint
                                                tweenService:Create(instance4, newTweenInfo(v680, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()

                                                if visible then
                                                    local options = {sparkChance = 0, grav = 520, drag = 1.2, base = 0.35, lifeMult = 1.6}
                                                    burst(10, v374:Lerp(colors.Void, 0.3), 700, 80, 260, options)
                                                end

                                                return
                                            end

                                            for _, instance in {ui4, ui6, ui7} do
                                                instance.Scale = v400 * 1.07
                                                local propertyTable = {Scale = v400}
                                                local back = Enum.EasingStyle.Back
                                                local newTweenInfo = TweenInfo.new
                                                local v688 = pace * 0.22
                                                local easingStyle = back or Enum.EasingStyle.Quint
                                                local tween = tweenService:Create(instance, newTweenInfo(v688, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                                                tween:Play()
                                            end

                                            local v691 = visible and 9 or 6
                                            local v692 = count
                                            local v693 = 0.22

                                            task.spawn(
                                                function()
                                                    --[[
                                                      line: 696
                                                      upvalues:
                                                        v693 (copy, index: 1)
                                                        pace (ref,  index: 2)
                                                        v692 (copy, index: 3)
                                                        count (ref,  index: 4)
                                                        parent3 (copy, index: 5)
                                                        random (copy, index: 6)
                                                        v691 (copy, index: 7)
                                                        runService (copy, index: 8)
                                                    ]]
                                                    local timestamp = os.clock()

                                                    while os.clock() - timestamp < v693 * pace and v692 == count do
                                                        local v695 = 1 - (os.clock() - timestamp) / (v693 * pace)
                                                        parent3.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v691) * v695, (random:NextNumber(-1, 1) * v691) * v695)
                                                        runService.RenderStepped:Wait()
                                                    end

                                                    parent3.Position = UDim2.new()
                                                end
                                            )

                                            instance9.TextTransparency = 0.25
                                            instance10.Scale = v400 * 1.02
                                            local propertyTable = {Scale = v400 * 1.28}
                                            local quart = Enum.EasingStyle.Quart
                                            local newTweenInfo = TweenInfo.new
                                            local v699 = pace * 0.55
                                            local easingStyle = quart or Enum.EasingStyle.Quint
                                            tweenService:Create(instance10, newTweenInfo(v699, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                                            local propertyTable2 = {TextTransparency = 1}
                                            local quad = Enum.EasingStyle.Quad
                                            local newTweenInfo2 = TweenInfo.new
                                            local v704 = pace * 0.55
                                            local easingStyle2 = quad or Enum.EasingStyle.Quint
                                            tweenService:Create(instance9, newTweenInfo2(v704, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
                                            local x = #v376 * 43 * v400
                                            local v707 = visible and 48 or 34
                                            local color = theme.Lighten(v374, 0.25)
                                            local y = 80 * v400
                                            local speed = visible and 1400 or 1150
                                            burst(v707, color, x, y, speed)
                                            instance5.ImageColor3 = theme.Lighten(v374, 0.3)
                                            instance5.Size = UDim2.fromOffset(120, 120)
                                            instance5.ImageTransparency = 0.25
                                            local propertyTable3 = {ImageTransparency = 1}
                                            local udim2FromOffset = UDim2.fromOffset
                                            local v713 = visible and 1700 or 1200
                                            local v714 = visible and 1700 or 1200
                                            propertyTable3.Size = udim2FromOffset(v713, v714)
                                            local quart2 = Enum.EasingStyle.Quart
                                            local newTweenInfo3 = TweenInfo.new
                                            local v717 = pace * 0.6
                                            local easingStyle3 = quart2 or Enum.EasingStyle.Quint
                                            tweenService:Create(instance5, newTweenInfo3(v717, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()
                                            instance4.ImageColor3 = v374
                                            instance4.Size = UDim2.fromOffset(v398 * 0.45, v399 * 1.6)
                                            instance4.ImageTransparency = 0.35
                                            local propertyTable4 = {ImageTransparency = 1, Size = UDim2.fromOffset(v398 * 0.7, v399 * 2.4)}
                                            local quad2 = Enum.EasingStyle.Quad
                                            local newTweenInfo4 = TweenInfo.new
                                            local v722 = pace * 0.7
                                            local easingStyle4 = quad2 or Enum.EasingStyle.Quint
                                            tweenService:Create(instance4, newTweenInfo4(v722, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable4):Play()
                                        end

                                        task.delay(v380 * pace, v676)
                                    end
                                end
                            end
                        end

                        if v390 then
                            v381 = v380 + 0.08
                        else
                            local v724 = v389 and 0.55 or 0.34
                            v381 = v379 + v724
                        end

                        do
                            local v725 = v401 ~= "shine" and (v389 and 0.9 or 0.55) or 0.85

                            do
                                local v726 = function()
                                    --[[
                                      line: 1197
                                      upvalues:
                                        v387 (copy, index: 1)
                                        count (ref,  index: 2)
                                        parent4 (copy, index: 3)
                                        v389 (copy, index: 4)
                                        instance13 (copy, index: 5)
                                        v725 (copy, index: 6)
                                        tweenService (copy, index: 7)
                                        pace (ref,  index: 8)
                                    ]]
                                    if v387 ~= count then
                                        return
                                    end

                                    parent4.MaxVisibleGraphemes = -1
                                    parent4.TextTransparency = v389 and 0.55 or 0
                                    instance13.Offset = Vector2.new(-1, 0)
                                    local propertyTable = {Offset = Vector2.new(1, 0)}
                                    local quad = Enum.EasingStyle.Quad
                                    local inOut = Enum.EasingDirection.InOut
                                    local newTweenInfo = TweenInfo.new
                                    local v731 = v725 * pace
                                    local easingStyle = quad or Enum.EasingStyle.Quint
                                    local easingDirection = inOut or Enum.EasingDirection.Out
                                    tweenService:Create(instance13, newTweenInfo(v731, easingStyle, easingDirection, 0, false, 0 * pace), propertyTable):Play()
                                    local v734 = v725 + 0.05

                                    local v735 = function()
                                        --[[
                                          line: 1205
                                          upvalues:
                                            v387 (copy, index: 1)
                                            count (ref,  index: 2)
                                            parent4 (copy, index: 3)
                                        ]]
                                        if v387 == count then
                                            parent4.TextTransparency = 1
                                        end
                                    end

                                    task.delay(v734 * pace, v735)
                                end

                                task.delay(v381 * pace, v726)
                            end
                        end

                        local v736 = -v399 / 2 - 8

                        if visible then
                            text2 = v388 and "MATCH WON" or v389 and "MATCH LOST" or "MATCH DRAWN"
                        elseif v390 then
                            text2 = v388 and "ROUND WON" or "ROUND LOST"
                        else
                            text2 = string.format("ROUND %d", a371 or 1)
                        end

                        instance14.Text = text2
                        instance14.TextColor3 = if v388 then theme.Lighten(v374, 0.45) else colors.TextDim
                        instance14.Position = UDim2.fromOffset(0, v736 + 14)
                        instance14.TextTransparency = 1
                        instance14.Visible = v391 == nil and (visible or not compact)
                        local propertyTable13 = {TextTransparency = 0, Position = UDim2.fromOffset(0, v736)}
                        local quint = Enum.EasingStyle.Quint
                        local out = Enum.EasingDirection.Out
                        local v740 = v379 + 0.3

                        do
                            local newTweenInfo9 = TweenInfo.new
                            local v742 = pace * 0.3
                            local quint4 = quint or Enum.EasingStyle.Quint
                            local out11 = out or Enum.EasingDirection.Out
                            tweenService:Create(instance14, newTweenInfo9(v742, quint4, out11, 0, false, (v740 or 0) * pace), propertyTable13):Play()
                            instance15.Transparency = 1

                            do
                                local propertyTable14 = {Transparency = 0.5}
                                local quint5 = Enum.EasingStyle.Quint
                                local out12 = Enum.EasingDirection.Out
                                local v748 = v379 + 0.3
                                newTweenInfo9 = TweenInfo.new
                                local v749 = pace * 0.3
                                local quint6 = quint5 or Enum.EasingStyle.Quint
                                local out13 = out12 or Enum.EasingDirection.Out
                                tweenService:Create(instance15, newTweenInfo9(v749, quint6, out13, 0, false, (v748 or 0) * pace), propertyTable14):Play()
                            end
                        end

                        local v752 = v399 / 2
                        local v753 = compact and 8 or 10

                        do
                            local v754 = v752 + v753

                            if v390 and options then
                                do
                                    do
                                        local v755
                                        local v756 = options

                                        do
                                            local v757 = v380 + 0.12
                                            local named = v390.named

                                            if named then
                                                do
                                                    v755 = {}
                                                    local v759 = if v756.id then state.FindMember(v756.id) else nil
                                                    v755[1] = v759
                                                        or {userId = false, id = options.id or "", name = options.name
                                                            or ""}
                                                end
                                            else
                                                local team = v756.team

                                                local v761 = state.Match
                                                v761 = v761 and v761.teams and v761.teams[team]
                                                v755 = v761 and v761.members or {}
                                            end

                                            local v762
                                            local alpha3
                                            local backgroundTransparency
                                            local transparency

                                            for v766, v767 in v115 do
                                                do
                                                    local v768 = v755[v766]
                                                    v767.holder.Visible = v768 ~= nil
                                                    v767.scale.Scale = 0

                                                    if v768 then
                                                        v767.stroke.Color = if v389 then v374:Lerp(colors.Void, 0.2) else v374

                                                        local v769 = v757 + (v766 - 1) * 0.06
                                                        local scale = v767.scale
                                                        local propertyTable15 = {Scale = 1}
                                                        local back = Enum.EasingStyle.Back
                                                        local out14 = Enum.EasingDirection.Out
                                                        local newTweenInfo10 = TweenInfo.new
                                                        local v775 = pace * 0.4
                                                        local easingStyle10 = back or Enum.EasingStyle.Quint
                                                        local out15 = out14 or Enum.EasingDirection.Out
                                                        tweenService:Create(scale, newTweenInfo10(v775, easingStyle10, out15, 0, false, (v769
                                                            or 0) * pace), propertyTable15):Play()

                                                        do
                                                            local img = v767.img
                                                            local color3 = if v389 then Color3.fromRGB(200, 200, 200) else Color3.new(1, 1, 1)
                                                            portraitWhenGrown(img, v768, color3, v769 + 0.42, v387)
                                                        end
                                                    end
                                                end
                                            end

                                            instance21.Visible = named

                                            if named then
                                                v762 = options.name

                                                if not v762 then
                                                    local name = v755[1] and v755[1].name or ""
                                                    v762 = tostring(name)
                                                end
                                            else
                                                v762 = ""
                                            end

                                            instance21.Text = v762
                                            instance21.TextTransparency = 1
                                            instance22.Transparency = 1
                                            local propertyTable16 = {TextTransparency = 0}
                                            local quad9 = Enum.EasingStyle.Quad
                                            local out16 = Enum.EasingDirection.Out
                                            local v784 = v757 + 0.06
                                            local newTweenInfo11 = TweenInfo.new

                                            do
                                                local v786 = pace * 0.3
                                                local easingStyle11 = quad9 or Enum.EasingStyle.Quint
                                                local out17 = out16 or Enum.EasingDirection.Out
                                                tweenService:Create(instance21, newTweenInfo11(v786, easingStyle11, out17, 0, false, (v784
                                                    or 0) * pace), propertyTable16):Play()
                                            end

                                            do
                                                local propertyTable17 = {Transparency = 0.35}
                                                local quad10 = Enum.EasingStyle.Quad
                                                local out18 = Enum.EasingDirection.Out
                                                local v792 = v757 + 0.06
                                                newTweenInfo11 = TweenInfo.new
                                                local v793 = pace * 0.3
                                                local easingStyle12 = quad10 or Enum.EasingStyle.Quint
                                                local out19 = out18 or Enum.EasingDirection.Out
                                                tweenService:Create(instance22, newTweenInfo11(v793, easingStyle12, out19, 0, false, (v792
                                                    or 0) * pace), propertyTable17):Play()
                                                instance23.Visible = options.kind == "clutch" and 2 <= options.vs
                                            end

                                            instance24.Text = "1v" .. tostring(options.vs)

                                            do
                                                local void3 = colors.Void

                                                if v389 then
                                                    alpha3 = 0.45
                                                else
                                                    alpha3 = 0.15
                                                end

                                                instance23.BackgroundColor3 = v374:Lerp(void3, alpha3)
                                                instance23.BackgroundTransparency = 1
                                                instance24.TextTransparency = 1
                                                instance25.Scale = 0.6
                                            end

                                            do
                                                local propertyTable18 = {BackgroundTransparency = 0.05}
                                                local quad11 = Enum.EasingStyle.Quad
                                                local out20 = Enum.EasingDirection.Out
                                                local v800 = v757 + 0.18
                                                newTweenInfo11 = TweenInfo.new
                                                local v801 = pace * 0.22
                                                local easingStyle13 = quad11 or Enum.EasingStyle.Quint
                                                local out21 = out20 or Enum.EasingDirection.Out
                                                tweenService:Create(instance23, newTweenInfo11(v801, easingStyle13, out21, 0, false, (v800
                                                    or 0) * pace), propertyTable18):Play()
                                            end

                                            do
                                                local propertyTable19 = {TextTransparency = 0}
                                                local quad12 = Enum.EasingStyle.Quad
                                                local out22 = Enum.EasingDirection.Out
                                                local v807 = v757 + 0.18
                                                newTweenInfo11 = TweenInfo.new
                                                local v808 = pace * 0.22
                                                local easingStyle14 = quad12 or Enum.EasingStyle.Quint
                                                local out23 = out22 or Enum.EasingDirection.Out
                                                tweenService:Create(instance24, newTweenInfo11(v808, easingStyle14, out23, 0, false, (v807
                                                    or 0) * pace), propertyTable19):Play()
                                            end

                                            do
                                                local v811 = {Scale = 1}
                                                local back = Enum.EasingStyle.Back
                                                local out24 = Enum.EasingDirection.Out
                                                local v814 = v757 + 0.18
                                                newTweenInfo11 = TweenInfo.new
                                                local v815 = pace * 0.35
                                                local easingStyle15 = back or Enum.EasingStyle.Quint
                                                local out25 = out24 or Enum.EasingDirection.Out
                                                tweenService:Create(instance25, newTweenInfo11(v815, easingStyle15, out25, 0, false, (v814
                                                    or 0) * pace), v811):Play()
                                                v811 = UDim.new
                                                local v818 = named and 24 or 6
                                                v106.PaddingRight = v811(0, v818)
                                                v106.PaddingLeft = UDim.new(0, 6)
                                                instance19.BackgroundTransparency = 1
                                                instance20.Color = v374
                                                instance20.Transparency = 1
                                            end

                                            local propertyTable20 = {}

                                            if v389 then
                                                backgroundTransparency = 0.3
                                            else
                                                backgroundTransparency = 0.35
                                            end

                                            propertyTable20.BackgroundTransparency = backgroundTransparency
                                            local quad13 = Enum.EasingStyle.Quad
                                            local out26 = Enum.EasingDirection.Out

                                            do
                                                local newTweenInfo12 = TweenInfo.new
                                                local v823 = pace * 0.3
                                                local easingStyle16 = quad13 or Enum.EasingStyle.Quint
                                                local out27 = out26 or Enum.EasingDirection.Out
                                                tweenService:Create(instance19, newTweenInfo12(v823, easingStyle16, out27, 0, false, (v757
                                                    or 0) * pace), propertyTable20):Play()

                                                do
                                                    local propertyTable21 = {}

                                                    if v389 then
                                                        transparency = 0.75
                                                    else
                                                        transparency = 0.55
                                                    end

                                                    propertyTable21.Transparency = transparency
                                                    local quad14 = Enum.EasingStyle.Quad
                                                    local out28 = Enum.EasingDirection.Out
                                                    newTweenInfo12 = TweenInfo.new

                                                    do
                                                        local v829 = pace * 0.3
                                                        local easingStyle17 = quad14 or Enum.EasingStyle.Quint
                                                        local out29 = out28 or Enum.EasingDirection.Out
                                                        tweenService:Create(instance20, newTweenInfo12(v829, easingStyle17, out29, 0, false, (v757
                                                            or 0) * pace), propertyTable21):Play()
                                                        instance19.Position = UDim2.fromOffset(0, v754 + 14)
                                                        instance19.Visible = true
                                                    end
                                                end

                                                do
                                                    local propertyTable22 = {Position = UDim2.fromOffset(0, v754)}
                                                    local quint7 = Enum.EasingStyle.Quint
                                                    local out30 = Enum.EasingDirection.Out
                                                    newTweenInfo12 = TweenInfo.new
                                                    local v835 = pace * 0.4
                                                    local quint8 = quint7 or Enum.EasingStyle.Quint
                                                    local out31 = out30 or Enum.EasingDirection.Out
                                                    tweenService:Create(instance19, newTweenInfo12(v835, quint8, out31, 0, false, (v757
                                                        or 0) * pace), propertyTable22):Play()
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                            instance16.Visible = not (v390 and compact)

                            if v390 then
                                v383 = v754 + 60 + 8
                            else
                                local v838 = v399 / 2
                                local v839 = compact and not visible and 0 or 6
                                v383 = v838 + v839
                            end
                        end

                        local v840 = if v390 then v380 + 0.24 else v379 + 0.38
                        ui8.Scale = visible and 1.3 or 1
                        instance16.Position = UDim2.fromOffset(0, v383 + 16)

                        do
                            local ally = colors.Ally
                            instance40.Text = tostring(a369)
                            instance40.Position = UDim2.new()
                            instance40.TextColor3 = ally
                        end

                        instance40.TextTransparency = 0
                        instance41.Visible = false

                        do
                            local enemy = colors.Enemy
                            instance43.Text = tostring(a370)
                            instance43.Position = UDim2.new()
                            instance43.TextColor3 = enemy
                        end

                        instance43.TextTransparency = 0
                        instance44.Visible = false

                        for _, instance38 in {instance40, instance43} do
                            instance38.TextTransparency = 1

                            do
                                local propertyTable23 = {TextTransparency = 0}
                                local quad15 = Enum.EasingStyle.Quad
                                local out32 = Enum.EasingDirection.Out
                                local newTweenInfo13 = TweenInfo.new
                                local v849 = pace * 0.3
                                local easingStyle18 = quad15 or Enum.EasingStyle.Quint
                                local out33 = out32 or Enum.EasingDirection.Out
                                tweenService:Create(instance38, newTweenInfo13(v849, easingStyle18, out33, 0, false, (v840
                                    or 0) * pace), propertyTable23):Play()
                            end
                        end

                        instance17.BackgroundTransparency = 1

                        do
                            local propertyTable24 = {BackgroundTransparency = 0.2}
                            local quad16 = Enum.EasingStyle.Quad
                            local out34 = Enum.EasingDirection.Out
                            local newTweenInfo14 = TweenInfo.new
                            local v856 = pace * 0.3
                            local easingStyle19 = quad16 or Enum.EasingStyle.Quint
                            local out35 = out34 or Enum.EasingDirection.Out
                            tweenService:Create(instance17, newTweenInfo14(v856, easingStyle19, out35, 0, false, (v840
                                or 0) * pace), propertyTable24):Play()
                        end

                        local propertyTable25 = {Position = UDim2.fromOffset(0, v383)}

                        do
                            local v860 = Enum.EasingStyle.Quint
                            local out36 = Enum.EasingDirection.Out
                            local newTweenInfo15 = TweenInfo.new
                            local v863 = pace * 0.34
                            local v864 = v860 or Enum.EasingStyle.Quint

                            do
                                local out37 = out36 or Enum.EasingDirection.Out
                                tweenService:Create(instance16, newTweenInfo15(v863, v864, out37, 0, false, (v840 or 0) * pace), propertyTable25):Play()

                                do
                                    local v866 = v840 + 0.24

                                    local v867 = function()
                                        --[[
                                          line: 1293
                                          upvalues:
                                            v387 (copy, index: 1)
                                            count (ref,  index: 2)
                                            a367 (copy, index: 3)
                                            a369 (copy, index: 4)
                                            rollDigit (copy, index: 5)
                                            v88 (copy, index: 6)
                                            instance40 (copy, index: 7)
                                            instance41 (copy, index: 8)
                                            instance42 (copy, index: 9)
                                            colors (copy, index: 10)
                                            a368 (copy, index: 11)
                                            a370 (copy, index: 12)
                                            v92 (copy, index: 13)
                                            instance43 (copy, index: 14)
                                            instance44 (copy, index: 15)
                                            instance45 (copy, index: 16)
                                        ]]
                                        if v387 ~= count then
                                            return
                                        end

                                        if a367 ~= a369 then
                                            rollDigit(v88, instance40, instance41, instance42, a367, colors.Ally)
                                        end

                                        if a368 ~= a370 then
                                            rollDigit(v92, instance43, instance44, instance45, a368, colors.Enemy)
                                        end
                                    end

                                    task.delay(v866 * pace, v867)
                                end

                                parent5.Visible = visible

                                if visible then
                                    do
                                        parent5.Position = UDim2.fromOffset(0, v383 + 116)
                                        local v868 = state.Match
                                        v868 = v868 and v868.teams and v868.teams[state.MyTeam()]
                                        local v869 = v868 and v868.members or {}

                                        do
                                            local v870 = math.min(#v869, #v98)

                                            for v871, v872 in v98 do
                                                do
                                                    local v873 = v869[v871]
                                                    v872.frame.Visible = v873 ~= nil

                                                    if v873 then
                                                        do
                                                            local v874
                                                            v872.name.Text = tostring((v873.name or "?"))

                                                            do
                                                                local name = v872.name

                                                                if v873.id == state.MyId() then
                                                                    v874 = theme.Lighten(colors.Accent, 0.2)
                                                                else
                                                                    v874 = colors.Text
                                                                end

                                                                name.TextColor3 = v874
                                                                v872.stroke.Color = if v389 then colors.TextMuted else v374
                                                            end
                                                        end

                                                        v872.star.Visible = a372 ~= nil
                                                            and v873.id == a372
                                                            and not v389
                                                        local position = UDim2.new(0.5, (v871 - ((v870 + 1) / 2)) * 150, 0, 0)
                                                        v872.frame.Position = position + UDim2.fromOffset(0, 60)
                                                        ui.GetScaleObj(v872.frame).Scale = 0
                                                        local frame = v872.frame
                                                        local propertyTable26 = {Position = position}
                                                        local back = Enum.EasingStyle.Back
                                                        local out38 = Enum.EasingDirection.Out
                                                        local v881 = v379 + 0.75 + v871 * 0.09

                                                        do
                                                            local newTweenInfo16 = TweenInfo.new
                                                            local v883 = pace * 0.5
                                                            local _ = back or Enum.EasingStyle.Quint
                                                            local out39 = out38 or Enum.EasingDirection.Out

                                                            do
                                                                local v886
                                                                tweenService:Create(frame, newTweenInfo16(v883, v886, out39, 0, false, (v881
                                                                    or 0) * pace), propertyTable26):Play()
                                                            end

                                                            do
                                                                local instance39 = ui.GetScaleObj(v872.frame)
                                                                local propertyTable27 = {Scale = 1}
                                                                local back2 = Enum.EasingStyle.Back
                                                                local out40 = Enum.EasingDirection.Out
                                                                local v891 = v379 + 0.75 + v871 * 0.09
                                                                newTweenInfo16 = TweenInfo.new
                                                                local v892 = pace * 0.5
                                                                local _ = back2 or Enum.EasingStyle.Quint
                                                                out39 = out40 or Enum.EasingDirection.Out

                                                                do
                                                                    local v894
                                                                    tweenService:Create(instance39, newTweenInfo16(v892, v894, out39, 0, false, (v891
                                                                        or 0) * pace), propertyTable27):Play()
                                                                end
                                                            end
                                                        end

                                                        local img = v872.img
                                                        local color3 = if v389 then Color3.fromRGB(170, 170, 170) else Color3.new(1, 1, 1)
                                                        portraitWhenGrown(img, v873, color3, (v379 + 0.75 + (v871 * 0.09)) + 0.52, v387)
                                                    end
                                                end
                                            end
                                        end
                                    end

                                    if v388 then
                                        do
                                            local v897 = function()
                                                --[[
                                                  line: 1331
                                                  upvalues:
                                                    v387 (copy, index: 1)
                                                    count (ref,  index: 2)
                                                    burst (copy, index: 3)
                                                    colors (copy, index: 4)
                                                ]]
                                                if v387 == count then
                                                    burst(22, colors.Gold, 900, 120, 700, {sparkChance = 0.3, grav = 620, drag = 1.6, lifeMult = 1.5})
                                                end
                                            end

                                            task.delay(pace * 1.05, v897)
                                        end
                                    end
                                end
                            end

                            if v391 and options then
                                do
                                    do
                                        local v898 = options
                                        local v899 = -v399 / 2 - 6
                                        instance28.Text = v391.text
                                        local newColorSequence = ColorSequence.new
                                        local text = colors.Text
                                        local lighten = theme.Lighten
                                        local v903 = v388 and 0.5 or 0.7
                                        ui13.Color = newColorSequence(text, lighten(v374, v903))
                                        instance28.TextTransparency = 1
                                        instance29.Transparency = 1

                                        do
                                            local propertyTable28 = {TextTransparency = 0}
                                            local quad17 = Enum.EasingStyle.Quad
                                            local out41 = Enum.EasingDirection.Out
                                            local newTweenInfo17 = TweenInfo.new
                                            local v908 = pace * 0.25
                                            local easingStyle20 = quad17 or Enum.EasingStyle.Quint
                                            local out42 = out41 or Enum.EasingDirection.Out
                                            tweenService:Create(instance28, newTweenInfo17(v908, easingStyle20, out42, 0, false, 0.7 * pace), propertyTable28):Play()
                                        end

                                        do
                                            local propertyTable29 = {Transparency = 0.4}
                                            local quad18 = Enum.EasingStyle.Quad
                                            local out43 = Enum.EasingDirection.Out
                                            newTweenInfo15 = TweenInfo.new
                                            local v914 = pace * 0.25
                                            local easingStyle21 = quad18 or Enum.EasingStyle.Quint
                                            local out44 = out43 or Enum.EasingDirection.Out
                                            tweenService:Create(instance29, newTweenInfo15(v914, easingStyle21, out44, 0, false, 0.7 * pace), propertyTable29):Play()
                                        end

                                        do
                                            local named = v391.named
                                            instance30.Visible = named
                                            v142.holder.Visible = named
                                            instance31.Visible = named
                                            local v918 = named
                                            if v918 then
                                                local v919 = false
                                                v918 = if v898.kind == "clutch" then 2 <= v898.vs else v919
                                            end

                                            instance33.Visible = v918

                                            if named then
                                                instance30.BackgroundColor3 = v374
                                                instance30.BackgroundTransparency = 1
                                                local propertyTable30 = {BackgroundTransparency = 0.15}
                                                local quad19 = Enum.EasingStyle.Quad
                                                local out45 = Enum.EasingDirection.Out
                                                local newTweenInfo18 = TweenInfo.new
                                                local v924 = pace * 0.25
                                                local easingStyle22 = quad19 or Enum.EasingStyle.Quint
                                                local out46 = out45 or Enum.EasingDirection.Out
                                                tweenService:Create(instance30, newTweenInfo18(v924, easingStyle22, out46, 0, false, 0.7799999999999999 * pace), propertyTable30):Play()
                                                local v927 = if v898.id then state.FindMember(v898.id) else nil
                                                local v928 = v927
                                                    or {userId = false, id = v898.id or "", name = v898.name or ""}
                                                v142.stroke.Color = if v389 then v374:Lerp(colors.Void, 0.2) else v374
                                                v142.scale.Scale = 0
                                                local scale = v142.scale
                                                local propertyTable31 = {Scale = 1}
                                                local back = Enum.EasingStyle.Back
                                                local out47 = Enum.EasingDirection.Out

                                                local newTweenInfo19 = TweenInfo.new
                                                local v934 = pace * 0.4
                                                local easingStyle23 = back or Enum.EasingStyle.Quint
                                                local out48 = out47 or Enum.EasingDirection.Out
                                                tweenService:Create(scale, newTweenInfo19(v934, easingStyle23, out48, 0, false, 0.7999999999999999 * pace), propertyTable31):Play()

                                                do
                                                    local img = v142.img
                                                    local color3 = if v389 then Color3.fromRGB(200, 200, 200) else Color3.new(1, 1, 1)

                                                    do
                                                        local alpha4
                                                        portraitWhenGrown(img, v928, color3, 1.22, v387)

                                                        do
                                                            local v940 = v898.name or tostring((v928.name or ""))
                                                            instance31.Text = v940
                                                            instance31.TextTransparency = 1
                                                            instance32.Transparency = 1
                                                        end

                                                        do
                                                            local propertyTable32 = {TextTransparency = 0}
                                                            local quad20 = Enum.EasingStyle.Quad
                                                            local out49 = Enum.EasingDirection.Out
                                                            newTweenInfo19 = TweenInfo.new
                                                            local v944 = pace * 0.3
                                                            local easingStyle24 = quad20 or Enum.EasingStyle.Quint
                                                            local out50 = out49 or Enum.EasingDirection.Out
                                                            tweenService:Create(instance31, newTweenInfo19(v944, easingStyle24, out50, 0, false, 0.84 * pace), propertyTable32):Play()
                                                        end

                                                        do
                                                            local propertyTable33 = {Transparency = 0.35}
                                                            local quad21 = Enum.EasingStyle.Quad
                                                            local out51 = Enum.EasingDirection.Out
                                                            newTweenInfo19 = TweenInfo.new
                                                            local v950 = pace * 0.3
                                                            local easingStyle25 = quad21 or Enum.EasingStyle.Quint
                                                            local out52 = out51 or Enum.EasingDirection.Out
                                                            tweenService:Create(instance32, newTweenInfo19(v950, easingStyle25, out52, 0, false, 0.84 * pace), propertyTable33):Play()
                                                            instance34.Text = "1v" .. tostring(v898.vs)
                                                        end

                                                        do
                                                            local void4 = colors.Void

                                                            if v389 then
                                                                alpha4 = 0.45
                                                            else
                                                                alpha4 = 0.15
                                                            end

                                                            instance33.BackgroundColor3 = v374:Lerp(void4, alpha4)
                                                            instance33.BackgroundTransparency = 1
                                                            instance34.TextTransparency = 1
                                                            instance35.Scale = 0.6
                                                        end
                                                    end

                                                    do
                                                        local propertyTable34 = {BackgroundTransparency = 0.05}
                                                        local quad22 = Enum.EasingStyle.Quad
                                                        local out53 = Enum.EasingDirection.Out
                                                        newTweenInfo19 = TweenInfo.new
                                                        local v957 = pace * 0.22
                                                        local easingStyle26 = quad22 or Enum.EasingStyle.Quint
                                                        local out54 = out53 or Enum.EasingDirection.Out
                                                        tweenService:Create(instance33, newTweenInfo19(v957, easingStyle26, out54, 0, false, 0.8999999999999999 * pace), propertyTable34):Play()
                                                    end

                                                    do
                                                        local propertyTable35 = {TextTransparency = 0}
                                                        local quad23 = Enum.EasingStyle.Quad
                                                        local out55 = Enum.EasingDirection.Out
                                                        newTweenInfo19 = TweenInfo.new
                                                        local v963 = pace * 0.22
                                                        local easingStyle27 = quad23 or Enum.EasingStyle.Quint
                                                        local out56 = out55 or Enum.EasingDirection.Out
                                                        tweenService:Create(instance34, newTweenInfo19(v963, easingStyle27, out56, 0, false, 0.8999999999999999 * pace), propertyTable35):Play()
                                                    end

                                                    do
                                                        local propertyTable36 = {Scale = 1}
                                                        local back3 = Enum.EasingStyle.Back
                                                        local out57 = Enum.EasingDirection.Out
                                                        local newTweenInfo20 = TweenInfo.new
                                                        local v970 = pace * 0.35
                                                        local easingStyle28 = back3 or Enum.EasingStyle.Quint

                                                        do
                                                            local out58 = out57 or Enum.EasingDirection.Out
                                                            tweenService:Create(instance35, newTweenInfo20(v970, easingStyle28, out58, 0, false, 0.8999999999999999 * pace), propertyTable36):Play()
                                                        end
                                                    end
                                                end
                                            end

                                            instance27.Position = UDim2.fromOffset(0, v899 + 16)
                                            instance27.Visible = true
                                            v918 = {Position = UDim2.fromOffset(0, v899)}
                                            local quint9 = Enum.EasingStyle.Quint
                                            local out59 = Enum.EasingDirection.Out

                                            do
                                                local newTweenInfo21 = TweenInfo.new
                                                local v976 = pace * 0.4
                                                local quint10 = quint9 or Enum.EasingStyle.Quint

                                                do
                                                    local out60 = out59

                                                    if out60 then
                                                        v860 = v918
                                                    else
                                                        out60 = Enum.EasingDirection.Out
                                                        v860 = v918
                                                    end

                                                    tweenService:Create(instance27, newTweenInfo21(v976, quint10, out60, 0, false, 0.7 * pace), v860):Play()

                                                    do
                                                        local v979 = function()
                                                            --[[
                                                              line: 1381
                                                              upvalues:
                                                                v387 (copy, index: 1)
                                                                count (ref,  index: 2)
                                                                instance27 (copy, index: 3)
                                                                ui12 (copy, index: 4)
                                                                instance26 (copy, index: 5)
                                                                startValue (copy, index: 6)
                                                                v374 (copy, index: 7)
                                                                v899 (copy, index: 8)
                                                                v389 (copy, index: 9)
                                                                tweenService (copy, index: 10)
                                                                pace (ref,  index: 11)
                                                                v391 (copy, index: 12)
                                                                named (copy, index: 13)
                                                                burst (copy, index: 14)
                                                                colors (copy, index: 15)
                                                                theme (copy, index: 16)
                                                                v898 (copy, index: 17)
                                                                volume (copy, index: 18)
                                                                result (ref,  index: 19)
                                                            ]]
                                                            local imageTransparency
                                                            local v981

                                                            if v387 ~= count then
                                                                return
                                                            end

                                                            local v982 = instance27.AbsoluteSize.X / 900
                                                            local v983 = not (0 < v982) and 420
                                                                or ui12.AbsoluteContentSize.X / v982
                                                            instance26.ImageColor3 = startValue:Lerp(v374, 0.25)
                                                            instance26.Position = UDim2.fromOffset(0, v899 - 42)
                                                            instance26.Size = UDim2.fromOffset(v983 * 0.5, 92)
                                                            instance26.ImageTransparency = 1
                                                            local propertyTable = {Size = UDim2.fromOffset(v983 + 260, 92)}

                                                            if v389 then
                                                                imageTransparency = 0.3
                                                                imageTransparency = v391
                                                            else
                                                                imageTransparency = 0.15
                                                                imageTransparency = v391
                                                            end

                                                            propertyTable.ImageTransparency = imageTransparency
                                                            tweenService:Create(instance26, TweenInfo.new(pace * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
                                                            local v985 = imageTransparency.width * 0.58
                                                            local v986 = named and 260 or 0
                                                            local x = v985 + v986
                                                            local v988 = v389 and 6 or 16
                                                            local v989 = if v389 then v374:Lerp(colors.Void, 0.3) else theme.Lighten(v374, 0.3)

                                                            if v389 then
                                                                v981 = 360
                                                                v981 = v898
                                                            else
                                                                v981 = 800
                                                                v981 = v898
                                                            end

                                                            burst(v988, v989, x, 50, v981, {sparkChance = 0.7})
                                                            local kind = v981.kind
                                                            local volume2 = volume * 0.75

                                                            if kind ~= "ace" and kind ~= "teamace" then
                                                                if kind ~= "clutch" then
                                                                    local v992 = {volume = volume2}

                                                                    if result then
                                                                        pcall(result.Play, "UI/Card_Reveal", nil, v992)
                                                                    end
                                                                else
                                                                    local v993 = {volume = volume2 * 0.8}

                                                                    if result then
                                                                        pcall(result.Play, "Match/Final_Round", nil, v993)
                                                                    end
                                                                end
                                                            else
                                                                local v994 = {volume = volume2}

                                                                if result then
                                                                    pcall(result.Play, "Kill_Triple", nil, v994)
                                                                end
                                                            end
                                                        end

                                                        task.delay(pace * 0.7, v979)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        if visible then
                            v384 = 3.35
                        elseif v390 then
                            v384 = v389 and 2.95 or 2.85
                        else
                            v384 = v389 and 2.05 or 1.95
                        end

                        do
                            local v995 = function()
                                --[[
                                  line: 1410
                                  upvalues:
                                    v387 (copy, index: 1)
                                    count (ref,  index: 2)
                                    instance6 (copy, index: 3)
                                    v398 (copy, index: 4)
                                    v399 (copy, index: 5)
                                    tweenService (copy, index: 6)
                                    pace (ref,  index: 7)
                                    instance8 (copy, index: 8)
                                    instance7 (copy, index: 9)
                                    instance11 (copy, index: 10)
                                    instance12 (copy, index: 11)
                                    instance14 (copy, index: 12)
                                    instance15 (copy, index: 13)
                                    instance40 (copy, index: 14)
                                    instance43 (copy, index: 15)
                                    instance17 (copy, index: 16)
                                    v390 (copy, index: 17)
                                    instance19 (copy, index: 18)
                                    v391 (copy, index: 19)
                                    ceremonyFade (copy, index: 20)
                                    visible (copy, index: 21)
                                    v98 (copy, index: 22)
                                    ui (copy, index: 23)
                                    instance (copy, index: 24)
                                    instance3 (copy, index: 25)
                                    screenFxOut (copy, index: 26)
                                    active (ref,  index: 27)
                                    v190 (ref,  index: 28)
                                    a22 (copy, index: 29)
                                    v149 (copy, index: 30)
                                    instance27 (copy, index: 31)
                                    instance18 (copy, index: 32)
                                    instance26 (copy, index: 33)
                                    parent4 (copy, index: 34)
                                    instance9 (copy, index: 35)
                                    parent (copy, index: 36)
                                    ui15 (ref,  index: 37)
                                    ui16 (ref,  index: 38)
                                ]]
                                if v387 ~= count then
                                    return
                                end

                                instance6.AnchorPoint = Vector2.new(1, 0.5)
                                instance6.Position = UDim2.fromOffset(v398 / 2, 0)
                                local propertyTable = {ImageTransparency = 0.6, Size = UDim2.fromOffset(0, v399)}
                                local quint = Enum.EasingStyle.Quint
                                local inValue = Enum.EasingDirection.In
                                local newTweenInfo = TweenInfo.new
                                local v1000 = pace * 0.28
                                local quint2 = quint or Enum.EasingStyle.Quint
                                local easingDirection = inValue or Enum.EasingDirection.Out
                                tweenService:Create(instance6, newTweenInfo(v1000, quint2, easingDirection, 0, false, 0 * pace), propertyTable):Play()
                                local propertyTable2 = {BackgroundTransparency = 1}
                                local quad = Enum.EasingStyle.Quad
                                local newTweenInfo2 = TweenInfo.new
                                local v1006 = pace * 0.2
                                local easingStyle = quad or Enum.EasingStyle.Quint
                                tweenService:Create(instance8, newTweenInfo2(v1006, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
                                local propertyTable3 = {ImageTransparency = 1, Size = UDim2.fromOffset(v398 * 1.3, v399 * 1.2)}
                                local quad2 = Enum.EasingStyle.Quad
                                local newTweenInfo3 = TweenInfo.new
                                local v1011 = pace * 0.3
                                local easingStyle2 = quad2 or Enum.EasingStyle.Quint
                                tweenService:Create(instance7, newTweenInfo3(v1011, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()

                                for _, instance2 in {instance11, instance12} do
                                    local propertyTable4 = {TextTransparency = 1, Position = instance2.Position - UDim2.fromOffset(0, 18)}
                                    local quint3 = Enum.EasingStyle.Quint
                                    local inValue2 = Enum.EasingDirection.In
                                    local newTweenInfo4 = TweenInfo.new
                                    local v1019 = pace * 0.24
                                    local quint4 = quint3 or Enum.EasingStyle.Quint
                                    local easingDirection2 = inValue2 or Enum.EasingDirection.Out
                                    tweenService:Create(instance2, newTweenInfo4(v1019, quint4, easingDirection2, 0, false, 0 * pace), propertyTable4):Play()
                                end

                                local propertyTable5 = {TextTransparency = 1}
                                local quad3 = Enum.EasingStyle.Quad
                                local newTweenInfo5 = TweenInfo.new
                                local v1025 = pace * 0.2
                                local easingStyle3 = quad3 or Enum.EasingStyle.Quint
                                tweenService:Create(instance14, newTweenInfo5(v1025, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable5):Play()
                                local propertyTable6 = {Transparency = 1}
                                local quad4 = Enum.EasingStyle.Quad
                                local newTweenInfo6 = TweenInfo.new
                                local v1030 = pace * 0.2
                                local easingStyle4 = quad4 or Enum.EasingStyle.Quint
                                tweenService:Create(instance15, newTweenInfo6(v1030, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable6):Play()

                                for _, instance4 in {instance40, instance43} do
                                    local easingStyle5
                                    local propertyTable7 = {TextTransparency = 1}
                                    local quad5 = Enum.EasingStyle.Quad
                                    local newTweenInfo7 = TweenInfo.new
                                    local v1038 = pace * 0.2
                                    easingStyle5 = if const quad6 = quad5 then quad6 else Enum.EasingStyle.Quint
                                    tweenService:Create(instance4, newTweenInfo7(v1038, easingStyle5, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable7):Play()
                                end

                                local propertyTable8 = {BackgroundTransparency = 1}
                                local quad7 = Enum.EasingStyle.Quad
                                local newTweenInfo8 = TweenInfo.new
                                local v1043 = pace * 0.2
                                local easingStyle6 = quad7 or Enum.EasingStyle.Quint
                                tweenService:Create(instance17, newTweenInfo8(v1043, easingStyle6, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable8):Play()

                                if v390 then
                                    local propertyTable9 = {Position = instance19.Position + UDim2.fromOffset(0, -10)}
                                    local quint5 = Enum.EasingStyle.Quint
                                    local inValue3 = Enum.EasingDirection.In
                                    v1043 = TweenInfo.new
                                    local v1048 = pace * 0.25
                                    local quint6 = quint5 or Enum.EasingStyle.Quint
                                    local easingDirection3 = inValue3 or Enum.EasingDirection.Out
                                    tweenService:Create(instance19, v1043(v1048, quint6, easingDirection3, 0, false, 0 * pace), propertyTable9):Play()
                                end

                                if v390 or v391 then
                                    ceremonyFade(0.25)
                                end

                                if visible then
                                    for _, v1052 in v98 do
                                        local frame = v1052.frame
                                        local propertyTable10 = {Position = v1052.frame.Position + UDim2.fromOffset(0, 40)}
                                        local quint7 = Enum.EasingStyle.Quint
                                        local inValue4 = Enum.EasingDirection.In
                                        local newTweenInfo9 = TweenInfo.new
                                        local v1058 = pace * 0.25
                                        local _ = quint7 or Enum.EasingStyle.Quint
                                        local easingDirection4 = inValue4 or Enum.EasingDirection.Out
                                        local v1061
                                        tweenService:Create(frame, newTweenInfo9(v1058, v1061, easingDirection4, 0, false, 0 * pace), propertyTable10):Play()
                                        local instance5 = ui.GetScaleObj(v1052.frame)
                                        local propertyTable11 = {Scale = 0}
                                        local quint8 = Enum.EasingStyle.Quint
                                        local inValue5 = Enum.EasingDirection.In
                                        newTweenInfo9 = TweenInfo.new
                                        local v1066 = pace * 0.25
                                        local _ = quint8 or Enum.EasingStyle.Quint
                                        local easingDirection5 = inValue5 or Enum.EasingDirection.Out
                                        local v1069
                                        tweenService:Create(instance5, newTweenInfo9(v1066, v1069, easingDirection5, 0, false, 0 * pace), propertyTable11):Play()
                                    end

                                    local propertyTable12 = {BackgroundTransparency = 1}
                                    local quad8 = Enum.EasingStyle.Quad
                                    local newTweenInfo10 = TweenInfo.new
                                    local v1073 = pace * 0.4
                                    local easingStyle7 = quad8 or Enum.EasingStyle.Quint
                                    tweenService:Create(instance, newTweenInfo10(v1073, easingStyle7, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable12):Play()
                                end

                                local propertyTable13 = {ImageTransparency = 1}
                                local quad9 = Enum.EasingStyle.Quad
                                local newTweenInfo11 = TweenInfo.new
                                local v1078 = pace * 0.45
                                local easingStyle8 = quad9 or Enum.EasingStyle.Quint
                                tweenService:Create(instance3, newTweenInfo11(v1078, easingStyle8, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable13):Play()
                                screenFxOut(0.45)

                                local v1080 = function()
                                    --[[
                                      line: 1443
                                      upvalues:
                                        v387 (copy, index: 1)
                                        count (ref,  index: 2)
                                        active (ref,  index: 3)
                                        v190 (ref,  index: 4)
                                        a22 (copy, index: 5)
                                        v149 (copy, index: 6)
                                        instance19 (copy, index: 7)
                                        instance27 (copy, index: 8)
                                        instance18 (copy, index: 9)
                                        instance26 (copy, index: 10)
                                        instance11 (copy, index: 11)
                                        instance12 (copy, index: 12)
                                        parent4 (copy, index: 13)
                                        instance9 (copy, index: 14)
                                        parent (copy, index: 15)
                                        ui15 (ref,  index: 16)
                                        ui16 (ref,  index: 17)
                                    ]]
                                    if v387 == count then
                                        active = false

                                        if v190 then
                                            a22.SetHudHidden("Celebrate", false)
                                        end

                                        v190 = false
                                        v149:Clear()
                                        instance19.Visible = false
                                        instance27.Visible = false
                                        instance18.ImageTransparency = 1
                                        instance26.ImageTransparency = 1

                                        for _, v1082 in {instance11, instance12, parent4, instance9} do
                                            v1082.MaxVisibleGraphemes = -1
                                        end

                                        parent.Visible = false

                                        if ui15 then
                                            ui15:Destroy()
                                            ui15 = nil
                                        end

                                        if ui16 then
                                            ui16:Destroy()
                                            ui16 = nil
                                        end
                                    end
                                end

                                task.delay(pace * 0.48, v1080)
                            end

                            task.delay(v384 * pace, v995)
                        end
                    end
                end
            end
        end
    end

    a22.OnMatchEvent(
        function(a1083, a1084)
            --[[
              line: 1460
              upvalues:
                state (copy, index: 1)
                pace (ref,  index: 2)
                play (copy, index: 3)
                readMoment (copy, index: 4)
                stop (copy, index: 5)
            ]]
            local v1085

            if type(a1084) ~= "table" then
                v1085 = {}
            else
                v1085 = a1084
            end

            if a1083 ~= "RoundEnd" then
                if a1083 == "PlayOfTheGame" or a1083 == "MatchEnd" or a1083 == "MatchStart" or a1083 == "RoundStart" then
                    stop(false)
                end

                return
            end

            local v1086, v1087
            local winnerTeam = v1085.winnerTeam
            local match = state.Match
            local teamKey = state.MyTeam()
            local v1091 = match and match.teams and match.teams[teamKey] and match.teams[teamKey].score or 0
            local v1092 = match
                and match.teams
                and match.teams[3 - teamKey]
                and match.teams[3 - teamKey].score
                or 0

            if match and match.phase ~= "RoundEnd" and (winnerTeam == 1 or winnerTeam == 2) then
                if winnerTeam ~= teamKey then
                    v1092 += 1
                    v1086, v1087 = v1091, v1092
                else
                    v1091 += 1
                    v1086, v1087 = v1091, v1092
                end
            elseif winnerTeam ~= teamKey then
                v1086, v1087 = v1091, if winnerTeam == 3 - teamKey then math.max(0, v1092 - 1) else v1092
            else
                v1086 = math.max(0, v1091 - 1)
                v1087 = v1092
            end

            local v1093 = winnerTeam == 0 and "draw"
                or winnerTeam ~= nil and (winnerTeam ~= teamKey and "lose" or "win")
                or "draw"
            local v1094 = state.RoundsToWin()
            local visible = v1094 <= v1091 or v1094 <= v1092
            pace = 1
            play(v1093, visible, v1091, v1092, v1086, v1087, (v1085.round or (match and match.round)), v1085.mvpId, (readMoment(v1085.moment)))
        end
    )

    state.PlayerStateChanged:Connect(
        function(a1096)
            --[[
              line: 1492
              upvalues:
                active (ref,  index: 1)
                count (ref,  index: 2)
                v190 (ref,  index: 3)
                a22 (copy, index: 4)
                v149 (copy, index: 5)
                instance19 (copy, index: 6)
                instance27 (copy, index: 7)
                instance18 (copy, index: 8)
                instance26 (copy, index: 9)
                instance11 (copy, index: 10)
                instance12 (copy, index: 11)
                parent4 (copy, index: 12)
                instance9 (copy, index: 13)
                parent (copy, index: 14)
                ui15 (ref,  index: 15)
                ui16 (ref,  index: 16)
            ]]
            if a1096 ~= "Match" then
                if not active then
                    return
                end

                count += 1
                active = false

                if v190 then
                    a22.SetHudHidden("Celebrate", false)
                end

                v190 = false
                v149:Clear()
                instance19.Visible = false
                instance27.Visible = false
                instance18.ImageTransparency = 1
                instance26.ImageTransparency = 1

                for _, v1098 in {instance11, instance12, parent4, instance9} do
                    v1098.MaxVisibleGraphemes = -1
                end

                parent.Visible = false

                if ui15 then
                    ui15:Destroy()
                    ui15 = nil
                end

                if ui16 then
                    ui16:Destroy()
                    ui16 = nil
                end
            end
        end
    )

    a22.Debug.celebrate = function(a1099, a1100, a1101, a1102, a1103)
        --[[
          line: 1499
          upvalues:
            pace (ref,  index: 1)
            play (copy, index: 2)
            state (copy, index: 3)
        ]]
        if type(a1103) ~= "number" or not (0 < a1103) then
            pace = 1
        else
            pace = a1103
        end

        local v1104 = a1099 ~= "lose" and a1099 ~= "draw" and "win" or a1099
        local v1105 = tonumber(a1101) or v1104 ~= "win" and 0 or 1
        local v1106 = tonumber(a1102) or v1104 ~= "lose" and 0 or 1
        local v1107 = if v1104 == "win" then math.max(0, v1105 - 1) else v1105
        local v1108 = if v1104 == "lose" then math.max(0, v1106 - 1) else v1106
        play(v1104, a1100 == true, v1105, v1106, v1107, v1108, 1, state.MyId())

        return true
    end

    a22.Debug.celebrateStop = function()
        --[[
          line: 1509
          upvalues:
            active (ref,  index: 1)
            count (ref,  index: 2)
            v190 (ref,  index: 3)
            a22 (copy, index: 4)
            v149 (copy, index: 5)
            instance19 (copy, index: 6)
            instance27 (copy, index: 7)
            instance18 (copy, index: 8)
            instance26 (copy, index: 9)
            instance11 (copy, index: 10)
            instance12 (copy, index: 11)
            parent4 (copy, index: 12)
            instance9 (copy, index: 13)
            parent (copy, index: 14)
            ui15 (ref,  index: 15)
            ui16 (ref,  index: 16)
        ]]
        if active then
            count += 1
            active = false

            if v190 then
                a22.SetHudHidden("Celebrate", false)
            end

            v190 = false
            v149:Clear()
            instance19.Visible = false
            instance27.Visible = false
            instance18.ImageTransparency = 1
            instance26.ImageTransparency = 1

            for _, v1110 in {instance11, instance12, parent4, instance9} do
                v1110.MaxVisibleGraphemes = -1
            end

            parent.Visible = false

            if ui15 then
                ui15:Destroy()
                ui15 = nil
            end

            if ui16 then
                ui16:Destroy()
                ui16 = nil
            end
        end

        return true
    end

    a22.Debug.ceremony = function(key, a1112, a1113, a1114)
        --[[
          line: 1516
          upvalues:
            pace (ref,  index: 1)
            v7 (copy, index: 2)
            state (copy, index: 3)
            readMoment (copy, index: 4)
            play (copy, index: 5)
        ]]
        local kind
        local v1116

        if type(a1114) ~= "number" or not (0 < a1114) then
            pace = 1
        else
            pace = a1114
        end

        if type(key) ~= "string" or not v7[key] then
            kind = "ace"
        else
            kind = key
        end

        local v1117 = state.MyTeam()
        local v1118 = if a1112 == "enemy" then 3 - v1117 else v1117
        local v1119 = state.Match
        v1119 = v1119 and v1119.teams and v1119.teams[v1118]
        local v1120 = v1119 and v1119.members or {}
        v1116 = nil

        for _, v1122 in v1120 do
            if v1116 == nil or v1122.id == state.MyId() then
                v1116 = v1122
            end
        end

        local match = state.Match
        local round = match and match.round or 2
        local v1125 = state.RoundsToWin()
        local v1126 = v1118 == v1117
        local v1127 = if a1113 and v1126 then v1125 else 1
        local v1128 = if a1113 and not v1126 then v1125 else 1
        local v1129 = {kind = kind, id = if v1116 then v1116.id else false}
        v1129.name = not v1116 and "Player" or v1116.name
        v1129.team = v1118
        v1129.vs = kind ~= "clutch" and 0 or 2
        local v1130 = readMoment(v1129)
        local v1131 = v1126 and "win" or "lose"
        local visible = a1113 == true
        local v1133 = if v1126 then v1127 - 1 else v1127
        local v1134 = if v1126 then v1128 else v1128 - 1
        play(v1131, visible, v1127, v1128, v1133, v1134, round, nil, v1130)

        return true
    end

    a22.Debug.ceremonyState = function()
        --[[
          line: 1544
          upvalues:
            active (ref,  index: 1)
            parent (copy, index: 2)
            instance11 (copy, index: 3)
            instance14 (copy, index: 4)
            instance19 (copy, index: 5)
            instance21 (copy, index: 6)
            instance23 (copy, index: 7)
            instance24 (copy, index: 8)
            instance27 (copy, index: 9)
            instance28 (copy, index: 10)
            instance31 (copy, index: 11)
        ]]
        local v1135 = {active = active, headline = if parent.Visible then instance11.Text else false, caption = if parent.Visible
            and instance14.Visible then instance14.Text else false}
        v1135.plate = instance19.Visible
        v1135.plateName = if instance19.Visible and instance21.Visible then instance21.Text else false
        v1135.vs = if instance19.Visible and instance23.Visible then instance24.Text else false
        v1135.accolade = if instance27.Visible then instance28.Text else false
        v1135.accoladeName = if instance27.Visible and instance31.Visible then instance31.Text else false
        return v1135
    end
end

return v5