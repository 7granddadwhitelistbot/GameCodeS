local Players_1 = game:GetService("Players")
local VRService_upv_1 = game:GetService("VRService")
local GuiService_upv_1 = game:GetService("GuiService")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local CommonUtils_1 = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local u1 = CommonUtils_1.get("ConnectionUtil")
local _ = CommonUtils_1.get("FlagUtil")
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController_upv_1 = require(script.Parent:WaitForChild("ZoomController"))
local CameraToggleStateController_upv_1 = require(script.Parent:WaitForChild("CameraToggleStateController"))
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI_upv_1 = require(script.Parent:WaitForChild("CameraUI"))
local CameraGamepadZoomAction_upv_1 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraGamepadZoomAction")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 74
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        CameraGamepadZoomAction_upv_1 (copy, index: 4)
        UserGameSettings_upv_1 (copy, index: 5)
    ]]
    local u2 = setmetatable({}, tbl_upv_1)
    u2._connections = u1.new()
    u2.gamepadZoomLevels = {0, 10, 20}
    u2.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    u2.cameraType = nil
    u2.cameraMovementMode = nil
    u2.lastCameraTransform = nil
    u2.lastUserPanCamera = tick()
    u2.humanoidRootPart = nil
    u2.humanoidCache = {}
    u2.lastSubject = nil
    u2.lastSubjectPosition = Vector3.new(0, 5, 0)
    u2.lastSubjectCFrame = CFrame.new(u2.lastSubjectPosition)
    u2.currentSubjectDistance = math.clamp(12.5, LocalPlayer_upv_1.CameraMinZoomDistance, LocalPlayer_upv_1.CameraMaxZoomDistance)
    u2.inFirstPerson = false
    u2.inMouseLockedMode = false
    u2.resetCameraAngle = true
    u2.enabled = false
    u2.cameraChangedConn = nil
    u2.shouldUseVRRotation = false
    u2.VRRotationIntensityAvailable = false
    u2.lastVRRotationIntensityCheckTime = 0
    u2.lastVRRotationTime = 0
    u2.vrRotateKeyCooldown = {}
    u2.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    u2.humanoidJumpOrigin = nil
    u2.trackingHumanoid = nil
    u2.cameraFrozen = false
    u2.subjectStateChangedConn = nil
    u2.gamepadZoomPressConnection = CameraGamepadZoomAction_upv_1.Pressed:Connect(
        function()
            --[[
              line: 122
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:GamepadZoomPress()
        end
    )
    u2.mouseLockOffset = Vector3.new(0, 0, 0)
    UserGameSettings_upv_1:SetCameraYInvertVisible()
    UserGameSettings_upv_1:SetGamepadCameraSensitivityVisible()
    return u2
end
function tbl_upv_1.GetModuleName(a1)
    --[[
      name: GetModuleName
      line: 136
    ]]
    return "BaseCamera"
end
local function onSelectedObjectChanged()
    --[[
      name: onSelectedObjectChanged
      line: 140
      upvalues:
        CameraGamepadZoomAction_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
    ]]
    CameraGamepadZoomAction_upv_1.Enabled = not GuiService_upv_1.SelectedObject
end
function tbl_upv_1._setUpConfigurations(a1)
    --[[
      name: _setUpConfigurations
      line: 144
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
        CameraGamepadZoomAction_upv_1 (copy, index: 3)
    ]]
    a1._connections:trackConnection(
        "CHARACTER_ADDED",
        LocalPlayer_upv_1.CharacterAdded:Connect(
            function(a2)
                --[[
                  line: 145
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:OnCharacterAdded(a2)
            end
        )
    )
    a1.humanoidRootPart = nil
    a1._connections:trackConnection(
        "CAMERA_MODE_CHANGED",
        LocalPlayer_upv_1:GetPropertyChangedSignal("CameraMode"):Connect(
            function()
                --[[
                  line: 150
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:OnPlayerCameraPropertyChange()
            end
        )
    )
    a1._connections:trackConnection(
        "CAMERA_MIN_DISTANCE_CHANGED",
        LocalPlayer_upv_1:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(
            function()
                --[[
                  line: 153
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:OnPlayerCameraPropertyChange()
            end
        )
    )
    a1._connections:trackConnection(
        "CAMERA_MAX_DISTANCE_CHANGED",
        LocalPlayer_upv_1:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(
            function()
                --[[
                  line: 156
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:OnPlayerCameraPropertyChange()
            end
        )
    )
    a1._connections:trackConnection(
        "SELECTION_MODE_CHANGED",
        GuiService_upv_1:GetPropertyChangedSignal("SelectedObject"):Connect(
            function()
                --[[
                  line: 159
                  upvalues:
                    CameraGamepadZoomAction_upv_1 (copy, index: 1)
                    GuiService_upv_1 (copy, index: 2)
                ]]
                CameraGamepadZoomAction_upv_1.Enabled = not GuiService_upv_1.SelectedObject
            end
        )
    )
    a1:OnPlayerCameraPropertyChange()
end
function tbl_upv_1.OnCharacterAdded(a1, a2)
    --[[
      name: OnCharacterAdded
      line: 165
    ]]
    a1.resetCameraAngle = a1.resetCameraAngle or a1:GetEnabled()
    a1.humanoidRootPart = nil
end
function tbl_upv_1.GetHumanoidRootPart(a1)
    --[[
      name: GetHumanoidRootPart
      line: 172
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    if not (a1.humanoidRootPart) and LocalPlayer_upv_1.Character then
        local v2 = LocalPlayer_upv_1.Character:FindFirstChildOfClass("Humanoid")
        if v2 then
            a1.humanoidRootPart = v2.RootPart
        end
    end
    return a1.humanoidRootPart
end
function tbl_upv_1.GetSubjectCFrame(a1)
    --[[
      name: GetSubjectCFrame
      line: 184
    ]]
    local v3 = a1.lastSubjectCFrame
    local CurrentCamera_1 = workspace.CurrentCamera
    local v4 = CurrentCamera_1 and (CurrentCamera_1.CameraSubject)
    if v4 then
        if v4:IsA("Humanoid") then
            CurrentCamera_1 = v4:GetState() == Enum.HumanoidStateType.Dead
            local CameraOffset_1 = CurrentCamera_1.CameraOffset
            if a1:GetIsMouseLocked() then
                local _ = Vector3.new()
            end
            local RootPart_1 = CurrentCamera_1.RootPart
            if CurrentCamera_1 and CurrentCamera_1.Parent then
                local v5 = CurrentCamera_1.Parent:IsA("Model")
                if v5 then
                    RootPart_1 = CurrentCamera_1.Parent:FindFirstChild("Head") or RootPart_1
                end
            end
            if RootPart_1 then
                local v6 = RootPart_1:IsA("BasePart")
                if v6 then
                    if CurrentCamera_1.RigType ~= Enum.HumanoidRigType.R15 then
                        v6 = Vector3.new(0, 1.5, 0)
                    else
                        local v7 = nil
                        if CurrentCamera_1.AutomaticScalingEnabled then
                            v6 = Vector3.new(0, 1.5, 0)
                            v7 = CurrentCamera_1.RootPart
                            if RootPart_1 == v7 then
                                v6 = v6 + Vector3.new(0, (v7.Size.Y - 2) / 2, 0)
                            end
                        else
                            v6 = Vector3.new(0, 2, 0)
                        end
                    end
                    v3 = RootPart_1.CFrame * CFrame.new(((CurrentCamera_1 and Vector3.new(0, 0, 0)) or v6) + CameraOffset_1)
                end
            end
        elseif v4:IsA("BasePart") then
            v3 = v4.CFrame
        else
            local v8 = v4:IsA("Model")
            if v8 then
                if v4.PrimaryPart then
                    v3 = v4:GetPrimaryPartCFrame()
                else
                    v3 = CFrame.new()
                end
            end
        end
        if v3 then
            a1.lastSubjectCFrame = v3
        end
    end
    return v3
end
function tbl_upv_1.GetSubjectVelocity(a1)
    --[[
      name: GetSubjectVelocity
      line: 258
    ]]
    local CurrentCamera_2 = workspace.CurrentCamera
    local v9 = CurrentCamera_2 and (CurrentCamera_2.CameraSubject)
    if v9 then
        if v9:IsA("BasePart") then
            return v9.Velocity
        else
            local v10 = nil
            if v9:IsA("Humanoid") then
                v10 = v9.RootPart
                if v10 then
                    return v10.Velocity
                end
            elseif v9:IsA("Model") then
                local PrimaryPart_1 = v9.PrimaryPart
                if PrimaryPart_1 then
                    return PrimaryPart_1.Velocity
                end
            end
            return Vector3.new(0, 0, 0)
        end
    else
        return Vector3.new(0, 0, 0)
    end
end
function tbl_upv_1.GetSubjectRotVelocity(a1)
    --[[
      name: GetSubjectRotVelocity
      line: 287
    ]]
    local CurrentCamera_3 = workspace.CurrentCamera
    local v11 = CurrentCamera_3 and (CurrentCamera_3.CameraSubject)
    if v11 then
        if v11:IsA("BasePart") then
            return v11.RotVelocity
        else
            local v12 = nil
            if v11:IsA("Humanoid") then
                v12 = v11.RootPart
                if v12 then
                    return v12.RotVelocity
                end
            elseif v11:IsA("Model") then
                local PrimaryPart_2 = v11.PrimaryPart
                if PrimaryPart_2 then
                    return PrimaryPart_2.RotVelocity
                end
            end
            return Vector3.new(0, 0, 0)
        end
    else
        return Vector3.new(0, 0, 0)
    end
end
function tbl_upv_1.StepZoom(a1, a2)
    --[[
      name: StepZoom
      line: 316
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        ZoomController_upv_1 (copy, index: 2)
    ]]
    local currentSubjectDistance_1 = a1.currentSubjectDistance
    local v13 = CameraInput_upv_1.getZoomDelta(a2)
    if math.abs(v13) > 0 then
        local v14
        if v13 > 0 then
            v14 = math.max(currentSubjectDistance_1 + (v13 * ((currentSubjectDistance_1 * 0.5) + 1)), a1.FIRST_PERSON_DISTANCE_THRESHOLD)
        else
            v14 = math.max((currentSubjectDistance_1 + v13) / (1 - (v13 * 0.5)), 0.5)
        end
        if v14 < a1.FIRST_PERSON_DISTANCE_THRESHOLD then
            v14 = 0.5
        end
        a1:SetCameraToSubjectDistance(v14)
    end
    return ZoomController_upv_1.GetZoomRadius()
end
function tbl_upv_1.GetSubjectPosition(a1)
    --[[
      name: GetSubjectPosition
      line: 341
    ]]
    local v15 = a1.lastSubjectPosition
    local CurrentCamera_4 = game.Workspace.CurrentCamera
    local v16 = CurrentCamera_4 and (CurrentCamera_4.CameraSubject)
    if v16 then
        if v16:IsA("Humanoid") then
            CurrentCamera_4 = v16:GetState() == Enum.HumanoidStateType.Dead
            local CameraOffset_2 = CurrentCamera_4.CameraOffset
            if a1:GetIsMouseLocked() then
                local _ = Vector3.new()
            end
            local RootPart_2 = CurrentCamera_4.RootPart
            if CurrentCamera_4 and CurrentCamera_4.Parent then
                local v17 = CurrentCamera_4.Parent:IsA("Model")
                if v17 then
                    RootPart_2 = CurrentCamera_4.Parent:FindFirstChild("Head") or RootPart_2
                end
            end
            if RootPart_2 then
                local v18 = RootPart_2:IsA("BasePart")
                if v18 then
                    if CurrentCamera_4.RigType ~= Enum.HumanoidRigType.R15 then
                        v18 = Vector3.new(0, 1.5, 0)
                    elseif CurrentCamera_4.AutomaticScalingEnabled then
                        v18 = Vector3.new(0, 1.5, 0)
                        if RootPart_2 == CurrentCamera_4.RootPart then
                            v18 = v18 + Vector3.new(0, CurrentCamera_4.RootPart.Size.Y / 2 - 1, 0)
                        end
                    else
                        v18 = Vector3.new(0, 2, 0)
                    end
                    v15 = RootPart_2.CFrame.Position + RootPart_2.CFrame:vectorToWorldSpace(((CurrentCamera_4 and Vector3.new(0, 0, 0)) or v18) + CameraOffset_2)
                end
            end
        elseif v16:IsA("VehicleSeat") then
            v15 = v16.CFrame.Position + v16.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
        elseif v16:IsA("SkateboardPlatform") then
            v15 = v16.CFrame.Position + Vector3.new(0, 5, 0)
        elseif v16:IsA("BasePart") then
            v15 = v16.CFrame.Position
        else
            local v19 = v16:IsA("Model")
            if v19 then
                if v16.PrimaryPart then
                    v15 = v16:GetPrimaryPartCFrame().Position
                else
                    v15 = v16:GetModelCFrame().Position
                end
            end
        end
        a1.lastSubject = CurrentCamera_4
        a1.lastSubjectPosition = v15
        return v15
    end
    return nil
end
function tbl_upv_1.OnCurrentCameraChanged(a1)
    --[[
      name: OnCurrentCameraChanged
      line: 419
    ]]
    if a1.cameraSubjectChangedConn then
        a1.cameraSubjectChangedConn:Disconnect()
        a1.cameraSubjectChangedConn = nil
    end
    local CurrentCamera_5 = game.Workspace.CurrentCamera
    if not CurrentCamera_5 then
        return
    end
    a1.cameraSubjectChangedConn = CurrentCamera_5:GetPropertyChangedSignal("CameraSubject"):Connect(
        function()
            --[[
              line: 428
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:OnNewCameraSubject()
        end
    )
    a1:OnNewCameraSubject()
end
function tbl_upv_1.OnPlayerCameraPropertyChange(a1)
    --[[
      name: OnPlayerCameraPropertyChange
      line: 435
    ]]
    a1:SetCameraToSubjectDistance(a1.currentSubjectDistance)
end
function tbl_upv_1.InputTranslationToCameraAngleChange(a1, a2, a3)
    --[[
      name: InputTranslationToCameraAngleChange
      line: 440
    ]]
    return a2 * a3
end
function tbl_upv_1.GamepadZoomPress(a1)
    --[[
      name: GamepadZoomPress
      line: 446
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v20 = a1:GetCameraToSubjectDistance()
    local v21 = LocalPlayer_upv_1.CameraMaxZoomDistance
    local v22 = nil
    for n_1 = #a1.gamepadZoomLevels, 1, -1 do
        v22 = a1.gamepadZoomLevels[n_1]
        if v21 < v22 then
            continue
        end
        if v22 < LocalPlayer_upv_1.CameraMinZoomDistance then
            local CameraMinZoomDistance_1 = LocalPlayer_upv_1.CameraMinZoomDistance
            if v21 == CameraMinZoomDistance_1 then
                break
            end
            v22 = CameraMinZoomDistance_1
        end
        if not (v22 + ((v21 - v22) / 2) < v20) then
            v21 = v22
            continue
        end
        a1:SetCameraToSubjectDistance(v22)
        return
    end
    a1:SetCameraToSubjectDistance(a1.gamepadZoomLevels[#a1.gamepadZoomLevels])
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 483
    ]]
    if a1.enabled == a2 then
        return
    end
    a1.enabled = a2
    a1:OnEnabledChanged()
end
function tbl_upv_1.OnEnabledChanged(a1)
    --[[
      name: OnEnabledChanged
      line: 491
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        CameraGamepadZoomAction_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    if a1.enabled then
        a1:_setUpConfigurations()
        CameraInput_upv_1.setInputEnabled(true)
        CameraGamepadZoomAction_upv_1.Enabled = true
        if LocalPlayer_upv_1.CameraMode == Enum.CameraMode.LockFirstPerson then
            a1.currentSubjectDistance = 0.5
            if not (a1.inFirstPerson) then
                a1:EnterFirstPerson()
            end
        end
        if a1.cameraChangedConn then
            a1.cameraChangedConn:Disconnect()
            a1.cameraChangedConn = nil
        end
        a1.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
            function()
                --[[
                  line: 507
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1:OnCurrentCameraChanged()
            end
        )
        a1:OnCurrentCameraChanged()
    else
        a1._connections:disconnectAll()
        CameraInput_upv_1.setInputEnabled(false)
        CameraGamepadZoomAction_upv_1.Enabled = false
        a1:Cleanup()
    end
end
function tbl_upv_1.GetEnabled(a1)
    --[[
      name: GetEnabled
      line: 522
    ]]
    return a1.enabled
end
function tbl_upv_1.Cleanup(a1)
    --[[
      name: Cleanup
      line: 526
      upvalues:
        CameraUtils_upv_1 (copy, index: 1)
    ]]
    if a1.subjectStateChangedConn then
        a1.subjectStateChangedConn:Disconnect()
        a1.subjectStateChangedConn = nil
    end
    if a1.cameraChangedConn then
        a1.cameraChangedConn:Disconnect()
        a1.cameraChangedConn = nil
    end
    a1.lastCameraTransform = nil
    a1.lastSubjectCFrame = nil
    CameraUtils_upv_1.restoreMouseBehavior()
end
function tbl_upv_1.UpdateMouseBehavior(a1)
    --[[
      name: UpdateMouseBehavior
      line: 543
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        CameraUI_upv_1 (copy, index: 2)
        CameraInput_upv_1 (copy, index: 3)
        CameraToggleStateController_upv_1 (copy, index: 4)
        CameraUtils_upv_1 (copy, index: 5)
    ]]
    local v23 = UserGameSettings_upv_1.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    if not a1.isCameraToggle or v23 ~= false then
        CameraUI_upv_1.setCameraModeToastEnabled(false)
        CameraInput_upv_1.disableCameraToggleInput()
        if not (a1.inFirstPerson) and not (a1.inMouseLockedMode) then
            CameraUtils_upv_1.restoreRotationType()
            if CameraInput_upv_1.getPanActivated() then
                CameraUtils_upv_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
            else
                CameraUtils_upv_1.restoreMouseBehavior()
            end
            return
        end
        CameraUtils_upv_1.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        CameraUtils_upv_1.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
    end
    CameraUI_upv_1.setCameraModeToastEnabled(true)
    CameraInput_upv_1.enableCameraToggleInput()
    CameraToggleStateController_upv_1(a1.inFirstPerson)
end
function tbl_upv_1.UpdateForDistancePropertyChange(a1)
    --[[
      name: UpdateForDistancePropertyChange
      line: 571
    ]]
    a1:SetCameraToSubjectDistance(a1.currentSubjectDistance)
end
function tbl_upv_1.SetCameraToSubjectDistance(a1, a2)
    --[[
      name: SetCameraToSubjectDistance
      line: 577
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        ZoomController_upv_1 (copy, index: 2)
    ]]
    local currentSubjectDistance_2 = a1.currentSubjectDistance
    local v24 = nil
    if LocalPlayer_upv_1.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        v24 = math.clamp(a2, LocalPlayer_upv_1.CameraMinZoomDistance, LocalPlayer_upv_1.CameraMaxZoomDistance)
        if v24 < 1 then
            a1.currentSubjectDistance = 0.5
            if not (a1.inFirstPerson) then
                a1:EnterFirstPerson()
            end
        else
            a1.currentSubjectDistance = v24
            if a1.inFirstPerson then
                a1:LeaveFirstPerson()
            end
        end
    else
        a1.currentSubjectDistance = 0.5
        if not (a1.inFirstPerson) then
            a1:EnterFirstPerson()
        end
    end
    ZoomController_upv_1.SetZoomParameters(a1.currentSubjectDistance, (math.sign(a2 - currentSubjectDistance_2)))
    return a1.currentSubjectDistance
end
function tbl_upv_1.SetCameraType(a1, a2)
    --[[
      name: SetCameraType
      line: 611
    ]]
    a1.cameraType = a2
end
function tbl_upv_1.GetCameraType(a1)
    --[[
      name: GetCameraType
      line: 616
    ]]
    return a1.cameraType
end
function tbl_upv_1.SetCameraMovementMode(a1, a2)
    --[[
      name: SetCameraMovementMode
      line: 621
    ]]
    a1.cameraMovementMode = a2
end
function tbl_upv_1.GetCameraMovementMode(a1)
    --[[
      name: GetCameraMovementMode
      line: 625
    ]]
    return a1.cameraMovementMode
end
function tbl_upv_1.SetIsMouseLocked(a1, a2)
    --[[
      name: SetIsMouseLocked
      line: 629
    ]]
    a1.inMouseLockedMode = a2
end
function tbl_upv_1.GetIsMouseLocked(a1)
    --[[
      name: GetIsMouseLocked
      line: 633
    ]]
    return a1.inMouseLockedMode
end
function tbl_upv_1.SetMouseLockOffset(a1, a2)
    --[[
      name: SetMouseLockOffset
      line: 637
    ]]
    a1.mouseLockOffset = a2
end
function tbl_upv_1.GetMouseLockOffset(a1)
    --[[
      name: GetMouseLockOffset
      line: 641
    ]]
    return a1.mouseLockOffset
end
function tbl_upv_1.InFirstPerson(a1)
    --[[
      name: InFirstPerson
      line: 645
    ]]
    return a1.inFirstPerson
end
function tbl_upv_1.EnterFirstPerson(a1)
    --[[
      name: EnterFirstPerson
      line: 649
    ]]
    a1.inFirstPerson = true
    a1:UpdateMouseBehavior()
end
function tbl_upv_1.LeaveFirstPerson(a1)
    --[[
      name: LeaveFirstPerson
      line: 654
    ]]
    a1.inFirstPerson = false
    a1:UpdateMouseBehavior()
end
function tbl_upv_1.GetCameraToSubjectDistance(a1)
    --[[
      name: GetCameraToSubjectDistance
      line: 660
    ]]
    return a1.currentSubjectDistance
end
function tbl_upv_1.GetMeasuredDistanceToFocus(a1)
    --[[
      name: GetMeasuredDistanceToFocus
      line: 667
    ]]
    local CurrentCamera_6 = game.Workspace.CurrentCamera
    if CurrentCamera_6 then
        return (CurrentCamera_6.CoordinateFrame.Position - CurrentCamera_6.Focus.Position).magnitude
    end
    return nil
end
function tbl_upv_1.GetCameraLookVector(a1)
    --[[
      name: GetCameraLookVector
      line: 675
    ]]
    return ((game.Workspace.CurrentCamera) and (game.Workspace.CurrentCamera.CFrame.LookVector)) or Vector3.new(0, 0, 1)
end
function tbl_upv_1.CalculateNewLookCFrameFromArg(a1, a2, a3)
    --[[
      name: CalculateNewLookCFrameFromArg
      line: 679
    ]]
    local v25 = a2 or (a1:GetCameraLookVector())
    local v26 = math.asin(v25.Y)
    v26 = Vector2.new(a3.X, math.clamp(a3.Y, v26 + -1.3962634015954636, v26 + 1.3962634015954636))
    local v27 = CFrame.new(Vector3.new(0, 0, 0), v25)
    return CFrame.Angles(0, -v26.X, 0) * v27 * CFrame.Angles(-v26.Y, 0, 0)
end
function tbl_upv_1.CalculateNewLookVectorFromArg(a1, a2, a3)
    --[[
      name: CalculateNewLookVectorFromArg
      line: 689
    ]]
    return a1:CalculateNewLookCFrameFromArg(a2, a3).LookVector
end
function tbl_upv_1.CalculateNewLookVectorVRFromArg(a1, a2)
    --[[
      name: CalculateNewLookVectorVRFromArg
      line: 694
    ]]
    local v28 = a1:GetSubjectPosition()
    local v29 = Vector2.new(a2.X, 0)
    local v30 = CFrame.new(Vector3.new(0, 0, 0), ((v28 - game.Workspace.CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).unit)
    return ((CFrame.Angles(0, -v29.X, 0) * v30 * CFrame.Angles(-v29.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end
function tbl_upv_1.GetHumanoid(a1)
    --[[
      name: GetHumanoid
      line: 704
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local v31
    if LocalPlayer_upv_1 then
        v31 = LocalPlayer_upv_1.Character
    else
        v31 = LocalPlayer_upv_1
    end
    if not v31 then
        return nil
    end
    local v32 = a1.humanoidCache[LocalPlayer_upv_1]
    if v32 and v32.Parent == v31 then
        return v32
    end
    a1.humanoidCache[LocalPlayer_upv_1] = nil
    local v33 = v31:FindFirstChildOfClass("Humanoid")
    if v33 then
        a1.humanoidCache[LocalPlayer_upv_1] = v33
    end
    return v33
end
function tbl_upv_1.OnNewCameraSubject(a1)
    --[[
      name: OnNewCameraSubject
      line: 722
    ]]
    if not a1.subjectStateChangedConn then
        return
    end
    a1.subjectStateChangedConn:Disconnect()
    a1.subjectStateChangedConn = nil
end
function tbl_upv_1.IsInFirstPerson(a1)
    --[[
      name: IsInFirstPerson
      line: 729
    ]]
    return a1.inFirstPerson
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 733
    ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end
function tbl_upv_1.GetCameraHeight(a1)
    --[[
      name: GetCameraHeight
      line: 737
      upvalues:
        VRService_upv_1 (copy, index: 1)
    ]]
    if VRService_upv_1.VREnabled and not (a1.inFirstPerson) then
        return 0.25881904510252074 * a1.currentSubjectDistance
    end
    return 0
end
return tbl_upv_1