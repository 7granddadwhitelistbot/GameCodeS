local tbl_upv_1 = {}
local function V(a1, a2, a3)
    --[[
      name: V
      line: 54
    ]]
    return (Vector3.new(a1, a2, a3))
end
function tbl_upv_1.Frame(a1, a2, a3)
    --[[
      name: Frame
      line: 60
    ]]
    local v1 = ((not (a2.Magnitude > 1e-04)) and Vector3.new(0, 1, 0)) or (a2.Unit)
    local v2 = a3 - v1 * a3:Dot(v1)
    if v2.Magnitude < 0.001 then
        v2 = v1:Cross(Vector3.new(1, 0, 0))
        if v2.Magnitude < 0.001 then
            v2 = v1:Cross(Vector3.new(0, 0, 1))
        end
    end
    local v3 = -v2.Unit
    return CFrame.fromMatrix(a1, v1:Cross(v3), v1, v3)
end
local tbl_2 = {contact = 0.09, release = 0.5}
tbl_2.smear = {0.04, 0.15}
tbl_2.keys = {
    {t = 0.03, pos = Vector3.new(-0.41999998688697815, -0.6600000262260437, -0.46000000834465027), tip = Vector3.new(-0.44999998807907104, 0.800000011920929, -0.4000000059604645), edge = Vector3.new(-0.10000000149011612, 0, -1)},
    {t = 0.055, pos = Vector3.new(-0.5799999833106995, -0.18000000715255737, -0.5), tip = Vector3.new(-0.8830000162124634, 0.20000000298023224, -0.4690000116825104), edge = Vector3.new(0.4690000116825104, 0, -0.8830000162124634)},
    {t = 0.09, pos = Vector3.new(-0.019999999552965164, -0.17000000178813934, -0.5), tip = Vector3.new(-0.5740000009536743, 0.14000000059604645, -0.8190000057220459), edge = Vector3.new(0.8190000057220459, 0, -0.5740000009536743)},
    {t = 0.14, pos = Vector3.new(0.6399999856948853, -0.07000000029802322, -0.5), tip = Vector3.new(0.13899999856948853, 0.10000000149011612, -0.9900000095367432), edge = Vector3.new(0.9900000095367432, 0, 0.13899999856948853)},
    {t = 0.24, pos = Vector3.new(0.8600000143051147, -0.30000001192092896, -0.46000000834465027), tip = Vector3.new(0.75, -0.44999998807907104, -0.47999998927116394), edge = Vector3.new(0.5, 0, 0.8659999966621399)},
    {t = 0.4, rest = Vector3.new(0, 0.02500000037252903, 0)},
    {t = 0.5, rest = Vector3.new(0, 0, 0)}
}
local tbl_3 = {contact = 0.09, release = 0.61}
tbl_3.smear = {0.04, 0.16}
tbl_3.keys = {
    {t = 0.03, pos = Vector3.new(0.4000000059604645, 0.03999999910593033, -0.5), tip = Vector3.new(0.7570000290870667, 0.6359999775886536, 0.1509999930858612), edge = Vector3.new(-0.22200000286102295, 0.46700000762939453, -0.8560000061988831)},
    {t = 0.055, pos = Vector3.new(0.4000000059604645, 0.18000000715255737, -0.5), tip = Vector3.new(0.18700000643730164, 0.722000002861023, -0.6660000085830688), edge = Vector3.new(-0.765999972820282, -0.31700000166893005, -0.5590000152587891)},
    {t = 0.09, pos = Vector3.new(0.10000000149011612, -0.14000000059604645, -0.5), tip = Vector3.new(-0.3499999940395355, 0.3499999940395355, -0.8690000176429749), edge = Vector3.new(-0.7070000171661377, -0.7070000171661377, 0)},
    {t = 0.145, pos = Vector3.new(-0.44999998807907104, -0.4399999976158142, -0.5), tip = Vector3.new(-0.765999972820282, -0.31700000166893005, -0.5590000152587891), edge = Vector3.new(-0.18700000643730164, -0.722000002861023, 0.6660000085830688)},
    {t = 0.26, pos = Vector3.new(-0.6600000262260437, -0.6600000262260437, -0.4399999976158142), tip = Vector3.new(-0.6359999775886536, -0.7570000290870667, 0.1509999930858612), edge = Vector3.new(0.46700000762939453, -0.22200000286102295, 0.8560000061988831)},
    {t = 0.4, pos = Vector3.new(0.2199999988079071, -0.8399999737739563, -0.47999998927116394), tip = Vector3.new(-0.20000000298023224, 0.8500000238418579, -0.5), edge = Vector3.new(-0.6000000238418579, 0, -0.800000011920929)},
    {t = 0.5, rest = Vector3.new(0, 0.02500000037252903, 0)},
    {t = 0.61, rest = Vector3.new(0, 0, 0)}
}
local tbl_4 = {contact = 0, release = 0.3}
tbl_4.keys = {{t = 0.12, pos = Vector3.new(0.4000000059604645, -0.36000001430511475, -0.5600000023841858), tip = Vector3.new(0.05000000074505806, 0.550000011920929, -0.8299999833106995), edge = Vector3.new(-0.699999988079071, 0.10000000149011612, -0.699999988079071)}, {t = 0.2, rest = Vector3.new(0, 0.029999999329447746, 0)}, {t = 0.3, rest = Vector3.new(0, 0, 0)}}
tbl_upv_1.SWORD = {
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
    slash_l = tbl_2,
    finisher = tbl_3,
    draw = tbl_4
}
local tbl_5 = {contact = 0.06, release = 0.34}
tbl_5.smear = {0.035, 0.12}
tbl_5.keys = {
    {t = 0.03, pos = Vector3.new(-0.20000000298023224, -0.41999998688697815, -0.4399999976158142), tip = Vector3.new(-0.5450000166893005, -0.7839999794960022, 0.296999990940094), edge = Vector3.new(-0.5699999928474426, 0.08699999749660492, -0.8169999718666077)},
    {t = 0.07, pos = Vector3.new(0.019999999552965164, -0.07999999821186066, -0.4399999976158142), tip = Vector3.new(-0.3499999940395355, 0.3499999940395355, -0.8690000176429749), edge = Vector3.new(0.7070000171661377, 0.7070000171661377, 0)},
    {t = 0.11, pos = Vector3.new(0.5, 0.3400000035762787, -0.4399999976158142), tip = Vector3.new(0.49300000071525574, 0.7889999747276306, -0.367000013589859), edge = Vector3.new(0.6159999966621399, -0.017999999225139618, 0.7879999876022339)},
    {t = 0.17, pos = Vector3.new(0.6200000047683716, 0.4399999976158142, -0.41999998688697815), tip = Vector3.new(0.7739999890327454, 0.5929999947547913, 0.22499999403953552), edge = Vector3.new(0.1550000011920929, -0.5210000276565552, 0.8399999737739563)},
    {t = 0.26, rest = Vector3.new(0, -0.019999999552965164, 0)},
    {t = 0.34, rest = Vector3.new(0, 0, 0)}
}
local tbl_6 = {contact = 0, release = 0.25}
tbl_6.keys = {
    {t = 0.07, pos = Vector3.new(0.3799999952316284, -0.41999998688697815, -0.5199999809265137), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(-0.9290000200271606, -0.2939999997615814, 0.22699999809265137)},
    {t = 0.12, pos = Vector3.new(0.3499999940395355, -0.3100000023841858, -0.5600000023841858), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(0.13199999928474426, 0.3089999854564667, 0.9419999718666077)},
    {t = 0.17, pos = Vector3.new(0.3400000035762787, -0.25, -0.5799999833106995), tip = Vector3.new(-0.34700000286102295, 0.9049999713897705, -0.24799999594688416), edge = Vector3.new(0.9290000200271606, 0.2939999997615814, -0.22699999809265137)},
    {t = 0.25, rest = Vector3.new(0, 0, 0)}
}
tbl_upv_1.DAGGER = {
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
    back = tbl_5,
    draw = tbl_6
}
tbl_upv_1.SETS = {Sword = tbl_upv_1.SWORD, Dagger = tbl_upv_1.DAGGER}
tbl_upv_1.DRAW = {Sword = tbl_upv_1.Frame(Vector3.new(0.46000000834465027, -0.7799999713897705, -0.46000000834465027), Vector3.new(-0.15000000596046448, -0.20000000298023224, -0.9700000286102295), Vector3.new(-0.699999988079071, 0.699999988079071, 0)), Dagger = tbl_upv_1.Frame(Vector3.new(0.41999998688697815, -0.6200000047683716, -0.4399999976158142), Vector3.new(-0.15000000596046448, -0.20000000298023224, -0.9700000286102295), Vector3.new(-0.699999988079071, 0.699999988079071, 0))}
function tbl_upv_1.Pick(a1, a2, a3)
    --[[
      name: Pick
      line: 213
    ]]
    local v4 = a2 % 2 == 0
    if a1 ~= "Dagger" then
        if a3 then
            return "finisher"
        elseif v4 then
            return "slash_l"
        else
            return "slash_r"
        end
    end
    if v4 then
        return "back"
    end
    return "cut"
