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
local u5 = nil
function tbl_upv_1.ParryFacing(a1, a2)
    --[[
      name: ParryFacing
      line: 295
      upvalues:
        u5 (ref,  index: 1)
        Combat_upv_1 (copy, index: 2)
    ]]
    if a1 and a1:GetAttribute("Parrying") == true then
        local HumanoidRootPart_1 = a1:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart_1 and HumanoidRootPart_1:IsA("BasePart") then
            if u5 == nil then
                local success_8, v43 = pcall(Combat_upv_1.Tuning, "katana")
                local v44
                if success_8 and type(v43) == "table" and type(v43.parry) == "table" then
                    v44 = v43.parry.arc or 150
                else
                    v44 = 150
                end
                u5 = math.cos(math.rad(math.min(179, (v44 / 2) + 20)))
            end
            local v45 = a2 * Vector3.new(1, 0, 1)
            local v46 = HumanoidRootPart_1.CFrame.LookVector * Vector3.new(1, 0, 1)
            if not (v45.Magnitude < 0.05) and not (v46.Magnitude < 0.05) then
                local v47 = (-v45.Unit):Dot(v46.Unit)
                local v48 = u5 <= v47
                return v48
            end
            return true
        end
        return false
    end
    return false
end
function tbl_upv_1.CanPredictHit(a1)
    --[[
      name: CanPredictHit
      line: 317
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v49 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v50 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v51
        if type(v50) ~= "string" then
            v51 = ""
        else
            v51 = v50
        end
        local v52
        if v51 == "" then
            v52 = true
        else
            v52 = false
        end
        return v52
    else
        v49 = tbl_upv_1.IsEnemy(a1)
        local v53
        if v49 then
            local v54 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v51
            if type(v54) ~= "string" then
                v51 = ""
            else
                v51 = v54
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v55 = Arenas_2 and (Arenas_2:FindFirstChild(v51))
            local v56 = v55 and (v55:GetAttribute("Phase"))
            v53 = true
            if v56 ~= "Live" then
                v53 = v56 == "Overtime"
            end
        else
            v53 = v49
        end
        return v53
    end
end
local u6 = -math.huge
local u7 = nil
local u8 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 334
      upvalues:
        u6 (ref, index: 1)
        u7 (ref, index: 2)
        u8 (ref, index: 3)
    ]]
    if type(a2) ~= "number" or not (a2 > 0) then
        return
    end
    u6 = os.clock()
    u7 = a1
    u8 = a2
end
function tbl_upv_1.GuardRecovery(a1)
    --[[
      name: GuardRecovery
      line: 340
      upvalues:
        u7 (ref, index: 1)
        u6 (ref, index: 2)
        u8 (ref, index: 3)
    ]]
    if a1 ~= nil and a1 ~= u7 then
        return (math.max(0, (u6 + u8) - os.clock()))
    end
    return 0
