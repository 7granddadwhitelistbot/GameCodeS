local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u1 = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local u2 = v1.getUserFlag("UserControlModuleEnabledAPI")
local StarterPlayer_upv_1 = game:GetService("StarterPlayer")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local Workspace_upv_1 = game:GetService("Workspace")
local AvatarAbilitiesInterface_upv_1 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local u3 = v1.getUserFlag("UserAbilitiesUserInterfaceB")
local u4 = (u3 and "ControlState") or "PlayerControlState"
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1._calculatePlayerInputValues(a1)
    --[[
      name: _calculatePlayerInputValues
      line: 15
    ]]
    local v2 = a1.Character
    if v2 == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end
    local Humanoid_1 = v2:FindFirstChild("Humanoid")
    if Humanoid_1 == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end
    v2 = a1:FindFirstChild("InputContexts")
    if v2 == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end
    local CharacterContext_1 = v2:FindFirstChild("CharacterContext")
    if CharacterContext_1 == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end
    v2 = CharacterContext_1.MoveAction
    local RotationAction_1 = CharacterContext_1:FindFirstChild("RotationAction")
    CharacterContext_1 = (RotationAction_1 ~= nil) and (RotationAction_1:GetState())
    local function isValidInput2D(a2)
        --[[
          name: isValidInput2D
          line: 36
        ]]
        local v3 = true
        local v4
        if a2.X ~= a2.X then
            v4 = v3
        else
            v4 = true
            if a2.Y == a2.Y then
                v4 = true
                if a2.X ~= math.huge then
                    v4 = a2.Y == math.huge
                end
            end
        end
        return not v4
    end
    local function isValidInput3D(a3)
        --[[
          name: isValidInput3D
          line: 44
        ]]
        local v5 = true
        local v6
        if a3.X ~= a3.X then
            v6 = v5
        else
            v6 = true
            if a3.Y == a3.Y then
                v6 = true
                if a3.Z == a3.Z then
                    v6 = true
                    if a3.X ~= math.huge then
                        v6 = true
                        if a3.Y ~= math.huge then
                            v6 = a3.Z == math.huge
                        end
                    end
                end
            end
        end
        return not v6
    end
    local v7
    if v2 == nil then
        v7 = Vector2.new(0, 0)
    else
        v7 = v2:GetState()
    end
    v2 = a1:GetCameraState().CFrame.LookVector
    local v8 = true
    local v9
    if v7.X ~= v7.X then
        v9 = v8
    else
        v9 = true
        if v7.Y == v7.Y then
            v9 = true
            if v7.X ~= math.huge then
                v9 = v7.Y == math.huge
            end
        end
    end
    if not (v9) then
        local v10 = true
        local v11
        if v2.X ~= v2.X then
            v11 = v10
        else
            v11 = true
            if v2.Y == v2.Y then
                v11 = true
                if v2.Z == v2.Z then
                    v11 = true
                    if v2.X ~= math.huge then
                        v11 = true
                        if v2.Y ~= math.huge then
                            v11 = v2.Z == math.huge
                        end
                    end
                end
            end
        end
        if not (v11) and v2.Magnitude > 0 then
            if Humanoid_1 and Humanoid_1:GetState() ~= Enum.HumanoidStateType.Swimming then
                v2 = Vector3.new(v2.X, 0, v2.Z).Unit
            end
            return (v2 * v7.Y) + (v2:Cross(Vector3.new(0, 1, 0)).Unit * v7.X), v2, CharacterContext_1
        end
    end
    return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
end
function tbl_upv_1.CloneInputsIfAbsent(a1)
    --[[
      name: CloneInputsIfAbsent
      line: 74
      upvalues:
        StarterPlayer_upv_1 (copy, index: 1)
    ]]
    if a1:FindFirstChild("InputContexts") then
        return
    end
    local v12 = StarterPlayer_upv_1.PlayerModule.InputContexts:Clone()
    v12.CharacterContext.Enabled = true
    v12.CameraContext.Enabled = true
    v12.Parent = a1
end
function tbl_upv_1.FireCustomInputs(a1)
    --[[
      name: FireCustomInputs
      line: 83
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
    ]]
    local InputContexts_1 = a1:FindFirstChild("InputContexts")
    if not InputContexts_1 then
        return
    end
    local CharacterContext_2 = InputContexts_1:FindFirstChild("CharacterContext")
    if not CharacterContext_2 or not InputContexts_1:FindFirstChild("CameraContext") then
        return
    end
    local RotationAction_2 = CharacterContext_2:FindFirstChild("RotationAction")
    if RotationAction_2 then
        local RotationScriptableBinding_1 = RotationAction_2:FindFirstChild("RotationScriptableBinding")
        if RotationScriptableBinding_1 then
            RotationScriptableBinding_1:Fire(UserGameSettings_upv_1.RotationType == Enum.RotationType.CameraRelative)
        end
    end
