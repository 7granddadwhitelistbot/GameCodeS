local Players_upv_1 = game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local TouchStart_upv_1 = require(v1:WaitForChild("Shared"):WaitForChild("TouchStart"))
local Loc_upv_1 = require(v1.Shared:WaitForChild("Loc"))
v1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = nil
local u2 = nil
local tbl_upv_1 = {}
local u3 = nil
local u4 = nil
local u5 = {}
local u6 = false
local u7 = false
local u8 = true
local u9 = nil
local u10 = false
local u11 = false
local u12 = Color3.fromRGB(40, 150, 255)
local u13 = Color3.fromRGB(18, 20, 26)
local u14 = Color3.fromRGB(36, 40, 50)
local u15 = Color3.fromRGB(255, 255, 255)
local u16 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local tbl_upv_2 = {Crossbow = "FIRE", Axe = "ATTACK", Shield = "BASH", Sword = "ATTACK", Spear = "ATTACK", Knives = "THROW", Club = "ATTACK", Gauntlets = "PUNCH", Dagger = "ATTACK", Horn = "BLOW", Bow = "DRAW", Musket = "FIRE", Fists = "PUNCH", Katana = "ATTACK", Scythe = "ATTACK", Trap = "SET", Herbs = "HEAL", Bomb = "THROW", Sling = "SLING", Javelin = "THROW", Blunderbuss = "FIRE", Pistol = "FIRE", Hatchets = "CHOP"}
local tbl_upv_3 = {Crossbow = true, Musket = true, Blunderbuss = true, Pistol = true}
local function makeButton(a1, a2, a3, a4, a5)
    --[[
      name: makeButton
      line: 112
      upvalues:
        u13 (copy, index: 1)
        u15 (copy, index: 2)
        u16 (copy, index: 3)
        Loc_upv_1 (copy, index: 4)
    ]]
    local v2 = Instance.new("TextButton")
    v2.Name = a2
    v2.AnchorPoint = Vector2.new(0.5, 0.5)
    v2.Size = UDim2.fromOffset(a3, a3)
    v2.BackgroundColor3 = u13
    v2.BackgroundTransparency = 0.3
    v2.AutoButtonColor = false
    v2.Text = a4
    v2.TextColor3 = u15
    v2.TextSize = a5
    v2.FontFace = u16
    v2.Active = true
    v2.Selectable = false
    local v3 = Instance.new("UICorner")
    v3.CornerRadius = UDim.new(1, 0)
    v3.Parent = v2
    local v4 = Instance.new("UIStroke")
    v4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v4.Thickness = 2
    v4.Color = u15
    v4.Transparency = 0.8
    v4.Parent = v2
    Instance.new("UIScale").Parent = v2
    Loc_upv_1.Fit(v2, 9, 0.06)
    v2.Parent = a1
    return v2
end
local function setPressedLook(a1, a2)
    --[[
      name: setPressedLook
      line: 143
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u10 (ref,  index: 2)
        u11 (ref,  index: 3)
        u14 (copy, index: 4)
        u13 (copy, index: 5)
        u12 (copy, index: 6)
    ]]
    local v5 = (a1 == tbl_upv_1.Secondary) and (u10 and (not a2))
    if a1 == tbl_upv_1.Secondary then
        u11 = a2
    end
    local v6
    if a2 then
        v6 = u14
    else
        v6 = u13
    end
    a1.BackgroundColor3 = v6
    a1.BackgroundTransparency = (a2 and 0.12) or ((v5 and 0.6) or 0.3)
    a1.TextTransparency = (v5 and 0.55) or 0
    local v7 = a1:FindFirstChildOfClass("UIStroke")
    if v7 then
        v7.Color = u12
        v7.Thickness = (a2 and 3) or 2
        v7.Transparency = (a2 and 0) or ((v5 and 0.92) or 0.8)
    end
    local v8 = a1:FindFirstChildOfClass("UIScale")
    if not v8 then
        return
    end
    v8.Scale = (a2 and 0.92) or 1
