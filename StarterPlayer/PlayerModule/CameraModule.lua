local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local tbl_upv_2 = {"CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock"}
local tbl_upv_3 = {"ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode"}
local Players_upv_1 = game:GetService("Players")
local RunService_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local VRService_upv_1 = game:GetService("VRService")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local CommonUtils_1 = require(script.Parent:WaitForChild("CommonUtils"))
local u1 = CommonUtils_1.get("ConnectionUtil")
local u2 = CommonUtils_1.get("FlagUtil")
local CameraUtils_upv_1 = require(script:WaitForChild("CameraUtils"))
local _ = require(script:WaitForChild("CameraInput"))
local ClassicCamera_upv_1 = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera_upv_1 = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera_upv_1 = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera_upv_1 = require(script:WaitForChild("VehicleCamera"))
local VRCamera_upv_1 = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera_upv_1 = require(script:WaitForChild("VRVehicleCamera"))
local Invisicam_upv_1 = require(script:WaitForChild("Invisicam"))
local Poppercam_upv_1 = require(script:WaitForChild("Poppercam"))
local TransparencyController_upv_1 = require(script:WaitForChild("TransparencyController"))
local MouseLockController_upv_1 = require(script:WaitForChild("MouseLockController"))
local tbl_upv_4 = {}
local tbl_upv_5 = {}
if not Players_upv_1.LocalPlayer then
    return {}
end
assert(Players_upv_1.LocalPlayer, "Strict typing check")
local PlayerScripts_1 = Players_upv_1.LocalPlayer:WaitForChild("PlayerScripts")
PlayerScripts_1:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
PlayerScripts_1:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
PlayerScripts_1:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
PlayerScripts_1:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
PlayerScripts_1:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
PlayerScripts_1:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
PlayerScripts_1:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
local u3 = u2.getUserFlag("UserPlayerConnectionMemoryLeak")
local u4 = u2.getUserFlag("UserPSFixCameraControllerReset")
local u5 = u2.getUserFlag("UserVRFixCameraCloseArticulation")
local FFlagUserOrthographicOcclusion_1 = FFlagUserOrthographicOcclusion
if FFlagUserOrthographicOcclusion_1 then
    u2 = pcall(
        function()
            --[[
              line: 107
            ]]
            return Instance.new("Camera").ProjectionType
        end
    )
else
    u2 = FFlagUserOrthographicOcclusion_1
