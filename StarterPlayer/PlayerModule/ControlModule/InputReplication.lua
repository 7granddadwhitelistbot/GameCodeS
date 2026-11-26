local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("FlagUtil")
local userFlag = v2.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v2.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v2.getUserFlag("UserControlModuleDisabledUpdate")
local starterPlayer = game:GetService("StarterPlayer")
local v6 = UserSettings():GetService("UserGameSettings")
local workspace = game:GetService("Workspace")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local userFlag3 = v2.getUserFlag("UserAbilitiesUserInterfaceB")
local v10 = userFlag3 and "ControlState" or "PlayerControlState"
local Class = {}
Class.__index = Class

function Class._calculatePlayerInputValues(a12)
    --[[
      name: _calculatePlayerInputValues
      line: 16
    ]]
    local character = a12.Character
    if character == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local inputContexts = a12:FindFirstChild("InputContexts")
    if inputContexts == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local characterContext = inputContexts:FindFirstChild("CharacterContext")
    if characterContext == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local moveAction = characterContext.MoveAction
    local rotationAction = characterContext:FindFirstChild("RotationAction")
    local state = rotationAction ~= nil and rotationAction:GetState()

    local function isValidInput2D(a21)
        --[[
          name: isValidInput2D
          line: 37
        ]]
        return not (a21.X ~= a21.X or a21.Y ~= a21.Y or a21.X == math.huge or (a21.Y == math.huge))
    end

    local function isValidInput3D(a23)
        --[[
          name: isValidInput3D
          line: 46
        ]]
        return not (a23.X ~= a23.X
            or a23.Y ~= a23.Y
            or a23.Z ~= a23.Z
            or a23.X == math.huge
            or a23.Y == math.huge
            or (a23.Z == math.huge))
    end

    local v24 = if moveAction ~= nil then moveAction:GetState() else Vector2.new(0, 0)
    local v25 = a12:GetCameraState().CFrame.LookVector
    local v26 = false

    if v24.X == v24.X and v24.Y == v24.Y and v24.X ~= math.huge and v24.Y ~= math.huge then
        if v25.X == v25.X
            and v25.Y == v25.Y
            and v25.Z == v25.Z
            and v25.X ~= math.huge
            and v25.Y ~= math.huge
            and v25.Z ~= math.huge
            and 0 < v25.Magnitude
        then
            if humanoid then
                local state2 = humanoid:GetState()

                if state2 ~= Enum.HumanoidStateType.Swimming then
                    v25 = Vector3.new(v25.X, 0, v25.Z).Unit
                end
            end
        else
            v26 = true
        end
    else
        v26 = true
    end

    if v26 then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local unit = v25:Cross(Vector3.new(0, 1, 0)).Unit

    return (v25 * v24.Y) + (unit * v24.X), v25, state
end

function Class.CloneInputsIfAbsent(parent: Instance?)
    --[[
      name: CloneInputsIfAbsent
      line: 77
      upvalues:
        starterPlayer (copy, index: 1)
    ]]
    if parent:FindFirstChild("InputContexts") then
        return
    end

    local inputContexts = starterPlayer.PlayerModule.InputContexts:Clone()
    inputContexts.CharacterContext.Enabled = true
    inputContexts.CameraContext.Enabled = true
    inputContexts.Parent = parent
end

function Class.FireCustomInputs(a31)
    --[[
      name: FireCustomInputs
      line: 88
      upvalues:
        v6 (copy, index: 1)
    ]]
    local inputContexts = a31:FindFirstChild("InputContexts")
    if not inputContexts then
        return
    end

    local characterContext = inputContexts:FindFirstChild("CharacterContext")
    if not characterContext then
        return
    end
    if not inputContexts:FindFirstChild("CameraContext") then
        return
    elseif const rotationAction = characterContext:FindFirstChild("RotationAction") then
        if const rotationScriptableBinding = rotationAction:FindFirstChild("RotationScriptableBinding") then
            rotationScriptableBinding:Fire(v6.RotationType == Enum.RotationType.CameraRelative)
        end
    end
end

