local v1 = {}
local texts = {flash = "rbxassetid://132385497945381", side = "rbxassetid://133080098550406", smoke = "rbxassetid://136705730872514", spark = "rbxassetid://106505437894279", star = "rbxassetid://121298090783218", ring = "rbxassetid://99127423363509", glow = "rbxassetid://120877893267841", dust = "rbxassetid://131207259844964", swoosh = "rbxassetid://91777724554771", ember = "rbxassetid://112265693545203"}
local v3 = {flash = true, smoke = true, dust = true}
v1.TEX = texts
local part = nil
local part2 = nil
local v6 = {}
local pointLight = nil
local attachment = nil
local v9 = 0
local v10 = 0
local on = false
local on2 = false
local v13 = nil
local timestamp = 0
local v15 = false

local function seq(...)
    --[[
      name: seq
      line: 50
    ]]
    local v17 = {...}
    local v18 = {}

    for index = 1, #v17, 2 do
        table.insert(v18, NumberSequenceKeypoint.new(v17[index], v17[index + 1]))
    end

    return NumberSequence.new(v18)
end

local function colors(a21, a22)
    --[[
      name: colors
      line: 59
    ]]
    return ColorSequence.new(a21, a22 or a21)
end

local function newPart(name: string)
    --[[
      name: newPart
      line: 63
    ]]
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Transparency = 1
    part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    return part
end

local function emitter(parent: Part, name: string, properties)
    --[[
      name: emitter
      line: 76
      upvalues:
        texts (copy, index: 1)
        v3 (copy, index: 2)
        v15 (ref,  index: 3)
        v6 (copy, index: 4)
    ]]
    local attachment = Instance.new("Attachment")
    attachment.Name = name
    attachment.Parent = parent

    local e = Instance.new("ParticleEmitter")
    e.Name = name
    e.Enabled = false
    e.LockedToPart = true
    e.LightInfluence = 0
    e.LightEmission = 0.4
    e.Speed = NumberRange.new(0)
    e.Rate = 0

    for v32, v33 in properties do
        e[v32] = v33
    end

    local texture = properties.Texture

    if type(texture) == "string" then
        for v35, text in texts do
            if text == texture then
                if v3[v35] and not string.find(text, "rbxasset://", 1, true) then
                    e.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid2x2
                    e.FlipbookMode = Enum.ParticleFlipbookMode.Random
                end
            end
        end
    end

    e.Parent = attachment

    if v15 then
        e.TimeScale = 0.01
    end

    local v37 = {att = attachment, e = e}
    v6[name] = v37

    return v37
end

Color3.fromRGB(255, 196, 120)
local color3 = Color3.fromRGB(255, 150, 70)

