local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local Effects = require(script.Parent:WaitForChild("Effects"))
local Characters = require(script.Parent:WaitForChild("Characters"))
local Perf = require(script.Parent:WaitForChild("Perf"))
local Quality = require(script.Parent:WaitForChild("Quality"))
local v8 = {}
local v9 = {}
v9[Enum.Material.Grass] = "Grass"
v9[Enum.Material.LeafyGrass] = "Grass"
v9[Enum.Material.Ground] = "Dirt"
v9[Enum.Material.Mud] = "Dirt"
v9[Enum.Material.Sand] = "Sand"
v9[Enum.Material.Salt] = "Grass"
v9[Enum.Material.Snow] = "Snow"
v9[Enum.Material.Glacier] = "Snow"
v9[Enum.Material.Ice] = "Snow"
v9[Enum.Material.Wood] = "Wood"
v9[Enum.Material.WoodPlanks] = "Wood"
v9[Enum.Material.Metal] = "Metal"
v9[Enum.Material.DiamondPlate] = "Metal"
v9[Enum.Material.CorrodedMetal] = "Metal"
v9[Enum.Material.Foil] = "Metal"
v9[Enum.Material.Water] = "Water"
v9[Enum.Material.Fabric] = "Soft"
v9[Enum.Material.Carpet] = "Soft"
v9[Enum.Material.Leather] = "Soft"
v9[Enum.Material.Cardboard] = "Wood"
v9[Enum.Material.Slate] = "Stone"
v9[Enum.Material.Cobblestone] = "Stone"
v9[Enum.Material.Rock] = "Stone"
v9[Enum.Material.Basalt] = "Dirt"
v9[Enum.Material.Limestone] = "Stone"
v9[Enum.Material.Sandstone] = "Stone"
v9[Enum.Material.Granite] = "Stone"
v9[Enum.Material.Brick] = "Stone"
v9[Enum.Material.Pavement] = "Stone"
v9[Enum.Material.Concrete] = "Stone"
v9[Enum.Material.Marble] = "Stone"
v9[Enum.Material.CrackedLava] = "Stone"
local v10 = {}
local localPlayer = players.LocalPlayer
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = false

v8.SurfaceFor = function(key)
    --[[
      name: surfaceFor
      line: 81
      upvalues:
        v9 (copy, index: 1)
    ]]
    return v9[key] or "Stone"
end

local function stepSoundName(a15)
    --[[
      name: stepSoundName
      line: 86
    ]]
    local instance = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    instance = instance
    instance = instance and instance:FindFirstChild("Sounds")

    if const character = instance and instance:FindFirstChild("Character") then
        if character:FindFirstChild("Footstep_" .. a15) then
            return "Footstep_" .. a15
        end
        if character:FindFirstChild("Footstep_Stone") then
            return "Footstep_Stone"
        end
    end

    return "Footstep"
end

v8.StepSoundName = stepSoundName
local v18 = {Running = true, Landing = true, Jumping = true, FreeFalling = true, GettingUp = true}

local function muteDefaultSounds(a20)
    --[[
      name: muteDefaultSounds
      line: 105
      upvalues:
        v18 (copy, index: 1)
    ]]
    local humanoidRootPart = a20:WaitForChild("HumanoidRootPart", 10)
    if not humanoidRootPart then
        return
    end

    local function mute(a23)
        --[[
          name: mute
          line: 110
          upvalues:
            v18 (copy, index: 1)
        ]]
        if a23:IsA("Sound") and v18[a23.Name] then
            a23.Volume = 0

            a23:GetPropertyChangedSignal("Volume"):Connect(
                function()
                    --[[
                      line: 113
                      upvalues:
                        a23 (copy, index: 1)
                    ]]
                    if a23.Volume ~= 0 then
                        a23.Volume = 0
                    end
                end
            )
        end
    end

    for _, child in humanoidRootPart:GetChildren() do
        mute(child)
    end

    humanoidRootPart.ChildAdded:Connect(mute)
end

local filterDescendantsInstances = {}
local v27 = 0