function Class.SendInputToCCLCharacter(a36)
    --[[
      name: SendInputToCCLCharacter
      line: 113
      upvalues:
        AvatarAbilitiesInterface (copy, index: 1)
        Class (copy, index: 2)
    ]]
    local v37

    if not a36 then
        return
    end

    local v38 = AvatarAbilitiesInterface.get(a36)
    local inputContexts = a36:FindFirstChild("InputContexts")
    if not inputContexts then
        return
    end

    local characterContext = inputContexts:FindFirstChild("CharacterContext")
    if not characterContext then
        return
    end

    for _, ability in v38:GetAbilities() do
        if const v43 = characterContext:FindFirstChild(ability .. "Action") then
            v38:SendInput(ability, v43:GetState())
        end
    end

    local v44, v45
    v44, v45, v37 = Class._calculatePlayerInputValues(a36)
    v38:SendInput("Move", v44)
    v38:SendInput("CameraLookDirection", v45)
    v38:SendInput("CameraRelativeRotation", v37)
end

function Class.SendInputToHumanoidForServerAuth(a46)
    --[[
      name: SendInputToHumanoidForServerAuth
      line: 140
      upvalues:
        Class (copy, index: 1)
    ]]
    local character = a46.Character
    if character == nil then
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid == nil then
        return
    end

    local inputContexts = a46:FindFirstChild("InputContexts")
    if inputContexts == nil then
        return
    end

    local characterContext = inputContexts:FindFirstChild("CharacterContext")
    if characterContext == nil then
        return
    end

    local jumpAction = characterContext.JumpAction
    local v52, v53, v54 = Class._calculatePlayerInputValues(a46)
    humanoid:Move(v52)
    humanoid.AutoRotate = not v54

    if v54
        and humanoid.SeatPart == nil
        and humanoid.RootPart ~= nil
        and not humanoid.Sit
        and not humanoid.RootPart:IsGrounded()
    then
        humanoid.RootPart.CFrame = CFrame.new(humanoid.RootPart.CFrame.Position, humanoid.RootPart.CFrame.Position + v53)
    end

    humanoid.Jump = if jumpAction ~= nil then jumpAction:GetState() else false
end

function Class.setupPlayerControlState(a55)
    --[[
      name: setupPlayerControlState
      line: 180
    ]]
    a55:AddVector3Field("Move", Vector3.new(0, 0, 0), 1)
    a55:AddBoolField("Jump", false)
    a55:AddBoolField("RotateToLookDirection", false)
    a55:AddUnitVector3Field("LookDirection", Vector3.new(0, 0, 1))
end

function Class.watchForPlayerControlState(a56)
    --[[
      name: watchForPlayerControlState
      line: 188
      upvalues:
        v10 (copy, index: 1)
        Class (copy, index: 2)
    ]]
    if a56.Character then
        local character = a56.Character

        if const v58 = character:FindFirstChildOfClass(v10) then
            Class.setupPlayerControlState(v58)
        end

        character.ChildAdded:Connect(
            function(a59)
                --[[
                  name: onPCSAdded
                  line: 190
                  upvalues:
                    v10 (copy, index: 1)
                    Class (copy, index: 2)
                ]]
                if a59:IsA(v10) then
                    Class.setupPlayerControlState(a59)
                end
            end
        )
    end

    a56.CharacterAdded:Connect(
        function(a60)
            --[[
              name: watchCharacter
              line: 189
              upvalues:
                v10 (copy, index: 1)
                Class (copy, index: 2)
            ]]
            if const v61 = a60:FindFirstChildOfClass(v10) then
                Class.setupPlayerControlState(v61)
            end

            a60.ChildAdded:Connect(
                function(a62)
                    --[[
                      name: onPCSAdded
                      line: 190
                      upvalues:
                        v10 (copy, index: 1)
                        Class (copy, index: 2)
                    ]]
                    if a62:IsA(v10) then
                        Class.setupPlayerControlState(a62)
                    end
                end
            )
        end
    )
end

