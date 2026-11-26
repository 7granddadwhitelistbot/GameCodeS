local players = game:GetService("Players")
local teleportService = game:GetService("TeleportService")
local v3 = {}

local function teleportGui(text, text2)
    --[[
      name: teleportGui
      line: 21
    ]]
    local trTeleport = Instance.new("ScreenGui")
    trTeleport.Name = "TR_Teleport"
    trTeleport.IgnoreGuiInset = true
    trTeleport.DisplayOrder = 100

    local parent = Instance.new("Frame")
    parent.Size = UDim2.fromScale(1, 1)
    parent.BackgroundColor3 = Color3.fromRGB(10, 11, 15)
    parent.BorderSizePixel = 0
    parent.Parent = trTeleport

    local textLabel = Instance.new("TextLabel")
    textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    textLabel.Position = UDim2.fromScale(0.5, 0.46)
    textLabel.Size = UDim2.fromScale(0.8, 0.09)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextScaled = true
    textLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Parent = parent

    local textLabel2 = Instance.new("TextLabel")
    textLabel2.AnchorPoint = Vector2.new(0.5, 0)
    textLabel2.Position = UDim2.fromScale(0.5, 0.53)
    textLabel2.Size = UDim2.fromScale(0.8, 0.035)
    textLabel2.BackgroundTransparency = 1
    textLabel2.Text = text2
    textLabel2.TextScaled = true
    textLabel2.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
    textLabel2.TextColor3 = Color3.fromRGB(186, 192, 206)
    textLabel2.Parent = parent

    local parent2 = Instance.new("Frame")
    parent2.AnchorPoint = Vector2.new(0.5, 0)
    parent2.Position = UDim2.fromScale(0.5, 0.6)
    parent2.Size = UDim2.new(0.12, 0, 0, 4)
    parent2.BackgroundColor3 = Color3.fromRGB(40, 150, 255)
    parent2.BorderSizePixel = 0

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent2
    parent2.Parent = parent

    return trTeleport
end

