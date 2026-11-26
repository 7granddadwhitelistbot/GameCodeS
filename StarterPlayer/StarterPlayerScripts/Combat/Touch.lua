local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local TouchStart = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("TouchStart"))
local Loc = require(replicatedStorage.Shared:WaitForChild("Loc"))
local v7 = {}
local localPlayer = players.LocalPlayer
local screenGui = nil
local frame = nil
local v11 = {}
local v12 = nil
local v13 = nil
local v14 = {}
local v15 = false
local v16 = false
local v17 = true
local Camera = nil
local v19 = false
local v20 = false
local color = Color3.fromRGB(40, 150, 255)
local backgroundColor3 = Color3.fromRGB(18, 20, 26)
local backgroundColor32 = Color3.fromRGB(36, 40, 50)
local color3 = Color3.fromRGB(255, 255, 255)
local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local v26 = {Fists = "PUNCH", Sword = "ATTACK", Axe = "ATTACK", Spear = "ATTACK", Dagger = "ATTACK", Club = "ATTACK", Shield = "BASH", Gauntlets = "PUNCH", Scythe = "ATTACK", Katana = "ATTACK", Hatchets = "CHOP", Bow = "DRAW", Crossbow = "FIRE", Musket = "FIRE", Pistol = "FIRE", Blunderbuss = "FIRE", Knives = "THROW", Javelin = "THROW", Sling = "SLING", Bomb = "THROW", Herbs = "HEAL", Trap = "SET", Horn = "BLOW"}
local v27 = {Crossbow = true, Musket = true, Pistol = true, Blunderbuss = true}

local function secondaryFor(key, a30)
    --[[
      name: secondaryFor
      line: 88
      upvalues:
        v27 (copy, index: 1)
    ]]
    if not key then
        return nil, nil
    end
    if key == "Bow" or v27[key] or key == "Knives" or key == "Sling" then
        return "AIM", "toggle"
    end
    if key == "Javelin" or key == "Bomb" then
        return "CANCEL", "tap"
    end
    if a30.parry then
        return "PARRY", "hold"
    end
    if a30.throw then
        return "THROW", "hold"
    end
    if a30.block then
        return "BLOCK", "hold"
    end
    if a30.heavy then
        return "HEAVY", "hold"
    end
    if a30.lunge and (a30.lunge.charge or 0.6) <= 0 then
        return "DASH", "hold"
    end
    if a30.lunge then
        return "LUNGE", "hold"
    end

    return nil, nil
end

local function makeButton(parent: Frame, name: string, a34: number, text: string, textSize: number)
    --[[
      name: makeButton
      line: 112
      upvalues:
        backgroundColor3 (copy, index: 1)
        color3 (copy, index: 2)
        fontFace (copy, index: 3)
        Loc (copy, index: 4)
    ]]
    local parent2 = Instance.new("TextButton")
    parent2.Name = name
    parent2.AnchorPoint = Vector2.new(0.5, 0.5)
    parent2.Size = UDim2.fromOffset(a34, a34)
    parent2.BackgroundColor3 = backgroundColor3
    parent2.BackgroundTransparency = 0.3
    parent2.AutoButtonColor = false
    parent2.Text = text
    parent2.TextColor3 = color3
    parent2.TextSize = textSize
    parent2.FontFace = fontFace
    parent2.Active = true
    parent2.Selectable = false

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent2

    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 2
    uiStroke.Color = color3
    uiStroke.Transparency = 0.8
    uiStroke.Parent = parent2
    Instance.new("UIScale").Parent = parent2
    Loc.Fit(parent2, 9, 0.06)
    parent2.Parent = parent

    return parent2
end

