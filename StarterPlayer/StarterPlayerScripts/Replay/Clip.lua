local replicatedStorage = game:GetService("ReplicatedStorage")
local ReplayCodec = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("ReplayCodec"))
local v3 = {}

function v3.Decode(buffer2: buffer)
    --[[
      name: Decode
      line: 91
      upvalues:
        ReplayCodec (copy, index: 1)
        v3 (copy, index: 2)
    ]]
    if typeof(buffer2) ~= "buffer" or buffer.len(buffer2) < 32 then
        return nil, "empty clip"
    end

    local v5 = ReplayCodec.Reader(buffer2)

    if ReplayCodec.RU32(v5) ~= ReplayCodec.MAGIC then
        return nil, "not a clip"
    end

    local v6 = ReplayCodec.RU8(v5)

    if v6 ~= ReplayCodec.VERSION or ReplayCodec.SAMPLE_BYTES ~= 27 then
        return nil, (`clip version {v6} (expected {ReplayCodec.VERSION})`)
    end

    local duration = ReplayCodec.RF32(v5)
    local preroll = ReplayCodec.RF32(v5)
    local origin = ReplayCodec.RV3(v5)
    local focus = ReplayCodec.RU8(v5)
    local endIndex = ReplayCodec.RU8(v5)
    local fighters = {}

    for index = 1, endIndex do
        local id = ReplayCodec.RStr(v5)
        local name = ReplayCodec.RStr(v5)
        local team = ReplayCodec.RU8(v5)
        local left = ReplayCodec.RU8(v5) == 1
        fighters[index] = {n = 0, cursor = 1, kn = 0, kcursor = 1, grid = nil, gcursor = 1, index = index, id = id, name = name, team = team, left = left, t = {}, px = {}, py = {}, pz = {}, rx = {}, ry = {}, rz = {}, vx = {}, vy = {}, vz = {}, item = {}, hp = {}, armor = {}, flags = {}, kt = {}, kyaw = {}, kpitch = {}, kfov = {}, kflags = {}}
    end

    local v18 = {}
    local v19 = {}

    for index = 1, ReplayCodec.RU8(v5) do
        v19[index] = ReplayCodec.RStr(v5)
    end

    local items = {}

    for index = 1, ReplayCodec.RU8(v5) do
        items[index] = ReplayCodec.RStr(v5)
    end

    local title = ReplayCodec.RStr(v5)
    local kills = ReplayCodec.RU8(v5)
    local headshots = ReplayCodec.RU8(v5)
    local v26 = ReplayCodec.RU32(v5)
    local v27 = math.min(v5.pos + v26, v5.len)
    local events = {}
    local buf = v5.buf
    local v30 = 1 / ReplayCodec.POS_Q
    local v31 = 1 / ReplayCodec.ROT_Q
    local v32 = 1 / ReplayCodec.VEL_Q
    local v33 = 1 / ReplayCodec.HP_Q

    while v5.pos + ReplayCodec.RECORD_HEADER <= v27 do
        local _ = v5.pos
        local v35 = ReplayCodec.RU8(v5)
        local t = ReplayCodec.RU16(v5) / 1000 - preroll
        local v37 = ReplayCodec.RU16(v5)
        local pos2 = v5.pos + v37

        if v27 < pos2 then
            break
        end

        if v35 == ReplayCodec.REC_FRAME then
            local v39 = ReplayCodec.RU16(v5)

            for index = 1, endIndex do
                if bit32.btest(v39, (bit32.lshift(1, index - 1))) then
                    if pos2 < v5.pos + ReplayCodec.SAMPLE_BYTES then
                        break
                    end

                    local v41 = fighters[index]
                    local v42 = v41.n + 1
                    v41.n = v42
                    local pos = v5.pos
                    v41.t[v42] = t
                    v41.px[v42] = buffer.readi16(buf, pos) * v30
                    v41.py[v42] = buffer.readi16(buf, pos + 2) * v30
                    v41.pz[v42] = buffer.readi16(buf, pos + 4) * v30
                    v41.rx[v42] = buffer.readi16(buf, pos + 6) * v31
                    v41.ry[v42] = buffer.readi16(buf, pos + 8) * v31
                    v41.rz[v42] = buffer.readi16(buf, pos + 10) * v31
                    v41.vx[v42] = buffer.readi16(buf, pos + 12) * v32
                    v41.vy[v42] = buffer.readi16(buf, pos + 14) * v32
                    v41.vz[v42] = buffer.readi16(buf, pos + 16) * v32
                    v41.item[v42] = buffer.readu8(buf, pos + 18)
                    v41.hp[v42] = buffer.readu8(buf, pos + 19) * v33
                    v41.armor[v42] = buffer.readu8(buf, pos + 20)
                    local v44 = buffer.readu8(buf, pos + 21)
                    v41.flags[v42] = v44
                    local v45 = buffer.readi16(buf, pos + 22)
                    local v46 = buffer.readi16(buf, pos + 24)
                    local v47 = buffer.readu8(buf, pos + 26)
                    local v48 = bit32.band(v44, (ReplayCodec.F_VIEW + ReplayCodec.F_FIRST) + ReplayCodec.F_AIMCAM)
                    local v49 = v18[index]

                    if not v49 or v49[1] ~= v45 or v49[2] ~= v46 or v49[3] ~= v47 or v49[4] ~= v48 then
                        local v50
                        v18[index] = {v45, v46, v47, v48}
                        local v51 = v41.kn + 1
                        v41.kn = v51
                        v41.kt[v51] = t
                        v41.kyaw[v51] = v45 * v31
                        v41.kpitch[v51] = v46 * v31
                        v41.kfov[v51] = bit32.band(v47, 127)
                        local kflags = v41.kflags

                        if not (128 <= v47) then
                            v50 = 0
                        else
                            v50 = 256
                        end

                        kflags[v51] = v48 + v50
                    end

                    v5.pos = pos + ReplayCodec.SAMPLE_BYTES
                    continue
                end
            end
        elseif v35 == ReplayCodec.REC_EVENT then
            local kind = v19[ReplayCodec.RU8(v5)]
            local data = {}

            for _ = 1, ReplayCodec.RU8(v5) do
                if pos2 <= v5.pos then
                    break
                end

                local v56 = v19[ReplayCodec.RU8(v5)]
                local v57 = ReplayCodec.ReadValue(v5)

                if v56 then
                    data[v56] = v57
                end
            end

            if kind then
                table.insert(events, {t = t, kind = kind, data = data})
            end
        end

        v5.pos = pos2
    end

    table.sort(
        events,
        function(left, right)
            --[[
              line: 237
            ]]
            return left.t < right.t
        end
    )

    if const v60 = fighters[focus] then
        v3.BuildViewGrid(v60)
    end

    return {duration = duration, preroll = preroll, origin = origin, focus = focus, fighters = fighters, events = events, items = items, title = title, kills = kills, headshots = headshots, bytes = buffer.len(buffer2)}, nil
