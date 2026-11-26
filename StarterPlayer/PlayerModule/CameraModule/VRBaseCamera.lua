local vrService = game:GetService("VRService")
local players = game:GetService("Players")
local _ = players.LocalPlayer
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")
local v6 = UserSettings():GetService("UserGameSettings")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
CommonUtils.get("FlagUtil")
local inputContexts = script.Parent.Parent:WaitForChild("InputContexts")
local cameraGamepadResetAction = inputContexts:WaitForChild("CameraContext"):WaitForChild("CameraGamepadResetAction")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local v13 = setmetatable({}, BaseCamera)
v13.__index = v13

function v13.new()
    --[[
      name: new
      line: 38
      upvalues:
        BaseCamera (copy, index: 1)
        v13 (copy, index: 2)
        cameraGamepadResetAction (copy, index: 3)
    ]]
    local v14 = setmetatable(BaseCamera.new(), v13)
    v14.gamepadZoomLevels = {0, 7}
    v14.headScale = 1
    v14:SetCameraToSubjectDistance(7)
    v14.VRFadeResetTimer = 0
    v14.VREdgeBlurTimer = 0
    v14.needsReset = true
    v14.recentered = false
    v14.gamepadResetConnection = cameraGamepadResetAction.Pressed:Connect(
        function()
            --[[
              line: 57
              upvalues:
                v14 (copy, index: 1)
            ]]
            v14:GamepadReset()
        end
    )
    v14:Reset()

    return v14
end

function v13.Reset(self)
    --[[
      name: Reset
      line: 67
    ]]
    self.stepRotateTimeout = 0
end

function v13.GetModuleName(a16)
    --[[
      name: GetModuleName
      line: 71
    ]]
    return "VRBaseCamera"
end

function v13.GamepadZoomPress(a17)
    --[[
      name: GamepadZoomPress
      line: 75
      upvalues:
        BaseCamera (copy, index: 1)
    ]]
    BaseCamera.GamepadZoomPress(a17)
    a17:GamepadReset()
    a17:ResetZoom()
end

function v13.GamepadReset(self)
    --[[
      name: GamepadReset
      line: 83
    ]]
    self.stepRotateTimeout = 0
    self.needsReset = true
end

function v13.ResetZoom(a19)
    --[[
      name: ResetZoom
      line: 88
      upvalues:
        ZoomController (copy, index: 1)
    ]]
    ZoomController.SetZoomParameters(a19.currentSubjectDistance, 0)
    ZoomController.ReleaseSpring()
end

function v13.OnEnabledChanged(a20)
    --[[
      name: OnEnabledChanged
      line: 93
      upvalues:
        BaseCamera (copy, index: 1)
        cameraGamepadResetAction (copy, index: 2)
        vrService (copy, index: 3)
        lighting (copy, index: 4)
    ]]
    BaseCamera.OnEnabledChanged(a20)

    if a20.enabled then
        cameraGamepadResetAction.Enabled = true
        a20.thirdPersonOptionChanged = vrService:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(
            function()
                --[[
                  line: 101
                  upvalues:
                    a20 (copy, index: 1)
                ]]
                a20:Reset()
            end
        )

        a20.vrRecentered = vrService.UserCFrameChanged:Connect(
            function(type: Enum.UserCFrame, value: CFrame)
                --[[
                  line: 105
                  upvalues:
                    a20 (copy, index: 1)
                ]]
                if type == Enum.UserCFrame.Floor then
                    a20.recentered = true
                end
            end
        )

        return
    end

    if a20.inFirstPerson then
        a20:GamepadZoomPress()
    end

    if a20.thirdPersonOptionChanged then
        a20.thirdPersonOptionChanged:Disconnect()
        a20.thirdPersonOptionChanged = nil
    end

    if a20.vrRecentered then
        a20.vrRecentered:Disconnect()
        a20.vrRecentered = nil
    end

    if a20.cameraHeadScaleChangedConn then
        a20.cameraHeadScaleChangedConn:Disconnect()
        a20.cameraHeadScaleChangedConn = nil
    end

    cameraGamepadResetAction.Enabled = false

    if const vrFade = lighting:FindFirstChild("VRFade") then
        vrFade.Brightness = 0
    end
end

function v13.OnCurrentCameraChanged(a24)
    --[[
      name: OnCurrentCameraChanged
      line: 142
      upvalues:
        BaseCamera (copy, index: 1)
    ]]
    BaseCamera.OnCurrentCameraChanged(a24)

    if a24.cameraHeadScaleChangedConn then
        a24.cameraHeadScaleChangedConn:Disconnect()
        a24.cameraHeadScaleChangedConn = nil
    end

    if const camera = workspace.CurrentCamera then
        a24.cameraHeadScaleChangedConn = camera:GetPropertyChangedSignal("HeadScale"):Connect(
            function()
                --[[
                  line: 154
                  upvalues:
                    a24 (copy, index: 1)
                ]]
                a24:OnHeadScaleChanged()
            end
        )
        a24:OnHeadScaleChanged()
    end