local function setPressedLook(pressedLook: TextButton?, a42: boolean)
    --[[
      name: setPressedLook
      line: 143
      upvalues:
        v11 (copy, index: 1)
        v19 (ref,  index: 2)
        v20 (ref,  index: 3)
        backgroundColor32 (copy, index: 4)
        backgroundColor3 (copy, index: 5)
        color (copy, index: 6)
        color3 (copy, index: 7)
    ]]
    local v43 = pressedLook == v11.Secondary and v19 and not a42

    if pressedLook == v11.Secondary then
        v20 = a42
    end

    pressedLook.BackgroundColor3 = if a42 then backgroundColor32 else backgroundColor3
    pressedLook.BackgroundTransparency = a42 and 0.12 or v43 and 0.6 or 0.3
    pressedLook.TextTransparency = v43 and 0.55 or 0

    if const uiStroke = pressedLook:FindFirstChildOfClass("UIStroke") then
        uiStroke.Color = if a42 then color else color3
        uiStroke.Thickness = a42 and 3 or 2
        uiStroke.Transparency = a42 and 0 or v43 and 0.92 or 0.8
    end

    if const uiScale = pressedLook:FindFirstChildOfClass("UIScale") then
        uiScale.Scale = a42 and 0.92 or 1
    end
end

local textButton = nil
local frame2 = nil

local function setNudge(nudge2: TextButton?)
    --[[
      name: setNudge
      line: 168
      upvalues:
        textButton (ref,  index: 1)
        frame2 (ref,  index: 2)
        color (copy, index: 3)
        tweenService (copy, index: 4)
    ]]
    if nudge2 == textButton then
        return
    end

    textButton = nudge2

    if frame2 then
        frame2:Destroy()
        frame2 = nil
    end

    if not nudge2 then
        return
    end

    local nudge = Instance.new("Frame")
    nudge.Name = "Nudge"
    nudge.AnchorPoint = Vector2.new(0.5, 0.5)
    nudge.Position = UDim2.fromScale(0.5, 0.5)
    nudge.Size = UDim2.fromScale(1, 1)
    nudge.BackgroundTransparency = 1
    nudge.ZIndex = 0

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = nudge

    local instance = Instance.new("UIStroke")
    instance.Thickness = 3
    instance.Color = color
    instance.Transparency = 1
    instance.Parent = nudge
    nudge.Parent = nudge2
    frame2 = nudge

    task.spawn(
        function()
            --[[
              line: 197
              upvalues:
                frame2 (ref,  index: 1)
                nudge (copy, index: 2)
                instance (copy, index: 3)
                tweenService (copy, index: 4)
            ]]
            local tweenInfo = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            while frame2 == nudge and nudge.Parent do
                nudge.Size = UDim2.fromScale(1, 1)
                instance.Transparency = 0.1
                local propertyTable = {Size = UDim2.fromScale(1.45, 1.45)}
                tweenService:Create(nudge, tweenInfo, propertyTable):Play()
                tweenService:Create(instance, tweenInfo, {Transparency = 1}):Play()
                task.wait(1.3)
            end
        end
    )
end

local function readOverride(screenGui: ScreenGui?, a57: string, absoluteSize: Vector2, offset: number)
    --[[
      name: readOverride
      line: 213
    ]]
    local text = screenGui:GetAttribute("Override_" .. a57)

    if type(text) ~= "string" then
        return nil, nil
    end

    local v61, v62, v63 = string.match(text, "^(%-?%d+),(%-?%d+),(%d+)$")
    if not v61 then
        return nil, nil
    end

    local flooredValue = math.floor(((tonumber(v63) / 1000) * offset) + 0.5)

    return UDim2.fromOffset((tonumber(v61) / 1000) * absoluteSize.X, tonumber(v62) / 1000 * absoluteSize.Y), (math.max(flooredValue, 24))
end

local function fire(a66, a67)
    --[[
      name: fire
      line: 226
      upvalues:
        v12 (ref, index: 1)
    ]]
    if v12 then
        v12(a66, a67)
    end
end

