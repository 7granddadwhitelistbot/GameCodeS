local Class = {}
Class.__index = Class

function Class.new(a2, frequency, a4)
    --[[
      name: new
      line: 24
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({value = a2, velocity = a2 * 0, target = a2, frequency = frequency, damping = a4 or 1}, Class))
end

function Class.Update(self, a6: number)
    --[[
      name: Update
      line: 35
    ]]
    local v7 = self.frequency * 2 * math.pi
    local damping = self.damping
    local v9 = math.min(a6, 0.13333333333333333)
    local v10 = self.value
    local v11 = self.velocity
    local target = self.target

    while 1e-06 < v9 do
        local v13 = math.min(0.004166666666666667, v9)
        v9 -= v13
        v11 += ((target - v10) * (v7 * v7) - (v11 * ((damping * 2) * v7))) * v13
        v10 += v11 * v13
    end

    self.value = v10
    self.velocity = v11

    return v10
end

function Class.Impulse(self, a15)
    --[[
      name: Impulse
      line: 51
    ]]
    self.velocity += a15
end

function Class.Snap(self, a17)
    --[[
      name: Snap
      line: 55
    ]]
    self.value = a17
    self.target = a17
    self.velocity = a17 * 0
end

return Class