end
local u17 = nil
local u18 = nil
local function setNudge(a1)
    --[[
      name: setNudge
      line: 168
      upvalues:
        u17 (ref,  index: 1)
        u18 (ref,  index: 2)
        u12 (copy, index: 3)
        TweenService_upv_1 (copy, index: 4)
    ]]
    if a1 == u17 then
        return
    end
    u17 = a1
    if u18 then
        u18:Destroy()
        u18 = nil
    end
    if not a1 then
        return
    end
    local u19 = Instance.new("Frame")
    u19.Name = "Nudge"
    u19.AnchorPoint = Vector2.new(0.5, 0.5)
    u19.Position = UDim2.fromScale(0.5, 0.5)
    u19.Size = UDim2.fromScale(1, 1)
    u19.BackgroundTransparency = 1
    u19.ZIndex = 0
    local v9 = Instance.new("UICorner")
    v9.CornerRadius = UDim.new(1, 0)
    v9.Parent = u19
    local u20 = Instance.new("UIStroke")
    u20.Thickness = 3
    u20.Color = u12
    u20.Transparency = 1
    u20.Parent = u19
    u19.Parent = a1
    u18 = u19
    task.spawn(
        function()
            --[[
              line: 197
              upvalues:
                u18 (ref,  index: 1)
                u19 (copy, index: 2)
                u20 (copy, index: 3)
                TweenService_upv_1 (copy, index: 4)
            ]]
            local v10 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            while u18 == u19 do
                if u19.Parent then
                    u19.Size = UDim2.fromScale(1, 1)
                    u20.Transparency = 0.1
                    local tbl_4 = {}
                    tbl_4.Size = UDim2.fromScale(1.45, 1.45)
                    TweenService_upv_1:Create(u19, v10, tbl_4):Play()
                    TweenService_upv_1:Create(u20, v10, {Transparency = 1}):Play()
                    task.wait(1.3)
                    continue
                else
                    break
                end
            end
        end
    )
end
local function fire(a1, a2)
    --[[
      name: fire
      line: 226
      upvalues:
        u3 (ref, index: 1)
    ]]
    if not u3 then
        return
    end
    u3(a1, a2)
end
local function readOverride(a1, a2, a3, a4)
    --[[
      name: readOverride
      line: 213
    ]]
    local v11 = a1:GetAttribute("Override_" .. a2)
    if type(v11) ~= "string" then
        return nil, nil
    end
    local v12, v13, v14 = string.match(v11, "^(%-?%d+),(%-?%d+),(%d+)$")
    if not v12 then
        return nil, nil
    end
    local v15 = math.floor(((tonumber(v14) / 1000) * a4) + 0.5)
    return UDim2.fromOffset(tonumber(v12) / 1000 * a3.X, tonumber(v13) / 1000 * a3.Y), (math.max(v15, 24))
