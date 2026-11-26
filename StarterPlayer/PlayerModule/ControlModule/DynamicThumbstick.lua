local localPlayer
local v2 = {0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75}
local v3 = {0.55, 0.65, 0.7, 0.75, 0.8, 0.85, 0.875}
local endIndex = #v2
local vector2 = Vector2.new(-1, -1)
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v8 = CommonUtils.get("FlagUtil")
local userFlag = v8.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v8.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v8.getUserFlag("UserAllowAbilityControlsBonus")
local userFlag3 = v8.getUserFlag("UserDoubleJumpButtonFix")
local userFlag4 = v8.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local players = game:GetService("Players")
local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local inputContexts = script.Parent.Parent:WaitForChild("InputContexts")
local v18 = inputContexts:WaitForChild("TransformerContext")
local thumbstickAction = v18:WaitForChild("ThumbstickAction")
v18 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v20 = if userFlag then v18.get(players.LocalPlayer) else nil

if const localPlayer2 = players.LocalPlayer then
    localPlayer = localPlayer2
else
    players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    localPlayer = players.LocalPlayer
end

local ActionController = require(script.Parent:WaitForChild("ActionController"))
local v23 = setmetatable({}, ActionController)
v23.__index = v23

function v23.new(data)
    --[[
      name: new
      line: 70
      upvalues:
        ActionController (copy, index: 1)
        v23 (copy, index: 2)
    ]]
    local v25 = setmetatable(ActionController.new(), v23)
    v25.data = data
    v25.enabled = false
    v25.isTouchActive = false
    v25.moveTouchFirstChanged = false
    v25.moveTouchStartPosition = nil
    v25.startImage = nil
    v25.endImage = nil
    v25.endImageStroke = nil
    v25.endImageCenter = nil
    v25.middleImages = {}
    v25.startImageFadeTween = nil
    v25.endImageFadeTween = nil
    v25.endImageCenterFadeTween = nil
    v25.middleImageFadeTweens = {}
    v25.isFirstTouch = true
    v25.thumbstickFrame = nil
    v25.onRenderSteppedConn = nil
    v25.fadeInAndOutBalance = 0.5
    v25.fadeInAndOutHalfDuration = 0.3
    v25.hasFadedBackgroundInPortrait = false
    v25.hasFadedBackgroundInLandscape = false
    v25.tweenInAlphaStart = nil
    v25.tweenOutAlphaStart = nil
    v25.newStyle = false
    return v25
end

function v23.GetIsJumping(a26)
    --[[
      name: GetIsJumping
      line: 112
    ]]
    local isJumping = a26.isJumping
    a26.isJumping = false

    return isJumping
end

local function setupThumbstickInput(a29)
    --[[
      name: setupThumbstickInput
      line: 118
      upvalues:
        thumbstickAction (copy, index: 1)
    ]]
    for _, child in thumbstickAction:GetChildren() do
        if child.Name == "DynamicTouchBinding" or child.Name == "ClassicTouchBinding" then
            child:Destroy()
        end
    end

    local dynamicTouchBinding = Instance.new("InputBinding")
    dynamicTouchBinding.Name = "DynamicTouchBinding"
    dynamicTouchBinding.KeyCode = Enum.KeyCode.TouchPosition
    dynamicTouchBinding.UIModifier = a29.thumbstickButton
    dynamicTouchBinding.Parent = thumbstickAction
end

local function enableThumbstickInput(a34, a35)
    --[[
      name: enableThumbstickInput
      line: 131
      upvalues:
        setupThumbstickInput (copy, index: 1)
        thumbstickAction (copy, index: 2)
    ]]
    if a35 then
        setupThumbstickInput(a34)
        a34.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a34.onStateChanged)
        thumbstickAction.Enabled = true

        return
    end

    thumbstickAction.Enabled = false

    if a34.thumbstickStateChangedConn then
        a34.thumbstickStateChangedConn:Disconnect()
        a34.thumbstickStateChangedConn = nil
    end
end

