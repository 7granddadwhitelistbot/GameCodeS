local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v2 = CommonUtils.get("FlagUtil")
local userFlag = v2.getUserFlag("UserFixOrbitalCameraAzimuth")
require(script.Parent:WaitForChild("CameraUtils"))
v2 = require(script.Parent:WaitForChild("CameraInput"))
local players = game:GetService("Players")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local v6 = setmetatable({}, BaseCamera)
v6.__index = v6

function v6.new()
    --[[
      name: new
      line: 34
      upvalues:
        BaseCamera (copy, index: 1)
        v6 (copy, index: 2)
    ]]
    local v7 = setmetatable(BaseCamera.new(), v6)
    v7.lastUpdate = tick()
    v7.changedSignalConnections = {}
    v7.refAzimuthRad = nil
    v7.curAzimuthRad = nil
    v7.minAzimuthAbsoluteRad = nil
    v7.maxAzimuthAbsoluteRad = nil
    v7.useAzimuthLimits = nil
    v7.curElevationRad = nil
    v7.minElevationRad = nil
    v7.maxElevationRad = nil
    v7.curDistance = nil
    v7.minDistance = nil
    v7.maxDistance = nil
    v7.gamepadDollySpeedMultiplier = 1
    v7.lastUserPanCamera = tick()
    v7.externalProperties = {}
    v7.externalProperties.InitialDistance = 25
    v7.externalProperties.MinDistance = 10
    v7.externalProperties.MaxDistance = 100
    v7.externalProperties.InitialElevation = 35
    v7.externalProperties.MinElevation = 35
    v7.externalProperties.MaxElevation = 35
    v7.externalProperties.ReferenceAzimuth = -45
    v7.externalProperties.CWAzimuthTravel = 90
    v7.externalProperties.CCWAzimuthTravel = 90
    v7.externalProperties.UseAzimuthLimits = false
    v7:LoadNumberValueParameters()

    return v7
end

function v6.LoadOrCreateNumberValueParameter(self, name: string, className: string, callback)
    --[[
      name: LoadOrCreateNumberValueParameter
      line: 73
    ]]
    local instance = script:FindFirstChild(name)

    if not instance or not instance:IsA(className) then
        if self.externalProperties[name] == nil then
            return
        end

        instance = Instance.new(className)
        instance.Name = name
        instance.Parent = script
        instance.Value = self.externalProperties[name]
    else
        self.externalProperties[name] = instance.Value
    end

    if callback then
        if self.changedSignalConnections[name] then
            self.changedSignalConnections[name]:Disconnect()
        end

        self.changedSignalConnections[name] = instance.Changed:Connect(
            function(value)
                --[[
                  line: 93
                  upvalues:
                    self (copy, index: 1)
                    name (copy, index: 2)
                    callback (copy, index: 3)
                ]]
                self.externalProperties[name] = value
                callback(self)
            end
        )
    end
end

function v6.SetAndBoundsCheckAzimuthValues(self)
    --[[
      name: SetAndBoundsCheckAzimuthValues
      line: 100
    ]]
    self.minAzimuthAbsoluteRad = math.rad(self.externalProperties.ReferenceAzimuth) - math.abs((math.rad(self.externalProperties.CWAzimuthTravel)))
    self.maxAzimuthAbsoluteRad = math.rad(self.externalProperties.ReferenceAzimuth) + math.abs((math.rad(self.externalProperties.CCWAzimuthTravel)))
    self.useAzimuthLimits = self.externalProperties.UseAzimuthLimits
    local useAzimuthLimits = self.useAzimuthLimits
    if useAzimuthLimits then
        self.curAzimuthRad = math.max(self.curAzimuthRad, self.minAzimuthAbsoluteRad)
        self.curAzimuthRad = math.min(self.curAzimuthRad, self.maxAzimuthAbsoluteRad)
    end
end

function v6.SetAndBoundsCheckElevationValues(self)
    --[[
      name: SetAndBoundsCheckElevationValues
      line: 112
    ]]
    local v17 = math.max(self.externalProperties.MinElevation, -80)
    local v18 = math.min(self.externalProperties.MaxElevation, 80)
    self.minElevationRad = math.rad((math.min(v17, v18)))
    self.maxElevationRad = math.rad((math.max(v17, v18)))
    self.curElevationRad = math.max(self.curElevationRad, self.minElevationRad)
    self.curElevationRad = math.min(self.curElevationRad, self.maxElevationRad)
end

function v6.SetAndBoundsCheckDistanceValues(self)
    --[[
      name: SetAndBoundsCheckDistanceValues
      line: 128
    ]]
    self.minDistance = self.externalProperties.MinDistance
    self.maxDistance = self.externalProperties.MaxDistance
    self.curDistance = math.max(self.curDistance, self.minDistance)
    self.curDistance = math.min(self.curDistance, self.maxDistance)
end

