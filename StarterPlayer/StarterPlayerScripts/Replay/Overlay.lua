local _ = game:GetService("GuiService")
local Players_1 = game:GetService("Players")
local TextService_upv_1 = game:GetService("TextService")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local Loc_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Loc"))
local u1 = nil
local function playUI(a1)
    --[[
      name: playUI
      line: 41
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v1 = nil
    if not (u1) then
        local Shared_1 = game:GetService("ReplicatedStorage"):FindFirstChild("Shared")
        v1 = Shared_1 and (Shared_1:FindFirstChild("Sfx"))
        if v1 and v1:IsA("ModuleScript") then
            local success_1, v2 = pcall(require, v1)
            local v3
            if (success_1) and type(v2) == "table" then
                v3 = v2
            else
                v3 = false
            end
            u1 = v3
        end
    end
    if not u1 then
        return
    end
    pcall(u1.PlayUI, a1)
end
local fromRGB_upv_1 = Color3.fromRGB
local tbl_upv_2 = {}
tbl_upv_2.Void = fromRGB_upv_1(6, 7, 10)
tbl_upv_2.Panel = fromRGB_upv_1(18, 20, 26)
tbl_upv_2.PanelHi = fromRGB_upv_1(28, 31, 39)
tbl_upv_2.Text = fromRGB_upv_1(255, 255, 255)
tbl_upv_2.TextDim = fromRGB_upv_1(186, 192, 206)
tbl_upv_2.TextMuted = fromRGB_upv_1(124, 131, 148)
tbl_upv_2.Accent = fromRGB_upv_1(40, 150, 255)
tbl_upv_2.Danger = fromRGB_upv_1(245, 64, 72)
tbl_upv_2.Gold = fromRGB_upv_1(255, 200, 60)
tbl_upv_2.Ally = fromRGB_upv_1(70, 170, 255)
tbl_upv_2.Enemy = fromRGB_upv_1(255, 72, 72)
local tbl_upv_3 = {}
tbl_upv_3.Display = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
tbl_upv_3.Title = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold)
tbl_upv_3.Bold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold)
tbl_upv_3.SemiBold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
local UI_1 = script.Parent.Parent:FindFirstChild("UI")
local v4 = UI_1 and (UI_1:FindFirstChild("Theme"))
if v4 and v4:IsA("ModuleScript") then
    local success_2, v5 = pcall(require, v4)
    if success_2 and type(v5) == "table" and type(v5.Colors) == "table" then
        for key_1 in tbl_upv_2 do
            local v6 = v5.Colors[key_1]
            if typeof(v6) == "Color3" then
                tbl_upv_2[key_1] = v6
            end
        end
        if type(v5.Fonts) == "table" then
            for key_2 in tbl_upv_3 do
                local v7 = v5.Fonts[key_2]
                if typeof(v7) == "Font" then
                    tbl_upv_3[key_2] = v7
                end
            end
        end
    end
