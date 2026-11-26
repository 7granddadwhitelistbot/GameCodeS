local DynamicThumbstick
local AvatarAbilitiesInterface, v3
local Class = {}
Class.__index = Class
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local workspace2 = game:GetService("Workspace")
local starterPlayer = game:GetService("StarterPlayer")
local v11 = UserSettings():GetService("UserGameSettings")
local vrService = game:GetService("VRService")
local contextActionService = game:GetService("ContextActionService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local v15 = CommonUtils.get("FlagUtil")
local userFlag = v15.getUserFlag("UserVRFixCameraCloseArticulation")
local userFlag2 = v15.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v15.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag3 = v15.getUserFlag("UserPlayerScriptsBindActivateOnIAS")
local userFlag4 = v15.getUserFlag("UserPlayerScriptsPlayerControlState2")
    or v15.getUserFlag("UserPlayerScriptsPlayerControlState2GA")
local userFlag5 = v15.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local userFlag6 = v15.getUserFlag("UserPlayerScriptsFixSAuthRenderStepMove")
local userFlag7 = v15.getUserFlag("UserPlayerScriptsSupportMicroGamepad")
local userFlag8 = v15.getUserFlag("UserAbilitiesUserInterfaceA")
local userFlag9 = v15.getUserFlag("UserAbilitiesUserInterfaceC")
local userFlag10 = v15.getUserFlag("UserPSUseBindToAnimation")
local userFlag11 = v15.getUserFlag("UserServerAuthorityDontSetAutoRotate")
local userFlag12 = v15.getUserFlag("UserPlayerModuleEngineAPI")
local userFlag13 = v15.getUserFlag("UserControlModuleDisabledUpdate")
local ActionController = require(script:WaitForChild("ActionController"))
local v30 = if not userFlag2 and not userFlag4 then nil else require(script:WaitForChild("InputReplication"))
local v31 = if userFlag2 then require(script:WaitForChild("InputSlots")) else nil

if runService:IsClient() then
    DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"))
else
    DynamicThumbstick = nil
end

local ClassicThumbstick = require(script:WaitForChild("ClassicThumbstick"))
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"))
local TouchJump = require(script:WaitForChild("TouchJump"))
local v35 = if userFlag2 then require(script:WaitForChild("TouchAbilities")) else nil
local v36 = if userFlag2 then require(script:WaitForChild("AbilitiesOverflowMenu")) else nil
local v37 = if userFlag2 then require(script:WaitForChild("AbilitiesKeybindBar")) else nil
local VehicleController = require(script:WaitForChild("VehicleController"))

if userFlag2 then
    AvatarAbilitiesInterface = require(script:WaitForChild("AvatarAbilitiesInterface"))
    v3 = AvatarAbilitiesInterface.get(players.LocalPlayer)
else
    v3, AvatarAbilitiesInterface = nil, nil
end

local cameraRotationAction = script.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraRotationAction")
local value = Enum.ContextActionPriority.Medium.Value
local v41 = CommonUtils.get("VRFirstPersonState")
local v42 = {}
v42[Enum.TouchMovementMode.DPad] = DynamicThumbstick
v42[Enum.DevTouchMovementMode.DPad] = DynamicThumbstick
v42[Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick
v42[Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick
v42[Enum.TouchMovementMode.Thumbstick] = ClassicThumbstick
v42[Enum.DevTouchMovementMode.Thumbstick] = ClassicThumbstick
v42[Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick
v42[Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick
v42[Enum.TouchMovementMode.ClickToMove] = ClickToMoveController
v42[Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController
v42[Enum.TouchMovementMode.Default] = DynamicThumbstick
v42[Enum.ComputerMovementMode.Default] = ActionController
v42[Enum.ComputerMovementMode.KeyboardMouse] = ActionController
v42[Enum.DevComputerMovementMode.KeyboardMouse] = ActionController
v42[Enum.DevComputerMovementMode.Scriptable] = nil
v42[Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController
v42[Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController

function Class.new()
    --[[
      name: new
      line: 123
      upvalues:
        Class (copy, index: 1)
        runService (copy, index: 2)
        players (copy, index: 3)
        VehicleController (copy, index: 4)
        userFlag12 (copy, index: 5)
        v11 (copy, index: 6)
        userFlag2 (copy, index: 7)
        v3 (ref,  index: 8)
        guiService (copy, index: 9)
        userInputService (copy, index: 10)
        userFlag3 (copy, index: 11)
        contextActionService (copy, index: 12)
    ]]
    local v43 = setmetatable({}, Class)

    if not runService:IsServer() then
        v43.controllers = {}
        v43.activeControlModule = nil
        v43.activeController = nil
        v43.touchJumpController = nil
        v43.touchAbilitiesController = nil
        v43.abilitiesOverflowController = nil
        v43.abilitiesKeybindBarController = nil
        v43.moveFunction = players.LocalPlayer.Move
        v43.humanoid = nil
        v43.controlsEnabled = true
        v43.enabled = false
        v43.humanoidSeatedConn = nil
        v43.vehicleController = nil
        v43.touchControlFrame = nil
        v43.abilitiesGui = nil
        v43.abilitiesFrame = nil
        v43.currentTorsoAngle = 0
        v43.inputMoveVector = Vector3.new(0, 0, 0)
        v43.renderedRotationOverride = nil
        v43.vehicleController = VehicleController.new()

        if not userFlag12 then
            players.LocalPlayer.CharacterAdded:Connect(
                function(character: Model)
                    --[[
                      line: 161
                      upvalues:
                        v43 (copy, index: 1)
                    ]]
                    v43:OnCharacterAdded(character)
                end
            )
            players.LocalPlayer.CharacterRemoving:Connect(
                function(character: Model)
                    --[[
                      line: 164
                      upvalues:
                        v43 (copy, index: 1)
                    ]]
                    v43:OnCharacterRemoving(character)
                end
            )

            if players.LocalPlayer.Character then
                v43:OnCharacterAdded(players.LocalPlayer.Character)
            end
        end

        v11:GetPropertyChangedSignal("TouchMovementMode"):Connect(
            function()
                --[[
                  line: 172
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
            end
        )
        players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(
            function()
                --[[
                  line: 175
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
            end
        )
        v11:GetPropertyChangedSignal("ComputerMovementMode"):Connect(
            function()
                --[[
                  line: 179
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
            end
        )
        players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(
            function()
                --[[
                  line: 182
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
            end
        )

        if userFlag2 then
            v3:GetEnabledChangedSignal():Connect(
                function()
                    --[[
                      line: 186
                      upvalues:
                        v43 (copy, index: 1)
                    ]]
                    v43:UpdateAbilitiesControllers()
                end
            )
        end

        v43.playerGui = nil
        v43.touchGui = nil
        v43.playerGuiAddedConn = nil

        guiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(
            function()
                --[[
                  line: 197
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
                v43:UpdateActiveControlModuleEnabled()
            end
        )

        userInputService:GetPropertyChangedSignal("PreferredInput"):Connect(
            function()
                --[[
                  line: 202
                  upvalues:
                    v43 (copy, index: 1)
                ]]
                v43:UpdateMovementMode()
            end
        )
        v43.playerGui = players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

        if not v43.playerGui then
            v43.playerGuiAddedConn = players.LocalPlayer.ChildAdded:Connect(
                function(child: Instance)
                    --[[
                      line: 208
                      upvalues:
                        v43 (copy, index: 1)
                        userFlag2 (copy, index: 2)
                    ]]
                    if child:IsA("PlayerGui") then
                        v43.playerGui = child
                        v43.playerGuiAddedConn:Disconnect()
                        v43.playerGuiAddedConn = nil
                        v43:UpdateMovementMode()

                        if userFlag2 then
                            v43:UpdateAbilitiesControllers()
                        end
                    end
                end
            )
        end

        if userFlag3 then
            contextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        end
    end

    return v43
end

local function _fireCustomInputs(localPlayer: Player?)
    --[[
      name: _fireCustomInputs
      line: 229
      upvalues:
        userFlag13 (copy, index: 1)
        v11 (copy, index: 2)
    ]]
    assert(not userFlag13)
    local inputContexts = localPlayer:FindFirstChild("InputContexts")
    if inputContexts ~= nil then
        local characterContext = inputContexts:FindFirstChild("CharacterContext")
        if characterContext == nil then
            return
        elseif const rotationAction = characterContext:FindFirstChild("RotationAction") then
            if const rotationScriptableBinding = rotationAction:FindFirstChild("RotationScriptableBinding") then
                rotationScriptableBinding:Fire(v11.RotationType == Enum.RotationType.CameraRelative)
            end
        end
    end
end

function Class.restoreSimulatedRotation(self)
    --[[
      name: restoreSimulatedRotation
      line: 250
    ]]
    local renderedRotationOverride = self.renderedRotationOverride
    if renderedRotationOverride == nil then
        return
    end

    if renderedRotationOverride.rootPart.Parent ~= nil then
        renderedRotationOverride.rootPart.CFrame = CFrame.new(renderedRotationOverride.rootPart.CFrame.Position) * renderedRotationOverride.simulatedRotation
    end

    self.renderedRotationOverride = nil
end

function Class.applyRenderedRotation(self)
    --[[
      name: applyRenderedRotation
      line: 261
      upvalues:
        workspace2 (copy, index: 1)
    ]]
    local camera = workspace2.CurrentCamera
    local humanoid = self.humanoid
    local rootPart = humanoid and humanoid.RootPart

    if camera == nil
        or rootPart == nil
        or humanoid.Sit
        or humanoid.SeatPart ~= nil
        or rootPart:IsGrounded()
        or humanoid:GetState() == Enum.HumanoidStateType.Swimming
    then
        return
    end

    local lookVector = camera.CFrame.LookVector
    local vector3 = Vector3.new(lookVector.X, 0, lookVector.Z)

    if vector3.Magnitude < 0.001 then
        return
    end

    if self.renderedRotationOverride ~= nil and self.renderedRotationOverride.rootPart ~= rootPart then
        self:restoreSimulatedRotation()
    end

    if self.renderedRotationOverride == nil then
        self.renderedRotationOverride = {rootPart = rootPart, simulatedRotation = rootPart.CFrame.Rotation}
    end

    local position = rootPart.CFrame.Position
    rootPart.CFrame = CFrame.lookAt(position, position + vector3)
end

local function _cloneInputs(player: Player)
    --[[
      name: _cloneInputs
      line: 293
      upvalues:
        starterPlayer (copy, index: 1)
    ]]
    local inputContexts = starterPlayer.PlayerModule.InputContexts:Clone()
    inputContexts.CharacterContext.Enabled = true
    inputContexts.CameraContext.Enabled = true
    inputContexts.Parent = player
end

function Class.InitializeServerAuthority(self)
    --[[
      name: InitializeServerAuthority
      line: 300
      upvalues:
        runService (copy, index: 1)
        userFlag2 (copy, index: 2)
        players (copy, index: 3)
        v30 (copy, index: 4)
        starterPlayer (copy, index: 5)
        _cloneInputs (copy, index: 6)
        userFlag4 (copy, index: 7)
        userFlag5 (copy, index: 8)
        AvatarAbilitiesInterface (ref,  index: 9)
        userFlag10 (copy, index: 10)
        userFlag11 (copy, index: 11)
        userFlag13 (copy, index: 12)
        _fireCustomInputs (copy, index: 13)
        v11 (copy, index: 14)
        v3 (ref,  index: 15)
    ]]
    if runService:IsServer() then
        if userFlag2 then
            for _, player in players:GetPlayers() do
                v30.CloneInputsIfAbsent(player)
            end

            players.PlayerAdded:Connect(v30.CloneInputsIfAbsent)
        else
            for _, player in players:GetPlayers() do
                local inputContexts = starterPlayer.PlayerModule.InputContexts:Clone()
                inputContexts.CharacterContext.Enabled = true
                inputContexts.CameraContext.Enabled = true
                inputContexts.Parent = player
            end

            players.PlayerAdded:Connect(_cloneInputs)
        end

        if userFlag4 then
            for _, player in players:GetPlayers() do
                v30.createPlayerControlState(player)
            end

            players.PlayerAdded:Connect(v30.createPlayerControlState)
        end

        if userFlag2 and userFlag5 then
            for _, player in players:GetPlayers() do
                AvatarAbilitiesInterface.get(player)
            end

            players.PlayerAdded:Connect(
                function(player: Player)
                    --[[
                      line: 325
                      upvalues:
                        AvatarAbilitiesInterface (ref, index: 1)
                    ]]
                    AvatarAbilitiesInterface.get(player)
                end
            )
        end

        if userFlag10 then
            runService:BindToAnimation(
                function(a76)
                    --[[
                      line: 331
                      upvalues:
                        players (copy, index: 1)
                        self (copy, index: 2)
                    ]]
                    for _, player in players:GetPlayers() do
                        self:ProcessInputs(player, a76)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        else
            runService:BindToSimulation(
                function(a79)
                    --[[
                      line: 337
                      upvalues:
                        players (copy, index: 1)
                        self (copy, index: 2)
                    ]]
                    for _, player in players:GetPlayers() do
                        self:ProcessInputs(player, a79)
                    end
                end,
                Enum.StepFrequency.Hz60
            )
        end
    else
        if userFlag4 then
            v30.watchForPlayerControlState(players.LocalPlayer)
        end

        if userFlag11 then
            runService.PreAnimation:Connect(
                function()
                    --[[
                      line: 349
                      upvalues:
                        self (copy, index: 1)
                    ]]
                    self:restoreSimulatedRotation()
                end
            )
        end

        runService:BindToRenderStep(
            "CameraInput",
            Enum.RenderPriority.Last.Value,
            function()
                --[[
                  line: 354
                  upvalues:
                    userFlag13 (copy, index: 1)
                    userFlag4 (copy, index: 2)
                    v30 (copy, index: 3)
                    players (copy, index: 4)
                    self (copy, index: 5)
                    userFlag2 (copy, index: 6)
                    _fireCustomInputs (copy, index: 7)
                    userFlag11 (copy, index: 8)
                    v11 (copy, index: 9)
                    v3 (ref,  index: 10)
                ]]
                if not userFlag13 then
                    if userFlag4 then
                        v30.writeInputToCS(players.LocalPlayer, self)
                    elseif userFlag2 then
                        v30.FireCustomInputs(players.LocalPlayer)
                    else
                        _fireCustomInputs(players.LocalPlayer)
                    end
                end

                if userFlag11
                    and v11.RotationType == Enum.RotationType.CameraRelative
                    and (not userFlag2 or not v3:isEnabled())
                then
                    self:applyRenderedRotation()
                end
            end
        )

        if userFlag10 then
            runService:BindToAnimation(
                function(a82)
                    --[[
                      line: 374
                      upvalues:
                        self (copy, index: 1)
                        players (copy, index: 2)
                    ]]
                    self:ProcessInputs(players.LocalPlayer, a82)
                end,
                Enum.StepFrequency.Hz60
            )
        else
            runService:BindToSimulation(
                function(a83)
                    --[[
                      line: 378
                      upvalues:
                        self (copy, index: 1)
                        players (copy, index: 2)
                    ]]
                    self:ProcessInputs(players.LocalPlayer, a83)
                end,
                Enum.StepFrequency.Hz60
            )
        end
    end

    if self.data and self.data.eventBus then
        self.data.isServerAuthority = true
        self.data.eventBus:publish("SERVER_AUTHORITY_CHANGED", true)
    end
end

local function NormalizeAngle(a85)
    --[[
      name: NormalizeAngle
      line: 390
    ]]
    local v86 = (a85 + 12.566370614359172) % math.tau

    if math.pi < v86 then
        v86 -= math.tau
    end

    return v86
end

local function AverageAngle(a88, a89)
    --[[
      name: AverageAngle
      line: 398
    ]]
    local v90 = ((a89 - a88) + 12.566370614359172) % math.tau

    if math.pi < v90 then
        v90 -= math.tau
    end

    local v91 = ((a88 + (v90 / 2)) + 12.566370614359172) % math.tau

    if math.pi < v91 then
        v91 -= math.tau
    end

    return v91
end

function Class.GetEstimatedVRTorsoFrame(self)
    --[[
      name: GetEstimatedVRTorsoFrame
      line: 403
      upvalues:
        vrService (copy, index: 1)
    ]]
    local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v95 = userCFrame:ToEulerAnglesYXZ()
    local currentTorsoAngle = -v95

    if not vrService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)
        or not vrService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
    then
        self.currentTorsoAngle = currentTorsoAngle
    else
        local userCFrame2 = vrService:GetUserCFrame(Enum.UserCFrame.LeftHand)
        local userCFrame3 = vrService:GetUserCFrame(Enum.UserCFrame.RightHand)
        local displacement = userCFrame.Position - userCFrame2.Position
        local displacement2 = userCFrame.Position - userCFrame3.Position
        local v101 = -math.atan2(displacement.X, displacement.Z)
        local v102 = ((-math.atan2(displacement2.X, displacement2.Z) - v101) + 12.566370614359172) % math.tau

        if math.pi < v102 then
            v102 -= math.tau
        end

        local v103 = ((v101 + (v102 / 2)) + 12.566370614359172) % math.tau

        if math.pi < v103 then
            v103 -= math.tau
        end

        local v104 = ((currentTorsoAngle - self.currentTorsoAngle) + 12.566370614359172) % math.tau

        if math.pi < v104 then
            v104 -= math.tau
        end

        local v105 = ((v103 - self.currentTorsoAngle) + 12.566370614359172) % math.tau

        if math.pi < v105 then
            v105 -= math.tau
        end

        local v106 = -1.5707963267948966 < v105 and v105 < 1.5707963267948966
        local v107 = if not v106 then v104 else v105
        local v108 = math.min(v107, v104)
        local v109 = math.max(v107, v104)
        local v110 = 0

        if not (0 < v108) then
            if v109 < 0 then
                v110 = v109
            end
        else
            v110 = v108
        end

        self.currentTorsoAngle = v110 + self.currentTorsoAngle
    end

    return CFrame.new(userCFrame.Position) * CFrame.fromEulerAnglesYXZ(0, -self.currentTorsoAngle, 0)
end

function Class.GetActiveController(self)
    --[[
      name: GetActiveController
      line: 448
    ]]
    return self.activeController
end

function Class.UpdateAbilitiesControllers(self)
    --[[
      name: UpdateAbilitiesControllers
      line: 452
      upvalues:
        userInputService (copy, index: 1)
        ClickToMoveController (copy, index: 2)
        ClassicThumbstick (copy, index: 3)
        DynamicThumbstick (ref,  index: 4)
        v3 (ref,  index: 5)
        TouchJump (copy, index: 6)
        v35 (copy, index: 7)
        userFlag8 (copy, index: 8)
        userFlag9 (copy, index: 9)
        v36 (copy, index: 10)
        v37 (copy, index: 11)
    ]]
    local v113 = self.enabled
        and self.touchControlFrame
        and userInputService.PreferredInput == Enum.PreferredInput.Touch
        and (self.activeControlModule == ClickToMoveController
            or self.activeControlModule == ClassicThumbstick
            or self.activeControlModule == DynamicThumbstick)
    local v114 = v113 and not v3:isEnabled()
    local isEnabled = v113 and v3:isEnabled()

    if v114 then
        if not self.controllers[TouchJump] then
            self.controllers[TouchJump] = TouchJump.new(self.data)
        end

        self.touchJumpController = self.controllers[TouchJump]
        self.touchJumpController:Enable(true, self.touchControlFrame)
    elseif self.touchJumpController then
        if isEnabled then
            self.touchJumpController:Destroy()
            self.controllers[TouchJump] = nil
            self.touchJumpController = nil
        else
            self.touchJumpController:Enable(false)
        end
    end

    if isEnabled then
        if not self.controllers[v35] then
            self.controllers[v35] = v35.new(self.touchControlFrame)
        end

        self.touchAbilitiesController = self.controllers[v35]
        self.touchAbilitiesController:Enable(true)
    elseif self.touchAbilitiesController then
        if v114 then
            self.touchAbilitiesController:Destroy()
            self.controllers[v35] = nil
            self.touchAbilitiesController = nil
        else
            self.touchAbilitiesController:Enable(false)
        end
    end

    local isEnabled2 = self.enabled and userFlag8 and userFlag9 and v3:isEnabled()

    if isEnabled2 then
        if not self.abilitiesGui then
            self:CreateAbilitiesGuiContainer()
        end

        if self.abilitiesGui then
            if not self.controllers[v36] then
                self.controllers[v36] = v36.new(self.abilitiesFrame)
            end

            self.abilitiesOverflowController = self.controllers[v36]
            self.abilitiesOverflowController:Enable(true)

            if v37 then
                if not self.controllers[v37] then
                    self.controllers[v37] = v37.new(self.abilitiesGui)
                end

                self.abilitiesKeybindBarController = self.controllers[v37]
                self.abilitiesKeybindBarController:Enable(true)
            end

            self.abilitiesGui.Enabled = true
        end
    else
        if self.abilitiesOverflowController then
            self.abilitiesOverflowController:Enable(false)
        end

        if self.abilitiesKeybindBarController then
            self.abilitiesKeybindBarController:Enable(false)
        end

        if self.abilitiesGui then
            self.abilitiesGui.Enabled = false
        end
    end
end

function Class.UpdateActiveControlModuleEnabled(self)
    --[[
      name: UpdateActiveControlModuleEnabled
      line: 533
      upvalues:
        userFlag2 (copy, index: 1)
        v3 (ref,  index: 2)
        players (copy, index: 3)
        userInputService (copy, index: 4)
        ClickToMoveController (copy, index: 5)
        ClassicThumbstick (copy, index: 6)
        DynamicThumbstick (ref,  index: 7)
        TouchJump (copy, index: 8)
        guiService (copy, index: 9)
    ]]
    local v118 = function()
        --[[
          line: 535
          upvalues:
            userFlag2 (copy, index: 1)
            self (copy, index: 2)
            v3 (ref,  index: 3)
            players (copy, index: 4)
        ]]
        if userFlag2 then
            self.enabled = false
        end

        self.activeController:Enable(false)

        if userFlag2 then
            self:UpdateAbilitiesControllers()
        elseif self.touchJumpController then
            self.touchJumpController:Enable(false)
        end

        if self.moveFunction and (not userFlag2 or not v3:isEnabled()) then
            self.moveFunction(players.LocalPlayer, Vector3.new(0, 0, 0), true)
        end
    end

    local v119 = function()
        --[[
          line: 555
          upvalues:
            userFlag2 (copy, index: 1)
            self (copy, index: 2)
            userInputService (copy, index: 3)
            ClickToMoveController (copy, index: 4)
            ClassicThumbstick (copy, index: 5)
            DynamicThumbstick (ref,  index: 6)
            TouchJump (copy, index: 7)
            players (copy, index: 8)
        ]]
        local v120, v121 = false, false

        if userFlag2 then
            self.enabled = true
            self:UpdateAbilitiesControllers()
        elseif self.touchControlFrame then
            if userInputService.PreferredInput ~= Enum.PreferredInput.Touch then
                v121 = true
            elseif self.activeControlModule == ClickToMoveController then
                v120 = true
            elseif self.activeControlModule == ClassicThumbstick then
                v120 = true
            elseif self.activeControlModule ~= DynamicThumbstick then
                v121 = true
            else
                v120 = true
            end
        else
            v121 = true
        end

        if v120 then
            if not self.controllers[TouchJump] then
                self.controllers[TouchJump] = TouchJump.new(self.data)
            end

            self.touchJumpController = self.controllers[TouchJump]
            self.touchJumpController:Enable(true, self.touchControlFrame)
        end

        if v121 and self.touchJumpController then
            self.touchJumpController:Enable(false)
        end

        if self.activeControlModule == ClickToMoveController then
            self.activeController:Enable(true, players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, self.touchJumpController)
            return
        end

        if self.touchControlFrame then
            self.activeController:Enable(true, self.touchControlFrame)
            return
        end

        self.activeController:Enable(true)
    end

    if not self.activeController then
        return
    end

    if not self.controlsEnabled then
        v118()
        return
    end

    if guiService.TouchControlsEnabled
        or userInputService.PreferredInput ~= Enum.PreferredInput.Touch
        or self.activeControlModule ~= ClickToMoveController
            and self.activeControlModule ~= ClassicThumbstick
            and self.activeControlModule ~= DynamicThumbstick
    then
        v119()
        return
    end

    v118()
end

function Class.Enable(self, controlsEnabled)
    --[[
      name: Enable
      line: 628
      upvalues:
        userFlag13 (copy, index: 1)
    ]]
    if userFlag13 then
        warn("ControlModule:Enable() and ControlModule:Disable() are deprecated and will be removed soon; set require(\"@rbx/PlayerModule\").ControlModule.Enabled instead")
        return
    end

    if controlsEnabled == nil then
        controlsEnabled = true
    end

    if self.controlsEnabled == controlsEnabled then
        return
    end

    self.controlsEnabled = controlsEnabled

    if not self.activeController then
        return
    end

    self:UpdateActiveControlModuleEnabled()
end

function Class.Disable(self)
    --[[
      name: Disable
      line: 651
    ]]
    self:Enable(false)
end

function Class.SelectComputerMovementModule(self)
    --[[
      name: SelectComputerMovementModule
      line: 656
      upvalues:
        userFlag7 (copy, index: 1)
        userInputService (copy, index: 2)
        ActionController (copy, index: 3)
        players (copy, index: 4)
        v11 (copy, index: 5)
        ClickToMoveController (copy, index: 6)
        v42 (copy, index: 7)
    ]]
    local v126
    local isMicroGamepad = false

    if userFlag7 then
        pcall(
            function()
                --[[
                  line: 659
                  upvalues:
                    isMicroGamepad (ref,  index: 1)
                    userInputService (copy, index: 2)
                ]]
                isMicroGamepad = userInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
            end
        )
    end

    if userInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse
        and userInputService.PreferredInput ~= Enum.PreferredInput.Gamepad
        and not isMicroGamepad
    then
        return nil, false
    end

    local devComputerMovementMode = players.LocalPlayer.DevComputerMovementMode

    if devComputerMovementMode ~= Enum.DevComputerMovementMode.UserChoice then
        v126 = v42[devComputerMovementMode]

        if not v126 and devComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", devComputerMovementMode)
        end
    else
        v126 = if v11.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then ClickToMoveController else ActionController
    end

    if v126 then
        return v126, true
    end
    if devComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true
    end

    return nil, false
end

function Class.SelectTouchModule(self)
    --[[
      name: SelectTouchModule
      line: 705
      upvalues:
        players (copy, index: 1)
        v42 (copy, index: 2)
        v11 (copy, index: 3)
    ]]
    local v130
    local devTouchMovementMode = players.LocalPlayer.DevTouchMovementMode

    if devTouchMovementMode ~= Enum.DevTouchMovementMode.UserChoice then
        if devTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end

        v130 = v42[devTouchMovementMode]
    else
        v130 = v42[v11.TouchMovementMode]
    end

    return v130, true
end

function Class.calculateRawMoveVector(self, a133, a134)
    --[[
      name: calculateRawMoveVector
      line: 718
      upvalues:
        workspace2 (copy, index: 1)
        vrService (copy, index: 2)
        cameraRotationAction (copy, index: 3)
    ]]
    local camera = workspace2.CurrentCamera
    if not camera then
        return a134
    end

    local v136 = camera.CFrame

    if vrService.VREnabled and a133.RootPart then
        local estimatedVrTorsoFrame = self:GetEstimatedVRTorsoFrame()
        v136 = if (camera.Focus.Position - v136.Position).Magnitude < 3 then v136 * estimatedVrTorsoFrame else camera.CFrame * (estimatedVrTorsoFrame.Rotation + (estimatedVrTorsoFrame.Position * camera.HeadScale))
    end

    local state = a133:GetState()

    if state ~= Enum.HumanoidStateType.Swimming then
        local v139, v140
        local _, _, _, v144, v145, v146, _, _, v149, _, _, v152 = v136:GetComponents()

        if not (v149 < 1) or not (-1 < v149) then
            v139 = -v145 * math.sign(v149)
            v140 = v144
        else
            v140, v139 = v152, v146
        end

        local v153 = math.sqrt((v140 * v140) + (v139 * v139))

        return (Vector3.new((v140 * a134.X + (v139 * a134.Z)) / v153, 0, (v140 * a134.Z - (v139 * a134.X)) / v153))
    end

    if not vrService.VREnabled then
        return v136:VectorToWorldSpace(a134)
    end

    local vector3 = Vector3.new(a134.X, 0, a134.Z)

    if vector3.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0)
    end

    local v155 = 0

    if cameraRotationAction and cameraRotationAction.Enabled then
        v155 = -cameraRotationAction:GetState().Y / 2.31
    end

    local v156 = math.atan2(-vector3.X, -vector3.Z)
    local _, v158 = v136:ToEulerAnglesYXZ()
    local v159 = v156 + v158
    local v160 = CFrame.fromEulerAnglesYXZ(v155, v159, 0)

    return v160.LookVector
end

function Class.initialize(self, data)
    --[[
      name: initialize
      line: 779
      upvalues:
        userFlag12 (copy, index: 1)
        ActionController (copy, index: 2)
        userFlag2 (copy, index: 3)
        v31 (copy, index: 4)
    ]]
    self.data = data
    self:UpdateMovementMode()

    if not userFlag12 then
        ActionController.initializeActions(self.data)
    end

    if userFlag2 then
        v31.setupSlotActions(self.data.engineInterface.player, self.data.isServerAuthority, self.data.eventBus)
    end
end

function Class.Update(self, a164, a165)
    --[[
      name: Update
      line: 792
      upvalues:
        userFlag12 (copy, index: 1)
        userFlag13 (copy, index: 2)
        ActionController (copy, index: 3)
        vrService (copy, index: 4)
    ]]
    assert(a164.engineInterface.player)
    local controlModule = a164.controlModule
    local controlModule2 = a164.playerModule.ControlModule
    local engineInterface = a164.engineInterface

    if userFlag12 then
        local humanoid = engineInterface.humanoid

        if engineInterface.characterChanged then
            self:OnCharacterChanged(humanoid)
        end

        if not userFlag13 then
            if not humanoid then
                return
            end
        end
    else
        assert(engineInterface.character)

        if not userFlag13 then
            if not self.humanoid then
                return
            end
        end
    end

    local enabled = controlModule2.Enabled

    if userFlag13 then
        controlModule.enabled = enabled

        if enabled == self.controlsEnabled then
            if not enabled then
                return
            end
        else
            self.controlsEnabled = enabled
            self:UpdateActiveControlModuleEnabled()
        end
    end

    repeat
        if not enabled then
            controlModule.isJumping = false
            controlModule.moveVector = Vector2.new()
            controlModule.worldMoveVector = Vector3.new()
            ActionController.update(a164)
            self.inputMoveVector = Vector3.new()

            if self.vehicleController then
                self.vehicleController:Update(Vector3.new(), true)
            end

            self:characterMove(a164)

            return
        end

        if userFlag13 and not self.humanoid then
            return
        end

        ActionController.initializeActions(a164)

        if userFlag13 then
            if not controlModule.actions.MoveAction then
                break
            end
            if not controlModule.actions.JumpAction then
                break
            end
        end

        if self.activeController and self.activeController.enabled and self.humanoid then
            ActionController.update(a164)
            local clickToMoveController = self:GetClickToMoveController()
            clickToMoveController:Update(a164, a165)
            local v172 = Vector3.new(controlModule.moveVector.X, 0, -controlModule.moveVector.Y)

            if self.vehicleController then
                local v173
                v172, v173 = self.vehicleController:Update(v172, true)
                _ = v173
            end

            local v174 = self:calculateRawMoveVector(self.humanoid, v172)
            self.inputMoveVector = v174

            if vrService.VREnabled then
                v174 = self:updateVRMoveVector(v174)
            end

            controlModule.worldMoveVector = v174
            self:characterMove(a164)
        end

        return
    until true
end

function Class.characterMove(self, a176)
    --[[
      name: characterMove
      line: 883
      upvalues:
        userFlag13 (copy, index: 1)
        userFlag4 (copy, index: 2)
        userFlag2 (copy, index: 3)
        v3 (ref,  index: 4)
        v30 (copy, index: 5)
        players (copy, index: 6)
        userFlag6 (copy, index: 7)
    ]]
    if userFlag13 and not self.humanoid then
        return
    end

    local controlModule = a176.controlModule

    if userFlag4 then
        if not a176.isServerAuthority then
            if not userFlag2 or not v3:isEnabled() then
                self.moveFunction(players.LocalPlayer, controlModule.worldMoveVector, false)
                self.humanoid.Jump = controlModule.isJumping

                return
            end

            if not userFlag13 then
                v30.writeInputToCS(players.LocalPlayer, self)
            end
        end
    elseif (not userFlag6 or not a176.isServerAuthority) and (not userFlag2 or not v3:isEnabled()) then
        self.moveFunction(players.LocalPlayer, controlModule.worldMoveVector, false)
        self.humanoid.Jump = controlModule.isJumping
    end
end

function Class.updateVRMoveVector(self, a179)
    --[[
      name: updateVRMoveVector
      line: 913
      upvalues:
        userFlag (copy, index: 1)
        v41 (copy, index: 2)
        vrService (copy, index: 3)
    ]]
    local camera = workspace.CurrentCamera
    local displacement = camera.Focus.Position - camera.CFrame.Position
    local v182 = if userFlag then v41.inFirstPerson else displacement.Magnitude < 5

    if a179.Magnitude ~= 0
        or not v182
        or not vrService.AvatarGestures
        or not self.humanoid
        or self.humanoid.Sit
    then
        return a179
    end

    local userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
    local v184 = userCFrame.Rotation + userCFrame.Position * camera.HeadScale
    local y = -0.7 * self.humanoid.RootPart.Size.Y / 2
    local v186 = (camera.CFrame * v184 * CFrame.new(0, y, 0)).Position - self.humanoid.RootPart.CFrame.Position
    local vector3 = Vector3.new(v186.x, 0, v186.z)

    if userFlag then
        local distance = (camera.Focus.Position - camera.CFrame.Position).Magnitude

        if math.max(4 * camera.HeadScale, 1) < distance then
            return a179
        end
    end

    return vector3
end

function Class.OnHumanoidSeated(self, a190, a191)
    --[[
      name: OnHumanoidSeated
      line: 963
    ]]
    if a190 then
        if a191 and a191:IsA("VehicleSeat") then
            if not self.vehicleController then
                self.vehicleController = self.vehicleController.new()
            end

            self.vehicleController:Enable(true, a191)
        end
    elseif self.vehicleController then
        self.vehicleController:Enable(false, a191)
    end
end

if userFlag12 then
    function Class.OnCharacterChanged(self, humanoid)
        --[[
          name: OnCharacterChanged
          line: 979
        ]]
        self.humanoid = humanoid
        self:UpdateMovementMode()

        if not humanoid then
            return
        end

        if self.humanoidSeatedConn then
            self.humanoidSeatedConn:Disconnect()
            self.humanoidSeatedConn = nil
        end

        self.humanoidSeatedConn = humanoid.Seated:Connect(
            function(a194, a195)
                --[[
                  line: 990
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnHumanoidSeated(a194, a195)
            end
        )
    end
else
    function Class.OnCharacterAdded(self, a197)
        --[[
          name: OnCharacterAdded
          line: 995
        ]]
        self.humanoid = a197:FindFirstChildOfClass("Humanoid")

        while not self.humanoid do
            a197.ChildAdded:wait()
            self.humanoid = a197:FindFirstChildOfClass("Humanoid")
        end

        if self.humanoidSeatedConn then
            self.humanoidSeatedConn:Disconnect()
            self.humanoidSeatedConn = nil
        end

        self.humanoidSeatedConn = self.humanoid.Seated:Connect(
            function(a198, a199)
                --[[
                  line: 1006
                  upvalues:
                    self (copy, index: 1)
                ]]
                self:OnHumanoidSeated(a198, a199)
            end
        )
        self:UpdateMovementMode()
    end

    function Class.OnCharacterRemoving(self, a201)
        --[[
          name: OnCharacterRemoving
          line: 1013
        ]]
        self.humanoid = nil
        self:UpdateMovementMode()
    end
end

function Class.UpdateTouchGuiVisibility(self)
    --[[
      name: UpdateTouchGuiVisibility
      line: 1020
      upvalues:
        guiService (copy, index: 1)
        userInputService (copy, index: 2)
    ]]
    local isTouch = self.humanoid
        and guiService.TouchControlsEnabled
        and userInputService.PreferredInput == Enum.PreferredInput.Touch

    if isTouch and not self.touchGui then
        self:CreateTouchGuiContainer()
    end

    if self.touchGui then
        self.touchGui.Enabled = not not isTouch
    end
end

function Class.SwitchToController(self, activeControlModule)
    --[[
      name: SwitchToController
      line: 1041
    ]]
    if not activeControlModule then
        if self.activeController then
            self.activeController:Enable(false)
        end

        self.activeController = nil
        self.activeControlModule = nil

        return
    end

    if not self.controllers[activeControlModule] then
        self.controllers[activeControlModule] = activeControlModule.new(self.data)
    end

    if self.activeController ~= self.controllers[activeControlModule] then
        if self.activeController then
            self.activeController:Enable(false)
        end

        self.activeController = self.controllers[activeControlModule]
        self.activeControlModule = activeControlModule
        self:UpdateActiveControlModuleEnabled()
    end
end

function Class.UpdateMovementMode(self)
    --[[
      name: UpdateMovementMode
      line: 1081
      upvalues:
        userInputService (copy, index: 1)
    ]]
    self:UpdateTouchGuiVisibility()

    if userInputService.PreferredInput ~= Enum.PreferredInput.Touch then
        self:SwitchToController((self:SelectComputerMovementModule()))
    else
        local v207, v208 = self:SelectTouchModule()

        if v208 and self.touchControlFrame then
            self:SwitchToController(v207)
        end
    end
end

function Class.CreateTouchGuiContainer(self)
    --[[
      name: CreateTouchGuiContainer
      line: 1097
      upvalues:
        userFlag2 (copy, index: 1)
        userFlag9 (copy, index: 2)
    ]]
    if not self.playerGui then
        return
    end

    if self.touchGui then
        self.touchGui:Destroy()
    end

    self.touchGui = Instance.new("ScreenGui")
    self.touchGui.Name = "TouchGui"
    self.touchGui.ResetOnSpawn = false
    self.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    if userFlag2 and userFlag9 then
        self.touchGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    end

    self.touchGui.ClipToDeviceSafeArea = false
    self.touchControlFrame = Instance.new("Frame")
    self.touchControlFrame.Name = "TouchControlFrame"
    self.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    self.touchControlFrame.BackgroundTransparency = 1
    self.touchControlFrame.Parent = self.touchGui
    self.touchGui.Parent = self.playerGui
end

function Class.CreateAbilitiesGuiContainer(self)
    --[[
      name: CreateAbilitiesGuiContainer
      line: 1128
    ]]
    if not self.playerGui then
        return
    end

    if self.abilitiesGui then
        self.abilitiesGui:Destroy()
    end

    self.abilitiesGui = Instance.new("ScreenGui")
    self.abilitiesGui.Name = "AbilitiesGui"
    self.abilitiesGui.ResetOnSpawn = false
    self.abilitiesGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.abilitiesGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    self.abilitiesGui.ClipToDeviceSafeArea = false
    self.abilitiesFrame = Instance.new("Frame")
    self.abilitiesFrame.Name = "AbilitiesFrame"
    self.abilitiesFrame.Size = UDim2.new(1, 0, 1, 0)
    self.abilitiesFrame.BackgroundTransparency = 1
    self.abilitiesFrame.Parent = self.abilitiesGui
    self.abilitiesGui.Parent = self.playerGui
end

function Class.GetClickToMoveController(self)
    --[[
      name: GetClickToMoveController
      line: 1153
      upvalues:
        ClickToMoveController (copy, index: 1)
    ]]
    if not self.controllers[ClickToMoveController] then
        self.controllers[ClickToMoveController] = ClickToMoveController.new()
    end

    return self.controllers[ClickToMoveController]
end

function Class.ProcessInputs(self, a213, a214)
    --[[
      name: ProcessInputs
      line: 1160
      upvalues:
        userFlag2 (copy, index: 1)
        AvatarAbilitiesInterface (ref,  index: 2)
        userFlag4 (copy, index: 3)
        v30 (copy, index: 4)
    ]]
    if userFlag2 then
        local v215 = AvatarAbilitiesInterface.get(a213)

        if not v215:isEnabled() then
            if userFlag4 then
                v30.processPCSInputs(a213)
                return
            end

            v30.SendInputToHumanoidForServerAuth(a213)
        end
    else
        if userFlag4 then
            v30.processPCSInputs(a213)
            return
        end

        local character = a213.Character
        if character == nil then
            return
        end

        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid == nil then
            return
        end

        local inputContexts = a213:FindFirstChild("InputContexts")
        if inputContexts == nil then
            return
        end

        local characterContext = inputContexts:FindFirstChild("CharacterContext")
        if characterContext == nil then
            return
        end

        local moveAction = characterContext.MoveAction
        local rotationAction = characterContext.RotationAction
        local jumpAction = characterContext.JumpAction

        local function isValidInput2D(a224)
            --[[
              name: isValidInput2D
              line: 1196
            ]]
            return not (a224.X ~= a224.X
                or a224.Y ~= a224.Y
                or a224.X == math.huge
                or (a224.Y == math.huge))
        end

        local function isValidInput3D(a226)
            --[[
              name: isValidInput3D
              line: 1205
            ]]
            return not (a226.X ~= a226.X
                or a226.Y ~= a226.Y
                or a226.Z ~= a226.Z
                or a226.X == math.huge
                or a226.Y == math.huge
                or (a226.Z == math.huge))
        end

        local v227 = if moveAction ~= nil then moveAction:GetState() else Vector2.new(0, 0)
        local v228 = a213:GetCameraState().CFrame.LookVector

        if v227.X == v227.X
            and v227.Y == v227.Y
            and v227.X ~= math.huge
            and v227.Y ~= math.huge
            and v228.X == v228.X
            and v228.Y == v228.Y
            and v228.Z == v228.Z
            and v228.X ~= math.huge
            and v228.Y ~= math.huge
            and v228.Z ~= math.huge
            and 0 < v228.Magnitude
        then
            local state = humanoid:GetState()

            if state ~= Enum.HumanoidStateType.Swimming then
                v228 = Vector3.new(v228.X, 0, v228.Z).Unit
            end

            local unit = v228:Cross(Vector3.new(0, 1, 0)).Unit
            humanoid:Move(v228 * v227.Y + (unit * v227.X))

            if rotationAction:GetState() then
                humanoid.AutoRotate = false

                if humanoid.SeatPart == nil
                    and humanoid.RootPart ~= nil
                    and not humanoid.Sit
                    and not humanoid.RootPart:IsGrounded()
                then
                    humanoid.RootPart.CFrame = CFrame.new(humanoid.RootPart.CFrame.Position, humanoid.RootPart.CFrame.Position + v228)
                end
            else
                humanoid.AutoRotate = true
            end
        end

        humanoid.Jump = if jumpAction ~= nil then jumpAction:GetState() else false
    end
end

if runService:IsClient() then
    local newClass = Class.new
    return newClass()
end

return Class