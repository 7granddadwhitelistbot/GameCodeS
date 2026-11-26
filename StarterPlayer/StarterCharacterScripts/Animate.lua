local v1
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local parent = script.Parent
local humanoid = parent:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator")
local humanoidRootPart = parent:WaitForChild("HumanoidRootPart")
local success, Camera = pcall(
    function()
        --[[
          line: 27
          upvalues:
            replicatedStorage (copy, index: 1)
        ]]
        return (require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Camera")))
    end
)
pcall(
    function()
        --[[
          line: 33
          upvalues:
            replicatedStorage (copy, index: 1)
            animator (copy, index: 2)
        ]]
        require(replicatedStorage:WaitForChild("Shared"):WaitForChild("AnimGuard")).Watch(animator)
    end
)
local playerScripts = players.LocalPlayer:WaitForChild("PlayerScripts")
local AnimationIds = require(playerScripts:WaitForChild("Character"):WaitForChild("AnimationIds"))
local r15 = AnimationIds.R15
local r6 = AnimationIds.R6
local emotes = AnimationIds.Emotes

if humanoid.RigType ~= Enum.HumanoidRigType.R6 then
    v1 = r15
else
    v1 = r6
end

local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}

local function load(name: string, animationId: string, looped: boolean)
    --[[
      name: load
      line: 68
      upvalues:
        animator (copy, index: 1)
        v16 (copy, index: 2)
        v17 (copy, index: 3)
    ]]
    local animation = Instance.new("Animation")
    animation.Name = name
    animation.AnimationId = animationId

    local animationTrack = animator:LoadAnimation(animation)
    animationTrack.Priority = Enum.AnimationPriority.Core
    animationTrack.Looped = looped
    v16[name] = animationTrack
    v17[name] = 0

    return animationTrack
end

for name, animationId in v1 do
    local animationId2 = animationId
    local name2 = name
    local animation = Instance.new("Animation")
    animation.Name = name2
    animation.AnimationId = animationId2

    local animationTrack = animator:LoadAnimation(animation)
    animationTrack.Priority = Enum.AnimationPriority.Core
    animationTrack.Looped = true
    v16[name2] = animationTrack
    v17[name2] = 0
end

for v32, v33 in v16 do
    local v34 = v32
    local v35 = v33
    v35:Play(0, 1e-04, 1)
    v17[v34] = 0
    v18[v34] = 1e-04
    v19[v34] = 1
end

v17.idle = 1
v16.idle:AdjustWeight(1, 0)
v18.idle = 1
local v36 = 0
local v37 = false
local v38 = "ground"
local v39 = -1
local v40 = 0
local v41 = 0
local animationTrack = nil

local function stopEmote()
    --[[
      name: stopEmote
      line: 105
      upvalues:
        animationTrack (ref,  index: 1)
        success (copy, index: 2)
        Camera (copy, index: 3)
    ]]
    if animationTrack then
        animationTrack:Stop(0.2)
        animationTrack = nil

        if success then
            Camera.ResumeCharacterRotation("Emote")
        end
    end
end

local v44 = {}
v44[Enum.HumanoidStateType.Jumping] = "air"
v44[Enum.HumanoidStateType.Freefall] = "air"
v44[Enum.HumanoidStateType.Climbing] = "climb"
v44[Enum.HumanoidStateType.Swimming] = "swim"
v44[Enum.HumanoidStateType.Seated] = "sit"
v44[Enum.HumanoidStateType.Dead] = "none"
v44[Enum.HumanoidStateType.Physics] = "none"
v44[Enum.HumanoidStateType.Ragdoll] = "none"
v44[Enum.HumanoidStateType.FallingDown] = "none"
v44[Enum.HumanoidStateType.PlatformStanding] = "none"
v44[Enum.HumanoidStateType.Running] = "ground"
v44[Enum.HumanoidStateType.RunningNoPhysics] = "ground"
v44[Enum.HumanoidStateType.Landed] = "ground"
v44[Enum.HumanoidStateType.GettingUp] = "ground"

