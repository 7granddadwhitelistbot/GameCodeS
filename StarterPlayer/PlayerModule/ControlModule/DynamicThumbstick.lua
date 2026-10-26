local tbl_upv_1 = {0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75}
local tbl_upv_2 = {0.55, 0.65, 0.7, 0.75, 0.8, 0.85, 0.875}
local u1 = #tbl_upv_1
local u2 = Vector2.new(-1, -1)
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u4 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u5 = v1.getUserFlag("UserAllowAbilityControlsBonus")
local u6 = v1.getUserFlag("UserDoubleJumpButtonFix")
local u7 = v1.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate")
local Players_1 = game:GetService("Players")
local GuiService_upv_1 = game:GetService("GuiService")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local ThumbstickAction_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext"):WaitForChild("ThumbstickAction")
local AvatarAbilitiesInterface_upv_1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
if u4 then
    local _ = AvatarAbilitiesInterface_upv_1.get(Players_1.LocalPlayer)
else
    local u8 = nil
end
local LocalPlayer_upv_1 = Players_1.LocalPlayer
if not (LocalPlayer_upv_1) then
    Players_1:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer_upv_1 = Players_1.LocalPlayer
end
local ActionController_upv_1 = require(script.Parent:WaitForChild("ActionController"))
local u9 = setmetatable({}, ActionController_upv_1)
u9.__index = u9
function u9.new(a1)
    --[[
      name: new
      line: 67
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u9 (copy, index: 2)
    ]]
    local v2 = setmetatable(ActionController_upv_1.new(), u9)
    v2.data = a1
    v2.enabled = false
    v2.isTouchActive = false
    v2.moveTouchFirstChanged = false
    v2.moveTouchStartPosition = nil
    v2.startImage = nil
    v2.endImage = nil
    v2.endImageStroke = nil
    v2.endImageCenter = nil
    v2.middleImages = {}
    v2.startImageFadeTween = nil
    v2.endImageFadeTween = nil
    v2.endImageCenterFadeTween = nil
    v2.middleImageFadeTweens = {}
    v2.isFirstTouch = true
    v2.thumbstickFrame = nil
    v2.onRenderSteppedConn = nil
    v2.fadeInAndOutBalance = 0.5
    v2.fadeInAndOutHalfDuration = 0.3
    v2.hasFadedBackgroundInPortrait = false
    v2.hasFadedBackgroundInLandscape = false
    v2.tweenInAlphaStart = nil
    v2.tweenOutAlphaStart = nil
    v2.newStyle = false
    return v2
end
function u9.GetIsJumping(a1)
    --[[
      name: GetIsJumping
      line: 109
    ]]
    local isJumping_1 = a1.isJumping
    a1.isJumping = false
    return isJumping_1
end
local function setupThumbstickInput(a1)
    --[[
      name: setupThumbstickInput
      line: 115
      upvalues:
        ThumbstickAction_upv_1 (copy, index: 1)
    ]]
    for _, value_1 in ThumbstickAction_upv_1:GetChildren() do
        if value_1.Name == "DynamicTouchBinding" or value_1.Name == "ClassicTouchBinding" then
            value_1:Destroy()
        end
    end
    local v3 = Instance.new("InputBinding")
    v3.Name = "DynamicTouchBinding"
    v3.KeyCode = Enum.KeyCode.TouchPosition
    v3.UIModifier = a1.thumbstickButton
    v3.Parent = ThumbstickAction_upv_1
end
local function enableThumbstickInput(a1, a2)
    --[[
      name: enableThumbstickInput
      line: 128
      upvalues:
        setupThumbstickInput (copy, index: 1)
        ThumbstickAction_upv_1 (copy, index: 2)
    ]]
    if a2 then
        setupThumbstickInput(a1)
        a1.thumbstickStateChangedConn = ThumbstickAction_upv_1.StateChanged:Connect(a1.onStateChanged)
        ThumbstickAction_upv_1.Enabled = true
    else
        ThumbstickAction_upv_1.Enabled = false
        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()
            a1.thumbstickStateChangedConn = nil
        end
    end