end

function v3.NewState()
    --[[
      name: NewState
      line: 259
    ]]
    return {present = false, vel = Vector3.new(0, 0, 0), item = 0, hp = 0, armor = 0, flags = 0, view = false, viewYaw = 0, viewPitch = 0, fov = 70, first = false, aimCam = false, bobbing = false, cf = CFrame.identity}
end

v3.LinearView = false

local function wrapPi(a62)
    --[[
      name: wrapPi
      line: 275
    ]]
    return ((a62 + math.pi) % math.tau) - math.pi
end

local function viewFlags(a64: number, a65)
    --[[
      name: viewFlags
      line: 279
      upvalues:
        ReplayCodec (copy, index: 1)
    ]]
    a65.view = bit32.btest(a64, ReplayCodec.F_VIEW)
    a65.first = bit32.btest(a64, ReplayCodec.F_FIRST)
    a65.aimCam = bit32.btest(a64, ReplayCodec.F_AIMCAM)
    a65.bobbing = bit32.btest(a64, 256)
end

local function keyAt(a67, a68)
    --[[
      name: keyAt
      line: 287
    ]]
    local kn = a67.kn

    if kn == 0 or a68 < a67.kt[1] then
        return 0
    end

    local v70
    local kt = a67.kt
    local kcursor = a67.kcursor

    if kn < kcursor or a68 < kt[kcursor] then
        v70 = 1
    else
        v70 = kcursor
    end

    while v70 < kn and kt[v70 + 1] <= a68 do
        v70 += 1
    end

    a67.kcursor = v70

    return v70