function v6.LoadNumberValueParameters(self)
    --[[
      name: LoadNumberValueParameters
      line: 136
      upvalues:
        userFlag (copy, index: 1)
    ]]
    self:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    self:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    local v21 = if userFlag then self.SetAndBoundsCheckAzimuthValues else self.SetAndBoundsCheckAzimuthValue
    self:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", v21)
    self:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", self.SetAndBoundsCheckAzimuthValues)
    self:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", self.SetAndBoundsCheckAzimuthValues)
    self:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", self.SetAndBoundsCheckElevationValues)
    self:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", self.SetAndBoundsCheckElevationValues)
    self:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", self.SetAndBoundsCheckDistanceValues)
    self:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", self.SetAndBoundsCheckDistanceValues)
    self:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", self.SetAndBoundsCheckAzimuthValues)
    self.curAzimuthRad = math.rad(self.externalProperties.ReferenceAzimuth)
    self.curElevationRad = math.rad(self.externalProperties.InitialElevation)
    self.curDistance = self.externalProperties.InitialDistance
    self:SetAndBoundsCheckAzimuthValues()
    self:SetAndBoundsCheckElevationValues()
    self:SetAndBoundsCheckDistanceValues()
end

function v6.GetModuleName(a22)
    --[[
      name: GetModuleName
      line: 167
    ]]
    return "OrbitalCamera"
end

function v6.GetCameraToSubjectDistance(a23)
    --[[
      name: GetCameraToSubjectDistance
      line: 173
    ]]
    return a23.curDistance
end

function v6.SetCameraToSubjectDistance(cameraToSubjectDistance, a25: number)
    --[[
      name: SetCameraToSubjectDistance
      line: 177
      upvalues:
        players (copy, index: 1)
    ]]
    if players.LocalPlayer then
        cameraToSubjectDistance.currentSubjectDistance = math.clamp(a25, cameraToSubjectDistance.minDistance, cameraToSubjectDistance.maxDistance)
        cameraToSubjectDistance.currentSubjectDistance = math.max(cameraToSubjectDistance.currentSubjectDistance, cameraToSubjectDistance.FIRST_PERSON_DISTANCE_THRESHOLD)
    end

    cameraToSubjectDistance.inFirstPerson = false
    cameraToSubjectDistance:UpdateMouseBehavior()

    return cameraToSubjectDistance.currentSubjectDistance
end

function v6.CalculateNewLookVector(a26, a27, a28)
    --[[
      name: CalculateNewLookVector
      line: 190
    ]]
    local v29 = a27 or a26:GetCameraLookVector()
    local v30 = math.asin(v29.Y)
    local y = math.clamp(a28.Y, v30 - 1.3962634015954636, v30 - -1.3962634015954636)
    local vector2 = Vector2.new(a28.X, y)
    y = CFrame.new(Vector3.new(0, 0, 0), v29)

    return (CFrame.Angles(0, -vector2.X, 0) * y * CFrame.Angles(-vector2.Y, 0, 0)).LookVector
end

function v6.Update(a33, a34)
    --[[
      name: Update
      line: 209
      upvalues:
        v2 (copy, index: 1)
        players (copy, index: 2)
    ]]
    local time = tick()
    local v36 = time - a33.lastUpdate
    local v37 = v2.getRotation(a34) ~= Vector2.new()
    local camera = workspace.CurrentCamera
    local cframe = camera.CFrame
    local cframe2 = camera.Focus
    local localPlayer = players.LocalPlayer
    local cameraSubject = camera and camera.CameraSubject
    local isVehicleSeat = cameraSubject and cameraSubject:IsA("VehicleSeat")
    local isSkateboardPlatform = cameraSubject and cameraSubject:IsA("SkateboardPlatform")

    if a33.lastUpdate == nil or 1 < v36 then
        a33.lastCameraTransform = nil
    end

    if v37 then
        a33.lastUserPanCamera = tick()
    end

    local subjectPosition = a33:GetSubjectPosition()

    if subjectPosition and localPlayer and camera then
        local curAzimuthRad
        local v47, v48, v49, v50 = false, false, false, false

        if a33.gamepadDollySpeedMultiplier ~= 1 then
            a33:SetCameraToSubjectDistance(a33.currentSubjectDistance * a33.gamepadDollySpeedMultiplier)
        end

        cframe2 = CFrame.new(subjectPosition)
        local rotation = v2.getRotation(a34)
        a33.curAzimuthRad -= rotation.X

        if a33.useAzimuthLimits then
            a33.curAzimuthRad = math.clamp(a33.curAzimuthRad, a33.minAzimuthAbsoluteRad, a33.maxAzimuthAbsoluteRad)
        elseif a33.curAzimuthRad == 0 then
            v47 = true
        else
            curAzimuthRad = math.sign(a33.curAzimuthRad) * (math.abs(a33.curAzimuthRad) % math.tau)

            if curAzimuthRad then
                v48 = true
            else
                v47 = true
            end
        end

        if v47 then
            curAzimuthRad = 0
            v48 = true
        end

        if v48 then
            a33.curAzimuthRad = curAzimuthRad
        end

        a33.curElevationRad = math.clamp(a33.curElevationRad + rotation.Y, a33.minElevationRad, a33.maxElevationRad)
        local v52 = subjectPosition + a33.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-a33.curElevationRad, a33.curAzimuthRad, 0) * Vector3.new(0, 0, 1))
        cframe = CFrame.new(v52, subjectPosition)
        a33.lastCameraTransform = cframe
        a33.lastCameraFocus = cframe2

        if isVehicleSeat then
            v49 = true
        elseif isSkateboardPlatform then
            v49 = true
        else
            v50 = true
        end

        if v49 then
            if cameraSubject:IsA("BasePart") then
                a33.lastSubjectCFrame = cameraSubject.CFrame
            else
                v50 = true
            end
        end

        if v50 then
            a33.lastSubjectCFrame = nil
        end
    end

    a33.lastUpdate = time

    return cframe, cframe2
end

return v6