end
function tbl_upv_1.SendInputToCCLCharacter(a1)
    --[[
      name: SendInputToCCLCharacter
      line: 102
      upvalues:
        AvatarAbilitiesInterface_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not a1 then
        return
    end
    local v13 = AvatarAbilitiesInterface_upv_1.get(a1)
    local InputContexts_2 = a1:FindFirstChild("InputContexts")
    if not InputContexts_2 then
        return
    end
    local CharacterContext_3 = InputContexts_2:FindFirstChild("CharacterContext")
    if CharacterContext_3 then
        for _, value_1 in v13:GetAbilities() do
            local v14 = CharacterContext_3:FindFirstChild(value_1 .. "Action")
            if v14 then
                v13:SendInput(value_1, v14:GetState())
            end
        end
        local v15, v16, v17 = tbl_upv_1._calculatePlayerInputValues(a1)
        v13:SendInput("Move", v15)
        v13:SendInput("CameraLookDirection", v16)
        v13:SendInput("CameraRelativeRotation", v17)
    end
end
function tbl_upv_1.SendInputToHumanoidForServerAuth(a1)
    --[[
      name: SendInputToHumanoidForServerAuth
      line: 123
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local Character_1 = a1.Character
    if Character_1 == nil then
        return
    end
    local Humanoid_2 = Character_1:FindFirstChild("Humanoid")
    if Humanoid_2 == nil then
        return
    end
    local InputContexts_3 = a1:FindFirstChild("InputContexts")
    if InputContexts_3 == nil then
        return
    end
    local CharacterContext_4 = InputContexts_3:FindFirstChild("CharacterContext")
    if CharacterContext_4 == nil then
        return
    end
    local JumpAction_1 = CharacterContext_4.JumpAction
    local v18, v19, v20 = tbl_upv_1._calculatePlayerInputValues(a1)
    Humanoid_2:Move(v18)
    Humanoid_2.AutoRotate = not v20
    if v20 and Humanoid_2.SeatPart == nil and Humanoid_2.RootPart ~= nil and not (Humanoid_2.Sit) and not (Humanoid_2.RootPart:IsGrounded()) then
        Humanoid_2.RootPart.CFrame = CFrame.new(Humanoid_2.RootPart.CFrame.Position, Humanoid_2.RootPart.CFrame.Position + v19)
    end
    if JumpAction_1 == nil then
        v20 = false
    else
        v20 = JumpAction_1:GetState()
    end
    Humanoid_2.Jump = v20
end
function tbl_upv_1.setupPlayerControlState(a1)
    --[[
      name: setupPlayerControlState
      line: 152
    ]]
    a1:AddVector3Field("Move", Vector3.new(0, 0, 0), 1)
    a1:AddBoolField("Jump", false)
    a1:AddBoolField("RotateToLookDirection", false)
    a1:AddUnitVector3Field("LookDirection", Vector3.new(0, 0, 1))
end
function tbl_upv_1.watchForPlayerControlState(a1)
    --[[
      name: watchForPlayerControlState
      line: 160
      upvalues:
        tbl_upv_1 (copy, index: 2)
    ]]
    local function watchCharacter(a2)
        --[[
          name: watchCharacter
          line: 161
          upvalues:
            tbl_upv_1 (copy, index: 2)
        ]]
        local v21 = function() end
        local v22 = a2:FindFirstChildOfClass(u4)
        if v22 then
            tbl_upv_1.setupPlayerControlState(v22)
        end
        a2.ChildAdded:Connect(v21)
    end
    local v23 = nil
    if a1.Character then
        local Character_2 = a1.Character
        v23 = Character_2:FindFirstChildOfClass(watchCharacter)
        if v23 then
            tbl_upv_1.setupPlayerControlState(v23)
        end
        local function onPCSAdded(a3)
            --[[
              name: onPCSAdded
              line: 162
              upvalues:
                tbl_upv_1 (copy, index: 2)
            ]]
            if not a3:IsA(u4) then
                return
            end
            tbl_upv_1.setupPlayerControlState(a3)
        end
        Character_2.ChildAdded:Connect(onPCSAdded)
    end
    a1.CharacterAdded:Connect(watchCharacter)
end
function tbl_upv_1.createPlayerControlState(a1)
    --[[
      name: createPlayerControlState
      line: 176
      upvalues:
        u3 (copy, index: 1)
        u4 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local function createForCharacter(a2)
        --[[
          name: createForCharacter
          line: 177
          upvalues:
            u3 (copy, index: 1)
            a1 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
        ]]
        if u3 then
            if a2:FindFirstChildOfClass(u4) then
                return
            end
        elseif a2:FindFirstChild(u4) then
            return
        end
        local v24 = Instance.new(u4)
        v24.Owner = a1
        v24.Parent = a2
        tbl_upv_1.setupPlayerControlState(v24)
    end
    if a1.Character then
        local Character_3 = a1.Character
        if u3 then
            local v25 = Character_3:FindFirstChildOfClass(createForCharacter)
            if not (v25) then
                local v26 = Instance.new(createForCharacter)
                v26.Owner = a1
                v26.Parent = Character_3
                tbl_upv_1.setupPlayerControlState(v26)
            end
        else
            local v27 = Character_3:FindFirstChild(createForCharacter)
            if not (v27) then
                local v26 = Instance.new(u4)
                v26.Owner = a1
                v26.Parent = Character_3
                tbl_upv_1.setupPlayerControlState(v26)
            end
        end
    end
    a1.CharacterAdded:Connect(createForCharacter)
end
function tbl_upv_1.writeInputToPCS(a1, a2, a3)
    --[[
      name: writeInputToPCS
      line: 193
      upvalues:
        u2 (copy, index: 1)
        u3 (copy, index: 2)
        u4 (copy, index: 3)
        UserGameSettings_upv_1 (copy, index: 4)
        Workspace_upv_1 (copy, index: 5)
        u1 (copy, index: 6)
        AvatarAbilitiesInterface_upv_1 (copy, index: 7)
    ]]
    local v28 = nil
    local _ = (not u2) or (a2.playerData)
    local Character_4 = a1.Character
    if not Character_4 then
        return
    end
    local v29
    if u3 then
        v29 = Character_4:FindFirstChildOfClass(u4)
    else
        v29 = Character_4:FindFirstChild(u4)
    end
    if not v29 then
        return
    end
    local humanoid_1 = a2.humanoid
    if not humanoid_1 then
        return
    end
    local v30
    if a3 then
        v30 = a1:FindFirstChild("InputContexts")
    else
        v30 = script.Parent.Parent:FindFirstChild("InputContexts")
    end
    local v31, v32
    if u2 then
        v32 = v28.isJumping
        v31 = v28.worldMoveVector
    else
        local v33 = v30 and v30:FindFirstChild("CharacterContext")
        if not v33 then
            return
        end
        local MoveAction_1 = v33:FindFirstChild("MoveAction")
        local JumpAction_2 = v33:FindFirstChild("JumpAction")
        if MoveAction_1 then
            v33 = MoveAction_1:GetState()
        else
            v33 = Vector2.zero
        end
        if JumpAction_2 then
            v32 = JumpAction_2:GetState()
        else
            v32 = false
        end
        v31 = a2:calculateRawMoveVector(humanoid_1, Vector3.new(v33.X, 0, -v33.Y))
    end
    v30 = UserGameSettings_upv_1.RotationType == Enum.RotationType.CameraRelative
    local v34 = ((Workspace_upv_1.CurrentCamera) and (Workspace_upv_1.CurrentCamera.CFrame.LookVector)) or Vector3.new(0, 0, 1)
    local v35 = Vector3.new(v34.X, 0, v34.Z)
    local v36 = ((not (v35.Magnitude > 0.001)) and Vector3.new(0, 0, 1)) or (v35.Unit)
    local tbl_2 = {}
    tbl_2.Move = v31
    tbl_2.RotateToLookDirection = v30
    tbl_2.LookDirection = v36
    if not (u1) or not (AvatarAbilitiesInterface_upv_1.get(a1):isEnabled()) then
        tbl_2.Jump = v32
    end
    v29:UpdateFields(tbl_2)
end
function tbl_upv_1.processPCSInputs(a1)
    --[[
      name: processPCSInputs
      line: 247
      upvalues:
        u3 (copy, index: 1)
        u4 (copy, index: 2)
    ]]
    local Character_5 = a1.Character
    if Character_5 == nil then
        return
    end
    local Humanoid_3 = Character_5:FindFirstChild("Humanoid")
    if Humanoid_3 == nil then
        return
    end
    local v37
    if u3 then
        v37 = Character_5:FindFirstChildOfClass(u4)
    else
        v37 = Character_5:FindFirstChild(u4)
    end
    if v37 == nil then
        return
    end
    local v38 = v37:GetState()
    local Move_1 = v38.Move
    local Jump_1 = v38.Jump
    local RotateToLookDirection_1 = v38.RotateToLookDirection
    local LookDirection_1 = v38.LookDirection
    if Move_1 then
        Humanoid_3:Move(Move_1)
    end
    Humanoid_3.AutoRotate = not RotateToLookDirection_1
    if RotateToLookDirection_1 and LookDirection_1 ~= nil and Humanoid_3.RootPart ~= nil and not (Humanoid_3.Sit) and Humanoid_3.SeatPart == nil and not (Humanoid_3.RootPart:IsGrounded()) then
        Humanoid_3.RootPart.CFrame = CFrame.new(Humanoid_3.RootPart.CFrame.Position, Humanoid_3.RootPart.CFrame.Position + LookDirection_1)
    end
    Humanoid_3.Jump = Jump_1 or false
end
return tbl_upv_1