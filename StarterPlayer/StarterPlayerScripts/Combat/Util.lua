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
    if v4 and a1 == v4.PROBE then
        if a2 ~= 1 then
            return false
        end
        return a1
    end
    return nil
end
local function caller(a1)
    --[[
      name: caller
      line: 47
      upvalues:
        stats (copy, index: 1)
    ]]
    local v5 = stats()
    if not v5 then
        return
    end
    v5.Caller(a1)
end
local v6 = ReplicatedStorage_1:WaitForChild("Assets", 30)
tbl_upv_1.Assets = v6
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local u2 = nil
local u3 = nil
task.spawn(
    function()
        --[[
          line: 63
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v7 = Shared_upv_1:WaitForChild("Camera", 12)
        if not v7 then
            return
        end
        if v7:IsA("ModuleScript") then
            local success_1, v8 = pcall(require, v7)
            if not success_1 or type(v8) ~= "table" then
                warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", v8)
            end
            u2 = v8
        end
    end
)
task.spawn(
    function()
        --[[
          line: 74
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v9 = Shared_upv_1:WaitForChild("Sfx", 20)
        if not v9 then
            return
        end
        if v9:IsA("ModuleScript") then
            local success_2, v10 = pcall(require, v9)
            if not success_2 or type(v10) ~= "table" or type(v10.Play) ~= "function" then
                return
            end
            u3 = v10
        end
    end
)
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 84
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 93
      upvalues:
        u2 (ref, index: 1)
    ]]
    if a1 and u2 and type(u2.Drawn) == "function" then
        local success_3, v11 = pcall(u2.Drawn, a1)
        if success_3 and typeof(v11) == "Instance" then
            return v11
        end
    end
    return a1
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 107
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v12 = (u2 ~= nil) and ((type(u2.InFirstPerson) == "function") and (u2.InFirstPerson() == true))
    return v12
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 111
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.GetAimRay) == "function" then
        local success_4, v13 = pcall(u2.GetAimRay)
        if success_4 and typeof(v13) == "Ray" then
            return v13
        end
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    local ViewportSize_1 = CurrentCamera_1.ViewportSize
    return CurrentCamera_1:ViewportPointToRay(ViewportSize_1.X / 2, ViewportSize_1.Y / 2)
end
function tbl_upv_1.SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 123
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.SetAiming) == "function" then
        pcall(u2.SetAiming, a1, a2)
        return
    end
    local TweenService_1 = game:GetService("TweenService")
    local v14 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_2 = {FieldOfView = 0}
    tbl_2.FieldOfView = ((not a1) and 70) or (a2 or 55)
    TweenService_1:Create(workspace.CurrentCamera, v14, tbl_2):Play()
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 135
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
      line: 141
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v15 = tbl_upv_1.Probe(a1, a2)
    if v15 == nil then
        if u2 and type(u2.Shake) == "function" then
            pcall(u2.Shake, a1, a2)
        end
    else
        return v15
    end
end
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 153
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v16 = tbl_upv_1.Probe(a1, a2)
    if v16 == nil then
        if u2 and type(u2.RecoilSlow) == "function" then
            pcall(u2.RecoilSlow, a1, a2, a3, a4)
        else
            tbl_upv_1.Recoil(a1 * 5, (a2 or 0) * 5)
        end
    else
        return v16
    end
end
function tbl_upv_1.Recoil(a1, a2)
    --[[
      name: Recoil
      line: 166
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
    ]]
    local v17 = tbl_upv_1.Probe(a1, a2)
    if v17 == nil then
        if u2 and type(u2.Recoil) == "function" then
            pcall(u2.Recoil, a1, a2)
        end
    else
        return v17
    end
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 176
      upvalues:
        u2 (ref, index: 1)
    ]]
    if u2 and type(u2.IsMouseUnlocked) == "function" then
        local success_5, v18 = pcall(u2.IsMouseUnlocked)
        return success_5 and (v18 == true)
    end
    return false
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 185
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
      line: 192
      upvalues:
        u2 (ref, index: 1)
    ]]
    if not u2 or type(u2.SetModifier) ~= "function" then
        return
    end
    if a2 and a2.pivot and type(u2.GetShoulderSide) == "function" then
        local success_6, v19 = pcall(u2.GetShoulderSide)
        if success_6 and type(v19) == "number" then
            local pivot_1 = a2.pivot
            a2 = table.clone(a2)
            a2.pivot = Vector3.new(pivot_1.X * v19, pivot_1.Y, pivot_1.Z)
        end
    end
    pcall(u2.SetModifier, a1, a2)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 206
    ]]
    return workspace.CurrentCamera.FieldOfView