local function obstacle(vector2: Vector2)
    --[[
      name: obstacle
      line: 234
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local v70 = vector2.Y
    local x = vector2.X
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    if not playerGui then
        return v70, x
    end

    local characterTouch = playerGui:FindFirstChild("CharacterTouch")

    if characterTouch and characterTouch:IsA("ScreenGui") and characterTouch.Enabled then
        local reservedMinY = characterTouch:GetAttribute("ReservedMinY")

        if type(reservedMinY) == "number" and 0 < reservedMinY then
            v70 = math.min(v70, reservedMinY)
        end
    end

    local touchGui = playerGui:FindFirstChild("TouchGui")
    local jumpButton = touchGui and touchGui:FindFirstChild("JumpButton", true)

    if jumpButton and jumpButton:IsA("GuiObject") and jumpButton.Visible and 0 < jumpButton.AbsoluteSize.X then
        v70 = math.min(v70, jumpButton.AbsolutePosition.Y)
    end

    return v70, x
end

local function layout()
    --[[
      name: layout
      line: 255
      upvalues:
        screenGui (ref,  index: 1)
        frame (ref,  index: 2)
        obstacle (copy, index: 3)
        v11 (copy, index: 4)
        readOverride (copy, index: 5)
    ]]
    local screenGui2 = screenGui
    local frame2 = frame

    if not screenGui2 or not frame2 then
        return
    end

    local v80
    local absolutePosition = frame2.AbsolutePosition
    local absoluteSize = frame2.AbsoluteSize

    if absoluteSize.X < 10 then
        return
    end

    local vector2 = absolutePosition + absoluteSize
    local v84 = obstacle(vector2)
    local v85 = absoluteSize.Y < 500
    local v86 = v85 and 92 or 100
    local v87 = v85 and 66 or 72
    local v88 = v85 and 58 or 62
    local v89 = math.min(v84, vector2.Y) - 12
    local v90 = vector2.X - 22 - v86 / 2
    local v91 = math.max(v89 - (v86 / 2), (absolutePosition.Y + (v86 / 2)) + 70)

    local function place(a93, a94, a95, a96: number)
        --[[
          name: place
          line: 275
          upvalues:
            absolutePosition (copy, index: 1)
        ]]
        a93.Size = UDim2.fromOffset(a96, a96)
        a93.Position = UDim2.fromOffset(a94 - absolutePosition.X, a95 - absolutePosition.Y)
    end

    local attack = v11.Attack
    attack.Size = UDim2.fromOffset(v86, v86)
    attack.Position = UDim2.fromOffset(v90 - absolutePosition.X, v91 - absolutePosition.Y)
    local v98 = (v90 - (v86 / 2)) - 14 - v87 / 2
    local secondary = v11.Secondary
    local v100 = v91 + (v86 - v87) / 2
    secondary.Size = UDim2.fromOffset(v87, v87)
    secondary.Position = UDim2.fromOffset(v98 - absolutePosition.X, v100 - absolutePosition.Y)

    if v11.Secondary.Visible then
        v80 = v98 - v87 / 2
    else
        v80 = v90 - v86 / 2
    end

    local v101 = v80 - 14 - v88 / 2
    local reload = v11.Reload
    local v103 = v91 + (v86 - v88) / 2
    reload.Size = UDim2.fromOffset(v88, v88)
    reload.Position = UDim2.fromOffset(v101 - absolutePosition.X, v103 - absolutePosition.Y)

    for v104, textButton in v11 do
        textButton:SetAttribute("DefaultSize", textButton.Size.X.Offset)
        local position, v107 = readOverride(screenGui2, v104, absoluteSize, textButton.Size.X.Offset)

        if position and v107 then
            textButton.Position = position
            textButton.Size = UDim2.fromOffset(v107, v107)
        end
    end
end

local function refresh()
    --[[
      name: refresh
      line: 294
      upvalues:
        screenGui (ref,  index: 1)
        localPlayer (copy, index: 2)
        v16 (ref,  index: 3)
        v17 (ref,  index: 4)
        v26 (copy, index: 5)
        v13 (ref,  index: 6)
        v11 (copy, index: 7)
        Loc (copy, index: 8)
        secondaryFor (copy, index: 9)
        v14 (ref,  index: 10)
        v15 (ref,  index: 11)
        v27 (copy, index: 12)
        layout (copy, index: 13)
        setNudge (copy, index: 14)
        v19 (ref,  index: 15)
    ]]
    local textButton
    local textButton2
    local screenGui2 = screenGui
    if not screenGui2 then
        return
    end

    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChildOfClass("Humanoid")
    local v113 = instance ~= nil and 0 < instance.Health
    local editPreview = screenGui2:GetAttribute("EditPreview") == true
    screenGui2.Enabled = (v16 or screenGui2:GetAttribute("ForceVisible") == true) and v17 and v113 or editPreview
    local v115 = v26[v13 or "Fists"] or "ATTACK"
    v11.Attack.AutoLocalize = v115 ~= "DRAW"
    v11.Attack.Text = if v115 == "DRAW" then Loc.Pick("DRAW (bow)", "DRAW") else v115
    local v116 = secondaryFor(v13, v14)
    v11.Secondary.Visible = (v116 ~= nil) or editPreview
    v11.Secondary.Text = v116 == "AIM" and v15 and "AIM ON" or v116 or editPreview and "ALT" or ""
    local reload = v11.Reload
    local visible = not not (not (v13 == nil or v27[v13] ~= true or not (1 < (tonumber(v14.magazine) or 1)))
        or editPreview)
    reload.Visible = visible

    if screenGui2.Enabled then
        layout()
    end

    local nudge = screenGui2:GetAttribute("Nudge")

    if type(nudge) == "string" and not editPreview then
        textButton = v11[nudge]
    else
        textButton = nil
    end

    if not textButton or not textButton.Visible or textButton == v11.Secondary and v19 then
        textButton2 = nil
    else
        textButton2 = textButton
    end

    setNudge(textButton2)
end

local function bindAttack(attack: TextButton?)
    --[[
      name: bindAttack
      line: 322
      upvalues:
        TouchStart (copy, index: 1)
        v11 (copy, index: 2)
        v19 (ref,  index: 3)
        v20 (ref,  index: 4)
        backgroundColor32 (copy, index: 5)
        color (copy, index: 6)
        v12 (ref,  index: 7)
        userInputService (copy, index: 8)
        Camera (ref,  index: 9)
        players (copy, index: 10)
        backgroundColor3 (copy, index: 11)
        color3 (copy, index: 12)
    ]]
    local inputObject = nil

    attack.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 324
              upvalues:
                inputObject (ref,  index: 1)
                TouchStart (copy, index: 2)
                attack (copy, index: 3)
                v11 (copy, index: 4)
                v19 (ref,  index: 5)
                v20 (ref,  index: 6)
                backgroundColor32 (copy, index: 7)
                color (copy, index: 8)
                v12 (ref,  index: 9)
            ]]
            if input.UserInputType ~= Enum.UserInputType.Touch
                or inputObject
                or not TouchStart.BeganOn(attack, input)
            then
                return
            end

            inputObject = input
            local attack2 = attack
            local v125 = false

            if attack2 == v11.Secondary then
                v125 = v19 and false
            end

            if attack2 == v11.Secondary then
                v20 = true
            end

            attack2.BackgroundColor3 = backgroundColor32
            attack2.BackgroundTransparency = 0.12
            attack2.TextTransparency = v125 and 0.55 or 0

            if const uiStroke = attack2:FindFirstChildOfClass("UIStroke") then
                uiStroke.Color = color
                uiStroke.Thickness = 3
                uiStroke.Transparency = 0
            end

            if const uiScale = attack2:FindFirstChildOfClass("UIScale") then
                uiScale.Scale = 0.92
            end

            if v12 then
                v12("Primary", true)
            end
        end
    )

    userInputService.TouchMoved:Connect(
        function(touch: InputObject)
            --[[
              line: 336
              upvalues:
                inputObject (ref,  index: 1)
                Camera (ref,  index: 2)
                userInputService (copy, index: 3)
                players (copy, index: 4)
            ]]
            if touch == inputObject and Camera and not userInputService.MouseEnabled then
                if players.LocalPlayer:GetAttribute("TouchAttackLookOff") == true then
                    return
                end

                local delta = touch.Delta

                if not pcall(
                    function()
                        --[[
                          line: 344
                          upvalues:
                            Camera (ref,  index: 1)
                            delta (copy, index: 2)
                        ]]
                        Camera.AddTouchLook(Vector2.new(delta.X, delta.Y))
                    end
                ) then
                    Camera = nil
                end
            end
        end
    )

    userInputService.TouchEnded:Connect(
        function(touch: InputObject)
            --[[
              line: 351
              upvalues:
                inputObject (ref,  index: 1)
                attack (copy, index: 2)
                v11 (copy, index: 3)
                v19 (ref,  index: 4)
                v20 (ref,  index: 5)
                backgroundColor3 (copy, index: 6)
                color3 (copy, index: 7)
                v12 (ref,  index: 8)
            ]]
            if touch ~= inputObject then
                return
            end

            inputObject = nil
            local attack2 = attack
            local v132 = false

            if attack2 == v11.Secondary then
                v132 = v19 and true
            end

            if attack2 == v11.Secondary then
                v20 = false
            end

            attack2.BackgroundColor3 = backgroundColor3
            attack2.BackgroundTransparency = v132 and 0.6 or 0.3
            attack2.TextTransparency = v132 and 0.55 or 0

            if const uiStroke = attack2:FindFirstChildOfClass("UIStroke") then
                uiStroke.Color = color3
                uiStroke.Thickness = 2
                uiStroke.Transparency = v132 and 0.92 or 0.8
            end

            if const uiScale = attack:FindFirstChildOfClass("UIScale") then
                uiScale.Scale = 1
            end

            if v12 then
                v12("Primary", false)
            end
        end
    )