end
local function obstacle(a1)
    --[[
      name: obstacle
      line: 234
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Y_1 = a1.Y
    local X_1 = a1.X
    local v16 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    if not v16 then
        return Y_1, X_1
    end
    local CharacterTouch_1 = v16:FindFirstChild("CharacterTouch")
    if CharacterTouch_1 then
        local v17 = CharacterTouch_1:IsA("ScreenGui")
        if v17 then
            local v18 = nil
            if CharacterTouch_1.Enabled then
                v18 = CharacterTouch_1:GetAttribute("ReservedMinY")
                if type(v18) == "number" and v18 > 0 then
                    Y_1 = math.min(Y_1, v18)
                end
            end
        end
    end
    local TouchGui_1 = v16:FindFirstChild("TouchGui")
    local v19 = TouchGui_1 and (TouchGui_1:FindFirstChild("JumpButton", true))
    if v19 then
        local v20 = v19:IsA("GuiObject")
        if v20 and v19.Visible and v19.AbsoluteSize.X > 0 then
            Y_1 = math.min(Y_1, v19.AbsolutePosition.Y)
        end
    end
    return Y_1, X_1
end
local function layout()
    --[[
      name: layout
      line: 255
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        obstacle (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        readOverride (copy, index: 5)
    ]]
    if not u1 or not u2 then
        return
    end
    local AbsolutePosition_upv_1 = u2.AbsolutePosition
    local AbsoluteSize_1 = u2.AbsoluteSize
    if AbsoluteSize_1.X < 10 then
        return
    end
    local v21 = AbsolutePosition_upv_1 + AbsoluteSize_1
    local v22 = obstacle(v21)
    local v23 = AbsoluteSize_1.Y < 500
    local v24
    if v23 then
        v24 = 92
    else
        v24 = 100
    end
    local v25 = (v23 and 66) or 72
    local v26 = (v23 and 58) or 62
    local v27 = math.min(v22, v21.Y) - 12
    local v28 = v21.X - 22 - v24 / 2
    local v29 = math.max(v27 - (v24 / 2), (AbsolutePosition_upv_1.Y + (v24 / 2)) + 70)
    local function place_1(a1, a2, a3, a4)
        --[[
          name: place
          line: 275
          upvalues:
            AbsolutePosition_upv_1 (copy, index: 1)
        ]]
        a1.Size = UDim2.fromOffset(a4, a4)
        a1.Position = UDim2.fromOffset(a2 - AbsolutePosition_upv_1.X, a3 - AbsolutePosition_upv_1.Y)
    end
    local Attack_1 = tbl_upv_1.Attack
    Attack_1.Size = UDim2.fromOffset(v24, v24)
    Attack_1.Position = UDim2.fromOffset(v28 - AbsolutePosition_upv_1.X, v29 - AbsolutePosition_upv_1.Y)
    local v30 = (v28 - (v24 / 2)) - 14 - v25 / 2
    local Secondary_1 = tbl_upv_1.Secondary
    Secondary_1.Size = UDim2.fromOffset(v25, v25)
    Secondary_1.Position = UDim2.fromOffset(v30 - AbsolutePosition_upv_1.X, (v29 + ((v24 - v25) / 2)) - AbsolutePosition_upv_1.Y)
    local v31 = ((tbl_upv_1.Secondary.Visible) and (v30 - v25 / 2)) or (v28 - v24 / 2)
    local Reload_1 = tbl_upv_1.Reload
    Reload_1.Size = UDim2.fromOffset(v26, v26)
    Reload_1.Position = UDim2.fromOffset(((v31 - 14) - (v26 / 2)) - AbsolutePosition_upv_1.X, (v29 + ((v24 - v26) / 2)) - AbsolutePosition_upv_1.Y)
    for key_1, value_1 in tbl_upv_1 do
        value_1:SetAttribute("DefaultSize", value_1.Size.X.Offset)
        local v32, v33 = readOverride(u1, key_1, AbsoluteSize_1, value_1.Size.X.Offset)
        if not (v32) then
            continue
        end
        if v33 then
            value_1.Position = v32
            value_1.Size = UDim2.fromOffset(v33, v33)
        end
    end
end
local function secondaryFor(a1, a2)
    --[[
      name: secondaryFor
      line: 88
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    if a1 then
        if a1 ~= "Bow" and not (tbl_upv_3[a1]) and a1 ~= "Knives" and a1 ~= "Sling" then
            if a1 ~= "Javelin" and a1 ~= "Bomb" then
                if a2.parry then
                    return "PARRY", "hold"
                end
                if a2.throw then
                    return "THROW", "hold"
                end
                if a2.block then
                    return "BLOCK", "hold"
                end
                if a2.heavy then
                    return "HEAVY", "hold"
                end
                if a2.lunge and (a2.lunge.charge or 0.6) <= 0 then
                    return "DASH", "hold"
                elseif a2.lunge then
                    return "LUNGE", "hold"
                else
                    return nil, nil
                end
            end
            return "CANCEL", "tap"
        end
        return "AIM", "toggle"
    end
    return nil, nil
end
local function refresh()
    --[[
      name: refresh
      line: 294
      upvalues:
        u1 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u7 (ref,  index: 3)
        u8 (ref,  index: 4)
        tbl_upv_2 (copy, index: 5)
        u4 (ref,  index: 6)
        tbl_upv_1 (copy, index: 7)
        Loc_upv_1 (copy, index: 8)
        secondaryFor (copy, index: 9)
        u5 (ref,  index: 10)
        u6 (ref,  index: 11)
        tbl_upv_3 (copy, index: 12)
        layout (copy, index: 13)
        setNudge (copy, index: 14)
        u10 (ref,  index: 15)
    ]]
    if not u1 then
        return
    end
    local v34 = LocalPlayer_upv_1.Character
    local v35 = v34 and (v34:FindFirstChildOfClass("Humanoid"))
    local v36 = false
    if v35 == nil then
        v34 = v36
    else
        v34 = v35.Health > 0
    end
    local v37 = u1:GetAttribute("EditPreview") == true
    u1.Enabled = ((u7) or u1:GetAttribute("ForceVisible") == true) and (u8) and (v34) or v37
    local v38 = tbl_upv_2[u4 or "Fists"] or "ATTACK"
    tbl_upv_1.Attack.AutoLocalize = v38 ~= "DRAW"
    local Attack_2 = tbl_upv_1.Attack
    local v39
    if v38 ~= "DRAW" then
        v39 = v38
    else
        v39 = Loc_upv_1.Pick("DRAW (bow)", "DRAW")
    end
    Attack_2.Text = v39
    local v40 = secondaryFor(u4, u5)
    local Secondary_2 = tbl_upv_1.Secondary
    local v41 = true
    if v40 == nil then
        v41 = v37
    end
    Secondary_2.Visible = v41
    local Secondary_3 = tbl_upv_1.Secondary
    if v40 == "AIM" and (u6) then
        v41 = "AIM ON"
    else
        v41 = v40 or ((v37 and "ALT") or "")
    end
    Secondary_3.Text = v41
    local Reload_2 = tbl_upv_1.Reload
    if u4 == nil or tbl_upv_3[u4] ~= true then
        v41 = v37
    else
        local v42 = true
        if (tonumber(u5.magazine) or 1) > 1 then
            v41 = v42
        else
            v41 = v37
        end
    end
    Reload_2.Visible = v41
    if u1.Enabled then
        layout()
    end
    local v43 = u1:GetAttribute("Nudge")
    local v44 = type(v43) ~= "string" or v37 or tbl_upv_1[v43]
    if v44 and v44.Visible then
        if v44 ~= tbl_upv_1.Secondary then
            v41 = v44
        else
            v41 = u10 or v44
        end
    else
        v41 = nil
    end
    setNudge(v41)
end
local function bindAttack(a1)
    --[[
      name: bindAttack
      line: 322
      upvalues:
        TouchStart_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        u10 (ref,  index: 3)
        u11 (ref,  index: 4)
        u14 (copy, index: 5)
        u12 (copy, index: 6)
        u3 (ref,  index: 7)
        UserInputService_upv_1 (copy, index: 8)
        u9 (ref,  index: 9)
        Players_upv_1 (copy, index: 10)
        u13 (copy, index: 11)
        u15 (copy, index: 12)
    ]]
    local u21 = nil
    a1.InputBegan:Connect(
        function(a2)
            --[[
              line: 324
              upvalues:
                u21 (ref,  index: 1)
                TouchStart_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                tbl_upv_1 (copy, index: 4)
                u10 (ref,  index: 5)
                u11 (ref,  index: 6)
                u14 (copy, index: 7)
                u12 (copy, index: 8)
                u3 (ref,  index: 9)
            ]]
            if a2.UserInputType ~= Enum.UserInputType.Touch or (u21) then
                return
            end
            if TouchStart_upv_1.BeganOn(a1, a2) then
                u21 = a2
                local v45 = a1
                local v46 = (v45 == tbl_upv_1.Secondary) and (u10 and false)
                if v45 == tbl_upv_1.Secondary then
                    u11 = true
                end
                v45.BackgroundColor3 = u14
                v45.BackgroundTransparency = 0.12
                v45.TextTransparency = (v46 and 0.55) or 0
                local v47 = v45:FindFirstChildOfClass("UIStroke")
                if v47 then
                    v47.Color = u12
                    v47.Thickness = 3
                    v47.Transparency = 0
                end
                local v48 = v45:FindFirstChildOfClass("UIScale")
                if v48 then
                    v48.Scale = 0.92
                end
                if u3 then
                    u3("Primary", true)
                end
            end
        end
    )
    UserInputService_upv_1.TouchMoved:Connect(
        function(a3)
            --[[
              line: 336
              upvalues:
                u21 (ref,  index: 1)
                u9 (ref,  index: 2)
                UserInputService_upv_1 (copy, index: 3)
                Players_upv_1 (copy, index: 4)
            ]]
            if a3 ~= u21 or not u9 then
                return
            end
            if not (UserInputService_upv_1.MouseEnabled) and Players_upv_1.LocalPlayer:GetAttribute("TouchAttackLookOff") ~= true then
                local Delta_upv_1 = a3.Delta
                if not (pcall(
                    function()
                        --[[
                          line: 344
                          upvalues:
                            u9 (ref,  index: 1)
                            Delta_upv_1 (copy, index: 2)
                        ]]
                        u9.AddTouchLook(Vector2.new(Delta_upv_1.X, Delta_upv_1.Y))
                    end
                )) then
                    u9 = nil
                end
            end
        end
    )
    UserInputService_upv_1.TouchEnded:Connect(
        function(a4)
            --[[
              line: 351
              upvalues:
                u21 (ref,  index: 1)
                a1 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                u10 (ref,  index: 4)
                u11 (ref,  index: 5)
                u13 (copy, index: 6)
                u15 (copy, index: 7)
                u3 (ref,  index: 8)
            ]]
            if a4 ~= u21 then
                return
            end
            u21 = nil
            local v49 = a1
            local v50 = (v49 == tbl_upv_1.Secondary) and (u10 and true)
            if v49 == tbl_upv_1.Secondary then
                u11 = false
            end
            v49.BackgroundColor3 = u13
            v49.BackgroundTransparency = (v50 and 0.6) or 0.3
            v49.TextTransparency = (v50 and 0.55) or 0
            local v51 = v49:FindFirstChildOfClass("UIStroke")
            if v51 then
                v51.Color = u15
                v51.Thickness = 2
                v51.Transparency = (v50 and 0.92) or 0.8
            end
            local v52 = a1:FindFirstChildOfClass("UIScale")
            if v52 then
                v52.Scale = 1
            end
            if not u3 then
                return
            end
            u3("Primary", false)
        end
    )
end
local function bindSecondary(a1)
    --[[
      name: bindSecondary
      line: 361
      upvalues:
        TouchStart_upv_1 (copy, index: 1)
        secondaryFor (copy, index: 2)
        u4 (ref,  index: 3)
        u5 (ref,  index: 4)
        u6 (ref,  index: 5)
        setPressedLook (copy, index: 6)
        u3 (ref,  index: 7)
        refresh (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        u10 (ref,  index: 10)
        u11 (ref,  index: 11)
        u14 (copy, index: 12)
        u12 (copy, index: 13)
        UserInputService_upv_1 (copy, index: 14)
        u13 (copy, index: 15)
        u15 (copy, index: 16)
    ]]
    local u22 = nil
    a1.InputBegan:Connect(
        function(a2)
            --[[
              line: 363
              upvalues:
                u22 (ref,  index: 1)
                TouchStart_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                secondaryFor (copy, index: 4)
                u4 (ref,  index: 5)
                u5 (ref,  index: 6)
                u6 (ref,  index: 7)
                setPressedLook (copy, index: 8)
                u3 (ref,  index: 9)
                refresh (copy, index: 10)
                tbl_upv_1 (copy, index: 11)
                u10 (ref,  index: 12)
                u11 (ref,  index: 13)
                u14 (copy, index: 14)
                u12 (copy, index: 15)
            ]]
            if a2.UserInputType ~= Enum.UserInputType.Touch or (u22) then
                return
            end
            if TouchStart_upv_1.BeganOn(a1, a2) then
                local _, v53 = secondaryFor(u4, u5)
                if v53 == "toggle" then
                    u6 = not u6
                    setPressedLook(a1, u6)
                    local v54 = u6
                    if u3 then
                        u3("Secondary", v54)
                    end
                    refresh()
                elseif v53 == "tap" then
                    if u3 then
                        u3("Secondary", true)
                    end
                    if u3 then
                        u3("Secondary", false)
                        return
                    end
                elseif v53 == "hold" then
                    u22 = a2
                    local v55 = a1
                    local v56 = (v55 == tbl_upv_1.Secondary) and (u10 and false)
                    if v55 == tbl_upv_1.Secondary then
                        u11 = true
                    end
                    v55.BackgroundColor3 = u14
                    v55.BackgroundTransparency = 0.12
                    v55.TextTransparency = (v56 and 0.55) or 0
                    local v57 = v55:FindFirstChildOfClass("UIStroke")
                    if v57 then
                        v57.Color = u12
                        v57.Thickness = 3
                        v57.Transparency = 0
                    end
                    local v58 = v55:FindFirstChildOfClass("UIScale")
                    if v58 then
                        v58.Scale = 0.92
                    end
                    if u3 then
                        u3("Secondary", true)
                    end
                end
            end
        end
    )
    UserInputService_upv_1.TouchEnded:Connect(
        function(a3)
            --[[
              line: 382
              upvalues:
                u22 (ref,  index: 1)
                a1 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                u10 (ref,  index: 4)
                u11 (ref,  index: 5)
                u13 (copy, index: 6)
                u15 (copy, index: 7)
                u3 (ref,  index: 8)
            ]]
            if a3 ~= u22 then
                return
            end
            u22 = nil
            local v59 = a1
            local v60 = (v59 == tbl_upv_1.Secondary) and (u10 and true)
            if v59 == tbl_upv_1.Secondary then
                u11 = false
            end
            v59.BackgroundColor3 = u13
            v59.BackgroundTransparency = (v60 and 0.6) or 0.3
            v59.TextTransparency = (v60 and 0.55) or 0
            local v61 = v59:FindFirstChildOfClass("UIStroke")
            if v61 then
                v61.Color = u15
                v61.Thickness = 2
                v61.Transparency = (v60 and 0.92) or 0.8
            end
            local v62 = a1:FindFirstChildOfClass("UIScale")
            if v62 then
                v62.Scale = 1
            end
            if not u3 then
                return
            end
            u3("Secondary", false)
        end
    )
end
function v1.SetWeapon(a1, a2)
    --[[
      name: SetWeapon
      line: 393
      upvalues:
        u4 (ref,  index: 1)
        u5 (ref,  index: 2)
        u6 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        u10 (ref,  index: 5)
        u11 (ref,  index: 6)
        u13 (copy, index: 7)
        u15 (copy, index: 8)
        refresh (copy, index: 9)
    ]]
    u4 = a1
    u5 = a2 or {}
    u6 = false
    if tbl_upv_1.Secondary then
        local Secondary_4 = tbl_upv_1.Secondary
        local v63 = (Secondary_4 == tbl_upv_1.Secondary) and (u10 and true)
        if Secondary_4 == tbl_upv_1.Secondary then
            u11 = false
        end
        Secondary_4.BackgroundColor3 = u13
        Secondary_4.BackgroundTransparency = (v63 and 0.6) or 0.3
        Secondary_4.TextTransparency = (v63 and 0.55) or 0
        local v64 = Secondary_4:FindFirstChildOfClass("UIStroke")
        if v64 then
            v64.Color = u15
            v64.Thickness = 2
            v64.Transparency = (v63 and 0.92) or 0.8
        end
        local v65 = Secondary_4:FindFirstChildOfClass("UIScale")
        if v65 then
            v65.Scale = 1
        end
    end
    refresh()
end
function v1.SetAltDim(a1)
    --[[
      name: SetAltDim
      line: 404
      upvalues:
        u10 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        setPressedLook (copy, index: 3)
        u11 (ref,  index: 4)
        refresh (copy, index: 5)
    ]]
    if a1 == u10 then
        return
    end
    u10 = a1
    if tbl_upv_1.Secondary then
        setPressedLook(tbl_upv_1.Secondary, u11)
    end
    refresh()
end
function v1.SetVisible(a1)
    --[[
      name: SetVisible
      line: 415
      upvalues:
        u8 (ref,  index: 1)
        refresh (copy, index: 2)
    ]]
    if a1 == u8 then
        return
    end
    u8 = a1
    refresh()
end
function v1.IsActive()
    --[[
      name: IsActive
      line: 422
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
local function updateActive(a1)
    --[[
      name: updateActive
      line: 426
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        u7 (ref,  index: 2)
        refresh (copy, index: 3)
    ]]
    local v66 = a1 or (UserInputService_upv_1:GetLastInputType())
    local v67
    if v66 == Enum.UserInputType.Touch then
        v67 = true
    elseif v66 == Enum.UserInputType.MouseButton1 or v66 == Enum.UserInputType.MouseMovement or v66 == Enum.UserInputType.Keyboard or string.find(v66.Name, "Gamepad") then
        v67 = false
    else
        v67 = UserInputService_upv_1.TouchEnabled and not UserInputService_upv_1.MouseEnabled
    end
    if v67 == u7 then
        return
    end
    u7 = v67
    refresh()
end
function v1.Start(a1)
    --[[
      name: Start
      line: 442
      upvalues:
        u1 (ref,  index: 1)
        u3 (ref,  index: 2)
        u9 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        u2 (ref,  index: 5)
        tbl_upv_1 (copy, index: 6)
        makeButton (copy, index: 7)
        bindAttack (copy, index: 8)
        bindSecondary (copy, index: 9)
        TouchStart_upv_1 (copy, index: 10)
        u10 (ref,  index: 11)
        u11 (ref,  index: 12)
        u14 (copy, index: 13)
        u12 (copy, index: 14)
        u13 (copy, index: 15)
        u15 (copy, index: 16)
        refresh (copy, index: 17)
        updateActive (copy, index: 18)
        UserInputService_upv_1 (copy, index: 19)
        layout (copy, index: 20)
        u6 (ref,  index: 21)
    ]]
    if u1 then
        return
    end
    u3 = a1
    task.spawn(
        function()
            --[[
              line: 447
              upvalues:
                u9 (ref, index: 1)
            ]]
            local success_1, v69 = pcall(
                function()
                    --[[
                      line: 448
                    ]]
                    return require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera", 10))
                end
            )
            local v70
            if success_1 and type(v69) == "table" and v69.SetLook and v69.GetYaw then
                v70 = v69
            else
                v70 = nil
            end
            u9 = v70
        end
    )
    local u23 = Instance.new("ScreenGui")
    u23.Name = "CombatTouch"
    u23.ResetOnSpawn = false
    u23.IgnoreGuiInset = true
    u23.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    u23.DisplayOrder = 5
    u23.Enabled = false
    u23.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    u1 = u23
    local v71 = Instance.new("Frame")
    v71.Name = "Root"
    v71.BackgroundTransparency = 1
    v71.Size = UDim2.fromScale(1, 1)
    v71.Parent = u23
    u2 = v71
    tbl_upv_1.Attack = makeButton(v71, "Attack", 96, "ATTACK", 16)
    tbl_upv_1.Secondary = makeButton(v71, "Secondary", 70, "BLOCK", 14)
    tbl_upv_1.Reload = makeButton(v71, "Reload", 60, "RELOAD", 12)
    bindAttack(tbl_upv_1.Attack)
    bindSecondary(tbl_upv_1.Secondary)
    tbl_upv_1.Reload.InputBegan:Connect(
        function(a2)
            --[[
              line: 473
              upvalues:
                TouchStart_upv_1 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
                u10 (ref,  index: 3)
                u11 (ref,  index: 4)
                u14 (copy, index: 5)
                u12 (copy, index: 6)
                u3 (ref,  index: 7)
                u13 (copy, index: 8)
                u15 (copy, index: 9)
            ]]
            if a2.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            if TouchStart_upv_1.BeganOn(tbl_upv_1.Reload, a2) then
                local Reload_3 = tbl_upv_1.Reload
                local v72 = (Reload_3 == tbl_upv_1.Secondary) and (u10 and false)
                if Reload_3 == tbl_upv_1.Secondary then
                    u11 = true
                end
                Reload_3.BackgroundColor3 = u14
                Reload_3.BackgroundTransparency = 0.12
                Reload_3.TextTransparency = (v72 and 0.55) or 0
                local v73 = Reload_3:FindFirstChildOfClass("UIStroke")
                if v73 then
                    v73.Color = u12
                    v73.Thickness = 3
                    v73.Transparency = 0
                end
                local v74 = Reload_3:FindFirstChildOfClass("UIScale")
                if v74 then
                    v74.Scale = 0.92
                end
                if u3 then
                    u3("Reload", true)
                end
                if u3 then
                    u3("Reload", false)
                end
                task.delay(
                    0.12,
                    function()
                        --[[
                          line: 478
                          upvalues:
                            tbl_upv_1 (copy, index: 1)
                            u10 (ref,  index: 2)
                            u11 (ref,  index: 3)
                            u13 (copy, index: 4)
                            u15 (copy, index: 5)
                        ]]
                        local Reload_4 = tbl_upv_1.Reload
                        local v75 = (Reload_4 == tbl_upv_1.Secondary) and (u10 and true)
                        if Reload_4 == tbl_upv_1.Secondary then
                            u11 = false
                        end
                        Reload_4.BackgroundColor3 = u13
                        Reload_4.BackgroundTransparency = (v75 and 0.6) or 0.3
                        Reload_4.TextTransparency = (v75 and 0.55) or 0
                        local v76 = Reload_4:FindFirstChildOfClass("UIStroke")
                        if v76 then
                            v76.Color = u15
                            v76.Thickness = 2
                            v76.Transparency = (v75 and 0.92) or 0.8
                        end
                        local v77 = Reload_4:FindFirstChildOfClass("UIScale")
                        if not v77 then
                            return
                        end
                        v77.Scale = 1
                    end
                )
            end
        end
    )
    u23:GetAttributeChangedSignal("ForceVisible"):Connect(refresh)
    u23.AttributeChanged:Connect(
        function(a3)
            --[[
              line: 484
              upvalues:
                refresh (copy, index: 1)
            ]]
            if a3 ~= "EditPreview" and a3 ~= "Nudge" and string.sub(a3, 1, 9) ~= "Override_" then
                return
            end
            refresh()
        end
    )
    updateActive(nil)
    UserInputService_upv_1.LastInputTypeChanged:Connect(updateActive)
    v71:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 491
              upvalues:
                u23 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u23.Enabled then
                return
            end
            layout()
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a4)
            --[[
              line: 496
              upvalues:
                u6 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            u6 = false
            local v78 = a4:WaitForChild("Humanoid", 10)
            if v78 then
                v78.Died:Connect(refresh)
            end
            refresh()
        end
    )
    task.spawn(
        function()
            --[[
              line: 505
              upvalues:
                u23 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            while u23.Parent do
                task.wait(1.5)
                if u23.Enabled then
                    layout()
                end
            end
        end
    )
    refresh()
end
return v1