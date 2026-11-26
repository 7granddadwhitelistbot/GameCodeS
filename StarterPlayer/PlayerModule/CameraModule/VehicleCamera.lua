local v1 = {0, 15, 30}
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
require(script.Parent:WaitForChild("ZoomController"))
local VehicleCameraCore = require(script:WaitForChild("VehicleCameraCore"))
local VehicleCameraConfig = require(script:WaitForChild("VehicleCameraConfig"))
local localPlayer = players.LocalPlayer
local _ = CameraUtils.map
local spring = CameraUtils.Spring
local mapClamp = CameraUtils.mapClamp
local sanitizeAngle = CameraUtils.sanitizeAngle

local function pitchVelocity(a15, a16)
    --[[
      name: pitchVelocity
      line: 31
    ]]
    return (math.abs((a16.XVector:Dot(a15))))
end

local function yawVelocity(a18, a19)
    --[[
      name: yawVelocity
      line: 36
    ]]
    return (math.abs((a19.YVector:Dot(a18))))
end

local deltaTime = 0.016666666666666666
runService.Stepped:Connect(
    function(time: number, deltaTime2: number)
        --[[
          line: 42
          upvalues:
            deltaTime (ref, index: 1)
        ]]
        deltaTime = deltaTime2
    end
)
local v23 = setmetatable({}, BaseCamera)
v23.__index = v23

function v23.new()
    --[[
      name: new
      line: 49
      upvalues:
        BaseCamera (copy, index: 1)
        v23 (copy, index: 2)
    ]]
    local v24 = setmetatable(BaseCamera.new(), v23)
    v24:Reset()

    return v24
end

function v23.Reset(self)
    --[[
      name: Reset
      line: 55
      upvalues:
        VehicleCameraCore (copy, index: 1)
        spring (copy, index: 2)
        VehicleCameraConfig (copy, index: 3)
        CameraUtils (copy, index: 4)
        v1 (copy, index: 5)
    ]]
    local instance
    self.vehicleCameraCore = VehicleCameraCore.new(self:GetSubjectCFrame())
    self.pitchSpring = spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle))
    self.yawSpring = spring.new(0, 0)
    self.lastPanTick = 0
    local camera = workspace.CurrentCamera
    local camera2 = camera

    if camera2 then
        instance = camera.CameraSubject
    else
        instance = camera2
    end

    assert(camera)
    assert(instance)
    assert(instance:IsA("VehicleSeat"))
    local connectedParts = instance:GetConnectedParts(true)
    local looseBoundingSphere, v31 = CameraUtils.getLooseBoundingSphere(connectedParts)
    self.assemblyRadius = math.max(v31, 5)
    self.assemblyOffset = instance.CFrame:Inverse() * looseBoundingSphere
    self.gamepadZoomLevels = {}

    for _, v33 in v1 do
        table.insert(self.gamepadZoomLevels, (v33 * self.assemblyRadius) / 10)
    end

    self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
end

function v23._StepRotation(a34, a35, a36)
    --[[
      name: _StepRotation
      line: 85
      upvalues:
        CameraInput (copy, index: 1)
        sanitizeAngle (copy, index: 2)
        VehicleCameraConfig (copy, index: 3)
        mapClamp (copy, index: 4)
    ]]
    local yawSpring = a34.yawSpring
    local pitchSpring = a34.pitchSpring
    local rotation = CameraInput.getRotation(a35)
    local v40 = -rotation.X
    local v41 = -rotation.Y
    yawSpring.pos = sanitizeAngle(yawSpring.pos + v40)
    pitchSpring.pos = sanitizeAngle((math.clamp(pitchSpring.pos + v41, -1.3962634015954636, 1.3962634015954636)))

    if CameraInput.getRotationActivated() then
        a34.lastPanTick = os.clock()
    end

    local goal = -math.rad(VehicleCameraConfig.pitchBaseAngle)
    local v43 = math.rad(VehicleCameraConfig.pitchDeadzoneAngle)
    local v44 = os.clock() - a34.lastPanTick

    if VehicleCameraConfig.autocorrectDelay < v44 then
        local freq = mapClamp(a36, VehicleCameraConfig.autocorrectMinCarSpeed, VehicleCameraConfig.autocorrectMaxCarSpeed, 0, VehicleCameraConfig.autocorrectResponse)
        yawSpring.freq = freq
        pitchSpring.freq = freq

        if yawSpring.freq < 0.001 then
            yawSpring.vel = 0
        end

        if pitchSpring.freq < 0.001 then
            pitchSpring.vel = 0
        end

        if math.abs((sanitizeAngle(goal - pitchSpring.pos))) <= v43 then
            pitchSpring.goal = pitchSpring.pos
        else
            pitchSpring.goal = goal
        end
    else
        yawSpring.freq = 0
        yawSpring.vel = 0
        pitchSpring.freq = 0
        pitchSpring.vel = 0
        pitchSpring.goal = goal
    end

    return CFrame.fromEulerAnglesYXZ(pitchSpring:step(a35), yawSpring:step(a35), 0)
end

function v23._GetThirdPersonLocalOffset(a46)
    --[[
      name: _GetThirdPersonLocalOffset
      line: 144
      upvalues:
        VehicleCameraConfig (copy, index: 1)
    ]]
    return a46.assemblyOffset + Vector3.new(0, a46.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0)
end

function v23._GetFirstPersonLocalOffset(a47, a48)
    --[[
      name: _GetFirstPersonLocalOffset
      line: 148
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer.Character

    if character and character.Parent then
        local head = character:FindFirstChild("Head")

        if head and head:IsA("BasePart") then
            return a48:Inverse() * head.Position
        end
    end

    return a47:_GetThirdPersonLocalOffset()
end

function v23.Update(a51)
    --[[
      name: Update
      line: 162
      upvalues:
        deltaTime (ref,  index: 1)
        mapClamp (copy, index: 2)
    ]]
    local camera = workspace.CurrentCamera
    local cameraSubject = camera and camera.CameraSubject
    local vehicleCameraCore = a51.vehicleCameraCore
    assert(camera)
    assert(cameraSubject)
    assert(cameraSubject:IsA("VehicleSeat"))
    local deltaTime2 = deltaTime
    deltaTime = 0
    local transform = a51:GetSubjectCFrame()
    local subjectVelocity = a51:GetSubjectVelocity()
    local subjectRotVelocity = a51:GetSubjectRotVelocity()
    local absoluteValue = math.abs((subjectVelocity:Dot(transform.ZVector)))
    local absoluteValue2 = math.abs((transform.YVector:Dot(subjectRotVelocity)))
    local absoluteValue3 = math.abs((transform.XVector:Dot(subjectRotVelocity)))
    local z = a51:StepZoom(deltaTime2)
    local v63 = a51:_StepRotation(deltaTime2, absoluteValue)
    local alpha = mapClamp(z, 0.5, a51.assemblyRadius, 1, 0)
    local startValue = a51:_GetThirdPersonLocalOffset()
    local interpolatedValue = startValue:Lerp(a51:_GetFirstPersonLocalOffset(transform), alpha)
    vehicleCameraCore:setTransform(transform)
    local v67 = vehicleCameraCore:step(deltaTime2, absoluteValue3, absoluteValue2, alpha)
    local v68 = CFrame.new(transform * interpolatedValue) * v67 * v63

    return v68 * CFrame.new(0, 0, z), v68
end

return v23