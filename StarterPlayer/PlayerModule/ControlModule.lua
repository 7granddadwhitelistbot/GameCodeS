local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local GuiService_upv_1 = game:GetService("GuiService")
local Workspace_upv_1 = game:GetService("Workspace")
local StarterPlayer_upv_1 = game:GetService("StarterPlayer")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local VRService_upv_1 = game:GetService("VRService")
local ContextActionService_upv_1 = game:GetService("ContextActionService")
local CommonUtils_1 = require(script.Parent:WaitForChild("CommonUtils"))
local v1 = CommonUtils_1.get("FlagUtil")
local u1 = v1.getUserFlag("UserVRFixCameraCloseArticulation")
local u2 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u3 = v1.getUserFlag("UserPlayerScriptsBindActivateOnIAS")
local u4 = v1.getUserFlag("UserPlayerScriptsPlayerControlState2")
local u5 = v1.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local u6 = v1.getUserFlag("UserPlayerScriptsFixSAuthRenderStepMove")
local u7 = v1.getUserFlag("UserPlayerScriptsSupportMicroGamepad")
local u8 = v1.getUserFlag("UserAbilitiesUserInterfaceC")
local u9 = v1.getUserFlag("UserControlModuleEnabledAPI")
local u10 = v1.getUserFlag("UserPSUseBindToAnimation")
local u11 = v1.getUserFlag("UserServerAuthorityDontSetAutoRotate")
local ActionController_upv_1 = require(script:WaitForChild("ActionController"))
if u2 or u4 then
    local InputReplication_upv_1 = require(script:WaitForChild("InputReplication"))
else
    local _ = nil
end
if u2 then
    local _ = require(script:WaitForChild("InputSlots"))
else
    local u12 = nil
end
local u13 = nil
u13 = (not RunService_upv_1:IsClient()) or (require(script:WaitForChild("DynamicThumbstick")))
local ClassicThumbstick_upv_1 = require(script:WaitForChild("ClassicThumbstick"))
local ClickToMoveController_upv_1 = require(script:WaitForChild("ClickToMoveController"))
local TouchJump_upv_1 = require(script:WaitForChild("TouchJump"))
if u2 then
    local TouchAbilities_upv_1 = require(script:WaitForChild("TouchAbilities"))
else
    local _ = nil
end
local VehicleController_upv_1 = require(script:WaitForChild("VehicleController"))
local AvatarAbilitiesInterface_upv_1 = nil
local u14 = nil
if u2 then
    AvatarAbilitiesInterface_upv_1 = require(script:WaitForChild("AvatarAbilitiesInterface"))
    u14 = AvatarAbilitiesInterface_upv_1.get(Players_upv_1.LocalPlayer)
