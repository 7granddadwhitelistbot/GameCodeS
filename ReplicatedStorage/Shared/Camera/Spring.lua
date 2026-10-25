local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new(a1, a2, a3)
    --[[
      name: new
      line: 24
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({value = a1, velocity = a1 * 0, target = a1, frequency = a2, damping = a3 or 1}, tbl_upv_1))
end
function tbl_upv_1.Update(a1, a2)
    --[[
      name: Update
      line: 35
    ]]
    local v1 = a1.frequency * 2 * math.pi
    local damping_1 = a1.damping
    local v2 = math.min(a2, 0.13333333333333333)
    local value_1 = a1.value
    local velocity_1 = a1.velocity
    local target_1 = a1.target
    while v2 > 1e-06 do
        local v3 = math.min(0.004166666666666667, v2)
        v2 = v2 - v3
        velocity_1 = velocity_1 + (((target_1 - value_1) * (v1 * v1)) - (velocity_1 * ((damping_1 * 2) * v1))) * v3
        value_1 = value_1 + velocity_1 * v3
    end
    a1.value = value_1
    a1.velocity = velocity_1
    return value_1
end
function tbl_upv_1.Impulse(a1, a2)
    --[[
      name: Impulse
      line: 51
    ]]
    a1.velocity = a1.velocity + a2
end
function tbl_upv_1.Snap(a1, a2)
    --[[
      name: Snap
      line: 55
    ]]
    a1.value = a2
    a1.target = a2
    a1.velocity = a2 * 0
end
return tbl_upv_1