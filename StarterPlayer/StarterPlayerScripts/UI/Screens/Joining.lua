local Players_upv_1 = game:GetService("Players")
local TeleportService_upv_1 = game:GetService("TeleportService")
local tbl_1 = {}
local function teleportGui(a1, a2)
    --[[
      name: teleportGui
      line: 21
    ]]
    local v1 = Instance.new("ScreenGui")
    v1.Name = "TR_Teleport"
    v1.IgnoreGuiInset = true
    v1.DisplayOrder = 100
    local v2 = Instance.new("Frame")
    v2.Size = UDim2.fromScale(1, 1)
    v2.BackgroundColor3 = Color3.fromRGB(10, 11, 15)
    v2.BorderSizePixel = 0
    v2.Parent = v1
    local v3 = Instance.new("TextLabel")
    v3.AnchorPoint = Vector2.new(0.5, 0.5)
    v3.Position = UDim2.fromScale(0.5, 0.46)
    v3.Size = UDim2.fromScale(0.8, 0.09)
    v3.BackgroundTransparency = 1
    v3.Text = a1
    v3.TextScaled = true
    v3.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
    v3.TextColor3 = Color3.new(1, 1, 1)
    v3.Parent = v2
    local v4 = Instance.new("TextLabel")
    v4.AnchorPoint = Vector2.new(0.5, 0)
    v4.Position = UDim2.fromScale(0.5, 0.53)
    v4.Size = UDim2.fromScale(0.8, 0.035)
    v4.BackgroundTransparency = 1
    v4.Text = a2
    v4.TextScaled = true
    v4.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
    v4.TextColor3 = Color3.fromRGB(186, 192, 206)
    v4.Parent = v2
    local v5 = Instance.new("Frame")
    v5.AnchorPoint = Vector2.new(0.5, 0)
    v5.Position = UDim2.fromScale(0.5, 0.6)
    v5.Size = UDim2.new(0.12, 0, 0, 4)
    v5.BackgroundColor3 = Color3.fromRGB(40, 150, 255)
    v5.BorderSizePixel = 0
    local v6 = Instance.new("UICorner")
    v6.CornerRadius = UDim.new(1, 0)
    v6.Parent = v5
    v5.Parent = v2
    return v1
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 64
      upvalues:
        Players_upv_1 (copy, index: 1)
        TeleportService_upv_1 (copy, index: 2)
        teleportGui (copy, index: 3)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_1 = Theme_1.Colors
    local Fonts_1 = Theme_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = {}
    u1.Name = "Joining"
    u1.AnchorPoint = Vector2.new(0.5, 0)
    u1.Position = UDim2.new(0.5, 0, 0, 12)
    u1.Size = UDim2.fromOffset(340, 62)
    u1.BackgroundColor3 = Colors_1.Panel
    u1.BackgroundTransparency = 0.08
    u1.Visible = false
    u1.Active = false
    u1[1], u1[2] = UI_upv_1.Corner(Theme_1.Radius.Pill), UI_upv_1.Stroke(Colors_1.Stroke, 1, 0.85)
    u1.Parent = a1.Canvas.Top
    local u2 = UI_upv_1.new("Frame", u1)
    local u3 = UI_upv_1.new("TextLabel", {Text = "JOINING MATCH", Name = "Title", BackgroundTransparency = 1, TextSize = 22, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 9), Size = UDim2.new(1, -40, 0, 24), FontFace = Fonts_1.Display, TextColor3 = Colors_1.Text, Parent = u2})
    u1 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", BackgroundTransparency = 1, TextSize = 14, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 33), Size = UDim2.new(1, -40, 0, 16), FontFace = Fonts_1.SemiBold, TextColor3 = Colors_1.TextDim, Parent = u2})
    local v7 = UI_upv_1.new("Frame", {Name = "Scan", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -6), Size = UDim2.new(1, -64, 0, 3), BackgroundColor3 = Colors_1.Raised, ClipsDescendants = true, [1] = UI_upv_1.Corner(Theme_1.Radius.Pill), Parent = u2})
    local u4 = UI_upv_1.new("Frame", {Name = "Bar", Size = UDim2.fromScale(0.35, 1), Position = UDim2.fromScale(-0.35, 0), BackgroundColor3 = Colors_1.Accent, [1] = UI_upv_1.Corner(Theme_1.Radius.Pill), Parent = v7})
    local v8 = UI_upv_1.TopInset()
    u2.Position = UDim2.new(0.5, 0, 0, v8 + (((UI_upv_1.Compact) and 6) or 12))
    local function place()
        --[[
          name: place
          line: 125
          upvalues:
            u2 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v9 = UI_upv_1.TopInset()
        u2.Position = UDim2.new(0.5, 0, 0, v9 + (((UI_upv_1.Compact) and 6) or 12))
    end
    UI_upv_1.LayoutChanged:Connect(place)
    local u5 = nil
    local u6 = nil
    local u7 = false
    local u8 = 0
    local function want()
        --[[
          name: want
          line: 136
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u7 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
        ]]
        if LocalPlayer_upv_1:GetAttribute("Teleporting") ~= true then
            if LocalPlayer_upv_1:GetAttribute("MMJoining") == true and not (State_upv_1.InMatch()) then
                return "wait", "JOINING MATCH", "Waiting for the other players..."
            end
            return nil, "", ""
        end
        if u7 then
            return nil, "", ""
        elseif LocalPlayer_upv_1:GetAttribute("TeleportKind") ~= "Lobby" then
            if LocalPlayer_upv_1:GetAttribute("TeleportKind") ~= "Party" then
                if LocalPlayer_upv_1:GetAttribute("TeleportKind") ~= "CustomCreate" then
                    if LocalPlayer_upv_1:GetAttribute("TeleportKind") ~= "Custom" then
                        return "match", "JOINING MATCH", "Heading to the arena..."
                    end
                    return "custom", "JOINING CUSTOM MATCH", "Heading to the host's server..."
                end
                return "custom", "CREATING YOUR MATCH", "Setting up your server..."
            end
            return "party", "JOINING YOUR FRIEND", "Heading to their lobby..."
        else
            return "lobby", "RETURNING TO LOBBY", "Taking you back to the lobby..."
        end
    end
    local function refresh()
        --[[
          name: refresh
          line: 159
          upvalues:
            want (copy, index: 1)
            u6 (ref,  index: 2)
            u8 (ref,  index: 3)
            u3 (copy, index: 4)
            u1 (copy, index: 5)
            u2 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u5 (ref,  index: 8)
            u4 (copy, index: 9)
            TeleportService_upv_1 (copy, index: 10)
            teleportGui (copy, index: 11)
        ]]
        local v10, u9, u10 = want()
        if v10 == u6 then
            return
        end
        u6 = v10
        if v10 then
            u8 = os.clock()
            u3.Text = u9
            u1.Text = u10
            if not (u2.Visible) then
                u2.Visible = true
                UI_upv_1.Enter(u2, Vector2.new(0, -12))
            end
            if not (u5) then
                u4.Position = UDim2.fromScale(-0.35, 0)
                local v11 = game:GetService("TweenService"):Create(u4, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {Position = UDim2.fromScale(1, 0)})
                u5 = v11
                u5:Play()
            end
            if v10 ~= "wait" then
                pcall(
                    function()
                        --[[
                          line: 179
                          upvalues:
                            TeleportService_upv_1 (copy, index: 1)
                            teleportGui (copy, index: 2)
                            u9 (copy, index: 3)
                            u10 (copy, index: 4)
                        ]]
                        TeleportService_upv_1:SetTeleportGui((teleportGui(u9, u10)))
                    end
                )
                return
            end
        else
            u2.Visible = false
            if u5 then
                u5:Cancel()
                u5 = nil
            end
        end
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal("Teleporting"):Connect(
        function()
            --[[
              line: 192
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u7 (ref,  index: 2)
            ]]
            if LocalPlayer_upv_1:GetAttribute("Teleporting") == true then
                return
            end
            u7 = false
        end
    )
    TeleportService_upv_1.TeleportInitFailed:Connect(
        function(a2, a3)
            --[[
              line: 198
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u6 (ref,  index: 2)
                u7 (ref,  index: 3)
                a1 (copy, index: 4)
                refresh (copy, index: 5)
            ]]
            if a2 ~= LocalPlayer_upv_1 or a3 == Enum.TeleportResult.IsTeleporting then
                return
            end
            if u6 and u6 ~= "wait" and not (u7) then
                u7 = true
                a1.Toast(((u6 ~= "custom") and "Couldn't reach the match server. You can keep playing here.") or "Couldn't reach that server. You can keep playing here.", "warning")
                refresh()
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 209
              upvalues:
                u6 (ref,  index: 1)
                u8 (ref,  index: 2)
                u7 (ref,  index: 3)
                refresh (copy, index: 4)
            ]]
            repeat
                task.wait(1)
            until u6
            if u6 == "wait" or not (os.clock() - u8 > 32) then
                return
            end
            u7 = true
            refresh()
        end
    )
    for _, value_1 in {"Teleporting", "TeleportKind", "MMJoining"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_1):Connect(refresh)
    end
    State_upv_1.PlayerStateChanged:Connect(refresh)
    refresh()
    a1.Debug.joining = function(a4)
        --[[
          line: 225
          upvalues:
            State_upv_1 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            refresh (copy, index: 3)
            u6 (ref,  index: 4)
        ]]
        if State_upv_1.Mock or a4 then
            if a4 == "match" or a4 == "lobby" then
                LocalPlayer_upv_1:SetAttribute("TeleportKind", ((a4 ~= "lobby") and "Match") or "Lobby")
                LocalPlayer_upv_1:SetAttribute("Teleporting", true)
            elseif a4 ~= "wait" then
                LocalPlayer_upv_1:SetAttribute("Teleporting", nil)
                LocalPlayer_upv_1:SetAttribute("MMJoining", nil)
            else
                LocalPlayer_upv_1:SetAttribute("MMJoining", true)
            end
        end
        refresh()
        local tbl_2 = {}
        tbl_2.shown = u6 or false
        return tbl_2
    end
end
return tbl_1