end

local function bindSecondary(secondary: TextButton?)
    --[[
      name: bindSecondary
      line: 361
      upvalues:
        TouchStart (copy, index: 1)
        secondaryFor (copy, index: 2)
        v13 (ref,  index: 3)
        v14 (ref,  index: 4)
        v15 (ref,  index: 5)
        setPressedLook (copy, index: 6)
        v12 (ref,  index: 7)
        refresh (copy, index: 8)
        v11 (copy, index: 9)
        v19 (ref,  index: 10)
        v20 (ref,  index: 11)
        backgroundColor32 (copy, index: 12)
        color (copy, index: 13)
        userInputService (copy, index: 14)
        backgroundColor3 (copy, index: 15)
        color3 (copy, index: 16)
    ]]
    local inputObject = nil

    secondary.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 363
              upvalues:
                inputObject (ref,  index: 1)
                TouchStart (copy, index: 2)
                secondary (copy, index: 3)
                secondaryFor (copy, index: 4)
                v13 (ref,  index: 5)
                v14 (ref,  index: 6)
                v15 (ref,  index: 7)
                setPressedLook (copy, index: 8)
                v12 (ref,  index: 9)
                refresh (copy, index: 10)
                v11 (copy, index: 11)
                v19 (ref,  index: 12)
                v20 (ref,  index: 13)
                backgroundColor32 (copy, index: 14)
                color (copy, index: 15)
            ]]
            if input.UserInputType ~= Enum.UserInputType.Touch
                or inputObject
                or not TouchStart.BeganOn(secondary, input)
            then
                return
            end

            local _, v140 = secondaryFor(v13, v14)

            if v140 == "toggle" then
                v15 = not v15
                setPressedLook(secondary, v15)
                local v141 = v15

                if v12 then
                    v12("Secondary", v141)
                end

                refresh()

                return
            end

            if v140 == "tap" then
                if v12 then
                    v12("Secondary", true)
                end

                if v12 then
                    v12("Secondary", false)
                end
            elseif v140 == "hold" then
                inputObject = input
                local secondary2 = secondary
                local v143 = false

                if secondary2 == v11.Secondary then
                    v143 = v19 and false
                end

                if secondary2 == v11.Secondary then
                    v20 = true
                end

                secondary2.BackgroundColor3 = backgroundColor32
                secondary2.BackgroundTransparency = 0.12
                secondary2.TextTransparency = v143 and 0.55 or 0

                if const uiStroke = secondary2:FindFirstChildOfClass("UIStroke") then
                    uiStroke.Color = color
                    uiStroke.Thickness = 3
                    uiStroke.Transparency = 0
                end

                if const uiScale = secondary2:FindFirstChildOfClass("UIScale") then
                    uiScale.Scale = 0.92
                end

                if v12 then
                    v12("Secondary", true)
                end
            end
        end
    )

    userInputService.TouchEnded:Connect(
        function(touch: InputObject)
            --[[
              line: 382
              upvalues:
                inputObject (ref,  index: 1)
                secondary (copy, index: 2)
                v11 (copy, index: 3)
                v19 (ref,  index: 4)
                v20 (ref,  index: 5)
                backgroundColor3 (copy, index: 6)
                color3 (copy, index: 7)
                v12 (ref,  index: 8)
            ]]
            if touch ~= inputObject then
                return
            end

            inputObject = nil
            local secondary2 = secondary
            local v148 = false

            if secondary2 == v11.Secondary then
                v148 = v19 and true
            end

            if secondary2 == v11.Secondary then
                v20 = false
            end

            secondary2.BackgroundColor3 = backgroundColor3
            secondary2.BackgroundTransparency = v148 and 0.6 or 0.3
            secondary2.TextTransparency = v148 and 0.55 or 0

            if const uiStroke = secondary2:FindFirstChildOfClass("UIStroke") then
                uiStroke.Color = color3
                uiStroke.Thickness = 2
                uiStroke.Transparency = v148 and 0.92 or 0.8
            end

            if const uiScale = secondary:FindFirstChildOfClass("UIScale") then
                uiScale.Scale = 1
            end

            if v12 then
                v12("Secondary", false)
            end
        end
    )
