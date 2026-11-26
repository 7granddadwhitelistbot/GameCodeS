local players = game:GetService("Players")
local vrService = game:GetService("VRService")
local guiService = game:GetService("GuiService")
local v4 = UserSettings():GetService("UserGameSettings")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v6 = CommonUtils.get("ConnectionUtil")
CommonUtils.get("FlagUtil")
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local inputContexts = script.Parent.Parent:WaitForChild("InputContexts")
local cameraContext = inputContexts:WaitForChild("CameraContext")
local cameraGamepadZoomAction = cameraContext:WaitForChild("CameraGamepadZoomAction")
local localPlayer = players.LocalPlayer
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 77
      upvalues:
        Class (copy, index: 1)
        v6 (copy, index: 2)
        localPlayer (copy, index: 3)
        cameraGamepadZoomAction (copy, index: 4)
        v4 (copy, index: 5)
    ]]
    local v17 = setmetatable({}, Class)
    v17._connections = v6.new()
    v17.gamepadZoomLevels = {0, 10, 20}
    v17.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    v17.cameraType = nil
    v17.cameraMovementMode = nil
    v17.lastCameraTransform = nil
    v17.lastUserPanCamera = tick()
    v17.humanoidRootPart = nil
    v17.humanoidCache = {}
    v17.lastSubject = nil
    v17.lastSubjectPosition = Vector3.new(0, 5, 0)
    v17.lastSubjectCFrame = CFrame.new(v17.lastSubjectPosition)
    v17.currentSubjectDistance = math.clamp(12.5, localPlayer.CameraMinZoomDistance, localPlayer.CameraMaxZoomDistance)
    v17.inFirstPerson = false
    v17.inMouseLockedMode = false
    v17.resetCameraAngle = true
    v17.enabled = false
    v17.cameraChangedConn = nil
    v17.shouldUseVRRotation = false
    v17.VRRotationIntensityAvailable = false
    v17.lastVRRotationIntensityCheckTime = 0
    v17.lastVRRotationTime = 0
    v17.vrRotateKeyCooldown = {}
    v17.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    v17.humanoidJumpOrigin = nil
    v17.trackingHumanoid = nil
    v17.cameraFrozen = false
    v17.subjectStateChangedConn = nil
    v17.gamepadZoomPressConnection = cameraGamepadZoomAction.Pressed:Connect(
        function()
            --[[
              line: 126
              upvalues:
                v17 (copy, index: 1)
            ]]
            v17:GamepadZoomPress()
        end
    )
    v17.mouseLockOffset = Vector3.new(0, 0, 0)
    v4:SetCameraYInvertVisible()
    v4:SetGamepadCameraSensitivityVisible()

    return v17
end

function Class.GetModuleName(a18)
    --[[
      name: GetModuleName
      line: 139
    ]]
    return "BaseCamera"
end

local function onSelectedObjectChanged()
    --[[
      name: onSelectedObjectChanged
      line: 143
      upvalues:
        cameraGamepadZoomAction (copy, index: 1)
        guiService (copy, index: 2)
    ]]
    cameraGamepadZoomAction.Enabled = not guiService.SelectedObject
end

