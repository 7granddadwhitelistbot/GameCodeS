local players = game:GetService("Players")
local runService = game:GetService("RunService")
local v3 = {FAR = 10}
local v4 = nil
local formattedText = nil
local isStudio = runService:IsStudio()
local v7 = {}

local function detail(a9, a10, a11, a12, a13)
    --[[
      name: detail
      line: 77
      upvalues:
        isStudio (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    if isStudio and #v7 < 40 then
        local stringFormat = string.format
        local v15 = not a13 and "-"
            or string.format("parts=%d vis=%d tr=%d ltm=%d far=%d loose=%d par=%s", a13.parts, a13.vis, a13.tr, a13.ltm, a13.far, a13.loose, (tostring(a13.parented)))
        table.insert(v7, stringFormat("%s %s why=%s src=%s %s", a9, a10, a11, a12, v15))
    end
end

local function num(a17)
    --[[
      name: num
      line: 85
    ]]
    if a17 < 0 then
        return "-"
    end
    if a17 == 0 then
        return "0"
    end
    if a17 < 5 then
        return "1+"
    end
    if a17 < 10 then
        return "5+"
    end
    if a17 < 20 then
        return "10+"
    end

    return "20+"
end

local function rel(a19, a20)
    --[[
      name: rel
      line: 100
    ]]
    if a19 <= 0 then
        return "0"
    end
    if a20 <= a19 then
        return "all"
    end
    if a20 <= a19 * 2 then
        return "most"
    end

    return "some"
end

local function cnt(a22)
    --[[
      name: cnt
      line: 111
    ]]
    if 2 <= a22 then
        return "2+"
    end

    return (tostring(a22))
end

local function b(a24)
    --[[
      name: b
      line: 115
    ]]
    if a24 then
        return "1"
    end

    return "0"
end

function v3.Evaluate(a25)
    --[[
      name: Evaluate
      line: 122
    ]]
    if not a25.parented then
        return "unparented"
    end
    if a25.parts == 0 then
        return "noparts"
    end

    local v26 = a25.far * 2

    if a25.parts <= v26 then
        return "far"
    end

    local v27 = a25.loose * 2

    if a25.parts <= v27 then
        return "loose"
    end
    if not (a25.vis * 3 < a25.parts) then
        return nil
    end

    if 0 < a25.tr then
        local tr = a25.tr

        if a25.ltm <= tr then
            return "tr"
        end
    end

    if 0 < a25.ltm then
        return "ltm"
    end

    return "vis"
end

local function kindOf(text: string)
    --[[
      name: kindOf
      line: 142
    ]]
    if string.sub(text, 1, 1) ~= "p" then
        return "B"
    end

    return "A"
end

local function tally(a32, text: string, a34)
    --[[
      name: tally
      line: 147
    ]]
    local v35

    if string.sub(text, 1, 1) ~= "p" then
        v35 = "B"
    else
        v35 = "A"
    end

    if a34 then
        if v35 == "A" then
            a32.hA += 1
            return
        end

        a32.hB += 1

        return
    end

    if v35 == "A" then
        a32.okA += 1
        return
    end

    a32.okB += 1
end

function v3.Begin(a36)
    --[[
      name: Begin
      line: 165
      upvalues:
        v7 (copy, index: 1)
        v4 (ref,  index: 2)
        players (copy, index: 3)
    ]]
    local ids = {}

    for v38, fighter in a36.fighters do
        ids[v38] = fighter.id
    end

    local fp = false
    local fighter = a36.fighters[a36.focus]

    if fighter and fighter.flags then
        for flagKey = 1, fighter.n do
            if bit32.band(fighter.flags[flagKey], 96) == 96 then
                fp = true
                break
            end
        end
    end

    table.clear(v7)
    v4 = {failure = nil, counts = nil, early = false, emitted = false, frames = 0, onFrames = 0, aimBest = math.huge, ids = ids, focus = a36.focus, me = "p" .. tostring(players.LocalPlayer.UserId), fp = fp, build = {hA = 0, hB = 0, okA = 0, okB = 0}, srcs = {}, shots = {}}
end

local function note(a44, at, index, why, src, st, live, fix)
    --[[
      name: note
      line: 200
    ]]
    local k

    if a44.failure then
        return
    end

    local text = a44.ids[index] or "?"
    local failure = {index = index, why = why}

    if string.sub(text, 1, 1) ~= "p" then
        k = "B"
    else
        k = "A"
    end

    failure.k = k
    failure.src = src
    failure.at = at
    failure.self = text == a44.me
    failure.focus = index == a44.focus
    failure.st = st
    failure.live = live
    failure.fix = fix
    a44.failure = failure
end

function v3.Built(key, a56, why, a58, st, live, a61, a62)
    --[[
      name: Built
      line: 222
      upvalues:
        v4 (ref,  index: 1)
        detail (copy, index: 2)
        note (copy, index: 3)
    ]]
    local v63 = v4
    if not v63 then
        return
    end

    local text = v63.ids[key] or "?"

    if a56 then
        v63.srcs[a56.src] = (v63.srcs[a56.src] or 0) + 1
    end

    if a62 then
        local failure = v63.failure

        if failure and failure.index == key and failure.at == "build" and a56 and a61 then
            failure.fix = a56.src
        end

        return
    end

    local v66
    local v67
    local v68 = why ~= nil or a56 == nil
    local build = v63.build

    if string.sub(text, 1, 1) ~= "p" then
        v66 = "B"
    else
        v66 = "A"
    end

    if v68 then
        if v66 ~= "A" then
            build.hB += 1
        else
            build.hA += 1
        end
    elseif v66 ~= "A" then
        build.okB += 1
    else
        build.okA += 1
    end

    if v68 then
        detail("build", text, (why or "missing"), (a58 or "none"), st)
    end

    if not v68 then
        return
    end

    if a56 and a61 and why then
        v67 = a56.src
    else
        v67 = why and "failed" or "none"
    end

    if a56 ~= nil or why ~= nil then
        note(v63, "build", key, why, (a58 or "?"), st, live, v67)
    else
        note(v63, "build", key, "missing", "none", nil, live, "none")
    end

    if v63.failure and v63.failure.at == "build" and v63.counts == nil then
        v63.counts = v63.build
    end
end

function v3.Check(at, a71, a72, callback, callback2)
    --[[
      name: Check
      line: 261
      upvalues:
        v4 (ref,  index: 1)
        v3 (copy, index: 2)
        detail (copy, index: 3)
        note (copy, index: 4)
    ]]
    local v75 = v4
    if not v75 then
        return
    end

    if at == "early" then
        v75.early = true
    end

    local counts = {hA = 0, hB = 0, okA = 0, okB = 0}
    local v77 = false

    for v78, fighter in a71.clip.fighters do
        local puppet = a71.puppets[v78]

        if 0 < fighter.n and not puppet then
            callback2(v78)
        end

        local state = a71.states[v78]

        if 0 < fighter.n then
            if not state then
                continue
            end
            if not state.present then
                continue
            end

            if v78 ~= a71.focus or not a72 then
                local v82
                local v83
                local v84 = nil

                if puppet then
                    v84 = callback(puppet)
                    v82 = v3.Evaluate(v84)

                    if not v82
                        and puppet.alive
                        and 3 < (puppet.root.Position - state.cf.Position).Magnitude
                    then
                        v82 = "drift"
                    end
                else
                    v82 = "missing"
                end

                local id = fighter.id
                local v86 = v82 ~= nil

                if string.sub(id, 1, 1) == "p" then
                    v83 = "A"
                else
                    v83 = "B"
                end

                if v86 then
                    if v83 == "A" then
                        counts.hA += 1
                    else
                        counts.hB += 1
                    end
                elseif v83 == "A" then
                    counts.okA += 1
                else
                    counts.okB += 1
                end

                if v82 then
                    local id2 = fighter.id
                    local v88 = not puppet and "none" or puppet.src
                    detail(at, id2, v82, v88, v84)
                end

                if v82 then
                    if v75.failure then
                        continue
                    end

                    local v89 = not puppet and "none" or puppet.src
                    local v90 = not puppet and -1 or puppet.liveParts
                    note(v75, at, v78, v82, v89, v84, v90, "none")
                    v77 = true
                end
            end
        end
    end

    if v77 then
        v75.counts = counts
    end
end

function v3.Frame(a91, a92)
    --[[
      name: Frame
      line: 306
      upvalues:
        v4 (ref, index: 1)
    ]]
    local v93 = v4
    if not v93 then
        return
    end

    v93.frames += 1
    local cFrame = a92.CFrame
    local lookVector = cFrame.LookVector
    local position = cFrame.Position
    local team = a91.clip.fighters[a91.focus].team
    local v98 = false

    for stateKey, fighter in a91.clip.fighters do
        local state = a91.states[stateKey]

        if stateKey ~= a91.focus then
            if not state then
                continue
            end
            if not state.present then
                continue
            end

            local v102 = state.cf.Position + Vector3.new(0, 1, 0)
            local v103, v104 = a92:WorldToViewportPoint(v102)

            if v104 and 0 < v103.Z then
                v98 = true
            end

            if fighter.team ~= team and bit32.btest(state.flags, 1) then
                local v105 = v102 - position

                if 1 < v105.Magnitude then
                    local aimBest = math.deg((math.acos((math.clamp(lookVector:Dot(v105.Unit), -1, 1)))))

                    if aimBest < v93.aimBest then
                        v93.aimBest = aimBest
                    end
                end
            end
        end
    end

    if v98 then
        v93.onFrames += 1
    end
end

function v3.Shot(a107, a108)
    --[[
      name: Shot
      line: 342
      upvalues:
        v4 (ref, index: 1)
    ]]
    local v109 = v4

    if not v109 or 32 <= #v109.shots then
        return
    end

    local cFrame = a107.CFrame
    local v111 = a108 - cFrame.Position

    if v111.Magnitude < 2 then
        return
    end

    table.insert(v109.shots, (math.deg((math.acos((math.clamp(cFrame.LookVector:Dot(v111.Unit), -1, 1)))))))
end

local function median(a113)
    --[[
      name: median
      line: 355
    ]]
    if #a113 == 0 then
        return nil
    end

    local values = table.clone(a113)
    table.sort(values)

    return values[math.ceil(#values / 2)]
end

local function view(a116)
    --[[
      name: view
      line: 364
    ]]
    local value
    local shots = a116.shots

    if #shots ~= 0 then
        local values = table.clone(shots)
        table.sort(values)
        value = values[math.ceil(#values / 2)]
    else
        value = nil
    end

    local v120 = value ~= nil and (value < 2 and "<2" or value < 5 and "<5" or value < 15 and "<15" or "15+") or "-"
    local aimBest = a116.aimBest
    local v122 = aimBest ~= math.huge
        and (aimBest < 5 and "<5" or aimBest < 15 and "<15" or aimBest < 45 and "<45" or "45+")
        or "-"
    local v123 = "-"

    if 0 < a116.frames then
        local v124 = a116.onFrames / a116.frames
        v123 = a116.onFrames ~= 0 and (v124 < 0.25 and "<25" or v124 < 0.75 and "<75" or "75+") or "0"
    end

    return string.format("shot=%s aim=%s onscr=%s", v120, v122, v123)
end

function v3.Flush()
    --[[
      name: Flush
      line: 380
      upvalues:
        v4 (ref,  index: 1)
        view (copy, index: 2)
        runService (copy, index: 3)
        formattedText (ref,  index: 4)
    ]]
    local v125 = v4

    if not v125 or v125.emitted then
        return
    end

    local value
    v125.emitted = true
    local shots = v125.shots

    if #shots ~= 0 then
        local values = table.clone(shots)
        table.sort(values)
        value = values[math.ceil(#values / 2)]
    else
        value = nil
    end

    if not v125.failure and value and 2 <= #v125.shots and 15 <= value then
        local k
        local text = v125.ids[v125.focus] or "?"
        local failure = {why = "aim", src = "-", at = "clip", focus = true, st = nil, live = -1, fix = "none", index = v125.focus}

        if string.sub(text, 1, 1) ~= "p" then
            k = "B"
        else
            k = "A"
        end

        failure.k = k
        failure.self = text == v125.me
        v125.failure = failure
    end

    local failure = v125.failure
    local formattedText2 = nil

    if failure then
        local v134
        local st = failure.st
        local v136 = v125.counts or v125.build
        local stringFormat = string.format
        local why = failure.why
        local k = failure.k
        local src = failure.src
        local at = failure.at
        local v142 = failure.self and "1" or "0"
        local v143 = failure.focus and "1" or "0"
        local v144 = v125.fp and "1" or "0"

        if st then
            local parts = st.parts
            v134 = parts < 0 and "-"
                or parts ~= 0 and (parts < 5 and "1+" or parts < 10 and "5+" or parts < 20 and "10+" or "20+")
                or "0"
        else
            v134 = "-"
        end

        local v146
        local v147
        local v148
        local v149
        local v150
        local v151
        local text, v153
        local live = failure.live
        local v155 = live < 0 and "-"
            or live ~= 0 and (live < 5 and "1+" or live < 10 and "5+" or live < 20 and "10+" or "20+")
            or "0"

        if st then
            local vis = st.vis
            local parts = st.parts
            v146 = vis <= 0 and "0" or parts <= vis and "all" or parts <= vis * 2 and "most" or "some"
        else
            v146 = "-"
        end

        if st then
            local tr = st.tr
            local parts = st.parts
            v147 = tr <= 0 and "0" or parts <= tr and "all" or parts <= tr * 2 and "most" or "some"
        else
            v147 = "-"
        end

        if st then
            local ltm = st.ltm
            local parts = st.parts
            v148 = ltm <= 0 and "0" or parts <= ltm and "all" or parts <= ltm * 2 and "most" or "some"
        else
            v148 = "-"
        end

        if st then
            local far = st.far
            local parts = st.parts
            v149 = far <= 0 and "0" or parts <= far and "all" or parts <= far * 2 and "most" or "some"
        else
            v149 = "-"
        end

        if st then
            local loose = st.loose
            local parts = st.parts
            v150 = loose <= 0 and "0" or parts <= loose and "all" or parts <= loose * 2 and "most" or "some"
        else
            v150 = "-"
        end

        local v166 = st and (st.parented and "1" or "0") or "-"

        if st then
            local wrap = st.wrap
            v151 = wrap < 0 and "-"
                or wrap ~= 0 and (wrap < 5 and "1+" or wrap < 10 and "5+" or wrap < 20 and "10+" or "20+")
                or "0"
        else
            v151 = "-"
        end

        local fix = failure.fix
        local hA = v136.hA
        local v170 = 2 <= hA and "2+" or tostring(hA)
        local hB = v136.hB
        local v172 = 2 <= hB and "2+" or tostring(hB)
        local okA = v136.okA
        local v174 = 2 <= okA and "2+" or tostring(okA)
        local okB = v136.okB

        if not (2 <= okB) then
            text = tostring(okB)
            v153 = v125
        else
            text = "2+"
            v153 = v125
        end

        formattedText2 = stringFormat("[ReplayDiag] hidden why=%s k=%s src=%s at=%s self=%s foc=%s fp=%s parts=%s live=%s vis=%s tr=%s ltm=%s far=%s loose=%s par=%s wrap=%s fix=%s hA=%s hB=%s okA=%s okB=%s %s", why, k, src, at, v142, v143, v144, v134, v155, v146, v147, v148, v149, v150, v166, v151, fix, v170, v172, v174, text, view(v153))
        warn(formattedText2)
    elseif v125.early
        and (math.random() < 0.1 or runService:IsStudio() and workspace:GetAttribute("ReplayDiagAlways") == true)
    then
        local v176
        local build = v125.build
        local parts = {}

        for v179 in v125.srcs do
            table.insert(parts, v179)
        end

        table.sort(parts)
        local stringFormat = string.format
        local v181 = v125.fp and "1" or "0"

        if string.sub(v125.ids[v125.focus] or "?", 1, 1) ~= "p" then
            v176 = "B"
        else
            v176 = "A"
        end

        local v182 = v176 == "A" and "1" or "0"
        local v183 = v125.ids[v125.focus] == v125.me and "1" or "0"
        local v184 = build.okA + build.hA
        local v185 = 2 <= v184 and "2+" or tostring(v184)
        local v186 = build.okB + build.hB
        local v187 = 2 <= v186 and "2+" or tostring(v186)
        local v188 = not (0 < #parts) and "-" or table.concat(parts, "+")
        formattedText2 = stringFormat("[ReplayDiag] ok fp=%s focA=%s mine=%s A=%s B=%s src=%s %s", v181, v182, v183, v185, v187, v188, view(v125))
        warn(formattedText2)
    end

    formattedText = formattedText2
end

function v3.End()
    --[[
      name: End
      line: 445
      upvalues:
        v3 (copy, index: 1)
        v4 (ref,  index: 2)
    ]]
    v3.Flush()
    v4 = nil
end

function v3.LastLine()
    --[[
      name: LastLine
      line: 452
      upvalues:
        formattedText (ref,  index: 1)
        v7 (copy, index: 2)
    ]]
    return formattedText, v7
end

return v3