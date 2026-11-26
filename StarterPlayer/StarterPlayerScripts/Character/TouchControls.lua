local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local Camera = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Camera"))
local TouchStart = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("TouchStart"))
local Loc = require(replicatedStorage.Shared:WaitForChild("Loc"))
local Movement = require(script.Parent:WaitForChild("Movement"))
local v11 = {}
local localPlayer = players.LocalPlayer
local backgroundColor3 = Color3.fromRGB(18, 20, 26)
local color3 = Color3.fromRGB(36, 40, 50)
local color32 = Color3.fromRGB(40, 150, 255)
local color33 = Color3.fromRGB(255, 255, 255)
local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local screenGui = nil
local frame = nil
local button = nil
local button2 = nil
local button3 = nil
local v23 = false
local v24 = false
local frozen = false
local v26 = {Spectate = true, FreeCursor = true}

local function makeButton(parent: Frame, name: string, text: string)
    --[[
      name: makeButton
      line: 68
      upvalues:
        backgroundColor3 (copy, index: 1)
        color33 (copy, index: 2)
        fontFace (copy, index: 3)
        Loc (copy, index: 4)
    ]]
    local parent2 = Instance.new("TextButton")
    parent2.Name = name
    parent2.AnchorPoint = Vector2.new(0.5, 0.5)
    parent2.BackgroundColor3 = backgroundColor3
    parent2.BackgroundTransparency = 0.3
    parent2.AutoButtonColor = false
    parent2.Text = text
    parent2.TextColor3 = color33
    parent2.FontFace = fontFace
    parent2.Active = true
    parent2.Selectable = false

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = parent2

    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 2
    uiStroke.Color = color33
    uiStroke.Transparency = 0.8
    uiStroke.Parent = parent2
    Instance.new("UIScale").Parent = parent2
    Loc.Fit(parent2, 8, 0.06)
    parent2.Parent = parent

    return parent2
end

local function setPressed(pressed: TextButton?, a36: boolean)
    --[[
      name: setPressed
      line: 97
      upvalues:
        color3 (copy, index: 1)
        backgroundColor3 (copy, index: 2)
        color32 (copy, index: 3)
        color33 (copy, index: 4)
        frozen (ref,  index: 5)
        tweenService (copy, index: 6)
    ]]
    pressed.BackgroundColor3 = if a36 then color3 else backgroundColor3
    pressed.BackgroundTransparency = a36 and 0.12 or 0.3

    if const uiStroke = pressed:FindFirstChildOfClass("UIStroke") then
        uiStroke.Color = if a36 then color32 else color33
        uiStroke.Thickness = a36 and 3 or 2
        uiStroke.Transparency = a36 and 0 or frozen and 0.92 or 0.8
    end

    if const uiScale = pressed:FindFirstChildOfClass("UIScale") then
        local scale
        local v40 = TweenInfo.new
        local v41 = a36 and 0.06 or 0.12
        v40 = v40(v41, Enum.EasingStyle.Quad)
        local propertyTable = {}

        if a36 then
            scale = 0.92
        else
            scale = 1
        end

        propertyTable.Scale = scale
        tweenService:Create(uiScale, v40, propertyTable):Play()
    end
end

local function bindHold(button: TextButton?, callback, callback2)
    --[[
      name: bindHold
      line: 113
      upvalues:
        setPressed (copy, index: 1)
        TouchStart (copy, index: 2)
        userInputService (copy, index: 3)
    ]]
    local inputObject = nil

    button.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 115
              upvalues:
                inputObject (ref,  index: 1)
                setPressed (copy, index: 2)
                button (copy, index: 3)
                callback2 (copy, index: 4)
                TouchStart (copy, index: 5)
                callback (copy, index: 6)
            ]]
            local userInputType = input.UserInputType

            if userInputType ~= Enum.UserInputType.Touch and userInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end

            local inputObject2 = inputObject

            if inputObject2
                and inputObject2.UserInputState ~= Enum.UserInputState.Begin
                and inputObject2.UserInputState ~= Enum.UserInputState.Change
            then
                inputObject = nil
                setPressed(button, false)
                callback2()
            end

            if inputObject or not TouchStart.BeganOn(button, input) then
                return
            end

            inputObject = input
            setPressed(button, true)
            callback()
        end
    )

    userInputService.InputEnded:Connect(
        function(input: InputObject)
            --[[
              line: 135
              upvalues:
                inputObject (ref,  index: 1)
                setPressed (copy, index: 2)
                button (copy, index: 3)
                callback2 (copy, index: 4)
            ]]
            if input == inputObject then
                inputObject = nil
                setPressed(button, false)
                callback2()
            end
        end
    )

    button:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 143
              upvalues:
                button (copy, index: 1)
                inputObject (ref,  index: 2)
                setPressed (copy, index: 3)
                callback2 (copy, index: 4)
            ]]
            if not button.Visible and inputObject then
                inputObject = nil
                setPressed(button, false)
                callback2()
            end
        end
    )
