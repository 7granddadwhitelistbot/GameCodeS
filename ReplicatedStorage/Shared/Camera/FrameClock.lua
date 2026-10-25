local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 39
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (setmetatable({bucket = -1, sim = 0, mins = table.create(10, math.huge)}, tbl_upv_1))
end
function tbl_upv_1.Step(a1)
    --[[
      name: Step
      line: 51
    ]]
    a1.sim = a1.sim + 0.016666666666666666
end
function tbl_upv_1.Reset(a1)
    --[[
      name: Reset
      line: 55
    ]]
    a1.mins[1] = math.huge
    a1.mins[2] = math.huge
    a1.mins[3] = math.huge
    a1.mins[4] = math.huge
    a1.mins[5] = math.huge
    a1.mins[6] = math.huge
    a1.mins[7] = math.huge
    a1.mins[8] = math.huge
    a1.mins[9] = math.huge
    a1.mins[10] = math.huge
    a1.bucket = -1
    a1.lastNow = nil
    a1.dtAvg = nil
end
function tbl_upv_1.Alpha(a1, a2, a3)
    --[[
      name: Alpha
      line: 66
    ]]
    local lastNow_1 = a1.lastNow
    if lastNow_1 then
        local v1 = a2 - lastNow_1
        if v1 > 0.25 then
            a1:Reset()
        else
            local v2 = nil
            if v1 < 0 then
                a1:Reset()
            else
                v2 = a1.dtAvg
                local v3
                if v2 then
                    v3 = v2 + (v1 - v2) * 0.1
                else
                    v3 = v1
                end
                a1.dtAvg = v3
            end
        end
    end
    a1.lastNow = a2
    local v4 = a1.sim - a2
    local v1 = math.floor(a2 / 0.1)
    if v1 ~= a1.bucket then
        local v5 = ((a1.bucket < 0) and 10) or (math.min(v1 - a1.bucket, 10))
        for n_1 = 1, v5 do
            a1.mins[(((v1 - v5) + n_1) % 10) + 1] = math.huge
        end
        a1.bucket = v1
    end
    local v6 = v1 % 10 + 1
    if v4 < a1.mins[v6] then
        a1.mins[v6] = v4
    end
    local v7 = math.huge
    local v2 = v7
    for n_2 = 1, 10 do
        if a1.mins[n_2] < v2 then
            v2 = a1.mins[n_2]
        end
    end
    if v4 - v2 > 0.016666666666666666 then
        v6 = v4 - 0.016666666666666666
        for n_3 = 1, 10 do
            if a1.mins[n_3] < v6 then
                a1.mins[n_3] = v6
            end
        end
    end
    local dtAvg_1 = a1.dtAvg
    if a3 or dtAvg_1 ~= nil and not (dtAvg_1 > 0.05) then
        return (math.clamp(1 - ((v4 - v2) / 0.016666666666666666), 0, 1))
    end
    return 1
end
return tbl_upv_1