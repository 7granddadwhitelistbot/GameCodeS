require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local players = game:GetService("Players")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local v4 = setmetatable({}, BaseCamera)
v4.__index = v4

function v4.new()
    --[[
      name: new
      line: 22
      upvalues:
        BaseCamera (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    local v5 = setmetatable(BaseCamera.new(), v4)
    v5.cameraType = Enum.CameraType.Fixed
    v5.lastUpdate = tick()
    v5.lastDistanceToSubject = nil
    return v5
end

function v4.GetModuleName(a6)
    --[[
      name: GetModuleName
      line: 32
    ]]
    return "LegacyCamera"
end

function v4.Update(a7, a8)
    --[[
      name: Update
      line: 36
      upvalues:
        players (copy, index: 1)
        CameraInput (copy, index: 2)
    ]]
    if not a7.cameraType then
        return nil, nil
    end

    local time = tick()
    local v10 = time - a7.lastUpdate
    local camera = workspace.CurrentCamera
    local v12 = camera.CFrame
    local v13 = camera.Focus
    local localPlayer = players.LocalPlayer
    local rotation = CameraInput.getRotation(a8)

    if a7.lastUpdate == nil or 1 < v10 then
        a7.lastDistanceToSubject = nil
    end

    local subjectPosition = a7:GetSubjectPosition()

    if a7.cameraType ~= Enum.CameraType.Fixed then
        if a7.cameraType ~= Enum.CameraType.Attach then
            if a7.cameraType ~= Enum.CameraType.Watch then
                return camera.CFrame, camera.Focus
            end

            if subjectPosition and localPlayer and camera then
                local unit = nil

                if subjectPosition == camera.CFrame.Position then
                    warn("Camera cannot watch subject in same position as itself")
                    return camera.CFrame, camera.Focus
                end

                local humanoid = a7:GetHumanoid()

                if humanoid and humanoid.RootPart then
                    local v19 = subjectPosition - camera.CFrame.Position
                    unit = v19.unit

                    if a7.lastDistanceToSubject and a7.lastDistanceToSubject == a7:GetCameraToSubjectDistance() then
                        a7:SetCameraToSubjectDistance(v19.magnitude)
                    end
                end

                local lastDistanceToSubject = a7:GetCameraToSubjectDistance()
                local v21 = a7:CalculateNewLookVectorFromArg(unit, rotation)
                v13 = CFrame.new(subjectPosition)
                v12 = CFrame.new(subjectPosition - (lastDistanceToSubject * v21), subjectPosition)
                a7.lastDistanceToSubject = lastDistanceToSubject
            end
        else
            local subjectCFrame = a7:GetSubjectCFrame()
            local v23 = camera.CFrame:ToEulerAnglesYXZ()
            local _, v25 = subjectCFrame:ToEulerAnglesYXZ()
            local clampedValue = math.clamp(v23 - rotation.Y, -1.3962634015954636, 1.3962634015954636)
            v13 = CFrame.new(subjectCFrame.Position) * CFrame.fromEulerAnglesYXZ(clampedValue, v25, 0)
            v12 = v13 * CFrame.new(0, 0, a7:StepZoom(a8))
        end
    elseif subjectPosition and localPlayer and camera then
        local cameraToSubjectDistance = a7:GetCameraToSubjectDistance()
        local v28 = a7:CalculateNewLookVectorFromArg(nil, rotation)
        v13 = camera.Focus
        v12 = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + (cameraToSubjectDistance * v28))
    end

    a7.lastUpdate = time

    return v12, v13
end

return v4