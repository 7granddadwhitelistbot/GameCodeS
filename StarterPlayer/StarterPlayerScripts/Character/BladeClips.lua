local v1 = {}

local function V(x: number, y: number, z: number)
    --[[
      name: V
      line: 54
    ]]
    return (Vector3.new(x, y, z))
end

function v1.Frame(a6, a7, a8)
    --[[
      name: Frame
      line: 60
    ]]
    local v9 = not (1e-04 < a7.Magnitude) and Vector3.new(0, 1, 0) or a7.Unit
    local v10 = a8 - v9 * a8:Dot(v9)

    if v10.Magnitude < 0.001 then
        v10 = v9:Cross(Vector3.new(1, 0, 0))

        if v10.Magnitude < 0.001 then
            v10 = v9:Cross(Vector3.new(0, 0, 1))
        end
    end

    local v11 = -v10.Unit

    return CFrame.fromMatrix(a6, v9:Cross(v11), v9, v11)
end

v1.SWORD = {
    slash_r = {
        contact = 0.09,
        release = 0.58,
        smear = {0.04, 0.15},
        keys = {
            {t = 0.03, pos = Vector3.new(0.46000000834465027, -0.10000000149011612, -0.5), tip = Vector3.new(0.41999998688697815, 0.8799999952316284, -0.2199999988079071), edge = Vector3.new(0.10000000149011612, 0, -1)},
            {t = 0.055, pos = Vector3.new(0.5799999833106995, -0.10000000149011612, -0.5), tip = Vector3.new(0.8830000162124634, 0.20000000298023224, -0.4690000116825104), edge = Vector3.new(-0.4690000116825104, 0, -0.8830000162124634)},
            {t = 0.09, pos = Vector3.new(0.03999999910593033, -0.20000000298023224, -0.5), tip = Vector3.new(0.5740000009536743, 0.11999999731779099, -0.8190000057220459), edge = Vector3.new(-0.8190000057220459, 0, -0.5740000009536743)},
            {t = 0.14, pos = Vector3.new(-0.6399999856948853, -0.36000001430511475, -0.5), tip = Vector3.new(-0.13899999856948853, 0.05000000074505806, -0.9900000095367432), edge = Vector3.new(-0.9900000095367432, 0, 0.13899999856948853)},
            {t = 0.24, pos = Vector3.new(-0.8600000143051147, -0.5600000023841858, -0.46000000834465027), tip = Vector3.new(-0.8659999966621399, -0.05000000074505806, -0.5), edge = Vector3.new(-0.5, 0, 0.8659999966621399)},
            {t = 0.37, pos = Vector3.new(0.2199999988079071, -0.8399999737739563, -0.47999998927116394), tip = Vector3.new(-0.20000000298023224, 0.8500000238418579, -0.5), edge = Vector3.new(-0.6000000238418579, 0, -0.800000011920929)},
            {t = 0.47, rest = Vector3.new(0, 0.02500000037252903, 0)},
            {t = 0.58, rest = Vector3.new(0, 0, 0)}
        }
    },
    slash_l = {
        contact = 0.09,
        release = 0.5,
        smear = {0.04, 0.15},
        keys = {
            {t = 0.03, pos = Vector3.new(-0.41999998688697815, -0.6600000262260437, -0.46000000834465027), tip = Vector3.new(-0.44999998807907104, 0.800000011920929, -0.4000000059604645), edge = Vector3.new(-0.10000000149011612, 0, -1)},
            {t = 0.055, pos = Vector3.new(-0.5799999833106995, -0.18000000715255737, -0.5), tip = Vector3.new(-0.8830000162124634, 0.20000000298023224, -0.4690000116825104), edge = Vector3.new(0.4690000116825104, 0, -0.8830000162124634)},
            {t = 0.09, pos = Vector3.new(-0.019999999552965164, -0.17000000178813934, -0.5), tip = Vector3.new(-0.5740000009536743, 0.14000000059604645, -0.8190000057220459), edge = Vector3.new(0.8190000057220459, 0, -0.5740000009536743)},
            {t = 0.14, pos = Vector3.new(0.6399999856948853, -0.07000000029802322, -0.5), tip = Vector3.new(0.13899999856948853, 0.10000000149011612, -0.9900000095367432), edge = Vector3.new(0.9900000095367432, 0, 0.13899999856948853)},
            {t = 0.24, pos = Vector3.new(0.8600000143051147, -0.30000001192092896, -0.46000000834465027), tip = Vector3.new(0.75, -0.44999998807907104, -0.47999998927116394), edge = Vector3.new(0.5, 0, 0.8659999966621399)},
            {t = 0.4, rest = Vector3.new(0, 0.02500000037252903, 0)},
            {t = 0.5, rest = Vector3.new(0, 0, 0)}
        }
    },
    finisher = {
        contact = 0.09,
        release = 0.61,
        smear = {0.04, 0.16},
        keys = {
            {t = 0.03, pos = Vector3.new(0.4000000059604645, 0.03999999910593033, -0.5), tip = Vector3.new(0.7570000290870667, 0.6359999775886536, 0.1509999930858612), edge = Vector3.new(-0.22200000286102295, 0.46700000762939453, -0.8560000061988831)},
            {t = 0.055, pos = Vector3.new(0.4000000059604645, 0.18000000715255737, -0.5), tip = Vector3.new(0.18700000643730164, 0.722000002861023, -0.6660000085830688), edge = Vector3.new(-0.765999972820282, -0.31700000166893005, -0.5590000152587891)},
            {t = 0.09, pos = Vector3.new(0.10000000149011612, -0.14000000059604645, -0.5), tip = Vector3.new(-0.3499999940395355, 0.3499999940395355, -0.8690000176429749), edge = Vector3.new(-0.7070000171661377, -0.7070000171661377, 0)},
            {t = 0.145, pos = Vector3.new(-0.44999998807907104, -0.4399999976158142, -0.5), tip = Vector3.new(-0.765999972820282, -0.31700000166893005, -0.5590000152587891), edge = Vector3.new(-0.18700000643730164, -0.722000002861023, 0.6660000085830688)},
            {t = 0.26, pos = Vector3.new(-0.6600000262260437, -0.6600000262260437, -0.4399999976158142), tip = Vector3.new(-0.6359999775886536, -0.7570000290870667, 0.1509999930858612), edge = Vector3.new(0.46700000762939453, -0.22200000286102295, 0.8560000061988831)},
            {t = 0.4, pos = Vector3.new(0.2199999988079071, -0.8399999737739563, -0.47999998927116394), tip = Vector3.new(-0.20000000298023224, 0.8500000238418579, -0.5), edge = Vector3.new(-0.6000000238418579, 0, -0.800000011920929)},
            {t = 0.5, rest = Vector3.new(0, 0.02500000037252903, 0)},
            {t = 0.61, rest = Vector3.new(0, 0, 0)}
        }
    },
    draw = {contact = 0, release = 0.3, keys = {{t = 0.12, pos = Vector3.new(0.4000000059604645, -0.36000001430511475, -0.5600000023841858), tip = Vector3.new(0.05000000074505806, 0.550000011920929, -0.8299999833106995), edge = Vector3.new(-0.699999988079071, 0.10000000149011612, -0.699999988079071)}, {t = 0.2, rest = Vector3.new(0, 0.029999999329447746, 0)}, {t = 0.3, rest = Vector3.new(0, 0, 0)}}}
}
v1.DAGGER = {
    cut = {
        contact = 0.06,
        release = 0.395,
        smear = {0.045, 0.125},
        keys = {
            {t = 0.024, pos = Vector3.new(0.41999998688697815, 0.03999999910593033, -0.4399999976158142), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(-0.13199999928474426, -0.3089999854564667, -0.9419999718666077)},
            {t = 0.046, pos = Vector3.new(0.3199999928474426, 0.41999998688697815, -0.4399999976158142), tip = Vector3.new(0.31700000166893005, 0.765999972820282, -0.5590000152587891), edge = Vector3.new(-0.722000002861023, -0.18700000643730164, -0.6660000085830688)},
            {t = 0.07, pos = Vector3.new(0.05999999865889549, -0.05999999865889549, -0.4399999976158142), tip = Vector3.new(-0.3499999940395355, 0.3499999940395355, -0.8690000176429749), edge = Vector3.new(-0.7070000171661377, -0.7070000171661377, 0)},
            {t = 0.115, pos = Vector3.new(-0.47999998927116394, -0.41999998688697815, -0.4399999976158142), tip = Vector3.new(-0.7799999713897705, -0.3790000081062317, -0.49900001287460327), edge = Vector3.new(-0.11900000274181366, -0.6919999718666077, 0.7120000123977661)},
            {t = 0.175, pos = Vector3.new(-0.5600000023841858, -0.5600000023841858, -0.4000000059604645), tip = Vector3.new(-0.6359999775886536, -0.7570000290870667, 0.1509999930858612), edge = Vector3.new(0.46700000762939453, -0.22200000286102295, 0.8560000061988831)},
            {t = 0.245, pos = Vector3.new(0.20000000298023224, -0.6000000238418579, -0.41999998688697815), tip = Vector3.new(-0.20000000298023224, 0.8500000238418579, -0.5), edge = Vector3.new(-0.6000000238418579, 0, -0.800000011920929)},
            {t = 0.315, rest = Vector3.new(0, 0.019999999552965164, 0)},
            {t = 0.395, rest = Vector3.new(0, 0, 0)}
        }
    },
    back = {
        contact = 0.06,
        release = 0.34,
        smear = {0.035, 0.12},
        keys = {
            {t = 0.03, pos = Vector3.new(-0.20000000298023224, -0.41999998688697815, -0.4399999976158142), tip = Vector3.new(-0.5450000166893005, -0.7839999794960022, 0.296999990940094), edge = Vector3.new(-0.5699999928474426, 0.08699999749660492, -0.8169999718666077)},
            {t = 0.07, pos = Vector3.new(0.019999999552965164, -0.07999999821186066, -0.4399999976158142), tip = Vector3.new(-0.3499999940395355, 0.3499999940395355, -0.8690000176429749), edge = Vector3.new(0.7070000171661377, 0.7070000171661377, 0)},
            {t = 0.11, pos = Vector3.new(0.5, 0.3400000035762787, -0.4399999976158142), tip = Vector3.new(0.49300000071525574, 0.7889999747276306, -0.367000013589859), edge = Vector3.new(0.6159999966621399, -0.017999999225139618, 0.7879999876022339)},
            {t = 0.17, pos = Vector3.new(0.6200000047683716, 0.4399999976158142, -0.41999998688697815), tip = Vector3.new(0.7739999890327454, 0.5929999947547913, 0.22499999403953552), edge = Vector3.new(0.1550000011920929, -0.5210000276565552, 0.8399999737739563)},
            {t = 0.26, rest = Vector3.new(0, -0.019999999552965164, 0)},
            {t = 0.34, rest = Vector3.new(0, 0, 0)}
        }
    },
    draw = {
        contact = 0,
        release = 0.25,
        keys = {
            {t = 0.07, pos = Vector3.new(0.3799999952316284, -0.41999998688697815, -0.5199999809265137), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(-0.9290000200271606, -0.2939999997615814, 0.22699999809265137)},
            {t = 0.12, pos = Vector3.new(0.3499999940395355, -0.3100000023841858, -0.5600000023841858), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(0.13199999928474426, 0.3089999854564667, 0.9419999718666077)},
            {t = 0.17, pos = Vector3.new(0.3400000035762787, -0.25, -0.5799999833106995), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(0.9290000200271606, 0.2939999997615814, -0.22699999809265137)},
            {t = 0.25, rest = Vector3.new(0, 0, 0)}
        }
    }
}
v1.SETS = {Sword = v1.SWORD, Dagger = v1.DAGGER}
v1.DRAW = {Sword = v1.Frame(Vector3.new(0.46000000834465027, -0.7799999713897705, -0.46000000834465027), Vector3.new(-0.15000000596046448, -0.20000000298023224, -0.9700000286102295), Vector3.new(-0.699999988079071, 0.699999988079071, 0)), Dagger = v1.Frame(Vector3.new(0.41999998688697815, -0.6200000047683716, -0.4399999976158142), Vector3.new(-0.15000000596046448, -0.20000000298023224, -0.9700000286102295), Vector3.new(-0.699999988079071, 0.699999988079071, 0))}

