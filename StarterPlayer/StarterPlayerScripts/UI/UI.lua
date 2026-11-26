local v1
local touch
local v3
local gamepad
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local Theme = require(script.Parent.Theme)
local Sounds = require(script.Parent.Sounds)
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds = require(replicatedStorage.Shared:WaitForChild("Keybinds"))
local Loc = require(replicatedStorage.Shared:WaitForChild("Loc"))
local v16 = {Icons = {}, WeaponArt = {}}

if const uiAssets = replicatedStorage.Shared:FindFirstChild("UIAssets") then
    local success, result = pcall(require, uiAssets)

    if success then
        v1 = result
    else
        v1 = v16
    end
else
    v1 = v16
end

local colors = Theme.Colors
local fonts = Theme.Fonts
local v22 = {Theme = Theme, Sounds = Sounds, Assets = v1}
local v23 = {
    Frame = {BackgroundTransparency = 1, BorderSizePixel = 0},
    TextLabel = {BackgroundTransparency = 1, BorderSizePixel = 0, TextSize = 18, RichText = false, TextColor3 = colors.Text, FontFace = fonts.Heavy},
    TextButton = {BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false, Text = ""},
    ImageLabel = {BackgroundTransparency = 1, BorderSizePixel = 0},
    ImageButton = {BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false},
    ScrollingFrame = {BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 6, ScrollBarImageTransparency = 0.2, ScrollBarImageColor3 = colors.StrokeSoft, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar},
    ViewportFrame = {BackgroundTransparency = 1, BorderSizePixel = 0},
    CanvasGroup = {BackgroundTransparency = 1, BorderSizePixel = 0}
}

function v22.new(key: string, properties)
    --[[
      name: new
      line: 71
      upvalues:
        v23 (copy, index: 1)
    ]]
    local parent = Instance.new(key)
    local v27 = v23[key]
    if v27 then
        for v28, v29 in v27 do
            parent[v28] = v29
        end
    end

    local parent2 = nil

    if properties then
        if v27 and properties.BackgroundColor3 ~= nil and properties.BackgroundTransparency == nil then
            parent.BackgroundTransparency = 0
        end

        for v31, v32 in properties do
            if v31 == "Parent" then
                parent2 = v32
            elseif type(v31) ~= "number" then
                parent[v31] = v32
            end
        end

        for _, v34 in ipairs(properties) do
            v34.Parent = parent
        end
    end

    if parent2 then
        parent.Parent = parent2
    end

    return parent
end

function v22.Corner(a35: number)
    --[[
      name: Corner
      line: 102
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
    ]]
    local v36
    local v37 = a35

    if type(v37) ~= "number" then
        v36 = a35
    else
        v36 = UDim.new(0, v37)
    end

    return v22.new("UICorner", {CornerRadius = v36 or Theme.Radius.Medium})
end

function v22.Stroke(a38, a39, a40)
    --[[
      name: Stroke
      line: 110
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
    ]]
    return v22.new("UIStroke", {Color = a38 or colors.Stroke, Thickness = a39 or 2, Transparency = a40 or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Round})
end

function v22.TextStroke(a41, a42, a43)
    --[[
      name: TextStroke
      line: 121
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
    ]]
    return v22.new("UIStroke", {Color = a41 or colors.Void, Thickness = a42 or 2, Transparency = a43 or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual, LineJoinMode = Enum.LineJoinMode.Round})
end

function v22.Gradient(a44, a45, a46, a47)
    --[[
      name: Gradient
      line: 131
      upvalues:
        v22 (copy, index: 1)
    ]]
    local color

    if typeof(a44) ~= "ColorSequence" then
        color = ColorSequence.new(a44, a45 or a44)
    else
        color = a44
    end

    local new = v22.new
    local v50 = {Color = color, Rotation = a46 or 90}
    local transparency = a47 or NumberSequence.new(0)
    v50.Transparency = transparency

    return new("UIGradient", v50)
end

function v22.Padding(a52: number, a53, a54, a55)
    --[[
      name: Padding
      line: 145
      upvalues:
        v22 (copy, index: 1)
    ]]
    local new = v22.new
    local v57 = {PaddingTop = UDim.new(0, a52), PaddingRight = UDim.new(0, a53 or a52), PaddingBottom = UDim.new(0, a54
        or a52)}
    local newUDim = UDim.new
    local v59 = a55 or a53 or a52
    v57.PaddingLeft = newUDim(0, v59)

    return new("UIPadding", v57)
end

function v22.List(a60, a61, a62, a63)
    --[[
      name: List
      line: 154
      upvalues:
        v22 (copy, index: 1)
    ]]
    local new = v22.new
    local v65 = {FillDirection = a60 or Enum.FillDirection.Vertical, Padding = UDim.new(0, a61 or 8), HorizontalAlignment = a62
        or Enum.HorizontalAlignment.Left, VerticalAlignment = a63 or Enum.VerticalAlignment.Top, SortOrder = Enum.SortOrder.LayoutOrder}

    return new("UIListLayout", v65)
end

function v22.DisplayText(a66)
    --[[
      name: DisplayText
      line: 165
      upvalues:
        colors (copy, index: 1)
        fonts (copy, index: 2)
        v22 (copy, index: 3)
    ]]
    local values = table.clone(a66)
    local v68 = math.min((values.StrokeThickness or 1.5), 2)
    local v69 = values.StrokeColor or colors.Void
    values.StrokeThickness = nil
    values.StrokeColor = nil
    values.FontFace = values.FontFace or fonts.Display
    local parent = v22.new("TextLabel", values)
    v22.TextStroke(v69, v68, 0.45).Parent = parent

    return parent
end

function v22.Image(a71, a72)
    --[[
      name: Image
      line: 178
      upvalues:
        v22 (copy, index: 1)
    ]]
    local v73 = not a72 and {} or table.clone(a72)
    v73.Image = a71 or ""
    v73.ScaleType = v73.ScaleType or Enum.ScaleType.Fit

    return v22.new("ImageLabel", v73)
end

function v22.Tween(instance: Instance, tweenInfo: TweenInfo, propertyTable)
    --[[
      name: Tween
      line: 189
      upvalues:
        tweenService (copy, index: 1)
    ]]
    local tween = tweenService:Create(instance, tweenInfo, propertyTable)
    tween:Play()

    return tween
end

v22.GetScaleObj = function(parent: Instance?, a79)
    --[[
      name: getScaleObj
      line: 195
    ]]
    local childName = a79 or "AnimScale"
    local child = parent:FindFirstChild(childName)

    if child and child:IsA("UIScale") then
        return child
    end

    local uiScale = Instance.new("UIScale")
    uiScale.Name = childName
    uiScale.Parent = parent
    return uiScale
end

function v22.Pop(parent: Instance?, a84, a85)
    --[[
      name: Pop
      line: 210
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
    ]]
    local animScale
    local animScale2 = parent:FindFirstChild("AnimScale")

    if not animScale2 or not animScale2:IsA("UIScale") then
        animScale = Instance.new("UIScale")
        animScale.Name = "AnimScale"
        animScale.Parent = parent
    else
        animScale = animScale2
    end

    animScale.Scale = a84 or 0.6
    v22.Tween(animScale, (a85 or Theme.Tween.Pop), {Scale = 1})
end

function v22.Bump(parent: Instance?, a89)
    --[[
      name: Bump
      line: 217
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
    ]]
    local animScale
    local animScale2 = parent:FindFirstChild("AnimScale")

    if not animScale2 or not animScale2:IsA("UIScale") then
        animScale = Instance.new("UIScale")
        animScale.Name = "AnimScale"
        animScale.Parent = parent
    else
        animScale = animScale2
    end

    animScale.Scale = 1 + (a89 or 0.15)
    v22.Tween(animScale, Theme.Tween.PopSmall, {Scale = 1})
end

function v22.SlideIn(a92, a93, a94, a95)
    --[[
      name: SlideIn
      line: 224
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
    ]]
    local v96

    if a95 then
        v96 = a95
    else
        local slideTarget = a92:GetAttribute("_slideTarget")

        if typeof(slideTarget) ~= "UDim2" then
            v96 = a92.Position
        else
            v96 = slideTarget
        end
    end

    local v98 = a93 or Vector2.new(0, 24)
    a92:SetAttribute("_slideTarget", v96)
    a92.Position = v96 + UDim2.fromOffset(v98.X, v98.Y)
    local v99 = v22.Tween(a92, (a94 or Theme.Tween.Smooth), {Position = v96})

    v99.Completed:Connect(
        function(a100)
            --[[
              line: 234
              upvalues:
                a92 (copy, index: 1)
            ]]
            if a100 == Enum.PlaybackState.Completed then
                a92:SetAttribute("_slideTarget", nil)
            end
        end
    )

    return v99
end

local function fadeProps(a102)
    --[[
      name: fadeProps
      line: 243
    ]]
    local v103 = {}

    if a102:IsA("GuiObject") then
        v103.BackgroundTransparency = a102.BackgroundTransparency
    end

    if a102:IsA("TextLabel") or a102:IsA("TextButton") or a102:IsA("TextBox") then
        v103.TextTransparency = a102.TextTransparency
    elseif a102:IsA("ImageLabel") or a102:IsA("ImageButton") or a102:IsA("ViewportFrame") then
        v103.ImageTransparency = a102.ImageTransparency
    elseif a102:IsA("UIStroke") then
        v103.Transparency = a102.Transparency
    end

    for v104, v105 in v103 do
        if 1 <= v105 then
            v103[v104] = nil
        end
    end

    if next(v103) then
        return v103
    end

    return nil
end

local v106 = setmetatable({}, {__mode = "k"})

local function capture(key)
    --[[
      name: capture
      line: 266
      upvalues:
        v106 (copy, index: 1)
        fadeProps (copy, index: 2)
    ]]
    if const v109 = v106[key] then
        return v109
    end

    local v110 = {}

    if const v111 = fadeProps(key) then
        v110[key] = v111
    end

    for _, descendant in key:GetDescendants() do
        if const v114 = fadeProps(descendant) then
            v110[descendant] = v114
        end
    end

    v106[key] = v110

    return v110
end

function v22.ResetFade(key)
    --[[
      name: ResetFade
      line: 286
      upvalues:
        v106 (copy, index: 1)
    ]]
    v106[key] = nil
end

function v22.FadeIn(key, a117)
    --[[
      name: FadeIn
      line: 291
      upvalues:
        Theme (copy, index: 1)
        capture (copy, index: 2)
        v22 (copy, index: 3)
    ]]
    local v118 = a117 or Theme.Tween.Smooth

    for v119, v120 in capture(key) do
        if v119 == key or v119:IsDescendantOf(key) then
            for v121 in v120 do
                v119[v121] = 1
            end

            v22.Tween(v119, v118, v120)
        end
    end
end

function v22.FadeOut(key, a123)
    --[[
      name: FadeOut
      line: 304
      upvalues:
        Theme (copy, index: 1)
        capture (copy, index: 2)
        v22 (copy, index: 3)
    ]]
    local v124 = a123 or Theme.Tween.Close

    for v125, v126 in capture(key) do
        if v125 == key or v125:IsDescendantOf(key) then
            local v127 = {}

            for v128 in v126 do
                v127[v128] = 1
            end

            v22.Tween(v125, v124, v127)
        end
    end
end

function v22.Unfade(key)
    --[[
      name: Unfade
      line: 318
      upvalues:
        capture (copy, index: 1)
    ]]
    for v130, v131 in capture(key) do
        if v130 == key or v130:IsDescendantOf(key) then
            for v132, v133 in v131 do
                v130[v132] = v133
            end
        end
    end
end

function v22.Enter(a134, a135, a136, a137)
    --[[
      name: Enter
      line: 329
      upvalues:
        v22 (copy, index: 1)
    ]]
    local v138 = a136 or 0
    v22.SlideIn(a134, a135, TweenInfo.new(0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v138), a137)
    v22.FadeIn(a134, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v138))
end

function v22.Shake(a139, a140)
    --[[
      name: Shake
      line: 336
    ]]
    local v141
    local shakeBase = a139:GetAttribute("_shakeBase")

    if shakeBase ~= nil then
        v141 = shakeBase
    else
        local v143
        local slideTarget = a139:GetAttribute("_slideTarget")

        if typeof(slideTarget) ~= "UDim2" then
            v143 = a139.Position
        else
            v143 = slideTarget
        end

        a139:SetAttribute("_shakeBase", v143)
        v141 = v143
    end

    local v145 = a140 or 8

    task.spawn(
        function()
            --[[
              line: 344
              upvalues:
                v145 (copy, index: 1)
                a139 (copy, index: 2)
                v141 (ref,  index: 3)
            ]]
            for _, v147 in {v145, -v145, v145 * 0.6, -v145 * 0.6, v145 * 0.3, 0} do
                a139.Position = v141 + UDim2.fromOffset(v147, 0)
                task.wait(0.03)
            end

            a139.Position = v141
            a139:SetAttribute("_shakeBase", nil)
        end
    )
end

function v22.CountUp(parent: Instance?, a149, a150)
    --[[
      name: CountUp
      line: 355
      upvalues:
        v22 (copy, index: 1)
    ]]
    local v151 = a149 or v22.FormatNumber
    local numberValue = Instance.new("NumberValue")
    numberValue.Parent = parent
    local v153 = 0

    numberValue.Changed:Connect(
        function(value: number)
            --[[
              line: 360
              upvalues:
                v153 (ref,  index: 1)
                parent (copy, index: 2)
                v151 (copy, index: 3)
            ]]
            v153 = value
            parent.Text = v151((math.floor(value + 0.5)))
        end
    )

    local v155 = nil

    return function(value: number, a157)
        --[[
          line: 365
          upvalues:
            v155 (ref,  index: 1)
            numberValue (copy, index: 2)
            parent (copy, index: 3)
            v151 (copy, index: 4)
            a150 (copy, index: 5)
            v153 (ref,  index: 6)
            v22 (copy, index: 7)
        ]]
        if v155 then
            v155:Cancel()
        end

        if a157 then
            numberValue.Value = value
            parent.Text = v151((math.floor(value + 0.5)))

            return
        end

        local v158 = a150 or math.clamp(math.abs(value - v153) / 400, 0.35, 1.2)
        v155 = v22.Tween(numberValue, TweenInfo.new(v158, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Value = value})
    end
end

function v22.FormatNumber(a159: number)
    --[[
      name: FormatNumber
      line: 379
    ]]
    local text = tostring((math.floor((math.abs(a159)))))
    local text2 = text:reverse():gsub("(%d%d%d)", "%1,"):reverse()

    if text2:sub(1, 1) == "," then
        text2 = text2:sub(2)
    end

    local v162 = not (a159 < 0) and "" or "-"

    return v162 .. text2
