local v1 = {
    MAX_LIFETIME = 5,
    MAX_DISTANCE = 1200,
    new = (function(pos, vel, gravity, a5)
        --[[
          name: new
          line: 19
        ]]
        return {age = 0, traveled = 0, pos = pos, vel = vel, gravity = gravity, radius = a5 or 0}
    end),
    Advance = (function(a6, a7)
        --[[
          name: Advance
          line: 32
        ]]
        local vector3 = Vector3.new(0, -a6.gravity, 0)
        local v9 = a6.vel * a7 + vector3 * ((a7 * 0.5) * a7)
        local pos = a6.pos
        a6.pos = pos + v9
        a6.vel += (vector3 * a7)
        a6.age += a7
        a6.traveled += v9.Magnitude

        return pos, v9
    end)
}

function v1.Expired(a11)
    --[[
      name: Expired
      line: 43
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v12 = true
    local age = a11.age

    if not (v1.MAX_LIFETIME < age) then
        local traveled = a11.traveled
        v12 = v1.MAX_DISTANCE < traveled
    end

    return v12
end

function v1.Cast(origin: Vector3, direction: Vector3, a17, raycastParams: RaycastParams?)
    --[[
      name: Cast
      line: 48
    ]]
    if direction.Magnitude < 1e-04 then
        return nil
    end

    if 0 < a17 then
        local success, result = pcall(workspace.Spherecast, workspace, origin, a17, direction, raycastParams)
        if success then
            return result
        end
    end

    return workspace:Raycast(origin, direction, raycastParams)
end

function v1.Velocity(a21, a22)
    --[[
      name: Velocity
      line: 64
    ]]
    return a21.Unit * a22
end

return v1