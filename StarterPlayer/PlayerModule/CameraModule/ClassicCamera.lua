local u1 = 0
local u2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local u3 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserFixCameraFPError")
local Players_upv_1 = game:GetService("Players")
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local BaseCamera_upv_1 = require(script.Parent:WaitForChild("BaseCamera"))
local u4 = setmetatable({}, BaseCamera_upv_1)
u4.__index = u4
function u4.new()
    --[[
      name: new
      line: 35
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        u4 (copy, index: 2)
        CameraUtils_upv_1 (copy, index: 3)
    ]]
    local v1 = setmetatable(BaseCamera_upv_1.new(), u4)
    v1.isFollowCamera = false
    v1.isCameraToggle = false
    v1.lastUpdate = tick()
    v1.cameraToggleSpring = CameraUtils_upv_1.Spring.new(5, 0)
    return v1
end
function u4.GetCameraToggleOffset(a1, a2)
    --[[
      name: GetCameraToggleOffset
      line: 46
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        CameraUtils_upv_1 (copy, index: 2)
    ]]
    if not a1.isCameraToggle then
        return (Vector3.new())
    end
    local currentSubjectDistance_1 = a1.currentSubjectDistance
    if CameraInput_upv_1.getTogglePan() then
        a1.cameraToggleSpring.goal = math.clamp(CameraUtils_upv_1.map(currentSubjectDistance_1, 0.5, a1.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1)
    else
        a1.cameraToggleSpring.goal = 0
    end
    local v2 = math.clamp(CameraUtils_upv_1.map(currentSubjectDistance_1, 0.5, 64, 0, 1), 0, 1) + 1
    return (Vector3.new(0, a1.cameraToggleSpring:step(a2) * v2, 0))
end
function u4.SetCameraMovementMode(a1, a2)
    --[[
      name: SetCameraMovementMode
      line: 64
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
    ]]
    BaseCamera_upv_1.SetCameraMovementMode(a1, a2)
    a1.isFollowCamera = a2 == Enum.ComputerCameraMovementMode.Follow
    a1.isCameraToggle = a2 == Enum.ComputerCameraMovementMode.CameraToggle
end
function u4.Update(a1, a2)
    --[[
      name: Update
      line: 71
      upvalues:
        u2 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        CameraInput_upv_1 (copy, index: 3)
        u1 (ref,  index: 4)
        CameraUtils_upv_1 (copy, index: 5)
        u3 (copy, index: 6)
    ]]
    local time_1 = tick()
    local CurrentCamera_1 = workspace.CurrentCamera
    local v3 = CurrentCamera_1.CFrame
    local v4 = CurrentCamera_1.Focus
    local lookVector_1 = nil
    local v5 = nil
    if a1.resetCameraAngle then
        v5 = a1:GetHumanoidRootPart()
        if v5 then
            lookVector_1 = (v5.CFrame * u2).lookVector
        else
            lookVector_1 = u2.lookVector
        end
        a1.resetCameraAngle = false
    end
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local v6 = a1:GetHumanoid()
    local CameraSubject_1 = CurrentCamera_1.CameraSubject
    local _ = CameraSubject_1 and (CameraSubject_1:IsA("VehicleSeat"))
    local v31 = CameraSubject_1 and (CameraSubject_1:IsA("SkateboardPlatform"))
    local v7 = v6 and (v6:GetState() == Enum.HumanoidStateType.Climbing)
    if a1.lastUpdate == nil or a2 > 1 then
        a1.lastCameraTransform = nil
    end
    local v8 = CameraInput_upv_1.getRotation(a2)
    a1:StepZoom(a2)
    local v9 = a1:GetCameraHeight()
    if v8 ~= Vector2.new() then
        u1 = 0
        a1.lastUserPanCamera = tick()
    end
    local v10 = time_1 - a1.lastUserPanCamera < 2
    local v11 = a1:GetSubjectPosition()
    if v11 and LocalPlayer_1 and CurrentCamera_1 then
        local v12 = a1:GetCameraToSubjectDistance()
        local v13 = ((v12 < 0.5) and 0.5) or v12
        if not (a1:GetIsMouseLocked()) or a1:IsInFirstPerson() then
            local v14 = v8 ~= Vector2.new()
            if not v14 and a1.lastCameraTransform then
                local v15 = a1:IsInFirstPerson()
                if CameraSubject_1 then
                    if a1.lastUpdate and v6 and v6.Torso then
                        if v15 then
                            if a1.lastSubjectCFrame and CameraSubject_1 then
                                local v16 = CameraSubject_1:IsA("BasePart")
                                if v16 then
                                    local v17 = -CameraUtils_upv_1.GetAngleBetweenXZVectors(a1.lastSubjectCFrame.lookVector, CameraSubject_1.CFrame.lookVector)
                                    v8 = (CameraUtils_upv_1.IsFinite(v17) and (v8 + Vector2.new(v17, 0))) or v8
                                    u1 = 0
                                end
                            end
                        elseif not v10 then
                            local lookVector_2 = v6.Torso.CFrame.lookVector
                            u1 = math.clamp(u1 + (3.839724354387525 * a2), 0, 4.363323129985824)
                            local v18 = math.clamp(u1 * a2, 0, 1)
                            local v19 = a1:IsInFirstPerson()
                            if v19 and (not (a1.isFollowCamera) or not (a1.isClimbing)) then
                                v18 = 1
                            end
                            local v20 = CameraUtils_upv_1.GetAngleBetweenXZVectors(lookVector_2, a1:GetCameraLookVector())
                            local v21 = CameraUtils_upv_1.IsFinite(v20)
                            if v21 then
                                v8 = ((math.abs(v20) > 1e-04) and (v8 + Vector2.new(v20 * v18, 0))) or v8
                            end
                        end
                    elseif a1.isFollowCamera and not v15 and not v10 then
                        local v22 = CameraUtils_upv_1.GetAngleBetweenXZVectors(-(a1.lastCameraTransform.Position - v11), a1:GetCameraLookVector())
                        local v23 = CameraUtils_upv_1.IsFinite(v22)
                        if v23 and math.abs(v22) > 1e-04 then
                            v8 = ((0.4 * a2 < math.abs(v22)) and (v8 + Vector2.new(v22, 0))) or v8
                        end
                    end
                else
                    if (CameraSubject_1 or a1.isFollowCamera and v7) and a1.lastUpdate and v6 and v6.Torso then
                        if v15 then
                            if a1.lastSubjectCFrame and CameraSubject_1 then
                                local v16 = CameraSubject_1:IsA("BasePart")
                                if v16 then
                                    local v17 = -CameraUtils_upv_1.GetAngleBetweenXZVectors(a1.lastSubjectCFrame.lookVector, CameraSubject_1.CFrame.lookVector)
                                    v8 = (CameraUtils_upv_1.IsFinite(v17) and (v8 + Vector2.new(v17, 0))) or v8
                                    u1 = 0
                                end
                            end
                        elseif not v10 then
                            local lookVector_2 = v6.Torso.CFrame.lookVector
                            u1 = math.clamp(u1 + (3.839724354387525 * a2), 0, 4.363323129985824)
                            local v18 = math.clamp(u1 * a2, 0, 1)
                            local v19 = a1:IsInFirstPerson()
                            if v19 and (not (a1.isFollowCamera) or not (a1.isClimbing)) then
                                v18 = 1
                            end
                            local v20 = CameraUtils_upv_1.GetAngleBetweenXZVectors(lookVector_2, a1:GetCameraLookVector())
                            local v21 = CameraUtils_upv_1.IsFinite(v20)
                            if v21 then
                                v8 = ((math.abs(v20) > 1e-04) and (v8 + Vector2.new(v20 * v18, 0))) or v8
                            end
                        end
                        if a1.isFollowCamera then
                            local v24 = a1:CalculateNewLookVectorFromArg(lookVector_1, v8)
                            v4 = CFrame.new(v11)
                            v3 = ((not u3) and (CFrame.new(v4.Position - (v13 * v24), v4.Position) + Vector3.new(0, v9, 0))) or (CFrame.lookAlong(v4.Position - (v13 * v24), v24))
                        else
                            v4 = CFrame.new(v11)
                            local Position_1 = v4.Position
                            local v25 = a1:CalculateNewLookVectorFromArg(lookVector_1, v8)
                            if u3 then
                                v3 = CFrame.lookAlong(Position_1 - (v13 * v25), v25)
                            else
                                v3 = CFrame.new(Position_1 - (v13 * v25), Position_1)
                            end
                        end
                        local v26 = a1:GetCameraToggleOffset(a2)
                        v4 = v4 + v26
                        v3 = v3 + v26
                        a1.lastCameraTransform = v3
                        a1.lastCameraFocus = v4
                        if not (CameraSubject_1) or not (CameraSubject_1:IsA("BasePart")) then
                            a1.lastSubjectCFrame = nil
                            a1.lastUpdate = time_1
                            return v3, v4
                        end
                        a1.lastSubjectCFrame = CameraSubject_1.CFrame
                        a1.lastUpdate = time_1
                        return v3, v4
                    end
                    if a1.isFollowCamera and not v15 and not v10 then
                        local v22 = CameraUtils_upv_1.GetAngleBetweenXZVectors(-(a1.lastCameraTransform.Position - v11), a1:GetCameraLookVector())
                        local v23 = CameraUtils_upv_1.IsFinite(v22)
                        if v23 and math.abs(v22) > 1e-04 then
                            v8 = ((0.4 * a2 < math.abs(v22)) and (v8 + Vector2.new(v22, 0))) or v8
                        end
                    end
                end
            end
        else
            local v27 = a1:CalculateNewLookCFrameFromArg(lookVector_1, v8)
            local v28 = a1:GetMouseLockOffset()
            local v29 = (v6 and (v28 + v6.CameraOffset)) or v28
            local v30 = (v29.X * v27.RightVector) + (v29.Y * v27.UpVector) + v29.Z * v27.LookVector
            v11 = (CameraUtils_upv_1.IsFiniteVector3(v30) and (v11 + v30)) or v11
        end
        if a1.isFollowCamera then
            local v24 = a1:CalculateNewLookVectorFromArg(lookVector_1, v8)
            v4 = CFrame.new(v11)
            v3 = ((not u3) and (CFrame.new(v4.Position - (v13 * v24), v4.Position) + Vector3.new(0, v9, 0))) or (CFrame.lookAlong(v4.Position - (v13 * v24), v24))
        else
            v4 = CFrame.new(v11)
            local Position_1 = v4.Position
            local v25 = a1:CalculateNewLookVectorFromArg(lookVector_1, v8)
            if u3 then
                v3 = CFrame.lookAlong(Position_1 - (v13 * v25), v25)
            else
                v3 = CFrame.new(Position_1 - (v13 * v25), Position_1)
            end
        end
        local v26 = a1:GetCameraToggleOffset(a2)
        v4 = v4 + v26
        v3 = v3 + v26
        a1.lastCameraTransform = v3
        a1.lastCameraFocus = v4
        if not (CameraSubject_1) or not (CameraSubject_1:IsA("BasePart")) then
            a1.lastSubjectCFrame = nil
            a1.lastUpdate = time_1
            return v3, v4
        end
        a1.lastSubjectCFrame = CameraSubject_1.CFrame
    end
    a1.lastUpdate = time_1
    return v3, v4
end
return u4