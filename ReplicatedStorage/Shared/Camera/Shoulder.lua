local Occlusion_upv_1 = require(script.Parent:WaitForChild("Occlusion"))
local tbl_upv_1 = {}
local u1 = 1
local u2 = 1
local u3 = nil
local u4 = 0
local u5 = 22
local u6 = 2.9
local function swapTo(a1, a2)
    --[[
      name: swapTo
      line: 33
      upvalues:
        u2 (ref,  index: 1)
        u3 (ref,  index: 2)
        Occlusion_upv_1 (copy, index: 3)
        u4 (ref,  index: 4)
        u5 (ref,  index: 5)
        u6 (ref,  index: 6)
    ]]
    if a1 == u2 then
        return
    end
    u2 = a1
    local v1 = u3
    local v2 = Occlusion_upv_1.Shown()
    if v1 and math.abs(v2) < math.abs(v1) - 0.01 and v2 * v1 >= 0 then
        u3 = v2
        u4 = 0
    end
    if a2 then
        u5 = 22
        if u3 then
            u4 = ((u6 * u2) - u3) * 11
        end
    else
        u5 = 9
    end
end
function tbl_upv_1.Step(a1, a2)
    --[[
      name: Step
      line: 55
      upvalues:
        u6 (ref, index: 1)
        u2 (ref, index: 2)
        u3 (ref, index: 3)
        u4 (ref, index: 4)
        u5 (ref, index: 5)
    ]]
    u6 = a2
    local v3 = a2 * u2
    local v4 = u3
    if v4 ~= nil and v4 == v4 and u4 == u4 and a1 == a1 then
        local v5 = v4 - v3
        local v6 = math.exp(-u5 * math.max(a1, 0))
        local v7 = (u4 + (u5 * v5)) * a1
        local v8 = v3 + (v5 + v7) * v6
        u4 = (u4 - (u5 * v7)) * v6
        u3 = v8
        return v8
    end
    u3 = v3
    u4 = 0
    return v3
end
function tbl_upv_1.Value()
    --[[
      name: Value
      line: 73
      upvalues:
        u3 (ref, index: 1)
        u6 (ref, index: 2)
        u2 (ref, index: 3)
    ]]
    local v9 = u3 or (u6 * u2)
    return v9
end
function tbl_upv_1.Toggle()
    --[[
      name: Toggle
      line: 78
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    tbl_upv_1.Set(-u2)
end
function tbl_upv_1.Set(a1)
    --[[
      name: Set
      line: 83
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        u3 (ref,  index: 3)
        Occlusion_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
        u5 (ref,  index: 6)
        u6 (ref,  index: 7)
    ]]
    u1 = ((a1 < 0) and -1) or 1
    local v10 = u1
    local v11 = nil
    if v10 ~= u2 then
        u2 = v10
        v11 = u3
        local v12 = Occlusion_upv_1.Shown()
        if v11 and math.abs(v12) < math.abs(v11) - 0.01 and v12 * v11 >= 0 then
            u3 = v12
            u4 = 0
        end
        u5 = 22
        if u3 then
            u4 = ((u6 * u2) - u3) * 11
        end
    end
    Occlusion_upv_1.ManualSwap()
end
function tbl_upv_1.Update(a1, a2, a3, a4)
    --[[
      name: Update
      line: 90
      upvalues:
        Occlusion_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        u2 (ref,  index: 3)
        u3 (ref,  index: 4)
        u4 (ref,  index: 5)
        u5 (ref,  index: 6)
    ]]
    local v13 = Occlusion_upv_1.Side(a1, a2, a3, u1, a4)
    if v13 == u2 then
        return
    end
    u2 = v13
    local v14 = u3
    local v15 = Occlusion_upv_1.Shown()
    if v14 and math.abs(v15) < math.abs(v14) - 0.01 and v15 * v14 >= 0 then
        u3 = v15
        u4 = 0
    end
    u5 = 9
end
function tbl_upv_1.Get()
    --[[
      name: Get
      line: 95
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Preferred()
    --[[
      name: Preferred
      line: 99
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.Reset(a1)
    --[[
      name: Reset
      line: 104
      upvalues:
        u1 (ref, index: 1)
        u2 (ref, index: 2)
        u3 (ref, index: 3)
        u4 (ref, index: 4)
        u5 (ref, index: 5)
    ]]
    local v16
    if (a1) and (a1 < 0) then
        v16 = -1
    else
        v16 = 1
    end
    u1 = v16
    u2 = u1
    u3 = nil
    u4 = 0
    u5 = 22
end
return tbl_upv_1