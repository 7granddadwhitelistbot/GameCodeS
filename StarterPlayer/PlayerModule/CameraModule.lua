local Class = {}
Class.__index = Class
local propertys = {"CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock"}
local v3 = {"ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode"}
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local vrService = game:GetService("VRService")
local v8 = UserSettings():GetService("UserGameSettings")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local v10 = CommonUtils.get("ConnectionUtil")
local v11 = CommonUtils.get("FlagUtil")
local CameraUtils = require(script:WaitForChild("CameraUtils"))
require(script:WaitForChild("CameraInput"))
local ClassicCamera = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera = require(script:WaitForChild("VehicleCamera"))
local VRCamera = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"))
local Invisicam = require(script:WaitForChild("Invisicam"))
local Poppercam = require(script:WaitForChild("Poppercam"))
local TransparencyController = require(script:WaitForChild("TransparencyController"))
local MouseLockController = require(script:WaitForChild("MouseLockController"))
local v23 = {}
local v24 = {}

if not players.LocalPlayer then
    return {}
end

assert(players.LocalPlayer, "Strict typing check")
local playerScripts = players.LocalPlayer:WaitForChild("PlayerScripts")
playerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
playerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
playerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
playerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
playerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
playerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
playerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
local userFlag = v11.getUserFlag("UserPlayerConnectionMemoryLeak")
local userFlag2 = v11.getUserFlag("UserPSFixCameraControllerReset")
local userFlag3 = v11.getUserFlag("UserPlayerModuleEngineAPI")
local userFlag4 = v11.getUserFlag("UserVRFixCameraCloseArticulation")
local v30 = CommonUtils.get("VRFirstPersonState")

function Class.new()
    --[[
      name: new
      line: 156
      upvalues:
        TransparencyController (copy, index: 1)
        userFlag (copy, index: 2)
        v10 (copy, index: 3)
        Class (copy, index: 4)
        userFlag3 (copy, index: 5)
        players (copy, index: 6)
        MouseLockController (copy, index: 7)
        propertys (copy, index: 8)
        v3 (copy, index: 9)
        v8 (copy, index: 10)
        userInputService (copy, index: 11)
    ]]
    local v31 = {activeTransparencyController = TransparencyController.new(), connectionUtil = if userFlag then v10.new() else nil}
    local v32 = setmetatable(v31, Class)
    v32.activeCameraController = nil
    v32.activeOcclusionModule = nil
    v32.activeMouseLockController = nil
    v32.currentComputerCameraMovementMode = nil
    v32.cameraSubjectChangedConn = nil
    v32.cameraTypeChangedConn = nil

    if not userFlag3 then
        for _, player in pairs(players:GetPlayers()) do
            v32:OnPlayerAdded(player)
        end

        players.PlayerAdded:Connect(
            function(player: Player)
                --[[
                  line: 180
                  upvalues:
                    v32 (copy, index: 1)
                ]]
                v32:OnPlayerAdded(player)
            end
        )

        if userFlag then
            players.PlayerRemoving:Connect(
                function(player: Player)
                    --[[
                      line: 185
                      upvalues:
                        v32 (copy, index: 1)
                    ]]
                    v32:OnPlayerRemoving(player)
                end
            )
        end
    end

    v32.activeTransparencyController:Enable(true)
    v32.activeMouseLockController = MouseLockController.new()
    assert(v32.activeMouseLockController, "Strict typing check")

    if const bindableToggleEvent = v32.activeMouseLockController:GetBindableToggleEvent() then
        bindableToggleEvent:Connect(
            function()
                --[[
                  line: 198
                  upvalues:
                    v32 (copy, index: 1)
                ]]
                v32:OnMouseLockToggled()
            end
        )
    end

    v32:ActivateCameraController()
    v32:ActivateOcclusionModule(players.LocalPlayer.DevCameraOcclusionMode)
    v32:OnCurrentCameraChanged()

    for _, property in pairs(propertys) do
        players.LocalPlayer:GetPropertyChangedSignal(property):Connect(
            function()
                --[[
                  line: 208
                  upvalues:
                    v32 (copy, index: 1)
                    property (copy, index: 2)
                ]]
                v32:OnLocalPlayerCameraPropertyChanged(property)
            end
        )
    end

    for _, v41 in pairs(v3) do
        v8:GetPropertyChangedSignal(v41):Connect(
            function()
                --[[
                  line: 214
                  upvalues:
                    v32 (copy, index: 1)
                    v41 (copy, index: 2)
                ]]
                v32:OnUserGameSettingsPropertyChanged(v41)
            end
        )
    end

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
        function()
            --[[
              line: 218
              upvalues:
                v32 (copy, index: 1)
            ]]
            v32:OnCurrentCameraChanged()
        end
    )
    userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 221
              upvalues:
                v32 (copy, index: 1)
            ]]
            v32:OnPreferredInputChanged()
        end
    )

    return v32