end
tbl_upv_1.Colors = tbl_upv_2
local function tween(a1, a2, a3, a4, a5)
    --[[
      name: tween
      line: 103
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    local v8 = a4 or (Enum.EasingStyle.Quint)
    local v9 = TweenService_upv_1:Create(a1, TweenInfo.new(a2, v8, a5 or (Enum.EasingDirection.Out)), a3)
    v9:Play()
    return v9
end
local function label(a1)
    --[[
      name: label
      line: 127
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    a1.BackgroundTransparency = 1
    a1.TextColor3 = a1.TextColor3 or (tbl_upv_2.Text)
    a1.FontFace = a1.FontFace or (tbl_upv_3.Bold)
    a1.TextXAlignment = a1.TextXAlignment or (Enum.TextXAlignment.Left)
    local v10 = Instance.new("TextLabel")
    for key_3, value_1 in a1 do
        if key_3 ~= "Parent" then
            v10[key_3] = value_1
        end
    end
    if a1.Parent then
        v10.Parent = a1.Parent
    end
    return v10
end
local u2 = nil
local tbl_upv_4 = {Brightness = 0.01, Saturation = -0.42, Contrast = -0.18}
tbl_upv_4.TintColor = Color3.fromRGB(255, 220, 194)
local tbl_upv_5 = {Brightness = 0, Saturation = 0, Contrast = 0}
tbl_upv_5.TintColor = Color3.new(1, 1, 1)
local tbl_upv_6 = {Vector2.new(0, 0), Vector2.new(1, 0), Vector2.new(0, 1), Vector2.new(1, 1)}
local function textWidth(a1, a2)
    --[[
      name: textWidth
      line: 187
    ]]
    local success_3, v11 = pcall(function() end)
    if success_3 then
        return v11.X * 1.06
    end
    return (#a1 * a2) * 0.62
end
local function scaleFor(a1)
    --[[
      name: scaleFor
      line: 194
    ]]
    local Y_1 = a1.Y
    if Y_1 < 560 then
        return (math.clamp(Y_1 / 620, 0.5, 1))
    end
    return (math.clamp(Y_1 / 900, 0.6, 1.4))
end
local function new(a1, a2, a3)
    --[[
      name: new
      line: 109
    ]]
    local v12 = Instance.new(a1)
    for key_4, value_2 in a2 do
        if key_4 ~= "Parent" then
            v12[key_4] = value_2
        end
    end
    if a3 then
        for _, value_3 in a3 do
            value_3.Parent = v12
        end
    end
    if a2.Parent then
        v12.Parent = a2.Parent
    end
    return v12
end
local function build()
    --[[
      name: build
      line: 202
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        new (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        fromRGB_upv_1 (copy, index: 6)
    ]]
    local PlayerGui_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    local tbl_7 = {Enabled = false, Name = "TR_Replay", DisplayOrder = 60, ResetOnSpawn = false, IgnoreGuiInset = true}
    tbl_7.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local u3 = Instance.new("ScreenGui")
    for key_5, value_4 in tbl_7 do
        if key_5 ~= "Parent" then
            u3[key_5] = value_4
        end
    end
    if tbl_7.Parent then
        u3.Parent = tbl_7.Parent
    end
    pcall(
        function()
            --[[
              line: 212
              upvalues:
                u3 (copy, index: 1)
            ]]
            u3.ScreenInsets = Enum.ScreenInsets.None
        end
    )
    local tbl_upv_8 = {Enabled = false, Name = "TR_ReplayHud", DisplayOrder = 61, ResetOnSpawn = false, IgnoreGuiInset = true}
    tbl_upv_8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local u4 = Instance.new("ScreenGui")
    for key_6, value_5 in tbl_upv_8 do
        if key_6 ~= "Parent" then
            u4[key_6] = value_5
        end
    end
    if tbl_upv_8.Parent then
        u4.Parent = tbl_upv_8.Parent
    end
    pcall(
        function()
            --[[
              line: 223
              upvalues:
                u4 (copy, index: 1)
            ]]
            u4.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        end
    )
    local tbl_9 = {Enabled = false, Name = "TR_ReplayFrame", DisplayOrder = 62, ResetOnSpawn = false, IgnoreGuiInset = false}
    tbl_9.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    tbl_upv_8 = Instance.new("ScreenGui")
    for key_7, value_6 in tbl_9 do
        if key_7 ~= "Parent" then
            tbl_upv_8[key_7] = value_6
        end
    end
    if tbl_9.Parent then
        tbl_upv_8.Parent = tbl_9.Parent
    end
    pcall(
        function()
            --[[
              line: 237
              upvalues:
                tbl_upv_8 (copy, index: 1)
            ]]
            tbl_upv_8.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
        end
    )
    tbl_9 = {}
    local tbl_10 = {}
    for key_8, value_7 in tbl_upv_6 do
        local tbl_11 = {BackgroundTransparency = 1}
        tbl_11.Name = "Corner" .. key_8
        tbl_11.AnchorPoint = value_7
        tbl_11.Parent = tbl_upv_8
        local v13 = Instance.new("Frame")
        for key_9, value_8 in tbl_11 do
            if key_9 ~= "Parent" then
                v13[key_9] = value_8
            end
        end
        if tbl_11.Parent then
            v13.Parent = tbl_11.Parent
        end
        local tbl_12 = {Name = "H", BorderSizePixel = 0}
        tbl_12.AnchorPoint = Vector2.new(0, value_7.Y)
        tbl_12.Position = UDim2.fromScale(0, value_7.Y)
        tbl_12.BackgroundColor3 = tbl_upv_2.Text
        tbl_12.Parent = v13
        local v14 = Instance.new("Frame")
        for key_10, value_9 in tbl_12 do
            if key_10 ~= "Parent" then
                v14[key_10] = value_9
            end
        end
        if tbl_12.Parent then
            v14.Parent = tbl_12.Parent
        end
        local tbl_13 = {Name = "V", BorderSizePixel = 0}
        local v15 = nil
        tbl_13.AnchorPoint = Vector2.new(v15.X, 0)
        tbl_13.Position = UDim2.fromScale(v15.X, 0)
        tbl_13.BackgroundColor3 = tbl_upv_2.Text
        tbl_13.Parent = v13
        tbl_12 = Instance.new("Frame")
        for key_11, value_10 in tbl_13 do
            if key_11 ~= "Parent" then
                tbl_12[key_11] = value_10
            end
        end
        if tbl_13.Parent then
            tbl_12.Parent = tbl_13.Parent
        end
        table.insert(tbl_9, v13)
        table.insert(tbl_10, v14)
        table.insert(tbl_10, tbl_12)
    end
    local tbl_14 = {Name = "Rec", BackgroundTransparency = 1}
    tbl_14.AnchorPoint = Vector2.new(1, 0.5)
    tbl_14.AutomaticSize = Enum.AutomaticSize.X
    tbl_14.Parent = tbl_upv_8
    local tbl_15 = {}
    local tbl_16 = {}
    tbl_16.FillDirection = Enum.FillDirection.Horizontal
    tbl_16.VerticalAlignment = Enum.VerticalAlignment.Center
    tbl_16.SortOrder = Enum.SortOrder.LayoutOrder
    local v16 = Instance.new("UIListLayout")
    for key_12, value_11 in tbl_16 do
        if key_12 ~= "Parent" then
            v16[key_12] = value_11
        end
    end
    if tbl_16.Parent then
        v16.Parent = tbl_16.Parent
    end
    tbl_15[1] = v16
    local v17 = new("Frame", tbl_14, tbl_15)
    local tbl_17 = {LayoutOrder = 1, Name = "Dot", BorderSizePixel = 0}
    tbl_17.BackgroundColor3 = tbl_upv_2.Danger
    tbl_17.Parent = v17
    local tbl_18 = {}
    local tbl_19 = {}
    tbl_19.CornerRadius = UDim.new(1, 0)
    local v18 = Instance.new("UICorner")
    for key_13, value_12 in tbl_19 do
        if key_13 ~= "Parent" then
            v18[key_13] = value_12
        end
    end
    if tbl_19.Parent then
        v18.Parent = tbl_19.Parent
    end
    tbl_18[1] = v18
    local v19 = new("Frame", tbl_17, tbl_18)
    local tbl_20 = {LayoutOrder = 2, Name = "Text", Text = "REC", TextStrokeTransparency = 0.85}
    tbl_20.FontFace = tbl_upv_3.Title
    tbl_20.AutomaticSize = Enum.AutomaticSize.X
    tbl_20.TextStrokeColor3 = tbl_upv_2.Void
    tbl_20.Parent = v17
    tbl_20.BackgroundTransparency = 1
    tbl_20.TextColor3 = tbl_20.TextColor3 or (tbl_upv_2.Text)
    tbl_20.FontFace = tbl_20.FontFace or (tbl_upv_3.Bold)
    tbl_20.TextXAlignment = tbl_20.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_14 = Instance.new("TextLabel")
    for key_14, value_13 in tbl_20 do
        if key_14 ~= "Parent" then
            tbl_14[key_14] = value_13
        end
    end
    if tbl_20.Parent then
        tbl_14.Parent = tbl_20.Parent
    end
    local tbl_21 = {Name = "Cover", ZIndex = 10, BorderSizePixel = 0}
    tbl_21.BackgroundColor3 = tbl_upv_2.Void
    tbl_21.Size = UDim2.fromScale(1, 1)
    tbl_21.Parent = u3
    local v20 = Instance.new("Frame")
    for key_15, value_14 in tbl_21 do
        if key_15 ~= "Parent" then
            v20[key_15] = value_14
        end
    end
    if tbl_21.Parent then
        v20.Parent = tbl_21.Parent
    end
    tbl_21 = {Rotation = 90}
    tbl_21.Color = ColorSequence.new(fromRGB_upv_1(22, 26, 36), tbl_upv_2.Void)
    tbl_21.Parent = v20
    local v21 = Instance.new("UIGradient")
    for key_16, value_15 in tbl_21 do
        if key_16 ~= "Parent" then
            v21[key_16] = value_15
        end
    end
    if tbl_21.Parent then
        v21.Parent = tbl_21.Parent
    end
    v21 = {Name = "Card", ZIndex = 11, BackgroundTransparency = 1}
    v21.AnchorPoint = Vector2.new(0.5, 0.5)
    v21.Position = UDim2.fromScale(0.5, 0.5)
    v21.Size = UDim2.fromOffset(1180, 260)
    v21.Parent = v20
    tbl_21 = Instance.new("Frame")
    for key_17, value_16 in v21 do
        if key_17 ~= "Parent" then
            tbl_21[key_17] = value_16
        end
    end
    if v21.Parent then
        tbl_21.Parent = v21.Parent
    end
    local tbl_22 = {}
    tbl_22.Parent = tbl_21
    v21 = Instance.new("UIScale")
    for key_18, value_17 in tbl_22 do
        if key_18 ~= "Parent" then
            v21[key_18] = value_17
        end
    end
    if tbl_22.Parent then
        v21.Parent = tbl_22.Parent
    end
    local tbl_23 = {Text = "PLAY OF THE GAME", Name = "Label", ZIndex = 12, TextSize = 30}
    tbl_23.FontFace = tbl_upv_3.Title
    tbl_23.TextColor3 = tbl_upv_2.Accent
    tbl_23.Position = UDim2.fromOffset(196, 8)
    tbl_23.Size = UDim2.fromOffset(700, 34)
    tbl_23.Parent = tbl_21
    tbl_23.BackgroundTransparency = 1
    tbl_23.TextColor3 = tbl_23.TextColor3 or (tbl_upv_2.Text)
    tbl_23.FontFace = tbl_23.FontFace or (tbl_upv_3.Bold)
    tbl_23.TextXAlignment = tbl_23.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_22 = Instance.new("TextLabel")
    for key_19, value_18 in tbl_23 do
        if key_19 ~= "Parent" then
            tbl_22[key_19] = value_18
        end
    end
    if tbl_23.Parent then
        tbl_22.Parent = tbl_23.Parent
    end
    local tbl_24 = {Name = "Bar", ZIndex = 12, BorderSizePixel = 0}
    tbl_24.BackgroundColor3 = tbl_upv_2.Accent
    tbl_24.Position = UDim2.fromOffset(198, 48)
    tbl_24.Size = UDim2.fromOffset(0, 5)
    tbl_24.Parent = tbl_21
    tbl_23 = Instance.new("Frame")
    for key_20, value_19 in tbl_24 do
        if key_20 ~= "Parent" then
            tbl_23[key_20] = value_19
        end
    end
    if tbl_24.Parent then
        tbl_23.Parent = tbl_24.Parent
    end
    local tbl_25 = {Name = "Stripe", ZIndex = 12, BorderSizePixel = 0}
    tbl_25.BackgroundColor3 = tbl_upv_2.Ally
    tbl_25.Position = UDim2.fromOffset(198, 66)
    tbl_25.Size = UDim2.fromOffset(6, 104)
    tbl_25.Parent = tbl_21
    tbl_24 = Instance.new("Frame")
    for key_21, value_20 in tbl_25 do
        if key_21 ~= "Parent" then
            tbl_24[key_21] = value_20
        end
    end
    if tbl_25.Parent then
        tbl_24.Parent = tbl_25.Parent
    end
    local tbl_26 = {AutoLocalize = false, Text = "", Name = "PlayerName", ZIndex = 12, TextSize = 104}
    tbl_26.FontFace = tbl_upv_3.Display
    tbl_26.Position = UDim2.fromOffset(222, 60)
    tbl_26.Size = UDim2.fromOffset(950, 112)
    tbl_26.Parent = tbl_21
    tbl_26.BackgroundTransparency = 1
    tbl_26.TextColor3 = tbl_26.TextColor3 or (tbl_upv_2.Text)
    tbl_26.FontFace = tbl_26.FontFace or (tbl_upv_3.Bold)
    tbl_26.TextXAlignment = tbl_26.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_25 = Instance.new("TextLabel")
    for key_22, value_21 in tbl_26 do
        if key_22 ~= "Parent" then
            tbl_25[key_22] = value_21
        end
    end
    if tbl_26.Parent then
        tbl_25.Parent = tbl_26.Parent
    end
    local tbl_27 = {AutoLocalize = false, Text = "", Name = "Title", ZIndex = 12, TextSize = 30}
    tbl_27.FontFace = tbl_upv_3.Bold
    tbl_27.TextColor3 = tbl_upv_2.TextDim
    tbl_27.Position = UDim2.fromOffset(224, 178)
    tbl_27.Size = UDim2.fromOffset(950, 36)
    tbl_27.Parent = tbl_21
    tbl_27.BackgroundTransparency = 1
    tbl_27.TextColor3 = tbl_27.TextColor3 or (tbl_upv_2.Text)
    tbl_27.FontFace = tbl_27.FontFace or (tbl_upv_3.Bold)
    tbl_27.TextXAlignment = tbl_27.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_26 = Instance.new("TextLabel")
    for key_23, value_22 in tbl_27 do
        if key_23 ~= "Parent" then
            tbl_26[key_23] = value_22
        end
    end
    if tbl_27.Parent then
        tbl_26.Parent = tbl_27.Parent
    end
    local tbl_28 = {LightDirection = Vector3.new(-0.6000000238418579, -1, -0.800000011920929), Name = "Portrait", ZIndex = 12, BackgroundTransparency = 0}
    tbl_28.BackgroundColor3 = tbl_upv_2.PanelHi
    tbl_28.Position = UDim2.fromOffset(0, 40)
    tbl_28.Size = UDim2.fromOffset(170, 170)
    tbl_28.Ambient = fromRGB_upv_1(170, 172, 182)
    tbl_28.LightColor = fromRGB_upv_1(255, 250, 240)
    tbl_28.Parent = tbl_21
    local tbl_29 = {}
    local tbl_30 = {}
    tbl_30.CornerRadius = UDim.new(0, 14)
    local v22 = Instance.new("UICorner")
    for key_24, value_23 in tbl_30 do
        if key_24 ~= "Parent" then
            v22[key_24] = value_23
        end
    end
    if tbl_30.Parent then
        v22.Parent = tbl_30.Parent
    end
    local tbl_31 = {Transparency = 0.82, Thickness = 2}
    tbl_31.Color = tbl_upv_2.Text
    local v23 = Instance.new("UIStroke")
    for key_25, value_24 in tbl_31 do
        if key_25 ~= "Parent" then
            v23[key_25] = value_24
        end
    end
    if tbl_31.Parent then
        v23.Parent = tbl_31.Parent
    end
    tbl_29[1], tbl_29[2] = v22, v23
    local v24 = new("ViewportFrame", tbl_28, tbl_29)
    tbl_28 = {}
    tbl_28.Parent = v24
    local v25 = Instance.new("UIScale")
    for key_26, value_25 in tbl_28 do
        if key_26 ~= "Parent" then
            v25[key_26] = value_25
        end
    end
    if tbl_28.Parent then
        v25.Parent = tbl_28.Parent
    end
    local tbl_32 = {BackgroundTransparency = 1, Name = "Canvas"}
    tbl_32.Size = UDim2.fromScale(1, 1)
    tbl_32.Parent = u4
    tbl_28 = Instance.new("Frame")
    for key_27, value_26 in tbl_32 do
        if key_27 ~= "Parent" then
            tbl_28[key_27] = value_26
        end
    end
    if tbl_32.Parent then
        tbl_28.Parent = tbl_32.Parent
    end
    local tbl_33 = {}
    tbl_33.Parent = tbl_28
    tbl_32 = Instance.new("UIScale")
    for key_28, value_27 in tbl_33 do
        if key_28 ~= "Parent" then
            tbl_32[key_28] = value_27
        end
    end
    if tbl_33.Parent then
        tbl_32.Parent = tbl_33.Parent
    end
    local tbl_34 = {BackgroundTransparency = 0.12, Name = "Tag"}
    tbl_34.AnchorPoint = Vector2.new(0, 1)
    tbl_34.Position = UDim2.new(0, 28, 1, -22)
    tbl_34.Size = UDim2.fromOffset(0, 74)
    tbl_34.AutomaticSize = Enum.AutomaticSize.X
    tbl_34.BackgroundColor3 = tbl_upv_2.Panel
    tbl_34.Parent = tbl_28
    local tbl_35 = {}
    local tbl_36 = {}
    tbl_36.CornerRadius = UDim.new(0, 10)
    local tbl_37 = Instance.new("UICorner")
    for key_29, value_28 in tbl_36 do
        if key_29 ~= "Parent" then
            tbl_37[key_29] = value_28
        end
    end
    if tbl_36.Parent then
        tbl_37.Parent = tbl_36.Parent
    end
    local tbl_38 = {Transparency = 0.9, Thickness = 1}
    tbl_38.Color = tbl_upv_2.Text
    tbl_36 = Instance.new("UIStroke")
    for key_30, value_29 in tbl_38 do
        if key_30 ~= "Parent" then
            tbl_36[key_30] = value_29
        end
    end
    if tbl_38.Parent then
        tbl_36.Parent = tbl_38.Parent
    end
    local tbl_39 = {}
    tbl_39.PaddingLeft = UDim.new(0, 22)
    tbl_39.PaddingRight = UDim.new(0, 20)
    tbl_38 = Instance.new("UIPadding")
    for key_31, value_30 in tbl_39 do
        if key_31 ~= "Parent" then
            tbl_38[key_31] = value_30
        end
    end
    if tbl_39.Parent then
        tbl_38.Parent = tbl_39.Parent
    end
    tbl_35[1], tbl_35[2], tbl_35[3] = tbl_37, tbl_36, tbl_38
    local v26 = new("Frame", tbl_34, tbl_35)
    local tbl_40 = {Name = "Stripe", BorderSizePixel = 0}
    tbl_40.BackgroundColor3 = tbl_upv_2.Accent
    tbl_40.Position = UDim2.new(0, -22, 0, 0)
    tbl_40.Size = UDim2.new(0, 5, 1, 0)
    tbl_40.Parent = v26
    tbl_37 = {}
    tbl_38 = {}
    tbl_38.CornerRadius = UDim.new(0, 3)
    tbl_36 = Instance.new("UICorner")
    for key_32, value_31 in tbl_38 do
        if key_32 ~= "Parent" then
            tbl_36[key_32] = value_31
        end
    end
    if tbl_38.Parent then
        tbl_36.Parent = tbl_38.Parent
    end
    tbl_37[1] = tbl_36
    local v27 = new("Frame", tbl_40, tbl_37)
    tbl_34 = {Text = "PLAY OF THE GAME", Name = "Label", TextSize = 15}
    tbl_34.FontFace = tbl_upv_3.Title
    tbl_34.TextColor3 = tbl_upv_2.Accent
    tbl_34.Position = UDim2.fromOffset(0, 9)
    tbl_34.Size = UDim2.fromOffset(0, 16)
    tbl_34.AutomaticSize = Enum.AutomaticSize.X
    tbl_34.Parent = v26
    tbl_34.BackgroundTransparency = 1
    tbl_34.TextColor3 = tbl_34.TextColor3 or (tbl_upv_2.Text)
    tbl_34.FontFace = tbl_34.FontFace or (tbl_upv_3.Bold)
    tbl_34.TextXAlignment = tbl_34.TextXAlignment or (Enum.TextXAlignment.Left)
    local v28 = Instance.new("TextLabel")
    for key_33, value_32 in tbl_34 do
        if key_33 ~= "Parent" then
            v28[key_33] = value_32
        end
    end
    if tbl_34.Parent then
        v28.Parent = tbl_34.Parent
    end
    local tbl_41 = {AutoLocalize = false, Text = "", Name = "PlayerName", TextSize = 30}
    tbl_41.FontFace = tbl_upv_3.Display
    tbl_41.Position = UDim2.fromOffset(0, 26)
    tbl_41.Size = UDim2.fromOffset(0, 30)
    tbl_41.AutomaticSize = Enum.AutomaticSize.X
    tbl_41.Parent = v26
    tbl_41.BackgroundTransparency = 1
    tbl_41.TextColor3 = tbl_41.TextColor3 or (tbl_upv_2.Text)
    tbl_41.FontFace = tbl_41.FontFace or (tbl_upv_3.Bold)
    tbl_41.TextXAlignment = tbl_41.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_34 = Instance.new("TextLabel")
    for key_34, value_33 in tbl_41 do
        if key_34 ~= "Parent" then
            tbl_34[key_34] = value_33
        end
    end
    if tbl_41.Parent then
        tbl_34.Parent = tbl_41.Parent
    end
    local tbl_42 = {AutoLocalize = false, Text = "", Name = "Title", TextSize = 14}
    tbl_42.FontFace = tbl_upv_3.Bold
    tbl_42.TextColor3 = tbl_upv_2.TextDim
    tbl_42.Position = UDim2.fromOffset(0, 55)
    tbl_42.Size = UDim2.fromOffset(0, 14)
    tbl_42.AutomaticSize = Enum.AutomaticSize.X
    tbl_42.Parent = v26
    tbl_42.BackgroundTransparency = 1
    tbl_42.TextColor3 = tbl_42.TextColor3 or (tbl_upv_2.Text)
    tbl_42.FontFace = tbl_42.FontFace or (tbl_upv_3.Bold)
    tbl_42.TextXAlignment = tbl_42.TextXAlignment or (Enum.TextXAlignment.Left)
    local v29 = Instance.new("TextLabel")
    for key_35, value_34 in tbl_42 do
        if key_35 ~= "Parent" then
            v29[key_35] = value_34
        end
    end
    if tbl_42.Parent then
        v29.Parent = tbl_42.Parent
    end
    local tbl_43 = {Visible = true, Text = "SKIP  \226\128\186", AutoButtonColor = true, Name = "Skip", BackgroundTransparency = 0.12, TextSize = 22}
    tbl_43.AnchorPoint = Vector2.new(1, 1)
    tbl_43.Position = UDim2.new(1, -28, 1, -26)
    tbl_43.Size = UDim2.fromOffset(128, 52)
    tbl_43.BackgroundColor3 = tbl_upv_2.Panel
    tbl_43.FontFace = tbl_upv_3.Display
    tbl_43.TextColor3 = tbl_upv_2.Text
    tbl_43.Parent = tbl_28
    local tbl_44 = {}
    local tbl_45 = {}
    tbl_45.CornerRadius = UDim.new(0, 10)
    local v30 = Instance.new("UICorner")
    for key_36, value_35 in tbl_45 do
        if key_36 ~= "Parent" then
            v30[key_36] = value_35
        end
    end
    if tbl_45.Parent then
        v30.Parent = tbl_45.Parent
    end
    local tbl_46 = {Transparency = 0.8, Thickness = 1}
    tbl_46.Color = tbl_upv_2.Text
    tbl_46.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tbl_45 = Instance.new("UIStroke")
    for key_37, value_36 in tbl_46 do
        if key_37 ~= "Parent" then
            tbl_45[key_37] = value_36
        end
    end
    if tbl_46.Parent then
        tbl_45.Parent = tbl_46.Parent
    end
    tbl_44[1], tbl_44[2] = v30, tbl_45
    local v31 = new("TextButton", tbl_43, tbl_44)
    tbl_43 = {Name = "Pop", Visible = false, BackgroundTransparency = 1}
    tbl_43.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_43.Position = UDim2.fromScale(0.5, 0.22)
    tbl_43.Size = UDim2.fromOffset(900, 90)
    tbl_43.Parent = tbl_28
    local v32 = Instance.new("Frame")
    for key_38, value_37 in tbl_43 do
        if key_38 ~= "Parent" then
            v32[key_38] = value_37
        end
    end
    if tbl_43.Parent then
        v32.Parent = tbl_43.Parent
    end
    local tbl_47 = {Text = "ELIMINATED", TextStrokeTransparency = 0.7, Name = "Top", TextSize = 22}
    tbl_47.FontFace = tbl_upv_3.Title
    tbl_47.TextColor3 = tbl_upv_2.TextDim
    tbl_47.TextXAlignment = Enum.TextXAlignment.Center
    tbl_47.Size = UDim2.new(1, 0, 0, 26)
    tbl_47.Parent = v32
    tbl_47.BackgroundTransparency = 1
    tbl_47.TextColor3 = tbl_47.TextColor3 or (tbl_upv_2.Text)
    tbl_47.FontFace = tbl_47.FontFace or (tbl_upv_3.Bold)
    tbl_47.TextXAlignment = tbl_47.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_43 = Instance.new("TextLabel")
    for key_39, value_38 in tbl_47 do
        if key_39 ~= "Parent" then
            tbl_43[key_39] = value_38
        end
    end
    if tbl_47.Parent then
        tbl_43.Parent = tbl_47.Parent
    end
    local tbl_48 = {AutoLocalize = false, Text = "", TextStrokeTransparency = 0.6, Name = "Name", TextSize = 44}
    tbl_48.FontFace = tbl_upv_3.Display
    tbl_48.TextXAlignment = Enum.TextXAlignment.Center
    tbl_48.Position = UDim2.fromOffset(0, 26)
    tbl_48.Size = UDim2.new(1, 0, 0, 50)
    tbl_48.Parent = v32
    tbl_48.BackgroundTransparency = 1
    tbl_48.TextColor3 = tbl_48.TextColor3 or (tbl_upv_2.Text)
    tbl_48.FontFace = tbl_48.FontFace or (tbl_upv_3.Bold)
    tbl_48.TextXAlignment = tbl_48.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_47 = Instance.new("TextLabel")
    for key_40, value_39 in tbl_48 do
        if key_40 ~= "Parent" then
            tbl_47[key_40] = value_39
        end
    end
    if tbl_48.Parent then
        tbl_47.Parent = tbl_48.Parent
    end
    u3.Parent = PlayerGui_1
    u4.Parent = PlayerGui_1
    tbl_upv_8.Parent = PlayerGui_1
    tbl_48 = {}
    tbl_48.gui = u3
    tbl_48.hud = u4
    tbl_48.frame = tbl_upv_8
    tbl_48.cover = v20
    tbl_48.card = tbl_21
    tbl_48.cardScale = v21
    tbl_48.cardLabel = tbl_22
    tbl_48.cardBar = tbl_23
    tbl_48.cardName = tbl_25
    tbl_48.cardTitle = tbl_26
    tbl_48.cardStripe = tbl_24
    tbl_48.portrait = v24
    tbl_48.portraitScale = v25
    tbl_48.corners = tbl_9
    tbl_48.cornerLines = tbl_10
    tbl_48.rec = v17
    tbl_48.recDot = v19
    tbl_48.recText = tbl_14
    tbl_48.hudCanvas = tbl_28
    tbl_48.hudScale = tbl_32
    tbl_48.tag = v26
    tbl_48.tagName = tbl_34
    tbl_48.tagTitle = v29
    tbl_48.tagStripe = v27
    tbl_48.skip = v31
    tbl_48.pop = v32
    tbl_48.popTop = tbl_43
    tbl_48.popName = tbl_47
    return tbl_48
end
local function get()
    --[[
      name: get
      line: 543
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
    ]]
    if not (u2) then
        u2 = build()
    end
    return u2
end
local tbl_upv_49 = {arm = 40, recX = 35, inY = 20, inX = 24, recY = 48, stroke = 3}
local function cornerPos(a1, a2)
    --[[
      name: cornerPos
      line: 554
      upvalues:
        tbl_upv_6 (copy, index: 1)
        tbl_upv_49 (copy, index: 2)
    ]]
    local v33 = tbl_upv_6[a1]
    local X_1 = v33.X
    local v34 = ((v33.X ~= 0) and -1) or 1
    return UDim2.new(X_1, (v34 * tbl_upv_49.inX) * a2, v33.Y, ((((v33.Y ~= 0) and -1) or 1) * tbl_upv_49.inY) * a2)
end
local function recPos(a1)
    --[[
      name: recPos
      line: 559
      upvalues:
        tbl_upv_49 (copy, index: 1)
    ]]
    return UDim2.new(1, -((tbl_upv_49.inX * a1) + tbl_upv_49.recX), 0, (tbl_upv_49.inY * a1) + tbl_upv_49.recY)
end
local function round(a1)
    --[[
      name: round
      line: 564
    ]]
    return (math.floor(a1 + 0.5))
end
local function frameTo(a1, a2, a3, a4, a5, a6)
    --[[
      name: frameTo
      line: 604
      upvalues:
        tbl_upv_6 (copy, index: 1)
        tbl_upv_49 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    for key_41, value_40 in a1.corners do
        if a4 > 0 then
            local tbl_50 = {Position = 0}
            local v35 = tbl_upv_6[key_41]
            local X_2 = v35.X
            local v36 = ((v35.X ~= 0) and -1) or 1
            tbl_50.Position = UDim2.new(X_2, (v36 * tbl_upv_49.inX) * a2, v35.Y, ((((v35.Y ~= 0) and -1) or 1) * tbl_upv_49.inY) * a2)
            v36 = Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint)
            TweenService_upv_1:Create(value_40, TweenInfo.new(a4, v36, a5 or (Enum.EasingDirection.Out)), tbl_50):Play()
        else
            local v37 = tbl_upv_6[key_41]
            value_40.Position = UDim2.new(v37.X, ((((v37.X ~= 0) and -1) or 1) * tbl_upv_49.inX) * a2, v37.Y, ((((v37.Y ~= 0) and -1) or 1) * tbl_upv_49.inY) * a2)
        end
    end
    for _, value_41 in a1.cornerLines do
        if a4 > 0 then
            local tbl_51 = {}
            tbl_51.BackgroundTransparency = 1 - a3
            TweenService_upv_1:Create(value_41, TweenInfo.new(a4 * 0.8, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), a5 or (Enum.EasingDirection.Out)), tbl_51):Play()
        else
            value_41.BackgroundTransparency = 1 - a3
        end
    end
    local tbl_upv_52 = {}
    tbl_upv_52.TextTransparency = 1 - a3
    tbl_upv_52.TextStrokeTransparency = 1 - (a3 * 0.15)
    if a4 > 0 then
        local tbl_53 = {}
        tbl_53.Position = UDim2.new(1, -((tbl_upv_49.inX * a2) + tbl_upv_49.recX), 0, (tbl_upv_49.inY * a2) + tbl_upv_49.recY)
        TweenService_upv_1:Create(a1.rec, TweenInfo.new(a4, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), a5 or (Enum.EasingDirection.Out)), tbl_53):Play()
        local function fadeRec_1()
            --[[
              name: fadeRec
              line: 622
              upvalues:
                a1 (copy, index: 1)
                a4 (copy, index: 2)
                a3 (copy, index: 3)
                a5 (copy, index: 4)
                TweenService_upv_1 (copy, index: 5)
                tbl_upv_52 (copy, index: 6)
            ]]
            local tbl_54 = {}
            tbl_54.BackgroundTransparency = 1 - a3
            local recDot_1 = a1.recDot
            local v38 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
            TweenService_upv_1:Create(recDot_1, TweenInfo.new(a4 * 0.7, v38, a5 or (Enum.EasingDirection.Out)), tbl_54):Play()
            local recText_1 = a1.recText
            local v39 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
            TweenService_upv_1:Create(recText_1, TweenInfo.new(a4 * 0.7, v39, a5 or (Enum.EasingDirection.Out)), tbl_upv_52):Play()
        end
        if a6 and a6 > 0 then
            task.delay(a6, fadeRec_1)
        else
            fadeRec_1()
        end
    else
        a1.rec.Position = UDim2.new(1, -((tbl_upv_49.inX * a2) + tbl_upv_49.recX), 0, (tbl_upv_49.inY * a2) + tbl_upv_49.recY)
        a1.recDot.BackgroundTransparency = 1 - a3
        a1.recText.TextTransparency = tbl_upv_52.TextTransparency
        a1.recText.TextStrokeTransparency = tbl_upv_52.TextStrokeTransparency
    end
end
local u5 = nil
local function ensureGrade()
    --[[
      name: ensureGrade
      line: 641
      upvalues:
        u5 (ref,  index: 1)
        tbl_upv_5 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
    ]]
    local v40 = u5
    if not (v40) then
        local v41 = Instance.new("ColorCorrectionEffect")
        v41.Name = "TR_ReplayGrade"
        for key_42, value_42 in tbl_upv_5 do
            v41[key_42] = value_42
        end
        u5 = v41
        v40 = v41
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_1 and v40.Parent ~= CurrentCamera_1 then
        v40.Parent = CurrentCamera_1
    end
    return v40
end
local function gradeTo(a1, a2)
    --[[
      name: gradeTo
      line: 659
      upvalues:
        u5 (ref,  index: 1)
        tbl_upv_5 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        tbl_upv_4 (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
    ]]
    local v42 = nil
    if a1 then
        local v43 = u5
        if not (v43) then
            local v44 = Instance.new("ColorCorrectionEffect")
            v44.Name = "TR_ReplayGrade"
            for key_43, value_43 in tbl_upv_5 do
                v44[key_43] = value_43
            end
            u5 = v44
            v43 = v44
        end
        v42 = Workspace_upv_1.CurrentCamera
        if v42 and v43.Parent ~= v42 then
            v43.Parent = v42
        end
        TweenService_upv_1:Create(v43, TweenInfo.new(a2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_upv_4):Play()
    elseif u5 then
        TweenService_upv_1:Create(u5, TweenInfo.new(a2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_upv_5):Play()
    end
end
local function gradeClear()
    --[[
      name: gradeClear
      line: 667
      upvalues:
        u5 (ref, index: 1)
    ]]
    if not u5 then
        return
    end
    u5:Destroy()
    u5 = nil
end
local function setPortrait(a1, a2)
    --[[
      name: setPortrait
      line: 676
      upvalues:
        setPortrait (copy, index: 1)
    ]]
    for _, value_44 in a1.portrait:GetChildren() do
        if value_44:IsA("WorldModel") or value_44:IsA("Camera") then
            value_44:Destroy()
        end
    end
    if not a2 then
        return
    end
    local Head_1 = a2:FindFirstChild("Head")
    if not Head_1 then
        return
    end
    if Head_1:IsA("BasePart")
        and not (pcall(
            function()
                --[[
                  line: 689
                  upvalues:
                    a2 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                local v45 = Instance.new("WorldModel")
                local v46 = a2:Clone()
                for _, value_45 in v46:GetDescendants() do
                    if value_45:IsA("Tool") or value_45:IsA("Highlight") then
                        value_45:Destroy()
                    end
                end
                local v47 = v46:FindFirstChild("HumanoidRootPart")
                if v47 and v47:IsA("BasePart") then
                    v46.PrimaryPart = v47
                end
                v46:PivotTo(CFrame.new(0, 0, 0))
                v46.Parent = v45
                v45.Parent = a1.portrait
                v47 = v46:FindFirstChild("Head")
                local Position_1 = v47.Position
                local LookVector_1 = v47.CFrame.LookVector
                local v48 = Vector3.new(LookVector_1.X, 0, LookVector_1.Z)
                local v49 = ((not (v48.Magnitude > 0.2)) and Vector3.new(0, 0, -1)) or (v48.Unit)
                local v50 = v49:Cross(Vector3.new(0, 1, 0))
                local v51 = Instance.new("Camera")
                v51.FieldOfView = 30
                v51.CFrame = CFrame.lookAt(((Position_1 + (v49 * 4)) + (v50 * 0.9)) + Vector3.new(0, 0.30000001192092896, 0), Position_1 + Vector3.new(0, -0.25, 0))
                v51.Parent = a1.portrait
                a1.portrait.CurrentCamera = v51
            end
        )) then
        setPortrait(a1, nil)
    end
end
local u6 = nil
local u7 = nil
local u8 = 0
local function applyScale(a1)
    --[[
      name: applyScale
      line: 568
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        tbl_upv_49 (copy, index: 2)
    ]]
    local v52 = Workspace_upv_1.CurrentCamera
    local v53
    if v52 then
        v53 = v52.ViewportSize
    else
        v53 = Vector2.new(1600, 900)
    end
    local Y_2 = v53.Y
    if Y_2 < 560 then
        v52 = math.clamp(Y_2 / 620, 0.5, 1)
    else
        v52 = math.clamp(Y_2 / 900, 0.6, 1.4)
    end
    a1.cardScale.Scale = v52
    a1.hudScale.Scale = v52
    a1.hudCanvas.Size = UDim2.fromScale(1 / v52, 1 / v52)
    tbl_upv_49.inX = math.floor(math.clamp(v53.X * 0.0225, 12, 44) + 0.5)
    tbl_upv_49.inY = math.floor(math.clamp(v53.Y * 0.03, 10, 30) + 0.5)
    tbl_upv_49.arm = math.floor((v52 * 50) + 0.5)
    tbl_upv_49.stroke = math.max(2, math.floor((v52 * 4) + 0.5))
    for key_44, value_46 in a1.corners do
        value_46.Size = UDim2.fromOffset(tbl_upv_49.arm, tbl_upv_49.arm)
        a1.cornerLines[(key_44 * 2) - 1].Size = UDim2.new(1, 0, 0, tbl_upv_49.stroke)
        a1.cornerLines[key_44 * 2].Size = UDim2.new(0, tbl_upv_49.stroke, 1, 0)
    end
    local v54 = math.floor((v52 * 34) + 0.5)
    a1.recDot.Size = UDim2.fromOffset(v54, v54)
    a1.recText.TextSize = math.floor((v52 * 40) + 0.5)
    a1.recText.Size = UDim2.fromOffset(0, v54)
    a1.rec.Size = UDim2.fromOffset(0, v54)
    local v55 = a1.rec:FindFirstChildOfClass("UIListLayout")
    if v55 then
        v55.Padding = UDim.new(0, math.floor((v54 * 0.45) + 0.5))
    end
    tbl_upv_49.recX = math.floor(((tbl_upv_49.arm * 1.2) - (v54 / 2)) + 0.5)
    tbl_upv_49.recY = math.floor((tbl_upv_49.arm * 1.2) + 0.5)
    local v56 = tbl_upv_49.arm * 0.5
    a1.tag.Position = UDim2.new(0, (tbl_upv_49.inX + v56) / v52, 1, -(tbl_upv_49.inY + v56) / v52)
    a1.skip.Position = UDim2.new(1, -(tbl_upv_49.inX + v56) / v52, 1, -(tbl_upv_49.inY + v56) / v52)
end
local function locTitle(a1)
    --[[
      name: locTitle
      line: 31
      upvalues:
        Loc_upv_1 (copy, index: 1)
    ]]
    local v57 = string.split(a1, " \194\183 ")
    for key_45, value_47 in v57 do
        v57[key_45] = Loc_upv_1.T(value_47)
    end
    return table.concat(v57, " \194\183 ")
end
function tbl_upv_1.ShowIntro(a1)
    --[[
      name: ShowIntro
      line: 732
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        TextService_upv_1 (copy, index: 4)
        locTitle (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        setPortrait (copy, index: 7)
        playUI (copy, index: 8)
        TweenService_upv_1 (copy, index: 9)
    ]]
    if not (u2) then
        u2 = build()
    end
    applyScale(u2)
    u2.gui.Enabled = true
    u2.hud.Enabled = false
    u2.cover.Visible = true
    u2.cover.BackgroundTransparency = 0
    u2.card.Visible = true
    u2.frame.Enabled = false
    local u9 = string.upper(a1.name)
    local u10 = 104
    local success_4, v58 = pcall(function() end)
    local v59 = (success_4 and (v58.X * 1.06)) or (#u9 * u10 * 0.62)
    if v59 > 940 then
        u10 = math.max(48, math.floor(u10 * 940 / v59))
        local success_5, v60 = pcall(
            function()
                --[[
                  line: 188
                  upvalues:
                    TextService_upv_1 (copy, index: 1)
                    u9 (copy, index: 2)
                    u10 (copy, index: 3)
                ]]
                return TextService_upv_1:GetTextSize(u9, u10, Enum.Font.BuilderSansExtraBold, Vector2.new(4000, 400))
            end
        )
        v59 = (success_5 and (v60.X * 1.06)) or (#u9 * u10 * 0.62)
    end
    local v61 = locTitle(a1.title)
    u2.cardName.TextSize = u10
    u2.cardName.Text = u9
    u2.cardTitle.Text = v61
    local card_1 = u2.card
    local _ = 30
    local success_6, v62 = pcall(function() end)
    card_1.Size = UDim2.fromOffset(math.max(v59, ((success_6 and (v62.X * 1.06)) or (#v61 * 30 * 0.62)) * 0.85, 440) + 222, 260)
    local cardStripe_1 = u2.cardStripe
    local v63
    if a1.ally then
        v63 = tbl_upv_2.Ally
    else
        v63 = tbl_upv_2.Enemy
    end
    cardStripe_1.BackgroundColor3 = v63
    setPortrait(u2, a1.portrait)
    u2.cardLabel.TextTransparency = 1
    u2.cardLabel.Position = UDim2.fromOffset(166, 8)
    u2.cardBar.Size = UDim2.fromOffset(0, 5)
    u2.cardName.TextTransparency = 1
    u2.cardName.Position = UDim2.fromOffset(222, 84)
    u2.cardTitle.TextTransparency = 1
    u2.cardStripe.Size = UDim2.fromOffset(6, 0)
    u2.portrait.ImageTransparency = 1
    u2.portrait.BackgroundTransparency = 1
    u2.portraitScale.Scale = 0.82
    v59 = u2.portrait:FindFirstChildOfClass("UIStroke")
    if v59 then
        v59.Transparency = 0.82
    end
    task.delay(
        0.05,
        function()
            --[[
              line: 771
              upvalues:
                playUI (copy, index: 1)
                u2 (copy, index: 2)
                TweenService_upv_1 (copy, index: 3)
            ]]
            playUI("UI/Whoosh")
            local tbl_55 = {TextTransparency = 0}
            tbl_55.Position = UDim2.fromOffset(196, 8)
            TweenService_upv_1:Create(u2.cardLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_55):Play()
            local tbl_56 = {}
            tbl_56.Size = UDim2.fromOffset(150, 5)
            TweenService_upv_1:Create(u2.cardBar, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_56):Play()
        end
    )
    task.delay(
        0.18,
        function()
            --[[
              line: 776
              upvalues:
                u2 (copy, index: 1)
                TweenService_upv_1 (copy, index: 2)
            ]]
            local tbl_57 = {BackgroundTransparency = 0, ImageTransparency = 0}
            TweenService_upv_1:Create(u2.portrait, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_57):Play()
            local tbl_58 = {Scale = 1}
            TweenService_upv_1:Create(u2.portraitScale, TweenInfo.new(0.4, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_58):Play()
            local tbl_59 = {}
            tbl_59.Size = UDim2.fromOffset(6, 104)
            TweenService_upv_1:Create(u2.cardStripe, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_59):Play()
        end
    )
    task.delay(
        0.26,
        function()
            --[[
              line: 781
              upvalues:
                u2 (copy, index: 1)
                TweenService_upv_1 (copy, index: 2)
            ]]
            local tbl_60 = {TextTransparency = 0}
            tbl_60.Position = UDim2.fromOffset(222, 60)
            TweenService_upv_1:Create(u2.cardName, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_60):Play()
        end
    )
    task.delay(
        0.5,
        function()
            --[[
              line: 784
              upvalues:
                u2 (copy, index: 1)
                TweenService_upv_1 (copy, index: 2)
            ]]
            local tbl_61 = {TextTransparency = 0}
            TweenService_upv_1:Create(u2.cardTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_61):Play()
        end
    )
    u2.tagName.Text = string.upper(a1.name)
    u2.tagTitle.Text = v61
    local tagStripe_1 = u2.tagStripe
    local v64
    if a1.ally then
        v64 = tbl_upv_2.Ally
    else
        v64 = tbl_upv_2.Enemy
    end
    tagStripe_1.BackgroundColor3 = v64
end
function tbl_upv_1.Reveal()
    --[[
      name: Reveal
      line: 794
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        tbl_upv_6 (copy, index: 4)
        tbl_upv_49 (copy, index: 5)
        frameTo (copy, index: 6)
        u5 (ref,  index: 7)
        tbl_upv_5 (copy, index: 8)
        Workspace_upv_1 (copy, index: 9)
        tbl_upv_4 (copy, index: 10)
        TweenService_upv_1 (copy, index: 11)
        playUI (copy, index: 12)
    ]]
    if not (u2) then
        u2 = build()
    end
    applyScale(u2)
    u2.frame.Enabled = true
    for key_46, value_48 in u2.corners do
        local v65 = tbl_upv_6[key_46]
        value_48.Position = UDim2.new(v65.X, ((((v65.X ~= 0) and -1) or 1) * tbl_upv_49.inX) * 0, v65.Y, ((((v65.Y ~= 0) and -1) or 1) * tbl_upv_49.inY) * 0)
    end
    for _, value_49 in u2.cornerLines do
        value_49.BackgroundTransparency = 1
    end
    local tbl_62 = {TextTransparency = 1, TextStrokeTransparency = 1}
    u2.rec.Position = UDim2.new(1, -((tbl_upv_49.inX * 0) + tbl_upv_49.recX), 0, (tbl_upv_49.inY * 0) + tbl_upv_49.recY)
    u2.recDot.BackgroundTransparency = 1
    u2.recText.TextTransparency = tbl_62.TextTransparency
    u2.recText.TextStrokeTransparency = tbl_62.TextStrokeTransparency
    frameTo(u2, 1, 1, 0.4, Enum.EasingDirection.Out, 0.08)
    local v66 = u5
    if not (v66) then
        local v67 = Instance.new("ColorCorrectionEffect")
        v67.Name = "TR_ReplayGrade"
        for key_47, value_50 in tbl_upv_5 do
            v67[key_47] = value_50
        end
        u5 = v67
        v66 = v67
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_2 and v66.Parent ~= CurrentCamera_2 then
        v66.Parent = CurrentCamera_2
    end
    TweenService_upv_1:Create(v66, TweenInfo.new(0.4, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_upv_4):Play()
    local tbl_63 = {}
    tbl_63.Position = UDim2.new(0.5, -60, 0.5, 0)
    TweenService_upv_1:Create(u2.card, TweenInfo.new(0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out)), tbl_63):Play()
    for _, value_51 in {u2.cardLabel, u2.cardName, u2.cardTitle} do
        local tbl_64 = {TextTransparency = 1}
        TweenService_upv_1:Create(value_51, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_64):Play()
    end
    local tbl_65 = {BackgroundTransparency = 1, ImageTransparency = 1}
    TweenService_upv_1:Create(u2.portrait, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_65):Play()
    v66 = u2.portrait:FindFirstChildOfClass("UIStroke")
    if v66 then
        local tbl_66 = {Transparency = 1}
        TweenService_upv_1:Create(v66, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_66):Play()
    end
    local tbl_67 = {BackgroundTransparency = 1}
    TweenService_upv_1:Create(u2.cardBar, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_67):Play()
    local tbl_68 = {BackgroundTransparency = 1}
    TweenService_upv_1:Create(u2.cardStripe, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_68):Play()
    local tbl_69 = {BackgroundTransparency = 1}
    TweenService_upv_1:Create(u2.cover, TweenInfo.new(0.45, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_69):Play()
    playUI("UI/Whoosh")
    task.delay(
        0.46,
        function()
            --[[
              line: 814
              upvalues:
                u2 (copy, index: 1)
            ]]
            if not (u2.cover.BackgroundTransparency >= 0.99) then
                return
            end
            u2.card.Visible = false
            u2.card.Position = UDim2.fromScale(0.5, 0.5)
            u2.cardBar.BackgroundTransparency = 0
            u2.cardStripe.BackgroundTransparency = 0
        end
    )
    u2.hud.Enabled = true
    u2.tag.BackgroundTransparency = 1
    local tbl_70 = {BackgroundTransparency = 0.12}
    TweenService_upv_1:Create(u2.tag, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_70):Play()
end
function tbl_upv_1.Kill(a1, a2, a3)
    --[[
      name: Kill
      line: 828
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
        u8 (ref,  index: 3)
        tbl_upv_2 (copy, index: 4)
        Loc_upv_1 (copy, index: 5)
        TweenService_upv_1 (copy, index: 6)
    ]]
    if not (u2) then
        u2 = build()
    end
    u8 = u8 + 1
    local u11 = u8
    u2.popTop.Text = ((a2 >= 3) and "TRIPLE ELIMINATION") or (((a2 ~= 2) and "ELIMINATED") or "DOUBLE ELIMINATION")
    local popTop_1 = u2.popTop
    local v68
    if a2 >= 2 then
        v68 = tbl_upv_2.Gold
    else
        v68 = tbl_upv_2.TextDim
    end
    popTop_1.TextColor3 = v68
    local popName_1 = u2.popName
    local v69 = string.upper(a1)
    local v70 = (a3 and ("  \194\183  " .. Loc_upv_1.T("HEADSHOT"))) or ""
    popName_1.Text = v69 .. v70
    u2.pop.Visible = true
    u2.pop.Position = UDim2.new(0.5, 0, 0.22, 14)
    u2.popTop.TextTransparency = 1
    u2.popName.TextTransparency = 1
    local tbl_71 = {}
    tbl_71.Position = UDim2.fromScale(0.5, 0.22)
    TweenService_upv_1:Create(u2.pop, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_71):Play()
    local tbl_72 = {TextTransparency = 0}
    TweenService_upv_1:Create(u2.popTop, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_72):Play()
    local tbl_73 = {TextTransparency = 0}
    TweenService_upv_1:Create(u2.popName, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_73):Play()
    task.delay(
        1.5,
        function()
            --[[
              line: 843
              upvalues:
                u11 (copy, index: 1)
                u8 (ref,  index: 2)
                u2 (copy, index: 3)
                TweenService_upv_1 (copy, index: 4)
            ]]
            if u11 ~= u8 then
                return
            end
            local tbl_74 = {TextTransparency = 1}
            TweenService_upv_1:Create(u2.popTop, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_74):Play()
            local tbl_75 = {TextTransparency = 1}
            TweenService_upv_1:Create(u2.popName, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_75):Play()
            task.delay(
                0.32,
                function()
                    --[[
                      line: 849
                      upvalues:
                        u11 (copy, index: 1)
                        u8 (ref,  index: 2)
                        u2 (copy, index: 3)
                    ]]
                    if u11 ~= u8 then
                        return
                    end
                    u2.pop.Visible = false
                end
            )
        end
    )
end
function tbl_upv_1.Outro(a1, a2)
    --[[
      name: Outro
      line: 859
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
        frameTo (copy, index: 3)
        u5 (ref,  index: 4)
        tbl_upv_5 (copy, index: 5)
        TweenService_upv_1 (copy, index: 6)
    ]]
    if not (u2) then
        u2 = build()
    end
    local u12 = math.max(0.15, a2 * 0.45)
    u2.cover.Visible = true
    u2.card.Visible = false
    frameTo(u2, 0, 0, u12, Enum.EasingDirection.Out)
    if u5 then
        TweenService_upv_1:Create(u5, TweenInfo.new(u12, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_upv_5):Play()
    end
    local tbl_76 = {BackgroundTransparency = 0}
    TweenService_upv_1:Create(u2.cover, TweenInfo.new(u12, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out)), tbl_76):Play()
    task.delay(
        u12 + 0.02,
        function()
            --[[
              line: 868
              upvalues:
                u2 (copy, index: 1)
                u5 (ref,  index: 2)
                a1 (copy, index: 3)
                a2 (copy, index: 4)
                u12 (copy, index: 5)
                TweenService_upv_1 (copy, index: 6)
            ]]
            u2.hud.Enabled = false
            u2.frame.Enabled = false
            if u5 then
                u5:Destroy()
                u5 = nil
            end
            pcall(a1)
            local v71 = math.max(0.15, a2 - u12)
            local tbl_77 = {BackgroundTransparency = 1}
            TweenService_upv_1:Create(u2.cover, TweenInfo.new(v71, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_77):Play()
            task.delay(
                math.max(0.15, a2 - u12) + 0.02,
                function()
                    --[[
                      line: 874
                      upvalues:
                        u2 (copy, index: 1)
                    ]]
                    if not (u2.cover.BackgroundTransparency >= 0.99) then
                        return
                    end
                    u2.gui.Enabled = false
                end
            )
        end
    )
end
function tbl_upv_1.Hide()
    --[[
      name: Hide
      line: 883
      upvalues:
        u2 (ref,  index: 1)
        u5 (ref,  index: 2)
        setPortrait (copy, index: 3)
    ]]
    if not u2 then
        return
    end
    u2.gui.Enabled = false
    u2.hud.Enabled = false
    u2.frame.Enabled = false
    if u5 then
        u5:Destroy()
        u5 = nil
    end
    u2.pop.Visible = false
    setPortrait(u2, nil)
end
function tbl_upv_1.BindSkip(a1)
    --[[
      name: BindSkip
      line: 898
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        build (copy, index: 3)
        u6 (ref,  index: 4)
        u7 (ref,  index: 5)
        UserInputService_upv_1 (copy, index: 6)
    ]]
    tbl_upv_1.UnbindSkip()
    if not (u2) then
        u2 = build()
    end
    local u13 = os.clock() + 0.5
    local v72 = u2.skip.Activated:Connect(
        function()
            --[[
              line: 902
              upvalues:
                u13 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            if not (u13 <= os.clock()) then
                return
            end
            a1()
        end
    )
    u6 = v72
    local v73 = UserInputService_upv_1.InputBegan:Connect(
        function(a2, a3)
            --[[
              line: 907
              upvalues:
                u13 (copy, index: 1)
                UserInputService_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            if (os.clock() < u13) or (UserInputService_upv_1:GetFocusedTextBox()) then
                return
            end
            if a2.KeyCode == Enum.KeyCode.ButtonB and not (a3) then
                a1()
            end
        end
    )
    u7 = v73
end
function tbl_upv_1.UnbindSkip()
    --[[
      name: UnbindSkip
      line: 917
      upvalues:
        u6 (ref, index: 1)
        u7 (ref, index: 2)
    ]]
    if u6 then
        u6:Disconnect()
        u6 = nil
    end
    if not u7 then
        return
    end
    u7:Disconnect()
    u7 = nil
end
function tbl_upv_1.DebugFrame(a1)
    --[[
      name: DebugFrame
      line: 930
      upvalues:
        u2 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        tbl_upv_6 (copy, index: 4)
        tbl_upv_49 (copy, index: 5)
        u5 (ref,  index: 6)
        tbl_upv_5 (copy, index: 7)
        Workspace_upv_1 (copy, index: 8)
        tbl_upv_4 (copy, index: 9)
    ]]
    if not (u2) then
        u2 = build()
    end
    local v74 = math.clamp(a1 or 1, 0, 1)
    applyScale(u2)
    u2.frame.Enabled = true
    for key_48, value_52 in u2.corners do
        local v75 = tbl_upv_6[key_48]
        value_52.Position = UDim2.new(v75.X, ((((v75.X ~= 0) and -1) or 1) * tbl_upv_49.inX) * v74, v75.Y, ((((v75.Y ~= 0) and -1) or 1) * tbl_upv_49.inY) * v74)
    end
    for _, value_53 in u2.cornerLines do
        value_53.BackgroundTransparency = 1 - v74
    end
    local tbl_78 = {}
    tbl_78.TextTransparency = 1 - v74
    tbl_78.TextStrokeTransparency = 1 - (v74 * 0.15)
    u2.rec.Position = UDim2.new(1, -((tbl_upv_49.inX * v74) + tbl_upv_49.recX), 0, (tbl_upv_49.inY * v74) + tbl_upv_49.recY)
    u2.recDot.BackgroundTransparency = 1 - v74
    u2.recText.TextTransparency = tbl_78.TextTransparency
    u2.recText.TextStrokeTransparency = tbl_78.TextStrokeTransparency
    local v76 = u5
    if not (v76) then
        local tbl_79 = Instance.new("ColorCorrectionEffect")
        tbl_79.Name = "TR_ReplayGrade"
        for key_49, value_54 in tbl_upv_5 do
            tbl_79[key_49] = value_54
        end
        u5 = tbl_79
        v76 = tbl_79
    end
    local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_3 and v76.Parent ~= CurrentCamera_3 then
        v76.Parent = CurrentCamera_3
    end
    v76.TintColor = tbl_upv_5.TintColor:Lerp(tbl_upv_4.TintColor, v74)
    v76.Saturation = tbl_upv_4.Saturation * v74
    v76.Contrast = tbl_upv_4.Contrast * v74
    local tbl_79 = {}
    tbl_79.k = v74
    tbl_79.inX = tbl_upv_49.inX
    tbl_79.inY = tbl_upv_49.inY
    tbl_79.arm = tbl_upv_49.arm
    tbl_79.stroke = tbl_upv_49.stroke
    tbl_79.recX = tbl_upv_49.recX
    tbl_79.recY = tbl_upv_49.recY
    tbl_79.abs = u2.frame.AbsoluteSize
    return tbl_79
end
function tbl_upv_1.Gui()
    --[[
      name: Gui
      line: 943
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 then
        return u2.gui
    end
    return nil
end
function tbl_upv_1.HudGui()
    --[[
      name: HudGui
      line: 947
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 then
        return u2.hud
    end
    return nil
end
return tbl_upv_1