end

local function rampAt(a74, kflagKey, a76)
    --[[
      name: rampAt
      line: 306
      upvalues:
        ReplayCodec (copy, index: 1)
    ]]
    local v77 = a74.kyaw[kflagKey]
    local v78 = a74.kpitch[kflagKey]
    local v79 = a74.kfov[kflagKey]
    local kflagKey2 = kflagKey + 1

    if kflagKey2 <= a74.kn
        and bit32.btest(a74.kflags[kflagKey2], ReplayCodec.F_VIEW)
        and bit32.btest(a74.kflags[kflagKey], ReplayCodec.F_VIEW)
    then
        local v81 = a74.kt[kflagKey2]
        local v82 = math.max(a74.kt[kflagKey], v81 - 0.1)

        if v82 < a76 then
            local clampedValue = math.clamp((a76 - v82) / math.max(v81 - v82, 0.001), 0, 1)
            v77 += ((((a74.kyaw[kflagKey2] - v77) + math.pi) % math.tau) - math.pi) * clampedValue
            v78 += (a74.kpitch[kflagKey2] - v78) * clampedValue
            v79 += (a74.kfov[kflagKey2] - v79) * clampedValue
        end
    end

    return v77, v78, v79
end

local v84 = {[1] = 0.0038659201394728076, [2] = 0.014214791206736984, [3] = 0.0439369336234074, [4] = 0.11416176000968695, [5] = 0.24935220877729622, [6] = 0.4578333617716142, [7] = 0.7066482778577162, [8] = 0.9168553557320289, [9] = 1, [10] = 0.9168553557320289, [11] = 0.7066482778577162, [12] = 0.4578333617716142, [13] = 0.24935220877729622, [14] = 0.11416176000968695, [15] = 0.0439369336234074, [16] = 0.014214791206736984, [17] = 0.0038659201394728076}

local function smoothInto(values, endIndex: number, a88)
    --[[
      name: smoothInto
      line: 329
      upvalues:
        v84 (copy, index: 1)
    ]]
    for index = 1, endIndex do
        local total = 0
        local total2 = 0

        for valueKey = math.max(1, index - 8), math.min(endIndex, index + 8) do
            local v93 = v84[((valueKey - index) + 8) + 1]
            total += v93
            total2 += v93 * values[valueKey]
        end

        a88[index] = total2 / total
    end
end