function v23.Enable(a36, a37, a38)
    --[[
      name: Enable
      line: 145
      upvalues:
        ActionController (copy, index: 1)
        userFlag (copy, index: 2)
        v20 (copy, index: 3)
        userFlag4 (copy, index: 4)
        setupThumbstickInput (copy, index: 5)
        thumbstickAction (copy, index: 6)
    ]]
    if a37 == nil then
        return false
    end

    local v39 = not not a37
    a37 = v39

    if a36.enabled == a37 then
        return true
    end

    ActionController.Enable(a36, a37)

    if a37 then
        if not a36.thumbstickFrame then
            a36:Create(a38)

            if userFlag and not a36.avatarAbilitiesEnabledChangedConn then
                a36.avatarAbilitiesEnabledChangedConn = v20:GetEnabledChangedSignal():Connect(
                    function()
                        --[[
                          line: 162
                          upvalues:
                            a36 (copy, index: 1)
                            a38 (copy, index: 2)
                            userFlag4 (copy, index: 3)
                            setupThumbstickInput (copy, index: 4)
                            thumbstickAction (copy, index: 5)
                        ]]
                        if a36.enabled then
                            a36:Create(a38)

                            if userFlag4 then
                                setupThumbstickInput(a36)
                                a36.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a36.onStateChanged)
                                thumbstickAction.Enabled = true
                            else
                                a36.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a36.onStateChanged)
                                thumbstickAction.Enabled = true
                            end

                            a36.thumbstickFrame.Visible = true
                        end
                    end
                )
            end
        end

        if userFlag4 then
            setupThumbstickInput(a36)
            a36.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a36.onStateChanged)
            thumbstickAction.Enabled = true
        else
            a36.thumbstickStateChangedConn = thumbstickAction.StateChanged:Connect(a36.onStateChanged)
            thumbstickAction.Enabled = true
        end
    else
        if userFlag4 then
            thumbstickAction.Enabled = false

            if a36.thumbstickStateChangedConn then
                a36.thumbstickStateChangedConn:Disconnect()
                a36.thumbstickStateChangedConn = nil
            end
        else
            thumbstickAction.Enabled = false

            if a36.thumbstickStateChangedConn then
                a36.thumbstickStateChangedConn:Disconnect()
                a36.thumbstickStateChangedConn = nil
            end
        end

        a36:OnInputEnded()
    end

    a36.enabled = v39
    a36.thumbstickFrame.Visible = v39

    return nil
end

function v23.OnInputEnded(a40)
    --[[
      name: OnInputEnded
      line: 204
    ]]
    a40.isTouchActive = false

    if const dynamicThumbstickScriptableBinding = a40.data.controlModule.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding") then
        dynamicThumbstickScriptableBinding:Fire(Vector2.zero)
    end

    a40:FadeThumbstick(false)
end

