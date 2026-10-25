local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local u1 = 1
local tbl_upv_2 = {pitch = -0.13962634015954636, aimFovW = 0, duration = 10, actionWant = 0, aimW = 0, pivotY = 0, yaw = 0, seg = 1, aimed = false, orbit = 0, fpW = 0, action = 0, fov = 70, offset = Vector3.new(2.9000000953674316, 0, 10.5), punch = 0, arm = 1, firstPerson = false}
tbl_upv_2.segments = {}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.IgnoreWater = true
local function yawOf(a1)
    --[[
      name: yawOf
      line: 105
    ]]
    local LookVector_1 = a1.LookVector
    return (math.atan2(-LookVector_1.X, -LookVector_1.Z))
end
local function wrap(a1)
    --[[
      name: wrap
      line: 110
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local function ease(a1)
    --[[
      name: ease
      line: 114
    ]]
    return 1 - ((1 - math.clamp(a1, 0, 1)) ^ 3)
end
local function yawPitchOf(a1)
    --[[
      name: yawPitchOf
      line: 119
    ]]
    local Unit_1 = a1.Unit
    return math.atan2(-Unit_1.X, -Unit_1.Z), (math.asin(math.clamp(Unit_1.Y, -1, 1)))
end
function tbl_1.SetWorld(a1)
    --[[
      name: SetWorld
      line: 125
      upvalues:
        u2 (copy, index: 1)
    ]]
    u2.FilterDescendantsInstances = a1
end
function tbl_1.SetSegments(a1)
    --[[
      name: SetSegments
      line: 130
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    table.sort(
        a1,
        function(a2, a3)
            --[[
              line: 131
            ]]
            return a2.t0 < a3.t0
        end
    )
    tbl_upv_2.segments = a1
    tbl_upv_2.seg = 1
end
function tbl_1.SetShoulderSide(a1)
    --[[
      name: SetShoulderSide
      line: 138
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = ((a1 < 0) and -1) or 1
end
function tbl_1.Begin(a1, a2)
    --[[
      name: Begin
      line: 142
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local LookVector_2 = a1.LookVector
    tbl_upv_2.yaw = math.atan2(-LookVector_2.X, -LookVector_2.Z)
    tbl_upv_2.pitch = -0.13962634015954636
    tbl_upv_2.fov = 70
    tbl_upv_2.pivotY = a1.Position.Y + 3.1
    tbl_upv_2.aimW = 0
    tbl_upv_2.aimFovW = 0
    tbl_upv_2.punch = 0
    tbl_upv_2.deadAt = nil
    tbl_upv_2.orbit = 0
    tbl_upv_2.duration = a2
    tbl_upv_2.seg = 1
    tbl_upv_2.arm = 1
    tbl_upv_2.offset = Vector3.new(2.9000000953674316, 0, 10.5)
    tbl_upv_2.action = 0
    tbl_upv_2.actionWant = 0
    tbl_upv_2.aimed = false
    tbl_upv_2.fpW = 0
    tbl_upv_2.firstPerson = false
end
function tbl_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 164
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2.firstPerson
end
function tbl_1.SetAction(a1)
    --[[
      name: SetAction
      line: 169
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    tbl_upv_2.actionWant = math.clamp(a1, 0, 1)
end
function tbl_1.SetAimed(a1)
    --[[
      name: SetAimed
      line: 174
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    tbl_upv_2.aimed = a1
end
function tbl_1.OnKill()
    --[[
      name: OnKill
      line: 178
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    tbl_upv_2.punch = 1
end
function tbl_1.OnShot(a1, a2)
    --[[
      name: OnShot
      line: 183
    ]]
end
local function candidate(a1, a2, a3)
    --[[
      name: candidate
      line: 207
    ]]
    if a1 ~= 1 then
        if a1 ~= 2 then
            if a1 ~= 3 then
                return (Vector3.new(a2 * 0.7, 2.2, a3 * 0.85))
            end
            return (Vector3.new(a2 * 0.7, -1.6, a3 * 0.8))
        end
        return (Vector3.new(-a2, 0, a3))
    end
    return (Vector3.new(a2, 0, a3))
end
local function freeLength(a1, a2)
    --[[
      name: freeLength
      line: 219
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    local Magnitude_1 = a2.Magnitude
    if Magnitude_1 < 0.001 then
        return 0
    end
    local v1 = Workspace_upv_1:Spherecast(a1, 0.6, a2, u2)
    if v1 then
        return v1.Distance
    end
    return Magnitude_1
end
local function aimAt(a1)
    --[[
      name: aimAt
      line: 186
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local segments_1 = tbl_upv_2.segments
    while tbl_upv_2.seg <= #segments_1 do
        if segments_1[tbl_upv_2.seg].t1 < a1 then
            tbl_upv_2.seg = tbl_upv_2.seg + 1
            continue
        else
            break
        end
    end
    local v2 = nil
    local v3 = 0
    local v4 = nil
    for n_1 = math.max(1, tbl_upv_2.seg - 1), math.min(#segments_1, tbl_upv_2.seg + 1) do
        local v5 = segments_1[n_1]
        v4 = 0
        if v5.t0 <= a1 and a1 <= v5.t1 then
            v4 = math.clamp(math.min(1, (a1 - v5.t0) / 0.28, (v5.t1 - a1) / 0.4 + (((a1 <= v5.shot) and 1) or 0)), 0, 1)
        end
        if v3 < v4 then
            v3, v2 = v4, v5
        end
    end
    if v2 then
        return v3, v2.point
    end
    return v3, nil
end
function tbl_1.Update(a1, a2, a3, a4, a5, a6)
    --[[
      name: Update
      line: 229
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        u2 (copy, index: 3)
        aimAt (copy, index: 4)
        u1 (ref,  index: 5)
    ]]
    local v6
    if a4 then
        v6 = a4.Position
    else
        v6 = nil
    end
    local v11 = nil
    if (v6) and (a5) then
        tbl_upv_2.deadAt = nil
        local v7 = v6 + Vector3.new(0, 1.5, 0)
        local v8 = Workspace_upv_1:Spherecast(v7, 0.4, Vector3.new(0, 1.600000023841858, 0), u2)
        v11 = (v8 and (v7.Y + math.max(0, v8.Distance - 0.4))) or v6.Y + 3.1
        local v10 = tbl_upv_2
        v10.pivotY = v10.pivotY + ((v11 - tbl_upv_2.pivotY) * (1 - math.exp(a2 * -10)))
    elseif v6 and not (tbl_upv_2.deadAt) then
        tbl_upv_2.deadAt = a3
    end
    if v6 then
        v11 = Vector3.new(v6.X, tbl_upv_2.pivotY, v6.Z)
    else
        v11 = a1.CFrame.Position
    end
    if tbl_upv_2.deadAt then
        v11 = (v6 and (v6 + Vector3.new(0, 1.2000000476837158, 0))) or v11
    end
    local v12 = false
    if a6 ~= nil then
        v12 = a6.valid
        v12 = a6.valid and a5
    end
    local v13
    if (a4) and (a5) then
        local v49 = a4.LookVector
        v13 = math.atan2(-a4.LookVector.X, -a4.LookVector.Z)
    else
        v13 = tbl_upv_2.yaw
    end
    local v14, v15 = aimAt(a3)
    tbl_upv_2.aimW = v12 and 0
    local Magnitude_2 = -0.13962634015954636
    local v17 = nil
    local v18 = v17.aimFovW
    local v19
    if (tbl_upv_2.aimed) and (a5) then
        v19 = 1
    else
        v19 = 0
    end
    v17.aimFovW = v18 + ((v19 - tbl_upv_2.aimFovW) * (1 - math.exp(a2 * -8)))
    local v20 = tbl_upv_2
    v20.action = v20.action + ((tbl_upv_2.actionWant - tbl_upv_2.action) * (1 - math.exp(a2 * -3)))
    local v21 = ((tbl_upv_2.deadAt) and 0) or (tbl_upv_2.action * (1 - v14))
    local v22 = u1 * (((tbl_upv_2.aimFovW * -0.10000000000000009) + 2.9) + v21 * 0.8)
    local v23 = tbl_upv_2.aimFovW * -2.5 + 10.5
    local v24 = nil
    local v32 = nil
    if v15 and v14 > 0 then
        v32 = tbl_upv_2.yaw
        local v26 = tbl_upv_2.pitch
        for v50 = 1, 2 do
            local Unit_2 = (v15 - (v11 + CFrame.fromEulerAnglesYXZ(v26, v32, 0):VectorToWorldSpace(tbl_upv_2.offset))).Unit
            local v27 = math.atan2(-Unit_2.X, -Unit_2.Z)
            v26, v32 = math.asin(math.clamp(Unit_2.Y, -1, 1)), v27
        end
        v24, Magnitude_2 = v13 + (((v32 - v13 + math.pi) % math.tau) - math.pi) * v14, (v26 - -0.13962634015954636) * v14 + -0.13962634015954636
    end
    if tbl_upv_2.deadAt then
        tbl_upv_2.yaw = tbl_upv_2.yaw + a2 * 0.35
        v24, Magnitude_2 = tbl_upv_2.yaw, -0.4188790204786391
    end
    if v12 then
        local v28 = math.clamp(a6.pitch, -1.3962634015954636, 1.361356816555577)
        tbl_upv_2.yaw = a6.yaw
        tbl_upv_2.pitch = v28
    else
        local v29 = ((v14 > 0) and 16) or 9
        v32 = tbl_upv_2
        v32.yaw = v32.yaw + (((((v24 - tbl_upv_2.yaw) + math.pi) % math.tau) - math.pi) * (1 - math.exp(-v29 * a2)))
        v32 = tbl_upv_2
        v32.pitch = v32.pitch + ((Magnitude_2 - tbl_upv_2.pitch) * (1 - math.exp(-(((v14 > 0) and 14) or 6) * a2)))
        tbl_upv_2.pitch = math.clamp(tbl_upv_2.pitch, -1.2217304763960306, 1.0471975511965976)
    end
    Magnitude_2 = 1 - (1 - math.clamp(a3 / 1, 0, 1)) ^ 3
    tbl_upv_2.punch = math.max(0, tbl_upv_2.punch - (a2 * 1.6))
    if tbl_upv_2.punch > 0.85 then
        v32 = (1 - tbl_upv_2.punch) / 0.15
    else
        v32 = tbl_upv_2.punch / 0.85
    end
    local v33 = (v12 and (a6.fov - v32 * 4)) or ((tbl_upv_2.aimFovW * -20) + 70 - v32 * 6)
    local v34 = ((tbl_upv_2.deadAt) and (v23 + math.min(3, (a3 - tbl_upv_2.deadAt) * 2))) or v23
    local v35 = CFrame.fromEulerAnglesYXZ(tbl_upv_2.pitch - ((1 - Magnitude_2) * 0.10471975511965978), tbl_upv_2.yaw + ((1 - Magnitude_2) * 0.5235987755982988), 0)
    Magnitude_2 = table.create(4, 0)
    local v36 = table.create(4, Vector3.new(0, 0, 0))
    local v37 = nil
    for n_2 = 1, 4 do
        v37 = v34 + (17 - v23) * (1 - Magnitude_2)
        local v38
        if n_2 == 1 then
            v38 = Vector3.new(v22, 0, v37)
        elseif n_2 == 2 then
            v38 = Vector3.new(-v22, 0, v37)
        elseif n_2 ~= 3 then
            v38 = Vector3.new(v22 * 0.7, 2.2, v37 * 0.85)
        else
            v38 = Vector3.new(v22 * 0.7, -1.6, v37 * 0.8)
        end
        local v39 = v38 + Vector3.new(0, (1 - Magnitude_2) * 4.5 + (v21 * 0.5), 0)
        v36[n_2] = v39
        local v40 = v35:VectorToWorldSpace(v39)
        local Magnitude_3 = v40.Magnitude
        if Magnitude_3 < 0.001 then
            v37 = 0
            Magnitude_2[n_2] = v37 / v39.Magnitude
            continue
        end
        local v41 = Workspace_upv_1:Spherecast(v11, 0.6, v40, u2)
        if v41 then
            v37 = v41.Distance
        else
            v37 = Magnitude_3
        end
        Magnitude_2[n_2] = v37 / v39.Magnitude
    end
    local v42 = tbl_upv_2.arm
    if Magnitude_2[1] >= 0.92 then
        v42 = 1
    elseif Magnitude_2[v42] < 0.92 then
        v18 = Magnitude_2[v42] + 0.15 < Magnitude_2[1] and 1 or v42
        if Magnitude_2[v18] + 0.15 < Magnitude_2[2] then
            v18 = 2
        end
        if Magnitude_2[v18] + 0.15 < Magnitude_2[3] then
            v18 = 3
        end
        if Magnitude_2[v18] + 0.15 < Magnitude_2[4] then
            v18 = 4
        end
        v42 = v18
    end
    tbl_upv_2.arm = v42
    tbl_upv_2.offset = tbl_upv_2.offset:Lerp(v36[v42], 1 - math.exp(a2 * -7))
    local v43 = v35:VectorToWorldSpace(tbl_upv_2.offset)
    Magnitude_2 = v43.Magnitude
    local v44 = nil
    if Magnitude_2 < 0.001 then
        v21 = 0
    else
        v44 = Workspace_upv_1:Spherecast(v11, 0.6, v43, u2)
        if v44 then
            v21 = v44.Distance
        else
            v21 = Magnitude_2
        end
    end
    local v45 = v11 + v43.Unit * math.max(math.min(v21 - 0.2, v43.Magnitude), math.min(3.2, v43.Magnitude))
    local v46 = CFrame.lookAt(v45, v45 + v35.LookVector)
    if v12 and a6 and a6.first and a6.eye and a3 >= 0.7 then
        v32 = 1
    else
        v32 = 0
    end
    if tbl_upv_2.fpW < v32 then
        tbl_upv_2.fpW = math.min(v32, tbl_upv_2.fpW + (a2 / 0.2))
    elseif v32 < tbl_upv_2.fpW then
        tbl_upv_2.fpW = math.max(v32, tbl_upv_2.fpW - (a2 / 0.2))
    end
    tbl_upv_2.firstPerson = tbl_upv_2.fpW >= 0.5
    if tbl_upv_2.fpW > 0 and a6 then
        local v47 = nil
        if a6.eye then
            local v48 = CFrame.new(a6.eye + Vector3.new(0, a6.bobY, 0)) * CFrame.fromEulerAnglesYXZ(math.clamp(a6.pitch, -1.3962634015954636, 1.361356816555577), a6.yaw, 0) * CFrame.Angles(0, 0, a6.bobRoll)
            v47 = tbl_upv_2.fpW * tbl_upv_2.fpW * (3 - (tbl_upv_2.fpW * 2))
            if v47 >= 1 then
                v46 = v48
            else
                v46 = v46:Lerp(v48, v47)
            end
        end
    end
    a1.CFrame = v46
    a1.FieldOfView = v33
end
function tbl_1.Stats()
    --[[
      name: Stats
      line: 354
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_3 = {}
    tbl_3.aimW = tbl_upv_2.aimW
    tbl_3.arm = tbl_upv_2.arm
    tbl_3.offset = tbl_upv_2.offset
    tbl_3.pivotY = tbl_upv_2.pivotY
    tbl_3.segments = #tbl_upv_2.segments
    return tbl_3
end
return tbl_1