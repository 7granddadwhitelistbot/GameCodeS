local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local Fighters = require(script.Parent:WaitForChild("Fighters"))
local v7 = {
    TOUCH = {
        ranged = {radius = 3, minDeg = 4.5, maxDeg = 12, friction = 0.5, track = 0.5, trackPitch = 0.3, pull = 0.15, range = 320},
        aimed = {radius = 2.6, minDeg = 3.5, maxDeg = 10, friction = 0.42, track = 0.6, trackPitch = 0.35, pull = 0.12, range = 420},
        scoped = {radius = 1.8, minDeg = 1.6, maxDeg = 6, friction = 0.45, track = 0.45, trackPitch = 0.25, pull = 0.06, range = 600},
        melee = {radius = 3.5, minDeg = 8, maxDeg = 24, friction = 0.7, track = 0.35, trackPitch = 0.15, pull = 0.08, range = 16}
    },
    GAMEPAD = {
        ranged = {radius = 2.6, minDeg = 5, maxDeg = 10, friction = 0.55, track = 0.35, trackPitch = 0.2, pull = 0.1, range = 320},
        aimed = {radius = 2.3, minDeg = 5, maxDeg = 9, friction = 0.5, track = 0.4, trackPitch = 0.25, pull = 0.08, range = 420},
        scoped = {radius = 1.6, minDeg = 5, maxDeg = 8, friction = 0.55, track = 0.3, trackPitch = 0.15, pull = 0.05, range = 600},
        melee = {radius = 3.2, minDeg = 8, maxDeg = 22, friction = 0.6, track = 0.25, trackPitch = 0.1, pull = 0.06, range = 16}
    },
    SCOPE_FOV = 42
}
local v8 = {Fists = true, Sword = true, Axe = true, Spear = true, Dagger = true, Club = true, Gauntlets = true, Scythe = true, Katana = true, Hatchets = true}
local v9 = {Bow = true, Crossbow = true, Musket = true, Pistol = true, Blunderbuss = true, Knives = true, Javelin = true, Sling = true}
local localPlayer = players.LocalPlayer
local isStudio = runService:IsStudio()
local enabled2 = true
local v13 = nil
local v14 = nil

local function combat()
    --[[
      name: combat
      line: 83
      upvalues:
        v14 (ref, index: 1)
    ]]
    if v14 == nil then
        local combat = script.Parent.Parent:FindFirstChild("Combat")

        local success, Combat = pcall(
            function()
                --[[
                  line: 86
                  upvalues:
                    combat (copy, index: 1)
                ]]
                local combat2 = combat
                return require(combat2)
            end
        )

        if not success or type(Combat) ~= "table" then
            v14 = false
        else
            v14 = Combat
        end
    end

    if v14 then
        return v14
    end

    return nil
end

local v20 = nil
local v21 = false
local timestamp = -math.huge
local timestamp2 = -math.huge
local timestamp3 = -math.huge
local timestamp4 = -math.huge
local v26 = nil
local v27 = nil
local v28 = nil
local unit = nil
local v30 = nil
local v31 = 0
local v32 = 0
local vector2 = Vector2.zero
local injectLeft = 0
local v35 = {frames = 0, slowed = 0, trackDeg = 0, pullDeg = 0, searches = 0, rays = 0, lastDeg = -1, lastCone = -1}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local function wrap(a38)
    --[[
      name: wrap
      line: 117
    ]]
    return ((a38 + math.pi) % math.tau) - math.pi
end

local function yawOf(a40)
    --[[
      name: yawOf
      line: 121
    ]]
    return (math.atan2(-a40.X, -a40.Z))
end

local function inputKind()
    --[[
      name: inputKind
      line: 125
      upvalues:
        v13 (ref,  index: 1)
        userInputService (copy, index: 2)
    ]]
    if v13 ~= nil then
        if v13 == "mouse" then
            return nil
        end

        return v13
    end

    local preferredInput = userInputService.PreferredInput

    if preferredInput == Enum.PreferredInput.Touch then
        return "touch"
    end
    if preferredInput == Enum.PreferredInput.Gamepad then
        return "gamepad"
    end

    return nil
