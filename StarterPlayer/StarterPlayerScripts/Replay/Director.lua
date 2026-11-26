local workspace = game:GetService("Workspace")
local v2 = {}
local v3 = 1
local v4 = {yaw = 0, pitch = -0.13962634015954636, fov = 70, pivotY = 0, aimW = 0, aimFovW = 0, punch = 0, deadAt = nil, orbit = 0, duration = 10, seg = 1, arm = 1, offset = Vector3.new(2.9000000953674316, 0, 10.5), action = 0, actionWant = 0, aimed = false, fpW = 0, firstPerson = false, segments = {}}
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.IgnoreWater = true

local function yawOf(a7)
    --[[
      name: yawOf
      line: 105
    ]]
    local lookVector = a7.LookVector
    return (math.atan2(-lookVector.X, -lookVector.Z))
end

local function wrap(a10)
    --[[
      name: wrap
      line: 110
    ]]
    return ((a10 + math.pi) % math.tau) - math.pi
end

local function ease(a12: number)
    --[[
      name: ease
      line: 114
    ]]
    return 1 - ((function(...) return (...) ^ 3 end)(((1 - math.clamp(a12, 0, 1)))))
end

local function yawPitchOf(a14)
    --[[
      name: yawPitchOf
      line: 119
    ]]
    local unit = a14.Unit
    return math.atan2(-unit.X, -unit.Z), (math.asin((math.clamp(unit.Y, -1, 1))))
end

function v2.SetWorld(world)
    --[[
      name: SetWorld
      line: 125
      upvalues:
        params (copy, index: 1)
    ]]
    params.FilterDescendantsInstances = world
end

function v2.SetSegments(segments)
    --[[
      name: SetSegments
      line: 130
      upvalues:
        v4 (copy, index: 1)
    ]]
    table.sort(
        segments,
        function(left, right)
            --[[
              line: 131
            ]]
            return left.t0 < right.t0
        end
    )
    v4.segments = segments
    v4.seg = 1
end

function v2.SetShoulderSide(shoulderSide)
    --[[
      name: SetShoulderSide
      line: 138
      upvalues:
        v3 (ref, index: 1)
    ]]
    v3 = not (shoulderSide < 0) and 1 or -1
end

function v2.Begin(a21, duration)
    --[[
      name: Begin
      line: 142
      upvalues:
        v4 (copy, index: 1)
    ]]
    local lookVector = a21.LookVector
    v4.yaw = math.atan2(-lookVector.X, -lookVector.Z)
    v4.pitch = -0.13962634015954636
    v4.fov = 70
    v4.pivotY = a21.Position.Y + 3.1
    v4.aimW = 0
    v4.aimFovW = 0
    v4.punch = 0
    v4.deadAt = nil
    v4.orbit = 0
    v4.duration = duration
    v4.seg = 1
    v4.arm = 1
    v4.offset = Vector3.new(2.9000000953674316, 0, 10.5)
    v4.action = 0
    v4.actionWant = 0
    v4.aimed = false
    v4.fpW = 0
    v4.firstPerson = false
end

function v2.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 164
      upvalues:
        v4 (copy, index: 1)
    ]]
    return v4.firstPerson
end

function v2.SetAction(action: number)
    --[[
      name: SetAction
      line: 169
      upvalues:
        v4 (copy, index: 1)
    ]]
    v4.actionWant = math.clamp(action, 0, 1)
end

function v2.SetAimed(aimed)
    --[[
      name: SetAimed
      line: 174
      upvalues:
        v4 (copy, index: 1)
    ]]
    v4.aimed = aimed
end

function v2.OnKill()
    --[[
      name: OnKill
      line: 178
      upvalues:
        v4 (copy, index: 1)
    ]]
    v4.punch = 1
end

function v2.OnShot(a26, a27)
    --[[
      name: OnShot
      line: 183
    ]]
end