local function build()
    --[[
      name: build
      line: 112
      upvalues:
        part2 (ref,  index: 1)
        emitter (copy, index: 2)
        texts (copy, index: 3)
        seq (copy, index: 4)
        color3 (copy, index: 5)
        v13 (ref,  index: 6)
        attachment (ref,  index: 7)
        pointLight (ref,  index: 8)
    ]]
    local tribesViewFx = Instance.new("Part")
    tribesViewFx.Name = "TribesViewFx"
    tribesViewFx.Anchored = true
    tribesViewFx.CanCollide = false
    tribesViewFx.CanQuery = false
    tribesViewFx.CanTouch = false
    tribesViewFx.CastShadow = false
    tribesViewFx.Transparency = 1
    tribesViewFx.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)

    local tribesViewMuzzle = Instance.new("Part")
    tribesViewMuzzle.Name = "TribesViewMuzzle"
    tribesViewMuzzle.Anchored = true
    tribesViewMuzzle.CanCollide = false
    tribesViewMuzzle.CanQuery = false
    tribesViewMuzzle.CanTouch = false
    tribesViewMuzzle.CastShadow = false
    tribesViewMuzzle.Transparency = 1
    tribesViewMuzzle.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    part2 = tribesViewMuzzle
    local properties = {LightEmission = 0.28, ZOffset = 0.3, Texture = texts.flash}
    local color32 = Color3.fromRGB(255, 186, 92)
    local color33 = Color3.fromRGB(214, 96, 36)
    properties.Color = ColorSequence.new(color32, color33 or color32)
    properties.Size = seq(0, 0.07, 0.35, 0.14, 1, 0.1)
    properties.Transparency = seq(0, 0.05, 0.6, 0.35, 1, 1)
    properties.Lifetime = NumberRange.new(0.05, 0.065)
    properties.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewMuzzle, "flash", properties)
    local properties2 = {ZOffset = 0.25, Texture = texts.side}
    local color34 = Color3.fromRGB(255, 170, 80)
    local color35 = Color3.fromRGB(200, 80, 30)
    properties2.Color = ColorSequence.new(color34, color35 or color34)
    properties2.Orientation = Enum.ParticleOrientation.VelocityParallel
    properties2.Speed = NumberRange.new(0.6)
    properties2.Size = seq(0, 0.05, 0.4, 0.1, 1, 0.07)
    properties2.Squash = seq(0, 1.2, 1, 1)
    properties2.Transparency = seq(0, 0.1, 0.6, 0.4, 1, 1)
    properties2.Lifetime = NumberRange.new(0.045, 0.06)
    properties2.Rotation = NumberRange.new(90)
    emitter(tribesViewMuzzle, "tongue", properties2)
    local properties3 = {Drag = 6, Acceleration = Vector3.new(0, -1.5, 0), ZOffset = 0.2, Texture = texts.spark}
    local color36 = Color3.fromRGB(255, 210, 130)
    properties3.Color = ColorSequence.new(color36, color3 or color36)
    properties3.Orientation = Enum.ParticleOrientation.VelocityParallel
    properties3.Speed = NumberRange.new(2.2, 4.5)
    properties3.SpreadAngle = Vector2.new(14, 14)
    properties3.Size = seq(0, 0.016, 1, 0.004)
    properties3.Squash = seq(0, 2, 1, 1)
    properties3.Transparency = seq(0, 0.05, 1, 1)
    properties3.Lifetime = NumberRange.new(0.08, 0.2)
    properties3.Rotation = NumberRange.new(90)
    emitter(tribesViewMuzzle, "sparks", properties3)
    local properties4 = {LightEmission = 0, LightInfluence = 0.6, Drag = 2.6, Acceleration = Vector3.new(0, 0.11999999731779099, 0), ZOffset = 0.1, Texture = texts.smoke}
    local color37 = Color3.fromRGB(150, 146, 140)
    local color38 = Color3.fromRGB(122, 118, 114)
    properties4.Color = ColorSequence.new(color37, color38 or color37)
    properties4.Speed = NumberRange.new(0.35, 0.8)
    properties4.SpreadAngle = Vector2.new(18, 18)
    properties4.Size = seq(0, 0.05, 0.3, 0.14, 1, 0.26)
    properties4.Transparency = seq(0, 0.45, 0.25, 0.55, 1, 1)
    properties4.Lifetime = NumberRange.new(0.6, 1)
    properties4.Rotation = NumberRange.new(0, 360)
    properties4.RotSpeed = NumberRange.new(-50, 50)
    emitter(tribesViewFx, "smoke", properties4)
    local properties5 = {LightEmission = 0, LightInfluence = 0.6, Acceleration = Vector3.new(0, 0.2199999988079071, 0), Drag = 1, Rate = 22, Texture = texts.smoke}
    color37, color38 = Color3.fromRGB(150, 146, 140)
    properties5.Color = ColorSequence.new(color37, color38 or color37)
    properties5.Speed = NumberRange.new(0.05, 0.12)
    properties5.Size = seq(0, 0.02, 1, 0.09)
    properties5.Transparency = seq(0, 0.55, 0.4, 0.7, 1, 1)
    properties5.Lifetime = NumberRange.new(0.5, 0.9)
    properties5.Rotation = NumberRange.new(0, 360)
    properties5.RotSpeed = NumberRange.new(-40, 40)
    emitter(tribesViewFx, "wisp", properties5)
    local properties6 = {LightEmission = 0.2, Drag = 8, Texture = texts.spark}
    color37, color38 = Color3.fromRGB(240, 232, 214)
    properties6.Color = ColorSequence.new(color37, color38 or color37)
    properties6.Orientation = Enum.ParticleOrientation.VelocityParallel
    properties6.Speed = NumberRange.new(2.5, 4)
    properties6.SpreadAngle = Vector2.new(4, 4)
    properties6.Size = seq(0, 0.012, 1, 0.002)
    properties6.Squash = seq(0, 2.5, 1, 1)
    properties6.Transparency = seq(0, 0.3, 1, 1)
    properties6.Lifetime = NumberRange.new(0.06, 0.1)
    properties6.Rotation = NumberRange.new(90)
    emitter(tribesViewFx, "twang", properties6)
    local properties7 = {LightEmission = 0.1, ZOffset = 0.1, Texture = texts.ring}
    color37, color38 = Color3.fromRGB(236, 226, 206)
    properties7.Color = ColorSequence.new(color37, color38 or color37)
    properties7.Size = seq(0, 0.025, 1, 0.16)
    properties7.Transparency = seq(0, 0.45, 1, 1)
    properties7.Lifetime = NumberRange.new(0.12, 0.14)
    emitter(tribesViewFx, "snap", properties7)
    local properties8 = {LightEmission = 0, LightInfluence = 0.8, Acceleration = Vector3.new(0, -0.30000001192092896, 0), Texture = texts.dust}
    color37, color38 = Color3.fromRGB(96, 90, 84)
    properties8.Color = ColorSequence.new(color37, color38 or color37)
    properties8.Speed = NumberRange.new(0.05, 0.2)
    properties8.SpreadAngle = Vector2.new(60, 60)
    properties8.Size = seq(0, 0.03, 1, 0.07)
    properties8.Transparency = seq(0, 0.3, 1, 1)
    properties8.Lifetime = NumberRange.new(0.25, 0.45)
    properties8.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "powder", properties8)
    local properties9 = {LightEmission = 0, LightInfluence = 0.8, Acceleration = Vector3.new(0, 0.15000000596046448, 0), Texture = texts.dust}
    color37, color38 = Color3.fromRGB(190, 184, 176)
    properties9.Color = ColorSequence.new(color37, color38 or color37)
    properties9.Speed = NumberRange.new(0.1, 0.3)
    properties9.SpreadAngle = Vector2.new(40, 40)
    properties9.Size = seq(0, 0.05, 1, 0.12)
    properties9.Transparency = seq(0, 0.4, 1, 1)
    properties9.Lifetime = NumberRange.new(0.3, 0.5)
    properties9.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "puff", properties9)
    local properties10 = {ZOffset = 0.2, Texture = texts.flash}
    local color39 = Color3.fromRGB(255, 150, 60)
    local color310 = Color3.fromRGB(200, 80, 30)
    properties10.Color = ColorSequence.new(color39, color310 or color39)
    properties10.Size = seq(0, 0.035, 0.5, 0.04, 1, 0.02)
    properties10.Transparency = seq(0, 0.1, 0.6, 0.4, 1, 1)
    properties10.Lifetime = NumberRange.new(0.05, 0.06)
    properties10.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "pan", properties10)
    local properties11 = {LightEmission = 0.4, ZOffset = 0.2, Texture = texts.star}
    color39, color310 = Color3.fromRGB(255, 200, 130)
    properties11.Color = ColorSequence.new(color39, color310 or color39)
    properties11.Size = seq(0, 0.03, 0.3, 0.05, 1, 0)
    properties11.Transparency = seq(0, 0.2, 1, 1)
    properties11.Lifetime = NumberRange.new(0.12, 0.16)
    properties11.Rotation = NumberRange.new(0, 45)
    emitter(tribesViewFx, "glint", properties11)
    local properties12 = {LightEmission = 0.4, ZOffset = 0.2, Texture = texts.star}
    color39, color310 = Color3.fromRGB(255, 214, 160)
    properties12.Color = ColorSequence.new(color39, color310 or color39)
    properties12.Size = seq(0, 0.05, 0.25, 0.09, 1, 0)
    properties12.Transparency = seq(0, 0.05, 0.7, 0.35, 1, 1)
    properties12.Lifetime = NumberRange.new(0.06, 0.07)
    properties12.Rotation = NumberRange.new(0, 45)
    emitter(tribesViewFx, "flare", properties12)
    local properties13 = {LightEmission = 0.25, Acceleration = Vector3.new(0, 0.5, 0), Drag = 2, Texture = texts.star}
    local color311 = Color3.fromRGB(150, 215, 140)
    local color312 = Color3.fromRGB(95, 175, 105)
    properties13.Color = ColorSequence.new(color311, color312 or color311)
    properties13.Speed = NumberRange.new(0.15, 0.45)
    properties13.SpreadAngle = Vector2.new(70, 70)
    properties13.Size = seq(0, 0, 0.2, 0.03, 1, 0)
    properties13.Transparency = seq(0, 0.1, 1, 1)
    properties13.Lifetime = NumberRange.new(0.2, 0.3)
    properties13.Rotation = NumberRange.new(0, 90)
    properties13.RotSpeed = NumberRange.new(-90, 90)
    emitter(tribesViewFx, "sparkle", properties13)
    local properties14 = {LightEmission = 0.3, Texture = texts.star}
    local color313 = Color3.fromRGB(236, 190, 90)
    local color314 = Color3.fromRGB(205, 140, 45)
    properties14.Color = ColorSequence.new(color313, color314 or color313)
    properties14.Speed = NumberRange.new(0)
    properties14.Size = seq(0, 0, 0.3, 0.04, 1, 0)
    properties14.Transparency = seq(0, 0.1, 1, 1)
    properties14.Lifetime = NumberRange.new(0.07, 0.1)
    properties14.Rotation = NumberRange.new(0, 90)
    emitter(tribesViewFx, "gold", properties14)
    local properties15 = {LightEmission = 0, LightInfluence = 0.6, Acceleration = Vector3.new(0, -3, 0), Texture = texts.glow}
    color313, color314 = Color3.fromRGB(236, 220, 170)
    properties15.Color = ColorSequence.new(color313, color314 or color313)
    properties15.Speed = NumberRange.new(0.25, 0.6)
    properties15.SpreadAngle = Vector2.new(50, 50)
    properties15.Size = seq(0, 0.008, 1, 0.006)
    properties15.Transparency = seq(0, 0, 0.7, 0.2, 1, 1)
    properties15.Lifetime = NumberRange.new(0.25, 0.4)
    emitter(tribesViewFx, "crumbs", properties15)
    local properties16 = {LightEmission = 0.1, ZOffset = 0.1, Texture = texts.ring}
    color313, color314 = Color3.fromRGB(255, 200, 120)
    properties16.Color = ColorSequence.new(color313, color314 or color313)
    properties16.Size = seq(0, 0.03, 1, 0.22)
    properties16.Transparency = seq(0, 0.6, 1, 1)
    properties16.Lifetime = NumberRange.new(0.4, 0.45)
    emitter(tribesViewFx, "ring", properties16)
    local properties17 = {LightEmission = 0, LightInfluence = 0.8, Acceleration = Vector3.new(0, 0.10000000149011612, 0), Texture = texts.dust}
    color313, color314 = Color3.fromRGB(176, 160, 136)
    properties17.Color = ColorSequence.new(color313, color314 or color313)
    properties17.Speed = NumberRange.new(0.1, 0.35)
    properties17.SpreadAngle = Vector2.new(70, 70)
    properties17.Size = seq(0, 0.03, 1, 0.1)
    properties17.Transparency = seq(0, 0.45, 1, 1)
    properties17.Lifetime = NumberRange.new(0.35, 0.6)
    properties17.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "dust", properties17)
    local properties18 = {Drag = 7, Acceleration = Vector3.new(0, -4, 0), Texture = texts.spark}
    local color315 = Color3.fromRGB(255, 214, 140)
    properties18.Color = ColorSequence.new(color315, color3 or color315)
    properties18.Orientation = Enum.ParticleOrientation.VelocityParallel
    properties18.Speed = NumberRange.new(0.8, 2)
    properties18.SpreadAngle = Vector2.new(180, 180)
    properties18.Size = seq(0, 0.012, 1, 0.003)
    properties18.Squash = seq(0, 2, 1, 1)
    properties18.Transparency = seq(0, 0.1, 1, 1)
    properties18.Lifetime = NumberRange.new(0.12, 0.26)
    properties18.Rotation = NumberRange.new(90)
    emitter(tribesViewFx, "block_spark", properties18)
    local properties19 = {LightEmission = 0, LightInfluence = 0.8, Acceleration = Vector3.new(0, -2, 0), Texture = texts.dust}
    color315, color314 = Color3.fromRGB(150, 116, 80)
    properties19.Color = ColorSequence.new(color315, color314 or color315)
    properties19.Speed = NumberRange.new(0.4, 1)
    properties19.SpreadAngle = Vector2.new(70, 70)
    properties19.Size = seq(0, 0.015, 1, 0.04)
    properties19.Transparency = seq(0, 0.3, 1, 1)
    properties19.Lifetime = NumberRange.new(0.2, 0.35)
    properties19.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "wood_hit", properties19)
    local properties20 = {Acceleration = Vector3.new(0, 0.6000000238418579, 0), Rate = 40, LightEmission = 0.35, Texture = texts.ember}
    local color316 = Color3.fromRGB(255, 190, 90)
    local color317 = Color3.fromRGB(240, 90, 40)
    properties20.Color = ColorSequence.new(color316, color317 or color316)
    properties20.Speed = NumberRange.new(0.05, 0.15)
    properties20.SpreadAngle = Vector2.new(25, 25)
    properties20.Size = seq(0, 0.02, 0.4, 0.028, 1, 0)
    properties20.Transparency = seq(0, 0.25, 1, 1)
    properties20.Lifetime = NumberRange.new(0.18, 0.3)
    properties20.Rotation = NumberRange.new(-15, 15)
    emitter(tribesViewFx, "embers", properties20)
    local properties21 = {LightEmission = 0.35, Acceleration = Vector3.new(0, 0.5, 0), Rate = 22, Texture = texts.side}
    local color318 = Color3.fromRGB(255, 170, 70)
    local color319 = Color3.fromRGB(220, 80, 30)
    properties21.Color = ColorSequence.new(color318, color319 or color318)
    properties21.Speed = NumberRange.new(0.1, 0.2)
    properties21.SpreadAngle = Vector2.new(10, 10)
    properties21.Size = seq(0, 0.09, 0.5, 0.07, 1, 0.02)
    properties21.Transparency = seq(0, 0.2, 1, 1)
    properties21.Lifetime = NumberRange.new(0.15, 0.24)
    properties21.Rotation = NumberRange.new(-90)
    emitter(tribesViewFx, "flame", properties21)
    local properties22 = {Acceleration = Vector3.new(0, -0.4000000059604645, 0), Rate = 18, LightEmission = 0.3, Texture = texts.spark}
    local color320 = Color3.fromRGB(255, 190, 110)
    local color321 = Color3.fromRGB(235, 120, 50)
    properties22.Color = ColorSequence.new(color320, color321 or color320)
    properties22.Speed = NumberRange.new(0.15, 0.35)
    properties22.SpreadAngle = Vector2.new(60, 60)
    properties22.Size = seq(0, 0.012, 1, 0)
    properties22.Transparency = seq(0, 0.2, 1, 1)
    properties22.Lifetime = NumberRange.new(0.15, 0.25)
    properties22.Rotation = NumberRange.new(0, 360)
    emitter(tribesViewFx, "fuse", properties22)
    local properties23 = {LightEmission = 0.1, ZOffset = 0.1, Texture = texts.ring}
    color320, color321 = Color3.fromRGB(214, 204, 186)
    properties23.Color = ColorSequence.new(color320, color321 or color320)
    properties23.Size = seq(0, 0.03, 1, 0.08)
    properties23.Transparency = seq(0, 0.35, 1, 1)
    properties23.Lifetime = NumberRange.new(0.1, 0.12)
    emitter(tribesViewFx, "puncture", properties23)
    local properties24 = {LightEmission = 0.15, Drag = 8, Texture = texts.spark}
    color320, color321 = Color3.fromRGB(230, 214, 180)
    properties24.Color = ColorSequence.new(color320, color321 or color320)
    properties24.Orientation = Enum.ParticleOrientation.VelocityParallel
    properties24.Speed = NumberRange.new(1.5, 2.5)
    properties24.SpreadAngle = Vector2.new(25, 25)
    properties24.Size = seq(0, 0.006, 1, 0.002)
    properties24.Squash = seq(0, 3, 1, 1)
    properties24.Transparency = seq(0, 0.3, 1, 1)
    properties24.Lifetime = NumberRange.new(0.06, 0.09)
    emitter(tribesViewFx, "puncture_lines", properties24)
    local streak0 = Instance.new("Attachment")
    streak0.Name = "streak0"
    streak0.Parent = tribesViewFx

    local streak1 = Instance.new("Attachment")
    streak1.Name = "streak1"
    streak1.Parent = tribesViewFx

    local beam = Instance.new("Beam")
    beam.Attachment0 = streak0
    beam.Attachment1 = streak1
    beam.FaceCamera = true
    beam.Segments = 1
    beam.Width0 = 0.004
    beam.Width1 = 0.02
    beam.LightEmission = 0.15
    beam.LightInfluence = 0.4
    beam.Color = ColorSequence.new(Color3.fromRGB(176, 166, 150))
    beam.Transparency = NumberSequence.new(1, 0.4)
    beam.Enabled = false
    beam.Parent = tribesViewFx
    v13 = {a0 = streak0, a1 = streak1, beam = beam}
    local light = Instance.new("Attachment")
    light.Name = "light"
    light.Parent = tribesViewMuzzle
    attachment = light
    local pointLight2 = Instance.new("PointLight")
    pointLight2.Brightness = 1
    pointLight2.Range = 9
    pointLight2.Color = Color3.fromRGB(255, 170, 90)
    pointLight2.Shadows = false
    pointLight2.Enabled = false
    pointLight2.Parent = light
    pointLight = pointLight2

    return tribesViewFx