end

local function isEnemy(a44, character: Model?)
    --[[
      name: isEnemy
      line: 138
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    if a44 == character then
        return false
    end

    local matchId = localPlayer:GetAttribute("MatchId")

    if type(matchId) ~= "string" or matchId == "" then
        return a44:HasTag("TrainingDummy")
    end

    local team = a44:GetAttribute("Team")

    return a44:GetAttribute("MatchId") == matchId and team ~= nil and team ~= localPlayer:GetAttribute("Team")
end

local function part(a49, a50)
    --[[
      name: part
      line: 150
    ]]
    local v51 = a49:FindFirstChild(a50)

    if v51 and v51:IsA("BasePart") then
        return v51
    end

    return nil
end

local function classify(character: Model?, a54, a55, a56)
    --[[
      name: classify
      line: 156
      upvalues:
        combat (copy, index: 1)
        v8 (copy, index: 2)
        v9 (copy, index: 3)
        v7 (copy, index: 4)
        timestamp4 (ref,  index: 5)
    ]]
    local v57 = "Fists"

    if const tool = character:FindFirstChildOfClass("Tool") then
        local weaponId = tool:GetAttribute("WeaponId")
        local v60 = combat()

        if type(weaponId) ~= "string" or not v60 or type(v60.Kind) ~= "function" then
            v57 = "?"
        else
            v57 = v60.Kind(weaponId) or "?"
        end
    end

    if v8[v57] then
        return "melee"
    end
    if not v9[v57] then
        return nil
    end

    if a54 then
        if a55 <= v7.SCOPE_FOV then
            return "scoped"
        end

        return "aimed"
    end

    if not a56 and not (os.clock() - timestamp4 < 0.25) then
        return "ranged"
    end

    return "aimed"
end

local function closestOnSegment(position: Vector3, lookVector, a64, a65)
    --[[
      name: closestOnSegment
      line: 177
    ]]
    local v66 = a65 - a64
    local v67 = a64 - position
    local v68 = v66:Dot(v66)
    local v69 = v66:Dot(lookVector)
    local v70 = v68 - v69 * v69
    local clampedValue = 0

    if 1e-06 < v70 then
        clampedValue = math.clamp((v69 * lookVector:Dot(v67) - v66:Dot(v67)) / v70, 0, 1)
    end

    return a64 + (v66 * clampedValue)
end

local function body(a73)
    --[[
      name: body
      line: 191
    ]]
    local humanoidRootPart = a73:FindFirstChild("HumanoidRootPart")
    local v75 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
    local upperTorso = a73:FindFirstChild("UpperTorso")
    local v77 = if upperTorso and upperTorso:IsA("BasePart") then upperTorso else nil
    if not v77 then
        local torso = a73:FindFirstChild("Torso")
        v77 = if torso and torso:IsA("BasePart") then torso else nil
    end

    local head = a73:FindFirstChild("Head")
    local v80 = if head and head:IsA("BasePart") then head else nil
    local v81 = v75 or v77
    if not v81 then
        return nil, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), nil
    end

    local position = v81.Position
    local v83 = position - Vector3.new(0, 2.200000047683716, 0)
    local v84 = if v80 then v80.Position + Vector3.new(0, 0.4000000059604645, 0) else position + Vector3.new(0, 2.200000047683716, 0)
    local v85 = if v77 then v77.Position + Vector3.new(0, 0.30000001192092896, 0) else position + Vector3.new(0, 0.800000011920929, 0)

    return v81, v83, v84, v85, v77 or v81
end

local v86 = {deg = 0, cone = 0, point = Vector3.new(0, 0, 0), capsule = Vector3.new(0, 0, 0)}

local function evaluate(a88, position: Vector3, lookVector, a91, position2)
    --[[
      name: evaluate
      line: 211
      upvalues:
        workspace (copy, index: 1)
        body (copy, index: 2)
        closestOnSegment (copy, index: 3)
        v86 (copy, index: 4)
    ]]
    local humanoid = a88:FindFirstChildOfClass("Humanoid")

    if not humanoid or humanoid.Health <= 0 or not a88:IsDescendantOf(workspace) then
        return false
    end

    local v94, v95, v96, v97 = body(a88)
    if v94 then
        local magnitude = (v94.Position - position2).Magnitude

        if not (a91.range < magnitude) then
            local capsule = closestOnSegment(position, lookVector, v95, v96)
            local v100 = capsule - position
            local magnitude2 = v100.Magnitude

            if magnitude2 < 0.5 then
                return false
            end

            v86.deg, v86.cone = math.deg((math.acos((math.clamp(lookVector:Dot(v100 / magnitude2), -1, 1))))), math.clamp(math.deg((math.atan(a91.radius / magnitude2))), a91.minDeg, a91.maxDeg)
            v86.capsule = capsule
            v86.point = closestOnSegment(position, lookVector, v94.Position - Vector3.new(0, 0.800000011920929, 0), v97)

            return true
        end
    end

    return false
end

local function sees(origin: Vector3, a104, m)
    --[[
      name: sees
      line: 236
      upvalues:
        v35 (copy, index: 1)
        workspace (copy, index: 2)
        raycastParams (copy, index: 3)
        combat (copy, index: 4)
    ]]
    v35.rays += 1
    local raycastResult = workspace:Raycast(origin, a104 - origin, raycastParams)

    if raycastResult and not raycastResult.Instance:IsDescendantOf(m) then
        return false
    end

    local v107 = combat()

    if v107 and type(v107.SmokeBlocks) == "function" and v107.SmokeBlocks(origin, a104) then
        return false
    end

    return true
end

local v108 = {{m = nil, s = 0}, {m = nil, s = 0}, {m = nil, s = 0}}

local function search(position: Vector3, lookVector, a112, filterDescendantsInstances, character: Model?, position2)
    --[[
      name: search
      line: 252
      upvalues:
        v35 (copy, index: 1)
        isEnemy (copy, index: 2)
        evaluate (copy, index: 3)
        v86 (copy, index: 4)
        v20 (ref,  index: 5)
        v108 (copy, index: 6)
        Fighters (copy, index: 7)
        localPlayer (copy, index: 8)
        collectionService (copy, index: 9)
        raycastParams (copy, index: 10)
        sees (copy, index: 11)
    ]]
    v35.searches += 1
    local count = 0

    local function consider(m)
        --[[
          name: consider
          line: 255
          upvalues:
            isEnemy (copy, index: 1)
            character (copy, index: 2)
            evaluate (copy, index: 3)
            position (copy, index: 4)
            lookVector (copy, index: 5)
            a112 (copy, index: 6)
            position2 (copy, index: 7)
            v86 (copy, index: 8)
            v20 (ref,  index: 9)
            count (ref,  index: 10)
            v108 (copy, index: 11)
        ]]
        if not isEnemy(m, character) or not evaluate(m, position, lookVector, a112, position2) then
            return
        end

        local v119
        local deg = v86.deg

        if v86.cone < deg then
            return
        end

        local v121 = v86.deg / v86.cone
        local v122 = m ~= v20 and 1 or 0.7
        local s = v121 * v122
        local v124 = count + 1

        if not (3 <= count) then
            count += 1
            v119 = v124
        else
            if v108[3].s <= s then
                return
            end

            v119 = 3
        end

        while 1 < v119 do
            if not (s < v108[v119 - 1].s) then
                break
            end

            v108[v119].m, v108[v119].s = v108[v119 - 1].m, v108[v119 - 1].s
            v119 -= 1
        end

        local v125 = v108[v119]
        local v126 = v108[v119]
        v125.m = m
        v126.s = s
    end

    for _, m in Fighters.List() do
        consider(m)
    end

    if localPlayer:GetAttribute("State") ~= "Match" then
        for _, trainingDummy in collectionService:GetTagged("TrainingDummy") do
            if trainingDummy:IsA("Model") then
                consider(trainingDummy)
            end
        end
    end

    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    local m

    for index = 1, count do
        m = v108[index].m

        if evaluate(m, position, lookVector, a112, position2) then
            if sees(position, v86.point, m) then
                return m, true
            end

            local head = m:FindFirstChild("Head")

            if not head or not head:IsA("BasePart") then
                head = nil
            end

            if head then
                if sees(position, head.Position, m) then
                    return m, false
                end
            end
        end
    end

    return nil, false
end

local function drop()
    --[[
      name: drop
      line: 305
      upvalues:
        v20 (ref,  index: 1)
        unit (ref,  index: 2)
        v30 (ref,  index: 3)
        v35 (copy, index: 4)
    ]]
    v20 = nil
    unit = nil
    v30 = nil
    v35.lastDeg = -1
    v35.lastCone = -1
end

local function tuneFor(a136, key)
    --[[
      name: tuneFor
      line: 312
      upvalues:
        v7 (copy, index: 1)
    ]]
    if not a136 or not key then
        return nil
    end

    local v138 = if a136 == "gamepad" then v7.GAMEPAD else v7.TOUCH

    return v138[key]
end

local function weight(a140, a141, a142, a143)
    --[[
      name: weight
      line: 321
    ]]
    local clampedValue = math.clamp(((a140 / a141) - a142) / (a143 - a142), 0, 1)
    return 1 - (clampedValue * clampedValue * (3 - (clampedValue * 2)))
end

function v7.Apply(a145, a146, a147, a148, a149, a150, filterDescendantsInstances, a152, a153, a154)
    --[[
      name: Apply
      line: 329
      upvalues:
        v31 (ref,  index: 1)
        v32 (ref,  index: 2)
        timestamp3 (ref,  index: 3)
        timestamp4 (ref,  index: 4)
        timestamp2 (ref,  index: 5)
        v20 (ref,  index: 6)
        unit (ref,  index: 7)
        v30 (ref,  index: 8)
        v35 (copy, index: 9)
        v13 (ref,  index: 10)
        userInputService (copy, index: 11)
        localPlayer (copy, index: 12)
        workspace (copy, index: 13)
        enabled2 (ref,  index: 14)
        timestamp (ref,  index: 15)
        v28 (ref,  index: 16)
        v26 (ref,  index: 17)
        classify (copy, index: 18)
        v27 (ref,  index: 19)
        v7 (copy, index: 20)
        v21 (ref,  index: 21)
        search (copy, index: 22)
        evaluate (copy, index: 23)
        v86 (copy, index: 24)
        body (copy, index: 25)
    ]]
    local v155
    local v156
    local instance
    local timestamp5 = os.clock()

    if v31 == 0 then
        v155 = a146
    else
        local v159 = v32 * a145
        local absoluteValue = math.abs(v159)

        if math.abs(v31) <= absoluteValue then
            v159 = v31
        end

        v31 -= v159
        v155 = a146 + v159
    end

    local v161 = a146 ~= 0 or a147 ~= 0
    if v161 then
        timestamp3 = timestamp5
    end

    if a154 then
        timestamp4 = timestamp5
    end

    local v162 = 0.25 < timestamp5 - timestamp2
    timestamp2 = timestamp5

    if v162 then
        v20 = nil
        unit = nil
        v30 = nil
        v35.lastDeg = -1
        v35.lastCone = -1
    end

    if v13 == nil then
        local preferredInput = userInputService.PreferredInput
        v156 = preferredInput == Enum.PreferredInput.Touch and "touch"
            or preferredInput == Enum.PreferredInput.Gamepad and "gamepad"
            or nil
    else
        v156 = if v13 == "mouse" then nil else v13
    end

    local character = localPlayer.Character
    local character2 = character

    if character2 then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        instance = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
    else
        instance = character2
    end

    local camera = workspace.CurrentCamera

    if not enabled2 or not a150 or not v156 or not character or not instance or not camera then
        v20 = nil
        unit = nil
        v30 = nil
        v35.lastDeg = -1
        v35.lastCone = -1

        return v155, a147
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local v169 = humanoid ~= nil and 0.1 < humanoid.MoveDirection.Magnitude
    local v170 = timestamp5 - timestamp3 < 0.35 or v169 or a152 or a154
    if not v170 then
        v20 = nil
        unit = nil
        v30 = nil
        v35.lastDeg = -1
        v35.lastCone = -1

        return v155, a147
    end

    local position = camera.CFrame.Position
    local lookVector = CFrame.fromEulerAnglesYXZ(a149, a148, 0).LookVector
    local position2 = instance.Position

    if v162 or 0.05 <= timestamp5 - timestamp then
        timestamp = timestamp5
        v28 = v156
        v26 = classify(character, a152, a153, a154)
        local v174 = v26

        if not v156 or not v174 then
            v27 = nil
        else
            local v175 = if v156 == "gamepad" then v7.GAMEPAD else v7.TOUCH
            v27 = v175[v174]
        end

        if v27 then
            v20, v21 = search(position, lookVector, v27, filterDescendantsInstances, character, position2)
        else
            v20 = nil
        end
    end

    local v176 = v27
    local v177 = v20

    if not v176 or not v177 then
        v20 = nil
        unit = nil
        v30 = nil
        v35.lastDeg = -1
        v35.lastCone = -1

        return v155, a147
    end

    if evaluate(v177, position, lookVector, v176, position2) then
        local deg = v86.deg

        if not (v86.cone * 1.25 < deg) then
            local v179
            v35.frames += 1
            v35.lastDeg, v35.lastCone = v86.deg, v86.cone
            local clampedValue = math.clamp(((v86.deg / v86.cone) - 0.6) / 0.4, 0, 1)
            local v181 = 1 - clampedValue * clampedValue * (3 - (clampedValue * 2))
            local clampedValue2 = math.clamp(((v86.deg / v86.cone) - 0.85) / 0.4, 0, 1)
            local v183 = 1 - clampedValue2 * clampedValue2 * (3 - (clampedValue2 * 2))

            if v161 then
                if not (0 < v181) then
                    v179 = a147
                else
                    local unit2 = (v86.point - position).Unit
                    local v185 = ((math.atan2(-unit2.X, -unit2.Z) - a148) + math.pi) % math.tau - math.pi
                    local v186 = math.asin((math.clamp(unit2.Y, -1, 1))) - a149
                    local v187 = 0 < (a146 * v185) + (a147 * v186)
                    local v188 = (1 - v176.friction) * v181
                    local v189 = v187 and 0.35 or 1
                    local v190 = 1 - v188 * v189
                    v155 += a146 * (v190 - 1)
                    v179 = a147 + a147 * (v190 - 1)

                    if v190 < 0.999 then
                        v35.slowed += 1
                    end

                    if v21 and 0 < v176.pull then
                        local v191 = math.sqrt((v185 * v185) + (v186 * v186))
                        local v192 = math.sqrt((a146 * a146) + (a147 * a147))

                        if 1e-04 < v191 then
                            local v193 = math.min((v176.pull * v181) * v192, v191 * 0.5)
                            v155 += (v185 / v191) * v193
                            v179 += (v186 / v191) * v193
                            local v194 = v35
                            v194.pullDeg += math.deg(v193)
                        end
                    end
                end
            else
                v179 = a147
            end

            local _, _, _, _, v199 = body(v177)
            if v199 then
                local v200 = position2 + Vector3.new(0, 1.5, 0)
                local unit3 = (v199.Position - v200).Unit
                local unit4 = unit

                if unit4 and v30 == v177 and 0 < a145 and a145 < 0.1 then
                    local v203 = ((math.atan2(-unit3.X, -unit3.Z) - math.atan2(-unit4.X, -unit4.Z)) + math.pi) % math.tau - math.pi
                    local v204 = math.asin((math.clamp(unit3.Y, -1, 1))) - math.asin((math.clamp(unit4.Y, -1, 1)))

                    if math.abs(v203) < 0.13962634015954636 and math.abs(v204) < 0.13962634015954636 then
                        local maxValue = a145 * 1.5707963267948966
                        local clampedValue3 = math.clamp((v203 * v176.track) * v183, -maxValue, maxValue)
                        local clampedValue4 = math.clamp((v204 * v176.trackPitch) * v183, -maxValue, maxValue)
                        v155 += clampedValue3
                        v179 += clampedValue4
                        v35.trackDeg += math.deg(math.abs(clampedValue3) + math.abs(clampedValue4))
                    end
                end

                unit = unit3
                v30 = v177
            end

            return v155, v179
        end
    end

    v20 = nil
    unit = nil
    v30 = nil
    v35.lastDeg = -1
    v35.lastCone = -1

    return v155, a147
end

function v7.Shot(filterDescendantsInstances, a209, a210, a211, a212, a213)
    --[[
      name: Shot
      line: 456
      upvalues:
        v13 (ref,  index: 1)
        userInputService (copy, index: 2)
        localPlayer (copy, index: 3)
        workspace (copy, index: 4)
        enabled2 (ref,  index: 5)
        classify (copy, index: 6)
        v7 (copy, index: 7)
        search (copy, index: 8)
        evaluate (copy, index: 9)
        body (copy, index: 10)
        v86 (copy, index: 11)
    ]]
    local input
    local instance

    if v13 == nil then
        local preferredInput = userInputService.PreferredInput
        input = preferredInput == Enum.PreferredInput.Touch and "touch"
            or preferredInput == Enum.PreferredInput.Gamepad and "gamepad"
            or nil
    else
        input = if v13 == "mouse" then nil else v13
    end

    local character = localPlayer.Character
    local character2 = character

    if character2 then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        instance = if humanoidRootPart and humanoidRootPart:IsA("BasePart") then humanoidRootPart else nil
    else
        instance = character2
    end

    local camera = workspace.CurrentCamera

    if not enabled2 or not input or not character or not instance or not camera then
        return nil
    end

    local v221
    local class = classify(character, a211, a212, a213)

    if not input or not class then
        v221 = nil
    else
        local v223 = if input == "gamepad" then v7.GAMEPAD else v7.TOUCH
        v221 = v223[class]
    end

    if not v221 or not class then
        return nil
    end

    local position = camera.CFrame.Position
    local lookVector = CFrame.fromEulerAnglesYXZ(a210, a209, 0).LookVector
    local model, torsoVisible = search(position, lookVector, v221, filterDescendantsInstances, character, instance.Position)

    if not model or not evaluate(model, position, lookVector, v221, instance.Position) then
        return nil
    end

    local _, _, _, _, part = body(model)
    if not part then
        return nil
    end

    return {model = model, part = part, point = v86.point, deg = v86.deg, cone = v86.cone, class = class, input = input, torsoVisible = torsoVisible}
end

function v7.Nudge(a233, a234: number)
    --[[
      name: Nudge
      line: 492
      upvalues:
        v31 (ref, index: 1)
        v32 (ref, index: 2)
    ]]
    v31 = a233
    v32 = a233 / math.max(a234, 0.004166666666666667)
end

function v7.IsAssistedInput()
    --[[
      name: IsAssistedInput
      line: 497
      upvalues:
        v13 (ref,  index: 1)
        userInputService (copy, index: 2)
    ]]
    local v235

    if v13 == nil then
        local preferredInput = userInputService.PreferredInput
        v235 = preferredInput == Enum.PreferredInput.Touch and "touch"
            or preferredInput == Enum.PreferredInput.Gamepad and "gamepad"
            or nil
    else
        v235 = if v13 == "mouse" then nil else v13
    end

    return v235 ~= nil
end

function v7.InputKind()
    --[[
      name: InputKind
      line: 501
      upvalues:
        v13 (ref,  index: 1)
        userInputService (copy, index: 2)
    ]]
    if v13 ~= nil then
        if v13 == "mouse" then
            return nil
        end

        return v13
    end

    local preferredInput = userInputService.PreferredInput

    if preferredInput == Enum.PreferredInput.Touch then
        return "touch"
    end
    if preferredInput == Enum.PreferredInput.Gamepad then
        return "gamepad"
    end

    return nil
end

function v7.SetEnabled(enabled)
    --[[
      name: SetEnabled
      line: 505
      upvalues:
        enabled2 (ref,  index: 1)
        v20 (ref,  index: 2)
        unit (ref,  index: 3)
        v30 (ref,  index: 4)
        v35 (copy, index: 5)
        v31 (ref,  index: 6)
    ]]
    enabled2 = enabled == true

    if not enabled2 then
        v20 = nil
        unit = nil
        v30 = nil
        v35.lastDeg = -1
        v35.lastCone = -1
        v31 = 0
    end
end

function v7.IsEnabled()
    --[[
      name: IsEnabled
      line: 513
      upvalues:
        enabled2 (ref, index: 1)
    ]]
    return enabled2
end

function v7.TakeInjected()
    --[[
      name: TakeInjected
      line: 518
      upvalues:
        injectLeft (ref, index: 1)
        vector2 (ref, index: 2)
    ]]
    if injectLeft <= 0 then
        return Vector2.zero
    end

    injectLeft -= 1

    return vector2
end

function v7.Stats()
    --[[
      name: Stats
      line: 526
      upvalues:
        v20 (ref,  index: 1)
        v35 (copy, index: 2)
        v26 (ref,  index: 3)
        v28 (ref,  index: 4)
    ]]
    local v239 = {aimAssistTarget = if v20 then v20.Name else ""}
    v239.aimAssistDeg = v35.lastDeg
    v239.aimAssistCone = v35.lastCone
    v239.aimAssistFrames = v35.frames
    v239.aimAssistSlowed = v35.slowed
    v239.aimAssistTrackDeg = v35.trackDeg
    v239.aimAssistPullDeg = v35.pullDeg
    v239.aimAssistSearches = v35.searches
    v239.aimAssistRays = v35.rays
    v239.aimAssistClass = v26 or ""
    v239.aimAssistInput = v28 or ""
    return v239
end

function v7.Debug(a240, a241, a242, a243)
    --[[
      name: Debug
      line: 546
      upvalues:
        v7 (copy, index: 1)
        enabled2 (ref,  index: 2)
        v13 (ref,  index: 3)
        userInputService (copy, index: 4)
        injectLeft (ref,  index: 5)
        v35 (copy, index: 6)
        isStudio (copy, index: 7)
        vector2 (ref,  index: 8)
    ]]
    if a240 == "state" then
        local v244
        local v245 = v7.Stats()
        v245.enabled = enabled2
        v245.forced = v13 or false

        if v13 == nil then
            local preferredInput = userInputService.PreferredInput
            v244 = preferredInput == Enum.PreferredInput.Touch and "touch"
                or preferredInput == Enum.PreferredInput.Gamepad and "gamepad"
                or nil
        else
            v244 = if v13 == "mouse" then nil else v13
        end

        v245.assisted = v244 ~= nil
        v245.injectLeft = injectLeft

        return v245
    end

    if a240 == "reset" then
        for v247 in v35 do
            v35[v247] = 0
        end

        v35.lastDeg = -1
        v35.lastCone = -1

        return true
    end

    if not isStudio then
        return nil
    end

    if a240 == "force" then
        v13 = if a241 ~= "touch" and a241 ~= "gamepad" and a241 ~= "mouse" then nil else a241
        return v13 or false
    end

    if a240 == "inject" then
        vector2 = Vector2.new((tonumber(a241) or 0), (tonumber(a242) or 0))
        injectLeft = math.clamp(math.floor((tonumber(a243) or 1)), 0, 1e+05)

        return true
    end

    return nil
end

return v7