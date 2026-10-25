local Players_upv_1 = game:GetService("Players")
local VRService_upv_1 = game:GetService("VRService")
local _ = require(script.Parent:WaitForChild("CameraInput"))
local v2 = require(script.Parent:WaitForChild("CameraUtils"))
local VRCameraTeleportDetector_upv_1 = require(script.Parent:WaitForChild("VRCameraTeleportDetector"))
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u1 = v1.getUserFlag("UserPSVRCameraInputMoveVector")
local u2 = v1.getUserFlag("UserVRRecenterOnExternalTeleport")
local u3 = v1.getUserFlag("UserVRSkipOcclusionInFirstPerson")
local u4 = v1.getUserFlag("UserFixVRImmersionAutoRotate")
local VRBaseCamera_upv_1 = require(script.Parent:WaitForChild("VRBaseCamera"))
local u5 = setmetatable({}, VRBaseCamera_upv_1)
u5.__index = u5
function u5.new()
    --[[
      name: new
      line: 35
      upvalues:
        VRBaseCamera_upv_1 (copy, index: 1)
        u5 (copy, index: 2)
    ]]
    local v2 = setmetatable(VRBaseCamera_upv_1.new(), u5)
    v2.lastUpdate = tick()
    v2.focusOffset = CFrame.new()
    v2:Reset()
    v2.controlModule = require(script.Parent.Parent:WaitForChild("ControlModule"))
    v2.savedAutoRotate = true
    v2.autoRotateOverridden = false
    return v2
end
function u5.Reset(a1)
    --[[
      name: Reset
      line: 49
      upvalues:
        VRBaseCamera_upv_1 (copy, index: 1)
    ]]
    a1.needsReset = true
    a1.needsBlackout = true
    a1.motionDetTime = 0
    a1.blackOutTimer = 0
    a1.lastCameraResetPosition = nil
    VRBaseCamera_upv_1.Reset(a1)