function v3.Init(a13)
    --[[
      name: Init
      line: 64
      upvalues:
        players (copy, index: 1)
        teleportService (copy, index: 2)
        teleportGui (copy, index: 3)
    ]]
    local ui = a13.UI
    local theme = a13.Theme
    local state = a13.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local localPlayer = players.LocalPlayer
    local parent = ui.new("Frame", {Name = "Joining", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 12), Size = UDim2.fromOffset(340, 62), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.08, Visible = false, Active = false, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1, 0.85)), Parent = a13.Canvas.Top})
    local ui2 = ui.new("TextLabel", {Name = "Title", Text = "JOINING MATCH", TextSize = 22, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 9), Size = UDim2.new(1, -40, 0, 24), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent})
    local ui3 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 14, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 33), Size = UDim2.new(1, -40, 0, 16), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, Parent = parent})
    local parent2 = ui.new("Frame", {Name = "Scan", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -6), Size = UDim2.new(1, -64, 0, 3), BackgroundColor3 = colors.Raised, ClipsDescendants = true, (ui.Corner(theme.Radius.Pill)), Parent = parent})
    local instance = ui.new("Frame", {Name = "Bar", Size = UDim2.fromScale(0.35, 1), Position = UDim2.fromScale(-0.35, 0), BackgroundColor3 = colors.Accent, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
    local newUDim2 = UDim2.new
    local v26 = ui.TopInset()
    local v27 = ui.Compact and 6 or 12
    parent.Position = newUDim2(0.5, 0, 0, v26 + v27)

    ui.LayoutChanged:Connect(
        function()
            --[[
              name: place
              line: 125
              upvalues:
                parent (copy, index: 1)
                ui (copy, index: 2)
            ]]
            local newUDim2 = UDim2.new
            local v29 = ui.TopInset()
            local v30 = ui.Compact and 6 or 12
            parent.Position = newUDim2(0.5, 0, 0, v29 + v30)
        end
    )

    local tween = nil
    local v32 = nil
    local v33 = false
    local timestamp = 0

    local function want()
        --[[
          name: want
          line: 136
          upvalues:
            localPlayer (copy, index: 1)
            v33 (ref,  index: 2)
            state (copy, index: 3)
        ]]
        if localPlayer:GetAttribute("Teleporting") ~= true then
            if localPlayer:GetAttribute("MMJoining") == true and not state.InMatch() then
                return "wait", "JOINING MATCH", "Waiting for the other players..."
            end

            return nil, "", ""
        end

        if v33 then
            return nil, "", ""
        end
        if localPlayer:GetAttribute("TeleportKind") == "Lobby" then
            return "lobby", "RETURNING TO LOBBY", "Taking you back to the lobby..."
        end
        if localPlayer:GetAttribute("TeleportKind") == "Party" then
            return "party", "JOINING YOUR FRIEND", "Heading to their lobby..."
        end
        if localPlayer:GetAttribute("TeleportKind") == "CustomCreate" then
            return "custom", "CREATING YOUR MATCH", "Setting up your server..."
        end
        if localPlayer:GetAttribute("TeleportKind") == "Custom" then
            return "custom", "JOINING CUSTOM MATCH", "Heading to the host's server..."
        end

        return "match", "JOINING MATCH", "Heading to the arena..."
    end

    local function refresh()
        --[[
          name: refresh
          line: 159
          upvalues:
            want (copy, index: 1)
            v32 (ref,  index: 2)
            timestamp (ref,  index: 3)
            ui2 (copy, index: 4)
            ui3 (copy, index: 5)
            parent (copy, index: 6)
            ui (copy, index: 7)
            tween (ref,  index: 8)
            instance (copy, index: 9)
            teleportService (copy, index: 10)
            teleportGui (copy, index: 11)
        ]]
        local v37, text, text2 = want()

        if v37 == v32 then
            return
        end

        v32 = v37

        if v37 then
            timestamp = os.clock()
            ui2.Text = text
            ui3.Text = text2

            if not parent.Visible then
                parent.Visible = true
                ui.Enter(parent, Vector2.new(0, -12))
            end

            if not tween then
                instance.Position = UDim2.fromScale(-0.35, 0)
                tween = game:GetService("TweenService"):Create(instance, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {Position = UDim2.fromScale(1, 0)})
                tween:Play()
            end

            if v37 ~= "wait" then
                pcall(
                    function()
                        --[[
                          line: 179
                          upvalues:
                            teleportService (copy, index: 1)
                            teleportGui (copy, index: 2)
                            text (copy, index: 3)
                            text2 (copy, index: 4)
                        ]]
                        teleportService:SetTeleportGui((teleportGui(text, text2)))
                    end
                )
            end
        else
            parent.Visible = false

            if tween then
                tween:Cancel()
                tween = nil
            end
        end
    end

    localPlayer:GetAttributeChangedSignal("Teleporting"):Connect(
        function()
            --[[
              line: 192
              upvalues:
                localPlayer (copy, index: 1)
                v33 (ref,  index: 2)
            ]]
            if localPlayer:GetAttribute("Teleporting") ~= true then
                v33 = false
            end
        end
    )

    teleportService.TeleportInitFailed:Connect(
        function(player: Instance, teleportResult: Enum.TeleportResult)
            --[[
              line: 198
              upvalues:
                localPlayer (copy, index: 1)
                v32 (ref,  index: 2)
                v33 (ref,  index: 3)
                a13 (copy, index: 4)
                refresh (copy, index: 5)
            ]]
            if player ~= localPlayer or teleportResult == Enum.TeleportResult.IsTeleporting then
                return
            end

            if v32 and v32 ~= "wait" and not v33 then
                v33 = true
                local toast = a13.Toast
                local v43 = v32 ~= "custom" and "Couldn't reach the match server. You can keep playing here."
                    or "Couldn't reach that server. You can keep playing here."
                toast(v43, "warning")
                refresh()
            end
        end
    )

    task.spawn(
        function()
            --[[
              line: 209
              upvalues:
                v32 (ref,  index: 1)
                timestamp (ref,  index: 2)
                v33 (ref,  index: 3)
                refresh (copy, index: 4)
            ]]
            while true do
                task.wait(1)

                if v32 then
                    if v32 ~= "wait" and 32 < os.clock() - timestamp then
                        v33 = true
                        refresh()
                    end
                end
            end
        end
    )

    for _, attribute in {"Teleporting", "TeleportKind", "MMJoining"} do
        localPlayer:GetAttributeChangedSignal(attribute):Connect(refresh)
    end

    state.PlayerStateChanged:Connect(refresh)
    refresh()

    a13.Debug.joining = function(a46)
        --[[
          line: 225
          upvalues:
            state (copy, index: 1)
            localPlayer (copy, index: 2)
            refresh (copy, index: 3)
            v32 (ref,  index: 4)
        ]]
        if state.Mock or a46 then
            if a46 == "match" or a46 == "lobby" then
                local teleportKind = a46 ~= "lobby" and "Match" or "Lobby"
                localPlayer:SetAttribute("TeleportKind", teleportKind)
                localPlayer:SetAttribute("Teleporting", true)
            elseif a46 ~= "wait" then
                localPlayer:SetAttribute("Teleporting", nil)
                localPlayer:SetAttribute("MMJoining", nil)
            else
                localPlayer:SetAttribute("MMJoining", true)
            end
        end

        refresh()

        return {shown = v32 or false}
    end
end

return v3