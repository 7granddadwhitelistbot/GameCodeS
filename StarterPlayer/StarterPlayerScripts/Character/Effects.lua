local debris = game:GetService("Debris")
local replicatedStorage = game:GetService("ReplicatedStorage")
local soundService = game:GetService("SoundService")
local workspace = game:GetService("Workspace")
local Quality = require(script.Parent:WaitForChild("Quality"))
local v6 = {}
local v7 = {Jump = {id = "rbxasset://sounds/action_jump.mp3", volume = 0.15}, Land = {id = "rbxasset://sounds/action_jump_land.mp3", volume = 0.5}, LandHeavy = {id = "rbxasset://sounds/action_jump_land.mp3", volume = 0.9, speed = 0.8}, Footstep = {id = "rbxasset://sounds/action_footsteps_plastic.mp3", volume = 0.25}, Slide = {id = "rbxasset://sounds/action_falling.mp3", volume = 0.3, speed = 1.6}}

local function soundsFolder()
    --[[
      name: soundsFolder
      line: 27
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local instance = replicatedStorage:FindFirstChild("Assets")
    instance = instance and instance:FindFirstChild("Sounds")

    return instance and instance:FindFirstChild("Character")
end

local result = nil
local timestamp = -math.huge
local v12 = false

local function getSfx()
    --[[
      name: getSfx
      line: 37
      upvalues:
        result (ref,  index: 1)
        v12 (ref,  index: 2)
        timestamp (ref,  index: 3)
        replicatedStorage (copy, index: 4)
    ]]
    if result or v12 then
        return result
    end

    local timestamp2 = os.clock()

    if timestamp2 - timestamp < 5 then
        return nil
    end

    timestamp = timestamp2
    local shared = replicatedStorage:FindFirstChild("Shared")
    local sfx = shared and shared:FindFirstChild("Sfx")

    if sfx and sfx:IsA("ModuleScript") then
        local success, result2 = pcall(require, sfx)

        if not success or type(result2) ~= "table" or type(result2.Play) ~= "function" then
            v12 = true
            warn("[Character] Shared.Sfx failed to load; playing character sounds locally")
        else
            result = result2
        end
    end

    return result
end

function v6.Group(childName: string)
    --[[
      name: Group
      line: 60
      upvalues:
        soundService (copy, index: 1)
    ]]
    local child = soundService:FindFirstChild(childName)

    if child and child:IsA("SoundGroup") then
        return child
    end

    return nil
end

local function pickTemplate(childName: string)
    --[[
      name: pickTemplate
      line: 70
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local instance = replicatedStorage:FindFirstChild("Assets")
    instance = instance and instance:FindFirstChild("Sounds")
    local character = instance and instance:FindFirstChild("Character")
    local child = character and character:FindFirstChild(childName)
    if not child then
        return nil, nil
    end
    if child:IsA("Sound") then
        return child, "Character/" .. childName
    end

    local children = child:GetChildren()
    local childCount = #children

    if childCount == 0 then
        return nil, nil
    end

    local v28 = math.random(1, childCount)
    local child2

    for index = 0, childCount - 1 do
        child2 = children[(((v28 + index) - 1) % childCount) + 1]

        if child2:IsA("Sound") then
            return child2, "Character/" .. childName .. "/" .. child2.Name
        end
    end

    return nil, nil
end

function v6.MakeSound(name: string)
    --[[
      name: MakeSound
      line: 95
      upvalues:
        pickTemplate (copy, index: 1)
        v7 (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    local instance

    if const instance2 = pickTemplate(name) then
        instance = instance2:Clone()
    else
        local v34 = v7[name]
        if not v34 then
            return nil
        end

        instance = Instance.new("Sound")
        instance.Name = name
        instance.SoundId = v34.id
        instance.Volume = v34.volume
        instance.PlaybackSpeed = v34.speed or 1
    end

    local v35 = instance.SoundGroup or v6.Group("SFX")
    instance.SoundGroup = v35

    return instance
end

local function speedOf(a37)
    --[[
      name: speedOf
      line: 123
    ]]
    local v38 = a37.speed or 1
    local pitchVar = a37.pitchVar
    if pitchVar then
        v38 *= 1 + (((math.random() * 2) - 1) * a37.pitchVar)
    end

    return v38
end

local function playLocal(childName: string, a42, a43, a44)
    --[[
      name: playLocal
      line: 131
      upvalues:
        v6 (copy, index: 1)
        soundService (copy, index: 2)
        debris (copy, index: 3)
    ]]
    local item = v6.MakeSound(childName)
    if not item then
        return nil
    end

    item.Volume *= (a43.volume or 1)
    item.PlaybackSpeed *= a44

    if a43.maxDistance then
        item.RollOffMaxDistance = a43.maxDistance
    end

    item.Looped = a43.looped == true
    item.Parent = a42 or soundService
    item:Play()

    if not item.Looped then
        item.Ended:Once(
            function()
                --[[
                  line: 145
                  upvalues:
                    item (copy, index: 1)
                ]]
                item:Destroy()
            end
        )
        debris:AddItem(item, 10)
    end

    return item
end

local function sfxPath(childName: string)
    --[[
      name: sfxPath
      line: 155
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local instance = replicatedStorage:FindFirstChild("Assets")
    instance = instance and instance:FindFirstChild("Sounds")
    local character = instance and instance:FindFirstChild("Character")

    if character and character:FindFirstChild(childName) then
        return "Character/" .. childName
    end

    return nil
end

local function viaSfx(childName: string, a52, a53, pitch)
    --[[
      name: viaSfx
      line: 165
      upvalues:
        getSfx (copy, index: 1)
        replicatedStorage (copy, index: 2)
    ]]
    local v55
    local sfx = getSfx()
    local sfx2 = sfx

    if sfx2 then
        local instance = replicatedStorage:FindFirstChild("Assets")
        instance = instance and instance:FindFirstChild("Sounds")
        local character = instance and instance:FindFirstChild("Character")
        v55 = if character and character:FindFirstChild(childName) then "Character/" .. childName else nil
    else
        v55 = sfx2
    end

    if not sfx or not v55 then
        return false, nil
    end

    local success, result = pcall(sfx.Play, v55, a52, {volume = a53.volume or 1, pitch = pitch})
    return success, result
end

local function loopViaSfx(childName: string, a64, a65, a66)
    --[[
      name: loopViaSfx
      line: 176
      upvalues:
        getSfx (copy, index: 1)
        replicatedStorage (copy, index: 2)
    ]]
    local v67
    local sfx = getSfx()
    local sfx2 = sfx

    if sfx2 then
        local instance = replicatedStorage:FindFirstChild("Assets")
        instance = instance and instance:FindFirstChild("Sounds")
        local character = instance and instance:FindFirstChild("Character")
        v67 = if character and character:FindFirstChild(childName) then "Character/" .. childName else nil
    else
        v67 = sfx2
    end

    if not sfx or not v67 or type(sfx.Loop) ~= "function" then
        return nil
    end

    local success, _, v74 = pcall(sfx.Loop, v67, a64)

    if not success or typeof(v74) ~= "Instance" or not v74:IsA("Sound") then
        return nil
    end

    v74.Volume *= (a65.volume or 1)
    v74.PlaybackSpeed *= a66

    return v74
end

function v6.PlaySound(childName: string, a76, options)
    --[[
      name: PlaySound
      line: 193
      upvalues:
        loopViaSfx (copy, index: 1)
        viaSfx (copy, index: 2)
        playLocal (copy, index: 3)
    ]]
    local v78 = options or {}
    local v79 = v78.speed or 1

    if v78.pitchVar then
        v79 *= 1 + (((math.random() * 2) - 1) * v78.pitchVar)
    end

    if v78.looped then
        if const v80 = loopViaSfx(childName, a76, v78, v79) then
            return v80
        end
    else
        local v81, v82 = viaSfx(childName, a76, v78, v79)
        if v81 then
            if typeof(v82) == "Instance" and v82:IsA("Sound") then
                return v82
            end

            return nil
        end
    end

    return (playLocal(childName, a76, v78, v79))
end

function v6.PlaySoundAt(childName: string, worldPosition: Vector3, options)
    --[[
      name: PlaySoundAt
      line: 211
      upvalues:
        viaSfx (copy, index: 1)
        workspace (copy, index: 2)
        debris (copy, index: 3)
        playLocal (copy, index: 4)
    ]]
    local v86 = options or {}
    local v87 = v86.speed or 1

    if v86.pitchVar then
        v87 *= 1 + (((math.random() * 2) - 1) * v86.pitchVar)
    end

    local v88, v89 = viaSfx(childName, worldPosition, v86, v87)
    if not v88 then
        local item = Instance.new("Attachment")
        item.WorldPosition = worldPosition
        item.Parent = workspace.Terrain
        debris:AddItem(item, 4)

        return (playLocal(childName, item, v86, v87))
    end

    if typeof(v89) == "Instance" and v89:IsA("Sound") then
        return v89
    end

    return nil
end

local folder = nil

local function localFx()
    --[[
      name: localFx
      line: 229
      upvalues:
        folder (ref,  index: 1)
        workspace (copy, index: 2)
    ]]
    if folder and folder.Parent then
        return folder
    end

    local characterFx = Instance.new("Folder")
    characterFx.Name = "CharacterFX"
    characterFx.Parent = workspace.CurrentCamera
    folder = characterFx

    return characterFx
end

local function makeDustEmitter(a95, a96)
    --[[
      name: makeDustEmitter
      line: 242
    ]]
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    particleEmitter.LightEmission = 0
    particleEmitter.LightInfluence = 1
    particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(0.6, 0.7), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter.Lifetime = NumberRange.new(0.45, 0.8)
    particleEmitter.Rotation = NumberRange.new(0, 360)
    particleEmitter.RotSpeed = NumberRange.new(-60, 60)
    particleEmitter.Drag = 6
    particleEmitter.SpreadAngle = Vector2.new(180, 8)
    particleEmitter.Acceleration = Vector3.new(0, 3, 0)
    particleEmitter.Shape = Enum.ParticleEmitterShape.Disc
    particleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
    particleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
    particleEmitter.Enabled = false
    particleEmitter.Color = ColorSequence.new((a95 or Color3.fromRGB(214, 200, 176)))
    particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a96 * 0.6), NumberSequenceKeypoint.new(1, a96 * 2.2)})
    particleEmitter.Speed = NumberRange.new(a96 * 6, a96 * 11)
    particleEmitter.Orientation = Enum.ParticleOrientation.FacingCamera
    return particleEmitter
end

function v6.Dust(vector3: Vector3, a99, a100)
    --[[
      name: Dust
      line: 273
      upvalues:
        folder (ref,  index: 1)
        workspace (copy, index: 2)
        makeDustEmitter (copy, index: 3)
        Quality (copy, index: 4)
        debris (copy, index: 5)
    ]]
    local characterFx
    local item = Instance.new("Part")
    item.Anchored = true
    item.CanCollide = false
    item.CanQuery = false
    item.CanTouch = false
    item.Transparency = 1
    item.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    item.CFrame = CFrame.new(vector3)

    if folder and folder.Parent then
        characterFx = folder
    else
        characterFx = Instance.new("Folder")
        characterFx.Name = "CharacterFX"
        characterFx.Parent = workspace.CurrentCamera
        folder = characterFx
    end

    item.Parent = characterFx
    local dustEmitter = makeDustEmitter(a100, a99)
    dustEmitter.Parent = item
    dustEmitter:Emit((math.clamp(math.floor((a99 * 8) * Quality.budget.dustScale), 2, 30)))
    debris:AddItem(item, 2)
end

function v6.Trail(parent: Instance?, a105)
    --[[
      name: Trail
      line: 290
      upvalues:
        makeDustEmitter (copy, index: 1)
        Quality (copy, index: 2)
    ]]
    local dustEmitter = makeDustEmitter(a105, 0.55)
    dustEmitter.SpreadAngle = Vector2.new(35, 35)
    dustEmitter.EmissionDirection = Enum.NormalId.Top
    dustEmitter.Shape = Enum.ParticleEmitterShape.Box
    dustEmitter.Speed = NumberRange.new(2, 5)
    dustEmitter.Lifetime = NumberRange.new(0.35, 0.6)
    dustEmitter.Rate = 34 * Quality.budget.dustScale
    dustEmitter.Enabled = true
    dustEmitter.Parent = parent
    return dustEmitter
end

local v107 = {}
v107[Enum.Material.Grass] = Color3.fromRGB(150, 175, 110)
v107[Enum.Material.LeafyGrass] = Color3.fromRGB(150, 175, 110)
v107[Enum.Material.Salt] = Color3.fromRGB(150, 175, 110)
v107[Enum.Material.Basalt] = Color3.fromRGB(170, 140, 105)
v107[Enum.Material.Sand] = Color3.fromRGB(226, 206, 158)
v107[Enum.Material.Snow] = Color3.fromRGB(218, 224, 232)
v107[Enum.Material.Mud] = Color3.fromRGB(120, 95, 70)
v107[Enum.Material.Ground] = Color3.fromRGB(170, 140, 105)
v107[Enum.Material.Water] = Color3.fromRGB(186, 208, 230)
v107[Enum.Material.Wood] = Color3.fromRGB(176, 150, 118)
v107[Enum.Material.WoodPlanks] = Color3.fromRGB(176, 150, 118)

function v6.DustColor(key)
    --[[
      name: DustColor
      line: 317
      upvalues:
        v107 (copy, index: 1)
    ]]
    return key and v107[key] or Color3.fromRGB(196, 186, 170)
end

return v6