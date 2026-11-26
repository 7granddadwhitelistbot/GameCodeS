local _ = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local parent = script.Parent.Parent
local AnimationIds = require(parent:WaitForChild("Character"):WaitForChild("AnimationIds"))
local v6 = {}
local Footsteps = nil
local Sfx = nil

task.spawn(
    function()
        --[[
          line: 44
          upvalues:
            parent (copy, index: 1)
            Footsteps (ref,  index: 2)
            replicatedStorage (copy, index: 3)
            Sfx (ref,  index: 4)
        ]]
        local success, Footsteps2 = pcall(
            function()
                --[[
                  line: 45
                  upvalues:
                    parent (copy, index: 1)
                ]]
                return require((parent:WaitForChild("Character"):WaitForChild("Footsteps", 10)))
            end
        )

        if success and type(Footsteps2) == "table" then
            Footsteps = Footsteps2
        end

        local success2, Sfx2 = pcall(
            function()
                --[[
                  line: 51
                  upvalues:
                    replicatedStorage (copy, index: 1)
                ]]
                return require((replicatedStorage:WaitForChild("Shared"):WaitForChild("Sfx", 10)))
            end
        )

        if success2 and type(Sfx2) == "table" then
            Sfx = Sfx2
        end
    end
)

local function load(a14, animationId, priority: Enum.AnimationPriority, name: string)
    --[[
      name: load
      line: 59
    ]]
    if not animationId or animationId == "" then
        return nil
    end

    local animation = Instance.new("Animation")
    animation.Name = name
    animation.AnimationId = animationId
    local success, result = pcall(
        function()
            --[[
              line: 66
              upvalues:
                a14 (copy, index: 1)
                animation (copy, index: 2)
            ]]
            return a14:LoadAnimation(animation)
        end
    )

    if not success or not result then
        return nil
    end

    result.Priority = priority
    result.Looped = true

    return result
end

