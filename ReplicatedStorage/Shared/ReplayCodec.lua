local v1 = {
    VERSION = 3,
    MAGIC = 1196707664,
    REC_FRAME = 1,
    REC_EVENT = 2,
    RECORD_HEADER = 5,
    SAMPLE_BYTES = 27,
    POS_Q = 20,
    ROT_Q = 10430.060040584269,
    VEL_Q = 50,
    HP_Q = 2.5,
    F_ALIVE = 1,
    F_GROUNDED = 2,
    F_SLIDING = 4,
    F_BLOCKING = 8,
    F_AIMING = 16,
    F_VIEW = 32,
    F_FIRST = 64,
    F_AIMCAM = 128,
    V_LEFT = 1,
    VIEW_FORMAT_BYTES = 6,
    VIEW_HZ = 15,
    INV_FORMAT = "<BBBBBBHHH",
    INV_BYTES = 12,
    INTRO_TIME = 2,
    OUTRO_TIME = 0.6,
    MAX_FIGHTERS = 16,
    MAX_KEYS = 250,
    T_FALSE = 0,
    T_TRUE = 1,
    T_U8 = 2,
    T_I32 = 3,
    T_F32 = 4,
    T_F64 = 5,
    T_STR = 6,
    T_V3 = 7,
    T_CF = 8,
    T_FIGHTER = 9,
    T_PART = 10,
    Writer = (function(a2)
        --[[
          name: Writer
          line: 78
        ]]
        local cap = math.max(64, (a2 or 1024))
        return {pos = 0, buf = buffer.create(cap), cap = cap}
    end)
}

local function ensure(a5, a6)
    --[[
      name: ensure
      line: 83
    ]]
    local v7 = a5.pos + a6

    if v7 <= a5.cap then
        return
    end

    local cap = a5.cap * 2

    while cap < v7 do
        cap *= 2
    end

    local buf = buffer.create(cap)
    buffer.copy(buf, 0, a5.buf, 0, a5.pos)
    a5.buf = buf
    a5.cap = cap
end

v1.Ensure = ensure

