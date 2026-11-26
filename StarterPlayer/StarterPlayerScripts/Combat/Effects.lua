local fx2
local debris = game:GetService("Debris")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local shared = replicatedStorage:WaitForChild("Shared")
local Combat = require(shared.Combat)
local Weapons = require(shared.Weapons)
local ballistics = Combat.Ballistics
local Util = require(script.Parent.Util)
local Metrics = require(script.Parent.Metrics)
local Quality = require(script.Parent.Quality)
local Presentation = require(script.Parent.Presentation)
local v15 = {}
local localPlayer = players.LocalPlayer
local vfx = Util.Assets:WaitForChild("VFX", 10)

if const fx3 = workspace:FindFirstChild("FX") then
    fx2 = fx3
else
    fx2 = Instance.new("Folder")
    fx2.Name = "FX"
    fx2.Parent = workspace
end

local function fx()
    --[[
      name: fx
      line: 34
      upvalues:
        fx2 (ref, index: 1)
    ]]
    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    return fx2
end

local function template(text)
    --[[
      name: template
      line: 50
      upvalues:
        vfx (copy, index: 1)
    ]]
    local v23

    if not vfx then
        return nil
    end

    v23 = vfx

    for v24 in string.gmatch(text, "[^/]+") do
        v23 = v23 and v23:FindFirstChild(v24)
    end

    return v23
end

local function prep(a26)
    --[[
      name: prep
      line: 61
    ]]
    local descendants = a26:GetDescendants()
    table.insert(descendants, a26)

    for _, descendant in descendants do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true
            descendant.CanCollide = false
            descendant.CanQuery = false
            descendant.CanTouch = false
            descendant.CastShadow = false
        end
    end
end

local v30 = {}
local v31 = {}
local v32 = 0
v15.NEAR = Quality.nearRadius
Quality.OnChanged(
    function()
        --[[
          line: 82
          upvalues:
            v15 (copy, index: 1)
            Quality (copy, index: 2)
        ]]
        v15.NEAR = Quality.nearRadius
    end
)

local function snapshot(a34)
    --[[
      name: snapshot
      line: 86
      upvalues:
        v31 (copy, index: 1)
    ]]
    local descendants = a34:GetDescendants()
    table.insert(descendants, a34)
    local v36 = {}

    for _, descendant in descendants do
        if descendant:IsA("BasePart") then
            table.insert(v36, {descendant, descendant.Transparency})
        elseif descendant:IsA("ParticleEmitter") then
            table.insert(v36, {descendant, {descendant.Enabled, descendant.Color, descendant.LightEmission}})
        elseif descendant:IsA("Trail") or descendant:IsA("Beam") then
            table.insert(v36, {descendant, descendant.Enabled})
        elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
            table.insert(v36, {descendant, descendant.Brightness})
        end
    end

    v31[a34] = v36
    a34.Destroying:Connect(
        function()
            --[[
              line: 102
              upvalues:
                v31 (copy, index: 1)
                a34 (copy, index: 2)
            ]]
            v31[a34] = nil
        end
    )
end

local function restore(a40)
    --[[
      name: restore
      line: 107
      upvalues:
        v31 (copy, index: 1)
    ]]
    local v41 = {}
    local v42 = v31[a40] or {}

    for _, v44 in v42 do
        v41[v44[1]] = v44[2]
    end

    local descendants = a40:GetDescendants()
    table.insert(descendants, a40)

    for _, descendant in descendants do
        local v48 = v41[descendant]

        if descendant:IsA("BasePart") then
            descendant.Anchored = true

            if type(v48) == "number" then
                descendant.Transparency = v48
            end
        elseif descendant:IsA("ParticleEmitter") and type(v48) == "table" then
            descendant.Enabled, descendant.Color, descendant.LightEmission = v48[1], v48[2], v48[3]
            descendant:Clear()
        else
            local v49, v50, v51, v52 = false, false, false, false

            if descendant:IsA("Trail") then
                if type(v48) ~= "boolean" then
                    v49 = true
                else
                    descendant.Enabled = v48
                    descendant:Clear()
                end
            else
                v49 = true
            end

            if v49 then
                if descendant:IsA("Beam") then
                    if type(v48) ~= "boolean" then
                        v50 = true
                    else
                        descendant.Enabled = v48
                    end
                else
                    v50 = true
                end
            end

            if v50 then
                if descendant:IsA("PointLight") then
                    v51 = true
                elseif descendant:IsA("SpotLight") then
                    v51 = true
                elseif descendant:IsA("SurfaceLight") then
                    v51 = true
                else
                    v52 = true
                end
            end

            if v51 then
                if type(v48) ~= "number" then
                    v52 = true
                else
                    descendant.Brightness = v48
                end
            end

            if v52 and descendant:IsA("WeldConstraint") and descendant.Name == "StickWeld" then
                descendant:Destroy()
            end
        end
    end
end

local function takeFromPool(poolKey, a55)
    --[[
      name: takeFromPool
      line: 137
      upvalues:
        v30 (copy, index: 1)
        restore (copy, index: 2)
        prep (copy, index: 3)
        snapshot (copy, index: 4)
    ]]
    local v56 = v30[poolKey]
    v56 = v56 and table.remove(v56)

    if v56 then
        restore(v56)
    else
        v56 = a55:Clone()
        prep(v56)
        snapshot(v56)
        v56:SetAttribute("PoolKey", poolKey)
    end

    v56:SetAttribute("Released", nil)

    return v56
end

local function release(a58)
    --[[
      name: release
      line: 152
      upvalues:
        v30 (copy, index: 1)
    ]]
    if not a58 or a58:GetAttribute("Released") then
        return
    end

    local v59
    local poolKey = a58:GetAttribute("PoolKey")

    if type(poolKey) ~= "string" then
        v59 = nil
    else
        v59 = v30[poolKey] or {}
    end

    if not v59 or 12 <= #v59 then
        a58:Destroy()
        return
    end

    v30[poolKey] = v59
    a58.Parent = nil
    a58:SetAttribute("Released", true)
    table.insert(v59, a58)
end

local v61 = setmetatable({}, {__mode = "k"})

local function bodyOf(model)
    --[[
      name: bodyOf
      line: 170
      upvalues:
        v61 (copy, index: 1)
    ]]
    local v64

    if const v65 = v61[model] then
        return v65
    end

    if model:IsA("Model") then
        v64 = model:GetPivot()
    else
        v64 = if model:IsA("BasePart") then model.CFrame else CFrame.identity
    end

    local parts = {}
    local rels = {}
    local descendants = model:GetDescendants()
    table.insert(descendants, model)

    for _, descendant in descendants do
        if descendant:IsA("BasePart") then
            table.insert(parts, descendant)
            table.insert(rels, v64:ToObjectSpace(descendant.CFrame))
        end
    end

    local v71 = {parts = parts, rels = rels}
    v61[model] = v71

    return v71
end

v15.CamDistance = function(a72)
    --[[
      name: camDistance
      line: 190
    ]]
    return if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a72).Magnitude else 0
end

local function flatPart(name: string, size: Vector3, cFrame: CFrame, color: Color3, a79, a80)
    --[[
      name: flatPart
      line: 196
      upvalues:
        fx2 (ref, index: 1)
    ]]
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Size = size
    part.CFrame = cFrame
    part.Color = color
    part.Material = a79 or Enum.Material.SmoothPlastic
    part.Transparency = a80 or 0

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    part.Parent = fx2

    return part
end

function v15.WeaponColor(a83)
    --[[
      name: WeaponColor
      line: 214
      upvalues:
        Weapons (copy, index: 1)
        Presentation (copy, index: 2)
    ]]
    local v84
    local weaponId = a83 and a83:GetAttribute("WeaponId")
    local v86 = Weapons.Get(weaponId)
    local v87 = v86 and Presentation.Kind(v86.kind)
    local v88 = false

    if v87 then
        v84 = v87.slashColor

        if not v84 then
            v84 = v87.glow

            if not v84 then
                v88 = true
            end
        end
    else
        v88 = true
    end

    if v88 then
        v84 = Color3.fromRGB(226, 170, 100)
    end

    return v84
end

v15.GroundAt = function(a89, a90)
    --[[
      name: groundAt
      line: 221
      upvalues:
        Util (copy, index: 1)
    ]]
    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(a89 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a90 + 1.5), 0), raycastParams) then
        return raycastResult.Position, raycastResult.Normal
    end

    return nil, nil
end

local function groundDecal(a94, a95, image: string, color3: Color3, a98, a99, a100: number, imageTransparency: number, a102)
    --[[
      name: groundDecal
      line: 232
      upvalues:
        Quality (copy, index: 1)
        fx2 (ref,  index: 2)
        tweenService (copy, index: 3)
        debris (copy, index: 4)
    ]]
    if not Quality.decals then
        return
    end

    local unit = a95.Unit
    local v104 = unit:Cross(Vector3.new(0, 0, 1))

    if v104.Magnitude < 0.1 then
        v104 = unit:Cross(Vector3.new(1, 0, 0))
    end

    local unit2 = v104.Unit
    local unit3 = unit2:Cross(unit).Unit
    local cFrame = CFrame.fromMatrix(a94 + (unit * 0.06), unit2, unit, -unit3)
    local size = Vector3.new(a98, 0.05, a98)
    local smoothPlastic = Enum.Material.SmoothPlastic
    local groundFx = Instance.new("Part")
    groundFx.Name = "GroundFX"
    groundFx.Anchored = true
    groundFx.CanCollide = false
    groundFx.CanQuery = false
    groundFx.CanTouch = false
    groundFx.CastShadow = false
    groundFx.Size = size
    groundFx.CFrame = cFrame
    groundFx.Color = color3
    groundFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
    groundFx.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    groundFx.Parent = fx2
    local parent = Instance.new("SurfaceGui")
    parent.Face = Enum.NormalId.Top
    parent.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
    parent.CanvasSize = Vector2.new(256, 256)
    parent.LightInfluence = 1
    parent.Parent = groundFx

    local instance = Instance.new("ImageLabel")
    instance.Size = UDim2.fromScale(1, 1)
    instance.BackgroundTransparency = 1
    instance.Image = image
    instance.ImageColor3 = color3
    instance.ImageTransparency = imageTransparency
    instance.Parent = parent
    local tweenInfo = TweenInfo.new(a100, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local propertyTable = {Size = Vector3.new(a99, 0.05, a99)}
    tweenService:Create(groundFx, tweenInfo, propertyTable):Play()

    task.delay(
        (a102 or 0),
        function()
            --[[
              line: 259
              upvalues:
                tweenService (copy, index: 1)
                instance (copy, index: 2)
                a102 (copy, index: 3)
                a100 (copy, index: 4)
            ]]
            local newTweenInfo = TweenInfo.new
            local v117 = a102 and 1.2 or a100
            local propertyTable = {ImageTransparency = 1}
            tweenService:Create(instance, newTweenInfo(v117, Enum.EasingStyle.Quad, Enum.EasingDirection.In), propertyTable):Play()
        end
    )

    debris:AddItem(groundFx, ((a102 or 0) + a100) + 1.3)
end

local function emitAll(a120, a121)
    --[[
      name: emitAll
      line: 265
      upvalues:
        Quality (copy, index: 1)
        tweenService (copy, index: 2)
    ]]
    local v122 = 0.5
    local instances = a120:GetDescendants()
    table.insert(instances, a120)

    for _, instance in instances do
        if instance:IsA("ParticleEmitter") then
            local emitCount = instance:GetAttribute("EmitCount")

            if type(emitCount) == "number" then

            else
                emitCount = 12
            end

            local v127 = math.max(1, (math.floor((emitCount * (a121 or 1) * Quality.particleScale) + 0.5)))
            local emitDelay = instance:GetAttribute("EmitDelay")

            if type(emitDelay) ~= "number" or not (0 < emitDelay) then
                instance:Emit(v127)
                v122 = math.max(v122, instance.Lifetime.Max)
            else
                task.delay(
                    emitDelay,
                    function()
                        --[[
                          line: 276
                          upvalues:
                            instance (copy, index: 1)
                            v127 (ref,  index: 2)
                        ]]
                        if instance.Parent then
                            instance:Emit(v127)
                        end
                    end
                )

                v122 = math.max(v122, emitDelay + instance.Lifetime.Max)
            end
        elseif instance:IsA("PointLight") or instance:IsA("SpotLight") then
            instance.Enabled = true
            local propertyTable = {Brightness = 0}
            tweenService:Create(instance, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
        end
    end

    return v122
end

function v15.Burst(a130: string, a131, a132, a133, a134)
    --[[
      name: Burst
      line: 295
      upvalues:
        template (copy, index: 1)
        v32 (ref,  index: 2)
        Quality (copy, index: 3)
        takeFromPool (copy, index: 4)
        fx2 (ref,  index: 5)
        emitAll (copy, index: 6)
        release (copy, index: 7)
    ]]
    local v135 = template(a130)
    if not v135 then
        return false
    end

    local v136 = v32

    if Quality.maxBursts <= v136 then
        local position = a131.Position
        local camera = workspace.CurrentCamera

        if 40 < ((not camera and 0) or (camera.CFrame.Position - position).Magnitude) then
            return true
        end
    end

    local v139 = takeFromPool(a130, v135)

    if v139:IsA("BasePart") then
        v139.Transparency = 1
        v139.CFrame = a131

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        v139.Parent = fx2
    elseif v139:IsA("Model") then
        v139:PivotTo(a131)

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        v139.Parent = fx2
    else
        if not v139:IsA("Attachment") then
            v139:Destroy()
            return false
        end

        v139.Parent = workspace.Terrain
        v139.WorldCFrame = a131
    end

    if a133 then
        for _, descendant in v139:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("Tint") or a134 then
                    descendant.Color = ColorSequence.new(a133)
                    descendant.LightEmission = math.min(descendant.LightEmission, 0.35)
                end
            end
        end
    end

    local v144 = emitAll(v139, a132)
    v32 += 1

    task.delay(
        v144 + 0.3,
        function()
            --[[
              line: 328
              upvalues:
                v32 (ref,  index: 1)
                release (copy, index: 2)
                v139 (copy, index: 3)
            ]]
            v32 -= 1
            release(v139)
        end
    )

    return true
end

local function anchorPart(vector3: Vector3, size: Vector3)
    --[[
      name: anchorPart
      line: 336
      upvalues:
        fx2 (ref, index: 1)
    ]]
    local cFrame = CFrame.new(vector3)
    local color = Color3.new()
    local smoothPlastic = Enum.Material.SmoothPlastic
    local puffFx = Instance.new("Part")
    puffFx.Name = "PuffFX"
    puffFx.Anchored = true
    puffFx.CanCollide = false
    puffFx.CanQuery = false
    puffFx.CanTouch = false
    puffFx.CastShadow = false
    puffFx.Size = size
    puffFx.CFrame = cFrame
    puffFx.Color = color
    puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
    puffFx.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    puffFx.Parent = fx2

    return puffFx
end

function v15.Puff(vector3: Vector3, a154, a155, a156, a157, a158, a159)
    --[[
      name: Puff
      line: 340
      upvalues:
        fx2 (ref,  index: 1)
        Quality (copy, index: 2)
        debris (copy, index: 3)
    ]]
    local cFrame = CFrame.new(vector3)
    local color = Color3.new()
    local smoothPlastic = Enum.Material.SmoothPlastic
    local puffFx = Instance.new("Part")
    puffFx.Name = "PuffFX"
    puffFx.Anchored = true
    puffFx.CanCollide = false
    puffFx.CanQuery = false
    puffFx.CanTouch = false
    puffFx.CastShadow = false
    puffFx.Size = Vector3.new(1, 1, 1)
    puffFx.CFrame = cFrame
    puffFx.Color = color
    puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
    puffFx.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    puffFx.Parent = fx2

    if a159 then
        puffFx.CFrame = CFrame.lookAt(vector3, vector3 + a159)
    end

    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    particleEmitter.Color = ColorSequence.new(a154)
    particleEmitter.LightEmission = 0
    particleEmitter.LightInfluence = 1
    particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a156 * 0.5), NumberSequenceKeypoint.new(1, a156 * 1.6)})
    particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(0.6, 0.55), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter.Lifetime = NumberRange.new(a158 * 0.7, a158)
    particleEmitter.Speed = NumberRange.new(a157 * 0.4, a157)
    particleEmitter.SpreadAngle = if a159 then Vector2.new(22, 22) else Vector2.new(180, 180)
    particleEmitter.EmissionDirection = Enum.NormalId.Front
    particleEmitter.Rotation = NumberRange.new(0, 360)
    particleEmitter.RotSpeed = NumberRange.new(-40, 40)
    particleEmitter.Drag = 3
    particleEmitter.Acceleration = Vector3.new(0, 1.5, 0)
    particleEmitter.Rate = 0
    particleEmitter.Parent = puffFx
    particleEmitter:Emit((math.max(1, (math.floor((a155 * Quality.particleScale) + 0.5)))))
    debris:AddItem(puffFx, a158 + 0.3)
end

