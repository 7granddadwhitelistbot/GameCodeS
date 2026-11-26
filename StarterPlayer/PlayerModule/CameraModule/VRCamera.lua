local players = game:GetService("Players")
local vrService = game:GetService("VRService")
require(script.Parent:WaitForChild("CameraInput"))
require(script.Parent:WaitForChild("CameraUtils"))
local VRCameraTeleportDetector = require(script.Parent:WaitForChild("VRCameraTeleportDetector"))
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v5 = CommonUtils.get("FlagUtil")
local userFlag = v5.getUserFlag("UserVRRecenterOnExternalTeleport")
local userFlag2 = v5.getUserFlag("UserVRSkipOcclusionInFirstPerson")
local userFlag3 = v5.getUserFlag("UserFixVRImmersionAutoRotate")
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))
local v10 = setmetatable({}, VRBaseCamera)
v10.__index = v10

function v10.new()
    --[[
      name: new
      line: 36
      upvalues:
        VRBaseCamera (copy, index: 1)
        v10 (copy, index: 2)
    ]]
    local v11 = setmetatable(VRBaseCamera.new(), v10)
    v11.lastUpdate = tick()
    v11.focusOffset = CFrame.new()
    v11:Reset()
    v11.controlModule = require(script.Parent.Parent:WaitForChild("ControlModule"))
    v11.savedAutoRotate = true
    v11.autoRotateOverridden = false

    return v11
end

function v10.Reset(self)
    --[[
      name: Reset
      line: 50
      upvalues:
        VRBaseCamera (copy, index: 1)
    ]]
    self.needsReset = true
    self.needsBlackout = true
    self.motionDetTime = 0
    self.blackOutTimer = 0
    self.lastCameraResetPosition = nil
    VRBaseCamera.Reset(self)
end

function v10.Update(a13, a14: number)
    --[[
      name: Update
      line: 59
      upvalues:
        players (copy, index: 1)
        userFlag2 (copy, index: 2)
        vrService (copy, index: 3)
    ]]
    local camera = workspace.CurrentCamera
    local v16 = camera.CFrame
    local v17 = camera.Focus
    local localPlayer = players.LocalPlayer

    if a13.lastUpdate == nil or 1 < a14 then
        a13.lastCameraTransform = nil
    end

    a13:UpdateFadeFromBlack(a14)
    local lastSubjectPosition = a13.lastSubjectPosition
    local subjectPosition = a13:GetSubjectPosition()

    if a13.needsBlackout then
        a13:StartFadeFromBlack()
        local clampedValue = math.clamp(a14, 1e-04, 0.1)
        a13.blackOutTimer += clampedValue

        if 0.1 < a13.blackOutTimer and game:IsLoaded() then
            a13.needsBlackout = false
            a13.needsReset = true
        end
    end

    if subjectPosition and localPlayer and camera then
        local lastCameraFocus
        local vrFocus = a13:GetVRFocus(subjectPosition, a14)

        if userFlag2 then
            local skipOcclusion = a13:IsInFirstPerson()
                and localPlayer.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
            a13.skipOcclusion = skipOcclusion
        end

        if a13:IsInFirstPerson() then
            if vrService.AvatarGestures then
                v16, lastCameraFocus = a13:UpdateImmersionCamera(a14, v16, vrFocus, lastSubjectPosition, subjectPosition)
            else
                v16, lastCameraFocus = a13:UpdateFirstPersonTransform(a14, v16, vrFocus, lastSubjectPosition, subjectPosition)
            end
        elseif vrService.ThirdPersonFollowCamEnabled then
            v16, lastCameraFocus = a13:UpdateThirdPersonFollowTransform(a14, v16, vrFocus, lastSubjectPosition, subjectPosition)
        else
            v16, lastCameraFocus = a13:UpdateThirdPersonComfortTransform(a14, v16, vrFocus, lastSubjectPosition, subjectPosition)
        end

        a13.lastCameraTransform = v16
        a13.lastCameraFocus = lastCameraFocus
        v17 = lastCameraFocus
    end

    a13.lastUpdate = tick()

    return v16, v17
end

