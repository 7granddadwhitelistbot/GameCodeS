local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Net_upv_1 = require(Shared_1:WaitForChild("Net"))
local Keybinds_upv_1 = require(Shared_1:WaitForChild("Keybinds"))
local Combat_upv_1 = require(Shared_1:WaitForChild("Combat"))
local Sfx_upv_1 = require(Shared_1:WaitForChild("Sfx"))
local Util_upv_1 = require(script.Parent:WaitForChild("Util"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = Color3.fromRGB(40, 150, 255)
local u2 = Color3.fromRGB(235, 70, 60)
local u3 = Color3.fromRGB(18, 20, 26)
local u4 = Color3.fromRGB(255, 255, 255)
local u5 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local tbl_upv_2 = {FreeCursor = true, UI = true, Spectate = true}
local u6 = nil
local tbl_upv_3 = {}
local u7 = -math.huge
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local function matchId()
    --[[
      name: matchId
      line: 69
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v1 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(v1) ~= "string" then
        return ""
    end
    return v1
end
local function sideOf(a1)
    --[[
      name: sideOf
      line: 76
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v2 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local v3
    if type(v2) ~= "string" then
        v3 = ""
    else
        v3 = v2
    end
    local v4 = LocalPlayer_upv_1:GetAttribute("Team")
    if v3 ~= "" and a1:GetAttribute("MatchId") == v3 and v4 ~= nil then
        if a1:GetAttribute("Team") ~= v4 then
            return "enemy"
        end
        return "ally"
    end
    return nil
end
local function hasHumanTeammate()
    --[[
      name: hasHumanTeammate
      line: 84
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        u8 (ref,  index: 3)
        Players_upv_1 (copy, index: 4)
    ]]
    local v5 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local v6
    if type(v5) ~= "string" then
        v6 = ""
    else
        v6 = v5
    end
    local v7 = LocalPlayer_upv_1:GetAttribute("Team")
    if v6 == "" then
        return false
    end
    local v8 = RunService_upv_1:IsStudio()
    if v8 and u8 and u8:GetAttribute("ForceVisible") == true then
        return true
    end
    for _, value_1 in Players_upv_1:GetPlayers() do
        if value_1 == LocalPlayer_upv_1 or value_1:GetAttribute("MatchId") ~= v6 or value_1:GetAttribute("Team") ~= v7 then
            continue
        end
        return true
    end
    return false
end
local function isDead()
    --[[
      name: isDead
      line: 102
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    if LocalPlayer_upv_1:GetAttribute("Alive") == false then
        return true
    end
    local Character_1 = LocalPlayer_upv_1.Character
    local v9 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
    return not v9 or (v9.Health <= 0)
end
local function headshot(a1)
    --[[
      name: headshot
      line: 137
    ]]
    if a1 > 0 then
        return (string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", a1))
    end
    return ""
end
local function screenScale()
    --[[
      name: screenScale
      line: 142
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    local v10
    if CurrentCamera_1 then
        v10 = CurrentCamera_1.ViewportSize
    else
        v10 = Vector2.new(1600, 900)
    end
    return (math.clamp(math.min(v10.X / 1600, v10.Y / 900), 0.8, 1.2))
end
local function remove(a1)
    --[[
      name: remove
      line: 148
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v11 = tbl_upv_3[a1]
    if not v11 then
        return
    end
    tbl_upv_3[a1] = nil
    v11.frame:Destroy()
end
local function stroke(a1, a2)
    --[[
      name: stroke
      line: 156
      upvalues:
        u3 (copy, index: 1)
    ]]
    local v12 = Instance.new("UIStroke")
    v12.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v12.Thickness = a2
    v12.Color = u3
    v12.Transparency = 0.35
    v12.Parent = a1
    return v12
end
local function show(a1, a2, a3)
    --[[
      name: show
      line: 168
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u2 (copy, index: 2)
        u1 (copy, index: 3)
        u5 (copy, index: 4)
        u4 (copy, index: 5)
        u3 (copy, index: 6)
        u9 (ref,  index: 7)
        TweenService_upv_1 (copy, index: 8)
        Sfx_upv_1 (copy, index: 9)
    ]]
    local v13 = tbl_upv_3[a1]
    if v13 then
        tbl_upv_3[a1] = nil
        v13.frame:Destroy()
    end
    local v14
    if a3 ~= "enemy" then
        v14 = u1
    else
        v14 = u2
    end
    local v15 = Instance.new("Frame")
    v15.Name = "Mark"
    v15.AnchorPoint = Vector2.new(0.5, 0.9642857142857143)
    v15.Size = UDim2.fromOffset(60, 56)
    v15.BackgroundTransparency = 1
    v15.Visible = false
    local v16 = Instance.new("UIScale")
    v16.Parent = v15
    local v17 = Instance.new("Frame")
    v17.Name = "Pointer"
    v17.AnchorPoint = Vector2.new(0.5, 0.5)
    v17.Position = UDim2.new(0.5, 0, 0, 47)
    v17.Size = UDim2.fromOffset(10, 10)
    v17.Rotation = 45
    v17.BackgroundColor3 = v14
    v17.BorderSizePixel = 0
    v17.ZIndex = 1
    v17.Parent = v15
    local v18 = Instance.new("Frame")
    v18.Name = "Ring"
    v18.AnchorPoint = Vector2.new(0.5, 0)
    v18.Position = UDim2.new(0.5, 0, 0, 16)
    v18.Size = UDim2.fromOffset(32, 32)
    v18.BackgroundColor3 = v14
    v18.BorderSizePixel = 0
    v18.ZIndex = 2
    v18.Parent = v15
    local v19 = Instance.new("UICorner")
    v19.CornerRadius = UDim.new(1, 0)
    v19.Parent = v18
    local v20 = Instance.new("ImageLabel")
    v20.Name = "Head"
    v20.AnchorPoint = Vector2.new(0.5, 0.5)
    v20.Position = UDim2.fromScale(0.5, 0.5)
    v20.Size = UDim2.fromOffset(26, 26)
    v20.BackgroundColor3 = v14:Lerp(Color3.new(0, 0, 0), 0.55)
    v20.BorderSizePixel = 0
    v20.ScaleType = Enum.ScaleType.Crop
    v20.Image = not (a1 > 0) and "" or string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", a1)
    v20.ZIndex = 3
    v20.Parent = v18
    local v22 = Instance.new("UICorner")
    v22.CornerRadius = UDim.new(1, 0)
    v22.Parent = v20
    local v23 = Instance.new("TextLabel")
    v23.Name = "Distance"
    v23.BackgroundTransparency = 1
    v23.AnchorPoint = Vector2.new(0.5, 1)
    v23.Position = UDim2.new(0.5, 0, 0, 15)
    v23.Size = UDim2.new(1, 0, 0, 16)
    v23.TextYAlignment = Enum.TextYAlignment.Bottom
    v23.FontFace = u5
    v23.TextSize = 14
    v23.TextColor3 = u4
    v23.TextStrokeColor3 = u3
    v23.TextStrokeTransparency = 0.3
    v23.Text = ""
    v23.AutoLocalize = false
    v23.Parent = v15
    v15.Parent = u9
    local CurrentCamera_2 = workspace.CurrentCamera
    local v24
    if CurrentCamera_2 then
        v24 = CurrentCamera_2.ViewportSize
    else
        v24 = Vector2.new(1600, 900)
    end
    local v25 = math.clamp(math.min(v24.X / 1600, v24.Y / 900), 0.8, 1.2)
    v16.Scale = v25 * 0.5
    local tbl_4 = {}
    tbl_4.Scale = v25
    TweenService_upv_1:Create(v16, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_4):Play()
    local tbl_5 = {}
    tbl_5.position = a2
    tbl_5.frame = v15
    tbl_5.scale = v16
    tbl_5.ring = v18
    tbl_5.pointer = v17
    tbl_5.head = v20
    local v26 = Instance.new("UIStroke")
    v26.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v26.Thickness = 1.5
    v26.Color = u3
    v26.Transparency = 0.35
    v26.Parent = v18
    local v27 = Instance.new("UIStroke")
    v27.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v27.Thickness = 1.5
    v27.Color = u3
    v27.Transparency = 0.35
    v27.Parent = v17
    tbl_5.strokes = {v26, v27}
    tbl_5.label = v23
    tbl_5.born = os.clock()
    tbl_upv_3[a1] = tbl_5
    Sfx_upv_1.PlayUI("Click")
end
local function toMarks(a1, a2)
    --[[
      name: toMarks
      line: 245
      upvalues:
        u9 (ref, index: 1)
    ]]
    local v28 = a1:WorldToScreenPoint(a2)
    local v29
    if u9 then
        v29 = u9.AbsolutePosition
    else
        v29 = Vector2.zero
    end
    return v28.X - v29.X, v28.Y - v29.Y, v28.Z
end
local function place(a1, a2)
    --[[
      name: place
      line: 252
      upvalues:
        u9 (ref, index: 1)
    ]]
    local v30
    if u9 then
        v30 = u9.AbsoluteSize
    else
        v30 = a2.ViewportSize
    end
    local v31 = a2:WorldToScreenPoint(a1.position)
    local v32
    if u9 then
        v32 = u9.AbsolutePosition
    else
        v32 = Vector2.zero
    end
    local v33 = v31.X - v32.X
    local v34 = v31.Y - v32.Y
    if v31.Z <= 0 then
        v33, v34 = v30.X - v33, v30.Y
    end
    local v35 = math.max(44, v30.X - 44)
    local v36 = math.max(98, v30.Y - 44)
    a1.frame.Position = UDim2.fromOffset(math.floor(math.clamp(v33, 44, v35) + 0.5), math.floor(math.clamp(v34, 98, v36) + 0.5))
    a1.frame.Visible = true
    a1.label.Text = tostring(math.floor((a2.CFrame.Position - a1.position).Magnitude + 0.5))
end
local function blocked(a1)
    --[[
      name: blocked
      line: 113
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        GuiService_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
    ]]
    if LocalPlayer_upv_1:GetAttribute("MenuOpen") == true then
        return true
    end
    if not a1 then
        return Util_upv_1.IsMouseUnlocked()
    end
    if GuiService_upv_1.MenuIsOpen then
        return true
    end
    local v37 = Util_upv_1.Camera()
    if not v37 or type(v37.GetUnlockReasons) ~= "function" then
        return false
    end
    local success_1, v38 = pcall(v37.GetUnlockReasons)
    if success_1 and type(v38) == "table" then
        for _, value_2 in v38 do
            if tbl_upv_2[value_2] then
                continue
            end
            return true
        end
    end
    return false
end
local function spectateAim()
    --[[
      name: spectateAim
      line: 274
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_3 = workspace.CurrentCamera
    if not CurrentCamera_3 then
        return nil, nil
    end
    local v39
    if UserInputService_upv_1.MouseBehavior == Enum.MouseBehavior.LockCenter or UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse then
        v39 = Util_upv_1.GetAimRay()
    else
        local v40 = UserInputService_upv_1:GetMouseLocation()
        v39 = CurrentCamera_3:ViewportPointToRay(v40.X, v40.Y)
    end
    local tbl_6 = {}
    local v41, v42 = nil, nil
    for _, value_3 in Util_upv_1.Targets() do
        local v43 = LocalPlayer_upv_1:GetAttribute("MatchId")
        if type(v43) ~= "string" then
            v41 = ""
        else
            v41 = v43
        end
        local v44 = LocalPlayer_upv_1:GetAttribute("Team")
        if v41 ~= "" and value_3:GetAttribute("MatchId") == v41 and v44 ~= nil then
            v42 = ((value_3:GetAttribute("Team") ~= v44) and "enemy") or "ally"
        else
            v42 = nil
        end
        if v42 == "ally" then
            table.insert(tbl_6, value_3)
        end
    end
    local v45 = workspace:Raycast(v39.Origin, v39.Direction.Unit * 600, Util_upv_1.WorldParams(tbl_6))
    if v45 then
        return v45.Position, v45
    end
    return nil, nil
end
local function ping()
    --[[
      name: ping
      line: 301
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u7 (ref,  index: 2)
        blocked (copy, index: 3)
        spectateAim (copy, index: 4)
        Util_upv_1 (copy, index: 5)
        Combat_upv_1 (copy, index: 6)
        show (copy, index: 7)
        u6 (ref,  index: 8)
    ]]
    local v46 = os.clock()
    local v47
    local v50
    if LocalPlayer_upv_1:GetAttribute("Alive") ~= false then
        v50 = LocalPlayer_upv_1.Character
        local v48 = LocalPlayer_upv_1.Character and LocalPlayer_upv_1.Character:FindFirstChildOfClass("Humanoid")
        v47 = not v48 or (v48.Health <= 0)
    else
        v47 = true
    end
    local v49 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(v49) ~= "string" then
        v50 = ""
    else
        v50 = v49
    end
    if v50 == "" or (v46 - u7 < 0.6) then
        return
    end
    if not (blocked(v47)) then
        if v47 then
            local v51, v52 = spectateAim()
            v50, v49 = v51, v52
        else
            local v53, v54 = Util_upv_1.AimPoint(600)
            v50, v49 = v53, v54
        end
        if not v50 then
            return
        end
        v47 = nil
        local v55 = nil
        if v49 then
            v55 = Combat_upv_1.FindCharacter(v49.Instance)
            if v55 then
                local v56 = nil
                if v55 ~= LocalPlayer_upv_1.Character then
                    v56 = LocalPlayer_upv_1:GetAttribute("MatchId")
                    local v57
                    if type(v56) ~= "string" then
                        v57 = ""
                    else
                        v57 = v56
                    end
                    local v58 = LocalPlayer_upv_1:GetAttribute("Team")
                    local v52
                    if v57 ~= "" and v55:GetAttribute("MatchId") == v57 and v58 ~= nil then
                        v52 = ((v55:GetAttribute("Team") ~= v58) and "enemy") or "ally"
                    else
                        v52 = nil
                    end
                    if v52 == "enemy" then
                        v47 = v55
                    end
                end
            end
        end
        u7 = v46
        local UserId_1 = LocalPlayer_upv_1.UserId
        local v58
        if v47 then
            v58 = "enemy"
        else
            v58 = "spot"
        end
        show(UserId_1, v50, v58)
        v49 = workspace.CurrentCamera
        if u6 and v49 then
            u6:FireServer(v50, v47, v49.CFrame.Position)
        end
    end
end
local function refreshButton()
    --[[
      name: refreshButton
      line: 332
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        hasHumanTeammate (copy, index: 2)
        blocked (copy, index: 3)
        u10 (ref,  index: 4)
        UserInputService_upv_1 (copy, index: 5)
        u11 (ref,  index: 6)
        u9 (ref,  index: 7)
    ]]
    local v59
    if LocalPlayer_upv_1:GetAttribute("Alive") ~= false then
        local _ = LocalPlayer_upv_1.Character
        local v60 = LocalPlayer_upv_1.Character and LocalPlayer_upv_1.Character:FindFirstChildOfClass("Humanoid")
        v59 = not v60 or (v60.Health <= 0)
    else
        v59 = true
    end
    local v61 = hasHumanTeammate() and (not blocked(v59))
    if u10 then
        u10.Visible = v61 and (UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch)
    end
    local v62 = u11
    local CurrentCamera_4 = workspace.CurrentCamera
    if not v62 then
        return
    end
    if CurrentCamera_4 then
        v62.Visible = v61 and v59 and LocalPlayer_upv_1:GetAttribute("SpectateMode") == "follow" and UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse
        local v64 = CurrentCamera_4:WorldToScreenPoint(CurrentCamera_4.CFrame.Position + (CurrentCamera_4.CFrame.LookVector * 10))
        local v65
        if u9 then
            v65 = u9.AbsolutePosition
        else
            v65 = Vector2.zero
        end
        v62.Position = UDim2.fromOffset(math.floor((v64.X - v65.X) + 0.5), math.floor((v64.Y - v65.Y) + 0.5))
    end
end
local function buildButton()
    --[[
      name: buildButton
      line: 350
      upvalues:
        u3 (copy, index: 1)
        u4 (copy, index: 2)
        u5 (copy, index: 3)
        ping (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u8 (ref,  index: 6)
        u10 (ref,  index: 7)
        u9 (ref,  index: 8)
        u11 (ref,  index: 9)
    ]]
    local v66 = Instance.new("ScreenGui")
    v66.Name = "TribesPing"
    v66.ResetOnSpawn = false
    v66.IgnoreGuiInset = true
    v66.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    v66.DisplayOrder = 5
    local v67 = Instance.new("TextButton")
    v67.Name = "Ping"
    v67.AnchorPoint = Vector2.new(1, 0.5)
    v67.Position = UDim2.new(1, -22, 0.3, 0)
    v67.Size = UDim2.fromOffset(48, 48)
    v67.BackgroundColor3 = u3
    v67.BackgroundTransparency = 0.3
    v67.AutoButtonColor = false
    v67.Text = "PING"
    v67.TextColor3 = u4
    v67.TextSize = 12
    v67.FontFace = u5
    v67.Visible = false
    local v68 = Instance.new("UICorner")
    v68.CornerRadius = UDim.new(1, 0)
    v68.Parent = v67
    local v69 = Instance.new("UIStroke")
    v69.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v69.Thickness = 2
    v69.Color = u4
    v69.Transparency = 0.8
    v69.Parent = v67
    v67.InputBegan:Connect(
        function(a1)
            --[[
              line: 379
              upvalues:
                ping (copy, index: 1)
            ]]
            if a1.UserInputType ~= Enum.UserInputType.Touch and a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            ping()
        end
    )
    v67.Parent = v66
    v66.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    u8 = v66
    u10 = v67
    local v70 = Instance.new("ScreenGui")
    v70.Name = "TribesPingMarks"
    v70.ResetOnSpawn = false
    v70.IgnoreGuiInset = true
    v70.ScreenInsets = Enum.ScreenInsets.None
    v70.DisplayOrder = 4
    v70.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    u9 = v70
    local v71 = Instance.new("Frame")
    v71.Name = "SpectateAim"
    v71.AnchorPoint = Vector2.new(0.5, 0.5)
    v71.Position = UDim2.fromScale(0.5, 0.5)
    v71.Size = UDim2.fromOffset(6, 6)
    v71.BackgroundColor3 = u4
    v71.BackgroundTransparency = 0.25
    v71.BorderSizePixel = 0
    v71.Visible = false
    local v72 = Instance.new("UICorner")
    v72.CornerRadius = UDim.new(1, 0)
    v72.Parent = v71
    local v73 = Instance.new("UIStroke")
    v73.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v73.Thickness = 1
    v73.Color = u3
    v73.Transparency = 0.35
    v73.Parent = v71
    v71.Parent = v70
    u11 = v71
end
function tbl_1.Start()
    --[[
      name: Start
      line: 413
      upvalues:
        u6 (ref,  index: 1)
        Net_upv_1 (copy, index: 2)
        buildButton (copy, index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        show (copy, index: 5)
        Keybinds_upv_1 (copy, index: 6)
        ping (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
        refreshButton (copy, index: 9)
        tbl_upv_3 (copy, index: 10)
        place (copy, index: 11)
    ]]
    u6 = Net_upv_1.Event("Ping")
    buildButton()
    u6.OnClientEvent:Connect(
        function(a1, a2, a3)
            --[[
              line: 416
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                show (copy, index: 2)
            ]]
            if type(a1) ~= "number" then
                return
            end
            if typeof(a2) == "Vector3" then
                local v74 = LocalPlayer_upv_1:GetAttribute("MatchId")
                local v75
                if type(v74) ~= "string" then
                    v75 = ""
                else
                    v75 = v74
                end
                if v75 == "" then
                    return
                end
                show(a1, a2, ((a3 ~= "enemy") and "spot") or "enemy")
            end
        end
    )
    Keybinds_upv_1.OnInput(
        "Began",
        function(a4, a5)
            --[[
              line: 421
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                ping (copy, index: 2)
            ]]
            if a5 then
                return
            end
            if Keybinds_upv_1.ActionOf(a4) == "Ping" or Keybinds_upv_1.IsPad(a4, "Ping") and not (Keybinds_upv_1.PadBlocked()) then
                ping()
            end
        end
    )
    local u12 = 0
    RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 431
              upvalues:
                u12 (ref,  index: 1)
                refreshButton (copy, index: 2)
                LocalPlayer_upv_1 (copy, index: 3)
                tbl_upv_3 (copy, index: 4)
                place (copy, index: 5)
            ]]
            local v76 = os.clock()
            local v77 = nil
            if u12 <= v76 then
                u12 = v76 + 0.25
                refreshButton()
                v77 = LocalPlayer_upv_1:GetAttribute("MatchId")
                local v78
                if type(v77) ~= "string" then
                    v78 = ""
                else
                    v78 = v77
                end
                if v78 == "" then
                    for key_1 in tbl_upv_3 do
                        local v79 = tbl_upv_3[key_1]
                        if v79 then
                            tbl_upv_3[key_1] = nil
                            v79.frame:Destroy()
                        end
                    end
                end
            end
            local CurrentCamera_5 = workspace.CurrentCamera
            for key_2, value_4 in tbl_upv_3 do
                local v80 = v76 - value_4.born
                if v80 >= 6 then
                    local v81 = tbl_upv_3[key_2]
                    if v81 then
                        tbl_upv_3[key_2] = nil
                        v81.frame:Destroy()
                    end
                else
                    local v82 = math.clamp((v80 - 5) / 1, 0, 1)
                    value_4.ring.BackgroundTransparency = v82
                    value_4.pointer.BackgroundTransparency = v82
                    value_4.head.BackgroundTransparency = v82
                    value_4.head.ImageTransparency = v82
                    for _, value_5 in value_4.strokes do
                        value_5.Transparency = (v82 * 0.65) + 0.35
                    end
                    value_4.label.TextTransparency = v82
                    value_4.label.TextStrokeTransparency = (v82 * 0.7) + 0.3
                    if CurrentCamera_5 then
                        place(value_4, CurrentCamera_5)
                    end
                end
            end
        end
    )
end
return tbl_1