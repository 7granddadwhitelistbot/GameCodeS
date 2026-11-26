local step
local v2

local function localTime(a4)
    --[[
      name: localTime
      line: 644
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 645
              upvalues:
                a4 (copy, index: 1)
            ]]
            return DateTime.fromUnixTimestamp(a4):FormatLocalTime("dddd h:mm A", "en-us")
        end
    )
    if success then
        return string.upper(result) .. " YOUR TIME"
    end

    return ""
end

local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local Config = require(replicatedStorage.Shared.Config)
require(replicatedStorage.Shared:WaitForChild("Loc")).Install()
local UIAssets = require(replicatedStorage.Shared.UIAssets)
local Theme = require(script.Parent.Parent.UI.Theme)
local updateCountdown2 = Config.UPDATE_COUNTDOWN
if not updateCountdown2 then
    return
end

local function emblem(a18)
    --[[
      name: emblem
      line: 43
      upvalues:
        UIAssets (copy, index: 1)
    ]]
    local ranks = UIAssets.Ranks
    return ranks and ranks[string.lower(a18.name)] or a18.img or ""
end

local Sfx = nil
pcall(
    function()
        --[[
          line: 48
          upvalues:
            Sfx (ref,  index: 1)
            replicatedStorage (copy, index: 2)
        ]]
        Sfx = require(replicatedStorage.Shared.Sfx)
    end
)
local colors = Theme.Colors
local color3FromRGB = Color3.fromRGB
local v23 = updateCountdown2.skyHours * 3600
local v24 = updateCountdown2.goldenHours * 3600
local gold = colors.Gold
local imageColor3 = color3FromRGB(12, 16, 30)
local fontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local fontFace2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold)
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera
local timestamp = os.clock()

while localPlayer:GetAttribute("LoadingShownMs") == nil and os.clock() - timestamp < 30 do
    task.wait(0.2)
end