end

function v22.FormatCompact(a163: number)
    --[[
      name: FormatCompact
      line: 388
      upvalues:
        v22 (copy, index: 1)
    ]]
    local formattedText
    local absoluteValue = math.abs(a163)

    if not (1e+06 <= absoluteValue) then
        if not (10000 <= absoluteValue) then
            return v22.FormatNumber(a163)
        end

        formattedText = string.format("%.1fK", absoluteValue / 1000)
    else
        formattedText = string.format("%.2fM", absoluteValue / 1e+06)
    end

    local v166 = formattedText:gsub("%.0+([KM])$", "%1"):gsub("(%.%d)0([KM])$", "%1%2")
    local v167 = not (a163 < 0) and "" or "-"

    return v167 .. v166
end

function v22.FormatTime(a168: number)
    --[[
      name: FormatTime
      line: 402
    ]]
    local v169 = math.max(0, (math.ceil(a168)))
    return string.format("%d:%02d", v169 // 60, v169 % 60)
end

v22.Scale = 1
v22.ScaleChanged = Signal.new()
v22.BackdropCanvas = nil
v22.Touch = false
v22.Compact = false
v22.Tablet = false
v22.LayoutChanged = Signal.new()
v22.TouchChanged = Signal.new()
v22.COMPACT_DESIGN = Vector2.new(1280, 600)
v22.TV_DESIGN = Vector2.new(1280, 720)
v22.Gamepad = false
v22.GamepadChanged = Signal.new()
v22.TenFoot = false
v22.DebugDevice = nil

local function touchOnlyDevice()
    --[[
      name: touchOnlyDevice
      line: 435
      upvalues:
        userInputService (copy, index: 1)
    ]]
    return userInputService.TouchEnabled
        and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)
end

local function preferredTouch()
    --[[
      name: preferredTouch
      line: 439
      upvalues:
        userInputService (copy, index: 1)
    ]]
    local success, preferredInput = pcall(
        function()
            --[[
              line: 440
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput
        end
    )

    if not success or preferredInput == nil then
        return nil
    end

    local success2, isTouch = pcall(
        function()
            --[[
              line: 446
              upvalues:
                preferredInput (copy, index: 1)
            ]]
            return preferredInput == Enum.PreferredInput.Touch
        end
    )
    if success2 then
        return isTouch
    end

    return nil
end

local v176 = nil

local function decisive(lastInputType: Enum.UserInputType)
    --[[
      name: decisive
      line: 453
    ]]
    if lastInputType == Enum.UserInputType.Touch then
        return true
    end
    if lastInputType ~= Enum.UserInputType.Keyboard
        and lastInputType ~= Enum.UserInputType.MouseButton1
        and lastInputType ~= Enum.UserInputType.MouseButton2
        and lastInputType ~= Enum.UserInputType.MouseWheel
        and not string.find(lastInputType.Name, "Gamepad", 1, true)
    then
        return nil
    end

    return false
end

local function decideTouch()
    --[[
      name: decideTouch
      line: 464
      upvalues:
        userInputService (copy, index: 1)
        preferredTouch (copy, index: 2)
        v176 (ref,  index: 3)
        decisive (copy, index: 4)
    ]]
    if not userInputService.TouchEnabled then
        return false
    end

    local v180 = userInputService.TouchEnabled
        and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)
    if v180 then
        return true
    end

    local v181 = preferredTouch()
    if v181 ~= nil then
        return v181
    end

    if v176 == nil then
        v176 = decisive(userInputService:GetLastInputType()) == true
    end

    return v176
end

if userInputService.TouchEnabled then
    local v182 = userInputService.TouchEnabled
        and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)

    if v182 then
        touch = true
    else
        local v183 = preferredTouch()

        if v183 == nil then
            if v176 == nil then
                if decisive(userInputService:GetLastInputType()) == true then
                    v176 = true
                else
                    v176 = false
                end
            end

            touch = v176
        else
            touch = v183
        end
    end
else
    touch = false
end

v22.Touch = touch

local function computeScale()
    --[[
      name: computeScale
      line: 482
      upvalues:
        v22 (copy, index: 1)
        workspace (copy, index: 2)
        Theme (copy, index: 3)
    ]]
    local v185, v186, v187

    if const debugDevice = v22.DebugDevice then
        local compact = debugDevice.compact ~= false
        local tablet = compact and debugDevice.tablet == true
        v185 = debugDevice.scale
        v186, v187 = compact, tablet
    else
        local camera = workspace.CurrentCamera
        local v192 = camera and camera.ViewportSize or Theme.DesignSize

        if v192.X < 2 or v192.Y < 2 then
            return 1
        end

        local v193
        local maxValue
        local v195 = v22.Touch or v192.Y < 560
        local v196 = v195
        local v197 = v22.TenFoot and not v195

        if v195 then
            v193 = v22.COMPACT_DESIGN
        else
            v193 = if v197 then v22.TV_DESIGN else Theme.DesignSize
        end

        local v198 = math.min(v192.X / v193.X, v192.Y / v193.Y)

        if v197 then
            maxValue = 3.2
        else
            maxValue = 1.6
        end

        v185 = math.clamp(v198, 0.4, maxValue)
        local v199 = v195 and 760 <= v192.Y / v185
        v186, v187 = v196, v199
    end

    local compact = v22.Compact

    if v186 ~= compact or v187 ~= v22.Tablet then
        v22.Compact = v186
        v22.Tablet = v187
        task.defer(
            function()
                --[[
                  line: 505
                  upvalues:
                    v22 (copy, index: 1)
                    v186 (ref,  index: 2)
                ]]
                v22.LayoutChanged:Fire(v186)
            end
        )
    end

    return v185
end

local v201 = {}

local function applyScale()
    --[[
      name: applyScale
      line: 514
      upvalues:
        computeScale (copy, index: 1)
        v22 (copy, index: 2)
        workspace (copy, index: 3)
        Theme (copy, index: 4)
        v201 (copy, index: 5)
    ]]
    local scale = computeScale()
    v22.Scale = scale
    local debugDevice = v22.DebugDevice
    local camera = workspace.CurrentCamera
    local v206 = camera and camera.ViewportSize or Theme.DesignSize

    for _, v208 in v201 do
        v208.scale.Scale = scale

        if debugDevice then
            v208.frame.Size = UDim2.fromOffset(debugDevice.rect.X / scale, debugDevice.rect.Y / scale)
            v208.frame.Position = if debugDevice.topLeft then UDim2.new() else UDim2.fromOffset(math.floor((v206.X - debugDevice.rect.X) / 2), (math.floor((v206.Y - debugDevice.rect.Y) / 2)))
        else
            v208.frame.Size = UDim2.fromScale(1 / scale, 1 / scale)
            v208.frame.Position = UDim2.new()
        end
    end

    v22.ScaleChanged:Fire(scale)
end

local function setTouch(touch)
    --[[
      name: setTouch
      line: 535
      upvalues:
        v22 (copy, index: 1)
        applyScale (copy, index: 2)
    ]]
    if touch == v22.Touch then
        return
    end

    v22.Touch = touch
    applyScale()
    v22.TouchChanged:Fire(touch)
end

local count = 0
local v212 = nil

local function reconsiderTouch()
    --[[
      name: reconsiderTouch
      line: 546
      upvalues:
        v22 (copy, index: 1)
        userInputService (copy, index: 2)
        preferredTouch (copy, index: 3)
        v176 (ref,  index: 4)
        decisive (copy, index: 5)
        v212 (ref,  index: 6)
        count (ref,  index: 7)
        applyScale (copy, index: 8)
    ]]
    local touch

    if v22.DebugDevice then
        return
    end

    if userInputService.TouchEnabled then
        local v215 = userInputService.TouchEnabled
            and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)

        if v215 then
            touch = true
        else
            local v216 = preferredTouch()

            if v216 == nil then
                if v176 == nil then
                    v176 = decisive(userInputService:GetLastInputType()) == true
                end

                touch = v176
            else
                touch = v216
            end
        end
    else
        touch = false
    end

    if touch ~= v22.Touch then
        if v212 ~= touch then
            v212 = touch
            count += 1
            local v217 = count

            task.delay(
                0.3,
                function()
                    --[[
                      line: 564
                      upvalues:
                        v217 (copy, index: 1)
                        count (ref,  index: 2)
                        v212 (ref,  index: 3)
                        v22 (copy, index: 4)
                        userInputService (copy, index: 5)
                        preferredTouch (copy, index: 6)
                        v176 (ref,  index: 7)
                        decisive (copy, index: 8)
                        touch (copy, index: 9)
                        applyScale (copy, index: 10)
                    ]]
                    if v217 ~= count then
                        return
                    end

                    v212 = nil

                    if not v22.DebugDevice then
                        local v218

                        if userInputService.TouchEnabled then
                            local v219 = userInputService.TouchEnabled
                                and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)

                            if v219 then
                                v218 = true
                            else
                                local v220 = preferredTouch()

                                if v220 == nil then
                                    if v176 == nil then
                                        v176 = decisive(userInputService:GetLastInputType()) == true
                                    end

                                    v218 = v176
                                else
                                    v218 = v220
                                end
                            end
                        else
                            v218 = false
                        end

                        if v218 == touch then
                            if touch == v22.Touch then
                                return
                            end

                            v22.Touch = touch
                            applyScale()
                            v22.TouchChanged:Fire(touch)
                        end
                    end
                end
            )
        end
    elseif v212 ~= nil then
        v212 = nil
        count += 1
    end
end

userInputService.LastInputTypeChanged:Connect(
    function(lastInputType: Enum.UserInputType)
        --[[
          line: 574
          upvalues:
            decisive (copy, index: 1)
            v176 (ref,  index: 2)
            reconsiderTouch (copy, index: 3)
        ]]
        local v222 = decisive(lastInputType)
        if v222 ~= nil then
            v176 = v222
        end

        reconsiderTouch()
    end
)

pcall(
    function()
        --[[
          line: 581
          upvalues:
            userInputService (copy, index: 1)
            reconsiderTouch (copy, index: 2)
        ]]
        userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(reconsiderTouch)
    end
)

for _, property in {"TouchEnabled", "KeyboardEnabled", "MouseEnabled"} do
    userInputService:GetPropertyChangedSignal(property):Connect(reconsiderTouch)
end

local v225 = nil

if string.find(userInputService:GetLastInputType().Name, "Gamepad", 1, true) ~= nil then
    v3 = true
else
    v3 = false
end

local function decideGamepad()
    --[[
      name: decideGamepad
      line: 593
      upvalues:
        v225 (ref,  index: 1)
        v22 (copy, index: 2)
        userInputService (copy, index: 3)
        v3 (ref,  index: 4)
    ]]
    if v225 ~= nil then
        return v225
    end
    if v22.Touch then
        return false
    end

    local success, isGamepad = pcall(
        function()
            --[[
              line: 600
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
        end
    )
    if not success then
        return v3 or v22.TenFoot and not userInputService.KeyboardEnabled
    end
    if isGamepad then
        return true
    end

    return v3 or v22.TenFoot and not userInputService.KeyboardEnabled
end

local function reconsiderGamepad()
    --[[
      name: reconsiderGamepad
      line: 609
      upvalues:
        v225 (ref,  index: 1)
        v22 (copy, index: 2)
        userInputService (copy, index: 3)
        v3 (ref,  index: 4)
    ]]
    local gamepad

    if v225 == nil then
        if v22.Touch then
            gamepad = false
        else
            local success, isGamepad = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        userInputService (copy, index: 1)
                    ]]
                    return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
                end
            )
            gamepad = success and isGamepad and true or v3 or v22.TenFoot and not userInputService.KeyboardEnabled
        end
    else
        gamepad = v225
    end

    if gamepad ~= v22.Gamepad then
        v22.Gamepad = gamepad
        v22.GamepadChanged:Fire(gamepad)
    end
end

userInputService.LastInputTypeChanged:Connect(
    function(lastInputType: Enum.UserInputType)
        --[[
          line: 616
          upvalues:
            v3 (ref,  index: 1)
            decisive (copy, index: 2)
            v225 (ref,  index: 3)
            v22 (copy, index: 4)
            userInputService (copy, index: 5)
        ]]
        local gamepad

        if string.find(lastInputType.Name, "Gamepad", 1, true) then
            v3 = true
        elseif decisive(lastInputType) ~= nil then
            v3 = false
        end

        if v225 == nil then
            if v22.Touch then
                gamepad = false
            else
                local success, isGamepad = pcall(
                    function()
                        --[[
                          line: 600
                          upvalues:
                            userInputService (copy, index: 1)
                        ]]
                        return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
                    end
                )
                gamepad = success and isGamepad and true
                    or v3
                    or v22.TenFoot and not userInputService.KeyboardEnabled
            end
        else
            gamepad = v225
        end

        if gamepad ~= v22.Gamepad then
            v22.Gamepad = gamepad
            v22.GamepadChanged:Fire(gamepad)
        end
    end
)

pcall(
    function()
        --[[
          line: 624
          upvalues:
            userInputService (copy, index: 1)
            reconsiderGamepad (copy, index: 2)
        ]]
        userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(reconsiderGamepad)
    end
)
v22.TouchChanged:Connect(reconsiderGamepad)

function v22.SetDebugGamepad(debugGamepad)
    --[[
      name: SetDebugGamepad
      line: 628
      upvalues:
        runService (copy, index: 1)
        v225 (ref,  index: 2)
        v22 (copy, index: 3)
        userInputService (copy, index: 4)
        v3 (ref,  index: 5)
    ]]
    local gamepad

    if not runService:IsStudio() then
        return
    end

    v225 = debugGamepad

    if v225 == nil then
        if v22.Touch then
            gamepad = false
        else
            local success, isGamepad = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        userInputService (copy, index: 1)
                    ]]
                    return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
                end
            )
            gamepad = success and isGamepad and true or v3 or v22.TenFoot and not userInputService.KeyboardEnabled
        end
    else
        gamepad = v225
    end

    if gamepad ~= v22.Gamepad then
        v22.Gamepad = gamepad
        v22.GamepadChanged:Fire(gamepad)
    end
end

