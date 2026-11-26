local Occlusion = require(script.Parent:WaitForChild("Occlusion"))
local v2 = {}
local v3 = 1
local v4 = 1
local v5 = nil
local v6 = 0
local v7 = 22
local v8 = 2.9

local function swapTo(a10, a11)
    --[[
      name: swapTo
      line: 33
      upvalues:
        v4 (ref,  index: 1)
        v5 (ref,  index: 2)
        Occlusion (copy, index: 3)
        v6 (ref,  index: 4)
        v7 (ref,  index: 5)
        v8 (ref,  index: 6)
    ]]
    if a10 == v4 then
        return
    end

    v4 = a10
    local v12 = v5
    local v13 = Occlusion.Shown()

    if v12 and math.abs(v13) < math.abs(v12) - 0.01 and 0 <= v13 * v12 then
        v5 = v13
        v6 = 0
    end

    if a11 then
        v7 = 22

        if v12 then
            v6 = (v8 * v4 - v12) * 11
        end
    else
        v7 = 9
    end
end

function v2.Step(a14: number, a15)
    --[[
      name: Step
      line: 55
      upvalues:
        v8 (ref, index: 1)
        v4 (ref, index: 2)
        v5 (ref, index: 3)
        v6 (ref, index: 4)
        v7 (ref, index: 5)
    ]]
    v8 = a15
    local v16 = a15 * v4
    local v17 = v5

    if v17 == nil or v17 ~= v17 or v6 ~= v6 or a14 ~= a14 then
        v5 = v16
        v6 = 0

        return v16
    end

    local v18 = v17 - v16
    local v19 = math.exp(-v7 * math.max(a14, 0))
    local v20 = (v6 + (v7 * v18)) * a14
    local v21 = v16 + (v18 + v20) * v19
    v6 = (v6 - (v7 * v20)) * v19
    v5 = v21

    return v21
end

function v2.Value()
    --[[
      name: Value
      line: 73
      upvalues:
        v5 (ref, index: 1)
        v8 (ref, index: 2)
        v4 (ref, index: 3)
    ]]
    return v5 or v8 * v4
end

function v2.Toggle()
    --[[
      name: Toggle
      line: 78
      upvalues:
        v2 (copy, index: 1)
        v4 (ref,  index: 2)
    ]]
    v2.Set(-v4)
end

function v2.Set(a22)
    --[[
      name: Set
      line: 83
      upvalues:
        v3 (ref,  index: 1)
        v4 (ref,  index: 2)
        v5 (ref,  index: 3)
        Occlusion (copy, index: 4)
        v6 (ref,  index: 5)
        v7 (ref,  index: 6)
        v8 (ref,  index: 7)
    ]]
    v3 = not (a22 < 0) and 1 or -1
    local v23 = v3

    if v23 ~= v4 then
        v4 = v23
        local v24 = v5
        local v25 = Occlusion.Shown()

        if v24 and math.abs(v25) < math.abs(v24) - 0.01 and 0 <= v25 * v24 then
            v5 = v25
            v6 = 0
        end

        v7 = 22

        if v24 then
            v6 = (v8 * v4 - v24) * 11
        end
    end

    Occlusion.ManualSwap()
end

function v2.Update(a26, a27, a28, a29)
    --[[
      name: Update
      line: 90
      upvalues:
        Occlusion (copy, index: 1)
        v3 (ref,  index: 2)
        v4 (ref,  index: 3)
        v5 (ref,  index: 4)
        v6 (ref,  index: 5)
        v7 (ref,  index: 6)
    ]]
    local v30 = Occlusion.Side(a26, a27, a28, v3, a29)

    if v30 == v4 then
        return
    end

    v4 = v30
    local v31 = v5
    local v32 = Occlusion.Shown()

    if v31 and math.abs(v32) < math.abs(v31) - 0.01 and 0 <= v32 * v31 then
        v5 = v32
        v6 = 0
    end

    v7 = 9
end

function v2.Get()
    --[[
      name: Get
      line: 95
      upvalues:
        v4 (ref, index: 1)
    ]]
    return v4
end

function v2.Preferred()
    --[[
      name: Preferred
      line: 99
      upvalues:
        v3 (ref, index: 1)
    ]]
    return v3
end

function v2.Reset(a33)
    --[[
      name: Reset
      line: 104
      upvalues:
        v3 (ref, index: 1)
        v4 (ref, index: 2)
        v5 (ref, index: 3)
        v6 (ref, index: 4)
        v7 (ref, index: 5)
    ]]
    v3 = a33 and a33 < 0 and -1 or 1
    v4 = v3
    v5 = nil
    v6 = 0
    v7 = 22
end

return v2