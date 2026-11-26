local workspace = game:GetService("Workspace")
local v2 = {}
local v3 = {1, 0.5, 0}
v2.RADIUS = 0.35
v2.THIN = 1.6
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.IgnoreWater = true
local v5 = nil
local v6 = true
local v7 = {pullIns = 0, holds = 0, swaps = 0, casts = 0, clamps = 0}

function v2.Classify(a8)
    --[[
      name: Classify
      line: 73
      upvalues:
        workspace (copy, index: 1)
    ]]
    if a8 == workspace.Terrain then
        return 1
    end
    if 0.6 < a8.Transparency or not a8.CanCollide then
        return 0
    end

    local size = a8.Size
    local x = size.X
    local y = size.Y
    local z = size.Z

    if not (math.max(math.min(x, y), (math.min(math.max(x, y), z))) < 1.6) then
        return 1
    end

    return 2
end

function v2.IgnoreChanged()
    --[[
      name: IgnoreChanged
      line: 91
      upvalues:
        v6 (ref, index: 1)
    ]]
    v6 = true
end

local function sweep(position, a15, filterDescendantsInstances, radius)
    --[[
      name: sweep
      line: 97
      upvalues:
        v5 (ref,  index: 1)
        v6 (ref,  index: 2)
        params (copy, index: 3)
        v7 (copy, index: 4)
        workspace (copy, index: 5)
        v2 (copy, index: 6)
    ]]
    local v18 = a15 - position
    local magnitude = v18.Magnitude

    if magnitude < 0.001 then
        return 0, nil
    end
    if magnitude ~= magnitude or magnitude == math.huge then
        return 0, nil
    end

    local v20 = math.min(magnitude, 1000)

    if filterDescendantsInstances ~= v5 then
        v5 = filterDescendantsInstances
        v6 = true
    end

    if v6 then
        params.FilterDescendantsInstances = filterDescendantsInstances
        v6 = false
    end

    local v21 = v18 / magnitude
    local raycastResult

    for _ = 1, 6 do
        v7.casts += 1
        raycastResult = workspace:Spherecast(position, radius, v21 * v20, params)

        if not raycastResult then
            return magnitude, nil
        end

        local instance = raycastResult.Instance

        if not instance:IsA("BasePart") or v2.Classify(instance) == 1 then
            return math.max(0, raycastResult.Distance), raycastResult.Position
        end

        params:AddToFilter(instance)
        v6 = true
    end

    return magnitude, nil
end

function v2.Cast(position: Vector3, a26, filterDescendantsInstances, a28)
    --[[
      name: Cast
      line: 139
      upvalues:
        sweep (copy, index: 1)
    ]]
    return (sweep(position, a26, filterDescendantsInstances, (a28 or 0.35)))
end

local function usable(a30, a31)
    --[[
      name: usable
      line: 148
    ]]
    if a31 - 0.01 <= a30 then
        return a31
    end

    return (math.max(0, a30 - 0.12))
end

local function smoothstep(a33: number)
    --[[
      name: smoothstep
      line: 152
    ]]
    local clampedValue = math.clamp(a33, 0, 1)
    return clampedValue * clampedValue * (3 - (clampedValue * 2))
end

local function softOf(position, a37, a38, filterDescendantsInstances)
    --[[
      name: softOf
      line: 162
      upvalues:
        sweep (copy, index: 1)
    ]]
    local v40 = a37 - position
    local magnitude = v40.Magnitude

    if magnitude < 0.001 then
        return a38
    end

    local _, v43 = sweep(position, a37, filterDescendantsInstances, 1.3)
    if not v43 then
        return a38
    end

    local v44 = v40 / magnitude
    local v45 = v43 - position
    local v46 = v45:Dot(v44)
    local magnitude2 = (v45 - (v44 * v46)).Magnitude
    local clampedValue = math.clamp((1.3 - magnitude2) / 0.9500000000000001, 0, 1)
    local v49 = clampedValue * clampedValue * (3 - (clampedValue * 2))

    return (math.min(a38, magnitude + ((math.clamp((v46 - math.sqrt((math.max(0.12249999999999998 - (magnitude2 * magnitude2), 0)))) - 0.12, 0, magnitude) - magnitude) * v49)))