local function setTenFoot(tenFoot)
    --[[
      name: setTenFoot
      line: 638
      upvalues:
        v22 (copy, index: 1)
        applyScale (copy, index: 2)
        v225 (ref,  index: 3)
        userInputService (copy, index: 4)
        v3 (ref,  index: 5)
    ]]
    if tenFoot ~= v22.TenFoot then
        local gamepad
        v22.TenFoot = tenFoot
        applyScale()

        if v225 == nil then
            if v22.Touch then
                gamepad = false
            else
                local success, isGamepad = pcall(
                    function()
                        --[[
                          line: 600
                          upvalues:
                            userInputService (copy, index: 1)
                        ]]
                        return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
                    end
                )
                gamepad = success and isGamepad and true
                    or v3
                    or v22.TenFoot and not userInputService.KeyboardEnabled
            end
        else
            gamepad = v225
        end

        if gamepad ~= v22.Gamepad then
            v22.Gamepad = gamepad
            v22.GamepadChanged:Fire(gamepad)
        end

        v22.TouchChanged:Fire(v22.Touch)
    end
end

local success, isTenFootInterface = pcall(
    function()
        --[[
          line: 647
          upvalues:
            guiService (copy, index: 1)
        ]]
        return guiService:IsTenFootInterface()
    end
)
v22.TenFoot = success and (isTenFootInterface == true)

function v22.SetDebugTenFoot(debugTenFoot)
    --[[
      name: SetDebugTenFoot
      line: 652
      upvalues:
        v22 (copy, index: 1)
        applyScale (copy, index: 2)
        v225 (ref,  index: 3)
        userInputService (copy, index: 4)
        v3 (ref,  index: 5)
    ]]
    if debugTenFoot ~= v22.TenFoot then
        local gamepad
        v22.TenFoot = debugTenFoot
        applyScale()

        if v225 == nil then
            if v22.Touch then
                gamepad = false
            else
                local success, isGamepad = pcall(
                    function()
                        --[[
                          line: 600
                          upvalues:
                            userInputService (copy, index: 1)
                        ]]
                        return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
                    end
                )
                gamepad = success and isGamepad and true
                    or v3
                    or v22.TenFoot and not userInputService.KeyboardEnabled
            end
        else
            gamepad = v225
        end

        if gamepad ~= v22.Gamepad then
            v22.Gamepad = gamepad
            v22.GamepadChanged:Fire(gamepad)
        end

        v22.TouchChanged:Fire(v22.Touch)
    end
end

if v225 == nil then
    if v22.Touch then
        gamepad = false
    else
        local success2, isGamepad = pcall(
            function()
                --[[
                  line: 600
                  upvalues:
                    userInputService (copy, index: 1)
                ]]
                return userInputService.PreferredInput == Enum.PreferredInput.Gamepad
            end
        )
        gamepad = success2 and isGamepad and true or v3 or v22.TenFoot and not userInputService.KeyboardEnabled
    end
else
    gamepad = v225
end

v22.Gamepad = gamepad

function v22.SetDebugDevice(debugDevice, a255)
    --[[
      name: SetDebugDevice
      line: 657
      upvalues:
        v22 (copy, index: 1)
        count (ref,  index: 2)
        v212 (ref,  index: 3)
        userInputService (copy, index: 4)
        preferredTouch (copy, index: 5)
        v176 (ref,  index: 6)
        decisive (copy, index: 7)
        applyScale (copy, index: 8)
    ]]
    local touch
    v22.DebugDevice = debugDevice
    count += 1
    v212 = nil

    if debugDevice then
        touch = a255 ~= false
    elseif userInputService.TouchEnabled then
        local v257 = userInputService.TouchEnabled
            and not (userInputService.KeyboardEnabled and userInputService.MouseEnabled)

        if v257 then
            touch = true
        else
            local v258 = preferredTouch()

            if v258 == nil then
                if v176 == nil then
                    v176 = decisive(userInputService:GetLastInputType()) == true
                end

                touch = v176
            else
                touch = v258
            end
        end
    else
        touch = false
    end

    if touch == v22.Touch then
        applyScale()
        return
    end

    if touch == v22.Touch then
        return
    end

    v22.Touch = touch
    applyScale()
    v22.TouchChanged:Fire(touch)
end

local viewportSizeChangedConnection = nil

local function hookCamera()
    --[[
      name: hookCamera
      line: 670
      upvalues:
        viewportSizeChangedConnection (ref,  index: 1)
        workspace (copy, index: 2)
        applyScale (copy, index: 3)
    ]]
    if viewportSizeChangedConnection then
        viewportSizeChangedConnection:Disconnect()
    end

    if const camera = workspace.CurrentCamera then
        viewportSizeChangedConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(applyScale)
    end

    applyScale()
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(hookCamera)

if viewportSizeChangedConnection then
    viewportSizeChangedConnection:Disconnect()
end

if const camera = workspace.CurrentCamera then
    viewportSizeChangedConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(applyScale)
end

applyScale()
local v263 = {}

v22.TouchChanged:Connect(
    function(a264)
        --[[
          line: 685
          upvalues:
            v263 (copy, index: 1)
            v22 (copy, index: 2)
        ]]
        for v265 in v263 do
            v265.ScreenInsets = if not a264 and not v22.TenFoot then Enum.ScreenInsets.None else Enum.ScreenInsets.DeviceSafeInsets
        end
    end
)