local function startJump(timePosition)
    --[[
      name: startJump
      line: 134
      upvalues:
        v38 (ref,  index: 1)
        v39 (ref,  index: 2)
        v16 (copy, index: 3)
    ]]
    if v38 == "air" and 0 < v39 and os.clock() - v39 < 0.4 then
        return
    end

    v38 = "air"
    v39 = os.clock() - timePosition
    v16.jump.TimePosition = timePosition
end

local function enterMode(a48)
    --[[
      name: enterMode
      line: 143
      upvalues:
        v38 (ref,  index: 1)
        v39 (ref,  index: 2)
        animationTrack (ref,  index: 3)
        success (copy, index: 4)
        Camera (copy, index: 5)
    ]]
    if a48 == v38 then
        return
    end

    if a48 == "air" then
        v39 = -1
    end

    if a48 ~= "ground" and a48 ~= "sit" and animationTrack then
        animationTrack:Stop(0.2)
        animationTrack = nil

        if success then
            Camera.ResumeCharacterRotation("Emote")
        end
    end

    v38 = a48
end

humanoid.StateChanged:Connect(
    function(a49, key)
        --[[
          line: 156
          upvalues:
            runService (copy, index: 1)
            v38 (ref,  index: 2)
            v39 (ref,  index: 3)
            v16 (copy, index: 4)
            animationTrack (ref,  index: 5)
            success (copy, index: 6)
            Camera (copy, index: 7)
            v44 (copy, index: 8)
        ]]
        if runService:IsResimulating() then
            return
        end

        if key == Enum.HumanoidStateType.Jumping then
            if v38 ~= "air" or not (0 < v39) or not (os.clock() - v39 < 0.4) then
                v38 = "air"
                v39 = os.clock() - 0
                v16.jump.TimePosition = 0
            end

            if animationTrack then
                animationTrack:Stop(0.2)
                animationTrack = nil

                if success then
                    Camera.ResumeCharacterRotation("Emote")
                end
            end

            return
        elseif const v51 = v44[key] then
            if v51 == v38 then
                return
            end

            if v51 == "air" then
                v39 = -1
            end

            if v51 ~= "ground" and v51 ~= "sit" and animationTrack then
                animationTrack:Stop(0.2)
                animationTrack = nil

                if success then
                    Camera.ResumeCharacterRotation("Emote")
                end
            end

            v38 = v51
        end
    end
)

humanoid.Climbing:Connect(
    function(speed: number)
        --[[
          line: 171
          upvalues:
            v40 (ref, index: 1)
        ]]
        v40 = speed
    end
)
humanoid.Swimming:Connect(
    function(speed: number)
        --[[
          line: 174
          upvalues:
            v41 (ref, index: 1)
        ]]
        v41 = speed
    end
)
local playEmote = script:FindFirstChild("PlayEmote")
if not playEmote then
    playEmote = Instance.new("BindableFunction")
    playEmote.Name = "PlayEmote"
    playEmote.Parent = script
end

local function inMatch()
    --[[
      name: inMatch
      line: 186
      upvalues:
        players (copy, index: 1)
    ]]
    return players.LocalPlayer:GetAttribute("State") == "Match"
end

players.LocalPlayer:GetAttributeChangedSignal("State"):Connect(
    function()
        --[[
          line: 189
          upvalues:
            players (copy, index: 1)
            animationTrack (ref,  index: 2)
            success (copy, index: 3)
            Camera (copy, index: 4)
        ]]
        local v56 = players.LocalPlayer:GetAttribute("State") == "Match"

        if v56 and animationTrack then
            animationTrack:Stop(0.2)
            animationTrack = nil

            if success then
                Camera.ResumeCharacterRotation("Emote")
            end
        end
    end
)

