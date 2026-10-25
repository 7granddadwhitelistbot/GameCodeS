local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_1 = game:GetService("Players")
local combat = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local Fighters_upv_1 = require(script.Parent:WaitForChild("Fighters"))
local tbl_upv_1 = {}
tbl_upv_1.TOUCH = {
    ranged = {friction = 0.5, radius = 3, minDeg = 4.5, range = 320, maxDeg = 12, pull = 0.15, trackPitch = 0.3, track = 0.5},
    aimed = {friction = 0.42, radius = 2.6, minDeg = 3.5, range = 420, maxDeg = 10, pull = 0.12, trackPitch = 0.35, track = 0.6},
    scoped = {friction = 0.45, radius = 1.8, minDeg = 1.6, range = 600, maxDeg = 6, pull = 0.06, trackPitch = 0.25, track = 0.45},
    melee = {friction = 0.7, radius = 3.5, minDeg = 8, range = 16, maxDeg = 24, pull = 0.08, trackPitch = 0.15, track = 0.35}
}
tbl_upv_1.GAMEPAD = {
    ranged = {friction = 0.55, radius = 2.6, minDeg = 5, range = 320, maxDeg = 10, pull = 0.1, trackPitch = 0.2, track = 0.35},
    aimed = {friction = 0.5, radius = 2.3, minDeg = 5, range = 420, maxDeg = 9, pull = 0.08, trackPitch = 0.25, track = 0.4},
    scoped = {friction = 0.55, radius = 1.6, minDeg = 5, range = 600, maxDeg = 8, pull = 0.05, trackPitch = 0.15, track = 0.3},
    melee = {friction = 0.6, radius = 3.2, minDeg = 8, range = 16, maxDeg = 22, pull = 0.06, trackPitch = 0.1, track = 0.25}
}
tbl_upv_1.SCOPE_FOV = 42
local tbl_upv_2 = {Fists = true, Axe = true, Sword = true, Spear = true, Club = true, Gauntlets = true, Dagger = true, Scythe = true, Katana = true, Hatchets = true}
local tbl_upv_3 = {Crossbow = true, Musket = true, Sling = true, Blunderbuss = true, Javelin = true, Knives = true, Bow = true, Pistol = true}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = combat:IsStudio()
local u2 = true
local u3 = nil
local u4 = nil
combat = function()
    --[[
      name: combat
      line: 83
      upvalues:
        u4 (ref, index: 1)
    ]]
    if u4 == nil then
        local Combat_upv_1 = script.Parent.Parent:FindFirstChild("Combat")
        local success_1, v1 = pcall(
            function()
                --[[
                  line: 86
                  upvalues:
                    Combat_upv_1 (copy, index: 1)
                ]]
                return require(Combat_upv_1)
            end
        )
        local v2
        if (success_1) and type(v1) == "table" then
            v2 = v1
        else
            v2 = false
        end
        u4 = v2
    end
    if u4 then
        return u4
    end
    return nil
end
local u5 = nil
local u6 = false
local u7 = -math.huge
local u8 = -math.huge
local u9 = -math.huge
local u10 = -math.huge
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = nil
local u15 = nil
local u16 = 0
local u17 = 0
local u18 = Vector2.zero
local u19 = 0
local tbl_upv_4 = {pullDeg = 0, rays = 0, trackDeg = 0, searches = 0, slowed = 0, lastCone = -1, frames = 0, lastDeg = -1}
local u20 = RaycastParams.new()
u20.FilterType = Enum.RaycastFilterType.Exclude
u20.IgnoreWater = true
local function wrap(a1)
    --[[
      name: wrap
      line: 117
    ]]
    return ((a1 + math.pi) % math.tau) - math.pi
end
local function yawOf(a1)
    --[[
      name: yawOf
      line: 121
    ]]
    return (math.atan2(-a1.X, -a1.Z))
