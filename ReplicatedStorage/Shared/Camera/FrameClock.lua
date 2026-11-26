local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 39
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({sim = 0, bucket = -1, dtAvg = nil, lastNow = nil, mins = table.create(10, math.huge)}, Class))
end

function Class.Step(self)
    --[[
      name: Step
      line: 51
    ]]
    self.sim += 0.016666666666666666
end

function Class.Reset(self)
    --[[
      name: Reset
      line: 55
    ]]
    self.mins[1] = math.huge
    self.mins[2] = math.huge
    self.mins[3] = math.huge
    self.mins[4] = math.huge
    self.mins[5] = math.huge
    self.mins[6] = math.huge
    self.mins[7] = math.huge
    self.mins[8] = math.huge
    self.mins[9] = math.huge
    self.mins[10] = math.huge
    self.bucket = -1
    self.lastNow = nil
    self.dtAvg = nil
end

function Class.Alpha(self, lastNow, a6)
    --[[
      name: Alpha
      line: 66
    ]]
    if const lastNow2 = self.lastNow then
        local v8 = lastNow - lastNow2

        if 0.25 < v8 or v8 < 0 then
            self:Reset()
        else
            local dtAvg = self.dtAvg
            self.dtAvg = if dtAvg then dtAvg + (v8 - dtAvg) * 0.1 else v8
        end
    end

    self.lastNow = lastNow
    local v10 = self.sim - lastNow
    local bucket = math.floor(lastNow / 0.1)

    if bucket ~= self.bucket then
        local v12 = self.bucket < 0 and 10 or math.min(bucket - self.bucket, 10)

        for index = 1, v12 do
            self.mins[(((bucket - v12) + index) % 10) + 1] = math.huge
        end

        self.bucket = bucket
    end

    local minKey = bucket % 10 + 1

    if v10 < self.mins[minKey] then
        self.mins[minKey] = v10
    end

    local v15 = math.huge

    for minKey2 = 1, 10 do
        if self.mins[minKey2] < v15 then
            v15 = self.mins[minKey2]
        end
    end

    if 0.016666666666666666 < v10 - v15 then
        v15 = v10 - 0.016666666666666666

        for minKey3 = 1, 10 do
            if self.mins[minKey3] < v15 then
                self.mins[minKey3] = v15
            end
        end
    end

    local dtAvg = self.dtAvg

    if not (a6) and (dtAvg == nil or 0.05 < dtAvg) then
        return 1
    end

    return (math.clamp(1 - ((v10 - v15) / 0.016666666666666666), 0, 1))
end

return Class