playEmote.OnInvoke = function(emoteKey)
    --[[
      line: 194
      upvalues:
        v38 (ref,  index: 1)
        humanoid (copy, index: 2)
        players (copy, index: 3)
        emotes (copy, index: 4)
        animationTrack (ref,  index: 5)
        success (copy, index: 6)
        Camera (copy, index: 7)
        animator (copy, index: 8)
    ]]
    if v38 ~= "ground"
        or 0.05 < humanoid.MoveDirection.Magnitude
        or players.LocalPlayer:GetAttribute("State") == "Match"
    then
        return false
    end

    local v58
    local v59 = nil

    if typeof(emoteKey) == "Instance" and emoteKey:IsA("Animation") then
        v58 = emoteKey
    elseif typeof(emoteKey) ~= "string" then
        v58 = v59
    elseif emotes[emoteKey] then
        v58 = Instance.new("Animation")
        v58.AnimationId = emotes[emoteKey]
    else
        v58 = v59
    end

    if not v58 then
        return false
    end

    if animationTrack then
        animationTrack:Stop(0.2)
        animationTrack = nil

        if success then
            Camera.ResumeCharacterRotation("Emote")
        end
    end

    local animationTrack2 = animator:LoadAnimation(v58)
    animationTrack2.Priority = Enum.AnimationPriority.Idle
    animationTrack2:Play(0.2)
    animationTrack = animationTrack2

    if success then
        Camera.SuspendCharacterRotation("Emote")
    end

    animationTrack2.Stopped:Once(
        function()
            --[[
              line: 217
              upvalues:
                animationTrack (ref,  index: 1)
                animationTrack2 (copy, index: 2)
                success (copy, index: 3)
                Camera (copy, index: 4)
            ]]
            if animationTrack == animationTrack2 then
                animationTrack = nil

                if success then
                    Camera.ResumeCharacterRotation("Emote")
                end
            end
        end
    )

    return true
end

local v61 = {}

local function scale()
    --[[
      name: scale
      line: 231
      upvalues:
        parent (copy, index: 1)
        humanoid (copy, index: 2)
    ]]
    local v63
    local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
    local sHipBase = humanoidRootPart and humanoidRootPart:GetAttribute("SHipBase")

    if type(sHipBase) ~= "number" then
        v63 = humanoid.HipHeight
    else
        v63 = sHipBase
    end

    return (math.max(0.5, v63 / 2))
end

local v66 = false
local v67 = {}
local v68 = 0
local v69 = v38

local function push()
    --[[
      name: push
      line: 246
      upvalues:
        v16 (copy, index: 1)
        v17 (copy, index: 2)
        v18 (copy, index: 3)
        v61 (copy, index: 4)
        v67 (copy, index: 5)
        v19 (copy, index: 6)
    ]]
    for v71, v72 in v16 do
        local v73 = v17[v71]
        local v74 = v18[v71]

        if v73 ~= v74 and (0.01 <= math.abs(v73 - v74) or v73 == math.max(v61[v71] or 0, 1e-04)) then
            v18[v71] = v73
            v72:AdjustWeight(v73, 0.05)
        end

        local v75 = v67[v71]

        if v75 and 0.02 <= math.abs(v75 - v19[v71]) then
            v19[v71] = v75
            v72:AdjustSpeed(v75)
        end

        if not v72.IsPlaying then
            v72:Play(0, v18[v71], v19[v71])
        end
    end
end