end
function tbl_upv_1.Subdivide(a1, a2, a3)
    --[[
      name: Subdivide
      line: 224
    ]]
    local v5 = a2 or 60
    local tbl_7 = {}
    local v6
    if a3 then
        v6 = {t = 0}
        v6.rest = a3.rest or Vector3.new(0, 0, 0)
        v6.rot = a3.rot or Vector3.new(0, 0, 0)
    else
        v6 = nil
    end
    local v7, v8 = nil, nil
    for _, value_1 in a1.keys do
        if not (v6) or not (v6.rest) or not (value_1.rest) then
            table.insert(tbl_7, value_1)
            v6 = value_1
            continue
        end
        local v9 = v6.rot or Vector3.new(0, 0, 0)
        v8 = value_1.rot or Vector3.new(0, 0, 0)
        v7 = v8 - v9
        if not value_1.rot then
            local function wrap(a4)
                --[[
                  name: wrap
                  line: 237
                ]]
                return ((a4 + 180) % 360) - 180
            end
            v7 = -Vector3.new(((v9.X + 180) % 360) - 180, ((v9.Y + 180) % 360) - 180, ((v9.Z + 180) % 360) - 180)
            v8 = v9 + v7
        end
        local v10 = math.ceil(math.max(math.abs(v7.X), math.abs(v7.Y), math.abs(v7.Z)) / v5)
        for n_1 = 1, v10 - 1 do
            v7 = n_1 / v10
            table.insert(tbl_7, {t = v6.t + ((value_1.t - v6.t) * v7), rest = v6.rest:Lerp(value_1.rest, v7), rot = v9:Lerp(v8, v7)})
        end
        table.insert(tbl_7, value_1)
        v6 = value_1
    end
    a1.keys = tbl_7
    return a1