end
local u6 = CommonUtils_1.get("VRFirstPersonState")
function tbl_upv_1.new()
    --[[
      name: new
      line: 151
      upvalues:
        TransparencyController_upv_1 (copy, index: 1)
        u3 (copy, index: 2)
        u1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        Players_upv_1 (copy, index: 5)
        MouseLockController_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        tbl_upv_3 (copy, index: 8)
        UserGameSettings_upv_1 (copy, index: 9)
        UserInputService_upv_1 (copy, index: 10)
    ]]
    local tbl_6 = {connectionUtil = 0}
    tbl_6.activeTransparencyController = TransparencyController_upv_1.new()
    local v1
    if u3 then
        v1 = u1.new()
    else
        v1 = nil
    end
    tbl_6.connectionUtil = v1
    local u7 = setmetatable(tbl_6, tbl_upv_1)
    u7.activeCameraController = nil
    u7.activeOcclusionModule = nil
    u7.activeMouseLockController = nil
    u7.currentComputerCameraMovementMode = nil
    u7.cameraSubjectChangedConn = nil
    u7.cameraTypeChangedConn = nil
    for _, value_1 in pairs(Players_upv_1:GetPlayers()) do
        u7:OnPlayerAdded(value_1)
    end
    Players_upv_1.PlayerAdded:Connect(
        function(a1)
            --[[
              line: 174
              upvalues:
                u7 (copy, index: 1)
            ]]
            u7:OnPlayerAdded(a1)
        end
    )
    if u3 then
        Players_upv_1.PlayerRemoving:Connect(
            function(a2)
                --[[
                  line: 179
                  upvalues:
                    u7 (copy, index: 1)
                ]]
                u7:OnPlayerRemoving(a2)
            end
        )
    end
    u7.activeTransparencyController:Enable(true)
    u7.activeMouseLockController = MouseLockController_upv_1.new()
    assert(u7.activeMouseLockController, "Strict typing check")
    local v2 = u7.activeMouseLockController:GetBindableToggleEvent()
    if v2 then
        v2:Connect(
            function()
                --[[
                  line: 191
                  upvalues:
                    u7 (copy, index: 1)
                ]]
                u7:OnMouseLockToggled()
            end
        )
    end
    u7:ActivateCameraController()
    u7:ActivateOcclusionModule(Players_upv_1.LocalPlayer.DevCameraOcclusionMode)
    u7:OnCurrentCameraChanged()
    for _, value_upv_2 in pairs(tbl_upv_2) do
        Players_upv_1.LocalPlayer:GetPropertyChangedSignal(value_upv_2):Connect(
            function()
                --[[
                  line: 201
                  upvalues:
                    u7 (copy, index: 1)
                    value_upv_2 (copy, index: 2)
                ]]
                u7:OnLocalPlayerCameraPropertyChanged(value_upv_2)
            end
        )
    end
    for _, value_upv_3 in pairs(tbl_upv_3) do
        UserGameSettings_upv_1:GetPropertyChangedSignal(value_upv_3):Connect(
            function()
                --[[
                  line: 207
                  upvalues:
                    u7 (copy, index: 1)
                    value_upv_3 (copy, index: 2)
                ]]
                u7:OnUserGameSettingsPropertyChanged(value_upv_3)
            end
        )
    end
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(
        function()
            --[[
              line: 211
              upvalues:
                u7 (copy, index: 1)
            ]]
            u7:OnCurrentCameraChanged()
        end
    )
    UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(
        function()
            --[[
              line: 214
              upvalues:
                u7 (copy, index: 1)
            ]]
            u7:OnPreferredInputChanged()
        end
    )
    return u7
end
function tbl_upv_1.GetCameraMovementModeFromSettings(a1)
    --[[
      name: GetCameraMovementModeFromSettings
      line: 221
      upvalues:
        Players_upv_1 (copy, index: 1)
        CameraUtils_upv_1 (copy, index: 2)
        UserInputService_upv_1 (copy, index: 3)
        UserGameSettings_upv_1 (copy, index: 4)
    ]]
    if Players_upv_1.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        local v3, v4
        if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch then
            v3, v4 = CameraUtils_upv_1.ConvertCameraModeEnumToStandard(Players_upv_1.LocalPlayer.DevComputerCameraMode), CameraUtils_upv_1.ConvertCameraModeEnumToStandard(UserGameSettings_upv_1.ComputerCameraMovementMode)
        else
            v3 = CameraUtils_upv_1.ConvertCameraModeEnumToStandard(Players_upv_1.LocalPlayer.DevTouchCameraMode)
            v4 = CameraUtils_upv_1.ConvertCameraModeEnumToStandard(UserGameSettings_upv_1.TouchCameraMovementMode)
        end
        if v3 ~= Enum.DevComputerCameraMovementMode.UserChoice then
            return v3
        end
        return v4
    end
    return CameraUtils_upv_1.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
