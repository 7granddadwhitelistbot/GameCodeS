local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local UserGameSettings_upv_1 = UserSettings():GetService("UserGameSettings")
local tbl_upv_1 = {}
local function round(a1)
    --[[
      name: round
      line: 12
    ]]
    return (math.floor(a1 + 0.5))
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
function tbl_upv_2.new(a1, a2)
    --[[
      name: new
      line: 21
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return (setmetatable({vel = 0, freq = a1, goal = a2, pos = a2}, tbl_upv_2))
end
function tbl_upv_2.step(a1, a2)
    --[[
      name: step
      line: 31
    ]]
    local v1 = a1.freq * 2 * math.pi
    local goal_1 = a1.goal
    local vel_1 = a1.vel
    local v2 = a1.pos - goal_1
    local v3 = math.exp(-v1 * a2)
    local v4 = ((v2 * ((v1 * a2) + 1)) + (vel_1 * a2)) * v3 + goal_1
    a1.pos = v4
    a1.vel = ((vel_1 * (1 - (v1 * a2))) - (v2 * ((v1 * v1) * a2))) * v3
    return v4
end
tbl_upv_1.Spring = tbl_upv_2
function tbl_upv_1.map(a1, a2, a3, a4, a5)
    --[[
      name: map
      line: 53
    ]]
    return (((a1 - a2) * (a5 - a4)) / (a3 - a2)) + a4
end
function tbl_upv_1.mapClamp(a1, a2, a3, a4, a5)
    --[[
      name: mapClamp
      line: 58
    ]]
    return (math.clamp((((a1 - a2) * (a5 - a4)) / (a3 - a2)) + a4, math.min(a4, a5), math.max(a4, a5)))
end
function tbl_upv_1.getLooseBoundingSphere(a1)
    --[[
      name: getLooseBoundingSphere
      line: 67
    ]]
    local v5 = table.create(#a1)
    for key_1, value_1 in pairs(a1) do
        v5[key_1] = value_1.Position
    end
    local v6 = v5[1]
    local Magnitude_1 = 0
    local v7 = v6
    for _, value_2 in ipairs(v5) do
        local Magnitude_2 = (value_2 - v6).Magnitude
        if Magnitude_1 < Magnitude_2 then
            Magnitude_1, v7 = Magnitude_2, value_2
        end
    end
    local v8 = 0
    local v9
    v9, Magnitude_1 = v8, v7
    for _, value_3 in ipairs(v5) do
        local Magnitude_3 = (value_3 - v7).Magnitude
        if v9 < Magnitude_3 then
            v9, Magnitude_1 = Magnitude_3, value_3
        end
    end
    local v10 = (v7 + Magnitude_1) * 0.5
    local v11 = (v7 - Magnitude_1).Magnitude * 0.5
    local v12
    v9, v12 = v10, v11
    for _, value_4 in ipairs(v5) do
        Magnitude_1 = (value_4 - v9).Magnitude
        if v12 < Magnitude_1 then
            v9, v12 = v9 + ((Magnitude_1 - v12) * 0.5) * (value_4 - v9).Unit, (Magnitude_1 + v12) * 0.5
        end
    end
    return v9, v12
end
function tbl_upv_1.sanitizeAngle(a1)
    --[[
      name: sanitizeAngle
      line: 123
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
function tbl_upv_1.Round(a1, a2)
    --[[
      name: Round
      line: 128
    ]]
    local v13 = 10 ^ a2
    return math.floor((a1 * v13) + 0.5) / v13
end
function tbl_upv_1.IsFinite(a1)
    --[[
      name: IsFinite
      line: 133
    ]]
    return (a1 == a1) and ((a1 ~= math.huge) and (a1 ~= -math.huge))
end
function tbl_upv_1.IsFiniteVector3(a1)
    --[[
      name: IsFiniteVector3
      line: 137
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v14 = tbl_upv_1.IsFinite(a1.X) and (tbl_upv_1.IsFinite(a1.Y) and (tbl_upv_1.IsFinite(a1.Z)))
    return v14
end
function tbl_upv_1.GetAngleBetweenXZVectors(a1, a2)
    --[[
      name: GetAngleBetweenXZVectors
      line: 142
    ]]
    return (math.atan2((a2.X * a1.Z) - (a2.Z * a1.X), (a2.X * a1.X) + (a2.Z * a1.Z)))
end
function tbl_upv_1.RotateVectorByAngleAndRound(a1, a2, a3)
    --[[
      name: RotateVectorByAngleAndRound
      line: 146
    ]]
    if not (a1.Magnitude > 0) then
        return 0
    end
    local Unit_1 = a1.Unit
    local v15 = math.atan2(Unit_1.Z, Unit_1.X)
    return (math.floor(((math.atan2(Unit_1.Z, Unit_1.X) + a2) / a3) + 0.5) * a3) - v15
end
local function SCurveTranform(a1)
    --[[
      name: SCurveTranform
      line: 160
    ]]
    local v16 = math.clamp(a1, -1, 1)
    if v16 >= 0 then
        return (v16 * 0.35) / ((0.35 - v16) + 1)
    end
    return -((-v16 * 0.8) / ((v16 + 0.8) + 1))
end
local function toSCurveSpace(a1)
    --[[
      name: toSCurveSpace
      line: 169
    ]]
    return (((math.abs(a1) * 2) - 1) * 1.1) - 0.1
end
local function fromSCurveSpace(a1)
    --[[
      name: fromSCurveSpace
      line: 173
    ]]
    return (a1 / 2) + 0.5
end
function tbl_upv_1.GamepadLinearToCurve(a1)
    --[[
      name: GamepadLinearToCurve
      line: 177
    ]]
    local function onAxis(a2)
        --[[
          name: onAxis
          line: 178
        ]]
        local v17 = ((a2 < 0) and -1) or 1
        local v18 = math.clamp((((math.abs(math.abs(a2)) * 2) - 1) * 1.1) - 0.1, -1, 1)
        return (math.clamp((((((v18 >= 0) and (v18 * 0.35 / ((0.35 - v18) + 1))) or (-((-v18 * 0.8) / ((v18 + 0.8) + 1)))) / 2) + 0.5) * v17, -1, 1))
    end
    local X_1 = a1.X
    local v19 = ((X_1 < 0) and -1) or 1
    local v20 = math.clamp((((math.abs(math.abs(X_1)) * 2) - 1) * 1.1) - 0.1, -1, 1)
    local v21 = math.clamp((((((v20 >= 0) and (v20 * 0.35 / ((0.35 - v20) + 1))) or (-((-v20 * 0.8) / ((v20 + 0.8) + 1)))) / 2) + 0.5) * v19, -1, 1)
    local Y_1 = a1.Y
    local v22 = ((Y_1 < 0) and -1) or 1
    local v23 = math.clamp((((math.abs(math.abs(Y_1)) * 2) - 1) * 1.1) - 0.1, -1, 1)
    return Vector2.new(v21, math.clamp((((((v23 >= 0) and (v23 * 0.35 / ((0.35 - v23) + 1))) or (-((-v23 * 0.8) / ((v23 + 0.8) + 1)))) / 2) + 0.5) * v22, -1, 1))
end
function tbl_upv_1.ConvertCameraModeEnumToStandard(a1)
    --[[
      name: ConvertCameraModeEnumToStandard
      line: 191
    ]]
    if a1 ~= Enum.TouchCameraMovementMode.Default then
        if a1 ~= Enum.ComputerCameraMovementMode.Default and a1 ~= Enum.TouchCameraMovementMode.Classic and a1 ~= Enum.DevTouchCameraMovementMode.Classic and a1 ~= Enum.DevComputerCameraMovementMode.Classic and a1 ~= Enum.ComputerCameraMovementMode.Classic then
            if a1 ~= Enum.TouchCameraMovementMode.Follow and a1 ~= Enum.DevTouchCameraMovementMode.Follow and a1 ~= Enum.DevComputerCameraMovementMode.Follow and a1 ~= Enum.ComputerCameraMovementMode.Follow then
                if a1 ~= Enum.TouchCameraMovementMode.Orbital and a1 ~= Enum.DevTouchCameraMovementMode.Orbital and a1 ~= Enum.DevComputerCameraMovementMode.Orbital and a1 ~= Enum.ComputerCameraMovementMode.Orbital then
                    if a1 ~= Enum.ComputerCameraMovementMode.CameraToggle and a1 ~= Enum.DevComputerCameraMovementMode.CameraToggle then
                        if a1 ~= Enum.DevTouchCameraMovementMode.UserChoice and a1 ~= Enum.DevComputerCameraMovementMode.UserChoice then
                            return Enum.ComputerCameraMovementMode.Classic
                        end
                        return Enum.DevComputerCameraMovementMode.UserChoice
                    end
                    return Enum.ComputerCameraMovementMode.CameraToggle
                end
                return Enum.ComputerCameraMovementMode.Orbital
            end
            return Enum.ComputerCameraMovementMode.Follow
        end
        return Enum.ComputerCameraMovementMode.Classic
    end
    return Enum.ComputerCameraMovementMode.Follow
end
local function getMouse()
    --[[
      name: getMouse
      line: 240
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    if not (LocalPlayer_1) then
        Players_upv_1:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer_1 = Players_upv_1.LocalPlayer
    end
    assert(LocalPlayer_1)
    return LocalPlayer_1:GetMouse()
end
local Icon_upv_1 = ""
local u1 = nil
function tbl_upv_1.setMouseIconOverride(a1)
    --[[
      name: setMouseIconOverride
      line: 252
      upvalues:
        Players_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        Icon_upv_1 (ref,  index: 3)
    ]]
    local LocalPlayer_2 = Players_upv_1.LocalPlayer
    if not (LocalPlayer_2) then
        Players_upv_1:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer_2 = Players_upv_1.LocalPlayer
    end
    assert(LocalPlayer_2)
    local v24 = LocalPlayer_2:GetMouse()
    if v24.Icon ~= u1 then
        Icon_upv_1 = v24.Icon
    end
    v24.Icon = a1
    u1 = a1
end
function tbl_upv_1.restoreMouseIcon()
    --[[
      name: restoreMouseIcon
      line: 263
      upvalues:
        Players_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        Icon_upv_1 (ref,  index: 3)
    ]]
    local LocalPlayer_3 = Players_upv_1.LocalPlayer
    if not (LocalPlayer_3) then
        Players_upv_1:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer_3 = Players_upv_1.LocalPlayer
    end
    assert(LocalPlayer_3)
    local v25 = LocalPlayer_3:GetMouse()
    if v25.Icon == u1 then
        v25.Icon = Icon_upv_1
    end
    u1 = nil
end
local u2 = Enum.MouseBehavior.Default
local u3 = nil
function tbl_upv_1.setMouseBehaviorOverride(a1)
    --[[
      name: setMouseBehaviorOverride
      line: 274
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u2 (ref,  index: 3)
    ]]
    if UserInputService_upv_1.MouseBehavior ~= u3 then
        u2 = UserInputService_upv_1.MouseBehavior
    end
    UserInputService_upv_1.MouseBehavior = a1
    u3 = a1
end
function tbl_upv_1.restoreMouseBehavior()
    --[[
      name: restoreMouseBehavior
      line: 283
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u2 (ref,  index: 3)
    ]]
    if UserInputService_upv_1.MouseBehavior == u3 then
        UserInputService_upv_1.MouseBehavior = u2
    end
    u3 = nil
end
local u4 = Enum.RotationType.MovementRelative
local u5 = nil
function tbl_upv_1.setRotationTypeOverride(a1)
    --[[
      name: setRotationTypeOverride
      line: 292
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        u5 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    if UserGameSettings_upv_1.RotationType ~= u5 then
        u4 = UserGameSettings_upv_1.RotationType
    end
    UserGameSettings_upv_1.RotationType = a1
    u5 = a1
end
function tbl_upv_1.restoreRotationType()
    --[[
      name: restoreRotationType
      line: 301
      upvalues:
        UserGameSettings_upv_1 (copy, index: 1)
        u5 (ref,  index: 2)
        u4 (ref,  index: 3)
    ]]
    if UserGameSettings_upv_1.RotationType == u5 then
        UserGameSettings_upv_1.RotationType = u4
    end
    u5 = nil
end
return tbl_upv_1