end
function tbl_upv_1.CanAct()
    --[[
      name: CanAct
      line: 347
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
    local v57 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v57) == "number" and workspace:GetServerTimeNow() < v57 then
        return false
    end
    local v58 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v58) ~= "string" then
        v57 = ""
    else
        v57 = v58
    end
    local v59 = true
    local v60
    if v57 == "" then
        v60 = v59
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v61 = Arenas_3 and (Arenas_3:FindFirstChild(v57))
        local v62 = v61 and (v61:GetAttribute("Phase"))
        v60 = true
        if v62 ~= "Live" then
            v60 = v62 == "Overtime"
        end
    end
    return v60
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 379
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
      line: 405
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
      line: 367
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v63 = workspace:FindFirstChild(value_6)
        if v63 then
            table.insert(tbl_6, v63)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 415
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v64 = RaycastParams.new()
    v64.FilterType = Enum.RaycastFilterType.Exclude
    local v65 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v65, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v65, value_7)
        end
    end
    v64.FilterDescendantsInstances = v65
    v64.IgnoreWater = true
    return v64
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 434
      upvalues:
        stats (copy, index: 1)
        u2 (ref,  index: 2)
        fxFolders (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local v66 = stats()
    if v66 then
        v66.Caller(16384)
    end
    if u2 then
        if type(u2.GetAimPoint) ~= "function" then
            local v67 = tbl_upv_1.GetAimRay()
            local v68 = a1 or 1000
            local v69 = workspace:Raycast(v67.Origin, v67.Direction.Unit * v68, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v69 then
                return v69.Position, v69
            end
            return v67.Origin + (v67.Direction.Unit * v68), nil
        else
            local v70 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v70, value_8)
            end
            local v71, v72, v73 = pcall(u2.GetAimPoint, a1, v70)
            if v71 then
                if typeof(v72) == "Vector3" then
                    return v72, v73
                end
                local v67 = tbl_upv_1.GetAimRay()
                local v68 = a1 or 1000
                local v69 = workspace:Raycast(v67.Origin, v67.Direction.Unit * v68, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v69 then
                    return v69.Position, v69
                end
                return v67.Origin + (v67.Direction.Unit * v68), nil
            else
                local v67 = tbl_upv_1.GetAimRay()
                local v68 = a1 or 1000
                local v69 = workspace:Raycast(v67.Origin, v67.Direction.Unit * v68, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v69 then
                    return v69.Position, v69
                end
                return v67.Origin + (v67.Direction.Unit * v68), nil
            end
        end
    else
        local v67 = tbl_upv_1.GetAimRay()
        local v68 = a1 or 1000
        local v69 = workspace:Raycast(v67.Origin, v67.Direction.Unit * v68, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v69 then
            return v69.Position, v69
        end
        return v67.Origin + (v67.Direction.Unit * v68), nil
    end
end
function tbl_upv_1.AimDirection(a1, ...)
    --[[
      name: AimDirection
      line: 457
      upvalues:
        tbl_upv_1 (copy, index: 1)
        stats (copy, index: 2)
    ]]
    local v74 = tbl_upv_1.Probe(a1, ...)
    if v74 ~= nil then
        return v74
    end
    local v75 = stats()
    if v75 then
        v75.Caller(16384)
    end
    local v76 = tbl_upv_1.GetAimRay()
    local v77 = tbl_upv_1.AimPoint() - a1
    if not (v77.Magnitude < 2) and not (v77.Unit:Dot(v76.Direction.Unit) < 0.2) then
        return v77.Unit
    end
    return v76.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 498
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v78 = LocalPlayer_upv_1:GetAttribute(a1)
        local v79
        if type(v78) ~= "number" then
            v79 = 0
        else
            v79 = v78
        end
        LocalPlayer_upv_1:SetAttribute(a1, v79 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 505
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v80 = u2 and (u2[a1])
    if type(v80) ~= "function" then
        return nil
    end
    local success_9, v81 = pcall(v80, ...)
    if success_9 then
        return v81
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 515
      upvalues:
        u2 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u2 and camCall("GetAimAssistEnabled") ~= false then
        local v82 = camCall("IsAssistedInput") == true
        return v82
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 524
    ]]
    local v83 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v83 and v83:IsA("BasePart") then
        local v84 = nil
        if a4 then
            v84 = Vector3.new(a2.X, 0, a2.Z)
            if v84.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v84.Unit
            local v85 = Vector3.new(v83.Position.X - a1.X, 0, v83.Position.Z - a1.Z)
            local v86 = v85:Dot(Unit_1)
            return (v86 > 0) and ((v85 - (Unit_1 * v86)).Magnitude <= 1.1)
        else
            local v87 = v83.Position - Vector3.new(0, 2.200000047683716, 0)
            local v88
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v88 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v88 = v83.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v89 = v88 - v87
            local v90 = v87 - a1
            local v91 = v89:Dot(v89)
            local v92 = v89:Dot(Unit_2)
            local v93 = v91 - v92 * v92
            local v94 = ((not (v93 > 1e-06)) and 0) or (math.clamp((v92 * Unit_2:Dot(v90) - v89:Dot(v90)) / v93, 0, 1))
            local v95 = v87 + v89 * v94
            local v96 = (v95 - a1):Dot(Unit_2)
            return (v96 > 0) and (((v95 - a1) - (Unit_2 * v96)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 556
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
    ]]
    local v97 = stats()
    if v97 then
        v97.Caller(16384)
    end
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v98 = camCall("GetAimAssistShot")
    if type(v98) == "table" and v98.torsoVisible and typeof(v98.point) == "Vector3" and typeof(v98.model) == "Instance" then
        local model_1 = v98.model
        local point_1 = v98.point
        local v99 = (tbl_upv_1.ASSIST_MAGNET[v98.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v98.class]
        if type(v99) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v100 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v100 and not (v100.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v101 = nil
            if a3 then
                v101 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v102 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v101.Magnitude < 0.001) and not (v102 < 0.001) then
                    v101 = v101.Unit * v102
                    Unit_3 = Vector3.new(v101.X, a2.Y, v101.Z).Unit
                    local Unit_4 = a2.Unit
                    local v103 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v104 = math.rad(v99)
                    local v105 = nil
                    if RunService_upv_1:IsStudio() then
                        v105 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v106
                        if type(v105) ~= "number" then
                            v106 = 0
                        else
                            v106 = v105
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v106 + 1)
                    end
                    if (v103 <= v104) or (v103 < 1e-04) then
                        return Unit_3
                    end
                    local v107 = v104 / v103
                    local v108 = math.sin(v103)
                    return (Unit_4 * (math.sin((1 - v107) * v103) / v108) + (Unit_3 * (math.sin(v107 * v103) / v108))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v103 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v104 = math.rad(v99)
            local v105 = nil
            if RunService_upv_1:IsStudio() then
                v105 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v106
                if type(v105) ~= "number" then
                    v106 = 0
                else
                    v106 = v105
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v106 + 1)
            end
            if (v103 <= v104) or (v103 < 1e-04) then
                return Unit_3
            end
            local v107 = v104 / v103
            local v108 = math.sin(v103)
            return (Unit_4 * (math.sin((1 - v107) * v103) / v108) + (Unit_3 * (math.sin(v107 * v103) / v108))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 608
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
    local v109 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v110 = LocalPlayer_upv_1.Character
    local v111 = v110 and (v110:FindFirstChild("HumanoidRootPart"))
    if not v109 or not v111 or not v111:IsA("BasePart") then
        return 0
    end
    local Head_2 = v110:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v110 = Head_2.Position
    else
        v110 = v111.Position
    end
    local v112 = tbl_upv_1.GetAimRay()
    local v113 = Vector3.new(v112.Direction.X, 0, v112.Direction.Z)
    if v113.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v113.Unit
    v112 = math.cos(math.rad(v109.cone))
    local v114 = tbl_upv_1.Targets()
    local v115 = nil
    local v116 = nil
    local Unit_6 = math.huge
    local v117 = v115
    for _, value_9 in v114 do
        local v118 = tbl_upv_1.CanPredictHit(value_9)
        if not (v118) then
            continue
        end
        local v119 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_2 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v119) or v119.Health <= 0 or not (HumanoidRootPart_2) then
            continue
        end
        local v120 = HumanoidRootPart_2:IsA("BasePart")
        if not (v120) then
            continue
        end
        local v121 = HumanoidRootPart_2.Position - v110.Position
        local v122 = Vector3.new(v121.X, 0, v121.Z)
        local Magnitude_1 = v122.Magnitude
        if a1 + v109.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v121.Y) > 6 then
            continue
        end
        v121 = v122.Unit:Dot(Unit_5)
        if v121 < v112 then
            continue
        end
        local v123 = (1 - v121) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v123 then
            continue
        end
        local v124 = Combat_upv_1.SmokeBlocks(v110, HumanoidRootPart_2.Position)
        if v124 then
            continue
        end
        v124 = v117 or (tbl_upv_1.WorldParams(v114))
        v124 = workspace:Raycast(v110, HumanoidRootPart_2.Position - v110, v124)
        if not (v124) then
            Unit_6, v116 = v123, HumanoidRootPart_2.Position
        end
    end
    if not v116 then
        return 0
    end
    Unit_6 = Vector3.new(v116.X - v110.Position.X, 0, v116.Z - v110.Position.Z).Unit
    local v125 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v125) < 0.05235987755982989 then
        return 0
    end
    local v126 = math.clamp(v125, -math.rad(v109.max), math.rad(v109.max))
    camCall("Nudge", v126, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v127
        if type(Unit_6) ~= "number" then
            v127 = 0
        else
            v127 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v127 + 1)
    end
    return (math.deg(v126))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u9 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 684
      upvalues:
        u9 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u9 == nil then
        local success_10, v128 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v129
        if success_10 then
            v129 = v128
        else
            v129 = false
        end
        u9 = v129
    end
    if u9 and type(u9.AltAmmo) == "function" then
        return (u9.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 693
    ]]
    local v130 = a1:GetAttribute("Ammo_" .. a2)
    if type(v130) ~= "number" then
        return 0
    end
    return v130
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 699
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v131 = a1:GetAttribute("Ammo_" .. a2)
    local v132
    if type(v131) ~= "number" then
        v132 = 0
    else
        v132 = v131
    end
    local v133 = nil
    for _, value_10 in altAmmo(a2) do
        local v134 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v134) ~= "number" then
            v133 = 0
        else
            v133 = v134
        end
        v132 = v132 + v133
    end
    return v132
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 711
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v135 = nil
        for _, value_11 in altAmmo(a2) do
            local v136 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v136) ~= "number" then
                v135 = 0
            else
                v135 = v136
            end
            if not (v135 >= 1) then
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
      line: 725
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v137 = tbl_upv_1.AmmoNext(a1, a2)
    if v137 and a1 then
        local v138 = a1:GetAttribute("Ammo_" .. v137)
        local v139
        if type(v138) ~= "number" then
            v139 = 0
        else
            v139 = v138
        end
        return v139, tbl_upv_1.AMMO_NOUN[v137] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 734
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
      line: 739
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u10 = v9:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u11 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 777
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
      line: 751
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u10 (copy, index: 2)
    ]]
    local v140 = tbl_upv_8[a1]
    if v140 ~= nil then
        return v140 or nil
    end
    if not u10 then
        return nil
    end
    local v141 = u10
    for key_1 in string.gmatch(a1, "[^/]+") do
        v141 = v141 and v141:FindFirstChild(key_1)
    end
    v141 = v141 or (u10:FindFirstChild(a1, true))
    local v143 = not (v141) or not (v141:IsA("Sound")) or v141
    tbl_upv_8[a1] = v143 or false
    return v143
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 793
      upvalues:
        findSound (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u11 (ref,  index: 3)
        Quality_upv_1 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        Metrics_upv_1 (copy, index: 6)
        u3 (ref,  index: 7)
        SoundService_upv_1 (copy, index: 8)
    ]]
    local v144 = findSound(a1)
    local v145
    if typeof(a2) == "Vector3" then
        v145 = a2
    elseif typeof(a2) ~= "Instance" then
        v145 = nil
    elseif a2:IsA("BasePart") then
        v145 = a2.Position
    elseif a2:IsA("Attachment") then
        v145 = a2.WorldPosition
    else
        v145 = nil
    end
    local v146 = nil
    if v145 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v146 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v147 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v145).Magnitude)
        if not (v146) then
            local v148 = ((not v144) and 200) or (math.clamp(v144.RollOffMaxDistance, 60, 250))
            if v148 < v147 or Quality_upv_1.maxSounds <= u11 and v147 > 25 then
                return nil
            end
            local v149 = os.clock()
            local v150 = tbl_upv_9[a1]
            if v150 and v149 - v150.t < 0.035 and (v150.p - v145).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v149, p = v145}
        end
    end
    local v151 = (a3 and (a3.PlaybackSpeed)) or 1
    local v152 = (a3 and (a3.Volume)) or 1
    if v145 then
        u11 = u11 + 1
        Metrics_upv_1.sounds = u11
        local v153
        if (v144) and (v144.TimeLength > 0) then
            v153 = v144.TimeLength / math.max(0.05, v151)
        else
            v153 = 1.5
        end
        task.delay(
            math.min(v153 + 0.2, 6),
            function()
                --[[
                  line: 823
                  upvalues:
                    u11 (ref,  index: 1)
                    Metrics_upv_1 (copy, index: 2)
                ]]
                u11 = u11 - 1
                Metrics_upv_1.sounds = u11
            end
        )
    end
    if u3 then
        if a3 then
            v145 = {pitch = 0}
            v145.volume = v152
            local v154
            if a3.PlaybackSpeed then
                v154 = v151
            else
                v154 = nil
            end
            v145.pitch = v154
        else
            v145 = nil
        end
        local success_11, v155 = pcall(u3.Play, a1, a2, v145)
        if success_11 then
            if typeof(v155) == "Instance" and v155:IsA("Sound") then
                return v155
            end
            return nil
        end
    end
    if not v144 then
        return nil
    end
    local v156 = v144:GetAttribute("PitchVary")
    local v157 = math.random() * 2 - 1
    local v158
    if type(v156) ~= "number" then
        v158 = 0.05
    else
        v158 = v156
    end
    local u12 = v144:Clone()
    u12.PlaybackSpeed = u12.PlaybackSpeed * (v151 * (1 + (v157 * v158)))
    u12.Volume = u12.Volume * v152
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u12.SoundGroup = SFX_1
    end
    local u13 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u12.Parent = SoundService_upv_1
            u12:Play()
            local v159 = ((u12.TimeLength > 0) and (u12.TimeLength / math.max(0.05, u12.PlaybackSpeed))) or 3
            task.delay(
                math.min(v159 + 0.2, 12),
                function()
                    --[[
                      line: 862
                      upvalues:
                        u12 (copy, index: 1)
                        u13 (ref,  index: 2)
                    ]]
                    u12:Destroy()
                    if not u13 then
                        return
                    end
                    u13:Destroy()
                end
            )
            return u12
        end
        u12.Parent = a2
    else
        local v160 = Instance.new("Attachment")
        v160.WorldPosition = a2
        v160.Parent = workspace.Terrain
        u12.Parent = v160
        u13 = v160
    end
    u12:Play()
    local v159 = ((u12.TimeLength > 0) and (u12.TimeLength / math.max(0.05, u12.PlaybackSpeed))) or 3
    task.delay(
        math.min(v159 + 0.2, 12),
        function()
            --[[
              line: 862
              upvalues:
                u12 (copy, index: 1)
                u13 (ref,  index: 2)
            ]]
            u12:Destroy()
            if not u13 then
                return
            end
            u13:Destroy()
        end
    )
    return u12
