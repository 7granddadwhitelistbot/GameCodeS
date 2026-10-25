local tbl_1 = {}
local tbl_upv_2 = {ember = "rbxassetid://112265693545203", glow = "rbxassetid://120877893267841", side = "rbxassetid://133080098550406", swoosh = "rbxassetid://91777724554771", smoke = "rbxassetid://136705730872514", flash = "rbxassetid://132385497945381", dust = "rbxassetid://131207259844964", star = "rbxassetid://121298090783218", ring = "rbxassetid://99127423363509", spark = "rbxassetid://106505437894279"}
local tbl_upv_3 = {dust = true, smoke = true, flash = true}
tbl_1.TEX = tbl_upv_2
local u1 = nil
local u2 = nil
local tbl_upv_4 = {}
local u3 = nil
local u4 = nil
local u5 = 0
local u6 = 0
local u7 = false
local u8 = false
local tbl_upv_5 = nil
local u9 = 0
local u10 = false
local function colors(a1, a2)
    --[[
      name: colors
      line: 59
    ]]
    return ColorSequence.new(a1, a2 or a1)
end
local function newPart(a1)
    --[[
      name: newPart
      line: 63
    ]]
    local v1 = Instance.new("Part")
    v1.Name = a1
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    return v1
end
local function emitter(a1, a2, a3)
    --[[
      name: emitter
      line: 76
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        u10 (ref,  index: 3)
        tbl_upv_4 (copy, index: 4)
    ]]
    local v2 = Instance.new("Attachment")
    v2.Name = a2
    v2.Parent = a1
    local v3 = Instance.new("ParticleEmitter")
    v3.Name = a2
    v3.Enabled = false
    v3.LockedToPart = true
    v3.LightInfluence = 0
    v3.LightEmission = 0.4
    v3.Speed = NumberRange.new(0)
    v3.Rate = 0
    for key_1, value_1 in a3 do
        v3[key_1] = value_1
    end
    local v4 = a3.Texture
    if type(v4) == "string" then
        for key_2, value_2 in tbl_upv_2 do
            if value_2 ~= v4 or not (tbl_upv_3[key_2]) then
                continue
            end
            if not (string.find(value_2, "rbxasset://", 1, true)) then
                v3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid2x2
                v3.FlipbookMode = Enum.ParticleFlipbookMode.Random
            end
        end
    end
    v3.Parent = v2
    if u10 then
        v3.TimeScale = 0.01
    end
    v4 = {}
    v4.att = v2
    v4.e = v3
    tbl_upv_4[a2] = v4
    return v4
end
local _ = Color3.fromRGB(255, 196, 120)
local u11 = Color3.fromRGB(255, 150, 70)
local function seq(...)
    --[[
      name: seq
      line: 50
    ]]
    local tbl_6 = {...}
    local tbl_7 = {}
    for n_1 = 1, #tbl_6, 2 do
        table.insert(tbl_7, NumberSequenceKeypoint.new(tbl_6[n_1], tbl_6[n_1 + 1]))
    end
    return NumberSequence.new(tbl_7)