end

local function readOverride(screenGui: ScreenGui?, name: string, absoluteSize: Vector2, offset: number)
    --[[
      name: readOverride
      line: 156
    ]]
    local text = screenGui:GetAttribute("Override_" .. name)

    if type(text) ~= "string" then
        return nil, nil
    end

    local v58, v59, v60 = string.match(text, "^(%-?%d+),(%-?%d+),(%d+)$")
    if not v58 then
        return nil, nil
    end

    local flooredValue = math.floor(((tonumber(v60) / 1000) * offset) + 0.5)

    return UDim2.fromOffset((tonumber(v58) / 1000) * absoluteSize.X, tonumber(v59) / 1000 * absoluteSize.Y), (math.max(flooredValue, 24))
end

local function layout()
    --[[
      name: layout
      line: 169
      upvalues:
        frame (ref,  index: 1)
        button (ref,  index: 2)
        button2 (ref,  index: 3)
        button3 (ref,  index: 4)
        screenGui (ref,  index: 5)
        readOverride (copy, index: 6)
    ]]
    local frame2 = frame
    local button4 = button
    local button5 = button2
    local button6 = button3

    if not frame2 or not button4 or not button5 or not button6 or not screenGui then
        return
    end

    local absoluteSize = frame2.AbsoluteSize

    if absoluteSize.X < 10 or absoluteSize.Y < 10 then
        return
    end

    local scale = math.clamp(math.min(absoluteSize.X, absoluteSize.Y) / 360, 0.85, 1.45)
    local flooredValue = math.floor(scale * 84)
    local flooredValue2 = math.floor(scale * 64)
    local v71 = absoluteSize.X - (scale * 18) - flooredValue / 2
    local v72 = absoluteSize.Y - (scale * 14) - flooredValue / 2
    button4.Size = UDim2.fromOffset(flooredValue, flooredValue)
    button4.Position = UDim2.fromOffset(v71, v72)
    button4.TextSize = math.floor(scale * 17)
    local v73 = (v71 - (flooredValue / 2)) - (scale * 14) - flooredValue2 / 2
    local v74 = absoluteSize.Y - (scale * 14) - flooredValue2 / 2
    button5.Size = UDim2.fromOffset(flooredValue2, flooredValue2)
    button5.Position = UDim2.fromOffset(v73, v74)
    button5.TextSize = math.floor(scale * 14)
    local v75 = math.max(44, (math.floor(scale * 48)))
    button6.Size = UDim2.fromOffset(v75, v75)
    button6.Position = UDim2.fromOffset(((v73 - (flooredValue2 / 2)) - (scale * 14)) - (v75 / 2), absoluteSize.Y - (scale * 14) - (v75 / 2))
    button6.TextSize = math.floor(scale * 13)

    for _, textButton in {button4, button5, button6} do
        textButton:SetAttribute("DefaultSize", textButton.Size.X.Offset)
        local position, v79 = readOverride(screenGui, textButton.Name, absoluteSize, textButton.Size.X.Offset)

        if position and v79 then
            textButton.Position = position
            textButton.Size = UDim2.fromOffset(v79, v79)
            textButton.TextSize = math.floor(v79 * 0.2)
        end
    end

    local v80 = math.huge
    local v81 = math.huge

    for _, textButton in {button4, button5, button6} do
        v80 = math.min(v80, textButton.Position.X.Offset - (textButton.Size.X.Offset / 2))
        v81 = math.min(v81, textButton.Position.Y.Offset - (textButton.Size.Y.Offset / 2))
    end

    local absolutePosition = frame2.AbsolutePosition
    screenGui:SetAttribute("Scale", scale)
    screenGui:SetAttribute("ReservedMinX", (math.floor((absolutePosition.X + v80) - (scale * 10))))
    screenGui:SetAttribute("ReservedMinY", (math.floor((absolutePosition.Y + v81) - (scale * 10))))
end

