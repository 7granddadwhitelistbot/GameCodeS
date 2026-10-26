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
local v1 = ReplicatedStorage_1:WaitForChild("Assets", 30)
tbl_upv_1.Assets = v1
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_upv_1:WaitForChild("Combat"))
local u1 = nil
local u2 = nil
task.spawn(
    function()
        --[[
          line: 28
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
        ]]
        local v2 = Shared_upv_1:WaitForChild("Camera", 12)
        if not v2 then
            return
        end
        if v2:IsA("ModuleScript") then
            local success_1, v3 = pcall(require, v2)
            if not success_1 or type(v3) ~= "table" then
                warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", v3)
            end
            u1 = v3
        end
    end
)
task.spawn(
    function()
        --[[
          line: 39
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v4 = Shared_upv_1:WaitForChild("Sfx", 20)
        if not v4 then
            return
        end
        if v4:IsA("ModuleScript") then
            local success_2, v5 = pcall(require, v4)
            if not success_2 or type(v5) ~= "table" or type(v5.Play) ~= "function" then
                return
            end
            u2 = v5
        end
    end
)
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 49
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.Drawn(a1)
    --[[
      name: Drawn
      line: 58
      upvalues:
        u1 (ref, index: 1)
    ]]
    if a1 and u1 and type(u1.Drawn) == "function" then
        local success_3, v6 = pcall(u1.Drawn, a1)
        if success_3 and typeof(v6) == "Instance" then
            return v6
        end
    end
    return a1
end
function tbl_upv_1.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 72
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v7 = (u1 ~= nil) and ((type(u1.InFirstPerson) == "function") and (u1.InFirstPerson() == true))
    return v7
end
function tbl_upv_1.GetAimRay()
    --[[
      name: GetAimRay
      line: 76
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 and type(u1.GetAimRay) == "function" then
        local success_4, v8 = pcall(u1.GetAimRay)
        if success_4 and typeof(v8) == "Ray" then
            return v8
        end
    end
    local CurrentCamera_1 = workspace.CurrentCamera
    local ViewportSize_1 = CurrentCamera_1.ViewportSize
    return CurrentCamera_1:ViewportPointToRay(ViewportSize_1.X / 2, ViewportSize_1.Y / 2)
end
function tbl_upv_1.SetAiming(a1, a2)
    --[[
      name: SetAiming
      line: 88
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 and type(u1.SetAiming) == "function" then
        pcall(u1.SetAiming, a1, a2)
        return
    end
    local TweenService_1 = game:GetService("TweenService")
    local v9 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_2 = {FieldOfView = 0}
    tbl_2.FieldOfView = ((not a1) and 70) or (a2 or 55)
    TweenService_1:Create(workspace.CurrentCamera, v9, tbl_2):Play()
end
function tbl_upv_1.FovKick(a1, a2, a3)
    --[[
      name: FovKick
      line: 100
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or type(u1.FovKick) ~= "function" then
        return
    end
    pcall(u1.FovKick, a1, a2, a3)
end
function tbl_upv_1.Shake(a1, a2)
    --[[
      name: Shake
      line: 106
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or type(u1.Shake) ~= "function" then
        return
    end
    pcall(u1.Shake, a1, a2)
end
function tbl_upv_1.RecoilSlow(a1, a2, a3, a4)
    --[[
      name: RecoilSlow
      line: 114
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if u1 and type(u1.RecoilSlow) == "function" then
        pcall(u1.RecoilSlow, a1, a2, a3, a4)
    else
        tbl_upv_1.Recoil(a1 * 5, (a2 or 0) * 5)
    end
end
function tbl_upv_1.Recoil(a1, a2)
    --[[
      name: Recoil
      line: 123
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or type(u1.Recoil) ~= "function" then
        return
    end
    pcall(u1.Recoil, a1, a2)
end
function tbl_upv_1.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 129
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 and type(u1.IsMouseUnlocked) == "function" then
        local success_5, v10 = pcall(u1.IsMouseUnlocked)
        return success_5 and (v10 == true)
    end
    return false
end
function tbl_upv_1.FaceCamera()
    --[[
      name: FaceCamera
      line: 138
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or type(u1.FaceCamera) ~= "function" then
        return
    end
    pcall(u1.FaceCamera)
end
function tbl_upv_1.SetCameraModifier(a1, a2)
    --[[
      name: SetCameraModifier
      line: 145
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or type(u1.SetModifier) ~= "function" then
        return
    end
    if a2 and a2.pivot and type(u1.GetShoulderSide) == "function" then
        local success_6, v11 = pcall(u1.GetShoulderSide)
        if success_6 and type(v11) == "number" then
            local pivot_1 = a2.pivot
            a2 = table.clone(a2)
            a2.pivot = Vector3.new(pivot_1.X * v11, pivot_1.Y, pivot_1.Z)
        end
    end
    pcall(u1.SetModifier, a1, a2)
end
function tbl_upv_1.GetFOV()
    --[[
      name: GetFOV
      line: 159
    ]]
    return workspace.CurrentCamera.FieldOfView
end
local function matchOf(a1)
    --[[
      name: matchOf
      line: 165
    ]]
    local v12 = a1 and (a1:GetAttribute("MatchId"))
    if type(v12) ~= "string" then
        return ""
    end
    return v12
end
function tbl_upv_1.InMatch()
    --[[
      name: InMatch
      line: 171
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_1 = LocalPlayer_upv_1.Character
    local v13 = Character_1 and (Character_1:GetAttribute("MatchId"))
    local v14
    if type(v13) ~= "string" then
        v14 = ""
    else
        v14 = v13
    end
    local v15
    if v14 ~= "" then
        v15 = true
    else
        v15 = false
    end
    return v15
end
local function phaseLive(a1)
    --[[
      name: phaseLive
      line: 175
    ]]
    local Arenas_1 = workspace:FindFirstChild("Arenas")
    local v16 = Arenas_1 and (Arenas_1:FindFirstChild(a1))
    local v17 = v16 and (v16:GetAttribute("Phase"))
    local v18 = true
    if v17 ~= "Live" then
        v18 = v17 == "Overtime"
    end
    return v18
end
function tbl_upv_1.IsEnemy(a1)
    --[[
      name: IsEnemy
      line: 183
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_2 = LocalPlayer_upv_1.Character
    if a1 and Character_2 and a1 ~= Character_2 then
        local v19 = Character_2 and (Character_2:GetAttribute("MatchId"))
        local v20
        if type(v19) ~= "string" then
            v20 = ""
        else
            v20 = v19
        end
        if v20 ~= "" then
            local v21 = a1 and (a1:GetAttribute("MatchId"))
            if type(v21) ~= "string" then
                v19 = ""
            else
                v19 = v21
            end
            if v19 == v20 then
                v19 = Character_2:GetAttribute("Team")
                local v22 = a1:GetAttribute("Team")
                return (v19 ~= nil) and ((v22 ~= nil) and (v19 ~= v22))
            end
        end
        return false
    end
    return false
end
function tbl_upv_1.IsTeammate(a1)
    --[[
      name: IsTeammate
      line: 196
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
    ]]
    local Character_3 = LocalPlayer_upv_1.Character
    if a1 and Character_3 and a1 ~= Character_3 then
        local v23 = Character_3 and (Character_3:GetAttribute("MatchId"))
        local v24
        if type(v23) ~= "string" then
            v24 = ""
        else
            v24 = v23
        end
        local v25 = false
        local v26
        if v24 == "" then
            v26 = v25
        else
            v26 = false
            local v27 = a1 and (a1:GetAttribute("MatchId"))
            local v28
            if type(v27) ~= "string" then
                v28 = ""
            else
                v28 = v27
            end
            if v28 == v24 then
                v26 = a1:GetAttribute("Team") == Character_3:GetAttribute("Team")
            end
        end
        return v26
    end
    return false
end
local u3 = nil
function tbl_upv_1.ItemBonus(a1)
    --[[
      name: ItemBonus
      line: 209
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u3 (ref,  index: 2)
        Shared_upv_1 (copy, index: 3)
    ]]
    local Character_4 = LocalPlayer_upv_1.Character
    if Character_4 and type(a1) == "string" then
        local v29 = Character_4:GetAttribute("ItemLevels")
        if type(v29) == "string" and v29 ~= "" then
            if u3 == nil then
                local success_7, v30 = pcall(require, Shared_upv_1:FindFirstChild("Shards"))
                local v31
                if (success_7) and type(v30) == "table" then
                    v31 = v30
                else
                    v31 = false
                end
                u3 = v31
            end
            if u3 then
                return u3.Bonus(u3.DecodeLevels(v29)[a1] or 1)
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
      line: 230
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        CollectionService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not a1 then
        return false
    end
    local Character_5 = LocalPlayer_upv_1.Character
    local v32 = nil
    if CollectionService_upv_1:HasTag(a1, "TrainingDummy") then
        local v33 = Character_5 and (Character_5:GetAttribute("MatchId"))
        local v34
        if type(v33) ~= "string" then
            v34 = ""
        else
            v34 = v33
        end
        local v35
        if v34 == "" then
            v35 = true
        else
            v35 = false
        end
        return v35
    else
        v32 = tbl_upv_1.IsEnemy(a1)
        local v36
        if v32 then
            local v37 = Character_5 and (Character_5:GetAttribute("MatchId"))
            local v34
            if type(v37) ~= "string" then
                v34 = ""
            else
                v34 = v37
            end
            local Arenas_2 = workspace:FindFirstChild("Arenas")
            local v38 = Arenas_2 and (Arenas_2:FindFirstChild(v34))
            local v39 = v38 and (v38:GetAttribute("Phase"))
            v36 = true
            if v39 ~= "Live" then
                v36 = v39 == "Overtime"
            end
        else
            v36 = v32
        end
        return v36
    end
end
local u4 = -math.huge
local u5 = nil
local u6 = 0
function tbl_upv_1.GuardDown(a1, a2)
    --[[
      name: GuardDown
      line: 247
      upvalues:
        u4 (ref, index: 1)
        u5 (ref, index: 2)
        u6 (ref, index: 3)
    ]]
    if type(a2) ~= "number" or not (a2 > 0) then
        return
    end
    u4 = os.clock()
    u5 = a1
    u6 = a2
end
function tbl_upv_1.GuardRecovery(a1)
    --[[
      name: GuardRecovery
      line: 253
      upvalues:
        u5 (ref, index: 1)
        u4 (ref, index: 2)
        u6 (ref, index: 3)
    ]]
    if a1 ~= nil and a1 ~= u5 then
        return (math.max(0, (u4 + u6) - os.clock()))
    end
    return 0
end
function tbl_upv_1.CanAct()
    --[[
      name: CanAct
      line: 260
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
    local v40 = Character_6 and (Character_6:GetAttribute("StaggerUntil"))
    if type(v40) == "number" and workspace:GetServerTimeNow() < v40 then
        return false
    end
    local v41 = Character_6 and (Character_6:GetAttribute("MatchId"))
    if type(v41) ~= "string" then
        v40 = ""
    else
        v40 = v41
    end
    local v42 = true
    local v43
    if v40 == "" then
        v43 = v42
    else
        local Arenas_3 = workspace:FindFirstChild("Arenas")
        local v44 = Arenas_3 and (Arenas_3:FindFirstChild(v40))
        local v45 = v44 and (v44:GetAttribute("Phase"))
        v43 = true
        if v45 ~= "Live" then
            v43 = v45 == "Overtime"
        end
    end
    return v43
end
function tbl_upv_1.Targets()
    --[[
      name: Targets
      line: 292
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
      line: 318
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
      line: 280
    ]]
    local tbl_6 = {}
    for _, value_6 in {"FX", "Projectiles"} do
        local v46 = workspace:FindFirstChild(value_6)
        if v46 then
            table.insert(tbl_6, v46)
        end
    end
    return tbl_6
end
function tbl_upv_1.WorldParams(a1)
    --[[
      name: WorldParams
      line: 328
      upvalues:
        fxFolders (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    local v47 = RaycastParams.new()
    v47.FilterType = Enum.RaycastFilterType.Exclude
    local v48 = fxFolders()
    local Character_9 = LocalPlayer_upv_1.Character
    if Character_9 then
        table.insert(v48, Character_9)
    end
    if a1 then
        for _, value_7 in a1 do
            table.insert(v48, value_7)
        end
    end
    v47.FilterDescendantsInstances = v48
    v47.IgnoreWater = true
    return v47
end
function tbl_upv_1.AimPoint(a1)
    --[[
      name: AimPoint
      line: 347
      upvalues:
        u1 (ref,  index: 1)
        fxFolders (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if u1 then
        if type(u1.GetAimPoint) ~= "function" then
            local v49 = tbl_upv_1.GetAimRay()
            local v50 = a1 or 1000
            local v51 = workspace:Raycast(v49.Origin, v49.Direction.Unit * v50, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
            if v51 then
                return v51.Position, v51
            end
            return v49.Origin + (v49.Direction.Unit * v50), nil
        else
            local v52 = fxFolders()
            for _, value_8 in tbl_upv_1.Teammates() do
                table.insert(v52, value_8)
            end
            local success_8, v53, v54 = pcall(u1.GetAimPoint, a1, v52)
            if success_8 then
                if typeof(v53) == "Vector3" then
                    return v53, v54
                end
                local v49 = tbl_upv_1.GetAimRay()
                local v50 = a1 or 1000
                local v51 = workspace:Raycast(v49.Origin, v49.Direction.Unit * v50, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v51 then
                    return v51.Position, v51
                end
                return v49.Origin + (v49.Direction.Unit * v50), nil
            else
                local v49 = tbl_upv_1.GetAimRay()
                local v50 = a1 or 1000
                local v51 = workspace:Raycast(v49.Origin, v49.Direction.Unit * v50, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
                if v51 then
                    return v51.Position, v51
                end
                return v49.Origin + (v49.Direction.Unit * v50), nil
            end
        end
    else
        local v49 = tbl_upv_1.GetAimRay()
        local v50 = a1 or 1000
        local v51 = workspace:Raycast(v49.Origin, v49.Direction.Unit * v50, tbl_upv_1.WorldParams(tbl_upv_1.Teammates()))
        if v51 then
            return v51.Position, v51
        end
        return v49.Origin + (v49.Direction.Unit * v50), nil
    end
end
function tbl_upv_1.AimDirection(a1)
    --[[
      name: AimDirection
      line: 369
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v55 = tbl_upv_1.GetAimRay()
    local v56 = tbl_upv_1.AimPoint() - a1
    if not (v56.Magnitude < 2) and not (v56.Unit:Dot(v55.Direction.Unit) < 0.2) then
        return v56.Unit
    end
    return v55.Direction.Unit
end
tbl_upv_1.ASSIST_MAGNET = {touch = {ranged = 2.5, scoped = 1.5, aimed = 2.5}, gamepad = {ranged = 1.5, scoped = 1.5, aimed = 1.5}}
tbl_upv_1.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}
local function countAssist(a1)
    --[[
      name: countAssist
      line: 405
      upvalues:
        RunService_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if RunService_upv_1:IsStudio() then
        local v57 = LocalPlayer_upv_1:GetAttribute(a1)
        local v58
        if type(v57) ~= "number" then
            v58 = 0
        else
            v58 = v57
        end
        LocalPlayer_upv_1:SetAttribute(a1, v58 + 1)
    end
end
local function camCall(a1, ...)
    --[[
      name: camCall
      line: 412
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v59 = u1 and (u1[a1])
    if type(v59) ~= "function" then
        return nil
    end
    local success_9, v60 = pcall(v59, ...)
    if success_9 then
        return v60
    end
    return nil
end
function tbl_upv_1.AssistActive()
    --[[
      name: AssistActive
      line: 422
      upvalues:
        u1 (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if u1 and camCall("GetAimAssistEnabled") ~= false then
        local v61 = camCall("IsAssistedInput") == true
        return v61
    end
    return false
end
local function rawHitsBody(a1, a2, a3, a4)
    --[[
      name: rawHitsBody
      line: 431
    ]]
    local v62 = a3:FindFirstChild("HumanoidRootPart") or (a3:FindFirstChild("UpperTorso") or (a3:FindFirstChild("Torso")))
    local Head_1 = a3:FindFirstChild("Head")
    if v62 and v62:IsA("BasePart") then
        local v63 = nil
        if a4 then
            v63 = Vector3.new(a2.X, 0, a2.Z)
            if v63.Magnitude < 0.001 then
                return false
            end
            local Unit_1 = v63.Unit
            local v64 = Vector3.new(v62.Position.X - a1.X, 0, v62.Position.Z - a1.Z)
            local v65 = v64:Dot(Unit_1)
            return (v65 > 0) and ((v64 - (Unit_1 * v65)).Magnitude <= 1.1)
        else
            local v66 = v62.Position - Vector3.new(0, 2.200000047683716, 0)
            local v67
            if (Head_1) and (Head_1:IsA("BasePart")) then
                v67 = Head_1.Position + Vector3.new(0, 0.4000000059604645, 0)
            else
                v67 = v62.Position + Vector3.new(0, 2.200000047683716, 0)
            end
            local Unit_2 = a2.Unit
            local v68 = v67 - v66
            local v69 = v66 - a1
            local v70 = v68:Dot(v68)
            local v71 = v68:Dot(Unit_2)
            local v72 = v70 - v71 * v71
            local v73 = ((not (v72 > 1e-06)) and 0) or (math.clamp((v71 * Unit_2:Dot(v69) - v68:Dot(v69)) / v72, 0, 1))
            local v74 = v66 + v68 * v73
            local v75 = (v74 - a1):Dot(Unit_2)
            return (v75 > 0) and (((v74 - a1) - (Unit_2 * v75)).Magnitude <= 1.1)
        end
    end
    return false
end
function tbl_upv_1.AssistDirection(a1, a2, a3)
    --[[
      name: AssistDirection
      line: 463
      upvalues:
        tbl_upv_1 (copy, index: 1)
        camCall (copy, index: 2)
        rawHitsBody (copy, index: 3)
        Combat_upv_1 (copy, index: 4)
        RunService_upv_1 (copy, index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
    ]]
    if not tbl_upv_1.AssistActive() then
        return a2
    end
    local v76 = camCall("GetAimAssistShot")
    if type(v76) == "table" and v76.torsoVisible and typeof(v76.point) == "Vector3" and typeof(v76.model) == "Instance" then
        local model_1 = v76.model
        local point_1 = v76.point
        local v77 = (tbl_upv_1.ASSIST_MAGNET[v76.input] or (tbl_upv_1.ASSIST_MAGNET.touch))[v76.class]
        if type(v77) == "number" and not (rawHitsBody(a1, a2, model_1, a3)) then
            if Combat_upv_1.SmokeBlocks(a1, point_1) then
                return a2
            end
            local v78 = workspace:Raycast(a1, point_1 - a1, tbl_upv_1.WorldParams(tbl_upv_1.Targets()))
            if v78 and not (v78.Instance:IsDescendantOf(model_1)) then
                return a2
            end
            local Unit_3 = (point_1 - a1).Unit
            local v79 = nil
            if a3 then
                v79 = Vector3.new(Unit_3.X, 0, Unit_3.Z)
                local v80 = math.sqrt((a2.X * a2.X) + (a2.Z * a2.Z))
                if not (v79.Magnitude < 0.001) and not (v80 < 0.001) then
                    v79 = v79.Unit * v80
                    Unit_3 = Vector3.new(v79.X, a2.Y, v79.Z).Unit
                    local Unit_4 = a2.Unit
                    local v81 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
                    local v82 = math.rad(v77)
                    local v83 = nil
                    if RunService_upv_1:IsStudio() then
                        v83 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                        local v84
                        if type(v83) ~= "number" then
                            v84 = 0
                        else
                            v84 = v83
                        end
                        LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v84 + 1)
                    end
                    if (v81 <= v82) or (v81 < 1e-04) then
                        return Unit_3
                    end
                    local v85 = v82 / v81
                    local v86 = math.sin(v81)
                    return (Unit_4 * (math.sin((1 - v85) * v81) / v86) + (Unit_3 * (math.sin(v85 * v81) / v86))).Unit
                end
                return a2
            end
            local Unit_4 = a2.Unit
            local v81 = math.acos(math.clamp(Unit_4:Dot(Unit_3), -1, 1))
            local v82 = math.rad(v77)
            local v83 = nil
            if RunService_upv_1:IsStudio() then
                v83 = LocalPlayer_upv_1:GetAttribute("QA_AssistBends")
                local v84
                if type(v83) ~= "number" then
                    v84 = 0
                else
                    v84 = v83
                end
                LocalPlayer_upv_1:SetAttribute("QA_AssistBends", v84 + 1)
            end
            if (v81 <= v82) or (v81 < 1e-04) then
                return Unit_3
            end
            local v85 = v82 / v81
            local v86 = math.sin(v81)
            return (Unit_4 * (math.sin((1 - v85) * v81) / v86) + (Unit_3 * (math.sin(v85 * v81) / v86))).Unit
        end
        return a2
    end
    return a2
end
function tbl_upv_1.MeleeAssist(a1, a2)
    --[[
      name: MeleeAssist
      line: 514
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
    local v87 = tbl_upv_1.MELEE_NUDGE[camCall("GetAimAssistInput")]
    local v88 = LocalPlayer_upv_1.Character
    local v89 = v88 and (v88:FindFirstChild("HumanoidRootPart"))
    if not v87 or not v89 or not v89:IsA("BasePart") then
        return 0
    end
    local Head_2 = v88:FindFirstChild("Head")
    if (Head_2) and (Head_2:IsA("BasePart")) then
        v88 = Head_2.Position
    else
        v88 = v89.Position
    end
    local v90 = tbl_upv_1.GetAimRay()
    local v91 = Vector3.new(v90.Direction.X, 0, v90.Direction.Z)
    if v91.Magnitude < 0.05 then
        return 0
    end
    local Unit_5 = v91.Unit
    v90 = math.cos(math.rad(v87.cone))
    local v92 = tbl_upv_1.Targets()
    local v93 = nil
    local v94 = nil
    local Unit_6 = math.huge
    local v95 = v93
    for _, value_9 in v92 do
        local v96 = tbl_upv_1.CanPredictHit(value_9)
        if not (v96) then
            continue
        end
        local v97 = value_9:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart_1 = value_9:FindFirstChild("HumanoidRootPart")
        if not (v97) or v97.Health <= 0 or not (HumanoidRootPart_1) then
            continue
        end
        local v98 = HumanoidRootPart_1:IsA("BasePart")
        if not (v98) then
            continue
        end
        local v99 = HumanoidRootPart_1.Position - v88.Position
        local v100 = Vector3.new(v99.X, 0, v99.Z)
        local Magnitude_1 = v100.Magnitude
        if a1 + v87.reach < Magnitude_1 or Magnitude_1 < 0.5 or math.abs(v99.Y) > 6 then
            continue
        end
        v99 = v100.Unit:Dot(Unit_5)
        if v99 < v90 then
            continue
        end
        local v101 = (1 - v99) * 10 + Magnitude_1 * 0.05
        if Unit_6 <= v101 then
            continue
        end
        local v102 = Combat_upv_1.SmokeBlocks(v88, HumanoidRootPart_1.Position)
        if v102 then
            continue
        end
        v102 = v95 or (tbl_upv_1.WorldParams(v92))
        v102 = workspace:Raycast(v88, HumanoidRootPart_1.Position - v88, v102)
        if not (v102) then
            Unit_6, v94 = v101, HumanoidRootPart_1.Position
        end
    end
    if not v94 then
        return 0
    end
    Unit_6 = Vector3.new(v94.X - v88.Position.X, 0, v94.Z - v88.Position.Z).Unit
    local v103 = ((math.atan2(-Unit_6.X, -Unit_6.Z) - math.atan2(-Unit_5.X, -Unit_5.Z)) + math.pi) % math.tau - math.pi
    if math.abs(v103) < 0.05235987755982989 then
        return 0
    end
    local v104 = math.clamp(v103, -math.rad(v87.max), math.rad(v87.max))
    camCall("Nudge", v104, (a2 and 0) or 0.08)
    if RunService_upv_1:IsStudio() then
        Unit_6 = LocalPlayer_upv_1:GetAttribute("QA_AssistMelee")
        local v105
        if type(Unit_6) ~= "number" then
            v105 = 0
        else
            v105 = Unit_6
        end
        LocalPlayer_upv_1:SetAttribute("QA_AssistMelee", v105 + 1)
    end
    return (math.deg(v104))
end
tbl_upv_1.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
tbl_upv_1.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local u7 = nil
local function altAmmo(a1)
    --[[
      name: altAmmo
      line: 590
      upvalues:
        u7 (ref,  index: 1)
        Shared_upv_1 (copy, index: 2)
    ]]
    if u7 == nil then
        local success_10, v106 = pcall(require, Shared_upv_1:WaitForChild("Weapons"))
        local v107
        if success_10 then
            v107 = v106
        else
            v107 = false
        end
        u7 = v107
    end
    if u7 and type(u7.AltAmmo) == "function" then
        return (u7.AltAmmo(a1))
    end
    return {}
end
local function poolOf(a1, a2)
    --[[
      name: poolOf
      line: 599
    ]]
    local v108 = a1:GetAttribute("Ammo_" .. a2)
    if type(v108) ~= "number" then
        return 0
    end
    return v108
end
function tbl_upv_1.AmmoLeft(a1, a2)
    --[[
      name: AmmoLeft
      line: 605
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a1 or type(a2) ~= "string" then
        return math.huge
    end
    local v109 = a1:GetAttribute("Ammo_" .. a2)
    local v110
    if type(v109) ~= "number" then
        v110 = 0
    else
        v110 = v109
    end
    local v111 = nil
    for _, value_10 in altAmmo(a2) do
        local v112 = a1:GetAttribute("Ammo_" .. value_10)
        if type(v112) ~= "number" then
            v111 = 0
        else
            v111 = v112
        end
        v110 = v110 + v111
    end
    return v110
end
function tbl_upv_1.AmmoNext(a1, a2)
    --[[
      name: AmmoNext
      line: 617
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if a1 and type(a2) == "string" then
        local v113 = nil
        for _, value_11 in altAmmo(a2) do
            local v114 = a1:GetAttribute("Ammo_" .. value_11)
            if type(v114) ~= "number" then
                v113 = 0
            else
                v113 = v114
            end
            if not (v113 >= 1) then
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
      line: 631
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v115 = tbl_upv_1.AmmoNext(a1, a2)
    if v115 and a1 then
        local v116 = a1:GetAttribute("Ammo_" .. v115)
        local v117
        if type(v116) ~= "number" then
            v117 = 0
        else
            v117 = v116
        end
        return v117, tbl_upv_1.AMMO_NOUN[v115] or (tbl_upv_1.AMMO_NOUN[a2])
    end
    return tbl_upv_1.AmmoLeft(a1, a2), tbl_upv_1.AMMO_NOUN[a2]
end
function tbl_upv_1.ShotKind(a1, a2, a3)
    --[[
      name: ShotKind
      line: 640
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
      line: 645
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local tbl_7 = {a1:GetAttributeChangedSignal("Ammo_" .. a2):Connect(a3)}
    for _, value_12 in altAmmo(a2) do
        table.insert(tbl_7, a1:GetAttributeChangedSignal("Ammo_" .. value_12):Connect(a3))
    end
    return tbl_7
end
local u8 = v1:WaitForChild("Sounds", 10)
local tbl_upv_8 = {}
local u9 = 0
local tbl_upv_9 = {}
local function soundPos(a1)
    --[[
      name: soundPos
      line: 683
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
      line: 657
      upvalues:
        tbl_upv_8 (copy, index: 1)
        u8 (copy, index: 2)
    ]]
    local v118 = tbl_upv_8[a1]
    if v118 ~= nil then
        return v118 or nil
    end
    if not u8 then
        return nil
    end
    local v119 = u8
    for key_1 in string.gmatch(a1, "[^/]+") do
        v119 = v119 and v119:FindFirstChild(key_1)
    end
    v119 = v119 or (u8:FindFirstChild(a1, true))
    local v121 = not (v119) or not (v119:IsA("Sound")) or v119
    tbl_upv_8[a1] = v121 or false
    return v121
end
function tbl_upv_1.Sound(a1, a2, a3)
    --[[
      name: Sound
      line: 699
      upvalues:
        findSound (copy, index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        u9 (ref,  index: 3)
        Quality_upv_1 (copy, index: 4)
        tbl_upv_9 (copy, index: 5)
        Metrics_upv_1 (copy, index: 6)
        u2 (ref,  index: 7)
        SoundService_upv_1 (copy, index: 8)
    ]]
    local v122 = findSound(a1)
    local v123
    if typeof(a2) == "Vector3" then
        v123 = a2
    elseif typeof(a2) ~= "Instance" then
        v123 = nil
    elseif a2:IsA("BasePart") then
        v123 = a2.Position
    elseif a2:IsA("Attachment") then
        v123 = a2.WorldPosition
    else
        v123 = nil
    end
    local v124 = nil
    if v123 then
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character_10 = LocalPlayer_upv_1.Character
        v124 = (Character_10 ~= nil) and ((typeof(a2) == "Instance") and (a2:IsDescendantOf(Character_10)))
        local v125 = ((not CurrentCamera_2) and 0) or ((CurrentCamera_2.CFrame.Position - v123).Magnitude)
        if not (v124) then
            local v126 = ((not v122) and 200) or (math.clamp(v122.RollOffMaxDistance, 60, 250))
            if v126 < v125 or Quality_upv_1.maxSounds <= u9 and v125 > 25 then
                return nil
            end
            local v127 = os.clock()
            local v128 = tbl_upv_9[a1]
            if v128 and v127 - v128.t < 0.035 and (v128.p - v123).Magnitude < 8 then
                return nil
            end
            tbl_upv_9[a1] = {t = v127, p = v123}
        end
    end
    local v129 = (a3 and (a3.PlaybackSpeed)) or 1
    local v130 = (a3 and (a3.Volume)) or 1
    if v123 then
        u9 = u9 + 1
        Metrics_upv_1.sounds = u9
        local v131
        if (v122) and (v122.TimeLength > 0) then
            v131 = v122.TimeLength / math.max(0.05, v129)
        else
            v131 = 1.5
        end
        task.delay(
            math.min(v131 + 0.2, 6),
            function()
                --[[
                  line: 729
                  upvalues:
                    u9 (ref,  index: 1)
                    Metrics_upv_1 (copy, index: 2)
                ]]
                u9 = u9 - 1
                Metrics_upv_1.sounds = u9
            end
        )
    end
    if u2 then
        if a3 then
            v123 = {pitch = 0}
            v123.volume = v130
            local v132
            if a3.PlaybackSpeed then
                v132 = v129
            else
                v132 = nil
            end
            v123.pitch = v132
        else
            v123 = nil
        end
        local success_11, v133 = pcall(u2.Play, a1, a2, v123)
        if success_11 then
            if typeof(v133) == "Instance" and v133:IsA("Sound") then
                return v133
            end
            return nil
        end
    end
    if not v122 then
        return nil
    end
    local v134 = v122:GetAttribute("PitchVary")
    local v135 = math.random() * 2 - 1
    local v136
    if type(v134) ~= "number" then
        v136 = 0.05
    else
        v136 = v134
    end
    local u10 = v122:Clone()
    u10.PlaybackSpeed = u10.PlaybackSpeed * (v129 * (1 + (v135 * v136)))
    u10.Volume = u10.Volume * v130
    local SFX_1 = SoundService_upv_1:FindFirstChild("SFX")
    if SFX_1 and SFX_1:IsA("SoundGroup") then
        u10.SoundGroup = SFX_1
    end
    local u11 = nil
    if typeof(a2) ~= "Vector3" then
        if typeof(a2) ~= "Instance" or not (a2:IsA("BasePart")) and not (a2:IsA("Attachment")) then
            u10.Parent = SoundService_upv_1
            u10:Play()
            local v137 = ((u10.TimeLength > 0) and (u10.TimeLength / math.max(0.05, u10.PlaybackSpeed))) or 3
            task.delay(
                math.min(v137 + 0.2, 12),
                function()
                    --[[
                      line: 768
                      upvalues:
                        u10 (copy, index: 1)
                        u11 (ref,  index: 2)
                    ]]
                    u10:Destroy()
                    if not u11 then
                        return
                    end
                    u11:Destroy()
                end
            )
            return u10
        end
        u10.Parent = a2
    else
        local v138 = Instance.new("Attachment")
        v138.WorldPosition = a2
        v138.Parent = workspace.Terrain
        u10.Parent = v138
        u11 = v138
    end
    u10:Play()
    local v137 = ((u10.TimeLength > 0) and (u10.TimeLength / math.max(0.05, u10.PlaybackSpeed))) or 3
    task.delay(
        math.min(v137 + 0.2, 12),
        function()
            --[[
              line: 768
              upvalues:
                u10 (copy, index: 1)
                u11 (ref,  index: 2)
            ]]
            u10:Destroy()
            if not u11 then
                return
            end
            u11:Destroy()
        end
    )
    return u10
end
function tbl_upv_1.Loop(a1, a2)
    --[[
      name: Loop
      line: 778
      upvalues:
        u2 (ref,  index: 1)
        findSound (copy, index: 2)
        SoundService_upv_1 (copy, index: 3)
    ]]
    if u2 then
        local u12
        if type(u2.Loop) == "function" then
            local success_12, u12 = pcall(u2.Loop, a1, a2)
            if success_12 and type(u12) == "function" then
                return function(a3)
                    --[[
                      line: 782
                      upvalues:
                        u12 (copy, index: 1)
                    ]]
                    pcall(u12, a3)
                end
            end
        end
    end
    local v139 = findSound(a1)
    if not v139 then
        return function()
            --[[
              line: 789
            ]]
        end
    end
    local u13 = v139:Clone()
    u13.Looped = true
    u13.Parent = a2 or SoundService_upv_1
    u13:Play()
    return function()
        --[[
          line: 795
          upvalues:
            u13 (copy, index: 1)
        ]]
        u13:Destroy()
    end
end
local u14 = v1:WaitForChild("Animations", 10)
local tbl_upv_10 = {}
function tbl_upv_1.GetTrack(a1, a2)
    --[[
      name: GetTrack
      line: 806
      upvalues:
        u14 (copy, index: 1)
        tbl_upv_10 (copy, index: 2)
    ]]
    if a1 and u14 then
        local tbl_upv_11 = tbl_upv_10[a1]
        if not (tbl_upv_11) then
            tbl_upv_11 = {}
            tbl_upv_10[a1] = tbl_upv_11
            a1.Destroying:Once(
                function()
                    --[[
                      line: 814
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
                      line: 821
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
                              line: 825
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
                                          line: 831
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
        local v141 = tbl_upv_11[a2]
        if v141 then
            return v141
        end
        local u15 = u14:FindFirstChild(a2)
        if u15 and u15:IsA("Animation") then
            local success_13, v142 = pcall(
                function()
                    --[[
                      line: 847
                      upvalues:
                        a1 (copy, index: 1)
                        u15 (copy, index: 2)
                    ]]
                    return a1:LoadAnimation(u15)
                end
            )
            if success_13 and v142 then
                local v143 = u15:GetAttribute("Priority")
                if type(v143) == "string" and (Enum.AnimationPriority[v143]) then
                    v142.Priority = Enum.AnimationPriority[v143]
                else
                    v142.Priority = Enum.AnimationPriority.Action
                end
                local v144 = u15:GetAttribute("Looped")
                if type(v144) == "boolean" then
                    v142.Looped = v144
                end
                tbl_upv_11[a2] = v142
                return v142
            end
            return nil
        end
        return nil
    end
    return nil
end
local u16 = nil
function tbl_upv_1.SetAnimRelay(a1)
    --[[
      name: SetAnimRelay
      line: 870
      upvalues:
        u16 (ref, index: 1)
    ]]
    u16 = a1
end
local u17 = nil
local function notes()
    --[[
      name: notes
      line: 875
      upvalues:
        u17 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
    ]]
    if not (u17) then
        local v145 = LocalPlayer_upv_1:FindFirstChild("PlayerScripts") and (LocalPlayer_upv_1.PlayerScripts:FindFirstChild("Core"))
        local v146 = v145 and (v145:FindFirstChild("InputStats"))
        if v146 and v146:IsA("ModuleScript") then
            u17 = require(v146)
            return u17.Take()
        end
        return 0
    end
    return u17.Take()
end
local function relay(a1, a2, a3, a4, a5, a6)
    --[[
      name: relay
      line: 886
      upvalues:
        u16 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        notes (copy, index: 3)
    ]]
    local Character_11 = LocalPlayer_upv_1.Character
    if not u16 or not a1 or not Character_11 or not a1:IsDescendantOf(Character_11) then
        return
    end
    u16:FireServer(a2, a3, a4 or 1, a5 or 0.08, a6 or 1, notes())
end
local function playAnim(a1, a2, a3, a4, a5)
    --[[
      name: playAnim
      line: 894
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u14 (copy, index: 2)
    ]]
    if not a2 then
        return nil
    end
    local v147 = tbl_upv_1.GetTrack(a1, a2)
    if not v147 then
        return nil
    end
    local v148 = a3 or 1
    local v149 = u14 and (u14:FindFirstChild(a2))
    local v150 = v149 and (v149:GetAttribute("Speed"))
    if type(v150) == "number" then
        v148 = v148 * v150
    end
    v147:Play(a4 or 0.08, a5 or 1, v148)
    return v147
end
function tbl_upv_1.PlayAnim(a1, a2, a3, a4, a5)
    --[[
      name: PlayAnim
      line: 912
      upvalues:
        playAnim (copy, index: 1)
        u16 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        notes (copy, index: 4)
    ]]
    local v151 = playAnim(a1, a2, a3, a4, a5)
    if v151 and a2 then
        local Character_12 = LocalPlayer_upv_1.Character
        if u16 and a1 and Character_12 and a1:IsDescendantOf(Character_12) then
            u16:FireServer("Play", a2, a3 or 1, a4 or 0.08, a5 or 1, notes())
        end
    end
    return v151
end
function tbl_upv_1.PlayHold(a1, a2, a3)
    --[[
      name: PlayHold
      line: 921
      upvalues:
        playAnim (copy, index: 1)
        u16 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        notes (copy, index: 4)
    ]]
    local u18 = playAnim(a1, a2, a3, 0.08)
    if not u18 then
        return nil
    end
    local Character_13 = LocalPlayer_upv_1.Character
    if u16 and a1 and Character_13 and a1:IsDescendantOf(Character_13) then
        u16:FireServer("Hold", a2, a3 or 1, 0.08, 1, notes())
    end
    local function freeze()
        --[[
          name: freeze
          line: 928
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
              line: 934
              upvalues:
                u18 (copy, index: 1)
            ]]
            local v152 = os.clock()
            while u18.Length == 0 do
                if os.clock() - v152 < 2 then
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
      line: 946
      upvalues:
        tbl_upv_10 (copy, index: 1)
        u16 (ref,  index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
        notes (copy, index: 4)
    ]]
    if not a1 then
        return
    end
    if a2 then
        local v153 = tbl_upv_10[a1]
        local v154 = v153 and (v153[a2])
        if v154 and v154.IsPlaying then
            v154:Stop(a3 or 0.12)
            local v155 = u16
            local Character_14 = LocalPlayer_upv_1.Character
            if v155 and a1 and Character_14 and a1:IsDescendantOf(Character_14) then
                v155:FireServer("Stop", a2, 1, (a3 or 0.12) or 0.08, 1, notes())
            end
        end
    end
end
function tbl_upv_1.Preload(a1)
    --[[
      name: Preload
      line: 958
      upvalues:
        u14 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not u14 then
        return
    end
    for _, value_14 in u14:GetChildren() do
        if value_14:IsA("Animation") then
            tbl_upv_1.GetTrack(a1, value_14.Name)
        end
    end
end
function tbl_upv_1.ToolPoint(a1, a2)
    --[[
      name: ToolPoint
      line: 972
    ]]
    if not a1 then
        return nil
    end
    local v156 = a1:FindFirstChild(a2, true)
    if v156 and v156:IsA("Attachment") then
        return v156.WorldPosition
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
      line: 996
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.InFirstPerson() then
        return a2
    end
    local v157 = tbl_upv_1.AimPoint()
    local v158 = v157 - a2
    if v158.Magnitude < 3.5 then
        return a2
    end
    local v159 = tbl_upv_1.WorldParams(tbl_upv_1.Targets())
    if not workspace:Raycast(a2, v158.Unit * (v158.Magnitude - 1.5), v159) then
        return a2
    end
    local v160 = tbl_upv_1.GetAimRay()
    local Unit_7 = v160.Direction.Unit
    local v161 = v160.Origin + Unit_7 * math.max((a1 - v160.Origin):Dot(Unit_7), 0)
    local v162 = v157 - v161
    if not ((v161 - a1).Magnitude > 7) and not (v162.Magnitude < 3.5) and not (v162.Unit:Dot(Unit_7) < 0.9) then
        if not (workspace:Raycast(a1, v161 - a1, v159)) and not (workspace:Raycast(v161, v162.Unit * (v162.Magnitude - 1.5), v159)) then
            return v161
        end
        return a2
    end
    return a2
end
function tbl_upv_1.ShotOrigin(a1, a2)
    --[[
      name: ShotOrigin
      line: 1024
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v163 = LocalPlayer_upv_1.Character
    local _ = v163 and (v163:FindFirstChild("Head"))
    local v164 = v163 and (v163:FindFirstChild("HumanoidRootPart"))
    if v163 then
        v163 = v163.Position
    else
        v163 = (v164 and (v164.Position + Vector3.new(0, 1.5, 0))) or Vector3.new(0, 0, 0)
    end
    local v165 = tbl_upv_1.ToolPoint(a1, a2 or "Muzzle")
    if v165 and not ((v165 - v163).Magnitude > 7) then
        if workspace:Raycast(v163, v165 - v163, tbl_upv_1.WorldParams(tbl_upv_1.Targets())) then
            return (sightOrigin(v163, v163))
        end
        return (sightOrigin(v163, v165))
    end
    return v163
end
return tbl_upv_1