end
local u8
function u9.Enable(a1, a2, a3)
    --[[
      name: Enable
      line: 142
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        u8 (copy, index: 3)
        u7 (copy, index: 4)
        setupThumbstickInput (copy, index: 5)
        ThumbstickAction_upv_1 (copy, index: 6)
    ]]
    if a2 ~= nil then
        if a1.enabled ~= a2 then
            ActionController_upv_1.Enable(a1, a2)
            if a2 then
                if not (a1.thumbstickFrame) then
                    a1:Create(a3)
                    if u4 and not (a1.avatarAbilitiesEnabledChangedConn) then
                        a1.avatarAbilitiesEnabledChangedConn = u8:GetEnabledChangedSignal():Connect(
                            function()
                                --[[
                                  line: 153
                                  upvalues:
                                    a1 (copy, index: 1)
                                    a3 (copy, index: 2)
                                    u7 (copy, index: 3)
                                    setupThumbstickInput (copy, index: 4)
                                    ThumbstickAction_upv_1 (copy, index: 5)
                                ]]
                                if not a1.enabled then
                                    return
                                end
                                a1:Create(a3)
                                if u7 then
                                    setupThumbstickInput(a1)
                                end
                                a1.thumbstickStateChangedConn = ThumbstickAction_upv_1.StateChanged:Connect(a1.onStateChanged)
                                ThumbstickAction_upv_1.Enabled = true
                                a1.thumbstickFrame.Visible = true
                            end
                        )
                    end
                end
                if u7 then
                    setupThumbstickInput(a1)
                end
                a1.thumbstickStateChangedConn = ThumbstickAction_upv_1.StateChanged:Connect(a1.onStateChanged)
                ThumbstickAction_upv_1.Enabled = true
            else
                ThumbstickAction_upv_1.Enabled = false
                if a1.thumbstickStateChangedConn then
                    a1.thumbstickStateChangedConn:Disconnect()
                    a1.thumbstickStateChangedConn = nil
                end
                a1:OnInputEnded()
            end
            a1.enabled = a2
            a1.thumbstickFrame.Visible = a2
            return nil
        end
        return true
    end
    return false
end
function u9.OnInputEnded(a1)
    --[[
      name: OnInputEnded
      line: 194
    ]]
    a1.isTouchActive = false
    local DynamicThumbstickScriptableBinding_1 = a1.data.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding")
    if DynamicThumbstickScriptableBinding_1 then
        DynamicThumbstickScriptableBinding_1:Fire(Vector2.zero)
    end
    a1:FadeThumbstick(false)
