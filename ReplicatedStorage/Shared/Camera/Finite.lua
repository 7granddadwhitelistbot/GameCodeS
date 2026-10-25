local tbl_upv_1 = {}
tbl_upv_1.Authority = "?"
function tbl_upv_1.Number(a1)
    --[[
      name: Number
      line: 15
    ]]
    return (a1 == a1) and ((a1 > -1e+07) and (a1 < 1e+07))
end
function tbl_upv_1.Vector(a1)
    --[[
      name: Vector
      line: 19
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = tbl_upv_1.Number(a1.X) and (tbl_upv_1.Number(a1.Y) and (tbl_upv_1.Number(a1.Z)))
    return v1
end
local tbl_upv_2 = {}
function tbl_upv_1.Say(a1)
    --[[
      name: Say
      line: 25
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not (tbl_upv_2[a1]) then
        tbl_upv_2[a1] = true
        warn((("[CameraNaN] %* auth=%*"):format(a1, tbl_upv_1.Authority)))
    end
    return false
end
function tbl_upv_1.HealSpring(a1, a2, a3)
    --[[
      name: HealSpring
      line: 34
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local value_1 = a1.value
    local v2 = a1.velocity
    local v3
    if typeof(value_1) ~= "Vector3" then
        v3 = tbl_upv_1.Number(value_1) and (tbl_upv_1.Number(v2))
    else
        v3 = tbl_upv_1.Vector(value_1) and (tbl_upv_1.Vector(v2))
    end
    if v3 then
        return
    end
    tbl_upv_1.Say("spring " .. a3)
    local target_1 = a1.target
    if typeof(target_1) ~= "Vector3" then
        v2 = (type(target_1) == "number") and (tbl_upv_1.Number(target_1))
    else
        v2 = tbl_upv_1.Vector(target_1)
    end
    local v4
    if v2 then
        v4 = target_1
    else
        v4 = a2
    end
    a1:Snap(v4)
end
function tbl_upv_1.Offset(a1)
    --[[
      name: Offset
      line: 47
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v5 = a1.CameraOffset()
    if tbl_upv_1.Vector(v5) then
        return v5
    end
    tbl_upv_1.Say("own offset")
    a1.Reset()
    return Vector3.new(0, 0, 0)
end
return tbl_upv_1