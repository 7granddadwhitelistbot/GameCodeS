local tbl_upv_1 = {}
tbl_upv_1.MAX_RATE = 4.363323129985824
tbl_upv_1.PITCH = 0.75
tbl_upv_1.DEADZONE = 0.15
tbl_upv_1.BOOST = 1.6
tbl_upv_1.BOOST_AT = 0.92
tbl_upv_1.BOOST_DELAY = 0.12
tbl_upv_1.BOOST_RAMP = 0.3
tbl_upv_1.BOOST_FALL = 0.1
local u1 = 1
local u2 = false
local u3 = 0
local u4 = 0
function tbl_upv_1.SetSensitivity(a1)
    --[[
      name: SetSensitivity
      line: 28
      upvalues:
        u1 (ref, index: 1)
    ]]
    if type(a1) ~= "number" or a1 ~= a1 then
        return
    end
    u1 = math.clamp(a1, 0.1, 5)
end
function tbl_upv_1.GetSensitivity()
    --[[
      name: GetSensitivity
      line: 33
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.SetInvertY(a1)
    --[[
      name: SetInvertY
      line: 36
      upvalues:
        u2 (ref, index: 1)
    ]]
    u2 = a1 == true
end
local u5 = false
local u6 = -math.huge
local function inverted()
    --[[
      name: inverted
      line: 43
      upvalues:
        u6 (ref, index: 1)
        u5 (ref, index: 2)
        u2 (ref, index: 3)
    ]]
    local v1 = os.clock()
    if v1 - u6 > 2 then
        u6 = v1
        local success_1, v2 = pcall(function() end)
        u5 = success_1 and (v2 == -1)
    end
    local v3 = u2 or u5
    return v3
end
function tbl_upv_1.IsInverted()
    --[[
      name: IsInverted
      line: 54
      upvalues:
        u6 (ref, index: 1)
        u5 (ref, index: 2)
        u2 (ref, index: 3)
    ]]
    local v4 = os.clock()
    if v4 - u6 > 2 then
        u6 = v4
        local success_2, v5 = pcall(function() end)
        u5 = success_2 and (v5 == -1)
    end
    local v6 = u2 or u5
    return v6
end
function tbl_upv_1.Step(a1, a2, a3)
    --[[
      name: Step
      line: 59
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        u4 (ref,  index: 3)
        u1 (ref,  index: 4)
        u6 (ref,  index: 5)
        u5 (ref,  index: 6)
        u2 (ref,  index: 7)
    ]]
    local Magnitude_1 = a1.Magnitude
    if Magnitude_1 <= tbl_upv_1.DEADZONE then
        u3 = 0
        u4 = 0
        return 0, 0
    else
        local v7 = (math.min(Magnitude_1, 1) - tbl_upv_1.DEADZONE) / (1 - tbl_upv_1.DEADZONE)
        if not (tbl_upv_1.BOOST_AT <= Magnitude_1) or a3 then
            u3 = 0
            u4 = math.max(0, u4 - a2 / tbl_upv_1.BOOST_FALL)
        else
            u3 = u3 + a2
            if tbl_upv_1.BOOST_DELAY <= u3 then
                u4 = math.min(1, u4 + (a2 / tbl_upv_1.BOOST_RAMP))
            end
        end
        local v8 = ((tbl_upv_1.MAX_RATE * (((v7 * v7) * 0.6) + (v7 * 0.4))) * (1 + ((tbl_upv_1.BOOST - 1) * u4))) * u1 * a2
        local v9 = a1 / Magnitude_1
        local v10 = -v9.X * v8
        local v11 = os.clock()
        if v11 - u6 > 2 then
            u6 = v11
            local success_3, v12 = pcall(
                function()
                    --[[
                      line: 47
                    ]]
                    return UserSettings():GetService("UserGameSettings"):GetCameraYInvertValue()
                end
            )
            u5 = success_3 and (v12 == -1)
        end
        local v13 = u2 or u5
        local v14
        if v13 then
            v14 = -1
        else
            v14 = 1
        end
        return v10, (v9.Y * v8) * tbl_upv_1.PITCH * v14
    end
end
function tbl_upv_1.Boost()
    --[[
      name: Boost
      line: 82
      upvalues:
        u4 (ref, index: 1)
    ]]
    return u4
end
return tbl_upv_1