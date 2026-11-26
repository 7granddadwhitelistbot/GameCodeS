local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local Characters = require(script.Parent:WaitForChild("Characters"))
local Effects = require(script.Parent:WaitForChild("Effects"))
local Perf = require(script.Parent:WaitForChild("Perf"))
local AnimationIds = require(script.Parent:WaitForChild("AnimationIds"))
local AnimGuard = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("AnimGuard"))
local v9 = {}
local localPlayer = players.LocalPlayer
local isStudio = runService:IsStudio()

local function clientAuthority()
    --[[
      name: clientAuthority
      line: 78
      upvalues:
        workspace (copy, index: 1)
    ]]
    return workspace:GetAttribute("TribesAuthority") == "Client"
end

local v13 = {}

for _, v15 in {AnimationIds.R15, AnimationIds.R6} do
    for _, v17 in {"idle", "idle2", "walk", "run", "jump", "fall"} do
        local v18 = v15[v17]

        if type(v18) == "string" and v18 ~= "" then
            v13[v18] = true
        end
    end
end

local v19 = {}
v19[AnimationIds.SlideLegs] = true
v19[AnimationIds.SlideFallback] = true
local v20 = setmetatable({}, {__mode = "k"})
local v21 = {}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.RespectCanCollide = true
local v23 = setmetatable({}, {__mode = "k"})

local function guard(key)
    --[[
      name: guard
      line: 107
      upvalues:
        v23 (copy, index: 1)
    ]]
    if not key then
        return
    end

    local priority = v23[key]

    if priority and key.Priority ~= priority then
        key.Priority = priority
    end

    if not key.Looped then
        key.Looped = true
    end
end

local function load(animator, animationId, priority: Enum.AnimationPriority, name: string)
    --[[
      name: load
      line: 120
      upvalues:
        v23 (copy, index: 1)
        v20 (copy, index: 2)
    ]]
    if animationId == "" then
        return nil
    end

    local animation = Instance.new("Animation")
    animation.Name = name
    animation.AnimationId = animationId
    local success, result = pcall(
        function()
            --[[
              line: 127
              upvalues:
                animator (copy, index: 1)
                animation (copy, index: 2)
            ]]
            return animator:LoadAnimation(animation)
        end
    )

    if not success or not result then
        return nil
    end

    result.Priority = priority
    result.Looped = true
    v23[result] = priority
    v20[result] = true

    return result
end

