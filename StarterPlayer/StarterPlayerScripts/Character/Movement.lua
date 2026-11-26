local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local shared = replicatedStorage:WaitForChild("Shared")
local Camera = require(shared:WaitForChild("Camera"))
local Simulation = require(shared:WaitForChild("Simulation"))
local Effects = require(script.Parent:WaitForChild("Effects"))
local Footsteps = require(script.Parent:WaitForChild("Footsteps"))
local Perf = require(script.Parent:WaitForChild("Perf"))
local AnimationIds = require(script.Parent:WaitForChild("AnimationIds"))
local v12 = {}
local baseSpeed = Simulation.BASE_SPEED
local localPlayer = players.LocalPlayer
local v15 = nil
local v16 = {fov = 0}
local v17 = false
local v18 = {fov = 8, pivot = Vector3.new(0, -1.2000000476837158, 0)}

local function setSpeedKick(speedKick)
    --[[
      name: setSpeedKick
      line: 70
      upvalues:
        v16 (copy, index: 1)
        v17 (ref,  index: 2)
        Camera (copy, index: 3)
    ]]
    if not (0.05 < speedKick) then
        if v17 then
            v17 = false
            Camera.SetModifier("Speed", nil)
        end
    else
        v16.fov = speedKick

        if not v17 then
            v17 = true
            Camera.SetModifier("Speed", v16)
        end
    end
end

local function drawnRoot(a22)
    --[[
      name: drawnRoot
      line: 84
      upvalues:
        Camera (copy, index: 1)
    ]]
    local success, result = pcall(Camera.Drawn, a22.root)

    if success and typeof(result) == "Instance" and result:IsA("BasePart") then
        return result
    end

    return a22.root
end

function v12.IsSliding()
    --[[
      name: IsSliding
      line: 92
      upvalues:
        v15 (ref, index: 1)
    ]]
    return v15 ~= nil and v15.sliding
end

function v12.BaseSpeed()
    --[[
      name: BaseSpeed
      line: 96
      upvalues:
        baseSpeed (copy, index: 1)
    ]]
    return baseSpeed
end

local function playing(a26)
    --[[
      name: playing
      line: 103
    ]]
    return a26 ~= nil and a26.IsPlaying
end

local function renderSlideStart(a28)
    --[[
      name: renderSlideStart
      line: 107
      upvalues:
        Camera (copy, index: 1)
        v18 (copy, index: 2)
        Effects (copy, index: 3)
    ]]
    local v29
    a28.sliding = true
    a28.slideAirborne = false
    a28.character:SetAttribute("Sliding", true)
    Camera.SuspendCharacterRotation("Slide")
    Camera.SetModifier("Slide", v18)
    Camera.Shake(0.1, 0.2)

    if a28.legsTrack then
        local legsTrack = a28.legsTrack
        local isPlaying = legsTrack ~= nil and legsTrack.IsPlaying
        if not isPlaying then
            a28.legsTrack:Play(0.08, 1, 1)
        end
    end

    if a28.upperTrack then
        local upperTrack = a28.upperTrack
        local isPlaying = upperTrack ~= nil and upperTrack.IsPlaying
        if not isPlaying then
            a28.upperTrack:Play(0.12, 1, 1)
        end
    end

    if not a28.slideSound then
        local v34
        local playSound = Effects.PlaySound
        local success, result = pcall(Camera.Drawn, a28.root)

        if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
            v34 = a28.root
        else
            v34 = result
        end

        a28.slideSound = playSound("Slide", v34, {pitchVar = 0.08, looped = true, volume = 1.2})
    end

    local v38 = Effects.DustColor(a28.humanoid.FloorMaterial)
    local dust = Effects.Dust
    local success, result = pcall(Camera.Drawn, a28.root)

    if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
        v29 = a28.root
    else
        v29 = result
    end

    dust(v29.Position - Vector3.new(0, 2.5999999046325684, 0), 1.1, v38)

    if a28.trailAttachment then
        if not a28.slideTrail or not a28.slideTrail.Parent then
            a28.slideTrail = Effects.Trail(a28.trailAttachment, v38)
        end

        local slideTrail = a28.slideTrail
        slideTrail.Color = ColorSequence.new(v38)
        slideTrail.Enabled = true
    end
end