function v1.U8(a10, a11: number)
    --[[
      name: U8
      line: 99
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a10, 1)
    buffer.writeu8(a10.buf, a10.pos, (math.clamp(a11, 0, 255)))
    a10.pos += 1
end

function v1.U16(a12, a13: number)
    --[[
      name: U16
      line: 105
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a12, 2)
    buffer.writeu16(a12.buf, a12.pos, (math.clamp(a13, 0, 65535)))
    a12.pos += 2
end

function v1.I16(a14, a15: number)
    --[[
      name: I16
      line: 111
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a14, 2)
    buffer.writei16(a14.buf, a14.pos, (math.clamp(a15, -32768, 32767)))
    a14.pos += 2
end

function v1.U32(a16, a17: number)
    --[[
      name: U32
      line: 117
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a16, 4)
    buffer.writeu32(a16.buf, a16.pos, a17)
    a16.pos += 4
end

function v1.I32(a18, a19: number)
    --[[
      name: I32
      line: 123
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a18, 4)
    buffer.writei32(a18.buf, a18.pos, a19)
    a18.pos += 4
end

function v1.F32(a20, a21: number)
    --[[
      name: F32
      line: 129
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a20, 4)
    buffer.writef32(a20.buf, a20.pos, a21)
    a20.pos += 4
end

function v1.F64(a22, a23: number)
    --[[
      name: F64
      line: 135
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a22, 8)
    buffer.writef64(a22.buf, a22.pos, a23)
    a22.pos += 8
end

function v1.Str(a24, a25: string)
    --[[
      name: Str
      line: 141
      upvalues:
        ensure (copy, index: 1)
    ]]
    local v26 = math.min(#a25, 255)
    ensure(a24, v26 + 1)
    buffer.writeu8(a24.buf, a24.pos, v26)
    buffer.writestring(a24.buf, a24.pos + 1, a25, v26)
    a24.pos += (v26 + 1)
end

function v1.V3(a27, a28)
    --[[
      name: V3
      line: 149
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a27, 12)
    buffer.writef32(a27.buf, a27.pos, a28.X)
    buffer.writef32(a27.buf, a27.pos + 4, a28.Y)
    buffer.writef32(a27.buf, a27.pos + 8, a28.Z)
    a27.pos += 12
end

function v1.Bytes(a29, a30: buffer, a31: number?, a32: number?)
    --[[
      name: Bytes
      line: 158
      upvalues:
        ensure (copy, index: 1)
    ]]
    ensure(a29, a32)
    buffer.copy(a29.buf, a29.pos, a30, a31, a32)
    a29.pos += a32
end

function v1.Finish(a33)
    --[[
      name: Finish
      line: 165
    ]]
    local v34 = buffer.create(a33.pos)
    buffer.copy(v34, 0, a33.buf, 0, a33.pos)

    return v34
end

v1.Q16 = function(a35, a36)
    --[[
      name: q16
      line: 172
    ]]
    local flooredValue = math.floor((a35 * a36) + 0.5)

    if flooredValue == flooredValue then
        return (math.clamp(flooredValue, -32767, 32767))
    end

    return 0
end

function v1.WriteSample(a38, a39, a40, a41, a42: number, a43, a44, a45: number, a46, a47, a48: number)
    --[[
      name: WriteSample
      line: 183
      upvalues:
        ensure (copy, index: 1)
        v1 (copy, index: 2)
    ]]
    local clampedValue
    local clampedValue2
    local clampedValue3
    local clampedValue4
    local clampedValue5
    local clampedValue6
    local clampedValue7
    local clampedValue8
    local clampedValue9
    local clampedValue10
    local clampedValue11
    ensure(a38, 27)
    local buf = a38.buf
    local pos = a38.pos
    local v62, v63, v64 = a40:ToEulerAnglesYXZ()
    local flooredValue = math.floor((a39.X * v1.POS_Q) + 0.5)

    if flooredValue == flooredValue then
        clampedValue = math.clamp(flooredValue, -32767, 32767)
    else
        clampedValue = 0
    end

    buffer.writei16(buf, pos, clampedValue)
    local v66 = pos + 2
    local flooredValue2 = math.floor((a39.Y * v1.POS_Q) + 0.5)

    if flooredValue2 == flooredValue2 then
        clampedValue2 = math.clamp(flooredValue2, -32767, 32767)
    else
        clampedValue2 = 0
    end

    buffer.writei16(buf, v66, clampedValue2)
    local v68 = pos + 4
    local flooredValue3 = math.floor((a39.Z * v1.POS_Q) + 0.5)

    if flooredValue3 == flooredValue3 then
        clampedValue3 = math.clamp(flooredValue3, -32767, 32767)
    else
        clampedValue3 = 0
    end

    buffer.writei16(buf, v68, clampedValue3)
    local v70 = pos + 6
    local flooredValue4 = math.floor((v62 * v1.ROT_Q) + 0.5)

    if flooredValue4 == flooredValue4 then
        clampedValue4 = math.clamp(flooredValue4, -32767, 32767)
    else
        clampedValue4 = 0
    end

    buffer.writei16(buf, v70, clampedValue4)
    local v72 = pos + 8
    local flooredValue5 = math.floor((v63 * v1.ROT_Q) + 0.5)

    if flooredValue5 == flooredValue5 then
        clampedValue5 = math.clamp(flooredValue5, -32767, 32767)
    else
        clampedValue5 = 0
    end

    buffer.writei16(buf, v72, clampedValue5)
    local v74 = pos + 10
    local flooredValue6 = math.floor((v64 * v1.ROT_Q) + 0.5)

    if flooredValue6 == flooredValue6 then
        clampedValue6 = math.clamp(flooredValue6, -32767, 32767)
    else
        clampedValue6 = 0
    end

    buffer.writei16(buf, v74, clampedValue6)
    local v76 = pos + 12
    local flooredValue7 = math.floor((a41.X * v1.VEL_Q) + 0.5)

    if flooredValue7 == flooredValue7 then
        clampedValue7 = math.clamp(flooredValue7, -32767, 32767)
    else
        clampedValue7 = 0
    end

    buffer.writei16(buf, v76, clampedValue7)
    local v78 = pos + 14
    local flooredValue8 = math.floor((a41.Y * v1.VEL_Q) + 0.5)

    if flooredValue8 == flooredValue8 then
        clampedValue8 = math.clamp(flooredValue8, -32767, 32767)
    else
        clampedValue8 = 0
    end

    buffer.writei16(buf, v78, clampedValue8)
    local v80 = pos + 16
    local flooredValue9 = math.floor((a41.Z * v1.VEL_Q) + 0.5)

    if flooredValue9 == flooredValue9 then
        clampedValue9 = math.clamp(flooredValue9, -32767, 32767)
    else
        clampedValue9 = 0
    end

    buffer.writei16(buf, v80, clampedValue9)
    buffer.writeu8(buf, pos + 18, (math.clamp(a42, 0, 255)))
    buffer.writeu8(buf, pos + 19, (math.clamp(math.floor((a43 * v1.HP_Q) + 0.5), 0, 255)))
    buffer.writeu8(buf, pos + 20, (math.clamp(math.floor(a44 + 0.5), 0, 255)))
    buffer.writeu8(buf, pos + 21, a45)
    local v82 = pos + 22
    local flooredValue10 = math.floor((a46 * v1.ROT_Q) + 0.5)

    if flooredValue10 == flooredValue10 then
        clampedValue10 = math.clamp(flooredValue10, -32767, 32767)
    else
        clampedValue10 = 0
    end

    buffer.writei16(buf, v82, clampedValue10)
    local v84 = pos + 24
    local flooredValue11 = math.floor((a47 * v1.ROT_Q) + 0.5)

    if flooredValue11 == flooredValue11 then
        clampedValue11 = math.clamp(flooredValue11, -32767, 32767)
    else
        clampedValue11 = 0
    end

    buffer.writei16(buf, v84, clampedValue11)
    buffer.writeu8(buf, pos + 26, (math.clamp(math.floor(a48), 0, 255)))
    a38.pos = pos + 27
end

function v1.WriteValue(a86, a87: number, callback)
    --[[
      name: WriteValue
      line: 208
      upvalues:
        v1 (copy, index: 1)
    ]]
    local valueType = typeof(a87)

    if valueType == "boolean" then
        local u8 = v1.U8
        local v91 = if a87 then v1.T_TRUE else v1.T_FALSE
        u8(a86, v91)
    elseif valueType == "number" then
        if a87 ~= a87 or a87 == math.huge or a87 == -math.huge then
            return false
        end

        if a87 ~= math.floor(a87) then
            v1.U8(a86, v1.T_F32)
            v1.F32(a86, a87)
        elseif 0 <= a87 and a87 <= 255 then
            v1.U8(a86, v1.T_U8)
            v1.U8(a86, a87)
        elseif not (-2147483648 <= a87) or not (a87 <= 2147483647) then
            v1.U8(a86, v1.T_F64)
            v1.F64(a86, a87)
        else
            v1.U8(a86, v1.T_I32)
            v1.I32(a86, a87)
        end
    elseif valueType == "string" then
        v1.U8(a86, v1.T_STR)
        v1.Str(a86, a87)
    elseif valueType == "Vector3" then
        v1.U8(a86, v1.T_V3)
        v1.V3(a86, a87)
    elseif valueType == "CFrame" then
        local v92, v93, v94 = a87:ToEulerAnglesXYZ()
        v1.U8(a86, v1.T_CF)
        v1.V3(a86, a87.Position)
        v1.F32(a86, v92)
        v1.F32(a86, v93)
        v1.F32(a86, v94)
    else
        if valueType ~= "Instance" then
            return false
        end

        local v95, v96 = callback(a87)
        if not v95 then
            return false
        end

        if v96 then
            v1.U8(a86, v1.T_PART)
            v1.U8(a86, v95)
            v1.Str(a86, v96)
        else
            v1.U8(a86, v1.T_FIGHTER)
            v1.U8(a86, v95)
        end
    end

    return true
end

function v1.Reader(buf: buffer, a98)
    --[[
      name: Reader
      line: 268
    ]]
    return {buf = buf, pos = a98 or 0, len = buffer.len(buf)}
end

function v1.Left(a99)
    --[[
      name: Left
      line: 272
    ]]
    return a99.len - a99.pos
end

function v1.RU8(a100)
    --[[
      name: RU8
      line: 276
    ]]
    local v101 = buffer.readu8(a100.buf, a100.pos)
    a100.pos += 1

    return v101
end

function v1.RU16(a102)
    --[[
      name: RU16
      line: 282
    ]]
    local v103 = buffer.readu16(a102.buf, a102.pos)
    a102.pos += 2

    return v103
end

function v1.RI16(a104)
    --[[
      name: RI16
      line: 288
    ]]
    local v105 = buffer.readi16(a104.buf, a104.pos)
    a104.pos += 2

    return v105
end

function v1.RU32(a106)
    --[[
      name: RU32
      line: 294
    ]]
    local v107 = buffer.readu32(a106.buf, a106.pos)
    a106.pos += 4

    return v107
end

function v1.RI32(a108)
    --[[
      name: RI32
      line: 300
    ]]
    local v109 = buffer.readi32(a108.buf, a108.pos)
    a108.pos += 4

    return v109
end

function v1.RF32(a110)
    --[[
      name: RF32
      line: 306
    ]]
    local v111 = buffer.readf32(a110.buf, a110.pos)
    a110.pos += 4

    return v111
end

function v1.RF64(a112)
    --[[
      name: RF64
      line: 312
    ]]
    local v113 = buffer.readf64(a112.buf, a112.pos)
    a112.pos += 8

    return v113
end

function v1.RStr(a114)
    --[[
      name: RStr
      line: 318
    ]]
    local count = buffer.readu8(a114.buf, a114.pos)
    local text = buffer.readstring(a114.buf, a114.pos + 1, count)
    a114.pos += (count + 1)

    return text
end

function v1.RV3(a117)
    --[[
      name: RV3
      line: 325
    ]]
    local x = buffer.readf32(a117.buf, a117.pos)
    local y = buffer.readf32(a117.buf, a117.pos + 4)
    local z = buffer.readf32(a117.buf, a117.pos + 8)
    a117.pos += 12

    return (Vector3.new(x, y, z))
end

function v1.ReadValue(a121)
    --[[
      name: ReadValue
      line: 337
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v122 = v1.RU8(a121)

    if v122 == v1.T_FALSE then
        return false
    end
    if v122 == v1.T_TRUE then
        return true
    end
    if v122 == v1.T_U8 then
        return v1.RU8(a121)
    end
    if v122 == v1.T_I32 then
        return v1.RI32(a121)
    end
    if v122 == v1.T_F32 then
        return v1.RF32(a121)
    end
    if v122 == v1.T_F64 then
        return v1.RF64(a121)
    end
    if v122 == v1.T_STR then
        return v1.RStr(a121)
    end
    if v122 == v1.T_V3 then
        return v1.RV3(a121)
    end

    if v122 == v1.T_CF then
        local v123 = v1.RV3(a121)
        local v124 = v1.RF32(a121)
        local v125 = v1.RF32(a121)
        local v126 = v1.RF32(a121)

        return CFrame.new(v123) * CFrame.fromEulerAnglesXYZ(v124, v125, v126)
    end

    if v122 == v1.T_FIGHTER then
        return {fighter = v1.RU8(a121)}
    end

    if v122 == v1.T_PART then
        local fighter = v1.RU8(a121)
        return {fighter = fighter, part = v1.RStr(a121)}
    end

    error("ReplayCodec: bad value tag " .. tostring(v122))
end

return v1