end

function v7.SetWeapon(a151, a152)
    --[[
      name: SetWeapon
      line: 393
      upvalues:
        v13 (ref,  index: 1)
        v14 (ref,  index: 2)
        v15 (ref,  index: 3)
        v11 (copy, index: 4)
        v19 (ref,  index: 5)
        v20 (ref,  index: 6)
        backgroundColor3 (copy, index: 7)
        color3 (copy, index: 8)
        refresh (copy, index: 9)
    ]]
    v13 = a151
    v14 = a152 or {}
    v15 = false

    if v11.Secondary then
        local secondary = v11.Secondary
        local v154 = false

        if secondary == v11.Secondary then
            v154 = v19 and true
        end

        if secondary == v11.Secondary then
            v20 = false
        end

        secondary.BackgroundColor3 = backgroundColor3
        secondary.BackgroundTransparency = v154 and 0.6 or 0.3
        secondary.TextTransparency = v154 and 0.55 or 0

        if const uiStroke = secondary:FindFirstChildOfClass("UIStroke") then
            uiStroke.Color = color3
            uiStroke.Thickness = 2
            uiStroke.Transparency = v154 and 0.92 or 0.8
        end

        if const uiScale = secondary:FindFirstChildOfClass("UIScale") then
            uiScale.Scale = 1
        end
    end

    refresh()
