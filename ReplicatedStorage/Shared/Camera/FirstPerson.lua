local Spring = require(script.Parent:WaitForChild("Spring"))
local v2 = {EYE_EASE = 5}
local eyeEase = v2.EYE_EASE
v2.STRIDE = 7
v2.BOB_SPEED = 21
v2.BOB_EASE = 8
v2.CAM_BOB_Y = 0.03
v2.CAM_BOB_ROLL = 0.002617993877991494
v2.RUN_SPEED = 21
v2.STRAFE_ROLL = 0.019198621771937627
v2.SLIDE_ROLL = 0.041887902047863905
v2.LAND_FALL = 56
v2.LAND_MAX = 2.2
v2.DROP = 0.13
v2.NOD = 0.012217304763960306
v2.TAKEOFF_DROP = 0.05
local spring = Spring.new(0, 6, 0.85)
local spring2 = Spring.new(0, 3, 0.5)
local spring3 = Spring.new(0, 3, 0.5)
local v7 = 0
local v8 = 0
local v9 = true
local v10 = false
local v11 = true
local v12 = 0
local v13 = nil
local v14 = 0
local v15 = 0
local v16 = 0
local v17 = nil

function v2.Set(a18)
    --[[
      name: Set
      line: 76
      upvalues:
        v10 (ref, index: 1)
    ]]
    v10 = a18 == true
end

function v2.Get()
    --[[
      name: Get
      line: 80
      upvalues:
        v10 (ref, index: 1)
    ]]
    return v10
end

function v2.SetBobbing(bobbing)
    --[[
      name: SetBobbing
      line: 84
      upvalues:
        v11 (ref, index: 1)
    ]]
    v11 = bobbing == true
end

function v2.GetBobbing()
    --[[
      name: GetBobbing
      line: 88
      upvalues:
        v11 (ref, index: 1)
    ]]
    return v11
end

function v2.Step(a20, a21)
    --[[
      name: Step
      line: 94
      upvalues:
        v12 (ref,  index: 1)
        v13 (ref,  index: 2)
        v17 (ref,  index: 3)
        v15 (ref,  index: 4)
        spring (copy, index: 5)
        spring2 (copy, index: 6)
        spring3 (copy, index: 7)
        v7 (ref,  index: 8)
        v8 (ref,  index: 9)
        v9 (ref,  index: 10)
        v10 (ref,  index: 11)
    ]]
    if not a21 then
        v12 = 0
        v13 = nil
        v17 = nil
        v15 = 0
        spring:Snap(0)
        spring2:Snap(0)
        spring3:Snap(0)
        v7 = 0
        v8 = 0
        v9 = true

        return 0
    end

    local v22 = v10 and 1 or 0

    if v12 < v22 then
        v12 = math.min(v22, v12 + (a20 / 0.2))
    elseif v22 < v12 then
        v12 = math.max(v22, v12 - (a20 / 0.2))
    end

    return v12
end

function v2.Eased()
    --[[
      name: Eased
      line: 116
      upvalues:
        v12 (ref, index: 1)
    ]]
    local v23 = v12
    return v23 * v23 * (3 - (v23 * 2))
end

local function kick(a25, a26)
    --[[
      name: kick
      line: 122
    ]]
    a25:Impulse((((a26 * a25.frequency) * 2) * math.pi) / 0.546)
end