function v3.BuildViewGrid(a94)
    --[[
      name: BuildViewGrid
      line: 343
      upvalues:
        ReplayCodec (copy, index: 1)
        rampAt (copy, index: 2)
        smoothInto (copy, index: 3)
    ]]
    local grid = {}
    local kn = a94.kn
    local kflagKey = 1

    while kflagKey <= kn do
        if bit32.btest(a94.kflags[kflagKey], ReplayCodec.F_VIEW) then
            local v98
            v98 = kflagKey

            while v98 + 1 <= kn and bit32.btest(a94.kflags[v98 + 1], ReplayCodec.F_VIEW) do
                v98 += 1
            end

            local v99 = v98
            local t0 = a94.kt[kflagKey]
            local t1 = if v99 < kn then a94.kt[v99 + 1] else math.max(t0, (a94.t[a94.n] or t0) + 0.05)
            local n = math.max(1, math.floor((t1 - t0) / 0.016666666666666666) + 2)
            local values = table.create(n, 0)
            local values2 = table.create(n, 0)
            local values3 = table.create(n, 0)
            local v106 = 0
            local v107 = kflagKey

            for valueKey = 1, n do
                local v109, v110
                local v111 = t0 + (valueKey - 1) * 0.016666666666666666

                while v107 < v98 and a94.kt[v107 + 1] <= v111 do
                    v107 += 1
                end

                v106, v109, v110 = rampAt(a94, v107, v111)

                if 1 < valueKey then
                    v106 += (((v106 - v106) + math.pi) % math.tau) - math.pi
                end

                values[valueKey] = v106
                values2[valueKey] = v109
                values3[valueKey] = v110
            end

            local v112 = {dt = 0.016666666666666666, t0 = t0, t1 = t1, n = n, yaw = table.create(n, 0), pitch = table.create(n, 0), fov = table.create(n, 0)}
            smoothInto(values, n, v112.yaw)
            smoothInto(values2, n, v112.pitch)
            smoothInto(values3, n, v112.fov)
            table.insert(grid, v112)
            kflagKey = v98 + 1
        else
            kflagKey += 1
        end
    end

    a94.grid = grid
    a94.gcursor = 1
end

local function catmull(a114, n, clampedValue: number, clampedValue2: number)
    --[[
      name: catmull
      line: 386
    ]]
    local v118 = a114[math.max(1, clampedValue - 1)]
    local v119 = a114[clampedValue]
    local v120 = a114[math.min(n, clampedValue + 1)]
    local v121 = a114[math.min(n, clampedValue + 2)]

    return (((v119 * 2) + ((v120 - v118) * clampedValue2)) + (((((v118 * 2) - (v119 * 5) + (v120 * 4)) - v121) * clampedValue2) * clampedValue2) + ((((((v119 * 3) - v118 - (v120 * 3)) + v121) * clampedValue2) * clampedValue2) * clampedValue2)) * 0.5
end

