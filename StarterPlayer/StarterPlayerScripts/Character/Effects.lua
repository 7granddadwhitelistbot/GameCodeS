local Debris_upv_1 = game:GetService("Debris")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local SoundService_upv_1 = game:GetService("SoundService")
local Workspace_upv_1 = game:GetService("Workspace")
local Quality_upv_1 = require(script.Parent:WaitForChild("Quality"))
local tbl_upv_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.Jump = {id = "rbxasset://sounds/action_jump.mp3", volume = 0.15}
tbl_upv_2.Land = {id = "rbxasset://sounds/action_jump_land.mp3", volume = 0.5}
tbl_upv_2.LandHeavy = {id = "rbxasset://sounds/action_jump_land.mp3", speed = 0.8, volume = 0.9}
tbl_upv_2.Footstep = {id = "rbxasset://sounds/action_footsteps_plastic.mp3", volume = 0.25}
tbl_upv_2.Slide = {id = "rbxasset://sounds/action_falling.mp3", speed = 1.6, volume = 0.3}
local function soundsFolder()
    --[[
      name: soundsFolder
      line: 27
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v1 = Assets_1 and (Assets_1:FindFirstChild("Sounds"))
    local v2 = v1 and (v1:FindFirstChild("Character"))
    return v2
end
local u1 = nil
local u2 = -math.huge
local u3 = false
local function getSfx()
    --[[
      name: getSfx
      line: 37
      upvalues:
        u1 (ref,  index: 1)
        u3 (ref,  index: 2)
        u2 (ref,  index: 3)
        ReplicatedStorage_upv_1 (copy, index: 4)
    ]]
    if not (u1) and not (u3) then
        local v3 = os.clock()
        if v3 - u2 < 5 then
            return nil
        end
        u2 = v3
        local Shared_1 = ReplicatedStorage_upv_1:FindFirstChild("Shared")
        local v4 = Shared_1 and (Shared_1:FindFirstChild("Sfx"))
        if v4 and v4:IsA("ModuleScript") then
            local success_1, v5 = pcall(require, v4)
            if success_1 and type(v5) == "table" and type(v5.Play) == "function" then
                u1 = v5
            else
                u3 = true
                warn("[Character] Shared.Sfx failed to load; playing character sounds locally")
            end
        end
        return u1
    end
    return u1
end
function tbl_upv_1.Group(a1)
    --[[
      name: Group
      line: 60
      upvalues:
        SoundService_upv_1 (copy, index: 1)
    ]]
    local v6 = SoundService_upv_1:FindFirstChild(a1)
    if v6 and v6:IsA("SoundGroup") then
        return v6
    end
    return nil
end
local function pickTemplate(a1)
    --[[
      name: pickTemplate
      line: 70
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local Assets_2 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v7 = Assets_2 and (Assets_2:FindFirstChild("Sounds"))
    local v8 = v7 and (v7:FindFirstChild("Character"))
    local v9 = v8 and (v8:FindFirstChild(a1))
    if not v9 then
        return nil, nil
    end
    if v9:IsA("Sound") then
        return v9, "Character/" .. a1
    end
    local v10 = v9:GetChildren()
    local v11 = #v10
    if v11 == 0 then
        return nil, nil
    end
    local v12 = math.random(1, v11)
    local v13 = nil
    for n_1 = 0, v11 - 1 do
        v13 = v10[(((v12 + n_1) - 1) % v11) + 1]
        local v14 = v13:IsA("Sound")
        if not (v14) then
            continue
        end
        return v13, "Character/" .. a1 .. "/" .. v13.Name
    end
    return nil, nil
end
function tbl_upv_1.MakeSound(a1)
    --[[
      name: MakeSound
      line: 95
      upvalues:
        pickTemplate (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v15 = pickTemplate(a1)
    local v16, v17 = nil, nil
    if v15 then
        v16 = v15:Clone()
    else
        v17 = tbl_upv_2[a1]
        if v17 then
            v16 = Instance.new("Sound")
            v16.Name = a1
            v16.SoundId = v17.id
            v16.Volume = v17.volume
            v16.PlaybackSpeed = v17.speed or 1
        else
            return nil
        end
    end
    v16.SoundGroup = v16.SoundGroup or tbl_upv_1.Group("SFX")
    return v16
end
local function speedOf(a1)
    --[[
      name: speedOf
      line: 123
    ]]
    local v19 = a1.speed or 1
    local v20 = ((a1.pitchVar) and (v19 * (1 + (((math.random() * 2) - 1) * a1.pitchVar)))) or v19
    return v20
end
local function sfxPath(a1)
    --[[
      name: sfxPath
      line: 155
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local Assets_3 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v21 = Assets_3 and (Assets_3:FindFirstChild("Sounds"))
    local v22 = v21 and (v21:FindFirstChild("Character"))
    if v22 and v22:FindFirstChild(a1) then
        return "Character/" .. a1
    end
    return nil
end
local function loopViaSfx(a1, a2, a3, a4)
    --[[
      name: loopViaSfx
      line: 176
      upvalues:
        getSfx (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
    ]]
    local v23 = getSfx()
    local v24
    if v23 then
        local Assets_4 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v25 = Assets_4 and (Assets_4:FindFirstChild("Sounds"))
        local v26 = v25 and (v25:FindFirstChild("Character"))
        v24 = not (v26) or not (v26:FindFirstChild(a1)) or "Character/" .. a1
    else
        v24 = v23
    end
    if v23 and v24 and type(v23.Loop) == "function" then
        local success_2, _, v27 = pcall(v23.Loop, v24, a2)
        if success_2 and typeof(v27) == "Instance" and v27:IsA("Sound") then
            v27.Volume = v27.Volume * (a3.volume or 1)
            v27.PlaybackSpeed = v27.PlaybackSpeed * a4
            return v27
        end
        return nil
    end
    return nil
end
local function viaSfx(a1, a2, a3, a4)
    --[[
      name: viaSfx
      line: 165
      upvalues:
        getSfx (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
    ]]
    local v28 = getSfx()
    local v29
    if v28 then
        local Assets_5 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v30 = Assets_5 and (Assets_5:FindFirstChild("Sounds"))
        local v31 = v30 and (v30:FindFirstChild("Character"))
        v29 = not (v31) or not (v31:FindFirstChild(a1)) or "Character/" .. a1
    else
        v29 = v28
    end
    if not v28 or not v29 then
        return false, nil
    end
    local success_3, v32 = pcall(v28.Play, v29, a2, {volume = a3.volume or 1, pitch = a4})
    return success_3, v32
end
local function playLocal(a1, a2, a3, a4)
    --[[
      name: playLocal
      line: 131
      upvalues:
        tbl_upv_1 (copy, index: 1)
        SoundService_upv_1 (copy, index: 2)
        Debris_upv_1 (copy, index: 3)
    ]]
    local u4 = tbl_upv_1.MakeSound(a1)
    if u4 then
        u4.Volume = u4.Volume * (a3.volume or 1)
        u4.PlaybackSpeed = u4.PlaybackSpeed * a4
        if a3.maxDistance then
            u4.RollOffMaxDistance = a3.maxDistance
        end
        u4.Looped = a3.looped == true
        u4.Parent = a2 or SoundService_upv_1
        u4:Play()
        if not (u4.Looped) then
            u4.Ended:Once(
                function()
                    --[[
                      line: 145
                      upvalues:
                        u4 (copy, index: 1)
                    ]]
                    u4:Destroy()
                end
            )
            Debris_upv_1:AddItem(u4, 10)
        end
        return u4
    end
    return nil
end
function tbl_upv_1.PlaySound(a1, a2, a3)
    --[[
      name: PlaySound
      line: 193
      upvalues:
        loopViaSfx (copy, index: 1)
        viaSfx (copy, index: 2)
        playLocal (copy, index: 3)
    ]]
    local v34 = a3 or {}
    local v35 = v34.speed or 1
    if v34.pitchVar then
        v35 = v35 * (1 + (math.random() * 2 - 1) * v34.pitchVar)
    end
    local v36 = nil
    if v34.looped then
        v36 = loopViaSfx(a1, a2, v34, v35)
        if v36 then
            return v36
        end
    else
        local v37, v38 = viaSfx(a1, a2, v34, v35)
        if v37 then
            if typeof(v38) == "Instance" and v38:IsA("Sound") then
                return v38
            end
            return nil
        end
    end
    return (playLocal(a1, a2, v34, v35))
end
function tbl_upv_1.PlaySoundAt(a1, a2, a3)
    --[[
      name: PlaySoundAt
      line: 211
      upvalues:
        viaSfx (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        Debris_upv_1 (copy, index: 3)
        playLocal (copy, index: 4)
    ]]
    local v39 = a3 or {}
    local v40 = v39.speed or 1
    if v39.pitchVar then
        v40 = v40 * (1 + (((math.random() * 2) - 1) * v39.pitchVar))
    end
    local v41, v42 = viaSfx(a1, a2, v39, v40)
    if v41 then
        if typeof(v42) == "Instance" and v42:IsA("Sound") then
            return v42
        end
        return nil
    else
        local v43 = Instance.new("Attachment")
        v43.WorldPosition = a2
        v43.Parent = Workspace_upv_1.Terrain
        Debris_upv_1:AddItem(v43, 4)
        return (playLocal(a1, v43, v39, v40))
    end
end
local u5 = nil
local function localFx()
    --[[
      name: localFx
      line: 229
      upvalues:
        u5 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    if u5 and u5.Parent then
        return u5
    end
    local v44 = Instance.new("Folder")
    v44.Name = "CharacterFX"
    v44.Parent = Workspace_upv_1.CurrentCamera
    u5 = v44
    return v44
end
local function makeDustEmitter(a1, a2)
    --[[
      name: makeDustEmitter
      line: 242
    ]]
    local v45 = Instance.new("ParticleEmitter")
    v45.Texture = "rbxasset://textures/particles/smoke_main.dds"
    v45.LightEmission = 0
    v45.LightInfluence = 1
    v45.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(0.6, 0.7), NumberSequenceKeypoint.new(1, 1)})
    v45.Lifetime = NumberRange.new(0.45, 0.8)
    v45.Rotation = NumberRange.new(0, 360)
    v45.RotSpeed = NumberRange.new(-60, 60)
    v45.Drag = 6
    v45.SpreadAngle = Vector2.new(180, 8)
    v45.Acceleration = Vector3.new(0, 3, 0)
    v45.Shape = Enum.ParticleEmitterShape.Disc
    v45.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
    v45.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
    v45.Enabled = false
    local v46 = a1 or (Color3.fromRGB(214, 200, 176))
    v45.Color = ColorSequence.new(v46)
    v45.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a2 * 0.6), NumberSequenceKeypoint.new(1, a2 * 2.2)})
    v45.Speed = NumberRange.new(a2 * 6, a2 * 11)
    v45.Orientation = Enum.ParticleOrientation.FacingCamera
    return v45
end
function tbl_upv_1.Dust(a1, a2, a3)
    --[[
      name: Dust
      line: 273
      upvalues:
        u5 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        makeDustEmitter (copy, index: 3)
        Quality_upv_1 (copy, index: 4)
        Debris_upv_1 (copy, index: 5)
    ]]
    local v47 = Instance.new("Part")
    v47.Anchored = true
    v47.CanCollide = false
    v47.CanQuery = false
    v47.CanTouch = false
    v47.Transparency = 1
    v47.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v47.CFrame = CFrame.new(a1)
    local v48
    if (u5) and (u5.Parent) then
        v48 = u5
    else
        local v49 = Instance.new("Folder")
        v49.Name = "CharacterFX"
        v49.Parent = Workspace_upv_1.CurrentCamera
        u5 = v49
        v48 = v49
    end
    v47.Parent = v48
    local v50 = makeDustEmitter(a3, a2)
    v50.Parent = v47
    v50:Emit((math.clamp(math.floor((a2 * 8) * Quality_upv_1.budget.dustScale), 2, 30)))
    Debris_upv_1:AddItem(v47, 2)
end
function tbl_upv_1.Trail(a1, a2)
    --[[
      name: Trail
      line: 290
      upvalues:
        makeDustEmitter (copy, index: 1)
        Quality_upv_1 (copy, index: 2)
    ]]
    local v51 = makeDustEmitter(a2, 0.55)
    v51.SpreadAngle = Vector2.new(35, 35)
    v51.EmissionDirection = Enum.NormalId.Top
    v51.Shape = Enum.ParticleEmitterShape.Box
    v51.Speed = NumberRange.new(2, 5)
    v51.Lifetime = NumberRange.new(0.35, 0.6)
    v51.Rate = 34 * Quality_upv_1.budget.dustScale
    v51.Enabled = true
    v51.Parent = a1
    return v51
end
local tbl_upv_3 = {}
tbl_upv_3[Enum.Material.Grass] = Color3.fromRGB(150, 175, 110)
tbl_upv_3[Enum.Material.LeafyGrass] = Color3.fromRGB(150, 175, 110)
tbl_upv_3[Enum.Material.Salt] = Color3.fromRGB(150, 175, 110)
tbl_upv_3[Enum.Material.Basalt] = Color3.fromRGB(170, 140, 105)
tbl_upv_3[Enum.Material.Sand] = Color3.fromRGB(226, 206, 158)
tbl_upv_3[Enum.Material.Snow] = Color3.fromRGB(218, 224, 232)
tbl_upv_3[Enum.Material.Mud] = Color3.fromRGB(120, 95, 70)
tbl_upv_3[Enum.Material.Ground] = Color3.fromRGB(170, 140, 105)
tbl_upv_3[Enum.Material.Water] = Color3.fromRGB(186, 208, 230)
tbl_upv_3[Enum.Material.Wood] = Color3.fromRGB(176, 150, 118)
tbl_upv_3[Enum.Material.WoodPlanks] = Color3.fromRGB(176, 150, 118)
function tbl_upv_1.DustColor(a1)
    --[[
      name: DustColor
      line: 317
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v52 = (a1 and (tbl_upv_3[a1])) or (Color3.fromRGB(196, 186, 170))
    return v52
end
return tbl_upv_1