end
function u9.FadeThumbstick(a1, a2)
    --[[
      name: FadeThumbstick
      line: 203
      upvalues:
        u4 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        u3 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
    ]]
    if ((a2) or not a1.isTouchActive) and not a1.isFirstTouch then
        if a1.startImageFadeTween then
            a1.startImageFadeTween:Cancel()
        end
        if a1.endImageFadeTween then
            a1.endImageFadeTween:Cancel()
        end
        if u4 and a1.endImageCenterFadeTween then
            a1.endImageCenterFadeTween:Cancel()
        end
        for n_1 = 1, #a1.middleImages do
            if a1.middleImageFadeTweens[n_1] then
                a1.middleImageFadeTweens[n_1]:Cancel()
            end
        end
        if a2 then
            if (u4) and (a1.newStyle) then
                a1.startImageFadeTween = TweenService_upv_1:Create(a1.startImage, u3, {BackgroundTransparency = 0.4})
                a1.startImageFadeTween:Play()
                a1.endImageFadeTween = TweenService_upv_1:Create(a1.endImageStroke, u3, {Transparency = 0})
                a1.endImageFadeTween:Play()
                a1.endImageCenterFadeTween = TweenService_upv_1:Create(a1.endImageCenter, u3, {BackgroundTransparency = 0})
                a1.endImageCenterFadeTween:Play()
            else
                a1.startImageFadeTween = TweenService_upv_1:Create(a1.startImage, u3, {ImageTransparency = 0})
                a1.startImageFadeTween:Play()
                a1.endImageFadeTween = TweenService_upv_1:Create(a1.endImage, u3, {ImageTransparency = 0.2})
                a1.endImageFadeTween:Play()
            end
            for n_2 = 1, #a1.middleImages do
                if not (u4) then
                    a1.middleImageFadeTweens[n_2] = TweenService_upv_1:Create(a1.middleImages[n_2], u3, {ImageTransparency = tbl_upv_1[n_2]})
                    a1.middleImageFadeTweens[n_2]:Play()
                    continue
                end
                if a1.newStyle then
                    a1.middleImageFadeTweens[n_2] = TweenService_upv_1:Create(a1.middleImages[n_2], u3, {BackgroundTransparency = tbl_upv_2[n_2]})
                else
                    a1.middleImageFadeTweens[n_2] = TweenService_upv_1:Create(a1.middleImages[n_2], u3, {ImageTransparency = tbl_upv_1[n_2]})
                end
                a1.middleImageFadeTweens[n_2]:Play()
            end
        else
            if (u4) and (a1.newStyle) then
                a1.startImageFadeTween = TweenService_upv_1:Create(a1.startImage, u3, {BackgroundTransparency = 1})
                a1.startImageFadeTween:Play()
                a1.endImageFadeTween = TweenService_upv_1:Create(a1.endImageStroke, u3, {Transparency = 1})
                a1.endImageFadeTween:Play()
                a1.endImageCenterFadeTween = TweenService_upv_1:Create(a1.endImageCenter, u3, {BackgroundTransparency = 1})
                a1.endImageCenterFadeTween:Play()
            else
                a1.startImageFadeTween = TweenService_upv_1:Create(a1.startImage, u3, {ImageTransparency = 1})
                a1.startImageFadeTween:Play()
                a1.endImageFadeTween = TweenService_upv_1:Create(a1.endImage, u3, {ImageTransparency = 1})
                a1.endImageFadeTween:Play()
            end
            for n_3 = 1, #a1.middleImages do
                if not (u4) then
                    a1.middleImageFadeTweens[n_3] = TweenService_upv_1:Create(a1.middleImages[n_3], u3, {ImageTransparency = 1})
                    a1.middleImageFadeTweens[n_3]:Play()
                    continue
                end
                if a1.newStyle then
                    a1.middleImageFadeTweens[n_3] = TweenService_upv_1:Create(a1.middleImages[n_3], u3, {BackgroundTransparency = 1})
                else
                    a1.middleImageFadeTweens[n_3] = TweenService_upv_1:Create(a1.middleImages[n_3], u3, {ImageTransparency = 1})
                end
                a1.middleImageFadeTweens[n_3]:Play()
            end
        end
    end
end
function u9.FadeThumbstickFrame(a1, a2, a3)
    --[[
      name: FadeThumbstickFrame
      line: 279
    ]]
    a1.fadeInAndOutHalfDuration = a2 * 0.5
    a1.fadeInAndOutBalance = a3
    a1.tweenInAlphaStart = tick()
end
function u9.DoFadeInBackground(a1)
    --[[
      name: DoFadeInBackground
      line: 285
      upvalues:
        LocalPlayer_upv_1 (ref, index: 1)
    ]]
    local v4 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    local v5 = false
    if v4 then
        if v4.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v4.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v5 = a1.hasFadedBackgroundInLandscape
            a1.hasFadedBackgroundInLandscape = true
        elseif v4.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v5 = a1.hasFadedBackgroundInPortrait
            a1.hasFadedBackgroundInPortrait = true
        end
    end
    if (v5) then
        return
    end
    a1.fadeInAndOutHalfDuration = 0.3
    a1.fadeInAndOutBalance = 0.5
    a1.tweenInAlphaStart = tick()