function v15.HitFlash(instance: Instance?, a167)
    --[[
      name: HitFlash
      line: 372
      upvalues:
        Quality (copy, index: 1)
        tweenService (copy, index: 2)
    ]]
    if not instance or not instance:IsA("Model") or not Quality.highlights then
        return
    end

    local combatHitFlash = instance:FindFirstChild("CombatHitFlash")
    if not combatHitFlash then
        combatHitFlash = Instance.new("Highlight")
        combatHitFlash.Name = "CombatHitFlash"
        combatHitFlash.DepthMode = Enum.HighlightDepthMode.Occluded
        combatHitFlash.Adornee = instance
        combatHitFlash.Parent = instance
    end

    local fillColor = a167 or Color3.fromRGB(255, 70, 60)
    combatHitFlash.FillColor = fillColor
    local outlineColor = a167 or Color3.fromRGB(255, 70, 60)
    combatHitFlash.OutlineColor = outlineColor
    combatHitFlash.FillTransparency = 1
    combatHitFlash.OutlineTransparency = 0.05
    local propertyTable = {OutlineTransparency = 1}
    tweenService:Create(combatHitFlash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    local tok = (combatHitFlash:GetAttribute("Tok") or 0) + 1
    combatHitFlash:SetAttribute("Tok", tok)

    task.delay(
        0.3,
        function()
            --[[
              line: 394
              upvalues:
                combatHitFlash (copy, index: 1)
                tok (copy, index: 2)
            ]]
            if combatHitFlash.Parent and combatHitFlash:GetAttribute("Tok") == combatHitFlash then
                combatHitFlash:Destroy()
            end
        end
    )
end

local v173 = {}

function v15.PredictHit(key, a175, a176, a177, a178, a179)
    --[[
      name: PredictHit
      line: 411
      upvalues:
        Util (copy, index: 1)
        v173 (copy, index: 2)
    ]]
    if not Util.CanPredictHit(key) then
        return
    end

    v173[key] = os.clock()

    if a175 then
        Util.Sound(a175, a176)
    end
end

function v15.ConsumePrediction(key)
    --[[
      name: ConsumePrediction
      line: 421
      upvalues:
        v173 (copy, index: 1)
    ]]
    if not key then
        return false
    end

    local v181 = v173[key]
    v173[key] = nil

    return v181 ~= nil and os.clock() - v181 < 0.8
end

task.spawn(
    function()
        --[[
          line: 430
          upvalues:
            v173 (copy, index: 1)
        ]]
        while true do
            task.wait(5)
            local timestamp = os.clock()

            for v183, v184 in v173 do
                if 2 < timestamp - v184 then
                    v173[v183] = nil
                end
            end
        end
    end
)

local v185 = {Grass = "Impact_Dust", LeafyGrass = "Impact_Dust", Ground = "Impact_Dust", Mud = "Impact_Dust", Sand = "Impact_Dust", Snow = "Impact_Dust", Salt = "Impact_Dust", Wood = "Impact_Wood", WoodPlanks = "Impact_Wood", Metal = "Impact_Sparks", DiamondPlate = "Impact_Sparks", CorrodedMetal = "Impact_Sparks", Foil = "Impact_Sparks"}
local v186 = {Impact_Dust = "Impact_Dirt", Impact_Wood = "Impact_Wood", Impact_Sparks = "Impact_Metal", Impact_Stone = "Impact_Stone"}

function v15.Impact(vector3: Vector3, a188, a189, a190, a191)
    --[[
      name: Impact
      line: 466
      upvalues:
        v185 (copy, index: 1)
        v15 (copy, index: 2)
        Util (copy, index: 3)
        v186 (copy, index: 4)
    ]]
    local v192 = v185[a189 or ""] or "Impact_Stone"
    local cframe = CFrame.lookAt(vector3, vector3 + (a188 or Vector3.new(0, 1, 0)))

    if not v15.Burst(v192, cframe, a191) then
        v15.Burst("Impact_Stone", cframe, a191)
    end

    if a190 ~= false then
        Util.Sound((v186[v192] or "Impact_Stone"), vector3)
    end
end

local v194 = {health = Color3.fromRGB(235, 110, 50), headshot = Color3.fromRGB(245, 190, 40), blocked = Color3.fromRGB(120, 190, 245)}

function v15.ArmorHit(vector3: Vector3, a196)
    --[[
      name: ArmorHit
      line: 486
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local volume
    local v199 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - vector3).Magnitude else 0

    if v15.NEAR < v199 then
        return
    end

    local burst = v15.Burst
    local cframe = CFrame.new(vector3)
    local v202 = a196 and 1.2 or 0.7
    burst("Block_Spark", cframe, v202, Color3.fromRGB(205, 210, 220), true)
    local sound = Util.Sound
    local v204 = a196 and "Shield_Break" or "Impact_Metal"
    local v205 = {}

    if a196 then
        volume = 0.9
    else
        volume = 0.5
    end

    v205.Volume = volume
    sound(v204, vector3, v205)
end

function v15.CharacterImpact(vector3: Vector3, a207, a208, key)
    --[[
      name: CharacterImpact
      line: 494
      upvalues:
        v194 (copy, index: 1)
        v15 (copy, index: 2)
    ]]
    local cframe = CFrame.lookAt(vector3, vector3 - (a207 or Vector3.new(0, 0, 1)))
    local v211 = key and v194[key]
    v15.Burst("Impact_Hit", cframe, (a208 and 1.6 or key and 1.15 or 0.7), v211, v211 ~= nil)

    if key == "headshot" then
        v15.CritStar(vector3)
    end
end

function v15.CritStar(a212)
    --[[
      name: CritStar
      line: 505
      upvalues:
        template (copy, index: 1)
        prep (copy, index: 2)
        fx2 (ref,  index: 3)
        runService (copy, index: 4)
    ]]
    local v213 = template("CritStar")
    if not v213 then
        return
    end

    local v214 = v213:Clone()
    prep(v214)
    v214:ScaleTo(0.25)
    v214:PivotTo(CFrame.lookAt(a212 + Vector3.new(0, 1.2000000476837158, 0), workspace.CurrentCamera.CFrame.Position))

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    v214.Parent = fx2
    local timestamp = os.clock()
    local renderSteppedConnection = nil

    renderSteppedConnection = runService.RenderStepped:Connect(
        function()
            --[[
              line: 517
              upvalues:
                timestamp (copy, index: 1)
                v214 (copy, index: 2)
                renderSteppedConnection (ref,  index: 3)
                a212 (copy, index: 4)
            ]]
            local v218 = (os.clock() - timestamp) / 0.45

            if 1 <= v218 or not v214.Parent then
                renderSteppedConnection:Disconnect()
                v214:Destroy()

                return
            end

            local v219 = if v218 < 0.3 then 0.25 + 0.65 * (v218 / 0.3) else 0.9 - 0.2 * (v218 - 0.3)
            v214:ScaleTo((math.max(0.05, v219)))
            v214:PivotTo(CFrame.lookAt(a212 + Vector3.new(0, 1.2 + (v218 * 1.2), 0), workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 0, v218 * 2))

            for _, descendant in v214:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = math.clamp((v218 - 0.55) / 0.45, 0, 1)
                end
            end
        end
    )
end

function v15.Trail(a222, a223: number)
    --[[
      name: Trail
      line: 537
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    if not a222 then
        return
    end

    local v224 = v15.WeaponColor(a222)

    for _, descendant in Util.Drawn(a222):GetDescendants() do
        if descendant:IsA("Trail") then
            descendant.Lifetime = 0.18
            descendant.LightEmission = 0.25
            descendant.LightInfluence = 0.5
            descendant.Color = ColorSequence.new(v224)
            descendant.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
            descendant.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
            descendant.Enabled = true
            local tok = (descendant:GetAttribute("Tok") or 0) + 1
            descendant:SetAttribute("Tok", tok)

            task.delay(
                a223,
                function()
                    --[[
                      line: 554
                      upvalues:
                        descendant (copy, index: 1)
                        tok (copy, index: 2)
                    ]]
                    if descendant:GetAttribute("Tok") == tok then
                        descendant.Enabled = false
                    end
                end
            )
        end
    end
end

local screenGui = nil

function v15.DashLines(a229: number?)
    --[[
      name: DashLines
      line: 568
      upvalues:
        players (copy, index: 1)
        screenGui (ref,  index: 2)
        tweenService (copy, index: 3)
    ]]
    local instance = players.LocalPlayer
    instance = instance and instance:FindFirstChildOfClass("PlayerGui")

    if not instance then
        return
    end

    local tribesDashLines = screenGui

    if not tribesDashLines or tribesDashLines.Parent ~= instance then
        tribesDashLines = Instance.new("ScreenGui")
        tribesDashLines.Name = "TribesDashLines"
        tribesDashLines.IgnoreGuiInset = true
        tribesDashLines.ResetOnSpawn = false
        tribesDashLines.DisplayOrder = 3
        tribesDashLines.Parent = instance
        screenGui = tribesDashLines
    end

    local random = Random.new()
    local tweenInfo = TweenInfo.new(a229, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    for index = 1, 16 do
        local v235 = ((index / 16) * math.pi) * 2 + random:NextNumber(-0.12, 0.12)
        local vector2 = Vector2.new(math.cos(v235), (math.sin(v235)))
        local v237 = random:NextNumber(0.36, 0.44)
        local line = Instance.new("Frame")
        line.Name = "Line"
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(236, 240, 248)
        line.BackgroundTransparency = 0.76
        line.Size = UDim2.new(random:NextNumber(0.07, 0.13), 0, 0, 2)
        line.Rotation = math.deg(v235)
        line.Position = UDim2.fromScale(0.5 + (vector2.X * v237), 0.5 + (vector2.Y * v237))
        line.Parent = tribesDashLines
        local v239 = v237 + random:NextNumber(0.12, 0.2)
        local propertyTable = {BackgroundTransparency = 1, Position = UDim2.fromScale(0.5 + (vector2.X * v239), 0.5 + (vector2.Y * v239))}
        tweenService:Create(line, tweenInfo, propertyTable):Play()
        task.delay(
            a229 + 0.05,
            function()
                --[[
                  line: 603
                  upvalues:
                    line (copy, index: 1)
                ]]
                line:Destroy()
            end
        )
    end
end

function v15.Slash(a241, a242, a243, a244, a245)
    --[[
      name: Slash
      line: 609
      upvalues:
        Util (copy, index: 1)
        fx2 (ref,  index: 2)
        Quality (copy, index: 3)
        runService (copy, index: 4)
    ]]
    local v246
    local v247
    local update

    if not a241 then
        return
    end

    local v249 = Util.Drawn(a241:FindFirstChild("HumanoidRootPart"))
    if not v249 then
        return
    end

    local startValue = a244 or Color3.fromRGB(226, 170, 100)
    local v251 = a243 and 90 or ({-32, 212, 38, 148})[((a242 - 1) % 4) + 1]
    local v252 = a242 % 2 ~= 0 and 1 or -1
    local clampedValue = math.clamp((a245 or 9) * 0.42, 3, 5.5)

    if a243 then
        v246 = 1.2
    else
        v246 = 1
    end

    local v254 = clampedValue * v246
    local v255 = v249.CFrame * CFrame.new(0, 0.6, -0.6)
    local cframeAngles = CFrame.Angles
    local v257 = a243 and 0 or 22
    local cFrame = v255 * cframeAngles(math.rad(v257), 0, 0) * CFrame.Angles(0, 0, (math.rad(v251)))

    if a243 then
        v247 = 150
    else
        v247 = 130
    end

    local v259 = math.rad(v247)
    local v260 = -v252 * v259 / 2
    local smoothPlastic = Enum.Material.SmoothPlastic
    local slashArc = Instance.new("Part")
    slashArc.Name = "SlashArc"
    slashArc.Anchored = true
    slashArc.CanCollide = false
    slashArc.CanQuery = false
    slashArc.CanTouch = false
    slashArc.CastShadow = false
    slashArc.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    slashArc.CFrame = cFrame
    slashArc.Color = startValue
    slashArc.Material = smoothPlastic or Enum.Material.SmoothPlastic
    slashArc.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    slashArc.Parent = fx2
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = slashArc

    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = slashArc

    local function place(a267, a268: number)
        --[[
          name: place
          line: 629
          upvalues:
            v254 (copy, index: 1)
            v252 (copy, index: 2)
        ]]
        local vector3 = Vector3.new(-v254 * math.sin(a268), 0, -v254 * math.cos(a268))
        local v270 = Vector3.new(-math.cos(a268), 0, (math.sin(a268))) * v252
        a267.CFrame = CFrame.fromMatrix(vector3, v270, Vector3.new(0, 1, 0))
    end

    local v271 = a243 and 1.35 or 1

    local function beam(width1: number, color: ColorSequence, transparency: NumberSequence, texture: string)
        --[[
          name: beam
          line: 635
          upvalues:
            attachment0 (copy, index: 1)
            attachment1 (copy, index: 2)
            slashArc (copy, index: 3)
        ]]
        local beam = Instance.new("Beam")
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1
        beam.FaceCamera = true
        beam.Segments = 24
        beam.LightEmission = 0.25
        beam.LightInfluence = 0.35
        beam.Width0 = width1 * 0.15
        beam.Width1 = width1
        beam.Color = color
        beam.Transparency = transparency

        if texture then
            beam.Texture = texture
            beam.TextureMode = Enum.TextureMode.Stretch
        end

        beam.Parent = slashArc

        return beam
    end

    local transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.55), NumberSequenceKeypoint.new(0.92, 0.05), NumberSequenceKeypoint.new(1, 0.15)})
    local transparency2 = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.65), NumberSequenceKeypoint.new(1, 0.35)})
    local width1 = v271 * 0.9
    local color = ColorSequence.new(startValue, startValue:Lerp(Color3.new(1, 1, 1), 0.15))
    local beam2 = Instance.new("Beam")
    beam2.Attachment0 = attachment0
    beam2.Attachment1 = attachment1
    beam2.FaceCamera = true
    beam2.Segments = 24
    beam2.LightEmission = 0.25
    beam2.LightInfluence = 0.35
    beam2.Width0 = width1 * 0.15
    beam2.Width1 = width1
    beam2.Color = color
    beam2.Transparency = transparency
    beam2.Parent = slashArc
    local width12 = v271 * 2.8
    local color2 = ColorSequence.new(startValue)
    local beam3 = Instance.new("Beam")
    beam3.Attachment0 = attachment0
    beam3.Attachment1 = attachment1
    beam3.FaceCamera = true
    beam3.Segments = 24
    beam3.LightEmission = 0.25
    beam3.LightInfluence = 0.35
    beam3.Width0 = width12 * 0.15
    beam3.Width1 = width12
    beam3.Color = color2
    beam3.Transparency = transparency2
    beam3.Texture = "rbxassetid://10525777446"
    beam3.TextureMode = Enum.TextureMode.Stretch
    beam3.Parent = slashArc
    local width13 = v271 * 1.6
    local color3 = ColorSequence.new(startValue)
    local beam4 = Instance.new("Beam")
    beam4.Attachment0 = attachment0
    beam4.Attachment1 = attachment1
    beam4.FaceCamera = true
    beam4.Segments = 24
    beam4.LightEmission = 0.25
    beam4.LightInfluence = 0.35
    beam4.Width0 = width13 * 0.15
    beam4.Width1 = width13
    beam4.Color = color3
    beam4.Transparency = transparency2
    beam4.Parent = slashArc

    if not Quality.layers then
        beam4.Enabled = false
    end

    local v289 = a243 and 0.16 or 0.12
    local v290 = v259 * 0.8
    local timestamp = os.clock()

    update = function()
        --[[
          name: update
          line: 674
          upvalues:
            timestamp (copy, index: 1)
            v289 (copy, index: 2)
            v260 (copy, index: 3)
            v252 (copy, index: 4)
            v259 (copy, index: 5)
            v290 (copy, index: 6)
            attachment0 (copy, index: 7)
            v254 (copy, index: 8)
            attachment1 (copy, index: 9)
            beam2 (copy, index: 10)
            beam3 (copy, index: 11)
            beam4 (copy, index: 12)
            v271 (copy, index: 13)
        ]]
        local elapsedTime = os.clock() - timestamp
        local v293 = math.min(1, elapsedTime / v289)
        local v294 = 1 - (function(...) return (...) ^ 2 end)(((1 - v293)))
        local v295 = v260 + (v252 * v259) * v294
        local clampedValue = math.clamp((elapsedTime - v289) / 0.14, 0, 1)
        local v297 = v260 + v252 * math.max(0, (v259 * v294) - (v290 * (1 - clampedValue)))
        local absoluteValue = math.abs(v295 - v297)

        if 1 <= clampedValue or absoluteValue < 0.02 and 1 <= v293 then
            return false
        end

        local vector3 = Vector3.new(-v254 * math.sin(v297), 0, -v254 * math.cos(v297))
        local v300 = Vector3.new(-math.cos(v297), 0, (math.sin(v297))) * v252
        attachment0.CFrame = CFrame.fromMatrix(vector3, v300, Vector3.new(0, 1, 0))
        local vector32 = Vector3.new(-v254 * math.sin(v295), 0, -v254 * math.cos(v295))
        local v302 = Vector3.new(-math.cos(v295), 0, (math.sin(v295))) * v252
        attachment1.CFrame = CFrame.fromMatrix(vector32, v302, Vector3.new(0, 1, 0))
        local v303 = math.tan(absoluteValue / 4) * 1.3333333333333333 * v254
        beam2.CurveSize0 = v303
        beam2.CurveSize1 = v303
        beam3.CurveSize0 = v303
        beam3.CurveSize1 = v303
        beam4.CurveSize0 = v303
        beam4.CurveSize1 = v303
        beam2.Width1 = v271 * 0.9 * (1 - (clampedValue * 0.6))
        beam3.Width1 = v271 * 2.8 * (1 - (clampedValue * 0.4))
        beam4.Width1 = v271 * 1.6 * (1 - (clampedValue * 0.5))

        return true
    end

    local vector3 = Vector3.new(-v254 * math.sin(v260), 0, -v254 * math.cos(v260))
    local v305 = Vector3.new(-math.cos(v260), 0, (math.sin(v260))) * v252
    attachment0.CFrame = CFrame.fromMatrix(vector3, v305, Vector3.new(0, 1, 0))
    local vector32 = Vector3.new(-v254 * math.sin(v260), 0, -v254 * math.cos(v260))
    local v307 = Vector3.new(-math.cos(v260), 0, (math.sin(v260))) * v252
    attachment1.CFrame = CFrame.fromMatrix(vector32, v307, Vector3.new(0, 1, 0))
    update()
    local renderSteppedConnection = nil

    renderSteppedConnection = runService.RenderStepped:Connect(
        function()
            --[[
              line: 701
              upvalues:
                slashArc (copy, index: 1)
                update (copy, index: 2)
                renderSteppedConnection (ref,  index: 3)
            ]]
            if not slashArc.Parent or not update() then
                renderSteppedConnection:Disconnect()
                slashArc:Destroy()
            end
        end
    )