end
local CameraRotationAction_upv_1 = script.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraRotationAction")
local u15 = CommonUtils_1.get("VRFirstPersonState")
local tbl_upv_2 = {}
tbl_upv_2[Enum.TouchMovementMode.DPad] = u13
tbl_upv_2[Enum.DevTouchMovementMode.DPad] = u13
tbl_upv_2[Enum.TouchMovementMode.Thumbpad] = u13
tbl_upv_2[Enum.DevTouchMovementMode.Thumbpad] = u13
tbl_upv_2[Enum.TouchMovementMode.Thumbstick] = ClassicThumbstick_upv_1
tbl_upv_2[Enum.DevTouchMovementMode.Thumbstick] = ClassicThumbstick_upv_1
tbl_upv_2[Enum.TouchMovementMode.DynamicThumbstick] = u13
tbl_upv_2[Enum.DevTouchMovementMode.DynamicThumbstick] = u13
tbl_upv_2[Enum.TouchMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.TouchMovementMode.Default] = u13
tbl_upv_2[Enum.ComputerMovementMode.Default] = ActionController_upv_1
tbl_upv_2[Enum.ComputerMovementMode.KeyboardMouse] = ActionController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.KeyboardMouse] = ActionController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.Scriptable] = nil
tbl_upv_2[Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 106
      upvalues:
        tbl_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        VehicleController_upv_1 (copy, index: 4)
        UserGameSettings_upv_1 (copy, index: 5)
        u2 (copy, index: 6)
        u14 (ref,  index: 7)
        GuiService_upv_1 (copy, index: 8)
        UserInputService_upv_1 (copy, index: 9)
        u3 (copy, index: 10)
        ContextActionService_upv_1 (copy, index: 11)
    ]]
    local u16 = setmetatable({}, tbl_upv_1)
    if not RunService_upv_1:IsServer() then
        u16.controllers = {}
        u16.activeControlModule = nil
        u16.activeController = nil
        u16.touchJumpController = nil
        u16.touchAbilitiesController = nil
        u16.moveFunction = Players_upv_1.LocalPlayer.Move
        u16.humanoid = nil
        u16.controlsEnabled = true
        u16.enabled = false
        u16.humanoidSeatedConn = nil
        u16.vehicleController = nil
        u16.touchControlFrame = nil
        u16.currentTorsoAngle = 0
        u16.inputMoveVector = Vector3.new(0, 0, 0)
        u16.renderedRotationOverride = nil
        u16.vehicleController = VehicleController_upv_1.new()
        Players_upv_1.LocalPlayer.CharacterAdded:Connect(
            function(a1)
                --[[
                  line: 139
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:OnCharacterAdded(a1)
            end
        )
        Players_upv_1.LocalPlayer.CharacterRemoving:Connect(
            function(a2)
                --[[
                  line: 140
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:OnCharacterRemoving(a2)
            end
        )
        if Players_upv_1.LocalPlayer.Character then
            u16:OnCharacterAdded(Players_upv_1.LocalPlayer.Character)
        end
        UserGameSettings_upv_1:GetPropertyChangedSignal("TouchMovementMode"):Connect(
            function()
                --[[
                  line: 145
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
            end
        )
        Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(
            function()
                --[[
                  line: 148
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
            end
        )
        UserGameSettings_upv_1:GetPropertyChangedSignal("ComputerMovementMode"):Connect(
            function()
                --[[
                  line: 152
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
            end
        )
        Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(
            function()
                --[[
                  line: 155
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
            end
        )
        if u2 then
            u14:GetEnabledChangedSignal():Connect(
                function()
                    --[[
                      line: 159
                      upvalues:
                        u16 (copy, index: 1)
                    ]]
                    u16:UpdateAbilitiesControllers()
                end
            )
        end
        u16.playerGui = nil
        u16.touchGui = nil
        u16.playerGuiAddedConn = nil
        GuiService_upv_1:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(
            function()
                --[[
                  line: 169
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
                u16:UpdateActiveControlModuleEnabled()
            end
        )
        UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(
            function()
                --[[
                  line: 174
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:UpdateMovementMode()
            end
        )
        u16.playerGui = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not (u16.playerGui) then
            u16.playerGuiAddedConn = Players_upv_1.LocalPlayer.ChildAdded:Connect(
                function(a3)
                    --[[
                      line: 180
                      upvalues:
                        u16 (copy, index: 1)
                    ]]
                    if not a3:IsA("PlayerGui") then
                        return
                    end
                    u16.playerGui = a3
                    u16.playerGuiAddedConn:Disconnect()
                    u16.playerGuiAddedConn = nil
                    u16:UpdateMovementMode()
                end
            )
        end
        if u3 then
            ContextActionService_upv_1:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        end
    end
    return u16
end
function tbl_upv_1.restoreSimulatedRotation(a1)
    --[[
      name: restoreSimulatedRotation
      line: 218
    ]]
    local renderedRotationOverride_1 = a1.renderedRotationOverride
    if renderedRotationOverride_1 == nil then
        return
    end
    if renderedRotationOverride_1.rootPart.Parent ~= nil then
        renderedRotationOverride_1.rootPart.CFrame = CFrame.new(renderedRotationOverride_1.rootPart.CFrame.Position) * renderedRotationOverride_1.simulatedRotation
    end
    a1.renderedRotationOverride = nil
end
function tbl_upv_1.applyRenderedRotation(a1)
    --[[
      name: applyRenderedRotation
      line: 229
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local humanoid_1 = a1.humanoid
    local v2 = humanoid_1 and (humanoid_1.RootPart)
    if CurrentCamera_1 == nil or v2 == nil or (humanoid_1.Sit) or humanoid_1.SeatPart ~= nil or (v2:IsGrounded()) then
        return
    end
    if humanoid_1:GetState() ~= Enum.HumanoidStateType.Swimming then
        local LookVector_1 = CurrentCamera_1.CFrame.LookVector
        local v3 = Vector3.new(LookVector_1.X, 0, LookVector_1.Z)
        if v3.Magnitude < 0.001 then
            return
        end
        if a1.renderedRotationOverride ~= nil and a1.renderedRotationOverride.rootPart ~= v2 then
            a1:restoreSimulatedRotation()
        end
        if a1.renderedRotationOverride == nil then
            a1.renderedRotationOverride = {rootPart = humanoid_1, simulatedRotation = humanoid_1.CFrame.Rotation}
        end
        local Position_1 = humanoid_1.CFrame.Position
        humanoid_1.CFrame = CFrame.lookAt(Position_1, Position_1 + v3)
    end
end
local InputReplication_upv_1
local function _cloneInputs(a1)
    --[[
      name: _cloneInputs
      line: 255
      upvalues:
        StarterPlayer_upv_1 (copy, index: 1)
    ]]
    local v4 = StarterPlayer_upv_1.PlayerModule.InputContexts:Clone()
    v4.CharacterContext.Enabled = true
    v4.CameraContext.Enabled = true
    v4.Parent = a1
end
local function _fireCustomInputs(a1)
    --[[
      name: _fireCustomInputs
      line: 198
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
    ]]
    local InputContexts_1 = a1:FindFirstChild("InputContexts")
    if InputContexts_1 == nil then
        return
    end
    local CharacterContext_1 = InputContexts_1:FindFirstChild("CharacterContext")
    if CharacterContext_1 == nil then
        return
    end
    local RotationAction_1 = CharacterContext_1:FindFirstChild("RotationAction")
    if RotationAction_1 then
        local RotationScriptableBinding_1 = RotationAction_1:FindFirstChild("RotationScriptableBinding")
        if not RotationScriptableBinding_1 then
            return
        end
        RotationScriptableBinding_1:Fire(UserGameSettings_upv_1.RotationType == Enum.RotationType.CameraRelative)
    end
end
function tbl_upv_1.InitializeServerAuthority(a1)
    --[[
      name: InitializeServerAuthority
      line: 262
      upvalues:
        RunService_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        InputReplication_upv_1 (copy, index: 4)
        StarterPlayer_upv_1 (copy, index: 5)
        _cloneInputs (copy, index: 6)
        u4 (copy, index: 7)
        u5 (copy, index: 8)
        AvatarAbilitiesInterface_upv_1 (ref,  index: 9)
        u10 (copy, index: 10)
        u11 (copy, index: 11)
        _fireCustomInputs (copy, index: 12)
        UserGameSettings_upv_1 (copy, index: 13)
        u14 (ref,  index: 14)
    ]]
    if RunService_upv_1:IsServer() then
        if u2 then
            for _, value_1 in Players_upv_1:GetPlayers() do
                InputReplication_upv_1.CloneInputsIfAbsent(value_1)
            end
            Players_upv_1.PlayerAdded:Connect(InputReplication_upv_1.CloneInputsIfAbsent)
        else
            for _, value_2 in Players_upv_1:GetPlayers() do
                local v5 = StarterPlayer_upv_1.PlayerModule.InputContexts:Clone()
                v5.CharacterContext.Enabled = true
                v5.CameraContext.Enabled = true
                v5.Parent = value_2
            end
            Players_upv_1.PlayerAdded:Connect(_cloneInputs)
        end
        if u4 then
            for _, value_3 in Players_upv_1:GetPlayers() do
                InputReplication_upv_1.createPlayerControlState(value_3)
            end
            Players_upv_1.PlayerAdded:Connect(InputReplication_upv_1.createPlayerControlState)
        end
        if u2 and u5 then
            for _, value_4 in Players_upv_1:GetPlayers() do
                AvatarAbilitiesInterface_upv_1.get(value_4)
            end
            Players_upv_1.PlayerAdded:Connect(
                function(a2)
                    --[[
                      line: 287
                      upvalues:
                        AvatarAbilitiesInterface_upv_1 (ref, index: 1)
                    ]]
                    AvatarAbilitiesInterface_upv_1.get(a2)
                end
            )
        end
        if u10 then
            RunService_upv_1:BindToAnimation(
                function(a3)
                    --[[
                      line: 293
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    for _, value_5 in Players_upv_1:GetPlayers() do
                        a1:ProcessInputs(value_5, a3)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        else
            RunService_upv_1:BindToSimulation(
                function(a4)
                    --[[
                      line: 299
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    for _, value_6 in Players_upv_1:GetPlayers() do
                        a1:ProcessInputs(value_6, a4)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        end
    else
        if u4 then
            InputReplication_upv_1.watchForPlayerControlState(Players_upv_1.LocalPlayer)
        end
        if u11 then
            RunService_upv_1.PreAnimation:Connect(
                function()
                    --[[
                      line: 311
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    a1:restoreSimulatedRotation()
                end
            )
        end
        RunService_upv_1:BindToRenderStep(
            "CameraInput",
            Enum.RenderPriority.Last.Value,
            function()
                --[[
                  line: 317
                  upvalues:
                    u4 (copy, index: 1)
                    InputReplication_upv_1 (copy, index: 2)
                    Players_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                    u2 (copy, index: 5)
                    _fireCustomInputs (copy, index: 6)
                    u11 (copy, index: 7)
                    UserGameSettings_upv_1 (copy, index: 8)
                    u14 (ref,  index: 9)
                ]]
                if u4 then
                    InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, true)
                elseif u2 then
                    InputReplication_upv_1.FireCustomInputs(Players_upv_1.LocalPlayer)
                else
                    _fireCustomInputs(Players_upv_1.LocalPlayer)
                end
                if not u11 or UserGameSettings_upv_1.RotationType ~= Enum.RotationType.CameraRelative or (u2) and (u14:isEnabled()) then
                    return
                end
                a1:applyRenderedRotation()
            end
        )
        if u10 then
            RunService_upv_1:BindToAnimation(
                function(a5)
                    --[[
                      line: 332
                      upvalues:
                        a1 (copy, index: 1)
                        Players_upv_1 (copy, index: 2)
                    ]]
                    a1:ProcessInputs(Players_upv_1.LocalPlayer, a5)
                end,
                Enum.StepFrequency.Hz60
            )
        else
            RunService_upv_1:BindToSimulation(
                function(a6)
                    --[[
                      line: 336
                      upvalues:
                        a1 (copy, index: 1)
                        Players_upv_1 (copy, index: 2)
                    ]]
                    a1:ProcessInputs(Players_upv_1.LocalPlayer, a6)
                end,
                Enum.StepFrequency.Hz60
            )
        end
    end
    if not a1.data or not a1.data.eventBus then
        return
    end
    a1.data.isServerAuthority = true
    a1.data.eventBus:publish("SERVER_AUTHORITY_CHANGED", true)
end
local function NormalizeAngle(a1)
    --[[
      name: NormalizeAngle
      line: 349
    ]]
    a1 = (a1 + 12.566370614359172) % math.tau
    return ((a1 > math.pi) and (a1 - math.tau)) or a1
end
local function AverageAngle(a1, a2)
    --[[
      name: AverageAngle
      line: 357
    ]]
    local v6 = ((a2 - a1) + 12.566370614359172) % math.tau
    local v7 = ((a1 + ((((v6 > math.pi) and (v6 - math.tau)) or v6) / 2)) + 12.566370614359172) % math.tau
    return ((v7 > math.pi) and (v7 - math.tau)) or v7
end
function tbl_upv_1.GetEstimatedVRTorsoFrame(a1)
    --[[
      name: GetEstimatedVRTorsoFrame
      line: 362
      upvalues:
        VRService_upv_1 (copy, index: 1)
    ]]
    local v8 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v9 = v8:ToEulerAnglesYXZ()
    local v10 = -v9
    if VRService_upv_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        local v11 = nil
        if VRService_upv_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
            local v12 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.LeftHand)
            local v13 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.RightHand)
            local v14 = v8.Position - v12.Position
            local v15 = v8.Position - v13.Position
            local v16 = -math.atan2(v14.X, v14.Z)
            local v17 = ((-math.atan2(v15.X, v15.Z) - v16) + 12.566370614359172) % math.tau
            local v18 = ((v16 + ((((v17 > math.pi) and (v17 - math.tau)) or v17) / 2)) + 12.566370614359172) % math.tau
            local v19 = ((v18 > math.pi) and (v18 - math.tau)) or v18
            local v20 = ((v10 - a1.currentTorsoAngle) + 12.566370614359172) % math.tau
            local v21 = ((v20 > math.pi) and (v20 - math.tau)) or v20
            _ = ((v19 - a1.currentTorsoAngle) + 12.566370614359172) % math.tau
            local v23 = ((_ > math.pi) and (_ - math.tau)) or _
            local v24 = false
            if v23 > -1.5707963267948966 then
                v24 = v23 < 1.5707963267948966
            end
            if v24 then
                _ = v23
            else
                _ = v21
            end
            v11 = math.min(v22, v21)
            local v25 = math.max(v22, v21)
            local v26 = 0
            if v11 > 0 then
                v26 = v11
            elseif v25 < 0 then
                v26 = v25
            end
            a1.currentTorsoAngle = v26 + a1.currentTorsoAngle
        else
            a1.currentTorsoAngle = v10
        end
    else
        a1.currentTorsoAngle = v10
    end
    return CFrame.new(v8.Position) * CFrame.fromEulerAnglesYXZ(0, -a1.currentTorsoAngle, 0)
end
function tbl_upv_1.GetActiveController(a1)
    --[[
      name: GetActiveController
      line: 406
    ]]
    return a1.activeController
end
local TouchAbilities_upv_1
function tbl_upv_1.UpdateAbilitiesControllers(a1)
    --[[
      name: UpdateAbilitiesControllers
      line: 410
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        ClickToMoveController_upv_1 (copy, index: 2)
        ClassicThumbstick_upv_1 (copy, index: 3)
        u13 (ref,  index: 4)
        u14 (ref,  index: 5)
        TouchJump_upv_1 (copy, index: 6)
        TouchAbilities_upv_1 (copy, index: 7)
    ]]
    local v27 = a1.enabled
    if v27 then
        v27 = a1.touchControlFrame
        if v27 then
            v27 = false
            if UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch then
                v27 = true
                if a1.activeControlModule ~= ClickToMoveController_upv_1 then
                    v27 = true
                    if a1.activeControlModule ~= ClassicThumbstick_upv_1 then
                        v27 = a1.activeControlModule == u13
                    end
                end
            end
        end
    end
    local v29 = v27 and (not u14:isEnabled())
    local v28 = v27 and (u14:isEnabled())
    if v27 then
        if not (a1.controllers[TouchJump_upv_1]) then
            a1.controllers[TouchJump_upv_1] = TouchJump_upv_1.new(a1.data)
        end
        a1.touchJumpController = a1.controllers[TouchJump_upv_1]
        a1.touchJumpController:Enable(true, a1.touchControlFrame)
    elseif a1.touchJumpController then
        a1.touchJumpController:Enable(false)
    end
    if v28 then
        if not (a1.controllers[TouchAbilities_upv_1]) then
            a1.controllers[TouchAbilities_upv_1] = TouchAbilities_upv_1.new(a1.touchControlFrame)
        end
        a1.touchAbilitiesController = a1.controllers[TouchAbilities_upv_1]
        a1.touchAbilitiesController:Enable(true)
    elseif a1.touchAbilitiesController then
        a1.touchAbilitiesController:Enable(false)
    end
end
function tbl_upv_1.UpdateActiveControlModuleEnabled(a1)
    --[[
      name: UpdateActiveControlModuleEnabled
      line: 446
      upvalues:
        u2 (copy, index: 1)
        u14 (ref,  index: 2)
        Players_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        ClickToMoveController_upv_1 (copy, index: 5)
        ClassicThumbstick_upv_1 (copy, index: 6)
        u13 (ref,  index: 7)
        TouchJump_upv_1 (copy, index: 8)
        GuiService_upv_1 (copy, index: 9)
    ]]
    local v29 = function()
        --[[
          line: 448
          upvalues:
            u2 (copy, index: 1)
            a1 (copy, index: 2)
            u14 (ref,  index: 3)
            Players_upv_1 (copy, index: 4)
        ]]
        if u2 then
            a1.enabled = false
        end
        a1.activeController:Enable(false)
        if u2 then
            a1:UpdateAbilitiesControllers()
        elseif a1.touchJumpController then
            a1.touchJumpController:Enable(false)
        end
        if not a1.moveFunction or (u2) and (u14:isEnabled()) then
            return
        end
        a1.moveFunction(Players_upv_1.LocalPlayer, Vector3.new(0, 0, 0), true)
    end
    local v30 = function()
        --[[
          line: 468
          upvalues:
            u2 (copy, index: 1)
            a1 (copy, index: 2)
            UserInputService_upv_1 (copy, index: 3)
            ClickToMoveController_upv_1 (copy, index: 4)
            ClassicThumbstick_upv_1 (copy, index: 5)
            u13 (ref,  index: 6)
            TouchJump_upv_1 (copy, index: 7)
            Players_upv_1 (copy, index: 8)
        ]]
        if u2 then
            a1.enabled = true
            a1:UpdateAbilitiesControllers()
        elseif a1.touchControlFrame and UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and (a1.activeControlModule == ClickToMoveController_upv_1 or a1.activeControlModule == ClassicThumbstick_upv_1 or a1.activeControlModule == u13) then
            if not (a1.controllers[TouchJump_upv_1]) then
                a1.controllers[TouchJump_upv_1] = TouchJump_upv_1.new(a1.data)
            end
            a1.touchJumpController = a1.controllers[TouchJump_upv_1]
            a1.touchJumpController:Enable(true, a1.touchControlFrame)
        elseif a1.touchJumpController then
            a1.touchJumpController:Enable(false)
        end
        if a1.activeControlModule == ClickToMoveController_upv_1 then
            a1.activeController:Enable(true, Players_upv_1.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, a1.touchJumpController)
        elseif a1.touchControlFrame then
            a1.activeController:Enable(true, a1.touchControlFrame)
        else
            a1.activeController:Enable(true)
        end
    end
    if not a1.activeController then
        return
    end
    if a1.controlsEnabled and ((GuiService_upv_1.TouchControlsEnabled) or UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch or a1.activeControlModule ~= ClickToMoveController_upv_1 and a1.activeControlModule ~= ClassicThumbstick_upv_1 and a1.activeControlModule ~= u13) then
        v30()
        return
    end
    v29()
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 533
    ]]
    if a2 == nil then
        a2 = true
    end
    if a1.controlsEnabled == a2 then
        return
    end
    a1.controlsEnabled = a2
    if not a1.activeController then
        return
    end
    a1:UpdateActiveControlModuleEnabled()
end
function tbl_upv_1.Disable(a1)
    --[[
      name: Disable
      line: 548
    ]]
    a1:Enable(false)
end
function tbl_upv_1.SelectComputerMovementModule(a1)
    --[[
      name: SelectComputerMovementModule
      line: 554
      upvalues:
        u7 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        ActionController_upv_1 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
        UserGameSettings_upv_1 (copy, index: 5)
        ClickToMoveController_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
    ]]
    local u17 = false
    if u7 then
        pcall(
            function()
                --[[
                  line: 557
                  upvalues:
                    u17 (ref,  index: 1)
                    UserInputService_upv_1 (copy, index: 2)
                ]]
                u17 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.MicroGamepad
            end
        )
    end
    if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse and UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Gamepad and not (u17) then
        return nil, false
    end
    local DevComputerMovementMode_1 = Players_upv_1.LocalPlayer.DevComputerMovementMode
    local v31, v32 = nil, nil
    if DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.UserChoice then
        v31 = tbl_upv_2[DevComputerMovementMode_1]
        if not v31 and DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode_1)
        end
        v32 = v31
    elseif UserGameSettings_upv_1.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove then
        v32 = ActionController_upv_1
    else
        v32 = ClickToMoveController_upv_1
    end
    if v32 then
        return v32, true
    elseif DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.Scriptable then
        return nil, false
    else
        return nil, true
    end
end
function tbl_upv_1.SelectTouchModule(a1)
    --[[
      name: SelectTouchModule
      line: 598
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        UserGameSettings_upv_1 (copy, index: 3)
    ]]
    local DevTouchMovementMode_1 = Players_upv_1.LocalPlayer.DevTouchMovementMode
    local v33 = nil
    if DevTouchMovementMode_1 == Enum.DevTouchMovementMode.UserChoice then
        v33 = tbl_upv_2[UserGameSettings_upv_1.TouchMovementMode]
    elseif DevTouchMovementMode_1 ~= Enum.DevTouchMovementMode.Scriptable then
        v33 = tbl_upv_2[DevTouchMovementMode_1]
    else
        return nil, true
    end
    return v33, true
end
function tbl_upv_1.calculateRawMoveVector(a1, a2, a3)
    --[[
      name: calculateRawMoveVector
      line: 611
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
        CameraRotationAction_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_2 then
        return a3
    end
    local CFrame_1 = CurrentCamera_2.CFrame
    if VRService_upv_1.VREnabled and a2.RootPart then
        local v34 = a1:GetEstimatedVRTorsoFrame()
        CFrame_1 = (((CurrentCamera_2.Focus.Position - CFrame_1.Position).Magnitude < 3) and (CFrame_1 * v34)) or (CurrentCamera_2.CFrame * (v34.Rotation + (v34.Position * CurrentCamera_2.HeadScale)))
    end
    local v35 = nil
    if a2:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, v47, v48, v36, v37, v38, v49, v50, v35, v51, v52, v39 = CFrame_1:GetComponents()
        local v40, v41
        if (v35 < 1) and (v35 > -1) then
            v40, v41 = v39, v38
        else
            v40, v41 = v36, -v37 * math.sign(v35)
        end
        local v42 = math.sqrt((v40 * v40) + (v41 * v41))
        return (Vector3.new(((v40 * a3.X) + (v41 * a3.Z)) / v42, 0, ((v40 * a3.Z) - (v41 * a3.X)) / v42))
    else
        if not VRService_upv_1.VREnabled then
            return CFrame_1:VectorToWorldSpace(a3)
        end
        local v43 = Vector3.new(a3.X, 0, a3.Z)
        if v43.Magnitude < 0.01 then
            return Vector3.new(0, 0, 0)
        end
        local v44 = 0
        if CameraRotationAction_upv_1 then
            v44 = ((CameraRotationAction_upv_1.Enabled) and (-CameraRotationAction_upv_1:GetState().Y / 2.31)) or v44
        end
        local v45 = math.atan2(-v43.X, -v43.Z)
        local _, v46 = CFrame_1:ToEulerAnglesYXZ()
        return CFrame.fromEulerAnglesYXZ(v44, v45 + v46, 0).LookVector
    end
end
local u12
function tbl_upv_1.initialize(a1, a2)
    --[[
      name: initialize
      line: 672
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        u12 (copy, index: 3)
    ]]
    a1.data = a2
    a1:UpdateMovementMode()
    ActionController_upv_1.initializeActions(a1.data)
    if not u2 then
        return
    end
    u12.setupSlotActions(a1.data.player, a1.data.isServerAuthority)
end
function tbl_upv_1.Update(a1, a2, a3)
    --[[
      name: Update
      line: 683
      upvalues:
        u9 (copy, index: 1)
        ActionController_upv_1 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
        u4 (copy, index: 4)
        u2 (copy, index: 5)
        u14 (ref,  index: 6)
        InputReplication_upv_1 (copy, index: 7)
        Players_upv_1 (copy, index: 8)
        u6 (copy, index: 9)
    ]]
    assert(a2.player)
    assert(a2.character)
    if u9 then
        if not a1.humanoid then
            return
        end
        if not (a2.playerModule.ControlModule.Enabled) then
            a2.isJumping = false
            a2.moveVector = Vector2.new()
            a2.worldMoveVector = Vector3.new()
            ActionController_upv_1.update(a2)
            a1.inputMoveVector = Vector3.new()
            if a1.vehicleController then
                a1.vehicleController:Update(Vector3.new(), true)
            end
            a1:characterMove(a2)
            return
        end
    end
    ActionController_upv_1.initializeActions(a2)
    if not u9 and (not a2.actions.MoveAction or not a2.actions.JumpAction) then
        return
    end
    if a1.activeController and a1.activeController.enabled and a1.humanoid then
        ActionController_upv_1.update(a2)
        a1:GetClickToMoveController():Update(a2, a3)
        local v47 = Vector3.new(a2.moveVector.X, 0, -a2.moveVector.Y)
        if a1.vehicleController then
            local v48, v49 = a1.vehicleController:Update(v47, true)
            _ = v49
            v47 = v48
        end
        v47 = a1:calculateRawMoveVector(a1.humanoid, v47)
        a1.inputMoveVector = v47
        if VRService_upv_1.VREnabled then
            v47 = a1:updateVRMoveVector(v47)
        end
        if u9 then
            a2.worldMoveVector = v47
            a1:characterMove(a2)
            return
        end
        if u4 then
            if not (a2.isServerAuthority) then
                if u2 and u14:isEnabled() then
                    InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, false)
                else
                    a1.moveFunction(Players_upv_1.LocalPlayer, v47, false)
                    a1.humanoid.Jump = a2.isJumping
                end
                return
            end
        elseif (not (u6) or not (a2.isServerAuthority)) and (not (u2) or not (u14:isEnabled())) then
            a1.moveFunction(Players_upv_1.LocalPlayer, v47, false)
            a1.humanoid.Jump = a2.isJumping
        end
    end
end
function tbl_upv_1.characterMove(a1, a2)
    --[[
      name: characterMove
      line: 764
      upvalues:
        u4 (copy, index: 1)
        u2 (copy, index: 2)
        u14 (ref,  index: 3)
        InputReplication_upv_1 (copy, index: 4)
        Players_upv_1 (copy, index: 5)
        u6 (copy, index: 6)
    ]]
    if u4 then
        if (a2.isServerAuthority) then
            return
        end
        if u2 and u14:isEnabled() then
            InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, false)
        else
            a1.moveFunction(Players_upv_1.LocalPlayer, a2.worldMoveVector, false)
            a1.humanoid.Jump = a2.isJumping
        end
    elseif (not u6 or not a2.isServerAuthority) and (not u2 or not u14:isEnabled()) then
        a1.moveFunction(Players_upv_1.LocalPlayer, a2.worldMoveVector, false)
        a1.humanoid.Jump = a2.isJumping
    end
end
function tbl_upv_1.updateVRMoveVector(a1, a2)
    --[[
      name: updateVRMoveVector
      line: 784
      upvalues:
        u1 (copy, index: 1)
        u15 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_3 = workspace.CurrentCamera
    local v50
    if u1 then
        v50 = u15.inFirstPerson
    else
        v50 = (CurrentCamera_3.Focus.Position - CurrentCamera_3.CFrame.Position).Magnitude < 5 and true
    end
    if a2.Magnitude == 0 and v50 and VRService_upv_1.AvatarGestures and a1.humanoid and not (a1.humanoid.Sit) then
        local v52 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
        local v53 = ((CurrentCamera_3.CFrame * (v52.Rotation + (v52.Position * CurrentCamera_3.HeadScale))) * CFrame.new(0, (-0.7 * a1.humanoid.RootPart.Size.Y) / 2, 0)).Position - a1.humanoid.RootPart.CFrame.Position
        local v54 = Vector3.new(v53.x, 0, v53.z)
        if u1 and math.max(4 * CurrentCamera_3.HeadScale, 1) < (CurrentCamera_3.Focus.Position - CurrentCamera_3.CFrame.Position).Magnitude then
            return a2
        end
        return v54
    end
    return a2
end
function tbl_upv_1.OnHumanoidSeated(a1, a2, a3)
    --[[
      name: OnHumanoidSeated
      line: 825
    ]]
    if a2 then
        if not a3 or not a3:IsA("VehicleSeat") then
            return
        end
        if not (a1.vehicleController) then
            a1.vehicleController = a1.vehicleController.new()
        end
        a1.vehicleController:Enable(true, a3)
    elseif a1.vehicleController then
        a1.vehicleController:Enable(false, a3)
    end
end
function tbl_upv_1.OnCharacterAdded(a1, a2)
    --[[
      name: OnCharacterAdded
      line: 840
    ]]
    a1.humanoid = a2:FindFirstChildOfClass("Humanoid")
    while not (a1.humanoid) do
        a2.ChildAdded:wait()
        a1.humanoid = a2:FindFirstChildOfClass("Humanoid")
    end
    if a1.humanoidSeatedConn then
        a1.humanoidSeatedConn:Disconnect()
        a1.humanoidSeatedConn = nil
    end
    a1.humanoidSeatedConn = a1.humanoid.Seated:Connect(
        function(a3, a4)
            --[[
              line: 851
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:OnHumanoidSeated(a3, a4)
        end
    )
    a1:UpdateMovementMode()
end
function tbl_upv_1.OnCharacterRemoving(a1, a2)
    --[[
      name: OnCharacterRemoving
      line: 858
    ]]
    a1.humanoid = nil
    a1:UpdateMovementMode()
end
function tbl_upv_1.UpdateTouchGuiVisibility(a1)
    --[[
      name: UpdateTouchGuiVisibility
      line: 864
      upvalues:
        GuiService_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local v55 = a1.humanoid and (GuiService_upv_1.TouchControlsEnabled and (UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch))
    if v55 and not (a1.touchGui) then
        a1:CreateTouchGuiContainer()
    end
    if not a1.touchGui then
        return
    end
    a1.touchGui.Enabled = not not v55
end
function tbl_upv_1.SwitchToController(a1, a2)
    --[[
      name: SwitchToController
      line: 883
    ]]
    if a2 then
        if not (a1.controllers[a2]) then
            a1.controllers[a2] = a2.new(a1.data)
        end
        if a1.activeController ~= a1.controllers[a2] then
            if a1.activeController then
                a1.activeController:Enable(false)
            end
            a1.activeController = a1.controllers[a2]
            a1.activeControlModule = a2
            a1:UpdateActiveControlModuleEnabled()
        end
    else
        if a1.activeController then
            a1.activeController:Enable(false)
        end
        a1.activeController = nil
        a1.activeControlModule = nil
    end
end
function tbl_upv_1.UpdateMovementMode(a1)
    --[[
      name: UpdateMovementMode
      line: 922
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    a1:UpdateTouchGuiVisibility()
    if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch then
        a1:SwitchToController((a1:SelectComputerMovementModule()))
    else
        local v56, v57 = a1:SelectTouchModule()
        if not v57 or not a1.touchControlFrame then
            return
        end
        a1:SwitchToController(v56)
    end
end
function tbl_upv_1.CreateTouchGuiContainer(a1)
    --[[
      name: CreateTouchGuiContainer
      line: 938
      upvalues:
        u2 (copy, index: 1)
        u8 (copy, index: 2)
    ]]
    if not a1.playerGui then
        return
    end
    if a1.touchGui then
        a1.touchGui:Destroy()
    end
    a1.touchGui = Instance.new("ScreenGui")
    a1.touchGui.Name = "TouchGui"
    a1.touchGui.ResetOnSpawn = false
    a1.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    if u2 and u8 then
        a1.touchGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    end
    a1.touchGui.ClipToDeviceSafeArea = false
    a1.touchControlFrame = Instance.new("Frame")
    a1.touchControlFrame.Name = "TouchControlFrame"
    a1.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    a1.touchControlFrame.BackgroundTransparency = 1
    a1.touchControlFrame.Parent = a1.touchGui
    a1.touchGui.Parent = a1.playerGui
end
function tbl_upv_1.GetClickToMoveController(a1)
    --[[
      name: GetClickToMoveController
      line: 965
      upvalues:
        ClickToMoveController_upv_1 (copy, index: 1)
    ]]
    if not (a1.controllers[ClickToMoveController_upv_1]) then
        a1.controllers[ClickToMoveController_upv_1] = ClickToMoveController_upv_1.new()
    end
    return a1.controllers[ClickToMoveController_upv_1]
end
function tbl_upv_1.ProcessInputs(a1, a2, a3)
    --[[
      name: ProcessInputs
      line: 972
      upvalues:
        u2 (copy, index: 1)
        AvatarAbilitiesInterface_upv_1 (ref,  index: 2)
        u4 (copy, index: 3)
        InputReplication_upv_1 (copy, index: 4)
    ]]
    if u2 then
        if (AvatarAbilitiesInterface_upv_1.get(a2):isEnabled()) then
            return
        end
        if u4 then
            InputReplication_upv_1.processPCSInputs(a2)
        else
            InputReplication_upv_1.SendInputToHumanoidForServerAuth(a2)
        end
    elseif u4 then
        InputReplication_upv_1.processPCSInputs(a2)
    else
        local v58 = a2.Character
        if v58 == nil then
            return
        end
        local Humanoid_1 = v58:FindFirstChild("Humanoid")
        if Humanoid_1 == nil then
            return
        end
        local InputContexts_2 = a2:FindFirstChild("InputContexts")
        if InputContexts_2 == nil then
            return
        end
        local CharacterContext_2 = InputContexts_2:FindFirstChild("CharacterContext")
        if CharacterContext_2 == nil then
            return
        end
        local MoveAction_1 = CharacterContext_2.MoveAction
        local RotationAction_2 = CharacterContext_2.RotationAction
        local JumpAction_1 = CharacterContext_2.JumpAction
        local function isValidInput2D(a4)
            --[[
              name: isValidInput2D
              line: 1008
            ]]
            local v59 = true
            local v60
            if a4.X ~= a4.X then
                v60 = v59
            else
                v60 = true
                if a4.Y == a4.Y then
                    v60 = true
                    if a4.X ~= math.huge then
                        v60 = a4.Y == math.huge
                    end
                end
            end
            return not v60
        end
        local function isValidInput3D(a5)
            --[[
              name: isValidInput3D
              line: 1016
            ]]
            local v61 = true
            local v62
            if a5.X ~= a5.X then
                v62 = v61
            else
                v62 = true
                if a5.Y == a5.Y then
                    v62 = true
                    if a5.Z == a5.Z then
                        v62 = true
                        if a5.X ~= math.huge then
                            v62 = true
                            if a5.Y ~= math.huge then
                                v62 = a5.Z == math.huge
                            end
                        end
                    end
                end
            end
            return not v62
        end
        local v63
        if MoveAction_1 == nil then
            v63 = Vector2.new(0, 0)
        else
            v63 = MoveAction_1:GetState()
        end
        v58 = a2:GetCameraState().CFrame.LookVector
        local v64 = true
        local v65
        if v63.X ~= v63.X then
            v65 = v64
        else
            v65 = true
            if v63.Y == v63.Y then
                v65 = true
                if v63.X ~= math.huge then
                    v65 = v63.Y == math.huge
                end
            end
        end
        if not (v65) then
            local v66 = true
            local v67
            if v58.X ~= v58.X then
                v67 = v66
            else
                v67 = true
                if v58.Y == v58.Y then
                    v67 = true
                    if v58.Z == v58.Z then
                        v67 = true
                        if v58.X ~= math.huge then
                            v67 = true
                            if v58.Y ~= math.huge then
                                v67 = v58.Z == math.huge
                            end
                        end
                    end
                end
            end
            if not (v67) and v58.Magnitude > 0 then
                if Humanoid_1:GetState() ~= Enum.HumanoidStateType.Swimming then
                    v58 = Vector3.new(v58.X, 0, v58.Z).Unit
                end
                Humanoid_1:Move((v58 * v63.Y) + (v58:Cross(Vector3.new(0, 1, 0)).Unit * v63.X))
                if RotationAction_2:GetState() then
                    Humanoid_1.AutoRotate = false
                    if Humanoid_1.SeatPart == nil and Humanoid_1.RootPart ~= nil and not (Humanoid_1.Sit) then
                        local v68 = Humanoid_1.RootPart:IsGrounded()
                        if not (v68) then
                            Humanoid_1.RootPart.CFrame = CFrame.new(Humanoid_1.RootPart.CFrame.Position, Humanoid_1.RootPart.CFrame.Position + v58)
                        end
                    end
                else
                    Humanoid_1.AutoRotate = true
                end
            end
        end
        if JumpAction_1 == nil then
            v63 = false
        else
            v63 = JumpAction_1:GetState()
        end
        Humanoid_1.Jump = v63
    end
end
if RunService_upv_1:IsClient() then
    return tbl_upv_1.new()
end
return tbl_upv_1