local u1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserFixOrbitalCameraAzimuth")
local _ = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local Players_upv_1 = game:GetService("Players")
local BaseCamera_upv_1 = require(script.Parent:WaitForChild("BaseCamera"))
local u2 = setmetatable({}, BaseCamera_upv_1)
u2.__index = u2
function u2.new()
    --[[
      name: new
      line: 33
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    local v1 = setmetatable(BaseCamera_upv_1.new(), u2)
    v1.lastUpdate = tick()
    v1.changedSignalConnections = {}
    v1.refAzimuthRad = nil
    v1.curAzimuthRad = nil
    v1.minAzimuthAbsoluteRad = nil
    v1.maxAzimuthAbsoluteRad = nil
    v1.useAzimuthLimits = nil
    v1.curElevationRad = nil
    v1.minElevationRad = nil
    v1.maxElevationRad = nil
    v1.curDistance = nil
    v1.minDistance = nil
    v1.maxDistance = nil
    v1.gamepadDollySpeedMultiplier = 1
    v1.lastUserPanCamera = tick()
    v1.externalProperties = {}
    v1.externalProperties.InitialDistance = 25
    v1.externalProperties.MinDistance = 10
    v1.externalProperties.MaxDistance = 100
    v1.externalProperties.InitialElevation = 35
    v1.externalProperties.MinElevation = 35
    v1.externalProperties.MaxElevation = 35
    v1.externalProperties.ReferenceAzimuth = -45
    v1.externalProperties.CWAzimuthTravel = 90
    v1.externalProperties.CCWAzimuthTravel = 90
    v1.externalProperties.UseAzimuthLimits = false
    v1:LoadNumberValueParameters()
    return v1
end
function u2.LoadOrCreateNumberValueParameter(a1, a2, a3, a4)
    --[[
      name: LoadOrCreateNumberValueParameter
      line: 72
    ]]
    local v2 = script:FindFirstChild(a2)
    if v2 and v2:IsA(a3) then
        a1.externalProperties[a2] = v2.Value
        if a4 then
            if a1.changedSignalConnections[a2] then
                a1.changedSignalConnections[a2]:Disconnect()
            end
            a1.changedSignalConnections[a2] = v2.Changed:Connect(
                function(a5)
                    --[[
                      line: 92
                      upvalues:
                        a1 (copy, index: 1)
                        a2 (copy, index: 2)
                        a4 (copy, index: 3)
                    ]]
                    a1.externalProperties[a2] = a5
                    a4(a1)
                end
            )
        end
        return
    end
    if a1.externalProperties[a2] == nil then
        return
    end
    local v3 = Instance.new(a3)
    v3.Name = a2
    v3.Parent = script
    v3.Value = a1.externalProperties[a2]
    v2 = v3
    if not a4 then
        return
    end
    if a1.changedSignalConnections[a2] then
        a1.changedSignalConnections[a2]:Disconnect()
    end
    a1.changedSignalConnections[a2] = v2.Changed:Connect(
        function(a5)
            --[[
              line: 92
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
                a4 (copy, index: 3)
            ]]
            a1.externalProperties[a2] = a5
            a4(a1)
        end
    )
end
function u2.SetAndBoundsCheckAzimuthValues(a1)
    --[[
      name: SetAndBoundsCheckAzimuthValues
      line: 99
    ]]
    a1.minAzimuthAbsoluteRad = math.rad(a1.externalProperties.ReferenceAzimuth) - math.abs(math.rad(a1.externalProperties.CWAzimuthTravel))
    a1.maxAzimuthAbsoluteRad = math.rad(a1.externalProperties.ReferenceAzimuth) + math.abs(math.rad(a1.externalProperties.CCWAzimuthTravel))
    a1.useAzimuthLimits = a1.externalProperties.UseAzimuthLimits
    if not a1.useAzimuthLimits then
        return
    end
    a1.curAzimuthRad = math.max(a1.curAzimuthRad, a1.minAzimuthAbsoluteRad)
    a1.curAzimuthRad = math.min(a1.curAzimuthRad, a1.maxAzimuthAbsoluteRad)
end
function u2.SetAndBoundsCheckElevationValues(a1)
    --[[
      name: SetAndBoundsCheckElevationValues
      line: 109
    ]]
    local v4 = math.max(a1.externalProperties.MinElevation, -80)
    local v5 = math.min(a1.externalProperties.MaxElevation, 80)
    a1.minElevationRad = math.rad(math.min(v4, v5))
    a1.maxElevationRad = math.rad(math.max(v4, v5))
    a1.curElevationRad = math.max(a1.curElevationRad, a1.minElevationRad)
    a1.curElevationRad = math.min(a1.curElevationRad, a1.maxElevationRad)
end
function u2.SetAndBoundsCheckDistanceValues(a1)
    --[[
      name: SetAndBoundsCheckDistanceValues
      line: 125
    ]]
    a1.minDistance = a1.externalProperties.MinDistance
    a1.maxDistance = a1.externalProperties.MaxDistance
    a1.curDistance = math.max(a1.curDistance, a1.minDistance)
    a1.curDistance = math.min(a1.curDistance, a1.maxDistance)
end
function u2.LoadNumberValueParameters(a1)
    --[[
      name: LoadNumberValueParameters
      line: 133
      upvalues:
        u1 (copy, index: 1)
    ]]
    a1:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    a1:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    local v6
    if u1 then
        v6 = a1.SetAndBoundsCheckAzimuthValues
    else
        v6 = a1.SetAndBoundsCheckAzimuthValue
    end
    a1:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", v6)
    a1:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", a1.SetAndBoundsCheckAzimuthValues)
    a1:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", a1.SetAndBoundsCheckAzimuthValues)
    a1:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", a1.SetAndBoundsCheckElevationValues)
    a1:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", a1.SetAndBoundsCheckElevationValues)
    a1:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", a1.SetAndBoundsCheckDistanceValues)
    a1:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", a1.SetAndBoundsCheckDistanceValues)
    a1:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", a1.SetAndBoundsCheckAzimuthValues)
    a1.curAzimuthRad = math.rad(a1.externalProperties.ReferenceAzimuth)
    a1.curElevationRad = math.rad(a1.externalProperties.InitialElevation)
    a1.curDistance = a1.externalProperties.InitialDistance
    a1:SetAndBoundsCheckAzimuthValues()
    a1:SetAndBoundsCheckElevationValues()
    a1:SetAndBoundsCheckDistanceValues()
end
function u2.GetModuleName(a1)
    --[[
      name: GetModuleName
      line: 159
    ]]
    return "OrbitalCamera"
end
function u2.GetCameraToSubjectDistance(a1)
    --[[
      name: GetCameraToSubjectDistance
      line: 164
    ]]
    return a1.curDistance
end
function u2.SetCameraToSubjectDistance(a1, a2)
    --[[
      name: SetCameraToSubjectDistance
      line: 168
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if Players_upv_1.LocalPlayer then
        a1.currentSubjectDistance = math.clamp(a2, a1.minDistance, a1.maxDistance)
        a1.currentSubjectDistance = math.max(a1.currentSubjectDistance, a1.FIRST_PERSON_DISTANCE_THRESHOLD)
    end
    a1.inFirstPerson = false
    a1:UpdateMouseBehavior()
    return a1.currentSubjectDistance
end
function u2.CalculateNewLookVector(a1, a2, a3)
    --[[
      name: CalculateNewLookVector
      line: 181
    ]]
    local v7 = a2 or (a1:GetCameraLookVector())
    local v8 = math.asin(v7.Y)
    v8 = Vector2.new(a3.X, math.clamp(a3.Y, v8 - 1.3962634015954636, v8 - -1.3962634015954636))
    local v9 = CFrame.new(Vector3.new(0, 0, 0), v7)
    return (CFrame.Angles(0, -v8.X, 0) * v9 * CFrame.Angles(-v8.Y, 0, 0)).LookVector
end
function u2.Update(a1, a2)
    --[[
      name: Update
      line: 192
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    local time_1 = tick()
    local v10 = CameraInput_upv_1.getRotation(a2) ~= Vector2.new()
    local CurrentCamera_1 = workspace.CurrentCamera
    local v11 = CurrentCamera_1.CFrame
    local v12 = CurrentCamera_1.Focus
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local v13 = CurrentCamera_1 and (CurrentCamera_1.CameraSubject)
    local _ = v13 and (v13:IsA("VehicleSeat"))
    local v17 = CurrentCamera_1 and (CurrentCamera_1:IsA("SkateboardPlatform"))
    if a1.lastUpdate == nil or time_1 - a1.lastUpdate > 1 then
        a1.lastCameraTransform = nil
    end
    if v10 then
        a1.lastUserPanCamera = tick()
    end
    local v14 = a1:GetSubjectPosition()
    if v14 and LocalPlayer_1 and CurrentCamera_1 then
        if a1.gamepadDollySpeedMultiplier ~= 1 then
            a1:SetCameraToSubjectDistance(a1.currentSubjectDistance * a1.gamepadDollySpeedMultiplier)
        end
        v12 = CFrame.new(v14)
        local v15 = CameraInput_upv_1.getRotation(a2)
        a1.curAzimuthRad = a1.curAzimuthRad - v15.X
        if a1.useAzimuthLimits then
            a1.curAzimuthRad = math.clamp(a1.curAzimuthRad, a1.minAzimuthAbsoluteRad, a1.maxAzimuthAbsoluteRad)
        else
            a1.curAzimuthRad = a1.curAzimuthRad ~= 0 and math.sign(a1.curAzimuthRad) * (math.abs(a1.curAzimuthRad) % math.tau) or 0
        end
        a1.curElevationRad = math.clamp(a1.curElevationRad + v15.Y, a1.minElevationRad, a1.maxElevationRad)
        v11 = CFrame.new(v14 + (a1.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-a1.curElevationRad, a1.curAzimuthRad, 0) * Vector3.new(0, 0, 1))), v14)
        a1.lastCameraTransform = v11
        a1.lastCameraFocus = v12
        if not (v13) and not (CurrentCamera_1) or not (CurrentCamera_1:IsA("BasePart")) then
            a1.lastSubjectCFrame = nil
            a1.lastUpdate = time_1
            return v11, v12
        end
        a1.lastSubjectCFrame = CurrentCamera_1.CFrame
    end
    a1.lastUpdate = time_1
    return v11, v12
end
return u2