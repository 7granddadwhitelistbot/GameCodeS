local CameraUtils_1 = require(script.Parent.Parent.CameraUtils)
local VehicleCameraConfig_upv_1 = require(script.Parent.VehicleCameraConfig)
local map_upv_1 = CameraUtils_1.map
local mapClamp_upv_1 = CameraUtils_1.mapClamp
local sanitizeAngle_upv_1 = CameraUtils_1.sanitizeAngle
local function getYaw(a1)
    --[[
      name: getYaw
      line: 10
      upvalues:
        sanitizeAngle_upv_1 (copy, index: 1)
    ]]
    local _, v1 = a1:toEulerAnglesYXZ()
    return sanitizeAngle_upv_1(v1)
end
local function getPitch(a1)
    --[[
      name: getPitch
      line: 16
      upvalues:
        sanitizeAngle_upv_1 (copy, index: 1)
    ]]
    return sanitizeAngle_upv_1(a1:toEulerAnglesYXZ())
end
local function stepSpringAxis(a1, a2, a3, a4, a5)
    --[[
      name: stepSpringAxis
      line: 22
      upvalues:
        sanitizeAngle_upv_1 (copy, index: 1)
    ]]
    local v2 = sanitizeAngle_upv_1(a4 - a3)
    local v3 = math.exp(-a2 * a1)
    return sanitizeAngle_upv_1((((v2 * (1 + (a2 * a1))) + (a5 * a1)) * v3) + a3), ((a5 * (1 - (a2 * a1))) - (v2 * ((a2 * a2) * a1))) * v3
