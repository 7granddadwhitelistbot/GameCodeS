local ProximityPromptService_upv_1 = game:GetService("ProximityPromptService")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local function easeOutBack(a1)
    --[[
      name: easeOutBack
      line: 34
    ]]
    return ((((a1 - 1) ^ 3) * 2.70158) + 1) + (((a1 - 1) ^ 2) * 1.70158)
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 39
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        ProximityPromptService_upv_1 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
    ]]
    local UI_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local resolve = Theme_1.Colors
    local Custom_upv_1 = a1.Custom
    local fromOffset_1 = UDim2.fromOffset
    local u1 = string.format("#%02X%02X%02X", math.floor((resolve.TextDim.R * 255) + 0.5), math.floor((resolve.TextDim.G * 255) + 0.5), math.floor((resolve.TextDim.B * 255) + 0.5))
    local u2 = UI_1.new("BillboardGui", {Enabled = false, Active = false, ResetOnSpawn = false, LightInfluence = 0, MaxDistance = 170, Name = "TR_CustomLive", ClipsDescendants = false, Brightness = 1, AlwaysOnTop = false, Size = fromOffset_1(320, 180), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a1.PlayerGui})
    local tbl_upv_2 = {}
    tbl_upv_2.Name = "Pill"
    tbl_upv_2.AnchorPoint = Vector2.new(0.5, 1)
    tbl_upv_2.Position = UDim2.new(0.5, 0, 0.5, -6)
    tbl_upv_2.Size = fromOffset_1(0, 30)
    tbl_upv_2.AutomaticSize = Enum.AutomaticSize.X
    tbl_upv_2.BackgroundColor3 = resolve.Void
    tbl_upv_2.BackgroundTransparency = 0.3
    tbl_upv_2[1], tbl_upv_2[2], tbl_upv_2[3] = UI_1.Corner(Theme_1.Radius.Pill), UI_1.Padding(0, 13, 0, 11), UI_1.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    tbl_upv_2.Parent = u2
    local u3 = UI_1.new("Frame", tbl_upv_2)
    local u4 = UI_1.new("UIStroke", {Thickness = 1.5, Transparency = 0.55, Name = "Rim", Color = resolve.Success, Parent = u3})
    local tbl_3 = {}
    tbl_3.Name = "Dot"
    tbl_3.Size = fromOffset_1(9, 9)
    tbl_3.BackgroundColor3 = resolve.Success
    tbl_3.LayoutOrder = 1
    tbl_3[1] = UI_1.Corner(Theme_1.Radius.Pill)
    tbl_3.Parent = u3
    tbl_upv_2 = UI_1.new("Frame", tbl_3)
    local u5 = UI_1.new("TextLabel", {LayoutOrder = 2, RichText = true, Text = "", Name = "Label", TextSize = 17, Size = fromOffset_1(0, 30), AutomaticSize = Enum.AutomaticSize.X, FontFace = Theme_1.Fonts.Heavy, TextColor3 = resolve.Text, Parent = u3})
    local u6 = UI_1.new("UIScale", {Name = "Fit", Parent = u3})
    local PrimaryPart_upv_1 = nil
    local u7 = Vector3.new(0, 0, 0)
    local u8 = nil
    local ObjectText_upv_1 = nil
    local function pavilion()
        --[[
          name: pavilion
          line: 103
          upvalues:
            Workspace_upv_1 (copy, index: 1)
        ]]
        local Lobby_1 = Workspace_upv_1:FindFirstChild("Lobby")
        local v1 = Lobby_1 and (Lobby_1:FindFirstChild("CustomMatches"))
        return v1
    end
    resolve = function()
        --[[
          name: resolve
          line: 108
          upvalues:
            PrimaryPart_upv_1 (ref,  index: 1)
            Workspace_upv_1 (copy, index: 2)
            u7 (ref,  index: 3)
            u2 (copy, index: 4)
        ]]
        if PrimaryPart_upv_1 and PrimaryPart_upv_1:IsDescendantOf(Workspace_upv_1) then
            return
        end
        PrimaryPart_upv_1 = nil
        local Lobby_2 = Workspace_upv_1:FindFirstChild("Lobby")
        local v2 = Lobby_2 and (Lobby_2:FindFirstChild("CustomMatches"))
        if not v2 then
            return
        end
        local SignBoard_1 = v2:FindFirstChild("SignBoard")
        if (SignBoard_1) and (SignBoard_1:IsA("BasePart")) then
            PrimaryPart_upv_1 = SignBoard_1
            u7 = Vector3.new(0, SignBoard_1.Size.Y / 2 + 0.13 + 0.55, 0)
        elseif v2:IsA("Model") and v2.PrimaryPart then
            local v3, v4 = v2:GetBoundingBox()
            PrimaryPart_upv_1 = v2.PrimaryPart
            u7 = Vector3.new(0, ((v3.Position.Y + (v4.Y / 2)) + 0.55) - v2.PrimaryPart.Position.Y, 0)
        end
        u2.Adornee = PrimaryPart_upv_1
        u2.StudsOffsetWorldSpace = u7
    end
    local u9 = 0
    local u10 = false
    local u11 = 0
    local u12 = -math.huge
    local u13 = 1
    local function liveCount()
        --[[
          name: liveCount
          line: 139
          upvalues:
            Workspace_upv_1 (copy, index: 1)
        ]]
        local v5 = Workspace_upv_1:GetAttribute("CustomLive")
        if type(v5) == "number" and v5 > 0 then
            return (math.floor(v5))
        end
        return 0
    end
    local function paintPrompt()
        --[[
          name: paintPrompt
          line: 144
          upvalues:
            u8 (ref,  index: 1)
            Workspace_upv_1 (copy, index: 2)
            ObjectText_upv_1 (ref,  index: 3)
            Custom_upv_1 (copy, index: 4)
            u9 (ref,  index: 5)
        ]]
        local v6 = u8
        if not (v6) or not (v6:IsDescendantOf(Workspace_upv_1)) then
            local Lobby_3 = Workspace_upv_1:FindFirstChild("Lobby")
            local v7 = Lobby_3 and (Lobby_3:FindFirstChild("CustomMatches"))
            local v8 = v7 and (v7:FindFirstChild("CustomMatchesPrompt", true))
            local v9 = nil
            if not (v8) or not (v8:IsA("ProximityPrompt")) then
                local v10 = nil
                v9, v6 = v10, v10
            end
            u8 = v9
        end
        if not v6 then
            return
        end
        if ObjectText_upv_1 == nil then
            ObjectText_upv_1 = v6.ObjectText
        end
        local v11 = ((Custom_upv_1.IsServer()) and 0) or u9
        local v12
        if v11 == 1 then
            v12 = "1 match live"
        elseif v11 > 1 then
            v12 = ("%* matches live"):format(v11)
        else
            v12 = ObjectText_upv_1 or ""
        end
        if v6.ObjectText == v12 then
            return
        end
        v6.ObjectText = v12
    end
    local function refresh()
        --[[
          name: refresh
          line: 165
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            u9 (ref,  index: 2)
            u5 (copy, index: 3)
            u1 (copy, index: 4)
            u11 (ref,  index: 5)
            u12 (ref,  index: 6)
            u13 (ref,  index: 7)
            paintPrompt (copy, index: 8)
            PrimaryPart_upv_1 (ref,  index: 9)
            State_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            Custom_upv_1 (copy, index: 12)
            u10 (ref,  index: 13)
        ]]
        local v13 = Workspace_upv_1:GetAttribute("CustomLive")
        local v14
        if type(v13) == "number" and (v13 > 0) then
            v14 = math.floor(v13)
        else
            v14 = 0
        end
        if v14 ~= u9 then
            local v15 = u9
            u9 = v14
            if v14 > 0 then
                u5.Text = ("%* <font color=\"%*\">LIVE</font>"):format(v14, u1)
                if v15 > 0 and u11 > 0.5 then
                    u12 = os.clock()
                    u13 = 0.86
                end
            end
            paintPrompt()
        end
        v14 = (u9 > 0) and ((PrimaryPart_upv_1 ~= nil) and (not State_upv_1.InMatch() and (not a1.HudHidden and (not Custom_upv_1.IsServer()))))
        if v14 and not (u10) and u11 < 0.05 then
            u12 = os.clock()
            u13 = 0.6
        end
        u10 = v14
    end
    Workspace_upv_1:GetAttributeChangedSignal("CustomLive"):Connect(refresh)
    Workspace_upv_1:GetAttributeChangedSignal("CustomServer"):Connect(
        function()
            --[[
              line: 186
              upvalues:
                refresh (copy, index: 1)
                paintPrompt (copy, index: 2)
            ]]
            refresh()
            paintPrompt()
        end
    )
    State_upv_1.PlayerStateChanged:Connect(refresh)
    a1.HudHiddenChanged:Connect(refresh)
    Custom_upv_1.Changed:Connect(refresh)
    ProximityPromptService_upv_1.PromptShown:Connect(
        function(a2)
            --[[
              line: 193
              upvalues:
                u8 (ref,  index: 1)
                paintPrompt (copy, index: 2)
            ]]
            if a2.Name ~= "CustomMatchesPrompt" then
                return
            end
            u8 = a2
            paintPrompt()
        end
    )
    UI_1.Every(
        u2,
        1,
        function()
            --[[
              line: 200
              upvalues:
                PrimaryPart_upv_1 (ref,  index: 1)
                Workspace_upv_1 (copy, index: 2)
                resolve (copy, index: 3)
                refresh (copy, index: 4)
                paintPrompt (copy, index: 5)
            ]]
            if (PrimaryPart_upv_1) and (PrimaryPart_upv_1:IsDescendantOf(Workspace_upv_1)) then
                return
            end
            resolve()
            refresh()
            paintPrompt()
        end
    )
    resolve()
    refresh()
    paintPrompt()
    local PlayerGui_upv_1 = a1.PlayerGui
    local tbl_upv_4 = {0.25, 0.75}
    local tbl_upv_5 = {-0.4, 0, 0.4}
    local function isPanel(a3, a4)
        --[[
          name: isPanel
          line: 217
          upvalues:
            u2 (copy, index: 1)
        ]]
        if a3:IsDescendantOf(u2) then
            return false
        end
        local AbsoluteSize_1 = a3.AbsoluteSize
        if a4.X * 0.7 <= AbsoluteSize_1.X and a4.Y * 0.7 <= AbsoluteSize_1.Y or not (a3.BackgroundTransparency < 0.6) and (not (a3:IsA("ImageLabel")) and not (a3:IsA("ImageButton")) or a3.Image == "" or not (a3.ImageTransparency < 0.6)) then
            return false
        end
        return true
    end
    local function coveredAt(a5, a6, a7)
        --[[
          name: coveredAt
          line: 233
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
            isPanel (copy, index: 2)
        ]]
        for _, value_1 in PlayerGui_upv_1:GetGuiObjectsAtPosition(a5, a6) do
            if not (isPanel(value_1, a7)) then
                continue
            end
            return true
        end
        return false
    end
    local function hudCovers(a8, a9)
        --[[
          name: hudCovers
          line: 241
          upvalues:
            u7 (ref,  index: 1)
            u3 (copy, index: 2)
            tbl_upv_4 (copy, index: 3)
            tbl_upv_5 (copy, index: 4)
            PlayerGui_upv_1 (copy, index: 5)
            isPanel (copy, index: 6)
        ]]
        local v16, v17 = a8:WorldToScreenPoint(a9.Position + u7)
        if not v17 then
            return false
        end
        local X_1 = u3.AbsoluteSize.X
        local Y_1 = u3.AbsoluteSize.Y
        local ViewportSize_1 = a8.ViewportSize
        local v18 = nil
        for _, value_2 in tbl_upv_4 do
            for v19, value_3 in tbl_upv_5 do
                for v20, value_4 in PlayerGui_upv_1:GetGuiObjectsAtPosition(v16.X + (X_1 * value_3), (v16.Y + u3.Position.Y.Offset) - (Y_1 * (1 - value_2))) do
                    if isPanel(value_4, ViewportSize_1) then
                        v18 = true
                    else
                        continue
                    end
                end
                if not (v18) then
                    continue
                end
                return true
            end
        end
        return false
    end
    local u14 = -1
    local u15 = -1
    local u16 = 1
    local u17 = false
    local u18 = -math.huge
    local u19 = math.huge
    RunService_upv_1.RenderStepped:Connect(
        function(a10)
            --[[
              line: 266
              upvalues:
                u10 (ref,  index: 1)
                u11 (ref,  index: 2)
                u2 (copy, index: 3)
                Workspace_upv_1 (copy, index: 4)
                PrimaryPart_upv_1 (ref,  index: 5)
                u7 (ref,  index: 6)
                u18 (ref,  index: 7)
                hudCovers (copy, index: 8)
                u17 (ref,  index: 9)
                u19 (ref,  index: 10)
                u16 (ref,  index: 11)
                u12 (ref,  index: 12)
                u13 (ref,  index: 13)
                u14 (ref,  index: 14)
                u6 (copy, index: 15)
                u15 (ref,  index: 16)
                u3 (copy, index: 17)
                u4 (copy, index: 18)
                u5 (copy, index: 19)
                tbl_upv_2 (copy, index: 20)
            ]]
            if not (u10) and u11 <= 0 then
                if u2.Enabled then
                    u2.Enabled = false
                end
                return
            end
            local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
            local v19 = PrimaryPart_upv_1
            if CurrentCamera_1 and v19 then
                local v20 = (u10 and (a10 / 0.25)) or (-a10 / 0.3)
                u11 = math.clamp(u11 + v20, 0, 1)
                local v21 = (PrimaryPart_upv_1.Position + u7 - CurrentCamera_1.CFrame.Position).Magnitude
                local v22 = math.clamp((170 - v21) / 25, 0, 1)
                local v23 = os.clock()
                if u11 * v22 > 0 and v23 - u18 >= 0.12 then
                    u18 = v23
                    if hudCovers(CurrentCamera_1, PrimaryPart_upv_1) then
                        u17 = true
                        u19 = math.huge
                    elseif u17 then
                        u19 = math.min(u19, v23)
                        if v23 - u19 >= 0.3 then
                            u17 = false
                        end
                    end
                end
                local v24 = (u17 and (-a10 / 0.15)) or (a10 / 0.25)
                u16 = math.clamp(u16 + v24, 0, 1)
                local v25 = u11 * v22 * u16
                u2.Enabled = v25 > 0
                if v25 <= 0 then
                    return
                end
                local v26 = math.clamp(CurrentCamera_1.ViewportSize.Y / 1080, 0.72, 1.3)
                local v27 = math.min((300 / math.max(v21, 1)) + 22, 44) * v26 / 30
                local v28 = os.clock() - u12
                if v28 < 0.45 then
                    local _ = v28 / 0.45
                    v21 = v27 * (u13 + (1 - u13) * ((v28 / 0.45 - 1) ^ 3 * 2.70158 + 1 + (v28 / 0.45 - 1) ^ 2 * 1.70158))
                else
                    v21 = v27
                end
                local v29 = math.floor((v21 * 200) + 0.5) / 200
                if v29 ~= u14 then
                    u14 = v29
                    u6.Scale = v29
                end
                local v30 = math.floor((v26 * 6) + 0.5)
                if v30 ~= u15 then
                    u15 = v30
                    u3.Position = UDim2.new(0.5, 0, 0.5, -v30)
                end
                local v31 = (0.5 - (math.cos(os.clock() * 2.6179938779914944) * 0.5)) * 0.55
                u3.BackgroundTransparency = 1 - (v25 * 0.7)
                u4.Transparency = 1 - (v25 * 0.45)
                u5.TextTransparency = 1 - v25
                tbl_upv_2.BackgroundTransparency = 1 - (v25 * (1 - v31))
                return
            end
            u11 = 0
            u2.Enabled = false
        end
    )
    a1.Debug.customLive = function()
        --[[
          line: 329
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            u9 (ref,  index: 2)
            u10 (ref,  index: 3)
            u11 (ref,  index: 4)
            u17 (ref,  index: 5)
            u16 (ref,  index: 6)
            u2 (copy, index: 7)
            PrimaryPart_upv_1 (ref,  index: 8)
            u8 (ref,  index: 9)
            u6 (copy, index: 10)
            u3 (copy, index: 11)
            u7 (ref,  index: 12)
        ]]
        local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
        local tbl_6 = {dist = 0, adornee = 0, text = 0, scale = 0, prompt = 0, pillPx = 0}
        tbl_6.count = u9
        tbl_6.attr = Workspace_upv_1:GetAttribute("CustomLive") or false
        tbl_6.players = Workspace_upv_1:GetAttribute("CustomLivePlayers") or false
        tbl_6.target = u10
        tbl_6.alpha = math.floor((u11 * 100) + 0.5) / 100
        tbl_6.covered = u17
        tbl_6.cover = math.floor((u16 * 100) + 0.5) / 100
        tbl_6.enabled = u2.Enabled
        tbl_6.text = not (u9 > 0) and "" or ("%* LIVE"):format(u9)
        local v33
        if PrimaryPart_upv_1 then
            v33 = PrimaryPart_upv_1:GetFullName()
        else
            v33 = false
        end
        tbl_6.adornee = v33
        local v34
        if u8 then
            v34 = u8.ObjectText
        else
            v34 = false
        end
        tbl_6.prompt = v34
        tbl_6.scale = math.floor((u6.Scale * 100) + 0.5) / 100
        tbl_6.pillPx = {math.floor(u3.AbsoluteSize.X), math.floor(u3.AbsoluteSize.Y)}
        if (PrimaryPart_upv_1) and (CurrentCamera_2) then
            v34 = math.floor((PrimaryPart_upv_1.Position + u7 - CurrentCamera_2.CFrame.Position).Magnitude)
        else
            v34 = false
        end
        tbl_6.dist = v34
        return tbl_6
    end
end
return tbl_1