local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local GuiService_upv_1 = game:GetService("GuiService")
local Theme_upv_1 = require(script.Parent.Theme)
local Sounds_upv_1 = require(script.Parent.Sounds)
local Signal_upv_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds_upv_1 = require(ReplicatedStorage_1.Shared:WaitForChild("Keybinds"))
local Loc_upv_1 = require(ReplicatedStorage_1.Shared:WaitForChild("Loc"))
local u1 = {Icons = 0, WeaponArt = 0}
u1.Icons = {}
u1.WeaponArt = {}
local UIAssets_1 = ReplicatedStorage_1.Shared:FindFirstChild("UIAssets")
if UIAssets_1 then
    local success_1, v1 = pcall(require, UIAssets_1)
    if success_1 then
        u1 = v1
    end
end
local Colors_upv_1 = Theme_upv_1.Colors
local Fonts_upv_1 = Theme_upv_1.Fonts
local tbl_upv_1 = {}
tbl_upv_1.Theme = Theme_upv_1
tbl_upv_1.Sounds = Sounds_upv_1
tbl_upv_1.Assets = u1
local tbl_upv_2 = {}
tbl_upv_2.Frame = {BackgroundTransparency = 1, BorderSizePixel = 0}
tbl_upv_2.TextLabel = {BackgroundTransparency = 1, RichText = false, BorderSizePixel = 0, TextSize = 18, TextColor3 = Colors_upv_1.Text, FontFace = Fonts_upv_1.Heavy}
tbl_upv_2.TextButton = {BorderSizePixel = 0, Text = "", BackgroundTransparency = 1, AutoButtonColor = false}
tbl_upv_2.ImageLabel = {BackgroundTransparency = 1, BorderSizePixel = 0}
tbl_upv_2.ImageButton = {BorderSizePixel = 0, BackgroundTransparency = 1, AutoButtonColor = false}
tbl_upv_2.ScrollingFrame = {ScrollBarImageTransparency = 0.2, ScrollBarThickness = 6, BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarImageColor3 = Colors_upv_1.StrokeSoft, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar}
tbl_upv_2.ViewportFrame = {BackgroundTransparency = 1, BorderSizePixel = 0}
tbl_upv_2.CanvasGroup = {BackgroundTransparency = 1, BorderSizePixel = 0}
function tbl_upv_1.new(a1, a2)
    --[[
      name: new
      line: 71
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v2 = Instance.new(a1)
    local v3 = tbl_upv_2[a1]
    if v3 then
        for key_1, value_1 in v3 do
            v2[key_1] = value_1
        end
    end
    local v4 = nil
    if a2 then
        if v3 and a2.BackgroundColor3 ~= nil and a2.BackgroundTransparency == nil then
            v2.BackgroundTransparency = 0
        end
        for key_2, value_2 in a2 do
            if key_2 == "Parent" then
                v4 = value_2
                continue
            end
            if type(key_2) ~= "number" then
                v2[key_2] = value_2
            end
        end
        for _, value_3 in ipairs(a2) do
            value_3.Parent = v2
        end
    end
    if v4 then
        v2.Parent = v4
    end
    return v2
end
function tbl_upv_1.Corner(a1)
    --[[
      name: Corner
      line: 102
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
    ]]
    local v5
    if type(a1) ~= "number" then
        v5 = a1
    else
        v5 = UDim.new(0, a1)
    end
    local new_1 = tbl_upv_1.new
    local tbl_3 = {CornerRadius = 0}
    tbl_3.CornerRadius = v5 or (Theme_upv_1.Radius.Medium)
    return new_1("UICorner", tbl_3)
end
function tbl_upv_1.Stroke(a1, a2, a3)
    --[[
      name: Stroke
      line: 110
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
    ]]
    local new_2 = tbl_upv_1.new
    local tbl_4 = {Thickness = 0, Transparency = 0, Color = 0, LineJoinMode = 0, ApplyStrokeMode = 0}
    tbl_4.Color = a1 or (Colors_upv_1.Stroke)
    tbl_4.Thickness = a2 or 2
    tbl_4.Transparency = a3 or 0
    tbl_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tbl_4.LineJoinMode = Enum.LineJoinMode.Round
    return new_2("UIStroke", tbl_4)
end
function tbl_upv_1.TextStroke(a1, a2, a3)
    --[[
      name: TextStroke
      line: 121
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
    ]]
    local new_3 = tbl_upv_1.new
    local tbl_5 = {Thickness = 0, Transparency = 0, Color = 0, LineJoinMode = 0, ApplyStrokeMode = 0}
    tbl_5.Color = a1 or (Colors_upv_1.Void)
    tbl_5.Thickness = a2 or 2
    tbl_5.Transparency = a3 or 0
    tbl_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    tbl_5.LineJoinMode = Enum.LineJoinMode.Round
    return new_3("UIStroke", tbl_5)
end
function tbl_upv_1.Gradient(a1, a2, a3, a4)
    --[[
      name: Gradient
      line: 131
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v6
    if typeof(a1) ~= "ColorSequence" then
        v6 = ColorSequence.new(a1, a2 or a1)
    else
        v6 = a1
    end
    local new_4 = tbl_upv_1.new
    local tbl_6 = {Transparency = 0}
    tbl_6.Color = v6
    tbl_6.Rotation = a3 or 90
    tbl_6.Transparency = a4 or NumberSequence.new(0)
    return new_4("UIGradient", tbl_6)
end
function tbl_upv_1.Padding(a1, a2, a3, a4)
    --[[
      name: Padding
      line: 145
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local new_5 = tbl_upv_1.new
    local tbl_7 = {PaddingLeft = 0}
    tbl_7.PaddingTop = UDim.new(0, a1)
    tbl_7.PaddingRight = UDim.new(0, a2 or a1)
    tbl_7.PaddingBottom = UDim.new(0, a3 or a1)
    local v8 = a4 or a2 or a1
    tbl_7.PaddingLeft = UDim.new(0, v8)
    return new_5("UIPadding", tbl_7)
end
function tbl_upv_1.List(a1, a2, a3, a4)
    --[[
      name: List
      line: 154
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local new_6 = tbl_upv_1.new
    local tbl_8 = {VerticalAlignment = 0, FillDirection = 0, HorizontalAlignment = 0, Padding = 0, SortOrder = 0}
    tbl_8.FillDirection = a1 or (Enum.FillDirection.Vertical)
    tbl_8.Padding = UDim.new(0, a2 or 8)
    tbl_8.HorizontalAlignment = a3 or (Enum.HorizontalAlignment.Left)
    tbl_8.VerticalAlignment = a4 or (Enum.VerticalAlignment.Top)
    tbl_8.SortOrder = Enum.SortOrder.LayoutOrder
    return new_6("UIListLayout", tbl_8)
end
function tbl_upv_1.DisplayText(a1)
    --[[
      name: DisplayText
      line: 165
      upvalues:
        Colors_upv_1 (copy, index: 1)
        Fonts_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v9 = table.clone(a1)
    local v10 = math.min(v9.StrokeThickness or 1.5, 2)
    local v11 = v9.StrokeColor or (Colors_upv_1.Void)
    v9.StrokeThickness = nil
    v9.StrokeColor = nil
    v9.FontFace = v9.FontFace or (Fonts_upv_1.Display)
    local v12 = tbl_upv_1.new("TextLabel", v9)
    tbl_upv_1.TextStroke(v11, v10, 0.45).Parent = v12
    return v12
end
function tbl_upv_1.Image(a1, a2)
    --[[
      name: Image
      line: 178
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v13 = ((not a2) and {}) or (table.clone(a2))
    v13.Image = a1 or ""
    v13.ScaleType = v13.ScaleType or (Enum.ScaleType.Fit)
    return tbl_upv_1.new("ImageLabel", v13)
end
function tbl_upv_1.Tween(a1, a2, a3)
    --[[
      name: Tween
      line: 189
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    local v14 = TweenService_upv_1:Create(a1, a2, a3)
    v14:Play()
    return v14
end
tbl_upv_1.GetScaleObj = function(a1, a2)
    --[[
      name: getScaleObj
      line: 195
    ]]
    local v15 = a2 or "AnimScale"
    local v16 = a1:FindFirstChild(v15)
    if v16 and v16:IsA("UIScale") then
        return v16
    end
    local v17 = Instance.new("UIScale")
    v17.Name = v15
    v17.Parent = a1
    return v17
end
function tbl_upv_1.Pop(a1, a2, a3)
    --[[
      name: Pop
      line: 210
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
    ]]
    local AnimScale_1 = a1:FindFirstChild("AnimScale")
    local v18
    if (AnimScale_1) and (AnimScale_1:IsA("UIScale")) then
        v18 = AnimScale_1
    else
        local v19 = Instance.new("UIScale")
        v19.Name = "AnimScale"
        v19.Parent = a1
        v18 = v19
    end
    v18.Scale = a2 or 0.6
    tbl_upv_1.Tween(v18, a3 or (Theme_upv_1.Tween.Pop), {Scale = 1})
end
function tbl_upv_1.Bump(a1, a2)
    --[[
      name: Bump
      line: 217
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
    ]]
    local AnimScale_2 = a1:FindFirstChild("AnimScale")
    local v20
    if (AnimScale_2) and (AnimScale_2:IsA("UIScale")) then
        v20 = AnimScale_2
    else
        local v21 = Instance.new("UIScale")
        v21.Name = "AnimScale"
        v21.Parent = a1
        v20 = v21
    end
    v20.Scale = 1 + (a2 or 0.15)
    tbl_upv_1.Tween(v20, Theme_upv_1.Tween.PopSmall, {Scale = 1})
end
function tbl_upv_1.SlideIn(a1, a2, a3, a4)
    --[[
      name: SlideIn
      line: 224
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
    ]]
    local v22, v23 = nil, nil
    if a4 then
        v22 = a4
    else
        v23 = a1:GetAttribute("_slideTarget")
        if typeof(v23) ~= "UDim2" then
            v22 = a1.Position
        else
            v22 = v23
        end
    end
    local v24 = a2 or (Vector2.new(0, 24))
    a1:SetAttribute("_slideTarget", v22)
    a1.Position = v22 + UDim2.fromOffset(v24.X, v24.Y)
    local v25 = tbl_upv_1.Tween(a1, a3 or (Theme_upv_1.Tween.Smooth), {Position = v22})
    v25.Completed:Connect(
        function(a5)
            --[[
              line: 234
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a5 ~= Enum.PlaybackState.Completed then
                return
            end
            a1:SetAttribute("_slideTarget", nil)
        end
    )
    return v25
end
local u2 = setmetatable({}, {__mode = "k"})
local function fadeProps(a1)
    --[[
      name: fadeProps
      line: 243
    ]]
    local tbl_9 = {}
    if a1:IsA("GuiObject") then
        tbl_9.BackgroundTransparency = a1.BackgroundTransparency
    end
    if a1:IsA("TextLabel") or a1:IsA("TextButton") or a1:IsA("TextBox") then
        tbl_9.TextTransparency = a1.TextTransparency
    elseif a1:IsA("ImageLabel") or a1:IsA("ImageButton") or a1:IsA("ViewportFrame") then
        tbl_9.ImageTransparency = a1.ImageTransparency
    elseif a1:IsA("UIStroke") then
        tbl_9.Transparency = a1.Transparency
    end
    for key_3, value_4 in tbl_9 do
        if value_4 >= 1 then
            tbl_9[key_3] = nil
        end
    end
    if next(tbl_9) then
        return tbl_9
    end
    return nil
end
function tbl_upv_1.ResetFade(a1)
    --[[
      name: ResetFade
      line: 286
      upvalues:
        u2 (copy, index: 1)
    ]]
    u2[a1] = nil
end
local function capture(a1)
    --[[
      name: capture
      line: 266
      upvalues:
        u2 (copy, index: 1)
        fadeProps (copy, index: 2)
    ]]
    local v26 = u2[a1]
    if v26 then
        return v26
    end
    local tbl_10 = {}
    local v27 = fadeProps(a1)
    if v27 then
        tbl_10[a1] = v27
    end
    for _, value_5 in a1:GetDescendants() do
        local v28 = fadeProps(value_5)
        if v28 then
            tbl_10[value_5] = v28
        end
    end
    u2[a1] = tbl_10
    return tbl_10
end
function tbl_upv_1.FadeIn(a1, a2)
    --[[
      name: FadeIn
      line: 291
      upvalues:
        Theme_upv_1 (copy, index: 1)
        capture (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v29 = a2 or (Theme_upv_1.Tween.Smooth)
    for key_4, value_6 in capture(a1) do
        if key_4 == a1 or key_4 ~= a1 and (key_4:IsDescendantOf(a1)) then
            for key_5 in value_6 do
                key_4[key_5] = 1
            end
            tbl_upv_1.Tween(key_4, v29, value_6)
        end
    end
end
function tbl_upv_1.FadeOut(a1, a2)
    --[[
      name: FadeOut
      line: 304
      upvalues:
        Theme_upv_1 (copy, index: 1)
        capture (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v30 = a2 or (Theme_upv_1.Tween.Close)
    for key_6, value_7 in capture(a1) do
        if key_6 == a1 or key_6 ~= a1 and (key_6:IsDescendantOf(a1)) then
            local tbl_11 = {}
            for key_7 in value_7 do
                tbl_11[key_7] = 1
            end
            tbl_upv_1.Tween(key_6, v30, tbl_11)
        end
    end
end
function tbl_upv_1.Unfade(a1)
    --[[
      name: Unfade
      line: 318
      upvalues:
        capture (copy, index: 1)
    ]]
    for key_8, value_8 in capture(a1) do
        if key_8 == a1 or key_8 ~= a1 and (key_8:IsDescendantOf(a1)) then
            for key_9, value_9 in value_8 do
                key_8[key_9] = value_9
            end
        end
    end
end
function tbl_upv_1.Enter(a1, a2, a3, a4)
    --[[
      name: Enter
      line: 329
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v31 = a3 or 0
    tbl_upv_1.SlideIn(a1, a2, TweenInfo.new(0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v31), a4)
    tbl_upv_1.FadeIn(a1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v31))
end
function tbl_upv_1.Shake(a1, a2)
    --[[
      name: Shake
      line: 336
    ]]
    local u3 = a1:GetAttribute("_shakeBase")
    local v32 = nil
    if u3 == nil then
        v32 = a1:GetAttribute("_slideTarget")
        if typeof(v32) ~= "UDim2" then
            u3 = a1.Position
        else
            u3 = v32
        end
        a1:SetAttribute("_shakeBase", u3)
    end
    local u4 = a2 or 8
    task.spawn(
        function()
            --[[
              line: 344
              upvalues:
                u4 (copy, index: 1)
                a1 (copy, index: 2)
                u3 (ref,  index: 3)
            ]]
            for _, value_10 in {u4, -u4, u4 * 0.6, -u4 * 0.6, u4 * 0.3, 0} do
                a1.Position = u3 + UDim2.fromOffset(value_10, 0)
                task.wait(0.03)
            end
            a1.Position = u3
            a1:SetAttribute("_shakeBase", nil)
        end
    )
end
function tbl_upv_1.CountUp(a1, a2, a3)
    --[[
      name: CountUp
      line: 355
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local u5 = a2 or (tbl_upv_1.FormatNumber)
    local u6 = Instance.new("NumberValue")
    u6.Parent = a1
    local u7 = 0
    u6.Changed:Connect(
        function(a4)
            --[[
              line: 360
              upvalues:
                u7 (ref,  index: 1)
                a1 (copy, index: 2)
                u5 (copy, index: 3)
            ]]
            u7 = a4
            a1.Text = u5(math.floor(a4 + 0.5))
        end
    )
    local u8 = nil
    local v33 = function(a5, a6)
        --[[
          line: 365
          upvalues:
            u8 (ref,  index: 1)
            u6 (copy, index: 2)
            a1 (copy, index: 3)
            u5 (copy, index: 4)
            a3 (copy, index: 5)
            u7 (ref,  index: 6)
            tbl_upv_1 (copy, index: 7)
        ]]
        if u8 then
            u8:Cancel()
        end
        if a6 then
            u6.Value = a5
            a1.Text = u5(math.floor(a5 + 0.5))
        else
            local v34 = a3 or (math.clamp(math.abs(a5 - u7) / 400, 0.35, 1.2))
            local v35 = tbl_upv_1.Tween(u6, TweenInfo.new(v34, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Value = a5})
            u8 = v35
        end
    end
    return v33
end
function tbl_upv_1.FormatNumber(a1)
    --[[
      name: FormatNumber
      line: 379
    ]]
    local v36 = tostring(math.floor(math.abs(a1))):reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if v36:sub(1, 1) == "," then
        v36 = v36:sub(2)
    end
    return (((a1 < 0) and "-") or "") .. v36
end
function tbl_upv_1.FormatCompact(a1)
    --[[
      name: FormatCompact
      line: 388
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v37 = math.abs(a1)
    local v38 = nil
    if v37 >= 1e+06 then
        v38 = string.format("%.2fM", v37 / 1e+06)
    elseif v37 >= 10000 then
        v38 = string.format("%.1fK", v37 / 1000)
    else
        return tbl_upv_1.FormatNumber(a1)
    end
    local v39 = v38:gsub("%.0+([KM])$", "%1"):gsub("(%.%d)0([KM])$", "%1%2")
    return (((a1 < 0) and "-") or "") .. v39
end
function tbl_upv_1.FormatTime(a1)
    --[[
      name: FormatTime
      line: 402
    ]]
    local v40 = math.max(0, math.ceil(a1))
    return string.format("%d:%02d", v40 // 60, v40 % 60)
end
tbl_upv_1.Scale = 1
tbl_upv_1.ScaleChanged = Signal_upv_1.new()
tbl_upv_1.BackdropCanvas = nil
tbl_upv_1.Touch = false
tbl_upv_1.Compact = false
tbl_upv_1.Tablet = false
tbl_upv_1.LayoutChanged = Signal_upv_1.new()
tbl_upv_1.TouchChanged = Signal_upv_1.new()
tbl_upv_1.COMPACT_DESIGN = Vector2.new(1280, 600)
tbl_upv_1.TV_DESIGN = Vector2.new(1280, 720)
tbl_upv_1.Gamepad = false
tbl_upv_1.GamepadChanged = Signal_upv_1.new()
tbl_upv_1.TenFoot = false
tbl_upv_1.DebugDevice = nil
local function touchOnlyDevice()
    --[[
      name: touchOnlyDevice
      line: 435
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    local v41 = UserInputService_upv_1.TouchEnabled
    if v41 then
        v41 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
    end
    return v41
end
local u9 = nil
local function preferredTouch()
    --[[
      name: preferredTouch
      line: 439
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    local success_2, u10 = pcall(
        function()
            --[[
              line: 440
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
            ]]
            return UserInputService_upv_1.PreferredInput
        end
    )
    if success_2 and u10 ~= nil then
        local success_3, v42 = pcall(
            function()
                --[[
                  line: 446
                  upvalues:
                    u10 (copy, index: 1)
                ]]
                return u10 == Enum.PreferredInput.Touch
            end
        )
        if success_3 then
            return v42
        end
        return nil
    end
    return nil
end
local function decisive(a1)
    --[[
      name: decisive
      line: 453
    ]]
    if a1 ~= Enum.UserInputType.Touch then
        if a1 ~= Enum.UserInputType.Keyboard and a1 ~= Enum.UserInputType.MouseButton1 and a1 ~= Enum.UserInputType.MouseButton2 and a1 ~= Enum.UserInputType.MouseWheel and not (string.find(a1.Name, "Gamepad", 1, true)) then
            return nil
        end
        return false
    end
    return true
end
local function decideTouch()
    --[[
      name: decideTouch
      line: 464
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        preferredTouch (copy, index: 2)
        u9 (ref,  index: 3)
        decisive (copy, index: 4)
    ]]
    if not UserInputService_upv_1.TouchEnabled then
        return false
    end
    local v43 = UserInputService_upv_1.TouchEnabled
    if v43 then
        v43 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
    end
    if v43 then
        return true
    end
    v43 = preferredTouch()
    if v43 == nil then
        if u9 == nil then
            local v44 = decisive(UserInputService_upv_1:GetLastInputType()) == true
            u9 = v44
        end
        return u9
    end
    return v43
end
local v45
if UserInputService_upv_1.TouchEnabled then
    local v46 = UserInputService_upv_1.TouchEnabled
    if v46 then
        v46 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
    end
    if v46 then
        v45 = true
    else
        v46 = preferredTouch()
        if v46 == nil then
            if u9 == nil then
                if decisive(UserInputService_upv_1:GetLastInputType()) == true then
                    u9 = true
                else
                    u9 = false
                end
            end
            v45 = u9
        else
            v45 = v46
        end
    end
else
    v45 = false
end
tbl_upv_1.Touch = v45
local tbl_upv_12 = {}
local function computeScale()
    --[[
      name: computeScale
      line: 482
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
    ]]
    local DebugDevice_1 = tbl_upv_1.DebugDevice
    local u11, v47, v48 = nil, nil, nil
    if DebugDevice_1 then
        u11 = DebugDevice_1.compact ~= false
        local v49 = DebugDevice_1.compact ~= false and DebugDevice_1.tablet == true
        v48 = DebugDevice_1.scale
        v47 = v49
    else
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        local v50 = (CurrentCamera_1 and (CurrentCamera_1.ViewportSize)) or (Theme_upv_1.DesignSize)
        if not (v50.X < 2) and not (v50.Y < 2) then
            u11 = tbl_upv_1.Touch or (v50.Y < 560)
            local TenFoot_1 = tbl_upv_1.TenFoot and (not u11)
            local v51
            if u11 then
                v51 = tbl_upv_1.COMPACT_DESIGN
            elseif TenFoot_1 then
                v51 = tbl_upv_1.TV_DESIGN
            else
                v51 = Theme_upv_1.DesignSize
            end
            local v52 = math.min(v50.X / v51.X, v50.Y / v51.Y)
            local v53 = math.clamp(v52, 0.4, (TenFoot_1 and 3.2) or 1.6)
            local v54 = u11 and (v50.Y / v53 >= 760)
            v47, v48 = v54, v53
            if u11 ~= tbl_upv_1.Compact or v47 ~= tbl_upv_1.Tablet then
                tbl_upv_1.Compact = u11
                tbl_upv_1.Tablet = v47
                task.defer(
                    function()
                        --[[
                          line: 505
                          upvalues:
                            tbl_upv_1 (copy, index: 1)
                            u11 (ref,  index: 2)
                        ]]
                        tbl_upv_1.LayoutChanged:Fire(u11)
                    end
                )
            end
            return v48
        end
        return 1
    end
    if u11 ~= tbl_upv_1.Compact or v47 ~= tbl_upv_1.Tablet then
        tbl_upv_1.Compact = u11
        tbl_upv_1.Tablet = v47
        task.defer(
            function()
                --[[
                  line: 505
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    u11 (ref,  index: 2)
                ]]
                tbl_upv_1.LayoutChanged:Fire(u11)
            end
        )
    end
    return v48
end
local function applyScale()
    --[[
      name: applyScale
      line: 514
      upvalues:
        computeScale (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        Theme_upv_1 (copy, index: 4)
        tbl_upv_12 (copy, index: 5)
    ]]
    local v55 = computeScale()
    tbl_upv_1.Scale = v55
    local DebugDevice_2 = tbl_upv_1.DebugDevice
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    local v56 = (CurrentCamera_2 and (CurrentCamera_2.ViewportSize)) or (Theme_upv_1.DesignSize)
    local v57 = nil
    for _, value_11 in tbl_upv_12 do
        value_11.scale.Scale = v55
        if not (DebugDevice_2) then
            value_11.frame.Size = UDim2.fromScale(1 / v55, 1 / v55)
            value_11.frame.Position = UDim2.new()
            continue
        end
        value_11.frame.Size = UDim2.fromOffset(DebugDevice_2.rect.X / v55, DebugDevice_2.rect.Y / v55)
        local frame_1 = value_11.frame
        if DebugDevice_2.topLeft then
            v57 = UDim2.new()
        else
            v57 = UDim2.fromOffset(math.floor((v56.X - DebugDevice_2.rect.X) / 2), math.floor((v56.Y - DebugDevice_2.rect.Y) / 2))
        end
        frame_1.Position = v57
    end
    tbl_upv_1.ScaleChanged:Fire(v55)
end
local function setTouch(a1)
    --[[
      name: setTouch
      line: 535
      upvalues:
        tbl_upv_1 (copy, index: 1)
        applyScale (copy, index: 2)
    ]]
    if a1 == tbl_upv_1.Touch then
        return
    end
    tbl_upv_1.Touch = a1
    applyScale()
    tbl_upv_1.TouchChanged:Fire(a1)
end
local u12 = 0
local u13 = nil
local function reconsiderTouch()
    --[[
      name: reconsiderTouch
      line: 546
      upvalues:
        tbl_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        preferredTouch (copy, index: 3)
        u9 (ref,  index: 4)
        decisive (copy, index: 5)
        u13 (ref,  index: 6)
        u12 (ref,  index: 7)
        applyScale (copy, index: 8)
    ]]
    if not tbl_upv_1.DebugDevice then
        local u14
        if UserInputService_upv_1.TouchEnabled then
            local v58 = UserInputService_upv_1.TouchEnabled
            if v58 then
                v58 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
            end
            if v58 then
                u14 = true
            else
                v58 = preferredTouch()
                if v58 == nil then
                    if u9 == nil then
                        local v59 = decisive(UserInputService_upv_1:GetLastInputType()) == true
                        u9 = v59
                    end
                    u14 = u9
                else
                    u14 = v58
                end
            end
        else
            u14 = false
        end
        if u14 ~= tbl_upv_1.Touch then
            if u13 == u14 then
                return
            end
            u13 = u14
            u12 = u12 + 1
            local u15 = u12
            task.delay(
                0.3,
                function()
                    --[[
                      line: 564
                      upvalues:
                        u15 (copy, index: 1)
                        u12 (ref,  index: 2)
                        u13 (ref,  index: 3)
                        tbl_upv_1 (copy, index: 4)
                        UserInputService_upv_1 (copy, index: 5)
                        preferredTouch (copy, index: 6)
                        u9 (ref,  index: 7)
                        decisive (copy, index: 8)
                        u14 (copy, index: 9)
                        applyScale (copy, index: 10)
                    ]]
                    if u15 ~= u12 then
                        return
                    end
                    u13 = nil
                    if not (tbl_upv_1.DebugDevice) then
                        local v60
                        if UserInputService_upv_1.TouchEnabled then
                            local v61 = UserInputService_upv_1.TouchEnabled
                            if v61 then
                                v61 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
                            end
                            if v61 then
                                v60 = true
                            else
                                v61 = preferredTouch()
                                if v61 == nil then
                                    if u9 == nil then
                                        local v62 = decisive(UserInputService_upv_1:GetLastInputType()) == true
                                        u9 = v62
                                    end
                                    v60 = u9
                                else
                                    v60 = v61
                                end
                            end
                        else
                            v60 = false
                        end
                        if v60 == u14 and u14 ~= tbl_upv_1.Touch then
                            tbl_upv_1.Touch = u14
                            applyScale()
                            tbl_upv_1.TouchChanged:Fire(u14)
                        end
                    end
                end
            )
        elseif u13 ~= nil then
            u13 = nil
            u12 = u12 + 1
        end
    end
end
UserInputService_upv_1.LastInputTypeChanged:Connect(
    function(a1)
        --[[
          line: 574
          upvalues:
            decisive (copy, index: 1)
            u9 (ref,  index: 2)
            reconsiderTouch (copy, index: 3)
        ]]
        local v63 = decisive(a1)
        if v63 ~= nil then
            u9 = v63
        end
        reconsiderTouch()
    end
)
pcall(
    function()
        --[[
          line: 581
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            reconsiderTouch (copy, index: 2)
        ]]
        UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(reconsiderTouch)
    end
)
for _, value_12 in {"TouchEnabled", "KeyboardEnabled", "MouseEnabled"} do
    UserInputService_upv_1:GetPropertyChangedSignal(value_12):Connect(reconsiderTouch)
end
local u16 = nil
local u17 = string.find(UserInputService_upv_1:GetLastInputType().Name, "Gamepad", 1, true) ~= nil
local function decideGamepad()
    --[[
      name: decideGamepad
      line: 593
      upvalues:
        u16 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
        u17 (ref,  index: 4)
    ]]
    if u16 ~= nil then
        return u16
    end
    if tbl_upv_1.Touch then
        return false
    end
    local success_4, v64 = pcall(function() end)
    if success_4 and v64 then
        return true
    end
    local v65 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
    return v65
end
local function reconsiderGamepad()
    --[[
      name: reconsiderGamepad
      line: 609
      upvalues:
        u16 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
        u17 (ref,  index: 4)
    ]]
    local v66
    if u16 == nil then
        if tbl_upv_1.Touch then
            v66 = false
        else
            local success_5, v67 = pcall(function() end)
            if (success_5) and (v67) then
                v66 = true
            else
                v66 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
            end
        end
    else
        v66 = u16
    end
    if v66 == tbl_upv_1.Gamepad then
        return
    end
    tbl_upv_1.Gamepad = v66
    tbl_upv_1.GamepadChanged:Fire(v66)
end
UserInputService_upv_1.LastInputTypeChanged:Connect(
    function(a1)
        --[[
          line: 616
          upvalues:
            u17 (ref,  index: 1)
            decisive (copy, index: 2)
            u16 (ref,  index: 3)
            tbl_upv_1 (copy, index: 4)
            UserInputService_upv_1 (copy, index: 5)
        ]]
        if string.find(a1.Name, "Gamepad", 1, true) then
            u17 = true
        elseif decisive(a1) ~= nil then
            u17 = false
        end
        local v68
        if u16 == nil then
            if tbl_upv_1.Touch then
                v68 = false
            else
                local success_6, v69 = pcall(function() end)
                if (success_6) and (v69) then
                    v68 = true
                else
                    v68 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
                end
            end
        else
            v68 = u16
        end
        if v68 == tbl_upv_1.Gamepad then
            return
        end
        tbl_upv_1.Gamepad = v68
        tbl_upv_1.GamepadChanged:Fire(v68)
    end
)
pcall(
    function()
        --[[
          line: 624
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            reconsiderGamepad (copy, index: 2)
        ]]
        UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(reconsiderGamepad)
    end
)
tbl_upv_1.TouchChanged:Connect(reconsiderGamepad)
function tbl_upv_1.SetDebugGamepad(a1)
    --[[
      name: SetDebugGamepad
      line: 628
      upvalues:
        RunService_upv_1 (copy, index: 1)
        u16 (ref,  index: 2)
        tbl_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        u17 (ref,  index: 5)
    ]]
    if RunService_upv_1:IsStudio() then
        u16 = a1
        local v70
        if u16 == nil then
            if tbl_upv_1.Touch then
                v70 = false
            else
                local success_7, v71 = pcall(function() end)
                if (success_7) and (v71) then
                    v70 = true
                else
                    v70 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
                end
            end
        else
            v70 = u16
        end
        if v70 ~= tbl_upv_1.Gamepad then
            tbl_upv_1.Gamepad = v70
            tbl_upv_1.GamepadChanged:Fire(v70)
        end
    end
end
local function setTenFoot(a1)
    --[[
      name: setTenFoot
      line: 638
      upvalues:
        tbl_upv_1 (copy, index: 1)
        applyScale (copy, index: 2)
        u16 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        u17 (ref,  index: 5)
    ]]
    if a1 ~= tbl_upv_1.TenFoot then
        tbl_upv_1.TenFoot = a1
        applyScale()
        local v72
        if u16 == nil then
            if tbl_upv_1.Touch then
                v72 = false
            else
                local success_8, v73 = pcall(function() end)
                if (success_8) and (v73) then
                    v72 = true
                else
                    v72 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
                end
            end
        else
            v72 = u16
        end
        if v72 ~= tbl_upv_1.Gamepad then
            tbl_upv_1.Gamepad = v72
            tbl_upv_1.GamepadChanged:Fire(v72)
        end
        tbl_upv_1.TouchChanged:Fire(tbl_upv_1.Touch)
    end
end
local success_9, v74 = pcall(
    function()
        --[[
          line: 647
          upvalues:
            GuiService_upv_1 (copy, index: 1)
        ]]
        return GuiService_upv_1:IsTenFootInterface()
    end
)
tbl_upv_1.TenFoot = success_9 and (v74 == true)
function tbl_upv_1.SetDebugTenFoot(a1)
    --[[
      name: SetDebugTenFoot
      line: 652
      upvalues:
        tbl_upv_1 (copy, index: 1)
        applyScale (copy, index: 2)
        u16 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        u17 (ref,  index: 5)
    ]]
    if a1 ~= tbl_upv_1.TenFoot then
        tbl_upv_1.TenFoot = a1
        applyScale()
        local v75
        if u16 == nil then
            if tbl_upv_1.Touch then
                v75 = false
            else
                local success_10, v76 = pcall(function() end)
                if (success_10) and (v76) then
                    v75 = true
                else
                    v75 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
                end
            end
        else
            v75 = u16
        end
        if v75 ~= tbl_upv_1.Gamepad then
            tbl_upv_1.Gamepad = v75
            tbl_upv_1.GamepadChanged:Fire(v75)
        end
        tbl_upv_1.TouchChanged:Fire(tbl_upv_1.Touch)
    end
end
local v77
if u16 == nil then
    if tbl_upv_1.Touch then
        v77 = false
    else
        local success_11, v78 = pcall(
            function()
                --[[
                  line: 600
                  upvalues:
                    UserInputService_upv_1 (copy, index: 1)
                ]]
                return UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Gamepad
            end
        )
        if (success_11) and (v78) then
            v77 = true
        else
            v77 = u17 or (tbl_upv_1.TenFoot and (not UserInputService_upv_1.KeyboardEnabled))
        end
    end
else
    v77 = u16
end
tbl_upv_1.Gamepad = v77
function tbl_upv_1.SetDebugDevice(a1, a2)
    --[[
      name: SetDebugDevice
      line: 657
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u12 (ref,  index: 2)
        u13 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        preferredTouch (copy, index: 5)
        u9 (ref,  index: 6)
        decisive (copy, index: 7)
        applyScale (copy, index: 8)
    ]]
    tbl_upv_1.DebugDevice = a1
    u12 = u12 + 1
    u13 = nil
    local v79
    if a1 then
        v79 = a2 ~= false
    elseif UserInputService_upv_1.TouchEnabled then
        local v80 = UserInputService_upv_1.TouchEnabled
        if v80 then
            v80 = not UserInputService_upv_1.KeyboardEnabled or not UserInputService_upv_1.MouseEnabled
        end
        if v80 then
            v79 = true
        else
            v80 = preferredTouch()
            if v80 == nil then
                if u9 == nil then
                    local v81 = decisive(UserInputService_upv_1:GetLastInputType()) == true
                    u9 = v81
                end
                v79 = u9
            else
                v79 = v80
            end
        end
    else
        v79 = false
    end
    if v79 == tbl_upv_1.Touch then
        applyScale()
    elseif v79 ~= tbl_upv_1.Touch then
        tbl_upv_1.Touch = v79
        applyScale()
        tbl_upv_1.TouchChanged:Fire(v79)
    end
end
local u18 = nil
local function hookCamera()
    --[[
      name: hookCamera
      line: 670
      upvalues:
        u18 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        applyScale (copy, index: 3)
    ]]
    if u18 then
        u18:Disconnect()
    end
    local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_3 then
        u18 = CurrentCamera_3:GetPropertyChangedSignal("ViewportSize"):Connect(applyScale)
    end
    applyScale()
end
Workspace_upv_1:GetPropertyChangedSignal("CurrentCamera"):Connect(hookCamera)
if u18 then
    u18:Disconnect()
end
local CurrentCamera_4 = Workspace_upv_1.CurrentCamera
if CurrentCamera_4 then
    u18 = CurrentCamera_4:GetPropertyChangedSignal("ViewportSize"):Connect(applyScale)
end
applyScale()
local tbl_upv_13 = {}
tbl_upv_1.TouchChanged:Connect(
    function(a1)
        --[[
          line: 685
          upvalues:
            tbl_upv_13 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local v82 = nil
        for key_10 in tbl_upv_13 do
            if a1 or tbl_upv_1.TenFoot then
                v82 = Enum.ScreenInsets.DeviceSafeInsets
            else
                v82 = Enum.ScreenInsets.None
            end
            key_10.ScreenInsets = v82
        end
    end
)
function tbl_upv_1.Screen(a1, a2, a3, a4)
    --[[
      name: Screen
      line: 692
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_13 (copy, index: 2)
        tbl_upv_12 (copy, index: 3)
    ]]
    local v83 = (a4 ~= nil) and (a4.fullBleed == true)
    local u19 = tbl_upv_1.new("ScreenGui", {ResetOnSpawn = false, IgnoreGuiInset = true, Name = a1, DisplayOrder = a2, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
    local v84 = nil
    if not (tbl_upv_1.Touch) and not (tbl_upv_1.TenFoot) or v83 then
        v84 = Enum.ScreenInsets.None
        u19.ScreenInsets = v84
        if not (v83) then
            tbl_upv_13[u19] = true
            u19.Destroying:Connect(
                function()
                    --[[
                      line: 704
                      upvalues:
                        tbl_upv_13 (copy, index: 1)
                        u19 (copy, index: 2)
                    ]]
                    tbl_upv_13[u19] = nil
                end
            )
        end
        local v85 = tbl_upv_1.new("Frame", {Name = "Canvas", Size = UDim2.fromScale(1, 1), Parent = u19})
        local v86 = tbl_upv_1.new("UIScale", {Name = "CanvasScale", Parent = v85})
        table.insert(tbl_upv_12, {frame = v85, scale = v86})
        v86.Scale = tbl_upv_1.Scale
        v85.Size = UDim2.fromScale(1 / tbl_upv_1.Scale, 1 / tbl_upv_1.Scale)
        u19.Parent = a3
        return u19, v85
    end
    v84 = Enum.ScreenInsets.DeviceSafeInsets
    u19.ScreenInsets = v84
    if not (v83) then
        tbl_upv_13[u19] = true
        u19.Destroying:Connect(
            function()
                --[[
                  line: 704
                  upvalues:
                    tbl_upv_13 (copy, index: 1)
                    u19 (copy, index: 2)
                ]]
                tbl_upv_13[u19] = nil
            end
        )
    end
    local v85 = tbl_upv_1.new("Frame", {Name = "Canvas", Size = UDim2.fromScale(1, 1), Parent = u19})
    local v86 = tbl_upv_1.new("UIScale", {Name = "CanvasScale", Parent = v85})
    table.insert(tbl_upv_12, {frame = v85, scale = v86})
    v86.Scale = tbl_upv_1.Scale
    v85.Size = UDim2.fromScale(1 / tbl_upv_1.Scale, 1 / tbl_upv_1.Scale)
    u19.Parent = a3
    return u19, v85
end
function tbl_upv_1.CanvasSize()
    --[[
      name: CanvasSize
      line: 718
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
    ]]
    local DebugDevice_3 = tbl_upv_1.DebugDevice
    if DebugDevice_3 then
        return DebugDevice_3.rect / DebugDevice_3.scale
    end
    local CurrentCamera_5 = Workspace_upv_1.CurrentCamera
    return ((CurrentCamera_5 and (CurrentCamera_5.ViewportSize)) or (Theme_upv_1.DesignSize)) / tbl_upv_1.Scale
end
tbl_upv_1.TopInsetChanged = Signal_upv_1.new()
function tbl_upv_1.TopInset()
    --[[
      name: TopInset
      line: 730
      upvalues:
        tbl_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
    ]]
    local v87 = tbl_upv_1.DebugDevice
    if v87 then
        return (v87.topInset or 60) + 4
    end
    local success_12, v88 = pcall(
        function()
            --[[
              line: 735
              upvalues:
                GuiService_upv_1 (copy, index: 1)
            ]]
            return GuiService_upv_1.TopbarInset
        end
    )
    if (success_12) and (v88) then
        v87 = v88.Max.Y
    else
        v87 = 58
    end
    if v87 <= 0 then
        v87 = 58
    end
    return math.ceil(v87 / math.max(tbl_upv_1.Scale, 0.01)) + 4
end
function tbl_upv_1.TopCentreY(a1)
    --[[
      name: TopCentreY
      line: 746
      upvalues:
        tbl_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
    ]]
    if tbl_upv_1.DebugDevice then
        return tbl_upv_1.TopInset()
    end
    local success_13, v89 = pcall(
        function()
            --[[
              line: 750
              upvalues:
                GuiService_upv_1 (copy, index: 1)
            ]]
            return GuiService_upv_1.TopbarInset
        end
    )
    if success_13 and v89 and not (v89.Width <= 0) then
        local CurrentCamera_6 = Workspace_upv_1.CurrentCamera
        local v90 = ((not CurrentCamera_6) and 0) or (CurrentCamera_6.ViewportSize.X)
        local v91 = (a1 * math.max(tbl_upv_1.Scale, 0.01)) / 2 + 2
        local v92 = v90 / 2
        if (v89.Min.X + tbl_upv_1.TopbarReserved) + 8 <= v92 - v91 and v92 + v91 <= v89.Max.X then
            return 6
        end
        return tbl_upv_1.TopInset()
    end
    return tbl_upv_1.TopInset()
end
tbl_upv_1.TopbarReserved = 0
pcall(
    function()
        --[[
          line: 770
          upvalues:
            GuiService_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        GuiService_upv_1:GetPropertyChangedSignal("TopbarInset"):Connect(
            function()
                --[[
                  line: 771
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                ]]
                tbl_upv_1.TopInsetChanged:Fire()
            end
        )
    end
)
tbl_upv_1.ScaleChanged:Connect(
    function()
        --[[
          line: 775
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.TopInsetChanged:Fire()
    end
)
function tbl_upv_1.OnResize(a1)
    --[[
      name: OnResize
      line: 782
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local u20 = false
    tbl_upv_1.ScaleChanged:Connect(
        function()
            --[[
              line: 784
              upvalues:
                u20 (ref,  index: 1)
                a1 (copy, index: 2)
            ]]
            if u20 then
                return
            end
            u20 = true
            task.defer(
                function()
                    --[[
                      line: 789
                      upvalues:
                        u20 (ref,  index: 1)
                        a1 (copy, index: 2)
                    ]]
                    u20 = false
                    a1()
                end
            )
        end
    )
end
tbl_upv_1.ChatChanged = Signal_upv_1.new()
tbl_upv_1.DebugChatRect = nil
local u21 = nil
local function unionRect(a1, a2, a3)
    --[[
      name: unionRect
      line: 811
    ]]
    if not (a3.X < 2) and not (a3.Y < 2) then
        if a1 then
            return Rect.new(math.min(a1.Min.X, a2.X), math.min(a1.Min.Y, a2.Y), math.max(a1.Max.X, a2.X + a3.X), math.max(a1.Max.Y, a2.Y + a3.Y))
        end
        return Rect.new(a2, a2 + a3)
    end
    return a1
end
local function sameRect(a1, a2)
    --[[
      name: sameRect
      line: 877
    ]]
    if a1 ~= nil and a2 ~= nil then
        local v93 = (math.abs(a1.Min.X - a2.Min.X) < 2) and ((math.abs(a1.Min.Y - a2.Min.Y) < 2) and ((math.abs(a1.Max.X - a2.Max.X) < 2) and (math.abs(a1.Max.Y - a2.Max.Y) < 2)))
        return v93
    end
    return a1 == a2
end
local u22 = 0
local function readChatRect()
    --[[
      name: readChatRect
      line: 826
      upvalues:
        tbl_upv_1 (copy, index: 1)
        unionRect (copy, index: 2)
    ]]
    if tbl_upv_1.DebugChatRect then
        return tbl_upv_1.DebugChatRect
    end
    local StarterGui_upv_1 = game:GetService("StarterGui")
    if not StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
        return nil
    end
    local success_14, v94 = pcall(
        function()
            --[[
              line: 834
              upvalues:
                StarterGui_upv_1 (copy, index: 1)
            ]]
            return StarterGui_upv_1:GetCore("ChatActive")
        end
    )
    if success_14 and v94 == false then
        return nil
    end
    local TextChatService_1 = game:GetService("TextChatService")
    local v95 = TextChatService_1:FindFirstChildOfClass("ChatWindowConfiguration")
    local v96 = (not v95) or ((not (v95.Enabled)) or (unionRect(nil, v95.AbsolutePosition, v95.AbsoluteSize)))
    local v97 = TextChatService_1:FindFirstChildOfClass("ChatInputBarConfiguration")
    local v98 = (not v97) or ((not (v97.Enabled)) or (unionRect(v96, v97.AbsolutePosition, v97.AbsoluteSize)))
    if v98 then
        return v98
    end
    local LocalPlayer_1 = game:GetService("Players").LocalPlayer
    local v99 = LocalPlayer_1 and (LocalPlayer_1:FindFirstChildOfClass("PlayerGui"))
    LocalPlayer_1 = v99 and (v99:FindFirstChild("Chat"))
    if not LocalPlayer_1 or not LocalPlayer_1:IsA("ScreenGui") or not LocalPlayer_1.Enabled then
        return nil
    end
    local Frame_1 = LocalPlayer_1:FindFirstChild("Frame")
    if not Frame_1 or not Frame_1:IsA("GuiObject") or not Frame_1.Visible then
        return nil
    end
    for _, value_13 in Frame_1:GetChildren() do
        local v101 = value_13:IsA("GuiObject")
        if not (v101) or not (value_13.Visible) then
            continue
        end
        local v102 = string.find(value_13.Name, "ParentFrame", 1, true)
        if v102 then
            LocalPlayer_1 = unionRect(LocalPlayer_1, value_13.AbsolutePosition, value_13.AbsoluteSize)
        end
    end
    return LocalPlayer_1
end
RunService_upv_1.Heartbeat:Connect(
    function(a1)
        --[[
          line: 886
          upvalues:
            u22 (ref,  index: 1)
            readChatRect (copy, index: 2)
            sameRect (copy, index: 3)
            u21 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        u22 = u22 + a1
        if u22 < 0.2 then
            return
        end
        u22 = 0
        local success_15, v103 = pcall(readChatRect)
        local v104
        if success_15 then
            v104 = v103
        else
            v104 = nil
        end
        if (sameRect(v104, u21)) then
            return
        end
        u21 = v104
        tbl_upv_1.ChatChanged:Fire(v104)
    end
)
function tbl_upv_1.ChatRect()
    --[[
      name: ChatRect
      line: 900
      upvalues:
        u21 (ref, index: 1)
    ]]
    return u21
end
function tbl_upv_1.ChatRectIn(a1)
    --[[
      name: ChatRectIn
      line: 904
      upvalues:
        u21 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not u21 then
        return nil
    end
    local AbsolutePosition_1 = a1.AbsolutePosition
    local v105 = math.max(tbl_upv_1.Scale, 0.01)
    return Rect.new((u21.Min - AbsolutePosition_1) / v105, (u21.Max - AbsolutePosition_1) / v105)
end
local u23 = Vector2.zero
local function trackPointer(a1)
    --[[
      name: trackPointer
      line: 916
      upvalues:
        u23 (ref, index: 1)
    ]]
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Touch and UserInputType_1 ~= Enum.UserInputType.MouseMovement and UserInputType_1 ~= Enum.UserInputType.MouseButton1 then
        return
    end
    u23 = Vector2.new(a1.Position.X, a1.Position.Y)
end
UserInputService_upv_1.InputBegan:Connect(trackPointer)
UserInputService_upv_1.InputChanged:Connect(trackPointer)
function tbl_upv_1.PointerAbs()
    --[[
      name: PointerAbs
      line: 924
      upvalues:
        u23 (ref, index: 1)
    ]]
    return u23
end
function tbl_upv_1.Panel(a1)
    --[[
      name: Panel
      line: 934
      upvalues:
        Colors_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
    ]]
    local v106 = table.clone(a1)
    local Radius_1 = v106.Radius
    local v107 = v106.StrokeColor or (Colors_upv_1.Stroke)
    local NoStroke_1 = v106.NoStroke
    local v108 = v106.TopColor or (Colors_upv_1.Panel)
    local v109 = v106.BottomColor or (Colors_upv_1.PanelLo)
    v106.Radius = nil
    v106.Trim = nil
    v106.StrokeColor = nil
    v106.StrokeTransparency = nil
    v106.NoStroke = nil
    v106.TopColor = nil
    v106.BottomColor = nil
    v106.StrokeThickness = nil
    v106.BackgroundTransparency = v106.BackgroundTransparency or 0.12
    v106.BackgroundColor3 = Color3.new(1, 1, 1)
    local v110 = tbl_upv_1.new("Frame", v106)
    tbl_upv_1.Corner(Radius_1 or (Theme_upv_1.Radius.Large)).Parent = v110
    tbl_upv_1.Gradient(v108, v109, 90).Parent = v110
    if not (NoStroke_1) then
        tbl_upv_1.Stroke(v107, v106.StrokeThickness or 1, v106.StrokeTransparency or 0.9).Parent = v110
    end
    return v110
end
function tbl_upv_1.TeethTrim(a1)
    --[[
      name: TeethTrim
      line: 957
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.new("Frame", {Visible = false, Name = "Trim", Size = UDim2.fromOffset(0, 0), Parent = a1.Parent})
end
function tbl_upv_1.DropShadow(a1, a2, a3, a4)
    --[[
      name: DropShadow
      line: 962
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
    ]]
    for key_11, value_14 in {0, 4, 9} do
        tbl_upv_1.new("Frame", {Name = "Shadow" .. key_11, BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 1 - ((a4 or 0.5) / (key_11 * 1.6)), Size = UDim2.new(1, value_14 * 2, 1, value_14 * 2), Position = UDim2.fromOffset(-value_14, -value_14 + (a3 or 6)), ZIndex = 0, [1] = tbl_upv_1.Corner((a2 or 14) + value_14), Parent = a1})
    end
end
function tbl_upv_1.Bar(a1)
    --[[
      name: Bar
      line: 981
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
    ]]
    local new_7 = tbl_upv_1.new
    local u24 = {}
    u24.Name = a1.Name or "Bar"
    u24.Size = a1.Size or UDim2.fromOffset(200, 10)
    u24.Position = a1.Position or UDim2.new()
    u24.AnchorPoint = a1.AnchorPoint or (Vector2.zero)
    u24.BackgroundColor3 = a1.TrackColor or (Colors_upv_1.Inset)
    u24.BackgroundTransparency = a1.TrackTransparency or 0.2
    u24.LayoutOrder = a1.LayoutOrder or 0
    u24.ClipsDescendants = true
    u24[1] = tbl_upv_1.Corner(a1.Radius or (Theme_upv_1.Radius.Pill))
    u24.Parent = a1.Parent
    local v113 = new_7("Frame", u24)
    if a1.Stroke ~= false then
        tbl_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.8).Parent = v113
    end
    local new_8 = tbl_upv_1.new
    local tbl_14 = {}
    tbl_14.Name = "Fill"
    tbl_14.Size = UDim2.fromScale(a1.Value or 0, 1)
    tbl_14.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_14[1] = tbl_upv_1.Corner(a1.Radius or (Theme_upv_1.Radius.Pill))
    tbl_14.Parent = v113
    local u25 = new_8("Frame", tbl_14)
    local Gradient_1 = tbl_upv_1.Gradient
    local v114 = Theme_upv_1.Lighten(a1.Color or (Colors_upv_1.Accent), 0.2)
    u24 = Gradient_1(v114, a1.Color or (Colors_upv_1.Accent), 90)
    u24.Parent = u25
    local u26 = nil
    local tbl_15 = {}
    tbl_15.Frame = v113
    tbl_15.Fill = u25
    function tbl_15.Set(a2, a3, a4)
        --[[
          name: Set
          line: 1010
          upvalues:
            u26 (ref,  index: 1)
            u25 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
        ]]
        local v115 = math.clamp(a2, 0, 1)
        if u26 then
            u26:Cancel()
            u26 = nil
        end
        if a3 then
            u25.Size = UDim2.fromScale(v115, 1)
        else
            local v116 = tbl_upv_1.Tween(u25, a4 or (Theme_upv_1.Tween.Smooth), {Size = UDim2.fromScale(v115, 1)})
            u26 = v116
        end
    end
    function tbl_15.SetColor(a5)
        --[[
          name: SetColor
          line: 1022
          upvalues:
            u24 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
        ]]
        u24.Color = ColorSequence.new(Theme_upv_1.Lighten(a5, 0.2), a5)
    end
    return tbl_15
end
local tbl_upv_16 = {}
tbl_upv_16.Primary = {top = Color3.fromRGB(64, 168, 255), bottom = Color3.fromRGB(28, 132, 246), lip = Color3.fromRGB(12, 70, 160), stroke = Color3.fromRGB(150, 210, 255), text = Colors_upv_1.Text}
tbl_upv_16.Success = {top = Color3.fromRGB(84, 224, 124), bottom = Color3.fromRGB(40, 184, 92), lip = Color3.fromRGB(16, 100, 48), stroke = Color3.fromRGB(170, 255, 200), text = Colors_upv_1.Text}
tbl_upv_16.Danger = {top = Color3.fromRGB(255, 92, 98), bottom = Color3.fromRGB(226, 52, 62), lip = Color3.fromRGB(120, 18, 28), stroke = Color3.fromRGB(255, 170, 176), text = Colors_upv_1.Text}
tbl_upv_16.Dark = {top = Color3.fromRGB(44, 48, 60), bottom = Color3.fromRGB(34, 37, 47), lip = Color3.fromRGB(16, 18, 24), stroke = Color3.fromRGB(96, 104, 124), text = Colors_upv_1.Text}
tbl_upv_16.Light = {top = Color3.fromRGB(250, 251, 253), bottom = Color3.fromRGB(226, 230, 238), lip = Color3.fromRGB(150, 156, 172), stroke = Color3.fromRGB(255, 255, 255), text = Colors_upv_1.TextDark}
tbl_upv_16.Disabled = {top = Color3.fromRGB(46, 49, 58), bottom = Color3.fromRGB(38, 41, 49), lip = Color3.fromRGB(20, 22, 28), stroke = Color3.fromRGB(70, 75, 88), text = Color3.fromRGB(130, 136, 150)}
tbl_upv_16.Ochre = tbl_upv_16.Primary
tbl_upv_16.Jade = tbl_upv_16.Success
tbl_upv_16.Ally = tbl_upv_16.Primary
tbl_upv_1.ButtonStyles = tbl_upv_16
function tbl_upv_1.PressKind(a1, a2)
    --[[
      name: PressKind
      line: 1068
      upvalues:
        GuiService_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if typeof(a1) == "Instance" and a1:IsA("InputObject") then
        if a1.UserInputType == Enum.UserInputType.Keyboard and a2 and GuiService_upv_1.SelectedObject ~= a2 then
            return nil
        end
        return a1.UserInputType.Value
    elseif tbl_upv_1.Gamepad then
        return -1
    else
        return nil
    end
end
function tbl_upv_1.Button(a1)
    --[[
      name: Button
      line: 1080
      upvalues:
        tbl_upv_16 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        Fonts_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
        Signal_upv_1 (copy, index: 5)
        Theme_upv_1 (copy, index: 6)
        Sounds_upv_1 (copy, index: 7)
        Loc_upv_1 (copy, index: 8)
    ]]
    local v117 = a1.Style or "Primary"
    local v118 = tbl_upv_16[v117] or (tbl_upv_16.Primary)
    local v119 = a1.Radius or 12
    local new_9 = tbl_upv_1.new
    local u27 = {AnchorPoint = 0, Visible = 0, Position = 0, Selectable = true, ZIndex = 0, LayoutOrder = 0, Size = 0}
    u27.Name = a1.Name or "Button"
    u27.Size = a1.Size or UDim2.fromOffset(220, 58)
    u27.Position = a1.Position or UDim2.new()
    u27.AnchorPoint = a1.AnchorPoint or (Vector2.zero)
    u27.LayoutOrder = a1.LayoutOrder or 0
    u27.ZIndex = a1.ZIndex or 1
    u27.Visible = a1.Visible ~= false
    local u28 = new_9("TextButton", u27)
    local v122 = tbl_upv_1.new("Frame", {Name = "Scaler", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Parent = u28})
    local HoverScale_1 = v122:FindFirstChild("HoverScale")
    if (HoverScale_1) and (HoverScale_1:IsA("UIScale")) then
        u27 = HoverScale_1
    else
        local v123 = Instance.new("UIScale")
        v123.Name = "HoverScale"
        v123.Parent = v122
        u27 = v123
    end
    local u29 = tbl_upv_1.new("Frame", {Name = "Lip", BackgroundColor3 = v118.lip, Size = UDim2.new(1, 0, 1, -3), Position = UDim2.fromOffset(0, 3), [1] = tbl_upv_1.Corner(v119), Parent = v122})
    local u30 = tbl_upv_1.new("Frame", {Name = "Face", BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 1, -3), [1] = tbl_upv_1.Corner(v119), Parent = v122})
    local u31 = tbl_upv_1.Gradient(v118.top, v118.bottom, 90)
    u31.Parent = u30
    local u32 = tbl_upv_1.Stroke(v118.stroke, 1, 0.6)
    u32.Parent = u30
    local u33 = tbl_upv_1.new("Frame", {Name = "Glow", BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), [1] = tbl_upv_1.Corner(v119), Parent = u30})
    local u34 = tbl_upv_1.new("Frame", {Name = "Content", Size = UDim2.fromScale(1, 1), [1] = tbl_upv_1.List(Enum.FillDirection.Horizontal, a1.Gap or 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = u30})
    if a1.Icon then
        a1.Icon.LayoutOrder = 0
        a1.Icon.Parent = u34
    end
    local new_10 = tbl_upv_1.new
    local tbl_17 = {LayoutOrder = 1, FontFace = 0, TextColor3 = 0, Parent = 0, Name = "Label", AutomaticSize = 0, TextSize = 0, Size = 0}
    tbl_17.Text = a1.Text or "BUTTON"
    tbl_17.FontFace = a1.Font or (Fonts_upv_1.Display)
    tbl_17.TextSize = a1.TextSize or 22
    tbl_17.TextColor3 = v118.text
    tbl_17.AutomaticSize = Enum.AutomaticSize.X
    tbl_17.Size = UDim2.new(0, 0, 1, 0)
    tbl_17.Parent = u34
    local u35 = new_10("TextLabel", tbl_17)
    local u36 = tbl_upv_1.TextStroke(Colors_upv_1.Void, 1, 1)
    u36.Parent = u35
    local TextSize_upv_1 = u35.TextSize
    local u37 = false
    local function setSize(a2)
        --[[
          name: setSize
          line: 1162
          upvalues:
            u37 (ref,  index: 1)
            u35 (copy, index: 2)
        ]]
        u37 = true
        u35.TextSize = a2
        u37 = false
    end
    u35:GetPropertyChangedSignal("TextSize"):Connect(
        function()
            --[[
              line: 1167
              upvalues:
                u37 (ref,  index: 1)
                TextSize_upv_1 (ref,  index: 2)
                u35 (copy, index: 3)
            ]]
            if (u37) then
                return
            end
            TextSize_upv_1 = u35.TextSize
        end
    )
    local function fitLabel()
        --[[
          name: fitLabel
          line: 1172
          upvalues:
            u30 (copy, index: 1)
            a1 (copy, index: 2)
            u34 (copy, index: 3)
            u35 (copy, index: 4)
            TextSize_upv_1 (ref,  index: 5)
            u37 (ref,  index: 6)
        ]]
        local v124 = u30.AbsoluteSize.X * 0.92
        local Icon_1 = a1.Icon
        if Icon_1 and Icon_1.Parent == u34 then
            v124 = ((Icon_1.Visible) and (v124 - (Icon_1.AbsoluteSize.X + (a1.Gap or 8)))) or v124
        end
        local X_1 = u35.AbsoluteSize.X
        local v125 = math.floor(TextSize_upv_1 * 0.6)
        if not (v124 > 1) or not (v124 + 0.5 < X_1) then
            return
        end
        if v125 < u35.TextSize then
            local v126 = math.max(v125, math.floor(u35.TextSize * v124 / X_1))
            u37 = true
            u35.TextSize = v126
            u37 = false
        end
    end
    local function refit()
        --[[
          name: refit
          line: 1184
          upvalues:
            u35 (copy, index: 1)
            TextSize_upv_1 (ref,  index: 2)
            u37 (ref,  index: 3)
            fitLabel (copy, index: 4)
        ]]
        if u35.TextSize ~= TextSize_upv_1 then
            u37 = true
            u35.TextSize = TextSize_upv_1
            u37 = false
        end
        task.defer(fitLabel)
    end
    u35:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitLabel)
    u35:GetPropertyChangedSignal("Text"):Connect(refit)
    u30:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitLabel)
    local tbl_upv_18 = {Enabled = 0, Style = 0}
    tbl_upv_18.Instance = u28
    tbl_upv_18.Face = u30
    tbl_upv_18.Label = u35
    tbl_upv_18.Content = u34
    tbl_upv_18.Activated = Signal_upv_1.new()
    tbl_upv_18.Enabled = a1.Enabled ~= false
    tbl_upv_18.Style = v117
    local u38 = false
    local u39 = false
    local function applyStyle()
        --[[
          name: applyStyle
          line: 1208
          upvalues:
            tbl_upv_18 (copy, index: 1)
            tbl_upv_16 (copy, index: 2)
            u31 (copy, index: 3)
            u29 (copy, index: 4)
            u32 (copy, index: 5)
            u35 (copy, index: 6)
            u36 (copy, index: 7)
        ]]
        local v127 = tbl_upv_16[((not (tbl_upv_18.Enabled)) and "Disabled") or (tbl_upv_18.Style)] or (tbl_upv_16.Primary)
        u31.Color = ColorSequence.new(v127.top, v127.bottom)
        u29.BackgroundColor3 = v127.lip
        u32.Color = v127.stroke
        u35.TextColor3 = v127.text
        u36.Transparency = 1
    end
    local function refresh()
        --[[
          name: refresh
          line: 1218
          upvalues:
            u39 (ref,  index: 1)
            tbl_upv_1 (copy, index: 2)
            u30 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            u38 (ref,  index: 5)
            tbl_upv_18 (copy, index: 6)
            u27 (copy, index: 7)
            u33 (copy, index: 8)
        ]]
        local v128 = (u39 and 2) or 0
        tbl_upv_1.Tween(u30, Theme_upv_1.Tween.Instant, {Position = UDim2.fromOffset(0, v128)})
        if u39 then
            v128 = 0.96
        elseif (u38) and (tbl_upv_18.Enabled) then
            v128 = 1.04
        else
            v128 = 1
        end
        tbl_upv_1.Tween(u27, Theme_upv_1.Tween.PopSmall, {Scale = v128})
        local Tween_1 = tbl_upv_1.Tween
        local Fast_1 = Theme_upv_1.Tween.Fast
        local tbl_19 = {BackgroundTransparency = 0}
        local v129
        if (u38) and (tbl_upv_18.Enabled) then
            v129 = 0.86
        else
            v129 = 1
        end
        tbl_19.BackgroundTransparency = v129
        Tween_1(u33, Fast_1, tbl_19)
    end
    u28.MouseEnter:Connect(
        function()
            --[[
              line: 1226
              upvalues:
                u38 (ref,  index: 1)
                tbl_upv_18 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                Sounds_upv_1 (copy, index: 4)
                refresh (copy, index: 5)
            ]]
            u38 = true
            if tbl_upv_18.Enabled and not (tbl_upv_1.Touch) then
                Sounds_upv_1.Play("Hover")
            end
            refresh()
        end
    )
    u28.MouseLeave:Connect(
        function()
            --[[
              line: 1233
              upvalues:
                u38 (ref,  index: 1)
                u39 (ref,  index: 2)
                refresh (copy, index: 3)
            ]]
            u38 = false
            u39 = false
            refresh()
        end
    )
    u28.MouseButton1Down:Connect(
        function()
            --[[
              line: 1238
              upvalues:
                u39 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            u39 = true
            refresh()
        end
    )
    u28.MouseButton1Up:Connect(
        function()
            --[[
              line: 1242
              upvalues:
                u39 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            u39 = false
            refresh()
        end
    )
    u28.Activated:Connect(
        function(a3, a4)
            --[[
              line: 1246
              upvalues:
                tbl_upv_18 (copy, index: 1)
                Sounds_upv_1 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                u28 (copy, index: 4)
                a1 (copy, index: 5)
            ]]
            if tbl_upv_18.Enabled then
                if a1.Sound ~= false then
                    Sounds_upv_1.Play(a1.Sound or "Click")
                end
                if a1.PassInput then
                    tbl_upv_18.Activated:Fire(a3, a4)
                else
                    tbl_upv_18.Activated:Fire()
                end
                if a1.OnClick then
                    task.spawn(a1.OnClick)
                end
            else
                Sounds_upv_1.Play("Error")
                tbl_upv_1.Shake(u28, 5)
                if a1.OnDisabledClick then
                    task.spawn(a1.OnDisabledClick)
                end
            end
        end
    )
    function tbl_upv_18.SetText(a5, a6)
        --[[
          name: SetText
          line: 1268
          upvalues:
            u35 (copy, index: 1)
            Loc_upv_1 (copy, index: 2)
        ]]
        local v130 = u35.RichText and (string.find(a6, "<", 1, true) ~= nil)
        u35.AutoLocalize = not v130
        local v131
        if v130 then
            v131 = Loc_upv_1.T(a6)
        else
            v131 = a6
        end
        u35.Text = v131
    end
    function tbl_upv_18.SetEnabled(a7, a8)
        --[[
          name: SetEnabled
          line: 1275
          upvalues:
            tbl_upv_18 (copy, index: 1)
            tbl_upv_16 (copy, index: 2)
            u31 (copy, index: 3)
            u29 (copy, index: 4)
            u32 (copy, index: 5)
            u35 (copy, index: 6)
            u36 (copy, index: 7)
            refresh (copy, index: 8)
        ]]
        a7.Enabled = a8
        local v132 = tbl_upv_16[((not (tbl_upv_18.Enabled)) and "Disabled") or (tbl_upv_18.Style)] or (tbl_upv_16.Primary)
        u31.Color = ColorSequence.new(v132.top, v132.bottom)
        u29.BackgroundColor3 = v132.lip
        u32.Color = v132.stroke
        u35.TextColor3 = v132.text
        u36.Transparency = 1
        refresh()
    end
    function tbl_upv_18.SetStyle(a9, a10)
        --[[
          name: SetStyle
          line: 1280
          upvalues:
            tbl_upv_18 (copy, index: 1)
            tbl_upv_16 (copy, index: 2)
            u31 (copy, index: 3)
            u29 (copy, index: 4)
            u32 (copy, index: 5)
            u35 (copy, index: 6)
            u36 (copy, index: 7)
        ]]
        a9.Style = a10
        local v133 = tbl_upv_16[((not (tbl_upv_18.Enabled)) and "Disabled") or (tbl_upv_18.Style)] or (tbl_upv_16.Primary)
        u31.Color = ColorSequence.new(v133.top, v133.bottom)
        u29.BackgroundColor3 = v133.lip
        u32.Color = v133.stroke
        u35.TextColor3 = v133.text
        u36.Transparency = 1
    end
    local v134 = tbl_upv_16[((not (tbl_upv_18.Enabled)) and "Disabled") or (tbl_upv_18.Style)] or (tbl_upv_16.Primary)
    u31.Color = ColorSequence.new(v134.top, v134.bottom)
    u29.BackgroundColor3 = v134.lip
    u32.Color = v134.stroke
    u35.TextColor3 = v134.text
    u36.Transparency = 1
    if a1.Parent then
        u28.Parent = a1.Parent
    end
    return tbl_upv_18
end
function tbl_upv_1.IconButton(a1)
    --[[
      name: IconButton
      line: 1292
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
        Fonts_upv_1 (copy, index: 3)
        Sounds_upv_1 (copy, index: 4)
        Theme_upv_1 (copy, index: 5)
    ]]
    local u40 = a1.Size or (UDim2.fromOffset(44, 44))
    local new_11 = tbl_upv_1.new
    local tbl_20 = {}
    tbl_20.Name = a1.Name or "IconButton"
    tbl_20.Size = u40
    tbl_20.Position = a1.Position or UDim2.new()
    tbl_20.AnchorPoint = a1.AnchorPoint or (Vector2.zero)
    tbl_20.BackgroundColor3 = a1.Color or (Colors_upv_1.Raised)
    tbl_20.BackgroundTransparency = a1.Transparency or 0.1
    tbl_20.Text = ((a1.IconName) and "") or (a1.Text or "")
    tbl_20.TextColor3 = a1.TextColor or (Colors_upv_1.Text)
    tbl_20.FontFace = a1.Font or (Fonts_upv_1.Display)
    tbl_20.TextSize = a1.TextSize or 26
    tbl_20.ZIndex = a1.ZIndex or 1
    tbl_20.LayoutOrder = a1.LayoutOrder or 0
    tbl_20.Visible = a1.Visible ~= false
    tbl_20[1] = tbl_upv_1.Corner(a1.Radius or 10)
    tbl_20.Parent = a1.Parent
    local u41 = new_11("TextButton", tbl_20)
    tbl_upv_1.Stroke(a1.StrokeColor or (Colors_upv_1.Stroke), 1, a1.StrokeTransparency or 0.85).Parent = u41
    if a1.IconName then
        local v136 = math.floor(u40.Y.Offset * (a1.IconScale or 0.5))
        tbl_upv_1.Icon(a1.IconName, v136, a1.TextColor or (Colors_upv_1.Text), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), ZIndex = a1.ZIndex, Parent = u41})
    end
    local HoverScale_2 = u41:FindFirstChild("HoverScale")
    if (HoverScale_2) and (HoverScale_2:IsA("UIScale")) then
        u40 = HoverScale_2
    else
        local v137 = Instance.new("UIScale")
        v137.Name = "HoverScale"
        v137.Parent = u41
        u40 = v137
    end
    local BackgroundColor3_upv_1 = u41.BackgroundColor3
    u41.MouseEnter:Connect(
        function()
            --[[
              line: 1323
              upvalues:
                tbl_upv_1 (copy, index: 1)
                Sounds_upv_1 (copy, index: 2)
                u40 (copy, index: 3)
                Theme_upv_1 (copy, index: 4)
                u41 (copy, index: 5)
                a1 (copy, index: 6)
                BackgroundColor3_upv_1 (copy, index: 7)
            ]]
            if not (tbl_upv_1.Touch) then
                Sounds_upv_1.Play("Hover")
            end
            tbl_upv_1.Tween(u40, Theme_upv_1.Tween.PopSmall, {Scale = 1.08})
            local Tween_2 = tbl_upv_1.Tween
            local Fast_2 = Theme_upv_1.Tween.Fast
            local tbl_21 = {BackgroundColor3 = 0}
            tbl_21.BackgroundColor3 = a1.HoverColor or Theme_upv_1.Lighten(BackgroundColor3_upv_1, 0.15)
            Tween_2(u41, Fast_2, tbl_21)
        end
    )
    u41.MouseLeave:Connect(
        function()
            --[[
              line: 1330
              upvalues:
                tbl_upv_1 (copy, index: 1)
                u40 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                u41 (copy, index: 4)
                BackgroundColor3_upv_1 (copy, index: 5)
            ]]
            tbl_upv_1.Tween(u40, Theme_upv_1.Tween.PopSmall, {Scale = 1})
            tbl_upv_1.Tween(u41, Theme_upv_1.Tween.Fast, {BackgroundColor3 = BackgroundColor3_upv_1})
        end
    )
    u41.MouseButton1Down:Connect(
        function()
            --[[
              line: 1334
              upvalues:
                tbl_upv_1 (copy, index: 1)
                u40 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            tbl_upv_1.Tween(u40, Theme_upv_1.Tween.Instant, {Scale = 0.9})
        end
    )
    u41.MouseButton1Up:Connect(
        function()
            --[[
              line: 1337
              upvalues:
                tbl_upv_1 (copy, index: 1)
                u40 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            tbl_upv_1.Tween(u40, Theme_upv_1.Tween.PopSmall, {Scale = 1})
        end
    )
    u41.Activated:Connect(
        function()
            --[[
              line: 1340
              upvalues:
                a1 (copy, index: 1)
                Sounds_upv_1 (copy, index: 2)
            ]]
            if a1.Sound ~= false then
                Sounds_upv_1.Play(a1.Sound or "Click")
            end
            if not a1.OnClick then
                return
            end
            task.spawn(a1.OnClick)
        end
    )
    return u41
end
local u42 = Color3.fromRGB(58, 63, 78)
function tbl_upv_1.Switch(a1)
    --[[
      name: Switch
      line: 1360
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u42 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
    ]]
    local v139 = a1 or {}
    local v140 = v139.Width or 60
    local v141 = v139.Height or (math.floor((v140 * 0.53) + 0.5))
    local u43 = math.max(3, math.floor((v141 * 0.12) + 0.5))
    local u44 = v141 - u43 * 2
    local new_12 = tbl_upv_1.new
    local tbl_22 = {}
    tbl_22.Name = v139.Name or "Switch"
    tbl_22.Size = UDim2.fromOffset(v140, v141)
    tbl_22.Position = v139.Position or UDim2.new()
    tbl_22.AnchorPoint = v139.AnchorPoint or (Vector2.zero)
    tbl_22.LayoutOrder = v139.LayoutOrder or 0
    tbl_22.ZIndex = v139.ZIndex or 1
    tbl_22.BackgroundColor3 = u42
    tbl_22[1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill)
    tbl_22.Parent = v139.Parent
    local u45 = new_12("Frame", tbl_22)
    local u46 = tbl_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
    u46.Parent = u45
    local tbl_23 = {}
    tbl_23.Name = "Knob"
    tbl_23.AnchorPoint = Vector2.new(0, 0.5)
    tbl_23.Position = UDim2.new(0, u43, 0.5, 0)
    tbl_23.Size = UDim2.fromOffset(u44, u44)
    tbl_23.BackgroundColor3 = Colors_upv_1.Bone
    tbl_23.ZIndex = (v139.ZIndex or 1) + 1
    tbl_23[1], tbl_23[2] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), tbl_upv_1.Stroke(Colors_upv_1.Void, 1, 0.8)
    tbl_23.Parent = u45
    local u47 = tbl_upv_1.new("Frame", tbl_23)
    local u48 = tbl_upv_1.Icon("check", math.floor(u44 * 0.56), Colors_upv_1.AccentDark, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Thickness = math.max(2, math.floor((u44 * 0.12) + 0.5)), ZIndex = (v139.ZIndex or 1) + 2, Parent = u47})
    u48.Visible = false
    local tbl_24 = {On = false}
    tbl_24.Instance = u45
    function tbl_24.Set(a2, a3, a4)
        --[[
          name: Set
          line: 1399
          upvalues:
            u43 (copy, index: 1)
            u44 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u42 (copy, index: 4)
            u47 (copy, index: 5)
            u45 (copy, index: 6)
            u46 (copy, index: 7)
            u48 (copy, index: 8)
            tbl_upv_1 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
        ]]
        local v143 = a3 ~= a2.On
        a2.On = a3
        local v144
        if a3 then
            v144 = UDim2.new(1, -(u43 + u44), 0.5, 0)
        else
            v144 = UDim2.new(0, u43, 0.5, 0)
        end
        local v145
        if a3 then
            v145 = Colors_upv_1.Accent
        else
            v145 = u42
        end
        local v146 = (a3 and 0.7) or 0.88
        if a4 then
            u47.Position = v144
            u45.BackgroundColor3 = v145
            u46.Transparency = v146
            u48.Visible = a3
        else
            tbl_upv_1.Tween(u47, Theme_upv_1.Tween.Smooth, {Position = v144})
            tbl_upv_1.Tween(u45, Theme_upv_1.Tween.Fast, {BackgroundColor3 = v145})
            tbl_upv_1.Tween(u46, Theme_upv_1.Tween.Fast, {Transparency = v146})
            u48.Visible = a3
            if a3 and v143 then
                tbl_upv_1.Pop(u48, 0.4, Theme_upv_1.Tween.PopSmall)
            end
        end
    end
    tbl_24:Set(v139.On == true, true)
    return tbl_24
end
function tbl_upv_1.Segmented(a1)
    --[[
      name: Segmented
      line: 1438
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u42 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
        Fonts_upv_1 (copy, index: 5)
    ]]
    local u49 = a1.Options or {}
    local v147 = math.max(#u49, 1)
    local v148 = a1.Width or 132
    local v149 = a1.Height or 36
    local v150 = a1.ZIndex or 1
    local new_13 = tbl_upv_1.new
    local tbl_25 = {}
    tbl_25.Name = a1.Name or "Segmented"
    tbl_25.Size = UDim2.fromOffset(v148, v149)
    tbl_25.Position = a1.Position or UDim2.new()
    tbl_25.AnchorPoint = a1.AnchorPoint or (Vector2.zero)
    tbl_25.LayoutOrder = a1.LayoutOrder or 0
    tbl_25.ZIndex = v150
    tbl_25.Visible = a1.Visible ~= false
    tbl_25.BackgroundColor3 = u42
    tbl_25[1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill)
    tbl_25.Parent = a1.Parent
    local v152 = new_13("Frame", tbl_25)
    tbl_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88).Parent = v152
    local u50 = (v148 - 6) / v147
    local tbl_26 = {}
    tbl_26.Name = "Knob"
    tbl_26.AnchorPoint = Vector2.new(0, 0.5)
    tbl_26.Position = UDim2.new(0, 3, 0.5, 0)
    tbl_26.Size = UDim2.fromOffset(u50, v149 - 6)
    tbl_26.BackgroundColor3 = Colors_upv_1.Accent
    tbl_26.ZIndex = v150 + 1
    tbl_26[1], tbl_26[2] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), tbl_upv_1.Stroke(Colors_upv_1.Void, 1, 0.8)
    tbl_26.Parent = v152
    local u51 = tbl_upv_1.new("Frame", tbl_26)
    local tbl_upv_27 = {Enabled = true, Value = ""}
    tbl_upv_27.Instance = v152
    tbl_upv_27.Buttons = {}
    local tbl_upv_28 = {}
    local u52 = nil
    local function paintLabels()
        --[[
          name: paintLabels
          line: 1473
          upvalues:
            tbl_upv_28 (copy, index: 1)
            tbl_upv_27 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u52 (ref,  index: 4)
        ]]
        local v153 = nil
        for key_12, value_15 in tbl_upv_28 do
            local v154 = key_12 == tbl_upv_27.Value
            if not v154 and (u52 ~= key_12 or not (tbl_upv_27.Enabled)) then
                v153 = Colors_upv_1.TextDim
                value_15.TextColor3 = v153
                if tbl_upv_27.Enabled then
                    v153 = 0
                    value_15.TextTransparency = v153
                    continue
                end
                if v154 then
                    v153 = 0
                else
                    v153 = 0.3
                end
                value_15.TextTransparency = v153
            end
            v153 = Colors_upv_1.Text
            value_15.TextColor3 = v153
            if tbl_upv_27.Enabled or v154 then
                v153 = 0
            else
                v153 = 0.3
            end
            value_15.TextTransparency = v153
        end
    end
    for key_13, value_16 in u49 do
        local str_upv_1 = tostring(value_16.id)
        local v155 = tbl_upv_1.new("TextButton", {Name = "Option_" .. str_upv_1, Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.new(0, 3 + ((key_13 - 1) * u50), 0, 0), Size = UDim2.new(0, u50, 1, 0), ZIndex = v150 + 2, [1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v152})
        local new_14 = tbl_upv_1.new
        local tbl_29 = {ZIndex = 0, Name = "Label", TextColor3 = 0, Parent = 0, TextSize = 0}
        tbl_29.Size = UDim2.fromScale(1, 1)
        tbl_29.Text = tostring(value_16.text or str_upv_1)
        tbl_29.FontFace = Fonts_upv_1.Heavy
        tbl_29.TextSize = a1.TextSize or math.floor((v149 * 0.47) + 0.5)
        tbl_29.TextColor3 = Colors_upv_1.TextDim
        tbl_29.ZIndex = v150 + 3
        tbl_29.Parent = v155
        tbl_upv_28[str_upv_1] = new_14("TextLabel", tbl_29)
        tbl_upv_27.Buttons[str_upv_1] = v155
        v155.MouseEnter:Connect(
            function()
                --[[
                  line: 1504
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    u52 (ref,  index: 2)
                    str_upv_1 (copy, index: 3)
                    paintLabels (copy, index: 4)
                ]]
                if (tbl_upv_1.Touch) then
                    return
                end
                u52 = str_upv_1
                paintLabels()
            end
        )
        v155.MouseLeave:Connect(
            function()
                --[[
                  line: 1510
                  upvalues:
                    u52 (ref,  index: 1)
                    str_upv_1 (copy, index: 2)
                    paintLabels (copy, index: 3)
                ]]
                if u52 ~= str_upv_1 then
                    return
                end
                u52 = nil
                paintLabels()
            end
        )
        v155.Activated:Connect(
            function()
                --[[
                  line: 1516
                  upvalues:
                    tbl_upv_27 (copy, index: 1)
                    str_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                ]]
                if not tbl_upv_27.Enabled or str_upv_1 == tbl_upv_27.Value or not a1.OnSelect then
                    return
                end
                a1.OnSelect(str_upv_1)
            end
        )
    end
    function tbl_upv_27.Set(a2, a3, a4)
        --[[
          name: Set
          line: 1522
          upvalues:
            u49 (copy, index: 1)
            u50 (copy, index: 2)
            u51 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            tbl_upv_28 (copy, index: 6)
            paintLabels (copy, index: 7)
        ]]
        local v157 = 1
        for key_14, value_17 in u49 do
            if tostring(value_17.id) == a3 then
                v157 = key_14
            end
        end
        local v158 = a3 ~= a2.Value
        a2.Value = a3
        local v159 = UDim2.new(0, 3 + ((v157 - 1) * u50), 0.5, 0)
        if a4 then
            u51.Position = v159
        else
            tbl_upv_1.Tween(u51, Theme_upv_1.Tween.Smooth, {Position = v159})
            if v158 then
                v157 = tbl_upv_28[a3]
                if v157 then
                    tbl_upv_1.Pop(v157, 0.85, Theme_upv_1.Tween.PopSmall)
                end
            end
        end
        paintLabels()
    end
    function tbl_upv_27.SetEnabled(a5, a6)
        --[[
          name: SetEnabled
          line: 1545
          upvalues:
            u51 (copy, index: 1)
            paintLabels (copy, index: 2)
        ]]
        a5.Enabled = a6
        for _, value_18 in a5.Buttons do
            value_18.Selectable = a6
        end
        u51.BackgroundTransparency = (a6 and 0) or 0.35
        paintLabels()
    end
    tbl_upv_27:Set(tostring(a1.Selected or (((u49[1]) and (u49[1].id)) or "")), true)
    return tbl_upv_27
end
local tbl_upv_30 = {}
local tbl_upv_31 = {}
local tbl_upv_32 = {}
local capVisible = nil
tbl_upv_1.TouchChanged:Connect(
    function()
        --[[
          line: 1564
          upvalues:
            tbl_upv_30 (copy, index: 1)
            capVisible (ref,  index: 2)
        ]]
        for key_15 in tbl_upv_30 do
            key_15.Visible = capVisible(key_15)
        end
    end
)
local tbl_upv_33 = {}
local function lastIsGamepad()
    --[[
      name: lastIsGamepad
      line: 1570
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.Gamepad
end
local tbl_upv_34 = {}
tbl_upv_34[Enum.KeyCode.ButtonSelect] = "VIEW"
tbl_upv_34[Enum.KeyCode.ButtonStart] = "MENU"
tbl_upv_34[Enum.KeyCode.ButtonA] = "A"
tbl_upv_34[Enum.KeyCode.ButtonB] = "B"
tbl_upv_34[Enum.KeyCode.ButtonX] = "X"
tbl_upv_34[Enum.KeyCode.ButtonY] = "Y"
tbl_upv_34[Enum.KeyCode.ButtonL1] = "LB"
tbl_upv_34[Enum.KeyCode.ButtonR1] = "RB"
tbl_upv_34[Enum.KeyCode.ButtonL2] = "LT"
tbl_upv_34[Enum.KeyCode.ButtonR2] = "RT"
tbl_upv_34[Enum.KeyCode.ButtonL3] = "LS"
tbl_upv_34[Enum.KeyCode.ButtonR3] = "RS"
local tbl_upv_35 = {}
local tbl_upv_36 = {}
local tbl_upv_37 = {}
local function setCapBare(a1, a2)
    --[[
      name: setCapBare
      line: 1588
      upvalues:
        tbl_upv_36 (copy, index: 1)
        tbl_upv_35 (copy, index: 2)
        tbl_upv_37 (copy, index: 3)
    ]]
    tbl_upv_36[a1] = a2
    local v160 = (a2 and 1) or (tbl_upv_35[a1] or 0.25)
    a1.BackgroundTransparency = v160 + ((1 - v160) * (tbl_upv_37[a1] or 0))
    local v161 = a1:FindFirstChildOfClass("UIStroke")
    if not v161 then
        return
    end
    v161.Enabled = not a2
end
local function mouseImageFor(a1)
    --[[
      name: mouseImageFor
      line: 1633
      upvalues:
        u1 (ref, index: 1)
    ]]
    local Mouse_1 = u1.Mouse
    if type(Mouse_1) == "table" then
        if a1 ~= "M1" then
            if a1 ~= "M2" then
                return nil
            end
            return Mouse_1.Right
        end
        return Mouse_1.Left
    end
    return nil
end
capVisible = function(a1)
    --[[
      name: capVisible
      line: 1647
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_33 (copy, index: 2)
        tbl_upv_32 (copy, index: 3)
        tbl_upv_31 (copy, index: 4)
    ]]
    if tbl_upv_1.Touch then
        return false
    end
    if tbl_upv_33[a1] == nil then
        return not tbl_upv_31[a1] and (not tbl_upv_1.Gamepad)
    elseif tbl_upv_1.Gamepad then
        return not tbl_upv_32[a1]
    else
        return not tbl_upv_31[a1]
    end
end
local function paintPadCap(a1, a2)
    --[[
      name: paintPadCap
      line: 1597
      upvalues:
        tbl_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        tbl_upv_34 (copy, index: 3)
        tbl_upv_36 (copy, index: 4)
        tbl_upv_35 (copy, index: 5)
        tbl_upv_37 (copy, index: 6)
    ]]
    local Key_1 = a1:FindFirstChild("Key")
    local Glyph_1 = a1:FindFirstChild("Glyph")
    local v162 = a1:FindFirstChild("Mouse")
    if not Key_1 then
        return
    end
    if Glyph_1 then
        local v163 = ""
        local Offset_1
        if tbl_upv_1.Gamepad then
            local v164
            Offset_1, v164 = pcall(
                function()
                    --[[
                      line: 1606
                      upvalues:
                        UserInputService_upv_1 (copy, index: 1)
                        a2 (copy, index: 2)
                    ]]
                    return UserInputService_upv_1:GetImageForKeyCode(a2.code)
                end
            )
            if (Offset_1) and type(v164) == "string" then
                v163 = v164
            else
                v163 = ""
            end
            if v163 == "" then
                Key_1.Text = tbl_upv_34[a2.code] or (a2.code.Name)
            end
        else
            Key_1.Text = a2.key
        end
        Glyph_1.Image = v163
        if v163 ~= "" then
            Offset_1 = true
        else
            Offset_1 = false
        end
        Glyph_1.Visible = Offset_1
        Glyph_1 = (v162 ~= nil) and (v163 == "")
        if v162 then
            v162.Visible = Glyph_1
        end
        Key_1.Visible = (v163 == "") and (not Glyph_1)
        local v165 = true
        if v163 ~= "" then
            Offset_1 = v165
        else
            Offset_1 = Glyph_1
        end
        tbl_upv_36[a1] = Offset_1
        if Offset_1 then
            v162 = 1
        else
            v162 = tbl_upv_35[a1] or 0.25
        end
        a1.BackgroundTransparency = v162 + ((1 - v162) * (tbl_upv_37[a1] or 0))
        v162 = a1:FindFirstChildOfClass("UIStroke")
        if v162 then
            v162.Enabled = not Offset_1
        end
        Offset_1 = a1.Size.Y.Offset
        local fromOffset_1 = UDim2.fromOffset
        local v166
        if v163 == "" then
            if Glyph_1 then
                v166 = Offset_1
            else
                v166 = math.max(Offset_1, (#Key_1.Text * (Offset_1 * 0.4)) + 12)
            end
        else
            v166 = Offset_1 + 4
        end
        a1.Size = fromOffset_1(v166, Offset_1)
    end
end
tbl_upv_1.GamepadChanged:Connect(
    function()
        --[[
          line: 1659
          upvalues:
            tbl_upv_33 (copy, index: 1)
            paintPadCap (copy, index: 2)
            tbl_upv_30 (copy, index: 3)
            capVisible (ref,  index: 4)
        ]]
        for key_16, value_19 in tbl_upv_33 do
            paintPadCap(key_16, value_19)
        end
        for key_17 in tbl_upv_30 do
            key_17.Visible = capVisible(key_17)
        end
    end
)
function tbl_upv_1.KeyCap(a1, a2)
    --[[
      name: KeyCap
      line: 1667
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        Colors_upv_1 (copy, index: 3)
        tbl_upv_35 (copy, index: 4)
        tbl_upv_36 (copy, index: 5)
        tbl_upv_37 (copy, index: 6)
        Fonts_upv_1 (copy, index: 7)
        tbl_upv_30 (copy, index: 8)
        tbl_upv_33 (copy, index: 9)
        paintPadCap (copy, index: 10)
        capVisible (ref,  index: 11)
    ]]
    local v167 = a2 or {}
    local v168 = v167.Height or 24
    local Mouse_2 = u1.Mouse
    local v169
    if type(Mouse_2) == "table" then
        if a1 == "M1" then
            v169 = Mouse_2.Left
        elseif a1 ~= "M2" then
            v169 = nil
        else
            v169 = Mouse_2.Right
        end
    else
        v169 = nil
    end
    local new_15 = tbl_upv_1.new
    local tbl_38 = {}
    tbl_38.Name = "KeyCap"
    tbl_38.Visible = not tbl_upv_1.Touch
    local fromOffset_2 = UDim2.fromOffset
    local v170
    if v169 then
        v170 = v168
    else
        v170 = math.max(v168, (#a1 * (v168 * 0.4)) + 12)
    end
    tbl_38.Size = fromOffset_2(v170, v168)
    tbl_38.BackgroundColor3 = v167.Color or (Colors_upv_1.Void)
    tbl_38.BackgroundTransparency = v167.Transparency or 0.25
    tbl_38.Position = v167.Position or UDim2.new()
    tbl_38.AnchorPoint = v167.AnchorPoint or (Vector2.zero)
    tbl_38.LayoutOrder = v167.LayoutOrder or 0
    tbl_38.ZIndex = v167.ZIndex or 1
    tbl_38[1], tbl_38[2] = tbl_upv_1.Corner(v167.Radius or 6), tbl_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.75)
    tbl_38.Parent = v167.Parent
    local u53 = new_15("Frame", tbl_38)
    tbl_upv_35[u53] = v167.Transparency or 0.25
    u53.Destroying:Connect(
        function()
            --[[
              line: 1686
              upvalues:
                tbl_upv_35 (copy, index: 1)
                u53 (copy, index: 2)
                tbl_upv_36 (copy, index: 3)
                tbl_upv_37 (copy, index: 4)
            ]]
            tbl_upv_35[u53] = nil
            tbl_upv_36[u53] = nil
            tbl_upv_37[u53] = nil
        end
    )
    local new_16 = tbl_upv_1.new
    local tbl_39 = {AutoLocalize = false, TextColor3 = 0, Parent = 0, Name = "Key", ZIndex = 0, TextSize = 0, Size = 0}
    tbl_39.Text = a1
    tbl_39.FontFace = Fonts_upv_1.Heavy
    tbl_39.TextSize = v167.TextSize or math.floor(v168 * 0.66)
    tbl_39.TextColor3 = Colors_upv_1.Text
    tbl_39.Size = UDim2.fromScale(1, 1)
    tbl_39.ZIndex = v167.ZIndex or 1
    tbl_39.Parent = u53
    new_16("TextLabel", tbl_39)
    if v169 then
        tbl_upv_1.new("ImageLabel", {Name = "Mouse", BackgroundTransparency = 1, Image = v169, Size = UDim2.fromOffset(v168 + 10, v168 + 10), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = v167.ZIndex or 1, Parent = u53})
        u53:FindFirstChild("Key").Visible = false
        tbl_upv_36[u53] = true
        u53.BackgroundTransparency = 1 + (0 * (tbl_upv_37[u53] or 0))
        local v173 = u53:FindFirstChildOfClass("UIStroke")
        if v173 then
            v173.Enabled = false
        end
    end
    if not (v167.Managed) then
        tbl_upv_30[u53] = true
        u53.Destroying:Connect(
            function()
                --[[
                  line: 1719
                  upvalues:
                    tbl_upv_30 (copy, index: 1)
                    u53 (copy, index: 2)
                ]]
                tbl_upv_30[u53] = nil
            end
        )
    end
    if typeof(v167.Gamepad) == "EnumItem" then
        tbl_upv_1.new("ImageLabel", {Visible = false, Name = "Glyph", BackgroundTransparency = 1, Size = UDim2.new(1, 4, 1, 4), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = v167.ZIndex or 1, Parent = u53})
        local tbl_40 = {}
        tbl_40.key = a1
        tbl_40.code = v167.Gamepad
        tbl_40.width = u53.Size.X.Offset
        tbl_upv_33[u53] = tbl_40
        u53.Destroying:Connect(
            function()
                --[[
                  line: 1737
                  upvalues:
                    tbl_upv_33 (copy, index: 1)
                    u53 (copy, index: 2)
                ]]
                tbl_upv_33[u53] = nil
            end
        )
        paintPadCap(u53, tbl_40)
    elseif not (v167.Managed) then
        u53.Visible = capVisible(u53)
    end
    return u53
end
function tbl_upv_1.SetCapKey(a1, a2)
    --[[
      name: SetCapKey
      line: 1749
      upvalues:
        tbl_upv_31 (copy, index: 1)
        capVisible (ref,  index: 2)
        u1 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        tbl_upv_37 (copy, index: 5)
        tbl_upv_33 (copy, index: 6)
        paintPadCap (copy, index: 7)
        tbl_upv_36 (copy, index: 8)
        tbl_upv_35 (copy, index: 9)
    ]]
    if a2 ~= nil then
        if tbl_upv_31[a1] then
            tbl_upv_31[a1] = nil
            a1.Visible = capVisible(a1)
        end
        local Offset_2 = a1.Size.Y.Offset
        local Key_2 = a1:FindFirstChild("Key")
        local v174 = u1.Mouse
        local v175
        if type(v174) == "table" then
            if a2 == "M1" then
                v175 = v174.Left
            elseif a2 ~= "M2" then
                v175 = nil
            else
                v175 = v174.Right
            end
        else
            v175 = nil
        end
        local Mouse_3 = a1:FindFirstChild("Mouse")
        if v175 then
            v174 = Mouse_3 or (tbl_upv_1.new("ImageLabel", {Name = "Mouse", BackgroundTransparency = 1, ImageTransparency = tbl_upv_37[a1] or 0, Size = UDim2.fromOffset(Offset_2 + 10, Offset_2 + 10), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, ZIndex = a1.ZIndex, Parent = a1}))
            v174.Image = v175
        elseif Mouse_3 then
            Mouse_3:Destroy()
        end
        if Key_2 then
            Key_2.Text = a2
        end
        local v176 = tbl_upv_33[a1]
        if v176 then
            v176.key = a2
            paintPadCap(a1, v176)
        else
            if Key_2 then
                Key_2.Visible = v175 == nil
            end
            local v177 = v175 ~= nil
            tbl_upv_36[a1] = v177
            if v177 then
                v174 = 1
            else
                v174 = tbl_upv_35[a1] or 0.25
            end
            a1.BackgroundTransparency = v174 + ((1 - v174) * (tbl_upv_37[a1] or 0))
            v174 = a1:FindFirstChildOfClass("UIStroke")
            if v174 then
                v174.Enabled = not v177
            end
            local v178
            if v175 then
                v178 = Offset_2
            else
                v178 = math.max(Offset_2, (#a2 * (Offset_2 * 0.4)) + 12)
            end
            a1.Size = UDim2.fromOffset(v178, Offset_2)
        end
    else
        tbl_upv_31[a1] = true
        a1.Visible = capVisible(a1)
    end
end
function tbl_upv_1.PadCap(a1, a2)
    --[[
      name: PadCap
      line: 1799
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v179 = table.clone(a2 or {})
    v179.Gamepad = a1
    local v180 = tbl_upv_1.KeyCap("", v179)
    tbl_upv_1.SetCapKey(v180, nil)
    return v180
end
function tbl_upv_1.SetCapFade(a1, a2)
    --[[
      name: SetCapFade
      line: 1810
      upvalues:
        tbl_upv_37 (copy, index: 1)
        tbl_upv_36 (copy, index: 2)
        tbl_upv_35 (copy, index: 3)
    ]]
    local v181 = math.clamp(a2, 0, 1)
    local v182
    if v181 > 0 then
        v182 = v181
    else
        v182 = nil
    end
    tbl_upv_37[a1] = v182
    local v183 = tbl_upv_36[a1] == true
    tbl_upv_36[a1] = v183
    local v184
    if v183 then
        v184 = 1
    else
        v184 = tbl_upv_35[a1] or 0.25
    end
    a1.BackgroundTransparency = v184 + ((1 - v184) * (tbl_upv_37[a1] or 0))
    local v185 = a1:FindFirstChildOfClass("UIStroke")
    if v185 then
        v185.Enabled = not v183
    end
    local v186 = a1:FindFirstChildOfClass("UIStroke")
    if v186 then
        v186.Transparency = (v181 * 0.25) + 0.75
    end
    for _, value_20 in a1:GetChildren() do
        if value_20:IsA("TextLabel") then
            value_20.TextTransparency = v181
            continue
        end
        if value_20:IsA("ImageLabel") then
            value_20.ImageTransparency = v181
        end
    end
end
function tbl_upv_1.SetCapPad(a1, a2)
    --[[
      name: SetCapPad
      line: 1829
      upvalues:
        tbl_upv_33 (copy, index: 1)
        tbl_upv_32 (copy, index: 2)
        paintPadCap (copy, index: 3)
        capVisible (ref,  index: 4)
    ]]
    local v187 = tbl_upv_33[a1]
    if not v187 then
        return
    end
    tbl_upv_32[a1] = ((not a2) and true) or nil
    if a2 then
        v187.code = a2
    end
    paintPadCap(a1, v187)
    a1.Visible = capVisible(a1)
end
function tbl_upv_1.ActionCap(a1, a2)
    --[[
      name: ActionCap
      line: 1845
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_31 (copy, index: 3)
        tbl_upv_32 (copy, index: 4)
    ]]
    local v188 = Keybinds_upv_1.PadAction(a1) ~= nil
    local v189
    if v188 then
        v189 = table.clone(a2 or {})
        v189.Gamepad = Keybinds_upv_1.PadCode(a1) or v189.Gamepad or Enum.KeyCode.ButtonA
    else
        v189 = a2
    end
    local u54 = tbl_upv_1.KeyCap(Keybinds_upv_1.CapText(a1) or "?", v189)
    tbl_upv_1.SetCapKey(u54, Keybinds_upv_1.CapText(a1))
    if v188 then
        tbl_upv_1.SetCapPad(u54, Keybinds_upv_1.PadCode(a1))
    end
    local u55 = Keybinds_upv_1.Changed:Connect(
        function(a3)
            --[[
              line: 1857
              upvalues:
                a1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
                u54 (copy, index: 3)
                Keybinds_upv_1 (copy, index: 4)
            ]]
            if not table.find(a3, a1) then
                return
            end
            tbl_upv_1.SetCapKey(u54, Keybinds_upv_1.CapText(a1))
        end
    )
    local u56
    if v188 then
        u56 = Keybinds_upv_1.PadChanged:Connect(
            function(a4)
                --[[
                  line: 1863
                  upvalues:
                    a1 (copy, index: 1)
                    tbl_upv_1 (copy, index: 2)
                    u54 (copy, index: 3)
                    Keybinds_upv_1 (copy, index: 4)
                ]]
                if not table.find(a4, a1) then
                    return
                end
                tbl_upv_1.SetCapPad(u54, Keybinds_upv_1.PadCode(a1))
            end
        )
    else
        u56 = nil
    end
    u54.Destroying:Connect(
        function()
            --[[
              line: 1869
              upvalues:
                u55 (copy, index: 1)
                u56 (copy, index: 2)
                tbl_upv_31 (copy, index: 3)
                u54 (copy, index: 4)
                tbl_upv_32 (copy, index: 5)
            ]]
            u55:Disconnect()
            if u56 then
                u56:Disconnect()
            end
            tbl_upv_31[u54] = nil
            tbl_upv_32[u54] = nil
        end
    )
    return u54
end
function tbl_upv_1.CapInfo(a1)
    --[[
      name: CapInfo
      line: 1881
      upvalues:
        tbl_upv_33 (copy, index: 1)
        tbl_upv_30 (copy, index: 2)
        tbl_upv_32 (copy, index: 3)
        tbl_upv_31 (copy, index: 4)
    ]]
    local v191 = tbl_upv_33[a1]
    if not (v191) and not (tbl_upv_30[a1]) then
        return nil
    end
    local Glyph_2 = a1:FindFirstChild("Glyph")
    local tbl_41 = {pad = 0, key = 0, visible = 0, unbound = 0, glyph = 0, padUnbound = 0}
    local v192
    if v191 then
        v192 = v191.key
    else
        v192 = a1:FindFirstChild("Key") and (a1:FindFirstChild("Key").Text)
    end
    tbl_41.key = v192
    local v193
    if v191 then
        v193 = v191.code.Name
    else
        v193 = false
    end
    tbl_41.pad = v193
    tbl_41.padUnbound = tbl_upv_32[a1] == true
    tbl_41.unbound = tbl_upv_31[a1] == true
    tbl_41.visible = a1.Visible
    if (Glyph_2) and (Glyph_2.Visible) then
        v193 = Glyph_2.Image
    else
        v193 = false
    end
    tbl_41.glyph = v193
    return tbl_41
end
function tbl_upv_1.PadActionCap(a1, a2)
    --[[
      name: PadActionCap
      line: 1899
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Keybinds_upv_1 (copy, index: 2)
        tbl_upv_32 (copy, index: 3)
    ]]
    local PadCap_1 = tbl_upv_1.PadCap
    local v194 = Keybinds_upv_1.PadCode(a1) or (Enum.KeyCode.ButtonA)
    local u57 = PadCap_1(v194, a2)
    tbl_upv_1.SetCapPad(u57, Keybinds_upv_1.PadCode(a1))
    local u58 = Keybinds_upv_1.PadChanged:Connect(
        function(a3)
            --[[
              line: 1902
              upvalues:
                a1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
                u57 (copy, index: 3)
                Keybinds_upv_1 (copy, index: 4)
            ]]
            if not table.find(a3, a1) then
                return
            end
            tbl_upv_1.SetCapPad(u57, Keybinds_upv_1.PadCode(a1))
        end
    )
    u57.Destroying:Connect(
        function()
            --[[
              line: 1907
              upvalues:
                u58 (copy, index: 1)
                tbl_upv_32 (copy, index: 2)
                u57 (copy, index: 3)
            ]]
            u58:Disconnect()
            tbl_upv_32[u57] = nil
        end
    )
    return u57
end
function tbl_upv_1.Pill(a1, a2, a3)
    --[[
      name: Pill
      line: 1915
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
        Fonts_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
    ]]
    local v195 = a3 or {}
    local new_17 = tbl_upv_1.new
    local tbl_42 = {}
    tbl_42.Name = v195.Name or "Pill"
    tbl_42.AutomaticSize = Enum.AutomaticSize.X
    tbl_42.Size = UDim2.fromOffset(0, v195.Height or 22)
    tbl_42.Position = v195.Position or UDim2.new()
    tbl_42.AnchorPoint = v195.AnchorPoint or (Vector2.zero)
    tbl_42.BackgroundColor3 = a2
    tbl_42.BackgroundTransparency = v195.Transparency or 0.1
    tbl_42.LayoutOrder = v195.LayoutOrder or 0
    tbl_42.ZIndex = v195.ZIndex or 1
    tbl_42[1], tbl_42[2] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), tbl_upv_1.Padding(0, v195.PadX or 9, 0, v195.PadX or 9)
    tbl_42.Parent = v195.Parent
    local v197 = new_17("Frame", tbl_42)
    local new_18 = tbl_upv_1.new
    local tbl_43 = {FontFace = 0, AutoLocalize = 0, TextColor3 = 0, Parent = 0, Name = "Text", AutomaticSize = 0, ZIndex = 0, TextSize = 0, Size = 0}
    tbl_43.Text = string.upper(a1)
    tbl_43.AutoLocalize = v195.AutoLocalize ~= false
    tbl_43.FontFace = v195.Font or (Fonts_upv_1.Heavy)
    tbl_43.TextSize = v195.TextSize or 14
    tbl_43.TextColor3 = v195.TextColor or (Colors_upv_1.Text)
    tbl_43.AutomaticSize = Enum.AutomaticSize.X
    tbl_43.Size = UDim2.fromScale(0, 1)
    tbl_43.ZIndex = v195.ZIndex or 1
    tbl_43.Parent = v197
    new_18("TextLabel", tbl_43)
    return v197
end
function tbl_upv_1.ShellAmount(a1, a2)
    --[[
      name: ShellAmount
      line: 1947
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        Fonts_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
    ]]
    local v198 = a2 or {}
    local v199 = v198.TextSize or 22
    local new_19 = tbl_upv_1.new
    local tbl_44 = {}
    tbl_44.Name = "Shells"
    tbl_44.AutomaticSize = Enum.AutomaticSize.X
    tbl_44.Size = UDim2.fromOffset(0, v199 + 6)
    tbl_44.LayoutOrder = v198.LayoutOrder or 0
    tbl_44.Position = v198.Position or UDim2.new()
    tbl_44.AnchorPoint = v198.AnchorPoint or (Vector2.zero)
    tbl_44.ZIndex = v198.ZIndex or 1
    tbl_44[1] = tbl_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    tbl_44.Parent = v198.Parent
    local v201 = new_19("Frame", tbl_44)
    tbl_upv_1.Image(u1.Icons.Shell, {LayoutOrder = 0, Name = "Icon", Size = UDim2.fromOffset(math.floor(v199 * 1.15), math.floor(v199 * 1.15)), ZIndex = v198.ZIndex or 1, Parent = v201})
    local new_20 = tbl_upv_1.new
    local tbl_45 = {LayoutOrder = 1, FontFace = 0, TextColor3 = 0, Parent = 0, Name = "Amount", AutomaticSize = 0, ZIndex = 0, TextSize = 0, Size = 0}
    tbl_45.Text = tbl_upv_1.FormatNumber(a1)
    tbl_45.FontFace = v198.Font or (Fonts_upv_1.Display)
    tbl_45.TextSize = v199
    tbl_45.TextColor3 = v198.Color or (Colors_upv_1.Shell)
    tbl_45.AutomaticSize = Enum.AutomaticSize.X
    tbl_45.Size = UDim2.fromScale(0, 1)
    tbl_45.ZIndex = v198.ZIndex or 1
    tbl_45.Parent = v201
    local v202 = new_20("TextLabel", tbl_45)
    if v198.Stroke ~= false then
        tbl_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = v202
    end
    return v201, v202
end
function tbl_upv_1.LevelBadge(a1, a2, a3)
    --[[
      name: LevelBadge
      line: 1987
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
        Colors_upv_1 (copy, index: 3)
        Fonts_upv_1 (copy, index: 4)
    ]]
    local v203 = a3 or {}
    local new_21 = tbl_upv_1.new
    local tbl_46 = {AnchorPoint = 0, Name = "LevelBadge", Position = 0, Parent = 0, ZIndex = 0, LayoutOrder = 0}
    tbl_46.Size = UDim2.fromOffset(a2, a2)
    tbl_46.Position = v203.Position or UDim2.new()
    tbl_46.AnchorPoint = v203.AnchorPoint or (Vector2.zero)
    tbl_46.LayoutOrder = v203.LayoutOrder or 0
    tbl_46.ZIndex = v203.ZIndex or 1
    tbl_46.Parent = v203.Parent
    local v205 = new_21("Frame", tbl_46)
    local tbl_47 = {}
    tbl_47.Name = "Disc"
    tbl_47.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_47.Position = UDim2.fromScale(0.5, 0.5)
    tbl_47.Size = UDim2.fromScale(0.86, 0.86)
    tbl_47.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_47.ZIndex = v203.ZIndex or 1
    tbl_47[1], tbl_47[2], tbl_47[3] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), tbl_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.12), Colors_upv_1.AccentDark, 90), tbl_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.75)
    tbl_47.Parent = v205
    tbl_upv_1.new("Frame", tbl_47)
    local new_22 = tbl_upv_1.new
    local tbl_48 = {ZIndex = 0, Name = "Level", TextColor3 = 0, Parent = 0, TextSize = 0}
    tbl_48.Size = UDim2.fromScale(1, 1)
    tbl_48.Text = tostring(a1)
    tbl_48.FontFace = Fonts_upv_1.Display
    tbl_48.TextSize = math.floor(a2 * (((a1 >= 100) and 0.34) or 0.42))
    tbl_48.TextColor3 = Colors_upv_1.Text
    tbl_48.ZIndex = (v203.ZIndex or 1) + 1
    tbl_48.Parent = v205
    return v205, (new_22("TextLabel", tbl_48))
end
local function line(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: line
      line: 2028
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Theme_upv_1 (copy, index: 2)
    ]]
    local v206 = a3 * a2
    local v207 = a4 * a2
    local v208 = (v206 + v207) / 2
    local v209 = v207 - v206
    local tbl_49 = {}
    tbl_49.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_49.Position = UDim2.fromOffset(v208.X, v208.Y)
    tbl_49.Size = UDim2.fromOffset(v209.Magnitude + a5, a5)
    tbl_49.Rotation = math.deg(math.atan2(v209.Y, v209.X))
    tbl_49.BackgroundColor3 = a6
    tbl_49.ZIndex = a7 or 1
    tbl_49[1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill)
    tbl_49.Parent = a1
    tbl_upv_1.new("Frame", tbl_49)
end
function tbl_upv_1.Icon(a1, a2, a3, a4)
    --[[
      name: Icon
      line: 2045
      upvalues:
        Colors_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        line (copy, index: 3)
        Theme_upv_1 (copy, index: 4)
    ]]
    local v210 = a4 or {}
    local v211 = a3 or (Colors_upv_1.Text)
    local v212 = v210.Thickness or (math.max(2, math.floor(a2 * 0.16 + 0.5)))
    local v213 = v210.ZIndex or 1
    local new_23 = tbl_upv_1.new
    local tbl_50 = {AnchorPoint = 0, Position = 0, Parent = 0, ZIndex = 0, LayoutOrder = 0}
    tbl_50.Name = "Icon_" .. a1
    tbl_50.Size = UDim2.fromOffset(a2, a2)
    tbl_50.Position = v210.Position or UDim2.new()
    tbl_50.AnchorPoint = v210.AnchorPoint or (Vector2.zero)
    tbl_50.LayoutOrder = v210.LayoutOrder or 0
    tbl_50.ZIndex = v213
    tbl_50.Parent = v210.Parent
    local v215 = new_23("Frame", tbl_50)
    local new_24 = Vector2.new
    if a1 == "cross" then
        line(v215, a2, new_24(0.2, 0.2), new_24(0.8, 0.8), v212, v211, v213)
        line(v215, a2, new_24(0.8, 0.2), new_24(0.2, 0.8), v212, v211, v213)
    elseif a1 == "check" then
        line(v215, a2, new_24(0.18, 0.52), new_24(0.42, 0.76), v212, v211, v213)
        line(v215, a2, new_24(0.42, 0.76), new_24(0.84, 0.26), v212, v211, v213)
    elseif a1 == "minus" then
        line(v215, a2, new_24(0.18, 0.5), new_24(0.82, 0.5), v212, v211, v213)
    elseif a1 == "plus" then
        line(v215, a2, new_24(0.5, 0.16), new_24(0.5, 0.84), v212, v211, v213)
        line(v215, a2, new_24(0.16, 0.5), new_24(0.84, 0.5), v212, v211, v213)
    elseif a1 == "chevLeft" then
        line(v215, a2, new_24(0.64, 0.2), new_24(0.34, 0.5), v212, v211, v213)
        line(v215, a2, new_24(0.34, 0.5), new_24(0.64, 0.8), v212, v211, v213)
    elseif a1 == "chevRight" then
        line(v215, a2, new_24(0.36, 0.2), new_24(0.66, 0.5), v212, v211, v213)
        line(v215, a2, new_24(0.66, 0.5), new_24(0.36, 0.8), v212, v211, v213)
    elseif a1 == "chevUp" then
        line(v215, a2, new_24(0.22, 0.64), new_24(0.5, 0.34), v212, v211, v213)
        line(v215, a2, new_24(0.5, 0.34), new_24(0.78, 0.64), v212, v211, v213)
    elseif a1 == "chevDown" then
        line(v215, a2, new_24(0.22, 0.36), new_24(0.5, 0.66), v212, v211, v213)
        line(v215, a2, new_24(0.5, 0.66), new_24(0.78, 0.36), v212, v211, v213)
    elseif a1 == "pencil" then
        line(v215, a2, new_24(0.3, 0.7), new_24(0.76, 0.24), v212 * 1.25, v211, v213)
        line(v215, a2, new_24(0.22, 0.78), new_24(0.3, 0.7), math.max(1, v212 * 0.7), v211, v213)
        line(v215, a2, new_24(0.16, 0.9), new_24(0.84, 0.9), math.max(1, v212 * 0.6), v211, v213)
    elseif a1 == "gear" then
        for n_1 = 0, 3 do
            local v216 = math.rad(n_1 * 45)
            local v217 = new_24(math.cos(v216), math.sin(v216)) * 0.4
            line(v215, a2, new_24(0.5, 0.5) - v217, new_24(0.5, 0.5) + v217, math.max(3, math.floor(a2 * 0.2)), v211, v213)
        end
        tbl_upv_1.new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), BackgroundColor3 = v211, ZIndex = v213, [1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v215})
        local new_25 = tbl_upv_1.new
        local tbl_51 = {}
        tbl_51.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_51.Position = UDim2.fromScale(0.5, 0.5)
        tbl_51.Size = UDim2.fromScale(0.26, 0.26)
        tbl_51.BackgroundColor3 = v210.HoleColor or (Colors_upv_1.Panel)
        tbl_51.ZIndex = v213
        tbl_51[1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_51.Parent = v215
        new_25("Frame", tbl_51)
    elseif a1 == "person" then
        tbl_upv_1.new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.06), Size = UDim2.fromScale(0.42, 0.42), BackgroundColor3 = v211, ZIndex = v213, [1] = tbl_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v215})
        tbl_upv_1.new("Frame", {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.8, 0.44), BackgroundColor3 = v211, ZIndex = v213, [1] = tbl_upv_1.Corner(UDim.new(0.45, 0)), Parent = v215})
    end
    return v215
end
local u59 = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular)
function tbl_upv_1.Glyph(a1, a2, a3, a4)
    --[[
      name: Glyph
      line: 2140
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u59 (copy, index: 2)
        Colors_upv_1 (copy, index: 3)
    ]]
    local v218 = a4 or {}
    local new_26 = tbl_upv_1.new
    local tbl_52 = {LayoutOrder = 0, FontFace = 0, AutoLocalize = false, TextColor3 = 0, Parent = 0, Text = 0, AnchorPoint = 0, Name = 0, Position = 0, ZIndex = 0, TextSize = 0, Size = 0}
    tbl_52.Name = v218.Name or ("Glyph_" .. a1)
    tbl_52.Text = a1
    tbl_52.FontFace = u59
    tbl_52.TextSize = a2
    tbl_52.TextColor3 = a3 or (Colors_upv_1.Text)
    tbl_52.Size = UDim2.fromOffset(a2, a2)
    tbl_52.Position = v218.Position or UDim2.new()
    tbl_52.AnchorPoint = v218.AnchorPoint or (Vector2.zero)
    tbl_52.LayoutOrder = v218.LayoutOrder or 0
    tbl_52.ZIndex = v218.ZIndex or 1
    tbl_52.Parent = v218.Parent
    local u60 = new_26("TextLabel", tbl_52)
    task.delay(
        2,
        function()
            --[[
              line: 2158
              upvalues:
                u60 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            local X_2 = u60.TextBounds.X
            if not u60.Parent or not (a2 * 1.6 < X_2) then
                return
            end
            u60.TextTransparency = 1
        end
    )
    return u60
end
function tbl_upv_1.SelectionRing(a1, a2)
    --[[
      name: SelectionRing
      line: 2170
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
    ]]
    local u61 = tbl_upv_1.new("Frame", {Name = "SelectionRing", Position = UDim2.fromOffset(-4, -4), Size = UDim2.new(1, 8, 1, 8), BackgroundTransparency = 1, tbl_upv_1.Corner((a2 or 12) + 4), tbl_upv_1.Stroke(Colors_upv_1.Text, 3, 0)})
    for _, value_21 in a1:GetDescendants() do
        local v220 = value_21:IsA("GuiButton")
        if not (v220) or not (value_21.Selectable) then
            continue
        end
        if value_21.SelectionImageObject == nil then
            value_21.SelectionImageObject = u61
        end
    end
    local function apply(a3)
        --[[
          name: apply
          line: 2180
          upvalues:
            u61 (copy, index: 1)
        ]]
        if not a3:IsA("GuiButton") or not a3.Selectable or a3.SelectionImageObject ~= nil then
            return
        end
        a3.SelectionImageObject = u61
    end
    a1.DescendantAdded:Connect(apply)
    return u61
end
local u62 = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
function tbl_upv_1.WindowCloseSize()
    --[[
      name: WindowCloseSize
      line: 2215
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.Touch then
        return 72
    end
    return 50
end
function tbl_upv_1.Window(a1)
    --[[
      name: Window
      line: 2219
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
        Fonts_upv_1 (copy, index: 3)
        Signal_upv_1 (copy, index: 4)
        Sounds_upv_1 (copy, index: 5)
        Theme_upv_1 (copy, index: 6)
        u62 (copy, index: 7)
    ]]
    local u63 = tbl_upv_1.new("Frame", {Visible = false, Name = a1.Name or "Window", Size = UDim2.fromScale(1, 1), Parent = a1.Parent})
    local new_27 = tbl_upv_1.new
    local tbl_53 = {Visible = 0, Parent = 0, Modal = true, Selectable = false, BackgroundTransparency = 1}
    tbl_53.Name = (a1.Name or "Window") .. "Backdrop"
    tbl_53.Size = UDim2.fromScale(1, 1)
    tbl_53.BackgroundColor3 = Colors_upv_1.Void
    tbl_53.Visible = tbl_upv_1.BackdropCanvas == nil
    tbl_53.Parent = tbl_upv_1.BackdropCanvas or u63
    local u64 = new_27("TextButton", tbl_53)
    if tbl_upv_1.BackdropCanvas then
        u63:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 2237
                  upvalues:
                    u64 (copy, index: 1)
                    u63 (copy, index: 2)
                ]]
                u64.Visible = u63.Visible
            end
        )
    end
    local new_28 = tbl_upv_1.new
    local tbl_54 = {Name = "Holder", Parent = 0, Size = 0}
    tbl_54.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_54.Position = UDim2.fromScale(0.5, 0.5)
    tbl_54.Size = a1.Size or UDim2.fromOffset(1000, 640)
    tbl_54.Parent = u63
    local u65 = new_28("Frame", tbl_54)
    tbl_upv_1.DropShadow(u65, 16, 8, 0.55)
    pcall(
        function()
            --[[
              line: 2250
              upvalues:
                u65 (copy, index: 1)
            ]]
            u65.SelectionGroup = true
            u65.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
            u65.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            u65.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
            u65.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        end
    )
    local FitScale_1 = u65:FindFirstChild("FitScale")
    local u66
    if (FitScale_1) and (FitScale_1:IsA("UIScale")) then
        u66 = FitScale_1
    else
        local v222 = Instance.new("UIScale")
        v222.Name = "FitScale"
        v222.Parent = u65
        u66 = v222
    end
    local function applyFit()
        --[[
          name: applyFit
          line: 2257
          upvalues:
            tbl_upv_1 (copy, index: 1)
            u65 (copy, index: 2)
            u66 (copy, index: 3)
        ]]
        local v223 = tbl_upv_1.CanvasSize()
        local Size_1 = u65.Size
        local Offset_3 = Size_1.X.Offset
        local Offset_4 = Size_1.Y.Offset
        if not (Offset_3 <= 0) and not (Offset_4 <= 0) then
            local v224 = tbl_upv_1.TopInset()
            u66.Scale = math.min(1, (v223.X - 24) / Offset_3, ((v223.Y - v224) - 12) / Offset_4)
            Offset_4 = math.max(v223.Y / 2, v224 + ((Offset_4 * u66.Scale) / 2))
            u65:SetAttribute("_base", UDim2.new(0.5, 0, 0, Offset_4))
            if not (u65:GetAttribute("_slideTarget")) then
                u65.Position = UDim2.new(0.5, 0, 0, Offset_4)
            end
            return
        end
        u66.Scale = 1
    end
    tbl_upv_1.ScaleChanged:Connect(applyFit)
    local v225 = tbl_upv_1.Panel({Name = "Body", Active = true, StrokeTransparency = 0.88, BackgroundTransparency = 0.04, Size = UDim2.fromScale(1, 1), Radius = UDim.new(0, 16), Parent = u65})
    local v226 = a1.HeaderHeight or 78
    local u67 = tbl_upv_1.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, v226), Parent = v225})
    local v227 = tbl_upv_1.DisplayText({StrokeThickness = 0, Name = "Title", TextSize = 36, Text = a1.Title or "", TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(28, 14), Size = UDim2.new(1, -150, 0, 40), Parent = u67})
    local v228 = tbl_upv_1.new("TextLabel", {Name = "Subtitle", TextSize = 17, Text = a1.Subtitle or "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(30, 52), Size = UDim2.new(1, -150, 0, 20), Parent = u67})
    tbl_upv_1.new("Frame", {Name = "Divider", BackgroundColor3 = Colors_upv_1.Divider, BackgroundTransparency = 0.2, Size = UDim2.new(1, -48, 0, 2), Position = UDim2.new(0, 24, 1, -2), [1] = tbl_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0, NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.4), NumberSequenceKeypoint.new(1, 1)})), Parent = u67})
    local tbl_upv_55 = {IsOpen = false}
    tbl_upv_55.Root = u63
    tbl_upv_55.Holder = u65
    tbl_upv_55.Body = v225
    tbl_upv_55.Header = u67
    tbl_upv_55.Title = v227
    tbl_upv_55.Subtitle = v228
    tbl_upv_55.Opened = Signal_upv_1.new()
    tbl_upv_55.Closed = Signal_upv_1.new()
    tbl_upv_55.Refit = applyFit
    local function makeClose()
        --[[
          name: makeClose
          line: 2341
          upvalues:
            tbl_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            u67 (copy, index: 3)
            a1 (copy, index: 4)
        ]]
        local v229 = tbl_upv_1.WindowCloseSize()
        local function OnClick_1()
            --[[
              name: OnClick
              line: 2353
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.OnCloseRequested then
                return
            end
            a1.OnCloseRequested()
        end
        return (tbl_upv_1.IconButton({IconName = "cross", Name = "Close", Sound = "Close", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(v229, v229), Color = Colors_upv_1.Raised, HoverColor = Colors_upv_1.Danger, Parent = u67, OnClick = OnClick_1}))
    end
    if not (a1.NoClose) then
        local u68 = makeClose()
        tbl_upv_55.CloseButton = u68
        tbl_upv_1.TouchChanged:Connect(
            function()
                --[[
                  line: 2365
                  upvalues:
                    u68 (ref,  index: 1)
                    makeClose (copy, index: 2)
                    tbl_upv_55 (copy, index: 3)
                ]]
                u68:Destroy()
                u68 = makeClose()
                tbl_upv_55.CloseButton = u68
            end
        )
    end
    tbl_upv_55.Content = tbl_upv_1.new("Frame", {Name = "Content", Position = UDim2.fromOffset(0, v226), Size = UDim2.new(1, 0, 1, -v226), [1] = tbl_upv_1.Padding(14, 22, 18, 22), Parent = v225})
    local u69 = 0
    local u70 = false
    u64.InputBegan:Connect(
        function(a2)
            --[[
              line: 2385
              upvalues:
                u70 (ref, index: 1)
            ]]
            local UserInputType_2 = a2.UserInputType
            if UserInputType_2 ~= Enum.UserInputType.MouseButton1 and UserInputType_2 ~= Enum.UserInputType.Touch then
                return
            end
            u70 = true
        end
    )
    u64.Activated:Connect(
        function()
            --[[
              line: 2391
              upvalues:
                u69 (ref,  index: 1)
                u70 (ref,  index: 2)
                a1 (copy, index: 3)
                Sounds_upv_1 (copy, index: 4)
            ]]
            if (os.clock() - u69 < 0.4) or not u70 then
                return
            end
            if a1.CloseOnBackdrop ~= false and a1.OnCloseRequested then
                Sounds_upv_1.Play("Close")
                a1.OnCloseRequested()
            end
        end
    )
    local u71 = 0
    function tbl_upv_55.Open(a3)
        --[[
          name: Open
          line: 2403
          upvalues:
            u69 (ref,  index: 1)
            u70 (ref,  index: 2)
            u71 (ref,  index: 3)
            u63 (copy, index: 4)
            u64 (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
            applyFit (copy, index: 9)
            u65 (copy, index: 10)
            u62 (copy, index: 11)
            Sounds_upv_1 (copy, index: 12)
        ]]
        if a3.IsOpen then
            return
        end
        a3.IsOpen = true
        u69 = os.clock()
        u70 = false
        u71 = u71 + 1
        u63.Visible = true
        u64.BackgroundTransparency = 1
        tbl_upv_1.Tween(u64, Theme_upv_1.Tween.Smooth, {BackgroundTransparency = a1.DimTransparency or 0.4})
        applyFit()
        local v230 = u65:GetAttribute("_base")
        local SlideIn_1 = tbl_upv_1.SlideIn
        local v231 = Vector2.new(0, 50)
        local v232
        if typeof(v230) ~= "UDim2" then
            v232 = UDim2.fromScale(0.5, 0.5)
        else
            v232 = v230
        end
        SlideIn_1(u65, v231, u62, v232)
        Sounds_upv_1.Play(a1.OpenSound or "Open")
        a3.Opened:Fire()
    end
    function tbl_upv_55.Close(a4, a5)
        --[[
          name: Close
          line: 2420
          upvalues:
            u71 (ref,  index: 1)
            u63 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            u64 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            u65 (copy, index: 6)
        ]]
        if not a4.IsOpen then
            return
        end
        a4.IsOpen = false
        u71 = u71 + 1
        local u72 = u71
        a4.Closed:Fire()
        if a5 then
            u63.Visible = false
        else
            tbl_upv_1.Tween(u64, Theme_upv_1.Tween.Close, {BackgroundTransparency = 1})
            local v233 = u65:GetAttribute("_base")
            local v234
            if typeof(v233) ~= "UDim2" then
                v234 = UDim2.fromScale(0.5, 0.5)
            else
                v234 = v233
            end
            tbl_upv_1.Tween(u65, Theme_upv_1.Tween.Close, {Position = v234 + UDim2.fromOffset(0, 30)})
            task.delay(
                0.15,
                function()
                    --[[
                      line: 2436
                      upvalues:
                        u71 (ref,  index: 1)
                        u72 (copy, index: 2)
                        u63 (copy, index: 3)
                    ]]
                    if u71 ~= u72 then
                        return
                    end
                    u63.Visible = false
                end
            )
        end
    end
    return tbl_upv_55
end
function tbl_upv_1.SectionTitle(a1, a2)
    --[[
      name: SectionTitle
      line: 2449
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Colors_upv_1 (copy, index: 2)
        Fonts_upv_1 (copy, index: 3)
    ]]
    local v235 = a2 or {}
    local new_29 = tbl_upv_1.new
    local tbl_56 = {LayoutOrder = 0, Name = "Section", Position = 0, Parent = 0, Size = 0}
    local v236 = v235.Size or (UDim2.new(1, 0, 0, 24))
    tbl_56.Size = v236
    v236 = v235.Position or (UDim2.new())
    tbl_56.Position = v236
    tbl_56.LayoutOrder = v235.LayoutOrder or 0
    tbl_56.Parent = v235.Parent
    local v237 = new_29("Frame", tbl_56)
    local new_30 = tbl_upv_1.new
    local tbl_57 = {}
    tbl_57.BackgroundColor3 = v235.Color or (Colors_upv_1.Accent)
    tbl_57.Size = UDim2.fromOffset(4, 16)
    tbl_57.Position = UDim2.fromOffset(0, 4)
    tbl_57[1] = tbl_upv_1.Corner(2)
    tbl_57.Parent = v237
    new_30("Frame", tbl_57)
    local new_31 = tbl_upv_1.new
    local tbl_58 = {TextColor3 = 0, Parent = 0, Name = "Text", TextXAlignment = 0, Position = 0, Size = 0}
    tbl_58.Text = string.upper(a1)
    tbl_58.FontFace = Fonts_upv_1.Heavy
    tbl_58.TextSize = v235.TextSize or 16
    tbl_58.TextColor3 = v235.TextColor or (Colors_upv_1.TextDim)
    tbl_58.TextXAlignment = Enum.TextXAlignment.Left
    tbl_58.Position = UDim2.fromOffset(12, 0)
    tbl_58.Size = UDim2.new(1, -12, 1, 0)
    tbl_58.Parent = v237
    new_31("TextLabel", tbl_58)
    return v237
end
function tbl_upv_1.Every(a1, a2, a3)
    --[[
      name: Every
      line: 2480
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local u73 = 0
    local u74 = nil
    local v238 = RunService_upv_1.Heartbeat:Connect(
        function(a4)
            --[[
              line: 2483
              upvalues:
                a1 (copy, index: 1)
                u74 (ref,  index: 2)
                u73 (ref,  index: 3)
                a2 (copy, index: 4)
                a3 (copy, index: 5)
            ]]
            if a1.Parent then
                u73 = u73 + a4
                if a2 <= u73 then
                    u73 = 0
                    a3()
                end
            else
                u74:Disconnect()
            end
        end
    )
    u74 = v238
    return u74
end
return tbl_upv_1