function v10.GetAvatarFeetWorldYValue(a25)
    --[[
      name: GetAvatarFeetWorldYValue
      line: 142
    ]]
    local camera = workspace.CurrentCamera
    local cameraSubject = camera.CameraSubject
    if not cameraSubject then
        return nil
    end
    if not cameraSubject:IsA("Humanoid") or not cameraSubject.RootPart then
        return nil
    end

    local rootPart = cameraSubject.RootPart

    return rootPart.Position.Y - (rootPart.Size.Y / 2) - cameraSubject.HipHeight
end

function v10.UpdateFirstPersonTransform(a29, a30, a31, a32, a33, a34)
    --[[
      name: UpdateFirstPersonTransform
      line: 157
    ]]
    if a29.needsReset then
        a29:StartFadeFromBlack()
        a29.needsReset = false
    end

    local position = a32.Position
    local cameraLookVector = a29:GetCameraLookVector()
    local unit = Vector3.new(cameraLookVector.X, 0, cameraLookVector.Z).Unit
    local x = a29:getRotation(a30)
    local v39 = a29:CalculateNewLookVectorFromArg(unit, Vector2.new(x, 0))

    return CFrame.new(position - (0.5 * v39), position), a32
end

function v10.UpdateImmersionCamera(a40, a41, a42, a43, a44, a45)
    --[[
      name: UpdateImmersionCamera
      line: 177
      upvalues:
        players (copy, index: 1)
        userFlag (copy, index: 2)
        userFlag3 (copy, index: 3)
        vrService (copy, index: 4)
        VRCameraTeleportDetector (copy, index: 5)
    ]]
    local v46
    local subjectCFrame = a40:GetSubjectCFrame()
    local camera = workspace.CurrentCamera
    local character = players.LocalPlayer.Character
    local humanoid = a40:GetHumanoid()
    if not humanoid then
        return camera.CFrame, camera.Focus
    end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return camera.CFrame, camera.Focus
    end

    local v52 = nil

    if userFlag then
        v52 = not a44 and 0 or Vector3.new(a45.X - a44.X, 0, a45.Z - a44.Z).Magnitude
    end

    a40.characterOrientation = humanoidRootPart:FindFirstChild("CharacterAlignOrientation")

    if not a40.characterOrientation then
        local rootAttachment = humanoidRootPart:FindFirstChild("RootAttachment")
        if not rootAttachment then
            return
        end

        a40.characterOrientation = Instance.new("AlignOrientation")
        a40.characterOrientation.Name = "CharacterAlignOrientation"
        a40.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        a40.characterOrientation.Attachment0 = rootAttachment
        a40.characterOrientation.RigidityEnabled = true
        a40.characterOrientation.Parent = humanoidRootPart
    end

    if a40.characterOrientation.Enabled == false then
        a40.characterOrientation.Enabled = true
    end

    if a40.needsReset then
        a40.needsReset = false

        if userFlag3 then
            a40:updateImmersionAutoRotate()
        else
            a40.savedAutoRotate = humanoid.AutoRotate
            humanoid.AutoRotate = false
        end

        if userFlag then
            vrService:RecenterUserHeadCFrame()
            a40.lastTeleportRecenter = tick()
        end

        a40:StartFadeFromBlack()
        v46 = subjectCFrame
    elseif humanoid.Sit then
        v46 = subjectCFrame
    else
        local estimatedVrTorsoFrame = a40.controlModule:GetEstimatedVRTorsoFrame()
        a40.characterOrientation.CFrame = camera.CFrame * estimatedVrTorsoFrame

        if 0 < a40.controlModule.inputMoveVector.Magnitude then
            a40.motionDetTime = 0.1
        end

        if 0 < a40.controlModule.inputMoveVector.Magnitude or 0 < a40.motionDetTime then
            a40.motionDetTime -= a41
            local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
            local v56 = userCFrame.Rotation + userCFrame.Position * camera.HeadScale
            local humanoidRootPart2 = character.HumanoidRootPart
            local y = -0.7 * humanoidRootPart2.Size.Y / 2
            local v59 = camera.CFrame * v56 * CFrame.new(0, y, 0)
            local lookVector = humanoidRootPart2.CFrame.LookVector
            local v61 = a45 - (v59 - ((Vector3.new(lookVector.X, 0, lookVector.Z).Unit * humanoidRootPart2.Size.Y) * 0.125)).Position + camera.CFrame.Position
            local vector3 = Vector3.new(v61.X, a45.Y, v61.Z)
            v46 = camera.CFrame.Rotation + vector3
        elseif userFlag
            and VRCameraTeleportDetector.shouldRecenter(a40.prevSubjStep, v52, a40.lastTeleportRecenter, tick())
        then
            local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
            local v64 = userCFrame.Rotation + userCFrame.Position * camera.HeadScale
            local humanoidRootPart3 = character.HumanoidRootPart
            local y = -0.7 * humanoidRootPart3.Size.Y / 2
            local v67 = camera.CFrame * v64 * CFrame.new(0, y, 0)
            local lookVector = humanoidRootPart3.CFrame.LookVector
            local v69 = a45 - (v67 - ((Vector3.new(lookVector.X, 0, lookVector.Z).Unit * humanoidRootPart3.Size.Y) * 0.125)).Position + camera.CFrame.Position
            local vector3 = Vector3.new(v69.X, a45.Y, v69.Z)
            v46 = camera.CFrame.Rotation + vector3
            vrService:RecenterUserHeadCFrame()
            a40:StartFadeFromBlack()
            a40.lastTeleportRecenter = tick()
        else
            v46 = camera.CFrame.Rotation + Vector3.new(camera.CFrame.Position.X, a45.Y, camera.CFrame.Position.Z)
        end

        local rotation = a40:getRotation(a41)

        if 0 < math.abs(rotation) then
            local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
            local v73 = userCFrame.Rotation + userCFrame.Position * camera.HeadScale
            local v74 = v46 * v73
            v46 = (CFrame.new(v74.Position) * CFrame.Angles(0, -math.rad(rotation * 90), 0)) * v74.Rotation * v73:Inverse()
        end
    end

    if userFlag then
        a40.prevSubjStep = v52
    end

    return v46, v46 * CFrame.new(0, 0, -0.5)