end
function tbl_upv_1.Turn(a1, a2)
    --[[
      name: Turn
      line: 264
    ]]
    local v11
    if (a2) and (a2.Magnitude > 0.001) then
        v11 = CFrame.fromAxisAngle(-a2.Unit, a1.Z * 0.017453292519943295)
    else
        v11 = CFrame.fromEulerAnglesYXZ(0, 0, a1.Z * 0.017453292519943295)
    end
    return v11 * CFrame.fromEulerAnglesYXZ(a1.X * 0.017453292519943295, a1.Y * 0.017453292519943295, 0)
end
function tbl_upv_1.StartFrame(a1, a2)
    --[[
      name: StartFrame
      line: 271
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if typeof(a1) ~= "CFrame" then
        return CFrame.new(a2.Position + (a1.rest or Vector3.new(0, 0, 0))) * tbl_upv_1.Turn(a1.rot or Vector3.new(0, 0, 0)) * a2.Rotation
    end
    return a1
end
function tbl_upv_1.Eval(a1, a2, a3, a4, a5, a6)
    --[[
      name: Eval
      line: 283
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local u1 = a4 or 1
    local u2 = a5 or (CFrame.identity)
    local keys_upv_1 = a1.keys
    local u3 = #keys_upv_1
    local function knotT(a7)
        --[[
          name: knotT
          line: 289
          upvalues:
            keys_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        if a7 ~= 0 then
            return keys_upv_1[a7].t * u1
        end
        return 0
    end
    local function knotV(a8, a9)
        --[[
          name: knotV
          line: 292
          upvalues:
            a2 (copy, index: 1)
            keys_upv_1 (copy, index: 2)
            u2 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
        ]]
        local v12 = nil
        if a8 ~= 0 then
            v12 = keys_upv_1[a8]
            local v13 = nil
            if v12.rest then
                v13 = v12.rot
                if v13 then
                    local _ = tbl_upv_1.Turn(v13, ((a1.eyeRoll) and (u2.Position + v12.rest)) or nil)
                end
                if a9 ~= 1 then
                    if a9 ~= 2 then
                        return u2.LookVector
                    end
                    return u2.UpVector
                else
                    local v14 = u2.Position + v12.rest
                    if a1.pivot then
                        v14 = (v13 and (v14 + (u2.UpVector - u2.UpVector) * a1.pivot)) or v14
                    end
                    return v14
                end
            else
                if a9 ~= 1 then
                    if a9 ~= 2 then
                        return v12.edge.Unit
                    end
                    return v12.tip.Unit
                end
                return v12.pos
            end
        else
            if a9 ~= 1 then
                if a9 ~= 2 then
                    return a2.LookVector
                end
                return a2.UpVector
            end
            return a2.Position
        end
    end
    if (((u3 ~= 0) and (keys_upv_1[u3].t * u1)) or 0) <= a3 then
        return tbl_upv_1.Frame(knotV(u3, 1), knotV(u3, 2), knotV(u3, 3))
    end
    local v15 = 0
    while true do
        local v16
        if not (v15 < u3 - 1) then
            break
        end
        v16 = v15 + 1
        if (((v16 ~= 0) and (keys_upv_1[v16].t * u1)) or 0) < a3 then
            v15 = v15 + 1
            continue
        else
            break
        end
    end
    local v17 = ((v15 ~= 0) and (keys_upv_1[v15].t * u1)) or 0
    local v18 = v15 + 1
    local v19 = math.max((((v18 ~= 0) and (keys_upv_1[v18].t * u1)) or 0) - v17, 1e-04)
    local v20 = math.clamp((a3 - v17) / v19, 0, 1)
    local v21 = v20 * v20
    local tangent = v20 * v20 * v20
    tangent = function(a10, a11)
        --[[
          name: tangent
          line: 326
          upvalues:
            a6 (copy, index: 1)
            u3 (copy, index: 2)
            knotV (copy, index: 3)
            keys_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
        ]]
        if a10 <= 0 then
            if a6 then
                if a11 ~= 1 then
                    if a11 ~= 2 then
                        return a6.edge
                    end
                    return a6.tip
                end
                return a6.pos
            end
            return Vector3.new(0, 0, 0)
        else
            if u3 <= a10 then
                return Vector3.new(0, 0, 0)
            end
            local v22 = knotV(a10 + 1, a11) - knotV(a10 - 1, a11)
            local v23 = a10 + 1
            local v24 = ((v23 ~= 0) and (keys_upv_1[v23].t * u1)) or 0
            local v25 = a10 - 1
            return v22 / math.max(v24 - (((v25 ~= 0) and (keys_upv_1[v25].t * u1)) or 0), 1e-04)
        end
    end
    local tbl_8 = {}
    for n_2 = 1, 3 do
        local v26 = knotV(v15, n_2)
        local v27 = knotV(v15 + 1, n_2)
        tbl_8[n_2] = ((v26 * (((tangent * 2) - (v21 * 3)) + 1)) + (tangent(v15, n_2) * (((tangent - (v21 * 2)) + v20) * v19))) + (v27 * ((tangent * -2) + (v21 * 3))) + (tangent(v15 + 1, n_2) * ((tangent - v21) * v19))
    end
    return tbl_upv_1.Frame(tbl_8[1], tbl_8[2], tbl_8[3])
end
return tbl_upv_1