end
function u5.Update(a1, a2)
    --[[
      name: Update
      line: 58
      upvalues:
        Players_upv_1 (copy, index: 1)
        u3 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    local v3 = CurrentCamera_1.CFrame
    local v4 = CurrentCamera_1.Focus
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    if a1.lastUpdate == nil or a2 > 1 then
        a1.lastCameraTransform = nil
    end
    a1:UpdateFadeFromBlack(a2)
    local lastSubjectPosition_1 = a1.lastSubjectPosition
    local v5 = a1:GetSubjectPosition()
    if a1.needsBlackout then
        a1:StartFadeFromBlack()
        a1.blackOutTimer = a1.blackOutTimer + math.clamp(a2, 1e-04, 0.1)
        if a1.blackOutTimer > 0.1 and game:IsLoaded() then
            a1.needsBlackout = false
            a1.needsReset = true
        end
    end
    if v5 and LocalPlayer_1 and CurrentCamera_1 then
        v4 = a1:GetVRFocus(v5, a2)
        if u3 then
            a1.skipOcclusion = a1:IsInFirstPerson() and LocalPlayer_1.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
        end
        if a1:IsInFirstPerson() then
            if VRService_upv_1.AvatarGestures then
                local v7, v8 = a1:UpdateImmersionCamera(a2, v3, v4, lastSubjectPosition_1, v5)
                v3, v4 = v7, v8
            else
                local v9, v10 = a1:UpdateFirstPersonTransform(a2, v3, v4, lastSubjectPosition_1, v5)
                v3, v4 = v9, v10
            end
        elseif VRService_upv_1.ThirdPersonFollowCamEnabled then
            local v11, v12 = a1:UpdateThirdPersonFollowTransform(a2, v3, v4, lastSubjectPosition_1, v5)
            v3, v4 = v11, v12
        else
            local v13, v14 = a1:UpdateThirdPersonComfortTransform(a2, v3, v4, lastSubjectPosition_1, v5)
            v3, v4 = v13, v14
        end
        a1.lastCameraTransform = v3
        a1.lastCameraFocus = v4
    end
    a1.lastUpdate = tick()
    return v3, v4
end
function u5.GetAvatarFeetWorldYValue(a1)
    --[[
      name: GetAvatarFeetWorldYValue
      line: 126
    ]]
    local CameraSubject_1 = workspace.CurrentCamera.CameraSubject
    if not CameraSubject_1 or not CameraSubject_1:IsA("Humanoid") or not CameraSubject_1.RootPart then
        return nil
    end
    local RootPart_1 = CameraSubject_1.RootPart
    return (RootPart_1.Position.Y - (RootPart_1.Size.Y / 2)) - CameraSubject_1.HipHeight
end
function u5.UpdateFirstPersonTransform(a1, a2, a3, a4, a5, a6)
    --[[
      name: UpdateFirstPersonTransform
      line: 141
    ]]
    if a1.needsReset then
        a1:StartFadeFromBlack()
        a1.needsReset = false
    end
    local Position_1 = a4.Position
    local v15 = a1:GetCameraLookVector()
    return CFrame.new(Position_1 - (0.5 * a1:CalculateNewLookVectorFromArg(Vector3.new(v15.X, 0, v15.Z).Unit, Vector2.new(a1:getRotation(a2), 0))), Position_1), a4
end
function u5.UpdateImmersionCamera(a1, a2, a3, a4, a5, a6)
    --[[
      name: UpdateImmersionCamera
      line: 161
      upvalues:
        Players_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        u4 (copy, index: 3)
        VRService_upv_1 (copy, index: 4)
        VRCameraTeleportDetector_upv_1 (copy, index: 5)
    ]]
    local v16 = a1:GetSubjectCFrame()
    local CurrentCamera_2 = workspace.CurrentCamera
    local Character_1 = Players_upv_1.LocalPlayer.Character
    local v17 = a1:GetHumanoid()
    if not v17 then
        return CurrentCamera_2.CFrame, CurrentCamera_2.Focus
    end
    local HumanoidRootPart_1 = Character_1:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart_1 then
        return CurrentCamera_2.CFrame, CurrentCamera_2.Focus
    end
    local v18 = (not u2) or (((not a5) and 0) or (Vector3.new(a6.X - a5.X, 0, a6.Z - a5.Z).Magnitude))
    a1.characterOrientation = HumanoidRootPart_1:FindFirstChild("CharacterAlignOrientation")
    local v19 = nil
    if not (a1.characterOrientation) then
        v19 = HumanoidRootPart_1:FindFirstChild("RootAttachment")
        if not v19 then
            return
        end
        a1.characterOrientation = Instance.new("AlignOrientation")
        a1.characterOrientation.Name = "CharacterAlignOrientation"
        a1.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        a1.characterOrientation.Attachment0 = v19
        a1.characterOrientation.RigidityEnabled = true
        a1.characterOrientation.Parent = HumanoidRootPart_1
    end
    if a1.characterOrientation.Enabled == false then
        a1.characterOrientation.Enabled = true
    end
    if a1.needsReset then
        a1.needsReset = false
        if u4 then
            a1:updateImmersionAutoRotate()
        else
            a1.savedAutoRotate = v17.AutoRotate
            v17.AutoRotate = false
        end
        if u2 then
            VRService_upv_1:RecenterUserHeadCFrame()
            a1.lastTeleportRecenter = tick()
        end
        a1:StartFadeFromBlack()
        a3 = v16
    else
        local v20 = nil
        if v17.Sit then
            a3 = v16
        else
            a1.characterOrientation.CFrame = CurrentCamera_2.CFrame * a1.controlModule:GetEstimatedVRTorsoFrame()
            if a1.controlModule.inputMoveVector.Magnitude > 0 then
                a1.motionDetTime = 0.1
            end
            if a1.controlModule.inputMoveVector.Magnitude > 0 or a1.motionDetTime > 0 then
                a1.motionDetTime = a1.motionDetTime - a2
                local v21 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
                local HumanoidRootPart_2 = Character_1.HumanoidRootPart
                local v22 = CurrentCamera_2.CFrame * (v21.Rotation + (v21.Position * CurrentCamera_2.HeadScale)) * CFrame.new(0, (-0.7 * HumanoidRootPart_2.Size.Y) / 2, 0)
                local LookVector_1 = HumanoidRootPart_2.CFrame.LookVector
                local v23 = a6 - (v22 - ((Vector3.new(LookVector_1.X, 0, LookVector_1.Z).Unit * HumanoidRootPart_2.Size.Y) * 0.125)).Position + CurrentCamera_2.CFrame.Position
                a3 = CurrentCamera_2.CFrame.Rotation + Vector3.new(v23.X, a6.Y, v23.Z)
            elseif (u2) and (VRCameraTeleportDetector_upv_1.shouldRecenter(a1.prevSubjStep, v18, a1.lastTeleportRecenter, tick())) then
                local v24 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
                local HumanoidRootPart_3 = Character_1.HumanoidRootPart
                local v25 = CurrentCamera_2.CFrame * (v24.Rotation + (v24.Position * CurrentCamera_2.HeadScale)) * CFrame.new(0, (-0.7 * HumanoidRootPart_3.Size.Y) / 2, 0)
                local LookVector_2 = HumanoidRootPart_3.CFrame.LookVector
                local v26 = a6 - (v25 - ((Vector3.new(LookVector_2.X, 0, LookVector_2.Z).Unit * HumanoidRootPart_3.Size.Y) * 0.125)).Position + CurrentCamera_2.CFrame.Position
                local v27 = CurrentCamera_2.CFrame.Rotation + Vector3.new(v26.X, a6.Y, v26.Z)
                VRService_upv_1:RecenterUserHeadCFrame()
                a1:StartFadeFromBlack()
                a1.lastTeleportRecenter = tick()
                a3 = v27
            else
                a3 = CurrentCamera_2.CFrame.Rotation + Vector3.new(CurrentCamera_2.CFrame.Position.X, a6.Y, CurrentCamera_2.CFrame.Position.Z)
            end
            v20 = a1:getRotation(a2)
            if math.abs(v20) > 0 then
                local v28 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
                local v29 = v28.Rotation + v28.Position * CurrentCamera_2.HeadScale
                local v30 = a3 * v29
                a3 = CFrame.new(v30.Position) * CFrame.Angles(0, -math.rad(v20 * 90), 0) * v30.Rotation * v29:Inverse()
            end
        end
    end
    if u2 then
        a1.prevSubjStep = v18
    end
    return a3, a3 * CFrame.new(0, 0, -0.5)
end
function u5.UpdateThirdPersonComfortTransform(a1, a2, a3, a4, a5, a6)
    --[[
      name: UpdateThirdPersonComfortTransform
      line: 313
      upvalues:
        u1 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
    ]]
    local v31 = a1:GetCameraToSubjectDistance()
    local v32 = ((v31 < 0.5) and 0.5) or v31
    if a5 ~= nil then
        local v33, v34 = nil, nil
        if a1.lastCameraFocus ~= nil then
            local v35
            if u1 then
                v35 = a1.controlModule.inputMoveVector
            else
                v35 = a1.controlModule:GetMoveVector()
            end
            local v36 = true
            if not ((a5 - a6).magnitude > 0.01) then
                v36 = v35.magnitude > 0.01
            end
            if v36 then
                a1.motionDetTime = 0.1
            end
            a1.motionDetTime = a1.motionDetTime - a2
            if (((a1.motionDetTime > 0) and true) or v36) and not (a1.needsReset) then
                a4 = a1.lastCameraFocus
                a1.VRCameraFocusFrozen = true
                return a3, a4
            end
            local v37 = true
            if a1.lastCameraResetPosition == nil then
                v35 = v37
            else
                v35 = (a6 - a1.lastCameraResetPosition).Magnitude > 1
            end
            v33 = a1:getRotation(a2)
            if math.abs(v33) > 0 then
                local v38 = a4:ToObjectSpace(a3)
                a3 = a4 * CFrame.Angles(0, -v33, 0) * v38
            end
            if a1.VRCameraFocusFrozen and v35 or a1.needsReset then
                VRService_upv_1:RecenterUserHeadCFrame()
                a1.VRCameraFocusFrozen = false
                a1.needsReset = false
                a1.lastCameraResetPosition = a6
                a1:ResetZoom()
                a1:StartFadeFromBlack()
                v34 = a1:GetHumanoid()
                local v39 = v34.Torso and v34.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
                local v40 = a4.Position - Vector3.new(v39.X, 0, v39.Z) * v32
                a3 = CFrame.new(v40, Vector3.new(a4.Position.X, v40.Y, a4.Position.Z))
            end
        end
    end
    return a3, a4
end
function u5.UpdateThirdPersonFollowTransform(a1, a2, a3, a4, a5, a6)
    --[[
      name: UpdateThirdPersonFollowTransform
      line: 379
      upvalues:
        VRService_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
    ]]
    local CurrentCamera_3 = workspace.CurrentCamera
    local v41 = a1:GetCameraToSubjectDistance()
    local v42 = a1:GetVRFocus(a6, a2)
    if a1.needsReset then
        a1.needsReset = false
        VRService_upv_1:RecenterUserHeadCFrame()
        a1:ResetZoom()
        a1:StartFadeFromBlack()
    end
    local v43, v44 = nil, nil
    if a1.recentered then
        v43 = a1:GetSubjectCFrame()
        if not v43 then
            return CurrentCamera_3.CFrame, CurrentCamera_3.Focus
        end
        local v45 = v42 * v43.Rotation * CFrame.new(0, 0, v41)
        a1.focusOffset = v42:ToObjectSpace(v45)
        a1.recentered = false
        return v45, v42
    else
        local v46 = v42:ToWorldSpace(a1.focusOffset)
        local controlModule_1 = a1.controlModule
        local v47
        if u1 then
            v47 = controlModule_1.inputMoveVector
        else
            v47 = controlModule_1:GetMoveVector()
        end
        if (a5 - a6).magnitude > 0.01 or v47.magnitude > 0 then
            local v48 = controlModule_1:GetEstimatedVRTorsoFrame()
            local v49 = CurrentCamera_3.CFrame * (v48.Rotation + (v48.Position * CurrentCamera_3.HeadScale))
            local LookVector_3 = v49.LookVector
            a3 = v46:Lerp(CFrame.new((CurrentCamera_3.CFrame.Position + (v42.Position - Vector3.new(LookVector_3.X, 0, LookVector_3.Z).Unit * v41)) - v49.Position) * v46.Rotation, 0.01)
        else
            a3 = v46
        end
        v44 = a1:getRotation(a2)
        if math.abs(v44) > 0 then
            local v50 = v42:ToObjectSpace(a3)
            a3 = v42 * CFrame.Angles(0, -v44, 0) * v50
        end
        a1.focusOffset = v42:ToObjectSpace(a3)
        return a3, a3 * CFrame.new(0, 0, -v41)
    end
end
function u5.updateImmersionAutoRotate(a1)
    --[[
      name: updateImmersionAutoRotate
      line: 453
      upvalues:
        VRService_upv_1 (copy, index: 1)
    ]]
    local v51 = a1:GetHumanoid()
    if not v51 then
        return
    end
    if a1:IsInFirstPerson() and VRService_upv_1.AvatarGestures then
        if not (a1.autoRotateOverridden) then
            a1.savedAutoRotate = v51.AutoRotate
            a1.autoRotateOverridden = true
        end
        v51.AutoRotate = false
        return
    end
    if a1.autoRotateOverridden then
        v51.AutoRotate = a1.savedAutoRotate
        a1.autoRotateOverridden = false
    end
end
function u5.OnEnabledChanged(a1)
    --[[
      name: OnEnabledChanged
      line: 473
      upvalues:
        VRBaseCamera_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
    ]]
    VRBaseCamera_upv_1.OnEnabledChanged(a1)
    if not u4 then
        return
    end
    if a1.enabled then
        if not (a1.avatarGesturesChangedConn) then
            a1.avatarGesturesChangedConn = VRService_upv_1:GetPropertyChangedSignal("AvatarGestures"):Connect(
                function()
                    --[[
                      line: 482
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    a1:updateImmersionAutoRotate()
                end
            )
            return
        end
    elseif a1.avatarGesturesChangedConn then
        a1.avatarGesturesChangedConn:Disconnect()
        a1.avatarGesturesChangedConn = nil
    end
end
function u5.LeaveFirstPerson(a1)
    --[[
      name: LeaveFirstPerson
      line: 492
      upvalues:
        VRBaseCamera_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
    ]]
    VRBaseCamera_upv_1.LeaveFirstPerson(a1)
    a1.needsReset = true
    if a1.VRBlur then
        a1.VRBlur.Visible = false
    end
    if a1.characterOrientation then
        a1.characterOrientation.Enabled = false
    end
    if u4 then
        a1:updateImmersionAutoRotate()
    else
        local v52 = a1:GetHumanoid()
        if v52 then
            v52.AutoRotate = a1.savedAutoRotate
        end
    end
end
return u5