local function touchPreferred()
    --[[
      name: touchPreferred
      line: 217
      upvalues:
        userInputService (copy, index: 1)
    ]]
    local success, preferredInput = pcall(
        function()
            --[[
              line: 218
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput
        end
    )

    if success and typeof(preferredInput) == "EnumItem" then
        return preferredInput.Name == "Touch"
    end
    if not userInputService.TouchEnabled then
        return false
    end

    local lastInputType = userInputService:GetLastInputType()

    if lastInputType == Enum.UserInputType.Touch then
        return true
    end

    return not userInputService.KeyboardEnabled
end

local function menuOpen()
    --[[
      name: menuOpen
      line: 234
      upvalues:
        localPlayer (copy, index: 1)
        guiService (copy, index: 2)
        Camera (copy, index: 3)
        v26 (copy, index: 4)
    ]]
    if localPlayer:GetAttribute("MenuOpen") == true or guiService.MenuIsOpen then
        return true
    end

    for _, unlockReason in Camera.GetUnlockReasons() do
        if not v26[unlockReason] then
            return true
        end
    end

    return false
end

local function characterAlive()
    --[[
      name: characterAlive
      line: 246
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChildOfClass("Humanoid")

    if not instance or instance.Health <= 0 then
        return false
    end

    local v94 = localPlayer:GetAttribute("State") == "Match" and localPlayer:GetAttribute("Alive") == false

    return not v94
end

local function robloxJumpButton()
    --[[
      name: robloxJumpButton
      line: 256
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local instance = localPlayer:FindFirstChildOfClass("PlayerGui")
    instance = instance and instance:FindFirstChild("TouchGui")
    local touchControlFrame = instance and instance:FindFirstChild("TouchControlFrame")
    local jumpButton = touchControlFrame and touchControlFrame:FindFirstChild("JumpButton")

    if jumpButton and jumpButton:IsA("GuiObject") then
        return jumpButton
    end

    return nil
end

local instance = nil

local function enforceRobloxJump()
    --[[
      name: enforceRobloxJump
      line: 265
      upvalues:
        robloxJumpButton (copy, index: 1)
        instance (ref,  index: 2)
        v24 (ref,  index: 3)
    ]]
    local instance2 = robloxJumpButton()
    if not instance2 then
        return
    end

    if instance2 ~= instance then
        instance = instance2

        instance2:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 272
                  upvalues:
                    v24 (ref,  index: 1)
                    instance2 (copy, index: 2)
                ]]
                if v24 and instance2.Visible then
                    instance2.Visible = false
                end
            end
        )
    end

    if v24 and instance2.Visible then
        instance2.Visible = false
    end
end

local function refresh()
    --[[
      name: refresh
      line: 283
      upvalues:
        screenGui (ref,  index: 1)
        runService (copy, index: 2)
        v24 (ref,  index: 3)
        touchPreferred (copy, index: 4)
        localPlayer (copy, index: 5)
        guiService (copy, index: 6)
        Camera (copy, index: 7)
        v26 (copy, index: 8)
        v23 (ref,  index: 9)
        Movement (copy, index: 10)
        button3 (ref,  index: 11)
        frozen (ref,  index: 12)
        button (ref,  index: 13)
        button2 (ref,  index: 14)
        color32 (copy, index: 15)
        enforceRobloxJump (copy, index: 16)
    ]]
    local v103
    local screenGui2 = screenGui
    if not screenGui2 then
        return
    end

    local forceVisible = runService:IsStudio() and screenGui2:GetAttribute("ForceVisible") == true
    v24 = touchPreferred() or forceVisible

    if v24 then
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local v108 = if humanoid and not (humanoid.Health <= 0) then not (localPlayer:GetAttribute("State") == "Match"
            and localPlayer:GetAttribute("Alive") == false) else false

        if v108 then
            local v109

            if localPlayer:GetAttribute("MenuOpen") == true or guiService.MenuIsOpen then
                v109 = true
            else
                v109 = false

                for _, unlockReason in Camera.GetUnlockReasons() do
                    if not v26[unlockReason] then
                        v109 = true
                        break
                    end
                end
            end

            v103 = not v109
            v103 = v103 or screenGui2:GetAttribute("EditPreview") == true
        else
            v103 = screenGui2:GetAttribute("EditPreview") == true
        end
    else
        v103 = screenGui2:GetAttribute("EditPreview") == true
    end

    if v103 ~= v23 then
        v23 = v103
        screenGui2.Enabled = v103

        if not v103 then
            Movement.SetJumpHeld(false)
            Movement.SetSlideHeld(false)
        end
    end

    if const button4 = button3 then
        local v113 = v23 and (Camera.GetMode() == "combat" or screenGui2:GetAttribute("EditPreview") == true)

        if button4.Visible ~= v113 then
            button4.Visible = v113
        end

        local text = Camera.IsFirstPerson and Camera.IsFirstPerson() and "1P" or "3P"

        if button4.Text ~= text then
            button4.Text = text
        end
    end

    local frozen2 = localPlayer:GetAttribute("Frozen") == true

    if frozen2 ~= frozen then
        frozen = frozen2

        for _, textButton in {button, button2} do
            if textButton then
                textButton.TextTransparency = frozen2 and 0.55 or 0
                local uiStroke = textButton:FindFirstChildOfClass("UIStroke")
                if not uiStroke then
                    continue
                end
                if uiStroke.Color == color32 then
                    continue
                end

                uiStroke.Transparency = frozen2 and 0.92 or 0.8
            end
        end
    end

    enforceRobloxJump()
end

function v11.IsVisible()
    --[[
      name: IsVisible
      line: 327
      upvalues:
        v23 (ref, index: 1)
    ]]
    return v23
end

local function gateRobloxTouch()
    --[[
      name: gateRobloxTouch
      line: 344
      upvalues:
        localPlayer (copy, index: 1)
        runService (copy, index: 2)
    ]]
    if localPlayer:GetAttribute("TouchControlsReady") == true then
        return
    end

    if not localPlayer.Character then
        localPlayer:SetAttribute("TouchControlsReady", false)
    end

    task.spawn(
        function()
            --[[
              line: 351
              upvalues:
                localPlayer (copy, index: 1)
                runService (copy, index: 2)
            ]]
            if not localPlayer.Character then
                localPlayer.CharacterAdded:Wait()
            end

            local timestamp = os.clock()
            local count = 0

            while count < 6 or os.clock() - timestamp < 0.3 do
                runService.RenderStepped:Wait()
                count += 1
            end

            localPlayer:SetAttribute("TouchControlsReady", true)
        end
    )
end

local hasRun = false

function v11.Start()
    --[[
      name: Start
      line: 365
      upvalues:
        hasRun (ref,  index: 1)
        gateRobloxTouch (copy, index: 2)
        localPlayer (copy, index: 3)
        frame (ref,  index: 4)
        button (ref,  index: 5)
        makeButton (copy, index: 6)
        button2 (ref,  index: 7)
        bindHold (copy, index: 8)
        Movement (copy, index: 9)
        button3 (ref,  index: 10)
        Camera (copy, index: 11)
        refresh (copy, index: 12)
        screenGui (ref,  index: 13)
        layout (copy, index: 14)
        userInputService (copy, index: 15)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    gateRobloxTouch()
    local playerGui = localPlayer:WaitForChild("PlayerGui")
    local characterTouch = Instance.new("ScreenGui")
    characterTouch.Name = "CharacterTouch"
    characterTouch.ResetOnSpawn = false
    characterTouch.IgnoreGuiInset = true
    characterTouch.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    characterTouch.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    characterTouch.DisplayOrder = 3
    characterTouch.Enabled = false

    local buttons = Instance.new("Frame")
    buttons.Name = "Buttons"
    buttons.BackgroundTransparency = 1
    buttons.Size = UDim2.fromScale(1, 1)
    buttons.Parent = characterTouch
    frame = buttons
    button = makeButton(buttons, "Jump", "JUMP")
    button2 = makeButton(buttons, "Slide", "SLIDE")
    bindHold(
        button,
        function()
            --[[
              line: 388
              upvalues:
                Movement (copy, index: 1)
            ]]
            Movement.SetJumpHeld(true)
        end,
        function()
            --[[
              line: 390
              upvalues:
                Movement (copy, index: 1)
            ]]
            Movement.SetJumpHeld(false)
        end
    )
    bindHold(
        button2,
        function()
            --[[
              line: 393
              upvalues:
                Movement (copy, index: 1)
            ]]
            Movement.SetSlideHeld(true)
        end,
        function()
            --[[
              line: 395
              upvalues:
                Movement (copy, index: 1)
            ]]
            Movement.SetSlideHeld(false)
        end
    )
    button3 = makeButton(buttons, "View", "3P")

    bindHold(
        button3,
        function()
            --[[
              line: 399
              upvalues:
                Camera (copy, index: 1)
                refresh (copy, index: 2)
            ]]
            if Camera.ToggleFirstPerson then
                Camera.ToggleFirstPerson()
            end

            task.defer(refresh)
        end,
        function()
            --[[
              line: 404
            ]]
        end
    )

    screenGui = characterTouch
    characterTouch.Parent = playerGui
    buttons:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)

    characterTouch.AttributeChanged:Connect(
        function(attribute: string)
            --[[
              line: 408
              upvalues:
                layout (copy, index: 1)
                refresh (copy, index: 2)
            ]]
            if string.sub(attribute, 1, 9) ~= "Override_" then
                if attribute == "EditPreview" then
                    task.defer(refresh)
                end
            else
                layout()
            end
        end
    )

    buttons:GetPropertyChangedSignal("AbsolutePosition"):Connect(layout)
    layout()

    task.spawn(
        function()
            --[[
              line: 419
              upvalues:
                refresh (copy, index: 1)
            ]]
            while true do
                pcall(refresh)
                task.wait(0.1)
            end
        end
    )

    userInputService.LastInputTypeChanged:Connect(
        function()
            --[[
              line: 425
              upvalues:
                refresh (copy, index: 1)
            ]]
            task.defer(refresh)
        end
    )
end

return v11