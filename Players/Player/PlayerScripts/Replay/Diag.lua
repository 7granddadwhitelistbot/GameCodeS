local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local tbl_upv_1 = {}
tbl_upv_1.FAR = 10
local u1 = nil
local u2 = nil
local u3 = RunService_upv_1:IsStudio()
local tbl_upv_2 = {}
local function num(a1)
    --[[
      name: num
      line: 85
    ]]
    if a1 < 0 then
        return "-"
    end
    if a1 ~= 0 then
        if a1 < 5 then
            return "1+"
        end
        if a1 < 10 then
            return "5+"
        elseif a1 < 20 then
            return "10+"
        else
            return "20+"
        end
    end
    return "0"
end
local function rel(a1, a2)
    --[[
      name: rel
      line: 100
    ]]
    if a1 <= 0 then
        return "0"
    end
    if a2 <= a1 then
        return "all"
    elseif a2 <= a1 * 2 then
        return "most"
    else
        return "some"
    end
end
local function cnt(a1)
    --[[
      name: cnt
      line: 111
    ]]
    if a1 >= 2 then
        return "2+"
    end
    return (tostring(a1))
end
local function b(a1)
    --[[
      name: b
      line: 115
    ]]
    if a1 then
        return "1"
    end
    return "0"
end
function tbl_upv_1.Evaluate(a1)
    --[[
      name: Evaluate
      line: 122
    ]]
    if a1.parented then
        if a1.parts ~= 0 then
            if a1.parts <= a1.far * 2 then
                return "far"
            end
            if a1.parts <= a1.loose * 2 then
                return "loose"
            end
            if a1.vis * 3 < a1.parts then
                if a1.tr > 0 and a1.ltm <= a1.tr then
                    return "tr"
                elseif a1.ltm > 0 then
                    return "ltm"
                else
                    return "vis"
                end
            end
            return nil
        end
        return "noparts"
    end
    return "unparented"
end
local function kindOf(a1)
    --[[
      name: kindOf
      line: 142
    ]]
    if string.sub(a1, 1, 1) ~= "p" then
        return "B"
    end
    return "A"
end
local function tally(a1, a2, a3)
    --[[
      name: tally
      line: 147
    ]]
    local v1 = ((string.sub(a2, 1, 1) ~= "p") and "B") or "A"
    if a3 then
        if v1 ~= "A" then
            a1.hB = a1.hB + 1
        else
            a1.hA = a1.hA + 1
        end
    elseif v1 ~= "A" then
        a1.okB = a1.okB + 1
    else
        a1.okA = a1.okA + 1
    end
end
function tbl_upv_1.Begin(a1)
    --[[
      name: Begin
      line: 165
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 2)
        Players_upv_1 (copy, index: 3)
    ]]
    local tbl_3 = {}
    for key_1, value_1 in a1.fighters do
        tbl_3[key_1] = value_1.id
    end
    local v2 = false
    local v3 = a1.fighters[a1.focus]
    if v3 and v3.flags then
        for n_1 = 1, v3.n do
            if bit32.band(v3.flags[n_1], 96) == 96 then
                v2 = true
                break
            end
        end
    end
    table.clear(tbl_upv_2)
    local tbl_4 = {aimBest = math.huge, frames = 0, onFrames = 0, emitted = false, early = false}
    tbl_4.ids = tbl_3
    tbl_4.focus = a1.focus
    tbl_4.me = "p" .. tostring(Players_upv_1.LocalPlayer.UserId)
    tbl_4.fp = v2
    tbl_4.build = {hB = 0, okB = 0, okA = 0, hA = 0}
    tbl_4.srcs = {}
    tbl_4.shots = {}
    u1 = tbl_4
