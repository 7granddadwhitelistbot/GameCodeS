local GuiService_upv_1 = game:GetService("GuiService")
local Players_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Camera_upv_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Camera"))
local TouchStart_upv_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("TouchStart"))
local Loc_upv_1 = require(ReplicatedStorage_1.Shared:WaitForChild("Loc"))
local Movement_upv_1 = require(script.Parent:WaitForChild("Movement"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = Color3.fromRGB(18, 20, 26)
local u2 = Color3.fromRGB(36, 40, 50)
local u3 = Color3.fromRGB(40, 150, 255)
local u4 = Color3.fromRGB(255, 255, 255)
local u5 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local u6 = nil
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = false
local u12 = false
local u13 = false
local tbl_upv_2 = {FreeCursor = true, Spectate = true}
local function setPressed(a1, a2)
    --[[
      name: setPressed
      line: 97
      upvalues:
        u2 (copy, index: 1)
        u3 (copy, index: 3)
        u13 (ref,  index: 5)
        TweenService_upv_1 (copy, index: 6)
    ]]
    a1.BackgroundColor3 = u2
    a1.BackgroundTransparency = (a2 and 0.12) or 0.3
    local v1 = a1:FindFirstChildOfClass("UIStroke")
    if v1 then
        v1.Color = u3
        v1.Thickness = (a2 and 3) or 2
        v1.Transparency = (a2 and 0) or ((u13 and 0.92) or 0.8)
    end
    local v2 = a1:FindFirstChildOfClass("UIScale")
    if v2 then
        local v3 = TweenInfo.new((a2 and 0.06) or 0.12, Enum.EasingStyle.Quad)
        local tbl_3 = {Scale = 0}
        tbl_3.Scale = (a2 and 0.92) or 1
        TweenService_upv_1:Create(v2, v3, tbl_3):Play()
    end
end
local function readOverride(a1, a2, a3, a4)
    --[[
      name: readOverride
      line: 148
    ]]
    local v4 = a1:GetAttribute("Override_" .. a2)
    if type(v4) ~= "string" then
        return nil, nil
    end
    local v5, v6, v7 = string.match(v4, "^(%-?%d+),(%-?%d+),(%d+)$")
    if not v5 then
        return nil, nil
    end
    local v8 = math.floor(((tonumber(v7) / 1000) * a4) + 0.5)
    return UDim2.fromOffset(tonumber(v5) / 1000 * a3.X, tonumber(v6) / 1000 * a3.Y), (math.max(v8, 24))
end
local function layout()
    --[[
      name: layout
      line: 161
      upvalues:
        u7 (ref,  index: 1)
        u8 (ref,  index: 2)
        u9 (ref,  index: 3)
        u10 (ref,  index: 4)
        u6 (ref,  index: 5)
        readOverride (copy, index: 6)
    ]]
    if not u7 or not u8 or not u9 or not u10 or not u6 then
        return
    end
    local AbsoluteSize_1 = u7.AbsoluteSize
    if AbsoluteSize_1.X < 10 or AbsoluteSize_1.Y < 10 then
        return
    end
    local v9 = math.clamp(math.min(AbsoluteSize_1.X, AbsoluteSize_1.Y) / 360, 0.85, 1.45)
    local v10 = math.floor(v9 * 84)
    local v11 = math.floor(v9 * 64)
    local v12 = AbsoluteSize_1.X - (v9 * 18) - v10 / 2
    u8.Size = UDim2.fromOffset(v10, v10)
    u8.Position = UDim2.fromOffset(v12, (AbsoluteSize_1.Y - (v9 * 14)) - (v10 / 2))
    u8.TextSize = math.floor(v9 * 17)
    local AbsolutePosition_1 = (v12 - (v10 / 2)) - (v9 * 14) - v11 / 2
    u9.Size = UDim2.fromOffset(v11, v11)
    u9.Position = UDim2.fromOffset(AbsolutePosition_1, (AbsoluteSize_1.Y - (v9 * 14)) - (v11 / 2))
    u9.TextSize = math.floor(v9 * 14)
    local v13 = math.max(44, math.floor(v9 * 48))
    u10.Size = UDim2.fromOffset(v13, v13)
    u10.Position = UDim2.fromOffset(((AbsolutePosition_1 - (v11 / 2)) - (v9 * 14)) - (v13 / 2), (AbsoluteSize_1.Y - (v9 * 14)) - (v13 / 2))
    u10.TextSize = math.floor(v9 * 13)
    for _, value_1 in {u8, u9, u10} do
        value_1:SetAttribute("DefaultSize", value_1.Size.X.Offset)
        local v14, v15 = readOverride(u6, value_1.Name, AbsoluteSize_1, value_1.Size.X.Offset)
        if not (v14) then
            continue
        end
        if v15 then
            value_1.Position = v14
            value_1.Size = UDim2.fromOffset(v15, v15)
            value_1.TextSize = math.floor(v15 * 0.2)
        end
    end
    local v16 = math.huge
    local v17 = math.huge
    for _, value_2 in {u8, u9, u10} do
        v16, v17 = math.min(v16, value_2.Position.X.Offset - (value_2.Size.X.Offset / 2)), math.min(v17, value_2.Position.Y.Offset - (value_2.Size.Y.Offset / 2))
    end
    AbsolutePosition_1 = u7.AbsolutePosition
    u6:SetAttribute("Scale", v9)
    u6:SetAttribute("ReservedMinX", (math.floor((AbsolutePosition_1.X + v16) - (v9 * 10))))
    u6:SetAttribute("ReservedMinY", (math.floor((AbsolutePosition_1.Y + v17) - (v9 * 10))))
end
local function menuOpen()
    --[[
      name: menuOpen
      line: 226
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
        Camera_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
    ]]
    if LocalPlayer_upv_1:GetAttribute("MenuOpen") == true or GuiService_upv_1.MenuIsOpen then
        return true
    end
    for _, value_3 in Camera_upv_1.GetUnlockReasons() do
        if tbl_upv_2[value_3] then
            continue
        end
        return true
    end
    return false
end
local function characterAlive()
    --[[
      name: characterAlive
      line: 238
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v18 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
    if v18 and not (v18.Health <= 0) then
        local v19 = (LocalPlayer_upv_1:GetAttribute("State") == "Match") and (LocalPlayer_upv_1:GetAttribute("Alive") == false)
        return not v19
    end
    return false
end
local u14 = nil
local function robloxJumpButton()
    --[[
      name: robloxJumpButton
      line: 248
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v20 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    local v21 = v20 and (v20:FindFirstChild("TouchGui"))
    local v22 = v21 and (v21:FindFirstChild("TouchControlFrame"))
    local v23 = v22 and (v22:FindFirstChild("JumpButton"))
    if v23 and v23:IsA("GuiObject") then
        return v23
    end
    return nil
end
local function enforceRobloxJump()
    --[[
      name: enforceRobloxJump
      line: 257
      upvalues:
        robloxJumpButton (copy, index: 1)
        u14 (ref,  index: 2)
        u12 (ref,  index: 3)
    ]]
    local u15 = robloxJumpButton()
    if not u15 then
        return
    end
    if u15 ~= u14 then
        u14 = u15
        u15:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 264
                  upvalues:
                    u12 (ref,  index: 1)
                    u15 (copy, index: 2)
                ]]
                if not u12 or not u15.Visible then
                    return
                end
                u15.Visible = false
            end
        )
    end
    if u12 and u15.Visible then
        u15.Visible = false
    end
end
local function touchPreferred()
    --[[
      name: touchPreferred
      line: 209
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    local success_1, v24 = pcall(
        function()
            --[[
              line: 210
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
            ]]
            return UserInputService_upv_1.PreferredInput
        end
    )
    if success_1 and typeof(v24) == "EnumItem" then
        return v24.Name == "Touch"
    elseif UserInputService_upv_1.TouchEnabled then
        if UserInputService_upv_1:GetLastInputType() ~= Enum.UserInputType.Touch then
            return not UserInputService_upv_1.KeyboardEnabled
        end
        return true
    else
        return false
    end
end
local function refresh()
    --[[
      name: refresh
      line: 275
      upvalues:
        u6 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        u12 (ref,  index: 3)
        touchPreferred (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        GuiService_upv_1 (copy, index: 6)
        Camera_upv_1 (copy, index: 7)
        tbl_upv_2 (copy, index: 8)
        u11 (ref,  index: 9)
        Movement_upv_1 (copy, index: 10)
        u10 (ref,  index: 11)
        u13 (ref,  index: 12)
        u8 (ref,  index: 13)
        u9 (ref,  index: 14)
        u3 (copy, index: 15)
        enforceRobloxJump (copy, index: 16)
    ]]
    if not u6 then
        return
    end
    local v25 = RunService_upv_1:IsStudio() and (u6:GetAttribute("ForceVisible") == true)
    u12 = touchPreferred() or v25
    if u12 then
        local Character_2 = LocalPlayer_upv_1.Character
        local v26 = Character_2 and (Character_2:FindFirstChildOfClass("Humanoid"))
        local v27
        if not (v26) or v26.Health <= 0 then
            v27 = false
        else
            local v28 = LocalPlayer_upv_1:GetAttribute("State") == "Match" and LocalPlayer_upv_1:GetAttribute("Alive") == false
            v27 = not v28
        end
        if v27 then
            if LocalPlayer_upv_1:GetAttribute("MenuOpen") == true or GuiService_upv_1.MenuIsOpen then
                v27 = true
            else
                for _, value_4 in Camera_upv_1.GetUnlockReasons() do
                    if not (tbl_upv_2[value_4]) then
                        v27 = true
                    end
                end
            end
            v25 = not v27
            v25 = v25 or u6:GetAttribute("EditPreview") == true
        else
            v25 = u6:GetAttribute("EditPreview") == true
        end
    else
        v25 = u6:GetAttribute("EditPreview") == true
    end
    if v25 ~= u11 then
        u11 = v25
        u6.Enabled = v25
        if not (v25) then
            Movement_upv_1.SetJumpHeld(false)
            Movement_upv_1.SetSlideHeld(false)
        end
    end
    if u10 then
        local v29 = u11
        if v29 then
            local v30 = true
            if Camera_upv_1.GetMode() == "combat" then
                v29 = v30
            else
                v29 = u6:GetAttribute("EditPreview") == true
            end
        end
        if u10.Visible ~= v29 then
            u10.Visible = v29
        end
        if (Camera_upv_1.IsFirstPerson) and (Camera_upv_1.IsFirstPerson()) then
            v29 = "1P"
        else
            v29 = "3P"
        end
        if u10.Text ~= v29 then
            u10.Text = v29
        end
    end
    v25 = LocalPlayer_upv_1:GetAttribute("Frozen") == true
    if v25 ~= u13 then
        u13 = v25
        for _, value_5 in {u8, u9} do
            if not (value_5) then
                continue
            end
            value_5.TextTransparency = (v25 and 0.55) or 0
            local v31 = value_5:FindFirstChildOfClass("UIStroke")
            if not (v31) then
                continue
            end
            if v31.Color ~= u3 then
                v31.Transparency = (v25 and 0.92) or 0.8
            end
        end
    end
    enforceRobloxJump()
end
function tbl_1.IsVisible()
    --[[
      name: IsVisible
      line: 319
      upvalues:
        u11 (ref, index: 1)
    ]]
    return u11
end
local u16 = false
local function bindHold(a1, a2, a3)
    --[[
      name: bindHold
      line: 113
      upvalues:
        TouchStart_upv_1 (copy, index: 1)
        setPressed (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
    ]]
    local u17 = nil
    a1.InputBegan:Connect(
        function(a4)
            --[[
              line: 115
              upvalues:
                u17 (ref,  index: 1)
                TouchStart_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                setPressed (copy, index: 4)
                a2 (copy, index: 5)
            ]]
            local UserInputType_1 = a4.UserInputType
            if (UserInputType_1 == Enum.UserInputType.Touch or UserInputType_1 == Enum.UserInputType.MouseButton1) and not (u17) and TouchStart_upv_1.BeganOn(a1, a4) then
                u17 = a4
                setPressed(a1, true)
                a2()
            end
        end
    )
    UserInputService_upv_1.InputEnded:Connect(
        function(a5)
            --[[
              line: 127
              upvalues:
                u17 (ref,  index: 1)
                setPressed (copy, index: 2)
                a1 (copy, index: 3)
                a3 (copy, index: 4)
            ]]
            if a5 ~= u17 then
                return
            end
            u17 = nil
            setPressed(a1, false)
            a3()
        end
    )
    a1:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 135
              upvalues:
                a1 (copy, index: 1)
                u17 (ref,  index: 2)
                setPressed (copy, index: 3)
                a3 (copy, index: 4)
            ]]
            if (a1.Visible) or not u17 then
                return
            end
            u17 = nil
            setPressed(a1, false)
            a3()
        end
    )
end
local function makeButton(a1, a2, a3)
    --[[
      name: makeButton
      line: 68
      upvalues:
        u1 (copy, index: 1)
        u4 (copy, index: 2)
        u5 (copy, index: 3)
        Loc_upv_1 (copy, index: 4)
    ]]
    local v32 = Instance.new("TextButton")
    v32.Name = a2
    v32.AnchorPoint = Vector2.new(0.5, 0.5)
    v32.BackgroundColor3 = u1
    v32.BackgroundTransparency = 0.3
    v32.AutoButtonColor = false
    v32.Text = a3
    v32.TextColor3 = u4
    v32.FontFace = u5
    v32.Active = true
    v32.Selectable = false
    local v33 = Instance.new("UICorner")
    v33.CornerRadius = UDim.new(1, 0)
    v33.Parent = v32
    local v34 = Instance.new("UIStroke")
    v34.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v34.Thickness = 2
    v34.Color = u4
    v34.Transparency = 0.8
    v34.Parent = v32
    Instance.new("UIScale").Parent = v32
    Loc_upv_1.Fit(v32, 8, 0.06)
    v32.Parent = a1
    return v32
end
local function gateRobloxTouch()
    --[[
      name: gateRobloxTouch
      line: 336
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
    ]]
    if LocalPlayer_upv_1:GetAttribute("TouchControlsReady") == true then
        return
    end
    if not (LocalPlayer_upv_1.Character) then
        LocalPlayer_upv_1:SetAttribute("TouchControlsReady", false)
    end
    task.spawn(
        function()
            --[[
              line: 343
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                RunService_upv_1 (copy, index: 2)
            ]]
            if not (LocalPlayer_upv_1.Character) then
                local _ = LocalPlayer_upv_1.CharacterAdded:Wait()
            end
            local v35 = os.clock()
            local v36 = 0
            while true do
                if v36 < 6 then
                    RunService_upv_1.RenderStepped:Wait()
                    v36 = v36 + 1
                    continue
                end
                if not (os.clock() - v35 < 0.3) then
                    break
                end
                RunService_upv_1.RenderStepped:Wait()
                v36 = v36 + 1
            end
            LocalPlayer_upv_1:SetAttribute("TouchControlsReady", true)
        end
    )
end
function tbl_1.Start()
    --[[
      name: Start
      line: 357
      upvalues:
        u16 (ref,  index: 1)
        gateRobloxTouch (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        u7 (ref,  index: 4)
        u8 (ref,  index: 5)
        makeButton (copy, index: 6)
        u9 (ref,  index: 7)
        bindHold (copy, index: 8)
        Movement_upv_1 (copy, index: 9)
        u10 (ref,  index: 10)
        Camera_upv_1 (copy, index: 11)
        refresh (copy, index: 12)
        u6 (ref,  index: 13)
        layout (copy, index: 14)
        UserInputService_upv_1 (copy, index: 15)
    ]]
    if u16 then
        return
    end
    u16 = true
    gateRobloxTouch()
    local PlayerGui_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    local v37 = Instance.new("ScreenGui")
    v37.Name = "CharacterTouch"
    v37.ResetOnSpawn = false
    v37.IgnoreGuiInset = true
    v37.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    v37.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v37.DisplayOrder = 3
    v37.Enabled = false
    local v38 = Instance.new("Frame")
    v38.Name = "Buttons"
    v38.BackgroundTransparency = 1
    v38.Size = UDim2.fromScale(1, 1)
    v38.Parent = v37
    u7 = v38
    u8 = makeButton(v38, "Jump", "JUMP")
    u9 = makeButton(v38, "Slide", "SLIDE")
    bindHold(
        u8,
        function()
            --[[
              line: 380
              upvalues:
                Movement_upv_1 (copy, index: 1)
            ]]
            Movement_upv_1.SetJumpHeld(true)
        end,
        function()
            --[[
              line: 382
              upvalues:
                Movement_upv_1 (copy, index: 1)
            ]]
            Movement_upv_1.SetJumpHeld(false)
        end
    )
    bindHold(
        u9,
        function()
            --[[
              line: 385
              upvalues:
                Movement_upv_1 (copy, index: 1)
            ]]
            Movement_upv_1.SetSlideHeld(true)
        end,
        function()
            --[[
              line: 387
              upvalues:
                Movement_upv_1 (copy, index: 1)
            ]]
            Movement_upv_1.SetSlideHeld(false)
        end
    )
    u10 = makeButton(v38, "View", "3P")
    bindHold(
        u10,
        function()
            --[[
              line: 391
              upvalues:
                Camera_upv_1 (copy, index: 1)
                refresh (copy, index: 2)
            ]]
            if Camera_upv_1.ToggleFirstPerson then
                Camera_upv_1.ToggleFirstPerson()
            end
            task.defer(refresh)
        end,
        function()
            --[[
              line: 396
            ]]
        end
    )
    u6 = v37
    v37.Parent = PlayerGui_1
    v38:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)
    v37.AttributeChanged:Connect(
        function(a1)
            --[[
              line: 400
              upvalues:
                layout (copy, index: 1)
                refresh (copy, index: 2)
            ]]
            if string.sub(a1, 1, 9) == "Override_" then
                layout()
            elseif a1 == "EditPreview" then
                task.defer(refresh)
            end
        end
    )
    v38:GetPropertyChangedSignal("AbsolutePosition"):Connect(layout)
    layout()
    task.spawn(
        function()
            --[[
              line: 411
              upvalues:
                refresh (copy, index: 1)
            ]]
            while true do
                pcall(refresh)
                task.wait(0.1)
            end
        end
    )
    UserInputService_upv_1.LastInputTypeChanged:Connect(
        function()
            --[[
              line: 417
              upvalues:
                refresh (copy, index: 1)
            ]]
            task.defer(refresh)
        end
    )
end
return tbl_1