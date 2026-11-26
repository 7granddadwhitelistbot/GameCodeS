local CameraUtils = require(script.Parent.Parent.CameraUtils)
local VehicleCameraConfig = require(script.Parent.VehicleCameraConfig)
local map = CameraUtils.map
local mapClamp = CameraUtils.mapClamp
local sanitizeAngle = CameraUtils.sanitizeAngle

local function getYaw(a7)
    --[[
      name: getYaw
      line: 10
      upvalues:
        sanitizeAngle (copy, index: 1)
    ]]
    local _, v9 = a7:toEulerAnglesYXZ()
    return sanitizeAngle(v9)
end

local function getPitch(a11)
    --[[
      name: getPitch
      line: 16
      upvalues:
        sanitizeAngle (copy, index: 1)
    ]]
    local v12 = a11:toEulerAnglesYXZ()
    return sanitizeAngle(v12)
end

local function stepSpringAxis(a14, a15, a16, a17, a18)
    --[[
      name: stepSpringAxis
      line: 22
      upvalues:
        sanitizeAngle (copy, index: 1)
    ]]
    local v19 = sanitizeAngle(a17 - a16)
    local v20 = math.exp(-a15 * a14)

    return sanitizeAngle(((v19 * (1 + (a15 * a14)) + (a18 * a14)) * v20) + a16), (a18 * (1 - (a15 * a14)) - (v19 * ((a15 * a15) * a14))) * v20
end

local Class = {}
Class.__index = Class

function Class.new(fRising, fFalling, a24)
    --[[
      name: new
      line: 37
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({fRising = fRising, fFalling = fFalling, g = a24, p = a24, v = a24 * 0}, Class))
end

function Class.step(self, a26)
    --[[
      name: step
      line: 47
    ]]
    local v27
    local fRising = self.fRising
    local fFalling = self.fFalling
    local g = self.g
    local p = self.p
    local v = self.v
    local v33 = math.tau

    if not (0 < v) then
        v27 = fFalling
    else
        v27 = fRising
        v27 = v27 or fFalling
    end

    local v34 = v33 * v27
    local v35 = p - g
    local v36 = math.exp(-v34 * a26)
    local p2 = (v35 * (1 + (v34 * a26)) + (v * a26)) * v36 + g
    self.p, self.v = p2, (v * (1 - (v34 * a26)) - (v35 * ((v34 * v34) * a26))) * v36

    return p2
end

local Class2 = {}
Class2.__index = Class2

function Class2.new(a39)
    --[[
      name: new
      line: 74
      upvalues:
        sanitizeAngle (copy, index: 1)
        Class (copy, index: 2)
        VehicleCameraConfig (copy, index: 3)
        Class2 (copy, index: 4)
    ]]
    assert(typeof(a39) == "CFrame")
    local v40 = {yawV = 0, pitchV = 0}
    local _, v42 = a39:toEulerAnglesYXZ()
    v40.yawG = sanitizeAngle(v42)
    local _, v44 = a39:toEulerAnglesYXZ()
    v40.yawP = sanitizeAngle(v44)
    local v45 = a39:toEulerAnglesYXZ()
    v40.pitchG = sanitizeAngle(v45)
    local v46 = a39:toEulerAnglesYXZ()
    v40.pitchP = sanitizeAngle(v46)
    v40.fSpringYaw = Class.new(VehicleCameraConfig.yawReponseDampingRising, VehicleCameraConfig.yawResponseDampingFalling, 0)
    v40.fSpringPitch = Class.new(VehicleCameraConfig.pitchReponseDampingRising, VehicleCameraConfig.pitchResponseDampingFalling, 0)

    return (setmetatable(v40, Class2))
end

function Class2.setGoal(self, goal)
    --[[
      name: setGoal
      line: 101
      upvalues:
        sanitizeAngle (copy, index: 1)
    ]]
    assert(typeof(goal) == "CFrame")
    local _, v50 = goal:toEulerAnglesYXZ()
    self.yawG = sanitizeAngle(v50)
    local v51 = goal:toEulerAnglesYXZ()
    self.pitchG = sanitizeAngle(v51)
end

function Class2.getCFrame(self)
    --[[
      name: getCFrame
      line: 108
    ]]
    return CFrame.fromEulerAnglesYXZ(self.pitchP, self.yawP, 0)
end

function Class2.step(self, a54, a55, a56, a57)
    --[[
      name: step
      line: 112
      upvalues:
        mapClamp (copy, index: 1)
        map (copy, index: 2)
        VehicleCameraConfig (copy, index: 3)
        sanitizeAngle (copy, index: 4)
    ]]
    assert(typeof(a54) == "number")
    assert(typeof(a56) == "number")
    assert(typeof(a55) == "number")
    assert(typeof(a57) == "number")
    local fSpringYaw = self.fSpringYaw
    local fSpringPitch = self.fSpringPitch
    fSpringYaw.g = mapClamp(map(a57, 0, 1, a56, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelYaw), math.rad(VehicleCameraConfig.cutoffMaxAngularVelYaw), 1, 0)
    fSpringPitch.g = mapClamp(map(a57, 0, 1, a55, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelPitch), math.rad(VehicleCameraConfig.cutoffMaxAngularVelPitch), 1, 0)
    local v60 = math.tau * VehicleCameraConfig.yawStiffness * fSpringYaw:step(a54)
    local v61 = (math.tau * VehicleCameraConfig.pitchStiffness) * fSpringPitch:step(a54) * map(a57, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)
    local v62 = v60 * map(a57, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)
    local yawG = self.yawG
    local yawP = self.yawP
    local yawV = self.yawV
    local v66 = sanitizeAngle(yawP - yawG)
    local v67 = math.exp(-v62 * a54)
    self.yawP, self.yawV = sanitizeAngle(((v66 * (1 + (v62 * a54)) + (yawV * a54)) * v67) + yawG), (yawV * (1 - (v62 * a54)) - (v66 * ((v62 * v62) * a54))) * v67
    local pitchG = self.pitchG
    local pitchP = self.pitchP
    local pitchV = self.pitchV
    local v71 = sanitizeAngle(pitchP - pitchG)
    local v72 = math.exp(-v61 * a54)
    self.pitchP, self.pitchV = sanitizeAngle(((v71 * (1 + (v61 * a54)) + (pitchV * a54)) * v72) + pitchG), (pitchV * (1 - (v61 * a54)) - (v71 * ((v61 * v61) * a54))) * v72

    return self:getCFrame()
end

local Class3 = {}
Class3.__index = Class3

function Class3.new(a74)
    --[[
      name: new
      line: 160
      upvalues:
        Class2 (copy, index: 1)
        Class3 (copy, index: 2)
    ]]
    return (setmetatable({vrs = Class2.new(a74)}, Class3))
end

function Class3.step(self, a76, a77, a78, a79)
    --[[
      name: step
      line: 166
    ]]
    return self.vrs:step(a76, a77, a78, a79)
end

function Class3.setTransform(self, goal)
    --[[
      name: setTransform
      line: 170
    ]]
    self.vrs:setGoal(goal)
end

return Class3