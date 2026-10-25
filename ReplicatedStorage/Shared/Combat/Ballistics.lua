local tbl_upv_1 = {}
tbl_upv_1.MAX_LIFETIME = 5
tbl_upv_1.MAX_DISTANCE = 1200
function tbl_upv_1.new(a1, a2, a3, a4)
    --[[
      name: new
      line: 19
    ]]
    local tbl_2 = {traveled = 0, age = 0}
    tbl_2.pos = a1
    tbl_2.vel = a2
    tbl_2.gravity = a3
    tbl_2.radius = a4 or 0
    return tbl_2
end
function tbl_upv_1.Advance(a1, a2)
    --[[
      name: Advance
      line: 32
    ]]
    local v1 = Vector3.new(0, -a1.gravity, 0)
    local v2 = a1.vel * a2 + v1 * ((a2 * 0.5) * a2)
    local pos_1 = a1.pos
    a1.pos = pos_1 + v2
    a1.vel = a1.vel + (v1 * a2)
    a1.age = a1.age + a2
    a1.traveled = a1.traveled + v2.Magnitude
    return pos_1, v2
end
function tbl_upv_1.Expired(a1)
    --[[
      name: Expired
      line: 43
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v3 = true
    if not (tbl_upv_1.MAX_LIFETIME < a1.age) then
        v3 = tbl_upv_1.MAX_DISTANCE < a1.traveled
    end
    return v3
end
function tbl_upv_1.Cast(a1, a2, a3, a4)
    --[[
      name: Cast
      line: 48
    ]]
    if a2.Magnitude < 1e-04 then
        return nil
    end
    if a3 > 0 then
        local success_1, v4 = pcall(workspace.Spherecast, workspace, a1, a3, a2, a4)
        if success_1 then
            return v4
        end
    end
    return workspace:Raycast(a1, a2, a4)
end
function tbl_upv_1.Velocity(a1, a2)
    --[[
      name: Velocity
      line: 64
    ]]
    return a1.Unit * a2
end
return tbl_upv_1