function v22.Screen(name, displayOrder, parent, a269)
    --[[
      name: Screen
      line: 692
      upvalues:
        v22 (copy, index: 1)
        v263 (copy, index: 2)
        v201 (copy, index: 3)
    ]]
    local fullBleed = a269 ~= nil and a269.fullBleed == true
    local parent2 = v22.new("ScreenGui", {ResetOnSpawn = false, IgnoreGuiInset = true, Name = name, DisplayOrder = displayOrder, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
    parent2.ScreenInsets = if (v22.Touch or v22.TenFoot) and not fullBleed then Enum.ScreenInsets.DeviceSafeInsets else Enum.ScreenInsets.None

    if not fullBleed then
        v263[parent2] = true
        parent2.Destroying:Connect(
            function()
                --[[
                  line: 704
                  upvalues:
                    v263 (copy, index: 1)
                    parent2 (copy, index: 2)
                ]]
                v263[parent2] = nil
            end
        )
    end

    local v272 = v22.new("Frame", {Name = "Canvas", Size = UDim2.fromScale(1, 1), Parent = parent2})
    local scale = v22.new("UIScale", {Name = "CanvasScale", Parent = v272})
    table.insert(v201, {frame = v272, scale = scale})
    scale.Scale = v22.Scale
    v272.Size = UDim2.fromScale(1 / v22.Scale, 1 / v22.Scale)
    parent2.Parent = parent

    return parent2, v272
end

function v22.CanvasSize()
    --[[
      name: CanvasSize
      line: 718
      upvalues:
        v22 (copy, index: 1)
        workspace (copy, index: 2)
        Theme (copy, index: 3)
    ]]
    if const debugDevice = v22.DebugDevice then
        return debugDevice.rect / debugDevice.scale
    end

    local camera = workspace.CurrentCamera
    local v276 = camera and camera.ViewportSize or Theme.DesignSize

    return v276 / v22.Scale
end

v22.TopInsetChanged = Signal.new()

function v22.TopInset()
    --[[
      name: TopInset
      line: 730
      upvalues:
        v22 (copy, index: 1)
        guiService (copy, index: 2)
    ]]
    local y

    if const debugDevice = v22.DebugDevice then
        return (debugDevice.topInset or 60) + 4
    end

    local success, topbarInset = pcall(
        function()
            --[[
              line: 735
              upvalues:
                guiService (copy, index: 1)
            ]]
            return guiService.TopbarInset
        end
    )

    if not success or not topbarInset then
        y = 58
    else
        y = topbarInset.Max.Y
    end

    if y <= 0 then
        y = 58
    end

    return math.ceil(y / math.max(v22.Scale, 0.01)) + 4
end

function v22.TopCentreY(a281)
    --[[
      name: TopCentreY
      line: 746
      upvalues:
        v22 (copy, index: 1)
        guiService (copy, index: 2)
        workspace (copy, index: 3)
    ]]
    if v22.DebugDevice then
        return v22.TopInset()
    end

    local success, topbarInset = pcall(
        function()
            --[[
              line: 750
              upvalues:
                guiService (copy, index: 1)
            ]]
            return guiService.TopbarInset
        end
    )

    if not success or not topbarInset or topbarInset.Width <= 0 then
        return v22.TopInset()
    end

    local v285 = if const camera = workspace.CurrentCamera then camera.ViewportSize.X else 0
    local v286 = (a281 * math.max(v22.Scale, 0.01)) / 2 + 2
    local v287 = v285 / 2

    if (topbarInset.Min.X + v22.TopbarReserved) + 8 <= v287 - v286 and v287 + v286 <= topbarInset.Max.X then
        return 6
    end

    return v22.TopInset()
end

v22.TopbarReserved = 0
pcall(
    function()
        --[[
          line: 770
          upvalues:
            guiService (copy, index: 1)
            v22 (copy, index: 2)
        ]]
        guiService:GetPropertyChangedSignal("TopbarInset"):Connect(
            function()
                --[[
                  line: 771
                  upvalues:
                    v22 (copy, index: 1)
                ]]
                v22.TopInsetChanged:Fire()
            end
        )
    end
)
v22.ScaleChanged:Connect(
    function()
        --[[
          line: 775
          upvalues:
            v22 (copy, index: 1)
        ]]
        v22.TopInsetChanged:Fire()
    end
)

function v22.OnResize(callback)
    --[[
      name: OnResize
      line: 782
      upvalues:
        v22 (copy, index: 1)
    ]]
    local isBusy = false

    v22.ScaleChanged:Connect(
        function()
            --[[
              line: 784
              upvalues:
                isBusy (ref,  index: 1)
                callback (copy, index: 2)
            ]]
            if isBusy then
                return
            end

            isBusy = true

            task.defer(
                function()
                    --[[
                      line: 789
                      upvalues:
                        isBusy (ref,  index: 1)
                        callback (copy, index: 2)
                    ]]
                    isBusy = false
                    callback()
                end
            )
        end
    )
end

v22.ChatChanged = Signal.new()
v22.DebugChatRect = nil
local result = nil

local function unionRect(a292, absolutePosition, absoluteSize)
    --[[
      name: unionRect
      line: 811
    ]]
    if absoluteSize.X < 2 or absoluteSize.Y < 2 then
        return a292
    end
    if not a292 then
        return Rect.new(absolutePosition, absolutePosition + absoluteSize)
    end

    return Rect.new(math.min(a292.Min.X, absolutePosition.X), math.min(a292.Min.Y, absolutePosition.Y), math.max(a292.Max.X, absolutePosition.X + absoluteSize.X), (math.max(a292.Max.Y, absolutePosition.Y + absoluteSize.Y)))
end

local function readChatRect()
    --[[
      name: readChatRect
      line: 826
      upvalues:
        v22 (copy, index: 1)
        unionRect (copy, index: 2)
    ]]
    local v296

    if v22.DebugChatRect then
        return v22.DebugChatRect
    end

    local starterGui = game:GetService("StarterGui")

    if not starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
        return nil
    end

    local success, core = pcall(
        function()
            --[[
              line: 834
              upvalues:
                starterGui (copy, index: 1)
            ]]
            return starterGui:GetCore("ChatActive")
        end
    )

    if success and core == false then
        return nil
    end

    local textChatService = game:GetService("TextChatService")
    local v301 = nil
    v296 = if const chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration") then if chatWindowConfiguration.Enabled then unionRect(v301, chatWindowConfiguration.AbsolutePosition, chatWindowConfiguration.AbsoluteSize) else v301 else v301
    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

    if chatInputBarConfiguration and chatInputBarConfiguration.Enabled then
        v296 = unionRect(v296, chatInputBarConfiguration.AbsolutePosition, chatInputBarConfiguration.AbsoluteSize)
    end

    if v296 then
        return v296
    end

    local localPlayer = game:GetService("Players").LocalPlayer
    local playerGui = localPlayer and localPlayer:FindFirstChildOfClass("PlayerGui")
    local chat = playerGui and playerGui:FindFirstChild("Chat")

    if not chat or not chat:IsA("ScreenGui") or not chat.Enabled then
        return nil
    end

    local frame = chat:FindFirstChild("Frame")

    if not frame or not frame:IsA("GuiObject") or not frame.Visible then
        return nil
    end

    local v308

    for _, child in frame:GetChildren() do
        if child:IsA("GuiObject") then
            if not child.Visible then
                continue
            end
            if not string.find(child.Name, "ParentFrame", 1, true) then
                continue
            end

            v308 = unionRect(v308, child.AbsolutePosition, child.AbsoluteSize)
        end
    end

    return v308
end

local function sameRect(result, result2)
    --[[
      name: sameRect
      line: 877
    ]]
    if result ~= nil and result2 ~= nil then
        local v314 = math.abs(result.Min.X - result2.Min.X) < 2
            and math.abs(result.Min.Y - result2.Min.Y) < 2
            and math.abs(result.Max.X - result2.Max.X) < 2
            and math.abs(result.Max.Y - result2.Max.Y) < 2
        return v314
    end

    return result == result2
end

local v315 = 0

runService.Heartbeat:Connect(
    function(deltaTime: number)
        --[[
          line: 886
          upvalues:
            v315 (ref,  index: 1)
            readChatRect (copy, index: 2)
            sameRect (copy, index: 3)
            result (ref,  index: 4)
            v22 (copy, index: 5)
        ]]
        local result2
        v315 += deltaTime

        if v315 < 0.2 then
            return
        end

        v315 = 0
        local success, result3 = pcall(readChatRect)

        if success then
            result2 = result3
        else
            result2 = nil
        end

        if not sameRect(result2, result) then
            result = result2
            v22.ChatChanged:Fire(result2)
        end
    end
)

function v22.ChatRect()
    --[[
      name: ChatRect
      line: 900
      upvalues:
        result (ref, index: 1)
    ]]
    return result
end

function v22.ChatRectIn(a320)
    --[[
      name: ChatRectIn
      line: 904
      upvalues:
        result (ref,  index: 1)
        v22 (copy, index: 2)
    ]]
    local result2 = result
    if not result2 then
        return nil
    end

    local absolutePosition = a320.AbsolutePosition
    local v323 = math.max(v22.Scale, 0.01)

    return Rect.new((result2.Min - absolutePosition) / v323, (result2.Max - absolutePosition) / v323)
end

local vector2 = Vector2.zero

local function trackPointer(input: InputObject)
    --[[
      name: trackPointer
      line: 916
      upvalues:
        vector2 (ref, index: 1)
    ]]
    local userInputType = input.UserInputType

    if userInputType == Enum.UserInputType.Touch
        or userInputType == Enum.UserInputType.MouseMovement
        or userInputType == Enum.UserInputType.MouseButton1
    then
        vector2 = Vector2.new(input.Position.X, input.Position.Y)
    end
end

userInputService.InputBegan:Connect(trackPointer)
userInputService.InputChanged:Connect(trackPointer)

function v22.PointerAbs()
    --[[
      name: PointerAbs
      line: 924
      upvalues:
        vector2 (ref, index: 1)
    ]]
    return vector2
end

function v22.Panel(a328)
    --[[
      name: Panel
      line: 934
      upvalues:
        colors (copy, index: 1)
        v22 (copy, index: 2)
        Theme (copy, index: 3)
    ]]
    local values = table.clone(a328)
    local radius = values.Radius
    local v331 = values.StrokeColor or colors.Stroke
    local strokeTransparency = values.StrokeTransparency or 0.9
    local noStroke = values.NoStroke
    local v334 = values.TopColor or colors.Panel
    local v335 = values.BottomColor or colors.PanelLo
    values.Radius = nil
    values.Trim = nil
    values.StrokeColor = nil
    values.StrokeTransparency = nil
    values.NoStroke = nil
    values.TopColor = nil
    values.BottomColor = nil
    local strokeThickness = values.StrokeThickness or 1
    values.StrokeThickness = nil
    values.BackgroundTransparency = values.BackgroundTransparency or 0.12
    values.BackgroundColor3 = Color3.new(1, 1, 1)
    local parent = v22.new("Frame", values)
    local corner = v22.Corner
    local v339 = radius or Theme.Radius.Large
    corner(v339).Parent = parent
    v22.Gradient(v334, v335, 90).Parent = parent

    if not noStroke then
        v22.Stroke(v331, strokeThickness, strokeTransparency).Parent = parent
    end

    return parent
end

function v22.TeethTrim(a340)
    --[[
      name: TeethTrim
      line: 957
      upvalues:
        v22 (copy, index: 1)
    ]]
    return v22.new("Frame", {Name = "Trim", Visible = false, Size = UDim2.fromOffset(0, 0), Parent = a340.Parent})
end

function v22.DropShadow(parent, a342, a343, a344)
    --[[
      name: DropShadow
      line: 962
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
    ]]
    for v345, v346 in {0, 4, 9} do
        v22.new("Frame", {Name = "Shadow" .. v345, BackgroundColor3 = colors.Void, BackgroundTransparency = 1 - ((a344
            or 0.5) / (v345 * 1.6)), Size = UDim2.new(1, v346 * 2, 1, v346 * 2), Position = UDim2.fromOffset(-v346, -v346 + (a343
            or 6)), ZIndex = 0, (v22.Corner((a342 or 14) + v346)), Parent = parent})
    end
end

function v22.Bar(options)
    --[[
      name: Bar
      line: 981
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
        Theme (copy, index: 3)
    ]]
    local new = v22.new
    local v349 = {Name = options.Name or "Bar"}
    local v350 = options.Size or UDim2.fromOffset(200, 10)
    v349.Size = v350
    local v351 = options.Position or UDim2.new()
    v349.Position = v351
    v349.AnchorPoint = options.AnchorPoint or Vector2.zero
    v349.BackgroundColor3 = options.TrackColor or colors.Inset
    v349.BackgroundTransparency = options.TrackTransparency or 0.2
    v349.LayoutOrder = options.LayoutOrder or 0
    v349.ClipsDescendants = true
    v349[1] = (v22.Corner((options.Radius or Theme.Radius.Pill)))
    v349.Parent = options.Parent
    local v352 = new("Frame", v349)

    if options.Stroke ~= false then
        v22.Stroke(colors.Stroke, 1.5, 0.8).Parent = v352
    end

    local new2 = v22.new
    local v354 = {Name = "Fill", Size = UDim2.fromScale((options.Value or 0), 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = (v22.Corner((options.Radius
        or Theme.Radius.Pill))), Parent = v352}
    local v355 = new2("Frame", v354)
    local gradient = v22.Gradient
    local v357 = Theme.Lighten((options.Color or colors.Accent), 0.2)
    local v358 = gradient(v357, (options.Color or colors.Accent), 90)
    v358.Parent = v355
    local v359 = nil

    return {
        Frame = v352,
        Fill = v355,
        Set = (function(a360: number, a361, a362)
            --[[
              name: Set
              line: 1010
              upvalues:
                v359 (ref,  index: 1)
                v355 (copy, index: 2)
                v22 (copy, index: 3)
                Theme (copy, index: 4)
            ]]
            local clampedValue = math.clamp(a360, 0, 1)

            if v359 then
                v359:Cancel()
                v359 = nil
            end

            if a361 then
                v355.Size = UDim2.fromScale(clampedValue, 1)
                return
            end

            v359 = v22.Tween(v355, (a362 or Theme.Tween.Smooth), {Size = UDim2.fromScale(clampedValue, 1)})
        end),
        SetColor = (function(color)
            --[[
              name: SetColor
              line: 1022
              upvalues:
                v358 (copy, index: 1)
                Theme (copy, index: 2)
            ]]
            v358.Color = ColorSequence.new(Theme.Lighten(color, 0.2), color)
        end)
    }
end

local buttonStyles = {
    Primary = {top = Color3.fromRGB(64, 168, 255), bottom = Color3.fromRGB(28, 132, 246), lip = Color3.fromRGB(12, 70, 160), stroke = Color3.fromRGB(150, 210, 255), text = colors.Text},
    Success = {top = Color3.fromRGB(84, 224, 124), bottom = Color3.fromRGB(40, 184, 92), lip = Color3.fromRGB(16, 100, 48), stroke = Color3.fromRGB(170, 255, 200), text = colors.Text},
    Danger = {top = Color3.fromRGB(255, 92, 98), bottom = Color3.fromRGB(226, 52, 62), lip = Color3.fromRGB(120, 18, 28), stroke = Color3.fromRGB(255, 170, 176), text = colors.Text},
    Dark = {top = Color3.fromRGB(44, 48, 60), bottom = Color3.fromRGB(34, 37, 47), lip = Color3.fromRGB(16, 18, 24), stroke = Color3.fromRGB(96, 104, 124), text = colors.Text},
    Light = {top = Color3.fromRGB(250, 251, 253), bottom = Color3.fromRGB(226, 230, 238), lip = Color3.fromRGB(150, 156, 172), stroke = Color3.fromRGB(255, 255, 255), text = colors.TextDark},
    Disabled = {top = Color3.fromRGB(46, 49, 58), bottom = Color3.fromRGB(38, 41, 49), lip = Color3.fromRGB(20, 22, 28), stroke = Color3.fromRGB(70, 75, 88), text = Color3.fromRGB(130, 136, 150)}
}
buttonStyles.Ochre = buttonStyles.Primary
buttonStyles.Jade = buttonStyles.Success
buttonStyles.Ally = buttonStyles.Primary
v22.ButtonStyles = buttonStyles
local v366 = setmetatable({}, {__mode = "k"})
local v367 = setmetatable({}, {__mode = "k"})

function v22.TrackPress(key)
    --[[
      name: TrackPress
      line: 1080
      upvalues:
        v366 (copy, index: 1)
        v367 (copy, index: 2)
    ]]
    if v366[key] ~= nil then
        return
    end

    v366[key] = -math.huge
    v367[key] = -math.huge

    local function pointer(a370)
        --[[
          name: pointer
          line: 1085
        ]]
        return (a370.UserInputType == Enum.UserInputType.MouseButton1)
            or (a370.UserInputType == Enum.UserInputType.Touch)
    end

    key.MouseButton1Down:Connect(
        function()
            --[[
              line: 1088
              upvalues:
                v366 (copy, index: 1)
                key (copy, index: 2)
            ]]
            v366[key] = os.clock()
        end
    )

    key.InputBegan:Connect(
        function(a371)
            --[[
              line: 1091
              upvalues:
                v366 (copy, index: 1)
                key (copy, index: 2)
                pointer (copy, index: 3)
            ]]
            if pointer(a371) then
                v366[key] = os.clock()
            end
        end
    )

    key.MouseButton1Up:Connect(
        function()
            --[[
              line: 1096
              upvalues:
                v367 (copy, index: 1)
                key (copy, index: 2)
            ]]
            v367[key] = os.clock()
        end
    )

    key.InputEnded:Connect(
        function(a372)
            --[[
              line: 1099
              upvalues:
                v367 (copy, index: 1)
                key (copy, index: 2)
                pointer (copy, index: 3)
            ]]
            if pointer(a372) then
                v367[key] = os.clock()
            end
        end
    )
end

function v22.PressKind(a373, key)
    --[[
      name: PressKind
      line: 1106
      upvalues:
        guiService (copy, index: 1)
        v366 (copy, index: 2)
        v367 (copy, index: 3)
        v22 (copy, index: 4)
    ]]
    if typeof(a373) ~= "Instance" or not a373:IsA("InputObject") then
        if v22.Gamepad then
            return -1
        end

        return nil
    end

    local userInputType = a373.UserInputType

    if userInputType == Enum.UserInputType.Keyboard and key and guiService.SelectedObject ~= key then
        return nil
    end

    local v376 = key and v366[key]

    if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch or not v376 then
        return userInputType.Value
    end

    local v377 = v367[key]

    if v376 ~= -math.huge and (not (v376 <= v377) or not (3 < os.clock() - v377)) then
        return userInputType.Value
    end
    if userInputType == Enum.UserInputType.Touch then
        return -2
    end

    return nil
end

function v22.Button(options)
    --[[
      name: Button
      line: 1126
      upvalues:
        buttonStyles (copy, index: 1)
        v22 (copy, index: 2)
        fonts (copy, index: 3)
        colors (copy, index: 4)
        Signal (copy, index: 5)
        Theme (copy, index: 6)
        Sounds (copy, index: 7)
        Loc (copy, index: 8)
    ]]
    local v379
    local style = options.Style or "Primary"
    local v381 = buttonStyles[style] or buttonStyles.Primary
    local radius = options.Radius or 12
    local new = v22.new
    local v384 = {Selectable = true, Name = options.Name or "Button"}
    local v385 = options.Size or UDim2.fromOffset(220, 58)
    v384.Size = v385
    local v386 = options.Position or UDim2.new()
    v384.Position = v386
    v384.AnchorPoint = options.AnchorPoint or Vector2.zero
    v384.LayoutOrder = options.LayoutOrder or 0
    v384.ZIndex = options.ZIndex or 1
    v384.Visible = options.Visible ~= false
    local v387 = new("TextButton", v384)
    local parent = v22.new("Frame", {Name = "Scaler", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Parent = v387})
    local hoverScale = parent:FindFirstChild("HoverScale")

    if not hoverScale or not hoverScale:IsA("UIScale") then
        v379 = Instance.new("UIScale")
        v379.Name = "HoverScale"
        v379.Parent = parent
    else
        v379 = hoverScale
    end

    local v390 = v22.new("Frame", {Name = "Lip", BackgroundColor3 = v381.lip, Size = UDim2.new(1, 0, 1, -3), Position = UDim2.fromOffset(0, 3), (v22.Corner(radius)), Parent = parent})
    local v391 = v22.new("Frame", {Name = "Face", BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 1, -3), (v22.Corner(radius)), Parent = parent})
    local v392 = v22.Gradient(v381.top, v381.bottom, 90)
    v392.Parent = v391

    local v393 = v22.Stroke(v381.stroke, 1, 0.6)
    v393.Parent = v391
    local v394 = v22.new("Frame", {Name = "Glow", BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), (v22.Corner(radius)), Parent = v391})
    local v395 = v22.new("Frame", {Name = "Content", Size = UDim2.fromScale(1, 1), (v22.List(Enum.FillDirection.Horizontal, options.Gap
        or 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = v391})

    if options.Icon then
        options.Icon.LayoutOrder = 0
        options.Icon.Parent = v395
    end

    local new2 = v22.new
    local v397 = {Name = "Label", LayoutOrder = 1, Text = options.Text or "BUTTON", FontFace = options.Font
        or fonts.Display, TextSize = options.TextSize or 22, TextColor3 = v381.text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Parent = v395}
    local v398 = new2("TextLabel", v397)
    local v399 = v22.TextStroke(colors.Void, 1, 1)
    v399.Parent = v398
    local textSize = v398.TextSize
    local v401 = false

    local function setSize(size)
        --[[
          name: setSize
          line: 1208
          upvalues:
            v401 (ref,  index: 1)
            v398 (copy, index: 2)
        ]]
        v401 = true
        v398.TextSize = size
        v401 = false
    end

    v398:GetPropertyChangedSignal("TextSize"):Connect(
        function()
            --[[
              line: 1213
              upvalues:
                v401 (ref,  index: 1)
                textSize (ref,  index: 2)
                v398 (copy, index: 3)
            ]]
            if not v401 then
                textSize = v398.TextSize
            end
        end
    )

    local function fitLabel()
        --[[
          name: fitLabel
          line: 1218
          upvalues:
            v391 (copy, index: 1)
            options (copy, index: 2)
            v395 (copy, index: 3)
            v398 (copy, index: 4)
            textSize (ref,  index: 5)
            v401 (ref,  index: 6)
        ]]
        local v405 = v391.AbsoluteSize.X * 0.92
        local icon = options.Icon

        if icon and icon.Parent == v395 and icon.Visible then
            v405 -= icon.AbsoluteSize.X + (options.Gap or 8)
        end

        local x = v398.AbsoluteSize.X
        local flooredValue = math.floor(textSize * 0.6)

        if 1 < v405 and v405 + 0.5 < x and flooredValue < v398.TextSize then
            local textSize2 = math.max(flooredValue, (math.floor((v398.TextSize * v405) / x)))
            v401 = true
            v398.TextSize = textSize2
            v401 = false
        end
    end

    local function refit()
        --[[
          name: refit
          line: 1230
          upvalues:
            v398 (copy, index: 1)
            textSize (ref,  index: 2)
            v401 (ref,  index: 3)
            fitLabel (copy, index: 4)
        ]]
        if v398.TextSize ~= textSize then
            v401 = true
            v398.TextSize = textSize
            v401 = false
        end

        task.defer(fitLabel)
    end

    v398:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitLabel)
    v398:GetPropertyChangedSignal("Text"):Connect(refit)
    v391:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitLabel)
    local v411 = {Instance = v387, Face = v391, Label = v398, Content = v395, Activated = Signal.new(), Enabled = options.Enabled ~= false, Style = style}
    local v412 = false
    local v413 = false

    local function applyStyle()
        --[[
          name: applyStyle
          line: 1254
          upvalues:
            v411 (copy, index: 1)
            buttonStyles (copy, index: 2)
            v392 (copy, index: 3)
            v390 (copy, index: 4)
            v393 (copy, index: 5)
            v398 (copy, index: 6)
            v399 (copy, index: 7)
        ]]
        local v415 = not v411.Enabled and "Disabled" or v411.Style
        local v416 = buttonStyles[v415] or buttonStyles.Primary
        v392.Color = ColorSequence.new(v416.top, v416.bottom)
        v390.BackgroundColor3 = v416.lip
        v393.Color = v416.stroke
        v398.TextColor3 = v416.text
        v399.Transparency = 1
    end

    local function refresh()
        --[[
          name: refresh
          line: 1264
          upvalues:
            v413 (ref,  index: 1)
            v22 (copy, index: 2)
            v391 (copy, index: 3)
            Theme (copy, index: 4)
            v412 (ref,  index: 5)
            v411 (copy, index: 6)
            v379 (copy, index: 7)
            v394 (copy, index: 8)
        ]]
        local backgroundTransparency
        local v419 = v413 and 2 or 0
        v22.Tween(v391, Theme.Tween.Instant, {Position = UDim2.fromOffset(0, v419)})
        local scale = v413 and 0.96 or v412 and (v411.Enabled and 1.04 or 1) or 1
        v22.Tween(v379, Theme.Tween.PopSmall, {Scale = scale})
        local tween = v22.Tween
        local fast = Theme.Tween.Fast
        local v423 = {}

        if v412 and v411.Enabled then
            backgroundTransparency = 0.86
        else
            backgroundTransparency = 1
        end

        v423.BackgroundTransparency = backgroundTransparency
        tween(v394, fast, v423)
    end

    v387.MouseEnter:Connect(
        function()
            --[[
              line: 1272
              upvalues:
                v412 (ref,  index: 1)
                v411 (copy, index: 2)
                v22 (copy, index: 3)
                Sounds (copy, index: 4)
                refresh (copy, index: 5)
            ]]
            v412 = true

            if v411.Enabled and not v22.Touch then
                Sounds.Play("Hover")
            end

            refresh()
        end
    )

    v387.MouseLeave:Connect(
        function()
            --[[
              line: 1279
              upvalues:
                v412 (ref,  index: 1)
                v413 (ref,  index: 2)
                refresh (copy, index: 3)
            ]]
            v412 = false
            v413 = false
            refresh()
        end
    )

    v22.TrackPress(v387)

    v387.MouseButton1Down:Connect(
        function()
            --[[
              line: 1285
              upvalues:
                v413 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            v413 = true
            refresh()
        end
    )

    v387.MouseButton1Up:Connect(
        function()
            --[[
              line: 1289
              upvalues:
                v413 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            v413 = false
            refresh()
        end
    )

    v387.Activated:Connect(
        function(a424, a425)
            --[[
              line: 1293
              upvalues:
                v411 (copy, index: 1)
                Sounds (copy, index: 2)
                v22 (copy, index: 3)
                v387 (copy, index: 4)
                options (copy, index: 5)
            ]]
            if v411.Enabled then
                if options.Sound ~= false then
                    Sounds.Play((options.Sound or "Click"))
                end

                if options.PassInput then
                    v411.Activated:Fire(a424, a425)
                else
                    v411.Activated:Fire()
                end

                if options.OnClick then
                    task.spawn(options.OnClick)
                end
            else
                Sounds.Play("Error")
                v22.Shake(v387, 5)

                if options.OnDisabledClick then
                    task.spawn(options.OnDisabledClick)
                end
            end
        end
    )

    function v411.SetText(a426, text: string)
        --[[
          name: SetText
          line: 1315
          upvalues:
            v398 (copy, index: 1)
            Loc (copy, index: 2)
        ]]
        local v428 = v398.RichText and string.find(text, "<", 1, true) ~= nil
        v398.AutoLocalize = not v428
        v398.Text = if v428 then Loc.T(text) else text
    end

    function v411.SetEnabled(enabled2, enabled)
        --[[
          name: SetEnabled
          line: 1322
          upvalues:
            v411 (copy, index: 1)
            buttonStyles (copy, index: 2)
            v392 (copy, index: 3)
            v390 (copy, index: 4)
            v393 (copy, index: 5)
            v398 (copy, index: 6)
            v399 (copy, index: 7)
            refresh (copy, index: 8)
        ]]
        enabled2.Enabled = enabled
        local v431 = not v411.Enabled and "Disabled" or v411.Style
        local v432 = buttonStyles[v431] or buttonStyles.Primary
        v392.Color = ColorSequence.new(v432.top, v432.bottom)
        v390.BackgroundColor3 = v432.lip
        v393.Color = v432.stroke
        v398.TextColor3 = v432.text
        v399.Transparency = 1
        refresh()
    end

    function v411.SetStyle(style2, style)
        --[[
          name: SetStyle
          line: 1327
          upvalues:
            v411 (copy, index: 1)
            buttonStyles (copy, index: 2)
            v392 (copy, index: 3)
            v390 (copy, index: 4)
            v393 (copy, index: 5)
            v398 (copy, index: 6)
            v399 (copy, index: 7)
        ]]
        style2.Style = style
        local v435 = not v411.Enabled and "Disabled" or v411.Style
        local v436 = buttonStyles[v435] or buttonStyles.Primary
        v392.Color = ColorSequence.new(v436.top, v436.bottom)
        v390.BackgroundColor3 = v436.lip
        v393.Color = v436.stroke
        v398.TextColor3 = v436.text
        v399.Transparency = 1
    end

    local v437 = not v411.Enabled and "Disabled" or v411.Style
    local v438 = buttonStyles[v437] or buttonStyles.Primary
    v392.Color = ColorSequence.new(v438.top, v438.bottom)
    v390.BackgroundColor3 = v438.lip
    v393.Color = v438.stroke
    v398.TextColor3 = v438.text
    v399.Transparency = 1

    if options.Parent then
        v387.Parent = options.Parent
    end

    return v411
end

function v22.IconButton(options)
    --[[
      name: IconButton
      line: 1339
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
        fonts (copy, index: 3)
        Sounds (copy, index: 4)
        Theme (copy, index: 5)
    ]]
    local v440
    local v441 = options.Size or UDim2.fromOffset(44, 44)
    local new = v22.new
    local v443 = {Name = options.Name or "IconButton", Size = v441}
    local v444 = options.Position or UDim2.new()
    v443.Position = v444
    v443.AnchorPoint = options.AnchorPoint or Vector2.zero
    v443.BackgroundColor3 = options.Color or colors.Raised
    v443.BackgroundTransparency = options.Transparency or 0.1
    v443.Text = options.IconName and "" or options.Text or ""
    v443.TextColor3 = options.TextColor or colors.Text
    v443.FontFace = options.Font or fonts.Display
    v443.TextSize = options.TextSize or 26
    v443.ZIndex = options.ZIndex or 1
    v443.LayoutOrder = options.LayoutOrder or 0
    v443.Visible = options.Visible ~= false
    v443[1] = (v22.Corner((options.Radius or 10)))
    v443.Parent = options.Parent
    local parent = new("TextButton", v443)
    local stroke = v22.Stroke
    local v447 = options.StrokeColor or colors.Stroke
    stroke(v447, 1, (options.StrokeTransparency or 0.85)).Parent = parent

    if options.IconName then
        local flooredValue = math.floor(v441.Y.Offset * (options.IconScale or 0.5))
        v22.Icon(options.IconName, flooredValue, (options.TextColor or colors.Text), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), ZIndex = options.ZIndex, Parent = parent})
    end

    local hoverScale = parent:FindFirstChild("HoverScale")

    if not hoverScale or not hoverScale:IsA("UIScale") then
        v440 = Instance.new("UIScale")
        v440.Name = "HoverScale"
        v440.Parent = parent
    else
        v440 = hoverScale
    end

    local backgroundColor3 = parent.BackgroundColor3

    parent.MouseEnter:Connect(
        function()
            --[[
              line: 1370
              upvalues:
                v22 (copy, index: 1)
                Sounds (copy, index: 2)
                v440 (copy, index: 3)
                Theme (copy, index: 4)
                parent (copy, index: 5)
                options (copy, index: 6)
                backgroundColor3 (copy, index: 7)
            ]]
            if not v22.Touch then
                Sounds.Play("Hover")
            end

            v22.Tween(v440, Theme.Tween.PopSmall, {Scale = 1.08})
            local tween = v22.Tween
            local fast = Theme.Tween.Fast
            local v453 = {}
            local v454 = options.HoverColor or Theme.Lighten(backgroundColor3, 0.15)
            v453.BackgroundColor3 = v454
            tween(parent, fast, v453)
        end
    )

    parent.MouseLeave:Connect(
        function()
            --[[
              line: 1377
              upvalues:
                v22 (copy, index: 1)
                v440 (copy, index: 2)
                Theme (copy, index: 3)
                parent (copy, index: 4)
                backgroundColor3 (copy, index: 5)
            ]]
            v22.Tween(v440, Theme.Tween.PopSmall, {Scale = 1})
            v22.Tween(parent, Theme.Tween.Fast, {BackgroundColor3 = backgroundColor3})
        end
    )

    parent.MouseButton1Down:Connect(
        function()
            --[[
              line: 1381
              upvalues:
                v22 (copy, index: 1)
                v440 (copy, index: 2)
                Theme (copy, index: 3)
            ]]
            v22.Tween(v440, Theme.Tween.Instant, {Scale = 0.9})
        end
    )
    parent.MouseButton1Up:Connect(
        function()
            --[[
              line: 1384
              upvalues:
                v22 (copy, index: 1)
                v440 (copy, index: 2)
                Theme (copy, index: 3)
            ]]
            v22.Tween(v440, Theme.Tween.PopSmall, {Scale = 1})
        end
    )

    parent.Activated:Connect(
        function()
            --[[
              line: 1387
              upvalues:
                options (copy, index: 1)
                Sounds (copy, index: 2)
            ]]
            if options.Sound ~= false then
                Sounds.Play((options.Sound or "Click"))
            end

            if options.OnClick then
                task.spawn(options.OnClick)
            end
        end
    )

    return parent
end

local backgroundColor3 = Color3.fromRGB(58, 63, 78)

function v22.Switch(options)
    --[[
      name: Switch
      line: 1407
      upvalues:
        v22 (copy, index: 1)
        backgroundColor3 (copy, index: 2)
        Theme (copy, index: 3)
        colors (copy, index: 4)
    ]]
    local v457 = options or {}
    local width = v457.Width or 60
    local v459 = v457.Height or math.floor((width * 0.53) + 0.5)
    local v460 = math.max(3, (math.floor((v459 * 0.12) + 0.5)))
    local v461 = v459 - v460 * 2
    local new = v22.new
    local v463 = {Name = v457.Name or "Switch", Size = UDim2.fromOffset(width, v459)}
    local v464 = v457.Position or UDim2.new()
    v463.Position = v464
    v463.AnchorPoint = v457.AnchorPoint or Vector2.zero
    v463.LayoutOrder = v457.LayoutOrder or 0
    v463.ZIndex = v457.ZIndex or 1
    v463.BackgroundColor3 = backgroundColor3
    v463[1] = (v22.Corner(Theme.Radius.Pill))
    v463.Parent = v457.Parent
    local v465 = new("Frame", v463)
    local v466 = v22.Stroke(colors.Stroke, 1, 0.88)
    v466.Parent = v465
    local parent = v22.new("Frame", {Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, v460, 0.5, 0), Size = UDim2.fromOffset(v461, v461), BackgroundColor3 = colors.Bone, ZIndex = (v457.ZIndex
        or 1) + 1, v22.Corner(Theme.Radius.Pill), (v22.Stroke(colors.Void, 1, 0.8)), Parent = v465})
    local v468 = v22.Icon("check", math.floor(v461 * 0.56), colors.AccentDark, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Thickness = math.max(2, (math.floor((v461 * 0.12) + 0.5))), ZIndex = (v457.ZIndex
        or 1) + 2, Parent = parent})
    v468.Visible = false
    local v469 = {
        On = false,
        Instance = v465,
        Set = (function(a470, a471, a472)
            --[[
              name: Set
              line: 1446
              upvalues:
                v460 (copy, index: 1)
                v461 (copy, index: 2)
                colors (copy, index: 3)
                backgroundColor3 (copy, index: 4)
                parent (copy, index: 5)
                v465 (copy, index: 6)
                v466 (copy, index: 7)
                v468 (copy, index: 8)
                v22 (copy, index: 9)
                Theme (copy, index: 10)
            ]]
            local v473 = a471 ~= a470.On
            a470.On = a471
            local position = if a471 then UDim2.new(1, -(v460 + v461), 0.5, 0) else UDim2.new(0, v460, 0.5, 0)
            local v475 = if a471 then colors.Accent else backgroundColor3
            local transparency = a471 and 0.7 or 0.88

            if a472 then
                parent.Position = position
                v465.BackgroundColor3 = v475
                v466.Transparency = transparency
                v468.Visible = a471

                return
            end

            v22.Tween(parent, Theme.Tween.Smooth, {Position = position})
            v22.Tween(v465, Theme.Tween.Fast, {BackgroundColor3 = v475})
            v22.Tween(v466, Theme.Tween.Fast, {Transparency = transparency})
            v468.Visible = a471

            if a471 and v473 then
                v22.Pop(v468, 0.4, Theme.Tween.PopSmall)
            end
        end)
    }
    v469:Set(v457.On == true, true)

    return v469
end

function v22.Segmented(options)
    --[[
      name: Segmented
      line: 1485
      upvalues:
        v22 (copy, index: 1)
        backgroundColor3 (copy, index: 2)
        Theme (copy, index: 3)
        colors (copy, index: 4)
        fonts (copy, index: 5)
    ]]
    local v478 = options.Options or {}
    local v479 = math.max(#v478, 1)
    local width = options.Width or 132
    local height = options.Height or 36
    local zIndex = options.ZIndex or 1
    local new = v22.new
    local v484 = {Name = options.Name or "Segmented", Size = UDim2.fromOffset(width, height)}
    local v485 = options.Position or UDim2.new()
    v484.Position = v485
    v484.AnchorPoint = options.AnchorPoint or Vector2.zero
    v484.LayoutOrder = options.LayoutOrder or 0
    v484.ZIndex = zIndex
    v484.Visible = options.Visible ~= false
    v484.BackgroundColor3 = backgroundColor3
    v484[1] = (v22.Corner(Theme.Radius.Pill))
    v484.Parent = options.Parent
    local v486 = new("Frame", v484)
    v22.Stroke(colors.Stroke, 1, 0.88).Parent = v486
    local v487 = (width - 6) / v479
    local v488 = v22.new("Frame", {Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(v487, height - 6), BackgroundColor3 = colors.Accent, ZIndex = zIndex + 1, v22.Corner(Theme.Radius.Pill), (v22.Stroke(colors.Void, 1, 0.8)), Parent = v486})
    local v489 = {Value = "", Enabled = true, Instance = v486, Buttons = {}}
    local v490 = {}
    local text = nil

    local function paintLabels()
        --[[
          name: paintLabels
          line: 1520
          upvalues:
            v490 (copy, index: 1)
            v489 (copy, index: 2)
            colors (copy, index: 3)
            text (ref,  index: 4)
        ]]
        for v493, v494 in v490 do
            local v495
            local v496 = v493 == v489.Value

            if v496 then
                v495 = colors.Text
            else
                v495 = if text == v493 and v489.Enabled then colors.Text else colors.TextDim
            end

            v494.TextColor3 = v495
            v494.TextTransparency = not v489.Enabled and not v496 and 0.3 or 0
        end
    end

    for v497, v498 in v478 do
        local text2 = tostring(v498.id)
        local parent = v22.new("TextButton", {Name = "Option_" .. text2, Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.new(0, 3 + ((v497 - 1) * v487), 0, 0), Size = UDim2.new(0, v487, 1, 0), ZIndex = zIndex + 2, (v22.Corner(Theme.Radius.Pill)), Parent = v486})
        local new2 = v22.new
        local v502 = {Name = "Label", Size = UDim2.fromScale(1, 1), Text = tostring((v498.text or text2)), FontFace = fonts.Heavy}
        local v503 = options.TextSize or math.floor((height * 0.47) + 0.5)
        v502.TextSize = v503
        v502.TextColor3 = colors.TextDim
        v502.ZIndex = zIndex + 3
        v502.Parent = parent
        v490[text2] = new2("TextLabel", v502)
        v489.Buttons[text2] = parent

        parent.MouseEnter:Connect(
            function()
                --[[
                  line: 1551
                  upvalues:
                    v22 (copy, index: 1)
                    text (ref,  index: 2)
                    text2 (copy, index: 3)
                    paintLabels (copy, index: 4)
                ]]
                if not v22.Touch then
                    text = text2
                    paintLabels()
                end
            end
        )

        parent.MouseLeave:Connect(
            function()
                --[[
                  line: 1557
                  upvalues:
                    text (ref,  index: 1)
                    text2 (copy, index: 2)
                    paintLabels (copy, index: 3)
                ]]
                if text == text2 then
                    text = nil
                    paintLabels()
                end
            end
        )

        parent.Activated:Connect(
            function()
                --[[
                  line: 1563
                  upvalues:
                    v489 (copy, index: 1)
                    text2 (copy, index: 2)
                    options (copy, index: 3)
                ]]
                if v489.Enabled and text2 ~= v489.Value and options.OnSelect then
                    options.OnSelect(text2)
                end
            end
        )
    end

    function v489.Set(a504, value, a506)
        --[[
          name: Set
          line: 1569
          upvalues:
            v478 (copy, index: 1)
            v487 (copy, index: 2)
            v488 (copy, index: 3)
            v22 (copy, index: 4)
            Theme (copy, index: 5)
            v490 (copy, index: 6)
            paintLabels (copy, index: 7)
        ]]
        local v507 = 1

        for v508, v509 in v478 do
            if tostring(v509.id) == value then
                v507 = v508
            end
        end

        local v510 = value ~= a504.Value
        a504.Value = value
        local position = UDim2.new(0, 3 + ((v507 - 1) * v487), 0.5, 0)

        if a506 then
            v488.Position = position
        else
            v22.Tween(v488, Theme.Tween.Smooth, {Position = position})

            if v510 then
                if const v512 = v490[value] then
                    v22.Pop(v512, 0.85, Theme.Tween.PopSmall)
                end
            end
        end

        paintLabels()
    end

    function v489.SetEnabled(enabled, a514)
        --[[
          name: SetEnabled
          line: 1592
          upvalues:
            v488 (copy, index: 1)
            paintLabels (copy, index: 2)
        ]]
        enabled.Enabled = a514

        for _, button in enabled.Buttons do
            button.Selectable = a514
        end

        v488.BackgroundTransparency = a514 and 0 or 0.35
        paintLabels()
    end

    local v517 = options.Selected or v478[1] and v478[1].id or ""
    v489:Set(tostring(v517), true)

    return v489
end

local v518 = {}
local v519 = {}
local v520 = {}
local capVisible = nil

v22.TouchChanged:Connect(
    function()
        --[[
          line: 1611
          upvalues:
            v518 (copy, index: 1)
            capVisible (ref,  index: 2)
        ]]
        for v522 in v518 do
            v522.Visible = capVisible(v522)
        end
    end
)

local v523 = {}

local function lastIsGamepad()
    --[[
      name: lastIsGamepad
      line: 1617
      upvalues:
        v22 (copy, index: 1)
    ]]
    return v22.Gamepad
end

local v525 = {}
v525[Enum.KeyCode.ButtonSelect] = "VIEW"
v525[Enum.KeyCode.ButtonStart] = "MENU"
v525[Enum.KeyCode.ButtonA] = "A"
v525[Enum.KeyCode.ButtonB] = "B"
v525[Enum.KeyCode.ButtonX] = "X"
v525[Enum.KeyCode.ButtonY] = "Y"
v525[Enum.KeyCode.ButtonL1] = "LB"
v525[Enum.KeyCode.ButtonR1] = "RB"
v525[Enum.KeyCode.ButtonL2] = "LT"
v525[Enum.KeyCode.ButtonR2] = "RT"
v525[Enum.KeyCode.ButtonL3] = "LS"
v525[Enum.KeyCode.ButtonR3] = "RS"
local v526 = {}
local v527 = {}
local v528 = {}

local function setCapBare(capBare, value)
    --[[
      name: setCapBare
      line: 1635
      upvalues:
        v527 (copy, index: 1)
        v526 (copy, index: 2)
        v528 (copy, index: 3)
    ]]
    v527[capBare] = value
    local v532 = value and 1 or v526[capBare] or 0.25
    capBare.BackgroundTransparency = v532 + ((1 - v532) * (v528[capBare] or 0))

    if const uiStroke = capBare:FindFirstChildOfClass("UIStroke") then
        uiStroke.Enabled = not value
    end
end

local function paintPadCap(key2, a536)
    --[[
      name: paintPadCap
      line: 1644
      upvalues:
        v22 (copy, index: 1)
        userInputService (copy, index: 2)
        v525 (copy, index: 3)
        v527 (copy, index: 4)
        v526 (copy, index: 5)
        v528 (copy, index: 6)
    ]]
    local key = key2:FindFirstChild("Key")
    local glyph = key2:FindFirstChild("Glyph")
    local mouse = key2:FindFirstChild("Mouse")

    if not key or not glyph then
        return
    end

    local v540
    local image = ""

    if v22.Gamepad then
        local success, imageForKeyCode = pcall(
            function()
                --[[
                  line: 1653
                  upvalues:
                    userInputService (copy, index: 1)
                    a536 (copy, index: 2)
                ]]
                return userInputService:GetImageForKeyCode(a536.code)
            end
        )

        if not success or type(imageForKeyCode) ~= "string" then
            image = ""
        else
            image = imageForKeyCode
        end

        if image == "" then
            key.Text = v525[a536.code] or a536.code.Name
        end
    else
        key.Text = a536.key
    end

    glyph.Image = image
    glyph.Visible = image ~= ""
    local visible = mouse ~= nil and image == ""

    if mouse then
        mouse.Visible = visible
    end

    key.Visible = image == "" and not visible
    local v545 = true
    local v546 = if image == "" then visible else v545
    v527[key2] = v546
    local v547 = v546 and 1 or v526[key2] or 0.25
    key2.BackgroundTransparency = v547 + ((1 - v547) * (v528[key2] or 0))

    if const uiStroke = key2:FindFirstChildOfClass("UIStroke") then
        uiStroke.Enabled = not v546
    end

    local offset = key2.Size.Y.Offset
    local udim2FromOffset = UDim2.fromOffset

    if image == "" then
        v540 = if visible then offset else math.max(offset, (#key.Text * (offset * 0.4)) + 12)
    else
        v540 = offset + 4
    end

    key2.Size = udim2FromOffset(v540, offset)
end

local function mouseImageFor(a552)
    --[[
      name: mouseImageFor
      line: 1680
      upvalues:
        v1 (ref, index: 1)
    ]]
    local mouse = v1.Mouse

    if type(mouse) ~= "table" then
        return nil
    end
    if a552 == "M1" then
        return mouse.Left
    end
    if a552 == "M2" then
        return mouse.Right
    end

    return nil
end

capVisible = function(key)
    --[[
      name: capVisible
      line: 1694
      upvalues:
        v22 (copy, index: 1)
        v523 (copy, index: 2)
        v520 (copy, index: 3)
        v519 (copy, index: 4)
    ]]
    if v22.Touch then
        return false
    end
    if v523[key] == nil then
        return not v519[key] and not v22.Gamepad
    end
    if v22.Gamepad then
        return not v520[key]
    end

    return not v519[key]
end

v22.GamepadChanged:Connect(
    function()
        --[[
          line: 1706
          upvalues:
            v523 (copy, index: 1)
            paintPadCap (copy, index: 2)
            v518 (copy, index: 3)
            capVisible (ref,  index: 4)
        ]]
        for key, v556 in v523 do
            paintPadCap(key, v556)
        end

        for v557 in v518 do
            v557.Visible = capVisible(v557)
        end
    end
)

function v22.KeyCap(a558, options)
    --[[
      name: KeyCap
      line: 1714
      upvalues:
        v1 (ref,  index: 1)
        v22 (copy, index: 2)
        colors (copy, index: 3)
        v526 (copy, index: 4)
        v527 (copy, index: 5)
        v528 (copy, index: 6)
        fonts (copy, index: 7)
        v518 (copy, index: 8)
        v523 (copy, index: 9)
        paintPadCap (copy, index: 10)
        capVisible (ref,  index: 11)
    ]]
    local v560
    local v561 = options or {}
    local height = v561.Height or 24
    local mouse = v1.Mouse

    if type(mouse) == "table" then
        if a558 ~= "M1" then
            v560 = if a558 == "M2" then mouse.Right else nil
        else
            v560 = mouse.Left
        end
    else
        v560 = nil
    end

    local new = v22.new
    local v565 = {Name = "KeyCap", Visible = not v22.Touch}
    local udim2FromOffset = UDim2.fromOffset
    local v567 = if v560 then height else math.max(height, (#a558 * (height * 0.4)) + 12)
    v565.Size = udim2FromOffset(v567, height)
    v565.BackgroundColor3 = v561.Color or colors.Void
    v565.BackgroundTransparency = v561.Transparency or 0.25
    local v568 = v561.Position or UDim2.new()
    v565.Position = v568
    v565.AnchorPoint = v561.AnchorPoint or Vector2.zero
    v565.LayoutOrder = v561.LayoutOrder or 0
    v565.ZIndex = v561.ZIndex or 1
    v565[1], v565[2] = v22.Corner((v561.Radius or 6)), (v22.Stroke(colors.Stroke, 1, 0.75))
    v565.Parent = v561.Parent
    local parent = new("Frame", v565)
    v526[parent] = v561.Transparency or 0.25

    parent.Destroying:Connect(
        function()
            --[[
              line: 1733
              upvalues:
                v526 (copy, index: 1)
                parent (copy, index: 2)
                v527 (copy, index: 3)
                v528 (copy, index: 4)
            ]]
            v526[parent] = nil
            v527[parent] = nil
            v528[parent] = nil
        end
    )

    local new2 = v22.new
    local v571 = {Name = "Key", AutoLocalize = false, Text = a558, FontFace = fonts.Heavy}
    local v572 = v561.TextSize or math.floor(height * 0.66)
    v571.TextSize = v572
    v571.TextColor3 = colors.Text
    v571.Size = UDim2.fromScale(1, 1)
    v571.ZIndex = v561.ZIndex or 1
    v571.Parent = parent
    new2("TextLabel", v571)

    if v560 then
        v22.new("ImageLabel", {Name = "Mouse", BackgroundTransparency = 1, Image = v560, Size = UDim2.fromOffset(height + 10, height + 10), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = v561.ZIndex
            or 1, Parent = parent})
        parent:FindFirstChild("Key").Visible = false
        v527[parent] = true
        parent.BackgroundTransparency = 1 + (0 * (v528[parent] or 0))

        if const uiStroke = parent:FindFirstChildOfClass("UIStroke") then
            uiStroke.Enabled = false
        end
    end

    if not v561.Managed then
        v518[parent] = true
        parent.Destroying:Connect(
            function()
                --[[
                  line: 1766
                  upvalues:
                    v518 (copy, index: 1)
                    parent (copy, index: 2)
                ]]
                v518[parent] = nil
            end
        )
    end

    if typeof(v561.Gamepad) ~= "EnumItem" then
        if not v561.Managed then
            parent.Visible = capVisible(parent)
        end
    else
        v22.new("ImageLabel", {Name = "Glyph", BackgroundTransparency = 1, Visible = false, Size = UDim2.new(1, 4, 1, 4), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = v561.ZIndex
            or 1, Parent = parent})
        local v574 = {key = a558, code = v561.Gamepad, width = parent.Size.X.Offset}
        v523[parent] = v574
        parent.Destroying:Connect(
            function()
                --[[
                  line: 1784
                  upvalues:
                    v523 (copy, index: 1)
                    parent (copy, index: 2)
                ]]
                v523[parent] = nil
            end
        )
        paintPadCap(parent, v574)
    end

    return parent
end

function v22.SetCapKey(capKey, a576)
    --[[
      name: SetCapKey
      line: 1796
      upvalues:
        v519 (copy, index: 1)
        capVisible (ref,  index: 2)
        v1 (ref,  index: 3)
        v22 (copy, index: 4)
        v528 (copy, index: 5)
        v523 (copy, index: 6)
        paintPadCap (copy, index: 7)
        v527 (copy, index: 8)
        v526 (copy, index: 9)
    ]]
    local v577

    if a576 == nil then
        v519[capKey] = true
        capKey.Visible = capVisible(capKey)

        return
    end

    if v519[capKey] then
        v519[capKey] = nil
        capKey.Visible = capVisible(capKey)
    end

    local offset = capKey.Size.Y.Offset
    local key = capKey:FindFirstChild("Key")
    local mouse = v1.Mouse

    if type(mouse) == "table" then
        if a576 ~= "M1" then
            v577 = if a576 == "M2" then mouse.Right else nil
        else
            v577 = mouse.Left
        end
    else
        v577 = nil
    end

    local v581 = capKey:FindFirstChild("Mouse")

    if v577 then
        v581 = v581
            or v22.new("ImageLabel", {Name = "Mouse", BackgroundTransparency = 1, ImageTransparency = v528[capKey] or 0, Size = UDim2.fromOffset(offset + 10, offset + 10), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = capKey.ZIndex, Parent = capKey})
        v581.Image = v577
    elseif v581 then
        v581:Destroy()
    end

    if key then
        key.Text = a576
    end

    if const v582 = v523[capKey] then
        v582.key = a576
        paintPadCap(capKey, v582)

        return
    end

    if key then
        key.Visible = v577 == nil
    end

    local v583 = v577 ~= nil
    v527[capKey] = v583
    local v584 = v583 and 1 or v526[capKey] or 0.25
    capKey.BackgroundTransparency = v584 + ((1 - v584) * (v528[capKey] or 0))

    if const uiStroke = capKey:FindFirstChildOfClass("UIStroke") then
        uiStroke.Enabled = not v583
    end

    local udim2FromOffset = UDim2.fromOffset
    local v587 = if v577 then offset else math.max(offset, (#a576 * (offset * 0.4)) + 12)
    capKey.Size = udim2FromOffset(v587, offset)
end

function v22.PadCap(gamepad, a589)
    --[[
      name: PadCap
      line: 1846
      upvalues:
        v22 (copy, index: 1)
    ]]
    local values = table.clone(a589 or {})
    values.Gamepad = gamepad
    local v591 = v22.KeyCap("", values)
    v22.SetCapKey(v591, nil)

    return v591
end

function v22.SetCapFade(capFade, a593: number)
    --[[
      name: SetCapFade
      line: 1857
      upvalues:
        v528 (copy, index: 1)
        v527 (copy, index: 2)
        v526 (copy, index: 3)
    ]]
    local clampedValue
    local clampedValue2 = math.clamp(a593, 0, 1)

    if not (0 < clampedValue2) then
        clampedValue = nil
    else
        clampedValue = clampedValue2
    end

    v528[capFade] = clampedValue
    local v596 = v527[capFade] == true
    v527[capFade] = v596
    local v597 = v596 and 1 or v526[capFade] or 0.25
    capFade.BackgroundTransparency = v597 + ((1 - v597) * (v528[capFade] or 0))

    if const uiStroke = capFade:FindFirstChildOfClass("UIStroke") then
        uiStroke.Enabled = not v596
    end

    if const uiStroke2 = capFade:FindFirstChildOfClass("UIStroke") then
        uiStroke2.Transparency = (clampedValue2 * 0.25) + 0.75
    end

    for _, child in capFade:GetChildren() do
        if child:IsA("TextLabel") then
            child.TextTransparency = clampedValue2
        elseif child:IsA("ImageLabel") then
            child.ImageTransparency = clampedValue2
        end
    end
end

function v22.SetCapPad(capPad, code)
    --[[
      name: SetCapPad
      line: 1876
      upvalues:
        v523 (copy, index: 1)
        v520 (copy, index: 2)
        paintPadCap (copy, index: 3)
        capVisible (ref,  index: 4)
    ]]
    local v604 = v523[capPad]
    if not v604 then
        return
    end

    v520[capPad] = not code or nil

    if code then
        v604.code = code
    end

    paintPadCap(capPad, v604)
    capPad.Visible = capVisible(capPad)
end

function v22.ActionCap(target, a606)
    --[[
      name: ActionCap
      line: 1892
      upvalues:
        Keybinds (copy, index: 1)
        v22 (copy, index: 2)
        v519 (copy, index: 3)
        v520 (copy, index: 4)
    ]]
    local v607
    local v608 = Keybinds.PadAction(target) ~= nil

    if v608 then
        v607 = table.clone(a606 or {})
        local v609 = Keybinds.PadCode(target) or v607.Gamepad or Enum.KeyCode.ButtonA
        v607.Gamepad = v609
    else
        v607 = a606
    end

    local v610 = v22.KeyCap((Keybinds.CapText(target) or "?"), v607)
    v22.SetCapKey(v610, Keybinds.CapText(target))

    if v608 then
        v22.SetCapPad(v610, Keybinds.PadCode(target))
    end

    local v611 = Keybinds.Changed:Connect(
        function(a612)
            --[[
              line: 1904
              upvalues:
                target (copy, index: 1)
                v22 (copy, index: 2)
                v610 (copy, index: 3)
                Keybinds (copy, index: 4)
            ]]
            if table.find(a612, target) then
                v22.SetCapKey(v610, Keybinds.CapText(target))
            end
        end
    )

    local v613 = if v608
        then Keybinds.PadChanged:Connect(
            function(a614)
                --[[
                  line: 1910
                  upvalues:
                    target (copy, index: 1)
                    v22 (copy, index: 2)
                    v610 (copy, index: 3)
                    Keybinds (copy, index: 4)
                ]]
                if table.find(a614, target) then
                    v22.SetCapPad(v610, Keybinds.PadCode(target))
                end
            end
        )
        else nil

    v610.Destroying:Connect(
        function()
            --[[
              line: 1916
              upvalues:
                v611 (copy, index: 1)
                v613 (copy, index: 2)
                v519 (copy, index: 3)
                v610 (copy, index: 4)
                v520 (copy, index: 5)
            ]]
            v611:Disconnect()

            if v613 then
                v613:Disconnect()
            end

            v519[v610] = nil
            v520[v610] = nil
        end
    )

    return v610
end

function v22.CapInfo(key)
    --[[
      name: CapInfo
      line: 1928
      upvalues:
        v523 (copy, index: 1)
        v518 (copy, index: 2)
        v520 (copy, index: 3)
        v519 (copy, index: 4)
    ]]
    local v616
    local v617 = v523[key]

    if not v617 and not v518[key] then
        return nil
    end

    local glyph = key:FindFirstChild("Glyph")
    local v619 = {}

    if v617 then
        v616 = v617.key
    else
        v616 = key:FindFirstChild("Key") and key:FindFirstChild("Key").Text
    end

    v619.key = v616
    v619.pad = if v617 then v617.code.Name else false
    v619.padUnbound = v520[key] == true
    v619.unbound = v519[key] == true
    v619.visible = key.Visible
    v619.glyph = if glyph and glyph.Visible then glyph.Image else false

    return v619
end

function v22.PadActionCap(target, a621)
    --[[
      name: PadActionCap
      line: 1946
      upvalues:
        v22 (copy, index: 1)
        Keybinds (copy, index: 2)
        v520 (copy, index: 3)
    ]]
    local v622 = v22.PadCap((Keybinds.PadCode(target) or Enum.KeyCode.ButtonA), a621)
    v22.SetCapPad(v622, Keybinds.PadCode(target))

    local v623 = Keybinds.PadChanged:Connect(
        function(a624)
            --[[
              line: 1949
              upvalues:
                target (copy, index: 1)
                v22 (copy, index: 2)
                v622 (copy, index: 3)
                Keybinds (copy, index: 4)
            ]]
            if table.find(a624, target) then
                v22.SetCapPad(v622, Keybinds.PadCode(target))
            end
        end
    )

    v622.Destroying:Connect(
        function()
            --[[
              line: 1954
              upvalues:
                v623 (copy, index: 1)
                v520 (copy, index: 2)
                v622 (copy, index: 3)
            ]]
            v623:Disconnect()
            v520[v622] = nil
        end
    )

    return v622
end

function v22.Pill(text: string, backgroundColor3, options)
    --[[
      name: Pill
      line: 1962
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
        fonts (copy, index: 3)
        colors (copy, index: 4)
    ]]
    local v628 = options or {}
    local new = v22.new
    local v630 = {Name = v628.Name or "Pill", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, (v628.Height
        or 22))}
    local v631 = v628.Position or UDim2.new()
    v630.Position = v631
    v630.AnchorPoint = v628.AnchorPoint or Vector2.zero
    v630.BackgroundColor3 = backgroundColor3
    v630.BackgroundTransparency = v628.Transparency or 0.1
    v630.LayoutOrder = v628.LayoutOrder or 0
    v630.ZIndex = v628.ZIndex or 1
    v630[1], v630[2] = v22.Corner(Theme.Radius.Pill), (v22.Padding(0, v628.PadX or 9, 0, (v628.PadX or 9)))
    v630.Parent = v628.Parent
    local parent = new("Frame", v630)
    local new2 = v22.new
    local v634 = {Name = "Text", Text = string.upper(text), AutoLocalize = v628.AutoLocalize ~= false, FontFace = v628.Font
        or fonts.Heavy, TextSize = v628.TextSize or 14, TextColor3 = v628.TextColor or colors.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), ZIndex = v628.ZIndex
        or 1, Parent = parent}
    new2("TextLabel", v634)

    return parent
end

function v22.LevelBadge(a635, a636: number, options)
    --[[
      name: LevelBadge
      line: 1994
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
        colors (copy, index: 3)
        fonts (copy, index: 4)
    ]]
    local v638
    local v639 = options or {}
    local new = v22.new
    local v641 = {Name = "LevelBadge", Size = UDim2.fromOffset(a636, a636)}
    local v642 = v639.Position or UDim2.new()
    v641.Position = v642
    v641.AnchorPoint = v639.AnchorPoint or Vector2.zero
    v641.LayoutOrder = v639.LayoutOrder or 0
    v641.ZIndex = v639.ZIndex or 1
    v641.Parent = v639.Parent
    local parent = new("Frame", v641)
    v22.new("Frame", {Name = "Disc", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.86, 0.86), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = v639.ZIndex
        or 1, v22.Corner(Theme.Radius.Pill), v22.Gradient(Theme.Lighten(colors.Accent, 0.12), colors.AccentDark, 90), (v22.Stroke(colors.Stroke, 1, 0.75)), Parent = parent})
    local new2 = v22.new
    local v645 = {Name = "Level", Size = UDim2.fromScale(1, 1), Text = tostring(a635), FontFace = fonts.Display}

    if not (100 <= a635) then
        v638 = 0.42
    else
        v638 = 0.34
    end

    v645.TextSize = math.floor(a636 * v638)
    v645.TextColor3 = colors.Text
    v645.ZIndex = (v639.ZIndex or 1) + 1
    v645.Parent = parent

    return parent, (new2("TextLabel", v645))
end

local function line(parent, a648: number, vector2: Vector2, vector22: Vector2, a651, backgroundColor3, zIndex)
    --[[
      name: line
      line: 2035
      upvalues:
        v22 (copy, index: 1)
        Theme (copy, index: 2)
    ]]
    local vector23 = vector2 * a648
    local vector24 = vector22 * a648
    local vector25 = (vector23 + vector24) / 2
    local vector26 = vector24 - vector23
    v22.new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(vector25.X, vector25.Y), Size = UDim2.fromOffset(vector26.Magnitude + a651, a651), Rotation = math.deg((math.atan2(vector26.Y, vector26.X))), BackgroundColor3 = backgroundColor3, ZIndex = zIndex
        or 1, (v22.Corner(Theme.Radius.Pill)), Parent = parent})
end

function v22.Icon(a658, a659: number, a660, options)
    --[[
      name: Icon
      line: 2052
      upvalues:
        colors (copy, index: 1)
        v22 (copy, index: 2)
        line (copy, index: 3)
        Theme (copy, index: 4)
    ]]
    local v662 = options or {}
    local v663 = a660 or colors.Text
    local v664 = v662.Thickness or math.max(2, (math.floor(a659 * 0.16 + 0.5)))
    local zIndex = v662.ZIndex or 1
    local new = v22.new
    local v667 = {Name = "Icon_" .. a658, Size = UDim2.fromOffset(a659, a659)}
    local v668 = v662.Position or UDim2.new()
    v667.Position = v668
    v667.AnchorPoint = v662.AnchorPoint or Vector2.zero
    v667.LayoutOrder = v662.LayoutOrder or 0
    v667.ZIndex = zIndex
    v667.Parent = v662.Parent
    local parent = new("Frame", v667)
    local newVector2 = Vector2.new

    if a658 == "cross" then
        line(parent, a659, newVector2(0.2, 0.2), newVector2(0.8, 0.8), v664, v663, zIndex)
        line(parent, a659, newVector2(0.8, 0.2), newVector2(0.2, 0.8), v664, v663, zIndex)

        return parent
    end

    if a658 == "check" then
        line(parent, a659, newVector2(0.18, 0.52), newVector2(0.42, 0.76), v664, v663, zIndex)
        line(parent, a659, newVector2(0.42, 0.76), newVector2(0.84, 0.26), v664, v663, zIndex)

        return parent
    end

    if a658 == "minus" then
        line(parent, a659, newVector2(0.18, 0.5), newVector2(0.82, 0.5), v664, v663, zIndex)
        return parent
    end

    if a658 == "plus" then
        line(parent, a659, newVector2(0.5, 0.16), newVector2(0.5, 0.84), v664, v663, zIndex)
        line(parent, a659, newVector2(0.16, 0.5), newVector2(0.84, 0.5), v664, v663, zIndex)

        return parent
    end

    if a658 == "chevLeft" then
        line(parent, a659, newVector2(0.64, 0.2), newVector2(0.34, 0.5), v664, v663, zIndex)
        line(parent, a659, newVector2(0.34, 0.5), newVector2(0.64, 0.8), v664, v663, zIndex)

        return parent
    end

    if a658 == "chevRight" then
        line(parent, a659, newVector2(0.36, 0.2), newVector2(0.66, 0.5), v664, v663, zIndex)
        line(parent, a659, newVector2(0.66, 0.5), newVector2(0.36, 0.8), v664, v663, zIndex)

        return parent
    end

    if a658 == "chevUp" then
        line(parent, a659, newVector2(0.22, 0.64), newVector2(0.5, 0.34), v664, v663, zIndex)
        line(parent, a659, newVector2(0.5, 0.34), newVector2(0.78, 0.64), v664, v663, zIndex)

        return parent
    end

    if a658 == "chevDown" then
        line(parent, a659, newVector2(0.22, 0.36), newVector2(0.5, 0.66), v664, v663, zIndex)
        line(parent, a659, newVector2(0.5, 0.66), newVector2(0.78, 0.36), v664, v663, zIndex)

        return parent
    end

    if a658 == "pencil" then
        line(parent, a659, newVector2(0.3, 0.7), newVector2(0.76, 0.24), v664 * 1.25, v663, zIndex)
        line(parent, a659, newVector2(0.22, 0.78), newVector2(0.3, 0.7), math.max(1, v664 * 0.7), v663, zIndex)
        line(parent, a659, newVector2(0.16, 0.9), newVector2(0.84, 0.9), math.max(1, v664 * 0.6), v663, zIndex)

        return parent
    end

    if a658 ~= "gear" then
        if a658 == "person" then
            v22.new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.06), Size = UDim2.fromScale(0.42, 0.42), BackgroundColor3 = v663, ZIndex = zIndex, (v22.Corner(Theme.Radius.Pill)), Parent = parent})
            v22.new("Frame", {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.8, 0.44), BackgroundColor3 = v663, ZIndex = zIndex, (v22.Corner(UDim.new(0.45, 0))), Parent = parent})
        end

        return parent
    end

    for index = 0, 3 do
        local v672 = math.rad(index * 45)
        local vector2 = newVector2(math.cos(v672), (math.sin(v672))) * 0.4
        line(parent, a659, newVector2(0.5, 0.5) - vector2, newVector2(0.5, 0.5) + vector2, math.max(3, (math.floor(a659 * 0.2))), v663, zIndex)
    end

    v22.new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), BackgroundColor3 = v663, ZIndex = zIndex, (v22.Corner(Theme.Radius.Pill)), Parent = parent})
    local new2 = v22.new
    local v675 = {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.26, 0.26)}
    local v676 = v662.HoleColor or colors.Panel
    v675.BackgroundColor3 = v676
    v675.ZIndex = zIndex
    v675[1] = (v22.Corner(Theme.Radius.Pill))
    v675.Parent = parent
    new2("Frame", v675)

    return parent