local function stepMotion(a28, a29, a30, a31, a32)
    --[[
      name: stepMotion
      line: 128
      upvalues:
        v2 (copy, index: 1)
        spring (copy, index: 2)
        v9 (ref,  index: 3)
        spring2 (copy, index: 4)
        v7 (ref,  index: 5)
        v8 (ref,  index: 6)
        spring3 (copy, index: 7)
    ]]
    local v33
    local rightVector = a30.RightVector
    local vector3 = Vector3.new(rightVector.X, 0, rightVector.Z)

    if not (0.001 < vector3.Magnitude) then
        v33 = 0
    else
        v33 = a29:Dot(vector3.Unit) / v2.RUN_SPEED
    end

    local target = -math.clamp(v33, -1.3, 1.3) * v2.STRAFE_ROLL

    if a32 then
        local v37

        if not (0.15 < math.abs(v33)) then
            v37 = -1
        else
            v37 = math.sign(v33)
        end

        target -= v37 * v2.SLIDE_ROLL
    end

    spring.target = target

    if a31 then
        if not v9 then
            local v38 = -v8

            if 0.12 < v7 and 18 < v38 then
                local v39 = math.min(v38 / v2.LAND_FALL, v2.LAND_MAX)
                spring2:Impulse((((-v2.DROP * v39 * spring2.frequency) * 2) * math.pi) / 0.546)
                spring3:Impulse((((-v2.NOD * v39 * spring3.frequency) * 2) * math.pi) / 0.546)
            end

            v7 = 0
            v8 = 0
        end
    else
        if v9 and 20 < a29.Y then
            spring2:Impulse((((-v2.TAKEOFF_DROP * spring2.frequency) * 2) * math.pi) / 0.546)
        end

        v7 += a28
        v8 = math.min(v8, a29.Y)
    end

    v9 = a31
    spring:Update(a28)
    spring2:Update(a28)
    spring3:Update(a28)
end

function v2.StepBob(a40, a41, a42, a43, a44, a45)
    --[[
      name: StepBob
      line: 160
      upvalues:
        stepMotion (copy, index: 1)
        v17 (ref,  index: 2)
        v16 (ref,  index: 3)
        v2 (copy, index: 4)
        v15 (ref,  index: 5)
        v14 (ref,  index: 6)
    ]]
    local clampedValue

    if a44 and a45 then
        stepMotion(a40, a44, a45, a42, a43)
    end

    local v47 = 0
    local v48 = v17

    if v48 and 0 < a40 then
        local v49 = a41 - v48
        v47 = Vector3.new(v49.X, 0, v49.Z).Magnitude / a40

        if 80 < v47 then
            v47 = 0
        end
    end

    v17 = a41
    v16 += ((v47 - v16) * (1 - math.exp(a40 * -12)))

    if not a42 or a43 then
        clampedValue = 0
    else
        clampedValue = math.clamp((v16 - 1) / (v2.BOB_SPEED - 1), 0, 1.25)
    end

    v15 += ((clampedValue - v15) * (1 - math.exp(-v2.BOB_EASE * a40)))

    if v15 < 0.002 and clampedValue == 0 then
        v15 = 0
    end

    if a42 then
        v14 = (v14 + (((v47 * a40 / v2.STRIDE) * 2) * math.pi)) % 12.566370614359172
    end
end

function v2.Bob()
    --[[
      name: Bob
      line: 186
      upvalues:
        v14 (ref, index: 1)
        v15 (ref, index: 2)
        v16 (ref, index: 3)
    ]]
    return v14, v15, v16
end

function v2.CameraBob()
    --[[
      name: CameraBob
      line: 192
      upvalues:
        v11 (ref,  index: 1)
        spring2 (copy, index: 2)
        spring3 (copy, index: 3)
        spring (copy, index: 4)
        v15 (ref,  index: 5)
        v14 (ref,  index: 6)
        v2 (copy, index: 7)
    ]]
    if not v11 then
        return 0, 0, 0
    end

    local v50 = spring2.value
    local value = spring3.value
    local v52 = spring.value
    local v53 = v15

    if 0 < v53 then
        v50 += (-math.cos(v14 * 2) * 0.5 * v2.CAM_BOB_Y) * v53
        v52 += (math.sin(v14) * v2.CAM_BOB_ROLL) * v53
    end

    return v50, value, v52
end

function v2.Eye(a54, a55, a56, a57, a58)
    --[[
      name: Eye
      line: 208
      upvalues:
        v13 (ref,  index: 1)
        eyeEase (copy, index: 2)
    ]]
    local vector3
    local v60 = not a57 and 1.5 or a57.Position.Y - a56.Position.Y
    local v61 = v60 + 0.25
    local y = v13
    y = if y == nil then v61 else y + (v61 - y) * (1 - math.exp(-eyeEase * a54))
    v13 = y
    local vector32 = Vector3.new(a58.X, 0, a58.Z)

    if not (0.001 < vector32.Magnitude) then
        vector3 = Vector3.new(0, 0, 0)
    else
        vector3 = vector32.Unit * 0.3
    end

    return (a55 + Vector3.new(0, y, 0)) - vector3
end

return v2