end

local total = 0

local function approach(a52, a53, a54, a55, a56)
    --[[
      name: approach
      line: 187
    ]]
    local v57 = a52 - a54
    local v58 = math.exp(-a55 * a56)
    local v59 = (a53 + (a55 * v57)) * a56

    return a54 + ((v57 + v59) * v58), (a53 - (a55 * v59)) * v58
end

local function newLen()
    --[[
      name: newLen
      line: 195
    ]]
    return {cur = nil, vel = 0, clearSince = nil}
end

local function follow(a62, a63, cur: number, a65: number, a66: number, a67: number, a68: number, a69: boolean)
    --[[
      name: follow
      line: 202
      upvalues:
        v7 (copy, index: 1)
        total (ref,  index: 2)
    ]]
    local cur2, vel2
    local v72 = a62.cur
    if v72 == nil then
        a62.cur = cur
        a62.vel = 0
        a62.clearSince = nil

        return cur
    end

    local v73 = v72
    local vel = a62.vel

    if cur < v73 then
        if a69 and cur < v73 - a68 and 0 <= vel then
            local v75 = v7
            v75.pullIns += 1
        end

        v72 -= cur
        local v76 = math.exp(a63 * -42)
        local v77 = (vel + (v72 * 42)) * a63
        cur2 = cur + (v72 + v77) * v76
        vel2 = (vel - (v77 * 42)) * v76
        a62.clearSince = nil
    elseif cur <= v73 + a68 then
        local v78 = v73 - cur
        local v79 = math.exp(-a67 * a63)
        local v80 = (vel + (a67 * v78)) * a63
        cur2 = cur + (v78 + v80) * v79
        vel2 = (vel - (a67 * v80)) * v79
    else
        if a62.clearSince == nil then
            a62.clearSince = total

            if a69 then
                local v81 = v7
                v81.holds += 1
            end
        end

        if a66 <= total - a62.clearSince then
            local v82 = v72 - cur
            local v83 = math.exp(-a67 * a63)
            local v84 = (vel + (a67 * v82)) * a63
            cur2 = cur + (v82 + v84) * v83
            vel2 = (vel - (a67 * v84)) * v83
        else
            local v85 = v72 - v72
            local v86 = math.exp(a63 * -42)
            local v87 = (vel + (v85 * 42)) * a63
            cur2 = v72 + (v85 + v87) * v86
            vel2 = (vel - (v87 * 42)) * v86
        end
    end

    if a65 < cur2 then
        if a69 and 0.02 < cur2 - a65 then
            local v88 = v7
            v88.clamps += 1
        end

        vel2 = math.min(vel2, 0)
        cur2 = a65
    end

    if cur2 < 0 then
        cur2 = 0
        vel2 = 0
    end

    a62.cur = cur2
    a62.vel = vel2

    return cur2
end

local v89 = {cur = nil, vel = 0, clearSince = nil}
local v90 = 0
local v91 = 1
local v92 = {cur = nil, vel = 0, clearSince = nil}
local v93 = {cur = nil, vel = 0, clearSince = nil}
local v94 = 0
local v95 = false
local v96 = -math.huge
local v97 = -math.huge
local v98 = nil
local v99 = nil
local v100 = Vector3.new(0, 0, 0)
local v101 = Vector3.new(0, 0, 0)
local v102 = nil

function v2.Reset()
    --[[
      name: Reset
      line: 263
      upvalues:
        v89 (ref, index: 1)
        v92 (ref, index: 2)
        v93 (ref, index: 3)
        v90 (ref, index: 4)
        v91 (ref, index: 5)
        v94 (ref, index: 6)
        v95 (ref, index: 7)
        v96 (ref, index: 8)
        v97 (ref, index: 9)
        v98 (ref, index: 10)
        v99 (ref, index: 11)
        v100 (ref, index: 12)
        v101 (ref, index: 13)
    ]]
    local v103 = {cur = nil, vel = 0, clearSince = nil}
    local v104 = {cur = nil, vel = 0, clearSince = nil}
    local v105 = {cur = nil, vel = 0, clearSince = nil}
    v89 = v103
    v92 = v104
    v93 = v105
    v90 = 0
    v91 = 1
    v94 = 0
    v95 = false
    v96 = -math.huge
    v97 = -math.huge
    v98 = nil
    v99 = nil
    v100 = Vector3.new(0, 0, 0)
    v101 = Vector3.new(0, 0, 0)