end

local fontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular)

function v22.Glyph(text, textSize: number, a680, options)
    --[[
      name: Glyph
      line: 2147
      upvalues:
        v22 (copy, index: 1)
        fontFace (copy, index: 2)
        colors (copy, index: 3)
    ]]
    local v682 = options or {}
    local new = v22.new
    local v684 = {AutoLocalize = false, Name = v682.Name or "Glyph_" .. text, Text = text, FontFace = fontFace, TextSize = textSize, TextColor3 = a680
        or colors.Text, Size = UDim2.fromOffset(textSize, textSize)}
    local v685 = v682.Position or UDim2.new()
    v684.Position = v685
    v684.AnchorPoint = v682.AnchorPoint or Vector2.zero
    v684.LayoutOrder = v682.LayoutOrder or 0
    v684.ZIndex = v682.ZIndex or 1
    v684.Parent = v682.Parent
    local v686 = new("TextLabel", v684)

    task.delay(
        2,
        function()
            --[[
              line: 2165
              upvalues:
                v686 (copy, index: 1)
                textSize (copy, index: 2)
            ]]
            local x = v686.TextBounds.X

            if v686.Parent and textSize * 1.6 < x then
                v686.TextTransparency = 1
            end
        end
    )

    return v686
end

function v22.SelectionRing(a688, a689)
    --[[
      name: SelectionRing
      line: 2177
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
    ]]
    local selectionImageObject = v22.new("Frame", {Name = "SelectionRing", Position = UDim2.fromOffset(-4, -4), Size = UDim2.new(1, 8, 1, 8), BackgroundTransparency = 1, v22.Corner((a689
        or 12) + 4), v22.Stroke(colors.Text, 3, 0)})

    for _, descendant in a688:GetDescendants() do
        if descendant:IsA("GuiButton") then
            if descendant.Selectable and descendant.SelectionImageObject == nil then
                descendant.SelectionImageObject = selectionImageObject
            end
        end
    end

    a688.DescendantAdded:Connect(
        function(a693)
            --[[
              name: apply
              line: 2187
              upvalues:
                selectionImageObject (copy, index: 1)
            ]]
            if a693:IsA("GuiButton") and a693.Selectable and a693.SelectionImageObject == nil then
                a693.SelectionImageObject = selectionImageObject
            end
        end
    )

    return selectionImageObject