end

function v15.GroundScuff(a309)
    --[[
      name: GroundScuff
      line: 709
      upvalues:
        Util (copy, index: 1)
        groundDecal (copy, index: 2)
    ]]
    local position, normal
    local v312 = a309 + Vector3.new(0, 2, 0)
    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(v312 + Vector3.new(0, 1.5, 0), Vector3.new(0, -7.5, 0), raycastParams) then
        position = raycastResult.Position
        normal = raycastResult.Normal
    else
        position, normal = nil, nil
    end

    if position and normal then
        groundDecal(position, normal, "rbxassetid://10430755572", Color3.fromRGB(70, 55, 40), 3, 4.2, 0.15, 0.35, 1.2)
        groundDecal(position, normal, "rbxassetid://10871117278", Color3.fromRGB(190, 165, 130), 1.5, 8, 0.25, 0.35)
    end
end

function v15.Muzzle(a315, a316, a317, a318)
    --[[
      name: Muzzle
      line: 720
      upvalues:
        v15 (copy, index: 1)
        fx2 (ref,  index: 2)
        tweenService (copy, index: 3)
        debris (copy, index: 4)
    ]]
    local position = a315.Position
    local v321 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0
    local v322 = v15.NEAR < v321
    local v323 = a316 and 1.4 or 1

    if not v322 and not a318 then
        local size = Vector3.new(0.5, 0.5, 1.399999976158142) * v323
        local cFrame = a315 * CFrame.new(0, 0, v323 * -0.7)
        local color = Color3.fromRGB(255, 170, 70)
        local smoothPlastic = Enum.Material.SmoothPlastic
        local muzzleFlash = Instance.new("Part")
        muzzleFlash.Name = "MuzzleFlash"
        muzzleFlash.Anchored = true
        muzzleFlash.CanCollide = false
        muzzleFlash.CanQuery = false
        muzzleFlash.CanTouch = false
        muzzleFlash.CastShadow = false
        muzzleFlash.Size = size
        muzzleFlash.CFrame = cFrame
        muzzleFlash.Color = color
        muzzleFlash.Material = smoothPlastic or Enum.Material.SmoothPlastic
        muzzleFlash.Transparency = 0.2

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        muzzleFlash.Parent = fx2
        local specialMesh = Instance.new("SpecialMesh")
        specialMesh.MeshType = Enum.MeshType.Sphere
        specialMesh.Parent = muzzleFlash

        local instance = Instance.new("PointLight")
        instance.Color = Color3.fromRGB(255, 160, 80)
        instance.Brightness = 1
        instance.Range = v323 * 10
        instance.Shadows = false
        instance.Parent = muzzleFlash
        tweenService:Create(muzzleFlash, TweenInfo.new(0.07), {Transparency = 1, Size = Vector3.new(0.8999999761581421, 0.8999999761581421, 2.200000047683716) * v323}):Play()
        local propertyTable = {Brightness = 0}
        tweenService:Create(instance, TweenInfo.new(0.09), propertyTable):Play()
        debris:AddItem(muzzleFlash, 0.12)
        v15.Puff(a315.Position, Color3.fromRGB(255, 190, 110), 5, v323 * 0.35, 18, 0.12, a315.LookVector)
    end

    if a317 ~= false then
        local puff = v15.Puff
        local position2 = a315.Position
        local color3 = Color3.fromRGB(196, 192, 184)
        local v336 = v322 and 4 or 9
        puff(position2, color3, v336, v323 * 1.1, 7, 1.7, a315.LookVector)
        local puff2 = v15.Puff
        local position3 = a315.Position
        local color32 = Color3.fromRGB(170, 166, 160)
        local v340 = v322 and 2 or 5
        puff2(position3, color32, v340, v323 * 1.5, 1.5, 2.4)
    end
end

local v341 = {Arrow = true, Bolt = true, Javelin = true, Knife = true, Harpoon = true, FireArrow = true, FireBolt = true}
local v342 = {
    Arrow = {"Arrow_Flesh", "Arrow_Thunk"},
    Bolt = {"Arrow_Flesh", "Arrow_Thunk"},
    Ball = {"Hit_Melee_Heavy", "Impact_Dirt"},
    Pellet = {"Hit_Melee", "Impact_Dirt"},
    Knife = {"Knife_Hit", "Knife_Thunk"},
    Javelin = {"Spear_Hit", "Javelin_Hit"},
    Stone = {"Stone_Hit", "Impact_Stone"},
    FireArrow = {"Arrow_Flesh", "Arrow_Thunk"},
    FireBolt = {"Arrow_Flesh", "Arrow_Thunk"},
    Bolas = {"Stone_Hit", "Impact_Stone"},
    Harpoon = {"Harpoon_Hit", "Harpoon_Thunk"},
    Hatchet = {"Hatchet_Hit", "Hatchet_Thunk"}
}
local v343 = {Knife = 24, Stone = 10, FireBomb = 6, SmokeBomb = 6, Bolas = 16, Flask = 6, Chakram = 30, Caltrops = 7, Hatchet = 20, Beehive = 5}
local v344 = {Bolas = true, Chakram = true}
local v345 = {}
local v346 = {Knife = 4, Bolas = 4, Chakram = 4, Stone = 5, FireBomb = 3.6, SmokeBomb = 3.6, Flask = 3.6, Caltrops = 3.6, Javelin = 7, Harpoon = 7, Hatchet = 4.5, Beehive = 3.6, Arrow = 6, FireArrow = 6, Bolt = 5, FireBolt = 5}
local v347 = {Knife = 0.1}
local v348 = nil
local v349 = nil

function v15.SetViewHandOff(a350, a351)
    --[[
      name: SetViewHandOff
      line: 812
      upvalues:
        v348 (ref, index: 1)
        v349 (ref, index: 2)
    ]]
    v348 = a350
    v349 = a351
end

local function setModelCFrame(modelCFrame, cFrame)
    --[[
      name: setModelCFrame
      line: 816
    ]]
    if modelCFrame:IsA("Model") then
        modelCFrame:PivotTo(cFrame)
        return
    end

    if modelCFrame:IsA("BasePart") then
        modelCFrame.CFrame = cFrame
    end
end

local function fadeOut(model, a357: number, a358: number?)
    --[[
      name: fadeOut
      line: 824
      upvalues:
        tweenService (copy, index: 1)
        release (copy, index: 2)
    ]]
    for _, instance in model:GetDescendants() do
        if instance:IsA("ParticleEmitter") or instance:IsA("Trail") or instance:IsA("Beam") then
            instance.Enabled = false
        elseif instance:IsA("PointLight") then
            local propertyTable = {Brightness = 0}
            tweenService:Create(instance, TweenInfo.new(a357), propertyTable):Play()
        end
    end

    local taskDelay = task.delay
    local v363 = a358 or a357 + 0.6
    taskDelay(
        v363,
        function()
            --[[
              line: 832
              upvalues:
                release (copy, index: 1)
                model (copy, index: 2)
            ]]
            release(model)
        end
    )
end

local function lowDetail(model)
    --[[
      name: lowDetail
      line: 837
    ]]
    for _, descendant in model:GetDescendants() do
        if descendant:IsA("ParticleEmitter")
            or descendant:IsA("Trail")
            or descendant:IsA("Beam")
            or descendant:IsA("PointLight")
        then
            descendant.Enabled = false
        end
    end
end

local function hideBody(model)
    --[[
      name: hideBody
      line: 845
    ]]
    for _, descendant in model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1
        end
    end

    if model:IsA("BasePart") then
        model.Transparency = 1
    end
end

function v15.MyKey(a372)
    --[[
      name: MyKey
      line: 857
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return (`p{localPlayer.UserId}:{a372}`)
end

local v373 = {}
local v374 = {}

local function paramsFor(a376)
    --[[
      name: paramsFor
      line: 863
      upvalues:
        v374 (copy, index: 1)
        v373 (copy, index: 2)
        Util (copy, index: 3)
        localPlayer (copy, index: 4)
    ]]
    local v377 = a376 or v374
    local v378 = v373[v377]
    local timestamp = os.clock()

    if v378 and timestamp - v378.t < 1 then
        return v378.p
    end

    local v380 = {}

    if a376 then
        table.insert(v380, a376)
        local matchId = a376:GetAttribute("MatchId")
        local team = a376:GetAttribute("Team")

        if type(matchId) == "string" and matchId ~= "" then
            for _, v384 in Util.Targets() do
                if v384:GetAttribute("MatchId") == matchId and v384:GetAttribute("Team") == team then
                    table.insert(v380, v384)
                end
            end

            local character = localPlayer.Character

            if character
                and a376 ~= character
                and character:GetAttribute("MatchId") == matchId
                and character:GetAttribute("Team") == team
            then
                table.insert(v380, character)
            end
        end
    end

    local p = RaycastParams.new()
    p.FilterType = Enum.RaycastFilterType.Exclude
    local v387 = {workspace:FindFirstChild("FX"), workspace:FindFirstChild("Projectiles")}
    local filterDescendantsInstances = {}

    for _, instance in v387 do
        if instance then
            table.insert(filterDescendantsInstances, instance)
        end
    end

    for _, v392 in v380 do
        table.insert(filterDescendantsInstances, v392)
    end

    p.FilterDescendantsInstances = filterDescendantsInstances
    p.IgnoreWater = true
    v373[v377] = {p = p, t = timestamp}

    return p
end

task.spawn(
    function()
        --[[
          line: 904
          upvalues:
            v373 (copy, index: 1)
        ]]
        while true do
            task.wait(3)
            local timestamp = os.clock()

            for v394, v395 in v373 do
                if 2 < timestamp - v395.t then
                    v373[v394] = nil
                end
            end
        end
    end
)

local v396 = 0

local function fallbackModel(kind)
    --[[
      name: fallbackModel
      line: 918
      upvalues:
        prep (copy, index: 1)
    ]]
    local size
    local part = Instance.new("Part")

    if kind == "Ball" or kind == "Pellet" or kind == "Stone" then
        size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896)
    else
        size = Vector3.new(0.20000000298023224, 0.20000000298023224, 2)
    end

    part.Size = size
    part.Material = Enum.Material.SmoothPlastic
    part.Color = Color3.fromRGB(90, 85, 80)
    prep(part)

    return part
end

local v401 = {}
local count = 0

local function dropLine(key, a405: number)
    --[[
      name: dropLine
      line: 934
      upvalues:
        v401 (copy, index: 1)
        tweenService (copy, index: 2)
        debris (copy, index: 3)
    ]]
    local v406 = v401[key]
    if not v406 then
        return
    end

    local token = v406.token

    task.delay(
        a405,
        function()
            --[[
              line: 940
              upvalues:
                v401 (copy, index: 1)
                key (copy, index: 2)
                token (copy, index: 3)
                v406 (copy, index: 4)
                tweenService (copy, index: 5)
                debris (copy, index: 6)
            ]]
            local v408 = v401[key]

            if v408 and v408.token == token then
                v401[key] = nil
            end

            if v406.beam.Parent then
                local propertyTable = {Width0 = 0, Width1 = 0}
                tweenService:Create(v406.beam, TweenInfo.new(0.15), propertyTable):Play()
            end

            debris:AddItem(v406.beam, 0.2)
            debris:AddItem(v406.a0, 0.2)
            debris:AddItem(v406.a1, 0.2)
        end
    )
end

local part = nil
local renderSteppedConnection = nil

local function viewLineHand()
    --[[
      name: viewLineHand
      line: 959
      upvalues:
        part (ref,  index: 1)
        renderSteppedConnection (ref,  index: 2)
        runService (copy, index: 3)
    ]]
    local camera = workspace.CurrentCamera
    if not camera then
        return nil
    end

    local tribesViewLineAnchor = part

    if not tribesViewLineAnchor or not tribesViewLineAnchor.Parent then
        tribesViewLineAnchor = Instance.new("Part")
        tribesViewLineAnchor.Name = "TribesViewLineAnchor"
        tribesViewLineAnchor.Anchored = true
        tribesViewLineAnchor.CanCollide = false
        tribesViewLineAnchor.CanQuery = false
        tribesViewLineAnchor.CanTouch = false
        tribesViewLineAnchor.CastShadow = false
        tribesViewLineAnchor.Transparency = 1
        tribesViewLineAnchor.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        tribesViewLineAnchor.Parent = camera
        part = tribesViewLineAnchor
    end

    renderSteppedConnection = renderSteppedConnection
        or runService.RenderStepped:Connect(
            function()
                --[[
                  line: 980
                  upvalues:
                    part (ref, index: 1)
                ]]
                local part2 = part
                local camera = workspace.CurrentCamera

                if part2 and camera then
                    part2.CFrame = camera.CFrame * CFrame.new(0.3, -0.36, -0.7)
                end
            end
        )

    return tribesViewLineAnchor
end

local function addLine(key, model, a420)
    --[[
      name: addLine
      line: 991
      upvalues:
        Util (copy, index: 1)
        localPlayer (copy, index: 2)
        viewLineHand (copy, index: 3)
        v401 (copy, index: 4)
        count (ref,  index: 5)
        tweenService (copy, index: 6)
        debris (copy, index: 7)
    ]]
    local v421

    if not a420 then
        return
    end

    local v422 = Util.Drawn(a420)
    local v423 = if v422 and v422:IsA("Model") then v422 else a420
    local v424 = v423:FindFirstChild("RightHand") or a420:FindFirstChild("RightHand")

    if a420 == localPlayer.Character and Util.InFirstPerson() then
        v424 = viewLineHand() or v424
    end

    if model:IsA("Model") then
        v421 = model.PrimaryPart
    else
        v421 = if model:IsA("BasePart") then model else nil
    end

    if not v424 or not v424:IsA("BasePart") or not v421 then
        return
    elseif const v425 = v401[key] then
        v425.beam:Destroy()
        v425.a0:Destroy()
        v425.a1:Destroy()
    end

    local harpoonLineHand = Instance.new("Attachment")
    harpoonLineHand.Name = "HarpoonLineHand"
    harpoonLineHand.Parent = v424

    local harpoonLineEnd = Instance.new("Attachment")
    harpoonLineEnd.Name = "HarpoonLineEnd"
    harpoonLineEnd.Position = Vector3.new(0, 0, 4.599999904632568)
    harpoonLineEnd.Parent = v421

    local harpoonLine = Instance.new("Beam")
    harpoonLine.Name = "HarpoonLine"
    harpoonLine.Attachment0 = harpoonLineHand
    harpoonLine.Attachment1 = harpoonLineEnd
    harpoonLine.FaceCamera = true
    harpoonLine.Width0 = 0.14
    harpoonLine.Width1 = 0.14
    harpoonLine.Segments = 1
    harpoonLine.Color = ColorSequence.new(Color3.fromRGB(196, 164, 112))
    harpoonLine.Transparency = NumberSequence.new(0)
    harpoonLine.LightEmission = 0
    harpoonLine.LightInfluence = 1
    harpoonLine.Parent = v421
    count += 1
    local v429 = {a0 = harpoonLineHand, a1 = harpoonLineEnd, beam = harpoonLine, token = count}
    v401[key] = v429

    if const v430 = v401[key] then
        local token = v430.token

        task.delay(
            3,
            function()
                --[[
                  line: 940
                  upvalues:
                    v401 (copy, index: 1)
                    key (copy, index: 2)
                    token (copy, index: 3)
                    v430 (copy, index: 4)
                    tweenService (copy, index: 5)
                    debris (copy, index: 6)
                ]]
                local v432 = v401[key]

                if v432 and v432.token == token then
                    v401[key] = nil
                end

                if v430.beam.Parent then
                    local propertyTable = {Width0 = 0, Width1 = 0}
                    tweenService:Create(v430.beam, TweenInfo.new(0.15), propertyTable):Play()
                end

                debris:AddItem(v430.beam, 0.2)
                debris:AddItem(v430.a0, 0.2)
                debris:AddItem(v430.a1, 0.2)
            end
        )
    end

    v401[key] = v429
end

v15.ParamsOverride = nil

function v15.Projectile(key, kind, origin: Vector3, a437, a438, a439, predict)
    --[[
      name: Projectile
      line: 1044
      upvalues:
        localPlayer (copy, index: 1)
        v15 (copy, index: 2)
        v396 (ref,  index: 3)
        Quality (copy, index: 4)
        template (copy, index: 5)
        takeFromPool (copy, index: 6)
        fallbackModel (copy, index: 7)
        lowDetail (copy, index: 8)
        fx2 (ref,  index: 9)
        ballistics (copy, index: 10)
        paramsFor (copy, index: 11)
        v343 (copy, index: 12)
        v348 (ref,  index: 13)
        Util (copy, index: 14)
        v349 (ref,  index: 15)
        v347 (copy, index: 16)
        v345 (copy, index: 17)
        release (copy, index: 18)
        addLine (copy, index: 19)
    ]]
    local params
    local view2
    local mine = a439 ~= nil and a439 == localPlayer.Character
    local far = not mine
    if far then
        local v446 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - origin).Magnitude else 0
        far = v15.NEAR < v446
    end

    if not mine and Quality.maxFlying <= v396 then
        return nil
    end

    local model = if const v447 = template("Projectiles/" .. kind) then takeFromPool("Projectiles/" .. kind, v447) else fallbackModel(kind)
    local cFrame = CFrame.lookAt(origin, origin + a437)

    if model:IsA("Model") then
        model:PivotTo(cFrame)
    elseif model:IsA("BasePart") then
        model.CFrame = cFrame
    end

    if far or not mine and not Quality.layers then
        lowDetail(model)
    end

    model:SetAttribute("CosKey", key)

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    local v451 = false
    model.Parent = fx2
    local v452 = {landed = false, impactPlayed = false, key = key, kind = kind, model = model, shot = ballistics.new(origin, a437, a438, 0)}

    if v15.ParamsOverride then
        params = v15.ParamsOverride(a439)

        if not params then
            v451 = true
        end
    else
        v451 = true
    end

    if v451 then
        params = paramsFor(a439)
    end

    v452.params = params
    v452.born = os.clock()
    v452.mine = mine
    v452.far = far
    v452.spin = v343[kind] or 0
    v452.predict = predict
    v452.origin = origin

    if not mine or not v348 or not Util.InFirstPerson() then
        view2 = nil
    else
        local v453 = {t0 = 0}
        local timestamp = os.clock()
        local v455 = not v349 and 0 or v349()
        v453.at = timestamp + math.clamp(v455, 0, 0.3)
        v453.dur = v347[kind] or 0.12
        v453.trails = {}
        view2 = v453
    end

    v452.view = view2

    if const view = v452.view then
        for _, descendant in model:GetDescendants() do
            if descendant:IsA("Trail") and descendant.Enabled then
                descendant.Enabled = false
                table.insert(view.trails, descendant)
            end
        end
    end

    if const v459 = v345[key] then
        if not v459.landed then
            v396 -= 1
        end

        if v459.stopLoop then
            v459.stopLoop(0)
        end

        release(v459.model)
    end

    local v460 = kind == "FireBomb" and "FireBomb_Fuse"
        or kind == "Beehive" and "Bees_Loop"
        or kind == "Hatchet" and "Hatchet_Spin"
        or nil

    if v460 and not far then
        local v461

        if model:IsA("Model") then
            v461 = model.PrimaryPart
        else
            v461 = if model:IsA("BasePart") then model else nil
        end

        if v461 then
            v452.stopLoop = Util.Loop(v460, v461)
        end
    end

    v345[key] = v452
    v396 += 1

    if kind == "Harpoon" and not far then
        addLine(key, model, a439)
    end

    return v452