end
local function detail(a1, a2, a3, a4, a5)
    --[[
      name: detail
      line: 77
      upvalues:
        u3 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    if not u3 then
        return
    end
    if #tbl_upv_2 < 40 then
        local v4 = ((not a5) and "-") or (string.format("parts=%d vis=%d tr=%d ltm=%d far=%d loose=%d par=%s", a5.parts, a5.vis, a5.tr, a5.ltm, a5.far, a5.loose, tostring(a5.parented)))
        table.insert(tbl_upv_2, string.format("%s %s why=%s src=%s %s", a1, a2, a3, a4, v4))
    end
end
local function note(a1, a2, a3, a4, a5, a6, a7, a8)
    --[[
      name: note
      line: 200
    ]]
    if a1.failure then
        return
    end
    local v5 = a1.ids[a3] or "?"
    local tbl_5 = {self = 0, live = 0, st = 0, at = 0, src = 0, k = 0, focus = 0, fix = 0}
    tbl_5.index = a3
    tbl_5.why = a4
    tbl_5.k = string.sub(v5, 1, 1) ~= "p" and "B" or "A"
    tbl_5.src = a5
    tbl_5.at = a2
    tbl_5.self = v5 == a1.me
    tbl_5.focus = a3 == a1.focus
    tbl_5.st = a6
    tbl_5.live = a7
    tbl_5.fix = a8
    a1.failure = tbl_5
end
function tbl_upv_1.Built(a1, a2, a3, a4, a5, a6, a7, a8)
    --[[
      name: Built
      line: 222
      upvalues:
        u1 (ref,  index: 1)
        detail (copy, index: 2)
        note (copy, index: 3)
    ]]
    if not u1 then
        return
    end
    local v7 = u1.ids[a1] or "?"
    if a2 then
        u1.srcs[a2.src] = (u1.srcs[a2.src] or 0) + 1
    end
    local v8
    if a8 then
        v8 = u1.failure
        if not v8 or v8.index ~= a1 or v8.at ~= "build" or not a2 or not a7 then
            return
        end
        v8.fix = a2.src
    else
        v8 = true
        if a3 == nil then
            v8 = a2 == nil
        end
        local build_1 = u1.build
        local v9 = ((string.sub(v7, 1, 1) ~= "p") and "B") or "A"
        if v8 then
            if v9 ~= "A" then
                build_1.hB = build_1.hB + 1
            else
                build_1.hA = build_1.hA + 1
            end
        elseif v9 ~= "A" then
            build_1.okB = build_1.okB + 1
        else
            build_1.okA = build_1.okA + 1
        end
        if v8 then
            detail("build", v7, a3 or "missing", a4 or "none", a5)
        end
        if v8 then
            if a2 and a7 and a3 then
                v8 = a2.src
            else
                v8 = (a3 and "failed") or "none"
            end
            if a2 == nil and a3 == nil then
                note(u1, "build", a1, "missing", "none", nil, a6, "none")
            else
                note(u1, "build", a1, a3, a4 or "?", a5, a6, v8)
            end
            if u1.failure and u1.failure.at == "build" and u1.counts == nil then
                u1.counts = u1.build
            end
        end
    end
end
function tbl_upv_1.Check(a1, a2, a3, a4, a5)
    --[[
      name: Check
      line: 261
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        detail (copy, index: 3)
        note (copy, index: 4)
    ]]
    if not u1 then
        return
    end
    if a1 == "early" then
        u1.early = true
    end
    local tbl_6 = {hB = 0, okB = 0, okA = 0, hA = 0}
    local v10 = false
    local v11, v12 = nil, nil
    local v13 = nil
    for key_2, value_2 in a2.clip.fighters do
        local v14 = a2.puppets[key_2]
        if value_2.n > 0 and not (v14) then
            a5(key_2)
        end
        local v15 = a2.states[key_2]
        if not (value_2.n > 0) or not (v15) or not (v15.present) then
            continue
        end
        if key_2 ~= a2.focus or not (a3) then
            v12 = nil
            if v14 then
                v12 = a4(v14)
                v11 = tbl_upv_1.Evaluate(v12)
                v12 = v11 or v14.alive and v12
            else
                v11 = "missing"
            end
            local id_1 = value_2.id
            if v11 ~= nil then
                v13 = true
            else
                v13 = false
            end
            local v16 = ((string.sub(id_1, 1, 1) ~= "p") and "B") or "A"
            if v13 then
                if v16 ~= "A" then
                    tbl_6.hB = tbl_6.hB + 1
                else
                    tbl_6.hA = tbl_6.hA + 1
                end
            elseif v16 ~= "A" then
                tbl_6.okB = tbl_6.okB + 1
            else
                tbl_6.okA = tbl_6.okA + 1
            end
            if v11 then
                detail(a1, value_2.id, v11, ((not v14) and "none") or (v14.src), v12)
            end
            if not (v11) then
                continue
            end
            if not (u1.failure) then
                note(u1, a1, key_2, v11, ((not v14) and "none") or (v14.src), v12, ((not v14) and -1) or (v14.liveParts), "none")
                v10 = true
            end
        end
    end
    if not v10 then
        return
    end
    u1.counts = tbl_6
end
function tbl_upv_1.Frame(a1, a2)
    --[[
      name: Frame
      line: 306
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 then
        return
    end
    u1.frames = u1.frames + 1
    local CFrame_1 = a2.CFrame
    local LookVector_1 = CFrame_1.LookVector
    local Position_1 = CFrame_1.Position
    local team_1 = a1.clip.fighters[a1.focus].team
    local v17 = false
    for key_3, value_3 in a1.clip.fighters do
        local v18 = a1.states[key_3]
        if key_3 == a1.focus or not (v18) or not (v18.present) then
            continue
        end
        local v19 = v18.cf.Position + Vector3.new(0, 1, 0)
        local v20, v21 = a2:WorldToViewportPoint(v19)
        if v21 then
            v17 = ((v20.Z > 0) and true) or v17
        end
        if value_3.team == team_1 then
            continue
        end
        local v22 = bit32.btest(v18.flags, 1)
        if not (v22) then
            continue
        end
        local v23 = v19 - Position_1
        if not (v23.Magnitude > 1) then
            continue
        end
        local v24 = math.deg(math.acos(math.clamp(LookVector_1:Dot(v23.Unit), -1, 1)))
        if v24 < u1.aimBest then
            u1.aimBest = v24
        end
    end
    if not v17 then
        return
    end
    u1.onFrames = u1.onFrames + 1
end
function tbl_upv_1.Shot(a1, a2)
    --[[
      name: Shot
      line: 342
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 then
        return
    end
    if not (#u1.shots >= 32) then
        local CFrame_2 = a1.CFrame
        local v25 = a2 - CFrame_2.Position
        if (v25.Magnitude < 2) then
            return
        end
        table.insert(u1.shots, (math.deg(math.acos(math.clamp(CFrame_2.LookVector:Dot(v25.Unit), -1, 1)))))
    end
end
local function median(a1)
    --[[
      name: median
      line: 355
    ]]
    if #a1 == 0 then
        return nil
    end
    local v26 = table.clone(a1)
    table.sort(v26)
    return v26[math.ceil(#v26 / 2)]
end
local function view(a1)
    --[[
      name: view
      line: 364
    ]]
    local v27 = a1.shots
    local v28
    if #v27 ~= 0 then
        local v29 = table.clone(v27)
        table.sort(v29)
        v28 = v29[math.ceil(#v29 / 2)]
    else
        v28 = nil
    end
    if v28 ~= nil then
        v27 = ((v28 < 2) and "<2") or (((v28 < 5) and "<5") or (((v28 < 15) and "<15") or "15+"))
    else
        v27 = "-"
    end
    local aimBest_1 = a1.aimBest
    local v29 = ((aimBest_1 == math.huge) and "-") or (((aimBest_1 < 5) and "<5") or (((aimBest_1 < 15) and "<15") or (((aimBest_1 < 45) and "<45") or "45+")))
    local v30 = "-"
    if a1.frames > 0 then
        local _ = a1.onFrames / a1.frames
        v30 = a1.onFrames == 0 and "0" or a1.onFrames / a1.frames < 0.25 and "<25" or a1.onFrames / a1.frames < 0.75 and "<75" or "75+"
    end
    return string.format("shot=%s aim=%s onscr=%s", v27, v29, v30)
end
function tbl_upv_1.Flush()
    --[[
      name: Flush
      line: 380
      upvalues:
        u1 (ref,  index: 1)
        view (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if not u1 or u1.emitted then
        return
    end
    u1.emitted = true
    local shots_1 = u1.shots
    local v31
    if #shots_1 ~= 0 then
        local v32 = table.clone(shots_1)
        table.sort(v32)
        v31 = v32[math.ceil(#v32 / 2)]
    else
        v31 = nil
    end
    if not (u1.failure) and v31 and #u1.shots >= 2 and v31 >= 15 then
        local v33 = u1.ids[u1.focus] or "?"
        local tbl_7 = {self = 0, live = -1, at = "clip", src = "-", k = 0, focus = true, why = "aim", fix = "none"}
        tbl_7.index = u1.focus
        tbl_7.k = string.sub(v33, 1, 1) ~= "p" and "B" or "A"
        tbl_7.self = v33 == u1.me
        u1.failure = tbl_7
    end
    local failure_1 = u1.failure
    local v35 = nil
    if failure_1 then
        local st_1 = failure_1.st
        local v36 = u1.counts or u1.build
        local why_1 = failure_1.why
        local v37 = failure_1.k
        local v38 = failure_1.src
        local at_1 = failure_1.at
        local v39 = failure_1.self and "1" or "0"
        local v40 = failure_1.focus and "1" or "0"
        local v41 = u1.fp and "1" or "0"
        local v42
        if st_1 then
            local _ = st_1.parts
            v42 = st_1.parts < 0 and "-" or st_1.parts == 0 and "0" or st_1.parts < 5 and "1+" or st_1.parts < 10 and "5+" or st_1.parts < 20 and "10+" or "20+"
        else
            v42 = "-"
        end
        local v43 = failure_1.live
        local v44 = ((v43 < 0) and "-") or (((v43 == 0) and "0") or (((v43 < 5) and "1+") or (((v43 < 10) and "5+") or (((v43 < 20) and "10+") or "20+"))))
        if st_1 then
            local v45 = st_1.vis
            local v46 = st_1.parts
            v43 = st_1.vis <= 0 and "0" or st_1.parts <= st_1.vis and "all" or st_1.parts <= st_1.vis * 2 and "most" or "some"
        else
            v43 = "-"
        end
        local v45
        local v46
        if st_1 then
            v46 = st_1.tr
            local v47 = st_1.parts
            v45 = st_1.tr <= 0 and "0" or st_1.parts <= st_1.tr and "all" or st_1.parts <= st_1.tr * 2 and "most" or "some"
        else
            v45 = "-"
        end
        local v47
        if st_1 then
            v47 = st_1.ltm
            local v48 = st_1.parts
            v46 = st_1.ltm <= 0 and "0" or st_1.parts <= st_1.ltm and "all" or st_1.parts <= st_1.ltm * 2 and "most" or "some"
        else
            v46 = "-"
        end
        local v48
        if st_1 then
            v48 = st_1.far
            local v65 = st_1.parts
            v47 = st_1.far <= 0 and "0" or st_1.parts <= st_1.far and "all" or st_1.parts <= st_1.far * 2 and "most" or "some"
        else
            v47 = "-"
        end
        if st_1 then
            local _ = st_1.loose
            local v49 = st_1.parts
            v48 = st_1.loose <= 0 and "0" or st_1.parts <= st_1.loose and "all" or st_1.parts <= st_1.loose * 2 and "most" or "some"
        else
            v48 = "-"
        end
        local v50 = ((not st_1) and "-") or (((st_1.parented) and "1") or "0")
        local v49
        if st_1 then
            local _ = st_1.wrap
            v49 = st_1.wrap < 0 and "-" or st_1.wrap == 0 and "0" or st_1.wrap < 5 and "1+" or st_1.wrap < 10 and "5+" or st_1.wrap < 20 and "10+" or "20+"
        else
            v49 = "-"
        end
        local fix_1 = failure_1.fix
        local hA_1 = v36.hA
        local v51 = ((hA_1 >= 2) and "2+") or (tostring(hA_1))
        local hB_1 = v36.hB
        local v52 = ((hB_1 >= 2) and "2+") or (tostring(hB_1))
        local okA_1 = v36.okA
        local v53 = ((okA_1 >= 2) and "2+") or (tostring(okA_1))
        local okB_1 = v36.okB
        local v54 = ((okB_1 >= 2) and "2+") or (tostring(okB_1))
        v35 = string.format("[ReplayDiag] hidden why=%s k=%s src=%s at=%s self=%s foc=%s fp=%s parts=%s live=%s vis=%s tr=%s ltm=%s far=%s loose=%s par=%s wrap=%s fix=%s hA=%s hB=%s okA=%s okB=%s %s", why_1, v37, v38, at_1, v39, v40, v41, v42, v44, v43, v45, v46, v47, v48, v50, v49, fix_1, v51, v52, v53, v54, view(u1))
        warn(v35)
    elseif u1.early then
        if math.random() < 0.1 then
            local build_2 = u1.build
            local tbl_8 = {}
            for key_4 in u1.srcs do
                table.insert(tbl_8, key_4)
            end
            table.sort(tbl_8)
            local v55 = ((u1.fp) and "1") or "0"
            local v56 = ((string.sub(u1.ids[u1.focus] or "?", 1, 1) ~= "p") and "B") or "A"
            local v38
            if v56 == "A" then
                v38 = true
            else
                v38 = false
            end
            local v37
            if v38 then
                v37 = "1"
            else
                v37 = "0"
            end
            local v57 = u1.ids[u1.focus] == u1.me
            if v57 then
                v38 = "1"
            else
                v38 = "0"
            end
            local v58 = build_2.okA + build_2.hA
            local v59 = ((v58 >= 2) and "2+") or (tostring(v58))
            local v60 = build_2.okB + build_2.hB
            local v61 = ((v60 >= 2) and "2+") or (tostring(v60))
            local v62 = ((not (#tbl_8 > 0)) and "-") or (table.concat(tbl_8, "+"))
            v35 = string.format("[ReplayDiag] ok fp=%s focA=%s mine=%s A=%s B=%s src=%s %s", v55, v37, v38, v59, v61, v62, view(u1))
            warn(v35)
        else
            local v63 = RunService_upv_1:IsStudio()
            if v63 and workspace:GetAttribute("ReplayDiagAlways") == true then
                local build_2 = u1.build
                local tbl_8 = {}
                for key_4 in u1.srcs do
                    table.insert(tbl_8, key_4)
                end
                table.sort(tbl_8)
                local v55 = ((u1.fp) and "1") or "0"
                local v56 = ((string.sub(u1.ids[u1.focus] or "?", 1, 1) ~= "p") and "B") or "A"
                local v38
                if v56 == "A" then
                    v38 = true
                else
                    v38 = false
                end
                local v37
                if v38 then
                    v37 = "1"
                else
                    v37 = "0"
                end
                local v57 = u1.ids[u1.focus] == u1.me
                if v57 then
                    v38 = "1"
                else
                    v38 = "0"
                end
                local v58 = build_2.okA + build_2.hA
                local v59 = ((v58 >= 2) and "2+") or (tostring(v58))
                local v60 = build_2.okB + build_2.hB
                local v61 = ((v60 >= 2) and "2+") or (tostring(v60))
                local v62 = ((not (#tbl_8 > 0)) and "-") or (table.concat(tbl_8, "+"))
                v35 = string.format("[ReplayDiag] ok fp=%s focA=%s mine=%s A=%s B=%s src=%s %s", v55, v37, v38, v59, v61, v62, view(u1))
                warn(v64)
                v35 = v64
            end
        end
    end
    u2 = v35
end
function tbl_upv_1.End()
    --[[
      name: End
      line: 445
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    tbl_upv_1.Flush()
    u1 = nil
end
function tbl_upv_1.LastLine()
    --[[
      name: LastLine
      line: 452
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    return u2, tbl_upv_2
end
return tbl_upv_1