local function step(a29, a30, humanoid, a32, a33: number?)
    --[[
      name: step
      line: 129
      upvalues:
        localPlayer (copy, index: 1)
        v27 (ref,  index: 2)
        Quality (copy, index: 3)
        filterDescendantsInstances (copy, index: 4)
        raycastParams (copy, index: 5)
        workspace (copy, index: 6)
        v9 (copy, index: 7)
        Effects (copy, index: 8)
        stepSoundName (copy, index: 9)
    ]]
    local v34
    local speed
    local v36 = a29 == localPlayer.Character
    if not v36 then
        local v37 = v27

        if Quality.budget.maxSteps <= v37 then
            return
        end
    end

    local sWade = a30:GetAttribute("SWade")

    if type(sWade) == "number" and 0.3 <= sWade then
        return
    end

    local v39 = a30.Position - Vector3.new(0, humanoid.HipHeight + (a30.Size.Y / 2), 0)

    if not v36 or humanoid.FloorMaterial == Enum.Material.Air then
        filterDescendantsInstances[1] = a29
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        local raycastResult = workspace:Raycast(a30.Position, Vector3.new(0, -((humanoid.HipHeight + (a30.Size.Y / 2)) + 1.5), 0), raycastParams)
        if not raycastResult then
            return
        end

        v34 = raycastResult.Material
        v39 = raycastResult.Position
    else
        v34 = humanoid.FloorMaterial
    end

    local v41 = v9[v34] or "Stone"

    if v41 == "Water" then
        return
    end

    local v42 = 23 < a33
    local v43 = v42 and 1 or 0.8
    local v44 = v36 and 0.55 or 1
    local volume = v43 * v44
    a32.leftFoot = not a32.leftFoot
    local rightVector = a30.CFrame.RightVector
    local v47 = a32.leftFoot and -0.5 or 0.5
    local v48 = rightVector * v47
    local playSoundAt = Effects.PlaySoundAt
    local v50 = stepSoundName(v41)
    local v51 = v39 + v48
    local v52 = {pitchVar = 0.09, maxDistance = 90, volume = volume}

    if v42 then
        speed = 1.05
    else
        speed = 1
    end

    v52.speed = speed

    if const v53 = playSoundAt(v50, v51, v52) then
        v27 += 1
        local v54 = not (0 < v53.TimeLength) and 0.5 or v53.TimeLength / math.max(v53.PlaybackSpeed, 0.5)
        task.delay(
            math.clamp(v54, 0.15, 1.5),
            function()
                --[[
                  line: 174
                  upvalues:
                    v27 (ref, index: 1)
                ]]
                v27 -= 1
            end
        )
    end

    if v42
        and (v41 == "Dirt" or v41 == "Sand" or v41 == "Snow")
        and math.random() < 0.5
        and (v36 or Quality.budget.remoteDust)
    then
        Effects.Dust(v39 + v48, 0.35, Effects.DustColor(v34))
    end
end

local v55 = {}
local v56 = 90
local v57 = 0