end

local tweenInfo = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

function v22.WindowCloseSize()
    --[[
      name: WindowCloseSize
      line: 2222
      upvalues:
        v22 (copy, index: 1)
    ]]
    if v22.Touch then
        return 72
    end

    return 50
end

function v22.Window(options)
    --[[
      name: Window
      line: 2226
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
        fonts (copy, index: 3)
        Signal (copy, index: 4)
        Sounds (copy, index: 5)
        Theme (copy, index: 6)
        tweenInfo (copy, index: 7)
    ]]
    local v696
    local v697 = v22.new("Frame", {Visible = false, Name = options.Name or "Window", Size = UDim2.fromScale(1, 1), Parent = options.Parent})
    local new = v22.new
    local v699 = {BackgroundTransparency = 1, Modal = true, Selectable = false, Name = (options.Name or "Window") .. "Backdrop", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Visible = v22.BackdropCanvas == nil, Parent = v22.BackdropCanvas
        or v697}
    local v700 = new("TextButton", v699)

    if v22.BackdropCanvas then
        v697:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 2244
                  upvalues:
                    v700 (copy, index: 1)
                    v697 (copy, index: 2)
                ]]
                v700.Visible = v697.Visible
            end
        )
    end

    local new2 = v22.new
    local v702 = {Name = "Holder", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
    local v703 = options.Size or UDim2.fromOffset(1000, 640)
    v702.Size = v703
    v702.Parent = v697
    local v704 = new2("Frame", v702)
    v22.DropShadow(v704, 16, 8, 0.55)

    pcall(
        function()
            --[[
              line: 2257
              upvalues:
                v704 (copy, index: 1)
            ]]
            v704.SelectionGroup = true
            v704.SelectionBehaviorUp, v704.SelectionBehaviorDown = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
            v704.SelectionBehaviorLeft, v704.SelectionBehaviorRight = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
        end
    )

    local fitScale = v704:FindFirstChild("FitScale")

    if not fitScale or not fitScale:IsA("UIScale") then
        v696 = Instance.new("UIScale")
        v696.Name = "FitScale"
        v696.Parent = v704
    else
        v696 = fitScale
    end

    local function applyFit()
        --[[
          name: applyFit
          line: 2264
          upvalues:
            v22 (copy, index: 1)
            v704 (copy, index: 2)
            v696 (copy, index: 3)
        ]]
        local v707 = v22.CanvasSize()
        local size = v704.Size
        local offset = size.X.Offset
        local offset2 = size.Y.Offset

        if not (offset <= 0) and not (offset2 <= 0) then
            local v711 = v22.TopInset()
            v696.Scale = math.min(1, (v707.X - 24) / offset, ((v707.Y - v711) - 12) / offset2)
            local v712 = offset2 * v696.Scale
            local v713 = math.max(v707.Y / 2, v711 + (v712 / 2))
            v704:SetAttribute("_base", UDim2.new(0.5, 0, 0, v713))

            if not v704:GetAttribute("_slideTarget") then
                v704.Position = UDim2.new(0.5, 0, 0, v713)
            end
        else
            v696.Scale = 1
        end
    end

    v22.ScaleChanged:Connect(applyFit)
    local v714 = v22.Panel({Name = "Body", Active = true, BackgroundTransparency = 0.04, StrokeTransparency = 0.88, Size = UDim2.fromScale(1, 1), Radius = UDim.new(0, 16), Parent = v704})
    local headerHeight = options.HeaderHeight or 78
    local v716 = v22.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, headerHeight), Parent = v714})
    local title = v22.DisplayText({Name = "Title", TextSize = 36, StrokeThickness = 0, Text = options.Title or "", TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(28, 14), Size = UDim2.new(1, -150, 0, 40), Parent = v716})
    local subtitle = v22.new("TextLabel", {Name = "Subtitle", TextSize = 17, Text = options.Subtitle or "", FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(30, 52), Size = UDim2.new(1, -150, 0, 20), Parent = v716})
    v22.new("Frame", {Name = "Divider", BackgroundColor3 = colors.Divider, BackgroundTransparency = 0.2, Size = UDim2.new(1, -48, 0, 2), Position = UDim2.new(0, 24, 1, -2), (v22.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0, NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.4), NumberSequenceKeypoint.new(1, 1)}))), Parent = v716})
    local v719 = {IsOpen = false, Root = v697, Holder = v704, Body = v714, Header = v716, Title = title, Subtitle = subtitle, Opened = Signal.new(), Closed = Signal.new(), Refit = applyFit}

    local function makeClose()
        --[[
          name: makeClose
          line: 2348
          upvalues:
            v22 (copy, index: 1)
            colors (copy, index: 2)
            v716 (copy, index: 3)
            options (copy, index: 4)
        ]]
        local v721 = v22.WindowCloseSize()
        return (v22.IconButton(
            {
                Name = "Close",
                IconName = "cross",
                Sound = "Close",
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -14, 0, 12),
                Size = UDim2.fromOffset(v721, v721),
                Color = colors.Raised,
                HoverColor = colors.Danger,
                Parent = v716,
                OnClick = (function()
                    --[[
                      name: OnClick
                      line: 2360
                      upvalues:
                        options (copy, index: 1)
                    ]]
                    if options.OnCloseRequested then
                        options.OnCloseRequested()
                    end
                end)
            }
        ))
    end

    if not options.NoClose then
        local closeButton = makeClose()
        v719.CloseButton = closeButton

        v22.TouchChanged:Connect(
            function()
                --[[
                  line: 2372
                  upvalues:
                    closeButton (ref,  index: 1)
                    makeClose (copy, index: 2)
                    v719 (copy, index: 3)
                ]]
                closeButton:Destroy()
                closeButton = makeClose()
                v719.CloseButton = closeButton
            end
        )
    end

    v719.Content = v22.new("Frame", {Name = "Content", Position = UDim2.fromOffset(0, headerHeight), Size = UDim2.new(1, 0, 1, -headerHeight), (v22.Padding(14, 22, 18, 22)), Parent = v714})
    local timestamp = 0
    local v724 = false

    v700.InputBegan:Connect(
        function(a725)
            --[[
              line: 2392
              upvalues:
                v724 (ref, index: 1)
            ]]
            local userInputType = a725.UserInputType

            if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
                v724 = true
            end
        end
    )

    v700.Activated:Connect(
        function()
            --[[
              line: 2398
              upvalues:
                timestamp (ref,  index: 1)
                v724 (ref,  index: 2)
                options (copy, index: 3)
                Sounds (copy, index: 4)
            ]]
            if not (os.clock() - timestamp < 0.4)
                and v724
                and options.CloseOnBackdrop ~= false
                and options.OnCloseRequested
            then
                Sounds.Play("Close")
                options.OnCloseRequested()
            end
        end
    )

    local count = 0

    function v719.Open(a728)
        --[[
          name: Open
          line: 2410
          upvalues:
            timestamp (ref,  index: 1)
            v724 (ref,  index: 2)
            count (ref,  index: 3)
            v697 (copy, index: 4)
            v700 (copy, index: 5)
            v22 (copy, index: 6)
            Theme (copy, index: 7)
            options (copy, index: 8)
            applyFit (copy, index: 9)
            v704 (copy, index: 10)
            tweenInfo (copy, index: 11)
            Sounds (copy, index: 12)
        ]]
        local v729

        if a728.IsOpen then
            return
        end

        a728.IsOpen = true
        timestamp = os.clock()
        v724 = false
        count += 1
        v697.Visible = true
        v700.BackgroundTransparency = 1
        v22.Tween(v700, Theme.Tween.Smooth, {BackgroundTransparency = options.DimTransparency or 0.4})
        applyFit()
        local base = v704:GetAttribute("_base")
        local slideIn = v22.SlideIn
        local vector2 = Vector2.new(0, 50)

        if typeof(base) ~= "UDim2" then
            v729 = UDim2.fromScale(0.5, 0.5)
        else
            v729 = base
        end

        slideIn(v704, vector2, tweenInfo, v729)
        Sounds.Play((options.OpenSound or "Open"))
        a728.Opened:Fire()
    end

    function v719.Close(a733, a734)
        --[[
          name: Close
          line: 2427
          upvalues:
            count (ref,  index: 1)
            v697 (copy, index: 2)
            v22 (copy, index: 3)
            v700 (copy, index: 4)
            Theme (copy, index: 5)
            v704 (copy, index: 6)
        ]]
        local v735

        if not a733.IsOpen then
            return
        end

        a733.IsOpen = false
        count += 1
        local v736 = count
        a733.Closed:Fire()

        if a734 then
            v697.Visible = false
            return
        end

        v22.Tween(v700, Theme.Tween.Close, {BackgroundTransparency = 1})
        local base = v704:GetAttribute("_base")

        if typeof(base) ~= "UDim2" then
            v735 = UDim2.fromScale(0.5, 0.5)
        else
            v735 = base
        end

        v22.Tween(v704, Theme.Tween.Close, {Position = v735 + UDim2.fromOffset(0, 30)})

        task.delay(
            0.15,
            function()
                --[[
                  line: 2443
                  upvalues:
                    count (ref,  index: 1)
                    v736 (copy, index: 2)
                    v697 (copy, index: 3)
                ]]
                if count == v736 then
                    v697.Visible = false
                end
            end
        )
    end

    return v719