local function shipped()
    --[[
      name: shipped
      line: 85
      upvalues:
        workspace (copy, index: 1)
        updateCountdown2 (copy, index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    if workspace:GetAttribute("CountdownPreviewShipped") == true then
        return true
    end

    return updateCountdown2.shipped ~= nil
        and replicatedStorage.Shared:FindFirstChild(updateCountdown2.shipped) ~= nil
end

if updateCountdown2.shipped
    and replicatedStorage.Shared:FindFirstChild(updateCountdown2.shipped)
    and workspace:GetAttribute("CountdownPreview") == nil
    and workspace:GetAttribute("CountdownPreviewAt") == nil
then
    return
end

local function inLobby()
    --[[
      name: inLobby
      line: 100
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    return localPlayer:GetAttribute("State") ~= "Match"
end

local function now()
    --[[
      name: now
      line: 105
      upvalues:
        workspace (copy, index: 1)
        updateCountdown2 (copy, index: 2)
    ]]
    local serverTimeNow = workspace:GetServerTimeNow()
    local countdownPreview = workspace:GetAttribute("CountdownPreview")
    local countdownPreviewAt = workspace:GetAttribute("CountdownPreviewAt")

    if type(countdownPreview) == "number" and type(countdownPreviewAt) == "number" then
        return updateCountdown2.at - countdownPreview + (serverTimeNow - countdownPreviewAt)
    end

    return serverTimeNow
end

local function play(a39)
    --[[
      name: play
      line: 114
      upvalues:
        Sfx (ref, index: 1)
    ]]
    if Sfx then
        pcall(Sfx.PlayUI, a39)
    end
end

local updateCountdownSky = Instance.new("Part")
updateCountdownSky.Name = "UpdateCountdownSky"
updateCountdownSky.Anchored = true
updateCountdownSky.CanCollide = false
updateCountdownSky.CanQuery = false
updateCountdownSky.CanTouch = false
updateCountdownSky.CastShadow = false
updateCountdownSky.Transparency = 1
updateCountdownSky.Size = Vector3.new(357, 64, 0.20000000298023224)
updateCountdownSky.CFrame = CFrame.lookAt(Vector3.new(0, 66, -135), Vector3.new(0, 9, 120))
updateCountdownSky.Parent = workspace

local updateCountdown = Instance.new("SurfaceGui")
updateCountdown.Name = "UpdateCountdown"
updateCountdown.Adornee = updateCountdownSky
updateCountdown.Face = Enum.NormalId.Front
updateCountdown.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
updateCountdown.PixelsPerStud = 3.361344537815126
updateCountdown.LightInfluence = 0
updateCountdown.Brightness = 1.25
updateCountdown.MaxDistance = 2000
updateCountdown.ResetOnSpawn = false
updateCountdown.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local root = Instance.new("Frame")
root.Name = "Root"
root.BackgroundTransparency = 1
root.Size = UDim2.fromScale(1, 1)
root.Parent = updateCountdown

local function text(name: string, a45: number, a46: number, a47: number, a48: number, fontFace, a50: number, frame: Frame?)
    --[[
      name: text
      line: 155
      upvalues:
        root (copy, index: 1)
        imageColor3 (copy, index: 2)
        colors (copy, index: 3)
    ]]
    local frame2 = Instance.new("Frame")
    frame2.Name = name
    frame2.BackgroundTransparency = 1
    frame2.AnchorPoint = Vector2.new(0.5, 0.5)
    frame2.Position = UDim2.fromOffset(a45, a46)
    frame2.Size = UDim2.fromOffset(a47, a48)
    frame2.Parent = frame or root

    local scale = Instance.new("UIScale")
    scale.Parent = frame2

    local function mk(name: string, a56: number, textColor3, textTransparency: number, zIndex: number)
        --[[
          name: mk
          line: 165
          upvalues:
            fontFace (copy, index: 1)
            frame2 (copy, index: 2)
        ]]
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = name
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.FontFace = fontFace
        textLabel.TextColor3 = textColor3
        textLabel.TextTransparency = textTransparency
        textLabel.Position = UDim2.fromOffset(0, a56)
        textLabel.Size = UDim2.fromScale(1, 1)
        textLabel.Text = ""
        textLabel.ZIndex = zIndex
        textLabel.Parent = frame2
        return textLabel
    end

    local shadow = mk("Shadow", a50, imageColor3, 0.45, 1)
    local label = mk("Text", 0, colors.White, 0, 2)

    return {label = label, shadow = shadow, holder = frame2, scale = scale}
end

local plate = Instance.new("ImageLabel")
plate.Name = "Plate"
plate.BackgroundTransparency = 1
plate.Image = "rbxassetid://90962482350826"
plate.ImageColor3 = imageColor3
plate.ImageTransparency = 0.3
plate.ScaleType = Enum.ScaleType.Stretch
plate.AnchorPoint = Vector2.new(0.5, 0.5)
plate.Position = UDim2.fromOffset(600, 112)
plate.Size = UDim2.fromOffset(1240, 300)
plate.Parent = root
local v64 = text("Title", 600, 82, 1000, 84, fontFace, 4)
v64.label.Text = updateCountdown2.title
v64.shadow.Text = updateCountdown2.title
local v65 = text("Timer", 600, 168, 480, 74, fontFace, 4)
local v66 = text("When", 600, 22, 600, 24, fontFace2, 2)
local updateCountdownSkyBig = updateCountdownSky:Clone()
updateCountdownSkyBig.Name = "UpdateCountdownSkyBig"
updateCountdownSkyBig.CFrame = updateCountdownSky.CFrame * CFrame.new(0, 0, -0.3)
updateCountdownSkyBig.Parent = workspace

local updateCountdownBig = updateCountdown:Clone()
updateCountdownBig.Name = "UpdateCountdownBig"
updateCountdownBig.Adornee = updateCountdownSkyBig
updateCountdownBig.PixelsPerStud = 1.680672268907563
updateCountdownBig:ClearAllChildren()
local root2 = Instance.new("Frame")
root2.Name = "Root"
root2.BackgroundTransparency = 1
root2.Size = UDim2.fromScale(1, 1)
root2.Parent = updateCountdownBig
local v70 = text("Big", 300, 62, 560, 84, fontFace, 4, root2)
v70.holder.Visible = false
local v71 = {v64, v65, v66}
local v72 = {}
local ceilingValue = math.ceil(#updateCountdown2.ranks / 2)

for v74, rank in updateCountdown2.ranks do
    local v76 = if v74 <= ceilingValue then 310 - (ceilingValue - v74) * 74 else 890 + ((v74 - ceilingValue) - 1) * 74
    local rank2, img
    local v79
    local v80 = false
    local frame = Instance.new("Frame")
    frame.Name = rank.name
    frame.BackgroundTransparency = 1
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromOffset(v76, 168)
    frame.Size = UDim2.fromOffset(62, 62)
    frame.Parent = root

    local emblem2 = Instance.new("ImageLabel")
    emblem2.Name = "Emblem"
    emblem2.BackgroundTransparency = 1

    if const ranks = UIAssets.Ranks then
        rank2 = ranks[string.lower(rank.name)]

        if rank2 then
            v79 = rank2
        else
            v80 = true
        end
    else
        v80 = true
    end

    if v80 then
        img = rank.img

        if img then
            v79 = img
        else
            v79 = ""
        end
    end

    emblem2.Image = v79
    emblem2.ScaleType = Enum.ScaleType.Fit
    emblem2.Size = UDim2.fromScale(1, 1)
    emblem2.Parent = frame
    local scale = Instance.new("UIScale")
    scale.Parent = frame
    table.insert(v72, {cell = frame, img = emblem2, scale = scale})
end

local hero = Instance.new("Frame")
hero.Name = "Hero"
hero.BackgroundTransparency = 1
hero.AnchorPoint = Vector2.new(0.5, 0.5)
hero.Position = UDim2.fromOffset(640, 120)
hero.Size = UDim2.fromOffset(620, 210)
hero.Visible = false
hero.ZIndex = 3
hero.Parent = root

local instance = Instance.new("UIScale")
instance.Parent = hero

local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://90962482350826"
glow.ImageTransparency = 1
glow.ScaleType = Enum.ScaleType.Stretch
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.fromOffset(100, 105)
glow.Size = UDim2.fromOffset(300, 300)
glow.Parent = hero

local instance2 = Instance.new("UIScale")
instance2.Parent = glow

local emblem3 = Instance.new("ImageLabel")
emblem3.Name = "Emblem"
emblem3.BackgroundTransparency = 1
emblem3.ScaleType = Enum.ScaleType.Fit
emblem3.AnchorPoint = Vector2.new(0.5, 0.5)
emblem3.Position = UDim2.fromOffset(100, 105)
emblem3.Size = UDim2.fromOffset(180, 180)
emblem3.ZIndex = 4
emblem3.Parent = hero
local v90 = text("Kicker", 370, 66, 320, 30, fontFace2, 2, hero)
local v91 = text("HeroName", 370, 124, 320, 80, fontFace, 4, hero)

for _, v93 in {v90, v91} do
    local v94 = v93
    v94.label.TextXAlignment = Enum.TextXAlignment.Left
    v94.shadow.TextXAlignment = Enum.TextXAlignment.Left
    v94.label.ZIndex = 5
    v94.shadow.ZIndex = 4
end

v90.label.Text = "NEW RANK REVEALED"
v90.shadow.Text = "NEW RANK REVEALED"
v90.label.TextColor3 = gold
local flyer = Instance.new("ImageLabel")
flyer.Name = "Flyer"
flyer.BackgroundTransparency = 1
flyer.ScaleType = Enum.ScaleType.Fit
flyer.AnchorPoint = Vector2.new(0.5, 0.5)
flyer.Visible = false
flyer.ZIndex = 6
flyer.Parent = root
updateCountdown.Parent = localPlayer:WaitForChild("PlayerGui")
updateCountdownBig.Parent = localPlayer:WaitForChild("PlayerGui")
local updateCountdownBanner = Instance.new("ScreenGui")
updateCountdownBanner.Name = "UpdateCountdownBanner"
updateCountdownBanner.ResetOnSpawn = false
updateCountdownBanner.DisplayOrder = 30
updateCountdownBanner.IgnoreGuiInset = false
updateCountdownBanner.Parent = localPlayer:WaitForChild("PlayerGui")

local banner = Instance.new("Frame")
banner.Name = "Banner"
banner.AnchorPoint = Vector2.new(0.5, 1)
banner.Position = UDim2.new(0.5, 0, 0, -10)
banner.Size = UDim2.fromOffset(420, 92)
banner.BackgroundColor3 = color3FromRGB(14, 17, 24)
banner.BackgroundTransparency = 0.08
banner.Visible = false
banner.Parent = updateCountdownBanner

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 14)
uiCorner.Parent = banner

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = gold
uiStroke.Transparency = 0.25
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = banner

local imageLabel = Instance.new("ImageLabel")
imageLabel.BackgroundTransparency = 1
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.Position = UDim2.fromOffset(12, 10)
imageLabel.Size = UDim2.fromOffset(72, 72)
imageLabel.Parent = banner

local textLabel = Instance.new("TextLabel")
textLabel.BackgroundTransparency = 1
textLabel.Position = UDim2.fromOffset(98, 14)
textLabel.Size = UDim2.new(1, -110, 0, 22)
textLabel.FontFace = fontFace2
textLabel.TextSize = 17
textLabel.TextColor3 = gold
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Text = "NEW RANK REVEALED"
textLabel.Parent = banner

local textLabel2 = Instance.new("TextLabel")
textLabel2.BackgroundTransparency = 1
textLabel2.Position = UDim2.fromOffset(98, 38)
textLabel2.Size = UDim2.new(1, -110, 0, 40)
textLabel2.FontFace = fontFace
textLabel2.TextScaled = true
textLabel2.TextColor3 = colors.White
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = banner
local count = 0

local function showBanner(rank)
    --[[
      name: showBanner
      line: 368
      upvalues:
        count (ref,  index: 1)
        imageLabel (copy, index: 2)
        UIAssets (copy, index: 3)
        textLabel2 (copy, index: 4)
        banner (copy, index: 5)
        tweenService (copy, index: 6)
    ]]
    count += 1
    local v106 = count
    local ranks = UIAssets.Ranks
    imageLabel.Image = ranks and ranks[string.lower(rank.name)] or rank.img or ""
    textLabel2.Text = rank.name
    banner.Position = UDim2.new(0.5, 0, 0, -10)
    banner.Visible = true
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local propertyTable = {Position = UDim2.new(0.5, 0, 0, 110)}
    tweenService:Create(banner, tweenInfo, propertyTable):Play()

    task.delay(
        4.2,
        function()
            --[[
              line: 376
              upvalues:
                count (ref,  index: 1)
                v106 (copy, index: 2)
                tweenService (copy, index: 3)
                banner (copy, index: 4)
            ]]
            if count == v106 then
                local tween = tweenService:Create(banner, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -10)})

                tween.Completed:Once(
                    function()
                        --[[
                          line: 379
                          upvalues:
                            count (ref,  index: 1)
                            v106 (copy, index: 2)
                            banner (copy, index: 3)
                        ]]
                        if count == v106 then
                            banner.Visible = false
                        end
                    end
                )

                tween:Play()
            end
        end
    )
end

local updateCountdownFx = Instance.new("Folder")
updateCountdownFx.Name = "UpdateCountdownFx"
updateCountdownFx.Parent = workspace
local random = Random.new()
local rightVector = updateCountdownSky.CFrame.RightVector
local upVector = updateCountdownSky.CFrame.UpVector
local vector3 = -updateCountdownSky.CFrame.LookVector

local function around(a117, a118, a119)
    --[[
      name: around
      line: 401
      upvalues:
        rightVector (copy, index: 1)
        upVector (copy, index: 2)
        vector3 (copy, index: 3)
    ]]
    return (Vector3.new(0, 66, -135) + (rightVector * a117)) + (upVector * a118) + (vector3 * (a119 or 30))
end

local v120 = {}

local function fwSound(key: string, a123: number, a124: number, volume: number)
    --[[
      name: fwSound
      line: 410
      upvalues:
        Sfx (ref,  index: 1)
        v120 (copy, index: 2)
        random (copy, index: 3)
    ]]
    if not Sfx or os.clock() - (v120[key] or 0) < a123 then
        return
    end

    v120[key] = os.clock()
    task.delay(
        a124,
        function()
            --[[
              line: 415
              upvalues:
                Sfx (ref,  index: 1)
                key (copy, index: 2)
                volume (copy, index: 3)
                random (copy, index: 4)
            ]]
            pcall(Sfx.Play, key, nil, {volume = volume, pitch = random:NextNumber(0.94, 1.06)})
        end
    )
end

local function boom(a127)
    --[[
      name: boom
      line: 419
      upvalues:
        fwSound (copy, index: 1)
    ]]
    fwSound("Firework/Explode", 0.25, 0.15, 1)
    fwSound("Firework/Crackle", 0.6, 0.45, 1)
end

local function burst(a129, startValue, a131)
    --[[
      name: burst
      line: 424
      upvalues:
        updateCountdownFx (copy, index: 1)
        colors (copy, index: 2)
    ]]
    local parent = Instance.new("Part")
    parent.Anchored = true
    parent.CanCollide = false
    parent.CanQuery = false
    parent.CanTouch = false
    parent.Transparency = 1
    parent.Size = Vector3.new(1, 1, 1)
    parent.CFrame = CFrame.new(a129)
    parent.Parent = updateCountdownFx

    local function emitter(particleCount: number, a135, a136, a137: number, interpolatedValue, brightness: number)
        --[[
          name: emitter
          line: 434
          upvalues:
            startValue (copy, index: 1)
            parent (copy, index: 2)
        ]]
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.LightEmission = 1
        particleEmitter.LightInfluence = 0
        particleEmitter.Brightness = brightness
        particleEmitter.Color = ColorSequence.new(interpolatedValue, startValue)
        particleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a135), NumberSequenceKeypoint.new(0.7, a135 * 0.6), NumberSequenceKeypoint.new(1, 0)})
        particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.15), NumberSequenceKeypoint.new(1, 1)})
        particleEmitter.Lifetime = NumberRange.new(a137 * 0.75, a137)
        particleEmitter.Speed = NumberRange.new(a136 * 0.8, a136)
        particleEmitter.SpreadAngle = Vector2.new(180, 180)
        particleEmitter.Acceleration = Vector3.new(0, -22, 0)
        particleEmitter.Drag = 1.6
        particleEmitter.Rate = 0
        particleEmitter.RotSpeed = NumberRange.new(-180, 180)
        particleEmitter.Parent = parent
        particleEmitter:Emit(particleCount)
    end

    emitter(math.floor(a131 * 120), a131 * 8, a131 * 72, 2, startValue:Lerp(colors.White, 0.1), 3)
    emitter(math.floor(a131 * 26), a131 * 4, a131 * 36, 2.6, startValue:Lerp(colors.White, 0.6), 2)
    task.delay(
        4,
        function()
            --[[
              line: 456
              upvalues:
                parent (copy, index: 1)
            ]]
            parent:Destroy()
        end
    )
