local tbl_upv_1 = {}
tbl_upv_1.VERSION = 3
tbl_upv_1.MAGIC = 1196707664
tbl_upv_1.REC_FRAME = 1
tbl_upv_1.REC_EVENT = 2
tbl_upv_1.RECORD_HEADER = 5
tbl_upv_1.SAMPLE_BYTES = 27
tbl_upv_1.POS_Q = 20
tbl_upv_1.ROT_Q = 10430.060040584269
tbl_upv_1.VEL_Q = 50
tbl_upv_1.HP_Q = 2.5
tbl_upv_1.F_ALIVE = 1
tbl_upv_1.F_GROUNDED = 2
tbl_upv_1.F_SLIDING = 4
tbl_upv_1.F_BLOCKING = 8
tbl_upv_1.F_AIMING = 16
tbl_upv_1.F_VIEW = 32
tbl_upv_1.F_FIRST = 64
tbl_upv_1.F_AIMCAM = 128
tbl_upv_1.V_LEFT = 1
tbl_upv_1.VIEW_FORMAT_BYTES = 6
tbl_upv_1.VIEW_HZ = 15
tbl_upv_1.INV_FORMAT = "<BBBBBBHHH"
tbl_upv_1.INV_BYTES = 12
tbl_upv_1.INTRO_TIME = 2
tbl_upv_1.OUTRO_TIME = 0.6
tbl_upv_1.MAX_FIGHTERS = 16
tbl_upv_1.MAX_KEYS = 250
tbl_upv_1.T_FALSE = 0
tbl_upv_1.T_TRUE = 1
tbl_upv_1.T_U8 = 2
tbl_upv_1.T_I32 = 3
tbl_upv_1.T_F32 = 4
tbl_upv_1.T_F64 = 5
tbl_upv_1.T_STR = 6
tbl_upv_1.T_V3 = 7
tbl_upv_1.T_CF = 8
tbl_upv_1.T_FIGHTER = 9
tbl_upv_1.T_PART = 10
function tbl_upv_1.Writer(a1)
    --[[
      name: Writer
      line: 78
    ]]
    local v1 = math.max(64, a1 or 1024)
    local tbl_2 = {pos = 0}
    tbl_2.buf = buffer.create(v1)
    tbl_2.cap = v1
    return tbl_2
end
local function ensure(a1, a2)
    --[[
      name: ensure
      line: 83
    ]]
    local v2 = a1.pos + a2
    if v2 <= a1.cap then
        return
    end
    local v3 = a1.cap * 2
    while v3 < v2 do
        v3 = v3 * 2
    end
    local v4 = buffer.create(v3)
    buffer.copy(v4, 0, a1.buf, 0, a1.pos)
    a1.buf = v4
    a1.cap = v3