end
local function inputKind()
    --[[
      name: inputKind
      line: 125
      upvalues:
        u3 (ref,  index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local v3 = nil
    if u3 == nil then
        v3 = UserInputService_upv_1.PreferredInput
        if v3 ~= Enum.PreferredInput.Touch then
            if v3 ~= Enum.PreferredInput.Gamepad then
                return nil
            end
            return "gamepad"
        end
        return "touch"
    elseif u3 ~= "mouse" then
        return u3
    else
        return nil
    end
end
local function part(a1, a2)
    --[[
      name: part
      line: 150
    ]]
    local v4 = a1:FindFirstChild(a2)
    if v4 and v4:IsA("BasePart") then
        return v4
    end
    return nil
end
local function classify(a1, a2, a3, a4)
    --[[
      name: classify
      line: 156
      upvalues:
        combat (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        u10 (ref,  index: 5)
    ]]
    local v5 = "Fists"
    local v6 = a1:FindFirstChildOfClass("Tool")
    local v7 = nil
    if v6 then
        v7 = v6:GetAttribute("WeaponId")
        local v8 = combat()
        if type(v7) == "string" and v8 then
            if type(v8.Kind) ~= "function" then
                v5 = "?"
            else
                v5 = v8.Kind(v7) or "?"
            end
        else
            v5 = "?"
        end
    end
    if tbl_upv_2[v5] then
        return "melee"
    elseif tbl_upv_3[v5] then
        if a2 then
            if a3 <= tbl_upv_1.SCOPE_FOV then
                return "scoped"
            end
        elseif not (a4) and not (os.clock() - u10 < 0.25) then
            return "ranged"
        end
        return "aimed"
    else
        return nil
    end
end
local function body(a1)
    --[[
      name: body
      line: 191
    ]]
    local v9 = a1:FindFirstChild("HumanoidRootPart")
    local v10 = not (v9) or not (v9:IsA("BasePart")) or v9
    local UpperTorso_1 = a1:FindFirstChild("UpperTorso")
    v9 = not (UpperTorso_1) or not (UpperTorso_1:IsA("BasePart")) or UpperTorso_1
    local v11 = nil
    if not (v9) then
        v11 = a1:FindFirstChild("Torso")
        v9 = not (v11) or not (v11:IsA("BasePart")) or v11
    end
    local Head_1 = a1:FindFirstChild("Head")
    UpperTorso_1 = not (Head_1) or not (Head_1:IsA("BasePart")) or Head_1
    local v12 = v10 or v9
    if not v12 then
        return nil, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), nil
    end
    local Position_1 = v12.Position
    local v13 = (UpperTorso_1 and (UpperTorso_1.Position + Vector3.new(0, 0.4000000059604645, 0))) or (Position_1 + Vector3.new(0, 2.200000047683716, 0))
    return v12, Position_1 - Vector3.new(0, 2.200000047683716, 0), v13, (v9 and (v9.Position + Vector3.new(0, 0.30000001192092896, 0))) or (Position_1 + Vector3.new(0, 0.800000011920929, 0)), v9 or v12
end
local tbl_upv_5 = {cone = 0, capsule = Vector3.new(0, 0, 0), deg = 0, point = Vector3.new(0, 0, 0)}
local function closestOnSegment(a1, a2, a3, a4)
    --[[
      name: closestOnSegment
      line: 177
    ]]
    local v14 = a4 - a3
    local v15 = a3 - a1
    local v16 = v14:Dot(v14)
    local v17 = v14:Dot(a2)
    local v18 = v16 - v17 * v17
    local v19 = 0
    if v18 > 1e-06 then
        v19 = math.clamp((v17 * a2:Dot(v15) - v14:Dot(v15)) / v18, 0, 1)
    end
    return a3 + (v14 * v19)
end
local function sees(a1, a2, a3)
    --[[
      name: sees
      line: 236
      upvalues:
        tbl_upv_4 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        u20 (copy, index: 3)
        combat (copy, index: 4)
    ]]
    tbl_upv_4.rays = tbl_upv_4.rays + 1
    local v20 = Workspace_upv_1:Raycast(a1, a2 - a1, u20)
    if v20 and not (v20.Instance:IsDescendantOf(a3)) then
        return false
    end
    local v21 = combat()
    if v21 and type(v21.SmokeBlocks) == "function" and v21.SmokeBlocks(a1, a2) then
        return false
    end
    return true
end
local tbl_upv_6 = {{s = 0}, {s = 0}, {s = 0}}
local function evaluate(a1, a2, a3, a4, a5)
    --[[
      name: evaluate
      line: 211
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        body (copy, index: 2)
        closestOnSegment (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
    ]]
    local v22 = a1:FindFirstChildOfClass("Humanoid")
    if v22 and not (v22.Health <= 0) and a1:IsDescendantOf(Workspace_upv_1) then
        local v23, v24, v25, v26 = body(a1)
        if v23 and not (a4.range < (v23.Position - a5).Magnitude) then
            local v27 = closestOnSegment(a2, a3, v24, v25)
            local v28 = v27 - a2
            local Magnitude_1 = v28.Magnitude
            if Magnitude_1 < 0.5 then
                return false
            end
            local v29 = math.deg(math.acos(math.clamp(a3:Dot(v28 / Magnitude_1), -1, 1)))
            local v30 = math.clamp(math.deg(math.atan(a4.radius / Magnitude_1)), a4.minDeg, a4.maxDeg)
            tbl_upv_5.deg = v29
            tbl_upv_5.cone = v30
            tbl_upv_5.capsule = v27
            tbl_upv_5.point = closestOnSegment(a2, a3, v23.Position - Vector3.new(0, 0.800000011920929, 0), v26)
            return true
        end
        return false
    end
    return false
end
local function isEnemy(a1, a2)
    --[[
      name: isEnemy
      line: 138
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    if a1 == a2 then
        return false
    end
    local v31 = LocalPlayer_upv_1:GetAttribute("MatchId")
    if type(v31) == "string" and v31 ~= "" then
        local v32 = a1:GetAttribute("Team")
        local v33 = (a1:GetAttribute("MatchId") == v31) and ((v32 ~= nil) and (v32 ~= LocalPlayer_upv_1:GetAttribute("Team")))
        return v33
    end
    return a1:HasTag("TrainingDummy")
end
local function search(a1, a2, a3, a4, a5, a6)
    --[[
      name: search
      line: 252
      upvalues:
        tbl_upv_4 (copy, index: 1)
        isEnemy (copy, index: 2)
        evaluate (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
        u5 (ref,  index: 5)
        tbl_upv_6 (copy, index: 6)
        Fighters_upv_1 (copy, index: 7)
        LocalPlayer_upv_1 (copy, index: 8)
        CollectionService_upv_1 (copy, index: 9)
        u20 (copy, index: 10)
        sees (copy, index: 11)
    ]]
    tbl_upv_4.searches = tbl_upv_4.searches + 1
    local u21 = 0
    local function consider_1(a7)
        --[[
          name: consider
          line: 255
          upvalues:
            isEnemy (copy, index: 1)
            a5 (copy, index: 2)
            evaluate (copy, index: 3)
            a1 (copy, index: 4)
            a2 (copy, index: 5)
            a3 (copy, index: 6)
            a6 (copy, index: 7)
            tbl_upv_5 (copy, index: 8)
            u5 (ref,  index: 9)
            u21 (ref,  index: 10)
            tbl_upv_6 (copy, index: 11)
        ]]
        if not isEnemy(a7, a5) or not evaluate(a7, a1, a2, a3, a6) or tbl_upv_5.cone < tbl_upv_5.deg then
            return
        end
        local v34 = ((a7 ~= u5) and 1) or 0.7
        local v35 = tbl_upv_5.deg / tbl_upv_5.cone * v34
        local v36 = u21 + 1
        if u21 >= 3 then
            if tbl_upv_6[3].s <= v35 then
                return
            end
            v36 = 3
        else
            u21 = u21 + 1
        end
        while v36 > 1 do
            if v35 < tbl_upv_6[v36 - 1].s then
                tbl_upv_6[v36].m = tbl_upv_6[v36 - 1].m
                tbl_upv_6[v36].s = tbl_upv_6[v36 - 1].s
                v36 = v36 - 1
                continue
            else
                break
            end
        end
        tbl_upv_6[v36].m = a7
        tbl_upv_6[v36].s = v35
    end
    for _, value_1 in Fighters_upv_1.List() do
        consider_1(value_1)
    end
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        for _, value_2 in CollectionService_upv_1:GetTagged("TrainingDummy") do
            local v37 = value_2:IsA("Model")
            if v37 then
                consider_1(value_2)
            end
        end
    end
    u20.FilterDescendantsInstances = a4
    local _, v38 = nil, nil
    for n_1 = 1, u21 do
        consider_1 = tbl_upv_6[n_1].m
        local v39 = evaluate(consider_1, a1, a2, a3, a6)
        if not (v39) then
            continue
        end
        if sees(a1, tbl_upv_5.point, consider_1) then
            return consider_1, true
        end
        local Head_2 = consider_1:FindFirstChild("Head")
        if not (Head_2) or not (Head_2:IsA("BasePart")) then
            v38 = nil
            if not (v38) then
                continue
            end
            local v40 = sees(a1, v38.Position, consider_1)
            if not (v40) then
                continue
            end
            return consider_1, false
        end
        v38 = Head_2
        if not (v38) then
            continue
        end
        local v40 = sees(a1, v38.Position, consider_1)
        if not (v40) then
            continue
        end
        return consider_1, false
    end
    return nil, false
end
local function drop()
    --[[
      name: drop
      line: 305
      upvalues:
        u5 (ref,  index: 1)
        u14 (ref,  index: 2)
        u15 (ref,  index: 3)
        tbl_upv_4 (copy, index: 4)
    ]]
    u5 = nil
    u14 = nil
    u15 = nil
    tbl_upv_4.lastDeg = -1
    tbl_upv_4.lastCone = -1
end
local function tuneFor(a1, a2)
    --[[
      name: tuneFor
      line: 312
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 and a2 then
        local v41
        if a1 ~= "gamepad" then
            v41 = tbl_upv_1.TOUCH
        else
            v41 = tbl_upv_1.GAMEPAD
        end
        return v41[a2]
    end
    return nil
end
local function weight(a1, a2, a3, a4)
    --[[
      name: weight
      line: 321
    ]]
    local v42 = math.clamp(((a1 / a2) - a3) / (a4 - a3), 0, 1)
    return 1 - ((v42 * v42) * (3 - (v42 * 2)))
end
function tbl_upv_1.Apply(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    --[[
      name: Apply
      line: 329
      upvalues:
        u16 (ref,  index: 1)
        u17 (ref,  index: 2)
        u9 (ref,  index: 3)
        u10 (ref,  index: 4)
        u8 (ref,  index: 5)
        u5 (ref,  index: 6)
        u14 (ref,  index: 7)
        u15 (ref,  index: 8)
        tbl_upv_4 (copy, index: 9)
        u3 (ref,  index: 10)
        UserInputService_upv_1 (copy, index: 11)
        LocalPlayer_upv_1 (copy, index: 12)
        Workspace_upv_1 (copy, index: 13)
        u2 (ref,  index: 14)
        u7 (ref,  index: 15)
        u13 (ref,  index: 16)
        u11 (ref,  index: 17)
        classify (copy, index: 18)
        u12 (ref,  index: 19)
        tbl_upv_1 (copy, index: 20)
        u6 (ref,  index: 21)
        search (copy, index: 22)
        evaluate (copy, index: 23)
        tbl_upv_5 (copy, index: 24)
        body (copy, index: 25)
    ]]
    local v43 = os.clock()
    local v44
    if u16 == 0 then
        v44 = a2
    else
        local v45 = u17 * a1
        local v46 = math.abs(u17 * a1)
        if math.abs(u16) <= v46 then
            v45 = u16
        end
        u16 = u16 - v45
        v44 = a2 + v45
    end
    local v47 = true
    if a2 == 0 then
        v47 = a3 ~= 0
    end
    if v47 then
        u9 = v43
    end
    if a10 then
        u10 = v43
    end
    local v48 = v43 - u8 > 0.25
    u8 = v43
    if v48 then
        u5 = nil
        u14 = nil
        u15 = nil
        tbl_upv_4.lastDeg = -1
        tbl_upv_4.lastCone = -1
    end
    local v49
    if u3 == nil then
        local _ = UserInputService_upv_1.PreferredInput
        v49 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and "touch" or UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Gamepad and "gamepad" or nil
    elseif u3 ~= "mouse" then
        v49 = u3
    else
        v49 = nil
    end
    local Character_1 = LocalPlayer_upv_1.Character
    local v50, v51 = nil, nil
    if Character_1 then
        v50 = Character_1:FindFirstChild("HumanoidRootPart")
        v51 = not (v50) or not (v50:IsA("BasePart")) or v50
    else
        v51 = Character_1
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if u2 and a6 and v49 and Character_1 and v51 and CurrentCamera_1 then
        local v52 = Character_1:FindFirstChildOfClass("Humanoid")
        local v53 = (v52 ~= nil) and (v52.MoveDirection.Magnitude > 0.1)
        local v54 = true
        if not (v43 - u9 < 0.35) then
            v54 = v53
            if not (v54) then
                v54 = a8 or a10
            end
        end
        if v54 then
            local Position_2 = CurrentCamera_1.CFrame.Position
            local LookVector_1 = CFrame.fromEulerAnglesYXZ(a5, a4, 0).LookVector
            local Position_3 = v51.Position
            if v48 or v43 - u7 >= 0.05 then
                u7 = v43
                u13 = v49
                local v55 = classify(Character_1, a8, a9, a10)
                u11 = v55
                local v56 = u11
                if (v49) and (v56) then
                    local v57
                    if v49 ~= "gamepad" then
                        v57 = tbl_upv_1.TOUCH
                    else
                        v57 = tbl_upv_1.GAMEPAD
                    end
                    v55 = v57[u11]
                else
                    v55 = nil
                end
                u12 = v55
                if u12 then
                    u5, u6 = search(Position_2, LookVector_1, u12, a7, Character_1, Position_3)
                else
                    u5 = nil
                end
            end
            local v58 = u12
            local v59 = u5
            if v58 and v59 then
                if evaluate(v59, Position_2, LookVector_1, v58, Position_3) and not (tbl_upv_5.cone * 1.25 < tbl_upv_5.deg) then
                    tbl_upv_4.frames = tbl_upv_4.frames + 1
                    tbl_upv_4.lastDeg = tbl_upv_5.deg
                    tbl_upv_4.lastCone = tbl_upv_5.cone
                    local v60 = math.clamp(((tbl_upv_5.deg / tbl_upv_5.cone) - 0.6) / 0.4, 0, 1)
                    local v61 = 1 - (v60 * v60) * (3 - (v60 * 2))
                    local v62 = math.clamp(((tbl_upv_5.deg / tbl_upv_5.cone) - 0.85) / 0.4, 0, 1)
                    local v63 = 1 - (v62 * v62) * (3 - (v62 * 2))
                    local v64
                    local v75 = nil
                    if v47 and v61 > 0 then
                        local Unit_1 = (tbl_upv_5.point - Position_2).Unit
                        local v65 = ((math.atan2(-Unit_1.X, -Unit_1.Z) - a4) + math.pi) % math.tau - math.pi
                        local v66 = math.asin(math.clamp(Unit_1.Y, -1, 1)) - a5
                        local v67 = (a2 * v65) + (a3 * v66) > 0
                        local v68 = (1 - u12.friction) * v61
                        local v69
                        if v67 then
                            v69 = 0.35
                        else
                            v69 = 1
                        end
                        v75 = 1 - v68 * v69
                        v44 = v44 + a2 * (v75 - 1)
                        v64 = a3 + a3 * (v75 - 1)
                        if v75 < 0.999 then
                            tbl_upv_4.slowed = tbl_upv_4.slowed + 1
                        end
                        if u6 then
                            if u12.pull > 0 then
                                v75 = math.sqrt((v65 * v65) + (v66 * v66))
                                local v72 = math.sqrt((a2 * a2) + (a3 * a3))
                                if v75 > 1e-04 then
                                    local v73 = math.min((u12.pull * v61) * v72, v75 * 0.5)
                                    v44 = v44 + (v65 / v75) * v73
                                    v64 = v64 + (v66 / v75) * v73
                                    v68 = tbl_upv_4
                                    v68.pullDeg = v68.pullDeg + math.deg(v73)
                                end
                            end
                        end
                    else
                        v64 = a3
                    end
                    local _, v81, v82, v83, v74 = body(u5)
                    if v74 then
                        local Unit_2 = (v74.Position - (Position_3 + Vector3.new(0, 1.5, 0))).Unit
                        v75 = u14
                        if v75 and u15 == u5 and a1 > 0 then
                            local v76 = nil
                            if a1 < 0.1 then
                                v76 = ((math.atan2(-Unit_2.X, -Unit_2.Z) - math.atan2(-v75.X, -v75.Z)) + math.pi) % math.tau - math.pi
                                local v77 = math.asin(math.clamp(Unit_2.Y, -1, 1)) - math.asin(math.clamp(v75.Y, -1, 1))
                                if math.abs(v76) < 0.13962634015954636 and math.abs(v77) < 0.13962634015954636 then
                                    local v78 = a1 * 1.5707963267948966
                                    local v79 = math.clamp((v76 * u12.track) * v63, -v78, v78)
                                    local v80 = math.clamp((v77 * u12.trackPitch) * v63, -v78, v78)
                                    v44 = v44 + v79
                                    v64 = v64 + v80
                                    tbl_upv_4.trackDeg = tbl_upv_4.trackDeg + math.deg(math.abs(v79) + math.abs(v80))
                                end
                            end
                        end
                        u14 = Unit_2
                        u15 = u5
                    end
                    return v44, v64
                end
                u5 = nil
                u14 = nil
                u15 = nil
                tbl_upv_4.lastDeg = -1
                tbl_upv_4.lastCone = -1
                return v44, a3
            end
        end
        u5 = nil
        u14 = nil
        u15 = nil
        tbl_upv_4.lastDeg = -1
        tbl_upv_4.lastCone = -1
        return v44, a3
    end
    u5 = nil
    u14 = nil
    u15 = nil
    tbl_upv_4.lastDeg = -1
    tbl_upv_4.lastCone = -1
    return v44, a3
end
function tbl_upv_1.Shot(a1, a2, a3, a4, a5, a6)
    --[[
      name: Shot
      line: 456
      upvalues:
        u3 (ref,  index: 1)
        UserInputService_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        u2 (ref,  index: 5)
        classify (copy, index: 6)
        tbl_upv_1 (copy, index: 7)
        search (copy, index: 8)
        evaluate (copy, index: 9)
        body (copy, index: 10)
        tbl_upv_5 (copy, index: 11)
    ]]
    local v81
    if u3 == nil then
        local _ = UserInputService_upv_1.PreferredInput
        v81 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and "touch" or UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Gamepad and "gamepad" or nil
    elseif u3 ~= "mouse" then
        v81 = u3
    else
        v81 = nil
    end
    local Character_2 = LocalPlayer_upv_1.Character
    local v82, v83 = nil, nil
    if Character_2 then
        v82 = Character_2:FindFirstChild("HumanoidRootPart")
        v83 = not (v82) or not (v82:IsA("BasePart")) or v82
    else
        v83 = Character_2
    end
    local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
    if u2 and v81 and Character_2 and v83 and CurrentCamera_2 then
        local v84 = classify(Character_2, a4, a5, a6)
        local v85
        if (v81) and (v84) then
            local v86
            if v81 ~= "gamepad" then
                v86 = tbl_upv_1.TOUCH
            else
                v86 = tbl_upv_1.GAMEPAD
            end
            v85 = v86[v84]
        else
            v85 = nil
        end
        if v85 and v84 then
            local Position_4 = CurrentCamera_2.CFrame.Position
            local LookVector_2 = CFrame.fromEulerAnglesYXZ(a3, a2, 0).LookVector
            local v87, v88 = search(Position_4, LookVector_2, v85, a1, Character_2, v83.Position)
            if v87 and evaluate(v87, Position_4, LookVector_2, v85, v83.Position) then
                local _, v90, v91, v92, v89 = body(v87)
                if not v89 then
                    return nil
                end
                local tbl_7 = {}
                tbl_7.model = v87
                tbl_7.part = v89
                tbl_7.point = tbl_upv_5.point
                tbl_7.deg = tbl_upv_5.deg
                tbl_7.cone = tbl_upv_5.cone
                tbl_7.class = v84
                tbl_7.input = v81
                tbl_7.torsoVisible = v88
                return tbl_7
            end
            return nil
        end
        return nil
    end
    return nil
end
function tbl_upv_1.Nudge(a1, a2)
    --[[
      name: Nudge
      line: 492
      upvalues:
        u16 (ref, index: 1)
        u17 (ref, index: 2)
    ]]
    u16 = a1
    u17 = a1 / math.max(a2, 0.004166666666666667)
end
function tbl_upv_1.IsAssistedInput()
    --[[
      name: IsAssistedInput
      line: 497
      upvalues:
        u3 (ref,  index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local v90
    if u3 == nil then
        local _ = UserInputService_upv_1.PreferredInput
        v90 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and "touch" or UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Gamepad and "gamepad" or nil
    elseif u3 ~= "mouse" then
        v90 = u3
    else
        v90 = nil
    end
    local v91
    if v90 ~= nil then
        v91 = true
    else
        v91 = false
    end
    return v91
end
function tbl_upv_1.InputKind()
    --[[
      name: InputKind
      line: 501
      upvalues:
        u3 (ref,  index: 1)
        UserInputService_upv_1 (copy, index: 2)
    ]]
    local v92 = nil
    if u3 == nil then
        v92 = UserInputService_upv_1.PreferredInput
        if v92 ~= Enum.PreferredInput.Touch then
            if v92 ~= Enum.PreferredInput.Gamepad then
                return nil
            end
            return "gamepad"
        end
        return "touch"
    elseif u3 ~= "mouse" then
        return u3
    else
        return nil
    end
end
function tbl_upv_1.SetEnabled(a1)
    --[[
      name: SetEnabled
      line: 505
      upvalues:
        u2 (ref,  index: 1)
        u5 (ref,  index: 2)
        u14 (ref,  index: 3)
        u15 (ref,  index: 4)
        tbl_upv_4 (copy, index: 5)
        u16 (ref,  index: 6)
    ]]
    u2 = a1 == true
    if (u2) then
        return
    end
    u5 = nil
    u14 = nil
    u15 = nil
    tbl_upv_4.lastDeg = -1
    tbl_upv_4.lastCone = -1
    u16 = 0
end
function tbl_upv_1.IsEnabled()
    --[[
      name: IsEnabled
      line: 513
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.TakeInjected()
    --[[
      name: TakeInjected
      line: 518
      upvalues:
        u19 (ref, index: 1)
        u18 (ref, index: 2)
    ]]
    if u19 <= 0 then
        return Vector2.zero
    end
    u19 = u19 - 1
    return u18
end
function tbl_upv_1.Stats()
    --[[
      name: Stats
      line: 526
      upvalues:
        u5 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        u11 (ref,  index: 3)
        u13 (ref,  index: 4)
    ]]
    local tbl_8 = {aimAssistPullDeg = 0, aimAssistDeg = 0, aimAssistInput = 0, aimAssistTarget = 0, aimAssistFrames = 0, aimAssistClass = 0, aimAssistSearches = 0, aimAssistRays = 0, aimAssistTrackDeg = 0, aimAssistSlowed = 0, aimAssistCone = 0}
    tbl_8.aimAssistTarget = ((not u5) and "") or (u5.Name)
    tbl_8.aimAssistDeg = tbl_upv_4.lastDeg
    tbl_8.aimAssistCone = tbl_upv_4.lastCone
    tbl_8.aimAssistFrames = tbl_upv_4.frames
    tbl_8.aimAssistSlowed = tbl_upv_4.slowed
    tbl_8.aimAssistTrackDeg = tbl_upv_4.trackDeg
    tbl_8.aimAssistPullDeg = tbl_upv_4.pullDeg
    tbl_8.aimAssistSearches = tbl_upv_4.searches
    tbl_8.aimAssistRays = tbl_upv_4.rays
    tbl_8.aimAssistClass = u11 or ""
    tbl_8.aimAssistInput = u13 or ""
    return tbl_8
end
function tbl_upv_1.Debug(a1, a2, a3, a4)
    --[[
      name: Debug
      line: 546
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        u3 (ref,  index: 3)
        UserInputService_upv_1 (copy, index: 4)
        u19 (ref,  index: 5)
        tbl_upv_4 (copy, index: 6)
        u1 (copy, index: 7)
        u18 (ref,  index: 8)
    ]]
    if a1 == "state" then
        local v93 = tbl_upv_1.Stats()
        v93.enabled = u2
        v93.forced = u3 or false
        local v94
        if u3 == nil then
            local _ = UserInputService_upv_1.PreferredInput
            v94 = UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch and "touch" or UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Gamepad and "gamepad" or nil
        elseif u3 ~= "mouse" then
            v94 = u3
        else
            v94 = nil
        end
        local v95
        if v94 ~= nil then
            v95 = true
        else
            v95 = false
        end
        v93.assisted = v95
        v93.injectLeft = u19
        return v93
    elseif a1 == "reset" then
        for key_1 in tbl_upv_4 do
            tbl_upv_4[key_1] = 0
        end
        tbl_upv_4.lastDeg = -1
        tbl_upv_4.lastCone = -1
        return true
    elseif u1 then
        if a1 ~= "force" then
            if a1 ~= "inject" then
                return nil
            end
            u18 = Vector2.new(tonumber(a2) or 0, tonumber(a3) or 0)
            u19 = math.clamp(math.floor(tonumber(a4) or 1), 0, 1e+05)
            return true
        else
            local v96
            if a2 ~= "touch" and a2 ~= "gamepad" and a2 ~= "mouse" then
                v96 = nil
            else
                v96 = a2
            end
            u3 = v96
            return u3 or false
        end
    else
        return nil
    end
end
return tbl_upv_1