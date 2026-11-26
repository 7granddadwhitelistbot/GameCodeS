local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local soundService = game:GetService("SoundService")
game:GetService("UserInputService")
local Metrics = require(script.Parent.Metrics)
local Quality = require(script.Parent.Quality)
local v8 = {}
local localPlayer = players.LocalPlayer
local InputStats = nil

local function stats()
    --[[
      name: stats
      line: 22
      upvalues:
        InputStats (ref,  index: 1)
        localPlayer (copy, index: 2)
    ]]
    if not InputStats then
        local core = localPlayer:FindFirstChild("PlayerScripts") and localPlayer.PlayerScripts:FindFirstChild("Core")
        local inputStats = core and core:FindFirstChild("InputStats")

        if inputStats and inputStats:IsA("ModuleScript") then
            local inputStats2 = inputStats
            InputStats = require(inputStats2)
        end
    end

    return InputStats
end

local function notes()
    --[[
      name: notes
      line: 32
      upvalues:
        stats (copy, index: 1)
    ]]
    return if const v16 = stats() then (v16.Take()) else 0
end

function v8.Probe(a17, a18)
    --[[
      name: Probe
      line: 39
      upvalues:
        InputStats (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    local v19 = InputStats or stats()
    local probe = v19 and v19.PROBE

    if not probe
        or a17 == nil
        or a17 ~= probe.n
            and a17 ~= probe.s
            and a17 ~= probe.t
            and a17 ~= probe.v
            and a17 ~= probe.m
            and a17 ~= probe.at
    then
        return nil
    end
    if a18 ~= nil and a18 ~= 1 then
        return false
    end

    return a17
end

function v8.ProbeValues()
    --[[
      name: ProbeValues
      line: 49
      upvalues:
        InputStats (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    local v21 = InputStats or stats()
    return v21 and v21.PROBE
end

function v8.Hooked()
    --[[
      name: Hooked
      line: 53
      upvalues:
        InputStats (ref,  index: 1)
        stats (copy, index: 2)
    ]]
    if const v22 = InputStats or stats() then
        v22.Note(256)
    end
end

local function caller(a24)
    --[[
      name: caller
      line: 60
      upvalues:
        stats (copy, index: 1)
    ]]
    if const v25 = stats() then
        v25.Caller(a24)
    end
end

local assets = replicatedStorage:WaitForChild("Assets", 30)
v8.Assets = assets
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "Combat"
local child = require(shared:WaitForChild(childName))
local result = nil
local result2 = nil

task.spawn(
    function()
        --[[
          line: 76
          upvalues:
            shared (copy, index: 1)
            result (ref,  index: 2)
        ]]
        local camera = shared:WaitForChild("Camera", 12)

        if camera and camera:IsA("ModuleScript") then
            local success, result2 = pcall(require, camera)

            if success and type(result2) == "table" then
                result = result2
                return
            end

            warn("[Combat] Shared.Camera failed to load, using fallback camera helpers:", result2)
        end
    end
)

task.spawn(
    function()
        --[[
          line: 87
          upvalues:
            shared (copy, index: 1)
            result2 (ref,  index: 2)
        ]]
        local sfx = shared:WaitForChild("Sfx", 20)

        if sfx and sfx:IsA("ModuleScript") then
            local success, result = pcall(require, sfx)

            if success and type(result) == "table" and type(result.Play) == "function" then
                result2 = result
            end
        end
    end
)

function v8.Camera()
    --[[
      name: Camera
      line: 97
      upvalues:
        result (ref, index: 1)
    ]]
    return result
end

function v8.Drawn(a38)
    --[[
      name: Drawn
      line: 106
      upvalues:
        result (ref, index: 1)
    ]]
    local result2 = result

    if a38 and result2 and type(result2.Drawn) == "function" then
        local success, result3 = pcall(result2.Drawn, a38)

        if success and typeof(result3) == "Instance" then
            return result3
        end
    end

    return a38
end

function v8.InFirstPerson()
    --[[
      name: InFirstPerson
      line: 120
      upvalues:
        result (ref, index: 1)
    ]]
    return result ~= nil and type(result.InFirstPerson) == "function" and result.InFirstPerson() == true
end

function v8.GetAimRay()
    --[[
      name: GetAimRay
      line: 124
      upvalues:
        result (ref, index: 1)
    ]]
    if result and type(result.GetAimRay) == "function" then
        local success, result2 = pcall(result.GetAimRay)

        if success and typeof(result2) == "Ray" then
            return result2
        end
    end

    local camera = workspace.CurrentCamera
    local viewportSize = camera.ViewportSize

    return camera:ViewportPointToRay(viewportSize.X / 2, viewportSize.Y / 2)
end

function v8.SetAiming(a46, a47)
    --[[
      name: SetAiming
      line: 136
      upvalues:
        result (ref, index: 1)
    ]]
    if result and type(result.SetAiming) == "function" then
        pcall(result.SetAiming, a46, a47)
        return
    end

    local camera = workspace.CurrentCamera
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local propertyTable = {FieldOfView = if a46 then a47 or 55 else 70}
    tweenService:Create(camera, tweenInfo, propertyTable):Play()
end

function v8.FovKick(a52, a53, a54)
    --[[
      name: FovKick
      line: 148
      upvalues:
        result (ref, index: 1)
    ]]
    if result and type(result.FovKick) == "function" then
        pcall(result.FovKick, a52, a53, a54)
    end
end

function v8.Shake(a55, a56)
    --[[
      name: Shake
      line: 154
      upvalues:
        v8 (copy, index: 1)
        result (ref,  index: 2)
    ]]
    local v57 = v8.Probe(a55, a56)
    if v57 ~= nil then
        return v57
    end

    if result and type(result.Shake) == "function" then
        pcall(result.Shake, a55, a56)
    end
end

function v8.RecoilSlow(a58, a59, a60, a61)
    --[[
      name: RecoilSlow
      line: 166
      upvalues:
        v8 (copy, index: 1)
        result (ref,  index: 2)
    ]]
    local v62 = v8.Probe(a58, a59)
    if v62 ~= nil then
        return v62
    end

    if result and type(result.RecoilSlow) == "function" then
        pcall(result.RecoilSlow, a58, a59, a60, a61)
        return
    end

    v8.Recoil(a58 * 5, (a59 or 0) * 5)
end

function v8.Recoil(a63, a64)
    --[[
      name: Recoil
      line: 179
      upvalues:
        v8 (copy, index: 1)
        result (ref,  index: 2)
    ]]
    local v65 = v8.Probe(a63, a64)
    if v65 ~= nil then
        return v65
    end

    if result and type(result.Recoil) == "function" then
        pcall(result.Recoil, a63, a64)
    end
end

function v8.IsMouseUnlocked()
    --[[
      name: IsMouseUnlocked
      line: 189
      upvalues:
        result (ref, index: 1)
    ]]
    if not result or type(result.IsMouseUnlocked) ~= "function" then
        return false
    end

    local success, result2 = pcall(result.IsMouseUnlocked)

    return success and (result2 == true)
end

function v8.FaceCamera()
    --[[
      name: FaceCamera
      line: 198
      upvalues:
        result (ref, index: 1)
    ]]
    if result and type(result.FaceCamera) == "function" then
        pcall(result.FaceCamera)
    end
end

function v8.SetCameraModifier(a68, a69)
    --[[
      name: SetCameraModifier
      line: 205
      upvalues:
        result (ref, index: 1)
    ]]
    if result and type(result.SetModifier) == "function" then
        if a69 and a69.pivot and type(result.GetShoulderSide) == "function" then
            local success, result2 = pcall(result.GetShoulderSide)

            if success and type(result2) == "number" then
                local pivot = a69.pivot
                a69 = table.clone(a69)
                a69.pivot = Vector3.new(pivot.X * result2, pivot.Y, pivot.Z)
            end
        end

        pcall(result.SetModifier, a68, a69)
    end
end

function v8.GetFOV()
    --[[
      name: GetFOV
      line: 219
    ]]
    return workspace.CurrentCamera.FieldOfView
end

local function matchOf(a74)
    --[[
      name: matchOf
      line: 225
    ]]
    local matchId = a74 and a74:GetAttribute("MatchId")

    if type(matchId) ~= "string" then
        return ""
    end

    return matchId
end

function v8.InMatch()
    --[[
      name: InMatch
      line: 231
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local v76
    local v77 = localPlayer.Character
    v77 = v77 and v77:GetAttribute("MatchId")

    if type(v77) ~= "string" then
        v76 = ""
    else
        v76 = v77
    end

    return v76 ~= ""
end

local function phaseLive(childName: string)
    --[[
      name: phaseLive
      line: 235
    ]]
    local instance = workspace:FindFirstChild("Arenas")
    instance = instance
    instance = instance and instance:FindFirstChild(childName)
    local phase = instance and instance:GetAttribute("Phase")

    return phase == "Live" or phase == "Overtime"
end

function v8.IsEnemy(a82)
    --[[
      name: IsEnemy
      line: 243
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer.Character

    if not a82 or not character or a82 == character then
        return false
    end

    local matchId
    local matchId2 = character and character:GetAttribute("MatchId")

    if type(matchId2) ~= "string" then
        matchId = ""
    else
        matchId = matchId2
    end

    if matchId ~= "" then
        local matchId3
        local matchId4 = a82 and a82:GetAttribute("MatchId")

        if type(matchId4) ~= "string" then
            matchId3 = ""
        else
            matchId3 = matchId4
        end

        if matchId3 == matchId then
            local team = character:GetAttribute("Team")
            local team2 = a82:GetAttribute("Team")

            return team ~= nil and team2 ~= nil and (team ~= team2)
        end
    end

    return false
end

function v8.IsTeammate(a90)
    --[[
      name: IsTeammate
      line: 256
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local character = localPlayer.Character

    if not a90 or not character or a90 == character then
        return false
    end

    local matchId
    local matchId2 = character and character:GetAttribute("MatchId")

    if type(matchId2) ~= "string" then
        matchId = ""
    else
        matchId = matchId2
    end

    local v94 = false

    if matchId ~= "" then
        local matchId3
        v94 = false
        local matchId4 = a90 and a90:GetAttribute("MatchId")

        if type(matchId4) ~= "string" then
            matchId3 = ""
        else
            matchId3 = matchId4
        end

        if matchId3 == matchId then
            v94 = a90:GetAttribute("Team") == character:GetAttribute("Team")
        end
    end

    return v94
end

local result3 = nil

function v8.ItemBonus(key)
    --[[
      name: ItemBonus
      line: 269
      upvalues:
        localPlayer (copy, index: 1)
        result3 (ref,  index: 2)
        shared (copy, index: 3)
    ]]
    local character = localPlayer.Character

    if not character or type(key) ~= "string" then
        return 1
    end

    local itemLevels = character:GetAttribute("ItemLevels")

    if type(itemLevels) ~= "string" or itemLevels == "" then
        return 1
    end

    if result3 == nil then
        local success, result = pcall(require, (shared:FindFirstChild("Shards")))

        if not success or type(result) ~= "table" then
            result3 = false
        else
            result3 = result
        end
    end

    if not result3 then
        return 1
    end

    return result3.Bonus((result3.DecodeLevels(itemLevels)[key] or 1))
end

local v103 = nil

function v8.ParryFacing(a104, a105)
    --[[
      name: ParryFacing
      line: 295
      upvalues:
        v103 (ref,  index: 1)
        child (copy, index: 2)
    ]]
    if not a104 or a104:GetAttribute("Parrying") ~= true then
        return false
    end

    local humanoidRootPart = a104:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
        return false
    end

    if v103 == nil then
        local arc
        local success, result = pcall(child.Tuning, "katana")

        if not success or type(result) ~= "table" or type(result.parry) ~= "table" then
            arc = 150
        else
            arc = result.parry.arc or 150
        end

        v103 = math.cos((math.rad((math.min(179, (arc / 2) + 20)))))
    end

    local v110 = a105 * Vector3.new(1, 0, 1)
    local v111 = humanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)

    if v110.Magnitude < 0.05 or v111.Magnitude < 0.05 then
        return true
    end

    local v112 = (-v110.Unit):Dot(v111.Unit)

    return v103 <= v112
end

function v8.CanPredictHit(instance: Instance)
    --[[
      name: CanPredictHit
      line: 317
      upvalues:
        localPlayer (copy, index: 1)
        collectionService (copy, index: 2)
        v8 (copy, index: 3)
    ]]
    if not instance then
        return false
    end

    local character = localPlayer.Character

    if collectionService:HasTag(instance, "TrainingDummy") then
        local matchId
        local matchId2 = character and character:GetAttribute("MatchId")

        if type(matchId2) ~= "string" then
            matchId = ""
        else
            matchId = matchId2
        end

        return matchId == ""
    end

    local isEnemy = v8.IsEnemy(instance)
    if isEnemy then
        local v118
        local matchId = character and character:GetAttribute("MatchId")

        if type(matchId) ~= "string" then
            v118 = ""
        else
            v118 = matchId
        end

        local arenas = workspace:FindFirstChild("Arenas")
        local child = arenas and arenas:FindFirstChild(v118)
        local phase = child and child:GetAttribute("Phase")

        return phase == "Live" or phase == "Overtime"
    end

    return isEnemy
end

local timestamp = -math.huge
local v124 = nil
local v125 = 0

function v8.GuardDown(a126, a127)
    --[[
      name: GuardDown
      line: 334
      upvalues:
        timestamp (ref, index: 1)
        v124 (ref, index: 2)
        v125 (ref, index: 3)
    ]]
    if type(a127) == "number" and 0 < a127 then
        timestamp = os.clock()
        v124 = a126
        v125 = a127
    end
end

function v8.GuardRecovery(a128)
    --[[
      name: GuardRecovery
      line: 340
      upvalues:
        v124 (ref, index: 1)
        timestamp (ref, index: 2)
        v125 (ref, index: 3)
    ]]
    if a128 ~= nil and a128 ~= v124 then
        return (math.max(0, (timestamp + v125) - os.clock()))
    end

    return 0
end

function v8.CanAct()
    --[[
      name: CanAct
      line: 347
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local v129

    if localPlayer:GetAttribute("Frozen") == true then
        return false
    end

    local character = localPlayer.Character

    if character and character:GetAttribute("Frozen") == true then
        return false
    end

    local staggerUntil = character and character:GetAttribute("StaggerUntil")

    if type(staggerUntil) == "number" and workspace:GetServerTimeNow() < staggerUntil then
        return false
    end

    local matchId = character and character:GetAttribute("MatchId")

    if type(matchId) ~= "string" then
        v129 = ""
    else
        v129 = matchId
    end

    local v133 = true

    if v129 ~= "" then
        local instance = workspace:FindFirstChild("Arenas")
        instance = instance and instance:FindFirstChild(v129)
        local phase = instance and instance:GetAttribute("Phase")

        return phase == "Live" or phase == "Overtime"
    end

    return v133
end

local function fxFolders()
    --[[
      name: fxFolders
      line: 367
    ]]
    local v137 = {}

    for _, childName in {"FX", "Projectiles"} do
        if const child = workspace:FindFirstChild(childName) then
            table.insert(v137, child)
        end
    end

    return v137
end

function v8.Targets()
    --[[
      name: Targets
      line: 379
      upvalues:
        localPlayer (copy, index: 1)
        players (copy, index: 2)
        collectionService (copy, index: 3)
    ]]
    local v141 = {}
    local character = localPlayer.Character

    for _, player in players:GetPlayers() do
        if const character2 = player.Character then
            if character2 ~= character and character2:IsDescendantOf(workspace) then
                table.insert(v141, character2)
            end
        end
    end

    local v146 = {}

    for _, v148 in v141 do
        v146[v148] = true
    end

    for _, tag in {"Combatant", "Bot", "TrainingDummy"} do
        for _, instance in collectionService:GetTagged(tag) do
            if instance:IsA("Model") then
                if instance == character then
                    continue
                end

                if not v146[instance] and instance:IsDescendantOf(workspace) then
                    v146[instance] = true
                    table.insert(v141, instance)
                end
            end
        end
    end

    return v141
end

function v8.Teammates()
    --[[
      name: Teammates
      line: 405
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v153 = {}

    for _, v155 in v8.Targets() do
        if v8.IsTeammate(v155) then
            table.insert(v153, v155)
        end
    end

    return v153
end

function v8.WorldParams(a156)
    --[[
      name: WorldParams
      line: 415
      upvalues:
        fxFolders (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local filterDescendantsInstances = fxFolders()

    if const character = localPlayer.Character then
        table.insert(filterDescendantsInstances, character)
    end

    if a156 then
        for _, v161 in a156 do
            table.insert(filterDescendantsInstances, v161)
        end
    end

    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    raycastParams.IgnoreWater = true

    return raycastParams
end

function v8.AimPoint(a162)
    --[[
      name: AimPoint
      line: 434
      upvalues:
        stats (copy, index: 1)
        result (ref,  index: 2)
        fxFolders (copy, index: 3)
        v8 (copy, index: 4)
    ]]
    if const v163 = stats() then
        v163.Caller(16384)
    end

    if result and type(result.GetAimPoint) == "function" then
        local v164
        local v165 = fxFolders()

        for _, v167 in v8.Teammates() do
            table.insert(v165, v167)
        end

        local success, result2
        success, result2, v164 = pcall(result.GetAimPoint, a162, v165)

        if success then
            if typeof(result2) == "Vector3" then
                return result2, v164
            end
        end
    end

    local aimRay = v8.GetAimRay()
    local v171 = a162 or 1000

    if const raycastResult = workspace:Raycast(aimRay.Origin, aimRay.Direction.Unit * v171, v8.WorldParams(v8.Teammates())) then
        return raycastResult.Position, raycastResult
    end

    return aimRay.Origin + (aimRay.Direction.Unit * v171), nil
end

function v8.AimDirection(a173, ...)
    --[[
      name: AimDirection
      line: 457
      upvalues:
        v8 (copy, index: 1)
        stats (copy, index: 2)
    ]]
    local v174 = v8.Probe(a173, ...)
    if v174 ~= nil then
        return v174
    elseif const v175 = stats() then
        v175.Caller(16384)
    end

    local aimRay = v8.GetAimRay()
    local v177 = v8.AimPoint() - a173

    if not (v177.Magnitude < 2) and not (v177.Unit:Dot(aimRay.Direction.Unit) < 0.2) then
        return v177.Unit
    end

    return aimRay.Direction.Unit
end

v8.ASSIST_MAGNET = {touch = {ranged = 2.5, aimed = 2.5, scoped = 1.5}, gamepad = {ranged = 1.5, aimed = 1.5, scoped = 1.5}}
v8.MELEE_NUDGE = {touch = {cone = 50, max = 20, reach = 1.5}, gamepad = {cone = 40, max = 12, reach = 1}}

local function countAssist(attributeName: string)
    --[[
      name: countAssist
      line: 498
      upvalues:
        runService (copy, index: 1)
        localPlayer (copy, index: 2)
    ]]
    if runService:IsStudio() then
        local v180
        local v181 = localPlayer:GetAttribute(attributeName)

        if type(v181) ~= "number" then
            v180 = 0
        else
            v180 = v181
        end

        localPlayer:SetAttribute(attributeName, v180 + 1)
    end
end

local function camCall(key: string, ...)
    --[[
      name: camCall
      line: 505
      upvalues:
        result (ref, index: 1)
    ]]
    local v184 = result and result[key]

    if type(v184) ~= "function" then
        return nil
    end

    local success, result2 = pcall(v184, ...)
    if success then
        return result2
    end

    return nil
end

function v8.AssistActive()
    --[[
      name: AssistActive
      line: 515
      upvalues:
        result (ref,  index: 1)
        camCall (copy, index: 2)
    ]]
    if result and camCall("GetAimAssistEnabled") ~= false then
        return camCall("IsAssistedInput") == true
    end

    return false
end

local function rawHitsBody(origin: Vector3, a189, model, a191)
    --[[
      name: rawHitsBody
      line: 524
    ]]
    local v192 = model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("UpperTorso")
        or model:FindFirstChild("Torso")
    local head = model:FindFirstChild("Head")

    if not v192 or not v192:IsA("BasePart") then
        return false
    end

    if a191 then
        local vector3 = Vector3.new(a189.X, 0, a189.Z)

        if vector3.Magnitude < 0.001 then
            return false
        end

        local unit = vector3.Unit
        local vector32 = Vector3.new(v192.Position.X - origin.X, 0, v192.Position.Z - origin.Z)
        local v197 = vector32:Dot(unit)

        return 0 < v197 and (vector32 - (unit * v197)).Magnitude <= 1.1
    end

    local v198 = v192.Position - Vector3.new(0, 2.200000047683716, 0)
    local v199 = if head and head:IsA("BasePart") then head.Position + Vector3.new(0, 0.4000000059604645, 0) else v192.Position + Vector3.new(0, 2.200000047683716, 0)
    local unit = a189.Unit
    local v201 = v199 - v198
    local v202 = v198 - origin
    local v203 = v201:Dot(v201)
    local v204 = v201:Dot(unit)
    local v205 = v203 - v204 * v204
    local v206 = not (1e-06 < v205) and 0 or math.clamp((v204 * unit:Dot(v202) - v201:Dot(v202)) / v205, 0, 1)
    local v207 = v198 + v201 * v206
    local v208 = (v207 - origin):Dot(unit)

    return (0 < v208) and ((v207 - origin - (unit * v208)).Magnitude <= 1.1)
end

function v8.AssistDirection(origin: Vector3, a210, a211)
    --[[
      name: AssistDirection
      line: 556
      upvalues:
        stats (copy, index: 1)
        v8 (copy, index: 2)
        camCall (copy, index: 3)
        rawHitsBody (copy, index: 4)
        child (copy, index: 5)
        runService (copy, index: 6)
        localPlayer (copy, index: 7)
    ]]
    if const v212 = stats() then
        v212.Caller(16384)
    end

    if not v8.AssistActive() then
        return a210
    end

    local v213 = camCall("GetAimAssistShot")

    if type(v213) ~= "table"
        or not v213.torsoVisible
        or typeof(v213.point) ~= "Vector3"
        or typeof(v213.model) ~= "Instance"
    then
        return a210
    end

    local model = v213.model
    local point = v213.point
    local v216 = v8.ASSIST_MAGNET[v213.input] or v8.ASSIST_MAGNET.touch
    local v217 = v216[v213.class]

    if type(v217) ~= "number" or rawHitsBody(origin, a210, model, a211) then
        return a210
    end
    if child.SmokeBlocks(origin, point) then
        return a210
    end

    local raycastResult = workspace:Raycast(origin, point - origin, v8.WorldParams(v8.Targets()))

    if raycastResult and not raycastResult.Instance:IsDescendantOf(model) then
        return a210
    end

    local unit = (point - origin).Unit
    local vector3

    if a211 then
        vector3 = Vector3.new(unit.X, 0, unit.Z)
        local v221 = math.sqrt(a210.X * a210.X + (a210.Z * a210.Z))

        if vector3.Magnitude < 0.001 or v221 < 0.001 then
            return a210
        end

        vector3 = vector3.Unit * v221
        unit = Vector3.new(vector3.X, a210.Y, vector3.Z).Unit
    end

    local unit2 = a210.Unit
    local v223 = math.acos((math.clamp(unit2:Dot(unit), -1, 1)))
    local v224 = math.rad(v217)

    if runService:IsStudio() then
        local qaAssistBends
        local qaAssistBends2 = localPlayer:GetAttribute("QA_AssistBends")

        if type(qaAssistBends2) ~= "number" then
            qaAssistBends = 0
        else
            qaAssistBends = qaAssistBends2
        end

        localPlayer:SetAttribute("QA_AssistBends", qaAssistBends + 1)
    end

    if v223 <= v224 or v223 < 1e-04 then
        return unit
    end

    local v227 = v224 / v223
    local v228 = math.sin(v223)

    return (unit2 * (math.sin((1 - v227) * v223) / v228) + (unit * (math.sin(v227 * v223) / v228))).Unit
end

function v8.MeleeAssist(a229, a230)
    --[[
      name: MeleeAssist
      line: 608
      upvalues:
        v8 (copy, index: 1)
        camCall (copy, index: 2)
        localPlayer (copy, index: 3)
        child (copy, index: 4)
        runService (copy, index: 5)
    ]]
    if not v8.AssistActive() then
        return 0
    end

    local v231 = camCall("GetAimAssistInput")
    local v232 = v8.MELEE_NUDGE[v231]
    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not v232 or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
        return 0
    end

    local head = character:FindFirstChild("Head")
    local position = if head and head:IsA("BasePart") then head.Position else humanoidRootPart.Position
    local aimRay = v8.GetAimRay()
    local vector3 = Vector3.new(aimRay.Direction.X, 0, aimRay.Direction.Z)

    if vector3.Magnitude < 0.05 then
        return 0
    end

    local position2
    local unit = vector3.Unit
    local v241 = math.cos((math.rad(v232.cone)))
    local v242 = v8.Targets()
    local v243 = math.huge
    local v244
    v244, position2 = nil, nil

    for _, v246 in v242 do
        if v8.CanPredictHit(v246) then
            local humanoid = v246:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart2 = v246:FindFirstChild("HumanoidRootPart")

            if not humanoid then
                continue
            end
            if humanoid.Health <= 0 then
                continue
            end
            if not humanoidRootPart2 then
                continue
            end
            if not humanoidRootPart2:IsA("BasePart") then
                continue
            end

            local v249 = humanoidRootPart2.Position - humanoidRootPart.Position
            local vector32 = Vector3.new(v249.X, 0, v249.Z)
            local magnitude = vector32.Magnitude

            if a229 + v232.reach < magnitude then
                continue
            end
            if magnitude < 0.5 then
                continue
            end
            if 6 < math.abs(v249.Y) then
                continue
            end

            local v252 = vector32.Unit:Dot(unit)

            if v252 < v241 then
                continue
            end

            local v253 = (1 - v252) * 10 + magnitude * 0.05

            if v243 <= v253 then
                continue
            end
            if child.SmokeBlocks(position, humanoidRootPart2.Position) then
                continue
            end

            local raycastParams = v244 or v8.WorldParams(v242)
            local raycastParams2 = raycastParams

            if workspace:Raycast(position, humanoidRootPart2.Position - position, raycastParams2) then
                v244 = raycastParams2
            else
                position2 = humanoidRootPart2.Position
                v243, v244 = v253, raycastParams2
            end
        end
    end

    if not position2 then
        return 0
    end

    local unit2 = Vector3.new(position2.X - humanoidRootPart.Position.X, 0, position2.Z - humanoidRootPart.Position.Z).Unit
    local v257 = ((math.atan2(-unit2.X, -unit2.Z) - math.atan2(-unit.X, -unit.Z)) + math.pi) % math.tau - math.pi

    if math.abs(v257) < 0.05235987755982989 then
        return 0
    end

    local v258
    local clampedValue = math.clamp(v257, -math.rad(v232.max), (math.rad(v232.max)))

    if a230 then
        v258 = 0
    else
        v258 = 0.08
    end

    camCall("Nudge", clampedValue, v258)

    if runService:IsStudio() then
        local qaAssistMelee
        local qaAssistMelee2 = localPlayer:GetAttribute("QA_AssistMelee")

        if type(qaAssistMelee2) ~= "number" then
            qaAssistMelee = 0
        else
            qaAssistMelee = qaAssistMelee2
        end

        localPlayer:SetAttribute("QA_AssistMelee", qaAssistMelee + 1)
    end

    return (math.deg(clampedValue))
end

v8.AMMO_NOUN = {arrows = "ARROWS", shot = "BULLETS", fire_arrows = "FIRE ARROWS"}
v8.AMMO_OUT = {arrows = "OUT OF ARROWS", shot = "OUT OF BULLETS"}
local result4 = nil

local function altAmmo(a264)
    --[[
      name: altAmmo
      line: 684
      upvalues:
        result4 (ref,  index: 1)
        shared (copy, index: 2)
    ]]
    if result4 == nil then
        local success, result = pcall(require, shared:WaitForChild("Weapons"))

        if success then
            result4 = result
        else
            result4 = false
        end
    end

    local result = result4

    if result and type(result.AltAmmo) == "function" then
        return (result.AltAmmo(a264))
    end

    return {}
end

local function poolOf(a269, a270)
    --[[
      name: poolOf
      line: 693
    ]]
    local v271 = a269:GetAttribute("Ammo_" .. a270)

    if type(v271) ~= "number" then
        return 0
    end

    return v271
end

function v8.AmmoLeft(a272, a273)
    --[[
      name: AmmoLeft
      line: 699
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a272 or type(a273) ~= "string" then
        return math.huge
    end

    local v274
    local v275 = a272:GetAttribute("Ammo_" .. a273)

    if type(v275) ~= "number" then
        v274 = 0
    else
        v274 = v275
    end

    for _, v277 in altAmmo(a273) do
        local v278 = a272:GetAttribute("Ammo_" .. v277)

        if type(v278) ~= "number" then
            v278 = 0
        end

        v274 += v278
    end

    return v274
end

function v8.AmmoNext(a279, a280)
    --[[
      name: AmmoNext
      line: 711
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    if not a279 or type(a280) ~= "string" then
        return nil
    end

    for _, v282 in altAmmo(a280) do
        local v283 = a279:GetAttribute("Ammo_" .. v282)

        if type(v283) ~= "number" then
            v283 = 0
        end

        if 1 <= v283 then
            return v282
        end
    end

    return nil
end

function v8.AmmoShown(a284, key)
    --[[
      name: AmmoShown
      line: 725
      upvalues:
        v8 (copy, index: 1)
    ]]
    local v286 = v8.AmmoNext(a284, key)

    if not v286 or not a284 then
        return v8.AmmoLeft(a284, key), v8.AMMO_NOUN[key]
    end

    local v287
    local v288 = a284:GetAttribute("Ammo_" .. v286)

    if type(v288) ~= "number" then
        v287 = 0
    else
        v287 = v288
    end

    local v289 = v8.AMMO_NOUN[v286] or v8.AMMO_NOUN[key]

    return v287, v289
end

function v8.ShotKind(a290, a291, a292)
    --[[
      name: ShotKind
      line: 734
      upvalues:
        v8 (copy, index: 1)
    ]]
    if v8.AmmoNext(a290, a291) == "fire_arrows" then
        return "Fire" .. a292
    end

    return a292
end

function v8.WatchAmmo(a293, a294, a295)
    --[[
      name: WatchAmmo
      line: 739
      upvalues:
        altAmmo (copy, index: 1)
    ]]
    local v296 = {a293:GetAttributeChangedSignal("Ammo_" .. a294):Connect(a295)}

    for _, v298 in altAmmo(a294) do
        table.insert(v296, a293:GetAttributeChangedSignal("Ammo_" .. v298):Connect(a295))
    end

    return v296
end

local sounds = assets:WaitForChild("Sounds", 10)
local v300 = {}

local function findSound(childName: string)
    --[[
      name: findSound
      line: 751
      upvalues:
        v300 (copy, index: 1)
        sounds (copy, index: 2)
    ]]
    local v303
    local v304 = v300[childName]
    if v304 ~= nil then
        return v304 or nil
    end
    if not sounds then
        return nil
    end

    v303 = sounds

    for v305 in string.gmatch(childName, "[^/]+") do
        v303 = v303 and v303:FindFirstChild(v305)
    end

    v303 = v303 or sounds:FindFirstChild(childName, true)
    local v306 = if v303 and v303:IsA("Sound") then v303 else nil
    v300[childName] = v306 or false

    return v306
end

local sounds2 = 0
local v308 = {}

local function soundPos(a310)
    --[[
      name: soundPos
      line: 777
    ]]
    if typeof(a310) == "Vector3" then
        return a310
    end

    if typeof(a310) == "Instance" then
        if a310:IsA("BasePart") then
            return a310.Position
        end
        if a310:IsA("Attachment") then
            return a310.WorldPosition
        end
    end

    return nil
end

function v8.Sound(key: string, vector3: Vector3, a313)
    --[[
      name: Sound
      line: 793
      upvalues:
        findSound (copy, index: 1)
        localPlayer (copy, index: 2)
        sounds2 (ref,  index: 3)
        Quality (copy, index: 4)
        v308 (copy, index: 5)
        Metrics (copy, index: 6)
        result2 (ref,  index: 7)
        soundService (copy, index: 8)
    ]]
    local v314
    local pitchVary
    local sound = findSound(key)

    if typeof(vector3) ~= "Vector3" then
        if typeof(vector3) ~= "Instance" then
            v314 = nil
        elseif vector3:IsA("BasePart") then
            v314 = vector3.Position
        elseif vector3:IsA("Attachment") then
            v314 = vector3.WorldPosition
        else
            v314 = nil
        end
    else
        v314 = vector3
    end

    if v314 then
        local camera = workspace.CurrentCamera
        local character = localPlayer.Character
        local isDescendantOf = character ~= nil and typeof(vector3) == "Instance" and vector3:IsDescendantOf(character)
        local v320 = not camera and 0 or (camera.CFrame.Position - v314).Magnitude

        if not isDescendantOf then
            local v321 = not sound and 200 or math.clamp(sound.RollOffMaxDistance, 60, 250)

            if v321 < v320 then
                return nil
            end

            local v322 = sounds2

            if Quality.maxSounds <= v322 and 25 < v320 then
                return nil
            end

            local timestamp = os.clock()
            local v324 = v308[key]

            if v324 and timestamp - v324.t < 0.035 and (v324.p - v314).Magnitude < 8 then
                return nil
            end

            v308[key] = {t = timestamp, p = v314}
        end
    end

    local playbackSpeed = a313 and a313.PlaybackSpeed or 1
    local volume = a313 and a313.Volume or 1

    if v314 then
        sounds2 += 1
        Metrics.sounds = sounds2
        local v327 = if sound and 0 < sound.TimeLength then sound.TimeLength / math.max(0.05, playbackSpeed) else 1.5

        task.delay(
            math.min(v327 + 0.2, 6),
            function()
                --[[
                  line: 823
                  upvalues:
                    sounds2 (ref,  index: 1)
                    Metrics (copy, index: 2)
                ]]
                sounds2 -= 1
                Metrics.sounds = sounds2
            end
        )
    end

    if result2 then
        if a313 then
            local v328 = {volume = volume, pitch = if a313.PlaybackSpeed then playbackSpeed else nil}
            v314 = v328
        else
            v314 = nil
        end

        local success, result = pcall(result2.Play, key, vector3, v314)
        if success then
            if typeof(result) == "Instance" and result:IsA("Sound") then
                return result
            end

            return nil
        end
    end

    if not sound then
        return nil
    end

    local pitchVary2 = sound:GetAttribute("PitchVary")
    local v332 = math.random() * 2 - 1

    if type(pitchVary2) ~= "number" then
        pitchVary = 0.05
    else
        pitchVary = pitchVary2
    end

    local v333 = playbackSpeed * (1 + (v332 * pitchVary))
    local v334 = sound:Clone()
    v334.PlaybackSpeed *= v333
    v334.Volume *= volume
    local sfx = soundService:FindFirstChild("SFX")

    if sfx and sfx:IsA("SoundGroup") then
        v334.SoundGroup = sfx
    end

    local attachment = nil

    if typeof(vector3) ~= "Vector3" then
        if typeof(vector3) ~= "Instance" or not vector3:IsA("BasePart") and not vector3:IsA("Attachment") then
            v334.Parent = soundService
        else
            v334.Parent = vector3
        end
    else
        local parent = Instance.new("Attachment")
        parent.WorldPosition = vector3
        parent.Parent = workspace.Terrain
        v334.Parent = parent
        attachment = parent
    end

    v334:Play()
    local v338 = not (0 < v334.TimeLength) and 3 or v334.TimeLength / math.max(0.05, v334.PlaybackSpeed)
    local v339 = v338 + 0.2

    task.delay(
        math.min(v339, 12),
        function()
            --[[
              line: 862
              upvalues:
                v334 (copy, index: 1)
                attachment (ref,  index: 2)
            ]]
            v334:Destroy()

            if attachment then
                attachment:Destroy()
            end
        end
    )

    return v334
end

function v8.Loop(childName: string, a341)
    --[[
      name: Loop
      line: 872
      upvalues:
        result2 (ref,  index: 1)
        findSound (copy, index: 2)
        soundService (copy, index: 3)
    ]]
    if result2 and type(result2.Loop) == "function" then
        local success, result = pcall(result2.Loop, childName, a341)

        if success and type(result) == "function" then
            return function(a344)
                --[[
                  line: 876
                  upvalues:
                    result (copy, index: 1)
                ]]
                pcall(result, a344)
            end
        end
    end

    local sound = findSound(childName)
    if not sound then
        return function()
            --[[
              line: 883
            ]]
        end
    end

    local v346 = sound:Clone()
    v346.Looped = true
    v346.Parent = a341 or soundService
    v346:Play()

    return function()
        --[[
          line: 889
          upvalues:
            v346 (copy, index: 1)
        ]]
        v346:Destroy()
    end
end

local animations = assets:WaitForChild("Animations", 10)
local v348 = {}

function v8.GetTrack(key, childName: string)
    --[[
      name: GetTrack
      line: 900
      upvalues:
        animations (copy, index: 1)
        v348 (copy, index: 2)
    ]]
    if not key or not animations then
        return nil
    end

    local v351 = v348[key]
    if not v351 then
        local v352 = {}
        v348[key] = v352
        key.Destroying:Once(
            function()
                --[[
                  line: 908
                  upvalues:
                    v348 (copy, index: 1)
                    key (copy, index: 2)
                ]]
                v348[key] = nil
            end
        )

        key.AncestryChanged:Connect(
            function()
                --[[
                  line: 915
                  upvalues:
                    key (copy, index: 1)
                    v348 (copy, index: 2)
                    v352 (ref,  index: 3)
                ]]
                if key:IsDescendantOf(game) or v348[key] ~= v352 then
                    return
                end

                task.delay(
                    20,
                    function()
                        --[[
                          line: 919
                          upvalues:
                            v348 (copy, index: 1)
                            key (copy, index: 2)
                            v352 (ref,  index: 3)
                        ]]
                        if v348[key] ~= v352 or key:IsDescendantOf(game) then
                            return
                        end

                        v348[key] = nil

                        for _, v354 in v352 do
                            pcall(
                                function()
                                    --[[
                                      line: 925
                                      upvalues:
                                        v354 (copy, index: 1)
                                    ]]
                                    v354:Stop(0)
                                    v354:Destroy()
                                end
                            )
                        end
                    end
                )
            end
        )

        v351 = v352
    end

    if const v355 = v351[childName] then
        return v355
    end

    local child = animations:FindFirstChild(childName)

    if not child or not child:IsA("Animation") then
        return nil
    end

    local success, result = pcall(
        function()
            --[[
              line: 941
              upvalues:
                key (copy, index: 1)
                child (copy, index: 2)
            ]]
            return key:LoadAnimation(child)
        end
    )

    if not success or not result then
        return nil
    end

    local priority = child:GetAttribute("Priority")

    if type(priority) ~= "string" or not Enum.AnimationPriority[priority] then
        result.Priority = Enum.AnimationPriority.Action
    else
        result.Priority = Enum.AnimationPriority[priority]
    end

    local looped = child:GetAttribute("Looped")

    if type(looped) == "boolean" then
        result.Looped = looped
    end

    v351[childName] = result

    return result
end

local v361 = nil

function v8.SetAnimRelay(animRelay)
    --[[
      name: SetAnimRelay
      line: 964
      upvalues:
        v361 (ref, index: 1)
    ]]
    v361 = animRelay
end

local function relay(a364, a365, a366, a367, a368, a369)
    --[[
      name: relay
      line: 968
      upvalues:
        v361 (ref,  index: 1)
        localPlayer (copy, index: 2)
        stats (copy, index: 3)
    ]]
    local v370 = v361
    local character = localPlayer.Character

    if v370 and a364 and character and a364:IsDescendantOf(character) then
        local v373 = if const v372 = stats() then v372.Take() else 0
        v370:FireServer(a365, a366, a367 or 1, a368 or 0.08, a369 or 1, v373)
    end
end

local function playAnim(a375, childName: string, a377, a378, a379)
    --[[
      name: playAnim
      line: 976
      upvalues:
        v8 (copy, index: 1)
        animations (copy, index: 2)
    ]]
    if not childName then
        return nil
    end

    local track = v8.GetTrack(a375, childName)
    if not track then
        return nil
    end

    local v381 = a377 or 1
    local child = animations and animations:FindFirstChild(childName)
    local speed = child and child:GetAttribute("Speed")

    if type(speed) == "number" then
        v381 *= speed
    end

    track:Play(a378 or 0.08, a379 or 1, v381)

    return track
end

function v8.PlayAnim(a384, childName: string, a386, a387, a388)
    --[[
      name: PlayAnim
      line: 994
      upvalues:
        stats (copy, index: 1)
        playAnim (copy, index: 2)
        v361 (ref,  index: 3)
        localPlayer (copy, index: 4)
    ]]
    if const v389 = stats() then
        v389.Caller(8192)
    end

    local v390 = playAnim(a384, childName, a386, a387, a388)

    if v390 and childName then
        local v391 = v361
        local character = localPlayer.Character

        if v391 and a384 and character and a384:IsDescendantOf(character) then
            local v394 = if const v393 = stats() then v393.Take() else 0
            v391:FireServer("Play", childName, a386 or 1, a387 or 0.08, a388 or 1, v394)
        end
    end

    return v390
end

function v8.PlayHold(a395, childName: string, a397)
    --[[
      name: PlayHold
      line: 1004
      upvalues:
        playAnim (copy, index: 1)
        v361 (ref,  index: 2)
        localPlayer (copy, index: 3)
        stats (copy, index: 4)
    ]]
    local v398 = playAnim(a395, childName, a397, 0.08)
    if not v398 then
        return nil
    end

    local v399 = v361
    local character = localPlayer.Character

    if v399 and a395 and character and a395:IsDescendantOf(character) then
        local v402 = if const v401 = stats() then v401.Take() else 0
        v399:FireServer("Hold", childName, a397 or 1, 0.08, 1, v402)
    end

    local function freeze()
        --[[
          name: freeze
          line: 1011
          upvalues:
            v398 (copy, index: 1)
        ]]
        if v398.IsPlaying then
            v398.TimePosition = math.max(0, v398.Length - 0.03)
            v398:AdjustSpeed(0)
        end
    end

    task.spawn(
        function()
            --[[
              line: 1017
              upvalues:
                v398 (copy, index: 1)
            ]]
            local timestamp = os.clock()

            while v398.Length == 0 and os.clock() - timestamp < 2 do
                task.wait()
            end

            local v405 = math.max(0.05, v398.Speed)
            task.wait((math.max(0, (v398.Length / v405) - 0.04)))

            if v398.IsPlaying then
                v398.TimePosition = math.max(0, v398.Length - 0.03)
                v398:AdjustSpeed(0)
            end
        end
    )

    return v398
end

function v8.StopAnim(key, key2, a408)
    --[[
      name: StopAnim
      line: 1029
      upvalues:
        v348 (copy, index: 1)
        v361 (ref,  index: 2)
        localPlayer (copy, index: 3)
        stats (copy, index: 4)
    ]]
    if not key or not key2 then
        return
    end

    local v409 = v348[key]
    v409 = v409 and v409[key2]

    if v409 and v409.IsPlaying then
        v409:Stop(a408 or 0.12)
        local v410 = v361
        local character = localPlayer.Character

        if v410 and key and character and key:IsDescendantOf(character) then
            local v413 = if const v412 = stats() then v412.Take() else 0
            v410:FireServer("Stop", key2, 1, a408 or 0.12 or 0.08, 1, v413)
        end
    end
end

function v8.Preload(a414)
    --[[
      name: Preload
      line: 1041
      upvalues:
        animations (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    if not animations then
        return
    end

    for _, child in animations:GetChildren() do
        if child:IsA("Animation") then
            v8.GetTrack(a414, child.Name)
        end
    end
end

function v8.ToolPoint(a417, a418)
    --[[
      name: ToolPoint
      line: 1055
    ]]
    if not a417 then
        return nil
    end

    local v419 = a417:FindFirstChild(a418, true)

    if v419 and v419:IsA("Attachment") then
        return v419.WorldPosition
    end

    local handle = a417:FindFirstChild("Handle")

    if handle and handle:IsA("BasePart") then
        return handle.Position
    end

    return nil
end

local function sightOrigin(origin, origin2)
    --[[
      name: sightOrigin
      line: 1079
      upvalues:
        v8 (copy, index: 1)
    ]]
    if v8.InFirstPerson() then
        return origin2
    end

    local v424 = v8.AimPoint()
    local v425 = v424 - origin2

    if v425.Magnitude < 3.5 then
        return origin2
    end

    local raycastParams = v8.WorldParams(v8.Targets())

    if not workspace:Raycast(origin2, v425.Unit * (v425.Magnitude - 1.5), raycastParams) then
        return origin2
    end

    local aimRay = v8.GetAimRay()
    local unit = aimRay.Direction.Unit
    local origin3 = aimRay.Origin + unit * math.max((origin - aimRay.Origin):Dot(unit), 0)
    local v430 = v424 - origin3

    if 7 < (origin3 - origin).Magnitude or v430.Magnitude < 3.5 or v430.Unit:Dot(unit) < 0.9 then
        return origin2
    end
    if not workspace:Raycast(origin, origin3 - origin, raycastParams)
        and not workspace:Raycast(origin3, v430.Unit * (v430.Magnitude - 1.5), raycastParams)
    then
        return origin3
    end

    return origin2
end

function v8.ShotOrigin(a431, a432)
    --[[
      name: ShotOrigin
      line: 1107
      upvalues:
        localPlayer (copy, index: 1)
        v8 (copy, index: 2)
        sightOrigin (copy, index: 3)
    ]]
    local v433
    local character = localPlayer.Character
    local head = character and character:FindFirstChild("Head")
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if head then
        v433 = head.Position
    else
        v433 = not humanoidRootPart and Vector3.new(0, 0, 0) or humanoidRootPart.Position + Vector3.new(0, 1.5, 0)
    end

    local origin = v8.ToolPoint(a431, a432 or "Muzzle")

    if not origin or 7 < (origin - v433).Magnitude then
        return v433
    end
    if workspace:Raycast(v433, origin - v433, v8.WorldParams(v8.Targets())) then
        return (sightOrigin(v433, v433))
    end

    return (sightOrigin(v433, origin))
end

return v8