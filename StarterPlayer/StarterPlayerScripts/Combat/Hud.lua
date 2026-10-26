local _ = game:GetService("GuiService")
local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold)
local u2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local u3 = Color3.fromRGB(250, 248, 242)
local u4 = Color3.fromRGB(255, 208, 60)
local u5 = Color3.fromRGB(255, 62, 62)
local u6 = Color3.fromRGB(96, 186, 255)
local u7 = Color3.fromRGB(16, 12, 10)
local u8 = Color3.fromRGB(120, 110, 100)
local u9 = nil
local u10 = nil
local tbl_upv_2 = {}
local u11 = "Dot"
local u12 = 1
local u13 = 0
local u14 = 0
local u15 = 0
local u16 = false
local u17 = false
local u18 = 0
local u19 = 0
local u20 = u3
local function stroke(a1, a2, a3, a4)
    --[[
      name: stroke
      line: 43
      upvalues:
        u7 (copy, index: 1)
    ]]
    local v1 = Instance.new("UIStroke")
    v1.Name = "Stroke"
    v1.Thickness = a2
    v1.Color = a3 or u7
    v1.Transparency = a4 or 0.35
    v1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v1.Parent = a1
    return v1
end
local function round(a1, a2)
    --[[
      name: round
      line: 66
    ]]
    local v3 = Instance.new("UICorner")
    v3.CornerRadius = UDim.new(a2 or 1, 0)
    v3.Parent = a1
end
local function frame(a1, a2, a3, a4, a5)
    --[[
      name: frame
      line: 54
      upvalues:
        u3 (copy, index: 1)
    ]]
    local v4 = Instance.new("Frame")
    v4.Name = a2
    v4.Size = a3
    v4.Position = a4 or UDim2.fromScale(0.5, 0.5)
    v4.AnchorPoint = Vector2.new(0.5, 0.5)
    v4.BackgroundColor3 = a5 or u3
    v4.BorderSizePixel = 0
    v4.Parent = a1
    return v4
end
local function dot(a1, a2)
    --[[
      name: dot
      line: 72
      upvalues:
        frame (copy, index: 1)
        u7 (copy, index: 2)
    ]]
    local v7 = frame(a1, "Dot", UDim2.fromOffset(a2, a2))
    local v8 = Instance.new("UICorner")
    v8.CornerRadius = UDim.new(1, 0)
    v8.Parent = v7
    local v9 = Instance.new("UIStroke")
    v9.Name = "Stroke"
    v9.Thickness = 1.2
    v9.Color = u7
    v9.Transparency = 0.25
    v9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v9.Parent = v7
    return v7
end
local function tick(a1, a2, a3, a4)
    --[[
      name: tick
      line: 102
      upvalues:
        frame (copy, index: 1)
        u7 (copy, index: 2)
    ]]
    local v10 = frame(a1, a2, UDim2.fromOffset(a3, a4))
    local v11 = Instance.new("UIStroke")
    v11.Name = "Stroke"
    v11.Thickness = 1
    v11.Color = u7
    v11.Transparency = 0.3
    v11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v11.Parent = v10
    return v10
end
local tbl_upv_3 = {}
local u21 = nil
local tbl_upv_4 = {}
local u22 = nil
local u23 = nil
local function ring(a1, a2, a3, a4, a5)
    --[[
      name: ring
      line: 79
      upvalues:
        frame (copy, index: 1)
        u3 (copy, index: 2)
        u7 (copy, index: 3)
    ]]
    local v12 = frame(a1, a2, UDim2.fromOffset(a3, a3))
    v12.BackgroundTransparency = 1
    local v13 = Instance.new("UICorner")
    v13.CornerRadius = UDim.new(1, 0)
    v13.Parent = v12
    local v14 = Instance.new("UIStroke")
    v14.Name = "Stroke"
    v14.Thickness = a4
    v14.Color = u3
    v14.Transparency = a5 or 0
    v14.Parent = v12
    local v15 = frame(v12, "Rim", UDim2.new(1, a4 + 2, 1, a4 + 2))
    v15.BackgroundTransparency = 1
    local v16 = Instance.new("UICorner")
    v16.CornerRadius = UDim.new(1, 0)
    v16.Parent = v15
    local v17 = Instance.new("UIStroke")
    v17.Name = "Stroke"
    v17.Thickness = 1
    v17.Color = u7
    v17.Transparency = 0.6
    v17.Parent = v15
    return v12