end
function u9.DoMove(a1, a2)
    --[[
      name: DoMove
      line: 308
    ]]
    local v6 = ((not (a2.Magnitude < a1.radiusOfDeadZone)) and (a2.Unit * (1 - math.max(0, (a1.radiusOfMaxSpeed - a2.Magnitude) / a1.radiusOfMaxSpeed)))) or (Vector2.new())
    local v7 = Vector2.new(v6.X, -v6.Y)
    local DynamicThumbstickScriptableBinding_2 = a1.data.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding")
    if not DynamicThumbstickScriptableBinding_2 then
        return
    end
    DynamicThumbstickScriptableBinding_2:Fire(v7)
end
function u9.LayoutMiddleImages(a1, a2, a3)
    --[[
      name: LayoutMiddleImages
      line: 328
      upvalues:
        u1 (copy, index: 1)
    ]]
    local v8 = a1.thumbstickSize / 2 + a1.middleSize
    local v9 = a3 - a2
    local v10 = v9.Magnitude - (a1.thumbstickRingSize / 2) - a1.middleSize
    local Unit_1 = v9.Unit
    local v11 = ((a1.middleSpacing * u1 < v10) and (v10 / u1)) or a1.middleSpacing
    for n_4 = 1, u1 do
        local v12 = a1.middleImages[n_4]
        local v13 = v8 + v11 * (n_4 - 1)
        if v8 + (v11 * (n_4 - 2)) < v10 then
            local v14 = a3 - Unit_1 * v13
            local v15 = math.clamp(1 - ((v13 - v10) / v11), 0, 1)
            v12.Visible = true
            v12.Position = UDim2.new(0, v14.X, 0, v14.Y)
            v12.Size = UDim2.new(0, a1.middleSize * v15, 0, a1.middleSize * v15)
        else
            v12.Visible = false
        end
    end
end
function u9.MoveStick(a1, a2)
    --[[
      name: MoveStick
      line: 359
    ]]
    local v16 = Vector2.new(a1.moveTouchStartPosition.X, a1.moveTouchStartPosition.Y)
    local v17 = Vector2.new(a2.X, a2.Y) - a1.thumbstickFrame.AbsolutePosition
    a1.endImage.Position = UDim2.new(0, v17.X, 0, v17.Y)
    a1:LayoutMiddleImages(v16 - a1.thumbstickFrame.AbsolutePosition, v17)
