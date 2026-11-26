local v1 = {MAX_RATE = 4.363323129985824, PITCH = 0.75, DEADZONE = 0.15, BOOST = 1.6, BOOST_AT = 0.92, BOOST_DELAY = 0.12, BOOST_RAMP = 0.3, BOOST_FALL = 0.1}
local clampedValue = 1
local v3 = false
local v4 = 0
local v5 = 0

function v1.SetSensitivity(sensitivity: number)
    --[[
      name: SetSensitivity
      line: 28
      upvalues:
        clampedValue (ref, index: 1)
    ]]
    if type(sensitivity) == "number" and sensitivity == sensitivity then
        clampedValue = math.clamp(sensitivity, 0.1, 5)
    end
end

function v1.GetSensitivity()
    --[[
      name: GetSensitivity
      line: 33
      upvalues:
        clampedValue (ref, index: 1)
    ]]
    return clampedValue
end

function v1.SetInvertY(invertY)
    --[[
      name: SetInvertY
      line: 36
      upvalues:
        v3 (ref, index: 1)
    ]]
    v3 = invertY == true
end

local v8 = false
local timestamp = -math.huge

local function inverted()
    --[[
      name: inverted
      line: 43
      upvalues:
        timestamp (ref, index: 1)
        v8 (ref, index: 2)
        v3 (ref, index: 3)
    ]]
    local timestamp2 = os.clock()

    if 2 < timestamp2 - timestamp then
        timestamp = timestamp2
        local success, cameraYInvertValue = pcall(
            function()
                --[[
                  line: 47
                ]]
                return UserSettings():GetService("UserGameSettings"):GetCameraYInvertValue()
            end
        )
        v8 = success and (cameraYInvertValue == -1)
    end

    return v3 or v8
end

function v1.IsInverted()
    --[[
      name: IsInverted
      line: 54
      upvalues:
        timestamp (ref, index: 1)
        v8 (ref, index: 2)
        v3 (ref, index: 3)
    ]]
    local timestamp2 = os.clock()

    if 2 < timestamp2 - timestamp then
        timestamp = timestamp2
        local success, cameraYInvertValue = pcall(
            function()
                --[[
                  line: 47
                ]]
                return UserSettings():GetService("UserGameSettings"):GetCameraYInvertValue()
            end
        )
        v8 = success and (cameraYInvertValue == -1)
    end

    return v3 or v8
end

function v1.Step(a17, a18, a19)
    --[[
      name: Step
      line: 59
      upvalues:
        v1 (copy, index: 1)
        v4 (ref,  index: 2)
        v5 (ref,  index: 3)
        clampedValue (ref,  index: 4)
        timestamp (ref,  index: 5)
        v8 (ref,  index: 6)
        v3 (ref,  index: 7)
    ]]
    local magnitude = a17.Magnitude

    if magnitude <= v1.DEADZONE then
        v4 = 0
        v5 = 0

        return 0, 0
    end

    local v21 = (math.min(magnitude, 1) - v1.DEADZONE) / (1 - v1.DEADZONE)
    local v22 = (v21 * v21) * 0.6 + v21 * 0.4

    if not (v1.BOOST_AT <= magnitude) or a19 then
        v4 = 0
        v5 = math.max(0, v5 - (a18 / v1.BOOST_FALL))
    else
        v4 += a18

        if v1.BOOST_DELAY <= v4 then
            v5 = math.min(1, v5 + (a18 / v1.BOOST_RAMP))
        end
    end

    local v23 = v1.MAX_RATE * v22 * (1 + ((v1.BOOST - 1) * v5)) * clampedValue * a18
    local v24 = a17 / magnitude
    local v25 = -v24.X * v23
    local v26 = v24.Y * v23 * v1.PITCH
    local timestamp2 = os.clock()

    if 2 < timestamp2 - timestamp then
        timestamp = timestamp2
        local success, cameraYInvertValue = pcall(
            function()
                --[[
                  line: 47
                ]]
                return UserSettings():GetService("UserGameSettings"):GetCameraYInvertValue()
            end
        )
        v8 = success and (cameraYInvertValue == -1)
    end

    local v30 = v3 or v8
    local v31 = v30 and -1 or 1

    return v25, v26 * v31
end

function v1.Boost()
    --[[
      name: Boost
      line: 82
      upvalues:
        v5 (ref, index: 1)
    ]]
    return v5
end

return v1