end

function v13.OnHeadScaleChanged(a26)
    --[[
      name: OnHeadScaleChanged
      line: 161
    ]]
    local camera = workspace.CurrentCamera
    local headScale = camera.HeadScale

    for gamepadZoomLevelKey, gamepadZoomLevel in a26.gamepadZoomLevels do
        a26.gamepadZoomLevels[gamepadZoomLevelKey] = gamepadZoomLevel * headScale / a26.headScale
    end

    a26:SetCameraToSubjectDistance(a26:GetCameraToSubjectDistance() * headScale / a26.headScale)
    a26.headScale = headScale
end

function v13.GetVRFocus(a31, a32, a33)
    --[[
      name: GetVRFocus
      line: 176
    ]]
    local v34 = a31.lastCameraFocus or a32
    a31.cameraTranslationConstraints = Vector3.new(a31.cameraTranslationConstraints.x, math.min(1, a31.cameraTranslationConstraints.y + a33), a31.cameraTranslationConstraints.z)
    local vector3 = Vector3.new(0, a31:GetCameraHeight(), 0)

    return (CFrame.new(Vector3.new(a32.x, v34.y, a32.z):Lerp(a32 + vector3, a31.cameraTranslationConstraints.y)))
end

function v13.StartFadeFromBlack(a36)
    --[[
      name: StartFadeFromBlack
      line: 195
      upvalues:
        v6 (copy, index: 1)
        lighting (copy, index: 2)
    ]]
    if v6.VignetteEnabled == false then
        return
    end

    local vrFade = lighting:FindFirstChild("VRFade")
    if not vrFade then
        vrFade = Instance.new("ColorCorrectionEffect")
        vrFade.Name = "VRFade"
        vrFade.Parent = lighting
    end

    vrFade.Brightness = -1
    a36.VRFadeResetTimer = 0.1
end

function v13.UpdateFadeFromBlack(a38, a39)
    --[[
      name: UpdateFadeFromBlack
      line: 210
      upvalues:
        lighting (copy, index: 1)
    ]]
    local vrFade = lighting:FindFirstChild("VRFade")

    if not (0 < a38.VRFadeResetTimer) then
        if vrFade then
            vrFade.Brightness = 0
        end
    else
        a38.VRFadeResetTimer = math.max(a38.VRFadeResetTimer - a39, 0)
        local vrFade2 = lighting:FindFirstChild("VRFade")

        if vrFade2 and vrFade2.Brightness < 0 then
            vrFade2.Brightness = math.min(vrFade2.Brightness + (a39 * 10), 0)
        end
    end
end

function v13.StartVREdgeBlur(a42, a43, a44)
    --[[
      name: StartVREdgeBlur
      line: 226
      upvalues:
        v6 (copy, index: 1)
        runService (copy, index: 2)
        vrService (copy, index: 3)
    ]]
    if not a44 and v6.VignetteEnabled == false then
        return
    end

    local instance = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
    if not instance then
        local vrBlurPart = Instance.new("Part")
        vrBlurPart.Name = "VRBlurPart"
        local camera = workspace.CurrentCamera
        vrBlurPart.Parent = camera
        vrBlurPart.CanTouch = false
        vrBlurPart.CanCollide = false
        vrBlurPart.CanQuery = false
        vrBlurPart.Anchored = true
        vrBlurPart.Size = Vector3.new(0.4399999976158142, 0.4699999988079071, 1)
        vrBlurPart.Transparency = 1
        vrBlurPart.CastShadow = false

        runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 246
                  upvalues:
                    vrService (copy, index: 1)
                    vrBlurPart (ref,  index: 2)
                ]]
                local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
                local v50 = workspace.CurrentCamera.CFrame * (CFrame.new(userCFrame.Position * workspace.CurrentCamera.HeadScale) * (userCFrame - userCFrame.Position))
                vrBlurPart.CFrame = v50 * CFrame.Angles(0, math.pi, 0) + (v50.LookVector * (1.05 * workspace.CurrentCamera.HeadScale))
                vrBlurPart.Size = Vector3.new(0.4399999976158142, 0.4699999988079071, 1) * workspace.CurrentCamera.HeadScale
            end
        )

        instance = vrBlurPart
    end

    local v51 = a43.PlayerGui:FindFirstChild("VRBlurScreen")
    local v52 = nil

    if v51 then
        v52 = v51:FindFirstChild("VRBlur")
    end

    if not v52 then
        v51 = v51 or Instance.new("SurfaceGui")
        v51.Name = "VRBlurScreen"
        v51.Parent = a43.PlayerGui
        v51.Adornee = instance
        v52 = Instance.new("ImageLabel")
        v52.Name = "VRBlur"
        v52.Parent = v51
        v52.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
        v52.AnchorPoint = Vector2.new(0.5, 0.5)
        v52.Position = UDim2.new(0.5, 0, 0.5, 0)
        local v53 = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
        local v54 = workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512
        v52.Size = UDim2.fromScale(v53, v54)
        v52.BackgroundTransparency = 1
        v52.Active = true
        v52.ScaleType = Enum.ScaleType.Stretch
    end

    v52.Visible = true
    v52.ImageTransparency = 0
    a42.VREdgeBlurTimer = 0.14