end
function tbl_upv_1.ActivateOcclusionModule(a1, a2)
    --[[
      name: ActivateOcclusionModule
      line: 246
      upvalues:
        Poppercam_upv_1 (copy, index: 1)
        Invisicam_upv_1 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
    ]]
    local v5
    if a2 ~= Enum.DevCameraOcclusionMode.Zoom then
        if a2 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode")
            return
        end
        v5 = Invisicam_upv_1
    else
        v5 = Poppercam_upv_1
    end
    a1.occlusionMode = a2
    if a1.activeOcclusionModule and a1.activeOcclusionModule:GetOcclusionMode() == a2 then
        if not (a1.activeOcclusionModule:GetEnabled()) then
            a1.activeOcclusionModule:Enable(true)
        end
        return
    end
    local activeOcclusionModule_1 = a1.activeOcclusionModule
    a1.activeOcclusionModule = tbl_upv_5[v5]
    if not (a1.activeOcclusionModule) then
        a1.activeOcclusionModule = v5.new()
        if a1.activeOcclusionModule then
            tbl_upv_5[v5] = a1.activeOcclusionModule
        end
    end
    if not a1.activeOcclusionModule then
        return
    end
    if a1.activeOcclusionModule:GetOcclusionMode() ~= a2 then
        warn("CameraScript ActivateOcclusionModule mismatch: ", a1.activeOcclusionModule:GetOcclusionMode(), "~=", a2)
    end
    if activeOcclusionModule_1 then
        if activeOcclusionModule_1 == a1.activeOcclusionModule then
            warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
        else
            activeOcclusionModule_1:Enable(false)
        end
    end
    if a2 ~= Enum.DevCameraOcclusionMode.Invisicam then
        for _, value_4 in pairs(Players_upv_1:GetPlayers()) do
            if not (value_4) then
                continue
            end
            if value_4.Character then
                a1.activeOcclusionModule:CharacterAdded(value_4.Character, value_4)
            end
        end
        a1.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
    elseif Players_upv_1.LocalPlayer.Character then
        a1.activeOcclusionModule:CharacterAdded(Players_upv_1.LocalPlayer.Character, Players_upv_1.LocalPlayer)
    end
    a1.activeOcclusionModule:Enable(true)
end
function tbl_upv_1.ShouldUseVehicleCamera(a1)
    --[[
      name: ShouldUseVehicleCamera
      line: 325
    ]]
    local v6 = workspace.CurrentCamera
    if not v6 then
        return false
    end
    local CameraType_1 = v6.CameraType
    local CameraSubject_1 = v6.CameraSubject
    local v7 = true
    if CameraType_1 == Enum.CameraType.Custom then
        v6 = v7
    else
        v6 = CameraType_1 == Enum.CameraType.Follow
    end
    local v8 = (CameraSubject_1 and (CameraSubject_1:IsA("VehicleSeat"))) or false
    local v9 = a1.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
    local v10
    if v8 then
        if v6 then
            v10 = v9
        else
            v10 = v6
        end
    else
        v10 = v8
    end
    return v10