end
local function buildStyles()
    --[[
      name: buildStyles
      line: 135
      upvalues:
        frame (copy, index: 1)
        u10 (ref,  index: 2)
        u7 (copy, index: 3)
        ring (copy, index: 4)
        u6 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        u3 (copy, index: 7)
        tbl_upv_3 (copy, index: 8)
        u21 (ref,  index: 9)
        u22 (ref,  index: 10)
        u23 (ref,  index: 11)
    ]]
    local v18 = frame(u10, "Melee", UDim2.fromOffset(0, 0))
    v18.BackgroundTransparency = 1
    local v19 = frame(v18, "Dot", UDim2.fromOffset(5, 5))
    local v20 = Instance.new("UICorner")
    v20.CornerRadius = UDim.new(1, 0)
    v20.Parent = v19
    local v21 = Instance.new("UIStroke")
    v21.Name = "Stroke"
    v21.Thickness = 1.2
    v21.Color = u7
    v21.Transparency = 0.25
    v21.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v21.Parent = v19
    ring(v18, "Ring", 24, 1.6, 0.45)
    local v22 = frame(v18, "Shield", UDim2.fromOffset(30, 36))
    v22.BackgroundTransparency = 1
    v22.Visible = false
    local tbl_5 = {"Top", UDim2.fromOffset(28, 20), UDim2.fromScale(0.5, 0.3)}
    local tbl_6 = {tbl_5, {"Point", UDim2.fromOffset(20, 20), UDim2.fromScale(0.5, 0.58)}}
    for _, value_1 in tbl_6 do
        local v23 = frame(v22, value_1[1], value_1[2], value_1[3], u6)
        v23.BackgroundTransparency = 0.3
        if value_1[1] == "Point" then
            v23.Rotation = 45
        end
        local v24 = Instance.new("UICorner")
        v24.CornerRadius = UDim.new(0, ((value_1[1] ~= "Top") and 3) or 5)
        v24.Parent = v23
    end
    local v25 = Instance.new("UIScale")
    v25.Name = "Pulse"
    v25.Parent = v22
    tbl_upv_2.Melee = v18
    local v26 = frame(u10, "Bow", UDim2.fromOffset(0, 0))
    v26.BackgroundTransparency = 1
    local v27 = frame(v26, "Dot", UDim2.fromOffset(4, 4))
    v18 = Instance.new("UICorner")
    v18.CornerRadius = UDim.new(1, 0)
    v18.Parent = v27
    local v28 = Instance.new("UIStroke")
    v28.Name = "Stroke"
    v28.Thickness = 1.2
    v28.Color = u7
    v28.Transparency = 0.25
    v28.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v28.Parent = v27
    ring(v26, "Ring", 66, 2.2, 0.1)
    for key_1, value_2 in {-1, 1} do
        local v29 = frame(v26, "Side" .. key_1, UDim2.fromOffset(9, 2.5))
        local v30 = Instance.new("UIStroke")
        v30.Name = "Stroke"
        v30.Thickness = 1
        if u7 or not u7 then
            v30.Color = u7
            v30.Transparency = 0.3
            v30.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v30.Parent = v29
            v29.Position = UDim2.new(0.5, value_2 * 44, 0.5, 0)
        end
    end
    tbl_upv_2.Bow = v26
    local v31 = frame(u10, "Gun", UDim2.fromOffset(0, 0))
    v31.BackgroundTransparency = 1
    local v32 = frame(v31, "Dot", UDim2.fromOffset(3.5, 3.5))
    local v33 = Instance.new("UICorner")
    v33.CornerRadius = UDim.new(1, 0)
    v33.Parent = v32
    local v34 = Instance.new("UIStroke")
    v34.Name = "Stroke"
    v34.Thickness = 1.2
    v34.Color = u7
    v34.Transparency = 0.25
    v34.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v34.Parent = v32
    local v35 = nil
    local v36 = nil
    for _, value_3 in {"Up", "Down", "Left", "Right"} do
        v35 = true
        if value_3 ~= "Up" then
            v35 = value_3 == "Down"
        end
        if v35 then
            v36 = 2.5
        else
            v36 = 10
        end
        local v37 = frame(v31, value_3, UDim2.fromOffset(v36, (v35 and 10) or 2.5))
        local v38 = Instance.new("UIStroke")
        v38.Name = "Stroke"
        v38.Thickness = 1
        if u7 or not u7 then
            v38.Color = u7
            v38.Transparency = 0.3
            v38.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v38.Parent = v37
        end
    end
    tbl_upv_2.Gun = v31
    local v39 = frame(u10, "Spread", UDim2.fromOffset(0, 0))
    v39.BackgroundTransparency = 1
    local v40 = frame(v39, "Dot", UDim2.fromOffset(4, 4))
    local v41 = Instance.new("UICorner")
    v41.CornerRadius = UDim.new(1, 0)
    v41.Parent = v40
    local v42 = Instance.new("UIStroke")
    v42.Name = "Stroke"
    v42.Thickness = 1.2
    v42.Color = u7
    v42.Transparency = 0.25
    v42.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v42.Parent = v40
    ring(v39, "Ring", 80, 2, 0.15)
    for n_1 = 0, 3 do
        local v43 = math.rad(n_1 * 90)
        v36 = ((n_1 % 2 ~= 0) and 8) or 2.5
        local v44 = frame(v39, "Notch" .. n_1, UDim2.fromOffset(v36, ((n_1 % 2 ~= 0) and 2.5) or 8))
        local v45 = Instance.new("UIStroke")
        v45.Name = "Stroke"
        v45.Thickness = 1
        if u7 or not u7 then
            v45.Color = u7
            v45.Transparency = 0.3
            v45.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v45.Parent = v44
            v44.Position = UDim2.new(0.5, math.sin(v43) * 40, 0.5, -math.cos(v43) * 40)
            local v46 = n_1
        end
    end
    tbl_upv_2.Spread = v39
    local v47 = frame(u10, "Throw", UDim2.fromOffset(0, 0))
    v47.BackgroundTransparency = 1
    local v48 = frame(v47, "Dot", UDim2.fromOffset(5, 5))
    local v49 = Instance.new("UICorner")
    v49.CornerRadius = UDim.new(1, 0)
    v49.Parent = v48
    local v46 = Instance.new("UIStroke")
    v46.Name = "Stroke"
    v46.Thickness = 1.2
    v46.Color = u7
    v46.Transparency = 0.25
    v46.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v46.Parent = v48
    ring(v47, "Ring", 44, 2, 0.25)
    tbl_upv_2.Throw = v47
    local v50 = frame(u10, "Use", UDim2.fromOffset(0, 0))
    v50.BackgroundTransparency = 1
    local v51 = frame(v50, "Dot", UDim2.fromOffset(5, 5))
    v49 = Instance.new("UICorner")
    v49.CornerRadius = UDim.new(1, 0)
    v49.Parent = v51
    v46 = Instance.new("UIStroke")
    v46.Name = "Stroke"
    v46.Thickness = 1.2
    v46.Color = u7
    v46.Transparency = 0.25
    v46.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v46.Parent = v51
    ring(v50, "Ring", 18, 1.4, 0.55)
    tbl_upv_2.Use = v50
    local v52 = frame(u10, "Dot", UDim2.fromOffset(0, 0))
    v52.BackgroundTransparency = 1
    local v53 = frame(v52, "Dot", UDim2.fromOffset(4, 4))
    v49 = Instance.new("UICorner")
    v49.CornerRadius = UDim.new(1, 0)
    v49.Parent = v53
    v46 = Instance.new("UIStroke")
    v46.Name = "Stroke"
    v46.Thickness = 1.2
    v46.Color = u7
    v46.Transparency = 0.25
    v46.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v46.Parent = v53
    tbl_upv_2.Dot = v52
    for _, value_4 in tbl_upv_2 do
        value_4.Visible = false
        local v54 = Instance.new("UIScale")
        v54.Name = "Punch"
        v54.Parent = value_4
    end
    tbl_upv_2.Dot.Visible = true
    local v55 = frame(u10, "Arc", UDim2.fromOffset(0, 0))
    v55.BackgroundTransparency = 1
    for n_2 = 1, 24 do
        local v56 = ((n_2 - 1) / 24) * math.pi * 2
        local v57 = frame(v55, "D" .. n_2, UDim2.fromOffset(4, 4), UDim2.new(0.5, math.sin(v56) * 30, 0.5, -math.cos(v56) * 30), u3)
        local v58 = Instance.new("UICorner")
        v58.CornerRadius = UDim.new(1, 0)
        v58.Parent = v57
        v57.Visible = false
        tbl_upv_3[n_2] = v57
        local v59 = n_2
    end
    u21 = frame(u10, "Pips", UDim2.fromOffset(120, 10), UDim2.new(0.5, 0, 0.5, 44))
    u21.BackgroundTransparency = 1
    local v60 = Instance.new("UIListLayout")
    v60.FillDirection = Enum.FillDirection.Horizontal
    v60.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v60.VerticalAlignment = Enum.VerticalAlignment.Center
    v60.Padding = UDim.new(0, 6)
    v60.SortOrder = Enum.SortOrder.LayoutOrder
    v60.Parent = u21
    u21.Visible = false
    u22 = frame(u10, "Guard", UDim2.fromOffset(72, 7), UDim2.new(0.5, 0, 0.5, 44), u7)
    u22.BackgroundTransparency = 0.45
    local v61 = u22
    local v62 = Instance.new("UICorner")
    v62.CornerRadius = UDim.new(0.5, 0)
    v62.Parent = v61
    local v63 = u22
    local v59 = Instance.new("UIStroke")
    v59.Name = "Stroke"
    v59.Thickness = 1.5
    v59.Color = u7
    v59.Transparency = 0.25
    v59.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v59.Parent = v63
    u23 = frame(u22, "Fill", UDim2.fromScale(1, 1), UDim2.fromScale(0, 0.5), u6)
    u23.AnchorPoint = Vector2.new(0, 0.5)
    local v64 = u23
    local v65 = Instance.new("UICorner")
    v65.CornerRadius = UDim.new(0.5, 0)
    v65.Parent = v64
    u22.Visible = false
end
local tbl_upv_7 = {}
local u24 = 0
local tbl_upv_8 = {Vector2.new(-1, -1), Vector2.new(1, -1), Vector2.new(1, 1), Vector2.new(-1, 1)}
local function buildHitmarker()
    --[[
      name: buildHitmarker
      line: 262
      upvalues:
        frame (copy, index: 1)
        u10 (ref,  index: 2)
        u7 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
    ]]
    local v66 = frame(u10, "Hitmarker", UDim2.fromOffset(0, 0))
    v66.BackgroundTransparency = 1
    v66.ZIndex = 5
    for n_3 = 1, 4 do
        local v67 = frame(v66, "L" .. n_3, UDim2.fromOffset(10, 3))
        v67.BackgroundTransparency = 1
        v67.Rotation = ((n_3 % 2 ~= 1) and -45) or 45
        v67.ZIndex = 5
        local v68 = Instance.new("UIStroke")
        v68.Name = "Stroke"
        v68.Thickness = 1.2
        if u7 or not u7 then
            v68.Color = u7
            v68.Transparency = 1
            v68.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v68.Parent = v67
            v68.Name = "Stroke"
            tbl_upv_7[n_3] = v67
        end
    end
end
local function markerColor(a1)
    --[[
      name: markerColor
      line: 277
      upvalues:
        u5 (copy, index: 1)
        u4 (copy, index: 2)
        u3 (copy, index: 3)
    ]]
    if a1 ~= "kill" then
        if a1 ~= "crit" then
            return u3
        end
        return u4
    end
    return u5