end
local function matchOf(a1)
    --[[
      name: matchOf
      line: 212
    ]]
    local v20 = a1 and (a1:GetAttribute("MatchId"))
    if type(v20) ~= "string" then
        return ""
    end
    return v20
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 218
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v21 = Character_1 and (Character_1:GetAttribute("MatchId"))
    local v22
    if type(v21) ~= "string" then
        v22 = ""
    else
        v22 = v21
    end
    local v23
    if v22 ~= "" then
        v23 = true
    else
        v23 = false
    end
    return v23
end
local function phaseLive(a1)
    --[[
      name: phaseLive
      line: 222
    ]]
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v24 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
    local v25 = v24 and (v24:GetAttribute("Phase"))
    local v26 = true
    if v25 ~= "Live" then
        v26 = v25 == "Overtime"
    end
    return v26
end
function tbl_upv_1.IsEnemy(a1)
    --[[
      name: IsEnemy
      line: 230
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if a1 and Character_2 and a1 ~= Character_2 then
        local v27 = Character_2 and (Character_2:GetAttribute("MatchId"))
        local v28
        if type(v27) ~= "string" then
            v28 = ""
        else
            v28 = v27
        end
        if v28 ~= "" then
            local v29 = a1 and (a1:GetAttribute("MatchId"))
            if type(v29) ~= "string" then
                v27 = ""
            else
                v27 = v29
            end
            if v27 == v28 then
                v27 = Character_2:GetAttribute("Team")
                local v30 = a1:GetAttribute("Team")
                return (v27 ~= nil) and ((v30 ~= nil) and (v27 ~= v30))
            end
        end
        return false
    end
    return false
end
function tbl_upv_1.IsTeammate(a1)
    --[[
      name: IsTeammate
      line: 243
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if a1 and Character_3 and a1 ~= Character_3 then
        local v31 = Character_3 and (Character_3:GetAttribute("MatchId"))
        local v32
        if type(v31) ~= "string" then
            v32 = ""
        else
            v32 = v31
        end
        local v33 = false
        local v34
        if v32 == "" then
            v34 = v33
        else
            v34 = false
            local v35 = a1 and (a1:GetAttribute("MatchId"))
            local v36
            if type(v35) ~= "string" then
                v36 = ""
            else
                v36 = v35
            end
            if v36 == v32 then
                v34 = a1:GetAttribute("Team") == Character_3:GetAttribute("Team")
            end
        end
        return v34
    end
    return false
end
local u4 = nil
function tbl_upv_1.ItemBonus(a1)
    --[[
      name: ItemBonus
      line: 256
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        Shared_upv_1 (copy, index: 3)
    ]]
    local Character_4 = LocalPlayer_upv_1.Character
    if Character_4 and type(a1) == "string" then
        local v37 = Character_4:GetAttribute("ItemLevels")
        if type(v37) == "string" and v37 ~= "" then
            if u4 == nil then
                local success_7, v38 = pcall(require, Shared_upv_1:FindFirstChild("Shards"))
                local v39
                if (success_7) and type(v38) == "table" then
                    v39 = v38
                else
                    v39 = false
                end
                u4 = v39
            end
            if u4 then
                return u4.Bonus(u4.DecodeLevels(v37)[a1] or 1)
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
      line: 277
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v40 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v41 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v42
        if type(v41) ~= "string" then
            v42 = ""
        else
            v42 = v41
        end
        local v43
        if v42 == "" then
            v43 = true
        else
            v43 = false
        end
        return v43
    else
        v40 = tbl_upv_1.IsEnemy(a1)
        local v44
        if v40 then
            local v45 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v42
            if type(v45) ~= "string" then
                v42 = ""
            else
                v42 = v45
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v46 = Arenas_2 and (Arenas_2:FindFirstChild(v42))
            local v47 = v46 and (v46:GetAttribute("Phase"))
            v44 = true
            if v47 ~= "Live" then
                v44 = v47 == "Overtime"
            end
        else
            v44 = v40
        end
        return v44
    end
end
local u5 = -math.huge
local u6 = nil
local u7 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 294
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
      line: 300
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
      line: 307
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
    local v48 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v48) == "number" and workspace:GetServerTimeNow() < v48 then
        return false
    end
    local v49 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v49) ~= "string" then
        v48 = ""
    else
        v48 = v49
    end
    local v50 = true
    local v51
    if v48 == "" then
        v51 = v50
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v52 = Arenas_3 and (Arenas_3:FindFirstChild(v48))
        local v53 = v52 and (v52:GetAttribute("Phase"))
        v51 = true
        if v53 ~= "Live" then
            v51 = v53 == "Overtime"
        end
    end
    return v51
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 339
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
      line: 365
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
      line: 327
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v54 = workspace:FindFirstChild(value_6)
        if v54 then
            table.insert(tbl_6, v54)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 375
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v55 = RaycastParams.new()
    v55.FilterType = Enum.RaycastFilterType.Exclude
    local v56 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v56, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v56, value_7)
        end
    end
    v55.FilterDescendantsInstances = v56
    v55.IgnoreWater = true
    return v55
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 394
      upvalues:
        stats (copy, index: 1)
        u2 (ref,  index: 2)
        fxFolders (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    local v57 = stats()
    if v57 then
        v57.Caller(16384)
    end
    if u2 then
        if type(u2.GetAimPoint) ~= "function" then
            local v58 = tbl_upv_1.GetAimRay()
            local v59 = a1 or 1000
            local v60 = workspace:Raycast(v58.Origin, v58.Direction.Unit * v59, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v60 then
                return v60.Position, v60
            end
            return v58.Origin + (v58.Direction.Unit * v59), nil
        else
            local v61 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v61, value_8)
            end
            local v62, v63, v64 = pcall(u2.GetAimPoint, a1, v61)
            if v62 then
                if typeof(v63) == "Vector3" then
                    return v63, v64
                end
                local v58 = tbl_upv_1.GetAimRay()
                local v59 = a1 or 1000
                local v60 = workspace:Raycast(v58.Origin, v58.Direction.Unit * v59, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v60 then
                    return v60.Position, v60
                end
                return v58.Origin + (v58.Direction.Unit * v59), nil
            else
                local v58 = tbl_upv_1.GetAimRay()
                local v59 = a1 or 1000
                local v60 = workspace:Raycast(v58.Origin, v58.Direction.Unit * v59, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v60 then
                    return v60.Position, v60
                end
                return v58.Origin + (v58.Direction.Unit * v59), nil
            end
        end
    else
        local v58 = tbl_upv_1.GetAimRay()
        local v59 = a1 or 1000
        local v60 = workspace:Raycast(v58.Origin, v58.Direction.Unit * v59, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v60 then
            return v60.Position, v60
        end
        return v58.Origin + (v58.Direction.Unit * v59), nil
    end
end
function tbl_upv_1.AimDirection(a1, ...)
    --[[
      name: AimDirection
      line: 417
      upvalues:
        tbl_upv_1 (copy, index: 1)
        stats (copy, index: 2)
    ]]
    local v65 = tbl_upv_1.Probe(a1, ...)
    if v65 ~= nil then
        return v65
    end
    local v66 = stats()
    if v66 then
        v66.Caller(16384)
    end
    local v67 = tbl_upv_1.GetAimRay()
    local v68 = tbl_upv_1.AimPoint() - a1
    if not (v68.Magnitude < 2) and not (v68.Unit:Dot(v67.Direction.Unit) < 0.2) then
        return v68.Unit
    end
    return v67.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 458
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v69 = LocalPlayer_upv_1:GetAttribute(a1)
        local v70
        if type(v69) ~= "number" then
            v70 = 0
        else
            v70 = v69
        end
        LocalPlayer_upv_1:SetAttribute(a1, v70 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 465
      upvalues:
        u2 (ref, index: 1)
    ]]
    local v71 = u2 and (u2[a1])
    if type(v71) ~= "function" then
        return nil
    end
    local success_8, v72 = pcall(v71, ...)
    if success_8 then
        return v72
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 475
      upvalues:
        u2 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u2 and camCall("GetAimAssistEnabled") ~= false then
        local v73 = camCall("IsAssistedInput") == true
        return v73
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 484
    ]]
    local v74 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v74 and v74:IsA("BasePart") then
        local v75 = nil
        if a4 then
            v75 = Vector3.new(a2.X, 0, a2.Z)
            if v75.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v75.Unit
            local v76 = Vector3.new(v74.Position.X - a1.X, 0, v74.Position.Z - a1.Z)
            local v77 = v76:Dot(Unit_1)
            return (v77 > 0) and ((v76 - (Unit_1 * v77)).Magnitude <= 1.1)
        else
            local v78 = v74.Position - Vector3.new(0, 2.200000047683716, 0)
            local v79
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v79 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v79 = v74.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v80 = v79 - v78
            local v81 = v78 - a1
            local v82 = v80:Dot(v80)
            local v83 = v80:Dot(Unit_2)
            local v84 = v82 - v83 * v83
            local v85 = ((not (v84 > 1e-06)) and 0) or (math.clamp((v83 * Unit_2:Dot(v81) - v80:Dot(v81)) / v84, 0, 1))
            local v86 = v78 + v80 * v85
            local v87 = (v86 - a1):Dot(Unit_2)
            return (v87 > 0) and (((v86 - a1) - (Unit_2 * v87)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 516
      upvalues:
        stats (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        Combat_upv_1 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
    ]]
    local v88 = stats()
    if v88 then
        v88.Caller(16384)
    end
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v89 = camCall("GetAimAssistShot")
    if type(v89) == "table" and v89.torsoVisible and typeof(v89.point) == "Vector3" and typeof(v89.model) == "Instance" then
        local model_1 = v89.model
        local point_1 = v89.point
        local v90 = (tbl_upv_1.ASSIST_MAGNET[v89.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v89.class]
        if type(v90) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v91 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v91 and not (v91.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v92 = nil
            if a3 then
                v92 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v93 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v92.Magnitude < 0.001) and not (v93 < 0.001) then
                    v92 = v92.Unit * v93
                    Unit_3 = Vector3.new(v92.X, a2.Y, v92.Z).Unit
                    local Unit_4 = a2.Unit
                    local v94 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v95 = math.rad(v90)
                    local v96 = nil
                    if RunService_upv_1:IsStudio() then
                        v96 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v97
                        if type(v96) ~= "number" then
                            v97 = 0
                        else
                            v97 = v96
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v97 + 1)
                    end
                    if (v94 <= v95) or (v94 < 1e-04) then
                        return Unit_3
                    end
                    local v98 = v95 / v94
                    local v99 = math.sin(v94)
                    return (Unit_4 * (math.sin((1 - v98) * v94) / v99) + (Unit_3 * (math.sin(v98 * v94) / v99))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v94 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v95 = math.rad(v90)
            local v96 = nil
            if RunService_upv_1:IsStudio() then
                v96 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v97
                if type(v96) ~= "number" then
                    v97 = 0
                else
                    v97 = v96
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v97 + 1)
            end
            if (v94 <= v95) or (v94 < 1e-04) then
                return Unit_3
            end
            local v98 = v95 / v94
            local v99 = math.sin(v94)
            return (Unit_4 * (math.sin((1 - v98) * v94) / v99) + (Unit_3 * (math.sin(v98 * v94) / v99))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 568
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
    local v100 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v101 = LocalPlayer_upv_1.Character
    local v102 = v101 and (v101:FindFirstChild("HumanoidRootPart"))
    if not v100 or not v102 or not v102:IsA("BasePart") then
        return 0
    end
    local Head_2 = v101:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v101 = Head_2.Position
    else
        v101 = v102.Position
    end
    local v103 = tbl_upv_1.GetAimRay()
    local v104 = Vector3.new(v103.Direction.X, 0, v103.Direction.Z)
    if v104.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v104.Unit
    v103 = math.cos(math.rad(v100.cone))
    local v105 = tbl_upv_1.Targets()
    local v106 = nil
    local v107 = nil
    local Unit_6 = math.huge
    local v108 = v106
    for _, value_9 in v105 do
        local v109 = tbl_upv_1.CanPredictHit(value_9)
        if not (v109) then
            continue
        end
        local v110 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v110) or v110.Health <= 0 or not (HumanoidRootPart_1) then
            continue
        end
        local v111 = HumanoidRootPart_1:IsA("BasePart")
        if not (v111) then
            continue
        end
        local v112 = HumanoidRootPart_1.Position - v101.Position
        local v113 = Vector3.new(v112.X, 0, v112.Z)
        local Magnitude_1 = v113.Magnitude
        if a1 + v100.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v112.Y) > 6 then
            continue
        end
        v112 = v113.Unit:Dot(Unit_5)
        if v112 < v103 then
            continue
        end
        local v114 = (1 - v112) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v114 then
            continue
        end
        local v115 = Combat_upv_1.SmokeBlocks(v101, HumanoidRootPart_1.Position)
        if v115 then
            continue
        end
        v115 = v108 or (tbl_upv_1.WorldParams(v105))
        v115 = workspace:Raycast(v101, HumanoidRootPart_1.Position - v101, v115)
        if not (v115) then
            Unit_6, v107 = v114, HumanoidRootPart_1.Position
        end
    end
    if not v107 then
        return 0
    end
    Unit_6 = Vector3.new(v107.X - v101.Position.X, 0, v107.Z - v101.Position.Z).Unit
    local v116 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v116) < 0.05235987755982989 then
        return 0
    end
    local v117 = math.clamp(v116, -math.rad(v100.max), math.rad(v100.max))
    camCall("Nudge", v117, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v118
        if type(Unit_6) ~= "number" then
            v118 = 0
        else
            v118 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v118 + 1)
    end
    return (math.deg(v117))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u8 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 644
      upvalues:
        u8 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u8 == nil then
        local success_9, v119 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v120
        if success_9 then
            v120 = v119
        else
            v120 = false
        end
        u8 = v120
    end
    if u8 and type(u8.AltAmmo) == "function" then
        return (u8.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 653
    ]]
    local v121 = a1:GetAttribute("Ammo_" .. a2)
    if type(v121) ~= "number" then
        return 0
    end
    return v121
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 659
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v122 = a1:GetAttribute("Ammo_" .. a2)
    local v123
    if type(v122) ~= "number" then
        v123 = 0
    else
        v123 = v122
    end
    local v124 = nil
    for _, value_10 in altAmmo(a2) do
        local v125 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v125) ~= "number" then
            v124 = 0
        else
            v124 = v125
        end
        v123 = v123 + v124
    end
    return v123
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 671
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v126 = nil
        for _, value_11 in altAmmo(a2) do
            local v127 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v127) ~= "number" then
                v126 = 0
            else
                v126 = v127
            end
            if not (v126 >= 1) then
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
      line: 685
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v128 = tbl_upv_1.AmmoNext(a1, a2)
    if v128 and a1 then
        local v129 = a1:GetAttribute("Ammo_" .. v128)
        local v130
        if type(v129) ~= "number" then
            v130 = 0
        else
            v130 = v129
        end
        return v130, tbl_upv_1.AMMO_NOUN[v128] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 694
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
      line: 699
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u9 = v6:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u10 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 737
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
      line: 711
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u9 (copy, index: 2)
    ]]
    local v131 = tbl_upv_8[a1]
    if v131 ~= nil then
        return v131 or nil
    end
    if not u9 then
        return nil
    end
    local v132 = u9
    for key_1 in string.gmatch(a1, "[^/]+") do
        v132 = v132 and v132:FindFirstChild(key_1)
    end
    v132 = v132 or (u9:FindFirstChild(a1, true))
    local v134 = not (v132) or not (v132:IsA("Sound")) or v132
    tbl_upv_8[a1] = v134 or false
    return v134
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 753
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
    local v135 = findSound(a1)
    local v136
    if typeof(a2) == "Vector3" then
        v136 = a2
    elseif typeof(a2) ~= "Instance" then
        v136 = nil
    elseif a2:IsA("BasePart") then
        v136 = a2.Position
    elseif a2:IsA("Attachment") then
        v136 = a2.WorldPosition
    else
        v136 = nil
    end
    local v137 = nil
    if v136 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v137 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v138 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v136).Magnitude)
        if not (v137) then
            local v139 = ((not v135) and 200) or (math.clamp(v135.RollOffMaxDistance, 60, 250))
            if v139 < v138 or Quality_upv_1.maxSounds <= u10 and v138 > 25 then
                return nil
            end
            local v140 = os.clock()
            local v141 = tbl_upv_9[a1]
            if v141 and v140 - v141.t < 0.035 and (v141.p - v136).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v140, p = v136}
        end
    end
    local v142 = (a3 and (a3.PlaybackSpeed)) or 1
    local v143 = (a3 and (a3.Volume)) or 1
    if v136 then
        u10 = u10 + 1
        Metrics_upv_1.sounds = u10
        local v144
        if (v135) and (v135.TimeLength > 0) then
            v144 = v135.TimeLength / math.max(0.05, v142)
        else
            v144 = 1.5
        end
        task.delay(
            math.min(v144 + 0.2, 6),
            function()
                --[[
                  line: 783
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
            v136 = {pitch = 0}
            v136.volume = v143
            local v145
            if a3.PlaybackSpeed then
                v145 = v142
            else
                v145 = nil
            end
            v136.pitch = v145
        else
            v136 = nil
        end
        local success_10, v146 = pcall(u3.Play, a1, a2, v136)
        if success_10 then
            if typeof(v146) == "Instance" and v146:IsA("Sound") then
                return v146
            end
            return nil
        end
    end
    if not v135 then
        return nil
    end
    local v147 = v135:GetAttribute("PitchVary")
    local v148 = math.random() * 2 - 1
    local v149
    if type(v147) ~= "number" then
        v149 = 0.05
    else
        v149 = v147
    end
    local u11 = v135:Clone()
    u11.PlaybackSpeed = u11.PlaybackSpeed * (v142 * (1 + (v148 * v149)))
    u11.Volume = u11.Volume * v143
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u11.SoundGroup = SFX_1
    end
    local u12 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u11.Parent = SoundService_upv_1
            u11:Play()
            local v150 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
            task.delay(
                math.min(v150 + 0.2, 12),
                function()
                    --[[
                      line: 822
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
        local v151 = Instance.new("Attachment")
        v151.WorldPosition = a2
        v151.Parent = workspace.Terrain
        u11.Parent = v151
        u12 = v151
    end
    u11:Play()
    local v150 = ((u11.TimeLength > 0) and (u11.TimeLength / math.max(0.05, u11.PlaybackSpeed))) or 3
    task.delay(
        math.min(v150 + 0.2, 12),
        function()
            --[[
              line: 822
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
      line: 832
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
                      line: 836
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    pcall(u13, a3)
                end
            end
        end
    end
    local v152 = findSound(a1)
    if not v152 then
        return function()
            --[[
              line: 843
            ]]
        end
    end
    local u14 = v152:Clone()
    u14.Looped = true
    u14.Parent = a2 or SoundService_upv_1
    u14:Play()
    return function()
        --[[
          line: 849
          upvalues:
            u14 (copy, index: 1)
        ]]
        u14:Destroy()
    end
end
local u15 = v6:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 860
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
                      line: 868
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
                      line: 875
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
                              line: 879
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
                                          line: 885
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
        local v154 = tbl_upv_11[a2]
        if v154 then
            return v154
        end
        local u16 = u15:FindFirstChild(a2)
        if u16 and u16:IsA("Animation") then
            local success_12, v155 = pcall(
                function()
                    --[[
                      line: 901
                      upvalues:
                        a1 (copy, index: 1)
                        u16 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u16)
                end
            )
            if success_12 and v155 then
                local v156 = u16:GetAttribute("Priority")
                if type(v156) == "string" and (Enum.AnimationPriority[v156]) then
                    v155.Priority = Enum.AnimationPriority[v156]
                else
                    v155.Priority = Enum.AnimationPriority.Action
                end
                local v157 = u16:GetAttribute("Looped")
                if type(v157) == "boolean" then
                    v155.Looped = v157
                end
                tbl_upv_11[a2] = v155
                return v155
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
      line: 924
      upvalues:
        u17 (ref, index: 1)
    ]]
    u17 = a1
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 928
      upvalues:
        u17 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v158 = u17
    local Character_11 = LocalPlayer_upv_1.Character
    if not v158 or not a1 or not Character_11 then
        return
    end
    if a1:IsDescendantOf(Character_11) then
        local v159 = stats()
        local v160 = ((not v159) and 0) or (v159.Take())
        u17:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, v160)
    end
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 936
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u15 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v161 = tbl_upv_1.GetTrack(a1, a2)
    if not v161 then
        return nil
    end
    local v162 = a3 or 1
    local v163 = u15 and (u15:FindFirstChild(a2))
    local v164 = v163 and (v163:GetAttribute("Speed"))
    if type(v164) == "number" then
        v162 = v162 * v164
    end
    v161:Play(a4 or 0.08, a5 or 1, v162)
    return v161
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 954
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        u17 (ref,  index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
    ]]
    local v165 = stats()
    if v165 then
        v165.Caller(8192)
    end
    local v166 = playAnim(a1, a2, a3, a4, a5)
    if v166 and a2 then
        local v167 = u17
        local Character_12 = LocalPlayer_upv_1.Character
        if v167 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            local v168 = stats()
            local v169 = ((not v168) and 0) or (v168.Take())
            u17:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, v169)
        end
    end
    return v166
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 964
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
    local v170 = u17
    local Character_13 = LocalPlayer_upv_1.Character
    if v170 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        local v171 = stats()
        local v172 = ((not v171) and 0) or (v171.Take())
        u17:FireServer("Hold", a2, a3 or 1, 0.08, 1, v172)
    end
    local function freeze()
        --[[
          name: freeze
          line: 971
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
              line: 977
              upvalues:
                u18 (copy, index: 1)
            ]]
            local v173 = os.clock()
            while u18.Length == 0 do
                if os.clock() - v173 < 2 then
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
      line: 989
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
        local v174 = tbl_upv_10[a1]
        local v175 = v174 and (v174[a2])
        if v175 and v175.IsPlaying then
            v175:Stop(a3 or 0.12)
            local v176 = u17
            local Character_14 = LocalPlayer_upv_1.Character
            if v176 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                local v177 = stats()
                local v178 = ((not v177) and 0) or (v177.Take())
                u17:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, v178)
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 1001
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
      line: 1015
    ]]
    if not a1 then
        return nil
    end
    local v179 = a1:FindFirstChild(a2, true)
    if v179 and v179:IsA("Attachment") then
        return v179.WorldPosition
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
      line: 1039
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v180 = tbl_upv_1.AimPoint()
    local v181 = v180 - a2
    if v181.Magnitude < 3.5 then
        return a2
    end
    local v182 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v181.Unit * (v181.Magnitude - 1.5), v182) then
        return a2
    end
    local v183 = tbl_upv_1.GetAimRay()
    local Unit_7 = v183.Direction.Unit
    local v184 = v183.Origin + Unit_7 * math.max((a1 - v183.Origin):Dot(Unit_7), 0)
    local v185 = v180 - v184
    if not ((v184 - a1).Magnitude > 7) and not (v185.Magnitude < 3.5) and not (v185.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v184 - a1, v182)) and not (workspace:Raycast(v184, v185.Unit * (v185.Magnitude - 1.5), v182)) then
            return v184
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1067
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v186 = LocalPlayer_upv_1.Character
    local _ = v186 and (v186:FindFirstChild("Head"))
    local v187 = v186 and (v186:FindFirstChild("HumanoidRootPart"))
    if v186 then
        v186 = v186.Position
    else
        v186 = (v187 and (v187.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v188 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v188 and not ((v188 - v186).Magnitude > 7) then
        if workspace:Raycast(v186, v188 - v186, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v186, v186))
        end
        return (sightOrigin(v186, v188))
    end
    return v186
end
return tbl_upv_1