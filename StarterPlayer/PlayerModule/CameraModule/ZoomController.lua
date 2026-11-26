local Popper = require(script:WaitForChild("Popper"))
local mathClamp = math.clamp
local mathExp = math.exp
local mathMin = math.min
local mathMax = math.max
local cameraMinZoomDistance = nil
local cameraMaxZoomDistance = nil
local localPlayer = game:GetService("Players").LocalPlayer
assert(localPlayer)

local function updateBounds()
    --[[
      name: updateBounds
      line: 24
      upvalues:
        cameraMinZoomDistance (ref,  index: 1)
        localPlayer (copy, index: 2)
        cameraMaxZoomDistance (ref,  index: 3)
    ]]
    cameraMinZoomDistance = localPlayer.CameraMinZoomDistance
    cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance
end

cameraMinZoomDistance = localPlayer.CameraMinZoomDistance
cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance
localPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(updateBounds)
localPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(updateBounds)
local Class = {}
Class.__index = Class

function Class.new(freq, a12, minValue: number, maxValue: number)
    --[[
      name: new
      line: 39
      upvalues:
        mathClamp (copy, index: 1)
        Class (copy, index: 2)
    ]]
    a12 = mathClamp(a12, minValue, maxValue)
    return (setmetatable({v = 0, freq = freq, x = a12, minValue = minValue, maxValue = maxValue, goal = a12}, Class))
end

function Class.Step(self, a16)
    --[[
      name: Step
      line: 51
      upvalues:
        mathExp (copy, index: 1)
    ]]
    local v17 = self.freq * 2 * math.pi
    local x = self.x
    local v = self.v
    local minValue = self.minValue
    local maxValue = self.maxValue
    local goal = self.goal
    local v23 = goal - x
    local v24 = v17 * a16
    local v25 = mathExp(-v24)
    local v26 = goal + (v * a16 - (v23 * (v24 + 1))) * v25
    local v2 = ((((v23 * v17) - v) * v24) + v) * v25

    if v26 < minValue then
        v2 = 0
        v26 = minValue
    elseif maxValue < v26 then
        v2 = 0
        v26 = maxValue
    end

    self.x = v26
    self.v = v2

    return v26
end

local class = Class.new(4.5, 12.5, 0.5, cameraMaxZoomDistance)

local function stepTargetZoom(a30, a31, minValue: number, maxValue: number)
    --[[
      name: stepTargetZoom
      line: 89
      upvalues:
        mathClamp (copy, index: 1)
    ]]
    local v34 = mathClamp(a30 + (a31 * ((a30 * 0.0375) + 1)), minValue, maxValue)

    if v34 < 1 then
        v34 = a31 <= 0 and minValue or 1
    end

    return v34
end

local v35 = 0

return {
    Update = (function(a36, a37, a38)
        --[[
          name: Update
          line: 101
          upvalues:
            class (copy, index: 1)
            v35 (ref,  index: 2)
            cameraMinZoomDistance (ref,  index: 3)
            cameraMaxZoomDistance (ref,  index: 4)
            mathClamp (copy, index: 5)
            mathMax (copy, index: 6)
            Popper (copy, index: 7)
            mathMin (copy, index: 8)
        ]]
        local v39 = math.huge

        if 1 < class.goal then
            local v40
            local x = class.x
            local goal = class.goal
            local v43 = v35
            local cameraMinZoomDistance2 = cameraMinZoomDistance
            local cameraMaxZoomDistance2 = cameraMaxZoomDistance
            local clampedValue = mathClamp(goal + (v43 * ((goal * 0.0375) + 1)), cameraMinZoomDistance2, cameraMaxZoomDistance2)

            if not (clampedValue < 1) then
                v40 = clampedValue
            else
                v40 = v43 <= 0 and cameraMinZoomDistance2 or 1
            end

            local v47 = mathMax(x, v40)
            v39 = Popper(a37 * CFrame.new(0, 0, 0.5), v47 - 0.5, a38) + 0.5
        end

        class.minValue = 0.5
        class.maxValue = mathMin(cameraMaxZoomDistance, v39)

        return class:Step(a36)
    end),
    GetZoomRadius = (function()
        --[[
          name: GetZoomRadius
          line: 125
          upvalues:
            class (copy, index: 1)
        ]]
        return class.x
    end),
    SetZoomParameters = (function(goal, a49)
        --[[
          name: SetZoomParameters
          line: 129
          upvalues:
            class (copy, index: 1)
            v35 (ref,  index: 2)
        ]]
        class.goal = goal
        v35 = a49
    end),
    ReleaseSpring = (function()
        --[[
          name: ReleaseSpring
          line: 134
          upvalues:
            class (copy, index: 1)
        ]]
        class.x = class.goal
        class.v = 0
    end)
}