end
function u9.Create(a1, a2)
    --[[
      name: Create
      line: 367
      upvalues:
        u7 (copy, index: 1)
        ThumbstickAction_upv_1 (copy, index: 2)
        u4 (copy, index: 3)
        u8 (copy, index: 4)
        u6 (copy, index: 5)
        u1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        tbl_upv_1 (copy, index: 8)
        AvatarAbilitiesInterface_upv_1 (copy, index: 9)
        u5 (copy, index: 10)
        RunService_upv_1 (copy, index: 11)
        u2 (copy, index: 12)
        GuiService_upv_1 (copy, index: 13)
        TweenService_upv_1 (copy, index: 14)
        LocalPlayer_upv_1 (ref,  index: 15)
    ]]
    if a1.thumbstickFrame then
        ThumbstickAction_upv_1.Enabled = false
        if a1.thumbstickStateChangedConn then
            a1.thumbstickStateChangedConn:Disconnect()
            a1.thumbstickStateChangedConn = nil
        end
        a1.thumbstickFrame:Destroy()
        a1.thumbstickFrame = nil
        if a1.onRenderSteppedConn then
            a1.onRenderSteppedConn:Disconnect()
            a1.onRenderSteppedConn = nil
        end
        if a1.absoluteSizeChangedConn then
            a1.absoluteSizeChangedConn:Disconnect()
            a1.absoluteSizeChangedConn = nil
        end
        if not (u4) and a1.avatarAbilitiesEnabledChangedConn then
            a1.avatarAbilitiesEnabledChangedConn:Disconnect()
            a1.avatarAbilitiesEnabledChangedConn = nil
        end
        if u4 then
            if a1.cameraChangedConn then
                a1.cameraChangedConn:Disconnect()
                a1.cameraChangedConn = nil
            end
            if a1.currentCameraChangedConn then
                a1.currentCameraChangedConn:Disconnect()
                a1.currentCameraChangedConn = nil
            end
            if a1.menuOpenedConnection then
                a1.menuOpenedConnection:Disconnect()
                a1.menuOpenedConnection = nil
            end
            if a1.playerGuiChangedConn then
                a1.playerGuiChangedConn:Disconnect()
                a1.playerGuiChangedConn = nil
            end
        end
    end
    local v18
    if u4 then
        v18 = u8:isEnabled()
    else
        v18 = u4
    end
    a1.newStyle = v18
    a1.thumbstickFrame = Instance.new("Frame")
    a1.thumbstickFrame.BorderSizePixel = 0
    a1.thumbstickFrame.Name = "DynamicThumbstickFrame"
    a1.thumbstickFrame.Visible = false
    a1.thumbstickFrame.BackgroundTransparency = 1
    a1.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    a1.thumbstickFrame.Active = false
    a1.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
    a1.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
    a1.thumbstickButton = Instance.new("ImageButton")
    a1.thumbstickButton.Name = "DynamicThumbstickUIModifier"
    a1.thumbstickButton.BackgroundTransparency = 1
    a1.thumbstickButton.ImageTransparency = 1
    a1.thumbstickButton.AutoButtonColor = false
    a1.thumbstickButton.Size = UDim2.new(1, 0, 1, 0)
    a1.thumbstickButton.ZIndex = a1.thumbstickFrame.ZIndex
    a1.thumbstickButton.Visible = true
    a1.thumbstickButton.Active = false
    a1.thumbstickButton.Parent = a1.thumbstickFrame
    if not (u7) then
        local _ = nil
        v18 = (not u6) or (ThumbstickAction_upv_1:FindFirstChild("DynamicTouchBinding"))
        if not (v18) then
            local v19 = Instance.new("InputBinding")
            v19.Name = "DynamicTouchBinding"
            v19.KeyCode = Enum.KeyCode.TouchPosition
            v19.Parent = ThumbstickAction_upv_1
            v18 = v19
        end
        v18.UIModifier = a1.thumbstickButton
    end
    local function layoutThumbstickFrame(a3)
        --[[
          name: layoutThumbstickFrame
          line: 415
          upvalues:
            a1 (copy, index: 1)
        ]]
        if a3 then
            a1.thumbstickFrame.Size = UDim2.new(1, 100, 0.4, 100)
            a1.thumbstickFrame.Position = UDim2.new(0, -100, 0.6, 0)
        else
            a1.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100)
            a1.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0)
        end
    end
    if u4 and a1.newStyle then
        a1.startImage = Instance.new("Frame")
        a1.startImage.Name = "ThumbstickStart"
        a1.startImage.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
        a1.startImage.BackgroundTransparency = 0.4
        a1.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a1.startImage.ZIndex = 10
        a1.startImage.Parent = a1.thumbstickFrame
        local v20 = Instance.new("UICorner")
        v20.CornerRadius = UDim.new(0.5, 0)
        v20.Parent = a1.startImage
        a1.endImage = Instance.new("Frame")
        a1.endImage.Name = "ThumbstickEnd"
        a1.endImage.BackgroundTransparency = 1
        a1.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a1.endImage.ZIndex = 10
        a1.endImage.Parent = a1.thumbstickFrame
        local v21 = Instance.new("UICorner")
        v21.CornerRadius = UDim.new(0.5, 0)
        v21.Parent = a1.endImage
        a1.endImageStroke = Instance.new("UIStroke")
        a1.endImageStroke.Thickness = (u6 and 1.5) or 2
        a1.endImageStroke.Color = Color3.fromRGB(213, 215, 221)
        a1.endImageStroke.Parent = a1.endImage
        a1.endImageCenter = Instance.new("Frame")
        a1.endImageCenter.Name = "ThumbstickEndCenter"
        a1.endImageCenter.BackgroundTransparency = 0
        a1.endImageCenter.BackgroundColor3 = Color3.fromRGB(213, 215, 221)
        a1.endImageCenter.AnchorPoint = Vector2.new(0.5, 0.5)
        a1.endImageCenter.Size = UDim2.new(0.74, 0, 0.74, 0)
        a1.endImageCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
        a1.endImageCenter.ZIndex = 10
        a1.endImageCenter.Parent = a1.endImage
        local v22 = Instance.new("UICorner")
        v22.CornerRadius = UDim.new(0.5, 0)
        v22.Parent = a1.endImageCenter
        for n_5 = 1, u1 do
            a1.middleImages[n_5] = Instance.new("Frame")
            a1.middleImages[n_5].Name = "ThumbstickMiddle"
            a1.middleImages[n_5].Visible = false
            a1.middleImages[n_5].BackgroundTransparency = tbl_upv_2[n_5]
            a1.middleImages[n_5].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            a1.middleImages[n_5].AnchorPoint = Vector2.new(0.5, 0.5)
            a1.middleImages[n_5].ZIndex = 9
            a1.middleImages[n_5].Parent = a1.thumbstickFrame
            local v23 = Instance.new("UICorner")
            v23.CornerRadius = UDim.new(0.5, 0)
            v23.Parent = a1.middleImages[n_5]
        end
    else
        a1.startImage = Instance.new("ImageLabel")
        a1.startImage.Name = "ThumbstickStart"
        a1.startImage.Visible = true
        a1.startImage.BackgroundTransparency = 1
        a1.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a1.startImage.ImageRectOffset = Vector2.new(1, 1)
        a1.startImage.ImageRectSize = Vector2.new(144, 144)
        a1.startImage.ImageColor3 = Color3.new(0, 0, 0)
        a1.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a1.startImage.ZIndex = 10
        a1.startImage.Parent = a1.thumbstickFrame
        a1.endImage = Instance.new("ImageLabel")
        a1.endImage.Name = "ThumbstickEnd"
        a1.endImage.Visible = true
        a1.endImage.BackgroundTransparency = 1
        a1.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        a1.endImage.ImageRectOffset = Vector2.new(1, 1)
        a1.endImage.ImageRectSize = Vector2.new(144, 144)
        a1.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
        a1.endImage.ZIndex = 10
        a1.endImage.Parent = a1.thumbstickFrame
        for n_6 = 1, u1 do
            a1.middleImages[n_6] = Instance.new("ImageLabel")
            a1.middleImages[n_6].Name = "ThumbstickMiddle"
            a1.middleImages[n_6].Visible = false
            a1.middleImages[n_6].BackgroundTransparency = 1
            a1.middleImages[n_6].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
            a1.middleImages[n_6].ImageRectOffset = Vector2.new(1, 1)
            a1.middleImages[n_6].ImageRectSize = Vector2.new(144, 144)
            a1.middleImages[n_6].ImageTransparency = tbl_upv_1[n_6]
            a1.middleImages[n_6].AnchorPoint = Vector2.new(0.5, 0.5)
            a1.middleImages[n_6].ZIndex = 9
            a1.middleImages[n_6].Parent = a1.thumbstickFrame
        end
    end
    local function ResizeThumbstick()
        --[[
          name: ResizeThumbstick
          line: 557
          upvalues:
            a2 (copy, index: 1)
            u4 (copy, index: 2)
            a1 (copy, index: 3)
            AvatarAbilitiesInterface_upv_1 (copy, index: 4)
            u5 (copy, index: 5)
        ]]
        local v24 = a2.AbsoluteSize
        local v25 = math.min(v24.X, v24.Y) > 500
        if v25 then
            v24 = 2
        else
            v24 = 1
        end
        local v26
        if u4 then
            v26 = a1.newStyle
        else
            v26 = AvatarAbilitiesInterface_upv_1.isEnabled()
        end
        if u5 and v26 then
            v24 = (v25 and 1.6216216216216217) or v24
        end
        a1.thumbstickSize = 45 * v24
        a1.thumbstickRingSize = 20 * v24
        a1.middleSize = 10 * v24
        a1.middleSpacing = 14 * v24
        a1.radiusOfDeadZone = 2 * v24
        a1.radiusOfMaxSpeed = 20 * v24
        local v27 = 74 * v24
        if not (u4) or a1.isFirstTouch then
            if v26 then
                v24 = (v25 and 100) or 64
                a1.startImage.Position = UDim2.new(0, ((v27 * 0.5) + 100) + v24, 1, ((-v27 * 0.5) - 100) - ((v25 and 112) or 64))
            else
                a1.startImage.Position = UDim2.new(0, (a1.thumbstickRingSize * 3.3) + 100, 1, (-a1.thumbstickRingSize * 2.8) - 100)
            end
            a1.startImage.Size = UDim2.new(0, v27, 0, v27)
        end
        a1.endImage.Position = a1.startImage.Position
        if u4 and a1.newStyle then
            a1.endImage.Size = UDim2.new(0, a1.thumbstickSize * 0.6, 0, a1.thumbstickSize * 0.6)
        else
            a1.endImage.Size = UDim2.new(0, a1.thumbstickSize * 0.8, 0, a1.thumbstickSize * 0.8)
        end
    end
    ResizeThumbstick()
    a1.absoluteSizeChangedConn = a2:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)
    if not (u4) then
        a1.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface_upv_1.GetEnabledChangedSignal():Connect(ResizeThumbstick)
    end
    local function onCurrentCameraChanged()
        --[[
          name: onCurrentCameraChanged
          line: 612
          upvalues:
            a1 (copy, index: 1)
            layoutThumbstickFrame (copy, index: 2)
        ]]
        if a1.cameraChangedConn then
            a1.cameraChangedConn:Disconnect()
            a1.cameraChangedConn = nil
        end
        local CurrentCamera_upv_1 = workspace.CurrentCamera
        if CurrentCamera_upv_1 then
            local function onViewportSizeChanged_1()
                --[[
                  name: onViewportSizeChanged
                  line: 619
                  upvalues:
                    CurrentCamera_upv_1 (copy, index: 1)
                    layoutThumbstickFrame (copy, index: 2)
                ]]
                local ViewportSize_1 = CurrentCamera_upv_1.ViewportSize
                layoutThumbstickFrame(ViewportSize_1.X < ViewportSize_1.Y)
            end
            a1.cameraChangedConn = CurrentCamera_upv_1:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged_1)
            local ViewportSize_2 = CurrentCamera_upv_1.ViewportSize
            layoutThumbstickFrame(ViewportSize_2.X < ViewportSize_2.Y)
        end
    end
    a1.currentCameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
    if workspace.CurrentCamera or u4 then
        onCurrentCameraChanged()
    end
    a1.startImageFadeTween = nil
    a1.endImageFadeTween = nil
    a1.endImageCenterFadeTween = nil
    a1.middleImageFadeTweens = {}
    if u7 and a1.isTouchActive then
        a1:OnInputEnded()
    end
    a1.moveTouchStartPosition = nil
    a1.onRenderSteppedConn = RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 643
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a1.tweenInAlphaStart == nil then
                if a1.tweenOutAlphaStart ~= nil then
                    local v28 = tick() - a1.tweenOutAlphaStart
                    local v29 = a1.fadeInAndOutHalfDuration * 2 - (a1.fadeInAndOutHalfDuration * 2) * a1.fadeInAndOutBalance
                    a1.thumbstickFrame.BackgroundTransparency = (math.min(v28 / v29, 1) * 0.35) + 0.65
                    if not (v29 < v28) then
                        return
                    end
                    a1.tweenOutAlphaStart = nil
                end
            else
                local v30 = tick() - a1.tweenInAlphaStart
                local v31 = a1.fadeInAndOutHalfDuration * 2 * a1.fadeInAndOutBalance
                a1.thumbstickFrame.BackgroundTransparency = 1 - (math.min(v30 / v31, 1) * 0.35)
                if not (v31 < v30) then
                    return
                end
                a1.tweenOutAlphaStart = tick()
                a1.tweenInAlphaStart = nil
            end
        end
    )
    a1.onStateChanged = function(a4)
        --[[
          line: 662
          upvalues:
            u2 (copy, index: 1)
            GuiService_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
            u4 (copy, index: 5)
        ]]
        if a4 == u2 then
            if not a1.isTouchActive then
                return
            end
            a1:OnInputEnded()
        else
            local Min_1 = GuiService_upv_1:GetInsetArea(Enum.ScreenInsets.None).Min
            local v32 = Vector3.new(a4.X + Min_1.X, a4.Y + Min_1.Y, 0)
            local v33 = nil
            if a1.isTouchActive then
                if a1.moveTouchFirstChanged then
                    a1.moveTouchFirstChanged = false
                    local v34 = Vector2.new(a1.moveTouchStartPosition.X - a1.thumbstickFrame.AbsolutePosition.X, a1.moveTouchStartPosition.Y - a1.thumbstickFrame.AbsolutePosition.Y)
                    a1.startImage.Visible = true
                    a1.startImage.Position = UDim2.new(0, v34.X, 0, v34.Y)
                    a1.endImage.Visible = true
                    a1.endImage.Position = a1.startImage.Position
                    a1:FadeThumbstick(true)
                    a1:MoveStick(a1.moveTouchStartPosition)
                end
                v33 = Vector2.new(v32.X - a1.moveTouchStartPosition.X, v32.Y - a1.moveTouchStartPosition.Y)
                if not (v33.Magnitude > 0) then
                    return
                end
                a1:DoMove(v33)
                a1:MoveStick(v32)
            else
                a1.isTouchActive = true
                if a1.isFirstTouch then
                    a1.isFirstTouch = false
                    local v35 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                    local tbl_3 = {}
                    tbl_3.Size = UDim2.new(0, 0, 0, 0)
                    TweenService_upv_1:Create(a1.startImage, v35, tbl_3):Play()
                    if not (u4) or not (a1.newStyle) then
                        local tbl_4 = {}
                        tbl_4.Size = UDim2.new(0, a1.thumbstickSize, 0, a1.thumbstickSize)
                        tbl_4.ImageColor3 = Color3.new(0, 0, 0)
                        TweenService_upv_1:Create(a1.endImage, v35, tbl_4):Play()
                    end
                end
                a1.moveTouchStartPosition = v32
                a1.moveTouchFirstChanged = true
                a1:DoFadeInBackground()
            end
        end
    end
    a1.menuOpenedConnection = GuiService_upv_1.MenuOpened:Connect(
        function()
            --[[
              line: 723
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.isTouchActive then
                return
            end
            a1:OnInputEnded()
        end
    )
    local u10 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    while not (u10) do
        LocalPlayer_upv_1.ChildAdded:wait()
        u10 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
    end
    local v36 = true
    local v37, u11 = nil, nil
    if v37.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft then
        u11 = v36
    else
        u11 = v37.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
    end
    local function longShowBackground()
        --[[
          name: longShowBackground
          line: 738
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.fadeInAndOutHalfDuration = 2.5
        a1.fadeInAndOutBalance = 0.05
        a1.tweenInAlphaStart = tick()
    end
    a1.playerGuiChangedConn = v37:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(
        function()
            --[[
              line: 744
              upvalues:
                u11 (copy, index: 1)
                u10 (ref,  index: 2)
                a1 (copy, index: 3)
            ]]
            if (not u11 or u10.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait) and ((u11) or u10.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait) then
                return
            end
            a1.playerGuiChangedConn:Disconnect()
            a1.fadeInAndOutHalfDuration = 2.5
            a1.fadeInAndOutBalance = 0.05
            a1.tweenInAlphaStart = tick()
            if u11 then
                a1.hasFadedBackgroundInPortrait = true
            else
                a1.hasFadedBackgroundInLandscape = true
            end
        end
    )
    a1.thumbstickFrame.Parent = a2
    if game:IsLoaded() then
        a1.fadeInAndOutHalfDuration = 2.5
        a1.fadeInAndOutBalance = 0.05
        a1.tweenInAlphaStart = tick()
    else
        coroutine.wrap(
            function()
                --[[
                  line: 764
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                game.Loaded:Wait()
                a1.fadeInAndOutHalfDuration = 2.5
                a1.fadeInAndOutBalance = 0.05
                a1.tweenInAlphaStart = tick()
            end
        )()
    end
end
return u9