end

function v7.SetAltDim(altDim)
    --[[
      name: SetAltDim
      line: 404
      upvalues:
        v19 (ref,  index: 1)
        v11 (copy, index: 2)
        setPressedLook (copy, index: 3)
        v20 (ref,  index: 4)
        refresh (copy, index: 5)
    ]]
    if altDim == v19 then
        return
    end

    v19 = altDim

    if v11.Secondary then
        setPressedLook(v11.Secondary, v20)
    end

    refresh()
end

function v7.SetVisible(visible)
    --[[
      name: SetVisible
      line: 415
      upvalues:
        v17 (ref,  index: 1)
        refresh (copy, index: 2)
    ]]
    if visible ~= v17 then
        v17 = visible
        refresh()
    end
end

function v7.IsActive()
    --[[
      name: IsActive
      line: 422
      upvalues:
        v16 (ref, index: 1)
    ]]
    return v16
end

local function updateActive(userInputType: Enum.UserInputType?)
    --[[
      name: updateActive
      line: 426
      upvalues:
        userInputService (copy, index: 1)
        v16 (ref,  index: 2)
        refresh (copy, index: 3)
    ]]
    local v161
    local userInputType2 = userInputType or userInputService:GetLastInputType()

    if userInputType2 ~= Enum.UserInputType.Touch then
        if userInputType2 == Enum.UserInputType.MouseButton1
            or userInputType2 == Enum.UserInputType.MouseMovement
            or userInputType2 == Enum.UserInputType.Keyboard
            or string.find(userInputType2.Name, "Gamepad")
        then
            v161 = false
        else
            v161 = userInputService.TouchEnabled and not userInputService.MouseEnabled
        end
    else
        v161 = true
    end

    if v161 ~= v16 then
        v16 = v161
        refresh()
    end