end
function tbl_upv_1.Loop(a1, a2)
    --[[
      name: Loop
      line: 872
      upvalues:
        u3 (ref,  index: 1)
        findSound (copy, index: 2)
        SoundService_upv_1 (copy, index: 3)
    ]]
    if u3 then
        local u14
        if type(u3.Loop) == "function" then
            local success_12, u14 = pcall(u3.Loop, a1, a2)
            if success_12 and type(u14) == "function" then
                return function(a3)
                    --[[
                      line: 876
                      upvalues:
                        u14 (copy, index: 1)
                    ]]
                    pcall(u14, a3)
                end
            end
        end
    end
    local v161 = findSound(a1)
    if not v161 then
        return function()
            --[[
              line: 883
            ]]
        end
    end
    local u15 = v161:Clone()
    u15.Looped = true
    u15.Parent = a2 or SoundService_upv_1
    u15:Play()
    return function()
        --[[
          line: 889
          upvalues:
            u15 (copy, index: 1)
        ]]
        u15:Destroy()
    end
end
local u16 = v9:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 900
      upvalues:
        u16 (copy, index: 1)
        tbl_upv_10 (copy, index: 2)
    ]]
    if a1 and u16 then
        local tbl_upv_11 = tbl_upv_10[a1]
        if not (tbl_upv_11) then
            tbl_upv_11 = {}
            tbl_upv_10[a1] = tbl_upv_11
            a1.Destroying:Once(
                function()
                    --[[
                      line: 908
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
                      line: 915
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
                              line: 919
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
                                          line: 925
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
        local v163 = tbl_upv_11[a2]
        if v163 then
            return v163
        end
        local u17 = u16:FindFirstChild(a2)
        if u17 and u17:IsA("Animation") then
            local success_13, v164 = pcall(
                function()
                    --[[
                      line: 941
                      upvalues:
                        a1 (copy, index: 1)
                        u17 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u17)
                end
            )
            if success_13 and v164 then
                local v165 = u17:GetAttribute("Priority")
                if type(v165) == "string" and (Enum.AnimationPriority[v165]) then
                    v164.Priority = Enum.AnimationPriority[v165]
                else
                    v164.Priority = Enum.AnimationPriority.Action
                end
                local v166 = u17:GetAttribute("Looped")
                if type(v166) == "boolean" then
                    v164.Looped = v166
                end
                tbl_upv_11[a2] = v164
                return v164
            end
            return nil
        end
        return nil
    end
    return nil
end
local u18 = nil
function tbl_upv_1.SetAnimRelay(a1)
    --[[
      name: SetAnimRelay
      line: 964
      upvalues:
        u18 (ref, index: 1)
    ]]
    u18 = a1
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 968
      upvalues:
        u18 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v167 = u18
    local Character_11 = LocalPlayer_upv_1.Character
    if not v167 or not a1 or not Character_11 then
        return
    end
    if a1:IsDescendantOf(Character_11) then
        local v168 = stats()
        local v169 = ((not v168) and 0) or (v168.Take())
        u18:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, v169)
    end
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 976
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u16 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v170 = tbl_upv_1.GetTrack(a1, a2)
    if not v170 then
        return nil
    end
    local v171 = a3 or 1
    local v172 = u16 and (u16:FindFirstChild(a2))
    local v173 = v172 and (v172:GetAttribute("Speed"))
    if type(v173) == "number" then
        v171 = v171 * v173
    end
    v170:Play(a4 or 0.08, a5 or 1, v171)
    return v170
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 994
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        u18 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v174 = stats()
    if v174 then
        v174.Caller(8192)
    end
    local v175 = playAnim(a1, a2, a3, a4, a5)
    if v175 and a2 then
        local v176 = u18
        local Character_12 = LocalPlayer_upv_1.Character
        if v176 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            local v177 = stats()
            local v178 = ((not v177) and 0) or (v177.Take())
            u18:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, v178)
        end
    end
    return v175
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 1004
      upvalues:
        playAnim (copy, index: 1)
        u18 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        stats (copy, index: 4)
    ]]
    local u19 = playAnim(a1, a2, a3, 0.08)
    if not u19 then
        return nil
    end
    local v179 = u18
    local Character_13 = LocalPlayer_upv_1.Character
    if v179 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        local v180 = stats()
        local v181 = ((not v180) and 0) or (v180.Take())
        u18:FireServer("Hold", a2, a3 or 1, 0.08, 1, v181)
    end
    local function freeze()
        --[[
          name: freeze
          line: 1011
          upvalues:
            u19 (copy, index: 1)
        ]]
        if not u19.IsPlaying then
            return
        end
        u19.TimePosition = math.max(0, u19.Length - 0.03)
        u19:AdjustSpeed(0)
    end
    task.spawn(
        function()
            --[[
              line: 1017
              upvalues:
                u19 (copy, index: 1)
            ]]
            local v182 = os.clock()
            while u19.Length == 0 do
                if os.clock() - v182 < 2 then
                    task.wait()
                    continue
                else
                    break
                end
            end
            task.wait((math.max(0, (u19.Length / math.max(0.05, u19.Speed)) - 0.04)))
            if not u19.IsPlaying then
                return
            end
            u19.TimePosition = math.max(0, u19.Length - 0.03)
            u19:AdjustSpeed(0)
        end
    )
    return u19