function v1.Pick(a12, a13, a14)
    --[[
      name: Pick
      line: 213
    ]]
    local v15 = a13 % 2 == 0

    if a12 == "Dagger" then
        if v15 then
            return "back"
        end

        return "cut"
    end

    if a14 then
        return "finisher"
    end
    if v15 then
        return "slash_l"
    end

    return "slash_r"
end

function v1.Subdivide(a16, a17, a18)
    --[[
      name: Subdivide
      line: 224
    ]]
    local function wrap(a20)
        --[[
          name: wrap
          line: 237
        ]]
        return ((a20 + 180) % 360) - 180
    end

    local keys = {}
    local v22 = a18 and {t = 0, rest = a18.rest or Vector3.new(0, 0, 0), rot = a18.rot or Vector3.new(0, 0, 0)}
        or nil

    for _, key in a16.keys do
        if not v22 or not v22.rest or not key.rest then
            table.insert(keys, key)
            v22 = key
        else
            local v25 = v22.rot or Vector3.new(0, 0, 0)
            local v26 = key.rot or Vector3.new(0, 0, 0)
            local v27 = v26 - v25

            if not key.rot then
                v27 = -Vector3.new(wrap(v25.X), wrap(v25.Y), (wrap(v25.Z)))
                v26 = v25 + v27
            end

            local ceilingValue = math.ceil(math.max(math.abs(v27.X), math.abs(v27.Y), (math.abs(v27.Z))) / (a17 or 60))

            for index = 1, ceilingValue - 1 do
                local alpha = index / ceilingValue
                table.insert(keys, {t = v22.t + ((key.t - v22.t) * alpha), rest = v22.rest:Lerp(key.rest, alpha), rot = v25:Lerp(v26, alpha)})
            end

            table.insert(keys, key)
            v22 = key
        end
    end

    a16.keys = keys

    return a16
