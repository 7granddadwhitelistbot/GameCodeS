local clampedValue = 0
local v2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v4 = CommonUtils.get("FlagUtil")
local userFlag = v4.getUserFlag("UserFixCameraFPError")
v4 = game:GetService("Players")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local v9 = setmetatable({}, BaseCamera)
v9.__index = v9

function v9.new()
    --[[
      name: new
      line: 37
      upvalues:
        BaseCamera (copy, index: 1)
        v9 (copy, index: 2)
        CameraUtils (copy, index: 3)
    ]]
    local v10 = setmetatable(BaseCamera.new(), v9)
    v10.isFollowCamera = false
    v10.isCameraToggle = false
    v10.lastUpdate = tick()
    v10.cameraToggleSpring = CameraUtils.Spring.new(5, 0)
    return v10
end

function v9.GetCameraToggleOffset(a11, a12)
    --[[
      name: GetCameraToggleOffset
      line: 48
      upvalues:
        CameraInput (copy, index: 1)
        CameraUtils (copy, index: 2)
    ]]
    if not a11.isCameraToggle then
        return (Vector3.new())
    end

    local currentSubjectDistance = a11.currentSubjectDistance

    if CameraInput.getTogglePan() then
        a11.cameraToggleSpring.goal = math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, a11.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1)
    else
        a11.cameraToggleSpring.goal = 0
    end

    local v14 = math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, 64, 0, 1), 0, 1) + 1

    return (Vector3.new(0, a11.cameraToggleSpring:step(a12) * v14, 0))
end

function v9.SetCameraMovementMode(cameraMovementMode, a16)
    --[[
      name: SetCameraMovementMode
      line: 67
      upvalues:
        BaseCamera (copy, index: 1)
    ]]
    BaseCamera.SetCameraMovementMode(cameraMovementMode, a16)
    cameraMovementMode.isFollowCamera = a16 == Enum.ComputerCameraMovementMode.Follow
    cameraMovementMode.isCameraToggle = a16 == Enum.ComputerCameraMovementMode.CameraToggle
end

