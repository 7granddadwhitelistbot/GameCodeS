local v1 = {SEGMENTS = 12, LAYERS = 2}
local part = nil
local v3 = {}
local v4 = {}
local attachment = nil
local particleEmitter = nil
local particleEmitter2 = nil
local v8 = false

local function build()
    --[[
      name: build
      line: 30
      upvalues:
        v1 (copy, index: 1)
        v3 (copy, index: 2)
        v4 (copy, index: 3)
        attachment (ref,  index: 4)
        particleEmitter (ref,  index: 5)
        particleEmitter2 (ref,  index: 6)
    ]]
    local tribesBladeSmear = Instance.new("Part")
    tribesBladeSmear.Name = "TribesBladeSmear"
    tribesBladeSmear.Anchored = true
    tribesBladeSmear.CanCollide = false
    tribesBladeSmear.CanQuery = false
    tribesBladeSmear.CanTouch = false
    tribesBladeSmear.CastShadow = false
    tribesBladeSmear.Transparency = 1
    tribesBladeSmear.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)

    for index = 1, v1.LAYERS do
        local v12 = {}
        local v13 = {}

        for index2 = 1, v1.SEGMENTS + 1 do
            local attachment2 = Instance.new("Attachment")
            attachment2.Parent = tribesBladeSmear
            v12[index2] = attachment2
        end

        for index3 = 1, v1.SEGMENTS do
            local beam = Instance.new("Beam")
            beam.Attachment0 = v12[index3]
            beam.Attachment1 = v12[index3 + 1]
            beam.FaceCamera = false
            beam.Segments = 1
            beam.LightEmission = 0.2
            beam.LightInfluence = 0.3
            beam.ZOffset = index * 0.01
            beam.Enabled = false
            beam.Parent = tribesBladeSmear
            v13[index3] = beam
        end

        v3[index] = v12
        v4[index] = v13
    end

    local parent = Instance.new("Attachment")
    parent.Parent = tribesBladeSmear
    attachment = parent
    local particleEmitter3 = Instance.new("ParticleEmitter")
    particleEmitter3.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particleEmitter3.Enabled = false
    particleEmitter3.LightEmission = 0.4
    particleEmitter3.LightInfluence = 0.2
    particleEmitter3.Color = ColorSequence.new(Color3.fromRGB(255, 214, 140), Color3.fromRGB(255, 140, 60))
    particleEmitter3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.05), NumberSequenceKeypoint.new(1, 0)})
    particleEmitter3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter3.Lifetime = NumberRange.new(0.12, 0.26)
    particleEmitter3.Speed = NumberRange.new(1.2, 3)
    particleEmitter3.SpreadAngle = Vector2.new(180, 180)
    particleEmitter3.Drag = 7
    particleEmitter3.Acceleration = Vector3.new(0, -4, 0)
    particleEmitter3.LockedToPart = true
    particleEmitter3.Parent = parent
    particleEmitter = particleEmitter3
    particleEmitter3 = Instance.new("ParticleEmitter")
    particleEmitter3.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particleEmitter3.Enabled = false
    particleEmitter3.LightEmission = 0.4
    particleEmitter3.LightInfluence = 0
    particleEmitter3.Color = ColorSequence.new(Color3.fromRGB(255, 236, 200))
    particleEmitter3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.06), NumberSequenceKeypoint.new(0.25, 0.16), NumberSequenceKeypoint.new(1, 0)})
    particleEmitter3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter3.Lifetime = NumberRange.new(0.1, 0.12)
    particleEmitter3.Speed = NumberRange.new(0)
    particleEmitter3.Rotation = NumberRange.new(0, 45)
    particleEmitter3.LockedToPart = true
    particleEmitter3.Parent = parent
    particleEmitter2 = particleEmitter3

    return tribesBladeSmear
end

local function ensure(parent: Instance?, cFrame: CFrame)
    --[[
      name: ensure
      line: 101
      upvalues:
        part (ref,  index: 1)
        build (copy, index: 2)
    ]]
    local part2 = part or build()
    part = part2
    part2.CFrame = cFrame

    if part2.Parent ~= parent then
        part2.Parent = parent
    end

    return part2
end

function v1.Draw(parent: Instance?, cFrame: CFrame, key, a27, a28, a29, a30)
    --[[
      name: Draw
      line: 111
      upvalues:
        v1 (copy, index: 1)
        part (ref,  index: 2)
        build (copy, index: 3)
        v3 (copy, index: 4)
        v4 (copy, index: 5)
        v8 (ref,  index: 6)
    ]]
    local endIndex = math.min(#a27, v1.SEGMENTS + 1)

    if endIndex < 2 then
        v1.Hide()
        return
    end

    local part2 = part or build()
    part = part2
    part2.CFrame = cFrame

    if part2.Parent ~= parent then
        part2.Parent = parent
    end

    local v33 = v3[key]
    local v34 = v4[key]

    if not v33 then
        return
    end

    local color = ColorSequence.new(a30)

    for index = 1, endIndex do
        v33[index].CFrame = a27[index]
    end

    for index = 1, v1.SEGMENTS do
        local beam = v34[index]

        if index < endIndex then
            beam.Width0 = a28[index]
            beam.Width1 = a28[index + 1]
            beam.Transparency = NumberSequence.new(a29[index], a29[index + 1])
            beam.Color = color
            beam.Enabled = true
        elseif beam.Enabled then
            beam.Enabled = false
        end
    end

    v8 = true
end

function v1.Hide()
    --[[
      name: Hide
      line: 141
      upvalues:
        v8 (ref,  index: 1)
        v4 (copy, index: 2)
    ]]
    if not v8 then
        return
    end

    v8 = false

    for _, v40 in v4 do
        for _, beam in v40 do
            beam.Enabled = false
        end
    end
end

function v1.Follow(cFrame: CFrame)
    --[[
      name: Follow
      line: 154
      upvalues:
        part (ref, index: 1)
    ]]
    local part2 = part

    if part2 and part2.Parent then
        part2.CFrame = cFrame
    end
end

function v1.Spark(parent: Instance?, cFrame: CFrame, position: Vector3)
    --[[
      name: Spark
      line: 161
      upvalues:
        part (ref,  index: 1)
        build (copy, index: 2)
        attachment (ref,  index: 3)
        particleEmitter (ref,  index: 4)
        particleEmitter2 (ref,  index: 5)
    ]]
    local part2 = part or build()
    part = part2
    part2.CFrame = cFrame

    if part2.Parent ~= parent then
        part2.Parent = parent
    end

    local attachment2 = attachment
    local particleEmitter3 = particleEmitter

    if attachment2 and particleEmitter3 then
        attachment2.Position = position
        particleEmitter3:Emit(18)

        if particleEmitter2 then
            particleEmitter2:Emit(1)
        end
    end
end

return v1