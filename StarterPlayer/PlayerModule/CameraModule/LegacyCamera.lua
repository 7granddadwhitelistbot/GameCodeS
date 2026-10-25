local _ = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local Players_upv_1 = game:GetService("Players")
local BaseCamera_upv_1 = require(script.Parent:WaitForChild("BaseCamera"))
local u1 = setmetatable({}, BaseCamera_upv_1)
u1.__index = u1
function u1.new()
    --[[
      name: new
      line: 20
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
    ]]
    local v1 = setmetatable(BaseCamera_upv_1.new(), u1)
    v1.cameraType = Enum.CameraType.Fixed
    v1.lastUpdate = tick()
    v1.lastDistanceToSubject = nil
    return v1
end
function u1.GetModuleName(a1)
    --[[
      name: GetModuleName
      line: 30
    ]]
    return "LegacyCamera"
end
function u1.Update(a1, a2)
    --[[
      name: Update
      line: 34
      upvalues:
        Players_upv_1 (copy, index: 1)
        CameraInput_upv_1 (copy, index: 2)
    ]]
    if not a1.cameraType then
        return nil, nil
    end
    local time_1 = tick()
    local CurrentCamera_1 = workspace.CurrentCamera
    local v2 = CurrentCamera_1.CFrame
    local v3 = CurrentCamera_1.Focus
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local v4 = CameraInput_upv_1.getRotation(a2)
    if a1.lastUpdate == nil or time_1 - a1.lastUpdate > 1 then
        a1.lastDistanceToSubject = nil
    end
    local v5 = a1:GetSubjectPosition()
    if a1.cameraType ~= Enum.CameraType.Fixed then
        if a1.cameraType == Enum.CameraType.Attach then
            local v6 = a1:GetSubjectCFrame()
            local v7 = CurrentCamera_1.CFrame:ToEulerAnglesYXZ()
            local _, v8 = v6:ToEulerAnglesYXZ()
            v7 = math.clamp(v7 - v4.Y, -1.3962634015954636, 1.3962634015954636)
            v3 = CFrame.new(v6.Position) * CFrame.fromEulerAnglesYXZ(v7, v8, 0)
            v2 = v3 * CFrame.new(0, 0, a1:StepZoom(a2))
        elseif a1.cameraType ~= Enum.CameraType.Watch then
            return CurrentCamera_1.CFrame, CurrentCamera_1.Focus
        elseif v5 and LocalPlayer_1 and CurrentCamera_1 then
            local v9 = nil
            if v5 ~= CurrentCamera_1.CFrame.Position then
                local v10 = a1:GetHumanoid()
                if v10 and v10.RootPart then
                    local v11 = v5 - CurrentCamera_1.CFrame.Position
                    local unit_1 = v11.unit
                    if a1.lastDistanceToSubject and a1.lastDistanceToSubject == a1:GetCameraToSubjectDistance() then
                        a1:SetCameraToSubjectDistance(v11.magnitude)
                    end
                    v9 = unit_1
                end
                local v12 = a1:GetCameraToSubjectDistance()
                local v13 = a1:CalculateNewLookVectorFromArg(v9, v4)
                v3 = CFrame.new(v5)
                v2 = CFrame.new(v5 - (v12 * v13), v5)
                a1.lastDistanceToSubject = v12
            else
                warn("Camera cannot watch subject in same position as itself")
                return CurrentCamera_1.CFrame, CurrentCamera_1.Focus
            end
        end
    elseif v5 and LocalPlayer_1 and CurrentCamera_1 then
        local v14 = a1:GetCameraToSubjectDistance()
        local v15 = a1:CalculateNewLookVectorFromArg(nil, v4)
        v3 = CurrentCamera_1.Focus
        v2 = CFrame.new(CurrentCamera_1.CFrame.Position, CurrentCamera_1.CFrame.Position + (v14 * v15))
    end
    a1.lastUpdate = time_1
    return v2, v3
end
return u1