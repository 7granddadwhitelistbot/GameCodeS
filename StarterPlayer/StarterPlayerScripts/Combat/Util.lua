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
local function caller(a1)
    --[[
      name: caller
      line: 37
      upvalues:
        stats (copy, index: 1)
    ]]
    local v4 = stats()
    if not v4 then
        return
    end
    v4.Caller(a1)
end
local v5 = ReplicatedStorage_1:WaitForChild("Assets", 30)
tbl_upv_1.Assets = v5
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local u2 = nil
local u3 = nil
task.spawn(
    function()
        --[[
          line: 53
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v6 = Shared_upv_1:WaitForChild("Camera", 12)
        if not v6 then
            return
        end
        if v6:IsA("ModuleScript") then
            local success_1, v7 = pcall(require, v6)
            if not success_1 or type(v7) ~= "table" then
                warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", v7)
            end
            u2 = v7
        end
    end
)
task.spawn(
    function()
        --[[
          line: 64
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v8 = Shared_upv_1:WaitForChild("Sfx", 20)
        if not v8 then
            return
        end
        if v8:IsA("ModuleScript") then
            local success_2, v9 = pcall(require, v8)
            if not success_2 or type(v9) ~= "table" or type(v9.Play) ~= "function" then
                return
            end
            u3 = v9
        end
    end
)
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 74
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 83
      upvalues:
        u2 (ref, index: 1)
    ]]
    if a1 and u2 and type(u2.Drawn) == "function" then
        local success_3, v10 = pcall(u2.Drawn, a1)
        if success_3 and typeof(v10) == "Instance" then
            return v10
        end
    end
    return a1
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 97
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v11 = (u2 ~= nil) and ((type(u2.InFirstPerson) == "function") and (u2.InFirstPerson() == true))
    return v11
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 101
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.GetAimRay) == "function" then
        local success_4, v12 = pcall(u2.GetAimRay)
        if success_4 and typeof(v12) == "Ray" then
            return v12
        end
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    local ViewportSize_1 = CurrentCamera_1.ViewportSize
    return CurrentCamera_1:ViewportPointToRay(ViewportSize_1.X / 2, ViewportSize_1.Y / 2)
end
function tbl_upv_1.SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 113
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.SetAiming) == "function" then
        pcall(u2.SetAiming, a1, a2)
        return
    end
    local TweenService_1 = game:GetService("TweenService")
    local v13 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_2 = {FieldOfView = 0}
    tbl_2.FieldOfView = ((not a1) and 70) or (a2 or 55)
    TweenService_1:Create(workspace.CurrentCamera, v13, tbl_2):Play()
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 125
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
      line: 131
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.Shake) ~= "function" then
        return
    end
    pcall(u2.Shake, a1, a2)
end
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 139
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if u2 and type(u2.RecoilSlow) == "function" then
        pcall(u2.RecoilSlow, a1, a2, a3, a4)
    else
        tbl_upv_1.Recoil(a1 * 5, (a2 or 0) * 5)
    end
end
function tbl_upv_1.Recoil(a1, a2)
    --[[
      name: Recoil
      line: 148
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.Recoil) ~= "function" then
        return
    end
    pcall(u2.Recoil, a1, a2)
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 154
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.IsMouseUnlocked) == "function" then
        local success_5, v14 = pcall(u2.IsMouseUnlocked)
        return success_5 and (v14 == true)
    end
    return false
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 163
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
      line: 170
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.SetModifier) ~= "function" then
        return
    end
    if a2 and a2.pivot and type(u2.GetShoulderSide) == "function" then
        local success_6, v15 = pcall(u2.GetShoulderSide)
        if success_6 and type(v15) == "number" then
            local pivot_1 = a2.pivot
            a2 = table.clone(a2)
            a2.pivot = Vector3.new(pivot_1.X * v15, pivot_1.Y, pivot_1.Z)
        end
    end
    pcall(u2.SetModifier, a1, a2)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 184
    ]]
    return workspace.CurrentCamera.FieldOfView
