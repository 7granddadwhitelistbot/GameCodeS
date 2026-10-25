local Workspace_upv_1 = game:GetService("Workspace")
local tbl_upv_1 = {}
local tbl_upv_2 = {1, 0.5, 0}
tbl_upv_1.RADIUS = 0.35
tbl_upv_1.THIN = 1.6
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Exclude
u1.IgnoreWater = true
local u2 = nil
local u3 = true
local tbl_upv_3 = {holds = 0, clamps = 0, pullIns = 0, casts = 0, swaps = 0}
function tbl_upv_1.Classify(a1)
    --[[
      name: Classify
      line: 73
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    if a1 ~= Workspace_upv_1.Terrain then
        if not (a1.Transparency > 0.6) and a1.CanCollide then
            local Size_1 = a1.Size
            local X_1 = Size_1.X
            local Y_1 = Size_1.Y
            if math.max(math.min(X_1, Y_1), math.min(math.max(X_1, Y_1), Size_1.Z)) < 1.6 then
                return 2
            end
            return 1
        end
        return 0
    end
    return 1
end
function tbl_upv_1.IgnoreChanged()
    --[[
      name: IgnoreChanged
      line: 91
      upvalues:
        u3 (ref, index: 1)
    ]]
    u3 = true
end
local function sweep(a1, a2, a3, a4)
    --[[
      name: sweep
      line: 97
      upvalues:
        u2 (ref,  index: 1)
        u3 (ref,  index: 2)
        u1 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
        Workspace_upv_1 (copy, index: 5)
        tbl_upv_1 (copy, index: 6)
    ]]
    local v1 = a2 - a1
    local Magnitude_1 = v1.Magnitude
    if Magnitude_1 < 0.001 or Magnitude_1 ~= Magnitude_1 or Magnitude_1 == math.huge then
        return 0, nil
    end
    local v2 = math.min(Magnitude_1, 1000)
    if a3 ~= u2 then
        u2 = a3
        u3 = true
    end
    if u3 then
        u1.FilterDescendantsInstances = a3
        u3 = false
    end
    for _ = 1, 6 do
        tbl_upv_3.casts = tbl_upv_3.casts + 1
        v1 = Workspace_upv_1:Spherecast(a1, a4, v1 / Magnitude_1 * v2, u1)
        if not v1 then
            return Magnitude_1, nil
        end
        local Instance_1 = v1.Instance
        if not (Instance_1:IsA("BasePart")) or tbl_upv_1.Classify(Instance_1) == 1 then
            return math.max(0, v1.Distance), v1.Position
        end
        u1:AddToFilter(Instance_1)
        u3 = true
    end
    return Magnitude_1, nil
end
function tbl_upv_1.Cast(a1, a2, a3, a4)
    --[[
      name: Cast
      line: 139
      upvalues:
        sweep (copy, index: 1)
    ]]
    return (sweep(a1, a2, a3, a4 or 0.35))
end
local function usable(a1, a2)
    --[[
      name: usable
      line: 148
    ]]
    if a2 - 0.01 <= a1 then
        return a2
    end
    return (math.max(0, a1 - 0.12))
end
local function smoothstep(a1)
    --[[
      name: smoothstep
      line: 152
    ]]
    local v3 = math.clamp(a1, 0, 1)
    return (v3 * v3) * (3 - (v3 * 2))
end
local u4 = 0
local function approach(a1, a2, a3, a4, a5)
    --[[
      name: approach
      line: 187
    ]]
    local v4 = a1 - a3
    local v5 = math.exp(-a4 * a5)
    local v6 = (a2 + (a4 * v4)) * a5
    return a3 + ((v4 + v6) * v5), (a2 - (a4 * v6)) * v5
end
local function newLen()
    --[[
      name: newLen
      line: 195
    ]]
    return {vel = 0}
end
local function follow(a1, a2, a3, a4, a5, a6, a7, a8)
    --[[
      name: follow
      line: 202
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u4 (ref,  index: 2)
    ]]
    local cur_1 = a1.cur
    if cur_1 ~= nil then
        local v7 = a1.vel
        local v8
        if a3 < cur_1 then
            if a8 and a3 < cur_1 - a7 and v7 >= 0 then
                tbl_upv_3.pullIns = tbl_upv_3.pullIns + 1
            end
            cur_1 = cur_1 - a3
            local v9 = math.exp(a2 * -42)
            local v10 = (v7 + (cur_1 * 42)) * a2
            v8 = a3 + ((cur_1 + v10) * v9)
            v7 = (v7 - (v10 * 42)) * v9
            a1.clearSince = nil
        elseif a3 <= cur_1 + a7 then
            local v11 = cur_1 - a3
            local v12 = math.exp(-a6 * a2)
            local v13 = (v7 + (a6 * v11)) * a2
            v8 = a3 + ((v11 + v13) * v12)
            v7 = (v7 - (a6 * v13)) * v12
        else
            if a1.clearSince == nil then
                a1.clearSince = u4
                if a8 then
                    tbl_upv_3.holds = tbl_upv_3.holds + 1
                end
            end
            if a5 <= u4 - a1.clearSince then
                local v14 = cur_1 - a3
                local v15 = math.exp(-a6 * a2)
                local v16 = (v7 + (a6 * v14)) * a2
                v8 = a3 + ((v14 + v16) * v15)
                v7 = (v7 - (a6 * v16)) * v15
            else
                local v17 = cur_1 - cur_1
                local v18 = math.exp(a2 * -42)
                local v19 = (v7 + (v17 * 42)) * a2
                v8 = cur_1 + ((v17 + v19) * v18)
                v7 = (v7 - (v19 * 42)) * v18
            end
        end
        if a4 < v8 then
            if a8 and v8 - a4 > 0.02 then
                tbl_upv_3.clamps = tbl_upv_3.clamps + 1
            end
            v8, v7 = a4, math.min(v7, 0)
        end
        if v8 < 0 then
            v8, v7 = 0, 0
        end
        a1.cur = v8
        a1.vel = v7
        return v8
    end
    a1.cur = a3
    a1.vel = 0
    a1.clearSince = nil
    return a3
end
local u5 = {vel = 0}
local u6 = 0
local u7 = 1
local u8 = {vel = 0}
local u9 = {vel = 0}
local u10 = 0
local u11 = false
local u12 = -math.huge
local u13 = -math.huge
local u14 = nil
local u15 = nil
local u16 = Vector3.new(0, 0, 0)
local u17 = Vector3.new(0, 0, 0)
local tbl_upv_4 = nil
function tbl_upv_1.Reset()
    --[[
      name: Reset
      line: 263
      upvalues:
        u5 (ref, index: 1)
        u8 (ref, index: 2)
        u9 (ref, index: 3)
        u6 (ref, index: 4)
        u7 (ref, index: 5)
        u10 (ref, index: 6)
        u11 (ref, index: 7)
        u12 (ref, index: 8)
        u13 (ref, index: 9)
        u14 (ref, index: 10)
        u15 (ref, index: 11)
        u16 (ref, index: 12)
        u17 (ref, index: 13)
    ]]
    local tbl_5 = {vel = 0}
    local tbl_6 = {vel = 0}
    local tbl_7 = {vel = 0}
    u5 = tbl_5
    u8 = tbl_6
    u9 = tbl_7
    u6 = 0
    u7 = 1
    u10 = 0
    u11 = false
    u12 = -math.huge
    u13 = -math.huge
    u14 = nil
    u15 = nil
    u16 = Vector3.new(0, 0, 0)
    u17 = Vector3.new(0, 0, 0)
end
function tbl_upv_1.Shown()
    --[[
      name: Shown
      line: 272
      upvalues:
        u10 (ref, index: 1)
    ]]
    return u10
end
function tbl_upv_1.ManualSwap()
    --[[
      name: ManualSwap
      line: 278
      upvalues:
        u11 (ref, index: 1)
        u13 (ref, index: 2)
        u4 (ref, index: 3)
    ]]
    u11 = false
    u13 = u4
end
function tbl_upv_1.Side(a1, a2, a3, a4, a5)
    --[[
      name: Side
      line: 285
      upvalues:
        u4 (ref,  index: 1)
        u12 (ref,  index: 2)
        u13 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        u11 (ref,  index: 5)
        tbl_upv_3 (copy, index: 6)
    ]]
    if u4 - u12 >= 0.8 then
        local v20 = nil
        if u4 - u13 >= 1.5 then
            v20 = tbl_upv_1.Cast(a1, a1 + (a2 * (a3 * a4)), a5)
            if u11 then
                if a3 * 0.75 < v20 or tbl_upv_1.Cast(a1, a1 - (a2 * (a3 * a4)), a5) < v20 + 0.2 then
                    u11 = false
                    u12 = u4
                    tbl_upv_3.swaps = tbl_upv_3.swaps + 1
                end
            elseif v20 < a3 * 0.45 and v20 + 0.8 < tbl_upv_1.Cast(a1, a1 - (a2 * (a3 * a4)), a5) then
                u11 = true
                u12 = u4
                tbl_upv_3.swaps = tbl_upv_3.swaps + 1
            end
        end
    end
    if u11 then
        return -a4
    end
    return a4
end
local function softOf(a1, a2, a3, a4)
    --[[
      name: softOf
      line: 162
      upvalues:
        sweep (copy, index: 1)
    ]]
    local v21 = a2 - a1
    local Magnitude_2 = v21.Magnitude
    if Magnitude_2 < 0.001 then
        return a3
    end
    local _, v22 = sweep(a1, a2, a4, 1.3)
    if not v22 then
        return a3
    end
    local v23 = v21 / Magnitude_2
    local v24 = v22 - a1
    local v25 = v24:Dot(v23)
    local Magnitude_3 = (v24 - (v23 * v25)).Magnitude
    local v26 = math.clamp((1.3 - Magnitude_3) / 0.9500000000000001, 0, 1)
    return (math.min(a3, Magnitude_2 + ((math.clamp((v25 - math.sqrt(math.max(0.12249999999999998 - (Magnitude_3 * Magnitude_3), 0))) - 0.12, 0, Magnitude_2) - Magnitude_2) * ((v26 * v26) * (3 - (v26 * 2))))))
end
local function hardParts(a1, a2, a3, a4, a5, a6)
    --[[
      name: hardParts
      line: 312
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v27 = a1 + a2 * a5
    local v28 = v27 - a3 * a4
    local Magnitude_4 = (v28 - a1).Magnitude
    if not (Magnitude_4 < 0.001) and not (a4 < 0.001) then
        local v29 = tbl_upv_1.Cast(a1, v28, a6)
        local v30
        if Magnitude_4 - 0.01 <= v29 then
            v30 = Magnitude_4
        else
            v30 = math.max(0, v29 - 0.12)
        end
        local v31 = v30 / Magnitude_4
        local v32 = tbl_upv_1.Cast(v27, v28, a6)
        if a4 - 0.01 <= v32 then
            v29 = a4
        else
            v29 = math.max(0, v32 - 0.12)
        end
        return v31, v29 / a4
    end
    return 1, 1
end
function tbl_upv_1.Frame(a1, a2, a3, a4, a5, a6, a7, a8, a9)
    --[[
      name: Frame
      line: 326
      upvalues:
        u4 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        u9 (ref,  index: 3)
        u14 (ref,  index: 4)
        u15 (ref,  index: 5)
        u16 (ref,  index: 6)
        u17 (ref,  index: 7)
        u6 (ref,  index: 8)
        u5 (ref,  index: 9)
        u7 (ref,  index: 10)
        tbl_upv_2 (copy, index: 11)
        hardParts (copy, index: 12)
        follow (copy, index: 13)
        u10 (ref,  index: 14)
        softOf (copy, index: 15)
        u8 (ref,  index: 16)
        tbl_upv_4 (ref,  index: 17)
        u11 (ref,  index: 18)
    ]]
    u4 = u4 + a1
    local v33 = a3 - a2
    local Magnitude_5 = v33.Magnitude
    local v34 = 0
    local v35, v36, v37, v38, v39 = nil, nil, nil, nil, nil
    if Magnitude_5 > 0.001 then
        local v40 = v33 / Magnitude_5
        v37 = tbl_upv_1.Cast(a2, a3 + v33 / Magnitude_5 * 1, a8)
        v38 = Magnitude_5 + 1
        local v41
        if v38 - 0.01 <= v37 then
            v35, v41 = Magnitude_5, v38
        else
            v35, v41 = Magnitude_5, math.max(0, v37 - 0.12)
        end
        local v42 = math.max(0, v35 - v41)
        local v43 = (((Magnitude_5 + 1) - 0.01 <= v37) and 0) or (math.clamp(v35 - (v37 - 1), 0, math.max(0, v35 - 0.8)))
        local v44 = math.max(v43, v42)
        local v45 = u9.cur or v44
        local vel_1 = u9.vel
        local v46 = (((u9.cur or v44) < v44) and 42) or 12
        local v47 = v45 - v44
        local v48 = math.exp(-v46 * a1)
        local v49 = (vel_1 + (v46 * v47)) * a1
        v39 = v44 + (v47 + v49) * v48
        local v50 = (vel_1 - (v46 * v49)) * v48
        if v39 < v42 then
            v39, v50 = v42, math.max(v50, 0)
        end
        u9.cur = v39
        u9.vel = v50
        v36 = a3 - v40 * v39
    else
        v36, v35 = a3, Magnitude_5
    end
    if u14 and u15 and a1 > 0 and (v36 - u14).Magnitude < 8 then
        local v51 = 1 - math.exp(a1 * -25)
        u16 = u16 + ((((v36 - u14) / a1) - u16) * v51)
        u17 = u17 + ((((a5 - u15) / a1) - u17) * v51)
    else
        u16 = Vector3.new(0, 0, 0)
        u17 = Vector3.new(0, 0, 0)
    end
    u14 = v36
    u15 = a5
    local v52 = u17 * 0.18
    local v53 = Vector3.new(u16.X, 0, u16.Z) * 0.18
    local v54 = (v52.Magnitude * a7) + v53.Magnitude > 0.25
    local v55, v56, v57, v58 = nil, nil, nil, nil
    if v54 then
        v39 = (a5 + v52).Unit
        v55 = Vector3.new(-v39.Z, 0, v39.X)
        if v55.Magnitude > 0.001 then
            v56 = v55.Unit
        else
            v56 = a4
        end
        v58 = v36 + v53
        if v53.Magnitude > 0.25 then
            local v59 = tbl_upv_1.Cast(v58, v58 + Vector3.new(0, 1, 0), a8)
            v58 = ((v59 < 0.99) and (v58 - Vector3.new(0, 1, 0) * math.min(1 - v59, math.max(0, (v35 - 0.8) - v34)))) or v58
        end
    else
        v56, v58, v57 = a4, v36, a5
    end
    local v60 = math.abs(a6)
    v35 = ((a6 < 0) and -1) or 1
    local v61 = a4 * v35
    local v62 = v56 * v35
    local v63 = math.max(a9 or v60, v60)
    if v35 ~= u6 then
        u5 = {vel = 0}
        u6 = v35
        u7 = 1
    end
    local v64 = 0
    local v65 = 0
    local v66 = -1
    local v67 = 1
    local v68 = 1
    local v69 = 1
    local v70 = 1
    local v71 = nil
    if v63 > 0.001 then
        v71 = tbl_upv_1.Cast(v36, v36 + (v61 * v63), a8)
        local v72
        if v63 - 0.01 <= v71 then
            v72 = v63
        else
            v72 = math.max(0, v71 - 0.12)
        end
        local v73 = nil
        if v53.Magnitude > 0.25 then
            v73 = tbl_upv_1.Cast(v58, v58 + v62 * v63, a8)
            local v74
            if v63 - 0.01 <= v73 then
                v74 = v63
            else
                v74 = math.max(0, v73 - 0.12)
            end
            v71 = math.min(v72, v74)
        else
            v71 = v72
        end
        if v72 > 0.3 then
            v66 = v72 * tbl_upv_2[u7]
            local v75, v76
            v75, v76 = hardParts(v36, v61, a5, a7, v66, a8)
            if v54 then
                local v77, v78 = hardParts(v58, v62, v57, a7, v66, a8)
                v69, v70 = v77, v78
            end
            if math.min(v75, v76, v69, v70) < 0.9 or u7 > 1 then
                v75 = -math.huge
                v76 = u7
                local v79 = nil
                for key_1, value_1 in tbl_upv_2 do
                    v79 = math.min(v75, v76, v69, v70)
                    if key_1 ~= u7 then
                        local v80, v81 = hardParts(v36, v61, a5, a7, v72 * value_1, a8)
                        v79 = math.min(v80, v81)
                        if v54 then
                            local v82, v83 = hardParts(v58, v62, v57, a7, v72 * value_1, a8)
                            v79 = math.min(v79, v82, v83)
                        end
                    end
                    local v82 = ((key_1 ~= u7) and 0) or 0.05
                    local v84 = v79 - (0.2 * (1 - value_1)) + v82
                    if v75 < v84 then
                        v75, v76 = v84, key_1
                    end
                end
                if v76 ~= u7 then
                    v66 = -1
                    u7 = v76
                end
                v67, v68 = v75, v76
            else
                v67, v68 = v75, v76
            end
        else
            u7 = 1
        end
        v65 = follow(u5, a1, math.min(v71, v72 * tbl_upv_2[u7]), v72, 0.05, 16, 0.02, false)
        v64 = math.min(v60, v65)
    end
    u10 = v64 * v35
    local v85 = v36 + v61 * v64
    local v86 = v85 - a5 * a7
    local v87 = v86 - v36
    local Magnitude_6 = v87.Magnitude
    if not (Magnitude_6 < 0.001) and not (a7 < 0.001) then
        v35 = math.abs(v64 - v66) < 0.01
        if not v35 then
            local v88, v89 = hardParts(v36, v61, a5, a7, v64, a8)
            v67, v68 = v88, v89
        end
        v66 = math.min(v67, v68)
        v55 = math.min(softOf(v36, v86, v67 * Magnitude_6, a8) / Magnitude_6, softOf(v85, v86, v68 * a7, a8) / a7)
        if v54 then
            if not (v35) then
                v68 = v58 + (v62 * v64) - v57 * a7
                v67 = (v68 - v58).Magnitude
                local v90 = nil
                if v67 > 0.001 then
                    v90 = tbl_upv_1.Cast(v58, v68, a8)
                    local v91
                    if v67 - 0.01 <= v90 then
                        v91 = v67
                    else
                        v91 = math.max(0, v90 - 0.12)
                    end
                    v69 = v91 / v67
                else
                    v69 = 1
                end
            end
            v55 = math.min(v55, v69)
        end
        local v92 = follow(u8, a1, math.min(v55, v66), v66, 0.12, 10, 0.01, true)
        local v93 = v36 + v87 * v92
        if tbl_upv_4 then
            local v94 = tbl_upv_4
            local tbl_8 = {}
            local v95 = ((v66 < 1) and 1) or 0
            local v96 = (u11 and 1) or 0
            tbl_8[1], tbl_8[2], tbl_8[3], tbl_8[4], tbl_8[5], tbl_8[6], tbl_8[7], tbl_8[8], tbl_8[9], tbl_8[10] = u4, Magnitude_6, v55 * Magnitude_6, v92 * Magnitude_6, v95, v34, v64, v96, v66 * Magnitude_6, v65
            table.insert(v94, tbl_8)
        end
        return v93, v93 + (a5 * (a7 * v92)), v36
    end
    return v86, v85, v36
end
function tbl_upv_1.Debug(a1)
    --[[
      name: Debug
      line: 472
      upvalues:
        tbl_upv_4 (ref,  index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    if a1 ~= "start" then
        if a1 ~= "stop" then
            return table.clone(tbl_upv_3)
        end
        local v97 = tbl_upv_4
        tbl_upv_4 = nil
        return v97
    end
    tbl_upv_4 = {}
    return true
end
local u18 = RaycastParams.new()
u18.FilterType = Enum.RaycastFilterType.Include
u18.FilterDescendantsInstances = {Workspace_upv_1.Terrain}
u18.IgnoreWater = false
local u19 = 0
local u20 = game:GetService("RunService"):IsStudio() and (Workspace_upv_1:GetAttribute("WaterSimOff") == true)
function tbl_upv_1.AboveWater(a1)
    --[[
      name: AboveWater
      line: 498
      upvalues:
        u20 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        u18 (copy, index: 3)
        u19 (ref,  index: 4)
    ]]
    if u20 then
        return a1
    end
    local Position_1 = a1.Position
    local v98 = Workspace_upv_1:Raycast(Position_1 + Vector3.new(0, 12, 0), Vector3.new(0, -12.399999618530273, 0), u18)
    if v98 and v98.Material == Enum.Material.Water then
        local v99 = v98.Position.Y + 0.4 - Position_1.Y
        if v99 > 0 then
            u19 = u19 + 1
            return a1 + Vector3.new(0, v99, 0)
        end
    end
    return a1
end
function tbl_upv_1.WaterLifts()
    --[[
      name: WaterLifts
      line: 515
      upvalues:
        u19 (ref, index: 1)
    ]]
    return u19
end
return tbl_upv_1