local function aimAt(deadAt)
    --[[
      name: aimAt
      line: 186
      upvalues:
        v4 (copy, index: 1)
    ]]
    local segment
    local segments = v4.segments

    while v4.seg <= #segments and segments[v4.seg].t1 < deadAt do
        v4.seg += 1
    end

    local clampedValue = 0
    segment = nil

    for segmentKey = math.max(1, v4.seg - 1), math.min(#segments, v4.seg + 1) do
        local segment2 = segments[segmentKey]
        local clampedValue2 = 0

        if segment2.t0 <= deadAt and deadAt <= segment2.t1 then
            local v36 = (deadAt - segment2.t0) / 0.28
            local v37 = (segment2.t1 - deadAt) / 0.4
            local v38 = not (deadAt <= segment2.shot) and 0 or 1
            clampedValue2 = math.clamp(math.min(1, v36, v37 + v38), 0, 1)
        end

        if clampedValue < clampedValue2 then
            clampedValue, segment = clampedValue2, segment2
        end
    end

    if segment then
        return clampedValue, segment.point
    end

    return clampedValue, nil
end

local function candidate(a40, x: number, z: number)
    --[[
      name: candidate
      line: 207
    ]]
    if a40 == 1 then
        return (Vector3.new(x, 0, z))
    end
    if a40 == 2 then
        return (Vector3.new(-x, 0, z))
    end
    if a40 == 3 then
        return (Vector3.new(x * 0.7, -1.6, z * 0.8))
    end

    return (Vector3.new(x * 0.7, 2.2, z * 0.85))
end

local function freeLength(position: Vector3, direction: Vector3)
    --[[
      name: freeLength
      line: 219
      upvalues:
        workspace (copy, index: 1)
        params (copy, index: 2)
    ]]
    local magnitude = direction.Magnitude

    return if magnitude < 0.001 then 0 elseif const raycastResult = workspace:Spherecast(position, 0.6, direction, params) then raycastResult.Distance else magnitude
end

function v2.Update(a48, a49, deadAt, a51, a52, a53)
    --[[
      name: Update
      line: 229
      upvalues:
        v4 (copy, index: 1)
        workspace (copy, index: 2)
        params (copy, index: 3)
        aimAt (copy, index: 4)
        v3 (ref,  index: 5)
    ]]
    local v54
    local aimW, v56
    local v57
    local v58
    local v59
    local v60 = if a51 then a51.Position else nil

    if v60 and a52 then
        v4.deadAt = nil
        local v61 = v60.Y + 3.1
        local position = v60 + Vector3.new(0, 1.5, 0)

        if const raycastResult = workspace:Spherecast(position, 0.4, Vector3.new(0, 1.600000023841858, 0), params) then
            v61 = position.Y + math.max(0, raycastResult.Distance - 0.4)
        end

        v4.pivotY += ((v61 - v4.pivotY) * (1 - math.exp(a49 * -10)))
    elseif v60 and not v4.deadAt then
        v4.deadAt = deadAt
    end

    local v64 = if v60 then Vector3.new(v60.X, v4.pivotY, v60.Z) else a48.CFrame.Position

    if v4.deadAt and v60 then
        v64 = v60 + Vector3.new(0, 1.2000000476837158, 0)
    end

    local v65 = a53 ~= nil and a53.valid and a52

    if a51 and a52 then
        local lookVector = a51.LookVector
        v54 = math.atan2(-lookVector.X, -lookVector.Z)
    else
        v54 = v4.yaw
    end

    aimW, v56 = aimAt(deadAt)

    if v65 then
        aimW = 0
        v56 = nil
    end

    v4.aimW = aimW
    local v67 = v54
    local v68 = -0.13962634015954636
    local v69 = v4
    local aimFovW = v69.aimFovW
    local v71 = v4.aimed and a52 and 1 or 0
    v69.aimFovW = aimFovW + ((v71 - v4.aimFovW) * (1 - math.exp(a49 * -8)))
    v4.action += ((v4.actionWant - v4.action) * (1 - math.exp(a49 * -3)))

    if v4.deadAt then
        v57 = 0
    else
        v57 = v4.action * (1 - aimW)
    end

    local x = v3 * ((v4.aimFovW * -0.10000000000000009) + 2.9 + v57 * 0.8)
    local v73 = v4.aimFovW * -2.5 + 10.5

    if v56 and 0 < aimW then
        local v74 = v4.yaw
        local v75 = v4.pitch

        for _ = 1, 2 do
            local unit = (v56 - (v64 + CFrame.fromEulerAnglesYXZ(v75, v74, 0):VectorToWorldSpace(v4.offset))).Unit
            v74 = math.atan2(-unit.X, -unit.Z)
            v75 = math.asin((math.clamp(unit.Y, -1, 1)))
        end

        v67 = v54 + (((v74 - v54 + math.pi) % math.tau) - math.pi) * aimW
        v68 = (v75 - -0.13962634015954636) * aimW + -0.13962634015954636
    end

    if v4.deadAt then
        v4.yaw += a49 * 0.35
        v67 = v4.yaw
        v68 = -0.4188790204786391
    end

    if v65 then
        v4.yaw, v4.pitch = a53.yaw, math.clamp(a53.pitch, -1.3962634015954636, 1.361356816555577)
    else
        local v78
        local v79 = not (0 < aimW) and 9 or 16
        v4.yaw += (((((v67 - v4.yaw) + math.pi) % math.tau) - math.pi) * (1 - math.exp(-v79 * a49)))
        local v80 = v4
        local pitch = v80.pitch
        local v82 = v68 - v4.pitch

        if not (0 < aimW) then
            v78 = 6
        else
            v78 = 14
        end

        v80.pitch = pitch + (v82 * (1 - math.exp(-v78 * a49)))
        v4.pitch = math.clamp(v4.pitch, -1.2217304763960306, 1.0471975511965976)
    end

    local v83 = 1 - (function(...) return (...) ^ 3 end)(((1 - math.clamp(deadAt / 1, 0, 1))))
    local v84 = (17 - v73) * (1 - v83)
    local v85 = (1 - v83) * 4.5
    local v86 = (1 - v83) * 0.5235987755982988
    v4.punch = math.max(0, v4.punch - (a49 * 1.6))

    if not (0.85 < v4.punch) then
        v58 = v4.punch / 0.85
    else
        v58 = (1 - v4.punch) / 0.15
    end

    local fieldOfView = if v65 then a53.fov - v58 * 4 else (v4.aimFovW * -20) + 70 - v58 * 6

    if v4.deadAt then
        v73 += math.min(3, (deadAt - v4.deadAt) * 2)
    end

    local v88 = CFrame.fromEulerAnglesYXZ(v4.pitch - ((1 - v83) * 0.10471975511965978), v4.yaw + v86, 0)
    local values = table.create(4, 0)
    local values2 = table.create(4, Vector3.new(0, 0, 0))

    for valueKey = 1, 4 do
        local vector3
        local z = v73 + v84

        if valueKey == 1 then
            vector3 = Vector3.new(x, 0, z)
        elseif valueKey == 2 then
            vector3 = Vector3.new(-x, 0, z)
        else
            vector3 = if valueKey == 3 then Vector3.new(x * 0.7, -1.6, z * 0.8) else Vector3.new(x * 0.7, 2.2, z * 0.85)
        end

        local v94 = vector3 + Vector3.new(0, v85 + (v57 * 0.5), 0)
        values2[valueKey] = v94
        local direction = v88:VectorToWorldSpace(v94)
        local v96 = direction.Magnitude

        if not (v96 < 0.001) then
            if const raycastResult = workspace:Spherecast(v64, 0.6, direction, params) then
                v96 = raycastResult.Distance
            end
        else
            v96 = 0
        end

        values[valueKey] = v96 / v94.Magnitude
    end

    local arm = v4.arm

    if not (0.92 <= values[1]) then
        if values[arm] < 0.92 then
            local arm2 = arm
            local value = values[1]

            if values[arm2] + 0.15 < value then
                arm2 = 1
            end

            local value2 = values[2]

            if values[arm2] + 0.15 < value2 then
                arm2 = 2
            end

            local value3 = values[3]

            if values[arm2] + 0.15 < value3 then
                arm2 = 3
            end

            local value4 = values[4]

            if values[arm2] + 0.15 < value4 then
                arm2 = 4
            end

            arm = arm2
        end
    else
        arm = 1
    end

    v4.arm = arm
    v4.offset = v4.offset:Lerp(values2[arm], 1 - math.exp(a49 * -7))
    local direction = v88:VectorToWorldSpace(v4.offset)
    local magnitude = direction.Magnitude

    if not (magnitude < 0.001) then
        v59 = if const raycastResult = workspace:Spherecast(v64, 0.6, direction, params) then raycastResult.Distance else magnitude
    else
        v59 = 0
    end

    local v107 = math.max(math.min(v59 - 0.2, direction.Magnitude), (math.min(3.2, direction.Magnitude)))
    local v108 = v64 + direction.Unit * v107
    local startValue = CFrame.lookAt(v108, v108 + v88.LookVector)
    local v110 = v65 and a53 and a53.first and a53.eye and 0.7 <= deadAt and 1 or 0

    if v4.fpW < v110 then
        v4.fpW = math.min(v110, v4.fpW + (a49 / 0.2))
    elseif v110 < v4.fpW then
        v4.fpW = math.max(v110, v4.fpW - (a49 / 0.2))
    end

    v4.firstPerson = 0.5 <= v4.fpW

    if 0 < v4.fpW and a53 and a53.eye then
        local targetValue = CFrame.new(a53.eye + Vector3.new(0, a53.bobY, 0)) * CFrame.fromEulerAnglesYXZ(math.clamp(a53.pitch, -1.3962634015954636, 1.361356816555577), a53.yaw, 0) * CFrame.Angles(0, 0, a53.bobRoll)
        local alpha = v4.fpW * v4.fpW * (3 - (v4.fpW * 2))

        if not (1 <= alpha) then
            startValue = startValue:Lerp(targetValue, alpha)
        else
            startValue = targetValue
        end
    end

    a48.CFrame = startValue
    a48.FieldOfView = fieldOfView
end

function v2.Stats()
    --[[
      name: Stats
      line: 354
      upvalues:
        v4 (copy, index: 1)
    ]]
    return {aimW = v4.aimW, arm = v4.arm, offset = v4.offset, pivotY = v4.pivotY, segments = #v4.segments}
end

return v2