local function renderSlideEnd(a44)
    --[[
      name: renderSlideEnd
      line: 135
      upvalues:
        Camera (copy, index: 1)
    ]]
    a44.sliding = false

    if a44.character.Parent then
        a44.character:SetAttribute("Sliding", false)
    end

    if a44.legsTrack then
        a44.legsTrack:Stop(0.15)
    end

    if a44.upperTrack then
        a44.upperTrack:Stop(0.15)
    end

    if a44.slideTrail then
        a44.slideTrail.Enabled = false
    end

    if const slideSound = a44.slideSound then
        a44.slideSound = nil

        task.spawn(
            function()
                --[[
                  line: 152
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

    Camera.SetModifier("Slide", nil)
    Camera.ResumeCharacterRotation("Slide")
end

local function feetOf(a48)
    --[[
      name: feetOf
      line: 170
      upvalues:
        Camera (copy, index: 1)
    ]]
    local v49
    local v50 = a48.humanoid.HipHeight
    local sHipBase = a48.root:GetAttribute("SHipBase")

    if type(sHipBase) == "number" and sHipBase < v50 then
        v50 = sHipBase
    end

    local success, result = pcall(Camera.Drawn, a48.root)

    if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
        v49 = a48.root
    else
        v49 = result
    end

    return v49.Position - Vector3.new(0, (v50 + (a48.root.Size.Y / 2)) - 0.2, 0)
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = {workspace.Terrain}
raycastParams.IgnoreWater = false

local function waterSplashAt(a56)
    --[[
      name: waterSplashAt
      line: 189
      upvalues:
        raycastParams (copy, index: 1)
    ]]
    local sWade = a56.root:GetAttribute("SWade")

    if type(sWade) ~= "number" or sWade < 0.3 then
        return nil
    end

    local raycastResult = workspace:Raycast(a56.root.Position + Vector3.new(0, 4, 0), Vector3.new(0, -12, 0), raycastParams)

    if raycastResult and raycastResult.Material == Enum.Material.Water then
        return raycastResult.Position
    end

    return nil
end

local function onJumped(a60)
    --[[
      name: onJumped
      line: 202
      upvalues:
        Effects (copy, index: 1)
        Camera (copy, index: 2)
        waterSplashAt (copy, index: 3)
        feetOf (copy, index: 4)
    ]]
    local v61
    local timestamp = os.clock()

    if timestamp - a60.lastJumpFx < 0.4 then
        return
    end

    a60.airStart = timestamp
    a60.minVy = 0
    a60.lastJumpFx = timestamp
    local playSound = Effects.PlaySound
    local success, result = pcall(Camera.Drawn, a60.root)

    if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
        v61 = a60.root
    else
        v61 = result
    end

    playSound("Jump", v61, {pitchVar = 0.08, volume = 0.8})

    if const v66 = waterSplashAt(a60) then
        Effects.Dust(v66, 0.55, Effects.DustColor(Enum.Material.Water))
        return
    end

    Effects.Dust(feetOf(a60), 0.4, Effects.DustColor(a60.humanoid.FloorMaterial))
end

local function onLanded(a68)
    --[[
      name: onLanded
      line: 221
      upvalues:
        waterSplashAt (copy, index: 1)
        Effects (copy, index: 2)
        Camera (copy, index: 3)
        feetOf (copy, index: 4)
        Footsteps (copy, index: 5)
    ]]
    local v69 = -a68.minVy
    a68.minVy = 0
    local timestamp = os.clock()
    local v71 = timestamp - a68.airStart

    if v69 < 18 or v71 < 0.12 or timestamp - a68.lastLandFx < 0.4 then
        return
    end

    a68.lastLandFx = timestamp
    local floorMaterial = a68.humanoid.FloorMaterial
    local clampedValue = math.clamp((v69 - 70) / 60, 0, 1)

    if const v74 = waterSplashAt(a68) then
        Effects.Dust(v74, (clampedValue * 1.2) + 0.6, Effects.DustColor(Enum.Material.Water))
        return
    end

    local v75
    Camera.Dip((clampedValue * 1.2) + 0.12)

    if 0.6 < clampedValue then
        Camera.Shake((clampedValue * 0.3) + 0.15, 0.3)
    end

    Effects.Dust(feetOf(a68), (clampedValue * 1.8) + 0.45, Effects.DustColor(floorMaterial))
    local success, result = pcall(Camera.Drawn, a68.root)

    if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
        v75 = a68.root
    else
        v75 = result
    end

    if clampedValue <= 0 then
        local v78 = Footsteps.SurfaceFor(floorMaterial)
        local v79 = {volume = 0.8, pitchVar = 0.08}
        Effects.PlaySound(Footsteps.StepSoundName(v78), v75, v79)

        return
    end

    if clampedValue < 0.5 then
        Effects.PlaySound("Land", v75, {pitchVar = 0.06, volume = (clampedValue * 0.9) + 0.35})
        return
    end

    Effects.PlaySound("LandHeavy", v75, {pitchVar = 0.05, volume = (clampedValue * 0.5) + 0.5})
end

local function render()
    --[[
      name: render
      line: 257
      upvalues:
        v15 (ref,  index: 1)
        Camera (copy, index: 2)
        renderSlideStart (copy, index: 3)
        renderSlideEnd (copy, index: 4)
        Effects (copy, index: 5)
        feetOf (copy, index: 6)
        v17 (ref,  index: 7)
        baseSpeed (copy, index: 8)
        v16 (copy, index: 9)
    ]]
    local v81 = v15
    if not v81 then
        return
    end

    local humanoid = v81.humanoid
    local root = v81.root
    local v84 = humanoid.Parent ~= nil and 0 < humanoid.Health

    if const trailAttachment = v81.trailAttachment then
        local v86
        local success, result = pcall(Camera.Drawn, v81.root)

        if not success or typeof(result) ~= "Instance" or not result:IsA("BasePart") then
            v86 = v81.root
        else
            v86 = result
        end

        if trailAttachment.Parent ~= v86
            and not pcall(
                function()
                    --[[
                      line: 269
                      upvalues:
                        trailAttachment (copy, index: 1)
                        v86 (copy, index: 2)
                    ]]
                    trailAttachment.Parent = v86
                end
            )
        then
            local tribesSlideTrail = Instance.new("Attachment")
            tribesSlideTrail.Name = "TribesSlideTrail"
            tribesSlideTrail.Position = Vector3.new(0, -2.299999952316284, 1)
            tribesSlideTrail.Parent = v86
            v81.trailAttachment = tribesSlideTrail
            v81.slideTrail = nil
        end
    end

    local v90 = v84 and root:GetAttribute("SSlide") ~= nil

    if v90 == v81.sliding then
        if v90 then
            if v81.legsTrack then
                local legsTrack = v81.legsTrack
                local isPlaying = legsTrack ~= nil and legsTrack.IsPlaying
                if not isPlaying then
                    v81.legsTrack:Play(0.05, 1, 1)
                end
            end

            if v81.upperTrack then
                local upperTrack = v81.upperTrack
                local isPlaying = upperTrack ~= nil and upperTrack.IsPlaying
                if not isPlaying then
                    v81.upperTrack:Play(0.05, 1, 1)
                end
            end

            local slideAirborne = humanoid.FloorMaterial == Enum.Material.Air

            if slideAirborne ~= v81.slideAirborne then
                v81.slideAirborne = slideAirborne
                local timestamp = os.clock()

                if slideAirborne then
                    v81.slideAirAt = timestamp
                elseif 0.08 < timestamp - v81.slideAirAt then
                    Effects.Dust(feetOf(v81), 0.5, Effects.DustColor(humanoid.FloorMaterial))
                end

                if v81.slideTrail then
                    v81.slideTrail.Enabled = not slideAirborne
                end
            end
        end
    elseif v90 then
        renderSlideStart(v81)
    else
        renderSlideEnd(v81)
    end

    if not v84 then
        if v17 then
            v17 = false
            Camera.SetModifier("Speed", nil)
        end

        return
    end

    local assemblyLinearVelocity = root.AssemblyLinearVelocity

    if humanoid.FloorMaterial == Enum.Material.Air then
        v81.minVy = math.min(v81.minVy, assemblyLinearVelocity.Y)
    end

    if not v90 and not Camera.IsAiming() then
        local fov = math.clamp(((Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude - baseSpeed) - 1) * 0.45, 0, 7)

        if not (0.05 < fov) then
            if v17 then
                v17 = false
                Camera.SetModifier("Speed", nil)
            end
        else
            v16.fov = fov

            if not v17 then
                v17 = true
                Camera.SetModifier("Speed", v16)
            end
        end
    elseif v17 then
        v17 = false
        Camera.SetModifier("Speed", nil)
    end
end

local function loadTrack(animator: Instance?, animationId, priority: Enum.AnimationPriority, name: string)
    --[[
      name: loadTrack
      line: 330
    ]]
    if animationId == "" or animationId == "rbxassetid://0" then
        return nil
    end

    local animation = Instance.new("Animation")
    animation.Name = name
    animation.AnimationId = animationId
    local success, result = pcall(
        function()
            --[[
              line: 337
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

    return result
end

local function unbind()
    --[[
      name: unbind
      line: 348
      upvalues:
        v15 (ref,  index: 1)
        renderSlideEnd (copy, index: 2)
        v17 (ref,  index: 3)
        Camera (copy, index: 4)
    ]]
    local v108 = v15
    if not v108 then
        return
    end

    if v108.sliding then
        renderSlideEnd(v108)
    end

    if v17 then
        v17 = false
        Camera.SetModifier("Speed", nil)
    end

    for _, connection in v108.connections do
        connection:Disconnect()
    end

    if v108.trailAttachment then
        v108.trailAttachment:Destroy()
    end

    v15 = nil
end

local function bindCharacter(character: Model?)
    --[[
      name: bindCharacter
      line: 366
      upvalues:
        unbind (copy, index: 1)
        localPlayer (copy, index: 2)
        loadTrack (copy, index: 3)
        AnimationIds (copy, index: 4)
        v15 (ref,  index: 5)
        runService (copy, index: 6)
        onJumped (copy, index: 7)
        onLanded (copy, index: 8)
        renderSlideEnd (copy, index: 9)
        v17 (ref,  index: 10)
        Camera (copy, index: 11)
    ]]
    unbind()
    local humanoid = character:WaitForChild("Humanoid", 10)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)

    if not humanoid or not humanoidRootPart or localPlayer.Character ~= character then
        return
    end

    local tribesSlideTrail = Instance.new("Attachment")
    tribesSlideTrail.Name = "TribesSlideTrail"
    tribesSlideTrail.Position = Vector3.new(0, -2.299999952316284, 1)
    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 5)
    local legsTrack = nil
    local upperTrack = nil

    if animator and animator:IsA("Animator") then
        legsTrack = loadTrack(animator, AnimationIds.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs")
        upperTrack = loadTrack(animator, AnimationIds.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")
        legsTrack = legsTrack
            or loadTrack(animator, AnimationIds.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback")
    end

    local v119 = {sliding = false, slideSound = nil, slideTrail = nil, slideAirborne = false, slideAirAt = 0, minVy = 0, lastJumpFx = 0, lastLandFx = 0, character = character, humanoid = humanoid, root = humanoidRootPart, legsTrack = legsTrack, upperTrack = upperTrack, trailAttachment = tribesSlideTrail, airStart = os.clock(), connections = {}}
    v15 = v119
    character:SetAttribute("Sliding", false)

    table.insert(
        v119.connections,
        humanoid.StateChanged:Connect(
            function(a120, a121)
                --[[
                  line: 412
                  upvalues:
                    runService (copy, index: 1)
                    onJumped (copy, index: 2)
                    v119 (copy, index: 3)
                    onLanded (copy, index: 4)
                ]]
                if runService:IsResimulating() then
                    return
                end

                if a121 == Enum.HumanoidStateType.Jumping then
                    onJumped(v119)
                    return
                end

                if a121 ~= Enum.HumanoidStateType.Freefall then
                    if a121 == Enum.HumanoidStateType.Landed then
                        onLanded(v119)
                    end
                elseif a120 ~= Enum.HumanoidStateType.Jumping and 0.4 <= os.clock() - v119.lastJumpFx then
                    v119.airStart = os.clock()
                    v119.minVy = 0
                end
            end
        )
    )

    table.insert(
        v119.connections,
        humanoid.Died:Connect(
            function()
                --[[
                  line: 427
                  upvalues:
                    v119 (copy, index: 1)
                    renderSlideEnd (copy, index: 2)
                    v17 (ref,  index: 3)
                    Camera (copy, index: 4)
                ]]
                if v119.sliding then
                    renderSlideEnd(v119)
                end

                if v17 then
                    v17 = false
                    Camera.SetModifier("Speed", nil)
                end
            end
        )
    )
end

local v122 = {}
local v123 = {}

local function setHeld(key: string, a126: boolean)
    --[[
      name: setHeld
      line: 445
      upvalues:
        v123 (copy, index: 1)
        v122 (copy, index: 2)
        Simulation (copy, index: 3)
    ]]
    v123[key] = (v123[key] or 0) + 1

    if a126 then
        v122[key] = os.clock()
        Simulation.SetInput(key, true)

        return
    end

    local v127 = 0.1 - (os.clock() - (v122[key] or 0))

    if v127 <= 0 then
        Simulation.SetInput(key, false)
        return
    end

    local v128 = v123[key]

    task.delay(
        v127,
        function()
            --[[
              line: 458
              upvalues:
                v123 (copy, index: 1)
                key (copy, index: 2)
                v128 (copy, index: 3)
                Simulation (copy, index: 4)
            ]]
            if v123[key] == v128 then
                Simulation.SetInput(key, false)
            end
        end
    )
end

function v12.SetSlideHeld(slideHeld)
    --[[
      name: SetSlideHeld
      line: 466
      upvalues:
        setHeld (copy, index: 1)
    ]]
    setHeld("Slide", slideHeld == true)
end

function v12.RequestSlide()
    --[[
      name: RequestSlide
      line: 471
      upvalues:
        Simulation (copy, index: 1)
    ]]
    Simulation.Pulse("Slide", 0.1)
end

function v12.SetJumpHeld(jumpHeld)
    --[[
      name: SetJumpHeld
      line: 476
      upvalues:
        setHeld (copy, index: 1)
    ]]
    setHeld("Jump", jumpHeld == true)
end

local hasRun = false

function v12.Start()
    --[[
      name: Start
      line: 481
      upvalues:
        hasRun (ref,  index: 1)
        userInputService (copy, index: 2)
        Simulation (copy, index: 3)
        localPlayer (copy, index: 4)
        bindCharacter (copy, index: 5)
        v15 (ref,  index: 6)
        unbind (copy, index: 7)
        runService (copy, index: 8)
        v12 (copy, index: 9)
        Perf (copy, index: 10)
        render (copy, index: 11)
    ]]
    if hasRun then
        return
    end

    hasRun = true

    userInputService.WindowFocusReleased:Connect(
        function()
            --[[
              line: 486
              upvalues:
                Simulation (copy, index: 1)
            ]]
            Simulation.SetInput("Slide", false)
            Simulation.SetInput("Jump", false)
        end
    )

    if localPlayer.Character then
        task.spawn(bindCharacter, localPlayer.Character)
    end

    localPlayer.CharacterAdded:Connect(bindCharacter)

    localPlayer.CharacterRemoving:Connect(
        function(character: Model)
            --[[
              line: 494
              upvalues:
                v15 (ref,  index: 1)
                unbind (copy, index: 2)
            ]]
            if v15 and v15.character == character then
                unbind()
            end
        end
    )

    if runService:IsStudio() then
        local characterDebug = Instance.new("BindableFunction")
        characterDebug.Name = "CharacterDebug"

        characterDebug.OnInvoke = function(a134, a135)
            --[[
              line: 505
              upvalues:
                Simulation (copy, index: 1)
                v12 (copy, index: 2)
                v15 (ref,  index: 3)
            ]]
            if a134 == "jump" then
                Simulation.Pulse("Jump", 0.05)
                return true
            end

            if a134 == "slide" then
                v12.RequestSlide()
                return true
            end

            if a134 == "simperf" then
                return Simulation.DebugStats()
            end
            if a134 ~= "state" then
                return nil
            end

            local v136 = v15
            if not v136 then
                return nil
            end

            local v137 = {walkSpeed = v136.humanoid.WalkSpeed, jumpHeight = v136.humanoid.JumpHeight, hipHeight = v136.humanoid.HipHeight, rendered = v136.sliding}

            for text, attribute in v136.root:GetAttributes() do
                if string.sub(text, 1, 1) == "S" then
                    v137[text] = attribute
                end
            end

            return v137
        end

        characterDebug.Parent = localPlayer
    end

    runService.RenderStepped:Connect(
        function()
            --[[
              line: 531
              upvalues:
                Perf (copy, index: 1)
                render (copy, index: 2)
            ]]
            local v140 = Perf.Begin()
            render()
            Perf.End("Movement", v140)
        end
    )
end

return v12