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
local function caller(a1)
    --[[
      name: caller
      line: 48
      upvalues:
        stats (copy, index: 1)
    ]]
    local v6 = stats()
    if not v6 then
        return
    end
    v6.Caller(a1)
end
local v7 = ReplicatedStorage_1:WaitForChild("Assets", 30)
tbl_upv_1.Assets = v7
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local u2 = nil
local u3 = nil
task.spawn(
    function()
        --[[
          line: 64
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v8 = Shared_upv_1:WaitForChild("Camera", 12)
        if not v8 then
            return
        end
        if v8:IsA("ModuleScript") then
            local success_1, v9 = pcall(require, v8)
            if not success_1 or type(v9) ~= "table" then
                warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", v9)
            end
            u2 = v9
        end
    end
)
task.spawn(
    function()
        --[[
          line: 75
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v10 = Shared_upv_1:WaitForChild("Sfx", 20)
        if not v10 then
            return
        end
        if v10:IsA("ModuleScript") then
            local success_2, v11 = pcall(require, v10)
            if not success_2 or type(v11) ~= "table" or type(v11.Play) ~= "function" then
                return
            end
            u3 = v11
        end
    end
)
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 85
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 94
      upvalues:
        u2 (ref, index: 1)
    ]]
    if a1 and u2 and type(u2.Drawn) == "function" then
        local success_3, v12 = pcall(u2.Drawn, a1)
        if success_3 and typeof(v12) == "Instance" then
            return v12
        end
    end
    return a1
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 108
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v13 = (u2 ~= nil) and ((type(u2.InFirstPerson) == "function") and (u2.InFirstPerson() == true))
    return v13
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 112
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.GetAimRay) == "function" then
        local success_4, v14 = pcall(u2.GetAimRay)
        if success_4 and typeof(v14) == "Ray" then
            return v14
        end
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    local ViewportSize_1 = CurrentCamera_1.ViewportSize
    return CurrentCamera_1:ViewportPointToRay(ViewportSize_1.X / 2, ViewportSize_1.Y / 2)
end
function tbl_upv_1.SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 124
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.SetAiming) == "function" then
        pcall(u2.SetAiming, a1, a2)
        return
    end
    local TweenService_1 = game:GetService("TweenService")
    local v15 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_2 = {FieldOfView = 0}
    tbl_2.FieldOfView = ((not a1) and 70) or (a2 or 55)
    TweenService_1:Create(workspace.CurrentCamera, v15, tbl_2):Play()
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 136
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
      line: 142
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v16 = tbl_upv_1.Probe(a1, a2)
    if v16 == nil then
        if u2 and type(u2.Shake) == "function" then
            pcall(u2.Shake, a1, a2)
        end
    else
        return v16
    end
end
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 154
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v17 = tbl_upv_1.Probe(a1, a2)
    if v17 == nil then
        if u2 and type(u2.RecoilSlow) == "function" then
            pcall(u2.RecoilSlow, a1, a2, a3, a4)
        else
            tbl_upv_1.Recoil(a1 * 5, (a2 or 0) * 5)
        end
    else
        return v17
    end
end
function tbl_upv_1.Recoil(a1, a2)
    --[[
      name: Recoil
      line: 167
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v18 = tbl_upv_1.Probe(a1, a2)
    if v18 == nil then
        if u2 and type(u2.Recoil) == "function" then
            pcall(u2.Recoil, a1, a2)
        end
    else
        return v18
    end
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 177
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.IsMouseUnlocked) == "function" then
        local success_5, v19 = pcall(u2.IsMouseUnlocked)
        return success_5 and (v19 == true)
    end
    return false
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 186
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
      line: 193
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.SetModifier) ~= "function" then
        return
    end
    if a2 and a2.pivot and type(u2.GetShoulderSide) == "function" then
        local success_6, v20 = pcall(u2.GetShoulderSide)
        if success_6 and type(v20) == "number" then
            local pivot_1 = a2.pivot
            a2 = table.clone(a2)
            a2.pivot = Vector3.new(pivot_1.X * v20, pivot_1.Y, pivot_1.Z)
        end
    end
    pcall(u2.SetModifier, a1, a2)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 207
    ]]
    return workspace.CurrentCamera.FieldOfView
