local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Effects_upv_1 = require(script.Parent:WaitForChild("Effects"))
local Characters_upv_1 = require(script.Parent:WaitForChild("Characters"))
local Perf_upv_1 = require(script.Parent:WaitForChild("Perf"))
local Quality_upv_1 = require(script.Parent:WaitForChild("Quality"))
local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2[Enum.Material.Grass] = "Grass"
tbl_upv_2[Enum.Material.LeafyGrass] = "Grass"
tbl_upv_2[Enum.Material.Ground] = "Dirt"
tbl_upv_2[Enum.Material.Mud] = "Dirt"
tbl_upv_2[Enum.Material.Sand] = "Sand"
tbl_upv_2[Enum.Material.Salt] = "Grass"
tbl_upv_2[Enum.Material.Snow] = "Snow"
tbl_upv_2[Enum.Material.Glacier] = "Snow"
tbl_upv_2[Enum.Material.Ice] = "Snow"
tbl_upv_2[Enum.Material.Wood] = "Wood"
tbl_upv_2[Enum.Material.WoodPlanks] = "Wood"
tbl_upv_2[Enum.Material.Metal] = "Metal"
tbl_upv_2[Enum.Material.DiamondPlate] = "Metal"
tbl_upv_2[Enum.Material.CorrodedMetal] = "Metal"
tbl_upv_2[Enum.Material.Foil] = "Metal"
tbl_upv_2[Enum.Material.Water] = "Water"
tbl_upv_2[Enum.Material.Fabric] = "Soft"
tbl_upv_2[Enum.Material.Carpet] = "Soft"
tbl_upv_2[Enum.Material.Leather] = "Soft"
tbl_upv_2[Enum.Material.Cardboard] = "Wood"
tbl_upv_2[Enum.Material.Slate] = "Stone"
tbl_upv_2[Enum.Material.Cobblestone] = "Stone"
tbl_upv_2[Enum.Material.Rock] = "Stone"
tbl_upv_2[Enum.Material.Basalt] = "Dirt"
tbl_upv_2[Enum.Material.Limestone] = "Stone"
tbl_upv_2[Enum.Material.Sandstone] = "Stone"
tbl_upv_2[Enum.Material.Granite] = "Stone"
tbl_upv_2[Enum.Material.Brick] = "Stone"
tbl_upv_2[Enum.Material.Pavement] = "Stone"
tbl_upv_2[Enum.Material.Concrete] = "Stone"
tbl_upv_2[Enum.Material.Marble] = "Stone"
tbl_upv_2[Enum.Material.CrackedLava] = "Stone"
local tbl_upv_3 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Exclude
u1.IgnoreWater = false
tbl_1.SurfaceFor = function(a1)
    --[[
      name: surfaceFor
      line: 81
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2[a1] or "Stone"
end
local function stepSoundName(a1)
    --[[
      name: stepSoundName
      line: 86
    ]]
    local Assets_1 = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    local v1 = Assets_1 and (Assets_1:FindFirstChild("Sounds"))
    local v2 = v1 and (v1:FindFirstChild("Character"))
    if v2 then
        if v2:FindFirstChild("Footstep_" .. a1) then
            return "Footstep_" .. a1
        elseif v2:FindFirstChild("Footstep_Stone") then
            return "Footstep_Stone"
        end
    end
    return "Footstep"
end
tbl_1.StepSoundName = stepSoundName
local tbl_upv_4 = {Running = true, Jumping = true, Landing = true, FreeFalling = true, GettingUp = true}
local tbl_upv_5 = {}
local u2 = 0
local function step(a1, a2, a3, a4, a5)
    --[[
      name: step
      line: 129
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        Quality_upv_1 (copy, index: 3)
        tbl_upv_5 (copy, index: 4)
        u1 (copy, index: 5)
        Workspace_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
        Effects_upv_1 (copy, index: 8)
        stepSoundName (copy, index: 9)
    ]]
    local v3 = a1 == LocalPlayer_upv_1.Character
    if not (v3) and Quality_upv_1.budget.maxSteps <= u2 then
        return
    end
    local v4 = a2:GetAttribute("SWade")
    if type(v4) == "number" and v4 >= 0.3 then
        return
    end
    v4 = a2.Position - Vector3.new(0, a3.HipHeight + (a2.Size.Y / 2), 0)
    local v5 = nil
    if v3 and a3.FloorMaterial ~= Enum.Material.Air then
        v5 = a3.FloorMaterial
        local v6 = tbl_upv_2[v5] or "Stone"
        if v6 == "Water" then
            return
        end
        local v7 = a5 > 23
        local v8
        if v7 then
            v8 = 1
        else
            v8 = 0.8
        end
        local v9 = (v3 and 0.55) or 1
        a4.leftFoot = not a4.leftFoot
        local v10 = a2.CFrame.RightVector * (((a4.leftFoot) and -0.5) or 0.5)
        local PlaySoundAt_1 = Effects_upv_1.PlaySoundAt
        local v11 = stepSoundName(v6)
        local tbl_6 = {speed = 0, maxDistance = 90, pitchVar = 0.09}
        tbl_6.volume = v8 * v9
        tbl_6.speed = (v7 and 1.05) or 1
        v9 = PlaySoundAt_1(v11, v4 + v10, tbl_6)
        if v9 then
            u2 = u2 + 1
            local v12 = ((v9.TimeLength > 0) and (v9.TimeLength / math.max(v9.PlaybackSpeed, 0.5))) or 0.5
            task.delay(
                math.clamp(v12, 0.15, 1.5),
                function()
                    --[[
                      line: 174
                      upvalues:
                        u2 (ref, index: 1)
                    ]]
                    u2 = u2 - 1
                end
            )
        end
        if v7 then
            if v6 ~= "Dirt" and v6 ~= "Sand" and v6 ~= "Snow" or not (math.random() < 0.5) or not (v3) and not (Quality_upv_1.budget.remoteDust) then
                return
            end
            Effects_upv_1.Dust(v4 + v10, 0.35, Effects_upv_1.DustColor(v5))
        end
        return
    end
    tbl_upv_5[1] = a1
    u1.FilterDescendantsInstances = tbl_upv_5
    local v13 = Workspace_upv_1:Raycast(a2.Position, Vector3.new(0, -((a3.HipHeight + (a2.Size.Y / 2)) + 1.5), 0), u1)
    if not v13 then
        return
    end
    v5, v4 = v13.Material, v13.Position
    local v6 = tbl_upv_2[v5] or "Stone"
    if v6 == "Water" then
        return
    end
    local v7 = a5 > 23
    local v8
    if v7 then
        v8 = 1
    else
        v8 = 0.8
    end
    local v9 = (v3 and 0.55) or 1
    a4.leftFoot = not a4.leftFoot
    local v10 = a2.CFrame.RightVector * (((a4.leftFoot) and -0.5) or 0.5)
    local PlaySoundAt_1 = Effects_upv_1.PlaySoundAt
    local v11 = stepSoundName(v6)
    local tbl_6 = {speed = 0, maxDistance = 90, pitchVar = 0.09}
    tbl_6.volume = v8 * v9
    tbl_6.speed = (v7 and 1.05) or 1
    v9 = PlaySoundAt_1(v11, v4 + v10, tbl_6)
    if v9 then
        u2 = u2 + 1
        local v12 = ((v9.TimeLength > 0) and (v9.TimeLength / math.max(v9.PlaybackSpeed, 0.5))) or 0.5
        task.delay(
            math.clamp(v12, 0.15, 1.5),
            function()
                --[[
                  line: 174
                  upvalues:
                    u2 (ref, index: 1)
                ]]
                u2 = u2 - 1
            end
        )
    end
    if not v7 then
        return
    end
    if (v6 == "Dirt" or v6 == "Sand" or v6 == "Snow") and (math.random() < 0.5) and (v3 or Quality_upv_1.budget.remoteDust) then
        Effects_upv_1.Dust(v4 + v10, 0.35, Effects_upv_1.DustColor(v5))
    end
end
local tbl_upv_7 = {}
local u3 = 90
local u4 = 0
local function muteDefaultSounds(a1)
    --[[
      name: muteDefaultSounds
      line: 105
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v14 = a1:WaitForChild("HumanoidRootPart", 10)
    if not v14 then
        return
    end
    local function mute_1(a2)
        --[[
          name: mute
          line: 110
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        if not a2:IsA("Sound") or not tbl_upv_4[a2.Name] then
            return
        end
        a2.Volume = 0
        a2:GetPropertyChangedSignal("Volume"):Connect(
            function()
                --[[
                  line: 113
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                if a2.Volume == 0 then
                    return
                end
                a2.Volume = 0
            end
        )
    end
    for _, value_1 in v14:GetChildren() do
        mute_1(value_1)
    end
    v14.ChildAdded:Connect(mute_1)
end
local function update(a1)
    --[[
      name: update
      line: 187
      upvalues:
        Quality_upv_1 (copy, index: 1)
        u4 (ref,  index: 2)
        Workspace_upv_1 (copy, index: 3)
        LocalPlayer_upv_1 (copy, index: 4)
        u3 (ref,  index: 5)
        tbl_upv_7 (copy, index: 6)
        Characters_upv_1 (copy, index: 7)
        tbl_upv_3 (copy, index: 8)
        muteDefaultSounds (copy, index: 9)
        Effects_upv_1 (copy, index: 10)
        step (copy, index: 11)
    ]]
    local budget_1 = Quality_upv_1.budget
    u4 = u4 + a1
    local v15 = 1 / budget_1.remoteHz <= u4
    if v15 then
        u4 = 0
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local v16 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
    local Character_1 = LocalPlayer_upv_1.Character
    local v17 = u3 * u3
    local v18 = 0
    table.clear(tbl_upv_7)
    local v19, v20, v21, v20, v22, v23, v21 = nil, nil, nil, nil, nil, nil, nil
    local v24 = nil
    for _, value_2 in Characters_upv_1.List() do
        tbl_upv_7[value_2] = true
        v20 = value_2 == Character_1
        if v20 or v15 then
            if v20 then
                v19 = a1
            else
                v19 = u4
            end
            local v25 = tbl_upv_3[value_2]
            if v25 then
                v20 = v25
            else
                local tbl_8 = {leftFoot = false, distance = 0, lastVy = 0, airTime = 0}
                tbl_upv_3[value_2] = tbl_8
                task.spawn(muteDefaultSounds, value_2)
                v20 = tbl_8
            end
            v22 = v20.humanoid
            v21 = v20.root
            if not (v22) or v22.Parent ~= value_2 then
                local v26 = value_2:FindFirstChildOfClass("Humanoid")
                v20.humanoid = v26
                v22 = v26
            end
            if not (v21) or v21.Parent ~= value_2 then
                local v27 = value_2:FindFirstChild("HumanoidRootPart")
                if not (v27) or not (v27:IsA("BasePart")) then
                    v21 = nil
                    v20.root = v21
                    if not (v22) or not (v21) or v22.Health <= 0 then
                        continue
                    end
                    local v27 = v21.Position
                    local v28 = value_2 == Character_1
                    v23 = v27 - v16
                    if v28 then
                        v23 = v21.AssemblyLinearVelocity
                        local Magnitude_1 = Vector3.new(v23.X, 0, v23.Z).Magnitude
                        if v28 then
                            v24 = v22.FloorMaterial ~= Enum.Material.Air
                        else
                            local v29 = v22:GetState()
                            local v30 = (math.abs(v23.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                            v24 = v30
                        end
                        if not (v28) then
                            if v24 then
                                if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                                    v20.airTime = 0
                                    v20.lastVy = v23.Y
                                    v23 = true
                                    if value_2:GetAttribute("Sliding") ~= true then
                                        v23 = not v28 and (Magnitude_1 > 30)
                                    end
                                    if not (v24) then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v27
                                        continue
                                    end
                                    if not (Magnitude_1 > 2) then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v27
                                        continue
                                    end
                                    if v23 then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v27
                                        continue
                                    end
                                    local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                                    if v31 < 10 then
                                        v20.distance = v20.distance + v31
                                    end
                                    if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                        v20.distance = 0
                                        step(value_2, v21, v22, v20, Magnitude_1)
                                    end
                                    v20.lastPos = v27
                                end
                                local v32 = v27 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                                local v33 = -v20.lastVy
                                if v33 > 72 then
                                    local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                                    if budget_1.remoteDust then
                                        Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                                    end
                                    Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                                else
                                    step(value_2, v21, v22, v20, 16)
                                end
                                v20.airTime = 0
                            else
                                v20.airTime = v20.airTime + v19
                            end
                            v20.lastVy = v23.Y
                        end
                        v23 = true
                        if value_2:GetAttribute("Sliding") ~= true then
                            v23 = not v28 and (Magnitude_1 > 30)
                        end
                        if not (v24) then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        if not (Magnitude_1 > 2) then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        if v23 then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                        if v31 < 10 then
                            v20.distance = v20.distance + v31
                        end
                        if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                            v20.distance = 0
                            step(value_2, v21, v22, v20, Magnitude_1)
                        end
                        v20.lastPos = v27
                    else
                        if v17 < ((v23.X * v23.X) + (v23.Y * v23.Y)) + (v23.Z * v23.Z) then
                            v20.lastPos = v27
                            continue
                        end
                        v18 = v18 + 1
                        v23 = v21.AssemblyLinearVelocity
                        local Magnitude_1 = Vector3.new(v23.X, 0, v23.Z).Magnitude
                        if v28 then
                            v24 = v22.FloorMaterial ~= Enum.Material.Air
                        else
                            local v29 = v22:GetState()
                            local v30 = (math.abs(v23.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                            v24 = v30
                        end
                        if not (v28) then
                            if v24 then
                                if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                                    v20.airTime = 0
                                    v20.lastVy = v23.Y
                                    v23 = true
                                    if value_2:GetAttribute("Sliding") ~= true then
                                        v23 = not v28 and (Magnitude_1 > 30)
                                    end
                                    if not (v24) then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v35
                                        continue
                                    end
                                    if not (Magnitude_1 > 2) then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v35
                                        continue
                                    end
                                    if v23 then
                                        v20.distance = math.min(v20.distance, 2.34)
                                        v20.lastPos = v35
                                        continue
                                    end
                                    local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v35.X, 0, v35.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                                    if v31 < 10 then
                                        v20.distance = v20.distance + v31
                                    end
                                    if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                        v20.distance = 0
                                        step(value_2, v21, v22, v20, Magnitude_1)
                                    end
                                    v20.lastPos = v35
                                end
                                local v32 = v35 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                                local v33 = -v20.lastVy
                                if v33 > 72 then
                                    local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                                    if budget_1.remoteDust then
                                        Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                                    end
                                    Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                                else
                                    step(value_2, v21, v22, v20, 16)
                                end
                                v20.airTime = 0
                            else
                                v20.airTime = v20.airTime + v19
                            end
                            v20.lastVy = v23.Y
                        end
                        v23 = true
                        if value_2:GetAttribute("Sliding") ~= true then
                            v23 = not v28 and (Magnitude_1 > 30)
                        end
                        if not (v24) then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        if not (Magnitude_1 > 2) then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        if v23 then
                            v20.distance = math.min(v20.distance, 2.34)
                            v20.lastPos = v27
                            continue
                        end
                        local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                        if v31 < 10 then
                            v20.distance = v20.distance + v31
                        end
                        if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                            v20.distance = 0
                            step(value_2, v21, v22, v20, Magnitude_1)
                        end
                        v20.lastPos = v27
                    end
                    continue
                end
                v21 = v27
                v20.root = v21
                if not (v22) or not (v21) or v22.Health <= 0 then
                    continue
                end
                local v27 = v21.Position
                local v28 = value_2 == Character_1
                v23 = v27 - v16
                if v28 then
                    local AssemblyLinearVelocity_1 = v21.AssemblyLinearVelocity
                    local Magnitude_1 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude
                    if v28 then
                        v24 = v22.FloorMaterial ~= Enum.Material.Air
                    else
                        local v29 = v22:GetState()
                        local v30 = (math.abs(AssemblyLinearVelocity_1.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                        v24 = v30
                    end
                    if not (v28) then
                        if v24 then
                            if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                                v20.airTime = 0
                                v20.lastVy = AssemblyLinearVelocity_1.Y
                                local v36 = true
                                if value_2:GetAttribute("Sliding") == true then
                                    v23 = v36
                                else
                                    v23 = not v28 and (Magnitude_1 > 30)
                                end
                                if not (v24) then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v27
                                    continue
                                end
                                if not (Magnitude_1 > 2) then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v27
                                    continue
                                end
                                if v23 then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v27
                                    continue
                                end
                                local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                                if v31 < 10 then
                                    v20.distance = v20.distance + v31
                                end
                                if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                    v20.distance = 0
                                    step(value_2, v21, v22, v20, Magnitude_1)
                                end
                                v20.lastPos = v27
                            end
                            local v32 = v27 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                            local v33 = -v20.lastVy
                            if v33 > 72 then
                                local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                                if budget_1.remoteDust then
                                    Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                                end
                                Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                            else
                                step(value_2, v21, v22, v20, 16)
                            end
                            v20.airTime = 0
                        else
                            v20.airTime = v20.airTime + v19
                        end
                        v20.lastVy = AssemblyLinearVelocity_1.Y
                    end
                    local v36 = true
                    if value_2:GetAttribute("Sliding") == true then
                        v23 = v36
                    else
                        v23 = not v28 and (Magnitude_1 > 30)
                    end
                    if not (v24) then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    if not (Magnitude_1 > 2) then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    if v23 then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                    if v31 < 10 then
                        v20.distance = v20.distance + v31
                    end
                    if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                        v20.distance = 0
                        step(value_2, v21, v22, v20, Magnitude_1)
                    end
                    v20.lastPos = v27
                else
                    if v17 < ((v23.X * v23.X) + (v23.Y * v23.Y)) + (v23.Z * v23.Z) then
                        v20.lastPos = v27
                        continue
                    end
                    v18 = v18 + 1
                    local AssemblyLinearVelocity_1 = v21.AssemblyLinearVelocity
                    local Magnitude_1 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude
                    if v28 then
                        v24 = v22.FloorMaterial ~= Enum.Material.Air
                    else
                        local v29 = v22:GetState()
                        local v30 = (math.abs(AssemblyLinearVelocity_1.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                        v24 = v30
                    end
                    if not (v28) then
                        if v24 then
                            if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                                v20.airTime = 0
                                v20.lastVy = AssemblyLinearVelocity_1.Y
                                local v36 = true
                                if value_2:GetAttribute("Sliding") == true then
                                    v23 = v36
                                else
                                    v23 = not v28 and (Magnitude_1 > 30)
                                end
                                if not (v24) then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v35
                                    continue
                                end
                                if not (Magnitude_1 > 2) then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v35
                                    continue
                                end
                                if v23 then
                                    v20.distance = math.min(v20.distance, 2.34)
                                    v20.lastPos = v35
                                    continue
                                end
                                local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v35.X, 0, v35.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                                if v31 < 10 then
                                    v20.distance = v20.distance + v31
                                end
                                if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                    v20.distance = 0
                                    step(value_2, v21, v22, v20, Magnitude_1)
                                end
                                v20.lastPos = v35
                            end
                            local v32 = v35 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                            local v33 = -v20.lastVy
                            if v33 > 72 then
                                local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                                if budget_1.remoteDust then
                                    Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                                end
                                Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                            else
                                step(value_2, v21, v22, v20, 16)
                            end
                            v20.airTime = 0
                        else
                            v20.airTime = v20.airTime + v19
                        end
                        v20.lastVy = AssemblyLinearVelocity_1.Y
                    end
                    local v36 = true
                    if value_2:GetAttribute("Sliding") == true then
                        v23 = v36
                    else
                        v23 = not v28 and (Magnitude_1 > 30)
                    end
                    if not (v24) then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    if not (Magnitude_1 > 2) then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    if v23 then
                        v20.distance = math.min(v20.distance, 2.34)
                        v20.lastPos = v27
                        continue
                    end
                    local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                    if v31 < 10 then
                        v20.distance = v20.distance + v31
                    end
                    if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                        v20.distance = 0
                        step(value_2, v21, v22, v20, Magnitude_1)
                    end
                    v20.lastPos = v27
                end
                continue
            end
            if not (v22) or not (v21) or v22.Health <= 0 then
                continue
            end
            local v27 = v21.Position
            local v28 = value_2 == Character_1
            v23 = v27 - v16
            if v28 then
                local AssemblyLinearVelocity_1 = v21.AssemblyLinearVelocity
                local Magnitude_1 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude
                if v28 then
                    v24 = v22.FloorMaterial ~= Enum.Material.Air
                else
                    local v29 = v22:GetState()
                    local v30 = (math.abs(AssemblyLinearVelocity_1.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                    v24 = v30
                end
                if not (v28) then
                    if v24 then
                        if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                            v20.airTime = 0
                            v20.lastVy = AssemblyLinearVelocity_1.Y
                            local v36 = true
                            if value_2:GetAttribute("Sliding") == true then
                                v23 = v36
                            else
                                v23 = not v28 and (Magnitude_1 > 30)
                            end
                            if not (v24) then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v27
                                continue
                            end
                            if not (Magnitude_1 > 2) then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v27
                                continue
                            end
                            if v23 then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v27
                                continue
                            end
                            local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                            if v31 < 10 then
                                v20.distance = v20.distance + v31
                            end
                            if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                v20.distance = 0
                                step(value_2, v21, v22, v20, Magnitude_1)
                            end
                            v20.lastPos = v27
                        end
                        local v32 = v27 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                        local v33 = -v20.lastVy
                        if v33 > 72 then
                            local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                            if budget_1.remoteDust then
                                Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                            end
                            Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                        else
                            step(value_2, v21, v22, v20, 16)
                        end
                        v20.airTime = 0
                    else
                        v20.airTime = v20.airTime + v19
                    end
                    v20.lastVy = AssemblyLinearVelocity_1.Y
                end
                local v36 = true
                if value_2:GetAttribute("Sliding") == true then
                    v23 = v36
                else
                    v23 = not v28 and (Magnitude_1 > 30)
                end
                if not (v24) or not (Magnitude_1 > 2) or v23 then
                    v20.distance = math.min(v20.distance, 2.34)
                    v20.lastPos = v27
                    continue
                end
                local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                if v31 < 10 then
                    v20.distance = v20.distance + v31
                end
                if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                    v20.distance = 0
                    step(value_2, v21, v22, v20, Magnitude_1)
                end
                v20.lastPos = v27
            else
                if v17 < ((v23.X * v23.X) + (v23.Y * v23.Y)) + (v23.Z * v23.Z) then
                    v20.lastPos = v27
                    continue
                end
                v18 = v18 + 1
                local AssemblyLinearVelocity_1 = v21.AssemblyLinearVelocity
                local Magnitude_1 = Vector3.new(AssemblyLinearVelocity_1.X, 0, AssemblyLinearVelocity_1.Z).Magnitude
                if v28 then
                    v24 = v22.FloorMaterial ~= Enum.Material.Air
                else
                    local v29 = v22:GetState()
                    local v30 = (math.abs(AssemblyLinearVelocity_1.Y) < 6) and ((v29 ~= Enum.HumanoidStateType.Freefall) and ((v29 ~= Enum.HumanoidStateType.Jumping) and (v29 ~= Enum.HumanoidStateType.Swimming)))
                    v24 = v30
                end
                if not (v28) then
                    if v24 then
                        if not (v20.airTime > 0.35) or not (v20.lastVy < -30) then
                            v20.airTime = 0
                            v20.lastVy = AssemblyLinearVelocity_1.Y
                            local v36 = true
                            if value_2:GetAttribute("Sliding") == true then
                                v23 = v36
                            else
                                v23 = not v28 and (Magnitude_1 > 30)
                            end
                            if not (v24) then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v35
                                continue
                            end
                            if not (Magnitude_1 > 2) then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v35
                                continue
                            end
                            if v23 then
                                v20.distance = math.min(v20.distance, 2.34)
                                v20.lastPos = v35
                                continue
                            end
                            local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v35.X, 0, v35.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                            if v31 < 10 then
                                v20.distance = v20.distance + v31
                            end
                            if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                                v20.distance = 0
                                step(value_2, v21, v22, v20, Magnitude_1)
                            end
                            v20.lastPos = v35
                        end
                        local v32 = v35 - Vector3.new(0, v22.HipHeight + (v21.Size.Y / 2), 0)
                        local v33 = -v20.lastVy
                        if v33 > 72 then
                            local v34 = math.clamp((v33 - 64) / 60, 0, 1)
                            if budget_1.remoteDust then
                                Effects_upv_1.Dust(v32, (v34 * 1.4) + 0.6, Effects_upv_1.DustColor(nil))
                            end
                            Effects_upv_1.PlaySoundAt(((v34 > 0.5) and "LandHeavy") or "Land", v32, {maxDistance = 90, pitchVar = 0.06, volume = (v34 * 0.6) + 0.35})
                        else
                            step(value_2, v21, v22, v20, 16)
                        end
                        v20.airTime = 0
                    else
                        v20.airTime = v20.airTime + v19
                    end
                    v20.lastVy = AssemblyLinearVelocity_1.Y
                end
                local v36 = true
                if value_2:GetAttribute("Sliding") == true then
                    v23 = v36
                else
                    v23 = not v28 and (Magnitude_1 > 30)
                end
                if not (v24) or not (Magnitude_1 > 2) or v23 then
                    v20.distance = math.min(v20.distance, 2.34)
                    v20.lastPos = v27
                    continue
                end
                local v31 = ((not (v20.lastPos)) and 0) or ((Vector3.new(v27.X, 0, v27.Z) - Vector3.new(v20.lastPos.X, 0, v20.lastPos.Z)).Magnitude)
                if v31 < 10 then
                    v20.distance = v20.distance + v31
                end
                if (((Magnitude_1 > 15) and 5.2) or 3.9) <= v20.distance then
                    v20.distance = 0
                    step(value_2, v21, v22, v20, Magnitude_1)
                end
                v20.lastPos = v27
            end
        end
    end
    if v15 then
        for key_1 in tbl_upv_3 do
            if not (tbl_upv_7[key_1]) then
                tbl_upv_3[key_1] = nil
            end
        end
    end
    if v15 then
        local stepCap_1 = budget_1.stepCap
        if stepCap_1 < v18 then
            u3 = math.max(30, u3 * 0.92)
        elseif v18 < stepCap_1 * 0.7 then
            u3 = math.min(budget_1.stepRadius, u3 + (u4 * 20))
        end
        u3 = math.min(u3, budget_1.stepRadius)
    end
end
function tbl_1.Start()
    --[[
      name: Start
      line: 315
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Perf_upv_1 (copy, index: 2)
        update (copy, index: 3)
    ]]
    RunService_upv_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 316
              upvalues:
                Perf_upv_1 (copy, index: 1)
                update (copy, index: 2)
            ]]
            local v37 = Perf_upv_1.Begin()
            update(a1)
            Perf_upv_1.End("Footsteps", v37)
        end
    )
end
return tbl_1