function v23.FadeThumbstick(a42, a43)
    --[[
      name: FadeThumbstick
      line: 213
      upvalues:
        userFlag (copy, index: 1)
        tweenService (copy, index: 2)
        tweenInfo (copy, index: 3)
        v3 (copy, index: 4)
        v2 (copy, index: 5)
    ]]
    if not a43 and a42.isTouchActive then
        return
    end
    if a42.isFirstTouch then
        return
    end

    if a42.startImageFadeTween then
        a42.startImageFadeTween:Cancel()
    end

    if a42.endImageFadeTween then
        a42.endImageFadeTween:Cancel()
    end

    if userFlag and a42.endImageCenterFadeTween then
        a42.endImageCenterFadeTween:Cancel()
    end

    for middleImageFadeTweenKey = 1, #a42.middleImages do
        if a42.middleImageFadeTweens[middleImageFadeTweenKey] then
            a42.middleImageFadeTweens[middleImageFadeTweenKey]:Cancel()
        end
    end

    if a43 then
        if userFlag and a42.newStyle then
            a42.startImageFadeTween = tweenService:Create(a42.startImage, tweenInfo, {BackgroundTransparency = 0.4})
            a42.startImageFadeTween:Play()
            a42.endImageFadeTween = tweenService:Create(a42.endImageStroke, tweenInfo, {Transparency = 0})
            a42.endImageFadeTween:Play()
            a42.endImageCenterFadeTween = tweenService:Create(a42.endImageCenter, tweenInfo, {BackgroundTransparency = 0})
            a42.endImageCenterFadeTween:Play()
        else
            a42.startImageFadeTween = tweenService:Create(a42.startImage, tweenInfo, {ImageTransparency = 0})
            a42.startImageFadeTween:Play()
            a42.endImageFadeTween = tweenService:Create(a42.endImage, tweenInfo, {ImageTransparency = 0.2})
            a42.endImageFadeTween:Play()
        end

        for v45 = 1, #a42.middleImages do
            local v46 = false

            if userFlag then
                if a42.newStyle then
                    a42.middleImageFadeTweens[v45] = tweenService:Create(a42.middleImages[v45], tweenInfo, {BackgroundTransparency = v3[v45]})
                else
                    v46 = true
                end
            else
                v46 = true
            end

            if v46 then
                a42.middleImageFadeTweens[v45] = tweenService:Create(a42.middleImages[v45], tweenInfo, {ImageTransparency = v2[v45]})
            end

            a42.middleImageFadeTweens[v45]:Play()
        end

        return
    end

    if userFlag and a42.newStyle then
        a42.startImageFadeTween = tweenService:Create(a42.startImage, tweenInfo, {BackgroundTransparency = 1})
        a42.startImageFadeTween:Play()
        a42.endImageFadeTween = tweenService:Create(a42.endImageStroke, tweenInfo, {Transparency = 1})
        a42.endImageFadeTween:Play()
        a42.endImageCenterFadeTween = tweenService:Create(a42.endImageCenter, tweenInfo, {BackgroundTransparency = 1})
        a42.endImageCenterFadeTween:Play()
    else
        a42.startImageFadeTween = tweenService:Create(a42.startImage, tweenInfo, {ImageTransparency = 1})
        a42.startImageFadeTween:Play()
        a42.endImageFadeTween = tweenService:Create(a42.endImage, tweenInfo, {ImageTransparency = 1})
        a42.endImageFadeTween:Play()
    end

    for v47 = 1, #a42.middleImages do
        local v48 = false

        if userFlag then
            if a42.newStyle then
                a42.middleImageFadeTweens[v47] = tweenService:Create(a42.middleImages[v47], tweenInfo, {BackgroundTransparency = 1})
            else
                v48 = true
            end
        else
            v48 = true
        end

        if v48 then
            a42.middleImageFadeTweens[v47] = tweenService:Create(a42.middleImages[v47], tweenInfo, {ImageTransparency = 1})
        end

        a42.middleImageFadeTweens[v47]:Play()
    end
end

function v23.FadeThumbstickFrame(a49, a50, fadeInAndOutBalance)
    --[[
      name: FadeThumbstickFrame
      line: 311
    ]]
    a49.fadeInAndOutHalfDuration = a50 * 0.5
    a49.fadeInAndOutBalance = fadeInAndOutBalance
    a49.tweenInAlphaStart = tick()
end

function v23.DoFadeInBackground(a52)
    --[[
      name: DoFadeInBackground
      line: 317
      upvalues:
        localPlayer (ref, index: 1)
    ]]
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    local v54 = false

    if playerGui then
        if playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft
            or playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
        then
            v54 = a52.hasFadedBackgroundInLandscape
            a52.hasFadedBackgroundInLandscape = true
        elseif playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v54 = a52.hasFadedBackgroundInPortrait
            a52.hasFadedBackgroundInPortrait = true
        end
    end

    if not v54 then
        a52.fadeInAndOutHalfDuration = 0.3
        a52.fadeInAndOutBalance = 0.5
        a52.tweenInAlphaStart = tick()
    end
end

function v23.DoMove(a55, a56)
    --[[
      name: DoMove
      line: 342
    ]]
    local v57 = a56
    local v58 = if v57.Magnitude < a55.radiusOfDeadZone then Vector2.new() else v57.Unit * (1 - math.max(0, (a55.radiusOfMaxSpeed - v57.Magnitude) / a55.radiusOfMaxSpeed))
    local vector2 = Vector2.new(v58.X, -v58.Y)

    if const dynamicThumbstickScriptableBinding = a55.data.controlModule.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding") then
        dynamicThumbstickScriptableBinding:Fire(vector2)
    end
