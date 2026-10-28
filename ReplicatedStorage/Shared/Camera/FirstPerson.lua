local Spring_1 = require(script.Parent:WaitForChild("Spring"))
local tbl_upv_1 = {}
tbl_upv_1.EYE_EASE = 5
local EYE_EASE_upv_1 = tbl_upv_1.EYE_EASE
tbl_upv_1.STRIDE = 7
tbl_upv_1.BOB_SPEED = 21
tbl_upv_1.BOB_EASE = 8
tbl_upv_1.CAM_BOB_Y = 0.03
tbl_upv_1.CAM_BOB_ROLL = 0.002617993877991494
tbl_upv_1.RUN_SPEED = 21
tbl_upv_1.STRAFE_ROLL = 0.019198621771937627
tbl_upv_1.SLIDE_ROLL = 0.041887902047863905
tbl_upv_1.LAND_FALL = 56
tbl_upv_1.LAND_MAX = 2.2
tbl_upv_1.DROP = 0.13
tbl_upv_1.NOD = 0.012217304763960306
tbl_upv_1.TAKEOFF_DROP = 0.05
local u1 = Spring_1.new(0, 6, 0.85)
local u2 = Spring_1.new(0, 3, 0.5)
local u3 = Spring_1.new(0, 3, 0.5)
local u4 = 0
local u5 = 0
local u6 = true
local u7 = false
local u8 = true
local u9 = 0
local u10 = nil
local u11 = 0
local u12 = 0
local u13 = 0
local u14 = nil
function tbl_upv_1.Set(a1)
    --[[
      name: Set
      line: 76
      upvalues:
        u7 (ref, index: 1)
    ]]
    u7 = a1 == true
end
function tbl_upv_1.Get()
    --[[
      name: Get
      line: 80
      upvalues:
        u7 (ref, index: 1)
    ]]
    return u7
end
function tbl_upv_1.SetBobbing(a1)
    --[[
      name: SetBobbing
      line: 84
      upvalues:
        u8 (ref, index: 1)
    ]]
    u8 = a1 == true
end
function tbl_upv_1.GetBobbing()
    --[[
      name: GetBobbing
      line: 88
      upvalues:
        u8 (ref, index: 1)
    ]]
    return u8
end
function tbl_upv_1.Step(a1, a2)
    --[[
      name: Step
      line: 94
      upvalues:
        u9 (ref,  index: 1)
        u10 (ref,  index: 2)
        u14 (ref,  index: 3)
        u12 (ref,  index: 4)
        u1 (copy, index: 5)
        u2 (copy, index: 6)
        u3 (copy, index: 7)
        u4 (ref,  index: 8)
        u5 (ref,  index: 9)
        u6 (ref,  index: 10)
        u7 (ref,  index: 11)
    ]]
    if a2 then
        local v1 = (u7 and 1) or 0
        if u9 < v1 then
            u9 = math.min(v1, u9 + (a1 / 0.2))
        elseif v1 < u9 then
            u9 = math.max(v1, u9 - (a1 / 0.2))
        end
        return u9
    end
    u9 = 0
    u10 = nil
    u14 = nil
    u12 = 0
    u1:Snap(0)
    u2:Snap(0)
    u3:Snap(0)
    u4 = 0
    u5 = 0
    u6 = true
    return 0
end
function tbl_upv_1.Eased()
    --[[
      name: Eased
      line: 116
      upvalues:
        u9 (ref, index: 1)
    ]]
    local v2 = u9
    return (v2 * v2) * (3 - (v2 * 2))
end
local function kick(a1, a2)
    --[[
      name: kick
      line: 122
    ]]
    a1:Impulse((((a2 * a1.frequency) * 2) * math.pi) / 0.546)