end
function tbl_upv_1.ActivateCameraController(a1)
    --[[
      name: ActivateCameraController
      line: 341
      upvalues:
        LegacyCamera_upv_1 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
        VRCamera_upv_1 (copy, index: 3)
        ClassicCamera_upv_1 (copy, index: 4)
        OrbitalCamera_upv_1 (copy, index: 5)
        VRVehicleCamera_upv_1 (copy, index: 6)
        VehicleCamera_upv_1 (copy, index: 7)
        tbl_upv_4 (copy, index: 8)
        u4 (copy, index: 9)
    ]]
    local CameraType_2 = workspace.CurrentCamera.CameraType
    local v11 = a1:GetCameraMovementModeFromSettings()
    local v12 = nil
    if CameraType_2 ~= Enum.CameraType.Scriptable then
        if CameraType_2 == Enum.CameraType.Custom then
            v11 = a1:GetCameraMovementModeFromSettings()
        elseif CameraType_2 == Enum.CameraType.Track then
            v11 = Enum.ComputerCameraMovementMode.Classic
        elseif CameraType_2 == Enum.CameraType.Follow then
            v11 = Enum.ComputerCameraMovementMode.Follow
        elseif CameraType_2 == Enum.CameraType.Orbital then
            v11 = Enum.ComputerCameraMovementMode.Orbital
        elseif CameraType_2 ~= Enum.CameraType.Attach and CameraType_2 ~= Enum.CameraType.Watch and CameraType_2 ~= Enum.CameraType.Fixed then
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", CameraType_2)
        else
            v12 = LegacyCamera_upv_1
        end
        local v14 = nil
        if v12 then
            local v13 = a1:ShouldUseVehicleCamera()
            if v13 then
                if VRService_upv_1.VREnabled then
                    v12 = VRVehicleCamera_upv_1
                else
                    v12 = VehicleCamera_upv_1
                end
            end
        elseif VRService_upv_1.VREnabled then
            v12 = VRCamera_upv_1
            local v13 = a1:ShouldUseVehicleCamera()
            if v13 then
                if VRService_upv_1.VREnabled then
                    v12 = VRVehicleCamera_upv_1
                else
                    v12 = VehicleCamera_upv_1
                end
            end
        else
            if v11 ~= Enum.ComputerCameraMovementMode.Classic and v11 ~= Enum.ComputerCameraMovementMode.Follow and v11 ~= Enum.ComputerCameraMovementMode.Default and v11 ~= Enum.ComputerCameraMovementMode.CameraToggle then
                if v11 ~= Enum.ComputerCameraMovementMode.Orbital then
                    warn("ActivateCameraController did not select a module.")
                else
                    v12 = OrbitalCamera_upv_1
                    local v13 = a1:ShouldUseVehicleCamera()
                    if v13 then
                        if VRService_upv_1.VREnabled then
                            v12 = VRVehicleCamera_upv_1
                        else
                            v12 = VehicleCamera_upv_1
                        end
                    end
                    if tbl_upv_4[v12] then
                        v14 = tbl_upv_4[v12]
                        if u4 then
                            if v14.Reset and a1.activeCameraController ~= v14 then
                                v14:Reset()
                            end
                        elseif v14.Reset then
                            v14:Reset()
                        end
                        v14 = v14
                    else
                        v14 = v12.new()
                        tbl_upv_4[v12] = v14
                    end
                    if a1.activeCameraController then
                        if a1.activeCameraController == v14 then
                            if not (a1.activeCameraController:GetEnabled()) then
                                a1.activeCameraController:Enable(true)
                            end
                        else
                            if v14.HandleSubjectDistance then
                                v14:HandleSubjectDistance(a1.activeCameraController)
                            end
                            a1.activeCameraController:Enable(false)
                            a1.activeCameraController = v14
                            a1.activeCameraController:Enable(true)
                        end
                    elseif v14 ~= nil then
                        a1.activeCameraController = v14
                        assert(a1.activeCameraController, "Strict typing check")
                        a1.activeCameraController:Enable(true)
                    end
                    if a1.activeCameraController then
                        a1.activeCameraController:SetCameraMovementMode(v11)
                        a1.activeCameraController:SetCameraType(CameraType_2)
                    end
                end
                return
            end
            v12 = ClassicCamera_upv_1
            local v13 = a1:ShouldUseVehicleCamera()
            if v13 then
                if VRService_upv_1.VREnabled then
                    v12 = VRVehicleCamera_upv_1
                else
                    v12 = VehicleCamera_upv_1
                end
            end
        end
        if tbl_upv_4[v12] then
            local v15 = tbl_upv_4[v12]
            if u4 then
                if v15.Reset and a1.activeCameraController ~= v15 then
                    v15:Reset()
                end
            elseif v15.Reset then
                v15:Reset()
            end
            v14 = v15
        else
            v14 = v12.new()
            tbl_upv_4[v12] = v14
        end
        if a1.activeCameraController then
            if a1.activeCameraController == v14 then
                if not (a1.activeCameraController:GetEnabled()) then
                    a1.activeCameraController:Enable(true)
                end
            else
                if v14.HandleSubjectDistance then
                    v14:HandleSubjectDistance(a1.activeCameraController)
                end
                a1.activeCameraController:Enable(false)
                a1.activeCameraController = v14
                a1.activeCameraController:Enable(true)
            end
        elseif v14 ~= nil then
            a1.activeCameraController = v14
            assert(a1.activeCameraController, "Strict typing check")
            a1.activeCameraController:Enable(true)
        end
        if a1.activeCameraController then
            a1.activeCameraController:SetCameraMovementMode(v11)
            a1.activeCameraController:SetCameraType(CameraType_2)
        end
    elseif a1.activeCameraController then
        a1.activeCameraController:Enable(false)
        a1.activeCameraController = nil
    end