end
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1, a2, a3)
    --[[
      name: new
      line: 36
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({fRising = a1, fFalling = a2, g = a3, p = a3, v = a3 * 0}, tbl_upv_1))
end
function tbl_upv_1.step(a1, a2)
    --[[
      name: step
      line: 46
    ]]
    local fRising_1 = a1.fRising
    local fFalling_1 = a1.fFalling
    local g_1 = a1.g
    local p_1 = a1.p
    local v_1 = a1.v
    local v4 = math.tau
    local v5
    if v_1 > 0 then
        v5 = fRising_1 or fFalling_1
    else
        v5 = fFalling_1
    end
    local v6 = v4 * v5
    local v7 = p_1 - g_1
    local v8 = math.exp(-v6 * a2)
    local v9 = ((v7 * (1 + (v6 * a2))) + (v_1 * a2)) * v8 + g_1
    a1.p = v9
    a1.v = ((v_1 * (1 - (v6 * a2))) - (v7 * ((v6 * v6) * a2))) * v8
    return v9
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.new(a1)
    --[[
      name: new
      line: 72
      upvalues:
        sanitizeAngle_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        VehicleCameraConfig_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
    ]]
    local v10 = typeof(a1) == "CFrame"
    assert(v10)
    local tbl_3 = {pitchV = 0, yawV = 0}
    local _, v11 = a1:toEulerAnglesYXZ()
    tbl_3.yawG = sanitizeAngle_upv_1(v11)
    local v13, v12 = a1:toEulerAnglesYXZ()
    tbl_3.yawP = sanitizeAngle_upv_1(v12)
    tbl_3.pitchG = sanitizeAngle_upv_1(a1:toEulerAnglesYXZ())
    tbl_3.pitchP = sanitizeAngle_upv_1(a1:toEulerAnglesYXZ())
    tbl_3.fSpringYaw = tbl_upv_1.new(VehicleCameraConfig_upv_1.yawReponseDampingRising, VehicleCameraConfig_upv_1.yawResponseDampingFalling, 0)
    tbl_3.fSpringPitch = tbl_upv_1.new(VehicleCameraConfig_upv_1.pitchReponseDampingRising, VehicleCameraConfig_upv_1.pitchResponseDampingFalling, 0)
    return (setmetatable(tbl_3, tbl_upv_2))
end
function tbl_upv_2.setGoal(a1, a2)
    --[[
      name: setGoal
      line: 99
      upvalues:
        sanitizeAngle_upv_1 (copy, index: 1)
    ]]
    local v13 = typeof(a2) == "CFrame"
    assert(v13)
    local _, v14 = a2:toEulerAnglesYXZ()
    a1.yawG = sanitizeAngle_upv_1(v14)
    a1.pitchG = sanitizeAngle_upv_1(a2:toEulerAnglesYXZ())
end
function tbl_upv_2.getCFrame(a1)
    --[[
      name: getCFrame
      line: 106
    ]]
    return CFrame.fromEulerAnglesYXZ(a1.pitchP, a1.yawP, 0)
end
function tbl_upv_2.step(a1, a2, a3, a4, a5)
    --[[
      name: step
      line: 110
      upvalues:
        mapClamp_upv_1 (copy, index: 1)
        map_upv_1 (copy, index: 2)
        VehicleCameraConfig_upv_1 (copy, index: 3)
        sanitizeAngle_upv_1 (copy, index: 4)
    ]]
    local v15 = typeof(a2) == "number"
    assert(v15)
    local v16 = typeof(a4) == "number"
    assert(v16)
    local v17 = typeof(a3) == "number"
    assert(v17)
    local v18 = typeof(a5) == "number"
    assert(v18)
    local fSpringYaw_1 = a1.fSpringYaw
    local fSpringPitch_1 = a1.fSpringPitch
    fSpringYaw_1.g = mapClamp_upv_1(map_upv_1(a5, 0, 1, a4, 0), math.rad(VehicleCameraConfig_upv_1.cutoffMinAngularVelYaw), math.rad(VehicleCameraConfig_upv_1.cutoffMaxAngularVelYaw), 1, 0)
    fSpringPitch_1.g = mapClamp_upv_1(map_upv_1(a5, 0, 1, a3, 0), math.rad(VehicleCameraConfig_upv_1.cutoffMinAngularVelPitch), math.rad(VehicleCameraConfig_upv_1.cutoffMaxAngularVelPitch), 1, 0)
    local v19 = math.tau * VehicleCameraConfig_upv_1.yawStiffness * fSpringYaw_1:step(a2)
    local v20 = (math.tau * VehicleCameraConfig_upv_1.pitchStiffness) * fSpringPitch_1:step(a2) * map_upv_1(a5, 0, 1, 1, VehicleCameraConfig_upv_1.firstPersonResponseMul)
    local v21 = v19 * map_upv_1(a5, 0, 1, 1, VehicleCameraConfig_upv_1.firstPersonResponseMul)
    local yawG_1 = a1.yawG
    local yawV_1 = a1.yawV
    local v22 = sanitizeAngle_upv_1(a1.yawP - yawG_1)
    local v23 = math.exp(-v21 * a2)
    a1.yawP = sanitizeAngle_upv_1((((v22 * (1 + (v21 * a2))) + (yawV_1 * a2)) * v23) + yawG_1)
    a1.yawV = ((yawV_1 * (1 - (v21 * a2))) - (v22 * ((v21 * v21) * a2))) * v23
    local pitchG_1 = a1.pitchG
    local pitchV_1 = a1.pitchV
    local v24 = sanitizeAngle_upv_1(a1.pitchP - pitchG_1)
    local v25 = math.exp(-v20 * a2)
    a1.pitchP = sanitizeAngle_upv_1((((v24 * (1 + (v20 * a2))) + (pitchV_1 * a2)) * v25) + pitchG_1)
    a1.pitchV = ((pitchV_1 * (1 - (v20 * a2))) - (v24 * ((v20 * v20) * a2))) * v25
    return a1:getCFrame()
end
local tbl_upv_4 = {}
tbl_upv_4.__index = tbl_upv_4
function tbl_upv_4.new(a1)
    --[[
      name: new
      line: 167
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    return (setmetatable({vrs = tbl_upv_2.new(a1)}, tbl_upv_4))
end
function tbl_upv_4.step(a1, a2, a3, a4, a5)
    --[[
      name: step
      line: 173
    ]]
    return a1.vrs:step(a2, a3, a4, a5)
end
function tbl_upv_4.setTransform(a1, a2)
    --[[
      name: setTransform
      line: 177
    ]]
    a1.vrs:setGoal(a2)
end
return tbl_upv_4