local function sampleView(a123, a124, a125)
    --[[
      name: sampleView
      line: 395
      upvalues:
        keyAt (copy, index: 1)
        ReplayCodec (copy, index: 2)
        v3 (copy, index: 3)
        catmull (copy, index: 4)
        rampAt (copy, index: 5)
    ]]
    local kflagKey = keyAt(a123, a124)

    if kflagKey == 0 then
        a125.view = false
        return
    end

    local kflag = a123.kflags[kflagKey]
    a125.view = bit32.btest(kflag, ReplayCodec.F_VIEW)
    a125.first = bit32.btest(kflag, ReplayCodec.F_FIRST)
    a125.aimCam = bit32.btest(kflag, ReplayCodec.F_AIMCAM)
    a125.bobbing = bit32.btest(kflag, 256)
    local grid = a123.grid

    if grid and a125.view and not v3.LinearView then
        local v129, v130
        local v131 = false
        local gcursor = a123.gcursor

        if const v133 = grid[gcursor] then
            if not (a124 < v133.t0) then
                v129, v130 = v133, gcursor
            else
                v131 = true
            end
        else
            v131 = true
        end

        if v131 then
            v130 = 1
            v129 = grid[1]
        end

        while v129 and v129.t1 < a124 do
            if not (v130 < #grid) then
                break
            end

            v130 += 1
            v129 = grid[v130]
        end

        a123.gcursor = v130

        if v129 and v129.t0 <= a124 then
            if a124 <= v129.t1 + 0.016666666666666666 then
                local fov
                local v135 = (a124 - v129.t0) / v129.dt
                local clampedValue = math.clamp(math.floor(v135) + 1, 1, v129.n)
                local clampedValue2 = math.clamp(v135 - (clampedValue - 1), 0, 1)
                local v138 = catmull(v129.fov, v129.n, clampedValue, clampedValue2)
                a125.viewYaw = ((catmull(v129.yaw, v129.n, clampedValue, clampedValue2) + math.pi) % math.tau) - math.pi
                a125.viewPitch = catmull(v129.pitch, v129.n, clampedValue, clampedValue2)

                if not (20 <= v138) then
                    fov = 70
                else
                    fov = v138
                end

                a125.fov = fov

                return
            end
        end
    end

    local viewYaw, viewPitch, v141 = rampAt(a123, kflagKey, a124)
    local fov = not (20 <= v141) and 70 or v141
    a125.viewYaw = viewYaw
    a125.viewPitch = viewPitch
    a125.fov = fov
end

local function cfAt(a144, a145, origin)
    --[[
      name: cfAt
      line: 430
    ]]
    return CFrame.new(origin.X + a144.px[a145], origin.Y + a144.py[a145], origin.Z + a144.pz[a145]) * CFrame.fromEulerAnglesYXZ(a144.rx[a145], a144.ry[a145], a144.rz[a145])
end

function v3.Sample(a147, a148, a149, a150)
    --[[
      name: Sample
      line: 436
      upvalues:
        cfAt (copy, index: 1)
        sampleView (copy, index: 2)
    ]]
    local v151
    local n = a148.n

    if n == 0 then
        a150.present = false
        return
    end

    local v153 = a148.t
    local cursor = a148.cursor

    if n < cursor then
        v151 = 1
    elseif a149 < v153[cursor] then
        v151 = 1
    else
        v151 = cursor
    end

    while v151 < n and v153[v151 + 1] <= a149 do
        v151 += 1
    end

    a148.cursor = v151
    local origin = a147.origin

    if a149 < v153[1] then
        if 0.3 < v153[1] - a149 then
            a150.present = false
            return
        end

        v151 = 1
    end

    local v156 = v153[v151]
    local v157 = v151 + 1

    if not (n < v157) and not (0.3 < v153[v157] - v156) and not (a149 < v156) then
        local v158
        v153 = v153[v157] - v156
        local alpha = math.clamp((a149 - v156) / v153, 0, 1)
        local vector3 = Vector3.new(a148.px[v151], a148.py[v151], a148.pz[v151])
        local vector32 = Vector3.new(a148.px[v157], a148.py[v157], a148.pz[v157])
        local startValue = Vector3.new(a148.vx[v151], a148.vy[v151], a148.vz[v151])
        local targetValue = Vector3.new(a148.vx[v157], a148.vy[v157], a148.vz[v157])

        if not (12 < (vector32 - vector3).Magnitude) then
            local v164 = alpha * alpha
            local v165 = alpha * alpha * alpha
            local v166 = v165 * 2 - (v164 * 3) + 1
            local v167 = v165 - (v164 * 2) + alpha
            local v168 = v165 * -2 + v164 * 3
            local v169 = v165 - v164
            v158 = ((vector3 * v166) + (startValue * (v167 * v153))) + (vector32 * v168) + targetValue * (v169 * v153)
        else
            v158 = if alpha < 0.5 then vector3 else vector32
        end

        local startValue2 = CFrame.fromEulerAnglesYXZ(a148.rx[v151], a148.ry[v151], a148.rz[v151])
        local targetValue2 = CFrame.fromEulerAnglesYXZ(a148.rx[v157], a148.ry[v157], a148.rz[v157])
        a150.present = true
        a150.cf = CFrame.new(origin + v158) * startValue2:Lerp(targetValue2, alpha)
        a150.vel = startValue:Lerp(targetValue, alpha)
        local v172 = if alpha < 0.5 then v151 else v157
        a150.item, a150.hp, a150.armor, a150.flags = a148.item[v172], a148.hp[v172], a148.armor[v172], a148.flags[v172]
        sampleView(a148, a149, a150)

        return
    end

    a150.present = (a149 - v156) <= 0.3
    a150.cf = cfAt(a148, v151, origin)
    a150.vel = Vector3.new(a148.vx[v151], a148.vy[v151], a148.vz[v151])
    a150.item, a150.hp, a150.armor, a150.flags = a148.item[v151], a148.hp[v151], a148.armor[v151], a148.flags[v151]
    sampleView(a148, a149, a150)
end

return v3