end

function v15.Pellets(a462, a463, a464, a465, a466, a467, a468, a469, a470, a471, a472)
    --[[
      name: Pellets
      line: 1112
      upvalues:
        Combat (copy, index: 1)
        v15 (copy, index: 2)
    ]]
    local v473 = Combat.PelletDirs(a465, a468, a469, a470)

    for v474, v475 in v473 do
        v15.Projectile(`{a462}/{v474}`, a463, a464, v475 * a466, a467, a471, a472)
    end
end

local v476 = {FireBomb = true, SmokeBomb = true, Flask = true, Caltrops = true, Beehive = true}
local v477 = {}

local function hitSound(kind, a480: boolean, position)
    --[[
      name: hitSound
      line: 1124
      upvalues:
        v342 (copy, index: 1)
        v477 (copy, index: 2)
        Util (copy, index: 3)
    ]]
    local v482 = v342[kind]
    if not v482 then
        return
    end

    local v483 = a480 and "b" or "w"
    local v484 = kind .. v483
    local timestamp = os.clock()

    if kind == "Pellet" and timestamp - (v477[v484] or 0) < 0.06 then
        return
    end

    v477[v484] = timestamp
    local sound = Util.Sound
    local v487 = if a480 then v482[1] else v482[2]
    sound(v487, position)
end

local function landCosmetic(a489, position, normal, a492, a493: boolean, a494, a495)
    --[[
      name: landCosmetic
      line: 1139
      upvalues:
        v396 (ref,  index: 1)
        v401 (copy, index: 2)
        count (ref,  index: 3)
        tweenService (copy, index: 4)
        debris (copy, index: 5)
        Combat (copy, index: 6)
        v15 (copy, index: 7)
        v341 (copy, index: 8)
        fadeOut (copy, index: 9)
        hitSound (copy, index: 10)
        hideBody (copy, index: 11)
    ]]
    if not a489.landed then
        v396 -= 1
    end

    a489.landed = true

    if a489.stopLoop then
        a489.stopLoop(0.1)
        a489.stopLoop = nil
    end

    if a489.kind == "Harpoon" and v401[a489.key] then
        count += 1
        v401[a489.key].token = count
        local key = a489.key
        local v497 = a493 and 0.75 or 0.2

        if const v498 = v401[key] then
            local token = v498.token

            task.delay(
                v497,
                function()
                    --[[
                      line: 940
                      upvalues:
                        v401 (copy, index: 1)
                        key (copy, index: 2)
                        token (copy, index: 3)
                        v498 (copy, index: 4)
                        tweenService (copy, index: 5)
                        debris (copy, index: 6)
                    ]]
                    local v500 = v401[key]

                    if v500 and v500.token == token then
                        v401[key] = nil
                    end

                    if v498.beam.Parent then
                        local propertyTable = {Width0 = 0, Width1 = 0}
                        tweenService:Create(v498.beam, TweenInfo.new(0.15), propertyTable):Play()
                    end

                    debris:AddItem(v498.beam, 0.2)
                    debris:AddItem(v498.a0, 0.2)
                    debris:AddItem(v498.a1, 0.2)
                end
            )
        end
    end

    if a493 and a489.mine and a494 and not a489.impactPlayed then
        local v502 = nil
        local isHeadPart = false
        local predict = a489.predict

        if predict and type(predict.damage) == "number" then
            local v505 = predict.tuning or {}
            isHeadPart = Combat.IsHeadPart(a495)
            local v506 = predict.damage * Combat.Falloff(v505, (position - a489.origin).Magnitude)
            local v507 = if isHeadPart then v505.headshotMult or 1.5 else 1
            v502 = v506 * v507
        end

        v15.PredictHit(a494, nil, position, true, v502, isHeadPart)
    end

    local v508 = not (0 < a489.shot.vel.Magnitude) and Vector3.new(0, 0, 1) or a489.shot.vel.Unit
    local v509 = not a489.far
    if not v509 then
        local v511 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0
        v509 = v511 <= v15.NEAR
    end

    if v341[a489.kind] then
        local model = a489.model
        local cFrame = CFrame.lookAt(position - (v508 * 0.6), (position - (v508 * 0.6)) + v508)

        if model:IsA("Model") then
            model:PivotTo(cFrame)
        elseif model:IsA("BasePart") then
            model.CFrame = cFrame
        end

        fadeOut(a489.model, 0.2, 4)

        if not a489.impactPlayed and v509 then
            a489.impactPlayed = true

            if not a493 then
                local impact = v15.Impact
                local v515 = a489.kind ~= "Javelin" and 0.8 or 1.3
                impact(position, normal, a492, false, v515)
            end

            hitSound(a489.kind, a493, position)
        end
    elseif a489.kind == "Ball"
        or a489.kind == "Pellet"
        or a489.kind == "Stone"
        or a489.kind == "Bolas"
        or a489.kind == "Hatchet"
    then
        hideBody(a489.model)
        fadeOut(a489.model, 0.08)

        if not a489.impactPlayed and v509 then
            a489.impactPlayed = true
            local v516 = a489.kind == "Pellet"

            if not a493 then
                v15.Impact(position, normal, a492, false, (v516 and 0.45 or a489.kind ~= "Stone" and 0.8 or 0.9))
            end

            hitSound(a489.kind, a493, position)
        end
    else
        hideBody(a489.model)
        fadeOut(a489.model, 0.15)
    end
end

local v517 = false
local partList = {}
local cframeList = {}

runService.Heartbeat:Connect(
    function(deltaTime: number)
        --[[
          line: 1198
          upvalues:
            v517 (ref,  index: 1)
            partList (copy, index: 2)
            cframeList (copy, index: 3)
            v345 (copy, index: 4)
            release (copy, index: 5)
            v396 (ref,  index: 6)
            ballistics (copy, index: 7)
            Combat (copy, index: 8)
            v476 (copy, index: 9)
            Util (copy, index: 10)
            landCosmetic (copy, index: 11)
            v348 (ref,  index: 12)
            v346 (copy, index: 13)
            v344 (copy, index: 14)
            bodyOf (copy, index: 15)
            Metrics (copy, index: 16)
        ]]
        local timestamp = os.clock()
        v517 = not v517
        table.clear(partList)
        table.clear(cframeList)

        for v522, v523 in v345 do
            if v523.landed then
                if 10 < os.clock() - v523.born then
                    v345[v522] = nil
                end
            elseif v523.pending then
                if 1.5 < os.clock() - v523.pending then
                    if v523.stopLoop then
                        v523.stopLoop(0)
                        v523.stopLoop = nil
                    end

                    release(v523.model)
                    v345[v522] = nil
                    v396 -= 1
                end
            elseif v523.model.Parent then
                local origin, direction = ballistics.Advance(v523.shot, deltaTime)
                local raycastResult = nil

                if not v523.far then
                    if v523.mine then
                        raycastResult = workspace:Raycast(origin, direction, v523.params)
                    else
                        local v527 = v523.castFrom or origin

                        if v517 or 30 < (v523.shot.pos - v527).Magnitude then
                            raycastResult = workspace:Raycast(v527, v523.shot.pos - v527, v523.params)
                            v523.castFrom = v523.shot.pos
                        elseif not v523.castFrom then
                            v523.castFrom = origin
                        end
                    end
                end

                if raycastResult then
                    local character = Combat.FindCharacter(raycastResult.Instance)

                    if not character or v476[v523.kind] or not Util.ParryFacing(character, v523.shot.vel) then
                        landCosmetic(v523, raycastResult.Position, raycastResult.Normal, raycastResult.Material.Name, character ~= nil, character, raycastResult.Instance)
                    else
                        v523.pending = os.clock()
                        local v529 = not (0 < v523.shot.vel.Magnitude) and Vector3.new(0, 0, 1)
                            or v523.shot.vel.Unit
                        local model = v523.model
                        local cFrame = CFrame.lookAt(raycastResult.Position - (v529 * 0.6), (raycastResult.Position - (v529 * 0.6)) + v529)

                        if model:IsA("Model") then
                            model:PivotTo(cFrame)
                        elseif model:IsA("BasePart") then
                            model.CFrame = cFrame
                        end
                    end
                elseif ballistics.Expired(v523.shot) then
                    if v523.stopLoop then
                        v523.stopLoop(0)
                        v523.stopLoop = nil
                    end

                    release(v523.model)
                    v345[v522] = nil
                    v396 -= 1
                elseif not v523.far or v517 then
                    local v532
                    local vel = v523.shot.vel
                    local pos = v523.shot.pos

                    if const view = v523.view then
                        local timestamp2 = os.clock()
                        local camera = workspace.CurrentCamera

                        if timestamp2 < view.at then
                            v532 = v523.shot.pos - Vector3.new(0, 10000, 0)
                        else
                            if view.t0 == 0 then
                                view.t0 = timestamp2
                                v523.spinT0 = timestamp2
                                local v538 = v348 and v348()

                                if v538 and camera then
                                    local cFrame = camera.CFrame
                                    view.p0 = cFrame:PointToObjectSpace(cFrame.Position + ((v538 - cFrame.Position) * (v346[v523.kind]
                                        or 4)))
                                end

                                for _, trail in view.trails do
                                    trail:Clear()
                                    trail.Enabled = true
                                end
                            end

                            local clampedValue = math.clamp((timestamp2 - view.t0) / view.dur, 0, 1)
                            local v543 = 1 - (1 - clampedValue) * (1 - clampedValue)

                            if const p0 = view.p0 then
                                if camera then
                                    local cFrame = camera.CFrame
                                    local objectSpacePos = cFrame:PointToObjectSpace(v523.shot.pos)

                                    if not (objectSpacePos.Z < -0.05) then
                                        v532 = pos
                                    elseif not (p0.Z < -0.05) then
                                        v532 = pos
                                    else
                                        local v547 = -p0.Z
                                        local v548 = -objectSpacePos.Z
                                        local v549 = v547 + (v548 - v547) * v543
                                        local v550 = p0.X / v547 + (objectSpacePos.X / v548 - (p0.X / v547)) * v543
                                        local v551 = p0.Y / v547 + (objectSpacePos.Y / v548 - (p0.Y / v547)) * v543
                                        v532 = cFrame:PointToWorldSpace((Vector3.new(v550 * v549, v551 * v549, -v549)))
                                    end
                                else
                                    v532 = pos
                                end
                            else
                                v532 = pos
                            end

                            if 1 <= clampedValue then
                                v523.view = nil
                            end
                        end
                    else
                        v532 = pos
                    end

                    if 0.01 < vel.Magnitude then
                        local cframe = CFrame.lookAt(v532, v532 + vel)

                        if 0 < v523.spin then
                            local timestamp3 = os.clock()
                            local v554 = v523.spinT0 or v523.born
                            local rotationY = (timestamp3 - v554) * v523.spin
                            local cframe2 = if v344[v523.kind] then CFrame.Angles(0, rotationY, 0) else CFrame.Angles(-rotationY, 0, 0)
                            cframe *= cframe2
                        end

                        local v557 = bodyOf(v523.model)

                        for relKey, part in v557.parts do
                            table.insert(partList, part)
                            table.insert(cframeList, cframe * v557.rels[relKey])
                        end
                    end
                end
            else
                v345[v522] = nil
                v396 -= 1
            end
        end

        if 0 < #partList then
            workspace:BulkMoveTo(partList, cframeList, Enum.BulkMoveMode.FireCFrameChanged)
        end

        Metrics.AddProj(os.clock() - timestamp, v396)
    end
)

function v15.ResolveProjectile(a560)
    --[[
      name: ResolveProjectile
      line: 1326
      upvalues:
        v345 (copy, index: 1)
        release (copy, index: 2)
        v396 (ref,  index: 3)
        landCosmetic (copy, index: 4)
        v341 (copy, index: 5)
        v15 (copy, index: 6)
    ]]
    local key = a560.key

    if type(key) ~= "string" then
        return
    end

    local v562 = v345[key]

    if a560.expired then
        if v562 and not v562.landed then
            if v562.stopLoop then
                v562.stopLoop(0)
                v562.stopLoop = nil
            end

            release(v562.model)
            v345[key] = nil
            v396 -= 1

            return
        end

        if v562 and a560.deflected then
            v562.model.Parent = nil
            v345[key] = nil
        end

        return
    end

    local position = a560.position

    if typeof(position) ~= "Vector3" then
        return
    end

    local v564 = a560.character ~= nil

    if v562 then
        if not v562.landed then
            landCosmetic(v562, position, a560.normal, a560.material, v564)
        end

        local part = a560.part
        local rel = a560.rel
        local v567 = v562.model:GetAttribute("CosKey") == key

        if v567
            and v341[v562.kind]
            and typeof(part) == "Instance"
            and part:IsA("BasePart")
            and typeof(rel) == "CFrame"
            and v562.model.Parent
        then
            local v568
            local model = v562.model
            local cFrame = part.CFrame * rel

            if model:IsA("Model") then
                model:PivotTo(cFrame)
            elseif model:IsA("BasePart") then
                model.CFrame = cFrame
            end

            if v562.model:IsA("Model") then
                v568 = v562.model.PrimaryPart
            else
                v568 = if v562.model:IsA("BasePart") then v562.model else nil
            end

            if v568 and not part.Anchored then
                for _, descendant in v562.model:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Anchored = false
                        descendant.Massless = true
                    end
                end

                if v562.model:IsA("BasePart") then
                    v562.model.Anchored = false
                end

                local stickWeld = Instance.new("WeldConstraint")
                stickWeld.Name = "StickWeld"
                stickWeld.Part0 = part
                stickWeld.Part1 = v568
                stickWeld.Parent = v568
            end
        end
    else
        local v575 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0

        if v575 <= v15.NEAR then
            if v564 then
                v15.CharacterImpact(position, nil, false)
                return
            end

            if a560.kind ~= "FireBomb"
                and a560.kind ~= "SmokeBomb"
                and a560.kind ~= "Flask"
                and a560.kind ~= "Caltrops"
                and a560.kind ~= "Beehive"
            then
                local impact = v15.Impact
                local normal = a560.normal
                local material = a560.material
                local v579 = a560.kind ~= "Pellet"
                local v580 = a560.kind ~= "Pellet" and 0.8 or 0.45
                impact(position, normal, material, v579, v580)
            end
        end
    end
end

