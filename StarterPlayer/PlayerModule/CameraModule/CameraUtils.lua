local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local v3 = UserSettings():GetService("UserGameSettings")
local v4 = {}

local function round(a6)
    --[[
      name: round
      line: 12
    ]]
    return (math.floor(a6 + 0.5))
end

local Spring = {}
Spring.__index = Spring

function Spring.new(freq, a9)
    --[[
      name: new
      line: 22
      upvalues:
        Spring (copy, index: 1)
    ]]
    return (setmetatable({vel = 0, freq = freq, goal = a9, pos = a9}, Spring))
end

function Spring.step(self, a11)
    --[[
      name: step
      line: 32
    ]]
    local v12 = self.freq * 2 * math.pi
    local goal = self.goal
    local pos = self.pos
    local vel = self.vel
    local v16 = pos - goal
    local v17 = math.exp(-v12 * a11)
    local pos2 = (v16 * ((v12 * a11) + 1) + (vel * a11)) * v17 + goal
    self.pos, self.vel = pos2, (vel * (1 - (v12 * a11)) - (v16 * ((v12 * v12) * a11))) * v17

    return pos2
end

v4.Spring = Spring

function v4.map(a19, a20, a21, a22, a23)
    --[[
      name: map
      line: 54
    ]]
    return ((a19 - a20) * (a23 - a22) / (a21 - a20)) + a22
end

function v4.mapClamp(a24, a25, a26, a27: number, a28: number)
    --[[
      name: mapClamp
      line: 59
    ]]
    return (math.clamp(((a24 - a25) * (a28 - a27) / (a26 - a25)) + a27, math.min(a27, a28), (math.max(a27, a28))))
end

