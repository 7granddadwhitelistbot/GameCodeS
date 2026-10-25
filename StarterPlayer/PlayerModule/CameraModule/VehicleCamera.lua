local tbl_upv_1 = {0, 15, 30}
local Players_1 = game:GetService("Players")
local RunService_1 = game:GetService("RunService")
local BaseCamera_upv_1 = require(script.Parent:WaitForChild("BaseCamera"))
local CameraInput_upv_1 = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils_upv_1 = require(script.Parent:WaitForChild("CameraUtils"))
local _ = require(script.Parent:WaitForChild("ZoomController"))
local VehicleCameraCore_upv_1 = require(script:WaitForChild("VehicleCameraCore"))
local VehicleCameraConfig_upv_1 = require(script:WaitForChild("VehicleCameraConfig"))
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local Spring_upv_1 = CameraUtils_upv_1.Spring
local mapClamp_upv_1 = CameraUtils_upv_1.mapClamp
local sanitizeAngle_upv_1 = CameraUtils_upv_1.sanitizeAngle
local function pitchVelocity(a1, a2)
    --[[
      name: pitchVelocity
      line: 31
    ]]
    return (math.abs(a2.XVector:Dot(a1)))
end
local function yawVelocity(a1, a2)
    --[[
      name: yawVelocity
      line: 36
    ]]
    return (math.abs(a2.YVector:Dot(a1)))