function v9.Update(a17, a18)
    --[[
      name: Update
      line: 74
      upvalues:
        v2 (copy, index: 1)
        v4 (copy, index: 2)
        CameraInput (copy, index: 3)
        clampedValue (ref,  index: 4)
        CameraUtils (copy, index: 5)
        userFlag (copy, index: 6)
    ]]
    local time = tick()
    local camera = workspace.CurrentCamera
    local v21 = camera.CFrame
    local v22 = camera.Focus
    local lookVector = nil

    if a17.resetCameraAngle then
        lookVector = if const humanoidRootPart = a17:GetHumanoidRootPart() then (humanoidRootPart.CFrame * v2).lookVector else v2.lookVector
        a17.resetCameraAngle = false
    end

    local localPlayer = v4.LocalPlayer
    local humanoid = a17:GetHumanoid()
    local cameraSubject = camera.CameraSubject
    local isVehicleSeat = cameraSubject and cameraSubject:IsA("VehicleSeat")
    local isSkateboardPlatform = cameraSubject and cameraSubject:IsA("SkateboardPlatform")
    local isClimbing = humanoid and humanoid:GetState() == Enum.HumanoidStateType.Climbing

    if a17.lastUpdate == nil or 1 < a18 then
        a17.lastCameraTransform = nil
    end

    local v31 = CameraInput.getRotation(a18)
    a17:StepZoom(a18)
    local y = a17:GetCameraHeight()

    if v31 ~= Vector2.new() then
        clampedValue = 0
        a17.lastUserPanCamera = tick()
    end

    local v33 = time - a17.lastUserPanCamera < 2
    local v34 = a17:GetSubjectPosition()

    if v34 and localPlayer and camera then
        local cframe, v36
        local cameraToSubjectDistance = a17:GetCameraToSubjectDistance()

        if cameraToSubjectDistance < 0.5 then
            cameraToSubjectDistance = 0.5
        end

        if a17:GetIsMouseLocked() then
            if a17:IsInFirstPerson() then
                if v31 == Vector2.new() and a17.lastCameraTransform then
                    local isInFirstPerson = a17:IsInFirstPerson()

                    if isVehicleSeat or isSkateboardPlatform or a17.isFollowCamera and isClimbing then
                        if a17.lastUpdate and humanoid and humanoid.Torso then
                            if isInFirstPerson then
                                if a17.lastSubjectCFrame
                                    and (isVehicleSeat or isSkateboardPlatform)
                                    and cameraSubject:IsA("BasePart")
                                then
                                    local x = -CameraUtils.GetAngleBetweenXZVectors(a17.lastSubjectCFrame.lookVector, cameraSubject.CFrame.lookVector)

                                    if CameraUtils.IsFinite(x) then
                                        v31 += Vector2.new(x, 0)
                                    end

                                    clampedValue = 0
                                end
                            elseif not v33 then
                                local lookVector2 = humanoid.Torso.CFrame.lookVector
                                clampedValue = math.clamp(clampedValue + (3.839724354387525 * a18), 0, 4.363323129985824)
                                local clampedValue2 = math.clamp(clampedValue * a18, 0, 1)

                                if a17:IsInFirstPerson() and (not a17.isFollowCamera or not a17.isClimbing) then
                                    clampedValue2 = 1
                                end

                                local angleBetweenXzVectors = CameraUtils.GetAngleBetweenXZVectors(lookVector2, a17:GetCameraLookVector())

                                if CameraUtils.IsFinite(angleBetweenXzVectors)
                                    and 1e-04 < math.abs(angleBetweenXzVectors)
                                then
                                    v31 += Vector2.new(angleBetweenXzVectors * clampedValue2, 0)
                                end
                            end
                        elseif a17.isFollowCamera and not isInFirstPerson and not v33 then
                            local v43 = -(a17.lastCameraTransform.Position - v34)
                            local x2 = CameraUtils.GetAngleBetweenXZVectors(v43, a17:GetCameraLookVector())

                            if CameraUtils.IsFinite(x2) and 1e-04 < math.abs(x2) then
                                local absoluteValue = math.abs(x2)

                                if 0.4 * a18 < absoluteValue then
                                    v31 += Vector2.new(x2, 0)
                                end
                            end
                        end
                    elseif a17.isFollowCamera then
                        if not isInFirstPerson then
                            if not v33 then
                                local v43 = -(a17.lastCameraTransform.Position - v34)
                                local x2 = CameraUtils.GetAngleBetweenXZVectors(v43, a17:GetCameraLookVector())

                                if CameraUtils.IsFinite(x2) then
                                    if 1e-04 < math.abs(x2) then
                                        local absoluteValue = math.abs(x2)

                                        if 0.4 * a18 < absoluteValue then
                                            v31 += Vector2.new(x2, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                local v46 = a17:CalculateNewLookCFrameFromArg(lookVector, v31)
                local v47 = a17:GetMouseLockOffset()

                if humanoid then
                    v47 += humanoid.CameraOffset
                end

                local v48 = (v47.X * v46.RightVector) + (v47.Y * v46.UpVector) + v47.Z * v46.LookVector

                if CameraUtils.IsFiniteVector3(v48) then
                    v34 += v48
                end
            end
        elseif v31 == Vector2.new() then
            if a17.lastCameraTransform then
                local isInFirstPerson = a17:IsInFirstPerson()

                if isVehicleSeat or isSkateboardPlatform or a17.isFollowCamera and isClimbing then
                    if a17.lastUpdate and humanoid and humanoid.Torso then
                        if isInFirstPerson then
                            if a17.lastSubjectCFrame then
                                if isVehicleSeat or isSkateboardPlatform then
                                    if cameraSubject:IsA("BasePart") then
                                        local x = -CameraUtils.GetAngleBetweenXZVectors(a17.lastSubjectCFrame.lookVector, cameraSubject.CFrame.lookVector)

                                        if CameraUtils.IsFinite(x) then
                                            v31 += Vector2.new(x, 0)
                                        end

                                        clampedValue = 0
                                    end
                                end
                            end
                        elseif not v33 then
                            local lookVector2 = humanoid.Torso.CFrame.lookVector
                            clampedValue = math.clamp(clampedValue + (3.839724354387525 * a18), 0, 4.363323129985824)
                            local clampedValue2 = math.clamp(clampedValue * a18, 0, 1)

                            if a17:IsInFirstPerson() then
                                if not a17.isFollowCamera or not a17.isClimbing then
                                    clampedValue2 = 1
                                end
                            end

                            local angleBetweenXzVectors = CameraUtils.GetAngleBetweenXZVectors(lookVector2, a17:GetCameraLookVector())

                            if CameraUtils.IsFinite(angleBetweenXzVectors) then
                                if 1e-04 < math.abs(angleBetweenXzVectors) then
                                    v31 += Vector2.new(angleBetweenXzVectors * clampedValue2, 0)
                                end
                            end
                        end
                    elseif a17.isFollowCamera then
                        if not isInFirstPerson then
                            if not v33 then
                                local v43 = -(a17.lastCameraTransform.Position - v34)
                                local x2 = CameraUtils.GetAngleBetweenXZVectors(v43, a17:GetCameraLookVector())

                                if CameraUtils.IsFinite(x2) then
                                    if 1e-04 < math.abs(x2) then
                                        local absoluteValue = math.abs(x2)

                                        if 0.4 * a18 < absoluteValue then
                                            v31 += Vector2.new(x2, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                elseif a17.isFollowCamera then
                    if not isInFirstPerson then
                        if not v33 then
                            local v43 = -(a17.lastCameraTransform.Position - v34)
                            local x2 = CameraUtils.GetAngleBetweenXZVectors(v43, a17:GetCameraLookVector())

                            if CameraUtils.IsFinite(x2) then
                                if 1e-04 < math.abs(x2) then
                                    local absoluteValue = math.abs(x2)

                                    if 0.4 * a18 < absoluteValue then
                                        v31 += Vector2.new(x2, 0)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if a17.isFollowCamera then
            local v49 = a17:CalculateNewLookVectorFromArg(lookVector, v31)
            cframe = CFrame.new(v34)
            v36 = if userFlag then CFrame.lookAlong(cframe.Position - (cameraToSubjectDistance * v49), v49) else CFrame.new(cframe.Position - (cameraToSubjectDistance * v49), cframe.Position) + Vector3.new(0, y, 0)
        else
            cframe = CFrame.new(v34)
            local position = cframe.Position
            local v51 = a17:CalculateNewLookVectorFromArg(lookVector, v31)
            v36 = if userFlag then CFrame.lookAlong(position - (cameraToSubjectDistance * v51), v51) else CFrame.new(position - (cameraToSubjectDistance * v51), position)
        end

        local cameraToggleOffset = a17:GetCameraToggleOffset(a18)
        v22 = cframe + cameraToggleOffset
        v21 = v36 + cameraToggleOffset
        a17.lastCameraTransform = v21
        a17.lastCameraFocus = v22

        if not isVehicleSeat and not isSkateboardPlatform or not cameraSubject:IsA("BasePart") then
            a17.lastSubjectCFrame = nil
        else
            a17.lastSubjectCFrame = cameraSubject.CFrame
        end
    end

    a17.lastUpdate = time

    return v21, v22
end

return v9