end

function v10.UpdateThirdPersonComfortTransform(a75, a76, a77, a78, a79, lastCameraResetPosition)
    --[[
      name: UpdateThirdPersonComfortTransform
      line: 339
      upvalues:
        vrService (copy, index: 1)
    ]]
    local cameraToSubjectDistance = a75:GetCameraToSubjectDistance()

    if cameraToSubjectDistance < 0.5 then
        cameraToSubjectDistance = 0.5
    end

    if a79 ~= nil and a75.lastCameraFocus ~= nil then
        local v82 = a79 - lastCameraResetPosition
        local inputMoveVector = a75.controlModule.inputMoveVector
        local v84 = 0.01 < v82.magnitude or 0.01 < inputMoveVector.magnitude
        if v84 then
            a75.motionDetTime = 0.1
        end

        a75.motionDetTime -= a76

        if 0 < a75.motionDetTime then
            v84 = true
        end

        if v84 and not a75.needsReset then
            local lastCameraFocus = a75.lastCameraFocus
            a75.VRCameraFocusFrozen = true

            return a77, lastCameraFocus
        end

        local v86 = a75.lastCameraResetPosition == nil
            or 1 < (lastCameraResetPosition - a75.lastCameraResetPosition).Magnitude
        local rotation = a75:getRotation(a76)

        if 0 < math.abs(rotation) then
            local v88 = a78:ToObjectSpace(a77)
            a77 = a78 * CFrame.Angles(0, -rotation, 0) * v88
        end

        if a75.VRCameraFocusFrozen and v86 or a75.needsReset then
            vrService:RecenterUserHeadCFrame()
            a75.VRCameraFocusFrozen = false
            a75.needsReset = false
            a75.lastCameraResetPosition = lastCameraResetPosition
            a75:ResetZoom()
            a75:StartFadeFromBlack()
            local humanoid = a75:GetHumanoid()
            local v90 = humanoid.Torso and humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
            local vector3 = Vector3.new(v90.X, 0, v90.Z)
            local v92 = a78.Position - vector3 * cameraToSubjectDistance
            local vector32 = Vector3.new(a78.Position.X, v92.Y, a78.Position.Z)
            a77 = CFrame.new(v92, vector32)
        end
    end

    return a77, a78
end