end

local function rocket(a142, startValue, a144)
    --[[
      name: rocket
      line: 462
      upvalues:
        random (copy, index: 1)
        colors (copy, index: 2)
        updateCountdownFx (copy, index: 3)
        tweenService (copy, index: 4)
        burst (copy, index: 5)
        fwSound (copy, index: 6)
    ]]
    local vector3 = Vector3.new(a142.X + random:NextNumber(-20, 20), 30, a142.Z + random:NextNumber(-10, 10))
    local instance = Instance.new("Part")
    instance.Anchored = true
    instance.CanCollide = false
    instance.CanQuery = false
    instance.CanTouch = false
    instance.CastShadow = false
    instance.Material = Enum.Material.Neon
    instance.Color = startValue:Lerp(colors.White, 0.5)
    instance.Size = Vector3.new(1.600000023841858, 1.600000023841858, 1.600000023841858)
    instance.Shape = Enum.PartType.Ball
    instance.CFrame = CFrame.new(vector3)

    local attachment0 = Instance.new("Attachment")
    attachment0.Position = Vector3.new(0, 0.800000011920929, 0)
    attachment0.Parent = instance

    local attachment1 = Instance.new("Attachment")
    attachment1.Position = Vector3.new(0, -0.800000011920929, 0)
    attachment1.Parent = instance

    local trail = Instance.new("Trail")
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Lifetime = 0.45
    trail.LightEmission = 1
    trail.FaceCamera = true
    trail.Color = ColorSequence.new(startValue:Lerp(colors.White, 0.6), startValue)
    trail.Transparency = NumberSequence.new(0, 1)
    trail.WidthScale = NumberSequence.new(1, 0)
    trail.Parent = instance
    instance.Parent = updateCountdownFx
    local tween = tweenService:Create(instance, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(a142)})

    tween.Completed:Once(
        function()
            --[[
              line: 493
              upvalues:
                instance (copy, index: 1)
                burst (copy, index: 2)
                a142 (copy, index: 3)
                startValue (copy, index: 4)
                a144 (copy, index: 5)
                fwSound (copy, index: 6)
            ]]
            instance.Transparency = 1
            burst(a142, startValue, a144)
            fwSound("Firework/Explode", 0.25, 0.15, 1)
            fwSound("Firework/Crackle", 0.6, 0.45, 1)
            task.delay(
                0.6,
                function()
                    --[[
                      line: 497
                      upvalues:
                        instance (copy, index: 1)
                    ]]
                    instance:Destroy()
                end
            )
        end
    )

    tween:Play()