end

function v2.Shown()
    --[[
      name: Shown
      line: 272
      upvalues:
        v94 (ref, index: 1)
    ]]
    return v94
end

function v2.ManualSwap()
    --[[
      name: ManualSwap
      line: 278
      upvalues:
        v95 (ref, index: 1)
        v97 (ref, index: 2)
        total (ref, index: 3)
    ]]
    v95 = false
    v97 = total
end

function v2.Side(a106, a107, a108, a109, a110)
    --[[
      name: Side
      line: 285
      upvalues:
        total (ref,  index: 1)
        v96 (ref,  index: 2)
        v97 (ref,  index: 3)
        v2 (copy, index: 4)
        v95 (ref,  index: 5)
        v7 (copy, index: 6)
    ]]
    if 0.8 <= total - v96 and 1.5 <= total - v97 then
        local v111 = v2.Cast(a106, a106 + (a107 * (a108 * a109)), a110)

        if v95 then
            if a108 * 0.75 < v111 then
                v95 = false
                v96 = total
                local v112 = v7
                v112.swaps += 1
            elseif v2.Cast(a106, a106 - (a107 * (a108 * a109)), a110) < v111 + 0.2 then
                v95 = false
                v96 = total
                local v113 = v7
                v113.swaps += 1
            end
        elseif v111 < a108 * 0.45 then
            local v114 = v2.Cast(a106, a106 - (a107 * (a108 * a109)), a110)

            if v111 + 0.8 < v114 then
                v95 = true
                v96 = total
                local v115 = v7
                v115.swaps += 1
            end
        end
    end

    if v95 then
        return -a109
    end

    return a109
end

local function hardParts(a117, a118, a119, a120, a121, filterDescendantsInstances)
    --[[
      name: hardParts
      line: 312
      upvalues:
        v2 (copy, index: 1)
    ]]
    local v123 = a117 + a118 * a121
    local v124 = v123 - a119 * a120
    local magnitude = (v124 - a117).Magnitude

    if magnitude < 0.001 or a120 < 0.001 then
        return 1, 1
    end

    local v126 = v2.Cast(a117, v124, filterDescendantsInstances)
    local v127 = if magnitude - 0.01 <= v126 then magnitude else math.max(0, v126 - 0.12)
    local v128 = v127 / magnitude
    local v129 = v2.Cast(v123, v124, filterDescendantsInstances)
    local v130 = if a120 - 0.01 <= v129 then a120 else math.max(0, v129 - 0.12)

    return v128, v130 / a120
end