function v6.new(hum, root, a23)
    --[[
      name: new
      line: 77
      upvalues:
        AnimationIds (copy, index: 1)
        load (copy, index: 2)
    ]]
    local v24 = if hum.RigType == Enum.HumanoidRigType.R6 then AnimationIds.R6 else AnimationIds.R15
    local v25 = {legs = nil, upper = nil, sliding = false, groundedAt = 0, jumpAt = -1, active = false, stepDist = 0, lastPos = nil, leftFoot = false, airTime = 0, lastVy = 0, hum = hum, root = root, tracks = {}, weights = {}, targets = {}}

    for _, v27 in {"idle", "walk", "run", "jump", "fall"} do
        if const v28 = load(a23, v24[v27], Enum.AnimationPriority.Core, v27) then
            v25.tracks[v27] = v28
            v25.weights[v27] = 0
        end
    end

    v25.legs = load(a23, AnimationIds.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs")
        or load(a23, AnimationIds.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback")
    v25.upper = load(a23, AnimationIds.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")

    return v25
end

function v6.Stop(a29)
    --[[
      name: Stop
      line: 110
    ]]
    for weightKey, track in a29.tracks do
        track:Stop(0.2)
        a29.weights[weightKey] = 0
    end

    if a29.legs then
        a29.legs:Stop(0.15)
    end

    if a29.upper then
        a29.upper:Stop(0.15)
    end

    a29.sliding = false
    a29.active = false
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.IgnoreWater = true

function v6.SetGround(ground)
    --[[
      name: SetGround
      line: 130
      upvalues:
        raycastParams (copy, index: 1)
    ]]
    raycastParams.FilterDescendantsInstances = ground
end

local function footstep(a35, a36: number)
    --[[
      name: footstep
      line: 134
      upvalues:
        Footsteps (ref,  index: 1)
        Sfx (ref,  index: 2)
        workspace (copy, index: 3)
        raycastParams (copy, index: 4)
    ]]
    if not Footsteps or not Sfx then
        return
    end

    local root = a35.root
    local hum = a35.hum
    local camera = workspace.CurrentCamera

    if camera and 90 < (camera.CFrame.Position - root.Position).Magnitude then
        return
    end

    local v40 = hum.HipHeight + (root.Size.Y / 2) + 1.5
    local raycastResult = workspace:Raycast(root.Position, Vector3.new(0, -v40, 0), raycastParams)
    if not raycastResult then
        return
    end

    local success, result = pcall(
        function()
            --[[
              line: 148
              upvalues:
                Footsteps (ref,  index: 1)
                raycastResult (copy, index: 2)
            ]]
            return Footsteps.StepSoundName(Footsteps.SurfaceFor(raycastResult.Material))
        end
    )

    if not success or type(result) ~= "string" then
        return
    end

    local volume
    a35.leftFoot = not a35.leftFoot
    local rightVector = root.CFrame.RightVector
    local v46 = a35.leftFoot and -0.5 or 0.5
    local v47 = rightVector * v46
    local play = Sfx.Play
    local v49 = "Character/" .. result
    local v50 = raycastResult.Position + v47
    local v51 = {}

    if not (23 < a36) then
        volume = 0.8
    else
        volume = 1
    end

    v51.volume = volume
    pcall(play, v49, v50, v51)
end

function v6.Step(a52, a53, a54, a55, a56, sliding, a58)
    --[[
      name: Step
      line: 160
      upvalues:
        v6 (copy, index: 1)
        Sfx (ref,  index: 2)
        workspace (copy, index: 3)
        footstep (copy, index: 4)
    ]]
    if not a58 then
        if a52.active then
            v6.Stop(a52)
        end

        return
    end

    a52.active = true
    local hum = a52.hum
    local root = a52.root
    local targets = a52.targets

    for targetKey in a52.tracks do
        targets[targetKey] = 0
    end

    local magnitude = Vector3.new(a55.X, 0, a55.Z).Magnitude
    local v64 = math.max(0.5, hum.HipHeight / 2)

    if a56 then
        a52.groundedAt = a54
    elseif 8 < a55.Y and a54 - a52.groundedAt < 0.25 then
        a52.jumpAt = a54
    end

    if a56 or a54 - a52.groundedAt < 0.1 then
        local v65
        local clampedValue = math.clamp((magnitude - 0.6) / 2.5, 0, 1)
        local clampedValue2 = math.clamp(((magnitude / v64) - 9) / 5, 0, 1)
        targets.idle = 1 - clampedValue
        targets.walk = clampedValue * (1 - clampedValue2)
        targets.run = clampedValue * clampedValue2
        local v68 = 1

        if not (1 < magnitude) then
            v65 = v68
        else
            local lookVector = root.CFrame.LookVector
            v65 = (a55.X * lookVector.X + (a55.Z * lookVector.Z)) / magnitude < -0.35 and -1 or v68
        end

        local walk = a52.tracks.walk
        local run = a52.tracks.run

        if walk then
            walk:AdjustSpeed(v65 * math.clamp(magnitude / (v64 * 7.5), 0.4, 1.8))
        end

        if run then
            run:AdjustSpeed(v65 * math.clamp(magnitude / (v64 * 16.5), 0.55, 1.7))
        end
    elseif not (0 < a52.jumpAt) or not (a54 - a52.jumpAt < 0.45) or not (-12 < a55.Y) then
        targets.fall = 1
    else
        targets.jump = 1
    end

    local v72 = 1 - math.exp(a53 * -14)

    for v73, track in a52.tracks do
        local v75 = a52.weights[v73] + ((targets[v73] or 0) - a52.weights[v73]) * v72

        if v75 < 0.001 then
            v75 = 1e-04
        end

        a52.weights[v73] = v75

        if track.IsPlaying then
            track:AdjustWeight(v75, 0)
        else
            track:Play(0, v75, track.Speed)
        end
    end

    if sliding ~= a52.sliding then
        a52.sliding = sliding

        if sliding then
            if a52.legs then
                a52.legs:Play(0.08, 1, 1)
            end

            if a52.upper then
                a52.upper:Play(0.12, 1, 1)
            end
        else
            if a52.legs then
                a52.legs:Stop(0.15)
            end

            if a52.upper then
                a52.upper:Stop(0.15)
            end
        end
    end

    if a56 then
        if not (0.35 < a52.airTime) or not (a52.lastVy < -30) then
            a52.airTime = 0
        else
            local v76 = -a52.lastVy

            if not (72 < v76) or not Sfx then
                footstep(a52, 16)
            else
                local camera = workspace.CurrentCamera
                local v78 = root.Position - Vector3.new(0, hum.HipHeight + (root.Size.Y / 2), 0)

                if not camera or (camera.CFrame.Position - v78).Magnitude <= 90 then
                    local v79
                    local clampedValue = math.clamp((v76 - 64) / 60, 0, 1)
                    local play = Sfx.Play

                    if not (0.5 < clampedValue) then
                        v79 = "Character/Land"
                    else
                        v79 = "Character/LandHeavy"
                    end

                    pcall(play, v79, v78, {volume = (clampedValue * 0.6) + 0.35})
                end
            end

            a52.airTime = 0
        end
    else
        a52.airTime += a53
        a52.lastVy = a55.Y
    end

    local position = root.Position

    if not a56 or not (2 < magnitude) or sliding then
        a52.stepDist = math.min(a52.stepDist, 2.34)
    else
        if const lastPos = a52.lastPos then
            local magnitude2 = Vector3.new(position.X - lastPos.X, 0, position.Z - lastPos.Z).Magnitude

            if magnitude2 < 10 then
                a52.stepDist += magnitude2
            end
        end

        local stepDist = a52.stepDist
        local v86 = not (15 < magnitude) and 3.9 or 5.2

        if v86 <= stepDist then
            a52.stepDist = 0
            footstep(a52, magnitude)
        end
    end

    a52.lastPos = position
end

return v6