end
local u1 = 0.016666666666666666
RunService_1.Stepped:Connect(
    function(a1, a2)
        --[[
          line: 42
          upvalues:
            u1 (ref, index: 1)
        ]]
        u1 = a2
    end
)
local u2 = setmetatable({}, BaseCamera_upv_1)
u2.__index = u2
function u2.new()
    --[[
      name: new
      line: 49
      upvalues:
        BaseCamera_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    local v1 = setmetatable(BaseCamera_upv_1.new(), u2)
    v1:Reset()
    return v1
end
function u2.Reset(a1)
    --[[
      name: Reset
      line: 55
      upvalues:
        VehicleCameraCore_upv_1 (copy, index: 1)
        Spring_upv_1 (copy, index: 2)
        VehicleCameraConfig_upv_1 (copy, index: 3)
        CameraUtils_upv_1 (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
    ]]
    a1.vehicleCameraCore = VehicleCameraCore_upv_1.new(a1:GetSubjectCFrame())
    a1.pitchSpring = Spring_upv_1.new(0, -math.rad(VehicleCameraConfig_upv_1.pitchBaseAngle))
    a1.yawSpring = Spring_upv_1.new(0, 0)
    a1.lastPanTick = 0
    local CurrentCamera_1 = workspace.CurrentCamera
    local v2 = CurrentCamera_1 and (CurrentCamera_1.CameraSubject)
    assert(CurrentCamera_1)
    assert(v2)
    assert(v2:IsA("VehicleSeat"))
    local v3, v4 = CameraUtils_upv_1.getLooseBoundingSphere(v2:GetConnectedParts(true))
    a1.assemblyRadius = math.max(v4, 5)
    a1.assemblyOffset = v2.CFrame:Inverse() * v3
    a1.gamepadZoomLevels = {}
    for _, value_1 in tbl_upv_1 do
        table.insert(a1.gamepadZoomLevels, (value_1 * a1.assemblyRadius) / 10)
    end
    a1:SetCameraToSubjectDistance(a1.gamepadZoomLevels[#a1.gamepadZoomLevels])
end
function u2._StepRotation(a1, a2, a3)
    --[[
      name: _StepRotation
      line: 85
      upvalues:
        CameraInput_upv_1 (copy, index: 1)
        sanitizeAngle_upv_1 (copy, index: 2)
        VehicleCameraConfig_upv_1 (copy, index: 3)
        mapClamp_upv_1 (copy, index: 4)
    ]]
    local yawSpring_1 = a1.yawSpring
    local pitchSpring_1 = a1.pitchSpring
    local v5 = CameraInput_upv_1.getRotation(a2)
    yawSpring_1.pos = sanitizeAngle_upv_1(yawSpring_1.pos + -v5.X)
    pitchSpring_1.pos = sanitizeAngle_upv_1(math.clamp(pitchSpring_1.pos + -v5.Y, -1.3962634015954636, 1.3962634015954636))
    if CameraInput_upv_1.getRotationActivated() then
        a1.lastPanTick = os.clock()
    end
    local v6 = -math.rad(VehicleCameraConfig_upv_1.pitchBaseAngle)
    local v7 = math.rad(VehicleCameraConfig_upv_1.pitchDeadzoneAngle)
    if VehicleCameraConfig_upv_1.autocorrectDelay < os.clock() - a1.lastPanTick then
        v5 = mapClamp_upv_1(a3, VehicleCameraConfig_upv_1.autocorrectMinCarSpeed, VehicleCameraConfig_upv_1.autocorrectMaxCarSpeed, 0, VehicleCameraConfig_upv_1.autocorrectResponse)
        yawSpring_1.freq = v5
        pitchSpring_1.freq = v5
        if yawSpring_1.freq < 0.001 then
            yawSpring_1.vel = 0
        end
        if pitchSpring_1.freq < 0.001 then
            pitchSpring_1.vel = 0
        end
        if math.abs(sanitizeAngle_upv_1(v6 - pitchSpring_1.pos)) <= v7 then
            pitchSpring_1.goal = pitchSpring_1.pos
        else
            pitchSpring_1.goal = v6
        end
    else
        yawSpring_1.freq = 0
        yawSpring_1.vel = 0
        pitchSpring_1.freq = 0
        pitchSpring_1.vel = 0
        pitchSpring_1.goal = v6
    end
    return CFrame.fromEulerAnglesYXZ(pitchSpring_1:step(a2), yawSpring_1:step(a2), 0)
end
function u2._GetThirdPersonLocalOffset(a1)
    --[[
      name: _GetThirdPersonLocalOffset
      line: 148
      upvalues:
        VehicleCameraConfig_upv_1 (copy, index: 1)
    ]]
    return a1.assemblyOffset + Vector3.new(0, a1.assemblyRadius * VehicleCameraConfig_upv_1.verticalCenterOffset, 0)
end
function u2._GetFirstPersonLocalOffset(a1, a2)
    --[[
      name: _GetFirstPersonLocalOffset
      line: 152
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    if Character_1 and Character_1.Parent then
        local Head_1 = Character_1:FindFirstChild("Head")
        if Head_1 and Head_1:IsA("BasePart") then
            return a2:Inverse() * Head_1.Position
        end
    end
    return a1:_GetThirdPersonLocalOffset()
end
function u2.Update(a1)
    --[[
      name: Update
      line: 166
      upvalues:
        u1 (ref,  index: 1)
        mapClamp_upv_1 (copy, index: 2)
    ]]
    local CurrentCamera_2 = workspace.CurrentCamera
    local v8 = CurrentCamera_2 and (CurrentCamera_2.CameraSubject)
    local vehicleCameraCore_1 = a1.vehicleCameraCore
    assert(CurrentCamera_2)
    assert(v8)
    assert(v8:IsA("VehicleSeat"))
    local v9 = u1
    u1 = 0
    local v10 = a1:GetSubjectCFrame()
    local v11 = a1:GetSubjectVelocity()
    local v12 = a1:GetSubjectRotVelocity()
    local v13 = math.abs(v11:Dot(v10.ZVector))
    local v14 = math.abs(v10.YVector:Dot(v12))
    local v15 = math.abs(v10.XVector:Dot(v12))
    local v16 = a1:StepZoom(v9)
    local v17 = a1:_StepRotation(v9, v13)
    local v18 = mapClamp_upv_1(v16, 0.5, a1.assemblyRadius, 1, 0)
    local v19 = a1:_GetThirdPersonLocalOffset():Lerp(a1:_GetFirstPersonLocalOffset(v10), v18)
    vehicleCameraCore_1:setTransform(v10)
    local v20 = vehicleCameraCore_1:step(v9, v15, v14, v18)
    local v21 = CFrame.new(v10 * v19) * v20 * v17
    return v21 * CFrame.new(0, 0, v16), v21
end
return u2