function v15.Explosion(vector3: Vector3, a582, a583, a584)
    --[[
      name: Explosion
      line: 1397
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
        fx2 (ref,  index: 3)
        tweenService (copy, index: 4)
        debris (copy, index: 5)
        Quality (copy, index: 6)
        groundDecal (copy, index: 7)
        localPlayer (copy, index: 8)
    ]]
    local position, normal
    local v588 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - vector3).Magnitude else 0
    local v589 = v15.NEAR < v588
    local burst = v15.Burst
    local cframe = CFrame.new(vector3)
    local v592 = a582 / 9
    local v593 = v589 and 0.5 or 1
    burst("Explosion_Fire", cframe, v592 * v593, Color3.fromRGB(245, 140, 50), true)
    Util.Sound("FireBomb_Explode", vector3)
    local v594 = a583 or a582 * 0.8
    local v595 = a584 or 2.2
    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(vector3 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a582 + 1.5), 0), raycastParams) then
        position = raycastResult.Position
        normal = raycastResult.Normal
    else
        position, normal = nil, nil
    end

    if not v589 then
        local cFrame = CFrame.new(vector3)
        local color, v600, v601 = Color3.fromRGB(245, 125, 40)
        local explosionCore = Instance.new("Part")
        explosionCore.Name = "ExplosionCore"
        explosionCore.Anchored = true
        explosionCore.CanCollide = false
        explosionCore.CanQuery = false
        explosionCore.CanTouch = false
        explosionCore.CastShadow = false
        explosionCore.Size = Vector3.new(1.5, 1.5, 1.5)
        explosionCore.CFrame = cFrame
        explosionCore.Color = color
        explosionCore.Material = v600 or Enum.Material.SmoothPlastic
        explosionCore.Transparency = v601 or 0

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        explosionCore.Parent = fx2
        explosionCore.Shape = Enum.PartType.Ball
        explosionCore.Transparency = 0.3
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local propertyTable = {Transparency = 1, Size = (Vector3.new(1, 1, 1) * a582) * 0.7, Color = Color3.fromRGB(200, 70, 25)}
        tweenService:Create(explosionCore, tweenInfo, propertyTable):Play()
        debris:AddItem(explosionCore, 0.25)
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 140, 60)
        pointLight.Range = 16
        pointLight.Brightness = 1
        pointLight.Parent = explosionCore
        local cFrame2 = CFrame.new(vector3)
        local color2 = Color3.new()
        local smoothPlastic = Enum.Material.SmoothPlastic
        local puffFx = Instance.new("Part")
        puffFx.Name = "PuffFX"
        puffFx.Anchored = true
        puffFx.CanCollide = false
        puffFx.CanQuery = false
        puffFx.CanTouch = false
        puffFx.CastShadow = false
        puffFx.Size = Vector3.new(1, 1, 1)
        puffFx.CFrame = cFrame2
        puffFx.Color = color2
        puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
        puffFx.Transparency = 1

        if const fx3 = workspace:FindFirstChild("FX") then
            fx2 = fx3
        end

        puffFx.Parent = fx2
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 170, 70), Color3.fromRGB(230, 90, 30))
        particleEmitter.LightEmission = 0.35
        particleEmitter.LightInfluence = 0.4
        particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0)})
        particleEmitter.Lifetime = NumberRange.new(0.6, 1.1)
        particleEmitter.Speed = NumberRange.new(10, 22)
        particleEmitter.SpreadAngle = Vector2.new(70, 70)
        particleEmitter.EmissionDirection = Enum.NormalId.Top
        particleEmitter.Acceleration = Vector3.new(0, -24, 0)
        particleEmitter.Rate = 0
        particleEmitter.Parent = puffFx
        particleEmitter:Emit((math.floor((20 * Quality.particleScale) + 0.5)))
        debris:AddItem(puffFx, 1.3)
    end

    if position and normal then
        if not v589 then
            groundDecal(position, normal, "rbxassetid://10871117278", Color3.fromRGB(235, 140, 70), 2, a582 * 2.4, 0.26, 0.3)
        end

        groundDecal(position, normal, "rbxassetid://10430755572", Color3.fromRGB(60, 32, 22), v594 * 2, v594 * 2.1, 0.15, 0.25, v595)
        local v613 = v589 and 5 or 10

        for index = 1, v613 do
            local v615 = ((index / v613) * math.pi) * 2 + math.random() * 0.5
            local v616 = index == 1 and 0 or v594 * ((math.sqrt((math.random())) * 0.65) + 0.25)
            local v617 = position + Vector3.new(math.cos(v615) * v616, 0.4, math.sin(v615) * v616)
            local cFrame = CFrame.new(v617)
            local color = Color3.new()
            local smoothPlastic = Enum.Material.SmoothPlastic
            local puffFx = Instance.new("Part")
            puffFx.Name = "PuffFX"
            puffFx.Anchored = true
            puffFx.CanCollide = false
            puffFx.CanQuery = false
            puffFx.CanTouch = false
            puffFx.CastShadow = false
            puffFx.Size = Vector3.new(2, 0.5, 2)
            puffFx.CFrame = cFrame
            puffFx.Color = color
            puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
            puffFx.Transparency = 1

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            puffFx.Parent = fx2
            local particleEmitter = Instance.new("ParticleEmitter")
            particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
            particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 190, 80), Color3.fromRGB(235, 90, 30))
            particleEmitter.LightEmission = 0.35
            particleEmitter.LightInfluence = 0.3
            particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.5), NumberSequenceKeypoint.new(0.4, 4.5), NumberSequenceKeypoint.new(1, 0)})
            particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
            particleEmitter.Lifetime = NumberRange.new(0.6, 0.9)
            particleEmitter.Speed = NumberRange.new(3, 5)
            particleEmitter.SpreadAngle = Vector2.new(10, 10)
            particleEmitter.EmissionDirection = Enum.NormalId.Top
            particleEmitter.Rotation = NumberRange.new(-20, 20)
            local v624 = v589 and 0.6 or 1
            particleEmitter.Rate = v624 * 14
            particleEmitter.Shape = Enum.ParticleEmitterShape.Box
            particleEmitter.Parent = puffFx
            task.delay(
                v595,
                function()
                    --[[
                      line: 1471
                      upvalues:
                        particleEmitter (copy, index: 1)
                    ]]
                    particleEmitter.Enabled = false
                end
            )
            debris:AddItem(puffFx, v595 + 1)
        end

        local v625 = position + Vector3.new(0, 1.5, 0)
        local size = Vector3.new(v594, 1, v594)
        local cFrame = CFrame.new(v625)
        local color = Color3.new()
        local smoothPlastic = Enum.Material.SmoothPlastic
        local puffFx = Instance.new("Part")
        puffFx.Name = "PuffFX"
        puffFx.Anchored = true
        puffFx.CanCollide = false
        puffFx.CanQuery = false
        puffFx.CanTouch = false
        puffFx.CastShadow = false
        puffFx.Size = size
        puffFx.CFrame = cFrame
        puffFx.Color = color
        local smoothPlastic2 = smoothPlastic or Enum.Material.SmoothPlastic
        puffFx.Material = smoothPlastic2
        puffFx.Transparency = 1

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        puffFx.Parent = fx2
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(80, 55, 45))
        particleEmitter.LightEmission = 0
        particleEmitter.LightInfluence = 1
        particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 5)})
        particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 1)})
        particleEmitter.Lifetime = NumberRange.new(1.5, 2.2)
        particleEmitter.Speed = NumberRange.new(3, 5)
        particleEmitter.EmissionDirection = Enum.NormalId.Top
        particleEmitter.SpreadAngle = Vector2.new(8, 8)
        particleEmitter.Rate = 6
        particleEmitter.Parent = puffFx
        task.delay(
            v595,
            function()
                --[[
                  line: 1491
                  upvalues:
                    particleEmitter (copy, index: 1)
                ]]
                particleEmitter.Enabled = false
            end
        )
        debris:AddItem(puffFx, v595 + 2.5)
    end

    local character = localPlayer.Character

    if const humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart") then
        local magnitude = (humanoidRootPart.Position - vector3).Magnitude

        if magnitude < a582 * 4 then
            Util.Shake(math.clamp(1.4 * (1 - (magnitude / (a582 * 4))), 0.2, 1.4), 0.45)
        end
    end
end

function v15.SmokeCloud(vector3: Vector3, a638, a639)
    --[[
      name: SmokeCloud
      line: 1507
      upvalues:
        Combat (copy, index: 1)
        fx2 (ref,  index: 2)
        v15 (copy, index: 3)
        Util (copy, index: 4)
    ]]
    Combat.AddSmoke(vector3, a638, a639)
    local size = Vector3.new(a638 * 1.5, a638 * 0.9, a638 * 1.5)
    local cFrame = CFrame.new(vector3)
    local color = Color3.new()
    local smoothPlastic = Enum.Material.SmoothPlastic
    local puffFx = Instance.new("Part")
    puffFx.Name = "PuffFX"
    puffFx.Anchored = true
    puffFx.CanCollide = false
    puffFx.CanQuery = false
    puffFx.CanTouch = false
    puffFx.CastShadow = false
    puffFx.Size = size
    puffFx.CFrame = cFrame
    puffFx.Color = color
    puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
    puffFx.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    puffFx.Parent = fx2
    local color3 = Color3.fromRGB(176, 180, 186)

    local function emitter(name: string, a649, a650, a651: number, rate: number)
        --[[
          name: emitter
          line: 1511
          upvalues:
            color3 (copy, index: 1)
            puffFx (copy, index: 2)
        ]]
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Name = name
        particleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
        particleEmitter.Color = ColorSequence.new(color3)
        particleEmitter.LightEmission = 0
        particleEmitter.LightInfluence = 1
        particleEmitter.Shape = Enum.ParticleEmitterShape.Sphere
        particleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
        particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a649), NumberSequenceKeypoint.new(1, a650)})
        particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.06), NumberSequenceKeypoint.new(0.75, 0.12), NumberSequenceKeypoint.new(1, 1)})
        particleEmitter.Lifetime = NumberRange.new(a651 * 0.8, a651)
        particleEmitter.Rate = rate
        particleEmitter.Speed = NumberRange.new(0.4, 1.4)
        particleEmitter.SpreadAngle = Vector2.new(180, 180)
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.RotSpeed = NumberRange.new(-12, 12)
        particleEmitter.Drag = 1
        particleEmitter.Parent = puffFx
        return particleEmitter
    end

    local particleEmitter = emitter("Body", a638 * 0.7, a638 * 0.95, 3.2, 34)
    local particleEmitter2 = emitter("Low", a638 * 0.5, a638 * 0.7, 2.6, 16)
    particleEmitter2.Acceleration = Vector3.new(0, -0.6000000238418579, 0)
    particleEmitter:Emit(30)
    particleEmitter2:Emit(10)
    v15.Puff(vector3, color3, 14, a638 * 0.4, 16, 0.8)
    Util.Sound("Smoke_Pop", vector3)

    task.delay(
        math.max(0.5, a639 - 2.6),
        function()
            --[[
              line: 1545
              upvalues:
                particleEmitter (copy, index: 1)
                particleEmitter2 (copy, index: 2)
            ]]
            particleEmitter.Enabled = false
            particleEmitter2.Enabled = false
        end
    )

    task.delay(
        a639 + 1.5,
        function()
            --[[
              line: 1549
              upvalues:
                puffFx (copy, index: 1)
            ]]
            puffFx:Destroy()
        end
    )
end

function v15.TrapSnap(vector3: Vector3)
    --[[
      name: TrapSnap
      line: 1555
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    v15.Burst("Impact_Sparks", CFrame.new(vector3 + Vector3.new(0, 0.5, 0)), 1.4)
    v15.Burst("Impact_Dust", CFrame.lookAt(vector3, vector3 + Vector3.new(0, 1, 0)), 1.2)
    Util.Sound("Trap_Snap", vector3)
end

function v15.ChargeGlow(a657, a658, a659)
    --[[
      name: ChargeGlow
      line: 1565
      upvalues:
        Util (copy, index: 1)
        v15 (copy, index: 2)
        Quality (copy, index: 3)
    ]]
    if not a657 then
        return
    end

    local v660 = Util.Drawn(a657) or a657
    local v661 = a659 or v15.WeaponColor(a657)

    if a658 <= 0.01 then
        for _, v663 in {a657, v660} do
            if const combatChargeHl = v663:FindFirstChild("CombatChargeHL") then
                combatChargeHl:Destroy()
            end

            local v665 = v663:FindFirstChild("Muzzle", true)
            v665 = v665 and v665:FindFirstChild("CombatGlow")

            if v665 then
                v665:Destroy()
            end
        end

        return
    end

    local v666 = v660:FindFirstChild("CombatChargeHL")
    local muzzle = v660:FindFirstChild("Muzzle", true)
    local v668 = muzzle and muzzle:FindFirstChild("CombatGlow")

    if not v666 and Quality.highlights then
        v666 = Instance.new("Highlight")
        v666.Name = "CombatChargeHL"
        v666.DepthMode = Enum.HighlightDepthMode.Occluded
        v666.Adornee = v660
        v666.FillTransparency = 1
        v666.Parent = v660
    end

    if v666 then
        v666.OutlineColor = v661
        local v669 = not (1 <= a658) and 0.6 or 0.9
        v666.OutlineTransparency = 1 - (a658 * v669)
    end

    if muzzle and muzzle:IsA("Attachment") then
        if not v668 then
            v668 = Instance.new("PointLight")
            v668.Name = "CombatGlow"
            v668.Range = 5
            v668.Shadows = false
            v668.Parent = muzzle
        end

        v668.Color = v661
        v668.Brightness = math.min(1, a658 * 0.8)
    end
end

function v15.ChargePing(a670, a671)
    --[[
      name: ChargePing
      line: 1618
      upvalues:
        Util (copy, index: 1)
        fx2 (ref,  index: 2)
        tweenService (copy, index: 3)
        debris (copy, index: 4)
        v15 (copy, index: 5)
    ]]
    local v672 = Util.Drawn(a670)
    local v673 = v672 and (v672:FindFirstChild("Muzzle", true) or v672:FindFirstChild("Tip", true))

    if not v673 or not v673:IsA("Attachment") then
        return
    end

    local worldCFrame = v673.WorldCFrame
    local color = a671 or Color3.fromRGB(245, 175, 60)
    local forceField = Enum.Material.ForceField
    local chargePing = Instance.new("Part")
    chargePing.Name = "ChargePing"
    chargePing.Anchored = true
    chargePing.CanCollide = false
    chargePing.CanQuery = false
    chargePing.CanTouch = false
    chargePing.CastShadow = false
    chargePing.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896)
    chargePing.CFrame = worldCFrame
    chargePing.Color = color
    chargePing.Material = forceField or Enum.Material.SmoothPlastic
    chargePing.Transparency = 0

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    chargePing.Parent = fx2
    chargePing.Shape = Enum.PartType.Ball
    local propertyTable = {Size = Vector3.new(1.7999999523162842, 1.7999999523162842, 1.7999999523162842), Transparency = 1}
    tweenService:Create(chargePing, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    debris:AddItem(chargePing, 0.25)
    v15.Burst("Charge_Sparkle", v673.WorldCFrame, 1, a671, a671 ~= nil)
end

local function torso(a681)
    --[[
      name: torso
      line: 1633
    ]]
    local v682 = a681:FindFirstChild("UpperTorso")
        or a681:FindFirstChild("Torso")
        or a681:FindFirstChild("HumanoidRootPart")

    if v682 and v682:IsA("BasePart") then
        return v682
    end

    return nil
end

function v15.Heal(a683, a684: number)
    --[[
      name: Heal
      line: 1639
      upvalues:
        Util (copy, index: 1)
        v15 (copy, index: 2)
        Quality (copy, index: 3)
        debris (copy, index: 4)
    ]]
    if not a683 or not a683:IsA("Model") then
        return
    end

    local v685 = Util.Drawn(a683)
    local v686 = if v685 and v685:IsA("Model") then v685 else a683
    local v687 = v686:FindFirstChild("UpperTorso")
        or v686:FindFirstChild("Torso")
        or v686:FindFirstChild("HumanoidRootPart")
    local v688 = if v687 and v687:IsA("BasePart") then v687 else nil
    if not v688 then
        return
    end

    v15.Burst("Heal_Health", v688.CFrame)
    Util.Sound("Herbs_Heal", v688)
    local combatHealFx = Instance.new("Attachment")
    combatHealFx.Name = "CombatHealFX"
    combatHealFx.Parent = v688

    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(120, 220, 110))
    particleEmitter.LightEmission = 0.3
    particleEmitter.LightInfluence = 0.5
    particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0)})
    particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter.Lifetime = NumberRange.new(0.6, 1)
    particleEmitter.Speed = NumberRange.new(1.5, 3)
    particleEmitter.SpreadAngle = Vector2.new(40, 40)
    particleEmitter.EmissionDirection = Enum.NormalId.Top
    particleEmitter.Shape = Enum.ParticleEmitterShape.Cylinder
    particleEmitter.Rate = 16 * Quality.particleScale
    particleEmitter.Parent = combatHealFx
    task.delay(
        a684,
        function()
            --[[
              line: 1667
              upvalues:
                particleEmitter (copy, index: 1)
            ]]
            particleEmitter.Enabled = false
        end
    )
    debris:AddItem(combatHealFx, a684 + 1.2)
end

local v691 = {}

function v15.Status(key, key2, a694: number)
    --[[
      name: Status
      line: 1675
      upvalues:
        Util (copy, index: 1)
        v15 (copy, index: 2)
        v691 (copy, index: 3)
        template (copy, index: 4)
        debris (copy, index: 5)
    ]]
    if not key or not key:IsA("Model") then
        return
    end

    local v695 = Util.Drawn(key)
    local v696 = if v695 and v695:IsA("Model") then v695 else key
    local v697 = v696:FindFirstChild("UpperTorso")
        or v696:FindFirstChild("Torso")
        or v696:FindFirstChild("HumanoidRootPart")
    local v698 = if v697 and v697:IsA("BasePart") then v697 else nil
    if not v698 then
        return
    end

    if key2 == "Snare" then
        local snare = v15.Snare
        local v700 = if v695 and v695:IsA("Model") then v695 else key
        snare(v700, a694)

        return
    end

    local v701

    if key2 ~= "Burn" then
        return
    elseif const v702 = v691[key] then
        v701 = v702
    else
        local v703 = {}
        v691[key] = v703
        key.Destroying:Once(
            function()
                --[[
                  line: 1695
                  upvalues:
                    v691 (copy, index: 1)
                    key (copy, index: 2)
                ]]
                v691[key] = nil
            end
        )
        v701 = v703
    end

    local v704 = false
    local v705 = v701[key2]

    if v705 then
        if not v705.inst.Parent then
            v704 = true
        end
    else
        v704 = true
    end

    if v704 then
        local v706 = template("Status_Burn")
        if not v706 then
            return
        end

        local inst = v706:Clone()

        if not inst:IsA("Attachment") then
            inst:Destroy()
            return
        end

        inst.Parent = v698
        v705 = {token = 0, inst = inst}
        v701[key2] = v705
    end

    local v708 = v705
    v708.token += 1
    local token = v708.token

    task.delay(
        a694,
        function()
            --[[
              line: 1718
              upvalues:
                v708 (copy, index: 1)
                token (copy, index: 2)
                debris (copy, index: 3)
                v701 (ref,  index: 4)
                key2 (copy, index: 5)
            ]]
            if v708.token ~= token then
                return
            end

            for _, descendant in v708.inst:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false
                end
            end

            debris:AddItem(v708.inst, 1)

            if v701[key2] == v708 then
                v701[key2] = nil
            end
        end
    )
end

local v712 = {}