local function update(deltaTime: number)
    --[[
      name: update
      line: 187
      upvalues:
        Quality (copy, index: 1)
        v57 (ref,  index: 2)
        workspace (copy, index: 3)
        localPlayer (copy, index: 4)
        v56 (ref,  index: 5)
        v55 (copy, index: 6)
        Characters (copy, index: 7)
        v10 (copy, index: 8)
        muteDefaultSounds (copy, index: 9)
        Effects (copy, index: 10)
        step (copy, index: 11)
    ]]
    local budget = Quality.budget
    v57 += deltaTime
    local v61 = v57
    local v62 = 1 / budget.remoteHz <= v61
    local v63 = v61

    if v62 then
        v57 = 0
    end

    local v65 = if const camera = workspace.CurrentCamera then camera.CFrame.Position else Vector3.new(0, 0, 0)
    local character = localPlayer.Character
    local v67 = v56 * v56
    local count = 0
    table.clear(v55)
    local v69, humanoid

    for _, v72 in Characters.List() do
        v55[v72] = true
        local v73 = v72 == character

        if v73 or v62 then
            local v74 = if v73 then deltaTime else v63
            local position, v76, assemblyLinearVelocity, magnitude, v79, clampedValue, playSoundAt
            local magnitude2
            local v83
            local v84
            local humanoid2
            local v86
            local v87, v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99 = false, false, false, false, false, false, false, false, false, false, false, false, false
            v69 = v10[v72]

            if v69 then
                v86 = v69
            else
                v86 = {humanoid = nil, root = nil, distance = 0, lastPos = nil, lastVy = 0, airTime = 0, leftFoot = false}
                v10[v72] = v86
                task.spawn(muteDefaultSounds, v72)
            end

            humanoid = v86.humanoid
            local root = v86.root

            if humanoid then
                if humanoid.Parent == v72 then
                    humanoid2 = humanoid
                else
                    v87 = true
                end
            else
                v87 = true
            end

            if v87 then
                humanoid2 = v72:FindFirstChildOfClass("Humanoid")
                v86.humanoid = humanoid2
            end

            if root then
                if root.Parent == v72 then
                    v84 = root
                else
                    v88 = true
                end
            else
                v88 = true
            end

            if v88 then
                v84 = v72:FindFirstChild("HumanoidRootPart")

                if v84 then
                    if v84:IsA("BasePart") then
                        v90 = true
                    else
                        v89 = true
                    end
                else
                    v89 = true
                end
            end

            if v89 then
                v84 = nil
                v90 = true
            end

            if v90 then
                v86.root = v84
            end

            if humanoid2 and v84 and not (humanoid2.Health <= 0) then
                position = v84.Position
                v76 = v72 == character
                local v101 = position - v65

                if v76 then
                    v91 = true
                elseif not (v67 < (v101.X * v101.X) + (v101.Y * v101.Y) + (v101.Z * v101.Z)) then
                    count += 1
                    v91 = true
                else
                    v86.lastPos = position
                end
            end

            if v91 then
                assemblyLinearVelocity = v84.AssemblyLinearVelocity
                magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude

                if v76 then
                    v83 = humanoid2.FloorMaterial ~= Enum.Material.Air
                else
                    local state = humanoid2:GetState()
                    v83 = math.abs(assemblyLinearVelocity.Y) < 6
                        and state ~= Enum.HumanoidStateType.Freefall
                        and state ~= Enum.HumanoidStateType.Jumping
                        and state ~= Enum.HumanoidStateType.Swimming
                end

                if v76 then
                    v96 = true
                elseif v83 then
                    if not (0.35 < v86.airTime) then
                        v94 = true
                    elseif not (v86.lastVy < -30) then
                        v94 = true
                    else
                        v79 = position - Vector3.new(0, humanoid2.HipHeight + (v84.Size.Y / 2), 0)
                        local v103 = -v86.lastVy

                        if not (72 < v103) then
                            step(v72, v84, humanoid2, v86, 16)
                            v93 = true
                        else
                            clampedValue = math.clamp((v103 - 64) / 60, 0, 1)

                            if budget.remoteDust then
                                Effects.Dust(v79, (clampedValue * 1.4) + 0.6, Effects.DustColor(nil))
                            end

                            v92 = true
                        end
                    end
                else
                    v86.airTime += v74
                    v95 = true
                end
            end

            if v92 then
                local v104
                playSoundAt = Effects.PlaySoundAt

                if not (0.5 < clampedValue) then
                    v104 = "Land"
                else
                    v104 = "LandHeavy"
                end

                playSoundAt(v104, v79, {pitchVar = 0.06, maxDistance = 90, volume = (clampedValue * 0.6) + 0.35})
                v93 = true
            end

            if v93 then
                v86.airTime = 0
                v95 = true
            end

            if v94 then
                v86.airTime = 0
                v95 = true
            end

            if v95 then
                v86.lastVy = assemblyLinearVelocity.Y
                v96 = true
            end

            if v96 then
                local v105 = v72:GetAttribute("Sliding") == true or not v76 and 30 < magnitude

                if v83 then
                    if not (2 < magnitude) then
                        v98 = true
                    elseif v105 then
                        v98 = true
                    else
                        if v86.lastPos then
                            magnitude2 = (Vector3.new(position.X, 0, position.Z) - Vector3.new(v86.lastPos.X, 0, v86.lastPos.Z)).Magnitude
                        else
                            magnitude2 = 0
                        end

                        v97 = true
                    end
                else
                    v98 = true
                end
            end

            if v97 then
                local v106

                if magnitude2 < 10 then
                    v86.distance += magnitude2
                end

                if not (15 < magnitude) then
                    v106 = 3.9
                else
                    v106 = 5.2
                end

                if v106 <= v86.distance then
                    v86.distance = 0
                    step(v72, v84, humanoid2, v86, magnitude)
                end

                v99 = true
            end

            if v98 then
                v86.distance = math.min(v86.distance, 2.34)
                v99 = true
            end

            if v99 then
                v86.lastPos = position
            end
        end
    end

    if v62 then
        for v107 in v10 do
            if not v55[v107] then
                v10[v107] = nil
            end
        end
    end

    if v62 then
        local stepCap = budget.stepCap

        if stepCap < count then
            v56 = math.max(30, v56 * 0.92)
        elseif count < stepCap * 0.7 then
            v56 = math.min(budget.stepRadius, v56 + (v63 * 20))
        end

        v56 = math.min(v56, budget.stepRadius)
    end
end

function v8.Start()
    --[[
      name: Start
      line: 315
      upvalues:
        runService (copy, index: 1)
        Perf (copy, index: 2)
        update (copy, index: 3)
    ]]
    runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 316
              upvalues:
                Perf (copy, index: 1)
                update (copy, index: 2)
            ]]
            local v110 = Perf.Begin()
            update(deltaTime)
            Perf.End("Footsteps", v110)
        end
    )
end

return v8