end

function v7.Start(a163)
    --[[
      name: Start
      line: 442
      upvalues:
        screenGui (ref,  index: 1)
        v12 (ref,  index: 2)
        Camera (ref,  index: 3)
        localPlayer (copy, index: 4)
        frame (ref,  index: 5)
        v11 (copy, index: 6)
        makeButton (copy, index: 7)
        bindAttack (copy, index: 8)
        bindSecondary (copy, index: 9)
        TouchStart (copy, index: 10)
        v19 (ref,  index: 11)
        v20 (ref,  index: 12)
        backgroundColor32 (copy, index: 13)
        color (copy, index: 14)
        backgroundColor3 (copy, index: 15)
        color3 (copy, index: 16)
        refresh (copy, index: 17)
        updateActive (copy, index: 18)
        userInputService (copy, index: 19)
        layout (copy, index: 20)
        v15 (ref,  index: 21)
    ]]
    if screenGui then
        return
    end

    v12 = a163

    task.spawn(
        function()
            --[[
              line: 447
              upvalues:
                Camera (ref, index: 1)
            ]]
            local success, Camera2 = pcall(
                function()
                    --[[
                      line: 448
                    ]]
                    return require((game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera", 10)))
                end
            )

            if not success or type(Camera2) ~= "table" or not Camera2.SetLook or not Camera2.GetYaw then
                Camera = nil
            else
                Camera = Camera2
            end
        end
    )

    local combatTouch = Instance.new("ScreenGui")
    combatTouch.Name = "CombatTouch"
    combatTouch.ResetOnSpawn = false
    combatTouch.IgnoreGuiInset = true
    combatTouch.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    combatTouch.DisplayOrder = 5
    combatTouch.Enabled = false
    combatTouch.Parent = localPlayer:WaitForChild("PlayerGui")
    screenGui = combatTouch
    local root = Instance.new("Frame")
    root.Name = "Root"
    root.BackgroundTransparency = 1
    root.Size = UDim2.fromScale(1, 1)
    root.Parent = combatTouch
    frame = root
    v11.Attack = makeButton(root, "Attack", 96, "ATTACK", 16)
    v11.Secondary = makeButton(root, "Secondary", 70, "BLOCK", 14)
    v11.Reload = makeButton(root, "Reload", 60, "RELOAD", 12)
    bindAttack(v11.Attack)
    bindSecondary(v11.Secondary)

    v11.Reload.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 473
              upvalues:
                TouchStart (copy, index: 1)
                v11 (copy, index: 2)
                v19 (ref,  index: 3)
                v20 (ref,  index: 4)
                backgroundColor32 (copy, index: 5)
                color (copy, index: 6)
                v12 (ref,  index: 7)
                backgroundColor3 (copy, index: 8)
                color3 (copy, index: 9)
            ]]
            if input.UserInputType == Enum.UserInputType.Touch and TouchStart.BeganOn(v11.Reload, input) then
                local reload = v11.Reload
                local v170 = false

                if reload == v11.Secondary then
                    v170 = v19 and false
                end

                if reload == v11.Secondary then
                    v20 = true
                end

                reload.BackgroundColor3 = backgroundColor32
                reload.BackgroundTransparency = 0.12
                reload.TextTransparency = v170 and 0.55 or 0

                if const uiStroke = reload:FindFirstChildOfClass("UIStroke") then
                    uiStroke.Color = color
                    uiStroke.Thickness = 3
                    uiStroke.Transparency = 0
                end

                if const uiScale = reload:FindFirstChildOfClass("UIScale") then
                    uiScale.Scale = 0.92
                end

                if v12 then
                    v12("Reload", true)
                end

                if v12 then
                    v12("Reload", false)
                end

                task.delay(
                    0.12,
                    function()
                        --[[
                          line: 478
                          upvalues:
                            v11 (copy, index: 1)
                            v19 (ref,  index: 2)
                            v20 (ref,  index: 3)
                            backgroundColor3 (copy, index: 4)
                            color3 (copy, index: 5)
                        ]]
                        local reload = v11.Reload
                        local v174 = false

                        if reload == v11.Secondary then
                            v174 = v19 and true
                        end

                        if reload == v11.Secondary then
                            v20 = false
                        end

                        reload.BackgroundColor3 = backgroundColor3
                        reload.BackgroundTransparency = v174 and 0.6 or 0.3
                        reload.TextTransparency = v174 and 0.55 or 0

                        if const uiStroke = reload:FindFirstChildOfClass("UIStroke") then
                            uiStroke.Color = color3
                            uiStroke.Thickness = 2
                            uiStroke.Transparency = v174 and 0.92 or 0.8
                        end

                        if const uiScale = reload:FindFirstChildOfClass("UIScale") then
                            uiScale.Scale = 1
                        end
                    end
                )
            end
        end
    )

    combatTouch:GetAttributeChangedSignal("ForceVisible"):Connect(refresh)

    combatTouch.AttributeChanged:Connect(
        function(attribute: string)
            --[[
              line: 484
              upvalues:
                refresh (copy, index: 1)
            ]]
            if attribute == "EditPreview" or attribute == "Nudge" or string.sub(attribute, 1, 9) == "Override_" then
                refresh()
            end
        end
    )

    updateActive(nil)
    userInputService.LastInputTypeChanged:Connect(updateActive)

    root:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 491
              upvalues:
                combatTouch (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if combatTouch.Enabled then
                layout()
            end
        end
    )

    localPlayer.CharacterAdded:Connect(
        function(character: Model)
            --[[
              line: 496
              upvalues:
                v15 (ref,  index: 1)
                refresh (copy, index: 2)
            ]]
            v15 = false

            if const humanoid = character:WaitForChild("Humanoid", 10) then
                humanoid.Died:Connect(refresh)
            end

            refresh()
        end
    )

    task.spawn(
        function()
            --[[
              line: 505
              upvalues:
                combatTouch (copy, index: 1)
                layout (copy, index: 2)
            ]]
            while combatTouch.Parent do
                task.wait(1.5)

                if combatTouch.Enabled then
                    layout()
                end
            end
        end
    )

    refresh()
end

return v7