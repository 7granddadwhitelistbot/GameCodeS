local _ = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local v5 = {}
local localPlayer = players.LocalPlayer
local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold)
local fontFace2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local color3 = Color3.fromRGB(250, 248, 242)
local crit = Color3.fromRGB(255, 208, 60)
local color32 = Color3.fromRGB(255, 62, 62)
local backgroundColor3 = Color3.fromRGB(96, 186, 255)
local color = Color3.fromRGB(16, 12, 10)
local color33 = Color3.fromRGB(120, 110, 100)
local combatHud = nil
local parent = nil
local v17 = {}
local v18 = "Dot"
local scale = 1
local clampedValue = 0
local v21 = 0
local v22 = 0
local v23 = false
local v24 = false
local v25 = 0
local v26 = 0
local v27 = color3

local function stroke(parent: Instance?, thickness: number, a31, a32)
    --[[
      name: stroke
      line: 43
      upvalues:
        color (copy, index: 1)
    ]]
    local color2
    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = thickness

    if a31 then
        color2 = a31
    else
        color2 = color
    end

    stroke.Color = color2
    stroke.Transparency = a32 or 0.35
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent

    return stroke
end

local function frame(parent: Instance?, name: string, size: UDim2, udim2: UDim2?, a40)
    --[[
      name: frame
      line: 54
      upvalues:
        color3 (copy, index: 1)
    ]]
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    local position = udim2 or UDim2.fromScale(0.5, 0.5)
    frame.Position = position
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = a40 or color3
    frame.BorderSizePixel = 0
    frame.Parent = parent

    return frame
end

local function round(parent: Instance?, a45)
    --[[
      name: round
      line: 66
    ]]
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(a45 or 1, 0)
    uiCorner.Parent = parent
end

local function dot(parent: Instance?, a49: number)
    --[[
      name: dot
      line: 72
      upvalues:
        frame (copy, index: 1)
        color (copy, index: 2)
    ]]
    local parent2 = frame(parent, "Dot", UDim2.fromOffset(a49, a49))
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent2

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = 1.2
    stroke.Color = color
    stroke.Transparency = 0.25
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent2

    return parent2
end

local function ring(parent: Frame, name: string, a56: number, thickness: number, a58: number)
    --[[
      name: ring
      line: 79
      upvalues:
        frame (copy, index: 1)
        color3 (copy, index: 2)
        color (copy, index: 3)
    ]]
    local parent2 = frame(parent, name, UDim2.fromOffset(a56, a56))
    parent2.BackgroundTransparency = 1

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent2

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = thickness
    stroke.Color = color3
    stroke.Transparency = a58 or 0
    stroke.Parent = parent2

    local parent3 = frame(parent2, "Rim", UDim2.new(1, thickness + 2, 1, thickness + 2))
    parent3.BackgroundTransparency = 1

    local uiCorner2 = Instance.new("UICorner")
    uiCorner2.CornerRadius = UDim.new(1, 0)
    uiCorner2.Parent = parent3

    local stroke2 = Instance.new("UIStroke")
    stroke2.Name = "Stroke"
    stroke2.Thickness = 1
    stroke2.Color = color
    stroke2.Transparency = 0.6
    stroke2.Parent = parent3

    return parent2
end

local function tick(parent: Instance?, name: string, a68: number, a69: number)
    --[[
      name: tick
      line: 102
      upvalues:
        frame (copy, index: 1)
        color (copy, index: 2)
    ]]
    local parent2 = frame(parent, name, UDim2.fromOffset(a68, a69))
    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = 1
    stroke.Color = color
    stroke.Transparency = 0.3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent2

    return parent2
end

local function label(parent: Frame?, name: string, text: string, textSize: number, position: UDim2, color32: Color3?)
    --[[
      name: label
      line: 108
      upvalues:
        fontFace (copy, index: 1)
        color3 (copy, index: 2)
        color (copy, index: 3)
    ]]
    local textColor3
    local parent2 = Instance.new("TextLabel")
    parent2.Name = name
    parent2.BackgroundTransparency = 1
    parent2.AnchorPoint = Vector2.new(0.5, 0.5)
    parent2.Position = position
    parent2.Size = UDim2.fromOffset(460, textSize + 8)
    parent2.FontFace = fontFace
    parent2.TextSize = textSize

    if color32 then
        textColor3 = color32
    else
        textColor3 = color3
    end

    parent2.TextColor3 = textColor3
    parent2.Text = text
    parent2.Parent = parent
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = color
    uiStroke.Transparency = 0.2
    uiStroke.Parent = parent2

    return parent2
end

local v82 = {}
local parent2 = nil
local v84 = {}
local frame2 = nil
local frame3 = nil