end

local function ensure(parent: Instance?, cFrame: CFrame)
    --[[
      name: ensure
      line: 311
      upvalues:
        part (ref,  index: 1)
        build (copy, index: 2)
        part2 (ref,  index: 3)
    ]]
    local part3 = part or build()
    part = part3
    part3.CFrame = cFrame

    if part3.Parent ~= parent then
        part3.Parent = parent
    end

    local part4 = part2

    if part4 and part4.Parent ~= parent then
        part4.Parent = parent
    end

    return part3
end

local function emit(key, cFrame, a99)
    --[[
      name: emit
      line: 325
      upvalues:
        v6 (copy, index: 1)
    ]]
    if const v100 = v6[key] then
        v100.att.CFrame = cFrame
        v100.e:Emit(a99)
    end
end

function v1.Preload()
    --[[
      name: Preload
      line: 335
      upvalues:
        part (ref,  index: 1)
        build (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    part = part or build()

    task.spawn(
        function()
            --[[
              line: 338
              upvalues:
                v6 (copy, index: 1)
            ]]
            local contentIdList = {}

            for _, v103 in v6 do
                table.insert(contentIdList, v103.e)
            end

            pcall(
                function()
                    --[[
                      line: 343
                      upvalues:
                        contentIdList (copy, index: 1)
                    ]]
                    game:GetService("ContentProvider"):PreloadAsync(contentIdList)
                end
            )
        end
    )
end

function v1.Follow(parent: Instance?, cFrame: CFrame)
    --[[
      name: Follow
      line: 349
      upvalues:
        timestamp (ref,  index: 1)
        part (ref,  index: 2)
        build (copy, index: 3)
        part2 (ref,  index: 4)
        pointLight (ref,  index: 5)
        v9 (ref,  index: 6)
        v6 (copy, index: 7)
        v10 (ref,  index: 8)
    ]]
    timestamp = os.clock()

    if not part then
        return
    end

    local part3 = part or build()
    part = part3
    part3.CFrame = cFrame

    if part3.Parent ~= parent then
        part3.Parent = parent
    end

    local part4 = part2

    if part4 and part4.Parent ~= parent then
        part4.Parent = parent
    end

    if pointLight and pointLight.Enabled and v9 <= timestamp then
        pointLight.Enabled = false
    end

    local wisp = v6.wisp

    if wisp and wisp.e.Enabled and v10 <= timestamp then
        wisp.e.Enabled = false
    end
end

local function along(a110)
    --[[
      name: along
      line: 365
    ]]
    local lookVector = a110.LookVector
    local rightVector = a110.RightVector

    return CFrame.fromMatrix(a110.Position, rightVector, lookVector, rightVector:Cross(lookVector))
end

local v113 = {musket = {flash = 0.09, tongue = 0.17, squash = 2.4, sparks = 8, spread = 10, smoke = 4, wisp = 1.1}, blunderbuss = {flash = 0.075, tongue = 0.08, squash = 0.6, sparks = 20, spread = 28, smoke = 6, wisp = 1.2, sparkSize = 0.03, sparkSquash = 3, sparkMin = 3, sparkMax = 6, sparkAt = 0.05}, pistol = {flash = 0.085, tongue = 0.09, squash = 0.8, sparks = 6, spread = 14, smoke = 2, wisp = 0.7}}

function v1.Play(a114, cFrame, options)
    --[[
      name: Play
      line: 382
      upvalues:
        part (ref,  index: 1)
        build (copy, index: 2)
        part2 (ref,  index: 3)
        v113 (copy, index: 4)
        v6 (copy, index: 5)
        seq (copy, index: 6)
        v10 (ref,  index: 7)
        pointLight (ref,  index: 8)
        attachment (ref,  index: 9)
        v9 (ref,  index: 10)
        on (ref,  index: 11)
        on2 (ref,  index: 12)
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local cFrame2 = camera.CFrame
    local part3 = part or build()
    part = part3
    part3.CFrame = cFrame2

    if part3.Parent ~= camera then
        part3.Parent = camera
    end

    local part4 = part2

    if part4 and part4.Parent ~= camera then
        part4.Parent = camera
    end

    local v121 = options or {}

    repeat
        local lookVector = cFrame.LookVector
        local rightVector = cFrame.RightVector
        local cFrame3 = CFrame.fromMatrix(cFrame.Position, rightVector, lookVector, rightVector:Cross(lookVector))

        if a114 == "muzzle" then
            local v125 = v113[v121.style or "musket"] or v113.musket
            local flash = v6.flash
            local tongue = v6.tongue
            local sparks = v6.sparks

            if flash then
                flash.e.Size = seq(0, v125.flash, 0.4, v125.flash * 1.08, 1, v125.flash * 0.5)
            end

            if tongue then
                tongue.e.Size = seq(0, v125.tongue, 0.5, v125.tongue * 1.1, 1, v125.tongue * 0.6)
                tongue.e.Squash = seq(0, v125.squash, 1, v125.squash * 0.7)
            end

            if sparks then
                sparks.e.SpreadAngle = Vector2.new(v125.spread, v125.spread)
                sparks.e.Size = seq(0, (v125.sparkSize or 0.016), 1, (v125.sparkSize or 0.016) * 0.27)
                sparks.e.Squash = seq(0, (v125.sparkSquash or 2), 1, (v125.sparkSquash or 2) * 0.5)
                sparks.e.Speed = NumberRange.new((v125.sparkMin or 2.2), (v125.sparkMax or 4.5))
            end

            if const part5 = part2 then
                part5.CFrame = camera.CFrame * cFrame3
            end

            local cFrame4 = CFrame.new(0, v125.flash * 0.3, 0)

            if const flash2 = v6.flash then
                flash2.att.CFrame = cFrame4
                flash2.e:Emit(1)
            end

            local cFrame5 = CFrame.new(0, (v125.tongue * v125.squash) * 0.5, 0)

            if const tongue2 = v6.tongue then
                tongue2.att.CFrame = cFrame5
                tongue2.e:Emit(2)
            end

            local cFrame6 = CFrame.new(0, (v125.sparkAt or 0.03), 0)
            local sparks2 = v125.sparks

            if const sparks3 = v6.sparks then
                sparks3.att.CFrame = cFrame6
                sparks3.e:Emit(sparks2)
            end

            local cFrame7 = cFrame3 + cFrame.LookVector * 0.03
            local smoke = v125.smoke

            if const smoke2 = v6.smoke then
                smoke2.att.CFrame = cFrame7
                smoke2.e:Emit(smoke)
            end

            if const wisp = v6.wisp then
                wisp.att.CFrame = cFrame3
                wisp.e.Enabled = true
                v10 = os.clock() + v125.wisp
            end

            if pointLight and attachment then
                attachment.CFrame = CFrame.identity
                pointLight.Enabled = true
                v9 = os.clock() + 0.05

                return
            end
        elseif a114 == "pan" then
            if const pan = v6.pan then
                pan.att.CFrame = cFrame3
                pan.e:Emit(1)
            end

            if const puff = v6.puff then
                puff.att.CFrame = cFrame3
                puff.e:Emit(2)

                return
            end
        elseif a114 == "twang" then
            if const twang = v6.twang then
                twang.att.CFrame = cFrame3
                twang.e:Emit(4)

                return
            end
        elseif a114 == "snap" then
            if const snap = v6.snap then
                snap.att.CFrame = cFrame3
                snap.e:Emit(1)
            end

            if const twang = v6.twang then
                twang.att.CFrame = cFrame3
                twang.e:Emit(10)
            end

            if const puff = v6.puff then
                puff.att.CFrame = cFrame3
                puff.e:Emit(2)

                return
            end
        elseif a114 == "powder" then
            if const powder = v6.powder then
                powder.att.CFrame = cFrame3
                powder.e:Emit(6)

                return
            end
        elseif a114 == "puff" then
            if const puff = v6.puff then
                puff.att.CFrame = cFrame3
                puff.e:Emit(3)

                return
            end
        else
            if a114 ~= "click" and a114 ~= "glint" and a114 ~= "bolt" then
                if a114 == "flare" then
                    if const flare = v6.flare then
                        flare.att.CFrame = cFrame3
                        flare.e:Emit(1)
                    end

                    if const glint = v6.glint then
                        glint.att.CFrame = cFrame3
                        glint.e:Emit(1)

                        return
                    end

                    break
                end

                if a114 == "sparkle" then
                    if const sparkle = v6.sparkle then
                        sparkle.att.CFrame = cFrame3
                        sparkle.e:Emit(6)

                        return
                    end

                    break
                end

                if a114 == "gold" then
                    if const gold = v6.gold then
                        gold.att.CFrame = cFrame3
                        gold.e:Emit(2)

                        return
                    end

                    break
                end

                if a114 == "crumbs" then
                    if const crumbs = v6.crumbs then
                        crumbs.att.CFrame = cFrame3
                        crumbs.e:Emit(5)

                        return
                    end

                    break
                end

                if a114 == "ring" then
                    if const ring = v6.ring then
                        ring.att.CFrame = cFrame
                        ring.e:Emit(1)

                        return
                    end

                    break
                end

                if a114 == "dust" then
                    if const dust = v6.dust then
                        dust.att.CFrame = cFrame3
                        dust.e:Emit(5)

                        return
                    end

                    break
                end

                if a114 == "puncture" then
                    if const puncture = v6.puncture then
                        puncture.att.CFrame = cFrame3
                        puncture.e:Emit(1)
                    end

                    if const punctureLines = v6.puncture_lines then
                        punctureLines.att.CFrame = cFrame3
                        punctureLines.e:Emit(6)

                        return
                    end

                    break
                end

                if a114 == "block_spark" then
                    if const blockSpark = v6.block_spark then
                        blockSpark.att.CFrame = cFrame3
                        blockSpark.e:Emit(16)
                    end

                    if const glint = v6.glint then
                        glint.att.CFrame = cFrame3
                        glint.e:Emit(1)

                        return
                    end

                    break
                end

                if a114 == "wood_hit" then
                    if const woodHit = v6.wood_hit then
                        woodHit.att.CFrame = cFrame3
                        woodHit.e:Emit(8)

                        return
                    end

                    break
                end

                if a114 ~= "embers" then
                    if a114 == "fuse" then
                        if const fuse = v6.fuse then
                            fuse.att.CFrame = cFrame3
                            fuse.e.Enabled = v121.on ~= false
                            fuse.e.Rate = v121.rate or 18
                            on2 = v121.on ~= false
                        end
                    end

                    break
                end

                for _, v163 in {"embers", "flame"} do
                    if const v164 = v6[v163] then
                        v164.att.CFrame = cFrame3
                        v164.e.Enabled = v121.on ~= false
                    end
                end

                local on3 = v121.on ~= false
                on = on3

                return
            elseif const glint = v6.glint then
                glint.att.CFrame = cFrame3
                glint.e:Emit(1)

                return
            end
        end
    until true
end

function v1.Streak(position, position2, a169, a170)
    --[[
      name: Streak
      line: 486
      upvalues:
        v13 (ref,  index: 1)
        part (ref,  index: 2)
        build (copy, index: 3)
        part2 (ref,  index: 4)
    ]]
    local v171 = v13
    if not v171 then
        return
    end

    if not position or not position2 or (position2 - position).Magnitude < 0.004 then
        v171.beam.Enabled = false
        return
    elseif const camera = workspace.CurrentCamera then
        local cFrame = camera.CFrame
        local part3 = part or build()
        part = part3
        part3.CFrame = cFrame

        if part3.Parent ~= camera then
            part3.Parent = camera
        end

        local part4 = part2

        if part4 and part4.Parent ~= camera then
            part4.Parent = camera
        end
    end

    v171.a0.Position = position
    v171.a1.Position = position2
    local width1 = a170 or 0.02

    if v171.beam.Width1 ~= width1 then
        v171.beam.Width1 = width1
        v171.beam.Width0 = not a170 and 0.004 or width1 * 0.2
    end

    v171.beam.Transparency = NumberSequence.new(1, 1 - (math.clamp((a169 or 1), 0, 1) * 0.75))
    v171.beam.Enabled = true
end

function v1.Track(a177, a178)
    --[[
      name: Track
      line: 511
      upvalues:
        part2 (ref,  index: 1)
        v6 (copy, index: 2)
        on (ref,  index: 3)
        on2 (ref,  index: 4)
    ]]
    if a177 ~= "muzzle" then
        if a177 == "embers" and on then
            for _, v180 in {"embers", "flame"} do
                if const v181 = v6[v180] then
                    local att = v181.att
                    local lookVector = a178.LookVector
                    local rightVector = a178.RightVector
                    att.CFrame = CFrame.fromMatrix(a178.Position, rightVector, lookVector, rightVector:Cross(lookVector))
                end
            end

            return
        end

        if a177 == "fuse" and on2 then
            if const fuse = v6.fuse then
                local att = fuse.att
                local lookVector = a178.LookVector
                local rightVector = a178.RightVector
                att.CFrame = CFrame.fromMatrix(a178.Position, rightVector, lookVector, rightVector:Cross(lookVector))
            end
        end
    else
        local part = part2
        local camera = workspace.CurrentCamera

        if part and camera then
            local cFrame = camera.CFrame
            local lookVector = a178.LookVector
            local rightVector = a178.RightVector
            part.CFrame = cFrame * CFrame.fromMatrix(a178.Position, rightVector, lookVector, rightVector:Cross(lookVector))
        end

        local wisp = v6.wisp

        if wisp and wisp.e.Enabled then
            local att = wisp.att
            local lookVector = a178.LookVector
            local rightVector = a178.RightVector
            att.CFrame = CFrame.fromMatrix(a178.Position, rightVector, lookVector, rightVector:Cross(lookVector))
        end
    end
end

function v1.Freeze(a198)
    --[[
      name: Freeze
      line: 539
      upvalues:
        v15 (ref,  index: 1)
        v6 (copy, index: 2)
    ]]
    v15 = a198

    for _, v200 in v6 do
        v200.e.TimeScale = a198 and 0.01 or 1
    end
end

function v1.Hide()
    --[[
      name: Hide
      line: 546
      upvalues:
        v6 (copy, index: 1)
        on (ref,  index: 2)
        on2 (ref,  index: 3)
        pointLight (ref,  index: 4)
        v13 (ref,  index: 5)
    ]]
    for _, v202 in v6 do
        v202.e.Enabled = false
        v202.e:Clear()
    end

    on = false
    on2 = false

    if pointLight then
        pointLight.Enabled = false
    end

    if v13 then
        v13.beam.Enabled = false
    end
end

return v1