function v10.UpdateThirdPersonFollowTransform(a94, a95, a96, a97, a98, a99)
    --[[
      name: UpdateThirdPersonFollowTransform
      line: 412
      upvalues:
        vrService (copy, index: 1)
    ]]
    local v100, v101, v102
    local v103 = false
    local camera = workspace.CurrentCamera
    local z = a94:GetCameraToSubjectDistance()
    local vrFocus = a94:GetVRFocus(a99, a95)

    if a94.needsReset then
        a94.needsReset = false
        vrService:RecenterUserHeadCFrame()
        a94:ResetZoom()
        a94:StartFadeFromBlack()
    end

    if a94.recentered then
        local subjectCFrame = a94:GetSubjectCFrame()
        if not subjectCFrame then
            return camera.CFrame, camera.Focus
        end

        local v108 = vrFocus * subjectCFrame.Rotation * CFrame.new(0, 0, z)
        a94.focusOffset = vrFocus:ToObjectSpace(v108)
        a94.recentered = false

        return v108, vrFocus
    end

    local startValue = vrFocus:ToWorldSpace(a94.focusOffset)
    local v110 = a98 - a99
    local controlModule = a94.controlModule
    local inputMoveVector = controlModule.inputMoveVector

    if 0.01 < v110.magnitude then
        v103 = true
    elseif not (0 < inputMoveVector.magnitude) then
        a96 = startValue
    else
        v103 = true
    end

    if v103 then
        local estimatedVrTorsoFrame = controlModule:GetEstimatedVRTorsoFrame()
        local v114 = estimatedVrTorsoFrame.Rotation + estimatedVrTorsoFrame.Position * camera.HeadScale
        v100 = camera.CFrame * v114
        local lookVector = v100.LookVector
        local v116 = Vector3.new(lookVector.X, 0, lookVector.Z).Unit * z
        v101 = vrFocus.Position - v116
        a96 = startValue:Lerp(CFrame.new(camera.CFrame.Position + v101 - v100.Position) * startValue.Rotation, 0.01)
    end

    local rotation = a94:getRotation(a95)

    if 0 < math.abs(rotation) then
        v102 = vrFocus:ToObjectSpace(a96)
        a96 = vrFocus * CFrame.Angles(0, -rotation, 0) * v102
    end

    a94.focusOffset = vrFocus:ToObjectSpace(a96)

    return a96, a96 * CFrame.new(0, 0, -z)
end

function v10.updateImmersionAutoRotate(a118)
    --[[
      name: updateImmersionAutoRotate
      line: 491
      upvalues:
        vrService (copy, index: 1)
    ]]
    local humanoid = a118:GetHumanoid()
    if not humanoid then
        return
    end

    if a118:IsInFirstPerson() and vrService.AvatarGestures then
        if not a118.autoRotateOverridden then
            a118.savedAutoRotate = humanoid.AutoRotate
            a118.autoRotateOverridden = true
        end

        humanoid.AutoRotate = false

        return
    end

    if a118.autoRotateOverridden then
        humanoid.AutoRotate = a118.savedAutoRotate
        a118.autoRotateOverridden = false
    end
end

function v10.OnEnabledChanged(a120)
    --[[
      name: OnEnabledChanged
      line: 511
      upvalues:
        VRBaseCamera (copy, index: 1)
        userFlag3 (copy, index: 2)
        vrService (copy, index: 3)
    ]]
    VRBaseCamera.OnEnabledChanged(a120)

    if not userFlag3 then
        return
    end

    if a120.enabled then
        if not a120.avatarGesturesChangedConn then
            a120.avatarGesturesChangedConn = vrService:GetPropertyChangedSignal("AvatarGestures"):Connect(
                function()
                    --[[
                      line: 520
                      upvalues:
                        a120 (copy, index: 1)
                    ]]
                    a120:updateImmersionAutoRotate()
                end
            )
        end
    elseif a120.avatarGesturesChangedConn then
        a120.avatarGesturesChangedConn:Disconnect()
        a120.avatarGesturesChangedConn = nil
    end
end

function v10.LeaveFirstPerson(a121)
    --[[
      name: LeaveFirstPerson
      line: 530
      upvalues:
        VRBaseCamera (copy, index: 1)
        userFlag3 (copy, index: 2)
    ]]
    VRBaseCamera.LeaveFirstPerson(a121)
    a121.needsReset = true

    if a121.VRBlur then
        a121.VRBlur.Visible = false
    end

    if a121.characterOrientation then
        a121.characterOrientation.Enabled = false
    end

    if userFlag3 then
        a121:updateImmersionAutoRotate()
        return
    elseif const humanoid = a121:GetHumanoid() then
        humanoid.AutoRotate = a121.savedAutoRotate
    end
end

return v10