function Class.createPlayerControlState(owner: Player?)
    --[[
      name: createPlayerControlState
      line: 208
      upvalues:
        userFlag3 (copy, index: 1)
        v10 (copy, index: 2)
        Class (copy, index: 3)
    ]]
    local character
    local createForCharacter2
    local v66 = false

    local function createForCharacter(parent: Instance?)
        --[[
          name: createForCharacter
          line: 209
          upvalues:
            userFlag3 (copy, index: 1)
            v10 (copy, index: 2)
            owner (copy, index: 3)
            Class (copy, index: 4)
        ]]
        if userFlag3 then
            if parent:FindFirstChildOfClass(v10) then
                return
            end
        elseif parent:FindFirstChild(v10) then
            return
        end

        local instance = Instance.new(v10)
        instance.Owner = owner
        instance.Parent = parent
        Class.setupPlayerControlState(instance)
    end

    if owner.Character then
        character = owner.Character

        if userFlag3 then
            if character:FindFirstChildOfClass(v10) then
                createForCharacter2 = createForCharacter
            else
                createForCharacter2 = createForCharacter
                v66 = true
            end
        elseif character:FindFirstChild(v10) then
            createForCharacter2 = createForCharacter
        else
            createForCharacter2 = createForCharacter
            v66 = true
        end
    else
        createForCharacter2 = createForCharacter
    end

    if v66 then
        local instance = Instance.new(v10)
        instance.Owner = owner
        instance.Parent = character
        Class.setupPlayerControlState(instance)
    end

    owner.CharacterAdded:Connect(createForCharacter2)
end

function Class.writeInputToCS(a71, a72)
    --[[
      name: writeInputToCS
      line: 231
      upvalues:
        userFlag2 (copy, index: 1)
        userFlag3 (copy, index: 2)
        v10 (copy, index: 3)
        v6 (copy, index: 4)
        workspace (copy, index: 5)
        userFlag (copy, index: 6)
        AvatarAbilitiesInterface (copy, index: 7)
    ]]
    assert(not userFlag2)
    local data = a72.data
    local character = a71.Character
    if not character then
        return
    end

    local vector3
    local v76 = if userFlag3 then character:FindFirstChildOfClass(v10) else character:FindFirstChild(v10)
    if not v76 then
        return
    end
    if not a72.humanoid then
        return
    end

    local isJumping = data.controlModule.isJumping
    local worldMoveVector = data.controlModule.worldMoveVector
    local rotateToLookDirection = v6.RotationType == Enum.RotationType.CameraRelative
    local v80 = workspace.CurrentCamera and workspace.CurrentCamera.CFrame.LookVector
        or Vector3.new(0, 0, 1)
    local vector32 = Vector3.new(v80.X, 0, v80.Z)

    if not (0.001 < vector32.Magnitude) then
        vector3 = Vector3.new(0, 0, 1)
    else
        vector3 = vector32.Unit
    end

    local v82 = {Move = worldMoveVector, RotateToLookDirection = rotateToLookDirection, LookDirection = vector3}

    if not userFlag or not AvatarAbilitiesInterface.get(a71):isEnabled() then
        v82.Jump = isJumping
    end

    v76:UpdateFields(v82)
end

function Class.processPCSInputs(a83)
    --[[
      name: processPCSInputs
      line: 271
      upvalues:
        userFlag3 (copy, index: 1)
        v10 (copy, index: 2)
    ]]
    local character = a83.Character
    if character == nil then
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid == nil then
        return
    end

    local v86 = if userFlag3 then character:FindFirstChildOfClass(v10) else character:FindFirstChild(v10)
    if v86 == nil then
        return
    end

    local state = v86:GetState()
    local move = state.Move
    local jump = state.Jump
    local rotateToLookDirection = state.RotateToLookDirection
    local lookDirection = state.LookDirection

    if move then
        humanoid:Move(move)
    end

    humanoid.AutoRotate = not rotateToLookDirection

    if rotateToLookDirection
        and lookDirection ~= nil
        and humanoid.RootPart ~= nil
        and not humanoid.Sit
        and humanoid.SeatPart == nil
        and not humanoid.RootPart:IsGrounded()
    then
        humanoid.RootPart.CFrame = CFrame.new(humanoid.RootPart.CFrame.Position, humanoid.RootPart.CFrame.Position + lookDirection)
    end

    humanoid.Jump = jump or false
end

return Class