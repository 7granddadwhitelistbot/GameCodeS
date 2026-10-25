local VRService_upv_1 = game:GetService("VRService")
local _ = game:GetService("Players").LocalPlayer
local Lighting_upv_1 = game:GetService("Lighting")
local RunService_upv_1 = game:GetService("RunService")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local ZoomController_upv_1 = require(script.Parent:WaitForChild("ZoomController"))
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local CameraGamepadResetAction_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraGamepadResetAction")
local BaseCamera_upv_1 = require(script.Parent:WaitForChild("BaseCamera"))
local u1 = setmetatable({}, BaseCamera_upv_1)
u1.__index = u1
function u1.new()
    --[[
      name: new
      line: 36
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        CameraGamepadResetAction_upv_1 (copy, index: 3)
    ]]
    local u2 = setmetatable(BaseCamera_upv_1.new(), u1)
    u2.gamepadZoomLevels = {0, 7}
    u2.headScale = 1
    u2:SetCameraToSubjectDistance(7)
    u2.VRFadeResetTimer = 0
    u2.VREdgeBlurTimer = 0
    u2.needsReset = true
    u2.recentered = false
    u2.gamepadResetConnection = CameraGamepadResetAction_upv_1.Pressed:Connect(
        function()
            --[[
              line: 55
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:GamepadReset()
        end
    )
    u2:Reset()
    return u2
end
function u1.Reset(a1)
    --[[
      name: Reset
      line: 65
    ]]
    a1.stepRotateTimeout = 0
end
function u1.GetModuleName(a1)
    --[[
      name: GetModuleName
      line: 69
    ]]
    return "VRBaseCamera"
end
function u1.GamepadZoomPress(a1)
    --[[
      name: GamepadZoomPress
      line: 73
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
    ]]
    BaseCamera_upv_1.GamepadZoomPress(a1)
    a1:GamepadReset()
    a1:ResetZoom()
end
function u1.GamepadReset(a1)
    --[[
      name: GamepadReset
      line: 81
    ]]
    a1.stepRotateTimeout = 0
    a1.needsReset = true
end
function u1.ResetZoom(a1)
    --[[
      name: ResetZoom
      line: 86
      upvalues:
        ZoomController_upv_1 (copy, index: 1)
    ]]
    ZoomController_upv_1.SetZoomParameters(a1.currentSubjectDistance, 0)
    ZoomController_upv_1.ReleaseSpring()
end
function u1.OnEnabledChanged(a1)
    --[[
      name: OnEnabledChanged
      line: 91
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        CameraGamepadResetAction_upv_1 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
        Lighting_upv_1 (copy, index: 4)
    ]]
    BaseCamera_upv_1.OnEnabledChanged(a1)
    if a1.enabled then
        CameraGamepadResetAction_upv_1.Enabled = true
        a1.thirdPersonOptionChanged = VRService_upv_1:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(
            function()
                --[[
                  line: 98
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:Reset()
            end
        )
        a1.vrRecentered = VRService_upv_1.UserCFrameChanged:Connect(
            function(a2, a3)
                --[[
                  line: 102
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                if a2 ~= Enum.UserCFrame.Floor then
                    return
                end
                a1.recentered = true
            end
        )
    else
        if a1.inFirstPerson then
            a1:GamepadZoomPress()
        end
        if a1.thirdPersonOptionChanged then
            a1.thirdPersonOptionChanged:Disconnect()
            a1.thirdPersonOptionChanged = nil
        end
        if a1.vrRecentered then
            a1.vrRecentered:Disconnect()
            a1.vrRecentered = nil
        end
        if a1.cameraHeadScaleChangedConn then
            a1.cameraHeadScaleChangedConn:Disconnect()
            a1.cameraHeadScaleChangedConn = nil
        end
        CameraGamepadResetAction_upv_1.Enabled = false
        local VRFade_1 = Lighting_upv_1:FindFirstChild("VRFade")
        if VRFade_1 then
            VRFade_1.Brightness = 0
        end
    end
end
function u1.OnCurrentCameraChanged(a1)
    --[[
      name: OnCurrentCameraChanged
      line: 139
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
    ]]
    BaseCamera_upv_1.OnCurrentCameraChanged(a1)
    if a1.cameraHeadScaleChangedConn then
        a1.cameraHeadScaleChangedConn:Disconnect()
        a1.cameraHeadScaleChangedConn = nil
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    a1.cameraHeadScaleChangedConn = CurrentCamera_1:GetPropertyChangedSignal("HeadScale"):Connect(
        function()
            --[[
              line: 151
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:OnHeadScaleChanged()
        end
    )
    a1:OnHeadScaleChanged()
end
function u1.OnHeadScaleChanged(a1)
    --[[
      name: OnHeadScaleChanged
      line: 156
    ]]
    local HeadScale_1 = workspace.CurrentCamera.HeadScale
    for key_1, value_1 in a1.gamepadZoomLevels do
        a1.gamepadZoomLevels[key_1] = (value_1 * HeadScale_1) / a1.headScale
    end
    a1:SetCameraToSubjectDistance(a1:GetCameraToSubjectDistance() * HeadScale_1 / a1.headScale)
    a1.headScale = HeadScale_1
end
function u1.GetVRFocus(a1, a2, a3)
    --[[
      name: GetVRFocus
      line: 172
    ]]
    a1.cameraTranslationConstraints = Vector3.new(a1.cameraTranslationConstraints.x, math.min(1, a1.cameraTranslationConstraints.y + a3), a1.cameraTranslationConstraints.z)
    local v1 = Vector3.new(0, a1:GetCameraHeight(), 0)
    return (CFrame.new(Vector3.new(a2.x, (a1.lastCameraFocus or a2).y, a2.z):Lerp(a2 + v1, a1.cameraTranslationConstraints.y)))
end
function u1.StartFadeFromBlack(a1)
    --[[
      name: StartFadeFromBlack
      line: 188
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        Lighting_upv_1 (copy, index: 2)
    ]]
    if UserGameSettings_upv_1.VignetteEnabled == false then
        return
    end
    local v2 = Lighting_upv_1:FindFirstChild("VRFade")
    if not (v2) then
        local v3 = Instance.new("ColorCorrectionEffect")
        v3.Name = "VRFade"
        v3.Parent = Lighting_upv_1
        v2 = v3
    end
    v2.Brightness = -1
    a1.VRFadeResetTimer = 0.1
end
function u1.UpdateFadeFromBlack(a1, a2)
    --[[
      name: UpdateFadeFromBlack
      line: 203
      upvalues:
        Lighting_upv_1 (copy, index: 1)
    ]]
    local VRFade_2 = Lighting_upv_1:FindFirstChild("VRFade")
    local v4 = nil
    if a1.VRFadeResetTimer > 0 then
        a1.VRFadeResetTimer = math.max(a1.VRFadeResetTimer - a2, 0)
        v4 = Lighting_upv_1:FindFirstChild("VRFade")
        if not v4 or not (v4.Brightness < 0) then
            return
        end
        v4.Brightness = math.min(v4.Brightness + (a2 * 10), 0)
    elseif VRFade_2 then
        VRFade_2.Brightness = 0
    end
end
function u1.StartVREdgeBlur(a1, a2, a3)
    --[[
      name: StartVREdgeBlur
      line: 219
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
    ]]
    if not (a3) and UserGameSettings_upv_1.VignetteEnabled == false then
        return
    end
    local VRBlurPart_1 = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
    if not (VRBlurPart_1) then
        local u3 = Instance.new("Part")
        u3.Name = "VRBlurPart"
        u3.Parent = workspace.CurrentCamera
        u3.CanTouch = false
        u3.CanCollide = false
        u3.CanQuery = false
        u3.Anchored = true
        u3.Size = Vector3.new(0.4399999976158142, 0.4699999988079071, 1)
        u3.Transparency = 1
        u3.CastShadow = false
        RunService_upv_1.RenderStepped:Connect(
            function(a4)
                --[[
                  line: 239
                  upvalues:
                    VRService_upv_1 (copy, index: 1)
                    u3 (ref,  index: 2)
                ]]
                local v5 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
                local v6 = workspace.CurrentCamera.CFrame * (CFrame.new(v5.Position * workspace.CurrentCamera.HeadScale) * (v5 - v5.Position))
                u3.CFrame = v6 * CFrame.Angles(0, math.pi, 0) + (v6.LookVector * (1.05 * workspace.CurrentCamera.HeadScale))
                u3.Size = Vector3.new(0.4399999976158142, 0.4699999988079071, 1) * workspace.CurrentCamera.HeadScale
            end
        )
    end
    local VRBlurScreen_1 = a2.PlayerGui:FindFirstChild("VRBlurScreen")
    local v7 = nil
    v7 = (not VRBlurScreen_1) or (VRBlurScreen_1:FindFirstChild("VRBlur"))
    if not (v7) then
        local v8 = VRBlurScreen_1 or Instance.new("SurfaceGui")
        v8.Name = "VRBlurScreen"
        v8.Parent = a2.PlayerGui
        v8.Adornee = VRBlurPart_1
        v7 = Instance.new("ImageLabel")
        v7.Name = "VRBlur"
        v7.Parent = v8
        v7.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
        v7.AnchorPoint = Vector2.new(0.5, 0.5)
        v7.Position = UDim2.new(0.5, 0, 0.5, 0)
        v7.Size = UDim2.fromScale((workspace.CurrentCamera.ViewportSize.X * 2.3) / 512, (workspace.CurrentCamera.ViewportSize.Y * 2.3) / 512)
        v7.BackgroundTransparency = 1
        v7.Active = true
        v7.ScaleType = Enum.ScaleType.Stretch
    end
    v7.Visible = true
    v7.ImageTransparency = 0
    a1.VREdgeBlurTimer = 0.14
end
function u1.UpdateEdgeBlur(a1, a2, a3)
    --[[
      name: UpdateEdgeBlur
      line: 288
    ]]
    local VRBlurScreen_2 = a2.PlayerGui:FindFirstChild("VRBlurScreen")
    local v9 = (not VRBlurScreen_2) or (VRBlurScreen_2:FindFirstChild("VRBlur"))
    if v9 then
        local v10 = nil
        if a1.VREdgeBlurTimer > 0 then
            a1.VREdgeBlurTimer = a1.VREdgeBlurTimer - a3
            v10 = a2.PlayerGui:FindFirstChild("VRBlurScreen")
            if v10 then
                local VRBlur_1 = v10:FindFirstChild("VRBlur")
                if not VRBlur_1 then
                    return
                end
                VRBlur_1.ImageTransparency = 1 - (math.clamp(a1.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142)
            end
        else
            v9.Visible = false
        end
    end
end
function u1.GetCameraHeight(a1)
    --[[
      name: GetCameraHeight
      line: 313
    ]]
    if a1.inFirstPerson then
        return 0
    end
    return 0.25881904510252074 * a1.currentSubjectDistance
end
function u1.GetSubjectCFrame(a1)
    --[[
      name: GetSubjectCFrame
      line: 320
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
    ]]
    local v11 = BaseCamera_upv_1.GetSubjectCFrame(a1)
    local CurrentCamera_2 = workspace.CurrentCamera
    local v12 = CurrentCamera_2 and (CurrentCamera_2.CameraSubject)
    if not v12 then
        return v11
    end
    local v13 = v12:IsA("Humanoid")
    if v13 then
        CurrentCamera_2 = v12:GetState() == Enum.HumanoidStateType.Dead
        if CurrentCamera_2 and CurrentCamera_2 == a1.lastSubject then
            v11 = a1.lastSubjectCFrame
        end
    end
    if v11 then
        a1.lastSubjectCFrame = v11
    end
    return v11
end
function u1.GetSubjectPosition(a1)
    --[[
      name: GetSubjectPosition
      line: 346
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
    ]]
    local v14 = BaseCamera_upv_1.GetSubjectPosition(a1)
    local CurrentCamera_3 = game.Workspace.CurrentCamera
    local v15 = CurrentCamera_3 and (CurrentCamera_3.CameraSubject)
    if v15 then
        if v15:IsA("Humanoid") then
            CurrentCamera_3 = v15:GetState() == Enum.HumanoidStateType.Dead
            if CurrentCamera_3 and CurrentCamera_3 == a1.lastSubject then
                v14 = a1.lastSubjectPosition
            end
        else
            v14 = (v15:IsA("VehicleSeat") and (v15.CFrame.Position + v15.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0)))) or v14
        end
        a1.lastSubjectPosition = v14
        return v14
    end
    return nil
end
function u1.getRotation(a1, a2)
    --[[
      name: getRotation
      line: 375
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        UserGameSettings_upv_1 (copy, index: 2)
    ]]
    local v16 = CameraInput_upv_1.getRotation(a2)
    if UserGameSettings_upv_1.VRSmoothRotationEnabled then
        return v16.X
    end
    if math.abs(v16.X) > 0.03 then
        if a1.stepRotateTimeout > 0 then
            a1.stepRotateTimeout = a1.stepRotateTimeout - a2
        end
        if a1.stepRotateTimeout <= 0 then
            local v17 = ((v16.X < 0) and -1) or 1
            a1:StartFadeFromBlack()
            a1.stepRotateTimeout = 0.25
            return v17 * 0.5235987755982988
        end
    elseif math.abs(v16.X) < 0.02 then
        a1.stepRotateTimeout = 0
    end
    return 0
end
function u1.HandleSubjectDistance(a1, a2)
    --[[
      name: HandleSubjectDistance
      line: 410
    ]]
    if not a2 or not a2.IsInFirstPerson or not a2:IsInFirstPerson() then
        return
    end
    a1:SetCameraToSubjectDistance(0)
end
return u1