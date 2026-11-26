local v1 = {
    Authority = "?",
    Number = (function(a2)
        --[[
          name: Number
          line: 15
        ]]
        return a2 == a2 and -1e+07 < a2 and (a2 < 1e+07)
    end)
}

function v1.Vector(a3)
    --[[
      name: Vector
      line: 19
      upvalues:
        v1 (copy, index: 1)
    ]]
    return v1.Number(a3.X) and v1.Number(a3.Y) and v1.Number(a3.Z)
end

local v4 = {}

function v1.Say(key)
    --[[
      name: Say
      line: 25
      upvalues:
        v4 (copy, index: 1)
        v1 (copy, index: 2)
    ]]
    if not v4[key] then
        v4[key] = true
        warn((`[CameraNaN] {key} auth={v1.Authority}`))
    end

    return false
end

function v1.HealSpring(a6, a7, a8)
    --[[
      name: HealSpring
      line: 34
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v9
    local v10
    local value = a6.value
    local velocity = a6.velocity

    if typeof(value) ~= "Vector3" then
        v9 = v1.Number(value) and v1.Number(velocity)
    else
        v9 = v1.Vector(value) and v1.Vector(velocity)
    end

    if v9 then
        return
    end

    v1.Say("spring " .. a8)
    local target = a6.target

    if typeof(target) ~= "Vector3" then
        v10 = type(target) == "number" and v1.Number(target)
    else
        v10 = v1.Vector(target)
    end

    local v14 = if v10 then target else a7
    a6:Snap(v14)
end

function v1.Offset(a15)
    --[[
      name: Offset
      line: 47
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v16 = a15.CameraOffset()

    if v1.Vector(v16) then
        return v16
    end

    v1.Say("own offset")
    a15.Reset()

    return Vector3.new(0, 0, 0)
end

return v1