end
local function stepMotion(a1, a2, a3, a4, a5)
    --[[
      name: stepMotion
      line: 128
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        u6 (ref,  index: 3)
        u2 (copy, index: 4)
        u4 (ref,  index: 5)
        u5 (ref,  index: 6)
        u3 (copy, index: 7)
    ]]
    local RightVector_1 = a3.RightVector
    local v3 = Vector3.new(RightVector_1.X, 0, RightVector_1.Z)
    local v4 = ((v3.Magnitude > 0.001) and (a2:Dot(v3.Unit) / tbl_upv_1.RUN_SPEED)) or 0
    local v5 = -math.clamp(v4, -1.3, 1.3) * tbl_upv_1.STRAFE_ROLL
    if a5 then
        local v6 = not (math.abs(v4) > 0.15) and -1 or math.sign(v4)
        v5 = v5 - v6 * tbl_upv_1.SLIDE_ROLL
    end
    u1.target = v5
    if a4 then
        if not (u6) then
            v3 = -u5
            if u4 > 0.12 and v3 > 18 then
                local v7 = math.min(v3 / tbl_upv_1.LAND_FALL, tbl_upv_1.LAND_MAX)
                u2:Impulse(((((-tbl_upv_1.DROP * v7) * u2.frequency) * 2) * math.pi) / 0.546)
                u3:Impulse(((((-tbl_upv_1.NOD * v7) * u3.frequency) * 2) * math.pi) / 0.546)
            end
            u4 = 0
            u5 = 0
        end
    else
        if u6 and a2.Y > 20 then
            u2:Impulse((((-tbl_upv_1.TAKEOFF_DROP * u2.frequency) * 2) * math.pi) / 0.546)
        end
        u4 = u4 + a1
        u5 = math.min(u5, a2.Y)
    end
    u6 = a4
    u1:Update(a1)
    u2:Update(a1)
    u3:Update(a1)
end
function tbl_upv_1.StepBob(a1, a2, a3, a4, a5, a6)
    --[[
      name: StepBob
      line: 160
      upvalues:
        stepMotion (copy, index: 1)
        u14 (ref,  index: 2)
        u13 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        u12 (ref,  index: 5)
        u11 (ref,  index: 6)
    ]]
    if a5 and a6 then
        stepMotion(a1, a5, a6, a3, a4)
    end
    local v8 = 0
    local v9 = u14
    if v9 and a1 > 0 then
        local _ = a2 - v9
        v8 = Vector3.new((a2 - v9).X, 0, (a2 - v9).Z).Magnitude / a1
        v8 = ((v8 > 80) and 0) or v8
    end
    u14 = a2
    u13 = u13 + (v8 - u13) * (1 - math.exp(a1 * -12))
    local v10
    if not (a3) or a4 then
        v10 = 0
    else
        v10 = math.clamp((u13 - 1) / (tbl_upv_1.BOB_SPEED - 1), 0, 1.25)
    end
    u12 = u12 + (v10 - u12) * (1 - math.exp(-tbl_upv_1.BOB_EASE * a1))
    if u12 < 0.002 and v10 == 0 then
        u12 = 0
    end
    if not a3 then
        return
    end
    u11 = (u11 + ((((v8 * a1) / tbl_upv_1.STRIDE) * 2) * math.pi)) % 12.566370614359172
end
function tbl_upv_1.Bob()
    --[[
      name: Bob
      line: 186
      upvalues:
        u11 (ref, index: 1)
        u12 (ref, index: 2)
        u13 (ref, index: 3)
    ]]
    return u11, u12, u13
end
function tbl_upv_1.CameraBob()
    --[[
      name: CameraBob
      line: 192
      upvalues:
        u8 (ref,  index: 1)
        u2 (copy, index: 2)
        u3 (copy, index: 3)
        u1 (copy, index: 4)
        u12 (ref,  index: 5)
        u11 (ref,  index: 6)
        tbl_upv_1 (copy, index: 7)
    ]]
    if not u8 then
        return 0, 0, 0
    end
    local value_1 = u2.value
    local value_2 = u3.value
    local value_3 = u1.value
    local v11 = u12
    if v11 > 0 then
        value_1, value_3 = value_1 + (-math.cos(u11 * 2) * 0.5 * tbl_upv_1.CAM_BOB_Y) * v11, value_3 + (math.sin(u11) * tbl_upv_1.CAM_BOB_ROLL) * v11
    end
    return value_1, value_2, value_3
end
function tbl_upv_1.Eye(a1, a2, a3, a4, a5)
    --[[
      name: Eye
      line: 208
      upvalues:
        u10 (ref,  index: 1)
        EYE_EASE_upv_1 (copy, index: 2)
    ]]
    local v12 = ((a4 and (a4.Position.Y - a3.Position.Y)) or 1.5) + 0.25
    local v13 = u10
    local v14
    if v13 ~= nil then
        v14 = v13 + (v12 - v13) * (1 - math.exp(-EYE_EASE_upv_1 * a1))
    else
        v14 = v12
    end
    u10 = v14
    local v15 = Vector3.new(a5.X, 0, a5.Z)
    return (a2 + Vector3.new(0, v14, 0)) - (((v15.Magnitude > 0.001) and (v15.Unit * 0.3)) or Vector3.new(0, 0, 0))
end
return tbl_upv_1