local ReplayCodec_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("ReplayCodec"))
local tbl_upv_1 = {}
function tbl_upv_1.Decode(a1)
    --[[
      name: Decode
      line: 91
      upvalues:
        ReplayCodec_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if typeof(a1) ~= "buffer" or buffer.len(a1) < 32 then
        return nil, "empty clip"
    end
    local v1 = ReplayCodec_upv_1.Reader(a1)
    if ReplayCodec_upv_1.RU32(v1) ~= ReplayCodec_upv_1.MAGIC then
        return nil, "not a clip"
    end
    local v2 = ReplayCodec_upv_1.RU8(v1)
    if v2 ~= ReplayCodec_upv_1.VERSION or ReplayCodec_upv_1.SAMPLE_BYTES ~= 27 then
        return nil, (("clip version %* (expected %*)"):format(v2, ReplayCodec_upv_1.VERSION))
    end
    local v3 = ReplayCodec_upv_1.RF32(v1)
    local v4 = ReplayCodec_upv_1.RF32(v1)
    local v5 = ReplayCodec_upv_1.RV3(v1)
    local v6 = ReplayCodec_upv_1.RU8(v1)
    local v7 = ReplayCodec_upv_1.RU8(v1)
    local tbl_2 = {}
    for n_1 = 1, v7 do
        local v8 = ReplayCodec_upv_1.RStr(v1)
        local v9 = ReplayCodec_upv_1.RStr(v1)
        local v10 = ReplayCodec_upv_1.RU8(v1)
        local v11 = ReplayCodec_upv_1.RU8(v1) == 1
        tbl_2[n_1] = {gcursor = 1, n = 0, kn = 0, cursor = 1, kcursor = 1, index = n_1, id = v8, name = v9, team = v10, left = v11, t = {}, px = {}, py = {}, pz = {}, rx = {}, ry = {}, rz = {}, vx = {}, vy = {}, vz = {}, item = {}, hp = {}, armor = {}, flags = {}, kt = {}, kyaw = {}, kpitch = {}, kfov = {}, kflags = {}}
    end
    local tbl_3 = {}
    local tbl_4 = {}
    for n_2 = 1, ReplayCodec_upv_1.RU8(v1) do
        tbl_4[n_2] = ReplayCodec_upv_1.RStr(v1)
    end
    local tbl_5 = {}
    for n_3 = 1, ReplayCodec_upv_1.RU8(v1) do
        tbl_5[n_3] = ReplayCodec_upv_1.RStr(v1)
        local v12 = n_3
    end
    local v13 = ReplayCodec_upv_1.RStr(v1)
    local v14 = ReplayCodec_upv_1.RU8(v1)
    local v12 = ReplayCodec_upv_1.RU8(v1)
    local v15 = math.min(v1.pos + ReplayCodec_upv_1.RU32(v1), v1.len)
    local tbl_6 = {}
    local buf_1 = v1.buf
    local v16 = 1 / ReplayCodec_upv_1.POS_Q
    local v17 = 1 / ReplayCodec_upv_1.ROT_Q
    local v18 = 1 / ReplayCodec_upv_1.VEL_Q
    v1 = nil
    while v1.pos + ReplayCodec_upv_1.RECORD_HEADER <= v15 do
        local v19 = ReplayCodec_upv_1.RU8(v1)
        local v20 = ReplayCodec_upv_1.RU16(v1) / 1000 - v4
        local v21 = v1.pos + ReplayCodec_upv_1.RU16(v1)
        local v22, v23 = nil, nil
        if v15 < v21 then
            break
        end
        if v19 ~= ReplayCodec_upv_1.REC_FRAME then
            if v19 ~= ReplayCodec_upv_1.REC_EVENT then
                v1.pos = v21
                continue
            end
            local v24 = tbl_4[ReplayCodec_upv_1.RU8(v1)]
            local tbl_7 = {}
            for _ = 1, ReplayCodec_upv_1.RU8(v1) do
                if v21 <= v1.pos then
                    break
                end
                v22 = tbl_4[ReplayCodec_upv_1.RU8(v1)]
                local v25 = ReplayCodec_upv_1.ReadValue(v1)
                if v22 then
                    tbl_7[v22] = v25
                end
            end
            if v24 then
                table.insert(tbl_6, {t = v20, kind = v24, data = tbl_7})
            end
        else
            local v26 = ReplayCodec_upv_1.RU16(v1)
            for n_4 = 1, v7 do
                local v27 = bit32.btest(v26, bit32.lshift(1, n_4 - 1))
                if not (v27) then
                    continue
                end
                if v21 < v1.pos + ReplayCodec_upv_1.SAMPLE_BYTES then
                    break
                end
                local v28 = tbl_2[n_4]
                local v29 = v28.n + 1
                v28.n = v29
                local pos_1 = v1.pos
                v28.t[v29] = v20
                v28.px[v29] = buffer.readi16(buf_1, pos_1) * v16
                v28.py[v29] = buffer.readi16(buf_1, pos_1 + 2) * v16
                v28.pz[v29] = buffer.readi16(buf_1, pos_1 + 4) * v16
                v28.rx[v29] = buffer.readi16(buf_1, pos_1 + 6) * v17
                v28.ry[v29] = buffer.readi16(buf_1, pos_1 + 8) * v17
                v28.rz[v29] = buffer.readi16(buf_1, pos_1 + 10) * v17
                v28.vx[v29] = buffer.readi16(buf_1, pos_1 + 12) * v18
                v28.vy[v29] = buffer.readi16(buf_1, pos_1 + 14) * v18
                v28.vz[v29] = buffer.readi16(buf_1, pos_1 + 16) * v18
                v28.item[v29] = buffer.readu8(buf_1, pos_1 + 18)
                v28.hp[v29] = buffer.readu8(buf_1, pos_1 + 19) * (1 / ReplayCodec_upv_1.HP_Q)
                v28.armor[v29] = buffer.readu8(buf_1, pos_1 + 20)
                local v30 = buffer.readu8(buf_1, pos_1 + 21)
                v28.flags[v29] = v30
                local v31 = buffer.readi16(buf_1, pos_1 + 22)
                local v32 = buffer.readi16(buf_1, pos_1 + 24)
                local v33 = buffer.readu8(buf_1, pos_1 + 26)
                local v34 = bit32.band(v30, (ReplayCodec_upv_1.F_VIEW + ReplayCodec_upv_1.F_FIRST) + ReplayCodec_upv_1.F_AIMCAM)
                v23 = tbl_3[n_4]
                if not (v23) or v23[1] ~= v31 or v23[2] ~= v32 or v23[3] ~= v33 then
                    tbl_3[n_4] = {v31, v32, v33, v34}
                    local v35 = v28.kn + 1
                    v28.kn = v35
                    v28.kt[v35] = v20
                    v28.kyaw[v35] = v31 * v17
                    v28.kpitch[v35] = v32 * v17
                    v28.kfov[v35] = bit32.band(v33, 127)
                    v28.kflags[v35] = v34 + (((v33 >= 128) and 256) or 0)
                    v1.pos = pos_1 + ReplayCodec_upv_1.SAMPLE_BYTES
                    continue
                end
                if v23[4] ~= v34 then
                    tbl_3[n_4] = {v31, v32, v33, v34}
                    local v35 = v28.kn + 1
                    v28.kn = v35
                    v28.kt[v35] = v20
                    v28.kyaw[v35] = v31 * v17
                    v28.kpitch[v35] = v32 * v17
                    v28.kfov[v35] = bit32.band(v33, 127)
                    v28.kflags[v35] = v34 + (((v33 >= 128) and 256) or 0)
                end
                v1.pos = pos_1 + ReplayCodec_upv_1.SAMPLE_BYTES
            end
        end
        v1.pos = v21
    end
    table.sort(
        tbl_6,
        function(a2, a3)
            --[[
              line: 237
            ]]
            return a2.t < a3.t
        end
    )
    local v36 = tbl_2[v6]
    if v36 then
        tbl_upv_1.BuildViewGrid(v36)
    end
    local tbl_8 = {}
    tbl_8.duration = v3
    tbl_8.preroll = v4
    tbl_8.origin = v5
    tbl_8.focus = v6
    tbl_8.fighters = tbl_2
    tbl_8.events = tbl_6
    tbl_8.items = tbl_5
    tbl_8.title = v13
    tbl_8.kills = v14
    tbl_8.headshots = v12
    tbl_8.bytes = buffer.len(a1)
    return tbl_8, nil
end
function tbl_upv_1.NewState()
    --[[
      name: NewState
      line: 259
    ]]
    local tbl_9 = {view = false, present = false, vel = Vector3.new(0, 0, 0), first = false, hp = 0, bobbing = false, viewPitch = 0, item = 0, viewYaw = 0, armor = 0, aimCam = false, fov = 70, flags = 0}
    tbl_9.cf = CFrame.identity
    return tbl_9
end
tbl_upv_1.LinearView = false
local function wrapPi(a1)
    --[[
      name: wrapPi
      line: 275
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local function viewFlags(a1, a2)
    --[[
      name: viewFlags
      line: 279
      upvalues:
        ReplayCodec_upv_1 (copy, index: 1)
    ]]
    a2.view = bit32.btest(a1, ReplayCodec_upv_1.F_VIEW)
    a2.first = bit32.btest(a1, ReplayCodec_upv_1.F_FIRST)
    a2.aimCam = bit32.btest(a1, ReplayCodec_upv_1.F_AIMCAM)
    a2.bobbing = bit32.btest(a1, 256)
end
local function rampAt(a1, a2, a3)
    --[[
      name: rampAt
      line: 306
      upvalues:
        ReplayCodec_upv_1 (copy, index: 1)
    ]]
    local v37 = a1.kyaw[a2]
    local v38 = a1.kpitch[a2]
    local v39 = a1.kfov[a2]
    local v40 = a2 + 1
    if v40 <= a1.kn then
        local v41 = bit32.btest(a1.kflags[v40], ReplayCodec_upv_1.F_VIEW)
        if v41 then
            local v42 = bit32.btest(a1.kflags[a2], ReplayCodec_upv_1.F_VIEW)
            local v43 = nil
            if v42 then
                local v44 = a1.kt[v40]
                v43 = math.max(a1.kt[a2], v44 - 0.1)
                if v43 < a3 then
                    local v45 = math.clamp((a3 - v43) / math.max(v44 - v43, 0.001), 0, 1)
                    v37 = v37 + ((((a1.kyaw[v40] - v37) + math.pi) % math.tau) - math.pi) * v45
                    v38 = v38 + (a1.kpitch[v40] - v38) * v45
                    v39 = v39 + (a1.kfov[v40] - v39) * v45
                end
            end
        end
    end
    return v37, v38, v39
end
local tbl_upv_10 = {}
tbl_upv_10[1] = 0.0038659201394728076
tbl_upv_10[2] = 0.014214791206736984
tbl_upv_10[3] = 0.0439369336234074
tbl_upv_10[4] = 0.11416176000968695
tbl_upv_10[5] = 0.24935220877729622
tbl_upv_10[6] = 0.4578333617716142
tbl_upv_10[7] = 0.7066482778577162
tbl_upv_10[8] = 0.9168553557320289
tbl_upv_10[9] = 1
tbl_upv_10[10] = 0.9168553557320289
tbl_upv_10[11] = 0.7066482778577162
tbl_upv_10[12] = 0.4578333617716142
tbl_upv_10[13] = 0.24935220877729622
tbl_upv_10[14] = 0.11416176000968695
tbl_upv_10[15] = 0.0439369336234074
tbl_upv_10[16] = 0.014214791206736984
tbl_upv_10[17] = 0.0038659201394728076
local function smoothInto(a1, a2, a3)
    --[[
      name: smoothInto
      line: 329
      upvalues:
        tbl_upv_10 (copy, index: 1)
    ]]
    for n_5 = 1, a2 do
        local v46 = 0
        local v47 = 0
        for n_6 = math.max(1, n_5 - 8), math.min(a2, n_5 + 8) do
            local v48 = tbl_upv_10[((n_6 - n_5) + 8) + 1]
            v46 = v46 + v48
            v47 = v47 + v48 * a1[n_6]
        end
        a3[n_5] = v47 / v46
    end
end
function tbl_upv_1.BuildViewGrid(a1)
    --[[
      name: BuildViewGrid
      line: 343
      upvalues:
        ReplayCodec_upv_1 (copy, index: 1)
        rampAt (copy, index: 2)
        smoothInto (copy, index: 3)
    ]]
    local tbl_11 = {}
    local kn_1 = a1.kn
    local v49 = 1
    local v50 = nil
    while v49 <= kn_1 do
        if not (bit32.btest(a1.kflags[v49], ReplayCodec_upv_1.F_VIEW)) then
            v49 = v49 + 1
            continue
        end
        while v49 + 1 <= kn_1 do
            if bit32.btest(a1.kflags[v49 + 1], ReplayCodec_upv_1.F_VIEW) then
                v49 = v49 + 1
                continue
            else
                break
            end
        end
        local v51 = a1.kt[v49]
        local v52
        if v49 < kn_1 then
            v52 = a1.kt[v49 + 1]
        else
            v52 = math.max(v51, (a1.t[a1.n] or v51) + 0.05)
        end
        local v53 = math.max(1, math.floor((v52 - v51) / 0.016666666666666666) + 2)
        local v54 = table.create(v53, 0)
        local v55 = table.create(v53, 0)
        local v56 = table.create(v53, 0)
        local v57 = 0
        v50 = v49
        for n_7 = 1, v53 do
            local v58 = v51 + (n_7 - 1) * 0.016666666666666666
            while v50 < v49 do
                if a1.kt[v50 + 1] <= v58 then
                    v50 = v50 + 1
                    continue
                else
                    break
                end
            end
            local v59, v60, v61 = rampAt(a1, v50, v58)
            local v62 = ((n_7 > 1) and (v57 + ((((v59 - v57) + math.pi) % math.tau) - math.pi))) or v59
            v54[n_7] = v62
            v55[n_7] = v60
            v56[n_7] = v61
            v57 = v62
        end
        local tbl_12 = {dt = 0.016666666666666666}
        tbl_12.t0 = v51
        tbl_12.t1 = v52
        tbl_12.n = v53
        tbl_12.yaw = table.create(v53, 0)
        tbl_12.pitch = table.create(v53, 0)
        tbl_12.fov = table.create(v53, 0)
        smoothInto(v54, v53, tbl_12.yaw)
        smoothInto(v55, v53, tbl_12.pitch)
        smoothInto(v56, v53, tbl_12.fov)
        table.insert(tbl_11, tbl_12)
        v49 = v49 + 1
    end
    a1.grid = tbl_11
    a1.gcursor = 1
end
local function keyAt(a1, a2)
    --[[
      name: keyAt
      line: 287
    ]]
    local kn_2 = a1.kn
    if kn_2 == 0 or a2 < a1.kt[1] then
        return 0
    end
    local kt_1 = a1.kt
    local v63 = a1.kcursor
    if kn_2 < v63 or a2 < kt_1[v63] then
        v63 = 1
    end
    while v63 < kn_2 do
        if kt_1[v63 + 1] <= a2 then
            v63 = v63 + 1
            continue
        else
            break
        end
    end
    a1.kcursor = v63
    return v63
end
local function catmull(a1, a2, a3, a4)
    --[[
      name: catmull
      line: 386
    ]]
    local v64 = a1[math.max(1, a3 - 1)]
    local v65 = a1[a3]
    local v66 = a1[math.min(a2, a3 + 1)]
    local v67 = a1[math.min(a2, a3 + 2)]
    return ((((v65 * 2) + ((v66 - v64) * a4)) + ((((((v64 * 2) - (v65 * 5)) + (v66 * 4)) - v67) * a4) * a4)) + (((((((v65 * 3) - v64) - (v66 * 3)) + v67) * a4) * a4) * a4)) * 0.5
end
local function cfAt(a1, a2, a3)
    --[[
      name: cfAt
      line: 430
    ]]
    return CFrame.new(a3.X + a1.px[a2], a3.Y + a1.py[a2], a3.Z + a1.pz[a2]) * CFrame.fromEulerAnglesYXZ(a1.rx[a2], a1.ry[a2], a1.rz[a2])
end
local function sampleView(a1, a2, a3)
    --[[
      name: sampleView
      line: 395
      upvalues:
        keyAt (copy, index: 1)
        ReplayCodec_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        catmull (copy, index: 4)
        rampAt (copy, index: 5)
    ]]
    local v68 = keyAt(a1, a2)
    if v68 ~= 0 then
        local grid_1 = a1.kflags[v68]
        a3.view = bit32.btest(grid_1, ReplayCodec_upv_1.F_VIEW)
        a3.first = bit32.btest(grid_1, ReplayCodec_upv_1.F_FIRST)
        a3.aimCam = bit32.btest(grid_1, ReplayCodec_upv_1.F_AIMCAM)
        a3.bobbing = bit32.btest(grid_1, 256)
        grid_1 = a1.grid
        if grid_1 and a3.view then
            local v69 = nil
            if tbl_upv_1.LinearView then
                local v70, _, v71 = rampAt(a1, v68, a2)
                local v72
                if v71 >= 20 then
                    v72 = v71
                else
                    v72 = 70
                end
                a3.viewYaw = v70
                a3.viewPitch = nil
                a3.fov = v72
            else
                local v73 = a1.gcursor
                v69 = grid_1[v73]
                if not (v69) or a2 < v69.t0 then
                    v69, v73 = grid_1[1], 1
                end
                while v69 and (v69.t1 < a2) do
                    if v73 < #grid_1 then
                        v73 = v73 + 1
                        v69 = grid_1[v73]
                        continue
                    else
                        break
                    end
                end
                a1.gcursor = v73
                if v69 and v69.t0 <= a2 and a2 <= v69.t1 + 0.016666666666666666 then
                    v73 = (a2 - v69.t0) / v69.dt
                    local v74 = math.clamp(math.floor(v73) + 1, 1, v69.n)
                    local v75 = math.clamp(v73 - (v74 - 1), 0, 1)
                    v73 = catmull(v69.fov, v69.n, v74, v75)
                    a3.viewYaw = ((catmull(v69.yaw, v69.n, v74, v75) + math.pi) % math.tau) - math.pi
                    a3.viewPitch = catmull(v69.pitch, v69.n, v74, v75)
                    local v76
                    if v73 >= 20 then
                        v76 = v73
                    else
                        v76 = 70
                    end
                    a3.fov = v76
                else
                    local v73, v69, v71 = rampAt(a1, v68, a2)
                    local v72
                    if v71 >= 20 then
                        v72 = v71
                    else
                        v72 = 70
                    end
                    a3.viewYaw = v73
                    a3.viewPitch = nil
                    a3.fov = v72
                end
            end
        else
            local v70, _, v71 = rampAt(a1, v68, a2)
            local v72
            if v71 >= 20 then
                v72 = v71
            else
                v72 = 70
            end
            a3.viewYaw = v70
            a3.viewPitch = nil
            a3.fov = v72
        end
    else
        a3.view = false
    end
end
function tbl_upv_1.Sample(a1, a2, a3, a4)
    --[[
      name: Sample
      line: 436
      upvalues:
        cfAt (copy, index: 1)
        sampleView (copy, index: 2)
    ]]
    local n_8 = a2.n
    if n_8 ~= 0 then
        local t_1 = a2.t
        local v77 = a2.cursor
        if n_8 < v77 or a3 < t_1[v77] then
            v77 = 1
        end
        while v77 < n_8 do
            if t_1[v77 + 1] <= a3 then
                v77 = v77 + 1
                continue
            else
                break
            end
        end
        a2.cursor = v77
        local origin_1 = a1.origin
        if a3 < t_1[1] then
            if t_1[1] - a3 > 0.3 then
                a4.present = false
                return
            end
            v77 = 1
        end
        local v78 = t_1[v77]
        local v79 = v77 + 1
        if not (n_8 < v79) and not (t_1[v79] - v78 > 0.3) then
            local _, v80 = nil, nil
            if not (a3 < v78) then
                t_1 = t_1[v79] - v78
                local v81 = math.clamp((a3 - v78) / t_1, 0, 1)
                v78 = Vector3.new(a2.px[v77], a2.py[v77], a2.pz[v77])
                v80 = Vector3.new(a2.px[v79], a2.py[v79], a2.pz[v79])
                local v82 = Vector3.new(a2.vx[v77], a2.vy[v77], a2.vz[v77])
                local v83 = Vector3.new(a2.vx[v79], a2.vy[v79], a2.vz[v79])
                local v84
                if (v80 - v78).Magnitude > 12 then
                    if v81 < 0.5 then
                        v84 = v78
                    else
                        v84 = v80
                    end
                else
                    local v86 = v81 * v81
                    local v87 = v81 * v81 * v81
                    v84 = v78 * (v81 * v81 * v81 * 2 - v81 * v81 * 3 + 1) + v82 * ((v81 * v81 * v81 - v81 * v81 * 2 + v81) * t_1) + v80 * (v81 * v81 * v81 * -2 + v81 * v81 * 3) + v83 * ((v81 * v81 * v81 - v81 * v81) * t_1)
                end
                local v85 = CFrame.fromEulerAnglesYXZ(a2.rx[v77], a2.ry[v77], a2.rz[v77])
                v78 = CFrame.fromEulerAnglesYXZ(a2.rx[v79], a2.ry[v79], a2.rz[v79])
                a4.present = true
                a4.cf = CFrame.new(origin_1 + v84) * v85:Lerp(v78, v81)
                a4.vel = v82:Lerp(v83, v81)
                if not (v81 < 0.5) then
                    v84 = v79
                end
                a4.item = a2.item[v84]
                a4.hp = a2.hp[v84]
                a4.armor = a2.armor[v84]
                a4.flags = a2.flags[v84]
                sampleView(a2, a3, a4)
                return
            end
        end
        a4.present = (a3 - v78) <= 0.3
        a4.cf = cfAt(a2, v77, origin_1)
        a4.vel = Vector3.new(a2.vx[v77], a2.vy[v77], a2.vz[v77])
        a4.item = a2.item[v77]
        a4.hp = a2.hp[v77]
        a4.armor = a2.armor[v77]
        a4.flags = a2.flags[v77]
        sampleView(a2, a3, a4)
    else
        a4.present = false
    end
end
return tbl_upv_1