end
local function matchOf(a1)
    --[[
      name: matchOf
      line: 213
    ]]
    local v21 = a1 and (a1:GetAttribute("MatchId"))
    if type(v21) ~= "string" then
        return ""
    end
    return v21
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 219
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v22 = Character_1 and (Character_1:GetAttribute("MatchId"))
    local v23
    if type(v22) ~= "string" then
        v23 = ""
    else
        v23 = v22
    end
    local v24
    if v23 ~= "" then
        v24 = true
    else
        v24 = false
    end
    return v24
end
local function phaseLive(a1)
    --[[
      name: phaseLive
      line: 223
    ]]
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v25 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
    local v26 = v25 and (v25:GetAttribute("Phase"))
    local v27 = true
    if v26 ~= "Live" then
        v27 = v26 == "Overtime"
    end
    return v27
end
function tbl_upv_1.IsEnemy(a1)
    --[[
      name: IsEnemy
      line: 231
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if a1 and Character_2 and a1 ~= Character_2 then
        local v28 = Character_2 and (Character_2:GetAttribute("MatchId"))
        local v29
        if type(v28) ~= "string" then
            v29 = ""
        else
            v29 = v28
        end
        if v29 ~= "" then
            local v30 = a1 and (a1:GetAttribute("MatchId"))
            if type(v30) ~= "string" then
                v28 = ""
            else
                v28 = v30
            end
            if v28 == v29 then
                v28 = Character_2:GetAttribute("Team")
                local v31 = a1:GetAttribute("Team")
                return (v28 ~= nil) and ((v31 ~= nil) and (v28 ~= v31))
            end
        end
        return false
    end
    return false
end
function tbl_upv_1.IsTeammate(a1)
    --[[
      name: IsTeammate
      line: 244
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if a1 and Character_3 and a1 ~= Character_3 then
        local v32 = Character_3 and (Character_3:GetAttribute("MatchId"))
        local v33
        if type(v32) ~= "string" then
            v33 = ""
        else
            v33 = v32
        end
        local v34 = false
        local v35
        if v33 == "" then
            v35 = v34
        else
            v35 = false
            local v36 = a1 and (a1:GetAttribute("MatchId"))
            local v37
            if type(v36) ~= "string" then
                v37 = ""
            else
                v37 = v36
            end
            if v37 == v33 then
                v35 = a1:GetAttribute("Team") == Character_3:GetAttribute("Team")
            end
        end
        return v35
    end
    return false
end
local u4 = nil
function tbl_upv_1.ItemBonus(a1)
    --[[
      name: ItemBonus
      line: 257
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        Shared_upv_1 (copy, index: 3)
    ]]
    local Character_4 = LocalPlayer_upv_1.Character
    if Character_4 and type(a1) == "string" then
        local v38 = Character_4:GetAttribute("ItemLevels")
        if type(v38) == "string" and v38 ~= "" then
            if u4 == nil then
                local success_7, v39 = pcall(require, Shared_upv_1:FindFirstChild("Shards"))
                local v40
                if (success_7) and type(v39) == "table" then
                    v40 = v39
                else
                    v40 = false
                end
                u4 = v40
            end
            if u4 then
                return u4.Bonus(u4.DecodeLevels(v38)[a1] or 1)
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
      line: 278
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v41 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v42 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v43
        if type(v42) ~= "string" then
            v43 = ""
        else
            v43 = v42
        end
        local v44
        if v43 == "" then
            v44 = true
        else
            v44 = false
        end
        return v44
    else
        v41 = tbl_upv_1.IsEnemy(a1)
        local v45
        if v41 then
            local v46 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v43
            if type(v46) ~= "string" then
                v43 = ""
            else
                v43 = v46
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v47 = Arenas_2 and (Arenas_2:FindFirstChild(v43))
            local v48 = v47 and (v47:GetAttribute("Phase"))
            v45 = true
            if v48 ~= "Live" then
                v45 = v48 == "Overtime"
            end
        else
            v45 = v41
        end
        return v45
    end
end
local u5 = -math.huge
local u6 = nil
local u7 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 295
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
      line: 301
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
      line: 308
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
    local v49 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v49) == "number" and workspace:GetServerTimeNow() < v49 then
        return false
    end
    local v50 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v50) ~= "string" then
        v49 = ""
    else
        v49 = v50
    end
    local v51 = true
    local v52
    if v49 == "" then
        v52 = v51
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v53 = Arenas_3 and (Arenas_3:FindFirstChild(v49))
        local v54 = v53 and (v53:GetAttribute("Phase"))
        v52 = true
        if v54 ~= "Live" then
            v52 = v54 == "Overtime"
        end
    end
    return v52
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 340
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
      line: 366
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
      line: 328
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v55 = workspace:FindFirstChild(value_6)
        if v55 then
            table.insert(tbl_6, v55)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 376
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v56 = RaycastParams.new()
    v56.FilterType = Enum.RaycastFilterType.Exclude
    local v57 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v57, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v57, value_7)
        end
    end
    v56.FilterDescendantsInstances = v57
    v56.IgnoreWater = true
    return v56
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 395
      upvalues:
        stats (copy, index: 1)
        u2 (ref,  index: 2)
        fxFolders (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local v58 = stats()
    if v58 then
        v58.Caller(16384)
    end
    if u2 then
        if type(u2.GetAimPoint) ~= "function" then
            local v59 = tbl_upv_1.GetAimRay()
            local v60 = a1 or 1000
            local v61 = workspace:Raycast(v59.Origin, v59.Direction.Unit * v60, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v61 then
                return v61.Position, v61
            end
            return v59.Origin + (v59.Direction.Unit * v60), nil
        else
            local v62 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v62, value_8)
            end
            local v63, v64, v65 = pcall(u2.GetAimPoint, a1, v62)
            if v63 then
                if typeof(v64) == "Vector3" then
                    return v64, v65
                end
                local v59 = tbl_upv_1.GetAimRay()
                local v60 = a1 or 1000
                local v61 = workspace:Raycast(v59.Origin, v59.Direction.Unit * v60, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v61 then
                    return v61.Position, v61
                end
                return v59.Origin + (v59.Direction.Unit * v60), nil
            else
                local v59 = tbl_upv_1.GetAimRay()
                local v60 = a1 or 1000
                local v61 = workspace:Raycast(v59.Origin, v59.Direction.Unit * v60, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v61 then
                    return v61.Position, v61
                end
                return v59.Origin + (v59.Direction.Unit * v60), nil
            end
        end
    else
        local v59 = tbl_upv_1.GetAimRay()
        local v60 = a1 or 1000
        local v61 = workspace:Raycast(v59.Origin, v59.Direction.Unit * v60, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v61 then
            return v61.Position, v61
        end
        return v59.Origin + (v59.Direction.Unit * v60), nil
    end
end
function tbl_upv_1.AimDirection(a1, ...)
    --[[
      name: AimDirection
      line: 418
      upvalues:
        tbl_upv_1 (copy, index: 1)
        stats (copy, index: 2)
    ]]
    local v66 = tbl_upv_1.Probe(a1, ...)
    if v66 ~= nil then
        return v66
    end
    local v67 = stats()
    if v67 then
        v67.Caller(16384)
    end
    local v68 = tbl_upv_1.GetAimRay()
    local v69 = tbl_upv_1.AimPoint() - a1
    if not (v69.Magnitude < 2) and not (v69.Unit:Dot(v68.Direction.Unit) < 0.2) then
        return v69.Unit
    end
    return v68.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 459
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v70 = LocalPlayer_upv_1:GetAttribute(a1)
        local v71
        if type(v70) ~= "number" then
            v71 = 0
        else
            v71 = v70
        end
        LocalPlayer_upv_1:SetAttribute(a1, v71 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 466
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v72 = u2 and (u2[a1])
    if type(v72) ~= "function" then
        return nil
    end
    local success_8, v73 = pcall(v72, ...)
    if success_8 then
        return v73
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 476
      upvalues:
        u2 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u2 and camCall("GetAimAssistEnabled") ~= false then
        local v74 = camCall("IsAssistedInput") == true
        return v74
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 485
    ]]
    local v75 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v75 and v75:IsA("BasePart") then
        local v76 = nil
        if a4 then
            v76 = Vector3.new(a2.X, 0, a2.Z)
            if v76.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v76.Unit
            local v77 = Vector3.new(v75.Position.X - a1.X, 0, v75.Position.Z - a1.Z)
            local v78 = v77:Dot(Unit_1)
            return (v78 > 0) and ((v77 - (Unit_1 * v78)).Magnitude <= 1.1)
        else
            local v79 = v75.Position - Vector3.new(0, 2.200000047683716, 0)
            local v80
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v80 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v80 = v75.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v81 = v80 - v79
            local v82 = v79 - a1
            local v83 = v81:Dot(v81)
            local v84 = v81:Dot(Unit_2)
            local v85 = v83 - v84 * v84
            local v86 = ((not (v85 > 1e-06)) and 0) or (math.clamp((v84 * Unit_2:Dot(v82) - v81:Dot(v82)) / v85, 0, 1))
            local v87 = v79 + v81 * v86
            local v88 = (v87 - a1):Dot(Unit_2)
            return (v88 > 0) and (((v87 - a1) - (Unit_2 * v88)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 517
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
    ]]
    local v89 = stats()
    if v89 then
        v89.Caller(16384)
    end
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v90 = camCall("GetAimAssistShot")
    if type(v90) == "table" and v90.torsoVisible and typeof(v90.point) == "Vector3" and typeof(v90.model) == "Instance" then
        local model_1 = v90.model
        local point_1 = v90.point
        local v91 = (tbl_upv_1.ASSIST_MAGNET[v90.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v90.class]
        if type(v91) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v92 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v92 and not (v92.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v93 = nil
            if a3 then
                v93 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v94 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v93.Magnitude < 0.001) and not (v94 < 0.001) then
                    v93 = v93.Unit * v94
                    Unit_3 = Vector3.new(v93.X, a2.Y, v93.Z).Unit
                    local Unit_4 = a2.Unit
                    local v95 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v96 = math.rad(v91)
                    local v97 = nil
                    if RunService_upv_1:IsStudio() then
                        v97 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v98
                        if type(v97) ~= "number" then
                            v98 = 0
                        else
                            v98 = v97
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v98 + 1)
                    end
                    if (v95 <= v96) or (v95 < 1e-04) then
                        return Unit_3
                    end
                    local v99 = v96 / v95
                    local v100 = math.sin(v95)
                    return (Unit_4 * (math.sin((1 - v99) * v95) / v100) + (Unit_3 * (math.sin(v99 * v95) / v100))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v95 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v96 = math.rad(v91)
            local v97 = nil
            if RunService_upv_1:IsStudio() then
                v97 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v98
                if type(v97) ~= "number" then
                    v98 = 0
                else
                    v98 = v97
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v98 + 1)
            end
            if (v95 <= v96) or (v95 < 1e-04) then
                return Unit_3
            end
            local v99 = v96 / v95
            local v100 = math.sin(v95)
            return (Unit_4 * (math.sin((1 - v99) * v95) / v100) + (Unit_3 * (math.sin(v99 * v95) / v100))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 569
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
    local v101 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v102 = LocalPlayer_upv_1.Character
    local v103 = v102 and (v102:FindFirstChild("HumanoidRootPart"))
    if not v101 or not v103 or not v103:IsA("BasePart") then
        return 0
    end
    local Head_2 = v102:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v102 = Head_2.Position
    else
        v102 = v103.Position
    end
    local v104 = tbl_upv_1.GetAimRay()
    local v105 = Vector3.new(v104.Direction.X, 0, v104.Direction.Z)
    if v105.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v105.Unit
    v104 = math.cos(math.rad(v101.cone))
    local v106 = tbl_upv_1.Targets()
    local v107 = nil
    local v108 = nil
    local Unit_6 = math.huge
    local v109 = v107
    for _, value_9 in v106 do
        local v110 = tbl_upv_1.CanPredictHit(value_9)
        if not (v110) then
            continue
        end
        local v111 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v111) or v111.Health <= 0 or not (HumanoidRootPart_1) then
            continue
        end
        local v112 = HumanoidRootPart_1:IsA("BasePart")
        if not (v112) then
            continue
        end
        local v113 = HumanoidRootPart_1.Position - v102.Position
        local v114 = Vector3.new(v113.X, 0, v113.Z)
        local Magnitude_1 = v114.Magnitude
        if a1 + v101.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v113.Y) > 6 then
            continue
        end
        v113 = v114.Unit:Dot(Unit_5)
        if v113 < v104 then
            continue
        end
        local v115 = (1 - v113) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v115 then
            continue
        end
        local v116 = Combat_upv_1.SmokeBlocks(v102, HumanoidRootPart_1.Position)
        if v116 then
            continue
        end
        v116 = v109 or (tbl_upv_1.WorldParams(v106))
        v116 = workspace:Raycast(v102, HumanoidRootPart_1.Position - v102, v116)
        if not (v116) then
            Unit_6, v108 = v115, HumanoidRootPart_1.Position
        end
    end
    if not v108 then
        return 0
    end
    Unit_6 = Vector3.new(v108.X - v102.Position.X, 0, v108.Z - v102.Position.Z).Unit
    local v117 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v117) < 0.05235987755982989 then
        return 0
    end
    local v118 = math.clamp(v117, -math.rad(v101.max), math.rad(v101.max))
    camCall("Nudge", v118, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v119
        if type(Unit_6) ~= "number" then
            v119 = 0
        else
            v119 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v119 + 1)
    end
    return (math.deg(v118))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u8 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 645
      upvalues:
        u8 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u8 == nil then
        local success_9, v120 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v121
        if success_9 then
            v121 = v120
        else
            v121 = false
        end
        u8 = v121
    end
    if u8 and type(u8.AltAmmo) == "function" then
        return (u8.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 654
    ]]
    local v122 = a1:GetAttribute("Ammo_" .. a2)
    if type(v122) ~= "number" then
        return 0
    end
    return v122
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 660
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v123 = a1:GetAttribute("Ammo_" .. a2)
    local v124
    if type(v123) ~= "number" then
        v124 = 0
    else
        v124 = v123
    end
    local v125 = nil
    for _, value_10 in altAmmo(a2) do
        local v126 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v126) ~= "number" then
            v125 = 0
        else
            v125 = v126
        end
        v124 = v124 + v125
    end
    return v124
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 672
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v127 = nil
        for _, value_11 in altAmmo(a2) do
            local v128 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v128) ~= "number" then
                v127 = 0
            else
                v127 = v128
            end
            if not (v127 >= 1) then
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
      line: 686
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v129 = tbl_upv_1.AmmoNext(a1, a2)
    if v129 and a1 then
        local v130 = a1:GetAttribute("Ammo_" .. v129)
        local v131
        if type(v130) ~= "number" then
            v131 = 0
        else
            v131 = v130
        end
        return v131, tbl_upv_1.AMMO_NOUN[v129] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 695
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
      line: 700
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u9 = v7:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u10 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 738
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
      line: 712
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u9 (copy, index: 2)
    ]]
    local v132 = tbl_upv_8[a1]
    if v132 ~= nil then
        return v132 or nil
    end
    if not u9 then
        return nil
    end
    local v133 = u9
    for key_1 in string.gmatch(a1, "[^/]+") do
        v133 = v133 and v133:FindFirstChild(key_1)
    end
    v133 = v133 or (u9:FindFirstChild(a1, true))
    local v135 = not (v133) or not (v133:IsA("Sound")) or v133
    tbl_upv_8[a1] = v135 or false
    return v135
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 754
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
    local v136 = findSound(a1)
    local v137
    if typeof(a2) == "Vector3" then
        v137 = a2
    elseif typeof(a2) ~= "Instance" then
        v137 = nil
    elseif a2:IsA("BasePart") then
        v137 = a2.Position
    elseif a2:IsA("Attachment") then
        v137 = a2.WorldPosition
    else
        v137 = nil
    end
    local v138 = nil
    if v137 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v138 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v139 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v137).Magnitude)
        if not (v138) then
            local v140 = ((not v136) and 200) or (math.clamp(v136.RollOffMaxDistance, 60, 250))
            if v140 < v139 or Quality_upv_1.maxSounds <= u10 and v139 > 25 then
                return nil
            end
            local v141 = os.clock()
            local v142 = tbl_upv_9[a1]
            if v142 and v141 - v142.t < 0.035 and (v142.p - v137).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v141, p = v137}
        end
    end
    local v143 = (a3 and (a3.PlaybackSpeed)) or 1
    local v144 = (a3 and (a3.Volume)) or 1
    if v137 then
        u10 = u10 + 1
        Metrics_upv_1.sounds = u10
        local v145
        if (v136) and (v136.TimeLength > 0) then
            v145 = v136.TimeLength / math.max(0.05, v143)
        else
            v145 = 1.5
        end
        task.delay(
            math.min(v145 + 0.2, 6),
            function()
                --[[
                  line: 784
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
            v137 = {pitch = 0}
            v137.volume = v144
            local v146
            if a3.PlaybackSpeed then
                v146 = v143
            else
                v146 = nil
            end
            v137.pitch = v146
        else
            v137 = nil
        end
        local success_10, v147 = pcall(u3.Play, a1, a2, v137)
        if success_10 then
            if typeof(v147) == "Instance" and v147:IsA("Sound") then
                return v147
            end
            return nil
        end
    end
    if not v136 then
        return nil
    end
    local v148 = v136:GetAttribute("PitchVary")
    local v149 = math.random() * 2 - 1
    local v150
    if type(v148) ~= "number" then
        v150 = 0.05
    else
        v150 = v148
    end
    local u11 = v136:Clone()
    u11.PlaybackSpeed = u11.PlaybackSpeed * (v143 * (1 + (v149 * v150)))
    u11.Volume = u11.Volume * v144
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u11.SoundGroup = SFX_1
    end
    local u12 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u11.Parent = SoundService_upv_1
            u11:Play()
            local v151 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
            task.delay(
                math.min(v151 + 0.2, 12),
                function()
                    --[[
                      line: 823
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
        local v152 = Instance.new("Attachment")
        v152.WorldPosition = a2
        v152.Parent = workspace.Terrain
        u11.Parent = v152
        u12 = v152
    end
    u11:Play()
    local v151 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
    task.delay(
        math.min(v151 + 0.2, 12),
        function()
            --[[
              line: 823
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
      line: 833
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
                      line: 837
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    pcall(u13, a3)
                end
            end
        end
    end
    local v153 = findSound(a1)
    if not v153 then
        return function()
            --[[
              line: 844
            ]]
        end
    end
    local u14 = v153:Clone()
    u14.Looped = true
    u14.Parent = a2 or SoundService_upv_1
    u14:Play()
    return function()
        --[[
          line: 850
          upvalues:
            u14 (copy, index: 1)
        ]]
        u14:Destroy()
    end
end
local u15 = v7:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 861
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
                      line: 869
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
                      line: 876
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
                              line: 880
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
                                          line: 886
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
        local v155 = tbl_upv_11[a2]
        if v155 then
            return v155
        end
        local u16 = u15:FindFirstChild(a2)
        if u16 and u16:IsA("Animation") then
            local success_12, v156 = pcall(
                function()
                    --[[
                      line: 902
                      upvalues:
                        a1 (copy, index: 1)
                        u16 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u16)
                end
            )
            if success_12 and v156 then
                local v157 = u16:GetAttribute("Priority")
                if type(v157) == "string" and (Enum.AnimationPriority[v157]) then
                    v156.Priority = Enum.AnimationPriority[v157]
                else
                    v156.Priority = Enum.AnimationPriority.Action
                end
                local v158 = u16:GetAttribute("Looped")
                if type(v158) == "boolean" then
                    v156.Looped = v158
                end
                tbl_upv_11[a2] = v156
                return v156
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
      line: 925
      upvalues:
        u17 (ref, index: 1)
    ]]
    u17 = a1
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 929
      upvalues:
        u17 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v159 = u17
    local Character_11 = LocalPlayer_upv_1.Character
    if not v159 or not a1 or not Character_11 then
        return
    end
    if a1:IsDescendantOf(Character_11) then
        local v160 = stats()
        local v161 = ((not v160) and 0) or (v160.Take())
        u17:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, v161)
    end
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 937
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u15 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v162 = tbl_upv_1.GetTrack(a1, a2)
    if not v162 then
        return nil
    end
    local v163 = a3 or 1
    local v164 = u15 and (u15:FindFirstChild(a2))
    local v165 = v164 and (v164:GetAttribute("Speed"))
    if type(v165) == "number" then
        v163 = v163 * v165
    end
    v162:Play(a4 or 0.08, a5 or 1, v163)
    return v162
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 955
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        u17 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v166 = stats()
    if v166 then
        v166.Caller(8192)
    end
    local v167 = playAnim(a1, a2, a3, a4, a5)
    if v167 and a2 then
        local v168 = u17
        local Character_12 = LocalPlayer_upv_1.Character
        if v168 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            local v169 = stats()
            local v170 = ((not v169) and 0) or (v169.Take())
            u17:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, v170)
        end
    end
    return v167
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 965
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
    local v171 = u17
    local Character_13 = LocalPlayer_upv_1.Character
    if v171 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        local v172 = stats()
        local v173 = ((not v172) and 0) or (v172.Take())
        u17:FireServer("Hold", a2, a3 or 1, 0.08, 1, v173)
    end
    local function freeze()
        --[[
          name: freeze
          line: 972
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
              line: 978
              upvalues:
                u18 (copy, index: 1)
            ]]
            local v174 = os.clock()
            while u18.Length == 0 do
                if os.clock() - v174 < 2 then
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
      line: 990
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
        local v175 = tbl_upv_10[a1]
        local v176 = v175 and (v175[a2])
        if v176 and v176.IsPlaying then
            v176:Stop(a3 or 0.12)
            local v177 = u17
            local Character_14 = LocalPlayer_upv_1.Character
            if v177 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                local v178 = stats()
                local v179 = ((not v178) and 0) or (v178.Take())
                u17:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, v179)
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 1002
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
      line: 1016
    ]]
    if not a1 then
        return nil
    end
    local v180 = a1:FindFirstChild(a2, true)
    if v180 and v180:IsA("Attachment") then
        return v180.WorldPosition
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
      line: 1040
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v181 = tbl_upv_1.AimPoint()
    local v182 = v181 - a2
    if v182.Magnitude < 3.5 then
        return a2
    end
    local v183 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v182.Unit * (v182.Magnitude - 1.5), v183) then
        return a2
    end
    local v184 = tbl_upv_1.GetAimRay()
    local Unit_7 = v184.Direction.Unit
    local v185 = v184.Origin + Unit_7 * math.max((a1 - v184.Origin):Dot(Unit_7), 0)
    local v186 = v181 - v185
    if not ((v185 - a1).Magnitude > 7) and not (v186.Magnitude < 3.5) and not (v186.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v185 - a1, v183)) and not (workspace:Raycast(v185, v186.Unit * (v186.Magnitude - 1.5), v183)) then
            return v185
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1068
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v187 = LocalPlayer_upv_1.Character
    local _ = v187 and (v187:FindFirstChild("Head"))
    local v188 = v187 and (v187:FindFirstChild("HumanoidRootPart"))
    if v187 then
        v187 = v187.Position
    else
        v187 = (v188 and (v188.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v189 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v189 and not ((v189 - v187).Magnitude > 7) then
        if workspace:Raycast(v187, v189 - v187, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v187, v187))
        end
        return (sightOrigin(v187, v189))
    end
    return v187
end
return tbl_upv_1