end
function tbl_upv_1.StopAnim(a1, a2, a3)
    --[[
      name: StopAnim
      line: 1029
      upvalues:
        tbl_upv_10 (copy, index: 1)
        u18 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        stats (copy, index: 4)
    ]]
    if not a1 then
        return
    end
    if a2 then
        local v183 = tbl_upv_10[a1]
        local v184 = v183 and (v183[a2])
        if v184 and v184.IsPlaying then
            v184:Stop(a3 or 0.12)
            local v185 = u18
            local Character_14 = LocalPlayer_upv_1.Character
            if v185 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                local v186 = stats()
                local v187 = ((not v186) and 0) or (v186.Take())
                u18:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, v187)
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 1041
      upvalues:
        u16 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not u16 then
        return
    end
    for _, value_14 in u16:GetChildren() do
        if value_14:IsA("Animation") then
            tbl_upv_1.GetTrack(a1, value_14.Name)
        end
    end
end
function tbl_upv_1.ToolPoint(a1, a2)
    --[[
      name: ToolPoint
      line: 1055
    ]]
    if not a1 then
        return nil
    end
    local v188 = a1:FindFirstChild(a2, true)
    if v188 and v188:IsA("Attachment") then
        return v188.WorldPosition
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
      line: 1079
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v189 = tbl_upv_1.AimPoint()
    local v190 = v189 - a2
    if v190.Magnitude < 3.5 then
        return a2
    end
    local v191 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v190.Unit * (v190.Magnitude - 1.5), v191) then
        return a2
    end
    local v192 = tbl_upv_1.GetAimRay()
    local Unit_7 = v192.Direction.Unit
    local v193 = v192.Origin + Unit_7 * math.max((a1 - v192.Origin):Dot(Unit_7), 0)
    local v194 = v189 - v193
    if not ((v193 - a1).Magnitude > 7) and not (v194.Magnitude < 3.5) and not (v194.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v193 - a1, v191)) and not (workspace:Raycast(v193, v194.Unit * (v194.Magnitude - 1.5), v191)) then
            return v193
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1107
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v195 = LocalPlayer_upv_1.Character
    local _ = v195 and (v195:FindFirstChild("Head"))
    local v196 = v195 and (v195:FindFirstChild("HumanoidRootPart"))
    if v195 then
        v195 = v195.Position
    else
        v195 = (v196 and (v196.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v197 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v197 and not ((v197 - v195).Magnitude > 7) then
        if workspace:Raycast(v195, v197 - v195, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v195, v195))
        end
        return (sightOrigin(v195, v197))
    end
    return v195
end
return tbl_upv_1