end

function v1.Turn(a31, a32)
    --[[
      name: Turn
      line: 264
    ]]
    local v33 = if a32 and 0.001 < a32.Magnitude then CFrame.fromAxisAngle(-a32.Unit, a31.Z * 0.017453292519943295) else CFrame.fromEulerAnglesYXZ(0, 0, a31.Z * 0.017453292519943295)
    return v33 * CFrame.fromEulerAnglesYXZ(a31.X * 0.017453292519943295, a31.Y * 0.017453292519943295, 0)
end

function v1.StartFrame(a34, a35)
    --[[
      name: StartFrame
      line: 271
      upvalues:
        v1 (copy, index: 1)
    ]]
    if typeof(a34) == "CFrame" then
        return a34
    end

    local v36 = a34.rest or Vector3.new(0, 0, 0)
    local v37 = a34.rot or Vector3.new(0, 0, 0)

    return CFrame.new(a35.Position + v36) * v1.Turn(v37) * a35.Rotation
end

function v1.Eval(a38, a39, a40, a41, a42, a43)
    --[[
      name: Eval
      line: 283
      upvalues:
        v1 (copy, index: 1)
    ]]
    local readIndex
    local v45 = a41 or 1
    local v46 = a42 or CFrame.identity
    local keys = a38.keys
    local keyKey = #keys

    local function knotT(keyKey)
        --[[
          name: knotT
          line: 289
          upvalues:
            keys (copy, index: 1)
            v45 (copy, index: 2)
        ]]
        if keyKey == 0 then
            return 0
        end

        return keys[keyKey].t * v45
    end

    local function knotV(keyKey, a53: number)
        --[[
          name: knotV
          line: 292
          upvalues:
            a39 (copy, index: 1)
            keys (copy, index: 2)
            v46 (copy, index: 3)
            v1 (copy, index: 4)
            a38 (copy, index: 5)
        ]]
        if keyKey == 0 then
            if a53 == 1 then
                return a39.Position
            end
            if a53 == 2 then
                return a39.UpVector
            end

            return a39.LookVector
        end

        local key = keys[keyKey]

        if not key.rest then
            if a53 == 1 then
                return key.pos
            end
            if a53 == 2 then
                return key.tip.Unit
            end

            return key.edge.Unit
        end

        local v55
        local rot = key.rot

        if rot then
            local turn = v1.Turn
            local v58 = if a38.eyeRoll then v46.Position + key.rest else nil
            v55 = turn(rot, v58) * v46.Rotation
        else
            v55 = v46
        end

        if a53 ~= 1 then
            if a53 == 2 then
                return v55.UpVector
            end

            return v55.LookVector
        end

        local v59 = v46.Position + key.rest

        if a38.pivot and rot then
            v59 += (v46.UpVector - v55.UpVector) * a38.pivot
        end

        return v59
    end

    local v60 = keyKey == 0 and 0 or keys[keyKey].t * v45

    if v60 <= a40 then
        return v1.Frame(knotV(keyKey, 1), knotV(keyKey, 2), (knotV(keyKey, 3)))
    end

    readIndex = 0

    while readIndex < keyKey - 1 do
        local keyKey2 = readIndex + 1
        local v62 = keyKey2 == 0 and 0 or keys[keyKey2].t * v45

        if not (v62 < a40) then
            break
        end

        readIndex += 1
    end

    local v63 = readIndex == 0 and 0 or keys[readIndex].t * v45
    local keyKey3 = readIndex + 1
    local v65 = keyKey3 == 0 and 0 or keys[keyKey3].t * v45
    local v66 = math.max(v65 - v63, 1e-04)
    local clampedValue = math.clamp((a40 - v63) / v66, 0, 1)
    local v68 = clampedValue * clampedValue
    local v69 = clampedValue * clampedValue * clampedValue
    local v70 = v69 * 2 - (v68 * 3) + 1
    local v71 = v69 - (v68 * 2) + clampedValue
    local v72 = v69 * -2 + v68 * 3
    local v73 = v69 - v68

    local function tangent(a75, a76: number)
        --[[
          name: tangent
          line: 326
          upvalues:
            a43 (copy, index: 1)
            keyKey (copy, index: 2)
            knotV (copy, index: 3)
            keys (copy, index: 4)
            v45 (copy, index: 5)
        ]]
        if not (a75 <= 0) then
            if keyKey <= a75 then
                return Vector3.new(0, 0, 0)
            end

            local v77 = knotV(a75 + 1, a76) - knotV(a75 - 1, a76)
            local keyKey2 = a75 + 1
            local v79 = keyKey2 == 0 and 0 or keys[keyKey2].t * v45
            local keyKey3 = a75 - 1
            local v81 = keyKey3 == 0 and 0 or keys[keyKey3].t * v45

            return v77 / math.max(v79 - v81, 1e-04)
        end

        if not a43 then
            return Vector3.new(0, 0, 0)
        end
        if a76 == 1 then
            return a43.pos
        end
        if a76 == 2 then
            return a43.tip
        end

        return a43.edge
    end

    local v82 = {}

    for index = 1, 3 do
        local v84 = knotV(readIndex, index)
        local v85 = knotV(readIndex + 1, index)
        v82[index] = (v84 * v70 + (tangent(readIndex, index) * (v71 * v66))) + (v85 * v72) + (tangent(readIndex + 1, index) * (v73 * v66))
    end

    return v1.Frame(v82[1], v82[2], v82[3])
end

return v1