function Class._setUpConfigurations(self)
    --[[
      name: _setUpConfigurations
      line: 147
      upvalues:
        localPlayer (copy, index: 1)
        guiService (copy, index: 2)
        cameraGamepadZoomAction (copy, index: 3)
    ]]
    self._connections:trackConnection(
        "CHARACTER_ADDED",
        localPlayer.CharacterAdded:Connect(
            function(character: Model)
                --[[
                  line: 150
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnCharacterAdded(character)
            end
        )
    )
    self.humanoidRootPart = nil
    self._connections:trackConnection(
        "CAMERA_MODE_CHANGED",
        localPlayer:GetPropertyChangedSignal("CameraMode"):Connect(
            function()
                --[[
                  line: 158
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnPlayerCameraPropertyChange()
            end
        )
    )
    self._connections:trackConnection(
        "CAMERA_MIN_DISTANCE_CHANGED",
        localPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(
            function()
                --[[
                  line: 164
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnPlayerCameraPropertyChange()
            end
        )
    )
    self._connections:trackConnection(
        "CAMERA_MAX_DISTANCE_CHANGED",
        localPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(
            function()
                --[[
                  line: 170
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnPlayerCameraPropertyChange()
            end
        )
    )
    self._connections:trackConnection(
        "SELECTION_MODE_CHANGED",
        guiService:GetPropertyChangedSignal("SelectedObject"):Connect(
            function()
                --[[
                  line: 176
                  upvalues:
                    cameraGamepadZoomAction (copy, index: 1)
                    guiService (copy, index: 2)
                ]]
                cameraGamepadZoomAction.Enabled = not guiService.SelectedObject
            end
        )
    )
    self:OnPlayerCameraPropertyChange()
end

function Class.OnCharacterAdded(self, a23)
    --[[
      name: OnCharacterAdded
      line: 183
    ]]
    local v24 = self.resetCameraAngle or self:GetEnabled()
    self.resetCameraAngle = v24
    self.humanoidRootPart = nil
end

function Class.GetHumanoidRootPart(self)
    --[[
      name: GetHumanoidRootPart
      line: 190
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    if not self.humanoidRootPart and localPlayer.Character then
        if const humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid") then
            self.humanoidRootPart = humanoid.RootPart
        end
    end

    return self.humanoidRootPart
end

function Class.GetSubjectCFrame(self)
    --[[
      name: GetSubjectCFrame
      line: 202
    ]]
    local v28 = self.lastSubjectCFrame
    local v29 = workspace.CurrentCamera
    v29 = v29
    v29 = v29 and v29.CameraSubject

    if not v29 then
        return v28
    end

    if v29:IsA("Humanoid") then
        local state = v29:GetState()
        local isDead = state == Enum.HumanoidStateType.Dead
        local v32 = v29.CameraOffset

        if self:GetIsMouseLocked() then
            v32 = Vector3.new()
        end

        local v33 = v29.RootPart

        if isDead and v29.Parent and v29.Parent:IsA("Model") then
            v33 = v29.Parent:FindFirstChild("Head") or v33
        end

        if v33 and v33:IsA("BasePart") then
            local v34

            if v29.RigType ~= Enum.HumanoidRigType.R15 then
                v34 = Vector3.new(0, 1.5, 0)
            elseif v29.AutomaticScalingEnabled then
                v34 = Vector3.new(0, 1.5, 0)
                local rootPart = v29.RootPart

                if v33 == rootPart then
                    v34 += Vector3.new(0, (rootPart.Size.Y - 2) / 2, 0)
                end
            else
                v34 = Vector3.new(0, 2, 0)
            end

            local v36 = isDead and Vector3.new(0, 0, 0) or v34
            v28 = v33.CFrame * CFrame.new(v36 + v32)
        end
    elseif v29:IsA("BasePart") then
        v28 = v29.CFrame
    elseif v29:IsA("Model") then
        v28 = if v29.PrimaryPart then v29:GetPrimaryPartCFrame() else CFrame.new()
    end

    if v28 then
        self.lastSubjectCFrame = v28
    end

    return v28
end

function Class.GetSubjectVelocity(a37)
    --[[
      name: GetSubjectVelocity
      line: 273
    ]]
    local v38 = workspace.CurrentCamera
    v38 = v38
    v38 = v38 and v38.CameraSubject

    if not v38 then
        return Vector3.new(0, 0, 0)
    end
    if v38:IsA("BasePart") then
        return v38.Velocity
    end

    if v38:IsA("Humanoid") then
        if const rootPart = v38.RootPart then
            return rootPart.Velocity
        end
    elseif v38:IsA("Model") then
        if const primaryPart = v38.PrimaryPart then
            return primaryPart.Velocity
        end
    end

    return Vector3.new(0, 0, 0)
end

function Class.GetSubjectRotVelocity(a41)
    --[[
      name: GetSubjectRotVelocity
      line: 300
    ]]
    local v42 = workspace.CurrentCamera
    v42 = v42
    v42 = v42 and v42.CameraSubject

    if not v42 then
        return Vector3.new(0, 0, 0)
    end
    if v42:IsA("BasePart") then
        return v42.RotVelocity
    end

    if v42:IsA("Humanoid") then
        if const rootPart = v42.RootPart then
            return rootPart.RotVelocity
        end
    elseif v42:IsA("Model") then
        if const primaryPart = v42.PrimaryPart then
            return primaryPart.RotVelocity
        end
    end

    return Vector3.new(0, 0, 0)
end

function Class.StepZoom(self, a46)
    --[[
      name: StepZoom
      line: 327
      upvalues:
        CameraInput (copy, index: 1)
        ZoomController (copy, index: 2)
    ]]
    local currentSubjectDistance = self.currentSubjectDistance
    local zoomDelta = CameraInput.getZoomDelta(a46)

    if 0 < math.abs(zoomDelta) then
        local cameraToSubjectDistance = if 0 < zoomDelta then math.max(currentSubjectDistance + (zoomDelta * ((currentSubjectDistance * 0.5) + 1)), self.FIRST_PERSON_DISTANCE_THRESHOLD) else math.max((currentSubjectDistance + zoomDelta) / (1 - (zoomDelta * 0.5)), 0.5)

        if cameraToSubjectDistance < self.FIRST_PERSON_DISTANCE_THRESHOLD then
            cameraToSubjectDistance = 0.5
        end

        self:SetCameraToSubjectDistance(cameraToSubjectDistance)
    end

    return ZoomController.GetZoomRadius()
end

function Class.GetSubjectPosition(self)
    --[[
      name: GetSubjectPosition
      line: 352
    ]]
    local v51 = self.lastSubjectPosition
    local v52 = game.Workspace.CurrentCamera
    v52 = v52
    v52 = v52 and v52.CameraSubject

    if not v52 then
        return nil
    end

    if v52:IsA("Humanoid") then
        local state = v52:GetState()
        local isDead = state == Enum.HumanoidStateType.Dead
        local v55 = v52.CameraOffset

        if self:GetIsMouseLocked() then
            v55 = Vector3.new()
        end

        local v56 = v52.RootPart

        if isDead and v52.Parent and v52.Parent:IsA("Model") then
            v56 = v52.Parent:FindFirstChild("Head") or v56
        end

        if v56 and v56:IsA("BasePart") then
            local v57

            if v52.RigType ~= Enum.HumanoidRigType.R15 then
                v57 = Vector3.new(0, 1.5, 0)
            elseif v52.AutomaticScalingEnabled then
                v57 = Vector3.new(0, 1.5, 0)

                if v56 == v52.RootPart then
                    v57 += Vector3.new(0, (v52.RootPart.Size.Y / 2) - 1, 0)
                end
            else
                v57 = Vector3.new(0, 2, 0)
            end

            local v58 = isDead and Vector3.new(0, 0, 0) or v57
            v51 = v56.CFrame.Position + v56.CFrame:vectorToWorldSpace(v58 + v55)
        end
    elseif v52:IsA("VehicleSeat") then
        v51 = v52.CFrame.Position + v52.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
    elseif v52:IsA("SkateboardPlatform") then
        v51 = v52.CFrame.Position + Vector3.new(0, 5, 0)
    elseif v52:IsA("BasePart") then
        v51 = v52.CFrame.Position
    elseif v52:IsA("Model") then
        v51 = if v52.PrimaryPart then v52:GetPrimaryPartCFrame().Position else v52:GetModelCFrame().Position
    end

    self.lastSubject = v52
    self.lastSubjectPosition = v51

    return v51
end

function Class.OnCurrentCameraChanged(self)
    --[[
      name: OnCurrentCameraChanged
      line: 430
    ]]
    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()
        self.cameraSubjectChangedConn = nil
    end

    if const camera = game.Workspace.CurrentCamera then
        self.cameraSubjectChangedConn = camera:GetPropertyChangedSignal("CameraSubject"):Connect(
            function()
                --[[
                  line: 439
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnNewCameraSubject()
            end
        )
        self:OnNewCameraSubject()
    end
end

function Class.OnPlayerCameraPropertyChange(self)
    --[[
      name: OnPlayerCameraPropertyChange
      line: 446
    ]]
    self:SetCameraToSubjectDistance(self.currentSubjectDistance)
end

function Class.InputTranslationToCameraAngleChange(a62, a63, a64)
    --[[
      name: InputTranslationToCameraAngleChange
      line: 451
    ]]
    return a63 * a64
end

function Class.GamepadZoomPress(self)
    --[[
      name: GamepadZoomPress
      line: 457
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local cameraToSubjectDistance = self:GetCameraToSubjectDistance()
    local v67 = localPlayer.CameraMaxZoomDistance
    local v68

    for gamepadZoomLevelKey = #self.gamepadZoomLevels, 1, -1 do
        local gamepadZoomLevel = self.gamepadZoomLevels[gamepadZoomLevelKey]

        if not (v67 < gamepadZoomLevel) then
            if gamepadZoomLevel < localPlayer.CameraMinZoomDistance then
                local cameraMinZoomDistance = localPlayer.CameraMinZoomDistance

                if v67 == cameraMinZoomDistance then
                    self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
                    return
                end

                v68 = cameraMinZoomDistance
            else
                v68 = gamepadZoomLevel
            end

            if v68 + ((v67 - v68) / 2) < cameraToSubjectDistance then
                self:SetCameraToSubjectDistance(v68)
                return
            end

            v67 = v68
        end
    end

    self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
end

function Class.Enable(self, enabled)
    --[[
      name: Enable
      line: 494
    ]]
    if self.enabled ~= enabled then
        self.enabled = enabled
        self:OnEnabledChanged()
    end
end

function Class.OnEnabledChanged(self)
    --[[
      name: OnEnabledChanged
      line: 502
      upvalues:
        CameraInput (copy, index: 1)
        cameraGamepadZoomAction (copy, index: 2)
        localPlayer (copy, index: 3)
    ]]
    if not self.enabled then
        self._connections:disconnectAll()
        CameraInput.setInputEnabled(false)
        cameraGamepadZoomAction.Enabled = false
        self:Cleanup()

        return
    end

    self:_setUpConfigurations()
    CameraInput.setInputEnabled(true)
    cameraGamepadZoomAction.Enabled = true

    if localPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        self.currentSubjectDistance = 0.5

        if not self.inFirstPerson then
            self:EnterFirstPerson()
        end
    end

    if self.cameraChangedConn then
        self.cameraChangedConn:Disconnect()
        self.cameraChangedConn = nil
    end

    self.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
        function()
            --[[
              line: 521
              upvalues:
                self (copy, index: 1)
            ]]
            self:OnCurrentCameraChanged()
        end
    )
    self:OnCurrentCameraChanged()
end

function Class.GetEnabled(self)
    --[[
      name: GetEnabled
      line: 536
    ]]
    return self.enabled
end

function Class.Cleanup(self)
    --[[
      name: Cleanup
      line: 540
      upvalues:
        CameraUtils (copy, index: 1)
    ]]
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()
        self.subjectStateChangedConn = nil
    end

    if self.cameraChangedConn then
        self.cameraChangedConn:Disconnect()
        self.cameraChangedConn = nil
    end

    self.lastCameraTransform = nil
    self.lastSubjectCFrame = nil
    CameraUtils.restoreMouseBehavior()
end

function Class.UpdateMouseBehavior(self)
    --[[
      name: UpdateMouseBehavior
      line: 557
      upvalues:
        v4 (copy, index: 1)
        CameraUI (copy, index: 2)
        CameraInput (copy, index: 3)
        CameraToggleStateController (copy, index: 4)
        CameraUtils (copy, index: 5)
    ]]
    local isClickToMove = v4.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove

    if self.isCameraToggle then
        if isClickToMove == false then
            CameraUI.setCameraModeToastEnabled(true)
            CameraInput.enableCameraToggleInput()
            CameraToggleStateController(self.inFirstPerson)

            return
        end
    end

    CameraUI.setCameraModeToastEnabled(false)
    CameraInput.disableCameraToggleInput()

    if not self.inFirstPerson then
        if not self.inMouseLockedMode then
            CameraUtils.restoreRotationType()

            if CameraInput.getPanActivated() then
                CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
                return
            end

            CameraUtils.restoreMouseBehavior()

            return
        end
    end

    CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
    CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
end

function Class.UpdateForDistancePropertyChange(self)
    --[[
      name: UpdateForDistancePropertyChange
      line: 585
    ]]
    self:SetCameraToSubjectDistance(self.currentSubjectDistance)
end

function Class.SetCameraToSubjectDistance(self, cameraToSubjectDistance: number)
    --[[
      name: SetCameraToSubjectDistance
      line: 591
      upvalues:
        localPlayer (copy, index: 1)
        ZoomController (copy, index: 2)
    ]]
    local currentSubjectDistance = self.currentSubjectDistance

    if localPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        local currentSubjectDistance2 = math.clamp(cameraToSubjectDistance, localPlayer.CameraMinZoomDistance, localPlayer.CameraMaxZoomDistance)

        if not (currentSubjectDistance2 < 1) then
            self.currentSubjectDistance = currentSubjectDistance2

            if self.inFirstPerson then
                self:LeaveFirstPerson()
            end
        else
            self.currentSubjectDistance = 0.5

            if not self.inFirstPerson then
                self:EnterFirstPerson()
            end
        end
    else
        self.currentSubjectDistance = 0.5

        if not self.inFirstPerson then
            self:EnterFirstPerson()
        end
    end

    ZoomController.SetZoomParameters(self.currentSubjectDistance, (math.sign(cameraToSubjectDistance - currentSubjectDistance)))

    return self.currentSubjectDistance
end

function Class.SetCameraType(self, cameraType)
    --[[
      name: SetCameraType
      line: 629
    ]]
    self.cameraType = cameraType
end

function Class.GetCameraType(self)
    --[[
      name: GetCameraType
      line: 634
    ]]
    return self.cameraType
end

function Class.SetCameraMovementMode(self, cameraMovementMode)
    --[[
      name: SetCameraMovementMode
      line: 639
    ]]
    self.cameraMovementMode = cameraMovementMode
end

function Class.GetCameraMovementMode(self)
    --[[
      name: GetCameraMovementMode
      line: 643
    ]]
    return self.cameraMovementMode
end

function Class.SetIsMouseLocked(self, isMouseLocked)
    --[[
      name: SetIsMouseLocked
      line: 647
    ]]
    self.inMouseLockedMode = isMouseLocked
end

function Class.GetIsMouseLocked(self)
    --[[
      name: GetIsMouseLocked
      line: 651
    ]]
    return self.inMouseLockedMode
end

function Class.SetMouseLockOffset(self, mouseLockOffset)
    --[[
      name: SetMouseLockOffset
      line: 655
    ]]
    self.mouseLockOffset = mouseLockOffset
end

function Class.GetMouseLockOffset(self)
    --[[
      name: GetMouseLockOffset
      line: 659
    ]]
    return self.mouseLockOffset
end

function Class.InFirstPerson(self)
    --[[
      name: InFirstPerson
      line: 663
    ]]
    return self.inFirstPerson
end

function Class.EnterFirstPerson(self)
    --[[
      name: EnterFirstPerson
      line: 667
    ]]
    self.inFirstPerson = true
    self:UpdateMouseBehavior()
end

function Class.LeaveFirstPerson(self)
    --[[
      name: LeaveFirstPerson
      line: 672
    ]]
    self.inFirstPerson = false
    self:UpdateMouseBehavior()
end

function Class.GetCameraToSubjectDistance(self)
    --[[
      name: GetCameraToSubjectDistance
      line: 678
    ]]
    return self.currentSubjectDistance
end

function Class.GetMeasuredDistanceToFocus(a100)
    --[[
      name: GetMeasuredDistanceToFocus
      line: 685
    ]]
    return if const camera = game.Workspace.CurrentCamera then (camera.CoordinateFrame.Position - camera.Focus.Position).magnitude else nil
end

function Class.GetCameraLookVector(a102)
    --[[
      name: GetCameraLookVector
      line: 693
    ]]
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector
        or Vector3.new(0, 0, 1)
end

function Class.CalculateNewLookCFrameFromArg(a103, a104, a105)
    --[[
      name: CalculateNewLookCFrameFromArg
      line: 697
    ]]
    local v106 = a104 or a103:GetCameraLookVector()
    local v107 = math.asin(v106.Y)
    local y = math.clamp(a105.Y, v107 + -1.3962634015954636, v107 + 1.3962634015954636)
    local vector2 = Vector2.new(a105.X, y)
    y = CFrame.new(Vector3.new(0, 0, 0), v106)

    return CFrame.Angles(0, -vector2.X, 0) * y * CFrame.Angles(-vector2.Y, 0, 0)
end

function Class.CalculateNewLookVectorFromArg(a110, a111, a112)
    --[[
      name: CalculateNewLookVectorFromArg
      line: 709
    ]]
    local v113 = a110:CalculateNewLookCFrameFromArg(a111, a112)
    return v113.LookVector
end

function Class.CalculateNewLookVectorVRFromArg(self, a115)
    --[[
      name: CalculateNewLookVectorVRFromArg
      line: 714
    ]]
    local unit = ((self:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).unit
    local vector2 = Vector2.new(a115.X, 0)
    local cframe = CFrame.new(Vector3.new(0, 0, 0), unit)

    return ((CFrame.Angles(0, -vector2.X, 0) * cframe * CFrame.Angles(-vector2.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end

function Class.GetHumanoid(self)
    --[[
      name: GetHumanoid
      line: 728
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer and localPlayer.Character
    if not character then
        return nil
    elseif const v121 = self.humanoidCache[localPlayer] then
        if v121.Parent == character then
            return v121
        end
    end

    self.humanoidCache[localPlayer] = nil
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        self.humanoidCache[localPlayer] = humanoid
    end

    return humanoid
end

function Class.OnNewCameraSubject(self)
    --[[
      name: OnNewCameraSubject
      line: 746
    ]]
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()
        self.subjectStateChangedConn = nil
    end
end

function Class.IsInFirstPerson(self)
    --[[
      name: IsInFirstPerson
      line: 753
    ]]
    return self.inFirstPerson
end

function Class.Update(a125, a126)
    --[[
      name: Update
      line: 757
    ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end

function Class.GetCameraHeight(self)
    --[[
      name: GetCameraHeight
      line: 761
      upvalues:
        vrService (copy, index: 1)
    ]]
    if vrService.VREnabled and not self.inFirstPerson then
        return 0.25881904510252074 * self.currentSubjectDistance
    end

    return 0
end

return Class