end
local function punch(a1)
    --[[
      name: punch
      line: 281
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u11 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    local v69 = tbl_upv_2[u11]
    local v70 = v69 and (v69:FindFirstChild("Punch"))
    if v70 then
        v70.Scale = a1
        local tbl_9 = {Scale = 1}
        TweenService_upv_1:Create(v70, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_9):Play()
    end
end
function tbl_upv_1.Hitmarker(a1)
    --[[
      name: Hitmarker
      line: 291
      upvalues:
        u24 (ref,  index: 1)
        u5 (copy, index: 2)
        u4 (copy, index: 3)
        u3 (copy, index: 4)
        tbl_upv_7 (copy, index: 5)
        tbl_upv_8 (copy, index: 6)
        TweenService_upv_1 (copy, index: 7)
        punch (copy, index: 8)
    ]]
    u24 = os.clock()
    local v71
    if a1 == "kill" then
        v71 = u5
    elseif a1 ~= "crit" then
        v71 = u3
    else
        v71 = u4
    end
    local v72 = true
    if a1 ~= "kill" then
        v72 = a1 == "crit"
    end
    local v73 = ((a1 == "kill") and 18) or (((a1 ~= "crit") and 11) or 14)
    local v74 = ((a1 == "kill") and 4) or (((a1 ~= "crit") and 2.8) or 3.4)
    local v75 = ((a1 ~= "kill") and 6) or 8
    local v76 = ((a1 == "kill") and 20) or ((v72 and 15) or 12)
    local v77 = ((a1 ~= "predict") and 0) or 0.25
    for key_2, value_5 in tbl_upv_7 do
        local v78 = tbl_upv_8[key_2]
        value_5.Size = UDim2.fromOffset(v73 * 1.4, v74)
        value_5.BackgroundColor3 = v71
        value_5.BackgroundTransparency = v77
        value_5.Position = UDim2.new(0.5, v78.X * v75, 0.5, v78.Y * v75)
        local Stroke_1 = value_5:FindFirstChild("Stroke")
        Stroke_1.Transparency = v77 + 0.25
        local v79 = TweenInfo.new(((a1 ~= "kill") and 0.34) or 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tbl_10 = {BackgroundTransparency = 1}
        tbl_10.Position = UDim2.new(0.5, v78.X * v76, 0.5, v78.Y * v76)
        tbl_10.Size = UDim2.fromOffset(v73, v74)
        TweenService_upv_1:Create(value_5, v79, tbl_10):Play()
        TweenService_upv_1:Create(Stroke_1, v79, {Transparency = 1}):Play()
    end
    punch(((a1 == "kill") and 1.6) or ((v72 and 1.35) or 1.2))
end
function tbl_upv_1.UpgradeHitmarker(a1)
    --[[
      name: UpgradeHitmarker
      line: 320
      upvalues:
        u24 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        u5 (copy, index: 3)
        u4 (copy, index: 4)
        u3 (copy, index: 5)
        tbl_upv_7 (copy, index: 6)
        TweenService_upv_1 (copy, index: 7)
    ]]
    if a1 == "kill" or a1 == "crit" or os.clock() - u24 > 0.3 then
        tbl_upv_1.Hitmarker(a1)
    else
        local v80
        if a1 == "kill" then
            v80 = u5
        elseif a1 ~= "crit" then
            v80 = u3
        else
            v80 = u4
        end
        local v81 = TweenInfo.new(math.max(0.12, 0.34 - (os.clock() - u24)), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        for _, value_6 in tbl_upv_7 do
            value_6.BackgroundColor3 = v80
            value_6.BackgroundTransparency = 0
            local Stroke_2 = value_6:FindFirstChild("Stroke")
            Stroke_2.Transparency = 0.25
            TweenService_upv_1:Create(value_6, v81, {BackgroundTransparency = 1}):Play()
            TweenService_upv_1:Create(Stroke_2, v81, {Transparency = 1}):Play()
        end
    end
end
local tbl_upv_11 = {}
local tbl_upv_12 = {}
local u25 = nil
local tbl_upv_13 = {}
tbl_upv_13.crit = u4
tbl_upv_13.kill = u5
tbl_upv_13.dot = Color3.fromRGB(255, 150, 60)
tbl_upv_13.health = u3
tbl_upv_13.blocked = Color3.fromRGB(150, 200, 255)
tbl_upv_13.armor = Color3.fromRGB(170, 190, 215)
local tbl_upv_14 = {kill = 62, dot = 26, armor = 38, blocked = 34, crit = 56, health = 42}
local function popNumber(a1)
    --[[
      name: popNumber
      line: 383
      upvalues:
        u12 (ref,  index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    local v82 = (((a1.big) and 1.7) or 1.5) * u12
    a1.scale.Scale = u12 * 0.3
    local tbl_15 = {}
    tbl_15.Scale = v82
    TweenService_upv_1:Create(a1.scale, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_15):Play()
    task.delay(
        0.12,
        function()
            --[[
              line: 387
              upvalues:
                a1 (copy, index: 1)
                TweenService_upv_1 (copy, index: 2)
                u12 (ref,  index: 3)
            ]]
            if a1.label.Parent then
                local v83 = TweenInfo.new(0.14, Enum.EasingStyle.Quad)
                local tbl_16 = {}
                tbl_16.Scale = u12
                TweenService_upv_1:Create(a1.scale, v83, tbl_16):Play()
            end
        end
    )
end
local function setKind(a1, a2)
    --[[
      name: setKind
      line: 414
      upvalues:
        tbl_upv_13 (copy, index: 1)
        u3 (copy, index: 2)
        tbl_upv_14 (copy, index: 3)
        u7 (copy, index: 4)
    ]]
    if a1.kind == a2 then
        return
    end
    if a1.kind ~= "kill" then
        a1.kind = a2
        local v84 = true
        if a2 ~= "crit" then
            v84 = a2 == "kill"
        end
        a1.big = v84
        v84 = a1.label
        local v85 = tbl_upv_13[a2] or u3
        v84.TextColor3 = v85
        a1.label.TextSize = tbl_upv_14[a2] or 42
        v84 = a1.stroke
        if a2 ~= "kill" then
            v85 = u7
        else
            v85 = Color3.fromRGB(60, 6, 6)
        end
        v84.Color = v85
        if a1.tag then
            a1.tag.TextColor3 = a1.label.TextColor3
        end
    end
end
local function display(a1)
    --[[
      name: display
      line: 430
    ]]
    if a1.confN < a1.predN then
        return (math.max(a1.confAmount, a1.predAmount))
    end
    return a1.confAmount
end
local function refresh(a1, a2)
    --[[
      name: refresh
      line: 437
      upvalues:
        popNumber (copy, index: 1)
    ]]
    local v86
    if a1.confN < a1.predN then
        v86 = math.max(a1.confAmount, a1.predAmount)
    else
        v86 = a1.confAmount
    end
    local v87
    if math.floor(v86 + 0.5) ~= math.floor(a1.amount + 0.5) then
        v87 = true
    else
        v87 = false
    end
    a1.amount = v86
    a1.label.Text = tostring(math.floor(v86 + 0.5))
    if not a2 and not v87 then
        return
    end
    popNumber(a1)
end
local function newNumber(a1, a2, a3, a4)
    --[[
      name: newNumber
      line: 447
      upvalues:
        tbl_upv_12 (copy, index: 1)
        u2 (copy, index: 2)
        tbl_upv_14 (copy, index: 3)
        tbl_upv_13 (copy, index: 4)
        u3 (copy, index: 5)
        u25 (ref,  index: 6)
        u7 (copy, index: 7)
        tbl_upv_11 (copy, index: 8)
    ]]
    local v88 = os.clock()
    local v89 = table.remove(tbl_upv_12)
    if not (v89) then
        local v90 = Instance.new("TextLabel")
        v90.Name = "DamageNumber"
        v90.BackgroundTransparency = 1
        v90.AnchorPoint = Vector2.new(0.5, 0.5)
        v90.Size = UDim2.fromOffset(200, 64)
        v90.FontFace = u2
        v90.ZIndex = 3
        local v91 = Instance.new("UIStroke")
        v91.Thickness = 3.5
        v91.Parent = v90
        Instance.new("UIScale").Parent = v90
        v89 = v90
    end
    local v92 = v89
    v92.TextSize = tbl_upv_14[a2] or 42
    v92.TextColor3 = tbl_upv_13[a2] or u3
    v92.TextTransparency = 0
    v92.Visible = false
    v92.Parent = u25
    v89 = v92:FindFirstChildOfClass("UIStroke")
    local v94
    if a2 ~= "kill" then
        v94 = u7
    else
        v94 = Color3.fromRGB(60, 6, 6)
    end
    v89.Color = v94
    v89.Transparency = 0
    local tbl_17 = {big = 0, predUntil = 0, amount = 0, confAmount = 0, predN = 0, confN = 0, predAmount = 0}
    tbl_17.label = v92
    tbl_17.stroke = v89
    tbl_17.world = a1
    tbl_17.t0 = v88
    tbl_17.lastHit = v88
    tbl_17.offset = Vector2.new((math.random() - 0.5) * 18, a4 * -32)
    tbl_17.key = a3
    tbl_17.kind = a2
    tbl_17.scale = v92:FindFirstChildOfClass("UIScale")
    local v95 = true
    if a2 ~= "crit" then
        v95 = a2 == "kill"
    end
    tbl_17.big = v95
    table.insert(tbl_upv_11, tbl_17)
    return tbl_17
end
function tbl_upv_1.PredictNumber(a1, a2, a3, a4)
    --[[
      name: PredictNumber
      line: 513
      upvalues:
        u25 (ref,  index: 1)
        tbl_upv_11 (copy, index: 2)
        setKind (copy, index: 3)
        popNumber (copy, index: 4)
    ]]
    if a2 < 0.5 or not u25 or a4 == nil then
        return
    end
    local v96 = os.clock()
    for _, value_7 in tbl_upv_11 do
        if value_7.key == a4 and v96 - value_7.lastHit < 0.45 and value_7.kind ~= "dot" then
            value_7.predAmount = value_7.predAmount + a2
            value_7.predN = value_7.predN + 1
            value_7.lastHit = v96
            value_7.predUntil = v96 + 0.7
            value_7.t0 = math.max(value_7.t0, v96 - 0.25)
            if a3 then
                setKind(value_7, "crit")
            end
            local v97
            if value_7.confN < value_7.predN then
                v97 = math.max(value_7.confAmount, value_7.predAmount)
            else
                v97 = value_7.confAmount
            end
            value_7.amount = v97
            value_7.label.Text = tostring(math.floor(v97 + 0.5))
            popNumber(value_7)
            return
        end
    end
end
local function stacked(a1, a2)
    --[[
      name: stacked
      line: 498
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    local v98 = 0
    if a1 ~= nil then
        for _, value_8 in tbl_upv_11 do
            if value_8.key == a1 then
                v98 = ((a2 - value_8.t0 < 0.5) and (v98 + 1)) or v98
            end
        end
    end
    return v98
end
local function tagLabel(a1, a2, a3)
    --[[
      name: tagLabel
      line: 394
      upvalues:
        u1 (copy, index: 1)
        u7 (copy, index: 2)
    ]]
    local v99 = Instance.new("TextLabel")
    v99.Name = "Tag"
    v99.BackgroundTransparency = 1
    v99.AnchorPoint = Vector2.new(0.5, 0)
    v99.Position = UDim2.new(0.5, 0, 1, -10)
    v99.Size = UDim2.fromOffset(160, 18)
    v99.FontFace = u1
    v99.TextSize = 16
    v99.TextColor3 = a3
    v99.Text = a2
    v99.ZIndex = 3
    v99.Parent = a1
    local v100 = Instance.new("UIStroke")
    v100.Thickness = 2
    v100.Color = u7
    v100.Parent = v99
    return v99
end
function tbl_upv_1.DamageNumber(a1, a2, a3, a4, a5)
    --[[
      name: DamageNumber
      line: 540
      upvalues:
        u25 (ref,  index: 1)
        tbl_upv_11 (copy, index: 2)
        setKind (copy, index: 3)
        tagLabel (copy, index: 4)
        popNumber (copy, index: 5)
        newNumber (copy, index: 6)
        stacked (copy, index: 7)
    ]]
    if a2 < 0.5 or not u25 then
        return
    end
    local v101 = os.clock()
    if a4 == nil then
        local v102 = newNumber(a1, a3, a4, stacked(a4, v101))
        v102.confAmount = a2
        v102.confN = 1
        if a5 then
            v102.tag = tagLabel(v102.label, a5, v102.label.TextColor3)
        end
        if v102.confN < v102.predN then
            v101 = math.max(v102.confAmount, v102.predAmount)
        else
            v101 = v102.confAmount
        end
        v102.amount = v101
        v102.label.Text = tostring(math.floor(v101 + 0.5))
        popNumber(v102)
    else
        for _, value_9 in tbl_upv_11 do
            if value_9.key == a4 and value_9.confN < value_9.predN and v101 < value_9.predUntil + 0.2 and a3 ~= "dot" then
                value_9.confN = value_9.confN + 1
                value_9.confAmount = value_9.confAmount + a2
                value_9.lastHit = v101
                value_9.predUntil = math.max(value_9.predUntil, v101 + 0.15)
                local kind_1 = value_9.kind
                if a3 ~= "health" then
                    setKind(value_9, a3)
                end
                if a5 and not (value_9.tag) then
                    value_9.tag = tagLabel(value_9.label, a5, value_9.label.TextColor3)
                end
                local v103 = value_9.kind ~= kind_1
                local v104
                if value_9.confN < value_9.predN then
                    v104 = math.max(value_9.confAmount, value_9.predAmount)
                else
                    v104 = value_9.confAmount
                end
                local v105
                if math.floor(v104 + 0.5) ~= math.floor(value_9.amount + 0.5) then
                    v105 = true
                else
                    v105 = false
                end
                value_9.amount = v104
                value_9.label.Text = tostring(math.floor(v104 + 0.5))
                if v103 or v105 then
                    popNumber(value_9)
                end
                return
            end
        end
    end
end
local function updateNumbers()
    --[[
      name: updateNumbers
      line: 594
      upvalues:
        tbl_upv_11 (copy, index: 1)
        popNumber (copy, index: 2)
        tbl_upv_12 (copy, index: 3)
        u12 (ref,  index: 4)
    ]]
    if #tbl_upv_11 == 0 then
        return
    end
    local v106 = os.clock()
    local v107 = 1
    while v107 <= #tbl_upv_11 do
        local v108 = tbl_upv_11[v107]
        if v108.confN < v108.predN and v108.predUntil < v106 then
            v108.predN = v108.confN
            v108.predAmount = v108.confAmount
            if v108.confN ~= 0 then
                local v109
                if v108.confN < v108.predN then
                    v109 = math.max(v108.confAmount, v108.predAmount)
                else
                    v109 = v108.confAmount
                end
                local v110
                if math.floor(v109 + 0.5) ~= math.floor(v108.amount + 0.5) then
                    v110 = true
                else
                    v110 = false
                end
                v108.amount = v109
                v108.label.Text = tostring(math.floor(v109 + 0.5))
                if v110 then
                    popNumber(v108)
                end
            else
                v108.t0 = math.min(v108.t0, v106 - 0.9999999999999999)
            end
        end
        local v111 = v106 - v108.t0
        if v111 >= 1.15 then
            if v108.tag then
                v108.tag:Destroy()
            end
            if #tbl_upv_12 < 24 then
                v108.label.Visible = false
                v108.label.Parent = nil
                table.insert(tbl_upv_12, v108.label)
            else
                v108.label:Destroy()
            end
            table.remove(tbl_upv_11, v107)
        else
            local v112 = v111 / 1.15
            local v113, v114 = workspace.CurrentCamera:WorldToViewportPoint(v108.world + Vector3.new(0, 3.5 * (1 - ((1 - v112) * (1 - v112))), 0))
            v108.label.Visible = v114 and (v113.Z > 0)
            v108.label.Position = UDim2.fromOffset(v113.X + (v108.offset.X * u12), v113.Y + (v108.offset.Y * u12))
            local v115 = math.clamp((v111 - 0.7499999999999999) / 0.4, 0, 1)
            v108.label.TextTransparency = v115
            v108.stroke.Transparency = v115
            if v108.tag then
                v108.tag.TextTransparency = v115
            end
            v107 = v107 + 1
        end
    end
end
local tbl_upv_18 = {}
local u26 = nil
local tbl_upv_19 = {}
local function buildVignette()
    --[[
      name: buildVignette
      line: 650
      upvalues:
        u5 (copy, index: 1)
        u9 (ref,  index: 2)
        tbl_upv_19 (copy, index: 3)
    ]]
    local tbl_20 = {"Top", UDim2.new(1, 0, 0.24, 0), UDim2.fromScale(0.5, 0), Vector2.new(0.5, 0), 90}
    local tbl_21 = {"Bottom", UDim2.new(1, 0, 0.24, 0), UDim2.fromScale(0.5, 1), Vector2.new(0.5, 1), -90}
    local tbl_22 = {"Left", UDim2.new(0.2, 0, 1, 0), UDim2.fromScale(0, 0.5), Vector2.new(0, 0.5), 0}
    for _, value_10 in {tbl_20, tbl_21, tbl_22, {"Right", UDim2.new(0.2, 0, 1, 0), UDim2.fromScale(1, 0.5), Vector2.new(1, 0.5), 180}} do
        local v116 = Instance.new("Frame")
        v116.Name = "Vignette" .. value_10[1]
        v116.Size = value_10[2]
        v116.Position = value_10[3]
        v116.AnchorPoint = value_10[4]
        v116.BorderSizePixel = 0
        v116.BackgroundColor3 = u5
        v116.BackgroundTransparency = 1
        v116.Parent = u9
        local v117 = Instance.new("UIGradient")
        v117.Rotation = value_10[5]
        v117.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        v117.Parent = v116
        table.insert(tbl_upv_19, v116)
    end
end
function tbl_upv_1.Hurt(a1, a2)
    --[[
      name: Hurt
      line: 678
      upvalues:
        tbl_upv_19 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    local v118 = math.clamp(a1, 0.15, 1)
    for _, value_11 in tbl_upv_19 do
        value_11.BackgroundColor3 = a2 or Color3.fromRGB(200, 20, 20)
        value_11.BackgroundTransparency = 1 - (v118 * 0.6)
        local tbl_23 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(value_11, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_23):Play()
    end
end
function tbl_upv_1.Flash(a1, a2, a3)
    --[[
      name: Flash
      line: 688
      upvalues:
        tbl_upv_19 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    for _, value_12 in tbl_upv_19 do
        value_12.BackgroundColor3 = a1
        value_12.BackgroundTransparency = 1 - (math.clamp(a2, 0, 1) * 0.6)
        local tbl_24 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(value_12, TweenInfo.new(a3 or 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_24):Play()
    end
end
function tbl_upv_1.DamageFrom(a1, a2, a3, a4)
    --[[
      name: DamageFrom
      line: 700
      upvalues:
        frame (copy, index: 1)
        u10 (ref,  index: 2)
        u5 (copy, index: 3)
        u7 (copy, index: 4)
        tbl_upv_18 (copy, index: 5)
    ]]
    local v120 = frame(u10, "DamageDir", UDim2.fromOffset(0, 0))
    v120.BackgroundTransparency = 1
    local tbl_25 = {}
    local v121 = (a2 and 22) or 18
    local v122 = (a2 and 7) or 5
    for n_4 = -1, 1 do
        local v124 = UDim2.fromOffset(v121, v122)
        local v123 = a3 or u5
        local v125 = frame(v120, "S" .. n_4, v124, nil, v123)
        local v126 = Instance.new("UICorner")
        v126.CornerRadius = UDim.new(1, 0)
        v126.Parent = v125
        local v127
        if a3 then
            v127 = Color3.fromRGB(60, 40, 10)
        else
            v127 = Color3.fromRGB(80, 0, 8)
        end
        local v128 = Instance.new("UIStroke")
        v128.Name = "Stroke"
        v128.Thickness = 1.2
        if not (v127) then
            v124 = u7
        end
        v128.Color = v127
        v128.Transparency = 0.35
        v128.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        v128.Parent = v125
        v125:SetAttribute("Offset", n_4)
        table.insert(tbl_25, v125)
    end
    table.insert(tbl_upv_18, {frame = v120, source = a1, t0 = os.clock(), life = a4})
    if not (#tbl_upv_18 > 6) then
        return
    end
    table.remove(tbl_upv_18, 1).frame:Destroy()
end
local u27 = nil
local u28 = nil
local u29 = nil
local u30 = 0
local u31 = 0
local u32 = nil
local u33 = nil
local u34 = nil
local u35 = nil
local function label(a1, a2, a3, a4, a5, a6)
    --[[
      name: label
      line: 108
      upvalues:
        u1 (copy, index: 1)
        u3 (copy, index: 2)
        u7 (copy, index: 3)
    ]]
    local v129 = Instance.new("TextLabel")
    v129.Name = a2
    v129.BackgroundTransparency = 1
    v129.AnchorPoint = Vector2.new(0.5, 0.5)
    v129.Position = a5
    v129.Size = UDim2.fromOffset(460, a4 + 8)
    v129.FontFace = u1
    v129.TextSize = a4
    v129.TextColor3 = a6 or u3
    v129.Text = a3
    v129.Parent = a1
    local v131 = Instance.new("UIStroke")
    v131.Thickness = 2
    v131.Color = u7
    v131.Transparency = 0.2
    v131.Parent = v129
    return v129
end
local function buildBars()
    --[[
      name: buildBars
      line: 773
      upvalues:
        u27 (ref,  index: 1)
        frame (copy, index: 2)
        u10 (ref,  index: 3)
        u7 (copy, index: 4)
        u28 (ref,  index: 5)
        u29 (ref,  index: 6)
        label (copy, index: 7)
        u32 (ref,  index: 8)
        u4 (copy, index: 9)
        u33 (ref,  index: 10)
        u34 (ref,  index: 11)
        u5 (copy, index: 12)
        u2 (copy, index: 13)
        u35 (ref,  index: 14)
    ]]
    u27 = frame(u10, "Channel", UDim2.fromOffset(170, 10), UDim2.new(0.5, 0, 0.5, 76), u7)
    u27.BackgroundTransparency = 0.25
    local v132 = u27
    local v133 = Instance.new("UICorner")
    v133.CornerRadius = UDim.new(0.5, 0)
    v133.Parent = v132
    local v134 = u27
    local v135 = Instance.new("UIStroke")
    v135.Name = "Stroke"
    v135.Thickness = 2
    v135.Color = u7
    v135.Transparency = 0.2
    v135.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v135.Parent = v134
    u28 = frame(u27, "Fill", UDim2.fromScale(0, 1), UDim2.fromScale(0, 0.5), Color3.fromRGB(120, 220, 110))
    u28.AnchorPoint = Vector2.new(0, 0.5)
    local v136 = u28
    local v137 = Instance.new("UICorner")
    v137.CornerRadius = UDim.new(0.5, 0)
    v137.Parent = v136
    u29 = label(u27, "Text", "", 18, UDim2.new(0.5, 0, 0, -16))
    u27.Visible = false
    u32 = label(u10, "Toast", "", 22, UDim2.new(0.5, 0, 0.5, -124), u4)
    u33 = label(u10, "Ammo", "", 18, UDim2.new(0.5, 0, 0.5, 60))
    u33.Visible = false
    u32.TextTransparency = 1
    local v138 = u32:FindFirstChildOfClass("UIStroke")
    if v138 then
        v138.Transparency = 1
    end
    u34 = label(u10, "Kill", "", 28, UDim2.new(0.5, 0, 0.5, 100), u5)
    u34.FontFace = u2
    u34.TextTransparency = 1
    u35 = label(u10, "KillSub", "", 17, UDim2.new(0.5, 0, 0.5, 122), u4)
    u35.AutoLocalize = false
    u35.TextTransparency = 1
    for _, value_13 in {u34, u35} do
        local v139 = value_13:FindFirstChildOfClass("UIStroke")
        if v139 then
            v139.Transparency = 1
        end
    end
end
function tbl_upv_1.StartChannel(a1, a2, a3)
    --[[
      name: StartChannel
      line: 808
      upvalues:
        u30 (ref, index: 1)
        u31 (ref, index: 2)
        u29 (ref, index: 3)
        u28 (ref, index: 4)
        u27 (ref, index: 5)
    ]]
    u30 = os.clock()
    u31 = u30 + a2
    u29.Text = a1
    u28.BackgroundColor3 = a3 or Color3.fromRGB(120, 220, 110)
    u28.Size = UDim2.fromScale(0, 1)
    u27.Visible = true
end
function tbl_upv_1.StopChannel()
    --[[
      name: StopChannel
      line: 817
      upvalues:
        u27 (ref, index: 1)
        u31 (ref, index: 2)
    ]]
    u27.Visible = false
    u31 = 0
end
function tbl_upv_1.Toast(a1, a2, a3)
    --[[
      name: Toast
      line: 822
      upvalues:
        u32 (ref,  index: 1)
        u4 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    u32.Text = a1
    local v141 = u32
    v141.TextColor3 = a2 or u4
    u32.TextTransparency = 0
    local u36 = u32:FindFirstChildOfClass("UIStroke")
    if u36 then
        u36.Transparency = 0.2
    end
    local v143 = u32:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
    v143.Parent = u32
    v143.Scale = 1.25
    local tbl_26 = {Scale = 1}
    TweenService_upv_1:Create(v143, TweenInfo.new(0.15, Enum.EasingStyle.Back), tbl_26):Play()
    local u37 = os.clock()
    u32:SetAttribute("T", u37)
    task.delay(
        a3 or 1.1,
        function()
            --[[
              line: 836
              upvalues:
                u32 (ref,  index: 1)
                u37 (copy, index: 2)
                TweenService_upv_1 (copy, index: 3)
                u36 (copy, index: 4)
            ]]
            if u32:GetAttribute("T") ~= u37 then
                return
            end
            local tbl_27 = {TextTransparency = 1}
            TweenService_upv_1:Create(u32, TweenInfo.new(0.3), tbl_27):Play()
            if u36 then
                local tbl_28 = {Transparency = 1}
                TweenService_upv_1:Create(u36, TweenInfo.new(0.3), tbl_28):Play()
            end
        end
    )
end
function tbl_upv_1.KillBanner(a1, a2)
    --[[
      name: KillBanner
      line: 849
      upvalues:
        u34 (ref,  index: 1)
        u35 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    u34.Text = a1
    u35.Text = a2 or ""
    local u38 = os.clock()
    local v144 = nil
    local v145 = nil
    for _, value_14 in {u34, u35} do
        if value_14 ~= u35 or a2 then
            value_14.TextTransparency = 0
            local v144 = value_14:FindFirstChildOfClass("UIStroke")
            if not (v144) then
                v144 = value_14:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
                v144.Parent = value_14
                v144.Scale = 1.7
                local tbl_29 = {Scale = 1}
                TweenService_upv_1:Create(v144, TweenInfo.new(0.26, Enum.EasingStyle.Back), tbl_29):Play()
                value_14:SetAttribute("T", u38)
                continue
            end
            if value_14 ~= u35 then
                v145 = 0.1
                v144.Transparency = v145
                v144 = value_14:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
                v144.Parent = value_14
                v144.Scale = 1.7
                local tbl_29 = {Scale = 1}
                TweenService_upv_1:Create(v144, TweenInfo.new(0.26, Enum.EasingStyle.Back), tbl_29):Play()
                value_14:SetAttribute("T", u38)
                continue
            end
            if a2 then
                v145 = 0.1
            else
                v145 = 1
            end
            v144.Transparency = v145
            v144 = value_14:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
            v144.Parent = value_14
            v144.Scale = 1.7
            local tbl_29 = {Scale = 1}
            TweenService_upv_1:Create(v144, TweenInfo.new(0.26, Enum.EasingStyle.Back), tbl_29):Play()
            value_14:SetAttribute("T", u38)
        end
        v144 = 1
        value_14.TextTransparency = 0
        local v144 = value_14:FindFirstChildOfClass("UIStroke")
        if not (v144) then
            v144 = value_14:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
            v144.Parent = value_14
            v144.Scale = 1.7
            local tbl_29 = {Scale = 1}
            TweenService_upv_1:Create(v144, TweenInfo.new(0.26, Enum.EasingStyle.Back), tbl_29):Play()
            value_14:SetAttribute("T", u38)
            continue
        end
        if value_14 ~= u35 or a2 then
            v145 = 0.1
        else
            v145 = 1
        end
        v144.Transparency = v145
        v144 = value_14:FindFirstChildOfClass("UIScale") or (Instance.new("UIScale"))
        v144.Parent = value_14
        v144.Scale = 1.7
        local tbl_29 = {Scale = 1}
        TweenService_upv_1:Create(v144, TweenInfo.new(0.26, Enum.EasingStyle.Back), tbl_29):Play()
        value_14:SetAttribute("T", u38)
    end
    task.delay(
        1.7,
        function()
            --[[
              line: 865
              upvalues:
                u34 (ref,  index: 1)
                u35 (ref,  index: 2)
                u38 (copy, index: 3)
                TweenService_upv_1 (copy, index: 4)
            ]]
            for _, value_15 in {u34, u35} do
                if value_15:GetAttribute("T") ~= u38 then
                    continue
                end
                local tbl_30 = {TextTransparency = 1}
                TweenService_upv_1:Create(value_15, TweenInfo.new(0.4), tbl_30):Play()
                local v146 = value_15:FindFirstChildOfClass("UIStroke")
                if v146 then
                    local tbl_31 = {Transparency = 1}
                    TweenService_upv_1:Create(v146, TweenInfo.new(0.4), tbl_31):Play()
                end
            end
        end
    )
end
function tbl_upv_1.SetStyle(a1)
    --[[
      name: SetStyle
      line: 880
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u11 (ref,  index: 2)
        u13 (ref,  index: 3)
        u14 (ref,  index: 4)
        u16 (ref,  index: 5)
        u15 (ref,  index: 6)
    ]]
    if not (tbl_upv_2[a1]) then
        a1 = "Dot"
    end
    u11 = a1
    for key_3, value_16 in tbl_upv_2 do
        value_16.Visible = key_3 == a1
    end
    u13 = 0
    u14 = 0
    u16 = false
    u15 = 0
end
function tbl_upv_1.GetStyle()
    --[[
      name: GetStyle
      line: 894
      upvalues:
        u11 (ref, index: 1)
    ]]
    return u11
end
function tbl_upv_1.SetCharge(a1)
    --[[
      name: SetCharge
      line: 898
      upvalues:
        u13 (ref, index: 1)
    ]]
    u13 = math.clamp(a1, 0, 1)
end
function tbl_upv_1.Kick(a1)
    --[[
      name: Kick
      line: 902
      upvalues:
        u14 (ref, index: 1)
    ]]
    u14 = math.min(u14 + a1, 30)
end
function tbl_upv_1.SetSpread(a1)
    --[[
      name: SetSpread
      line: 907
      upvalues:
        u15 (ref, index: 1)
    ]]
    u15 = math.max(0, a1)
end
function tbl_upv_1.SetPips(a1, a2, a3)
    --[[
      name: SetPips
      line: 912
      upvalues:
        u21 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        u7 (copy, index: 3)
        u3 (copy, index: 4)
    ]]
    local v147 = a2 or 0
    u21.Visible = v147 > 0
    for n_5 = #tbl_upv_4 + 1, v147 do
        local v148 = Instance.new("Frame")
        v148.Name = "P" .. n_5
        v148.LayoutOrder = n_5
        v148.Size = UDim2.fromOffset(8, 8)
        v148.BorderSizePixel = 0
        v148.Rotation = 45
        v148.Parent = u21
        local v149 = Instance.new("UIStroke")
        v149.Name = "Stroke"
        v149.Thickness = 1.2
        if u7 or not u7 then
            v149.Color = u7
            v149.Transparency = 0.2
            v149.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v149.Parent = v148
            tbl_upv_4[n_5] = v148
        end
    end
    local v150 = nil
    for key_4, value_17 in tbl_upv_4 do
        value_17.Visible = key_4 <= v147
        local v151 = key_4 <= a1
        if not (v151) then
            v150 = u7
            value_17.BackgroundColor3 = v150
            value_17.BackgroundTransparency = (v151 and 0) or 0.55
            continue
        end
        v150 = a3 or u3
        value_17.BackgroundColor3 = v150
        value_17.BackgroundTransparency = (v151 and 0) or 0.55
    end
end
local tbl_upv_32 = {ARROWS = "ARROW", BULLETS = "BULLET"}
function tbl_upv_1.SetAmmoCount(a1, a2)
    --[[
      name: SetAmmoCount
      line: 937
      upvalues:
        u33 (ref,  index: 1)
        tbl_upv_32 (copy, index: 2)
        u5 (copy, index: 3)
        u4 (copy, index: 4)
        u3 (copy, index: 5)
    ]]
    if not u33 then
        return
    end
    if a1 ~= nil then
        u33.Visible = true
        local v152 = math.max(0, math.floor(a1))
        local v153 = a2 or ""
        if v152 == 1 then
            v153 = tbl_upv_32[v153] or v153
        end
        u33.Text = ("%* %*"):format(v152, v153)
        local v154 = u33
        local v155
        if a1 <= 0 then
            v155 = u5
        elseif a1 <= 3 then
            v155 = u4
        else
            v155 = u3
        end
        v154.TextColor3 = v155
    else
        u33.Visible = false
    end
end
function tbl_upv_1.SetArc(a1, a2, a3)
    --[[
      name: SetArc
      line: 956
      upvalues:
        u18 (ref,  index: 1)
        u19 (ref,  index: 2)
        u20 (ref,  index: 3)
        u3 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
    ]]
    if a1 and a1 > 0 then
        local v156 = os.clock() - (a3 or 0)
        u18 = v156
        u19 = u18 + a1
        v156 = a2 or u3
        u20 = v156
        return
    end
    u19 = 0
    for _, value_18 in tbl_upv_3 do
        value_18.Visible = false
    end
end
function tbl_upv_1.SetBlocking(a1)
    --[[
      name: SetBlocking
      line: 969
      upvalues:
        u16 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    u16 = a1
    local v157 = tbl_upv_2.Melee and (tbl_upv_2.Melee:FindFirstChild("Shield"))
    local v158 = v157 and (v157:FindFirstChild("Pulse"))
    if not v158 then
        return
    end
    if a1 then
        v158.Scale = 0.6
        local tbl_33 = {Scale = 1}
        TweenService_upv_1:Create(v158, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_33):Play()
    end
end
function tbl_upv_1.SetGuard(a1, a2)
    --[[
      name: SetGuard
      line: 980
      upvalues:
        u22 (ref,  index: 1)
        u23 (ref,  index: 2)
        u5 (copy, index: 3)
        u4 (copy, index: 4)
        u6 (copy, index: 5)
    ]]
    if not u22 then
        return
    end
    u22.Visible = a1 ~= nil
    if a1 == nil then
        return
    end
    u23.Size = UDim2.fromScale(math.clamp(a1, 0, 1), 1)
    local v159 = u23
    local v160
    if a2 then
        v160 = u5
    elseif a1 <= 0.3 then
        v160 = u4
    else
        v160 = u6
    end
    v159.BackgroundColor3 = v160
    u23.BackgroundTransparency = (a2 and 0.35) or 0
end
function tbl_upv_1.BlockPulse()
    --[[
      name: BlockPulse
      line: 994
      upvalues:
        tbl_upv_2 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        u3 (copy, index: 3)
        u6 (copy, index: 4)
    ]]
    local Melee_1 = tbl_upv_2.Melee and (tbl_upv_2.Melee:FindFirstChild("Shield"))
    if not Melee_1 then
        return
    end
    local Pulse_1 = Melee_1:FindFirstChild("Pulse")
    if Pulse_1 then
        Pulse_1.Scale = 1.45
        local tbl_34 = {Scale = 1}
        TweenService_upv_1:Create(Pulse_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_34):Play()
    end
    for _, value_19 in Melee_1:GetChildren() do
        if value_19:IsA("Frame") then
            value_19.BackgroundColor3 = u3
            value_19.BackgroundTransparency = 0
            local tbl_35 = {BackgroundTransparency = 0.3}
            tbl_35.BackgroundColor3 = u6
            TweenService_upv_1:Create(value_19, TweenInfo.new(0.25), tbl_35):Play()
        end
    end
end
function tbl_upv_1.SetFrozen(a1)
    --[[
      name: SetFrozen
      line: 1014
      upvalues:
        u17 (ref,  index: 1)
        u10 (ref,  index: 2)
        u8 (copy, index: 3)
        u3 (copy, index: 4)
    ]]
    if u17 ~= a1 then
        u17 = a1
        local v161 = nil
        for _, value_20 in u10:GetDescendants() do
            if not (value_20:IsA("Frame")) or value_20.Name ~= "Dot" then
                continue
            end
            if u17 then
                v161 = u8
            else
                v161 = u3
            end
            value_20.BackgroundColor3 = v161
        end
    end
end
local function spreadPx(a1)
    --[[
      name: spreadPx
      line: 1026
      upvalues:
        u12 (ref, index: 1)
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    return (math.tan(math.rad(a1)) / math.tan(math.rad(CurrentCamera_1.FieldOfView / 2))) * (CurrentCamera_1.ViewportSize.Y / 2) / u12
end
local function strokeOf(a1)
    --[[
      name: strokeOf
      line: 1033
    ]]
    return (a1:FindFirstChild("Stroke"))
end
local function updateIndicators()
    --[[
      name: updateIndicators
      line: 720
      upvalues:
        tbl_upv_18 (copy, index: 1)
    ]]
    if #tbl_upv_18 == 0 then
        return
    end
    local v162 = os.clock()
    local CFrame_1 = workspace.CurrentCamera.CFrame
    local v163 = Vector3.new(CFrame_1.LookVector.X, 0, CFrame_1.LookVector.Z)
    local v164 = Vector3.new(CFrame_1.RightVector.X, 0, CFrame_1.RightVector.Z)
    local v165 = 1
    local v166 = nil
    while v165 <= #tbl_upv_18 do
        local v167 = tbl_upv_18[v165]
        local v168 = v162 - v167.t0
        local v169 = v167.life or 0.6
        if v169 < v168 then
            v167.frame:Destroy()
            table.remove(tbl_upv_18, v165)
            continue
        end
        local v170 = v167.source - CFrame_1.Position
        local v171 = Vector3.new(v170.X, 0, v170.Z)
        v166 = 0
        if v171.Magnitude > 0.1 and v163.Magnitude > 0.01 then
            v166 = math.atan2(v171.Unit:Dot(v164.Unit), v171.Unit:Dot(v163.Unit))
        end
        local v172 = math.clamp((v168 - (v169 - 0.45)) / 0.45, 0, 1)
        for _, value_21 in v167.frame:GetChildren() do
            if not (value_21:IsA("Frame")) then
                continue
            end
            local Stroke_3 = v166 + 0.1308996938995747 * (value_21:GetAttribute("Offset") or 0)
            value_21.Position = UDim2.new(0.5, math.sin(Stroke_3) * 140, 0.5, -math.cos(Stroke_3) * 140)
            value_21.Rotation = math.deg(Stroke_3)
            value_21.BackgroundTransparency = v172
            Stroke_3 = value_21:FindFirstChild("Stroke")
            if Stroke_3 then
                Stroke_3.Transparency = (v172 * 0.65) + 0.35
            end
        end
        v165 = v165 + 1
    end
end
local function update(a1)
    --[[
      name: update
      line: 1037
      upvalues:
        u14 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        u11 (ref,  index: 3)
        u13 (ref,  index: 4)
        u4 (copy, index: 5)
        u3 (copy, index: 6)
        u15 (ref,  index: 7)
        u12 (ref,  index: 8)
        u16 (ref,  index: 9)
        u19 (ref,  index: 10)
        u18 (ref,  index: 11)
        tbl_upv_3 (copy, index: 12)
        u20 (ref,  index: 13)
        u7 (copy, index: 14)
        tbl_upv_1 (copy, index: 15)
        u31 (ref,  index: 16)
        u30 (ref,  index: 17)
        u28 (ref,  index: 18)
        updateIndicators (copy, index: 19)
        updateNumbers (copy, index: 20)
    ]]
    local v173 = os.clock()
    u14 = math.max(0, u14 - (a1 * 80))
    local v174 = tbl_upv_2[u11]
    if u11 == "Bow" or u11 == "Throw" then
        local Ring_1 = v174:FindFirstChild("Ring")
        local v175 = ((u11 ~= "Bow") and 44) or 66
        local v176 = v175 - (v175 - 12) * (u13 ^ 0.8)
        Ring_1.Size = UDim2.fromOffset(v176, v176)
        local Stroke_4 = Ring_1:FindFirstChild("Stroke")
        local v177
        if u13 >= 0.999 then
            v177 = u4
        else
            v177 = u3
        end
        Stroke_4.Color = v177
        Stroke_4.Thickness = u13 >= 0.999 and math.sin(v173 * 20) * 0.6 + 2.8 or 2.2
        Stroke_4.Transparency = u13 > 0 and 0 or 0.35
        if u11 == "Bow" then
            for key_5, value_22 in {-1, 1} do
                local v180 = v174:FindFirstChild("Side" .. key_5)
                v180.Position = UDim2.new(0.5, value_22 * ((v176 / 2) + 8), 0.5, 0)
                v180.BackgroundColor3 = Stroke_4.Color
            end
        end
    elseif u11 == "Gun" then
        local v181 = u15
        local CurrentCamera_2 = workspace.CurrentCamera
        local v182 = ((math.tan(math.rad(v181)) / math.tan(math.rad(CurrentCamera_2.FieldOfView / 2))) * (CurrentCamera_2.ViewportSize.Y / 2) / u12) + 5 + u14
        local Up_1 = v174:FindFirstChild("Up")
        local Down_1 = v174:FindFirstChild("Down")
        local Left_1 = v174:FindFirstChild("Left")
        local Right_1 = v174:FindFirstChild("Right")
        Up_1.Position = UDim2.new(0.5, 0, 0.5, -v182 - 5)
        Down_1.Position = UDim2.new(0.5, 0, 0.5, v182 + 5)
        Left_1.Position = UDim2.new(0.5, -v182 - 5, 0.5, 0)
        Right_1.Position = UDim2.new(0.5, v182 + 5, 0.5, 0)
    elseif u11 == "Spread" then
        local Ring_2 = v174:FindFirstChild("Ring")
        local v183 = u15
        local CurrentCamera_3 = workspace.CurrentCamera
        local v184 = math.max(10, ((math.tan(math.rad(v183)) / math.tan(math.rad(CurrentCamera_3.FieldOfView / 2))) * (CurrentCamera_3.ViewportSize.Y / 2)) / u12) + u14 * 0.6
        Ring_2.Size = UDim2.fromOffset(v184 * 2, v184 * 2)
        for n_6 = 0, 3 do
            local v185 = math.rad(n_6 * 90)
            local v186 = v174:FindFirstChild("Notch" .. n_6)
            v186.Position = UDim2.new(0.5, math.sin(v185) * v184, 0.5, -math.cos(v185) * v184)
        end
    elseif u11 == "Melee" then
        local Ring_3 = v174:FindFirstChild("Ring")
        local Stroke_5 = Ring_3:FindFirstChild("Stroke")
        if u13 > 0 then
            local v187 = 46 - u13 * 26
            Ring_3.Size = UDim2.fromOffset(v187, v187)
            local v188
            if u13 >= 0.999 then
                v188 = u4
            else
                v188 = u3
            end
            Stroke_5.Color = v188
            Stroke_5.Transparency = 0
            Stroke_5.Thickness = u13 >= 0.999 and math.sin(v173 * 20) * 0.6 + 2.8 or 2.2
        else
            Stroke_5.Color = u3
            Stroke_5.Transparency = 0.45
            Stroke_5.Thickness = 1.6
            Ring_3.Size = UDim2.fromOffset(24, 24)
        end
        local Shield_1 = v174:FindFirstChild("Shield")
        Shield_1.Visible = u16 and (u13 <= 0)
        Ring_3.Visible = not Shield_1.Visible
    end
    if u19 > 0 then
        local v190 = math.clamp((v173 - u18) / math.max(0.01, u19 - u18), 0, 1)
        local v191 = math.floor((v190 * 24) + 0.5)
        local v192 = nil
        local _ = nil
        for key_6, value_23 in tbl_upv_3 do
            value_23.Visible = true
            if key_6 <= v191 then
                v192 = u20
            else
                v192 = u7
            end
            value_23.BackgroundColor3 = v192
            local v193 = nil
            if v193 <= v191 then
                v192 = 0.05
            else
                v192 = 0.6
            end
            value_23.BackgroundTransparency = v192
        end
        if v190 >= 1 then
            tbl_upv_1.SetArc(nil)
        end
    end
    if u31 > 0 then
        local v194 = math.clamp((v173 - u30) / math.max(0.01, u31 - u30), 0, 1)
        local v195 = u28
        v195.Size = UDim2.fromScale(v194, 1)
    end
    updateIndicators()
    updateNumbers()
end
function tbl_upv_1.Init()
    --[[
      name: Init
      line: 1115
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u9 (ref,  index: 2)
        u10 (ref,  index: 3)
        frame (copy, index: 4)
        u12 (ref,  index: 5)
        u26 (ref,  index: 6)
        u25 (ref,  index: 7)
        buildVignette (copy, index: 8)
        buildStyles (copy, index: 9)
        buildHitmarker (copy, index: 10)
        buildBars (copy, index: 11)
        RunService_upv_1 (copy, index: 12)
        update (copy, index: 13)
    ]]
    local PlayerGui_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    local CombatHUD_1 = PlayerGui_1:FindFirstChild("CombatHUD")
    if CombatHUD_1 then
        CombatHUD_1:Destroy()
    end
    u9 = Instance.new("ScreenGui")
    u9.Name = "CombatHUD"
    u9.IgnoreGuiInset = true
    u9.ScreenInsets = Enum.ScreenInsets.None
    u9.ResetOnSpawn = false
    u9.DisplayOrder = 4
    u9.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u9.Parent = PlayerGui_1
    u10 = frame(u9, "Center", UDim2.fromOffset(0, 0), UDim2.fromScale(0.5, 0.5))
    u10.BackgroundTransparency = 1
    local u39 = Instance.new("UIScale")
    u39.Name = "ScreenScale"
    u39.Parent = u10
    local function rescale()
        --[[
          name: rescale
          line: 1135
          upvalues:
            u12 (ref,  index: 1)
            u39 (copy, index: 2)
        ]]
        local ViewportSize_1 = workspace.CurrentCamera.ViewportSize
        u12 = math.clamp(math.min(ViewportSize_1.X / 1600, ViewportSize_1.Y / 900), 0.75, 1.6)
        u39.Scale = u12
    end
    local ViewportSize_2 = workspace.CurrentCamera.ViewportSize
    u12 = math.clamp(math.min(ViewportSize_2.X / 1600, ViewportSize_2.Y / 900), 0.75, 1.6)
    u39.Scale = u12
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale)
    u26 = frame(u9, "Directions", UDim2.fromScale(1, 1), UDim2.fromScale(0.5, 0.5))
    u26.BackgroundTransparency = 1
    u25 = frame(u9, "Numbers", UDim2.fromScale(1, 1), UDim2.fromScale(0.5, 0.5))
    u25.BackgroundTransparency = 1
    u25.ZIndex = 2
    buildVignette()
    buildStyles()
    buildHitmarker()
    buildBars()
    RunService_upv_1.RenderStepped:Connect(update)
end
function tbl_upv_1.ScreenScale()
    --[[
      name: ScreenScale
      line: 1157
      upvalues:
        u12 (ref, index: 1)
    ]]
    return u12
end
function tbl_upv_1.SetVisible(a1)
    --[[
      name: SetVisible
      line: 1161
      upvalues:
        u9 (ref, index: 1)
    ]]
    if not u9 then
        return
    end
    u9.Enabled = a1
end
return tbl_upv_1