end

local v151 = {color3FromRGB(255, 204, 64), color3FromRGB(255, 92, 92), color3FromRGB(86, 202, 255), color3FromRGB(186, 116, 255), color3FromRGB(120, 236, 150), color3FromRGB(255, 150, 80)}

local function volley(a153, a154: number, a155, a156)
    --[[
      name: volley
      line: 507
      upvalues:
        random (copy, index: 1)
        localPlayer (copy, index: 2)
        rocket (copy, index: 3)
        rightVector (copy, index: 4)
        upVector (copy, index: 5)
        vector3 (copy, index: 6)
        v151 (copy, index: 7)
    ]]
    for index = 1, a153 do
        task.delay(
            (((index - 1) / math.max(1, a153 - 1)) * a154) + random:NextNumber(0, 0.15),
            function()
                --[[
                  line: 509
                  upvalues:
                    localPlayer (copy, index: 1)
                    index (copy, index: 2)
                    random (copy, index: 3)
                    rocket (copy, index: 4)
                    rightVector (copy, index: 5)
                    upVector (copy, index: 6)
                    vector3 (copy, index: 7)
                    a155 (copy, index: 8)
                    v151 (copy, index: 9)
                    a156 (copy, index: 10)
                ]]
                if localPlayer:GetAttribute("State") == "Match" then
                    return
                end

                local v158 = index % 2 ~= 0 and -1 or 1
                local v159 = v158 * random:NextNumber(150, 260)
                local v160 = random:NextNumber(10, 80)

                if index % 3 == 0 then
                    v159 = random:NextNumber(-140, 140)
                    v160 = random:NextNumber(70, 110)
                end

                rocket(((Vector3.new(0, 66, -135) + (rightVector * v159)) + (upVector * v160)) + (vector3 * 30), (a155
                    or v151[random:NextInteger(1, #v151)]), a156)
            end
        )
    end
end

local lighting2 = replicatedStorage:FindFirstChild("Lighting")
local lobby = lighting2 and lighting2:FindFirstChild("Lobby")

local function base(attributeName: string, a165)
    --[[
      name: base
      line: 529
      upvalues:
        lobby (copy, index: 1)
    ]]
    local v166 = lobby and lobby:GetAttribute(attributeName)
    if v166 ~= nil then
        return v166
    end

    return a165
end

local atmosphere = lobby and lobby:FindFirstChildOfClass("Atmosphere")
local v168 = {}
local clockTime = lobby and lobby:GetAttribute("ClockTime")
v168.clock = clockTime == nil and 16.3 or clockTime
local color3 = color3FromRGB(214, 184, 140)
local colorShiftTop = lobby and lobby:GetAttribute("ColorShift_Top")
v168.shiftTop = if colorShiftTop ~= nil then colorShiftTop else color3
local brightness = lobby and lobby:GetAttribute("Brightness")
v168.brightness = brightness == nil and 2.5 or brightness
local color32 = color3FromRGB(136, 128, 126)
local outdoorAmbient = lobby and lobby:GetAttribute("OutdoorAmbient")
v168.outdoor = if outdoorAmbient ~= nil then outdoorAmbient else color32
v168.atmColor = if atmosphere then atmosphere.Color else color3FromRGB(224, 210, 190)
v168.atmDecay = if atmosphere then atmosphere.Decay else color3FromRGB(170, 160, 178)
v168.atmHaze = not atmosphere and 1.2 or atmosphere.Haze
v168.atmDensity = not atmosphere and 0.24 or atmosphere.Density
v168.atmGlare = not atmosphere and 0.08 or atmosphere.Glare
local sunRaysEffect = lobby and lobby:FindFirstChildOfClass("SunRaysEffect")
v168.rays = not sunRaysEffect and 0.035 or sunRaysEffect.Intensity
local v176 = {clock = 17.35, haze = 1.6, density = 0.27, glare = 2.2, bright = 2.9, rays = 0.14, shiftTop = color3FromRGB(255, 176, 110), atmColor = color3FromRGB(255, 178, 130), atmDecay = color3FromRGB(232, 128, 140), outdoor = color3FromRGB(170, 132, 118)}
local v177 = {clock = 17.62, haze = 1.9, density = 0.29, glare = 3, bright = 2.6, rays = 0.2, shiftTop = color3FromRGB(255, 140, 100), atmColor = color3FromRGB(255, 150, 120), atmDecay = color3FromRGB(196, 98, 150), outdoor = color3FromRGB(156, 112, 128)}
local updateCountdownGrade = Instance.new("ColorCorrectionEffect")
updateCountdownGrade.Name = "UpdateCountdownGrade"
updateCountdownGrade.Enabled = false
updateCountdownGrade.Parent = camera
local LightingController = nil
pcall(
    function()
        --[[
          line: 560
          upvalues:
            LightingController (ref, index: 1)
        ]]
        LightingController = require(script.Parent.Parent.Core.LightingController)
    end
)

local function lobbyLit()
    --[[
      name: lobbyLit
      line: 563
      upvalues:
        LightingController (ref, index: 1)
    ]]
    if not LightingController then
        return true
    end

    local success, result = pcall(LightingController.Current)

    return success and (result == "Lobby")
end

local v183 = {w = 0, d = 0}
local v184 = false

local function paintSky(alpha, alpha2)
    --[[
      name: paintSky
      line: 573
      upvalues:
        localPlayer (copy, index: 1)
        LightingController (ref,  index: 2)
        updateCountdownGrade (copy, index: 3)
        v184 (ref,  index: 4)
        lighting (copy, index: 5)
        v168 (copy, index: 6)
        v176 (copy, index: 7)
        v177 (copy, index: 8)
        colors (copy, index: 9)
        color3FromRGB (copy, index: 10)
    ]]
    if localPlayer:GetAttribute("State") ~= "Match" then
        local v188

        if LightingController then
            local success, result = pcall(LightingController.Current)
            v188 = success
            v188 = v188 and result == "Lobby"
        else
            v188 = true
        end

        if v188 then
            local clockTime
            local colorShiftTop
            local brightness2
            local v194
            local tintColor

            if alpha <= 0.001 then
                if alpha2 <= 0.001 then
                    if v184 then
                        lighting.ClockTime = v168.clock
                        lighting.ColorShift_Top = v168.shiftTop
                        lighting.Brightness = v168.brightness
                        lighting.OutdoorAmbient = v168.outdoor

                        if const atmosphere = lighting:FindFirstChildOfClass("Atmosphere") then
                            atmosphere.Color, atmosphere.Decay, atmosphere.Haze, atmosphere.Density, atmosphere.Glare = v168.atmColor, v168.atmDecay, v168.atmHaze, v168.atmDensity, v168.atmGlare
                        end

                        if const sunRaysEffect = lighting:FindFirstChildOfClass("SunRaysEffect") then
                            sunRaysEffect.Intensity = v168.rays
                        end

                        v184 = false
                    end

                    updateCountdownGrade.Enabled = false

                    return
                end
            end

            v184 = true

            local function mix(startValue, targetValue, targetValue2)
                --[[
                  name: mix
                  line: 600
                  upvalues:
                    alpha (copy, index: 1)
                    alpha2 (copy, index: 2)
                ]]
                if typeof(startValue) ~= "Color3" then
                    local v202 = startValue + (targetValue - startValue) * alpha
                    return v202 + ((targetValue2 - v202) * alpha2)
                end

                local startValue2 = startValue:Lerp(targetValue, alpha)

                return startValue2:Lerp(targetValue2, alpha2)
            end

            local clock = v168.clock
            local clock2 = v176.clock
            local clock3 = v177.clock

            if typeof(clock) ~= "Color3" then
                local v207 = clock + (clock2 - clock) * alpha
                clockTime = v207 + (clock3 - v207) * alpha2
            else
                clockTime = clock:Lerp(clock2, alpha):Lerp(clock3, alpha2)
            end

            lighting.ClockTime = clockTime
            local shiftTop = v168.shiftTop
            local shiftTop2 = v176.shiftTop
            local shiftTop3 = v177.shiftTop

            if typeof(shiftTop) ~= "Color3" then
                local v211 = shiftTop + (shiftTop2 - shiftTop) * alpha
                colorShiftTop = v211 + (shiftTop3 - v211) * alpha2
                colorShiftTop = v168
            else
                colorShiftTop = shiftTop:Lerp(shiftTop2, alpha):Lerp(shiftTop3, alpha2)
                colorShiftTop = v168
            end

            lighting.ColorShift_Top = colorShiftTop
            local brightness = colorShiftTop.brightness
            local bright = v176.bright
            local bright2 = v177.bright

            if typeof(brightness) ~= "Color3" then
                local v215 = brightness + (bright - brightness) * alpha
                brightness2 = v215 + (bright2 - v215) * alpha2
            else
                brightness2 = brightness:Lerp(bright, alpha):Lerp(bright2, alpha2)
            end

            lighting.Brightness = brightness2
            local outdoor = colorShiftTop.outdoor
            local outdoor2 = v176.outdoor
            local outdoor3 = v177.outdoor

            if typeof(outdoor) ~= "Color3" then
                local v219 = outdoor + (outdoor2 - outdoor) * alpha
                v194 = v219 + (outdoor3 - v219) * alpha2
                v194 = lighting
            else
                v194 = outdoor:Lerp(outdoor2, alpha):Lerp(outdoor3, alpha2)
                v194 = lighting
            end

            lighting.OutdoorAmbient = v194

            if const sunRaysEffect = v194:FindFirstChildOfClass("SunRaysEffect") then
                local intensity
                local rays = colorShiftTop.rays
                local rays2 = v176.rays
                local rays3 = v177.rays

                if typeof(rays) ~= "Color3" then
                    local v225 = rays + (rays2 - rays) * alpha
                    intensity = v225 + (rays3 - v225) * alpha2
                else
                    intensity = rays:Lerp(rays2, alpha):Lerp(rays3, alpha2)
                end

                sunRaysEffect.Intensity = intensity
            end

            if const atmosphere = lighting:FindFirstChildOfClass("Atmosphere") then
                local color
                local decay
                local haze3
                local density3
                local glare3
                local atmColor = colorShiftTop.atmColor
                local atmColor2 = v176.atmColor
                local atmColor3 = v177.atmColor

                if typeof(atmColor) ~= "Color3" then
                    local v235 = atmColor + (atmColor2 - atmColor) * alpha
                    color = v235 + (atmColor3 - v235) * alpha2
                else
                    color = atmColor:Lerp(atmColor2, alpha):Lerp(atmColor3, alpha2)
                end

                atmosphere.Color = color
                local atmDecay = colorShiftTop.atmDecay
                local atmDecay2 = v176.atmDecay
                local atmDecay3 = v177.atmDecay

                if typeof(atmDecay) ~= "Color3" then
                    local v239 = atmDecay + (atmDecay2 - atmDecay) * alpha
                    decay = v239 + (atmDecay3 - v239) * alpha2
                    decay = v168
                else
                    decay = atmDecay:Lerp(atmDecay2, alpha):Lerp(atmDecay3, alpha2)
                    decay = v168
                end

                atmosphere.Decay = decay
                local atmHaze = decay.atmHaze
                local haze = v176.haze
                local haze2 = v177.haze

                if typeof(atmHaze) ~= "Color3" then
                    local v243 = atmHaze + (haze - atmHaze) * alpha
                    haze3 = v243 + (haze2 - v243) * alpha2
                else
                    haze3 = atmHaze:Lerp(haze, alpha):Lerp(haze2, alpha2)
                end

                atmosphere.Haze = haze3
                local atmDensity = decay.atmDensity
                local density = v176.density
                local density2 = v177.density

                if typeof(atmDensity) ~= "Color3" then
                    local v247 = atmDensity + (density - atmDensity) * alpha
                    density3 = v247 + (density2 - v247) * alpha2
                    density3 = v168
                else
                    density3 = atmDensity:Lerp(density, alpha):Lerp(density2, alpha2)
                    density3 = v168
                end

                atmosphere.Density = density3
                local atmGlare = density3.atmGlare
                local glare = v176.glare
                local glare2 = v177.glare

                if typeof(atmGlare) ~= "Color3" then
                    local v251 = atmGlare + (glare - atmGlare) * alpha
                    glare3 = v251 + (glare2 - v251) * alpha2
                else
                    glare3 = atmGlare:Lerp(glare, alpha):Lerp(glare2, alpha2)
                end

                atmosphere.Glare = glare3
            end

            updateCountdownGrade.Enabled = true
            local white = colors.White
            local targetValue = color3FromRGB(255, 238, 222)
            local targetValue2 = color3FromRGB(255, 228, 226)

            if typeof(white) ~= "Color3" then
                local v255 = white + (targetValue - white) * alpha
                tintColor = v255 + (targetValue2 - v255) * alpha2
            else
                tintColor = white:Lerp(targetValue, alpha):Lerp(targetValue2, alpha2)
            end

            updateCountdownGrade.TintColor = tintColor
            updateCountdownGrade.Saturation = alpha * 0.12
            updateCountdownGrade.Contrast = alpha * 0.05
            updateCountdownGrade.Brightness = alpha * 0.03

            return
        end
    end

    updateCountdownGrade.Enabled = false
    v184 = false
end

local function clock(ceilingValue: number)
    --[[
      name: clock
      line: 633
    ]]
    local v258 = ceilingValue // 86400
    local v259 = ceilingValue // 3600 % 24
    local v260 = ceilingValue // 60 % 60
    local v261 = ceilingValue % 60

    if 0 < v258 then
        return string.format("%dD %02d:%02d:%02d", v258, v259, v260, v261)
    end
    if 0 < v259 then
        return string.format("%d:%02d:%02d", v259, v260, v261)
    end

    return string.format("%d:%02d", v260, v261)
end

local at = updateCountdown2.at
local success, result = pcall(
    function()
        --[[
          line: 645
          upvalues:
            at (copy, index: 1)
        ]]
        return DateTime.fromUnixTimestamp(at):FormatLocalTime("dddd h:mm A", "en-us")
    end
)

if success then
    v2 = string.upper(result) .. " YOUR TIME"
else
    v2 = ""
end

local v265 = {}

local function set(key, text)
    --[[
      name: set
      line: 653
      upvalues:
        v265 (copy, index: 1)
    ]]
    if v265[key] ~= text then
        v265[key] = text
        key.label.Text = text
        key.shadow.Text = text
    end
end

local function fadeText(textTransparency: number, a271: number)
    --[[
      name: fadeText
      line: 661
      upvalues:
        v71 (copy, index: 1)
        tweenService (copy, index: 2)
    ]]
    for _, v273 in v71 do
        local propertyTable = {TextTransparency = textTransparency}
        tweenService:Create(v273.label, TweenInfo.new(a271), propertyTable):Play()
        local shadow = v273.shadow
        local tweenInfo = TweenInfo.new(a271)
        local propertyTable2 = {TextTransparency = math.max(textTransparency, 0.45)}
        tweenService:Create(shadow, tweenInfo, propertyTable2):Play()
    end
end

local function paintSlot(rankKey, out)
    --[[
      name: paintSlot
      line: 668
      upvalues:
        v72 (copy, index: 1)
        updateCountdown2 (copy, index: 2)
        colors (copy, index: 3)
        imageColor3 (copy, index: 4)
    ]]
    local v281 = v72[rankKey]
    local _ = updateCountdown2.ranks[rankKey]
    v281.out = out

    if out then
        v281.img.ImageColor3 = colors.White
        v281.img.ImageTransparency = 0

        return
    end

    v281.img.ImageColor3 = imageColor3
    v281.img.ImageTransparency = 0.15
end

local v283 = false
local removedValue = 0

local function reveal(rankKey)
    --[[
      name: reveal
      line: 685
      upvalues:
        updateCountdown2 (copy, index: 1)
        gold (copy, index: 2)
        v283 (ref,  index: 3)
        removedValue (ref,  index: 4)
        v72 (copy, index: 5)
        imageColor3 (copy, index: 6)
        emblem3 (copy, index: 7)
        UIAssets (copy, index: 8)
        v91 (copy, index: 9)
        v265 (copy, index: 10)
        colors (copy, index: 11)
        v90 (copy, index: 12)
        hero (copy, index: 13)
        instance (copy, index: 14)
        fadeText (copy, index: 15)
        tweenService (copy, index: 16)
        glow (copy, index: 17)
        instance2 (copy, index: 18)
        Sfx (ref,  index: 19)
        volley (copy, index: 20)
        showBanner (copy, index: 21)
        flyer (copy, index: 22)
    ]]
    local rank = updateCountdown2.ranks[rankKey]
    local v288 = rank.color or gold
    local v289 = rankKey == #updateCountdown2.ranks
    v283 = true
    removedValue = rankKey
    local v290 = v72[rankKey]
    local _ = updateCountdown2.ranks[rankKey]
    v290.out = false
    v290.img.ImageColor3 = imageColor3
    v290.img.ImageTransparency = 0.15
    local ranks = UIAssets.Ranks
    emblem3.Image = ranks and ranks[string.lower(rank.name)] or rank.img or ""
    emblem3.ImageTransparency = 0
    local name = rank.name

    if v265[v91] ~= name then
        v265[v91] = name
        v91.label.Text = name
        v91.shadow.Text = name
    end

    v91.label.TextColor3 = v288:Lerp(colors.White, 0.35)

    for _, v295 in {v91, v90} do
        v295.label.TextTransparency = 0
        v295.shadow.TextTransparency = 0.45
    end

    hero.Position = UDim2.fromOffset(640, 120)
    hero.Visible = true
    instance.Scale = 0.3
    fadeText(1, 0.2)
    local propertyTable = {Scale = 1}
    tweenService:Create(instance, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
    glow.ImageColor3 = v288
    glow.ImageTransparency = 0
    instance2.Scale = 0.4
    local propertyTable2 = {ImageTransparency = 0.55}
    tweenService:Create(glow, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
    local propertyTable3 = {Scale = 1.3}
    tweenService:Create(instance2, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable3):Play()

    if Sfx then
        pcall(Sfx.PlayUI, "UI/Unlock")
    end

    if v289 then
        task.delay(
            0.15,
            function()
                --[[
                  line: 712
                  upvalues:
                    Sfx (ref, index: 1)
                ]]
                if Sfx then
                    pcall(Sfx.PlayUI, "UI/NewItem_Fanfare")
                end
            end
        )
    end

    local v299 = v289 and 14 or 8
    local v300 = v289 and 1.35 or 1.1
    volley(v299, 2.4, v288, v300)
    showBanner(rank)

    task.delay(
        3.4,
        function()
            --[[
              line: 718
              upvalues:
                v72 (copy, index: 1)
                rankKey (copy, index: 2)
                flyer (copy, index: 3)
                rank (copy, index: 4)
                UIAssets (copy, index: 5)
                hero (copy, index: 6)
                glow (copy, index: 7)
                tweenService (copy, index: 8)
                updateCountdown2 (copy, index: 9)
                colors (copy, index: 10)
                Sfx (ref,  index: 11)
                fadeText (copy, index: 12)
                v283 (ref,  index: 13)
                removedValue (ref,  index: 14)
            ]]
            local v301
            local v302 = false
            local v303 = v72[rankKey]
            local vector2 = Vector2.new(430, 120)
            local rank2 = rank

            if const ranks = UIAssets.Ranks then
                v301 = ranks[string.lower(rank2.name)]

                if v301 then
                    v301 = flyer
                else
                    v302 = true
                end
            else
                v302 = true
            end

            if v302 then
                v301 = rank2.img

                if v301 then
                    v301 = flyer
                else
                    v301 = ""
                    v301 = flyer
                end
            end

            flyer.Image = v301
            v301.Position = UDim2.fromOffset(vector2.X, vector2.Y)
            v301.Size = UDim2.fromOffset(180, 180)
            v301.Visible = true
            hero.Visible = false
            glow.ImageTransparency = 1
            local position = v303.cell.Position
            local tweenInfo = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            local propertyTable = {Position = position, Size = UDim2.fromOffset(62, 62)}
            tweenService:Create(v301, tweenInfo, propertyTable):Play()
            task.wait(0.55)
            v301.Visible = false
            local v310 = v72[rankKey]
            local _ = updateCountdown2.ranks[rankKey]
            v310.out = true
            v310.img.ImageColor3 = colors.White
            v310.img.ImageTransparency = 0
            v303.scale.Scale = 1.6
            local propertyTable2 = {Scale = 1}
            tweenService:Create(v303.scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable2):Play()

            if Sfx then
                pcall(Sfx.PlayUI, "UI/Card_Reveal")
            end

            fadeText(0, 0.35)
            v283 = false
            removedValue = 0
        end
    )
end

local ceilingValue2 = -1
local v314 = ""
local v315 = false
local timestamp2 = os.clock()
local timestamp3 = nil
local v318 = 0
local v319 = {}

workspace:GetAttributeChangedSignal("CountdownPreviewAt"):Connect(
    function()
        --[[
          line: 754
          upvalues:
            v315 (ref,  index: 1)
            v314 (ref,  index: 2)
            timestamp3 (ref,  index: 3)
            v319 (copy, index: 4)
        ]]
        v315 = false
        v314 = ""
        timestamp3 = nil
        table.clear(v319)
    end
)

step = function(a320)
    --[[
      name: step
      line: 761
      upvalues:
        workspace (copy, index: 1)
        updateCountdown2 (copy, index: 2)
        localPlayer (copy, index: 3)
        updateCountdown (copy, index: 4)
        updateCountdownBig (copy, index: 5)
        updateCountdownBanner (copy, index: 6)
        v72 (copy, index: 7)
        v315 (ref,  index: 8)
        colors (copy, index: 9)
        imageColor3 (copy, index: 10)
        v319 (copy, index: 11)
        removedValue (ref,  index: 12)
        timestamp2 (copy, index: 13)
        v283 (ref,  index: 14)
        reveal (copy, index: 15)
        v23 (copy, index: 16)
        v24 (copy, index: 17)
        replicatedStorage (copy, index: 18)
        v183 (copy, index: 19)
        paintSky (copy, index: 20)
        v64 (copy, index: 21)
        gold (copy, index: 22)
        v65 (copy, index: 23)
        v66 (copy, index: 24)
        v265 (copy, index: 25)
        v70 (copy, index: 26)
        ceilingValue2 (ref,  index: 27)
        tweenService (copy, index: 28)
        Sfx (ref,  index: 29)
        v2 (copy, index: 30)
        clock (copy, index: 31)
        v314 (ref,  index: 32)
        timestamp3 (ref,  index: 33)
        volley (copy, index: 34)
        v318 (ref,  index: 35)
        random (copy, index: 36)
    ]]
    local v321
    local serverTimeNow = workspace:GetServerTimeNow()
    local countdownPreview = workspace:GetAttribute("CountdownPreview")
    local countdownPreviewAt = workspace:GetAttribute("CountdownPreviewAt")

    if type(countdownPreview) == "number" and type(countdownPreviewAt) == "number" then
        v321 = updateCountdown2.at - countdownPreview + (serverTimeNow - countdownPreviewAt)
    else
        v321 = serverTimeNow
    end

    local v325 = updateCountdown2.at - v321
    local enabled = localPlayer:GetAttribute("State") ~= "Match"
    updateCountdown.Enabled = enabled
    updateCountdownBig.Enabled = enabled
    updateCountdownBanner.Enabled = enabled

    for rankKey, rank in updateCountdown2.ranks do
        local v329 = updateCountdown2.at - rank.hours * 3600
        local out = v329 <= v321
        local v331 = v72[rankKey]

        if v331.out == nil or not v315 then
            local v332 = v72[rankKey]
            local _ = updateCountdown2.ranks[rankKey]
            v332.out = out

            if out then
                v332.img.ImageColor3 = colors.White
                v332.img.ImageTransparency = 0
            else
                v332.img.ImageColor3 = imageColor3
                v332.img.ImageTransparency = 0.15
            end
        elseif out and not v331.out and not table.find(v319, rankKey) and removedValue ~= rankKey then
            if not (v321 - v329 < 4) or not (6 < os.clock() - timestamp2) then
                local v334 = v72[rankKey]
                local _ = updateCountdown2.ranks[rankKey]
                v334.out = true
                v334.img.ImageColor3 = colors.White
                v334.img.ImageTransparency = 0
            else
                table.insert(v319, rankKey)
            end
        elseif not out and v331.out then
            local v336 = v72[rankKey]
            local _ = updateCountdown2.ranks[rankKey]
            v336.out = false
            v336.img.ImageColor3 = imageColor3
            v336.img.ImageTransparency = 0.15
        end
    end

    v315 = true

    if not v283 and 0 < #v319 then
        local rankKey = table.remove(v319, 1)

        if enabled then
            reveal(rankKey)
        else
            local v339 = v72[rankKey]
            local _ = updateCountdown2.ranks[rankKey]
            v339.out = true
            v339.img.ImageColor3 = colors.White
            v339.img.ImageTransparency = 0
        end
    end

    local v341 = 0
    local v342 = 0

    if 0 < v325 and v325 <= v23 then
        if v24 < v325 then
            local v343 = (v23 - v325) / (v23 - v24)
            v341 = (0.6 * v343) * v343 * (3 - (2 * v343))
        else
            v341 = 0.6 + 0.4 * (1 - (math.max(0, v325 - 60) / (v24 - 60)))
        end

        v342 = not (v325 <= 60) and 0 or 1 - v325 / 60
    elseif v325 <= 0
        and workspace:GetAttribute("CountdownPreviewShipped") ~= true
        and (updateCountdown2.shipped == nil
            or replicatedStorage.Shared:FindFirstChild(updateCountdown2.shipped) == nil)
    then
        v341 = 1
        v342 = 1
    end

    local v344 = os.clock() - timestamp2 < 0.4 and 1 or math.min(1, a320 * 0.6)
    v183.w += ((v341 - v183.w) * v344)
    v183.d += ((v342 - v183.d) * v344)
    paintSky(v183.w, v183.d)

    if not (0 < v325) then
        if v314 == "final" or v314 == "close" then
            timestamp3 = os.clock()

            if enabled then
                if Sfx then
                    pcall(Sfx.PlayUI, "Match/Victory")
                end

                volley(16, 7, nil, 1.5)
                task.delay(
                    7.5,
                    function()
                        --[[
                          line: 863
                          upvalues:
                            volley (copy, index: 1)
                        ]]
                        volley(10, 3, nil, 1.8)
                    end
                )
            end
        end

        if v314 ~= "done" then
            v70.scale.Scale = 0.4
            local propertyTable = {Scale = 1}
            tweenService:Create(v70.scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
        end

        v314 = "done"

        for _, v347 in v72 do
            v347.cell.Visible = false
        end

        v64.holder.Visible = false
        v65.holder.Visible = false
        v66.holder.Visible = true
        v70.holder.Visible = true
        v66.label.TextColor3 = gold
        local text = string.upper(updateCountdown2.title)

        if v265[v66] ~= text then
            v265[v66] = text
            v66.label.Text = text
            v66.shadow.Text = text
        end

        if workspace:GetAttribute("CountdownPreviewShipped") == true
            or updateCountdown2.shipped ~= nil
                and replicatedStorage.Shared:FindFirstChild(updateCountdown2.shipped) ~= nil
        then
            local v349 = -v325

            if updateCountdown2.OUT_FOR < v349 then
                return false
            end

            if v265[v70] ~= "OUT NOW!" then
                v265[v70] = "OUT NOW!"
                v70.label.Text = "OUT NOW!"
                v70.shadow.Text = "OUT NOW!"
            end

            v70.label.TextColor3 = gold

            if enabled then
                local timestamp = os.clock()

                if v318 <= timestamp and -v325 < 7200 then
                    v318 = os.clock() + random:NextNumber(25, 40)

                    if timestamp3 == nil or 15 < os.clock() - timestamp3 then
                        volley(5, 2.5, nil, 1.1)
                    end
                end
            end
        else
            if v265[v70] ~= "SERVERS RESTARTING..." then
                v265[v70] = "SERVERS RESTARTING..."
                v70.label.Text = "SERVERS RESTARTING..."
                v70.shadow.Text = "SERVERS RESTARTING..."
            end

            v70.label.TextColor3 = colors.White
        end

        return true
    end

    local ceilingValue = math.ceil(v325)
    local v352 = v325 <= 60 and "final" or v325 <= v24 and "close" or "far"

    for _, v354 in v72 do
        v354.cell.Visible = true
    end

    local v355 = v352 ~= "far"
    v64.label.TextColor3 = if v355 then gold else colors.White
    v65.label.TextColor3 = if v355 then gold else colors.White

    if v352 ~= "final" then
        local text = v2

        if v265[v66] ~= text then
            v265[v66] = text
            v66.label.Text = text
            v66.shadow.Text = text
        end

        v66.label.TextColor3 = colors.White
        v64.holder.Visible = true
        v65.holder.Visible = true
        v70.holder.Visible = false
        local v357 = v65
        local text2 = clock(ceilingValue)

        if v265[v357] ~= text2 then
            v265[v357] = text2
            v357.label.Text = text2
            v357.shadow.Text = text2
        end
    else
        local text3 = string.upper(updateCountdown2.title) .. " IN"

        if v265[v66] ~= text3 then
            v265[v66] = text3
            v66.label.Text = text3
            v66.shadow.Text = text3
        end

        v66.label.TextColor3 = gold
        v64.holder.Visible = false
        v65.holder.Visible = false
        v70.holder.Visible = not v283
        v70.label.TextColor3 = if ceilingValue <= 10 then colors.White else gold

        if ceilingValue ~= ceilingValue2 then
            local text = tostring(ceilingValue)

            if v265[v70] ~= text then
                v265[v70] = text
                v70.label.Text = text
                v70.shadow.Text = text
            end

            v70.scale.Scale = not (ceilingValue <= 10) and 1.12 or 1.2
            local propertyTable = {Scale = 1}
            tweenService:Create(v70.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()

            if enabled then
                local v362 = ceilingValue <= 3 and "Match/Countdown_1" or "Match/Countdown_Tick"

                if Sfx then
                    pcall(Sfx.PlayUI, v362)
                end
            end
        end
    end

    ceilingValue2 = ceilingValue
    v314 = v352

    return true
end

local heartbeatConnection = nil
local v364 = 0

heartbeatConnection = runService.Heartbeat:Connect(
    function(deltaTime: number)
        --[[
          line: 904
          upvalues:
            v364 (ref,  index: 1)
            step (copy, index: 2)
            heartbeatConnection (ref,  index: 3)
            localPlayer (copy, index: 4)
            LightingController (ref,  index: 5)
            updateCountdownGrade (copy, index: 6)
            v184 (ref,  index: 7)
            lighting (copy, index: 8)
            v168 (copy, index: 9)
            updateCountdown (copy, index: 10)
            updateCountdownBig (copy, index: 11)
            updateCountdownBanner (copy, index: 12)
            updateCountdownSky (copy, index: 13)
            updateCountdownSkyBig (copy, index: 14)
            updateCountdownFx (copy, index: 15)
        ]]
        v364 += deltaTime

        if v364 < 0.05 then
            return
        end

        local success, result = pcall(step, v364)
        v364 = 0

        if not success or result ~= false then
            if not success then
                warn("[UpdateCountdown] " .. tostring(result))
            end

            return
        end

        local v368
        local v369, v370, v371, v372 = false, false, false, false

        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end

        if localPlayer:GetAttribute("State") ~= "Match" then
            if LightingController then
                local success2, result2 = pcall(LightingController.Current)
                v368 = success2
                v368 = v368 and result2 == "Lobby"
            else
                v368 = true
            end

            v369 = true
        else
            v370 = true
        end

        if v369 then
            if v368 then
                if v184 then
                    lighting.ClockTime = v168.clock
                    lighting.ColorShift_Top = v168.shiftTop
                    lighting.Brightness = v168.brightness
                    lighting.OutdoorAmbient = v168.outdoor

                    if const atmosphere = lighting:FindFirstChildOfClass("Atmosphere") then
                        atmosphere.Color, atmosphere.Decay, atmosphere.Haze, atmosphere.Density, atmosphere.Glare = v168.atmColor, v168.atmDecay, v168.atmHaze, v168.atmDensity, v168.atmGlare
                    end

                    v371 = true
                else
                    v372 = true
                end
            else
                v370 = true
            end
        end

        if v370 then
            updateCountdownGrade.Enabled = false
            v184 = false
        end

        if v371 then
            if const sunRaysEffect = lighting:FindFirstChildOfClass("SunRaysEffect") then
                sunRaysEffect.Intensity = v168.rays
            end

            v184 = false
            v372 = true
        end

        if v372 then
            updateCountdownGrade.Enabled = false
        end

        updateCountdown:Destroy()
        updateCountdownBig:Destroy()
        updateCountdownBanner:Destroy()
        updateCountdownSky:Destroy()
        updateCountdownSkyBig:Destroy()
        updateCountdownFx:Destroy()
        updateCountdownGrade:Destroy()
    end
)