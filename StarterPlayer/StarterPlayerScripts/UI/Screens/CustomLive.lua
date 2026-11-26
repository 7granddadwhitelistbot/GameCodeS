local proximityPromptService = game:GetService("ProximityPromptService")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local v4 = {}

local function easeOutBack(a6)
    --[[
      name: easeOutBack
      line: 34
    ]]
    return (((a6 - 1) ^ 3) * 2.70158) + 1 + (((a6 - 1) ^ 2) * 1.70158)
end

function v4.Init(a7)
    --[[
      name: Init
      line: 39
      upvalues:
        workspace (copy, index: 1)
        proximityPromptService (copy, index: 2)
        runService (copy, index: 3)
    ]]
    local ui = a7.UI
    local theme = a7.Theme
    local state = a7.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local custom = a7.Custom
    local udim2FromOffset = UDim2.fromOffset
    local formattedText = string.format("#%02X%02X%02X", math.floor((colors.TextDim.R * 255) + 0.5), math.floor((colors.TextDim.G * 255) + 0.5), (math.floor((colors.TextDim.B * 255) + 0.5)))
    local parent = ui.new("BillboardGui", {Name = "TR_CustomLive", LightInfluence = 0, Brightness = 1, AlwaysOnTop = false, MaxDistance = 170, ResetOnSpawn = false, Active = false, ClipsDescendants = false, Enabled = false, Size = udim2FromOffset(320, 180), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a7.PlayerGui})
    local parent2 = ui.new("Frame", {Name = "Pill", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0.5, -6), Size = udim2FromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, ui.Corner(theme.Radius.Pill), ui.Padding(0, 13, 0, 11), (ui.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
    local ui2 = ui.new("UIStroke", {Name = "Rim", Thickness = 1.5, Transparency = 0.55, Color = colors.Success, Parent = parent2})
    local ui3 = ui.new("Frame", {Name = "Dot", Size = udim2FromOffset(9, 9), BackgroundColor3 = colors.Success, LayoutOrder = 1, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
    local ui4 = ui.new("TextLabel", {Name = "Label", Text = "", RichText = true, TextSize = 17, LayoutOrder = 2, Size = udim2FromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent2})
    local ui5 = ui.new("UIScale", {Name = "Fit", Parent = parent2})
    local v22 = nil
    local studsOffsetWorldSpace = Vector3.new(0, 0, 0)
    local instance = nil
    local objectText = nil

    local function pavilion()
        --[[
          name: pavilion
          line: 103
          upvalues:
            workspace (copy, index: 1)
        ]]
        local lobby = workspace:FindFirstChild("Lobby")
        return lobby and lobby:FindFirstChild("CustomMatches")
    end

    local function resolve()
        --[[
          name: resolve
          line: 108
          upvalues:
            v22 (ref,  index: 1)
            workspace (copy, index: 2)
            studsOffsetWorldSpace (ref,  index: 3)
            parent (copy, index: 4)
        ]]
        if v22 and v22:IsDescendantOf(workspace) then
            return
        end

        v22 = nil
        local lobby = workspace:FindFirstChild("Lobby")
        local customMatches = lobby and lobby:FindFirstChild("CustomMatches")
        if not customMatches then
            return
        end

        local signBoard = customMatches:FindFirstChild("SignBoard")

        if signBoard and signBoard:IsA("BasePart") then
            v22 = signBoard
            studsOffsetWorldSpace = Vector3.new(0, ((signBoard.Size.Y / 2) + 0.13) + 0.55, 0)
        elseif customMatches:IsA("Model") and customMatches.PrimaryPart then
            local boundingBox, vector3 = customMatches:GetBoundingBox()
            v22 = customMatches.PrimaryPart
            studsOffsetWorldSpace = Vector3.new(0, ((boundingBox.Position.Y + (vector3.Y / 2)) + 0.55) - customMatches.PrimaryPart.Position.Y, 0)
        end

        parent.Adornee = v22
        parent.StudsOffsetWorldSpace = studsOffsetWorldSpace
    end

    local count = 0
    local target = false
    local clampedValue = 0
    local timestamp = -math.huge
    local v38 = 1

    local function liveCount()
        --[[
          name: liveCount
          line: 139
          upvalues:
            workspace (copy, index: 1)
        ]]
        local customLive = workspace:GetAttribute("CustomLive")

        if type(customLive) == "number" and 0 < customLive then
            return (math.floor(customLive))
        end

        return 0
    end

    local function paintPrompt()
        --[[
          name: paintPrompt
          line: 144
          upvalues:
            instance (ref,  index: 1)
            workspace (copy, index: 2)
            objectText (ref,  index: 3)
            custom (copy, index: 4)
            count (ref,  index: 5)
        ]]
        local instance2 = instance

        if not instance2 or not instance2:IsDescendantOf(workspace) then
            local lobby = workspace:FindFirstChild("Lobby")
            local customMatches = lobby and lobby:FindFirstChild("CustomMatches")
            local customMatchesPrompt = customMatches and customMatches:FindFirstChild("CustomMatchesPrompt", true)
            local instance3 = if customMatchesPrompt and customMatchesPrompt:IsA("ProximityPrompt") then customMatchesPrompt else nil
            instance = instance3
            instance2 = instance3
        end

        if not instance2 then
            return
        end

        if objectText == nil then
            objectText = instance2.ObjectText
        end

        local v47 = custom.IsServer() and 0 or count
        local v48 = v47 == 1 and "1 match live" or (if 1 < v47 then `{v47} matches live` else objectText or "")

        if instance2.ObjectText ~= v48 then
            instance2.ObjectText = v48
        end
    end

    local function refresh()
        --[[
          name: refresh
          line: 165
          upvalues:
            workspace (copy, index: 1)
            count (ref,  index: 2)
            ui4 (copy, index: 3)
            formattedText (copy, index: 4)
            clampedValue (ref,  index: 5)
            timestamp (ref,  index: 6)
            v38 (ref,  index: 7)
            paintPrompt (copy, index: 8)
            v22 (ref,  index: 9)
            state (copy, index: 10)
            a7 (copy, index: 11)
            custom (copy, index: 12)
            target (ref,  index: 13)
        ]]
        local flooredValue
        local customLive = workspace:GetAttribute("CustomLive")

        if type(customLive) == "number" and 0 < customLive then
            flooredValue = math.floor(customLive)
        else
            flooredValue = 0
        end

        if flooredValue ~= count then
            local flooredValue2 = count
            count = flooredValue

            if 0 < flooredValue then
                ui4.Text = `{flooredValue} <font color="{formattedText}">LIVE</font>`

                if 0 < flooredValue2 and 0.5 < clampedValue then
                    timestamp = os.clock()
                    v38 = 0.86
                end
            end

            paintPrompt()
        end

        local v53 = 0 < count
            and v22 ~= nil
            and not state.InMatch()
            and not a7.HudHidden
            and not custom.IsServer()

        if v53 and not target and clampedValue < 0.05 then
            timestamp = os.clock()
            v38 = 0.6
        end

        target = v53
    end

    workspace:GetAttributeChangedSignal("CustomLive"):Connect(refresh)

    workspace:GetAttributeChangedSignal("CustomServer"):Connect(
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

    state.PlayerStateChanged:Connect(refresh)
    a7.HudHiddenChanged:Connect(refresh)
    custom.Changed:Connect(refresh)

    proximityPromptService.PromptShown:Connect(
        function(prompt: ProximityPrompt)
            --[[
              line: 193
              upvalues:
                instance (ref,  index: 1)
                paintPrompt (copy, index: 2)
            ]]
            if prompt.Name == "CustomMatchesPrompt" then
                instance = prompt
                paintPrompt()
            end
        end
    )

    ui.Every(
        parent,
        1,
        function()
            --[[
              line: 200
              upvalues:
                v22 (ref,  index: 1)
                workspace (copy, index: 2)
                resolve (copy, index: 3)
                refresh (copy, index: 4)
                paintPrompt (copy, index: 5)
            ]]
            if not v22 or not v22:IsDescendantOf(workspace) then
                resolve()
                refresh()
                paintPrompt()
            end
        end
    )

    resolve()
    refresh()
    paintPrompt()
    local playerGui = a7.PlayerGui
    local v56 = {0.25, 0.75}
    local v57 = {-0.4, 0, 0.4}

    local function isPanel(guiObject, a60)
        --[[
          name: isPanel
          line: 217
          upvalues:
            parent (copy, index: 1)
        ]]
        if guiObject:IsDescendantOf(parent) then
            return false
        end

        local absoluteSize = guiObject.AbsoluteSize
        local x = absoluteSize.X

        if a60.X * 0.7 <= x then
            local y = absoluteSize.Y

            if a60.Y * 0.7 <= y then
                return false
            end
        end

        if guiObject.BackgroundTransparency < 0.6 then
            return true
        end
        if not guiObject:IsA("ImageLabel") and not guiObject:IsA("ImageButton")
            or guiObject.Image == ""
            or not (guiObject.ImageTransparency < 0.6)
        then
            return false
        end

        return true
    end

    local function coveredAt(a65, a66, a67)
        --[[
          name: coveredAt
          line: 233
          upvalues:
            playerGui (copy, index: 1)
            isPanel (copy, index: 2)
        ]]
        for _, guiObject in playerGui:GetGuiObjectsAtPosition(a65, a66) do
            if isPanel(guiObject, a67) then
                return true
            end
        end

        return false
    end

    local function hudCovers(camera: Camera?, a72)
        --[[
          name: hudCovers
          line: 241
          upvalues:
            studsOffsetWorldSpace (ref,  index: 1)
            parent2 (copy, index: 2)
            v56 (copy, index: 3)
            v57 (copy, index: 4)
            playerGui (copy, index: 5)
            isPanel (copy, index: 6)
        ]]
        local v73, v74 = camera:WorldToScreenPoint(a72.Position + studsOffsetWorldSpace)
        if not v74 then
            return false
        end

        local x = parent2.AbsoluteSize.X
        local y = parent2.AbsoluteSize.Y
        local v77 = v73.Y + parent2.Position.Y.Offset
        local viewportSize = camera.ViewportSize

        for _, v80 in v56 do
            local v81 = v77 - y * (1 - v80)

            for _, v83 in v57 do
                local v84
                v84 = false

                for _, guiObject in playerGui:GetGuiObjectsAtPosition(v73.X + (x * v83), v81) do
                    if isPanel(guiObject, viewportSize) then
                        v84 = true
                        break
                    end
                end

                if v84 then
                    return true
                end
            end
        end

        return false
    end

    local v87 = -1
    local flooredValue = -1
    local clampedValue2 = 1
    local covered = false
    local timestamp2 = -math.huge
    local v92 = math.huge

    runService.RenderStepped:Connect(
        function(deltaTime: number)
            --[[
              line: 266
              upvalues:
                target (ref,  index: 1)
                clampedValue (ref,  index: 2)
                parent (copy, index: 3)
                workspace (copy, index: 4)
                v22 (ref,  index: 5)
                studsOffsetWorldSpace (ref,  index: 6)
                timestamp2 (ref,  index: 7)
                hudCovers (copy, index: 8)
                covered (ref,  index: 9)
                v92 (ref,  index: 10)
                clampedValue2 (ref,  index: 11)
                timestamp (ref,  index: 12)
                v38 (ref,  index: 13)
                v87 (ref,  index: 14)
                ui5 (copy, index: 15)
                flooredValue (ref,  index: 16)
                parent2 (copy, index: 17)
                ui2 (copy, index: 18)
                ui4 (copy, index: 19)
                ui3 (copy, index: 20)
            ]]
            if not target and clampedValue <= 0 then
                if parent.Enabled then
                    parent.Enabled = false
                end

                return
            end

            local camera = workspace.CurrentCamera
            local v95 = v22

            if not camera or not v95 then
                clampedValue = 0
                parent.Enabled = false

                return
            end

            local clampedValue3 = clampedValue
            local v97 = if target then deltaTime / 0.25 else -deltaTime / 0.3
            clampedValue = math.clamp(clampedValue3 + v97, 0, 1)
            local magnitude = (v95.Position + studsOffsetWorldSpace - camera.CFrame.Position).Magnitude
            local clampedValue4 = math.clamp((170 - magnitude) / 25, 0, 1)
            local timestamp3 = os.clock()

            if 0 < clampedValue * clampedValue4 and 0.12 <= timestamp3 - timestamp2 then
                timestamp2 = timestamp3

                if hudCovers(camera, v95) then
                    covered = true
                    v92 = math.huge
                elseif covered then
                    v92 = math.min(v92, timestamp3)

                    if 0.3 <= timestamp3 - v92 then
                        covered = false
                    end
                end
            end

            local clampedValue5 = clampedValue2
            local v102 = if covered then -deltaTime / 0.15 else deltaTime / 0.25
            clampedValue2 = math.clamp(clampedValue5 + v102, 0, 1)
            local v103 = clampedValue * clampedValue4 * clampedValue2
            parent.Enabled = 0 < v103

            if v103 <= 0 then
                return
            end

            local clampedValue6 = math.clamp(camera.ViewportSize.Y / 1080, 0.72, 1.3)
            local v105 = math.min((300 / math.max(magnitude, 1)) + 22, 44) * clampedValue6 / 30
            local v106 = os.clock() - timestamp

            if v106 < 0.45 then
                local v107 = v38
                local v108 = 1 - v107
                local v109 = v106 / 0.45
                v105 *= v107 + (v108 * ((((function(...) return (...) ^ 3 end)(((v109 - 1)))) * 2.70158) + 1 + (((function(...) return (...) ^ 2 end)(((v109 - 1)))) * 1.70158)))
            end

            local scale = math.floor((v105 * 200) + 0.5) / 200

            if scale ~= v87 then
                v87 = scale
                ui5.Scale = scale
            end

            local flooredValue2 = math.floor((clampedValue6 * 6) + 0.5)

            if flooredValue2 ~= flooredValue then
                flooredValue = flooredValue2
                parent2.Position = UDim2.new(0.5, 0, 0.5, -flooredValue2)
            end

            local v112 = (0.5 - (math.cos(os.clock() * 2.6179938779914944) * 0.5)) * 0.55
            parent2.BackgroundTransparency = 1 - (v103 * 0.7)
            ui2.Transparency = 1 - (v103 * 0.45)
            ui4.TextTransparency = 1 - v103
            ui3.BackgroundTransparency = 1 - (v103 * (1 - v112))
        end
    )

    a7.Debug.customLive = function()
        --[[
          line: 329
          upvalues:
            workspace (copy, index: 1)
            count (ref,  index: 2)
            target (ref,  index: 3)
            clampedValue (ref,  index: 4)
            covered (ref,  index: 5)
            clampedValue2 (ref,  index: 6)
            parent (copy, index: 7)
            v22 (ref,  index: 8)
            instance (ref,  index: 9)
            ui5 (copy, index: 10)
            parent2 (copy, index: 11)
            studsOffsetWorldSpace (ref,  index: 12)
        ]]
        local formattedText
        local dist
        local camera = workspace.CurrentCamera
        local v116 = {count = count, attr = workspace:GetAttribute("CustomLive") or false, players = workspace:GetAttribute("CustomLivePlayers")
            or false, target = target, alpha = math.floor((clampedValue * 100) + 0.5) / 100, covered = covered, cover = math.floor((clampedValue2 * 100) + 0.5) / 100, enabled = parent.Enabled}

        if not (0 < count) then
            formattedText = ""
        else
            formattedText = `{count} LIVE`
        end

        v116.text = formattedText
        v116.adornee = if v22 then v22:GetFullName() else false
        v116.prompt = if instance then instance.ObjectText else false
        v116.scale = math.floor((ui5.Scale * 100) + 0.5) / 100
        v116.pillPx = {math.floor(parent2.AbsoluteSize.X), (math.floor(parent2.AbsoluteSize.Y))}

        if v22 and camera then
            dist = math.floor((v22.Position + studsOffsetWorldSpace - camera.CFrame.Position).Magnitude)
        else
            dist = false
        end

        v116.dist = dist

        return v116
    end
end

return v4