end

function v13.UpdateEdgeBlur(a55, a56, a57)
    --[[
      name: UpdateEdgeBlur
      line: 300
    ]]
    local vrBlurScreen = a56.PlayerGui:FindFirstChild("VRBlurScreen")
    local vrBlur = nil

    if vrBlurScreen then
        vrBlur = vrBlurScreen:FindFirstChild("VRBlur")
    end

    if vrBlur then
        if not (0 < a55.VREdgeBlurTimer) then
            vrBlur.Visible = false
        else
            a55.VREdgeBlurTimer -= a57

            if const vrBlurScreen2 = a56.PlayerGui:FindFirstChild("VRBlurScreen") then
                if const vrBlur2 = vrBlurScreen2:FindFirstChild("VRBlur") then
                    vrBlur2.ImageTransparency = 1 - (math.clamp(a55.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142)
                end
            end
        end
    end
end

function v13.GetCameraHeight(a62)
    --[[
      name: GetCameraHeight
      line: 326
    ]]
    if not a62.inFirstPerson then
        return 0.25881904510252074 * a62.currentSubjectDistance
    end

    return 0
end

function v13.GetSubjectCFrame(a63)
    --[[
      name: GetSubjectCFrame
      line: 333
      upvalues:
        BaseCamera (copy, index: 1)
    ]]
    local v64 = BaseCamera.GetSubjectCFrame(a63)
    local v65 = workspace.CurrentCamera
    v65 = v65 and v65.CameraSubject

    if not v65 then
        return v64
    end

    if v65:IsA("Humanoid") then
        local state = v65:GetState()

        if state == Enum.HumanoidStateType.Dead and v65 == a63.lastSubject then
            v64 = a63.lastSubjectCFrame
        end
    end

    if v64 then
        a63.lastSubjectCFrame = v64
    end

    return v64
end

function v13.GetSubjectPosition(a67)
    --[[
      name: GetSubjectPosition
      line: 359
      upvalues:
        BaseCamera (copy, index: 1)
    ]]
    local v68 = BaseCamera.GetSubjectPosition(a67)
    local v69 = game.Workspace.CurrentCamera
    v69 = v69 and v69.CameraSubject

    if not v69 then
        return nil
    end

    if v69:IsA("Humanoid") then
        local state = v69:GetState()

        if state == Enum.HumanoidStateType.Dead and v69 == a67.lastSubject then
            v68 = a67.lastSubjectPosition
        end
    elseif v69:IsA("VehicleSeat") then
        v68 = v69.CFrame.Position + v69.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
    end

    a67.lastSubjectPosition = v68

    return v68
end

function v13.getRotation(a71, a72)
    --[[
      name: getRotation
      line: 388
      upvalues:
        CameraInput (copy, index: 1)
        v6 (copy, index: 2)
    ]]
    local rotation = CameraInput.getRotation(a72)

    if v6.VRSmoothRotationEnabled then
        return rotation.X
    end

    if not (0.03 < math.abs(rotation.X)) then
        if math.abs(rotation.X) < 0.02 then
            a71.stepRotateTimeout = 0
        end
    else
        if 0 < a71.stepRotateTimeout then
            a71.stepRotateTimeout -= a72
        end

        if a71.stepRotateTimeout <= 0 then
            local v74 = 1

            if rotation.X < 0 then
                v74 = -1
            end

            local v75 = v74 * 0.5235987755982988
            a71:StartFadeFromBlack()
            a71.stepRotateTimeout = 0.25

            return v75
        end
    end

    return 0
end

function v13.HandleSubjectDistance(a76, a77)
    --[[
      name: HandleSubjectDistance
      line: 422
    ]]
    if a77 and a77.IsInFirstPerson and a77:IsInFirstPerson() then
        a76:SetCameraToSubjectDistance(0)
    end
end

return v13