end

function v22.SectionTitle(text: string, options)
    --[[
      name: SectionTitle
      line: 2456
      upvalues:
        v22 (copy, index: 1)
        colors (copy, index: 2)
        fonts (copy, index: 3)
    ]]
    local v740 = options or {}
    local new = v22.new
    local v742 = {Name = "Section"}
    local v743 = v740.Size or UDim2.new(1, 0, 0, 24)
    v742.Size = v743
    local v744 = v740.Position or UDim2.new()
    v742.Position = v744
    v742.LayoutOrder = v740.LayoutOrder or 0
    v742.Parent = v740.Parent
    local parent = new("Frame", v742)
    local new2 = v22.new
    local v747 = {BackgroundColor3 = v740.Color or colors.Accent, Size = UDim2.fromOffset(4, 16), Position = UDim2.fromOffset(0, 4), [1] = (v22.Corner(2)), Parent = parent}
    new2("Frame", v747)
    local new3 = v22.new
    local v749 = {Name = "Text", Text = string.upper(text), FontFace = fonts.Heavy, TextSize = v740.TextSize or 16, TextColor3 = v740.TextColor
        or colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -12, 1, 0), Parent = parent}
    new3("TextLabel", v749)

    return parent
end

function v22.Every(a750, a751, callback)
    --[[
      name: Every
      line: 2487
      upvalues:
        runService (copy, index: 1)
    ]]
    local v753 = 0
    local heartbeatConnection = nil

    heartbeatConnection = runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 2490
              upvalues:
                a750 (copy, index: 1)
                heartbeatConnection (ref,  index: 2)
                v753 (ref,  index: 3)
                a751 (copy, index: 4)
                callback (copy, index: 5)
            ]]
            if not a750.Parent then
                heartbeatConnection:Disconnect()
                return
            end

            v753 += deltaTime

            if a751 <= v753 then
                v753 = 0
                callback()
            end
        end
    )

    return heartbeatConnection
end

return v22