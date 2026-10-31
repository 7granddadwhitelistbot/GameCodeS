local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local SoundService_upv_1 = game:GetService("SoundService")
local _ = game:GetService("UserInputService")
local Metrics_upv_1 = require(script.Parent.Metrics)
local Quality_upv_1 = require(script.Parent.Quality)
local tbl_upv_1 = {}
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local u1 = nil
local function stats()
    --[[
      name: stats
      line: 22
      upvalues:
        u1 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if not (u1) then
        local v1 = LocalPlayer_upv_1:FindFirstChild("PlayerScripts") and (LocalPlayer_upv_1.PlayerScripts:FindFirstChild("Core"))
        local v2 = v1 and (v1:FindFirstChild("InputStats"))
        if v2 and v2:IsA("ModuleScript") then
            u1 = require(v2)
        end
    end
    return u1
end
local function notes()
    --[[
      name: notes
      line: 32
      upvalues:
        stats (copy, index: 1)
    ]]
    local v3 = stats()
    if v3 then
        return (v3.Take())
    end
    return 0
end
function tbl_upv_1.Probe(a1, a2)
    --[[
      name: Probe
      line: 39
      upvalues:
        u1 (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    local v4 = u1 or (stats())
    local v5 = v4 and (v4.PROBE)
    if v5 then
        if a1 ~= v5.n and a1 ~= v5.s and a1 ~= v5.t and a1 ~= v5.v then
            return nil
        elseif a2 ~= nil and a2 ~= 1 then
            return false
        else
            return a1
        end
    end
    return nil
end
function tbl_upv_1.ProbeValues()
    --[[
      name: ProbeValues
      line: 49
      upvalues:
        u1 (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    local v6 = u1 or (stats())
    return v6 and (v6.PROBE)
end
function tbl_upv_1.Hooked()
    --[[
      name: Hooked
      line: 53
      upvalues:
        u1 (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    local v7 = u1 or (stats())
    if not v7 then
        return
    end
    v7.Note(256)
end
local function caller(a1)
    --[[
      name: caller
      line: 60
      upvalues:
        stats (copy, index: 1)
    ]]
    local v8 = stats()
    if not v8 then
        return
    end
    v8.Caller(a1)
end
local v9 = ReplicatedStorage_1:WaitForChild("Assets", 30)
tbl_upv_1.Assets = v9
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local u2 = nil
local u3 = nil
task.spawn(
    function()
        --[[
          line: 76
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v10 = Shared_upv_1:WaitForChild("Camera", 12)
        if not v10 then
            return
        end
        if v10:IsA("ModuleScript") then
            local success_1, v11 = pcall(require, v10)
            if not success_1 or type(v11) ~= "table" then
                warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", v11)
            end
            u2 = v11
        end
    end
)
task.spawn(
    function()
        --[[
          line: 87
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v12 = Shared_upv_1:WaitForChild("Sfx", 20)
        if not v12 then
            return
        end
        if v12:IsA("ModuleScript") then
            local success_2, v13 = pcall(require, v12)
            if not success_2 or type(v13) ~= "table" or type(v13.Play) ~= "function" then
                return
            end
            u3 = v13
        end
    end
)
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 97
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 106
      upvalues:
        u2 (ref, index: 1)
    ]]
    if a1 and u2 and type(u2.Drawn) == "function" then
        local success_3, v14 = pcall(u2.Drawn, a1)
        if success_3 and typeof(v14) == "Instance" then
            return v14
        end
    end
    return a1
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 120
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v15 = (u2 ~= nil) and ((type(u2.InFirstPerson) == "function") and (u2.InFirstPerson() == true))
    return v15
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 124
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.GetAimRay) == "function" then
        local success_4, v16 = pcall(u2.GetAimRay)
        if success_4 and typeof(v16) == "Ray" then
            return v16
        end
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    local ViewportSize_1 = CurrentCamera_1.ViewportSize
    return CurrentCamera_1:ViewportPointToRay(ViewportSize_1.X / 2, ViewportSize_1.Y / 2)
end
function tbl_upv_1.SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 136
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.SetAiming) == "function" then
        pcall(u2.SetAiming, a1, a2)
        return
    end
    local TweenService_1 = game:GetService("TweenService")
    local v17 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_2 = {FieldOfView = 0}
    tbl_2.FieldOfView = ((not a1) and 70) or (a2 or 55)
    TweenService_1:Create(workspace.CurrentCamera, v17, tbl_2):Play()
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 148
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.FovKick) ~= "function" then
        return
    end
    pcall(u2.FovKick, a1, a2, a3)
end
function tbl_upv_1.Shake(a1, a2)
    --[[
      name: Shake
      line: 154
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v18 = tbl_upv_1.Probe(a1, a2)
    if v18 == nil then
        if u2 and type(u2.Shake) == "function" then
            pcall(u2.Shake, a1, a2)
        end
    else
        return v18
    end
end
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 166
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v19 = tbl_upv_1.Probe(a1, a2)
    if v19 == nil then
        if u2 and type(u2.RecoilSlow) == "function" then
            pcall(u2.RecoilSlow, a1, a2, a3, a4)
        else
            tbl_upv_1.Recoil(a1 * 5, (a2 or 0) * 5)
        end
    else
        return v19
    end
end
function tbl_upv_1.Recoil(a1, a2)
    --[[
      name: Recoil
      line: 179
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v20 = tbl_upv_1.Probe(a1, a2)
    if v20 == nil then
        if u2 and type(u2.Recoil) == "function" then
            pcall(u2.Recoil, a1, a2)
        end
    else
        return v20
    end
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 189
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.IsMouseUnlocked) == "function" then
        local success_5, v21 = pcall(u2.IsMouseUnlocked)
        return success_5 and (v21 == true)
    end
    return false
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 198
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.FaceCamera) ~= "function" then
        return
    end
    pcall(u2.FaceCamera)
end
function tbl_upv_1.SetCameraModifier(a1, a2)
    --[[
      name: SetCameraModifier
      line: 205
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.SetModifier) ~= "function" then
        return
    end
    if a2 and a2.pivot and type(u2.GetShoulderSide) == "function" then
        local success_6, v22 = pcall(u2.GetShoulderSide)
        if success_6 and type(v22) == "number" then
            local pivot_1 = a2.pivot
            a2 = table.clone(a2)
            a2.pivot = Vector3.new(pivot_1.X * v22, pivot_1.Y, pivot_1.Z)
        end
    end
    pcall(u2.SetModifier, a1, a2)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 219
    ]]
    return workspace.CurrentCamera.FieldOfView
end
local function matchOf(a1)
    --[[
      name: matchOf
      line: 225
    ]]
    local v23 = a1 and (a1:GetAttribute("MatchId"))
    if type(v23) ~= "string" then
        return ""
    end
    return v23
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 231
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v24 = Character_1 and (Character_1:GetAttribute("MatchId"))
    local v25
    if type(v24) ~= "string" then
        v25 = ""
    else
        v25 = v24
    end
    local v26
    if v25 ~= "" then
        v26 = true
    else
        v26 = false
    end
    return v26
end
local function phaseLive(a1)
    --[[
      name: phaseLive
      line: 235
    ]]
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v27 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
    local v28 = v27 and (v27:GetAttribute("Phase"))
    local v29 = true
    if v28 ~= "Live" then
        v29 = v28 == "Overtime"
    end
    return v29
end
function tbl_upv_1.IsEnemy(a1)
    --[[
      name: IsEnemy
      line: 243
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if a1 and Character_2 and a1 ~= Character_2 then
        local v30 = Character_2 and (Character_2:GetAttribute("MatchId"))
        local v31
        if type(v30) ~= "string" then
            v31 = ""
        else
            v31 = v30
        end
        if v31 ~= "" then
            local v32 = a1 and (a1:GetAttribute("MatchId"))
            if type(v32) ~= "string" then
                v30 = ""
            else
                v30 = v32
            end
            if v30 == v31 then
                v30 = Character_2:GetAttribute("Team")
                local v33 = a1:GetAttribute("Team")
                return (v30 ~= nil) and ((v33 ~= nil) and (v30 ~= v33))
            end
        end
        return false
    end
    return false
end
function tbl_upv_1.IsTeammate(a1)
    --[[
      name: IsTeammate
      line: 256
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if a1 and Character_3 and a1 ~= Character_3 then
        local v34 = Character_3 and (Character_3:GetAttribute("MatchId"))
        local v35
        if type(v34) ~= "string" then
            v35 = ""
        else
            v35 = v34
        end
        local v36 = false
        local v37
        if v35 == "" then
            v37 = v36
        else
            v37 = false
            local v38 = a1 and (a1:GetAttribute("MatchId"))
            local v39
            if type(v38) ~= "string" then
                v39 = ""
            else
                v39 = v38
            end
            if v39 == v35 then
                v37 = a1:GetAttribute("Team") == Character_3:GetAttribute("Team")
            end
        end
        return v37
    end
    return false
end
local u4 = nil
function tbl_upv_1.ItemBonus(a1)
    --[[
      name: ItemBonus
      line: 269
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        Shared_upv_1 (copy, index: 3)
    ]]
    local Character_4 = LocalPlayer_upv_1.Character
    if Character_4 and type(a1) == "string" then
        local v40 = Character_4:GetAttribute("ItemLevels")
        if type(v40) == "string" and v40 ~= "" then
            if u4 == nil then
                local success_7, v41 = pcall(require, Shared_upv_1:FindFirstChild("Shards"))
                local v42
                if (success_7) and type(v41) == "table" then
                    v42 = v41
                else
                    v42 = false
                end
                u4 = v42
            end
            if u4 then
                return u4.Bonus(u4.DecodeLevels(v40)[a1] or 1)
            end
            return 1
        end
        return 1
    end
    return 1
end
function tbl_upv_1.CanPredictHit(a1)
    --[[
      name: CanPredictHit
      line: 290
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v43 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v44 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v45
        if type(v44) ~= "string" then
            v45 = ""
        else
            v45 = v44
        end
        local v46
        if v45 == "" then
            v46 = true
        else
            v46 = false
        end
        return v46
    else
        v43 = tbl_upv_1.IsEnemy(a1)
        local v47
        if v43 then
            local v48 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v45
            if type(v48) ~= "string" then
                v45 = ""
            else
                v45 = v48
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v49 = Arenas_2 and (Arenas_2:FindFirstChild(v45))
            local v50 = v49 and (v49:GetAttribute("Phase"))
            v47 = true
            if v50 ~= "Live" then
                v47 = v50 == "Overtime"
            end
        else
            v47 = v43
        end
        return v47
    end
end
local u5 = -math.huge
local u6 = nil
local u7 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 307
      upvalues:
        u5 (ref, index: 1)
        u6 (ref, index: 2)
        u7 (ref, index: 3)
    ]]
    if type(a2) ~= "number" or not (a2 > 0) then
        return
    end
    u5 = os.clock()
    u6 = a1
    u7 = a2
end
function tbl_upv_1.GuardRecovery(a1)
    --[[
      name: GuardRecovery
      line: 313
      upvalues:
        u6 (ref, index: 1)
        u5 (ref, index: 2)
        u7 (ref, index: 3)
    ]]
    if a1 ~= nil and a1 ~= u6 then
        return (math.max(0, (u5 + u7) - os.clock()))
    end
    return 0
end
function tbl_upv_1.CanAct()
    --[[
      name: CanAct
      line: 320
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    if LocalPlayer_upv_1:GetAttribute("Frozen") == true then
        return false
    end
    local Character_6 = LocalPlayer_upv_1.Character
    if Character_6 and Character_6:GetAttribute("Frozen") == true then
        return false
    end
    local v51 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v51) == "number" and workspace:GetServerTimeNow() < v51 then
        return false
    end
    local v52 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v52) ~= "string" then
        v51 = ""
    else
        v51 = v52
    end
    local v53 = true
    local v54
    if v51 == "" then
        v54 = v53
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v55 = Arenas_3 and (Arenas_3:FindFirstChild(v51))
        local v56 = v55 and (v55:GetAttribute("Phase"))
        v54 = true
        if v56 ~= "Live" then
            v54 = v56 == "Overtime"
        end
    end
    return v54
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 352
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
    ]]
    local tbl_3 = {}
    local Character_7 = LocalPlayer_upv_1.Character
    for _, value_1 in Players_upv_1:GetPlayers() do
        local Character_8 = value_1.Character
        if not (Character_8) or Character_8 == Character_7 then
            continue
        end
        if Character_8:IsDescendantOf(workspace) then
            table.insert(tbl_3, Character_8)
        end
    end
    local tbl_4 = {}
    for _, value_2 in tbl_3 do
        tbl_4[value_2] = true
    end
    for _, value_3 in {"Combatant", "Bot", "TrainingDummy"} do
        for v1, value_4 in CollectionService_upv_1:GetTagged(value_3) do
            if not (value_4:IsA("Model")) or value_4 == Character_7 or tbl_4[value_4] then
                continue
            end
            if value_4:IsDescendantOf(workspace) then
                tbl_4[value_4] = true
                table.insert(tbl_3, value_4)
            end
        end
    end
    return tbl_3
end
function tbl_upv_1.Teammates()
    --[[
      name: Teammates
      line: 378
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_5 = {}
    for _, value_5 in tbl_upv_1.Targets() do
        if tbl_upv_1.IsTeammate(value_5) then
            table.insert(tbl_5, value_5)
        end
    end
    return tbl_5
end
local function fxFolders()
    --[[
      name: fxFolders
      line: 340
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v57 = workspace:FindFirstChild(value_6)
        if v57 then
            table.insert(tbl_6, v57)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 388
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v58 = RaycastParams.new()
    v58.FilterType = Enum.RaycastFilterType.Exclude
    local v59 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v59, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v59, value_7)
        end
    end
    v58.FilterDescendantsInstances = v59
    v58.IgnoreWater = true
    return v58
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 407
      upvalues:
        stats (copy, index: 1)
        u2 (ref,  index: 2)
        fxFolders (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local v60 = stats()
    if v60 then
        v60.Caller(16384)
    end
    if u2 then
        if type(u2.GetAimPoint) ~= "function" then
            local v61 = tbl_upv_1.GetAimRay()
            local v62 = a1 or 1000
            local v63 = workspace:Raycast(v61.Origin, v61.Direction.Unit * v62, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v63 then
                return v63.Position, v63
            end
            return v61.Origin + (v61.Direction.Unit * v62), nil
        else
            local v64 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v64, value_8)
            end
            local v65, v66, v67 = pcall(u2.GetAimPoint, a1, v64)
            if v65 then
                if typeof(v66) == "Vector3" then
                    return v66, v67
                end
                local v61 = tbl_upv_1.GetAimRay()
                local v62 = a1 or 1000
                local v63 = workspace:Raycast(v61.Origin, v61.Direction.Unit * v62, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v63 then
                    return v63.Position, v63
                end
                return v61.Origin + (v61.Direction.Unit * v62), nil
            else
                local v61 = tbl_upv_1.GetAimRay()
                local v62 = a1 or 1000
                local v63 = workspace:Raycast(v61.Origin, v61.Direction.Unit * v62, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v63 then
                    return v63.Position, v63
                end
                return v61.Origin + (v61.Direction.Unit * v62), nil
            end
        end
    else
        local v61 = tbl_upv_1.GetAimRay()
        local v62 = a1 or 1000
        local v63 = workspace:Raycast(v61.Origin, v61.Direction.Unit * v62, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v63 then
            return v63.Position, v63
        end
        return v61.Origin + (v61.Direction.Unit * v62), nil
    end
end
function tbl_upv_1.AimDirection(a1, ...)
    --[[
      name: AimDirection
      line: 430
      upvalues:
        tbl_upv_1 (copy, index: 1)
        stats (copy, index: 2)
    ]]
    local v68 = tbl_upv_1.Probe(a1, ...)
    if v68 ~= nil then
        return v68
    end
    local v69 = stats()
    if v69 then
        v69.Caller(16384)
    end
    local v70 = tbl_upv_1.GetAimRay()
    local v71 = tbl_upv_1.AimPoint() - a1
    if not (v71.Magnitude < 2) and not (v71.Unit:Dot(v70.Direction.Unit) < 0.2) then
        return v71.Unit
    end
    return v70.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 471
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v72 = LocalPlayer_upv_1:GetAttribute(a1)
        local v73
        if type(v72) ~= "number" then
            v73 = 0
        else
            v73 = v72
        end
        LocalPlayer_upv_1:SetAttribute(a1, v73 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 478
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v74 = u2 and (u2[a1])
    if type(v74) ~= "function" then
        return nil
    end
    local success_8, v75 = pcall(v74, ...)
    if success_8 then
        return v75
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 488
      upvalues:
        u2 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u2 and camCall("GetAimAssistEnabled") ~= false then
        local v76 = camCall("IsAssistedInput") == true
        return v76
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 497
    ]]
    local v77 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v77 and v77:IsA("BasePart") then
        local v78 = nil
        if a4 then
            v78 = Vector3.new(a2.X, 0, a2.Z)
            if v78.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v78.Unit
            local v79 = Vector3.new(v77.Position.X - a1.X, 0, v77.Position.Z - a1.Z)
            local v80 = v79:Dot(Unit_1)
            return (v80 > 0) and ((v79 - (Unit_1 * v80)).Magnitude <= 1.1)
        else
            local v81 = v77.Position - Vector3.new(0, 2.200000047683716, 0)
            local v82
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v82 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v82 = v77.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v83 = v82 - v81
            local v84 = v81 - a1
            local v85 = v83:Dot(v83)
            local v86 = v83:Dot(Unit_2)
            local v87 = v85 - v86 * v86
            local v88 = ((not (v87 > 1e-06)) and 0) or (math.clamp((v86 * Unit_2:Dot(v84) - v83:Dot(v84)) / v87, 0, 1))
            local v89 = v81 + v83 * v88
            local v90 = (v89 - a1):Dot(Unit_2)
            return (v90 > 0) and (((v89 - a1) - (Unit_2 * v90)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 529
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
    ]]
    local v91 = stats()
    if v91 then
        v91.Caller(16384)
    end
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v92 = camCall("GetAimAssistShot")
    if type(v92) == "table" and v92.torsoVisible and typeof(v92.point) == "Vector3" and typeof(v92.model) == "Instance" then
        local model_1 = v92.model
        local point_1 = v92.point
        local v93 = (tbl_upv_1.ASSIST_MAGNET[v92.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v92.class]
        if type(v93) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v94 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v94 and not (v94.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v95 = nil
            if a3 then
                v95 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v96 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v95.Magnitude < 0.001) and not (v96 < 0.001) then
                    v95 = v95.Unit * v96
                    Unit_3 = Vector3.new(v95.X, a2.Y, v95.Z).Unit
                    local Unit_4 = a2.Unit
                    local v97 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v98 = math.rad(v93)
                    local v99 = nil
                    if RunService_upv_1:IsStudio() then
                        v99 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v100
                        if type(v99) ~= "number" then
                            v100 = 0
                        else
                            v100 = v99
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v100 + 1)
                    end
                    if (v97 <= v98) or (v97 < 1e-04) then
                        return Unit_3
                    end
                    local v101 = v98 / v97
                    local v102 = math.sin(v97)
                    return (Unit_4 * (math.sin((1 - v101) * v97) / v102) + (Unit_3 * (math.sin(v101 * v97) / v102))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v97 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v98 = math.rad(v93)
            local v99 = nil
            if RunService_upv_1:IsStudio() then
                v99 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v100
                if type(v99) ~= "number" then
                    v100 = 0
                else
                    v100 = v99
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v100 + 1)
            end
            if (v97 <= v98) or (v97 < 1e-04) then
                return Unit_3
            end
            local v101 = v98 / v97
            local v102 = math.sin(v97)
            return (Unit_4 * (math.sin((1 - v101) * v97) / v102) + (Unit_3 * (math.sin(v101 * v97) / v102))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 581
      upvalues:
        tbl_upv_1 (copy, index: 1)
        camCall (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        RunService_upv_1 (copy, index: 5)
    ]]
    if not tbl_upv_1.AssistActive() then
        return 0
    end
    local v103 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v104 = LocalPlayer_upv_1.Character
    local v105 = v104 and (v104:FindFirstChild("HumanoidRootPart"))
    if not v103 or not v105 or not v105:IsA("BasePart") then
        return 0
    end
    local Head_2 = v104:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v104 = Head_2.Position
    else
        v104 = v105.Position
    end
    local v106 = tbl_upv_1.GetAimRay()
    local v107 = Vector3.new(v106.Direction.X, 0, v106.Direction.Z)
    if v107.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v107.Unit
    v106 = math.cos(math.rad(v103.cone))
    local v108 = tbl_upv_1.Targets()
    local v109 = nil
    local v110 = nil
    local Unit_6 = math.huge
    local v111 = v109
    for _, value_9 in v108 do
        local v112 = tbl_upv_1.CanPredictHit(value_9)
        if not (v112) then
            continue
        end
        local v113 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v113) or v113.Health <= 0 or not (HumanoidRootPart_1) then
            continue
        end
        local v114 = HumanoidRootPart_1:IsA("BasePart")
        if not (v114) then
            continue
        end
        local v115 = HumanoidRootPart_1.Position - v104.Position
        local v116 = Vector3.new(v115.X, 0, v115.Z)
        local Magnitude_1 = v116.Magnitude
        if a1 + v103.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v115.Y) > 6 then
            continue
        end
        v115 = v116.Unit:Dot(Unit_5)
        if v115 < v106 then
            continue
        end
        local v117 = (1 - v115) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v117 then
            continue
        end
        local v118 = Combat_upv_1.SmokeBlocks(v104, HumanoidRootPart_1.Position)
        if v118 then
            continue
        end
        v118 = v111 or (tbl_upv_1.WorldParams(v108))
        v118 = workspace:Raycast(v104, HumanoidRootPart_1.Position - v104, v118)
        if not (v118) then
            Unit_6, v110 = v117, HumanoidRootPart_1.Position
        end
    end
    if not v110 then
        return 0
    end
    Unit_6 = Vector3.new(v110.X - v104.Position.X, 0, v110.Z - v104.Position.Z).Unit
    local v119 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v119) < 0.05235987755982989 then
        return 0
    end
    local v120 = math.clamp(v119, -math.rad(v103.max), math.rad(v103.max))
    camCall("Nudge", v120, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v121
        if type(Unit_6) ~= "number" then
            v121 = 0
        else
            v121 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v121 + 1)
    end
    return (math.deg(v120))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u8 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 657
      upvalues:
        u8 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u8 == nil then
        local success_9, v122 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v123
        if success_9 then
            v123 = v122
        else
            v123 = false
        end
        u8 = v123
    end
    if u8 and type(u8.AltAmmo) == "function" then
        return (u8.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 666
    ]]
    local v124 = a1:GetAttribute("Ammo_" .. a2)
    if type(v124) ~= "number" then
        return 0
    end
    return v124
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 672
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v125 = a1:GetAttribute("Ammo_" .. a2)
    local v126
    if type(v125) ~= "number" then
        v126 = 0
    else
        v126 = v125
    end
    local v127 = nil
    for _, value_10 in altAmmo(a2) do
        local v128 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v128) ~= "number" then
            v127 = 0
        else
            v127 = v128
        end
        v126 = v126 + v127
    end
    return v126
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 684
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v129 = nil
        for _, value_11 in altAmmo(a2) do
            local v130 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v130) ~= "number" then
                v129 = 0
            else
                v129 = v130
            end
            if not (v129 >= 1) then
                continue
            end
            return value_11
        end
    end
    return nil
end
function tbl_upv_1.AmmoShown(a1, a2)
    --[[
      name: AmmoShown
      line: 698
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v131 = tbl_upv_1.AmmoNext(a1, a2)
    if v131 and a1 then
        local v132 = a1:GetAttribute("Ammo_" .. v131)
        local v133
        if type(v132) ~= "number" then
            v133 = 0
        else
            v133 = v132
        end
        return v133, tbl_upv_1.AMMO_NOUN[v131] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 707
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.AmmoNext(a1, a2) ~= "fire_arrows" then
        return a3
    end
    return "Fire" .. a3
end
function tbl_upv_1.WatchAmmo(a1, a2, a3)
    --[[
      name: WatchAmmo
      line: 712
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u9 = v9:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u10 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 750
    ]]
    if typeof(a1) ~= "Vector3" then
        if typeof(a1) == "Instance" then
            if a1:IsA("BasePart") then
                return a1.Position
            elseif a1:IsA("Attachment") then
                return a1.WorldPosition
            end
        end
        return nil
    end
    return a1
end
local function findSound(a1)
    --[[
      name: findSound
      line: 724
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u9 (copy, index: 2)
    ]]
    local v134 = tbl_upv_8[a1]
    if v134 ~= nil then
        return v134 or nil
    end
    if not u9 then
        return nil
    end
    local v135 = u9
    for key_1 in string.gmatch(a1, "[^/]+") do
        v135 = v135 and v135:FindFirstChild(key_1)
    end
    v135 = v135 or (u9:FindFirstChild(a1, true))
    local v137 = not (v135) or not (v135:IsA("Sound")) or v135
    tbl_upv_8[a1] = v137 or false
    return v137
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 766
      upvalues:
        findSound (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u10 (ref,  index: 3)
        Quality_upv_1 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        Metrics_upv_1 (copy, index: 6)
        u3 (ref,  index: 7)
        SoundService_upv_1 (copy, index: 8)
    ]]
    local v138 = findSound(a1)
    local v139
    if typeof(a2) == "Vector3" then
        v139 = a2
    elseif typeof(a2) ~= "Instance" then
        v139 = nil
    elseif a2:IsA("BasePart") then
        v139 = a2.Position
    elseif a2:IsA("Attachment") then
        v139 = a2.WorldPosition
    else
        v139 = nil
    end
    local v140 = nil
    if v139 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v140 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v141 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v139).Magnitude)
        if not (v140) then
            local v142 = ((not v138) and 200) or (math.clamp(v138.RollOffMaxDistance, 60, 250))
            if v142 < v141 or Quality_upv_1.maxSounds <= u10 and v141 > 25 then
                return nil
            end
            local v143 = os.clock()
            local v144 = tbl_upv_9[a1]
            if v144 and v143 - v144.t < 0.035 and (v144.p - v139).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v143, p = v139}
        end
    end
    local v145 = (a3 and (a3.PlaybackSpeed)) or 1
    local v146 = (a3 and (a3.Volume)) or 1
    if v139 then
        u10 = u10 + 1
        Metrics_upv_1.sounds = u10
        local v147
        if (v138) and (v138.TimeLength > 0) then
            v147 = v138.TimeLength / math.max(0.05, v145)
        else
            v147 = 1.5
        end
        task.delay(
            math.min(v147 + 0.2, 6),
            function()
                --[[
                  line: 796
                  upvalues:
                    u10 (ref,  index: 1)
                    Metrics_upv_1 (copy, index: 2)
                ]]
                u10 = u10 - 1
                Metrics_upv_1.sounds = u10
            end
        )
    end
    if u3 then
        if a3 then
            v139 = {pitch = 0}
            v139.volume = v146
            local v148
            if a3.PlaybackSpeed then
                v148 = v145
            else
                v148 = nil
            end
            v139.pitch = v148
        else
            v139 = nil
        end
        local success_10, v149 = pcall(u3.Play, a1, a2, v139)
        if success_10 then
            if typeof(v149) == "Instance" and v149:IsA("Sound") then
                return v149
            end
            return nil
        end
    end
    if not v138 then
        return nil
    end
    local v150 = v138:GetAttribute("PitchVary")
    local v151 = math.random() * 2 - 1
    local v152
    if type(v150) ~= "number" then
        v152 = 0.05
    else
        v152 = v150
    end
    local u11 = v138:Clone()
    u11.PlaybackSpeed = u11.PlaybackSpeed * (v145 * (1 + (v151 * v152)))
    u11.Volume = u11.Volume * v146
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u11.SoundGroup = SFX_1
    end
    local u12 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u11.Parent = SoundService_upv_1
            u11:Play()
            local v153 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
            task.delay(
                math.min(v153 + 0.2, 12),
                function()
                    --[[
                      line: 835
                      upvalues:
                        u11 (copy, index: 1)
                        u12 (ref,  index: 2)
                    ]]
                    u11:Destroy()
                    if not u12 then
                        return
                    end
                    u12:Destroy()
                end
            )
            return u11
        end
        u11.Parent = a2
    else
        local v154 = Instance.new("Attachment")
        v154.WorldPosition = a2
        v154.Parent = workspace.Terrain
        u11.Parent = v154
        u12 = v154
    end
    u11:Play()
    local v153 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
    task.delay(
        math.min(v153 + 0.2, 12),
        function()
            --[[
              line: 835
              upvalues:
                u11 (copy, index: 1)
                u12 (ref,  index: 2)
            ]]
            u11:Destroy()
            if not u12 then
                return
            end
            u12:Destroy()
        end
    )
    return u11
end
function tbl_upv_1.Loop(a1, a2)
    --[[
      name: Loop
      line: 845
      upvalues:
        u3 (ref,  index: 1)
        findSound (copy, index: 2)
        SoundService_upv_1 (copy, index: 3)
    ]]
    if u3 then
        local u13
        if type(u3.Loop) == "function" then
            local success_11, u13 = pcall(u3.Loop, a1, a2)
            if success_11 and type(u13) == "function" then
                return function(a3)
                    --[[
                      line: 849
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    pcall(u13, a3)
                end
            end
        end
    end
    local v155 = findSound(a1)
    if not v155 then
        return function()
            --[[
              line: 856
            ]]
        end
    end
    local u14 = v155:Clone()
    u14.Looped = true
    u14.Parent = a2 or SoundService_upv_1
    u14:Play()
    return function()
        --[[
          line: 862
          upvalues:
            u14 (copy, index: 1)
        ]]
        u14:Destroy()
    end
end
local u15 = v9:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 873
      upvalues:
        u15 (copy, index: 1)
        tbl_upv_10 (copy, index: 2)
    ]]
    if a1 and u15 then
        local tbl_upv_11 = tbl_upv_10[a1]
        if not (tbl_upv_11) then
            tbl_upv_11 = {}
            tbl_upv_10[a1] = tbl_upv_11
            a1.Destroying:Once(
                function()
                    --[[
                      line: 881
                      upvalues:
                        tbl_upv_10 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    tbl_upv_10[a1] = nil
                end
            )
            a1.AncestryChanged:Connect(
                function()
                    --[[
                      line: 888
                      upvalues:
                        a1 (copy, index: 1)
                        tbl_upv_10 (copy, index: 2)
                        tbl_upv_11 (ref,  index: 3)
                    ]]
                    if (a1:IsDescendantOf(game)) or tbl_upv_10[a1] ~= tbl_upv_11 then
                        return
                    end
                    task.delay(
                        20,
                        function()
                            --[[
                              line: 892
                              upvalues:
                                tbl_upv_10 (copy, index: 1)
                                a1 (copy, index: 2)
                                tbl_upv_11 (ref,  index: 3)
                            ]]
                            if tbl_upv_10[a1] ~= tbl_upv_11 or a1:IsDescendantOf(game) then
                                return
                            end
                            tbl_upv_10[a1] = nil
                            for _, value_upv_13 in tbl_upv_11 do
                                pcall(
                                    function()
                                        --[[
                                          line: 898
                                          upvalues:
                                            value_upv_13 (copy, index: 1)
                                        ]]
                                        value_upv_13:Stop(0)
                                        value_upv_13:Destroy()
                                    end
                                )
                            end
                        end
                    )
                end
            )
        end
        local v157 = tbl_upv_11[a2]
        if v157 then
            return v157
        end
        local u16 = u15:FindFirstChild(a2)
        if u16 and u16:IsA("Animation") then
            local success_12, v158 = pcall(
                function()
                    --[[
                      line: 914
                      upvalues:
                        a1 (copy, index: 1)
                        u16 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u16)
                end
            )
            if success_12 and v158 then
                local v159 = u16:GetAttribute("Priority")
                if type(v159) == "string" and (Enum.AnimationPriority[v159]) then
                    v158.Priority = Enum.AnimationPriority[v159]
                else
                    v158.Priority = Enum.AnimationPriority.Action
                end
                local v160 = u16:GetAttribute("Looped")
                if type(v160) == "boolean" then
                    v158.Looped = v160
                end
                tbl_upv_11[a2] = v158
                return v158
            end
            return nil
        end
        return nil
    end
    return nil
end
local u17 = nil
function tbl_upv_1.SetAnimRelay(a1)
    --[[
      name: SetAnimRelay
      line: 937
      upvalues:
        u17 (ref, index: 1)
    ]]
    u17 = a1
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 941
      upvalues:
        u17 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v161 = u17
    local Character_11 = LocalPlayer_upv_1.Character
    if not v161 or not a1 or not Character_11 then
        return
    end
    if a1:IsDescendantOf(Character_11) then
        local v162 = stats()
        local v163 = ((not v162) and 0) or (v162.Take())
        u17:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, v163)
    end
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 949
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u15 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v164 = tbl_upv_1.GetTrack(a1, a2)
    if not v164 then
        return nil
    end
    local v165 = a3 or 1
    local v166 = u15 and (u15:FindFirstChild(a2))
    local v167 = v166 and (v166:GetAttribute("Speed"))
    if type(v167) == "number" then
        v165 = v165 * v167
    end
    v164:Play(a4 or 0.08, a5 or 1, v165)
    return v164
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 967
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        u17 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v168 = stats()
    if v168 then
        v168.Caller(8192)
    end
    local v169 = playAnim(a1, a2, a3, a4, a5)
    if v169 and a2 then
        local v170 = u17
        local Character_12 = LocalPlayer_upv_1.Character
        if v170 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            local v171 = stats()
            local v172 = ((not v171) and 0) or (v171.Take())
            u17:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, v172)
        end
    end
    return v169
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 977
      upvalues:
        playAnim (copy, index: 1)
        u17 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        stats (copy, index: 4)
    ]]
    local u18 = playAnim(a1, a2, a3, 0.08)
    if not u18 then
        return nil
    end
    local v173 = u17
    local Character_13 = LocalPlayer_upv_1.Character
    if v173 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        local v174 = stats()
        local v175 = ((not v174) and 0) or (v174.Take())
        u17:FireServer("Hold", a2, a3 or 1, 0.08, 1, v175)
    end
    local function freeze()
        --[[
          name: freeze
          line: 984
          upvalues:
            u18 (copy, index: 1)
        ]]
        if not u18.IsPlaying then
            return
        end
        u18.TimePosition = math.max(0, u18.Length - 0.03)
        u18:AdjustSpeed(0)
    end
    task.spawn(
        function()
            --[[
              line: 990
              upvalues:
                u18 (copy, index: 1)
            ]]
            local v176 = os.clock()
            while u18.Length == 0 do
                if os.clock() - v176 < 2 then
                    task.wait()
                    continue
                else
                    break
                end
            end
            task.wait((math.max(0, (u18.Length / math.max(0.05, u18.Speed)) - 0.04)))
            if not u18.IsPlaying then
                return
            end
            u18.TimePosition = math.max(0, u18.Length - 0.03)
            u18:AdjustSpeed(0)
        end
    )
    return u18
end
function tbl_upv_1.StopAnim(a1, a2, a3)
    --[[
      name: StopAnim
      line: 1002
      upvalues:
        tbl_upv_10 (copy, index: 1)
        u17 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        stats (copy, index: 4)
    ]]
    if not a1 then
        return
    end
    if a2 then
        local v177 = tbl_upv_10[a1]
        local v178 = v177 and (v177[a2])
        if v178 and v178.IsPlaying then
            v178:Stop(a3 or 0.12)
            local v179 = u17
            local Character_14 = LocalPlayer_upv_1.Character
            if v179 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                local v180 = stats()
                local v181 = ((not v180) and 0) or (v180.Take())
                u17:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, v181)
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 1014
      upvalues:
        u15 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not u15 then
        return
    end
    for _, value_14 in u15:GetChildren() do
        if value_14:IsA("Animation") then
            tbl_upv_1.GetTrack(a1, value_14.Name)
        end
    end
end
function tbl_upv_1.ToolPoint(a1, a2)
    --[[
      name: ToolPoint
      line: 1028
    ]]
    if not a1 then
        return nil
    end
    local v182 = a1:FindFirstChild(a2, true)
    if v182 and v182:IsA("Attachment") then
        return v182.WorldPosition
    end
    local Handle_1 = a1:FindFirstChild("Handle")
    if Handle_1 and Handle_1:IsA("BasePart") then
        return Handle_1.Position
    end
    return nil
end
local function sightOrigin(a1, a2)
    --[[
      name: sightOrigin
      line: 1052
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v183 = tbl_upv_1.AimPoint()
    local v184 = v183 - a2
    if v184.Magnitude < 3.5 then
        return a2
    end
    local v185 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v184.Unit * (v184.Magnitude - 1.5), v185) then
        return a2
    end
    local v186 = tbl_upv_1.GetAimRay()
    local Unit_7 = v186.Direction.Unit
    local v187 = v186.Origin + Unit_7 * math.max((a1 - v186.Origin):Dot(Unit_7), 0)
    local v188 = v183 - v187
    if not ((v187 - a1).Magnitude > 7) and not (v188.Magnitude < 3.5) and not (v188.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v187 - a1, v185)) and not (workspace:Raycast(v187, v188.Unit * (v188.Magnitude - 1.5), v185)) then
            return v187
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1080
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v189 = LocalPlayer_upv_1.Character
    local _ = v189 and (v189:FindFirstChild("Head"))
    local v190 = v189 and (v189:FindFirstChild("HumanoidRootPart"))
    if v189 then
        v189 = v189.Position
    else
        v189 = (v190 and (v190.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v191 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v191 and not ((v191 - v189).Magnitude > 7) then
        if workspace:Raycast(v189, v191 - v189, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v189, v189))
        end
        return (sightOrigin(v189, v191))
    end
    return v189
end
return tbl_upv_1