local function build(character, a37: boolean)
    --[[
      name: build
      line: 140
      upvalues:
        AnimationIds (copy, index: 1)
        load (copy, index: 2)
    ]]
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")

    if not humanoid or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") or not animator then
        return nil
    end

    local v41
    local v42 = if humanoid.RigType == Enum.HumanoidRigType.R6 then AnimationIds.R6 else AnimationIds.R15
    local v43 = {legs = nil, upper = nil, sliding = false, slideSound = nil, replSliding = false, groundedAt = 0, jumpAt = -1, active = false, character = character, humanoid = humanoid, root = humanoidRootPart, tracks = {}, weights = {}, targets = {}}

    for _, v45 in {"idle", "walk", "run", "jump", "fall"} do
        if const v46 = load(animator, v42[v45], Enum.AnimationPriority.Core, v45) then
            v43.tracks[v45] = v46
            v43.weights[v45] = 0
        end
    end

    if not a37 then
        return v43
    end

    local legs = load(animator, AnimationIds.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs")

    if legs then
        v41 = v43
    else
        legs = load(animator, AnimationIds.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback")
        v41 = v43
    end

    v41.legs = legs
    v41.upper = load(animator, AnimationIds.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")

    return v41
end

local function muteReplicated(a49)
    --[[
      name: muteReplicated
      line: 181
      upvalues:
        v20 (copy, index: 1)
        v13 (copy, index: 2)
        v19 (copy, index: 3)
    ]]
    local animator = a49.humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        return
    end

    local replSliding = false

    for _, playingAnimationTrack in animator:GetPlayingAnimationTracks() do
        if not v20[playingAnimationTrack] then
            local animation = playingAnimationTrack.Animation

            if animation and v13[animation.AnimationId] then
                playingAnimationTrack:Stop(0)
            elseif animation then
                if not v19[animation.AnimationId] then
                    continue
                end
                if not (0.5 < playingAnimationTrack.WeightTarget) then
                    continue
                end

                replSliding = true
            end
        end
    end

    a49.replSliding = replSliding
end

local function setSlideSound(slideSound2, a57)
    --[[
      name: setSlideSound
      line: 201
      upvalues:
        Effects (copy, index: 1)
    ]]
    if a57 and not slideSound2.slideSound then
        slideSound2.slideSound = Effects.PlaySound("Slide", slideSound2.root, {pitchVar = 0.08, looped = true, volume = 1.2})
        return
    end

    if not a57 and slideSound2.slideSound then
        local slideSound = slideSound2.slideSound
        slideSound2.slideSound = nil

        task.spawn(
            function()
                --[[
                  line: 207
                  upvalues:
                    slideSound (copy, index: 1)
                ]]
                for _ = 1, 8 do
                    if not slideSound.Parent then
                        break
                    end

                    slideSound.Volume *= 0.7
                    task.wait(0.02)
                end

                slideSound:Destroy()
            end
        )
    end
end

local function setSliding(sliding3, a62)
    --[[
      name: setSliding
      line: 222
    ]]
    local character = sliding3.character

    if character.Parent then
        local sliding = character:GetAttribute("Sliding") == true

        if sliding ~= a62 then
            local sliding2 = a62 and true or nil
            character:SetAttribute("Sliding", sliding2)
        end
    end
end

local v66 = setmetatable({}, {__mode = "k"})

local function guardTracks(key)
    --[[
      name: guardTracks
      line: 235
      upvalues:
        v66 (copy, index: 1)
        AnimGuard (copy, index: 2)
    ]]
    local humanoid = key:FindFirstChildOfClass("Humanoid")

    if const animator = humanoid and humanoid:FindFirstChildOfClass("Animator") then
        v66[key] = true
        AnimGuard.Watch(animator)
    end
end

local function stopAll(a72)
    --[[
      name: stopAll
      line: 244
    ]]
    for weightKey, track in a72.tracks do
        track:Stop(0.2)
        a72.weights[weightKey] = 0
    end

    if a72.legs then
        a72.legs:Stop(0.15)
    end

    if a72.upper then
        a72.upper:Stop(0.15)
    end

    a72.sliding = false
    a72.replSliding = false

    if a72.slideSound then
        local slideSound = a72.slideSound
        a72.slideSound = nil

        task.spawn(
            function()
                --[[
                  line: 207
                  upvalues:
                    slideSound (copy, index: 1)
                ]]
                for _ = 1, 8 do
                    if not slideSound.Parent then
                        break
                    end

                    slideSound.Volume *= 0.7
                    task.wait(0.02)
                end

                slideSound:Destroy()
            end
        )
    end

    local character = a72.character

    if character.Parent then
        local sliding = character:GetAttribute("Sliding") == true

        if sliding ~= false then
            character:SetAttribute("Sliding", nil)
        end
    end

    a72.active = false
end

local function destroyRig(a80)
    --[[
      name: destroyRig
      line: 267
    ]]
    local function drop(a82)
        --[[
          name: drop
          line: 268
        ]]
        if a82 then
            pcall(
                function()
                    --[[
                      line: 270
                      upvalues:
                        a82 (copy, index: 1)
                    ]]
                    a82:Stop(0)
                    a82:Destroy()
                end
            )
        end
    end

    for _, track in a80.tracks do
        if track then
            pcall(
                function()
                    --[[
                      line: 270
                      upvalues:
                        track (copy, index: 1)
                    ]]
                    track:Stop(0)
                    track:Destroy()
                end
            )
        end
    end

    if const legs = a80.legs then
        pcall(
            function()
                --[[
                  line: 270
                  upvalues:
                    legs (copy, index: 1)
                ]]
                legs:Stop(0)
                legs:Destroy()
            end
        )
    end

    if const upper = a80.upper then
        pcall(
            function()
                --[[
                  line: 270
                  upvalues:
                    upper (copy, index: 1)
                ]]
                upper:Stop(0)
                upper:Destroy()
            end
        )
    end

    table.clear(a80.tracks)
    a80.legs = nil
    a80.upper = nil

    if a80.slideSound then
        a80.slideSound:Destroy()
        a80.slideSound = nil
    end

    a80.active = false
end

local function step(slideSound, a89: number, timestamp: number)
    --[[
      name: step
      line: 290
      upvalues:
        stopAll (copy, index: 1)
        raycastParams (copy, index: 2)
        workspace (copy, index: 3)
        v23 (copy, index: 4)
        setSlideSound (copy, index: 5)
        localPlayer (copy, index: 6)
    ]]
    local humanoid = slideSound.humanoid
    local root = slideSound.root

    if humanoid.Health <= 0 then
        if slideSound.active then
            stopAll(slideSound)
        end

        return
    end

    local v93
    local v94
    slideSound.active = true
    local targets = slideSound.targets

    for targetKey in slideSound.tracks do
        targets[targetKey] = 0
    end

    local assemblyLinearVelocity = root.AssemblyLinearVelocity
    local magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude
    local sHipBase = root:GetAttribute("SHipBase")

    if type(sHipBase) ~= "number" then
        v93 = humanoid.HipHeight
    else
        v93 = sHipBase
    end

    local v100 = math.max(0.5, v93 / 2)
    raycastParams.FilterDescendantsInstances = {slideSound.character}
    local v101 = humanoid.HipHeight + (root.Size.Y / 2) + 0.9
    local v102 = math.abs(assemblyLinearVelocity.Y) < 12
        and workspace:Raycast(root.Position, Vector3.new(0, -v101, 0), raycastParams) ~= nil

    if v102 then
        slideSound.groundedAt = timestamp
    elseif 8 < assemblyLinearVelocity.Y and timestamp - slideSound.groundedAt < 0.25 then
        slideSound.jumpAt = timestamp
    end

    if v102 or timestamp - slideSound.groundedAt < 0.1 then
        local v103
        local clampedValue = math.clamp((magnitude - 0.6) / 2.5, 0, 1)
        local clampedValue2 = math.clamp(((magnitude / v100) - 9) / 5, 0, 1)
        targets.idle = 1 - clampedValue
        targets.walk = clampedValue * (1 - clampedValue2)
        targets.run = clampedValue * clampedValue2
        local v106 = 1

        if not (1 < magnitude) then
            v103 = v106
        else
            local lookVector = root.CFrame.LookVector
            v103 = (assemblyLinearVelocity.X * lookVector.X + (assemblyLinearVelocity.Z * lookVector.Z)) / magnitude < -0.35
                and -1
                or v106
        end

        local walk = slideSound.tracks.walk
        local run = slideSound.tracks.run

        if walk then
            walk:AdjustSpeed(v103 * math.clamp(magnitude / (v100 * 7.5), 0.4, 1.8))
        end

        if run then
            run:AdjustSpeed(v103 * math.clamp(magnitude / (v100 * 16.5), 0.55, 1.7))
        end
    elseif not (0 < slideSound.jumpAt)
        or not (timestamp - slideSound.jumpAt < 0.45)
        or not (-12 < assemblyLinearVelocity.Y)
    then
        targets.fall = 1
    else
        targets.jump = 1
    end

    local v110 = 1 - math.exp(a89 * -14)

    if const legs = slideSound.legs then
        local priority = v23[legs]

        if priority and legs.Priority ~= priority then
            legs.Priority = priority
        end

        if not legs.Looped then
            legs.Looped = true
        end
    end

    if const upper = slideSound.upper then
        local priority = v23[upper]

        if priority and upper.Priority ~= priority then
            upper.Priority = priority
        end

        if not upper.Looped then
            upper.Looped = true
        end
    end

    for v115, track in slideSound.tracks do
        if track then
            local priority = v23[track]

            if priority and track.Priority ~= priority then
                track.Priority = priority
            end

            if not track.Looped then
                track.Looped = true
            end
        end

        local v118 = slideSound.weights[v115] + ((targets[v115] or 0) - slideSound.weights[v115]) * v110

        if v118 < 0.001 then
            v118 = 1e-04
        end

        slideSound.weights[v115] = v118

        if track.IsPlaying then
            track:AdjustWeight(v118, 0)
        else
            track:Play(0, v118, track.Speed)
        end
    end

    local sliding3 = root:GetAttribute("SSlide") ~= nil

    if sliding3 ~= slideSound.sliding then
        slideSound.sliding = sliding3

        if sliding3 then
            if slideSound.legs then
                slideSound.legs:Play(0.08, 1, 1)
            end

            if slideSound.upper then
                slideSound.upper:Play(0.12, 1, 1)
            end
        else
            if slideSound.legs then
                slideSound.legs:Stop(0.15)
            end

            if slideSound.upper then
                slideSound.upper:Stop(0.15)
            end
        end
    end

    if slideSound.sliding then
        v94 = 4 <= magnitude
    else
        v94 = slideSound.replSliding
        v94 = v94 and 4 <= magnitude
    end

    local character = slideSound.character

    if character.Parent then
        local sliding = character:GetAttribute("Sliding") == true

        if sliding ~= v94 then
            local sliding2 = v94 and true or nil
            character:SetAttribute("Sliding", sliding2)
        end
    end

    setSlideSound(slideSound, (v94 and (localPlayer:GetAttribute("State") == "Match")))
end

local v123 = 0

local function update(deltaTime: number)
    --[[
      name: update
      line: 390
      upvalues:
        v123 (ref,  index: 1)
        workspace (copy, index: 2)
        Characters (copy, index: 3)
        isStudio (copy, index: 4)
        localPlayer (copy, index: 5)
        v66 (copy, index: 6)
        AnimGuard (copy, index: 7)
        v21 (copy, index: 8)
        stopAll (copy, index: 9)
        build (copy, index: 10)
        muteReplicated (copy, index: 11)
        step (copy, index: 12)
        destroyRig (copy, index: 13)
    ]]
    v123 += deltaTime

    if v123 < 0.03333333333333333 then
        return
    end

    local v126 = math.min(v123, 0.1)
    v123 = 0
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local position = camera.CFrame.Position
    local timestamp = os.clock()
    local v130 = {}

    for _, character in Characters.List() do
        local v133 = Characters.PlayerOf(character)
        local hasTag = isStudio and character:HasTag("CharacterLoadTest")

        if v133 ~= localPlayer then
            if v133 or hasTag or character:HasTag("Combatant") then
                local v135 = v133 ~= nil and workspace:GetAttribute("TribesAuthority") == "Client"
                    or isStudio and character:HasTag("ClientAuthorityTest")

                if v135 and not v66[character] then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")

                    if const animator = humanoid and humanoid:FindFirstChildOfClass("Animator") then
                        v66[character] = true
                        AnimGuard.Watch(animator)
                    end
                end

                if const humanoidRootPart = character:FindFirstChild("HumanoidRootPart") then
                    local v139, v140
                    local v141
                    local v142 = false

                    if humanoidRootPart:IsA("BasePart") then
                        v139 = v21[character]

                        if not (160 < (humanoidRootPart.Position - position).Magnitude) then
                            if v139 then
                                v141 = v139
                                v142 = true
                            else
                                v140 = build(character, not v135)

                                if v140 then
                                    v21[character] = v140
                                    v141 = v140
                                    v142 = true
                                end
                            end
                        elseif v139 and v139.active then
                            stopAll(v139)
                        end
                    end

                    if v142 then
                        v130[character] = true

                        if v135 then
                            muteReplicated(v141)
                        end

                        step(v141, v126, timestamp)
                    end
                end
            end
        end
    end

    for v143, v144 in v21 do
        if v143.Parent then
            if not v130[v143] and v144.active then
                stopAll(v144)
            end
        else
            destroyRig(v144)
            v21[v143] = nil
        end
    end
end

local hasRun = false

function v9.Start()
    --[[
      name: Start
      line: 452
      upvalues:
        hasRun (ref,  index: 1)
        runService (copy, index: 2)
        Perf (copy, index: 3)
        update (copy, index: 4)
    ]]
    if hasRun then
        return
    end

    hasRun = true

    runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 457
              upvalues:
                Perf (copy, index: 1)
                update (copy, index: 2)
            ]]
            local v147 = Perf.Begin()
            update(deltaTime)
            Perf.End("RemoteAnimate", v147)
        end
    )
end

return v9