end

function Class.GetCameraMovementModeFromSettings(self)
    --[[
      name: GetCameraMovementModeFromSettings
      line: 228
      upvalues:
        players (copy, index: 1)
        CameraUtils (copy, index: 2)
        userInputService (copy, index: 3)
        v8 (copy, index: 4)
    ]]
    local v43, v44

    if players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
    end

    if userInputService.PreferredInput ~= Enum.PreferredInput.Touch then
        v43 = CameraUtils.ConvertCameraModeEnumToStandard(players.LocalPlayer.DevComputerCameraMode)
        v44 = CameraUtils.ConvertCameraModeEnumToStandard(v8.ComputerCameraMovementMode)
    else
        v43 = CameraUtils.ConvertCameraModeEnumToStandard(players.LocalPlayer.DevTouchCameraMode)
        v44 = CameraUtils.ConvertCameraModeEnumToStandard(v8.TouchCameraMovementMode)
    end

    if v43 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v44
    end

    return v43
end

function Class.ActivateOcclusionModule(self, occlusionMode)
    --[[
      name: ActivateOcclusionModule
      line: 253
      upvalues:
        Poppercam (copy, index: 1)
        Invisicam (copy, index: 2)
        v24 (copy, index: 3)
        players (copy, index: 4)
    ]]
    local v47

    if occlusionMode ~= Enum.DevCameraOcclusionMode.Zoom then
        if occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode")
            return
        end

        v47 = Invisicam
    else
        v47 = Poppercam
    end

    self.occlusionMode = occlusionMode

    if self.activeOcclusionModule and self.activeOcclusionModule:GetOcclusionMode() == occlusionMode then
        if not self.activeOcclusionModule:GetEnabled() then
            self.activeOcclusionModule:Enable(true)
        end

        return
    end

    local activeOcclusionModule = self.activeOcclusionModule
    self.activeOcclusionModule = v24[v47]

    if not self.activeOcclusionModule then
        self.activeOcclusionModule = v47.new()

        if self.activeOcclusionModule then
            v24[v47] = self.activeOcclusionModule
        end
    end

    if self.activeOcclusionModule then
        if self.activeOcclusionModule:GetOcclusionMode() ~= occlusionMode then
            warn("CameraScript ActivateOcclusionModule mismatch: ", self.activeOcclusionModule:GetOcclusionMode(), "~=", occlusionMode)
        end

        if activeOcclusionModule then
            if activeOcclusionModule == self.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
            else
                activeOcclusionModule:Enable(false)
            end
        end

        if occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam then
            for _, player in pairs(players:GetPlayers()) do
                if player and player.Character then
                    self.activeOcclusionModule:CharacterAdded(player.Character, player)
                end
            end

            self.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
        elseif players.LocalPlayer.Character then
            self.activeOcclusionModule:CharacterAdded(players.LocalPlayer.Character, players.LocalPlayer)
        end

        self.activeOcclusionModule:Enable(true)
    end