local function buildStyles()
    --[[
      name: buildStyles
      line: 135
      upvalues:
        frame (copy, index: 1)
        parent (ref,  index: 2)
        color (copy, index: 3)
        ring (copy, index: 4)
        backgroundColor3 (copy, index: 5)
        v17 (copy, index: 6)
        color3 (copy, index: 7)
        v82 (copy, index: 8)
        parent2 (ref,  index: 9)
        frame2 (ref,  index: 10)
        frame3 (ref,  index: 11)
    ]]
    local v88
    local melee = frame(parent, "Melee", UDim2.fromOffset(0, 0))
    melee.BackgroundTransparency = 1
    local parent3 = frame(melee, "Dot", UDim2.fromOffset(5, 5))
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent3

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = 1.2
    stroke.Color = color
    stroke.Transparency = 0.25
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent3
    ring(melee, "Ring", 24, 1.6, 0.45)
    local parent4 = frame(melee, "Shield", UDim2.fromOffset(30, 36))
    parent4.BackgroundTransparency = 1
    parent4.Visible = false
    local v94 = {"Top", UDim2.fromOffset(28, 20), UDim2.fromScale(0.5, 0.3)}
    local v95 = {"Point", UDim2.fromOffset(20, 20), UDim2.fromScale(0.5, 0.58)}

    for _, v97 in {v94, v95} do
        local parent5 = frame(parent4, v97[1], v97[2], v97[3], backgroundColor3)
        parent5.BackgroundTransparency = 0.3

        if v97[1] == "Point" then
            parent5.Rotation = 45
        end

        local uiCorner2 = Instance.new("UICorner")
        local newUDim = UDim.new
        local v101 = v97[1] ~= "Top" and 3 or 5
        uiCorner2.CornerRadius = newUDim(0, v101)
        uiCorner2.Parent = parent5
    end

    local pulse = Instance.new("UIScale")
    pulse.Name = "Pulse"
    pulse.Parent = parent4
    v17.Melee = melee
    local bow = frame(parent, "Bow", UDim2.fromOffset(0, 0))
    bow.BackgroundTransparency = 1
    local parent6 = frame(bow, "Dot", UDim2.fromOffset(4, 4))
    local uiCorner3 = Instance.new("UICorner")
    uiCorner3.CornerRadius = UDim.new(1, 0)
    uiCorner3.Parent = parent6

    local stroke2 = Instance.new("UIStroke")
    stroke2.Name = "Stroke"
    stroke2.Thickness = 1.2
    stroke2.Color = color
    stroke2.Transparency = 0.25
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = parent6
    ring(bow, "Ring", 66, 2.2, 0.1)

    for v107, v108 in {-1, 1} do
        local parent7 = frame(bow, "Side" .. v107, UDim2.fromOffset(9, 2.5))
        local stroke3 = Instance.new("UIStroke")
        stroke3.Name = "Stroke"
        stroke3.Thickness = 1
        stroke3.Color = color
        stroke3.Transparency = 0.3
        stroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke3.Parent = parent7
        parent7.Position = UDim2.new(0.5, v108 * 44, 0.5, 0)
    end

    v17.Bow = bow
    local gun = frame(parent, "Gun", UDim2.fromOffset(0, 0))
    gun.BackgroundTransparency = 1
    local parent8 = frame(gun, "Dot", UDim2.fromOffset(3.5, 3.5))
    local uiCorner4 = Instance.new("UICorner")
    uiCorner4.CornerRadius = UDim.new(1, 0)
    uiCorner4.Parent = parent8

    local stroke4 = Instance.new("UIStroke")
    stroke4.Name = "Stroke"
    stroke4.Thickness = 1.2
    stroke4.Color = color
    stroke4.Transparency = 0.25
    stroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke4.Parent = parent8

    for _, name in {"Up", "Down", "Left", "Right"} do
        local v117 = name == "Up" or name == "Down"
        local v118 = v117 and 2.5 or 10
        v88 = v117 and 10 or 2.5
        local parent9 = frame(gun, name, UDim2.fromOffset(v118, v88))
        local stroke5 = Instance.new("UIStroke")
        stroke5.Name = "Stroke"
        stroke5.Thickness = 1
        stroke5.Color = color
        stroke5.Transparency = 0.3
        stroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke5.Parent = parent9
    end

    v17.Gun = gun
    local spread = frame(parent, "Spread", UDim2.fromOffset(0, 0))
    spread.BackgroundTransparency = 1
    local parent10 = frame(spread, "Dot", UDim2.fromOffset(4, 4))
    local uiCorner5 = Instance.new("UICorner")
    uiCorner5.CornerRadius = UDim.new(1, 0)
    uiCorner5.Parent = parent10

    local stroke6 = Instance.new("UIStroke")
    stroke6.Name = "Stroke"
    stroke6.Thickness = 1.2
    stroke6.Color = color
    stroke6.Transparency = 0.25
    stroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke6.Parent = parent10
    ring(spread, "Ring", 80, 2, 0.15)

    for index = 0, 3 do
        local v126
        local v127 = math.rad(index * 90)
        local name = "Notch" .. index

        if index % 2 == 0 then
            v126 = 2.5
        else
            v126 = 8
        end

        v88 = index % 2 ~= 0 and 2.5 or 8
        local parent11 = frame(spread, name, UDim2.fromOffset(v126, v88))
        local stroke7 = Instance.new("UIStroke")
        stroke7.Name = "Stroke"
        stroke7.Thickness = 1
        stroke7.Color = color
        stroke7.Transparency = 0.3
        stroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke7.Parent = parent11
        parent11.Position = UDim2.new(0.5, math.sin(v127) * 40, 0.5, -math.cos(v127) * 40)
    end

    v17.Spread = spread
    local throw = frame(parent, "Throw", UDim2.fromOffset(0, 0))
    throw.BackgroundTransparency = 1
    local parent12 = frame(throw, "Dot", UDim2.fromOffset(5, 5))
    local uiCorner6 = Instance.new("UICorner")
    uiCorner6.CornerRadius = UDim.new(1, 0)
    uiCorner6.Parent = parent12

    local stroke8 = Instance.new("UIStroke")
    stroke8.Name = "Stroke"
    stroke8.Thickness = 1.2
    stroke8.Color = color
    stroke8.Transparency = 0.25
    stroke8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke8.Parent = parent12
    ring(throw, "Ring", 44, 2, 0.25)
    v17.Throw = throw
    local use = frame(parent, "Use", UDim2.fromOffset(0, 0))
    use.BackgroundTransparency = 1
    local parent13 = frame(use, "Dot", UDim2.fromOffset(5, 5))
    uiCorner6 = Instance.new("UICorner")
    uiCorner6.CornerRadius = UDim.new(1, 0)
    uiCorner6.Parent = parent13
    stroke8 = Instance.new("UIStroke")
    stroke8.Name = "Stroke"
    stroke8.Thickness = 1.2
    stroke8.Color = color
    stroke8.Transparency = 0.25
    stroke8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke8.Parent = parent13
    ring(use, "Ring", 18, 1.4, 0.55)
    v17.Use = use
    local dot = frame(parent, "Dot", UDim2.fromOffset(0, 0))
    dot.BackgroundTransparency = 1
    local parent14 = frame(dot, "Dot", UDim2.fromOffset(4, 4))
    uiCorner6 = Instance.new("UICorner")
    uiCorner6.CornerRadius = UDim.new(1, 0)
    uiCorner6.Parent = parent14
    stroke8 = Instance.new("UIStroke")
    stroke8.Name = "Stroke"
    stroke8.Thickness = 1.2
    stroke8.Color = color
    stroke8.Transparency = 0.25
    stroke8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke8.Parent = parent14
    v17.Dot = dot

    for _, parent15 in v17 do
        parent15.Visible = false
        local punch = Instance.new("UIScale")
        punch.Name = "Punch"
        punch.Parent = parent15
    end

    v17.Dot.Visible = true
    local parent16 = frame(parent, "Arc", UDim2.fromOffset(0, 0))
    parent16.BackgroundTransparency = 1

    for index = 1, 24 do
        local v144 = ((index - 1) / 24) * math.pi * 2
        local parent17 = frame(parent16, "D" .. index, UDim2.fromOffset(4, 4), UDim2.new(0.5, math.sin(v144) * 30, 0.5, -math.cos(v144) * 30), color3)
        local uiCorner7 = Instance.new("UICorner")
        uiCorner7.CornerRadius = UDim.new(1, 0)
        uiCorner7.Parent = parent17
        parent17.Visible = false
        v82[index] = parent17
    end

    parent2 = frame(parent, "Pips", UDim2.fromOffset(120, 10), UDim2.new(0.5, 0, 0.5, 44))
    parent2.BackgroundTransparency = 1
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayout.Padding = UDim.new(0, 6)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = parent2
    parent2.Visible = false
    frame2 = frame(parent, "Guard", UDim2.fromOffset(72, 7), UDim2.new(0.5, 0, 0.5, 44), color)
    frame2.BackgroundTransparency = 0.45
    local parent18 = frame2
    local uiCorner8 = Instance.new("UICorner")
    uiCorner8.CornerRadius = UDim.new(0.5, 0)
    uiCorner8.Parent = parent18
    local parent19 = parent18
    local stroke9 = Instance.new("UIStroke")
    stroke9.Name = "Stroke"
    stroke9.Thickness = 1.5
    stroke9.Color = color
    stroke9.Transparency = 0.25
    stroke9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke9.Parent = parent19
    frame3 = frame(parent18, "Fill", UDim2.fromScale(1, 1), UDim2.fromScale(0, 0.5), backgroundColor3)
    frame3.AnchorPoint = Vector2.new(0, 0.5)
    local parent20 = frame3
    local uiCorner9 = Instance.new("UICorner")
    uiCorner9.CornerRadius = UDim.new(0.5, 0)
    uiCorner9.Parent = parent20
    parent18.Visible = false
end

local instances = {}
local timestamp = 0
local v156 = {Vector2.new(-1, -1), Vector2.new(1, -1), Vector2.new(1, 1), Vector2.new(-1, 1)}

local function buildHitmarker()
    --[[
      name: buildHitmarker
      line: 262
      upvalues:
        frame (copy, index: 1)
        parent (ref,  index: 2)
        color (copy, index: 3)
        instances (copy, index: 4)
    ]]
    local parent2 = frame(parent, "Hitmarker", UDim2.fromOffset(0, 0))
    parent2.BackgroundTransparency = 1
    parent2.ZIndex = 5

    for index = 1, 4 do
        local rotation
        local parent3 = frame(parent2, "L" .. index, UDim2.fromOffset(10, 3))
        parent3.BackgroundTransparency = 1

        if index % 2 == 1 then
            rotation = 45
        else
            rotation = -45
        end

        parent3.Rotation = rotation
        parent3.ZIndex = 5
        local stroke = Instance.new("UIStroke")
        stroke.Name = "Stroke"
        stroke.Thickness = 1.2
        stroke.Color = color
        stroke.Transparency = 1
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = parent3
        stroke.Name = "Stroke"
        instances[index] = parent3
    end
