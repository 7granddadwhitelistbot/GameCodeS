local tbl_upv_1 = {}
tbl_upv_1.SEGMENTS = 12
tbl_upv_1.LAYERS = 2
local u1 = nil
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u2 = nil
local u3 = nil
local u4 = nil
local u5 = false
local function build()
    --[[
      name: build
      line: 30
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u4 (ref,  index: 6)
    ]]
    local v1 = Instance.new("Part")
    v1.Name = "TribesBladeSmear"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    for n_1 = 1, tbl_upv_1.LAYERS do
        local tbl_4 = {}
        local tbl_5 = {}
        for n_2 = 1, tbl_upv_1.SEGMENTS + 1 do
            local v2 = Instance.new("Attachment")
            v2.Parent = v1
            tbl_4[n_2] = v2
        end
        for n_3 = 1, tbl_upv_1.SEGMENTS do
            local v3 = Instance.new("Beam")
            v3.Attachment0 = tbl_4[n_3]
            v3.Attachment1 = tbl_4[n_3 + 1]
            v3.FaceCamera = false
            v3.Segments = 1
            v3.LightEmission = 0.2
            v3.LightInfluence = 0.3
            v3.ZOffset = n_1 * 0.01
            v3.Enabled = false
            v3.Parent = v1
            tbl_5[n_3] = v3
        end
        tbl_upv_2[n_1] = tbl_4
        tbl_upv_3[n_1] = tbl_5
    end
    local v4 = Instance.new("Attachment")
    v4.Parent = v1
    u2 = v4
    local v5 = Instance.new("ParticleEmitter")
    v5.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    v5.Enabled = false
    v5.LightEmission = 0.4
    v5.LightInfluence = 0.2
    v5.Color = ColorSequence.new(Color3.fromRGB(255, 214, 140), Color3.fromRGB(255, 140, 60))
    v5.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.05), NumberSequenceKeypoint.new(1, 0)})
    v5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
    v5.Lifetime = NumberRange.new(0.12, 0.26)
    v5.Speed = NumberRange.new(1.2, 3)
    v5.SpreadAngle = Vector2.new(180, 180)
    v5.Drag = 7
    v5.Acceleration = Vector3.new(0, -4, 0)
    v5.LockedToPart = true
    v5.Parent = v4
    u3 = v5
    v5 = Instance.new("ParticleEmitter")
    v5.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    v5.Enabled = false
    v5.LightEmission = 0.4
    v5.LightInfluence = 0
    v5.Color = ColorSequence.new(Color3.fromRGB(255, 236, 200))
    v5.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.06), NumberSequenceKeypoint.new(0.25, 0.16), NumberSequenceKeypoint.new(1, 0)})
    v5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
    v5.Lifetime = NumberRange.new(0.1, 0.12)
    v5.Speed = NumberRange.new(0)
    v5.Rotation = NumberRange.new(0, 45)
    v5.LockedToPart = true
    v5.Parent = v4
    u4 = v5
    return v1
end
local function ensure(a1, a2)
    --[[
      name: ensure
      line: 101
      upvalues:
        u1 (ref,  index: 1)
        build (copy, index: 2)
    ]]
    local v6 = u1 or (build())
    u1 = v6
    v6.CFrame = a2
    if v6.Parent ~= a1 then
        v6.Parent = a1
    end
    return v6
end
function tbl_upv_1.Draw(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Draw
      line: 111
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        build (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        u5 (ref,  index: 6)
    ]]
    local v7 = math.min(#a4, tbl_upv_1.SEGMENTS + 1)
    if v7 < 2 then
        tbl_upv_1.Hide()
    else
        local v8 = u1 or (build())
        u1 = v8
        v8.CFrame = a2
        if v8.Parent ~= a1 then
            v8.Parent = a1
        end
        local v9 = tbl_upv_2[a3]
        local v10 = tbl_upv_3[a3]
        if not v9 then
            return
        end
        local v11 = ColorSequence.new(a7)
        for n_4 = 1, v7 do
            v9[n_4].CFrame = a4[n_4]
        end
        for n_5 = 1, tbl_upv_1.SEGMENTS do
            local v12 = v10[n_5]
            if n_5 < v7 then
                v12.Width0 = a5[n_5]
                v12.Width1 = a5[n_5 + 1]
                v12.Transparency = NumberSequence.new(a6[n_5], a6[n_5 + 1])
                v12.Color = v11
                v12.Enabled = true
                continue
            end
            if v12.Enabled then
                v12.Enabled = false
            end
        end
        u5 = true
    end
end
function tbl_upv_1.Hide()
    --[[
      name: Hide
      line: 141
      upvalues:
        u5 (ref,  index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    if not u5 then
        return
    end
    u5 = false
    for _, value_1 in tbl_upv_3 do
        for v1, value_2 in value_1 do
            value_2.Enabled = false
        end
    end
end
function tbl_upv_1.Follow(a1)
    --[[
      name: Follow
      line: 154
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not u1 or not u1.Parent then
        return
    end
    u1.CFrame = a1
end
function tbl_upv_1.Spark(a1, a2, a3)
    --[[
      name: Spark
      line: 161
      upvalues:
        u1 (ref,  index: 1)
        build (copy, index: 2)
        u2 (ref,  index: 3)
        u3 (ref,  index: 4)
        u4 (ref,  index: 5)
    ]]
    local v13 = u1 or (build())
    u1 = v13
    v13.CFrame = a2
    if v13.Parent ~= a1 then
        v13.Parent = a1
    end
    if not u2 or not u3 then
        return
    end
    u2.Position = a3
    u3:Emit(18)
    if not u4 then
        return
    end
    u4:Emit(1)
end
return tbl_upv_1