function v15.Snare(parent: Instance?, a714: number)
    --[[
      name: Snare
      line: 1736
      upvalues:
        v712 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local v715 = (v712[parent] or 0) + 1
    v712[parent] = v715

    if const combatSnareFx2 = parent:FindFirstChild("CombatSnareFX") then
        combatSnareFx2:Destroy()
    end

    local leftLowerLeg = parent:FindFirstChild("LeftLowerLeg")
    local rightLowerLeg = parent:FindFirstChild("RightLowerLeg")
    local instance = if leftLowerLeg and leftLowerLeg:IsA("BasePart") then leftLowerLeg else nil
    local instance2 = if rightLowerLeg and rightLowerLeg:IsA("BasePart") then rightLowerLeg else nil

    if not instance or not instance2 then
        return
    end

    local combatSnareFx = Instance.new("Model")
    combatSnareFx.Name = "CombatSnareFX"

    local function piece(name: string, size: Vector3, cframe: CFrame, color: Color3, a727: boolean)
        --[[
          name: piece
          line: 1752
          upvalues:
            instance (copy, index: 1)
            combatSnareFx (copy, index: 2)
        ]]
        local part = Instance.new("Part")
        part.Name = name
        part.Size = size
        part.Color = color
        part.Material = Enum.Material.SmoothPlastic

        if a727 then
            part.Shape = Enum.PartType.Ball
        end

        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.Massless = true
        part.CastShadow = false
        part.CFrame = instance.CFrame * cframe
        local weldConstraint = Instance.new("WeldConstraint")
        weldConstraint.Part0 = instance
        weldConstraint.Part1 = part
        weldConstraint.Parent = part
        part.Parent = combatSnareFx
    end

    local objectSpacePosition = instance.CFrame:PointToObjectSpace(instance2.Position)
    local cframe = CFrame.new(objectSpacePosition / 2)
    local x = math.abs(objectSpacePosition.X) + instance.Size.X + 0.16
    local z = instance.Size.Z + 0.16
    local color = Color3.fromRGB(196, 164, 112)

    for v735, y in {0.28, 0.05, -0.2} do
        local v737
        local name = "Wrap" .. v735
        local size = Vector3.new(x, 0.1, z)
        local cframe2 = cframe * CFrame.new(0, y, 0)
        local cframeAngles = CFrame.Angles

        if v735 == 2 then
            v737 = -6
        else
            v737 = 5
        end

        local cframe3 = cframe2 * cframeAngles(0, 0, (math.rad(v737)))
        local part = Instance.new("Part")
        part.Name = name
        part.Size = size
        part.Color = color
        part.Material = Enum.Material.SmoothPlastic
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.Massless = true
        part.CastShadow = false
        part.CFrame = instance.CFrame * cframe3

        local weldConstraint = Instance.new("WeldConstraint")
        weldConstraint.Part0 = instance
        weldConstraint.Part1 = part
        weldConstraint.Parent = part
        part.Parent = combatSnareFx
    end

    piece("StoneA", Vector3.new(0.46000000834465027, 0.46000000834465027, 0.46000000834465027), cframe * CFrame.new((x / 2) + 0.05, -0.05, 0.2), Color3.fromRGB(128, 124, 118), true)
    piece("StoneB", Vector3.new(0.46000000834465027, 0.46000000834465027, 0.46000000834465027), cframe * CFrame.new((-x / 2) - 0.05, 0.2, -0.2), Color3.fromRGB(96, 92, 88), true)
    combatSnareFx.Parent = parent
    Util.Sound("Stone_Hit", instance)

    task.delay(
        a714,
        function()
            --[[
              line: 1786
              upvalues:
                v712 (copy, index: 1)
                parent (copy, index: 2)
                v715 (copy, index: 3)
                combatSnareFx (copy, index: 4)
            ]]
            if v712[parent] == v715 then
                v712[parent] = nil
                combatSnareFx:Destroy()
            end
        end
    )

    parent.Destroying:Once(
        function()
            --[[
              line: 1792
              upvalues:
                v712 (copy, index: 1)
                parent (copy, index: 2)
            ]]
            v712[parent] = nil
        end
    )
end

local v745 = {}

function v15.Reveal(adornee: Instance?, a747: number)
    --[[
      name: Reveal
      line: 1801
      upvalues:
        v745 (copy, index: 1)
        Quality (copy, index: 2)
        fx2 (ref,  index: 3)
    ]]
    local v748 = (v745[adornee] or 0) + 1
    v745[adornee] = v748
    local color3 = Color3.fromRGB(240, 170, 60)
    local combatReveal = Instance.new("Folder")
    combatReveal.Name = "CombatReveal"

    if Quality.highlights then
        local mark = Instance.new("Highlight")
        mark.Name = "Mark"
        mark.Adornee = adornee
        mark.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        mark.FillColor = color3
        mark.FillTransparency = 0.78
        mark.OutlineColor = color3
        mark.OutlineTransparency = 0.1
        mark.Parent = combatReveal
    end

    local head = adornee:FindFirstChild("Head")

    if head and head:IsA("BasePart") then
        local pin = Instance.new("BillboardGui")
        pin.Name = "Pin"
        pin.Adornee = head
        pin.AlwaysOnTop = true
        pin.Size = UDim2.fromOffset(18, 18)
        pin.StudsOffsetWorldSpace = Vector3.new(0, 2.5999999046325684, 0)
        pin.LightInfluence = 0

        local parent = Instance.new("Frame")
        parent.AnchorPoint = Vector2.new(0.5, 0.5)
        parent.Position = UDim2.fromScale(0.5, 0.5)
        parent.Size = UDim2.fromOffset(11, 11)
        parent.Rotation = 45
        parent.BackgroundColor3 = color3
        parent.BorderSizePixel = 0

        local uiStroke = Instance.new("UIStroke")
        uiStroke.Thickness = 1.5
        uiStroke.Color = Color3.fromRGB(60, 40, 10)
        uiStroke.Parent = parent
        parent.Parent = pin
        pin.Parent = combatReveal
    end

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    combatReveal.Parent = fx2

    task.delay(
        a747,
        function()
            --[[
              line: 1842
              upvalues:
                combatReveal (copy, index: 1)
                v745 (copy, index: 2)
                adornee (copy, index: 3)
                v748 (copy, index: 4)
            ]]
            combatReveal:Destroy()

            if v745[adornee] == v748 then
                v745[adornee] = nil
            end
        end
    )

    adornee.Destroying:Once(
        function()
            --[[
              line: 1848
              upvalues:
                combatReveal (copy, index: 1)
            ]]
            combatReveal:Destroy()
        end
    )
end

function v15.HornBlast(a757)
    --[[
      name: HornBlast
      line: 1854
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
        fx2 (ref,  index: 3)
        tweenService (copy, index: 4)
        debris (copy, index: 5)
    ]]
    local position, normal
    local v761 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a757).Magnitude else 0

    if v15.NEAR < v761 then
        return
    end

    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(a757 + Vector3.new(0, 1.5, 0), Vector3.new(0, -9.5, 0), raycastParams) then
        position = raycastResult.Position
        normal = raycastResult.Normal
    else
        position, normal = nil, nil
    end

    local v764 = position or a757 - Vector3.new(0, 2.799999952316284, 0)
    local v765 = normal or Vector3.new(0, 1, 0)
    local cFrame = CFrame.lookAt(v764 + (v765 * 0.15), v764 + (v765 * 1.15)) * CFrame.Angles(0, 1.5707963267948966, 0)
    local color = Color3.fromRGB(226, 190, 110)
    local smoothPlastic = Enum.Material.SmoothPlastic
    local hornRing = Instance.new("Part")
    hornRing.Name = "HornRing"
    hornRing.Anchored = true
    hornRing.CanCollide = false
    hornRing.CanQuery = false
    hornRing.CanTouch = false
    hornRing.CastShadow = false
    hornRing.Size = Vector3.new(0.05999999865889549, 3, 3)
    hornRing.CFrame = cFrame
    hornRing.Color = color
    hornRing.Material = smoothPlastic or Enum.Material.SmoothPlastic
    hornRing.Transparency = 0.45

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    hornRing.Parent = fx2
    hornRing.Shape = Enum.PartType.Cylinder
    local propertyTable = {Size = Vector3.new(0.05999999865889549, 34, 34), Transparency = 1}
    tweenService:Create(hornRing, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
    debris:AddItem(hornRing, 0.8)
end

local v772 = {}
local heartbeatConnection = nil

local function endRing(key, a776, vector3: Vector3)
    --[[
      name: endRing
      line: 1890
      upvalues:
        v772 (copy, index: 1)
        Util (copy, index: 2)
        fadeOut (copy, index: 3)
        debris (copy, index: 4)
    ]]
    local v778 = v772[key]
    if not v778 then
        return
    end

    v772[key] = nil

    if a776 then
        if v778.mine and not Util.InFirstPerson() then
            Util.Sound("Knife_Ready", (vector3 or v778.pos))
        end

        v778.model:Destroy()

        return
    end

    if vector3 then
        local model = v778.model
        local cFrame = CFrame.new(vector3)

        if model:IsA("Model") then
            model:PivotTo(cFrame)
        elseif model:IsA("BasePart") then
            model.CFrame = cFrame
        end

        Util.Sound("Knife_Thunk", vector3)
    end

    fadeOut(v778.model, 0.3, 1.2)
    debris:AddItem(v778.model, 2)
end

local function stepRings(deltaTime: number)
    --[[
      name: stepRings
      line: 1913
      upvalues:
        v772 (copy, index: 1)
        Util (copy, index: 2)
        fadeOut (copy, index: 3)
        debris (copy, index: 4)
        v348 (ref,  index: 5)
        heartbeatConnection (ref,  index: 6)
    ]]
    local timestamp = os.clock()
    local pos

    for v785, v786 in v772 do
        local v787, shooter, view, camera, clampedValue, cFrame, cframe, v794, v795, v796, v797, v798, pos2, v800
        local rotationX
        local v802
        local v803
        local v804, v805, v806, v807, v808, v809, v810, v811, v812, v813, v814, v815, v816 = false, false, false, false, false, false, false, false, false, false, false, false, false

        if v786.model.Parent then
            if not (9 < timestamp - v786.born) then
                v787 = v786.speed * deltaTime

                if v786.back then
                    shooter = v786.shooter

                    if shooter then
                        v803 = v786.shooter:FindFirstChild("HumanoidRootPart")
                    else
                        v803 = shooter
                    end

                    v805 = true
                else
                    v786.pos += (v786.dir * v787)
                    v786.traveled += v787
                    local traveled = v786.traveled

                    if v786.range <= traveled then
                        v786.back = true
                    end

                    v810 = true
                end
            else
                v804 = true
            end
        else
            v804 = true
        end

        if v804 then
            v772[v785] = nil

            if v786.model.Parent then
                v786.model:Destroy()
            end
        end

        if v805 then
            if v803 then
                if v803:IsA("BasePart") then
                    local v818 = v803.Position + Vector3.new(0, 0.6000000238418579, 0) - v786.pos

                    if not (v818.Magnitude <= v786.catch + v787) then
                        v786.pos += (v818.Unit * v787)
                        v810 = true
                    else
                        local position = v803.Position
                        v798 = v772[v785]

                        if v798 then
                            v772[v785] = nil

                            if v798.mine and not Util.InFirstPerson() then
                                Util.Sound("Knife_Ready", (position or v798.pos))
                            end

                            v809 = true
                        end
                    end
                else
                    v806 = true
                end
            else
                v806 = true
            end
        end

        if v806 then
            pos2 = v786.pos
            v800 = v772[v785]

            if v800 then
                v772[v785] = nil

                if pos2 then
                    local model = v800.model
                    local cFrame3 = CFrame.new(pos2)

                    if model:IsA("Model") then
                        model:PivotTo(cFrame3)
                    elseif model:IsA("BasePart") then
                        model.CFrame = cFrame3
                    end

                    v807 = true
                else
                    v808 = true
                end
            end
        end

        if v807 then
            Util.Sound("Knife_Thunk", pos2)
            v808 = true
        end

        if v808 then
            fadeOut(v800.model, 0.3, 1.2)
            debris:AddItem(v800.model, 2)
        end

        if v809 then
            v798.model:Destroy()
        end

        if v810 then
            pos = v786.pos
            view = v786.view

            if view then
                camera = workspace.CurrentCamera

                if not (timestamp < view.at) then
                    if view.t0 ~= 0 then
                        v812 = true
                    else
                        view.t0 = timestamp
                        v786.spinT0 = timestamp
                        v797 = v348
                        v797 = v797 and v348()
                        v811 = true
                    end
                else
                    v802 = v786.pos - Vector3.new(0, 10000, 0)
                    v813 = true
                end
            else
                v802 = pos
                v813 = true
            end
        end

        if v811 then
            if v797 and camera then
                local cFrame2 = camera.CFrame
                view.p0 = cFrame2:PointToObjectSpace(cFrame2.Position + ((v797 - cFrame2.Position) * 4))
            end

            v812 = true
        end

        if v812 then
            clampedValue = math.clamp((timestamp - view.t0) / 0.12, 0, 1)
            local v823 = 1 - (1 - clampedValue) * (1 - clampedValue)

            if const p0 = view.p0 then
                if camera then
                    cFrame = camera.CFrame
                    local objectSpacePos = cFrame:PointToObjectSpace(v786.pos)

                    if not (objectSpacePos.Z < -0.05) then
                        v802 = pos
                    elseif not (p0.Z < -0.05) then
                        v802 = pos
                    else
                        local v826 = -p0.Z
                        local v827 = -objectSpacePos.Z
                        v794 = v826 + (v827 - v826) * v823
                        v795 = p0.X / v826 + (objectSpacePos.X / v827 - (p0.X / v826)) * v823
                        v796 = p0.Y / v826 + (objectSpacePos.Y / v827 - (p0.Y / v826)) * v823
                        v802 = cFrame:PointToWorldSpace((Vector3.new(v795 * v794, v796 * v794, -v794)))
                    end
                else
                    v802 = pos
                end
            else
                v802 = pos
            end

            if 1 <= clampedValue then
                v786.view = nil
            end

            v813 = true
        end

        if v813 then
            v786.spinA = ((v786.spinA or 0) + math.min(deltaTime * 30, 0.3490658503988659)) % math.tau
            cframe = CFrame.Angles(0, v786.spinA, 0)

            if const view2 = v786.view then
                if not (0 < view2.t0) then
                    v814 = true
                else
                    rotationX = (1 - math.clamp((timestamp - view2.t0) / 0.12, 0, 1)) * 1.3089969389957472
                    v815 = true
                end
            else
                v814 = true
            end
        end

        if v814 then
            rotationX = 0
            v815 = true
        end

        if v815 then
            local vector3 = Vector3.new(v786.dir.X, 0, v786.dir.Z)

            if not (0 < rotationX) then
                v816 = true
            elseif not (0.001 < vector3.Magnitude) then
                v816 = true
            else
                local model = v786.model
                local cFrame4 = CFrame.lookAt(v802, v802 + vector3) * CFrame.Angles(rotationX, 0, 0) * cframe

                if model:IsA("Model") then
                    model:PivotTo(cFrame4)
                elseif model:IsA("BasePart") then
                    model.CFrame = cFrame4
                end
            end
        end

        if v816 then
            local model = v786.model
            local cFrame5 = CFrame.new(v802) * cframe

            if model:IsA("Model") then
                model:PivotTo(cFrame5)
            elseif model:IsA("BasePart") then
                model.CFrame = cFrame5
            end
        end
    end

    if next(v772) == nil and heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

function v15.Chakram(key, pos: Vector3, a836, speed, range, catch, shooter)
    --[[
      name: Chakram
      line: 1998
      upvalues:
        localPlayer (copy, index: 1)
        v15 (copy, index: 2)
        template (copy, index: 3)
        prep (copy, index: 4)
        fx2 (ref,  index: 5)
        v772 (copy, index: 6)
        v348 (ref,  index: 7)
        Util (copy, index: 8)
        v349 (ref,  index: 9)
        heartbeatConnection (ref,  index: 10)
        runService (copy, index: 11)
        stepRings (copy, index: 12)
    ]]
    local model
    local view
    local mine = shooter ~= nil and shooter == localPlayer.Character
    if not mine then
        local v845 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - pos).Magnitude else 0

        if v15.NEAR * 2 < v845 then
            return
        end
    end

    if const v846 = template("Projectiles/Chakram") then
        model = v846:Clone()
    else
        model = Instance.new("Part")
        model.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 2)
        model.Material = Enum.Material.SmoothPlastic
        model.Color = Color3.fromRGB(90, 85, 80)
        prep(model)
    end

    prep(model)
    local cFrame = CFrame.new(pos)

    if model:IsA("Model") then
        model:PivotTo(cFrame)
    elseif model:IsA("BasePart") then
        model.CFrame = cFrame
    end

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    model.Parent = fx2

    if const v849 = v772[key] then
        v849.model:Destroy()
    end

    local v850 = {traveled = 0, back = false, model = model, shooter = shooter, pos = pos, dir = a836.Unit, speed = speed, range = range, catch = catch, born = os.clock(), mine = mine}

    if not mine or not v348 or not Util.InFirstPerson() then
        view = nil
    else
        local v851 = {t0 = 0}
        local timestamp = os.clock()
        local v853 = not v349 and 0 or v349()
        v851.at = timestamp + math.clamp(v853, 0, 0.3)
        view = v851
    end

    v850.view = view
    v772[key] = v850
    heartbeatConnection = heartbeatConnection or runService.Heartbeat:Connect(stepRings)
end

function v15.ChakramTurn(key, pos)
    --[[
      name: ChakramTurn
      line: 2034
      upvalues:
        v772 (copy, index: 1)
    ]]
    if const v856 = v772[key] then
        v856.back = true

        if 3 < (v856.pos - pos).Magnitude then
            v856.pos = pos
        end
    end
end

function v15.ChakramEnd(key, a858, vector3: Vector3)
    --[[
      name: ChakramEnd
      line: 2045
      upvalues:
        endRing (copy, index: 1)
    ]]
    endRing(key, a858, vector3)
end