function v4.getLooseBoundingSphere(a29)
    --[[
      name: getLooseBoundingSphere
      line: 68
    ]]
    local value
    local value2
    local values = table.create(#a29)

    for valueKey, v34 in pairs(a29) do
        values[valueKey] = v34.Position
    end

    local value3 = values[1]
    local maxMagnitude = 0
    value = value3

    for _, value4 in ipairs(values) do
        local magnitude = (value4 - value3).Magnitude

        if maxMagnitude < magnitude then
            maxMagnitude, value = magnitude, value4
        end
    end

    local maxMagnitude2 = 0
    value2 = value

    for _, value5 in ipairs(values) do
        local magnitude = (value5 - value).Magnitude

        if maxMagnitude2 < magnitude then
            maxMagnitude2, value2 = magnitude, value5
        end
    end

    local v44 = (value + value2) * 0.5
    local v45 = (value - value2).Magnitude * 0.5

    for _, value6 in ipairs(values) do
        local magnitude = (value6 - v44).Magnitude

        if v45 < magnitude then
            v44 += (magnitude - v45) * 0.5 * (value6 - v44).Unit
            v45 = (magnitude + v45) * 0.5
        end
    end

    return v44, v45
end

function v4.sanitizeAngle(a49)
    --[[
      name: sanitizeAngle
      line: 124
    ]]
    return ((a49 + math.pi) % math.tau) - math.pi
end

function v4.Round(a50, a51)
    --[[
      name: Round
      line: 129
    ]]
    local v52 = 10 ^ a51
    return math.floor((a50 * v52) + 0.5) / v52
end

function v4.IsFinite(a53)
    --[[
      name: IsFinite
      line: 134
    ]]
    return a53 == a53 and a53 ~= math.huge and (a53 ~= -math.huge)
end

function v4.IsFiniteVector3(a54)
    --[[
      name: IsFiniteVector3
      line: 138
      upvalues:
        v4 (copy, index: 1)
    ]]
    return v4.IsFinite(a54.X) and v4.IsFinite(a54.Y) and v4.IsFinite(a54.Z)
end

function v4.GetAngleBetweenXZVectors(a55, a56)
    --[[
      name: GetAngleBetweenXZVectors
      line: 143
    ]]
    return (math.atan2((a56.X * a55.Z) - (a56.Z * a55.X), a56.X * a55.X + (a56.Z * a55.Z)))
end

function v4.RotateVectorByAngleAndRound(a57, a58, a59)
    --[[
      name: RotateVectorByAngleAndRound
      line: 147
    ]]
    if 0 < a57.Magnitude then
        local unit = a57.Unit
        local v61 = math.atan2(unit.Z, unit.X)

        return (math.floor(((math.atan2(unit.Z, unit.X) + a58) / a59) + 0.5) * a59) - v61
    end

    return 0
end

local function SCurveTranform(a63: number)
    --[[
      name: SCurveTranform
      line: 161
    ]]
    local clampedValue = math.clamp(a63, -1, 1)

    if not (0 <= clampedValue) then
        return -(-clampedValue * 0.8 / ((clampedValue + 0.8) + 1))
    end

    return clampedValue * 0.35 / ((0.35 - clampedValue) + 1)
end

local function toSCurveSpace(a66: number)
    --[[
      name: toSCurveSpace
      line: 170
    ]]
    return (((math.abs(a66) * 2) - 1) * 1.1) - 0.1
end

local function fromSCurveSpace(a68)
    --[[
      name: fromSCurveSpace
      line: 174
    ]]
    return (a68 / 2) + 0.5
end

function v4.GamepadLinearToCurve(a69)
    --[[
      name: GamepadLinearToCurve
      line: 178
    ]]
    local v70
    local v71, newVector2

    local function onAxis(a74: number)
        --[[
          name: onAxis
          line: 179
        ]]
        local v75
        local v76 = 1

        if a74 < 0 then
            v76 = -1
        end

        local clampedValue = math.clamp((((math.abs((math.abs(a74))) * 2) - 1) * 1.1) - 0.1, -1, 1)

        if not (0 <= clampedValue) then
            v75 = -(-clampedValue * 0.8 / ((clampedValue + 0.8) + 1))
        else
            v75 = clampedValue * 0.35 / ((0.35 - clampedValue) + 1)
        end

        return (math.clamp(((v75 / 2) + 0.5) * v76, -1, 1))
    end

    local newVector22 = Vector2.new
    local x = a69.X
    local v80 = 1

    if x < 0 then
        v80 = -1
    end

    local clampedValue = math.clamp((((math.abs((math.abs(x))) * 2) - 1) * 1.1) - 0.1, -1, 1)

    if not (0 <= clampedValue) then
        v70 = -(-clampedValue * 0.8 / ((clampedValue + 0.8) + 1))
    else
        v70 = clampedValue * 0.35 / ((0.35 - clampedValue) + 1)
    end

    local x2 = math.clamp(((v70 / 2) + 0.5) * v80, -1, 1)
    local y = a69.Y
    local v84 = 1

    if y < 0 then
        v84 = -1
    end

    local clampedValue2 = math.clamp((((math.abs((math.abs(y))) * 2) - 1) * 1.1) - 0.1, -1, 1)

    if not (0 <= clampedValue2) then
        v71 = -(-clampedValue2 * 0.8 / ((clampedValue2 + 0.8) + 1))
        newVector2 = newVector22
    else
        v71 = clampedValue2 * 0.35 / ((0.35 - clampedValue2) + 1)
        newVector2 = newVector22
    end

    return newVector2(x2, (math.clamp(((v71 / 2) + 0.5) * v84, -1, 1)))
end

function v4.ConvertCameraModeEnumToStandard(a86)
    --[[
      name: ConvertCameraModeEnumToStandard
      line: 192
    ]]
    if a86 == Enum.TouchCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Follow
    end
    if a86 == Enum.ComputerCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Classic
    end
    if a86 == Enum.TouchCameraMovementMode.Classic
        or a86 == Enum.DevTouchCameraMovementMode.Classic
        or a86 == Enum.DevComputerCameraMovementMode.Classic
        or a86 == Enum.ComputerCameraMovementMode.Classic
    then
        return Enum.ComputerCameraMovementMode.Classic
    end
    if a86 == Enum.TouchCameraMovementMode.Follow
        or a86 == Enum.DevTouchCameraMovementMode.Follow
        or a86 == Enum.DevComputerCameraMovementMode.Follow
        or a86 == Enum.ComputerCameraMovementMode.Follow
    then
        return Enum.ComputerCameraMovementMode.Follow
    end
    if a86 == Enum.TouchCameraMovementMode.Orbital
        or a86 == Enum.DevTouchCameraMovementMode.Orbital
        or a86 == Enum.DevComputerCameraMovementMode.Orbital
        or a86 == Enum.ComputerCameraMovementMode.Orbital
    then
        return Enum.ComputerCameraMovementMode.Orbital
    end
    if a86 == Enum.ComputerCameraMovementMode.CameraToggle or a86 == Enum.DevComputerCameraMovementMode.CameraToggle then
        return Enum.ComputerCameraMovementMode.CameraToggle
    end
    if a86 ~= Enum.DevTouchCameraMovementMode.UserChoice and a86 ~= Enum.DevComputerCameraMovementMode.UserChoice then
        return Enum.ComputerCameraMovementMode.Classic
    end

    return Enum.DevComputerCameraMovementMode.UserChoice
end

local function getMouse()
    --[[
      name: getMouse
      line: 249
      upvalues:
        players (copy, index: 1)
    ]]
    local localPlayer = players.LocalPlayer
    if not localPlayer then
        players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = players.LocalPlayer
    end

    assert(localPlayer)

    return localPlayer:GetMouse()
end

local icon = ""
local v90 = nil

function v4.setMouseIconOverride(mouseIconOverride: string)
    --[[
      name: setMouseIconOverride
      line: 261
      upvalues:
        players (copy, index: 1)
        v90 (ref,  index: 2)
        icon (ref,  index: 3)
    ]]
    local localPlayer = players.LocalPlayer
    if not localPlayer then
        players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = players.LocalPlayer
    end

    assert(localPlayer)
    local mouse = localPlayer:GetMouse()

    if mouse.Icon ~= v90 then
        icon = mouse.Icon
    end

    mouse.Icon = mouseIconOverride
    v90 = mouseIconOverride
end

function v4.restoreMouseIcon()
    --[[
      name: restoreMouseIcon
      line: 272
      upvalues:
        players (copy, index: 1)
        v90 (ref,  index: 2)
        icon (ref,  index: 3)
    ]]
    local localPlayer = players.LocalPlayer
    if not localPlayer then
        players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = players.LocalPlayer
    end

    assert(localPlayer)
    local mouse = localPlayer:GetMouse()

    if mouse.Icon == v90 then
        mouse.Icon = icon
    end

    v90 = nil
end

local mouseBehavior = Enum.MouseBehavior.Default
local mouseBehavior2 = nil

function v4.setMouseBehaviorOverride(mouseBehaviorOverride: Enum.MouseBehavior)
    --[[
      name: setMouseBehaviorOverride
      line: 283
      upvalues:
        userInputService (copy, index: 1)
        mouseBehavior2 (ref,  index: 2)
        mouseBehavior (ref,  index: 3)
    ]]
    if userInputService.MouseBehavior ~= mouseBehavior2 then
        mouseBehavior = userInputService.MouseBehavior
    end

    userInputService.MouseBehavior = mouseBehaviorOverride
    mouseBehavior2 = mouseBehaviorOverride
end

function v4.restoreMouseBehavior()
    --[[
      name: restoreMouseBehavior
      line: 292
      upvalues:
        userInputService (copy, index: 1)
        mouseBehavior2 (ref,  index: 2)
        mouseBehavior (ref,  index: 3)
    ]]
    if userInputService.MouseBehavior == mouseBehavior2 then
        userInputService.MouseBehavior = mouseBehavior
    end

    mouseBehavior2 = nil
end

local v99 = Enum.RotationType.MovementRelative
local v100 = nil

function v4.setRotationTypeOverride(rotationTypeOverride)
    --[[
      name: setRotationTypeOverride
      line: 301
      upvalues:
        v3 (copy, index: 1)
        v100 (ref,  index: 2)
        v99 (ref,  index: 3)
    ]]
    if v3.RotationType ~= v100 then
        v99 = v3.RotationType
    end

    v3.RotationType = rotationTypeOverride
    v100 = rotationTypeOverride
end

function v4.restoreRotationType()
    --[[
      name: restoreRotationType
      line: 310
      upvalues:
        v3 (copy, index: 1)
        v100 (ref,  index: 2)
        v99 (ref,  index: 3)
    ]]
    if v3.RotationType == v100 then
        v3.RotationType = v99
    end

    v100 = nil
end

return v4