end
local function matchOf(a1)
    --[[
      name: matchOf
      line: 190
    ]]
    local v16 = a1 and (a1:GetAttribute("MatchId"))
    if type(v16) ~= "string" then
        return ""
    end
    return v16
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 196
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v17 = Character_1 and (Character_1:GetAttribute("MatchId"))
    local v18
    if type(v17) ~= "string" then
        v18 = ""
    else
        v18 = v17
    end
    local v19
    if v18 ~= "" then
        v19 = true
    else
        v19 = false
    end
    return v19
end
local function phaseLive(a1)
    --[[
      name: phaseLive
      line: 200
    ]]
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v20 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
    local v21 = v20 and (v20:GetAttribute("Phase"))
    local v22 = true
    if v21 ~= "Live" then
        v22 = v21 == "Overtime"
    end
    return v22
end
function tbl_upv_1.IsEnemy(a1)
    --[[
      name: IsEnemy
      line: 208
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if a1 and Character_2 and a1 ~= Character_2 then
        local v23 = Character_2 and (Character_2:GetAttribute("MatchId"))
        local v24
        if type(v23) ~= "string" then
            v24 = ""
        else
            v24 = v23
        end
        if v24 ~= "" then
            local v25 = a1 and (a1:GetAttribute("MatchId"))
            if type(v25) ~= "string" then
                v23 = ""
            else
                v23 = v25
            end
            if v23 == v24 then
                v23 = Character_2:GetAttribute("Team")
                local v26 = a1:GetAttribute("Team")
                return (v23 ~= nil) and ((v26 ~= nil) and (v23 ~= v26))
            end
        end
        return false
    end
    return false
end
function tbl_upv_1.IsTeammate(a1)
    --[[
      name: IsTeammate
      line: 221
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if a1 and Character_3 and a1 ~= Character_3 then
        local v27 = Character_3 and (Character_3:GetAttribute("MatchId"))
        local v28
        if type(v27) ~= "string" then
            v28 = ""
        else
            v28 = v27
        end
        local v29 = false
        local v30
        if v28 == "" then
            v30 = v29
        else
            v30 = false
            local v31 = a1 and (a1:GetAttribute("MatchId"))
            local v32
            if type(v31) ~= "string" then
                v32 = ""
            else
                v32 = v31
            end
            if v32 == v28 then
                v30 = a1:GetAttribute("Team") == Character_3:GetAttribute("Team")
            end
        end
        return v30
    end
    return false
end
local u4 = nil
function tbl_upv_1.ItemBonus(a1)
    --[[
      name: ItemBonus
      line: 234
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        Shared_upv_1 (copy, index: 3)
    ]]
    local Character_4 = LocalPlayer_upv_1.Character
    if Character_4 and type(a1) == "string" then
        local v33 = Character_4:GetAttribute("ItemLevels")
        if type(v33) == "string" and v33 ~= "" then
            if u4 == nil then
                local success_7, v34 = pcall(require, Shared_upv_1:FindFirstChild("Shards"))
                local v35
                if (success_7) and type(v34) == "table" then
                    v35 = v34
                else
                    v35 = false
                end
                u4 = v35
            end
            if u4 then
                return u4.Bonus(u4.DecodeLevels(v33)[a1] or 1)
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
      line: 255
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v36 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v37 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v38
        if type(v37) ~= "string" then
            v38 = ""
        else
            v38 = v37
        end
        local v39
        if v38 == "" then
            v39 = true
        else
            v39 = false
        end
        return v39
    else
        v36 = tbl_upv_1.IsEnemy(a1)
        local v40
        if v36 then
            local v41 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v38
            if type(v41) ~= "string" then
                v38 = ""
            else
                v38 = v41
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v42 = Arenas_2 and (Arenas_2:FindFirstChild(v38))
            local v43 = v42 and (v42:GetAttribute("Phase"))
            v40 = true
            if v43 ~= "Live" then
                v40 = v43 == "Overtime"
            end
        else
            v40 = v36
        end
        return v40
    end
end
local u5 = -math.huge
local u6 = nil
local u7 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 272
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
      line: 278
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
      line: 285
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
    local v44 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v44) == "number" and workspace:GetServerTimeNow() < v44 then
        return false
    end
    local v45 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v45) ~= "string" then
        v44 = ""
    else
        v44 = v45
    end
    local v46 = true
    local v47
    if v44 == "" then
        v47 = v46
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v48 = Arenas_3 and (Arenas_3:FindFirstChild(v44))
        local v49 = v48 and (v48:GetAttribute("Phase"))
        v47 = true
        if v49 ~= "Live" then
            v47 = v49 == "Overtime"
        end
    end
    return v47
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 317
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
      line: 343
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
      line: 305
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v50 = workspace:FindFirstChild(value_6)
        if v50 then
            table.insert(tbl_6, v50)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 353
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v51 = RaycastParams.new()
    v51.FilterType = Enum.RaycastFilterType.Exclude
    local v52 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v52, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v52, value_7)
        end
    end
    v51.FilterDescendantsInstances = v52
    v51.IgnoreWater = true
    return v51
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 372
      upvalues:
        stats (copy, index: 1)
        u2 (ref,  index: 2)
        fxFolders (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local v53 = stats()
    if v53 then
        v53.Caller(16384)
    end
    if u2 then
        if type(u2.GetAimPoint) ~= "function" then
            local v54 = tbl_upv_1.GetAimRay()
            local v55 = a1 or 1000
            local v56 = workspace:Raycast(v54.Origin, v54.Direction.Unit * v55, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v56 then
                return v56.Position, v56
            end
            return v54.Origin + (v54.Direction.Unit * v55), nil
        else
            local v57 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v57, value_8)
            end
            local v58, v59, v60 = pcall(u2.GetAimPoint, a1, v57)
            if v58 then
                if typeof(v59) == "Vector3" then
                    return v59, v60
                end
                local v54 = tbl_upv_1.GetAimRay()
                local v55 = a1 or 1000
                local v56 = workspace:Raycast(v54.Origin, v54.Direction.Unit * v55, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v56 then
                    return v56.Position, v56
                end
                return v54.Origin + (v54.Direction.Unit * v55), nil
            else
                local v54 = tbl_upv_1.GetAimRay()
                local v55 = a1 or 1000
                local v56 = workspace:Raycast(v54.Origin, v54.Direction.Unit * v55, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v56 then
                    return v56.Position, v56
                end
                return v54.Origin + (v54.Direction.Unit * v55), nil
            end
        end
    else
        local v54 = tbl_upv_1.GetAimRay()
        local v55 = a1 or 1000
        local v56 = workspace:Raycast(v54.Origin, v54.Direction.Unit * v55, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v56 then
            return v56.Position, v56
        end
        return v54.Origin + (v54.Direction.Unit * v55), nil
    end
end
function tbl_upv_1.AimDirection(a1)
    --[[
      name: AimDirection
      line: 395
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v61 = stats()
    if v61 then
        v61.Caller(16384)
    end
    local v62 = tbl_upv_1.GetAimRay()
    local v63 = tbl_upv_1.AimPoint() - a1
    if not (v63.Magnitude < 2) and not (v63.Unit:Dot(v62.Direction.Unit) < 0.2) then
        return v63.Unit
    end
    return v62.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 432
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v64 = LocalPlayer_upv_1:GetAttribute(a1)
        local v65
        if type(v64) ~= "number" then
            v65 = 0
        else
            v65 = v64
        end
        LocalPlayer_upv_1:SetAttribute(a1, v65 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 439
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v66 = u2 and (u2[a1])
    if type(v66) ~= "function" then
        return nil
    end
    local success_8, v67 = pcall(v66, ...)
    if success_8 then
        return v67
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 449
      upvalues:
        u2 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u2 and camCall("GetAimAssistEnabled") ~= false then
        local v68 = camCall("IsAssistedInput") == true
        return v68
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 458
    ]]
    local v69 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v69 and v69:IsA("BasePart") then
        local v70 = nil
        if a4 then
            v70 = Vector3.new(a2.X, 0, a2.Z)
            if v70.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v70.Unit
            local v71 = Vector3.new(v69.Position.X - a1.X, 0, v69.Position.Z - a1.Z)
            local v72 = v71:Dot(Unit_1)
            return (v72 > 0) and ((v71 - (Unit_1 * v72)).Magnitude <= 1.1)
        else
            local v73 = v69.Position - Vector3.new(0, 2.200000047683716, 0)
            local v74
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v74 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v74 = v69.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v75 = v74 - v73
            local v76 = v73 - a1
            local v77 = v75:Dot(v75)
            local v78 = v75:Dot(Unit_2)
            local v79 = v77 - v78 * v78
            local v80 = ((not (v79 > 1e-06)) and 0) or (math.clamp((v78 * Unit_2:Dot(v76) - v75:Dot(v76)) / v79, 0, 1))
            local v81 = v73 + v75 * v80
            local v82 = (v81 - a1):Dot(Unit_2)
            return (v82 > 0) and (((v81 - a1) - (Unit_2 * v82)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 490
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
    ]]
    local v83 = stats()
    if v83 then
        v83.Caller(16384)
    end
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v84 = camCall("GetAimAssistShot")
    if type(v84) == "table" and v84.torsoVisible and typeof(v84.point) == "Vector3" and typeof(v84.model) == "Instance" then
        local model_1 = v84.model
        local point_1 = v84.point
        local v85 = (tbl_upv_1.ASSIST_MAGNET[v84.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v84.class]
        if type(v85) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v86 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v86 and not (v86.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v87 = nil
            if a3 then
                v87 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v88 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v87.Magnitude < 0.001) and not (v88 < 0.001) then
                    v87 = v87.Unit * v88
                    Unit_3 = Vector3.new(v87.X, a2.Y, v87.Z).Unit
                    local Unit_4 = a2.Unit
                    local v89 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v90 = math.rad(v85)
                    local v91 = nil
                    if RunService_upv_1:IsStudio() then
                        v91 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v92
                        if type(v91) ~= "number" then
                            v92 = 0
                        else
                            v92 = v91
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v92 + 1)
                    end
                    if (v89 <= v90) or (v89 < 1e-04) then
                        return Unit_3
                    end
                    local v93 = v90 / v89
                    local v94 = math.sin(v89)
                    return (Unit_4 * (math.sin((1 - v93) * v89) / v94) + (Unit_3 * (math.sin(v93 * v89) / v94))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v89 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v90 = math.rad(v85)
            local v91 = nil
            if RunService_upv_1:IsStudio() then
                v91 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v92
                if type(v91) ~= "number" then
                    v92 = 0
                else
                    v92 = v91
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v92 + 1)
            end
            if (v89 <= v90) or (v89 < 1e-04) then
                return Unit_3
            end
            local v93 = v90 / v89
            local v94 = math.sin(v89)
            return (Unit_4 * (math.sin((1 - v93) * v89) / v94) + (Unit_3 * (math.sin(v93 * v89) / v94))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 542
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
    local v95 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v96 = LocalPlayer_upv_1.Character
    local v97 = v96 and (v96:FindFirstChild("HumanoidRootPart"))
    if not v95 or not v97 or not v97:IsA("BasePart") then
        return 0
    end
    local Head_2 = v96:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v96 = Head_2.Position
    else
        v96 = v97.Position
    end
    local v98 = tbl_upv_1.GetAimRay()
    local v99 = Vector3.new(v98.Direction.X, 0, v98.Direction.Z)
    if v99.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v99.Unit
    v98 = math.cos(math.rad(v95.cone))
    local v100 = tbl_upv_1.Targets()
    local v101 = nil
    local v102 = nil
    local Unit_6 = math.huge
    local v103 = v101
    for _, value_9 in v100 do
        local v104 = tbl_upv_1.CanPredictHit(value_9)
        if not (v104) then
            continue
        end
        local v105 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v105) or v105.Health <= 0 or not (HumanoidRootPart_1) then
            continue
        end
        local v106 = HumanoidRootPart_1:IsA("BasePart")
        if not (v106) then
            continue
        end
        local v107 = HumanoidRootPart_1.Position - v96.Position
        local v108 = Vector3.new(v107.X, 0, v107.Z)
        local Magnitude_1 = v108.Magnitude
        if a1 + v95.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v107.Y) > 6 then
            continue
        end
        v107 = v108.Unit:Dot(Unit_5)
        if v107 < v98 then
            continue
        end
        local v109 = (1 - v107) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v109 then
            continue
        end
        local v110 = Combat_upv_1.SmokeBlocks(v96, HumanoidRootPart_1.Position)
        if v110 then
            continue
        end
        v110 = v103 or (tbl_upv_1.WorldParams(v100))
        v110 = workspace:Raycast(v96, HumanoidRootPart_1.Position - v96, v110)
        if not (v110) then
            Unit_6, v102 = v109, HumanoidRootPart_1.Position
        end
    end
    if not v102 then
        return 0
    end
    Unit_6 = Vector3.new(v102.X - v96.Position.X, 0, v102.Z - v96.Position.Z).Unit
    local v111 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v111) < 0.05235987755982989 then
        return 0
    end
    local v112 = math.clamp(v111, -math.rad(v95.max), math.rad(v95.max))
    camCall("Nudge", v112, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v113
        if type(Unit_6) ~= "number" then
            v113 = 0
        else
            v113 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v113 + 1)
    end
    return (math.deg(v112))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u8 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 618
      upvalues:
        u8 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u8 == nil then
        local success_9, v114 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v115
        if success_9 then
            v115 = v114
        else
            v115 = false
        end
        u8 = v115
    end
    if u8 and type(u8.AltAmmo) == "function" then
        return (u8.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 627
    ]]
    local v116 = a1:GetAttribute("Ammo_" .. a2)
    if type(v116) ~= "number" then
        return 0
    end
    return v116
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 633
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v117 = a1:GetAttribute("Ammo_" .. a2)
    local v118
    if type(v117) ~= "number" then
        v118 = 0
    else
        v118 = v117
    end
    local v119 = nil
    for _, value_10 in altAmmo(a2) do
        local v120 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v120) ~= "number" then
            v119 = 0
        else
            v119 = v120
        end
        v118 = v118 + v119
    end
    return v118
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 645
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v121 = nil
        for _, value_11 in altAmmo(a2) do
            local v122 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v122) ~= "number" then
                v121 = 0
            else
                v121 = v122
            end
            if not (v121 >= 1) then
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
      line: 659
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v123 = tbl_upv_1.AmmoNext(a1, a2)
    if v123 and a1 then
        local v124 = a1:GetAttribute("Ammo_" .. v123)
        local v125
        if type(v124) ~= "number" then
            v125 = 0
        else
            v125 = v124
        end
        return v125, tbl_upv_1.AMMO_NOUN[v123] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 668
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
      line: 673
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u9 = v5:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u10 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 711
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
      line: 685
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u9 (copy, index: 2)
    ]]
    local v126 = tbl_upv_8[a1]
    if v126 ~= nil then
        return v126 or nil
    end
    if not u9 then
        return nil
    end
    local v127 = u9
    for key_1 in string.gmatch(a1, "[^/]+") do
        v127 = v127 and v127:FindFirstChild(key_1)
    end
    v127 = v127 or (u9:FindFirstChild(a1, true))
    local v129 = not (v127) or not (v127:IsA("Sound")) or v127
    tbl_upv_8[a1] = v129 or false
    return v129
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 727
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
    local v130 = findSound(a1)
    local v131
    if typeof(a2) == "Vector3" then
        v131 = a2
    elseif typeof(a2) ~= "Instance" then
        v131 = nil
    elseif a2:IsA("BasePart") then
        v131 = a2.Position
    elseif a2:IsA("Attachment") then
        v131 = a2.WorldPosition
    else
        v131 = nil
    end
    local v132 = nil
    if v131 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v132 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v133 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v131).Magnitude)
        if not (v132) then
            local v134 = ((not v130) and 200) or (math.clamp(v130.RollOffMaxDistance, 60, 250))
            if v134 < v133 or Quality_upv_1.maxSounds <= u10 and v133 > 25 then
                return nil
            end
            local v135 = os.clock()
            local v136 = tbl_upv_9[a1]
            if v136 and v135 - v136.t < 0.035 and (v136.p - v131).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v135, p = v131}
        end
    end
    local v137 = (a3 and (a3.PlaybackSpeed)) or 1
    local v138 = (a3 and (a3.Volume)) or 1
    if v131 then
        u10 = u10 + 1
        Metrics_upv_1.sounds = u10
        local v139
        if (v130) and (v130.TimeLength > 0) then
            v139 = v130.TimeLength / math.max(0.05, v137)
        else
            v139 = 1.5
        end
        task.delay(
            math.min(v139 + 0.2, 6),
            function()
                --[[
                  line: 757
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
            v131 = {pitch = 0}
            v131.volume = v138
            local v140
            if a3.PlaybackSpeed then
                v140 = v137
            else
                v140 = nil
            end
            v131.pitch = v140
        else
            v131 = nil
        end
        local success_10, v141 = pcall(u3.Play, a1, a2, v131)
        if success_10 then
            if typeof(v141) == "Instance" and v141:IsA("Sound") then
                return v141
            end
            return nil
        end
    end
    if not v130 then
        return nil
    end
    local v142 = v130:GetAttribute("PitchVary")
    local v143 = math.random() * 2 - 1
    local v144
    if type(v142) ~= "number" then
        v144 = 0.05
    else
        v144 = v142
    end
    local u11 = v130:Clone()
    u11.PlaybackSpeed = u11.PlaybackSpeed * (v137 * (1 + (v143 * v144)))
    u11.Volume = u11.Volume * v138
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u11.SoundGroup = SFX_1
    end
    local u12 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u11.Parent = SoundService_upv_1
            u11:Play()
            local v145 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
            task.delay(
                math.min(v145 + 0.2, 12),
                function()
                    --[[
                      line: 796
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
        local v146 = Instance.new("Attachment")
        v146.WorldPosition = a2
        v146.Parent = workspace.Terrain
        u11.Parent = v146
        u12 = v146
    end
    u11:Play()
    local v145 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
    task.delay(
        math.min(v145 + 0.2, 12),
        function()
            --[[
              line: 796
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
      line: 806
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
                      line: 810
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    pcall(u13, a3)
                end
            end
        end
    end
    local v147 = findSound(a1)
    if not v147 then
        return function()
            --[[
              line: 817
            ]]
        end
    end
    local u14 = v147:Clone()
    u14.Looped = true
    u14.Parent = a2 or SoundService_upv_1
    u14:Play()
    return function()
        --[[
          line: 823
          upvalues:
            u14 (copy, index: 1)
        ]]
        u14:Destroy()
    end
end
local u15 = v5:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 834
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
                      line: 842
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
                      line: 849
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
                              line: 853
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
                                          line: 859
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
        local v149 = tbl_upv_11[a2]
        if v149 then
            return v149
        end
        local u16 = u15:FindFirstChild(a2)
        if u16 and u16:IsA("Animation") then
            local success_12, v150 = pcall(
                function()
                    --[[
                      line: 875
                      upvalues:
                        a1 (copy, index: 1)
                        u16 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u16)
                end
            )
            if success_12 and v150 then
                local v151 = u16:GetAttribute("Priority")
                if type(v151) == "string" and (Enum.AnimationPriority[v151]) then
                    v150.Priority = Enum.AnimationPriority[v151]
                else
                    v150.Priority = Enum.AnimationPriority.Action
                end
                local v152 = u16:GetAttribute("Looped")
                if type(v152) == "boolean" then
                    v150.Looped = v152
                end
                tbl_upv_11[a2] = v150
                return v150
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
      line: 898
      upvalues:
        u17 (ref, index: 1)
    ]]
    u17 = a1
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 902
      upvalues:
        u17 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v153 = u17
    local Character_11 = LocalPlayer_upv_1.Character
    if not v153 or not a1 or not Character_11 then
        return
    end
    if a1:IsDescendantOf(Character_11) then
        local v154 = stats()
        local v155 = ((not v154) and 0) or (v154.Take())
        u17:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, v155)
    end
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 910
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u15 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v156 = tbl_upv_1.GetTrack(a1, a2)
    if not v156 then
        return nil
    end
    local v157 = a3 or 1
    local v158 = u15 and (u15:FindFirstChild(a2))
    local v159 = v158 and (v158:GetAttribute("Speed"))
    if type(v159) == "number" then
        v157 = v157 * v159
    end
    v156:Play(a4 or 0.08, a5 or 1, v157)
    return v156
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 928
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        u17 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v160 = stats()
    if v160 then
        v160.Caller(8192)
    end
    local v161 = playAnim(a1, a2, a3, a4, a5)
    if v161 and a2 then
        local v162 = u17
        local Character_12 = LocalPlayer_upv_1.Character
        if v162 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            local v163 = stats()
            local v164 = ((not v163) and 0) or (v163.Take())
            u17:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, v164)
        end
    end
    return v161
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 938
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
    local v165 = u17
    local Character_13 = LocalPlayer_upv_1.Character
    if v165 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        local v166 = stats()
        local v167 = ((not v166) and 0) or (v166.Take())
        u17:FireServer("Hold", a2, a3 or 1, 0.08, 1, v167)
    end
    local function freeze()
        --[[
          name: freeze
          line: 945
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
              line: 951
              upvalues:
                u18 (copy, index: 1)
            ]]
            local v168 = os.clock()
            while u18.Length == 0 do
                if os.clock() - v168 < 2 then
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
      line: 963
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
        local v169 = tbl_upv_10[a1]
        local v170 = v169 and (v169[a2])
        if v170 and v170.IsPlaying then
            v170:Stop(a3 or 0.12)
            local v171 = u17
            local Character_14 = LocalPlayer_upv_1.Character
            if v171 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                local v172 = stats()
                local v173 = ((not v172) and 0) or (v172.Take())
                u17:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, v173)
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 975
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
      line: 989
    ]]
    if not a1 then
        return nil
    end
    local v174 = a1:FindFirstChild(a2, true)
    if v174 and v174:IsA("Attachment") then
        return v174.WorldPosition
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
      line: 1013
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v175 = tbl_upv_1.AimPoint()
    local v176 = v175 - a2
    if v176.Magnitude < 3.5 then
        return a2
    end
    local v177 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v176.Unit * (v176.Magnitude - 1.5), v177) then
        return a2
    end
    local v178 = tbl_upv_1.GetAimRay()
    local Unit_7 = v178.Direction.Unit
    local v179 = v178.Origin + Unit_7 * math.max((a1 - v178.Origin):Dot(Unit_7), 0)
    local v180 = v175 - v179
    if not ((v179 - a1).Magnitude > 7) and not (v180.Magnitude < 3.5) and not (v180.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v179 - a1, v177)) and not (workspace:Raycast(v179, v180.Unit * (v180.Magnitude - 1.5), v177)) then
            return v179
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1041
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v181 = LocalPlayer_upv_1.Character
    local _ = v181 and (v181:FindFirstChild("Head"))
    local v182 = v181 and (v181:FindFirstChild("HumanoidRootPart"))
    if v181 then
        v181 = v181.Position
    else
        v181 = (v182 and (v182.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v183 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v183 and not ((v183 - v181).Magnitude > 7) then
        if workspace:Raycast(v181, v183 - v181, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v181, v181))
        end
        return (sightOrigin(v181, v183))
    end
    return v181
end
return tbl_upv_1