runService.Heartbeat:Connect(
    function(deltaTime: number)
        --[[
          line: 265
          upvalues:
            v66 (ref,  index: 1)
            parent (copy, index: 2)
            v16 (copy, index: 3)
            v61 (copy, index: 4)
            v67 (copy, index: 5)
            humanoidRootPart (copy, index: 6)
            humanoid (copy, index: 7)
            v44 (copy, index: 8)
            v38 (ref,  index: 9)
            v39 (ref,  index: 10)
            animationTrack (ref,  index: 11)
            success (copy, index: 12)
            Camera (copy, index: 13)
            v36 (ref,  index: 14)
            v37 (ref,  index: 15)
            v40 (ref,  index: 16)
            v41 (ref,  index: 17)
            v17 (copy, index: 18)
            v68 (ref,  index: 19)
            v69 (ref,  index: 20)
            push (copy, index: 21)
        ]]
        if v66 or not parent.Parent then
            return
        end

        local v77

        for v78 in v16 do
            v61[v78] = 0
        end

        table.clear(v67)
        local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
        local magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude
        local humanoidRootPart2 = parent:FindFirstChild("HumanoidRootPart")
        local sHipBase = humanoidRootPart2 and humanoidRootPart2:GetAttribute("SHipBase")

        if type(sHipBase) ~= "number" then
            v77 = humanoid.HipHeight
        else
            v77 = sHipBase
        end

        local v83 = math.max(0.5, v77 / 2)
        local v84 = v44[humanoid:GetState()]

        if v84 and v84 ~= v38 then
            if v84 == "air" and 8 < assemblyLinearVelocity.Y then
                local gravity = workspace.Gravity
                local timePosition = math.clamp((math.sqrt(2 * gravity * math.max(humanoid.JumpHeight, 0.1)) - assemblyLinearVelocity.Y) / gravity, 0, 0.4)

                if v38 ~= "air" or not (0 < v39) or not (os.clock() - v39 < 0.4) then
                    v38 = "air"
                    v39 = os.clock() - timePosition
                    v16.jump.TimePosition = timePosition
                end
            elseif v84 ~= v38 then
                if v84 == "air" then
                    v39 = -1
                end

                if v84 ~= "ground" and v84 ~= "sit" and animationTrack then
                    animationTrack:Stop(0.2)
                    animationTrack = nil

                    if success then
                        Camera.ResumeCharacterRotation("Emote")
                    end
                end

                v38 = v84
            end
        end

        if v38 == "ground" then
            local clampedValue = math.clamp((magnitude - 0.6) / 2.5, 0, 1)

            if humanoid.MoveDirection.Magnitude < 0.05 and magnitude < 3 then
                clampedValue = 0
            end

            local clampedValue2 = math.clamp(((magnitude / v83) - 9) / 5, 0, 1)
            v36 += deltaTime

            if 12 < v36 then
                v36 = 0
                v37 = math.random() < 0.35
            end

            local v89 = v37 and "idle2" or "idle"
            v61[v89] = 1 - clampedValue
            v61.walk = clampedValue * (1 - clampedValue2)
            v61.run = clampedValue * clampedValue2
            local v90 = 1

            if 1 < magnitude then
                local lookVector = humanoidRootPart.CFrame.LookVector

                if (assemblyLinearVelocity.X * lookVector.X + (assemblyLinearVelocity.Z * lookVector.Z)) / magnitude < -0.35 then
                    v90 = -1
                end
            end

            v67.walk = v90 * math.clamp(magnitude / (v83 * 7.5), 0.4, 1.8)
            v67.run = v90 * math.clamp(magnitude / (v83 * 16.5), 0.55, 1.7)

            if animationTrack and 0.1 < clampedValue and animationTrack then
                animationTrack:Stop(0.2)
                animationTrack = nil

                if success then
                    Camera.ResumeCharacterRotation("Emote")
                end
            end
        elseif v38 == "air" then
            local v92 = os.clock() - v39

            if not (0 < v39) or not (v92 < 0.45) or not (-12 < assemblyLinearVelocity.Y) then
                v61.fall = 1
            else
                v61.jump = 1
            end
        elseif v38 == "climb" then
            local climb
            v61.climb = 1

            if not (0.1 < math.abs(v40)) then
                climb = 0
            else
                climb = v40 / (v83 * 5)
            end

            v67.climb = climb
        elseif v38 == "swim" then
            local swim = math.clamp((v41 - 1) / 3, 0, 1)
            v61.swim = swim
            v61.swimidle = 1 - swim
            v67.swim = math.clamp(v41 / 10, 0.6, 1.5)
        elseif v38 == "sit" then
            v61.sit = 1
        end

        local v95 = 1 - math.exp(-14 * deltaTime)

        for v96 in v16 do
            local v97 = v61[v96] or 0
            local v98 = v17[v96] + (v97 - v17[v96]) * v95

            if not (math.abs(v97 - v98) < 0.002) then
                v97 = v98
            end

            v17[v96] = v97 < 0.001 and 1e-04 or v97
        end

        v68 += deltaTime

        if 0.05 <= v68 or v38 ~= v69 then
            v68 = 0
            v69 = v38
            push()
        end
    end
)

humanoid.Died:Connect(
    function()
        --[[
          line: 360
          upvalues:
            v66 (ref,  index: 1)
            animationTrack (ref,  index: 2)
            success (copy, index: 3)
            Camera (copy, index: 4)
            v16 (copy, index: 5)
        ]]
        v66 = true

        if animationTrack then
            animationTrack:Stop(0.2)
            animationTrack = nil

            if success then
                Camera.ResumeCharacterRotation("Emote")
            end
        end

        for _, v100 in v16 do
            v100:Stop(0.3)
        end
    end
)