end

function v23.LayoutMiddleImages(a61, a62, a63)
    --[[
      name: LayoutMiddleImages
      line: 361
      upvalues:
        endIndex (copy, index: 1)
    ]]
    local v64 = a61.thumbstickSize / 2 + a61.middleSize
    local v65 = a63 - a62
    local v66 = v65.Magnitude - (a61.thumbstickRingSize / 2) - a61.middleSize
    local unit = v65.Unit
    local v68 = a61.middleSpacing * endIndex
    local v69 = a61.middleSpacing

    if v68 < v66 then
        v69 = v66 / endIndex
    end

    for middleImageKey = 1, endIndex do
        local middleImage = a61.middleImages[middleImageKey]
        local v72 = v64 + v69 * (middleImageKey - 2)
        local v73 = v64 + v69 * (middleImageKey - 1)

        if v72 < v66 then
            local v74 = a63 - unit * v73
            local clampedValue = math.clamp(1 - ((v73 - v66) / v69), 0, 1)
            middleImage.Visible = true
            middleImage.Position = UDim2.new(0, v74.X, 0, v74.Y)
            middleImage.Size = UDim2.new(0, a61.middleSize * clampedValue, 0, a61.middleSize * clampedValue)
        else
            middleImage.Visible = false
        end
    end
end

function v23.MoveStick(a76, a77)
    --[[
      name: MoveStick
      line: 392
    ]]
    local v78 = Vector2.new(a76.moveTouchStartPosition.X, a76.moveTouchStartPosition.Y) - a76.thumbstickFrame.AbsolutePosition
    local v79 = Vector2.new(a77.X, a77.Y) - a76.thumbstickFrame.AbsolutePosition
    a76.endImage.Position = UDim2.new(0, v79.X, 0, v79.Y)
    a76:LayoutMiddleImages(v78, v79)
end