end

function Class.ShouldUseVehicleCamera(self)
    --[[
      name: ShouldUseVehicleCamera
      line: 337
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return false
    end

    local cameraType = camera.CameraType
    local cameraSubject = camera.CameraSubject
    local v55 = cameraType == Enum.CameraType.Custom or cameraType == Enum.CameraType.Follow
    local isVehicleSeat = cameraSubject and cameraSubject:IsA("VehicleSeat") or false
    local isNotInvisicam = self.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam

    return isVehicleSeat and v55 and isNotInvisicam
end

function Class.ActivateCameraController(self)
    --[[
      name: ActivateCameraController
      line: 353
      upvalues:
        LegacyCamera (copy, index: 1)
        vrService (copy, index: 2)
        VRCamera (copy, index: 3)
        ClassicCamera (copy, index: 4)
        OrbitalCamera (copy, index: 5)
        VRVehicleCamera (copy, index: 6)
        VehicleCamera (copy, index: 7)
        v23 (copy, index: 8)
        userFlag2 (copy, index: 9)
    ]]
    local cameraType = workspace.CurrentCamera.CameraType
    local v60 = self:GetCameraMovementModeFromSettings()
    local v61 = nil

    if cameraType == Enum.CameraType.Scriptable then
        if self.activeCameraController then
            self.activeCameraController:Enable(false)
            self.activeCameraController = nil
        end

        return
    end

    local activeCameraController

    if cameraType ~= Enum.CameraType.Custom then
        if cameraType ~= Enum.CameraType.Track then
            if cameraType ~= Enum.CameraType.Follow then
                if cameraType ~= Enum.CameraType.Orbital then
                    if cameraType == Enum.CameraType.Attach
                        or cameraType == Enum.CameraType.Watch
                        or cameraType == Enum.CameraType.Fixed
                    then
                        v61 = LegacyCamera
                    else
                        warn("CameraScript encountered an unhandled Camera.CameraType value: ", cameraType)
                    end
                else
                    v60 = Enum.ComputerCameraMovementMode.Orbital
                end
            else
                v60 = Enum.ComputerCameraMovementMode.Follow
            end
        else
            v60 = Enum.ComputerCameraMovementMode.Classic
        end
    else
        v60 = self:GetCameraMovementModeFromSettings()
    end

    if not v61 then
        if vrService.VREnabled then
            v61 = VRCamera
        elseif v60 == Enum.ComputerCameraMovementMode.Classic
            or v60 == Enum.ComputerCameraMovementMode.Follow
            or v60 == Enum.ComputerCameraMovementMode.Default
            or v60 == Enum.ComputerCameraMovementMode.CameraToggle
        then
            v61 = ClassicCamera
        else
            if v60 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.")
                return
            end

            v61 = OrbitalCamera
        end
    end

    if self:ShouldUseVehicleCamera() then
        v61 = if vrService.VREnabled then VRVehicleCamera else VehicleCamera
    end

    if v23[v61] then
        activeCameraController = v23[v61]

        if userFlag2 then
            if activeCameraController.Reset and self.activeCameraController ~= activeCameraController then
                activeCameraController:Reset()
            end
        elseif activeCameraController.Reset then
            activeCameraController:Reset()
        end
    else
        activeCameraController = v61.new()
        v23[v61] = activeCameraController
    end

    if self.activeCameraController then
        if self.activeCameraController == activeCameraController then
            if not self.activeCameraController:GetEnabled() then
                self.activeCameraController:Enable(true)
            end
        else
            if activeCameraController.HandleSubjectDistance then
                activeCameraController:HandleSubjectDistance(self.activeCameraController)
            end

            self.activeCameraController:Enable(false)
            self.activeCameraController = activeCameraController
            self.activeCameraController:Enable(true)
        end
    elseif activeCameraController ~= nil then
        self.activeCameraController = activeCameraController
        assert(self.activeCameraController, "Strict typing check")
        self.activeCameraController:Enable(true)
    end

    if self.activeCameraController then
        self.activeCameraController:SetCameraMovementMode(v60)
        self.activeCameraController:SetCameraType(cameraType)
    end
end

function Class.OnCameraSubjectChanged(self)
    --[[
      name: OnCameraSubjectChanged
      line: 464
    ]]
    local instance = if const camera = workspace.CurrentCamera then camera.CameraSubject else nil

    if self.activeTransparencyController then
        self.activeTransparencyController:SetSubject(instance)
    end

    if self.activeOcclusionModule then
        self.activeOcclusionModule:OnCameraSubjectChanged(instance)
    end

    self:ActivateCameraController()
end

function Class.OnCameraTypeChanged(self, a67)
    --[[
      name: OnCameraTypeChanged
      line: 479
      upvalues:
        userInputService (copy, index: 1)
        CameraUtils (copy, index: 2)
    ]]
    if a67 == Enum.CameraType.Scriptable and userInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior()
    end

    self:ActivateCameraController()
end

function Class.OnCurrentCameraChanged(self)
    --[[
      name: OnCurrentCameraChanged
      line: 491
    ]]
    local camera = game.Workspace.CurrentCamera
    if not camera then
        return
    end

    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()
    end

    if self.cameraTypeChangedConn then
        self.cameraTypeChangedConn:Disconnect()
    end

    self.cameraSubjectChangedConn = camera:GetPropertyChangedSignal("CameraSubject"):Connect(
        function()
            --[[
              line: 505
              upvalues:
                self (copy, index: 1)
            ]]
            self:OnCameraSubjectChanged()
        end
    )
    self.cameraTypeChangedConn = camera:GetPropertyChangedSignal("CameraType"):Connect(
        function()
            --[[
              line: 509
              upvalues:
                self (copy, index: 1)
                camera (copy, index: 2)
            ]]
            self:OnCameraTypeChanged(camera.CameraType)
        end
    )
    self:OnCameraSubjectChanged()
    self:OnCameraTypeChanged(camera.CameraType)
end

function Class.OnLocalPlayerCameraPropertyChanged(self, a71)
    --[[
      name: OnLocalPlayerCameraPropertyChanged
      line: 517
      upvalues:
        players (copy, index: 1)
    ]]
    if a71 ~= "CameraMode" then
        if a71 == "DevComputerCameraMode" or a71 == "DevTouchCameraMode" then
            self:ActivateCameraController()
            return
        end

        if a71 == "DevCameraOcclusionMode" then
            self:ActivateOcclusionModule(players.LocalPlayer.DevCameraOcclusionMode)
            return
        end

        if a71 == "CameraMinZoomDistance" or a71 == "CameraMaxZoomDistance" then
            if self.activeCameraController then
                self.activeCameraController:UpdateForDistancePropertyChange()
            end
        end
    else
        if players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                self:ActivateCameraController()
                return
            end

            warn("Unhandled value for property player.CameraMode: ", players.LocalPlayer.CameraMode)

            return
        end

        if not self.activeCameraController or self.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            self:ActivateCameraController()
        end

        if self.activeCameraController then
            self.activeCameraController:UpdateForDistancePropertyChange()
        end
    end
end

function Class.OnUserGameSettingsPropertyChanged(self, a73)
    --[[
      name: OnUserGameSettingsPropertyChanged
      line: 555
    ]]
    if a73 == "ComputerCameraMovementMode" then
        self:ActivateCameraController()
    end
end

function Class.OnPreferredInputChanged(self)
    --[[
      name: OnPreferredInputChanged
      line: 561
    ]]
    self:ActivateCameraController()
end

function Class.Update(self, a76, a77)
    --[[
      name: Update
      line: 571
      upvalues:
        userFlag4 (copy, index: 1)
        vrService (copy, index: 2)
        v30 (copy, index: 3)
    ]]
    if self.activeCameraController then
        local cFrame, focus
        self.activeCameraController:UpdateMouseBehavior()
        cFrame, focus = self.activeCameraController:Update(a77)

        if userFlag4 and vrService.VREnabled and self.activeCameraController.IsInFirstPerson then
            v30.inFirstPerson = self.activeCameraController:IsInFirstPerson()
        end

        local camera = game.Workspace.CurrentCamera

        if self.activeOcclusionModule and not self.activeCameraController.skipOcclusion then
            cFrame, focus = self.activeOcclusionModule:Update(a77, cFrame, focus, a76)
        end

        camera.CFrame = cFrame
        camera.Focus = focus

        if self.activeTransparencyController then
            self.activeTransparencyController:Update(a77)
        end
    elseif userFlag4 and vrService.VREnabled then
        v30.inFirstPerson = false
    end
end

if not userFlag3 then
    function Class.OnCharacterAdded(self, a82, a83)
        --[[
          name: OnCharacterAdded
          line: 607
        ]]
        if self.activeOcclusionModule then
            self.activeOcclusionModule:CharacterAdded(a82, a83)
        end
    end

    function Class.OnCharacterRemoving(self, a85, a86)
        --[[
          name: OnCharacterRemoving
          line: 613
        ]]
        if self.activeOcclusionModule then
            self.activeOcclusionModule:CharacterRemoving(a85, a86)
        end
    end

    function Class.OnPlayerAdded(self, a88)
        --[[
          name: OnPlayerAdded
          line: 619
          upvalues:
            userFlag (copy, index: 1)
        ]]
        if userFlag then
            if self.connectionUtil then
                self.connectionUtil:trackConnection(
                    `{a88.UserId}CharacterAdded`,
                    a88.CharacterAdded:Connect(
                        function(a89)
                            --[[
                              line: 625
                              upvalues:
                                self (copy, index: 1)
                                a88 (copy, index: 2)
                            ]]
                            self:OnCharacterAdded(a89, a88)
                        end
                    )
                )
                self.connectionUtil:trackConnection(
                    `{a88.UserId}CharacterRemoving`,
                    a88.CharacterRemoving:Connect(
                        function(a90)
                            --[[
                              line: 631
                              upvalues:
                                self (copy, index: 1)
                                a88 (copy, index: 2)
                            ]]
                            self:OnCharacterRemoving(a90, a88)
                        end
                    )
                )
            end
        else
            a88.CharacterAdded:Connect(
                function(a91)
                    --[[
                      line: 637
                      upvalues:
                        self (copy, index: 1)
                        a88 (copy, index: 2)
                    ]]
                    self:OnCharacterAdded(a91, a88)
                end
            )
            a88.CharacterRemoving:Connect(
                function(a92)
                    --[[
                      line: 640
                      upvalues:
                        self (copy, index: 1)
                        a88 (copy, index: 2)
                    ]]
                    self:OnCharacterRemoving(a92, a88)
                end
            )
        end
    end

    function Class.OnPlayerRemoving(self, a94)
        --[[
          name: OnPlayerRemoving
          line: 646
        ]]
        if self.connectionUtil then
            self.connectionUtil:disconnect((`{a94.UserId}CharacterAdded`))
            self.connectionUtil:disconnect((`{a94.UserId}CharacterRemoving`))
        end
    end
end

function Class.OnMouseLockToggled(self)
    --[[
      name: OnMouseLockToggled
      line: 655
    ]]
    if self.activeMouseLockController then
        local isMouseLocked = self.activeMouseLockController:GetIsMouseLocked()
        local mouseLockOffset = self.activeMouseLockController:GetMouseLockOffset()

        if self.activeCameraController then
            self.activeCameraController:SetIsMouseLocked(isMouseLocked)
            self.activeCameraController:SetMouseLockOffset(mouseLockOffset)
        end
    end
end

if runService:IsClient() then
    return Class.new()
end

return Class