function v2.Frame(a131, a132, a133, a134, a135, a136: number, a137, filterDescendantsInstances, a139)
    --[[
      name: Frame
      line: 326
      upvalues:
        total (ref,  index: 1)
        v2 (copy, index: 2)
        v93 (ref,  index: 3)
        v98 (ref,  index: 4)
        v99 (ref,  index: 5)
        v100 (ref,  index: 6)
        v101 (ref,  index: 7)
        v90 (ref,  index: 8)
        v89 (ref,  index: 9)
        v91 (ref,  index: 10)
        v3 (copy, index: 11)
        hardParts (copy, index: 12)
        follow (copy, index: 13)
        v94 (ref,  index: 14)
        softOf (copy, index: 15)
        v92 (ref,  index: 16)
        v102 (ref,  index: 17)
        v95 (ref,  index: 18)
    ]]
    local v140
    local v141, v142, v143
    local v144
    total += a131
    local v145 = a133 - a132
    local magnitude = v145.Magnitude
    local v147 = 0

    if not (0.001 < magnitude) then
        v140 = a133
    else
        local clampedValue
        local v149
        local v150 = v145 / magnitude
        local v151 = v2.Cast(a132, a133 + (v150 * 1), filterDescendantsInstances)
        local v152 = magnitude + 1
        local v153 = if v152 - 0.01 <= v151 then v152 else math.max(0, v151 - 0.12)
        local v154 = math.max(0, magnitude - v153)

        if (magnitude + 1) - 0.01 <= v151 then
            clampedValue = 0
        else
            clampedValue = math.clamp(magnitude - (v151 - 1), 0, (math.max(0, magnitude - 0.8)))
        end

        local v155 = math.max(clampedValue, v154)
        local v156 = v93.cur or v155
        local vel = v93.vel

        if (v93.cur or v155) < v155 then
            v149 = 42
        else
            v149 = 12
        end

        local v158 = v156 - v155
        local v159 = math.exp(-v149 * a131)
        local v160 = (vel + (v149 * v158)) * a131
        local cur = v155 + (v158 + v160) * v159
        local vel2 = (vel - (v149 * v160)) * v159

        if cur < v154 then
            vel2 = math.max(vel2, 0)
            cur = v154
        end

        local v163 = v93
        v93.cur = cur
        v163.vel = vel2
        v147 = cur
        v140 = a133 - v150 * v147
    end

    if not v98 or not v99 or not (0 < a131) or not ((v140 - v98).Magnitude < 8) then
        v100 = Vector3.new(0, 0, 0)
        v101 = Vector3.new(0, 0, 0)
    else
        local v164 = 1 - math.exp(a131 * -25)
        v100 += (((v140 - v98) / a131 - v100) * v164)
        v101 += (((a135 - v99) / a131 - v101) * v164)
    end

    v98 = v140
    v99 = a135
    local v165 = v101 * 0.18
    local vector3 = Vector3.new(v100.X, 0, v100.Z) * 0.18
    local v167 = 0.25 < (v165.Magnitude * a137) + vector3.Magnitude

    if v167 then
        v141 = (a135 + v165).Unit
        local vector32 = Vector3.new(-v141.Z, 0, v141.X)

        if not (0.001 < vector32.Magnitude) then
            v143 = a134
        else
            v143 = vector32.Unit
        end

        v142 = v140 + vector3

        if 0.25 < vector3.Magnitude then
            local v169 = v2.Cast(v142, v142 + Vector3.new(0, 1, 0), filterDescendantsInstances)

            if v169 < 0.99 then
                v142 -= Vector3.new(0, 1, 0) * math.min(1 - v169, (math.max(0, (magnitude - 0.8) - v147)))
            end
        end
    else
        v143, v142, v141 = a134, v140, a135
    end

    local absoluteValue = math.abs(a136)

    if not (a136 < 0) then
        v144 = 1
    else
        v144 = -1
    end

    local v171 = a134 * v144
    local v172 = v143 * v144
    local v173 = math.max((a139 or absoluteValue), absoluteValue)

    if v144 ~= v90 then
        v89 = {cur = nil, vel = 0, clearSince = nil}
        v90 = v144
        v91 = 1
    end

    local v174 = 0
    local v175 = 0
    local v176 = -1
    local v177 = 1
    local v178 = 1
    local v179 = 1
    local v180 = 1

    if 0.001 < v173 then
        local v181
        local v182 = v2.Cast(v140, v140 + (v171 * v173), filterDescendantsInstances)
        local v183 = if v173 - 0.01 <= v182 then v173 else math.max(0, v182 - 0.12)

        if not (0.25 < vector3.Magnitude) then
            v181 = v183
        else
            local v184 = v2.Cast(v142, v142 + (v172 * v173), filterDescendantsInstances)
            local v185 = if v173 - 0.01 <= v184 then v173 else math.max(0, v184 - 0.12)
            v181 = math.min(v183, v185)
        end

        if not (0.3 < v183) then
            v91 = 1
        else
            v176 = v183 * v3[v91]
            local v186, v187 = hardParts(v140, v171, a135, a137, v176, filterDescendantsInstances)

            if v167 then
                v179, v180 = hardParts(v142, v172, v141, a137, v176, filterDescendantsInstances)
            end

            if math.min(v186, v187, v179, v180) < 0.9 or 1 < v91 then
                local maxValue = -math.huge
                local v189 = v91

                for v190, v191 in v3 do
                    local v192 = math.min(v186, v187, v179, v180)

                    if v190 ~= v91 then
                        local v193, v194 = hardParts(v140, v171, a135, a137, v183 * v191, filterDescendantsInstances)
                        local v195 = math.min(v193, v194)

                        if v167 then
                            local v196, v197 = hardParts(v142, v172, v141, a137, v183 * v191, filterDescendantsInstances)
                            v192 = math.min(v195, v196, v197)
                        else
                            v192 = v195
                        end
                    end

                    local v198 = v192 - 0.2 * (1 - v191)
                    local v199 = v190 ~= v91 and 0 or 0.05
                    local v200 = v198 + v199

                    if maxValue < v200 then
                        maxValue, v189 = v200, v190
                    end
                end

                if v189 == v91 then
                    v177, v178 = v186, v187
                else
                    v176 = -1
                    v91 = v189
                    v177, v178 = v186, v187
                end
            else
                v177, v178 = v186, v187
            end
        end

        v175 = follow(v89, a131, math.min(v181, v183 * v3[v91]), v183, 0.05, 16, 0.02, false)
        v174 = math.min(absoluteValue, v175)
    end

    v94 = v174 * v144
    local position = v140 + v171 * v174
    local v202 = position - a135 * a137
    local v203 = v202 - v140
    local magnitude2 = v203.Magnitude

    if magnitude2 < 0.001 or a137 < 0.001 then
        return v202, position, v140
    end

    local v205 = math.abs(v174 - v176) < 0.01
    if not v205 then
        v177, v178 = hardParts(v140, v171, a135, a137, v174, filterDescendantsInstances)
    end

    local v206 = math.min(v177, v178)
    local v207 = math.min(softOf(v140, v202, v177 * magnitude2, filterDescendantsInstances) / magnitude2, softOf(position, v202, v178 * a137, filterDescendantsInstances) / a137)

    if v167 then
        if not v205 then
            local v208 = v142
            local v209 = v208 + (v172 * v174) - v141 * a137
            local magnitude3 = (v209 - v208).Magnitude

            if not (0.001 < magnitude3) then
                v179 = 1
            else
                local v211 = v2.Cast(v208, v209, filterDescendantsInstances)
                local v212 = if magnitude3 - 0.01 <= v211 then magnitude3 else math.max(0, v211 - 0.12)
                v179 = v212 / magnitude3
            end
        end

        v207 = math.min(v207, v179)
    end

    local v213 = follow(v92, a131, math.min(v207, v206), v206, 0.12, 10, 0.01, true)
    local v214 = v140 + v203 * v213

    if v102 then
        local v215 = v102
        local v216 = total
        local v217 = v207 * magnitude2
        local v218 = v213 * magnitude2
        local v219 = not (v206 < 1) and 0 or 1
        local v220 = v95 and 1 or 0
        table.insert(v215, {v216, magnitude2, v217, v218, v219, v147, v174, v220, v206 * magnitude2, v175})
    end

    return v214, v214 + (a135 * (a137 * v213)), v140