function v15.FirePatch(a860, a861, a862: number)
    --[[
      name: FirePatch
      line: 2051
      upvalues:
        v15 (copy, index: 1)
        Quality (copy, index: 2)
        fx2 (ref,  index: 3)
        debris (copy, index: 4)
        Util (copy, index: 5)
    ]]
    local v864 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a860).Magnitude else 0

    if v15.NEAR * 1.5 < v864 then
        return
    end

    local v865 = Quality.layers and 3 or 2

    for index = 1, v865 do
        local v867 = ((index / v865) * math.pi) * 2 + math.random()
        local v868 = index == 1 and 0 or a861 * (0.3 + (0.4 * math.random()))
        local v869 = a860 + Vector3.new(math.cos(v867) * v868, 0.3, math.sin(v867) * v868)
        local cFrame = CFrame.new(v869)
        local color = Color3.new()
        local smoothPlastic = Enum.Material.SmoothPlastic
        local puffFx = Instance.new("Part")
        puffFx.Name = "PuffFX"
        puffFx.Anchored = true
        puffFx.CanCollide = false
        puffFx.CanQuery = false
        puffFx.CanTouch = false
        puffFx.CastShadow = false
        puffFx.Size = Vector3.new(1.2000000476837158, 0.4000000059604645, 1.2000000476837158)
        puffFx.CFrame = cFrame
        puffFx.Color = color
        puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
        puffFx.Transparency = 1

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        puffFx.Parent = fx2
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 190, 80), Color3.fromRGB(235, 90, 30))
        particleEmitter.LightEmission = 0.35
        particleEmitter.LightInfluence = 0.3
        particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(0.4, 2.2), NumberSequenceKeypoint.new(1, 0)})
        particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
        particleEmitter.Lifetime = NumberRange.new(0.5, 0.8)
        particleEmitter.Speed = NumberRange.new(2, 4)
        particleEmitter.SpreadAngle = Vector2.new(10, 10)
        particleEmitter.EmissionDirection = Enum.NormalId.Top
        particleEmitter.Rotation = NumberRange.new(-20, 20)
        particleEmitter.Rate = 12 * Quality.particleScale
        particleEmitter.Shape = Enum.ParticleEmitterShape.Box
        particleEmitter.Parent = puffFx
        task.delay(
            a862,
            function()
                --[[
                  line: 2075
                  upvalues:
                    particleEmitter (copy, index: 1)
                ]]
                particleEmitter.Enabled = false
            end
        )
        debris:AddItem(puffFx, a862 + 1)
    end

    Util.Sound("FireBomb_Fuse", a860)
end

function v15.Wall(a876, a877, a878, a879)
    --[[
      name: Wall
      line: 2084
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    local v881 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a876).Magnitude else 0

    if v15.NEAR * 1.5 < v881 then
        return
    end

    local color3 = Color3.fromRGB(150, 108, 68)

    if a877 == "Hit" then
        Util.Sound("Impact_Wood", a876)
        v15.Puff(a876, color3, 5, 0.5, 6, 0.4)

        return
    end

    local v883 = a876 - Vector3.new(0, (a879 / 2) - 0.3, 0)

    if a877 == "Place" then
        Util.Sound("Impact_Wood", a876)
        Util.Sound("Trap_Set", a876)
        v15.Puff(v883, Color3.fromRGB(170, 150, 120), 12, 1.1, 7, 0.6)

        return
    end

    Util.Sound("Impact_Wood", a876)

    if a877 == "Break" then
        Util.Sound("Hit_Melee_Heavy", a876)
    end

    v15.Puff(v883, Color3.fromRGB(170, 150, 120), 10, 1.2, 6, 0.7)
    local puff = v15.Puff
    local v885 = a877 ~= "Break" and 8 or 16
    puff(a876, color3, v885, 0.6, 11, 0.7)
end

function v15.HealPool(a886, a887, a888: number)
    --[[
      name: HealPool
      line: 2113
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
        fx2 (ref,  index: 3)
        tweenService (copy, index: 4)
        debris (copy, index: 5)
        Quality (copy, index: 6)
    ]]
    local position, normal
    local v892 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - a886).Magnitude else 0
    local v893 = v15.NEAR < v892
    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(a886 + Vector3.new(0, 1.5, 0), Vector3.new(0, -(a887 + 1.5), 0), raycastParams) then
        position = raycastResult.Position
        normal = raycastResult.Normal
    else
        position, normal = nil, nil
    end

    local v896 = position or a886
    Util.Sound("FireBomb_Shatter", v896)
    v15.Burst("Heal_Health", CFrame.new(v896 + Vector3.new(0, 1, 0)), 1.6)
    local v897 = normal or Vector3.new(0, 1, 0)
    local cframe = CFrame.lookAt(v896 + (v897 * 0.12), v896 + (v897 * 1.12)) * CFrame.Angles(0, 1.5707963267948966, 0)

    local function disc(name: string, a901, color: Color3, a903: number, x: number)
        --[[
          name: disc
          line: 2122
          upvalues:
            cframe (copy, index: 1)
            fx2 (ref,  index: 2)
            tweenService (copy, index: 3)
            a888 (copy, index: 4)
            debris (copy, index: 5)
        ]]
        local size = Vector3.new(0.08, a901, a901)
        local cFrame = cframe * CFrame.new(x, 0, 0)
        local smoothPlastic = Enum.Material.SmoothPlastic
        local part = Instance.new("Part")
        part.Name = name
        part.Anchored = true
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.CastShadow = false
        part.Size = size
        part.CFrame = cFrame
        part.Color = color
        part.Material = smoothPlastic or Enum.Material.SmoothPlastic
        part.Transparency = a903 or 0

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        part.Parent = fx2
        part.Shape = Enum.PartType.Cylinder
        local propertyTable = {Transparency = 1}
        tweenService:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, (math.max(0, a888 - 0.3))), propertyTable):Play()
        debris:AddItem(part, a888 + 0.4)

        return part
    end

    disc("HealPoolRim", a887 * 2, Color3.fromRGB(58, 132, 70), 0.55, 0)
    disc("HealPool", (a887 * 2) - 0.9, Color3.fromRGB(96, 178, 96), 0.72, 0.02)

    if v893 then
        return
    end

    local v911 = v896 + Vector3.new(0, 0.6000000238418579, 0)
    local size = Vector3.new(a887 * 1.5, 0.4, a887 * 1.5)
    local cFrame = CFrame.new(v911)
    local color = Color3.new()
    local smoothPlastic = Enum.Material.SmoothPlastic
    local puffFx = Instance.new("Part")
    puffFx.Name = "PuffFX"
    puffFx.Anchored = true
    puffFx.CanCollide = false
    puffFx.CanQuery = false
    puffFx.CanTouch = false
    puffFx.CastShadow = false
    puffFx.Size = size
    puffFx.CFrame = cFrame
    puffFx.Color = color
    puffFx.Material = smoothPlastic or Enum.Material.SmoothPlastic
    puffFx.Transparency = 1

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    puffFx.Parent = fx2
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(120, 220, 110))
    particleEmitter.LightEmission = 0.3
    particleEmitter.LightInfluence = 0.5
    particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.34), NumberSequenceKeypoint.new(1, 0)})
    particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1)})
    particleEmitter.Lifetime = NumberRange.new(0.8, 1.3)
    particleEmitter.Speed = NumberRange.new(2, 4)
    particleEmitter.SpreadAngle = Vector2.new(12, 12)
    particleEmitter.EmissionDirection = Enum.NormalId.Top
    particleEmitter.Shape = Enum.ParticleEmitterShape.Box
    particleEmitter.Rate = 34 * Quality.particleScale
    particleEmitter.Parent = puffFx
    task.delay(
        a888,
        function()
            --[[
              line: 2149
              upvalues:
                particleEmitter (copy, index: 1)
            ]]
            particleEmitter.Enabled = false
        end
    )
    debris:AddItem(puffFx, a888 + 1.5)
end

local v919 = {}
local v920 = {}
local runServiceHeartbeatConnection = nil
local color3 = Color3.fromRGB(122, 104, 84)

local function caltropModel()
    --[[
      name: caltropModel
      line: 2167
      upvalues:
        template (copy, index: 1)
        prep (copy, index: 2)
        fx2 (ref,  index: 3)
    ]]
    if const v924 = template("Caltrop") then
        local v925 = v924:Clone()
        prep(v925)

        return v925
    end

    local parent = Instance.new("Model")
    local cFrame = CFrame.new(0, 0.12, 0)
    local color = Color3.fromRGB(70, 68, 66)
    local metal = Enum.Material.Metal
    local root = Instance.new("Part")
    root.Name = "Root"
    root.Anchored = true
    root.CanCollide = false
    root.CanQuery = false
    root.CanTouch = false
    root.CastShadow = false
    root.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    root.CFrame = cFrame
    root.Color = color
    root.Material = metal or Enum.Material.SmoothPlastic
    root.Transparency = 0

    if const fx = workspace:FindFirstChild("FX") then
        fx2 = fx
    end

    root.Parent = fx2
    root.Parent = parent
    parent.PrimaryPart = root

    for v932, vector3 in {Vector3.new(0, 1, 0), Vector3.new(0.9399999976158142, -0.33000001311302185, 0), Vector3.new(-0.4699999988079071, -0.33000001311302185, 0.8199999928474426), Vector3.new(-0.4699999988079071, -0.33000001311302185, -0.8199999928474426)} do
        local name = "Point" .. v932
        local cFrame2 = CFrame.lookAt(root.Position + (vector3 * 0.18), root.Position + vector3)
        local color2 = Color3.fromRGB(86, 84, 82)
        local metal2 = Enum.Material.Metal
        local part = Instance.new("Part")
        part.Name = name
        part.Anchored = true
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.CastShadow = false
        part.Size = Vector3.new(0.07000000029802322, 0.07000000029802322, 0.41999998688697815)
        part.CFrame = cFrame2
        part.Color = color2
        part.Material = metal2 or Enum.Material.SmoothPlastic
        part.Transparency = 0

        if const fx3 = workspace:FindFirstChild("FX") then
            fx2 = fx3
        end

        part.Parent = fx2
        part.Parent = parent
    end

    return parent
end

local function stepCaltrops()
    --[[
      name: stepCaltrops
      line: 2186
      upvalues:
        v920 (copy, index: 1)
        runServiceHeartbeatConnection (ref,  index: 2)
    ]]
    local timestamp = os.clock()

    for index = #v920, 1, -1 do
        local v943 = v920[index]

        if v943.model.Parent then
            local clampedValue = math.clamp((timestamp - v943.t0) / v943.dur, 0, 1)
            local alpha = 1 - (1 - clampedValue) * (1 - clampedValue)
            local v946 = v943.from:Lerp(v943.to.Position, alpha) + Vector3.new(0, ((v943.hop * 4) * clampedValue) * (1 - clampedValue), 0)
            local v947 = 1 - alpha
            local v948 = CFrame.new(v946) * v943.to.Rotation * CFrame.Angles(v943.tumble.X * v947, v943.tumble.Y * v947, v943.tumble.Z * v947)
            v943.model:PivotTo(v948)

            if 1 <= clampedValue then
                table.remove(v920, index)
            end
        else
            table.remove(v920, index)
        end
    end

    if #v920 == 0 and runServiceHeartbeatConnection then
        runServiceHeartbeatConnection:Disconnect()
        runServiceHeartbeatConnection = nil
    end
end

local function caltropsGone(a950, a951: number)
    --[[
      name: caltropsGone
      line: 2210
      upvalues:
        v919 (copy, index: 1)
        tweenService (copy, index: 2)
        debris (copy, index: 3)
    ]]
    local v952 = v919[a950]
    if not v952 then
        return
    end

    v919[a950] = nil

    for _, item in v952.items do
        if item.Parent then
            local instances = item:IsA("BasePart") and {item} or item:GetDescendants()

            for _, instance in instances do
                if instance:IsA("BasePart") then
                    tweenService:Create(instance, TweenInfo.new(a951, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1, CFrame = instance.CFrame - Vector3.new(0, 0.25, 0)}):Play()
                elseif instance:IsA("SurfaceGui") then
                    instance.Enabled = false
                end
            end

            debris:AddItem(item, a951 + 0.1)
        end
    end
end

function v15.Caltrops(a958)
    --[[
      name: Caltrops
      line: 2235
      upvalues:
        v15 (copy, index: 1)
        v919 (copy, index: 2)
        caltropsGone (copy, index: 3)
        Util (copy, index: 4)
        fx2 (ref,  index: 5)
        tweenService (copy, index: 6)
        color3 (copy, index: 7)
        Quality (copy, index: 8)
        caltropModel (copy, index: 9)
        v920 (copy, index: 10)
        runServiceHeartbeatConnection (ref,  index: 11)
        runService (copy, index: 12)
        stepCaltrops (copy, index: 13)
    ]]
    local number = tonumber(a958.id)
    local position = a958.position

    if not number or typeof(position) ~= "Vector3" then
        return
    end

    local v961
    local magnitude
    local position2, normal
    local number2 = tonumber(a958.radius) or 3.5
    local number3 = tonumber(a958.duration) or 15

    if typeof(a958.from) ~= "Vector3" then
        v961 = position
    else
        v961 = a958.from
    end

    local random = Random.new((tonumber(a958.seed) or number))
    magnitude = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0
    local v969 = v15.NEAR < magnitude

    if v919[number] then
        caltropsGone(number, 0)
    end

    local items = {}
    v919[number] = {items = items, token = number}
    local attacker = a958.attacker
    local isEnemy = typeof(attacker) == "Instance" and Util.IsEnemy(attacker)
    local color32 = if isEnemy then Color3.fromRGB(196, 70, 64) else Color3.fromRGB(70, 132, 196)
    local v974 = position + Vector3.new(0, 0.5, 0)
    local raycastParams = Util.WorldParams(Util.Targets())

    if const raycastResult = workspace:Raycast(v974 + Vector3.new(0, 1.5, 0), Vector3.new(0, -4.5, 0), raycastParams) then
        position2 = raycastResult.Position
        normal = raycastResult.Normal
    else
        position2, normal = nil, nil
    end

    local position3 = position2 or position
    local v978 = normal or Vector3.new(0, 1, 0)
    local cframe = CFrame.lookAt(position3 + (v978 * 0.06), position3 + (v978 * 1.06)) * CFrame.Angles(0, 1.5707963267948966, 0)

    local function disc(name: string, a982, color: Color3, transparency: number, x: number)
        --[[
          name: disc
          line: 2260
          upvalues:
            cframe (copy, index: 1)
            fx2 (ref,  index: 2)
            tweenService (copy, index: 3)
            items (copy, index: 4)
        ]]
        local size = Vector3.new(0.05, a982, a982)
        local cFrame = cframe * CFrame.new(x, 0, 0)
        local smoothPlastic = Enum.Material.SmoothPlastic
        local instance = Instance.new("Part")
        instance.Name = name
        instance.Anchored = true
        instance.CanCollide = false
        instance.CanQuery = false
        instance.CanTouch = false
        instance.CastShadow = false
        instance.Size = size
        instance.CFrame = cFrame
        instance.Color = color
        instance.Material = smoothPlastic or Enum.Material.SmoothPlastic
        instance.Transparency = 1

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        instance.Parent = fx2
        instance.Shape = Enum.PartType.Cylinder
        local propertyTable = {Transparency = transparency}
        tweenService:Create(instance, TweenInfo.new(0.25), propertyTable):Play()
        table.insert(items, instance)
    end

    disc("CaltropsRing", number2 * 2, color32, 0.72, 0)
    disc("CaltropsDirt", (number2 * 2) - 0.5, color3, 0.82, 0.01)
    local v992 = v969 and 10 or Quality.layers and 18 or 13
    local timestamp = os.clock()

    for index = 1, v992 do
        local position4, normal2
        local v997 = index * 2.39996 + random:NextNumber(-0.35, 0.35)
        local v998 = number2 * 0.92 * math.sqrt((index - 0.4) / v992) * random:NextNumber(0.88, 1.04)
        local v999 = position3 + Vector3.new(math.cos(v997) * v998, 0, math.sin(v997) * v998)
        local v1000 = v999 + Vector3.new(0, 1, 0)
        local raycastParams2 = Util.WorldParams(Util.Targets())

        if const raycastResult2 = workspace:Raycast(v1000 + Vector3.new(0, 1.5, 0), Vector3.new(0, -4.5, 0), raycastParams2) then
            position4 = raycastResult2.Position
            normal2 = raycastResult2.Normal
        else
            position4, normal2 = nil, nil
        end

        local v1003 = position4 or v999
        local v1004 = normal2 or v978
        local v1005 = random:NextNumber(0, math.tau)
        local vector3 = Vector3.new(math.cos(v1005), 0, (math.sin(v1005)))
        local v1007 = vector3 - v1004 * vector3:Dot(v1004)

        if v1007.Magnitude < 0.05 then
            v1007 = Vector3.new(1, 0, 0)
        end

        local to = CFrame.lookAt(v1003, v1003 + v1007.Unit, v1004) * CFrame.Angles(0, 0, (math.rad((random:NextNumber(-8, 8)))))
        local model = caltropModel()
        local v1010 = random:NextNumber(0.9, 1.12)

        if model:IsA("Model") and v1010 ~= 1 then
            model:ScaleTo(v1010)
        end

        model:PivotTo(CFrame.new(v961) * to.Rotation)

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        model.Parent = fx2
        table.insert(items, model)

        if v969 then
            model:PivotTo(to)
        else
            table.insert(v920, {model = model, from = v961, to = to, t0 = timestamp + random:NextNumber(0, 0.03), dur = 0.14 + (0.16 * (v998 / math.max(number2, 0.1))) + random:NextNumber(0, 0.04), hop = 0.5 + random:NextNumber(0, 0.9), tumble = Vector3.new(random:NextNumber(-7, 7), random:NextNumber(-5, 5), random:NextNumber(-7, 7))})
        end
    end

    if not v969 then
        runServiceHeartbeatConnection = runServiceHeartbeatConnection or runService.Heartbeat:Connect(stepCaltrops)
        Util.Sound("Caltrops_Scatter", v961)
        v15.Puff(v961, Color3.fromRGB(150, 132, 108), 7, 0.7, 7, 0.45)

        task.delay(
            0.22,
            function()
                --[[
                  line: 2313
                  upvalues:
                    v919 (copy, index: 1)
                    number (copy, index: 2)
                    number (copy, index: 3)
                    v15 (copy, index: 4)
                    position3 (copy, index: 5)
                    v978 (copy, index: 6)
                ]]
                if v919[number] and v919[number].token == number then
                    v15.Puff(position3 + (v978 * 0.3), Color3.fromRGB(150, 132, 108), 9, 1.1, 4, 0.55)
                end
            end
        )
    end

    task.delay(
        number3,
        function()
            --[[
              line: 2319
              upvalues:
                v919 (copy, index: 1)
                number (copy, index: 2)
                number (copy, index: 3)
                caltropsGone (copy, index: 4)
            ]]
            local v1012 = v919[number]

            if v1012 and v1012.token == number then
                caltropsGone(number, 0.45)
            end
        end
    )
