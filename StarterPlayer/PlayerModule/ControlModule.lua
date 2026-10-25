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
local ActionController_upv_1 = require(script:WaitForChild("ActionController"))
if u2 or u4 then
    local InputReplication_upv_1 = require(script:WaitForChild("InputReplication"))
else
    local _ = nil
end
if u2 then
    local _ = require(script:WaitForChild("InputSlots"))
else
    local u11 = nil
end
local u12 = nil
u12 = (not RunService_upv_1:IsClient()) or (require(script:WaitForChild("DynamicThumbstick")))
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
local u13 = nil
if u2 then
    AvatarAbilitiesInterface_upv_1 = require(script:WaitForChild("AvatarAbilitiesInterface"))
    u13 = AvatarAbilitiesInterface_upv_1.get(Players_upv_1.LocalPlayer)
end
local CameraRotationAction_upv_1 = script.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraRotationAction")
local u14 = CommonUtils_1.get("VRFirstPersonState")
local tbl_upv_2 = {}
tbl_upv_2[Enum.TouchMovementMode.DPad] = u12
tbl_upv_2[Enum.DevTouchMovementMode.DPad] = u12
tbl_upv_2[Enum.TouchMovementMode.Thumbpad] = u12
tbl_upv_2[Enum.DevTouchMovementMode.Thumbpad] = u12
tbl_upv_2[Enum.TouchMovementMode.Thumbstick] = ClassicThumbstick_upv_1
tbl_upv_2[Enum.DevTouchMovementMode.Thumbstick] = ClassicThumbstick_upv_1
tbl_upv_2[Enum.TouchMovementMode.DynamicThumbstick] = u12
tbl_upv_2[Enum.DevTouchMovementMode.DynamicThumbstick] = u12
tbl_upv_2[Enum.TouchMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.TouchMovementMode.Default] = u12
tbl_upv_2[Enum.ComputerMovementMode.Default] = ActionController_upv_1
tbl_upv_2[Enum.ComputerMovementMode.KeyboardMouse] = ActionController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.KeyboardMouse] = ActionController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.Scriptable] = nil
tbl_upv_2[Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController_upv_1
tbl_upv_2[Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 105
      upvalues:
        tbl_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        VehicleController_upv_1 (copy, index: 4)
        UserGameSettings_upv_1 (copy, index: 5)
        u2 (copy, index: 6)
        u13 (ref,  index: 7)
        GuiService_upv_1 (copy, index: 8)
        UserInputService_upv_1 (copy, index: 9)
        u3 (copy, index: 10)
        ContextActionService_upv_1 (copy, index: 11)
    ]]
    local u15 = setmetatable({}, tbl_upv_1)
    if not RunService_upv_1:IsServer() then
        u15.controllers = {}
        u15.activeControlModule = nil
        u15.activeController = nil
        u15.touchJumpController = nil
        u15.touchAbilitiesController = nil
        u15.moveFunction = Players_upv_1.LocalPlayer.Move
        u15.humanoid = nil
        u15.controlsEnabled = true
        u15.enabled = false
        u15.humanoidSeatedConn = nil
        u15.vehicleController = nil
        u15.touchControlFrame = nil
        u15.currentTorsoAngle = 0
        u15.inputMoveVector = Vector3.new(0, 0, 0)
        u15.vehicleController = VehicleController_upv_1.new()
        Players_upv_1.LocalPlayer.CharacterAdded:Connect(
            function(a1)
                --[[
                  line: 136
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:OnCharacterAdded(a1)
            end
        )
        Players_upv_1.LocalPlayer.CharacterRemoving:Connect(
            function(a2)
                --[[
                  line: 137
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:OnCharacterRemoving(a2)
            end
        )
        if Players_upv_1.LocalPlayer.Character then
            u15:OnCharacterAdded(Players_upv_1.LocalPlayer.Character)
        end
        UserGameSettings_upv_1:GetPropertyChangedSignal("TouchMovementMode"):Connect(
            function()
                --[[
                  line: 142
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
            end
        )
        Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(
            function()
                --[[
                  line: 145
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
            end
        )
        UserGameSettings_upv_1:GetPropertyChangedSignal("ComputerMovementMode"):Connect(
            function()
                --[[
                  line: 149
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
            end
        )
        Players_upv_1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(
            function()
                --[[
                  line: 152
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
            end
        )
        if u2 then
            u13:GetEnabledChangedSignal():Connect(
                function()
                    --[[
                      line: 156
                      upvalues:
                        u15 (copy, index: 1)
                    ]]
                    u15:UpdateAbilitiesControllers()
                end
            )
        end
        u15.playerGui = nil
        u15.touchGui = nil
        u15.playerGuiAddedConn = nil
        GuiService_upv_1:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(
            function()
                --[[
                  line: 166
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
                u15:UpdateActiveControlModuleEnabled()
            end
        )
        UserInputService_upv_1:GetPropertyChangedSignal("PreferredInput"):Connect(
            function()
                --[[
                  line: 171
                  upvalues:
                    u15 (copy, index: 1)
                ]]
                u15:UpdateMovementMode()
            end
        )
        u15.playerGui = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not (u15.playerGui) then
            u15.playerGuiAddedConn = Players_upv_1.LocalPlayer.ChildAdded:Connect(
                function(a3)
                    --[[
                      line: 177
                      upvalues:
                        u15 (copy, index: 1)
                    ]]
                    if not a3:IsA("PlayerGui") then
                        return
                    end
                    u15.playerGui = a3
                    u15.playerGuiAddedConn:Disconnect()
                    u15.playerGuiAddedConn = nil
                    u15:UpdateMovementMode()
                end
            )
        end
        if u3 then
            ContextActionService_upv_1:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        end
    end
    return u15
end
local function _cloneInputs(a1)
    --[[
      name: _cloneInputs
      line: 216
      upvalues:
        StarterPlayer_upv_1 (copy, index: 1)
    ]]
    local v2 = StarterPlayer_upv_1.PlayerModule.InputContexts:Clone()
    v2.CharacterContext.Enabled = true
    v2.CameraContext.Enabled = true
    v2.Parent = a1
end
local InputReplication_upv_1
local function _fireCustomInputs(a1)
    --[[
      name: _fireCustomInputs
      line: 195
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
      line: 223
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
        _fireCustomInputs (copy, index: 11)
    ]]
    if RunService_upv_1:IsServer() then
        if u2 then
            for _, value_1 in Players_upv_1:GetPlayers() do
                InputReplication_upv_1.CloneInputsIfAbsent(value_1)
            end
            Players_upv_1.PlayerAdded:Connect(InputReplication_upv_1.CloneInputsIfAbsent)
        else
            for _, value_2 in Players_upv_1:GetPlayers() do
                local v3 = StarterPlayer_upv_1.PlayerModule.InputContexts:Clone()
                v3.CharacterContext.Enabled = true
                v3.CameraContext.Enabled = true
                v3.Parent = value_2
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
                      line: 248
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
                      line: 254
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
                      line: 260
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
        RunService_upv_1:BindToRenderStep(
            "CameraInput",
            Enum.RenderPriority.Last.Value,
            function()
                --[[
                  line: 271
                  upvalues:
                    u4 (copy, index: 1)
                    InputReplication_upv_1 (copy, index: 2)
                    Players_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                    u2 (copy, index: 5)
                    _fireCustomInputs (copy, index: 6)
                ]]
                if u4 then
                    InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, true)
                elseif u2 then
                    InputReplication_upv_1.FireCustomInputs(Players_upv_1.LocalPlayer)
                else
                    _fireCustomInputs(Players_upv_1.LocalPlayer)
                end
            end
        )
        if u10 then
            RunService_upv_1:BindToAnimation(
                function(a5)
                    --[[
                      line: 282
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
                      line: 286
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
      line: 299
    ]]
    a1 = (a1 + 12.566370614359172) % math.tau
    return ((a1 > math.pi) and (a1 - math.tau)) or a1
end
local function AverageAngle(a1, a2)
    --[[
      name: AverageAngle
      line: 307
    ]]
    local v4 = ((a2 - a1) + 12.566370614359172) % math.tau
    local v5 = ((a1 + ((((v4 > math.pi) and (v4 - math.tau)) or v4) / 2)) + 12.566370614359172) % math.tau
    return ((v5 > math.pi) and (v5 - math.tau)) or v5
end
function tbl_upv_1.GetEstimatedVRTorsoFrame(a1)
    --[[
      name: GetEstimatedVRTorsoFrame
      line: 312
      upvalues:
        VRService_upv_1 (copy, index: 1)
    ]]
    local v6 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v7 = v6:ToEulerAnglesYXZ()
    local v8 = -v7
    if VRService_upv_1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        local v9 = nil
        if VRService_upv_1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
            local v10 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.LeftHand)
            local v11 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.RightHand)
            local v12 = v6.Position - v10.Position
            local v13 = v6.Position - v11.Position
            local v14 = -math.atan2(v12.X, v12.Z)
            local v15 = ((-math.atan2(v13.X, v13.Z) - v14) + 12.566370614359172) % math.tau
            local v16 = ((v14 + ((((v15 > math.pi) and (v15 - math.tau)) or v15) / 2)) + 12.566370614359172) % math.tau
            local v17 = ((v16 > math.pi) and (v16 - math.tau)) or v16
            local v18 = ((v8 - a1.currentTorsoAngle) + 12.566370614359172) % math.tau
            local v19 = ((v18 > math.pi) and (v18 - math.tau)) or v18
            _ = ((v17 - a1.currentTorsoAngle) + 12.566370614359172) % math.tau
            local v21 = ((_ > math.pi) and (_ - math.tau)) or _
            local v22 = false
            if v21 > -1.5707963267948966 then
                v22 = v21 < 1.5707963267948966
            end
            if v22 then
                _ = v21
            else
                _ = v19
            end
            v9 = math.min(v20, v19)
            local v23 = math.max(v20, v19)
            local v24 = 0
            if v9 > 0 then
                v24 = v9
            elseif v23 < 0 then
                v24 = v23
            end
            a1.currentTorsoAngle = v24 + a1.currentTorsoAngle
        else
            a1.currentTorsoAngle = v8
        end
    else
        a1.currentTorsoAngle = v8
    end
    return CFrame.new(v6.Position) * CFrame.fromEulerAnglesYXZ(0, -a1.currentTorsoAngle, 0)
end
function tbl_upv_1.GetActiveController(a1)
    --[[
      name: GetActiveController
      line: 356
    ]]
    return a1.activeController
end
local TouchAbilities_upv_1
function tbl_upv_1.UpdateAbilitiesControllers(a1)
    --[[
      name: UpdateAbilitiesControllers
      line: 360
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        ClickToMoveController_upv_1 (copy, index: 2)
        ClassicThumbstick_upv_1 (copy, index: 3)
        u12 (ref,  index: 4)
        u13 (ref,  index: 5)
        TouchJump_upv_1 (copy, index: 6)
        TouchAbilities_upv_1 (copy, index: 7)
    ]]
    local v25 = a1.enabled
    if v25 then
        v25 = a1.touchControlFrame
        if v25 then
            v25 = false
            if UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch then
                v25 = true
                if a1.activeControlModule ~= ClickToMoveController_upv_1 then
                    v25 = true
                    if a1.activeControlModule ~= ClassicThumbstick_upv_1 then
                        v25 = a1.activeControlModule == u12
                    end
                end
            end
        end
    end
    local v27 = v25 and (not u13:isEnabled())
    local v26 = v25 and (u13:isEnabled())
    if v25 then
        if not (a1.controllers[TouchJump_upv_1]) then
            a1.controllers[TouchJump_upv_1] = TouchJump_upv_1.new(a1.data, a1.playerData)
        end
        a1.touchJumpController = a1.controllers[TouchJump_upv_1]
        a1.touchJumpController:Enable(true, a1.touchControlFrame)
    elseif a1.touchJumpController then
        a1.touchJumpController:Enable(false)
    end
    if v26 then
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
      line: 396
      upvalues:
        u2 (copy, index: 1)
        u13 (ref,  index: 2)
        Players_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        ClickToMoveController_upv_1 (copy, index: 5)
        ClassicThumbstick_upv_1 (copy, index: 6)
        u12 (ref,  index: 7)
        TouchJump_upv_1 (copy, index: 8)
        GuiService_upv_1 (copy, index: 9)
    ]]
    local v27 = function()
        --[[
          line: 398
          upvalues:
            u2 (copy, index: 1)
            a1 (copy, index: 2)
            u13 (ref,  index: 3)
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
        if not a1.moveFunction or (u2) and (u13:isEnabled()) then
            return
        end
        a1.moveFunction(Players_upv_1.LocalPlayer, Vector3.new(0, 0, 0), true)
    end
    local v28 = function()
        --[[
          line: 418
          upvalues:
            u2 (copy, index: 1)
            a1 (copy, index: 2)
            UserInputService_upv_1 (copy, index: 3)
            ClickToMoveController_upv_1 (copy, index: 4)
            ClassicThumbstick_upv_1 (copy, index: 5)
            u12 (ref,  index: 6)
            TouchJump_upv_1 (copy, index: 7)
            Players_upv_1 (copy, index: 8)
        ]]
        if u2 then
            a1.enabled = true
            a1:UpdateAbilitiesControllers()
        elseif a1.touchControlFrame and UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and (a1.activeControlModule == ClickToMoveController_upv_1 or a1.activeControlModule == ClassicThumbstick_upv_1 or a1.activeControlModule == u12) then
            if not (a1.controllers[TouchJump_upv_1]) then
                a1.controllers[TouchJump_upv_1] = TouchJump_upv_1.new(a1.data, a1.playerData)
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
    if a1.controlsEnabled and ((GuiService_upv_1.TouchControlsEnabled) or UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch or a1.activeControlModule ~= ClickToMoveController_upv_1 and a1.activeControlModule ~= ClassicThumbstick_upv_1 and a1.activeControlModule ~= u12) then
        v28()
        return
    end
    v27()
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 483
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
      line: 498
    ]]
    a1:Enable(false)
end
function tbl_upv_1.SelectComputerMovementModule(a1)
    --[[
      name: SelectComputerMovementModule
      line: 504
      upvalues:
        u7 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        ActionController_upv_1 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
        UserGameSettings_upv_1 (copy, index: 5)
        ClickToMoveController_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
    ]]
    local u16 = false
    if u7 then
        pcall(
            function()
                --[[
                  line: 507
                  upvalues:
                    u16 (ref,  index: 1)
                    UserInputService_upv_1 (copy, index: 2)
                ]]
                u16 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.MicroGamepad
            end
        )
    end
    if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse and UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Gamepad and not (u16) then
        return nil, false
    end
    local DevComputerMovementMode_1 = Players_upv_1.LocalPlayer.DevComputerMovementMode
    local v29, v30 = nil, nil
    if DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.UserChoice then
        v29 = tbl_upv_2[DevComputerMovementMode_1]
        if not v29 and DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode_1)
        end
        v30 = v29
    elseif UserGameSettings_upv_1.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove then
        v30 = ActionController_upv_1
    else
        v30 = ClickToMoveController_upv_1
    end
    if v30 then
        return v30, true
    elseif DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.Scriptable then
        return nil, false
    else
        return nil, true
    end
end
function tbl_upv_1.SelectTouchModule(a1)
    --[[
      name: SelectTouchModule
      line: 548
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        UserGameSettings_upv_1 (copy, index: 3)
    ]]
    local DevTouchMovementMode_1 = Players_upv_1.LocalPlayer.DevTouchMovementMode
    local v31 = nil
    if DevTouchMovementMode_1 == Enum.DevTouchMovementMode.UserChoice then
        v31 = tbl_upv_2[UserGameSettings_upv_1.TouchMovementMode]
    elseif DevTouchMovementMode_1 ~= Enum.DevTouchMovementMode.Scriptable then
        v31 = tbl_upv_2[DevTouchMovementMode_1]
    else
        return nil, true
    end
    return v31, true
end
function tbl_upv_1.calculateRawMoveVector(a1, a2, a3)
    --[[
      name: calculateRawMoveVector
      line: 561
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        VRService_upv_1 (copy, index: 2)
        CameraRotationAction_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_1 then
        return a3
    end
    local CFrame_1 = CurrentCamera_1.CFrame
    if VRService_upv_1.VREnabled and a2.RootPart then
        local v32 = a1:GetEstimatedVRTorsoFrame()
        CFrame_1 = (((CurrentCamera_1.Focus.Position - CFrame_1.Position).Magnitude < 3) and (CFrame_1 * v32)) or (CurrentCamera_1.CFrame * (v32.Rotation + (v32.Position * CurrentCamera_1.HeadScale)))
    end
    local v33 = nil
    if a2:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, v45, v46, v34, v35, v36, v47, v48, v33, v49, v50, v37 = CFrame_1:GetComponents()
        local v38, v39
        if (v33 < 1) and (v33 > -1) then
            v38, v39 = v37, v36
        else
            v38, v39 = v34, -v35 * math.sign(v33)
        end
        local v40 = math.sqrt((v38 * v38) + (v39 * v39))
        return (Vector3.new(((v38 * a3.X) + (v39 * a3.Z)) / v40, 0, ((v38 * a3.Z) - (v39 * a3.X)) / v40))
    else
        if not VRService_upv_1.VREnabled then
            return CFrame_1:VectorToWorldSpace(a3)
        end
        local v41 = Vector3.new(a3.X, 0, a3.Z)
        if v41.Magnitude < 0.01 then
            return Vector3.new(0, 0, 0)
        end
        local v42 = 0
        if CameraRotationAction_upv_1 then
            v42 = ((CameraRotationAction_upv_1.Enabled) and (-CameraRotationAction_upv_1:GetState().Y / 2.31)) or v42
        end
        local v43 = math.atan2(-v41.X, -v41.Z)
        local _, v44 = CFrame_1:ToEulerAnglesYXZ()
        return CFrame.fromEulerAnglesYXZ(v42, v43 + v44, 0).LookVector
    end
end
local u11
function tbl_upv_1.initialize(a1, a2, a3)
    --[[
      name: initialize
      line: 622
      upvalues:
        ActionController_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        u11 (copy, index: 3)
    ]]
    a1.data = a2
    a1.playerData = a3
    a1:UpdateMovementMode()
    ActionController_upv_1.initializeActions(a1.data, a1.playerData)
    if not u2 then
        return
    end
    u11.setupSlotActions(a1.playerData.player, a1.data.isServerAuthority)
end
function tbl_upv_1.Update(a1, a2, a3, a4)
    --[[
      name: Update
      line: 634
      upvalues:
        u9 (copy, index: 1)
        ActionController_upv_1 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
        u4 (copy, index: 4)
        u2 (copy, index: 5)
        u13 (ref,  index: 6)
        InputReplication_upv_1 (copy, index: 7)
        Players_upv_1 (copy, index: 8)
        u6 (copy, index: 9)
    ]]
    assert(a3.player)
    assert(a3.character)
    if u9 then
        if not a1.humanoid then
            return
        end
        if not (a3.playerModule.ControlModule.Enabled) then
            a3.isJumping = false
            a3.moveVector = Vector2.new()
            a3.worldMoveVector = Vector3.new()
            ActionController_upv_1.update(a3)
            a1.inputMoveVector = Vector3.new()
            if a1.vehicleController then
                a1.vehicleController:Update(Vector3.new(), true)
            end
            a1:characterMove(a2, a3)
            return
        end
    end
    ActionController_upv_1.initializeActions(a2, a3)
    if not u9 and (not a3.actions.MoveAction or not a3.actions.JumpAction) then
        return
    end
    if a1.activeController and a1.activeController.enabled and a1.humanoid then
        ActionController_upv_1.update(a3)
        a1:GetClickToMoveController():Update(a3, a4)
        local v45 = Vector3.new(a3.moveVector.X, 0, -a3.moveVector.Y)
        if a1.vehicleController then
            local v46, v47 = a1.vehicleController:Update(v45, true)
            _ = v47
            v45 = v46
        end
        v45 = a1:calculateRawMoveVector(a1.humanoid, v45)
        a1.inputMoveVector = v45
        if VRService_upv_1.VREnabled then
            v45 = a1:updateVRMoveVector(v45)
        end
        if u9 then
            a3.worldMoveVector = v45
            a1:characterMove(a2, a3)
            return
        end
        if u4 then
            if not (a2.isServerAuthority) then
                if u2 and u13:isEnabled() then
                    InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, false)
                else
                    a1.moveFunction(Players_upv_1.LocalPlayer, v45, false)
                    a1.humanoid.Jump = a3.isJumping
                end
                return
            end
        elseif (not (u6) or not (a2.isServerAuthority)) and (not (u2) or not (u13:isEnabled())) then
            a1.moveFunction(Players_upv_1.LocalPlayer, v45, false)
            a1.humanoid.Jump = a3.isJumping
        end
    end
end
function tbl_upv_1.characterMove(a1, a2, a3)
    --[[
      name: characterMove
      line: 715
      upvalues:
        u4 (copy, index: 1)
        u2 (copy, index: 2)
        u13 (ref,  index: 3)
        InputReplication_upv_1 (copy, index: 4)
        Players_upv_1 (copy, index: 5)
        u6 (copy, index: 6)
    ]]
    if u4 then
        if (a2.isServerAuthority) then
            return
        end
        if u2 and u13:isEnabled() then
            InputReplication_upv_1.writeInputToPCS(Players_upv_1.LocalPlayer, a1, false)
        else
            a1.moveFunction(Players_upv_1.LocalPlayer, a3.worldMoveVector, false)
            a1.humanoid.Jump = a3.isJumping
        end
    elseif (not u6 or not a2.isServerAuthority) and (not u2 or not u13:isEnabled()) then
        a1.moveFunction(Players_upv_1.LocalPlayer, a3.worldMoveVector, false)
        a1.humanoid.Jump = a3.isJumping
    end
end
function tbl_upv_1.updateVRMoveVector(a1, a2)
    --[[
      name: updateVRMoveVector
      line: 735
      upvalues:
        u1 (copy, index: 1)
        u14 (copy, index: 2)
        VRService_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_2 = workspace.CurrentCamera
    local v48
    if u1 then
        v48 = u14.inFirstPerson
    else
        v48 = (CurrentCamera_2.Focus.Position - CurrentCamera_2.CFrame.Position).Magnitude < 5 and true
    end
    if a2.Magnitude == 0 and v48 and VRService_upv_1.AvatarGestures and a1.humanoid and not (a1.humanoid.Sit) then
        local v50 = VRService_upv_1:GetUserCFrame(Enum.UserCFrame.Head)
        local v51 = ((CurrentCamera_2.CFrame * (v50.Rotation + (v50.Position * CurrentCamera_2.HeadScale))) * CFrame.new(0, (-0.7 * a1.humanoid.RootPart.Size.Y) / 2, 0)).Position - a1.humanoid.RootPart.CFrame.Position
        local v52 = Vector3.new(v51.x, 0, v51.z)
        if u1 and math.max(4 * CurrentCamera_2.HeadScale, 1) < (CurrentCamera_2.Focus.Position - CurrentCamera_2.CFrame.Position).Magnitude then
            return a2
        end
        return v52
    end
    return a2
end
function tbl_upv_1.OnHumanoidSeated(a1, a2, a3)
    --[[
      name: OnHumanoidSeated
      line: 776
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
      line: 791
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
              line: 802
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
      line: 809
    ]]
    a1.humanoid = nil
    a1:UpdateMovementMode()
end
function tbl_upv_1.UpdateTouchGuiVisibility(a1)
    --[[
      name: UpdateTouchGuiVisibility
      line: 815
      upvalues:
        GuiService_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local v53 = a1.humanoid and (GuiService_upv_1.TouchControlsEnabled and (UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch))
    if v53 and not (a1.touchGui) then
        a1:CreateTouchGuiContainer()
    end
    if not a1.touchGui then
        return
    end
    a1.touchGui.Enabled = not not v53
end
function tbl_upv_1.SwitchToController(a1, a2)
    --[[
      name: SwitchToController
      line: 834
    ]]
    if a2 then
        if not (a1.controllers[a2]) then
            a1.controllers[a2] = a2.new(a1.playerData)
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
      line: 873
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    a1:UpdateTouchGuiVisibility()
    if UserInputService_upv_1.PreferredInput ~= Enum.PreferredInput.Touch then
        a1:SwitchToController((a1:SelectComputerMovementModule()))
    else
        local v54, v55 = a1:SelectTouchModule()
        if not v55 or not a1.touchControlFrame then
            return
        end
        a1:SwitchToController(v54)
    end
end
function tbl_upv_1.CreateTouchGuiContainer(a1)
    --[[
      name: CreateTouchGuiContainer
      line: 889
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
      line: 916
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
      line: 923
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
        local v56 = a2.Character
        if v56 == nil then
            return
        end
        local Humanoid_1 = v56:FindFirstChild("Humanoid")
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
              line: 959
            ]]
            local v57 = true
            local v58
            if a4.X ~= a4.X then
                v58 = v57
            else
                v58 = true
                if a4.Y == a4.Y then
                    v58 = true
                    if a4.X ~= math.huge then
                        v58 = a4.Y == math.huge
                    end
                end
            end
            return not v58
        end
        local function isValidInput3D(a5)
            --[[
              name: isValidInput3D
              line: 967
            ]]
            local v59 = true
            local v60
            if a5.X ~= a5.X then
                v60 = v59
            else
                v60 = true
                if a5.Y == a5.Y then
                    v60 = true
                    if a5.Z == a5.Z then
                        v60 = true
                        if a5.X ~= math.huge then
                            v60 = true
                            if a5.Y ~= math.huge then
                                v60 = a5.Z == math.huge
                            end
                        end
                    end
                end
            end
            return not v60
        end
        local v61
        if MoveAction_1 == nil then
            v61 = Vector2.new(0, 0)
        else
            v61 = MoveAction_1:GetState()
        end
        v56 = a2:GetCameraState().CFrame.LookVector
        local v62 = true
        local v63
        if v61.X ~= v61.X then
            v63 = v62
        else
            v63 = true
            if v61.Y == v61.Y then
                v63 = true
                if v61.X ~= math.huge then
                    v63 = v61.Y == math.huge
                end
            end
        end
        if not (v63) then
            local v64 = true
            local v65
            if v56.X ~= v56.X then
                v65 = v64
            else
                v65 = true
                if v56.Y == v56.Y then
                    v65 = true
                    if v56.Z == v56.Z then
                        v65 = true
                        if v56.X ~= math.huge then
                            v65 = true
                            if v56.Y ~= math.huge then
                                v65 = v56.Z == math.huge
                            end
                        end
                    end
                end
            end
            if not (v65) and v56.Magnitude > 0 then
                if Humanoid_1:GetState() ~= Enum.HumanoidStateType.Swimming then
                    v56 = Vector3.new(v56.X, 0, v56.Z).Unit
                end
                Humanoid_1:Move((v56 * v61.Y) + (v56:Cross(Vector3.new(0, 1, 0)).Unit * v61.X))
                if RotationAction_2:GetState() then
                    Humanoid_1.AutoRotate = false
                    if Humanoid_1.SeatPart == nil and Humanoid_1.RootPart ~= nil and not (Humanoid_1.Sit) then
                        local v66 = Humanoid_1.RootPart:IsGrounded()
                        if not (v66) then
                            Humanoid_1.RootPart.CFrame = CFrame.new(Humanoid_1.RootPart.CFrame.Position, Humanoid_1.RootPart.CFrame.Position + v56)
                        end
                    end
                else
                    Humanoid_1.AutoRotate = true
                end
            end
        end
        if JumpAction_1 == nil then
            v61 = false
        else
            v61 = JumpAction_1:GetState()
        end
        Humanoid_1.Jump = v61
    end
end
if RunService_upv_1:IsClient() then
    return tbl_upv_1.new()
end
return tbl_upv_1