end

function v2.Debug(a221)
    --[[
      name: Debug
      line: 472
      upvalues:
        v102 (ref,  index: 1)
        v7 (copy, index: 2)
    ]]
    if a221 == "start" then
        v102 = {}
        return true
    end

    if a221 == "stop" then
        local v222 = v102
        v102 = nil

        return v222
    end

    return table.clone(v7)
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = {workspace.Terrain}
raycastParams.IgnoreWater = false
local count = 0
local waterSimOff = game:GetService("RunService"):IsStudio() and workspace:GetAttribute("WaterSimOff") == true

function v2.AboveWater(a226)
    --[[
      name: AboveWater
      line: 498
      upvalues:
        waterSimOff (copy, index: 1)
        workspace (copy, index: 2)
        raycastParams (copy, index: 3)
        count (ref,  index: 4)
    ]]
    if not waterSimOff then
        local position = a226.Position
        local raycastResult = workspace:Raycast(position + Vector3.new(0, 12, 0), Vector3.new(0, -12.399999618530273, 0), raycastParams)

        if raycastResult and raycastResult.Material == Enum.Material.Water then
            local y = raycastResult.Position.Y + 0.4 - position.Y

            if 0 < y then
                count += 1
                return a226 + Vector3.new(0, y, 0)
            end
        end
    end

    return a226
end

function v2.WaterLifts()
    --[[
      name: WaterLifts
      line: 515
      upvalues:
        count (ref, index: 1)
    ]]
    return count
end

return v2