end
function tbl_upv_1.OnCameraSubjectChanged(a1)
    --[[
      name: OnCameraSubjectChanged
      line: 450
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    local v16
    if CurrentCamera_1 then
        v16 = CurrentCamera_1.CameraSubject
    else
        v16 = nil
    end
    if a1.activeTransparencyController then
        a1.activeTransparencyController:SetSubject(v16)
    end
    if a1.activeOcclusionModule then
        a1.activeOcclusionModule:OnCameraSubjectChanged(v16)
    end
    a1:ActivateCameraController()
end
function tbl_upv_1.OnCameraTypeChanged(a1, a2)
    --[[
      name: OnCameraTypeChanged
      line: 465
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        CameraUtils_upv_1 (copy, index: 2)
    ]]
    if a2 == Enum.CameraType.Scriptable and UserInputService_upv_1.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils_upv_1.restoreMouseBehavior()
    end
    a1:ActivateCameraController()
end
function tbl_upv_1.OnCurrentCameraChanged(a1)
    --[[
      name: OnCurrentCameraChanged
      line: 477
    ]]
    local CurrentCamera_upv_2 = game.Workspace.CurrentCamera
    if not CurrentCamera_upv_2 then
        return
    end
    if a1.cameraSubjectChangedConn then
        a1.cameraSubjectChangedConn:Disconnect()
    end
    if a1.cameraTypeChangedConn then
        a1.cameraTypeChangedConn:Disconnect()
    end
    a1.cameraSubjectChangedConn = CurrentCamera_upv_2:GetPropertyChangedSignal("CameraSubject"):Connect(
        function()
            --[[
              line: 489
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:OnCameraSubjectChanged()
        end
    )
    a1.cameraTypeChangedConn = CurrentCamera_upv_2:GetPropertyChangedSignal("CameraType"):Connect(
        function()
            --[[
              line: 493
              upvalues:
                a1 (copy, index: 1)
                CurrentCamera_upv_2 (copy, index: 2)
            ]]
            a1:OnCameraTypeChanged(CurrentCamera_upv_2.CameraType)
        end
    )
    a1:OnCameraSubjectChanged()
    a1:OnCameraTypeChanged(CurrentCamera_upv_2.CameraType)
end
function tbl_upv_1.OnLocalPlayerCameraPropertyChanged(a1, a2)
    --[[
      name: OnLocalPlayerCameraPropertyChanged
      line: 501
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if a2 ~= "CameraMode" then
        if a2 ~= "DevComputerCameraMode" and a2 ~= "DevTouchCameraMode" then
            if a2 == "DevCameraOcclusionMode" then
                a1:ActivateOcclusionModule(Players_upv_1.LocalPlayer.DevCameraOcclusionMode)
            elseif a2 == "CameraMinZoomDistance" or a2 == "CameraMaxZoomDistance" then
                if a1.activeCameraController then
                    a1.activeCameraController:UpdateForDistancePropertyChange()
                end
            end
            return
        end
        a1:ActivateCameraController()
    elseif Players_upv_1.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        if not (a1.activeCameraController) or a1.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            a1:ActivateCameraController()
        end
        if not a1.activeCameraController then
            return
        end
        a1.activeCameraController:UpdateForDistancePropertyChange()
    elseif Players_upv_1.LocalPlayer.CameraMode ~= Enum.CameraMode.Classic then
        warn("Unhandled value for property player.CameraMode: ", Players_upv_1.LocalPlayer.CameraMode)
    else
        a1:ActivateCameraController()
    end
end
function tbl_upv_1.OnUserGameSettingsPropertyChanged(a1, a2)
    --[[
      name: OnUserGameSettingsPropertyChanged
      line: 543
    ]]
    if a2 ~= "ComputerCameraMovementMode" then
        return
    end
    a1:ActivateCameraController()
end
function tbl_upv_1.OnPreferredInputChanged(a1)
    --[[
      name: OnPreferredInputChanged
      line: 549
    ]]
    a1:ActivateCameraController()
end
function tbl_upv_1.Update(a1, a2, a3)
    --[[
      name: Update
      line: 559
      upvalues:
        u5 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
        u6 (copy, index: 3)
        u2 (copy, index: 4)
    ]]
    if a1.activeCameraController then
        a1.activeCameraController:UpdateMouseBehavior()
        local v17, v18 = a1.activeCameraController:Update(a3)
        if u5 and VRService_upv_1.VREnabled and a1.activeCameraController.IsInFirstPerson then
            u6.inFirstPerson = a1.activeCameraController:IsInFirstPerson()
        end
        local CurrentCamera_3 = game.Workspace.CurrentCamera
        if u2 then
            if a1.activeOcclusionModule and not a1.activeCameraController.skipOcclusion and CurrentCamera_3.ProjectionType ~= Enum.ProjectionType.Orthographic then
                local v19, v20 = a1.activeOcclusionModule:Update(a3, v17, v18)
                v17, v18 = v19, v20
            end
        elseif a1.activeOcclusionModule and not a1.activeCameraController.skipOcclusion then
            local v21, v22 = a1.activeOcclusionModule:Update(a3, v17, v18)
            v17, v18 = v21, v22
        end
        CurrentCamera_3.CFrame = v17
        CurrentCamera_3.Focus = v18
        if not a1.activeTransparencyController then
            return
        end
        a1.activeTransparencyController:Update(a3)
    elseif u5 and VRService_upv_1.VREnabled then
        u6.inFirstPerson = false
    end
end
function tbl_upv_1.OnCharacterAdded(a1, a2, a3)
    --[[
      name: OnCharacterAdded
      line: 596
    ]]
    if not a1.activeOcclusionModule then
        return
    end
    a1.activeOcclusionModule:CharacterAdded(a2, a3)
end
function tbl_upv_1.OnCharacterRemoving(a1, a2, a3)
    --[[
      name: OnCharacterRemoving
      line: 602
    ]]
    if not a1.activeOcclusionModule then
        return
    end
    a1.activeOcclusionModule:CharacterRemoving(a2, a3)
end
function tbl_upv_1.OnPlayerAdded(a1, a2)
    --[[
      name: OnPlayerAdded
      line: 608
      upvalues:
        u3 (copy, index: 1)
    ]]
    if u3 then
        if not a1.connectionUtil then
            return
        end
        a1.connectionUtil:trackConnection(
            ("%*CharacterAdded"):format(a2.UserId),
            a2.CharacterAdded:Connect(
                function(a3)
                    --[[
                      line: 612
                      upvalues:
                        a1 (copy, index: 1)
                        a2 (copy, index: 2)
                    ]]
                    a1:OnCharacterAdded(a3, a2)
                end
            )
        )
        a1.connectionUtil:trackConnection(
            ("%*CharacterRemoving"):format(a2.UserId),
            a2.CharacterRemoving:Connect(
                function(a4)
                    --[[
                      line: 615
                      upvalues:
                        a1 (copy, index: 1)
                        a2 (copy, index: 2)
                    ]]
                    a1:OnCharacterRemoving(a4, a2)
                end
            )
        )
    else
        a2.CharacterAdded:Connect(
            function(a5)
                --[[
                  line: 620
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1:OnCharacterAdded(a5, a2)
            end
        )
        a2.CharacterRemoving:Connect(
            function(a6)
                --[[
                  line: 623
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                a1:OnCharacterRemoving(a6, a2)
            end
        )
    end
end
function tbl_upv_1.OnPlayerRemoving(a1, a2)
    --[[
      name: OnPlayerRemoving
      line: 629
    ]]
    if not a1.connectionUtil then
        return
    end
    a1.connectionUtil:disconnect((("%*CharacterAdded"):format(a2.UserId)))
    a1.connectionUtil:disconnect((("%*CharacterRemoving"):format(a2.UserId)))
end
function tbl_upv_1.OnMouseLockToggled(a1)
    --[[
      name: OnMouseLockToggled
      line: 637
    ]]
    if a1.activeMouseLockController then
        local v23 = a1.activeMouseLockController:GetIsMouseLocked()
        local v24 = a1.activeMouseLockController:GetMouseLockOffset()
        if not a1.activeCameraController then
            return
        end
        a1.activeCameraController:SetIsMouseLocked(v23)
        a1.activeCameraController:SetMouseLockOffset(v24)
    end
end
if RunService_1:IsClient() then
    return tbl_upv_1.new()
end
return tbl_upv_1