end
tbl_upv_1.Ensure = ensure
function tbl_upv_1.U8(a1, a2)
    --[[
      name: U8
      line: 99
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 1)
    buffer.writeu8(a1.buf, a1.pos, (math.clamp(a2, 0, 255)))
    a1.pos = a1.pos + 1
end
function tbl_upv_1.U16(a1, a2)
    --[[
      name: U16
      line: 105
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 2)
    buffer.writeu16(a1.buf, a1.pos, (math.clamp(a2, 0, 65535)))
    a1.pos = a1.pos + 2
end
function tbl_upv_1.I16(a1, a2)
    --[[
      name: I16
      line: 111
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 2)
    buffer.writei16(a1.buf, a1.pos, (math.clamp(a2, -32768, 32767)))
    a1.pos = a1.pos + 2
end
function tbl_upv_1.U32(a1, a2)
    --[[
      name: U32
      line: 117
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 4)
    buffer.writeu32(a1.buf, a1.pos, a2)
    a1.pos = a1.pos + 4
end
function tbl_upv_1.I32(a1, a2)
    --[[
      name: I32
      line: 123
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 4)
    buffer.writei32(a1.buf, a1.pos, a2)
    a1.pos = a1.pos + 4
end
function tbl_upv_1.F32(a1, a2)
    --[[
      name: F32
      line: 129
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 4)
    buffer.writef32(a1.buf, a1.pos, a2)
    a1.pos = a1.pos + 4
end
function tbl_upv_1.F64(a1, a2)
    --[[
      name: F64
      line: 135
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 8)
    buffer.writef64(a1.buf, a1.pos, a2)
    a1.pos = a1.pos + 8
end
function tbl_upv_1.Str(a1, a2)
    --[[
      name: Str
      line: 141
      upvalues:
        ensure (copy, index: 1)
    ]]
    local v5 = math.min(#a2, 255)
    ensure(a1, v5 + 1)
    buffer.writeu8(a1.buf, a1.pos, v5)
    buffer.writestring(a1.buf, a1.pos + 1, a2, v5)
    a1.pos = a1.pos + (v5 + 1)
end
function tbl_upv_1.V3(a1, a2)
    --[[
      name: V3
      line: 149
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, 12)
    buffer.writef32(a1.buf, a1.pos, a2.X)
    buffer.writef32(a1.buf, a1.pos + 4, a2.Y)
    buffer.writef32(a1.buf, a1.pos + 8, a2.Z)
    a1.pos = a1.pos + 12
end
function tbl_upv_1.Bytes(a1, a2, a3, a4)
    --[[
      name: Bytes
      line: 158
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a1, a4)
    buffer.copy(a1.buf, a1.pos, a2, a3, a4)
    a1.pos = a1.pos + a4
end
function tbl_upv_1.Finish(a1)
    --[[
      name: Finish
      line: 165
    ]]
    local v6 = buffer.create(a1.pos)
    buffer.copy(v6, 0, a1.buf, 0, a1.pos)
    return v6
end
tbl_upv_1.Q16 = function(a1, a2)
    --[[
      name: q16
      line: 172
    ]]
    local v7 = math.floor((a1 * a2) + 0.5)
    if v7 == v7 then
        return (math.clamp(v7, -32767, 32767))
    end
    return 0
end
function tbl_upv_1.WriteSample(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11)
    --[[
      name: WriteSample
      line: 183
      upvalues:
        ensure (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    ensure(a1, 27)
    local buf_1 = a1.buf
    local pos_1 = a1.pos
    local v8, v9, v10 = a3:ToEulerAnglesYXZ()
    local v11 = math.floor((a2.X * tbl_upv_1.POS_Q) + 0.5)
    local v12 = ((v11 ~= v11) and 0) or (math.clamp(v11, -32767, 32767))
    buffer.writei16(buf_1, pos_1, v12)
    local v13 = math.floor((a2.Y * tbl_upv_1.POS_Q) + 0.5)
    local v14 = ((v13 ~= v13) and 0) or (math.clamp(v13, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 2, v14)
    local v15 = math.floor((a2.Z * tbl_upv_1.POS_Q) + 0.5)
    local v16 = ((v15 ~= v15) and 0) or (math.clamp(v15, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 4, v16)
    local v17 = math.floor((v8 * tbl_upv_1.ROT_Q) + 0.5)
    local v18 = ((v17 ~= v17) and 0) or (math.clamp(v17, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 6, v18)
    local v19 = math.floor((v9 * tbl_upv_1.ROT_Q) + 0.5)
    local v20 = ((v19 ~= v19) and 0) or (math.clamp(v19, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 8, v20)
    local v21 = math.floor((v10 * tbl_upv_1.ROT_Q) + 0.5)
    local v22 = ((v21 ~= v21) and 0) or (math.clamp(v21, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 10, v22)
    local v23 = math.floor((a4.X * tbl_upv_1.VEL_Q) + 0.5)
    local v24 = ((v23 ~= v23) and 0) or (math.clamp(v23, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 12, v24)
    local v25 = math.floor((a4.Y * tbl_upv_1.VEL_Q) + 0.5)
    local v26 = ((v25 ~= v25) and 0) or (math.clamp(v25, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 14, v26)
    local v27 = math.floor((a4.Z * tbl_upv_1.VEL_Q) + 0.5)
    local v28 = ((v27 ~= v27) and 0) or (math.clamp(v27, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 16, v28)
    buffer.writeu8(buf_1, pos_1 + 18, (math.clamp(a5, 0, 255)))
    buffer.writeu8(buf_1, pos_1 + 19, (math.clamp(math.floor((a6 * tbl_upv_1.HP_Q) + 0.5), 0, 255)))
    buffer.writeu8(buf_1, pos_1 + 20, (math.clamp(math.floor(a7 + 0.5), 0, 255)))
    buffer.writeu8(buf_1, pos_1 + 21, a8)
    local v29 = math.floor((a9 * tbl_upv_1.ROT_Q) + 0.5)
    local v30 = ((v29 ~= v29) and 0) or (math.clamp(v29, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 22, v30)
    local v31 = math.floor((a10 * tbl_upv_1.ROT_Q) + 0.5)
    local v32 = ((v31 ~= v31) and 0) or (math.clamp(v31, -32767, 32767))
    buffer.writei16(buf_1, pos_1 + 24, v32)
    buffer.writeu8(buf_1, pos_1 + 26, (math.clamp(math.floor(a11), 0, 255)))
    a1.pos = pos_1 + 27
end
function tbl_upv_1.WriteValue(a1, a2, a3)
    --[[
      name: WriteValue
      line: 208
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local ty_1 = typeof(a2)
    if ty_1 == "boolean" then
        local U8_1 = tbl_upv_1.U8
        local v33
        if a2 then
            v33 = tbl_upv_1.T_TRUE
        else
            v33 = tbl_upv_1.T_FALSE
        end
        U8_1(a1, v33)
    elseif ty_1 == "number" then
        if a2 == a2 and a2 ~= math.huge and a2 ~= -math.huge then
            if a2 ~= math.floor(a2) then
                tbl_upv_1.U8(a1, tbl_upv_1.T_F32)
                tbl_upv_1.F32(a1, a2)
            elseif (a2 >= 0) and (a2 <= 255) then
                tbl_upv_1.U8(a1, tbl_upv_1.T_U8)
                tbl_upv_1.U8(a1, a2)
            elseif (a2 >= -2147483648) and (a2 <= 2147483647) then
                tbl_upv_1.U8(a1, tbl_upv_1.T_I32)
                tbl_upv_1.I32(a1, a2)
            else
                tbl_upv_1.U8(a1, tbl_upv_1.T_F64)
                tbl_upv_1.F64(a1, a2)
            end
            return true
        end
        return false
    elseif ty_1 == "string" then
        tbl_upv_1.U8(a1, tbl_upv_1.T_STR)
        tbl_upv_1.Str(a1, a2)
    elseif ty_1 == "Vector3" then
        tbl_upv_1.U8(a1, tbl_upv_1.T_V3)
        tbl_upv_1.V3(a1, a2)
    elseif ty_1 ~= "CFrame" then
        if ty_1 ~= "Instance" then
            return false
        end
        local v34, v35 = a3(a2)
        if v34 then
            if v35 then
                tbl_upv_1.U8(a1, tbl_upv_1.T_PART)
                tbl_upv_1.U8(a1, v34)
                tbl_upv_1.Str(a1, v35)
            else
                tbl_upv_1.U8(a1, tbl_upv_1.T_FIGHTER)
                tbl_upv_1.U8(a1, v34)
            end
        else
            return false
        end
    else
        local v36, v37, v38 = a2:ToEulerAnglesXYZ()
        tbl_upv_1.U8(a1, tbl_upv_1.T_CF)
        tbl_upv_1.V3(a1, a2.Position)
        tbl_upv_1.F32(a1, v36)
        tbl_upv_1.F32(a1, v37)
        tbl_upv_1.F32(a1, v38)
    end
    return true
end
function tbl_upv_1.Reader(a1, a2)
    --[[
      name: Reader
      line: 268
    ]]
    local tbl_3 = {}
    tbl_3.buf = a1
    tbl_3.pos = a2 or 0
    tbl_3.len = buffer.len(a1)
    return tbl_3
end
function tbl_upv_1.Left(a1)
    --[[
      name: Left
      line: 272
    ]]
    return a1.len - a1.pos
end
function tbl_upv_1.RU8(a1)
    --[[
      name: RU8
      line: 276
    ]]
    local v39 = buffer.readu8(a1.buf, a1.pos)
    a1.pos = a1.pos + 1
    return v39
end
function tbl_upv_1.RU16(a1)
    --[[
      name: RU16
      line: 282
    ]]
    local v40 = buffer.readu16(a1.buf, a1.pos)
    a1.pos = a1.pos + 2
    return v40
end
function tbl_upv_1.RI16(a1)
    --[[
      name: RI16
      line: 288
    ]]
    local v41 = buffer.readi16(a1.buf, a1.pos)
    a1.pos = a1.pos + 2
    return v41
end
function tbl_upv_1.RU32(a1)
    --[[
      name: RU32
      line: 294
    ]]
    local v42 = buffer.readu32(a1.buf, a1.pos)
    a1.pos = a1.pos + 4
    return v42
end
function tbl_upv_1.RI32(a1)
    --[[
      name: RI32
      line: 300
    ]]
    local v43 = buffer.readi32(a1.buf, a1.pos)
    a1.pos = a1.pos + 4
    return v43
end
function tbl_upv_1.RF32(a1)
    --[[
      name: RF32
      line: 306
    ]]
    local v44 = buffer.readf32(a1.buf, a1.pos)
    a1.pos = a1.pos + 4
    return v44
end
function tbl_upv_1.RF64(a1)
    --[[
      name: RF64
      line: 312
    ]]
    local v45 = buffer.readf64(a1.buf, a1.pos)
    a1.pos = a1.pos + 8
    return v45
end
function tbl_upv_1.RStr(a1)
    --[[
      name: RStr
      line: 318
    ]]
    local v46 = buffer.readu8(a1.buf, a1.pos)
    local v47 = buffer.readstring(a1.buf, a1.pos + 1, v46)
    a1.pos = a1.pos + (v46 + 1)
    return v47
end
function tbl_upv_1.RV3(a1)
    --[[
      name: RV3
      line: 325
    ]]
    local v48 = buffer.readf32(a1.buf, a1.pos)
    local v49 = buffer.readf32(a1.buf, a1.pos + 4)
    local v50 = buffer.readf32(a1.buf, a1.pos + 8)
    a1.pos = a1.pos + 12
    return (Vector3.new(v48, v49, v50))
end
function tbl_upv_1.ReadValue(a1)
    --[[
      name: ReadValue
      line: 337
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v51 = tbl_upv_1.RU8(a1)
    if v51 == tbl_upv_1.T_FALSE then
        return false
    elseif v51 == tbl_upv_1.T_TRUE then
        return true
    elseif v51 == tbl_upv_1.T_U8 then
        return tbl_upv_1.RU8(a1)
    elseif v51 == tbl_upv_1.T_I32 then
        return tbl_upv_1.RI32(a1)
    elseif v51 == tbl_upv_1.T_F32 then
        return tbl_upv_1.RF32(a1)
    elseif v51 == tbl_upv_1.T_F64 then
        return tbl_upv_1.RF64(a1)
    elseif v51 == tbl_upv_1.T_STR then
        return tbl_upv_1.RStr(a1)
    elseif v51 == tbl_upv_1.T_V3 then
        return tbl_upv_1.RV3(a1)
    elseif v51 == tbl_upv_1.T_CF then
        local v52 = tbl_upv_1.RV3(a1)
        local v53 = tbl_upv_1.RF32(a1)
        local v54 = tbl_upv_1.RF32(a1)
        local v55 = tbl_upv_1.RF32(a1)
        return CFrame.new(v52) * CFrame.fromEulerAnglesXYZ(v53, v54, v55)
    elseif v51 == tbl_upv_1.T_FIGHTER then
        local tbl_4 = {}
        tbl_4.fighter = tbl_upv_1.RU8(a1)
        return tbl_4
    elseif v51 ~= tbl_upv_1.T_PART then
        error("ReplayCodec: bad value tag " .. tostring(v51))
    else
        local tbl_5 = {}
        tbl_5.fighter = tbl_upv_1.RU8(a1)
        tbl_5.part = tbl_upv_1.RStr(a1)
        return tbl_5
    end
end
return tbl_upv_1