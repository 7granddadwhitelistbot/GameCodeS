local tbl_upv_1 = {}
tbl_upv_1.EYE_EASE = 5
local EYE_EASE_upv_1 = tbl_upv_1.EYE_EASE
tbl_upv_1.STRIDE = 7
tbl_upv_1.BOB_SPEED = 21
tbl_upv_1.BOB_EASE = 8
tbl_upv_1.CAM_BOB_Y = 0.03
tbl_upv_1.CAM_BOB_ROLL = 0.002617993877991494
local u1 = false
local u2 = true
local u3 = 0
local u4 = nil
local u5 = 0
local u6 = 0
local u7 = 0
local u8 = nil
function tbl_upv_1.Set(a1)
    --[[
      name: Set
      line: 51
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = a1 == true
end
function tbl_upv_1.Get()
    --[[
      name: Get
      line: 55
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.SetBobbing(a1)
    --[[
      name: SetBobbing
      line: 59
      upvalues:
        u2 (ref, index: 1)
    ]]
    u2 = a1 == true
end
function tbl_upv_1.GetBobbing()
    --[[
      name: GetBobbing
      line: 63
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Step(a1, a2)
    --[[
      name: Step
      line: 69
      upvalues:
        u3 (ref, index: 1)
        u4 (ref, index: 2)
        u8 (ref, index: 3)
        u6 (ref, index: 4)
        u1 (ref, index: 5)
    ]]
    if a2 then
        local v1 = (u1 and 1) or 0
        if u3 < v1 then
            u3 = math.min(v1, u3 + (a1 / 0.2))
        elseif v1 < u3 then
            u3 = math.max(v1, u3 - (a1 / 0.2))
        end
        return u3
    end
    u3 = 0
    u4 = nil
    u8 = nil
    u6 = 0
    return 0
end
function tbl_upv_1.Eased()
    --[[
      name: Eased
      line: 87
      upvalues:
        u3 (ref, index: 1)
    ]]
    local v2 = u3
    return (v2 * v2) * (3 - (v2 * 2))
end
function tbl_upv_1.StepBob(a1, a2, a3, a4)
    --[[
      name: StepBob
      line: 94
      upvalues:
        u8 (ref,  index: 1)
        u7 (ref,  index: 2)
        tbl_upv_1 (copy, index: 3)
        u6 (ref,  index: 4)
        u5 (ref,  index: 5)
    ]]
    local v3 = 0
    local v4 = u8
    if v4 and a1 > 0 then
        local _ = a2 - v4
        v3 = Vector3.new((a2 - v4).X, 0, (a2 - v4).Z).Magnitude / a1
        v3 = ((v3 > 80) and 0) or v3
    end
    u8 = a2
    u7 = u7 + (v3 - u7) * (1 - math.exp(a1 * -12))
    local v5
    if not (a3) or a4 then
        v5 = 0
    else
        v5 = math.clamp((u7 - 1) / (tbl_upv_1.BOB_SPEED - 1), 0, 1.25)
    end
    u6 = u6 + (v5 - u6) * (1 - math.exp(-tbl_upv_1.BOB_EASE * a1))
    if u6 < 0.002 and v5 == 0 then
        u6 = 0
    end
    if not a3 then
        return
    end
    u5 = (u5 + ((((v3 * a1) / tbl_upv_1.STRIDE) * 2) * math.pi)) % 12.566370614359172
end
function tbl_upv_1.Bob()
    --[[
      name: Bob
      line: 117
      upvalues:
        u5 (ref, index: 1)
        u6 (ref, index: 2)
        u7 (ref, index: 3)
    ]]
    return u5, u6, u7
end
function tbl_upv_1.CameraBob()
    --[[
      name: CameraBob
      line: 122
      upvalues:
        u2 (ref,  index: 1)
        u6 (ref,  index: 2)
        u5 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not u2 or (u6 <= 0) then
        return 0, 0
    end
    local v6 = u6
    return (-math.cos(u5 * 2) * 0.5 * tbl_upv_1.CAM_BOB_Y) * v6, (math.sin(u5) * tbl_upv_1.CAM_BOB_ROLL) * v6
end
function tbl_upv_1.Eye(a1, a2, a3, a4, a5)
    --[[
      name: Eye
      line: 133
      upvalues:
        u4 (ref,  index: 1)
        EYE_EASE_upv_1 (copy, index: 2)
    ]]
    local v7 = ((a4 and (a4.Position.Y - a3.Position.Y)) or 1.5) + 0.25
    local v8 = u4
    local v9
    if v8 ~= nil then
        v9 = v8 + (v7 - v8) * (1 - math.exp(-EYE_EASE_upv_1 * a1))
    else
        v9 = v7
    end
    u4 = v9
    local v10 = Vector3.new(a5.X, 0, a5.Z)
    return (a2 + Vector3.new(0, v9, 0)) - (((v10.Magnitude > 0.001) and (v10.Unit * 0.3)) or Vector3.new(0, 0, 0))
end
return tbl_upv_1