end
local function build()
    --[[
      name: build
      line: 112
      upvalues:
        u2 (ref,  index: 1)
        emitter (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        seq (copy, index: 4)
        u11 (copy, index: 5)
        tbl_upv_5 (ref,  index: 6)
        u4 (ref,  index: 7)
        u3 (ref,  index: 8)
    ]]
    local v5 = Instance.new("Part")
    v5.Name = "TribesViewFx"
    v5.Anchored = true
    v5.CanCollide = false
    v5.CanQuery = false
    v5.CanTouch = false
    v5.CastShadow = false
    v5.Transparency = 1
    v5.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    local v6 = Instance.new("Part")
    v6.Name = "TribesViewMuzzle"
    v6.Anchored = true
    v6.CanCollide = false
    v6.CanQuery = false
    v6.CanTouch = false
    v6.CastShadow = false
    v6.Transparency = 1
    v6.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    u2 = v6
    local v7 = Color3.fromRGB(255, 186, 92)
    emitter(v6, "flash", {LightEmission = 0.28, ZOffset = 0.3, Texture = tbl_upv_2.flash, Color = ColorSequence.new(v7, Color3.fromRGB(214, 96, 36) or v7), Size = seq(0, 0.07, 0.35, 0.14, 1, 0.1), Transparency = seq(0, 0.05, 0.6, 0.35, 1, 1), Lifetime = NumberRange.new(0.05, 0.065), Rotation = NumberRange.new(0, 360)})
    local v8 = Color3.fromRGB(255, 170, 80)
    emitter(v6, "tongue", {ZOffset = 0.25, Texture = tbl_upv_2.side, Color = ColorSequence.new(v8, Color3.fromRGB(200, 80, 30) or v8), Orientation = Enum.ParticleOrientation.VelocityParallel, Speed = NumberRange.new(0.6), Size = seq(0, 0.05, 0.4, 0.1, 1, 0.07), Squash = seq(0, 1.2, 1, 1), Transparency = seq(0, 0.1, 0.6, 0.4, 1, 1), Lifetime = NumberRange.new(0.045, 0.06), Rotation = NumberRange.new(90)})
    local v9 = Color3.fromRGB(255, 210, 130)
    emitter(v6, "sparks", {Acceleration = Vector3.new(0, -1.5, 0), Drag = 6, ZOffset = 0.2, Texture = tbl_upv_2.spark, Color = ColorSequence.new(v9, u11 or v9), Orientation = Enum.ParticleOrientation.VelocityParallel, Speed = NumberRange.new(2.2, 4.5), SpreadAngle = Vector2.new(14, 14), Size = seq(0, 0.016, 1, 0.004), Squash = seq(0, 2, 1, 1), Transparency = seq(0, 0.05, 1, 1), Lifetime = NumberRange.new(0.08, 0.2), Rotation = NumberRange.new(90)})
    local v10 = Color3.fromRGB(150, 146, 140)
    emitter(
        v5,
        "smoke",
        {Acceleration = Vector3.new(0, 0.11999999731779099, 0), Drag = 2.6, ZOffset = 0.1, LightInfluence = 0.6, LightEmission = 0, Texture = tbl_upv_2.smoke, Color = ColorSequence.new(v10, Color3.fromRGB(122, 118, 114) or v10), Speed = NumberRange.new(0.35, 0.8), SpreadAngle = Vector2.new(18, 18), Size = seq(0, 0.05, 0.3, 0.14, 1, 0.26), Transparency = seq(0, 0.45, 0.25, 0.55, 1, 1), Lifetime = NumberRange.new(0.6, 1), Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-50, 50)}
    )
    local tbl_8 = {Acceleration = Vector3.new(0, 0.2199999988079071, 0), Drag = 1, Rate = 22, LightInfluence = 0.6, LightEmission = 0}
    tbl_8.Texture = tbl_upv_2.smoke
    local v10, v11 = Color3.fromRGB(150, 146, 140)
    tbl_8.Color = ColorSequence.new(v10, v11 or v10)
    tbl_8.Speed = NumberRange.new(0.05, 0.12)
    tbl_8.Size = seq(0, 0.02, 1, 0.09)
    tbl_8.Transparency = seq(0, 0.55, 0.4, 0.7, 1, 1)
    tbl_8.Lifetime = NumberRange.new(0.5, 0.9)
    tbl_8.Rotation = NumberRange.new(0, 360)
    tbl_8.RotSpeed = NumberRange.new(-40, 40)
    emitter(v5, "wisp", tbl_8)
    local tbl_9 = {Drag = 8, LightEmission = 0.2}
    tbl_9.Texture = tbl_upv_2.spark
    local v10, v12 = Color3.fromRGB(240, 232, 214)
    tbl_9.Color = ColorSequence.new(v10, v12 or v10)
    tbl_9.Orientation = Enum.ParticleOrientation.VelocityParallel
    tbl_9.Speed = NumberRange.new(2.5, 4)
    tbl_9.SpreadAngle = Vector2.new(4, 4)
    tbl_9.Size = seq(0, 0.012, 1, 0.002)
    tbl_9.Squash = seq(0, 2.5, 1, 1)
    tbl_9.Transparency = seq(0, 0.3, 1, 1)
    tbl_9.Lifetime = NumberRange.new(0.06, 0.1)
    tbl_9.Rotation = NumberRange.new(90)
    emitter(v5, "twang", tbl_9)
    local tbl_10 = {Acceleration = Vector3.new(0, -0.30000001192092896, 0), LightInfluence = 0.8, LightEmission = 0}
    tbl_10.Texture = tbl_upv_2.dust
    local v10, v13 = Color3.fromRGB(96, 90, 84)
    tbl_10.Color = ColorSequence.new(v10, v13 or v10)
    tbl_10.Speed = NumberRange.new(0.05, 0.2)
    tbl_10.SpreadAngle = Vector2.new(60, 60)
    tbl_10.Size = seq(0, 0.03, 1, 0.07)
    tbl_10.Transparency = seq(0, 0.3, 1, 1)
    tbl_10.Lifetime = NumberRange.new(0.25, 0.45)
    tbl_10.Rotation = NumberRange.new(0, 360)
    emitter(v5, "powder", tbl_10)
    local tbl_11 = {Acceleration = Vector3.new(0, 0.15000000596046448, 0), LightInfluence = 0.8, LightEmission = 0}
    tbl_11.Texture = tbl_upv_2.dust
    local v10, v14 = Color3.fromRGB(190, 184, 176)
    tbl_11.Color = ColorSequence.new(v10, v14 or v10)
    tbl_11.Speed = NumberRange.new(0.1, 0.3)
    tbl_11.SpreadAngle = Vector2.new(40, 40)
    tbl_11.Size = seq(0, 0.05, 1, 0.12)
    tbl_11.Transparency = seq(0, 0.4, 1, 1)
    tbl_11.Lifetime = NumberRange.new(0.3, 0.5)
    tbl_11.Rotation = NumberRange.new(0, 360)
    emitter(v5, "puff", tbl_11)
    local v15 = Color3.fromRGB(255, 150, 60)
    emitter(v5, "pan", {ZOffset = 0.2, Texture = tbl_upv_2.flash, Color = ColorSequence.new(v15, Color3.fromRGB(200, 80, 30) or v15), Size = seq(0, 0.035, 0.5, 0.04, 1, 0.02), Transparency = seq(0, 0.1, 0.6, 0.4, 1, 1), Lifetime = NumberRange.new(0.05, 0.06), Rotation = NumberRange.new(0, 360)})
    local tbl_12 = {LightEmission = 0.4, ZOffset = 0.2}
    tbl_12.Texture = tbl_upv_2.star
    local v15, v16 = Color3.fromRGB(255, 200, 130)
    tbl_12.Color = ColorSequence.new(v15, v16 or v15)
    tbl_12.Size = seq(0, 0.03, 0.3, 0.05, 1, 0)
    tbl_12.Transparency = seq(0, 0.2, 1, 1)
    tbl_12.Lifetime = NumberRange.new(0.12, 0.16)
    tbl_12.Rotation = NumberRange.new(0, 45)
    emitter(v5, "glint", tbl_12)
    local tbl_13 = {LightEmission = 0.4, ZOffset = 0.2}
    tbl_13.Texture = tbl_upv_2.star
    local v15, v17 = Color3.fromRGB(255, 214, 160)
    tbl_13.Color = ColorSequence.new(v15, v17 or v15)
    tbl_13.Size = seq(0, 0.05, 0.25, 0.09, 1, 0)
    tbl_13.Transparency = seq(0, 0.05, 0.7, 0.35, 1, 1)
    tbl_13.Lifetime = NumberRange.new(0.06, 0.07)
    tbl_13.Rotation = NumberRange.new(0, 45)
    emitter(v5, "flare", tbl_13)
    local v18 = Color3.fromRGB(150, 215, 140)
    emitter(v5, "sparkle", {Acceleration = Vector3.new(0, 0.5, 0), Drag = 2, LightEmission = 0.25, Texture = tbl_upv_2.star, Color = ColorSequence.new(v18, Color3.fromRGB(95, 175, 105) or v18), Speed = NumberRange.new(0.15, 0.45), SpreadAngle = Vector2.new(70, 70), Size = seq(0, 0, 0.2, 0.03, 1, 0), Transparency = seq(0, 0.1, 1, 1), Lifetime = NumberRange.new(0.2, 0.3), Rotation = NumberRange.new(0, 90), RotSpeed = NumberRange.new(-90, 90)})
    local v19 = Color3.fromRGB(236, 190, 90)
    emitter(v5, "gold", {LightEmission = 0.3, Texture = tbl_upv_2.star, Color = ColorSequence.new(v19, Color3.fromRGB(205, 140, 45) or v19), Speed = NumberRange.new(0), Size = seq(0, 0, 0.3, 0.04, 1, 0), Transparency = seq(0, 0.1, 1, 1), Lifetime = NumberRange.new(0.07, 0.1), Rotation = NumberRange.new(0, 90)})
    local tbl_14 = {Acceleration = Vector3.new(0, -3, 0), LightInfluence = 0.6, LightEmission = 0}
    tbl_14.Texture = tbl_upv_2.glow
    local v19, v20 = Color3.fromRGB(236, 220, 170)
    tbl_14.Color = ColorSequence.new(v19, v20 or v19)
    tbl_14.Speed = NumberRange.new(0.25, 0.6)
    tbl_14.SpreadAngle = Vector2.new(50, 50)
    tbl_14.Size = seq(0, 0.008, 1, 0.006)
    tbl_14.Transparency = seq(0, 0, 0.7, 0.2, 1, 1)
    tbl_14.Lifetime = NumberRange.new(0.25, 0.4)
    emitter(v5, "crumbs", tbl_14)
    local tbl_15 = {LightEmission = 0.1, ZOffset = 0.1}
    tbl_15.Texture = tbl_upv_2.ring
    local v19, v21 = Color3.fromRGB(255, 200, 120)
    tbl_15.Color = ColorSequence.new(v19, v21 or v19)
    tbl_15.Size = seq(0, 0.03, 1, 0.22)
    tbl_15.Transparency = seq(0, 0.6, 1, 1)
    tbl_15.Lifetime = NumberRange.new(0.4, 0.45)
    emitter(v5, "ring", tbl_15)
    local tbl_16 = {Acceleration = Vector3.new(0, 0.10000000149011612, 0), LightInfluence = 0.8, LightEmission = 0}
    tbl_16.Texture = tbl_upv_2.dust
    local v19, v22 = Color3.fromRGB(176, 160, 136)
    tbl_16.Color = ColorSequence.new(v19, v22 or v19)
    tbl_16.Speed = NumberRange.new(0.1, 0.35)
    tbl_16.SpreadAngle = Vector2.new(70, 70)
    tbl_16.Size = seq(0, 0.03, 1, 0.1)
    tbl_16.Transparency = seq(0, 0.45, 1, 1)
    tbl_16.Lifetime = NumberRange.new(0.35, 0.6)
    tbl_16.Rotation = NumberRange.new(0, 360)
    emitter(v5, "dust", tbl_16)
    local v23 = Color3.fromRGB(255, 214, 140)
    emitter(v5, "block_spark", {Acceleration = Vector3.new(0, -4, 0), Drag = 7, Texture = tbl_upv_2.spark, Color = ColorSequence.new(v23, u11 or v23), Orientation = Enum.ParticleOrientation.VelocityParallel, Speed = NumberRange.new(0.8, 2), SpreadAngle = Vector2.new(180, 180), Size = seq(0, 0.012, 1, 0.003), Squash = seq(0, 2, 1, 1), Transparency = seq(0, 0.1, 1, 1), Lifetime = NumberRange.new(0.12, 0.26), Rotation = NumberRange.new(90)})
    local tbl_17 = {Acceleration = Vector3.new(0, -2, 0), LightInfluence = 0.8, LightEmission = 0}
    tbl_17.Texture = tbl_upv_2.dust
    local v23, v24 = Color3.fromRGB(150, 116, 80)
    tbl_17.Color = ColorSequence.new(v23, v24 or v23)
    tbl_17.Speed = NumberRange.new(0.4, 1)
    tbl_17.SpreadAngle = Vector2.new(70, 70)
    tbl_17.Size = seq(0, 0.015, 1, 0.04)
    tbl_17.Transparency = seq(0, 0.3, 1, 1)
    tbl_17.Lifetime = NumberRange.new(0.2, 0.35)
    tbl_17.Rotation = NumberRange.new(0, 360)
    emitter(v5, "wood_hit", tbl_17)
    local v25 = Color3.fromRGB(255, 190, 90)
    emitter(v5, "embers", {Acceleration = Vector3.new(0, 0.6000000238418579, 0), Rate = 40, LightEmission = 0.35, Texture = tbl_upv_2.ember, Color = ColorSequence.new(v25, Color3.fromRGB(240, 90, 40) or v25), Speed = NumberRange.new(0.05, 0.15), SpreadAngle = Vector2.new(25, 25), Size = seq(0, 0.02, 0.4, 0.028, 1, 0), Transparency = seq(0, 0.25, 1, 1), Lifetime = NumberRange.new(0.18, 0.3), Rotation = NumberRange.new(-15, 15)})
    local v26 = Color3.fromRGB(255, 170, 70)
    emitter(v5, "flame", {Acceleration = Vector3.new(0, 0.5, 0), Rate = 22, LightEmission = 0.35, Texture = tbl_upv_2.side, Color = ColorSequence.new(v26, Color3.fromRGB(220, 80, 30) or v26), Speed = NumberRange.new(0.1, 0.2), SpreadAngle = Vector2.new(10, 10), Size = seq(0, 0.09, 0.5, 0.07, 1, 0.02), Transparency = seq(0, 0.2, 1, 1), Lifetime = NumberRange.new(0.15, 0.24), Rotation = NumberRange.new(-90)})
    local v27 = Color3.fromRGB(255, 190, 110)
    emitter(v5, "fuse", {Acceleration = Vector3.new(0, -0.4000000059604645, 0), Rate = 18, LightEmission = 0.3, Texture = tbl_upv_2.spark, Color = ColorSequence.new(v27, Color3.fromRGB(235, 120, 50) or v27), Speed = NumberRange.new(0.15, 0.35), SpreadAngle = Vector2.new(60, 60), Size = seq(0, 0.012, 1, 0), Transparency = seq(0, 0.2, 1, 1), Lifetime = NumberRange.new(0.15, 0.25), Rotation = NumberRange.new(0, 360)})
    local tbl_18 = {LightEmission = 0.1, ZOffset = 0.1}
    tbl_18.Texture = tbl_upv_2.ring
    local v27, v28 = Color3.fromRGB(214, 204, 186)
    tbl_18.Color = ColorSequence.new(v27, v28 or v27)
    tbl_18.Size = seq(0, 0.03, 1, 0.08)
    tbl_18.Transparency = seq(0, 0.35, 1, 1)
    tbl_18.Lifetime = NumberRange.new(0.1, 0.12)
    emitter(v5, "puncture", tbl_18)
    local tbl_19 = {Drag = 8, LightEmission = 0.15}
    tbl_19.Texture = tbl_upv_2.spark
    local v27, v29 = Color3.fromRGB(230, 214, 180)
    tbl_19.Color = ColorSequence.new(v27, v29 or v27)
    tbl_19.Orientation = Enum.ParticleOrientation.VelocityParallel
    tbl_19.Speed = NumberRange.new(1.5, 2.5)
    tbl_19.SpreadAngle = Vector2.new(25, 25)
    tbl_19.Size = seq(0, 0.006, 1, 0.002)
    tbl_19.Squash = seq(0, 3, 1, 1)
    tbl_19.Transparency = seq(0, 0.3, 1, 1)
    tbl_19.Lifetime = NumberRange.new(0.06, 0.09)
    emitter(v5, "puncture_lines", tbl_19)
    local v30 = Instance.new("Attachment")
    v30.Name = "streak0"
    v30.Parent = v5
    local v31 = Instance.new("Attachment")
    v31.Name = "streak1"
    v31.Parent = v5
    local v32 = Instance.new("Beam")
    v32.Attachment0 = v30
    v32.Attachment1 = v31
    v32.FaceCamera = true
    v32.Segments = 1
    v32.Width0 = 0.004
    v32.Width1 = 0.02
    v32.LightEmission = 0.15
    v32.LightInfluence = 0.4
    v32.Color = ColorSequence.new(Color3.fromRGB(176, 166, 150))
    v32.Transparency = NumberSequence.new(1, 0.4)
    v32.Enabled = false
    v32.Parent = v5
    tbl_upv_5 = {a0 = v30, a1 = v31, beam = v32}
    local v33 = Instance.new("Attachment")
    v33.Name = "light"
    v33.Parent = v6
    u4 = v33
    local v34 = Instance.new("PointLight")
    v34.Brightness = 1
    v34.Range = 9
    v34.Color = Color3.fromRGB(255, 170, 90)
    v34.Shadows = false
    v34.Enabled = false
    v34.Parent = v33
    u3 = v34
    return v5