end

function v15.CaltropsEnd(a1013)
    --[[
      name: CaltropsEnd
      line: 2327
      upvalues:
        caltropsGone (copy, index: 1)
    ]]
    caltropsGone(a1013, 0.35)
end

function v15.CaltropStep(a1014)
    --[[
      name: CaltropStep
      line: 2332
      upvalues:
        Util (copy, index: 1)
        v15 (copy, index: 2)
    ]]
    local v1015 = Util.Drawn(a1014)
    local v1016 = if v1015 and v1015:IsA("Model") then v1015 else a1014
    local v1017 = v1016:FindFirstChild("RightFoot")
        or v1016:FindFirstChild("LeftFoot")
        or v1016:FindFirstChild("HumanoidRootPart")

    if v1017 and v1017:IsA("BasePart") then
        Util.Sound("Caltrops_Step", v1017)
        local position = v1017.Position
        local v1020 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - position).Magnitude else 0

        if v1020 <= v15.NEAR then
            v15.Burst("Block_Spark", CFrame.new(v1017.Position - Vector3.new(0, 0.30000001192092896, 0)), 0.45, Color3.fromRGB(196, 150, 110))
        end
    end
end

function v15.Death(vector3: Vector3, a1022, a1023, a1024)
    --[[
      name: Death
      line: 2345
      upvalues:
        v15 (copy, index: 1)
        Util (copy, index: 2)
    ]]
    v15.Burst("Death_Burst", CFrame.new(vector3))
    Util.Sound("Death_Poof", vector3)
    v15.KillFlourish(vector3, a1023, a1022 == true, a1024 == true)

    if a1022 then
        Util.Shake(0.5, 0.25)
    end
end

local function fling(vector3: Vector3, a1027, a1028: number, a1029: number, a1030: number, a1031: boolean)
    --[[
      name: fling
      line: 2359
      upvalues:
        fx2 (ref,  index: 1)
        runService (copy, index: 2)
    ]]
    local v1032 = {}

    for v1033, part in a1027 do
        local vector32
        local vector33 = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5)

        if not (0.01 < vector33.Magnitude) then
            vector32 = Vector3.new(1, 0, 0)
        else
            vector32 = vector33.Unit
        end

        v1032[v1033] = (vector32 * a1028) * (0.6 + (math.random() * 0.6)) + Vector3.new(0, a1029 * (0.7 + (math.random() * 0.6)), 0)
        part.CFrame = CFrame.new(vector3) * CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)

        if const fx = workspace:FindFirstChild("FX") then
            fx2 = fx
        end

        part.Parent = fx2
    end

    local timestamp = os.clock()
    local renderSteppedConnection = nil

    renderSteppedConnection = runService.RenderStepped:Connect(
        function()
            --[[
              line: 2370
              upvalues:
                timestamp (copy, index: 1)
                a1030 (copy, index: 2)
                renderSteppedConnection (ref,  index: 3)
                a1027 (copy, index: 4)
                vector3 (copy, index: 5)
                v1032 (copy, index: 6)
                a1031 (copy, index: 7)
            ]]
            local elapsedTime = os.clock() - timestamp

            if a1030 <= elapsedTime then
                renderSteppedConnection:Disconnect()

                for _, part in a1027 do
                    part:Destroy()
                end

                return
            end

            local v1043 = elapsedTime / a1030

            for v1044, part in a1027 do
                local cframe
                local v1047 = vector3 + (v1032[v1044] * elapsedTime) + Vector3.new(0, (-30 * elapsedTime) * elapsedTime, 0)

                if a1031 then
                    cframe = CFrame.Angles((elapsedTime * 9) + v1044, elapsedTime * 7, 0)
                else
                    cframe = part.CFrame.Rotation
                end

                part.CFrame = CFrame.new(v1047) * cframe
                part.Transparency = math.clamp((v1043 - 0.5) / 0.5, 0, 1)
            end
        end
    )
end

local v1048 = {Bow = "feathers", Crossbow = "feathers", Javelin = "feathers", Knives = "feathers", Musket = "powder", Pistol = "powder", Blunderbuss = "powder", Axe = "stars", Club = "stars", Fists = "stars", Gauntlets = "stars", Hatchets = "stars", Sword = "slash", Dagger = "slash", Spear = "slash", Scythe = "slash", Katana = "slash", Sling = "chips", Bomb = "embers", Trap = "sparks"}

function v15.KillFlourish(vector3: Vector3, a1050, a1051, a1052)
    --[[
      name: KillFlourish
      line: 2397
      upvalues:
        v15 (copy, index: 1)
        v1048 (copy, index: 2)
        Combat (copy, index: 3)
        fx2 (ref,  index: 4)
        fling (copy, index: 5)
        Util (copy, index: 6)
        groundDecal (copy, index: 7)
        runService (copy, index: 8)
        tweenService (copy, index: 9)
        debris (copy, index: 10)
    ]]
    local v1054 = if const camera = workspace.CurrentCamera then (camera.CFrame.Position - vector3).Magnitude else 0

    if v15.NEAR < v1054 then
        return
    end

    local v1055 = v1048[Combat.Kind(a1050) or ""] or "none"
    local vector32 = vector3 + Vector3.new(0, 1.5, 0)
    local v1057 = a1051 and 1.25 or 1

    if v1055 == "feathers" then
        local v1058 = {}

        for index = 1, 7 do
            local color = if index % 3 == 0 then Color3.fromRGB(220, 208, 186) else Color3.fromRGB(178, 58, 44)
            local size = Vector3.new(0.05999999865889549, 0.699999988079071, 0.2199999988079071) * v1057
            local cFrame = CFrame.new(vector32)
            local smoothPlastic = Enum.Material.SmoothPlastic
            local killFeather = Instance.new("Part")
            killFeather.Name = "KillFeather"
            killFeather.Anchored = true
            killFeather.CanCollide = false
            killFeather.CanQuery = false
            killFeather.CanTouch = false
            killFeather.CastShadow = false
            killFeather.Size = size
            killFeather.CFrame = cFrame
            killFeather.Color = color
            killFeather.Material = smoothPlastic or Enum.Material.SmoothPlastic
            killFeather.Transparency = 0

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            killFeather.Parent = fx2
            table.insert(v1058, killFeather)
        end

        fling(vector32, v1058, 9, 10, 0.9, true)
        Util.Sound("Arrow_Flesh", vector3, {Volume = 0.6, PlaybackSpeed = 0.8})
    elseif v1055 == "powder" then
        v15.Puff(vector32, Color3.fromRGB(70, 64, 60), 14, v1057 * 1.6, 14, 1.1)
        v15.Burst("Impact_Sparks", CFrame.new(vector32), v1057 * 1.3, Color3.fromRGB(255, 150, 60), true)
        groundDecal(vector3 - Vector3.new(0, 2.799999952316284, 0), Vector3.new(0, 1, 0), "rbxassetid://10871117278", Color3.fromRGB(60, 50, 44), 2, v1057 * 9, 0.3, 0.3)
    elseif v1055 == "stars" then
        local v1066 = {}

        for _ = 1, 4 do
            local size = Vector3.new(0.5, 0.5, 0.11999999731779099) * v1057
            local cFrame = CFrame.new(vector32)
            local color = Color3.fromRGB(250, 205, 70)
            local smoothPlastic = Enum.Material.SmoothPlastic
            local bonkStar = Instance.new("Part")
            bonkStar.Name = "BonkStar"
            bonkStar.Anchored = true
            bonkStar.CanCollide = false
            bonkStar.CanQuery = false
            bonkStar.CanTouch = false
            bonkStar.CastShadow = false
            bonkStar.Size = size
            bonkStar.CFrame = cFrame
            bonkStar.Color = color
            bonkStar.Material = smoothPlastic or Enum.Material.SmoothPlastic
            bonkStar.Transparency = 0

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            bonkStar.Parent = fx2
            bonkStar.Shape = Enum.PartType.Block
            table.insert(v1066, bonkStar)
        end

        local vector33 = vector3 + Vector3.new(0, 2.5999999046325684, 0)
        local timestamp = os.clock()
        local renderSteppedConnection = nil

        renderSteppedConnection = runService.RenderStepped:Connect(
            function()
                --[[
                  line: 2427
                  upvalues:
                    timestamp (copy, index: 1)
                    renderSteppedConnection (ref,  index: 2)
                    v1066 (copy, index: 3)
                    vector33 (copy, index: 4)
                ]]
                local elapsedTime = os.clock() - timestamp

                if 0.9 < elapsedTime then
                    renderSteppedConnection:Disconnect()

                    for _, part in v1066 do
                        part:Destroy()
                    end

                    return
                end

                for v1080, part in v1066 do
                    local v1082 = elapsedTime * 9 + (v1080 * math.pi) / 2
                    part.CFrame = CFrame.new(vector33 + Vector3.new(math.cos(v1082) * 1.3, (math.sin((elapsedTime * 12) + v1080) * 0.15) + 0.2, math.sin(v1082) * 1.3)) * CFrame.Angles(0, 0, v1082 * 2)
                    part.Transparency = math.clamp((elapsedTime - 0.6) / 0.3, 0, 1)
                end
            end
        )

        Util.Sound("Hit_Punch", vector3, {PlaybackSpeed = 0.75})
    elseif v1055 == "slash" then
        for index = -1, 1, 2 do
            local size = Vector3.new(0.25, v1057 * 4.5, 0.1)
            local cFrame = CFrame.lookAt(vector32, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 0, (math.rad(index * 40)))
            local color = Color3.fromRGB(215, 70, 50)
            local smoothPlastic = Enum.Material.SmoothPlastic
            local killSlash = Instance.new("Part")
            killSlash.Name = "KillSlash"
            killSlash.Anchored = true
            killSlash.CanCollide = false
            killSlash.CanQuery = false
            killSlash.CanTouch = false
            killSlash.CastShadow = false
            killSlash.Size = size
            killSlash.CFrame = cFrame
            killSlash.Color = color
            killSlash.Material = smoothPlastic or Enum.Material.SmoothPlastic
            killSlash.Transparency = 0

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            killSlash.Parent = fx2
            killSlash.Transparency = 0.1
            local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local propertyTable = {Transparency = 1, Size = Vector3.new(0.05, v1057 * 6, 0.1)}
            tweenService:Create(killSlash, tweenInfo, propertyTable):Play()
            debris:AddItem(killSlash, 0.4)
        end
    elseif v1055 == "chips" then
        local v1092 = {}

        for _ = 1, 6 do
            local size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896) * v1057
            local cFrame = CFrame.new(vector32)
            local color = Color3.fromRGB(128, 124, 118)
            local slate = Enum.Material.Slate
            local killChip = Instance.new("Part")
            killChip.Name = "KillChip"
            killChip.Anchored = true
            killChip.CanCollide = false
            killChip.CanQuery = false
            killChip.CanTouch = false
            killChip.CastShadow = false
            killChip.Size = size
            killChip.CFrame = cFrame
            killChip.Color = color
            killChip.Material = slate or Enum.Material.SmoothPlastic
            killChip.Transparency = 0

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            killChip.Parent = fx2
            table.insert(v1092, killChip)
        end

        fling(vector32, v1092, 8, 9, 0.8, true)
    elseif v1055 == "embers" then
        v15.Burst("Impact_Sparks", CFrame.new(vector32), v1057 * 1.5, Color3.fromRGB(255, 140, 50), true)
    elseif v1055 == "sparks" then
        v15.Burst("Impact_Sparks", CFrame.new(vector3), v1057 * 1.2)
    end

    if a1052 then
        v15.CritStar(vector3 + Vector3.new(0, 1.5, 0))
    end
end

local beam = nil
local part2 = nil
local attachment = nil
local attachment2 = nil

local function beamProjectile(vector3: Vector3, a1106, a1107, a1108: number)
    --[[
      name: beamProjectile
      line: 2473
    ]]
    local v1109 = ((vector3 * 0.5) * a1108) * a1108 + (a1106 * a1108) + a1107
    local v1110 = v1109 - ((vector3 * a1108) * a1108 + (a1106 * a1108)) / 3
    local v1111 = ((((vector3 * 0.125) * a1108) * a1108 + ((a1106 * 0.5) * a1108)) + a1107 - ((a1107 + v1109) * 0.125)) / 0.375 - v1110
    local magnitude = (v1111 - a1107).Magnitude
    local magnitude2 = (v1110 - v1109).Magnitude
    local unit = (a1107 - v1109).Unit
    local unit2 = (v1111 - a1107).Unit
    local unit3 = unit2:Cross(unit).Unit
    local unit4 = (v1110 - v1109).Unit
    local unit5 = unit4:Cross(unit).Unit
    local unit6 = unit3:Cross(unit2).Unit
    local v1120 = CFrame.fromMatrix(a1107, unit2, unit3, unit6)
    local v1121 = CFrame.fromMatrix(v1109, unit4, unit5, unit6)

    return magnitude, -magnitude2, v1120, v1121
end

function v15.Trajectory(a1122, a1123, a1124, a1125, a1126)
    --[[
      name: Trajectory
      line: 2491
      upvalues:
        beam (ref,  index: 1)
        part2 (ref,  index: 2)
        fx2 (ref,  index: 3)
        attachment (ref,  index: 4)
        attachment2 (ref,  index: 5)
        ballistics (copy, index: 6)
        Util (copy, index: 7)
        beamProjectile (copy, index: 8)
    ]]
    if a1122 and a1123 and a1124 then
        local position
        local success, v1129, v1130, raycastResult
        local curveSize0, curveSize1, worldCFrame, worldCFrame2

        if not beam then
            local combatTrajA = Instance.new("Attachment")
            combatTrajA.Name = "CombatTrajA"
            combatTrajA.Parent = workspace.Terrain

            local combatTrajB = Instance.new("Attachment")
            combatTrajB.Name = "CombatTrajB"
            combatTrajB.Parent = workspace.Terrain

            local beam2 = Instance.new("Beam")
            beam2.Attachment0 = combatTrajA
            beam2.Attachment1 = combatTrajB
            beam2.Width0 = 0.2
            beam2.Width1 = 0.2
            beam2.Segments = 48
            beam2.FaceCamera = true
            beam2.LightEmission = 0.2
            beam2.LightInfluence = 0.4
            beam2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 0.2)})
            beam2.Parent = workspace.Terrain

            local combatTrajLanding = Instance.new("Part")
            combatTrajLanding.Name = "CombatTrajLanding"
            combatTrajLanding.Shape = Enum.PartType.Cylinder
            combatTrajLanding.Size = Vector3.new(0.11999999731779099, 3, 3)
            combatTrajLanding.Material = Enum.Material.SmoothPlastic
            combatTrajLanding.Transparency = 0.5
            combatTrajLanding.Anchored = true
            combatTrajLanding.CanCollide = false
            combatTrajLanding.CanQuery = false
            combatTrajLanding.CanTouch = false
            combatTrajLanding.CastShadow = false

            if const fx = workspace:FindFirstChild("FX") then
                fx2 = fx
            end

            combatTrajLanding.Parent = fx2
            part2 = combatTrajLanding
            beam = beam2
            attachment = combatTrajA
            attachment2 = combatTrajB
        end

        local ballistics2 = ballistics.new(a1122, a1123, a1124, 0)
        local raycastParams = Util.WorldParams(Util.Teammates())
        local v1143 = 3
        local total = 0
        position = nil

        for _ = 1, 90 do
            v1129, v1130 = ballistics.Advance(ballistics2, 0.03333333333333333)
            total += 0.03333333333333333
            raycastResult = workspace:Raycast(v1129, v1130, raycastParams)

            if raycastResult then
                v1143 = total - 0.03333333333333333 * (1 - ((raycastResult.Position - v1129).Magnitude / math.max(0.001, v1130.Magnitude)))
                position = raycastResult.Position
                break
            end
        end

        success, curveSize0, curveSize1, worldCFrame, worldCFrame2 = pcall(beamProjectile, Vector3.new(0, -a1124, 0), a1123, a1122, (math.max(0.05, v1143)))
        local beam3 = beam

        if not success then
            beam3.Enabled = false
            return
        end

        local attachment3 = attachment2
        attachment.WorldCFrame = worldCFrame
        attachment3.WorldCFrame = worldCFrame2
        beam3.CurveSize0 = curveSize0
        beam3.CurveSize1 = curveSize1
        local newColorSequence = ColorSequence.new
        local v1149 = a1125 or Color3.fromRGB(255, 190, 90)
        beam3.Color = newColorSequence(v1149)
        beam3.Enabled = true

        if const part = part2 then
            if not part.Parent then
                if const fx = workspace:FindFirstChild("FX") then
                    fx2 = fx
                end

                part.Parent = fx2
            end

            if position then
                local v1152 = a1126 or 3
                part.Size = Vector3.new(0.12, v1152, v1152)
                local color = a1125 or Color3.fromRGB(255, 190, 90)
                part.Color = color
                part.Transparency = 0.5
                part.CFrame = CFrame.new(position + Vector3.new(0, 0.07999999821186066, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)

                return
            end

            part.Transparency = 1
        end

        return
    end

    if beam then
        beam.Enabled = false
    end

    if part2 then
        part2.Transparency = 1
    end
end

return v15