function v23.Create(a80, parent)
    --[[
      name: Create
      line: 400
      upvalues:
        userFlag4 (copy, index: 1)
        thumbstickAction (copy, index: 2)
        userFlag (copy, index: 3)
        v20 (copy, index: 4)
        userFlag3 (copy, index: 5)
        endIndex (copy, index: 6)
        v3 (copy, index: 7)
        v2 (copy, index: 8)
        v18 (copy, index: 9)
        userFlag2 (copy, index: 10)
        runService (copy, index: 11)
        vector2 (copy, index: 12)
        guiService (copy, index: 13)
        tweenService (copy, index: 14)
        localPlayer (ref,  index: 15)
    ]]
    local playerGui

    if a80.thumbstickFrame then
        if userFlag4 then
            thumbstickAction.Enabled = false

            if a80.thumbstickStateChangedConn then
                a80.thumbstickStateChangedConn:Disconnect()
                a80.thumbstickStateChangedConn = nil
            end
        else
            thumbstickAction.Enabled = false

            if a80.thumbstickStateChangedConn then
                a80.thumbstickStateChangedConn:Disconnect()
                a80.thumbstickStateChangedConn = nil
            end
        end

        a80.thumbstickFrame:Destroy()
        a80.thumbstickFrame = nil

        if a80.onRenderSteppedConn then
            a80.onRenderSteppedConn:Disconnect()
            a80.onRenderSteppedConn = nil
        end

        if a80.absoluteSizeChangedConn then
            a80.absoluteSizeChangedConn:Disconnect()
            a80.absoluteSizeChangedConn = nil
        end

        if not userFlag and a80.avatarAbilitiesEnabledChangedConn then
            a80.avatarAbilitiesEnabledChangedConn:Disconnect()
            a80.avatarAbilitiesEnabledChangedConn = nil
        end

        if userFlag then
            if a80.cameraChangedConn then
                a80.cameraChangedConn:Disconnect()
                a80.cameraChangedConn = nil
            end

            if a80.currentCameraChangedConn then
                a80.currentCameraChangedConn:Disconnect()
                a80.currentCameraChangedConn = nil
            end

            if a80.menuOpenedConnection then
                a80.menuOpenedConnection:Disconnect()
                a80.menuOpenedConnection = nil
            end

            if a80.playerGuiChangedConn then
                a80.playerGuiChangedConn:Disconnect()
                a80.playerGuiChangedConn = nil
            end
        end
    end

    local function layoutThumbstickFrame(a84: boolean)
        --[[
          name: layoutThumbstickFrame
          line: 448
          upvalues:
            a80 (copy, index: 1)
        ]]
        if a84 then
            a80.thumbstickFrame.Size = UDim2.new(1, 100, 0.4, 100)
            a80.thumbstickFrame.Position = UDim2.new(0, -100, 0.6, 0)

            return
        end

        a80.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
        a80.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
    end

    local newStyle = userFlag and v20:isEnabled()
    a80.newStyle = newStyle
    a80.thumbstickFrame = Instance.new("Frame")
    a80.thumbstickFrame.BorderSizePixel = 0
    a80.thumbstickFrame.Name = "DynamicThumbstickFrame"
    a80.thumbstickFrame.Visible = false
    a80.thumbstickFrame.BackgroundTransparency = 1
    a80.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    a80.thumbstickFrame.Active = false
    a80.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
    a80.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
    a80.thumbstickButton = Instance.new("ImageButton")
    a80.thumbstickButton.Name = "DynamicThumbstickUIModifier"
    a80.thumbstickButton.BackgroundTransparency = 1
    a80.thumbstickButton.ImageTransparency = 1
    a80.thumbstickButton.AutoButtonColor = false
    a80.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    a80.thumbstickButton.ZIndex = a80.thumbstickFrame.ZIndex
    a80.thumbstickButton.Visible = true
    a80.thumbstickButton.Active = false
    a80.thumbstickButton.Parent = a80.thumbstickFrame

    if not userFlag4 then
        local v86 = nil

        if userFlag3 then
            v86 = thumbstickAction:FindFirstChild("DynamicTouchBinding")
        end

        if not v86 then
            v86 = Instance.new("InputBinding")
            v86.Name = "DynamicTouchBinding"
            v86.KeyCode = Enum.KeyCode.TouchPosition
            v86.Parent = thumbstickAction
        end

        v86.UIModifier = a80.thumbstickButton
    end

    if not userFlag or not a80.newStyle then
        a80.startImage = Instance.new("ImageLabel")
        a80.startImage.Name = "ThumbstickStart"
        a80.startImage.Visible = true
        a80.startImage.BackgroundTransparency = 1
        a80.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a80.startImage.ImageRectOffset = Vector2.new(1, 1)
        a80.startImage.ImageRectSize = Vector2.new(144, 144)
        a80.startImage.ImageColor3 = Color3.new(0, 0, 0)
        a80.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a80.startImage.ZIndex = 10
        a80.startImage.Parent = a80.thumbstickFrame
        a80.endImage = Instance.new("ImageLabel")
        a80.endImage.Name = "ThumbstickEnd"
        a80.endImage.Visible = true
        a80.endImage.BackgroundTransparency = 1
        a80.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a80.endImage.ImageRectOffset = Vector2.new(1, 1)
        a80.endImage.ImageRectSize = Vector2.new(144, 144)
        a80.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a80.endImage.ZIndex = 10
        a80.endImage.Parent = a80.thumbstickFrame

        for middleImageKey = 1, endIndex do
            a80.middleImages[middleImageKey] = Instance.new("ImageLabel")
            a80.middleImages[middleImageKey].Name = "ThumbstickMiddle"
            a80.middleImages[middleImageKey].Visible = false
            a80.middleImages[middleImageKey].BackgroundTransparency = 1
            a80.middleImages[middleImageKey].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            a80.middleImages[middleImageKey].ImageRectOffset = Vector2.new(1, 1)
            a80.middleImages[middleImageKey].ImageRectSize = Vector2.new(144, 144)
            a80.middleImages[middleImageKey].ImageTransparency = v2[middleImageKey]
            a80.middleImages[middleImageKey].AnchorPoint = Vector2.new(0.5, 0.5)
            a80.middleImages[middleImageKey].ZIndex = 9
            a80.middleImages[middleImageKey].Parent = a80.thumbstickFrame
        end
    else
        a80.startImage = Instance.new("Frame")
        a80.startImage.Name = "ThumbstickStart"
        a80.startImage.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        a80.startImage.BackgroundTransparency = 0.4
        a80.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a80.startImage.ZIndex = 10
        a80.startImage.Parent = a80.thumbstickFrame
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0.5, 0)
        uiCorner.Parent = a80.startImage
        a80.endImage = Instance.new("Frame")
        a80.endImage.Name = "ThumbstickEnd"
        a80.endImage.BackgroundTransparency = 1
        a80.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a80.endImage.ZIndex = 10
        a80.endImage.Parent = a80.thumbstickFrame
        local uiCorner2 = Instance.new("UICorner")
        uiCorner2.CornerRadius = UDim.new(0.5, 0)
        uiCorner2.Parent = a80.endImage
        a80.endImageStroke = Instance.new("UIStroke")
        a80.endImageStroke.Thickness = userFlag3 and 1.5 or 2
        a80.endImageStroke.Color = Color3.fromRGB(213, 215, 221)
        a80.endImageStroke.Parent = a80.endImage
        a80.endImageCenter = Instance.new("Frame")
        a80.endImageCenter.Name = "ThumbstickEndCenter"
        a80.endImageCenter.BackgroundTransparency = 0
        a80.endImageCenter.BackgroundColor3 = Color3.fromRGB(213, 215, 221)
        a80.endImageCenter.AnchorPoint = Vector2.new(0.5, 0.5)
        a80.endImageCenter.Size = UDim2.new(0.74, 0, 0.74, 0)
        a80.endImageCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
        a80.endImageCenter.ZIndex = 10
        a80.endImageCenter.Parent = a80.endImage
        local uiCorner3 = Instance.new("UICorner")
        uiCorner3.CornerRadius = UDim.new(0.5, 0)
        uiCorner3.Parent = a80.endImageCenter

        for middleImageKey = 1, endIndex do
            a80.middleImages[middleImageKey] = Instance.new("Frame")
            a80.middleImages[middleImageKey].Name = "ThumbstickMiddle"
            a80.middleImages[middleImageKey].Visible = false
            a80.middleImages[middleImageKey].BackgroundTransparency = v3[middleImageKey]
            a80.middleImages[middleImageKey].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            a80.middleImages[middleImageKey].AnchorPoint = Vector2.new(0.5, 0.5)
            a80.middleImages[middleImageKey].ZIndex = 9
            a80.middleImages[middleImageKey].Parent = a80.thumbstickFrame
            local uiCorner4 = Instance.new("UICorner")
            uiCorner4.CornerRadius = UDim.new(0.5, 0)
            uiCorner4.Parent = a80.middleImages[middleImageKey]
        end
    end

    local function ResizeThumbstick()
        --[[
          name: ResizeThumbstick
          line: 590
          upvalues:
            parent (copy, index: 1)
            userFlag (copy, index: 2)
            a80 (copy, index: 3)
            v18 (copy, index: 4)
            userFlag2 (copy, index: 5)
        ]]
        local absoluteSize = parent.AbsoluteSize
        local v95 = 500 < math.min(absoluteSize.X, absoluteSize.Y)
        local v96 = v95 and 2 or 1
        local v97 = if userFlag then a80.newStyle else v18.isEnabled()

        if userFlag2 and v97 and v95 then
            v96 = 1.6216216216216217
        end

        a80.thumbstickSize = 45 * v96
        a80.thumbstickRingSize = 20 * v96
        a80.middleSize = 10 * v96
        a80.middleSpacing = 14 * v96
        a80.radiusOfDeadZone = 2 * v96
        a80.radiusOfMaxSpeed = 20 * v96
        local v98 = 74 * v96

        if not userFlag or a80.isFirstTouch then
            if v97 then
                local v99 = v95 and 100 or 64
                local v100 = v95 and 112 or 64
                a80.startImage.Position = UDim2.new(0, ((v98 * 0.5) + 100) + v99, 1, ((-v98 * 0.5) - 100) - v100)
                a80.startImage.Size = UDim2.new(0, v98, 0, v98)
            else
                a80.startImage.Position = UDim2.new(0, (a80.thumbstickRingSize * 3.3) + 100, 1, (-a80.thumbstickRingSize * 2.8) - 100)
                a80.startImage.Size = UDim2.new(0, v98, 0, v98)
            end
        end

        a80.endImage.Position = a80.startImage.Position

        if userFlag and a80.newStyle then
            a80.endImage.Size = UDim2.new(0, a80.thumbstickSize * 0.6, 0, a80.thumbstickSize * 0.6)
            return
        end

        a80.endImage.Size = UDim2.new(0, a80.thumbstickSize * 0.8, 0, a80.thumbstickSize * 0.8)
    end

    ResizeThumbstick()
    a80.absoluteSizeChangedConn = parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)

    if not userFlag then
        a80.avatarAbilitiesEnabledChangedConn = v18.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end

    local function onCurrentCameraChanged()
        --[[
          name: onCurrentCameraChanged
          line: 656
          upvalues:
            a80 (copy, index: 1)
            layoutThumbstickFrame (copy, index: 2)
        ]]
        if a80.cameraChangedConn then
            a80.cameraChangedConn:Disconnect()
            a80.cameraChangedConn = nil
        end

        if const camera = workspace.CurrentCamera then
            a80.cameraChangedConn = camera:GetPropertyChangedSignal("ViewportSize"):Connect(
                function()
                    --[[
                      name: onViewportSizeChanged
                      line: 663
                      upvalues:
                        camera (copy, index: 1)
                        layoutThumbstickFrame (copy, index: 2)
                    ]]
                    local viewportSize = camera.ViewportSize
                    layoutThumbstickFrame(viewportSize.X < viewportSize.Y)
                end
            )

            local viewportSize = camera.ViewportSize
            layoutThumbstickFrame(viewportSize.X < viewportSize.Y)
        end
    end

    a80.currentCameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)

    if workspace.CurrentCamera or userFlag then
        onCurrentCameraChanged()
    end

    a80.startImageFadeTween = nil
    a80.endImageFadeTween = nil
    a80.endImageCenterFadeTween = nil
    a80.middleImageFadeTweens = {}

    if userFlag4 and a80.isTouchActive then
        a80:OnInputEnded()
    end

    a80.moveTouchStartPosition = nil

    a80.onRenderSteppedConn = runService.RenderStepped:Connect(
        function()
            --[[
              line: 687
              upvalues:
                a80 (copy, index: 1)
            ]]
            if a80.tweenInAlphaStart == nil then
                if a80.tweenOutAlphaStart ~= nil then
                    local v105 = tick() - a80.tweenOutAlphaStart
                    local v106 = a80.fadeInAndOutHalfDuration * 2 - a80.fadeInAndOutHalfDuration * 2 * a80.fadeInAndOutBalance
                    a80.thumbstickFrame.BackgroundTransparency = (math.min(v105 / v106, 1) * 0.35) + 0.65

                    if v106 < v105 then
                        a80.tweenOutAlphaStart = nil
                    end
                end
            else
                local v107 = tick() - a80.tweenInAlphaStart
                local v108 = a80.fadeInAndOutHalfDuration * 2 * a80.fadeInAndOutBalance
                a80.thumbstickFrame.BackgroundTransparency = 1 - (math.min(v107 / v108, 1) * 0.35)

                if v108 < v107 then
                    a80.tweenOutAlphaStart = tick()
                    a80.tweenInAlphaStart = nil
                end
            end
        end
    )

    a80.onStateChanged = function(a109)
        --[[
          line: 709
          upvalues:
            vector2 (copy, index: 1)
            guiService (copy, index: 2)
            a80 (copy, index: 3)
            tweenService (copy, index: 4)
            userFlag (copy, index: 5)
        ]]
        if a109 == vector2 then
            if a80.isTouchActive then
                a80:OnInputEnded()
            end
        else
            local min = guiService:GetInsetArea(Enum.ScreenInsets.None).Min
            local moveTouchStartPosition = Vector3.new(a109.X + min.X, a109.Y + min.Y, 0)

            if not a80.isTouchActive then
                a80.isTouchActive = true

                if a80.isFirstTouch then
                    a80.isFirstTouch = false
                    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                    local startImage = a80.startImage
                    local propertyTable = {Size = UDim2.new(0, 0, 0, 0)}
                    tweenService:Create(startImage, tweenInfo, propertyTable):Play()

                    if not userFlag or not a80.newStyle then
                        local endImage = a80.endImage
                        local propertyTable2 = {Size = UDim2.new(0, a80.thumbstickSize, 0, a80.thumbstickSize), ImageColor3 = Color3.new(0, 0, 0)}
                        tweenService:Create(endImage, tweenInfo, propertyTable2):Play()
                    end
                end

                a80.moveTouchStartPosition = moveTouchStartPosition
                a80.moveTouchFirstChanged = true
                a80:DoFadeInBackground()

                return
            end

            if a80.moveTouchFirstChanged then
                a80.moveTouchFirstChanged = false
                local vector22 = Vector2.new(a80.moveTouchStartPosition.X - a80.thumbstickFrame.AbsolutePosition.X, a80.moveTouchStartPosition.Y - a80.thumbstickFrame.AbsolutePosition.Y)
                a80.startImage.Visible = true
                a80.startImage.Position = UDim2.new(0, vector22.X, 0, vector22.Y)
                a80.endImage.Visible = true
                a80.endImage.Position = a80.startImage.Position
                a80:FadeThumbstick(true)
                a80:MoveStick(a80.moveTouchStartPosition)
            end

            local vector23 = Vector2.new(moveTouchStartPosition.X - a80.moveTouchStartPosition.X, moveTouchStartPosition.Y - a80.moveTouchStartPosition.Y)

            if 0 < vector23.Magnitude then
                a80:DoMove(vector23)
                a80:MoveStick(moveTouchStartPosition)
            end
        end
    end

    a80.menuOpenedConnection = guiService.MenuOpened:Connect(
        function()
            --[[
              line: 769
              upvalues:
                a80 (copy, index: 1)
            ]]
            if a80.isTouchActive then
                a80:OnInputEnded()
            end
        end
    )

    playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

    while not playerGui do
        localPlayer.ChildAdded:wait()
        playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    end

    local v119 = playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft
        or playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight

    local function longShowBackground()
        --[[
          name: longShowBackground
          line: 785
          upvalues:
            a80 (copy, index: 1)
        ]]
        a80.fadeInAndOutHalfDuration = 2.5
        a80.fadeInAndOutBalance = 0.05
        a80.tweenInAlphaStart = tick()
    end

    a80.playerGuiChangedConn = playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(
        function()
            --[[
              line: 791
              upvalues:
                v119 (copy, index: 1)
                playerGui (ref,  index: 2)
                a80 (copy, index: 3)
            ]]
            if not v119 or playerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
                if v119 or playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
                    return
                end
            end

            a80.playerGuiChangedConn:Disconnect()
            a80.fadeInAndOutHalfDuration = 2.5
            a80.fadeInAndOutBalance = 0.05
            a80.tweenInAlphaStart = tick()

            if v119 then
                a80.hasFadedBackgroundInPortrait = true
                return
            end

            a80.hasFadedBackgroundInLandscape = true
        end
    )

    a80.thumbstickFrame.Parent = parent

    if game:IsLoaded() then
        a80.fadeInAndOutHalfDuration = 2.5
        a80.fadeInAndOutBalance = 0.05
        a80.tweenInAlphaStart = tick()
    else
        coroutine.wrap(
            function()
                --[[
                  line: 818
                  upvalues:
                    a80 (copy, index: 1)
                ]]
                game.Loaded:Wait()
                a80.fadeInAndOutHalfDuration = 2.5
                a80.fadeInAndOutBalance = 0.05
                a80.tweenInAlphaStart = tick()
            end
        )()
    end
end

return v23