end
local function ensure(a1, a2)
    --[[
      name: ensure
      line: 305
      upvalues:
        u1 (ref,  index: 1)
        build (copy, index: 2)
        u2 (ref,  index: 3)
    ]]
    local v35 = u1 or (build())
    u1 = v35
    v35.CFrame = a2
    if v35.Parent ~= a1 then
        v35.Parent = a1
    end
    if u2 and u2.Parent ~= a1 then
        u2.Parent = a1
    end
    return v35
end
local function emit(a1, a2, a3)
    --[[
      name: emit
      line: 319
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v36 = tbl_upv_4[a1]
    if not v36 then
        return
    end
    v36.att.CFrame = a2
    v36.e:Emit(a3)
end
function tbl_1.Preload()
    --[[
      name: Preload
      line: 329
      upvalues:
        u1 (ref,  index: 1)
        build (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
    ]]
    local v37 = u1 or (build())
    u1 = v37
    task.spawn(
        function()
            --[[
              line: 332
              upvalues:
                tbl_upv_4 (copy, index: 1)
            ]]
            local tbl_upv_20 = {}
            for _, value_3 in tbl_upv_4 do
                table.insert(tbl_upv_20, value_3.e)
            end
            pcall(
                function()
                    --[[
                      line: 337
                      upvalues:
                        tbl_upv_20 (copy, index: 1)
                    ]]
                    game:GetService("ContentProvider"):PreloadAsync(tbl_upv_20)
                end
            )
        end
    )
end
function tbl_1.Follow(a1, a2)
    --[[
      name: Follow
      line: 343
      upvalues:
        u9 (ref,  index: 1)
        u1 (ref,  index: 2)
        build (copy, index: 3)
        u2 (ref,  index: 4)
        u3 (ref,  index: 5)
        u5 (ref,  index: 6)
        tbl_upv_4 (copy, index: 7)
        u6 (ref,  index: 8)
    ]]
    u9 = os.clock()
    if not u1 then
        return
    end
    local v38 = u1 or (build())
    u1 = v38
    v38.CFrame = a2
    if v38.Parent ~= a1 then
        v38.Parent = a1
    end
    if u2 and u2.Parent ~= a1 then
        u2.Parent = a1
    end
    if u3 and u3.Enabled and u5 <= u9 then
        u3.Enabled = false
    end
    local wisp_1 = tbl_upv_4.wisp
    if not wisp_1 then
        return
    end
    if wisp_1.e.Enabled and (u6 <= u9) then
        wisp_1.e.Enabled = false
    end
end
local function along(a1)
    --[[
      name: along
      line: 359
    ]]
    local LookVector_1 = a1.LookVector
    local RightVector_1 = a1.RightVector
    return CFrame.fromMatrix(a1.Position, RightVector_1, LookVector_1, RightVector_1:Cross(LookVector_1))
end
local tbl_upv_21 = {}
tbl_upv_21.musket = {wisp = 1.1, sparks = 8, squash = 2.4, smoke = 4, tongue = 0.17, spread = 10, flash = 0.09}
tbl_upv_21.blunderbuss = {sparkSquash = 3, sparks = 20, tongue = 0.08, flash = 0.075, sparkMax = 6, sparkSize = 0.03, sparkAt = 0.05, squash = 0.6, sparkMin = 3, wisp = 1.2, spread = 28, smoke = 6}
tbl_upv_21.pistol = {wisp = 0.7, sparks = 6, squash = 0.8, smoke = 2, tongue = 0.09, spread = 14, flash = 0.085}
function tbl_1.Play(a1, a2, a3)
    --[[
      name: Play
      line: 376
      upvalues:
        u1 (ref,  index: 1)
        build (copy, index: 2)
        u2 (ref,  index: 3)
        tbl_upv_21 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        seq (copy, index: 6)
        u6 (ref,  index: 7)
        u3 (ref,  index: 8)
        u4 (ref,  index: 9)
        u5 (ref,  index: 10)
        u7 (ref,  index: 11)
        u8 (ref,  index: 12)
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    local CFrame_1 = CurrentCamera_1.CFrame
    local v39 = u1 or (build())
    u1 = v39
    v39.CFrame = CFrame_1
    if v39.Parent ~= CurrentCamera_1 then
        v39.Parent = CurrentCamera_1
    end
    if u2 and u2.Parent ~= CurrentCamera_1 then
        u2.Parent = CurrentCamera_1
    end
    local v40 = a3 or {}
    local LookVector_2 = a2.LookVector
    local RightVector_2 = a2.RightVector
    local v41 = CFrame.fromMatrix(a2.Position, RightVector_2, LookVector_2, RightVector_2:Cross(LookVector_2))
    local v42, v43, v44, v45, v46, v47 = nil, nil, nil, nil, nil, nil
    if a1 ~= "muzzle" then
        local v48, v49 = nil, nil
        if a1 ~= "pan" then
            local v50 = nil
            if a1 ~= "twang" then
                local v51 = nil
                if a1 ~= "powder" then
                    local v52, v53 = nil, nil
                    if a1 == "puff" then
                        v53 = tbl_upv_4.puff
                        if v53 then
                            v53.att.CFrame = v41
                            v53.e:Emit(3)
                        end
                    elseif a1 ~= "click" and a1 ~= "glint" and a1 ~= "bolt" then
                        local v54, v55 = nil, nil
                        if a1 ~= "flare" then
                            local v56 = nil
                            if a1 ~= "sparkle" then
                                local v57 = nil
                                if a1 ~= "gold" then
                                    local v58 = nil
                                    if a1 ~= "crumbs" then
                                        local v59 = nil
                                        if a1 ~= "ring" then
                                            local v60 = nil
                                            if a1 ~= "dust" then
                                                local v61, v62 = nil, nil
                                                if a1 ~= "puncture" then
                                                    local v63, v64 = nil, nil
                                                    if a1 ~= "block_spark" then
                                                        local v65 = nil
                                                        if a1 ~= "wood_hit" then
                                                            local v66 = nil
                                                            if a1 == "embers" then
                                                                for _, value_4 in {"embers", "flame"} do
                                                                    local v67 = tbl_upv_4[value_4]
                                                                    if v67 then
                                                                        v67.att.CFrame = v41
                                                                        v67.e.Enabled = v40.on ~= false
                                                                    end
                                                                end
                                                                u7 = v40.on ~= false
                                                            elseif a1 == "fuse" then
                                                                v66 = tbl_upv_4.fuse
                                                                if not v66 then
                                                                    return
                                                                end
                                                                v66.att.CFrame = v41
                                                                v66.e.Enabled = v40.on ~= false
                                                                v66.e.Rate = v40.rate or 18
                                                                u8 = v40.on ~= false
                                                            end
                                                        else
                                                            v65 = tbl_upv_4.wood_hit
                                                            if v65 then
                                                                v65.att.CFrame = v41
                                                                v65.e:Emit(8)
                                                            end
                                                        end
                                                    else
                                                        v63 = tbl_upv_4.block_spark
                                                        if v63 then
                                                            v63.att.CFrame = v41
                                                            v63.e:Emit(16)
                                                        end
                                                        v64 = tbl_upv_4.glint
                                                        if v64 then
                                                            v64.att.CFrame = v41
                                                            v64.e:Emit(1)
                                                        end
                                                    end
                                                else
                                                    v61 = tbl_upv_4.puncture
                                                    if v61 then
                                                        v61.att.CFrame = v41
                                                        v61.e:Emit(1)
                                                    end
                                                    v62 = tbl_upv_4.puncture_lines
                                                    if v62 then
                                                        v62.att.CFrame = v41
                                                        v62.e:Emit(6)
                                                    end
                                                end
                                            else
                                                v60 = tbl_upv_4.dust
                                                if v60 then
                                                    v60.att.CFrame = v41
                                                    v60.e:Emit(5)
                                                end
                                            end
                                        else
                                            v59 = tbl_upv_4.ring
                                            if v59 then
                                                v59.att.CFrame = a2
                                                v59.e:Emit(1)
                                            end
                                        end
                                    else
                                        v58 = tbl_upv_4.crumbs
                                        if v58 then
                                            v58.att.CFrame = v41
                                            v58.e:Emit(5)
                                        end
                                    end
                                else
                                    v57 = tbl_upv_4.gold
                                    if v57 then
                                        v57.att.CFrame = v41
                                        v57.e:Emit(2)
                                    end
                                end
                            else
                                v56 = tbl_upv_4.sparkle
                                if v56 then
                                    v56.att.CFrame = v41
                                    v56.e:Emit(6)
                                end
                            end
                        else
                            v54 = tbl_upv_4.flare
                            if v54 then
                                v54.att.CFrame = v41
                                v54.e:Emit(1)
                            end
                            v55 = tbl_upv_4.glint
                            if v55 then
                                v55.att.CFrame = v41
                                v55.e:Emit(1)
                            end
                        end
                    else
                        v52 = tbl_upv_4.glint
                        if v52 then
                            v52.att.CFrame = v41
                            v52.e:Emit(1)
                        end
                    end
                else
                    v51 = tbl_upv_4.powder
                    if v51 then
                        v51.att.CFrame = v41
                        v51.e:Emit(6)
                    end
                end
            else
                v50 = tbl_upv_4.twang
                if v50 then
                    v50.att.CFrame = v41
                    v50.e:Emit(4)
                end
            end
        else
            v48 = tbl_upv_4.pan
            if v48 then
                v48.att.CFrame = v41
                v48.e:Emit(1)
            end
            v49 = tbl_upv_4.puff
            if v49 then
                v49.att.CFrame = v41
                v49.e:Emit(2)
            end
        end
    else
        local v68 = tbl_upv_21[v40.style or "musket"] or (tbl_upv_21.musket)
        v42 = tbl_upv_4.flash
        local tongue_1 = tbl_upv_4.tongue
        local sparks_1 = tbl_upv_4.sparks
        if v42 then
            v42.e.Size = seq(0, v68.flash, 0.4, v68.flash * 1.08, 1, v68.flash * 0.5)
        end
        if tongue_1 then
            tongue_1.e.Size = seq(0, v68.tongue, 0.5, v68.tongue * 1.1, 1, v68.tongue * 0.6)
            tongue_1.e.Squash = seq(0, v68.squash, 1, v68.squash * 0.7)
        end
        if sparks_1 then
            sparks_1.e.SpreadAngle = Vector2.new(v68.spread, v68.spread)
            sparks_1.e.Size = seq(0, v68.sparkSize or 0.016, 1, (v68.sparkSize or 0.016) * 0.27)
            sparks_1.e.Squash = seq(0, v68.sparkSquash or 2, 1, (v68.sparkSquash or 2) * 0.5)
            sparks_1.e.Speed = NumberRange.new(v68.sparkMin or 2.2, v68.sparkMax or 4.5)
        end
        if u2 then
            u2.CFrame = CurrentCamera_1.CFrame * v41
        end
        local v69 = CFrame.new(0, v68.flash * 0.3, 0)
        v43 = tbl_upv_4.flash
        if v43 then
            v43.att.CFrame = v69
            v43.e:Emit(1)
        end
        local v70 = CFrame.new(0, (v68.tongue * v68.squash) * 0.5, 0)
        v44 = tbl_upv_4.tongue
        if v44 then
            v44.att.CFrame = v70
            v44.e:Emit(2)
        end
        local v71 = CFrame.new(0, v68.sparkAt or 0.03, 0)
        local sparks_2 = v68.sparks
        v45 = tbl_upv_4.sparks
        if v45 then
            v45.att.CFrame = v71
            v45.e:Emit(sparks_2)
        end
        local smoke_1 = v68.smoke
        v46 = tbl_upv_4.smoke
        if v46 then
            v46.att.CFrame = v41 + (a2.LookVector * 0.03)
            v46.e:Emit(smoke_1)
        end
        v47 = tbl_upv_4.wisp
        if v47 then
            v47.att.CFrame = v41
            v47.e.Enabled = true
            local v72 = os.clock()
            u6 = v72 + v68.wisp
        end
        if u3 and u4 then
            u4.CFrame = CFrame.identity
            u3.Enabled = true
            u5 = os.clock() + 0.05
        end
    end
end
function tbl_1.Streak(a1, a2, a3, a4)
    --[[
      name: Streak
      line: 476
      upvalues:
        tbl_upv_5 (ref,  index: 1)
        u1 (ref,  index: 2)
        build (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if not tbl_upv_5 then
        return
    end
    if a1 and a2 and not ((a2 - a1).Magnitude < 0.004) then
        local CurrentCamera_2 = workspace.CurrentCamera
        if CurrentCamera_2 then
            local CFrame_2 = CurrentCamera_2.CFrame
            local v73 = u1 or (build())
            u1 = v73
            v73.CFrame = CFrame_2
            if v73.Parent ~= CurrentCamera_2 then
                v73.Parent = CurrentCamera_2
            end
            if u2 and u2.Parent ~= CurrentCamera_2 then
                u2.Parent = CurrentCamera_2
            end
        end
        tbl_upv_5.a0.Position = a1
        tbl_upv_5.a1.Position = a2
        local v74 = a4 or 0.02
        if tbl_upv_5.beam.Width1 ~= v74 then
            tbl_upv_5.beam.Width1 = v74
            local beam_1 = tbl_upv_5.beam
            beam_1.Width0 = (a4 and (v74 * 0.2)) or 0.004
        end
        tbl_upv_5.beam.Transparency = NumberSequence.new(1, 1 - (math.clamp(a3 or 1, 0, 1) * 0.75))
        tbl_upv_5.beam.Enabled = true
        return
    end
    tbl_upv_5.beam.Enabled = false
end
function tbl_1.Track(a1, a2)
    --[[
      name: Track
      line: 501
      upvalues:
        u2 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        u7 (ref,  index: 3)
        u8 (ref,  index: 4)
    ]]
    local v75, v76 = nil, nil
    if a1 == "muzzle" then
        local CurrentCamera_3 = workspace.CurrentCamera
        if u2 and CurrentCamera_3 then
            local LookVector_3 = a2.LookVector
            local RightVector_3 = a2.RightVector
            u2.CFrame = CurrentCamera_3.CFrame * CFrame.fromMatrix(a2.Position, RightVector_3, LookVector_3, RightVector_3:Cross(LookVector_3))
        end
        v76 = tbl_upv_4.wisp
        if not v76 or not v76.e.Enabled then
            return
        end
        local LookVector_4 = a2.LookVector
        local RightVector_4 = a2.RightVector
        v76.att.CFrame = CFrame.fromMatrix(a2.Position, RightVector_4, LookVector_4, RightVector_4:Cross(LookVector_4))
    elseif a1 == "embers" and u7 then
        for _, value_5 in {"embers", "flame"} do
            local v77 = tbl_upv_4[value_5]
            if v77 then
                local LookVector_5 = a2.LookVector
                local RightVector_5 = a2.RightVector
                v77.att.CFrame = CFrame.fromMatrix(a2.Position, RightVector_5, LookVector_5, RightVector_5:Cross(LookVector_5))
            end
        end
    elseif a1 == "fuse" and u8 then
        v75 = tbl_upv_4.fuse
        if v75 then
            local LookVector_6 = a2.LookVector
            local RightVector_6 = a2.RightVector
            v75.att.CFrame = CFrame.fromMatrix(a2.Position, RightVector_6, LookVector_6, RightVector_6:Cross(LookVector_6))
        end
    end
end
function tbl_1.Freeze(a1)
    --[[
      name: Freeze
      line: 529
      upvalues:
        u10 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    u10 = a1
    for _, value_6 in tbl_upv_4 do
        value_6.e.TimeScale = (a1 and 0.01) or 1
    end
end
function tbl_1.Hide()
    --[[
      name: Hide
      line: 536
      upvalues:
        tbl_upv_4 (copy, index: 1)
        u7 (ref,  index: 2)
        u8 (ref,  index: 3)
        u3 (ref,  index: 4)
        tbl_upv_5 (ref,  index: 5)
    ]]
    for _, value_7 in tbl_upv_4 do
        value_7.e.Enabled = false
        value_7.e:Clear()
    end
    u7 = false
    u8 = false
    if u3 then
        u3.Enabled = false
    end
    if not tbl_upv_5 then
        return
    end
    tbl_upv_5.beam.Enabled = false
end
return tbl_1