end

local function markerColor(a164)
    --[[
      name: markerColor
      line: 277
      upvalues:
        color32 (copy, index: 1)
        crit (copy, index: 2)
        color3 (copy, index: 3)
    ]]
    if a164 == "kill" then
        return color32
    end
    if a164 == "crit" then
        return crit
    end

    return color3
end

local function punch(scale)
    --[[
      name: punch
      line: 281
      upvalues:
        v17 (copy, index: 1)
        v18 (ref,  index: 2)
        tweenService (copy, index: 3)
    ]]
    local instance = v17[v18]
    instance = instance and instance:FindFirstChild("Punch")

    if instance then
        instance.Scale = scale
        local propertyTable = {Scale = 1}
        tweenService:Create(instance, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
    end
end

function v5.Hitmarker(a169)
    --[[
      name: Hitmarker
      line: 291
      upvalues:
        timestamp (ref,  index: 1)
        color32 (copy, index: 2)
        crit (copy, index: 3)
        color3 (copy, index: 4)
        instances (copy, index: 5)
        v156 (copy, index: 6)
        tweenService (copy, index: 7)
        punch (copy, index: 8)
    ]]
    local backgroundColor3
    timestamp = os.clock()

    if a169 ~= "kill" then
        backgroundColor3 = if a169 == "crit" then crit else color3
    else
        backgroundColor3 = color32
    end

    local v171 = a169 == "kill" or a169 == "crit"
    local v172 = a169 ~= "kill" and (a169 ~= "crit" and 11 or 14) or 18
    local v173 = a169 ~= "kill" and (a169 ~= "crit" and 2.8 or 3.4) or 4
    local v174 = a169 ~= "kill" and 6 or 8
    local v175 = a169 ~= "kill" and (v171 and 15 or 12) or 20
    local backgroundTransparency = a169 ~= "predict" and 0 or 0.25

    for v177, instance in instances do
        local vector2 = v156[v177]
        instance.Size = UDim2.fromOffset(v172 * 1.4, v173)
        instance.BackgroundColor3 = backgroundColor3
        instance.BackgroundTransparency = backgroundTransparency
        instance.Position = UDim2.new(0.5, vector2.X * v174, 0.5, vector2.Y * v174)
        local stroke = instance:FindFirstChild("Stroke")
        stroke.Transparency = backgroundTransparency + 0.25
        local v181 = TweenInfo.new
        local v182 = a169 ~= "kill" and 0.34 or 0.55
        v181 = v181(v182, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local propertyTable = {BackgroundTransparency = 1, Position = UDim2.new(0.5, vector2.X * v175, 0.5, vector2.Y * v175), Size = UDim2.fromOffset(v172, v173)}
        tweenService:Create(instance, v181, propertyTable):Play()
        tweenService:Create(stroke, v181, {Transparency = 1}):Play()
    end

    local scale = a169 == "kill" and 1.6 or v171 and 1.35 or 1.2
    punch(scale)
end

function v5.UpgradeHitmarker(a185)
    --[[
      name: UpgradeHitmarker
      line: 320
      upvalues:
        timestamp (ref,  index: 1)
        v5 (copy, index: 2)
        color32 (copy, index: 3)
        crit (copy, index: 4)
        color3 (copy, index: 5)
        instances (copy, index: 6)
        tweenService (copy, index: 7)
    ]]
    if a185 == "kill" or a185 == "crit" or 0.3 < os.clock() - timestamp then
        v5.Hitmarker(a185)
        return
    end

    local backgroundColor3

    if a185 ~= "kill" then
        backgroundColor3 = if a185 == "crit" then crit else color3
    else
        backgroundColor3 = color32
    end

    local v187 = math.max(0.12, 0.34 - (os.clock() - timestamp))
    local tweenInfo = TweenInfo.new(v187, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    for _, instance in instances do
        instance.BackgroundColor3 = backgroundColor3
        instance.BackgroundTransparency = 0
        local stroke = instance:FindFirstChild("Stroke")
        stroke.Transparency = 0.25
        tweenService:Create(instance, tweenInfo, {BackgroundTransparency = 1}):Play()
        tweenService:Create(stroke, tweenInfo, {Transparency = 1}):Play()
    end
end

local v192 = {}
local v193 = {}
local parent3 = nil
local v195 = {crit = crit, kill = color32, dot = Color3.fromRGB(255, 150, 60), health = color3, blocked = Color3.fromRGB(150, 200, 255), armor = Color3.fromRGB(170, 190, 215)}
local v196 = {crit = 56, kill = 62, dot = 26, health = 42, blocked = 34, armor = 38}

local function popNumber(a198)
    --[[
      name: popNumber
      line: 383
      upvalues:
        scale (ref,  index: 1)
        tweenService (copy, index: 2)
    ]]
    local v199 = a198.big and 1.7 or 1.5
    local scale2 = v199 * scale
    a198.scale.Scale = scale * 0.3
    local propertyTable = {Scale = scale2}
    tweenService:Create(a198.scale, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()

    task.delay(
        0.12,
        function()
            --[[
              line: 387
              upvalues:
                a198 (copy, index: 1)
                tweenService (copy, index: 2)
                scale (ref,  index: 3)
            ]]
            if a198.label.Parent then
                tweenService:Create(a198.scale, TweenInfo.new(0.14, Enum.EasingStyle.Quad), {Scale = scale}):Play()
            end
        end
    )
end

local function tagLabel(parent, text: string, textColor3)
    --[[
      name: tagLabel
      line: 394
      upvalues:
        fontFace (copy, index: 1)
        color (copy, index: 2)
    ]]
    local tag = Instance.new("TextLabel")
    tag.Name = "Tag"
    tag.BackgroundTransparency = 1
    tag.AnchorPoint = Vector2.new(0.5, 0)
    tag.Position = UDim2.new(0.5, 0, 1, -10)
    tag.Size = UDim2.fromOffset(160, 18)
    tag.FontFace = fontFace
    tag.TextSize = 16
    tag.TextColor3 = textColor3
    tag.Text = text
    tag.ZIndex = 3
    tag.Parent = parent

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = color
    uiStroke.Parent = tag

    return tag
end

local function setKind(kind2, kind)
    --[[
      name: setKind
      line: 414
      upvalues:
        v195 (copy, index: 1)
        color3 (copy, index: 2)
        v196 (copy, index: 3)
        color (copy, index: 4)
    ]]
    if kind2.kind == kind or kind2.kind == "kill" then
        return
    end

    kind2.kind = kind
    kind2.big = kind == "crit" or kind == "kill"
    kind2.label.TextColor3 = v195[kind] or color3
    kind2.label.TextSize = v196[kind] or 42
    kind2.stroke.Color = if kind == "kill" then Color3.fromRGB(60, 6, 6) else color

    if kind2.tag then
        kind2.tag.TextColor3 = kind2.label.TextColor3
    end
end

local function display(a212)
    --[[
      name: display
      line: 430
    ]]
    local predN = a212.predN

    if a212.confN < predN then
        return (math.max(a212.confAmount, a212.predAmount))
    end

    return a212.confAmount
end

local function refresh(a215, a216)
    --[[
      name: refresh
      line: 437
      upvalues:
        popNumber (copy, index: 1)
    ]]
    local predN = a215.predN
    local v218 = if a215.confN < predN then math.max(a215.confAmount, a215.predAmount) else a215.confAmount
    local v219 = math.floor(v218 + 0.5) ~= math.floor(a215.amount + 0.5)
    a215.amount = v218
    a215.label.Text = tostring((math.floor(v218 + 0.5)))

    if a216 or v219 then
        popNumber(a215)
    end
end

local function newNumber(world, kind, key, a224: number)
    --[[
      name: newNumber
      line: 447
      upvalues:
        v193 (copy, index: 1)
        fontFace2 (copy, index: 2)
        v196 (copy, index: 3)
        v195 (copy, index: 4)
        color3 (copy, index: 5)
        parent3 (ref,  index: 6)
        color (copy, index: 7)
        v192 (copy, index: 8)
    ]]
    local color2
    local timestamp = os.clock()
    local parent = table.remove(v193)
    if not parent then
        parent = Instance.new("TextLabel")
        parent.Name = "DamageNumber"
        parent.BackgroundTransparency = 1
        parent.AnchorPoint = Vector2.new(0.5, 0.5)
        parent.Size = UDim2.fromOffset(200, 64)
        parent.FontFace = fontFace2
        parent.ZIndex = 3
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Thickness = 3.5
        uiStroke.Parent = parent
        Instance.new("UIScale").Parent = parent
    end

    local label = parent
    label.TextSize = v196[kind] or 42
    local textColor3 = v195[kind] or color3
    label.TextColor3 = textColor3
    label.TextTransparency = 0
    label.Visible = false
    label.Parent = parent3
    local uiStroke = label:FindFirstChildOfClass("UIStroke")

    if kind ~= "kill" then
        color2 = color
    else
        color2 = Color3.fromRGB(60, 6, 6)
    end

    uiStroke.Color = color2
    uiStroke.Transparency = 0
    local v232 = {tag = nil, amount = 0, predAmount = 0, predN = 0, confAmount = 0, confN = 0, predUntil = 0, label = label, stroke = uiStroke, world = world, t0 = timestamp, lastHit = timestamp, offset = Vector2.new((math.random() - 0.5) * 18, a224 * -32), key = key, kind = kind, scale = label:FindFirstChildOfClass("UIScale"), big = (kind == "crit")
        or (kind == "kill")}
    table.insert(v192, v232)

    return v232
end

local function stacked(key, timestamp: number)
    --[[
      name: stacked
      line: 498
      upvalues:
        v192 (copy, index: 1)
    ]]
    local count = 0

    if key ~= nil then
        for _, v238 in v192 do
            if v238.key == key then
                if not (timestamp - v238.t0 < 0.5) then
                    continue
                end

                count += 1
            end
        end
    end

    return count
end

function v5.PredictNumber(world, predAmount, a241, key)
    --[[
      name: PredictNumber
      line: 513
      upvalues:
        parent3 (ref,  index: 1)
        v192 (copy, index: 2)
        setKind (copy, index: 3)
        popNumber (copy, index: 4)
        newNumber (copy, index: 5)
        stacked (copy, index: 6)
    ]]
    if predAmount < 0.5 or not parent3 or key == nil then
        return
    end

    local timestamp = os.clock()

    for _, kind in v192 do
        if kind.key == key and timestamp - kind.lastHit < 0.45 and kind.kind ~= "dot" then
            kind.predAmount += predAmount
            kind.predN += 1
            kind.lastHit = timestamp
            kind.predUntil = timestamp + 0.7
            kind.t0 = math.max(kind.t0, timestamp - 0.25)

            if a241 then
                setKind(kind, "crit")
            end

            local predN = kind.predN
            local v247 = if kind.confN < predN then math.max(kind.confAmount, kind.predAmount) else kind.confAmount
            local _ = math.floor(v247 + 0.5) ~= math.floor(kind.amount + 0.5)
            kind.amount = v247
            kind.label.Text = tostring((math.floor(v247 + 0.5)))
            popNumber(kind)

            return
        end
    end

    local kind = a241 and "crit" or "health"
    local v250 = newNumber(world, kind, key, (stacked(key, timestamp)))
    v250.predAmount = predAmount
    v250.predN = 1
    v250.predUntil = timestamp + 0.7
    local predN = v250.predN
    local v252 = if v250.confN < predN then math.max(v250.confAmount, v250.predAmount) else v250.confAmount
    local _ = math.floor(v252 + 0.5) ~= math.floor(v250.amount + 0.5)
    v250.amount = v252
    v250.label.Text = tostring((math.floor(v252 + 0.5)))
    popNumber(v250)
end

function v5.DamageNumber(world, confAmount, kind2, key, text: string)
    --[[
      name: DamageNumber
      line: 540
      upvalues:
        parent3 (ref,  index: 1)
        v192 (copy, index: 2)
        setKind (copy, index: 3)
        tagLabel (copy, index: 4)
        popNumber (copy, index: 5)
        newNumber (copy, index: 6)
        stacked (copy, index: 7)
    ]]
    if confAmount < 0.5 or not parent3 then
        return
    end

    local timestamp = os.clock()

    if key ~= nil then
        for _, kind3 in v192 do
            if kind3.key == key then
                local predN = kind3.predN

                if not (kind3.confN < predN) or not (timestamp < kind3.predUntil + 0.2) or kind2 == "dot" then
                    continue
                end

                kind3.confN += 1
                kind3.confAmount += confAmount
                kind3.lastHit = timestamp
                kind3.predUntil = math.max(kind3.predUntil, timestamp + 0.15)
                local kind = kind3.kind

                if kind2 ~= "health" then
                    setKind(kind3, kind2)
                end

                local v264 = false
                local v265

                if text and not kind3.tag then
                    kind3.tag = tagLabel(kind3.label, text, kind3.label.TextColor3)
                end

                local v266 = kind3.kind ~= kind
                local predN2 = kind3.predN

                if not (kind3.confN < predN2) then
                    v265 = kind3.confAmount
                else
                    v265 = math.max(kind3.confAmount, kind3.predAmount)
                end

                local v268 = math.floor(v265 + 0.5) ~= math.floor(kind3.amount + 0.5)
                kind3.amount = v265
                kind3.label.Text = tostring((math.floor(v265 + 0.5)))

                if v266 then
                    v264 = true
                elseif v268 then
                    v264 = true
                end

                if v264 then
                    popNumber(kind3)
                end

                return
            end
        end

        for _, kind in v192 do
            if kind.key == key then
                if not (kind.predN <= kind.confN) then
                    continue
                end
                if kind.kind ~= kind2 and (kind2 ~= "kill" or kind.kind ~= "health" and kind.kind ~= "crit")
                    or not (timestamp - kind.lastHit < 0.45)
                then
                    continue
                end

                kind.confN += 1
                kind.confAmount += confAmount
                kind.lastHit = timestamp
                kind.t0 = math.max(kind.t0, timestamp - 0.25)

                if kind2 == "kill" then
                    setKind(kind, "kill")
                end

                if text and not kind.tag then
                    kind.tag = tagLabel(kind.label, text, kind.label.TextColor3)
                end

                local predN = kind.predN
                local v272 = if kind.confN < predN then math.max(kind.confAmount, kind.predAmount) else kind.confAmount
                local _ = math.floor(v272 + 0.5) ~= math.floor(kind.amount + 0.5)
                kind.amount = v272
                kind.label.Text = tostring((math.floor(v272 + 0.5)))
                popNumber(kind)

                return
            end
        end
    end

    local v274 = newNumber(world, kind2, key, (stacked(key, timestamp)))
    v274.confAmount = confAmount
    v274.confN = 1

    if text then
        v274.tag = tagLabel(v274.label, text, v274.label.TextColor3)
    end

    local predN = v274.predN
    local v276 = if v274.confN < predN then math.max(v274.confAmount, v274.predAmount) else v274.confAmount
    local _ = math.floor(v276 + 0.5) ~= math.floor(v274.amount + 0.5)
    v274.amount = v276
    v274.label.Text = tostring((math.floor(v276 + 0.5)))
    popNumber(v274)
end

local function updateNumbers()
    --[[
      name: updateNumbers
      line: 594
      upvalues:
        v192 (copy, index: 1)
        popNumber (copy, index: 2)
        v193 (copy, index: 3)
        scale (ref,  index: 4)
    ]]
    if #v192 == 0 then
        return
    end

    local camera = workspace.CurrentCamera
    local timestamp = os.clock()
    local readIndex = 1

    while readIndex <= #v192 do
        local v282 = v192[readIndex]
        local predN = v282.predN

        if v282.confN < predN and v282.predUntil < timestamp then
            v282.predN = v282.confN
            v282.predAmount = v282.confAmount

            if v282.confN == 0 then
                v282.t0 = math.min(v282.t0, timestamp - 0.9999999999999999)
            else
                local predN2 = v282.predN
                local v285 = if v282.confN < predN2 then math.max(v282.confAmount, v282.predAmount) else v282.confAmount
                local v286 = math.floor(v285 + 0.5) ~= math.floor(v282.amount + 0.5)
                v282.amount = v285
                v282.label.Text = tostring((math.floor(v285 + 0.5)))

                if v286 then
                    popNumber(v282)
                end
            end
        end

        local v287 = timestamp - v282.t0

        if not (1.15 <= v287) then
            local v288 = v287 / 1.15
            local y = 3.5 * (1 - ((1 - v288) * (1 - v288)))
            local v290, v291 = camera:WorldToViewportPoint(v282.world + Vector3.new(0, y, 0))
            v282.label.Visible = v291 and (0 < v290.Z)
            v282.label.Position = UDim2.fromOffset(v290.X + (v282.offset.X * scale), v290.Y + (v282.offset.Y * scale))
            local clampedValue = math.clamp((v287 - 0.7499999999999999) / 0.4, 0, 1)
            v282.label.TextTransparency = clampedValue
            v282.stroke.Transparency = clampedValue

            if v282.tag then
                v282.tag.TextTransparency = clampedValue
            end

            readIndex += 1
        else
            if v282.tag then
                v282.tag:Destroy()
            end

            if not (#v193 < 24) then
                v282.label:Destroy()
            else
                v282.label.Visible = false
                v282.label.Parent = nil
                table.insert(v193, v282.label)
            end

            table.remove(v192, readIndex)
        end
    end
end

local v293 = {}
local frame4 = nil
local instances2 = {}

local function buildVignette()
    --[[
      name: buildVignette
      line: 650
      upvalues:
        color32 (copy, index: 1)
        combatHud (ref,  index: 2)
        instances2 (copy, index: 3)
    ]]
    local v297 = {"Top", UDim2.new(1, 0, 0.24, 0), UDim2.fromScale(0.5, 0), Vector2.new(0.5, 0), 90}
    local v298 = {"Bottom", UDim2.new(1, 0, 0.24, 0), UDim2.fromScale(0.5, 1), Vector2.new(0.5, 1), -90}
    local v299 = {"Left", UDim2.new(0.2, 0, 1, 0), UDim2.fromScale(0, 0.5), Vector2.new(0, 0.5), 0}

    for _, v301 in {v297, v298, v299, {"Right", UDim2.new(0.2, 0, 1, 0), UDim2.fromScale(1, 0.5), Vector2.new(1, 0.5), 180}} do
        local parent = Instance.new("Frame")
        parent.Name = "Vignette" .. v301[1]
        parent.Size = v301[2]
        parent.Position = v301[3]
        parent.AnchorPoint = v301[4]
        parent.BorderSizePixel = 0
        parent.BackgroundColor3 = color32
        parent.BackgroundTransparency = 1
        parent.Parent = combatHud

        local uiGradient = Instance.new("UIGradient")
        uiGradient.Rotation = v301[5]
        uiGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        uiGradient.Parent = parent
        table.insert(instances2, parent)
    end
end

function v5.Hurt(a304: number, a305)
    --[[
      name: Hurt
      line: 678
      upvalues:
        instances2 (copy, index: 1)
        tweenService (copy, index: 2)
    ]]
    local clampedValue = math.clamp(a304, 0.15, 1)

    for _, instance in instances2 do
        local backgroundColor3 = a305 or Color3.fromRGB(200, 20, 20)
        instance.BackgroundColor3 = backgroundColor3
        instance.BackgroundTransparency = 1 - (clampedValue * 0.6)
        local propertyTable = {BackgroundTransparency = 1}
        tweenService:Create(instance, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    end
end

function v5.Flash(backgroundColor3: Color3, a312: number, a313)
    --[[
      name: Flash
      line: 688
      upvalues:
        instances2 (copy, index: 1)
        tweenService (copy, index: 2)
    ]]
    for _, instance in instances2 do
        instance.BackgroundColor3 = backgroundColor3
        instance.BackgroundTransparency = 1 - (math.clamp(a312, 0, 1) * 0.6)
        local propertyTable = {BackgroundTransparency = 1}
        tweenService:Create(instance, TweenInfo.new((a313 or 0.14), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    end
end

function v5.DamageFrom(source, a318, a319, life)
    --[[
      name: DamageFrom
      line: 700
      upvalues:
        frame (copy, index: 1)
        parent (ref,  index: 2)
        color32 (copy, index: 3)
        color (copy, index: 4)
        v293 (copy, index: 5)
    ]]
    local frame2 = frame(parent, "DamageDir", UDim2.fromOffset(0, 0))
    frame2.BackgroundTransparency = 1
    local v322 = {}
    local v323 = a318 and 22 or 18
    local v324 = a318 and 7 or 5

    for offset = -1, 1 do
        local name = "S" .. offset
        local udim2 = UDim2.fromOffset(v323, v324)
        local v328 = a319 or color32
        local parent2 = frame(frame2, name, udim2, nil, v328)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(1, 0)
        uiCorner.Parent = parent2
        local color3 = if a319 then Color3.fromRGB(60, 40, 10) else Color3.fromRGB(80, 0, 8)
        local stroke = Instance.new("UIStroke")
        stroke.Name = "Stroke"
        stroke.Thickness = 1.2
        local color2 = color3 or color
        stroke.Color = color2
        stroke.Transparency = 0.35
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = parent2
        parent2:SetAttribute("Offset", offset)
        table.insert(v322, parent2)
    end

    table.insert(v293, {frame = frame2, source = source, t0 = os.clock(), life = life})

    if 6 < #v293 then
        local removedValue = table.remove(v293, 1)
        removedValue.frame:Destroy()
    end
end

local function updateIndicators()
    --[[
      name: updateIndicators
      line: 720
      upvalues:
        v293 (copy, index: 1)
    ]]
    if #v293 == 0 then
        return
    end

    local camera = workspace.CurrentCamera
    local timestamp = os.clock()
    local cFrame = camera.CFrame
    local vector3 = Vector3.new(cFrame.LookVector.X, 0, cFrame.LookVector.Z)
    local vector32 = Vector3.new(cFrame.RightVector.X, 0, cFrame.RightVector.Z)
    local readIndex = 1

    while readIndex <= #v293 do
        local v342 = v293[readIndex]
        local v343 = timestamp - v342.t0
        local life = v342.life or 0.6

        if life < v343 then
            v342.frame:Destroy()
            table.remove(v293, readIndex)
        else
            local v345 = v342.source - cFrame.Position
            local vector33 = Vector3.new(v345.X, 0, v345.Z)
            local v347 = 0

            if 0.1 < vector33.Magnitude and 0.01 < vector3.Magnitude then
                v347 = math.atan2(vector33.Unit:Dot(vector32.Unit), (vector33.Unit:Dot(vector3.Unit)))
            end

            local backgroundTransparency = math.clamp((v343 - (life - 0.45)) / 0.45, 0, 1)

            for _, child in v342.frame:GetChildren() do
                if child:IsA("Frame") then
                    local v351 = v347 + 0.1308996938995747 * (child:GetAttribute("Offset") or 0)
                    child.Position = UDim2.new(0.5, math.sin(v351) * 140, 0.5, -math.cos(v351) * 140)
                    child.Rotation = math.deg(v351)
                    child.BackgroundTransparency = backgroundTransparency
                    local stroke = child:FindFirstChild("Stroke")
                    if not stroke then
                        continue
                    end

                    stroke.Transparency = (backgroundTransparency * 0.65) + 0.35
                end
            end

            readIndex += 1
        end
    end
end

local frame5 = nil
local frame6 = nil
local textLabel = nil
local timestamp2 = 0
local v357 = 0
local parent4 = nil
local textLabel2 = nil
local textLabel3 = nil
local textLabel4 = nil

local function buildBars()
    --[[
      name: buildBars
      line: 773
      upvalues:
        frame5 (ref,  index: 1)
        frame (copy, index: 2)
        parent (ref,  index: 3)
        color (copy, index: 4)
        frame6 (ref,  index: 5)
        textLabel (ref,  index: 6)
        label (copy, index: 7)
        parent4 (ref,  index: 8)
        crit (copy, index: 9)
        textLabel2 (ref,  index: 10)
        textLabel3 (ref,  index: 11)
        color32 (copy, index: 12)
        fontFace2 (copy, index: 13)
        textLabel4 (ref,  index: 14)
    ]]
    frame5 = frame(parent, "Channel", UDim2.fromOffset(170, 10), UDim2.new(0.5, 0, 0.5, 76), color)
    frame5.BackgroundTransparency = 0.25
    local parent2 = frame5
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.5, 0)
    uiCorner.Parent = parent2
    local parent3 = parent2
    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = 2
    stroke.Color = color
    stroke.Transparency = 0.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent3
    frame6 = frame(parent2, "Fill", UDim2.fromScale(0, 1), UDim2.fromScale(0, 0.5), Color3.fromRGB(120, 220, 110))
    frame6.AnchorPoint = Vector2.new(0, 0.5)
    local parent5 = frame6
    local uiCorner2 = Instance.new("UICorner")
    uiCorner2.CornerRadius = UDim.new(0.5, 0)
    uiCorner2.Parent = parent5
    textLabel = label(parent2, "Text", "", 18, UDim2.new(0.5, 0, 0, -16))
    parent2.Visible = false
    parent4 = label(parent, "Toast", "", 22, UDim2.new(0.5, 0, 0.5, -124), crit)
    textLabel2 = label(parent, "Ammo", "", 18, UDim2.new(0.5, 0, 0.5, 60))
    textLabel2.Visible = false
    parent4.TextTransparency = 1

    if const uiStroke = parent4:FindFirstChildOfClass("UIStroke") then
        uiStroke.Transparency = 1
    end

    textLabel3 = label(parent, "Kill", "", 28, UDim2.new(0.5, 0, 0.5, 100), color32)
    textLabel3.FontFace = fontFace2
    textLabel3.TextTransparency = 1
    textLabel4 = label(parent, "KillSub", "", 17, UDim2.new(0.5, 0, 0.5, 122), crit)
    textLabel4.AutoLocalize = false
    textLabel4.TextTransparency = 1

    for _, textLabel5 in {textLabel3, textLabel4} do
        if const uiStroke2 = textLabel5:FindFirstChildOfClass("UIStroke") then
            uiStroke2.Transparency = 1
        end
    end
end

function v5.StartChannel(text: string, a374, a375)
    --[[
      name: StartChannel
      line: 808
      upvalues:
        timestamp2 (ref, index: 1)
        v357 (ref, index: 2)
        textLabel (ref, index: 3)
        frame6 (ref, index: 4)
        frame5 (ref, index: 5)
    ]]
    timestamp2 = os.clock()
    v357 = timestamp2 + a374
    textLabel.Text = text
    local frame = frame6
    local backgroundColor3 = a375 or Color3.fromRGB(120, 220, 110)
    frame.BackgroundColor3 = backgroundColor3
    frame6.Size = UDim2.fromScale(0, 1)
    frame5.Visible = true
end

function v5.StopChannel()
    --[[
      name: StopChannel
      line: 817
      upvalues:
        frame5 (ref, index: 1)
        v357 (ref, index: 2)
    ]]
    frame5.Visible = false
    v357 = 0
end

function v5.Toast(text: string, a379, a380)
    --[[
      name: Toast
      line: 822
      upvalues:
        parent4 (ref,  index: 1)
        crit (copy, index: 2)
        tweenService (copy, index: 3)
    ]]
    parent4.Text = text
    parent4.TextColor3 = a379 or crit
    parent4.TextTransparency = 0
    local uiStroke = parent4:FindFirstChildOfClass("UIStroke")
    if uiStroke then
        uiStroke.Transparency = 0.2
    end

    local uiScale = parent4:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    uiScale.Parent = parent4
    uiScale.Scale = 1.25
    local propertyTable = {Scale = 1}
    tweenService:Create(uiScale, TweenInfo.new(0.15, Enum.EasingStyle.Back), propertyTable):Play()
    local v384 = os.clock()
    parent4:SetAttribute("T", v384)

    task.delay(
        (a380 or 1.1),
        function()
            --[[
              line: 836
              upvalues:
                parent4 (ref,  index: 1)
                v384 (copy, index: 2)
                tweenService (copy, index: 3)
                uiStroke (copy, index: 4)
            ]]
            if parent4:GetAttribute("T") ~= v384 then
                return
            end

            local propertyTable = {TextTransparency = 1}
            tweenService:Create(parent4, TweenInfo.new(0.3), propertyTable):Play()

            if uiStroke then
                local propertyTable2 = {Transparency = 1}
                tweenService:Create(uiStroke, TweenInfo.new(0.3), propertyTable2):Play()
            end
        end
    )
end

function v5.KillBanner(text: string, a388)
    --[[
      name: KillBanner
      line: 849
      upvalues:
        textLabel3 (ref,  index: 1)
        textLabel4 (ref,  index: 2)
        tweenService (copy, index: 3)
    ]]
    textLabel3.Text = text
    textLabel4.Text = a388 or ""
    local v389 = os.clock()

    for _, parent in {textLabel3, textLabel4} do
        parent.TextTransparency = parent == textLabel4 and not a388 and 1 or 0

        if const uiStroke = parent:FindFirstChildOfClass("UIStroke") then
            uiStroke.Transparency = parent == textLabel4 and not a388 and 1 or 0.1
        end

        local uiScale = parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        uiScale.Parent = parent
        uiScale.Scale = 1.7
        local propertyTable = {Scale = 1}
        tweenService:Create(uiScale, TweenInfo.new(0.26, Enum.EasingStyle.Back), propertyTable):Play()
        parent:SetAttribute("T", v389)
    end

    task.delay(
        1.7,
        function()
            --[[
              line: 865
              upvalues:
                textLabel3 (ref,  index: 1)
                textLabel4 (ref,  index: 2)
                v389 (copy, index: 3)
                tweenService (copy, index: 4)
            ]]
            for _, instance in {textLabel3, textLabel4} do
                if instance:GetAttribute("T") == v389 then
                    local propertyTable = {TextTransparency = 1}
                    tweenService:Create(instance, TweenInfo.new(0.4), propertyTable):Play()
                    local uiStroke = instance:FindFirstChildOfClass("UIStroke")
                    if not uiStroke then
                        continue
                    end

                    local propertyTable2 = {Transparency = 1}
                    tweenService:Create(uiStroke, TweenInfo.new(0.4), propertyTable2):Play()
                end
            end
        end
    )
end

function v5.SetStyle(style)
    --[[
      name: SetStyle
      line: 880
      upvalues:
        v17 (copy, index: 1)
        v18 (ref,  index: 2)
        clampedValue (ref,  index: 3)
        v21 (ref,  index: 4)
        v23 (ref,  index: 5)
        v22 (ref,  index: 6)
    ]]
    if not v17[style] then
        style = "Dot"
    end

    v18 = style

    for v401, frame in v17 do
        frame.Visible = v401 == style
    end

    clampedValue = 0
    v21 = 0
    v23 = false
    v22 = 0
end

function v5.GetStyle()
    --[[
      name: GetStyle
      line: 894
      upvalues:
        v18 (ref, index: 1)
    ]]
    return v18
end

function v5.SetCharge(charge: number)
    --[[
      name: SetCharge
      line: 898
      upvalues:
        clampedValue (ref, index: 1)
    ]]
    clampedValue = math.clamp(charge, 0, 1)
end

function v5.Kick(a404)
    --[[
      name: Kick
      line: 902
      upvalues:
        v21 (ref, index: 1)
    ]]
    v21 = math.min(v21 + a404, 30)
end

function v5.SetSpread(spread: number)
    --[[
      name: SetSpread
      line: 907
      upvalues:
        v22 (ref, index: 1)
    ]]
    v22 = math.max(0, spread)
end

function v5.SetPips(a406, a407, a408)
    --[[
      name: SetPips
      line: 912
      upvalues:
        parent2 (ref,  index: 1)
        v84 (copy, index: 2)
        color (copy, index: 3)
        color3 (copy, index: 4)
    ]]
    local endIndex = a407 or 0
    local frame = parent2
    frame.Visible = 0 < endIndex

    for layoutOrder = #v84 + 1, endIndex do
        local parent = Instance.new("Frame")
        parent.Name = "P" .. layoutOrder
        parent.LayoutOrder = layoutOrder
        parent.Size = UDim2.fromOffset(8, 8)
        parent.BorderSizePixel = 0
        parent.Rotation = 45
        parent.Parent = parent2

        local stroke = Instance.new("UIStroke")
        stroke.Name = "Stroke"
        stroke.Thickness = 1.2
        stroke.Color = color
        stroke.Transparency = 0.2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = parent
        v84[layoutOrder] = parent
    end

    for v414, frame2 in v84 do
        local backgroundColor3
        frame2.Visible = v414 <= endIndex
        local v417 = v414 <= a406

        if v417 then
            backgroundColor3 = a408 or color3
        else
            backgroundColor3 = color
        end

        frame2.BackgroundColor3 = backgroundColor3
        frame2.BackgroundTransparency = v417 and 0 or 0.55
    end
end

local v418 = {ARROWS = "ARROW", BULLETS = "BULLET"}

function v5.SetAmmoCount(a419: number, a420)
    --[[
      name: SetAmmoCount
      line: 937
      upvalues:
        textLabel2 (ref,  index: 1)
        v418 (copy, index: 2)
        color32 (copy, index: 3)
        crit (copy, index: 4)
        color3 (copy, index: 5)
    ]]
    local textColor3

    if not textLabel2 then
        return
    end

    if a419 == nil then
        textLabel2.Visible = false
        return
    end

    textLabel2.Visible = true
    local v422 = math.max(0, (math.floor(a419)))
    local v423 = a420 or ""

    if v422 == 1 then
        v423 = v418[v423] or v423
    end

    textLabel2.Text = `{v422} {v423}`
    local textLabel = textLabel2

    if not (a419 <= 0) then
        textColor3 = if a419 <= 3 then crit else color3
    else
        textColor3 = color32
    end

    textLabel.TextColor3 = textColor3
end

function v5.SetArc(a425, a426, a427)
    --[[
      name: SetArc
      line: 956
      upvalues:
        v25 (ref,  index: 1)
        v26 (ref,  index: 2)
        v27 (ref,  index: 3)
        color3 (copy, index: 4)
        v82 (copy, index: 5)
    ]]
    if a425 and 0 < a425 then
        v25 = os.clock() - (a427 or 0)
        v26 = v25 + a425
        v27 = a426 or color3

        return
    end

    v26 = 0

    for _, frame in v82 do
        frame.Visible = false
    end
end

function v5.SetBlocking(blocking)
    --[[
      name: SetBlocking
      line: 969
      upvalues:
        v23 (ref,  index: 1)
        v17 (copy, index: 2)
        tweenService (copy, index: 3)
    ]]
    v23 = blocking
    local shield = v17.Melee and v17.Melee:FindFirstChild("Shield")
    local pulse = shield and shield:FindFirstChild("Pulse")

    if pulse and blocking then
        pulse.Scale = 0.6
        local propertyTable = {Scale = 1}
        tweenService:Create(pulse, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
    end
end

function v5.SetGuard(a434: number, a435)
    --[[
      name: SetGuard
      line: 980
      upvalues:
        frame2 (ref,  index: 1)
        frame3 (ref,  index: 2)
        color32 (copy, index: 3)
        crit (copy, index: 4)
        backgroundColor3 (copy, index: 5)
    ]]
    local backgroundColor32

    if not frame2 then
        return
    end

    local frame = frame2
    frame.Visible = a434 ~= nil

    if a434 == nil then
        return
    end

    frame3.Size = UDim2.fromScale(math.clamp(a434, 0, 1), 1)
    local frame4 = frame3

    if a435 then
        backgroundColor32 = color32
    else
        backgroundColor32 = if a434 <= 0.3 then crit else backgroundColor3
    end

    frame4.BackgroundColor3 = backgroundColor32
    frame3.BackgroundTransparency = a435 and 0.35 or 0
end

function v5.BlockPulse()
    --[[
      name: BlockPulse
      line: 994
      upvalues:
        v17 (copy, index: 1)
        tweenService (copy, index: 2)
        color3 (copy, index: 3)
        backgroundColor3 (copy, index: 4)
    ]]
    local shield = v17.Melee and v17.Melee:FindFirstChild("Shield")
    if not shield then
        return
    elseif const pulse = shield:FindFirstChild("Pulse") then
        pulse.Scale = 1.45
        local propertyTable = {Scale = 1}
        tweenService:Create(pulse, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    end

    for _, child in shield:GetChildren() do
        if child:IsA("Frame") then
            child.BackgroundColor3 = color3
            child.BackgroundTransparency = 0
            local propertyTable = {BackgroundTransparency = 0.3, BackgroundColor3 = backgroundColor3}
            tweenService:Create(child, TweenInfo.new(0.25), propertyTable):Play()
        end
    end
end

function v5.SetFrozen(frozen)
    --[[
      name: SetFrozen
      line: 1014
      upvalues:
        v24 (ref,  index: 1)
        parent (ref,  index: 2)
        color33 (copy, index: 3)
        color3 (copy, index: 4)
    ]]
    if v24 == frozen then
        return
    end

    v24 = frozen

    for _, descendant in parent:GetDescendants() do
        if descendant:IsA("Frame") then
            if descendant.Name ~= "Dot" then
                continue
            end

            descendant.BackgroundColor3 = if v24 then color33 else color3
        end
    end
end

local function spreadPx(a449: number)
    --[[
      name: spreadPx
      line: 1026
      upvalues:
        scale (ref, index: 1)
    ]]
    local camera = workspace.CurrentCamera
    local fieldOfView = camera.FieldOfView
    local v452 = camera.ViewportSize.Y / 2

    return (math.tan((math.rad(a449))) / math.tan((math.rad(fieldOfView / 2)))) * v452 / scale
end

local function strokeOf(a454)
    --[[
      name: strokeOf
      line: 1033
    ]]
    return (a454:FindFirstChild("Stroke"))
end

local function update(deltaTime: number)
    --[[
      name: update
      line: 1037
      upvalues:
        v21 (ref,  index: 1)
        v17 (copy, index: 2)
        v18 (ref,  index: 3)
        clampedValue (ref,  index: 4)
        crit (copy, index: 5)
        color3 (copy, index: 6)
        v22 (ref,  index: 7)
        scale (ref,  index: 8)
        v23 (ref,  index: 9)
        v26 (ref,  index: 10)
        v25 (ref,  index: 11)
        v82 (copy, index: 12)
        v27 (ref,  index: 13)
        color (copy, index: 14)
        v5 (copy, index: 15)
        v357 (ref,  index: 16)
        timestamp2 (ref,  index: 17)
        frame6 (ref,  index: 18)
        updateIndicators (copy, index: 19)
        updateNumbers (copy, index: 20)
    ]]
    local timestamp = os.clock()
    v21 = math.max(0, v21 - (deltaTime * 80))
    local frame = v17[v18]

    if v18 == "Bow" or v18 == "Throw" then
        local color2
        local ring = frame:FindFirstChild("Ring")
        local v461 = v18 ~= "Bow" and 44 or 66
        local v462 = v461 - (v461 - 12) * (clampedValue ^ 0.8)
        ring.Size = UDim2.fromOffset(v462, v462)
        local stroke = ring:FindFirstChild("Stroke")

        if not (0.999 <= clampedValue) then
            color2 = color3
        else
            color2 = crit
        end

        stroke.Color = color2
        stroke.Thickness = not (0.999 <= clampedValue) and 2.2 or math.sin(timestamp * 20) * 0.6 + 2.8
        stroke.Transparency = not (0 < clampedValue) and 0.35 or 0

        if v18 == "Bow" then
            for v464, v465 in {-1, 1} do
                local child = frame:FindFirstChild("Side" .. v464)
                child.Position = UDim2.new(0.5, v465 * ((v462 / 2) + 8), 0.5, 0)
                child.BackgroundColor3 = stroke.Color
            end
        end
    elseif v18 == "Gun" then
        local v467 = v22
        local camera = workspace.CurrentCamera
        local fieldOfView = camera.FieldOfView
        local v470 = camera.ViewportSize.Y / 2
        local v471 = ((math.tan((math.rad(v467))) / math.tan((math.rad(fieldOfView / 2)))) * v470 / scale) + 5 + v21
        local up = frame:FindFirstChild("Up")
        local down = frame:FindFirstChild("Down")
        local left = frame:FindFirstChild("Left")
        local right = frame:FindFirstChild("Right")
        up.Position = UDim2.new(0.5, 0, 0.5, -v471 - 5)
        down.Position = UDim2.new(0.5, 0, 0.5, v471 + 5)
        left.Position = UDim2.new(0.5, -v471 - 5, 0.5, 0)
        right.Position = UDim2.new(0.5, v471 + 5, 0.5, 0)
    elseif v18 == "Spread" then
        local ring = frame:FindFirstChild("Ring")
        local v477 = v22
        local camera = workspace.CurrentCamera
        local fieldOfView = camera.FieldOfView
        local v480 = camera.ViewportSize.Y / 2
        local v481 = math.max(10, ((math.tan((math.rad(v477))) / math.tan((math.rad(fieldOfView / 2)))) * v480) / scale) + v21 * 0.6
        ring.Size = UDim2.fromOffset(v481 * 2, v481 * 2)

        for index = 0, 3 do
            local v483 = math.rad(index * 90)
            frame:FindFirstChild("Notch" .. index).Position = UDim2.new(0.5, math.sin(v483) * v481, 0.5, -math.cos(v483) * v481)
        end
    elseif v18 == "Melee" then
        local ring = frame:FindFirstChild("Ring")
        local stroke = ring:FindFirstChild("Stroke")

        if not (0 < clampedValue) then
            stroke.Color = color3
            stroke.Transparency = 0.45
            stroke.Thickness = 1.6
            ring.Size = UDim2.fromOffset(24, 24)
        else
            local v486 = 46 - clampedValue * 26
            ring.Size = UDim2.fromOffset(v486, v486)
            stroke.Color = if 0.999 <= clampedValue then crit else color3
            stroke.Transparency = 0
            stroke.Thickness = not (0.999 <= clampedValue) and 2.2 or math.sin(timestamp * 20) * 0.6 + 2.8
        end

        local shield = frame:FindFirstChild("Shield")
        shield.Visible = v23 and clampedValue <= 0
        ring.Visible = not shield.Visible
    end

    if 0 < v26 then
        local clampedValue2 = math.clamp((timestamp - v25) / math.max(0.01, v26 - v25), 0, 1)
        local flooredValue = math.floor((clampedValue2 * 24) + 0.5)

        for v490, frame2 in v82 do
            frame2.Visible = true
            frame2.BackgroundColor3 = if v490 <= flooredValue then v27 else color
            frame2.BackgroundTransparency = not (v490 <= flooredValue) and 0.6 or 0.05
        end

        if 1 <= clampedValue2 then
            v5.SetArc(nil)
        end
    end

    if 0 < v357 then
        local clampedValue3 = math.clamp((timestamp - timestamp2) / math.max(0.01, v357 - timestamp2), 0, 1)
        frame6.Size = UDim2.fromScale(clampedValue3, 1)
    end

    updateIndicators()
    updateNumbers()
end

function v5.Init()
    --[[
      name: Init
      line: 1115
      upvalues:
        localPlayer (copy, index: 1)
        combatHud (ref,  index: 2)
        parent (ref,  index: 3)
        frame (copy, index: 4)
        scale (ref,  index: 5)
        frame4 (ref,  index: 6)
        parent3 (ref,  index: 7)
        buildVignette (copy, index: 8)
        buildStyles (copy, index: 9)
        buildHitmarker (copy, index: 10)
        buildBars (copy, index: 11)
        runService (copy, index: 12)
        update (copy, index: 13)
    ]]
    local playerGui = localPlayer:WaitForChild("PlayerGui")

    if const combatHud2 = playerGui:FindFirstChild("CombatHUD") then
        combatHud2:Destroy()
    end

    combatHud = Instance.new("ScreenGui")
    combatHud.Name = "CombatHUD"
    combatHud.IgnoreGuiInset = true
    combatHud.ScreenInsets = Enum.ScreenInsets.None
    combatHud.ResetOnSpawn = false
    combatHud.DisplayOrder = 4
    combatHud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    combatHud.Parent = playerGui
    parent = frame(combatHud, "Center", UDim2.fromOffset(0, 0), UDim2.fromScale(0.5, 0.5))
    parent.BackgroundTransparency = 1
    local screenScale = Instance.new("UIScale")
    screenScale.Name = "ScreenScale"
    screenScale.Parent = parent

    local function rescale()
        --[[
          name: rescale
          line: 1135
          upvalues:
            scale (ref,  index: 1)
            screenScale (copy, index: 2)
        ]]
        local viewportSize = workspace.CurrentCamera.ViewportSize
        scale = math.clamp(math.min(viewportSize.X / 1600, viewportSize.Y / 900), 0.75, 1.6)
        screenScale.Scale = scale
    end

    local viewportSize = workspace.CurrentCamera.ViewportSize
    scale = math.clamp(math.min(viewportSize.X / 1600, viewportSize.Y / 900), 0.75, 1.6)
    screenScale.Scale = scale
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale)
    frame4 = frame(combatHud, "Directions", UDim2.fromScale(1, 1), UDim2.fromScale(0.5, 0.5))
    frame4.BackgroundTransparency = 1
    parent3 = frame(combatHud, "Numbers", UDim2.fromScale(1, 1), UDim2.fromScale(0.5, 0.5))
    parent3.BackgroundTransparency = 1
    parent3.ZIndex = 2
    buildVignette()
    buildStyles()
    buildHitmarker()
    buildBars()
    runService.RenderStepped:Connect(update)
end

function v5.ScreenScale()
    --[[
      name: ScreenScale
      line: 1157
      upvalues:
        scale (ref, index: 1)
    ]]
    return scale
end

function v5.SetVisible(visible: boolean)
    --[[
      name: SetVisible
      line: 1161
      upvalues:
        combatHud (ref, index: 1)
    ]]
    if combatHud then
        combatHud.Enabled = visible
    end
end

return v5