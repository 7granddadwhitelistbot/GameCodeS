local collectionService = game:GetService("CollectionService")
local contentProvider = game:GetService("ContentProvider")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local soundService = game:GetService("SoundService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local Sounds = require(script.Parent:WaitForChild("Sounds"))
local isServer = runService:IsServer()
local v11 = {}
local sounds = nil
local v13 = {}
local v14 = {}
local timestamp = -math.huge
local v16 = {}
local v17 = {}

local function getRoot()
    --[[
      name: getRoot
      line: 76
      upvalues:
        sounds (ref,  index: 1)
        replicatedStorage (copy, index: 2)
    ]]
    if sounds and sounds.Parent then
        return sounds
    end

    local assets = replicatedStorage:FindFirstChild("Assets")
    sounds = assets and assets:FindFirstChild("Sounds")

    return sounds
end

local function relPath(sounds: Instance?, descendant: Instance)
    --[[
      name: relPath
      line: 85
    ]]
    local v23
    local parts = {}
    v23 = descendant

    while v23 and v23 ~= sounds do
        table.insert(parts, 1, v23.Name)
        v23 = v23.Parent
    end

    return table.concat(parts, "/")
end

local function rebuildLeafIndex(sounds: Instance?)
    --[[
      name: rebuildLeafIndex
      line: 95
      upvalues:
        timestamp (ref,  index: 1)
        v14 (copy, index: 2)
        relPath (copy, index: 3)
    ]]
    timestamp = os.clock()
    table.clear(v14)

    for _, descendant in sounds:GetDescendants() do
        if not descendant:IsA("Sound") and not descendant:IsA("Folder") then
            continue
        end

        local v29 = v14[descendant.Name]

        if v29 == nil then
            v14[descendant.Name] = relPath(sounds, descendant)
        elseif v29 ~= relPath(sounds, descendant) then
            v14[descendant.Name] = false
        end
    end
end

local function findPath(sounds: Instance?, text)
    --[[
      name: findPath
      line: 110
    ]]
    local v33
    v33 = sounds

    for v34 in string.gmatch(text, "[^/]+") do
        v33 = v33 and v33:FindFirstChild(v34)

        if not v33 then
            return nil
        end
    end

    return v33
end

local function fromManifest(text)
    --[[
      name: fromManifest
      line: 122
      upvalues:
        v16 (copy, index: 1)
        Sounds (copy, index: 2)
    ]]
    if const v37 = v16[text] then
        return v37
    end

    local v38 = Sounds.Get(text)
    if not v38 then
        return nil
    end

    local v39 = v38.id

    if not v39 and v38.variants and v38.variants[1] then
        v39 = v38.variants[1][2]
    end

    if type(v39) ~= "number" or v39 <= 0 then
        return nil
    end

    local sound = Instance.new("Sound")
    sound.Name = string.match(text, "([^/]+)$") or text
    sound.SoundId = "rbxassetid://" .. v39
    sound.Volume = v38.vol or 0.5
    sound.PlaybackSpeed = v38.pitch or 1
    sound.Looped = v38.looped == true
    local v41 = v38.roll or Sounds.ROLL.default
    sound.RollOffMinDistance = v41[1]
    sound.RollOffMaxDistance = v41[2]
    sound.RollOffMode = Enum.RollOffMode.InverseTapered

    if v38.region then
        sound.PlaybackRegionsEnabled = true
        sound.PlaybackRegion = NumberRange.new(v38.region[1], v38.region[2])
    end

    if v38.fade then
        sound:SetAttribute("FadeOut", v38.fade)
    end

    v16[text] = sound

    return sound
end

local v42 = {}

local function resolve(text)
    --[[
      name: resolve
      line: 161
      upvalues:
        v13 (copy, index: 1)
        v42 (copy, index: 2)
        sounds (ref,  index: 3)
        replicatedStorage (copy, index: 4)
        findPath (copy, index: 5)
        v14 (copy, index: 6)
        timestamp (ref,  index: 7)
        rebuildLeafIndex (copy, index: 8)
        fromManifest (copy, index: 9)
    ]]
    local sounds2
    local v46 = v13[text]

    if v46 and v46.Parent then
        return v46, v42[text] or text
    end

    if sounds and sounds.Parent then
        sounds2 = sounds
    else
        local assets = replicatedStorage:FindFirstChild("Assets")
        sounds = assets and assets:FindFirstChild("Sounds")
        sounds2 = sounds
    end

    if sounds2 then
        local v48
        local path = findPath(sounds2, text)

        if path then
            v48 = text
        elseif string.find(text, "/", 1, true) then
            v48 = text
        else
            if v14[text] == nil and 3 < os.clock() - timestamp then
                rebuildLeafIndex(sounds2)
            end

            if const text2 = v14[text] then
                path = findPath(sounds2, text2)
                v48 = text2
            else
                v48 = text
            end
        end

        if path and (path:IsA("Sound") or path:IsA("Folder")) then
            v13[text] = path
            v42[text] = v48

            return path, v48
        end
    end

    return fromManifest(text), text
end

local v51 = {}

local function pickVariant(key)
    --[[
      name: pickVariant
      line: 191
      upvalues:
        v51 (copy, index: 1)
    ]]
    local children = key:GetChildren()
    local childCount = #children

    if childCount == 0 then
        return nil
    end

    local v56 = math.random(1, childCount)

    if 1 < childCount and v51[key] == v56 then
        v56 = v56 % childCount + 1
    end

    v51[key] = v56
    local child

    for index = 0, childCount - 1 do
        child = children[(((v56 + index) - 1) % childCount) + 1]

        if child:IsA("Sound") then
            return child
        end
    end

    return nil
end

local function templateOf(key)
    --[[
      name: templateOf
      line: 211
      upvalues:
        pickVariant (copy, index: 1)
    ]]
    if key:IsA("Sound") then
        return key
    end

    return (pickVariant(key))
end

local function metaOf(text: string)
    --[[
      name: metaOf
      line: 219
      upvalues:
        Sounds (copy, index: 1)
    ]]
    return if const v63 = Sounds.Get(text) then v63 elseif const v64 = string.match(text, "^(.*)/[^/]+$") then (Sounds.Get(v64)) else nil
end

local function groupNameOf(text: string, a67)
    --[[
      name: groupNameOf
      line: 228
      upvalues:
        Sounds (copy, index: 1)
    ]]
    if a67 and a67.group then
        return a67.group
    end

    local v68 = Sounds.groupOf(text)

    if v68 == "SFX" then
        if const v69 = string.match(text, "^(.*)/[^/]+$") then
            v68 = Sounds.groupOf(v69)
        end
    end

    return v68
end

local function getGroup(childName: string)
    --[[
      name: getGroup
      line: 242
      upvalues:
        soundService (copy, index: 1)
    ]]
    local child = soundService:FindFirstChild(childName)

    if child and child:IsA("SoundGroup") then
        return child
    end

    return nil
end

local function warnOnce(key)
    --[[
      name: warnOnce
      line: 247
      upvalues:
        v17 (copy, index: 1)
    ]]
    if not v17[key] then
        v17[key] = true
        warn((`[Sfx] unknown sound '{key}'`))
    end
end

local function playLength(a76)
    --[[
      name: playLength
      line: 255
    ]]
    local v77 = a76.TimeLength

    if v77 <= 0 then
        return 0
    end

    if a76.PlaybackRegionsEnabled then
        local playbackRegion = a76.PlaybackRegion
        v77 = math.min(playbackRegion.Max, v77) - playbackRegion.Min
    end

    return math.max(v77, 0.05) / math.max(a76.PlaybackSpeed, 0.05)
end

local function whereToPosition(a80)
    --[[
      name: whereToPosition
      line: 267
    ]]
    local valueType = typeof(a80)

    if valueType == "Vector3" then
        return a80, nil
    end
    if valueType == "CFrame" then
        return a80.Position, nil
    end

    if valueType == "Instance" then
        local v82

        if a80:IsA("Model") then
            local v83 = a80.PrimaryPart
                or a80:FindFirstChild("HumanoidRootPart")
                or a80:FindFirstChildWhichIsA("BasePart")
            if not v83 then
                return nil, nil
            end

            v82 = v83
        else
            v82 = a80
        end

        if v82:IsA("BasePart") then
            return v82.Position, v82
        end
        if v82:IsA("Attachment") then
            return v82.WorldPosition, v82
        end
    end

    return nil, nil
end

local v84 = {}
local v85 = {}

local function throttled(key, a88, a89)
    --[[
      name: throttled
      line: 298
      upvalues:
        v84 (copy, index: 1)
        v85 (copy, index: 2)
    ]]
    local timestamp = os.clock()
    local throttle = a89 and a89.throttle or 0.035
    local v92 = v84[key]

    if v92 and timestamp - v92 < throttle then
        local v93 = v85[key]

        if not a88 or not v93 or (a88 - v93).Magnitude < 8 then
            return true
        end
    end

    v84[key] = timestamp
    v85[key] = a88 or false

    return false
end

local v94 = {Master = 1, SFX = 1, UI = 1, Music = 1, Ambient = 1}
local v95 = {}

local function duckFactor(childName)
    --[[
      name: duckFactor
      line: 320
      upvalues:
        v95 (copy, index: 1)
    ]]
    local v98 = 1
    local timestamp = os.clock()

    for _, v101 in v95 do
        if v101.group == childName then
            if not (timestamp < v101.untilT) then
                continue
            end

            v98 = math.min(v98, v101.factor)
        end
    end

    return v98
end

local function applyGroup(childName: string, a104: number)
    --[[
      name: applyGroup
      line: 331
      upvalues:
        soundService (copy, index: 1)
        Sounds (copy, index: 2)
        v94 (copy, index: 3)
        duckFactor (copy, index: 4)
        tweenService (copy, index: 5)
    ]]
    local child = soundService:FindFirstChild(childName)
    local instance = if child and child:IsA("SoundGroup") then child else nil
    local group = Sounds.GROUPS[childName]

    if not instance or not group then
        return
    end

    local volume = (group * (v94[childName] or 1)) * v94.Master * duckFactor(childName)

    if not a104 or not (0 < a104) then
        instance.Volume = volume
        return
    end

    local propertyTable = {Volume = volume}
    tweenService:Create(instance, TweenInfo.new(a104, Enum.EasingStyle.Sine), propertyTable):Play()
end

function v11.SetVolume(childName: string, a111: number)
    --[[
      name: SetVolume
      line: 346
      upvalues:
        v94 (copy, index: 1)
        isServer (copy, index: 2)
        Sounds (copy, index: 3)
        soundService (copy, index: 4)
        duckFactor (copy, index: 5)
    ]]
    v94[childName] = math.clamp(a111, 0, 1)

    if isServer then
        return
    end

    local instance

    if childName ~= "Master" then
        local child = soundService:FindFirstChild(childName)
        local instance2 = if child and child:IsA("SoundGroup") then child else nil
        local group = Sounds.GROUPS[childName]

        if instance2 and group then
            instance2.Volume = (group * (v94[childName] or 1)) * v94.Master * duckFactor(childName)
        end
    else
        for childName2 in Sounds.GROUPS do
            local child = soundService:FindFirstChild(childName2)

            if not child or not child:IsA("SoundGroup") then
                child = nil
            end

            local group = Sounds.GROUPS[childName2]

            if child and group then
                child.Volume = (group * (v94[childName2] or 1)) * v94.Master * duckFactor(childName2)
            end
        end
    end

    if childName ~= "Master" then
        local child = soundService:FindFirstChild(childName)
        instance = if child and child:IsA("SoundGroup") then child else nil
    else
        instance = soundService
    end

    if instance then
        local attribute = childName ~= "Master" and "UserVolume" or "MasterVolume"
        instance:SetAttribute(attribute, v94[childName])
    end
end

function v11.GetVolume(key)
    --[[
      name: GetVolume
      line: 364
      upvalues:
        v94 (copy, index: 1)
    ]]
    return v94[key] or 1
end

function v11.Duck(group: string, a123: number, a124: number)
    --[[
      name: Duck
      line: 369
      upvalues:
        isServer (copy, index: 1)
        v95 (copy, index: 2)
        applyGroup (copy, index: 3)
    ]]
    if isServer then
        return
    end

    table.insert(v95, {group = group, factor = math.clamp(a123, 0, 1), untilT = os.clock() + a124})
    applyGroup(group, 0.35)

    task.delay(
        a124,
        function()
            --[[
              line: 375
              upvalues:
                v95 (copy, index: 1)
                applyGroup (copy, index: 2)
                group (copy, index: 3)
            ]]
            local timestamp = os.clock()

            for index = #v95, 1, -1 do
                if v95[index].untilT <= timestamp then
                    table.remove(v95, index)
                end
            end

            applyGroup(group, 0.8)
        end
    )
end

function v11.ApplyGroups()
    --[[
      name: ApplyGroups
      line: 387
      upvalues:
        Sounds (copy, index: 1)
        soundService (copy, index: 2)
        v94 (copy, index: 3)
        duckFactor (copy, index: 4)
    ]]
    for childName in Sounds.GROUPS do
        local child = soundService:FindFirstChild(childName)

        if not child or not child:IsA("SoundGroup") then
            child = nil
        end

        local group = Sounds.GROUPS[childName]

        if child and group then
            child.Volume = (group * (v94[childName] or 1)) * v94.Master * duckFactor(childName)
        end
    end
end

local v130 = {}
local v131 = {}
local v132 = {}
local v133 = {}
local release = nil
local v135 = setmetatable({}, {__mode = "k"})

local function acquireSound(template)
    --[[
      name: acquireSound
      line: 418
      upvalues:
        v130 (copy, index: 1)
        v135 (copy, index: 2)
        v133 (copy, index: 3)
        release (ref,  index: 4)
    ]]
    local v138 = v130[template]
    local removedValue

    if v138 then
        while 0 < #v138 do
            removedValue = table.remove(v138)

            if not v135[removedValue] then
                return removedValue
            end
        end
    end

    local v140 = template:Clone()
    v140.Looped = false

    v140.Ended:Connect(
        function()
            --[[
              line: 430
              upvalues:
                v133 (copy, index: 1)
                v140 (copy, index: 2)
                release (ref,  index: 3)
            ]]
            if const v141 = v133[v140] then
                release(v141)
            end
        end
    )

    v140.Destroying:Connect(
        function()
            --[[
              line: 436
              upvalues:
                v135 (copy, index: 1)
                v140 (copy, index: 2)
                v133 (copy, index: 3)
                release (ref,  index: 4)
            ]]
            v135[v140] = true

            if const v142 = v133[v140] then
                release(v142)
            end
        end
    )

    return v140
end

local function acquireHolder(worldPosition)
    --[[
      name: acquireHolder
      line: 446
      upvalues:
        v131 (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    local v145 = table.remove(v131)

    if not v145 or not v145.Parent then
        v145 = Instance.new("Attachment")
        v145.Name = "SfxHolder"
        v145.Parent = workspace.Terrain
    end

    v145.WorldPosition = worldPosition

    return v145
end

release = function(target)
    --[[
      name: release
      line: 457
      upvalues:
        v132 (copy, index: 1)
        v133 (copy, index: 2)
        v135 (copy, index: 3)
        v130 (copy, index: 4)
        v131 (copy, index: 5)
    ]]
    if target.released then
        return
    end

    target.released = true

    if target.tween then
        target.tween:Cancel()
    end

    if const index = table.find(v132, target) then
        v132[index] = v132[#v132]
        v132[#v132] = nil
    end

    local sound = target.sound

    if v133[sound] == target then
        v133[sound] = nil
    end

    if pcall(
        function()
            --[[
              line: 474
              upvalues:
                sound (copy, index: 1)
            ]]
            sound:Stop()
            sound.Parent = nil
        end
    )
        and not v135[sound]
    then
        local v149 = v130[target.template]
        if not v149 then
            v149 = {}
            v130[target.template] = v149
        end

        if not (#v149 < 8) then
            sound:Destroy()
        else
            table.insert(v149, sound)
        end
    end

    if const holder = target.holder then
        if #v131 < 40 and holder.Parent then
            table.insert(v131, holder)
            return
        end

        holder:Destroy()
    end
end

local function cameraPosition()
    --[[
      name: cameraPosition
      line: 500
      upvalues:
        workspace (copy, index: 1)
    ]]
    return if const camera = workspace.CurrentCamera then camera.CFrame.Position else nil
end

local function inTrainingZone(a154)
    --[[
      name: inTrainingZone
      line: 512
      upvalues:
        collectionService (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    for _, trainingZone in collectionService:GetTagged("TrainingZone") do
        if trainingZone:IsA("BasePart") then
            if not trainingZone:IsDescendantOf(workspace) then
                continue
            end

            local objectSpacePoint = trainingZone.CFrame:PointToObjectSpace(a154)
            local v158 = trainingZone.Size * 0.5

            if not (math.abs(objectSpacePoint.X) <= v158.X + 2) then
                continue
            end
            if not (math.abs(objectSpacePoint.Z) <= v158.Z + 2) then
                continue
            end

            local y = objectSpacePoint.Y

            if not (-v158.Y - 4 <= y) or not (objectSpacePoint.Y <= v158.Y + 10) then
                continue
            end

            return true
        end
    end

    return false
end

local function isLocalCharacter(a161)
    --[[
      name: isLocalCharacter
      line: 525
      upvalues:
        isServer (copy, index: 1)
        players (copy, index: 2)
    ]]
    if not a161 or isServer then
        return false
    end

    local v162 = players.LocalPlayer
    v162 = v162 and v162.Character

    return v162 ~= nil and a161:IsDescendantOf(v162)
end

local function voicePosition(a164)
    --[[
      name: voicePosition
      line: 534
    ]]
    local inst = a164.inst

    if inst and inst.Parent then
        if inst:IsA("BasePart") then
            return inst.Position
        end
        if inst:IsA("Attachment") then
            return inst.WorldPosition
        end
    end

    return a164.pos
end

local function admit3D(a167, a168)
    --[[
      name: admit3D
      line: 547
      upvalues:
        v132 (copy, index: 1)
        workspace (copy, index: 2)
        release (ref,  index: 3)
    ]]
    local v169

    if #v132 < 28 then
        return true
    end

    local vector3 = if const camera = workspace.CurrentCamera then camera.CFrame.Position else nil
    local v172 = -1
    v169 = nil

    for _, v174 in v132 do
        if not v174.priority then
            local v175
            local inst = v174.inst

            if not inst or not inst.Parent then
                v175 = v174.pos
            elseif inst:IsA("BasePart") then
                v175 = inst.Position
            elseif inst:IsA("Attachment") then
                v175 = inst.WorldPosition
            else
                v175 = v174.pos
            end

            local v177 = if v175 and vector3 then (v175 - vector3).Magnitude else 0

            if not (v172 < v177) then
                continue
            end

            v172, v169 = v177, v174
        end
    end

    if v169 and (a168 or a167 < v172) then
        release(v169)
        return true
    end

    return a168
end

local function scheduleEnd(a179)
    --[[
      name: scheduleEnd
      line: 570
      upvalues:
        v133 (copy, index: 1)
        tweenService (copy, index: 2)
        release (ref,  index: 3)
    ]]
    local sound = a179.sound

    local function arm()
        --[[
          name: arm
          line: 572
          upvalues:
            a179 (copy, index: 1)
            sound (copy, index: 2)
            v133 (copy, index: 3)
            tweenService (copy, index: 4)
            release (ref,  index: 5)
        ]]
        local v182

        if a179.released then
            return
        end

        local sound2 = sound
        local v184 = sound2.TimeLength

        if not (v184 <= 0) then
            if sound2.PlaybackRegionsEnabled then
                local playbackRegion = sound2.PlaybackRegion
                v184 = math.min(playbackRegion.Max, v184) - playbackRegion.Min
            end

            v182 = math.max(v184, 0.05) / math.max(sound2.PlaybackSpeed, 0.05)
        else
            v182 = 0
        end

        if v182 <= 0 then
            v182 = 6
        end

        local fadeOut = sound:GetAttribute("FadeOut")

        if type(fadeOut) == "number" and 0 < fadeOut and fadeOut < v182 then
            task.delay(
                v182 - fadeOut,
                function()
                    --[[
                      line: 582
                      upvalues:
                        a179 (copy, index: 1)
                        v133 (copy, index: 2)
                        sound (copy, index: 3)
                        tweenService (copy, index: 4)
                        fadeOut (copy, index: 5)
                    ]]
                    if not a179.released and v133[sound] == a179 then
                        local propertyTable = {Volume = 0}
                        local tween = tweenService:Create(sound, TweenInfo.new(fadeOut, Enum.EasingStyle.Quad, Enum.EasingDirection.In), propertyTable)
                        a179.tween = tween
                        tween:Play()
                    end
                end
            )
        end

        task.delay(v182 + 0.1, release, a179)
    end

    if sound.IsLoaded then
        arm()
        return
    end

    local v189 = nil

    v189 = sound.Loaded:Connect(
        function()
            --[[
              line: 596
              upvalues:
                v189 (ref,  index: 1)
                arm (copy, index: 2)
            ]]
            if v189 then
                v189:Disconnect()
            end

            arm()
        end
    )

    task.delay(
        5,
        function()
            --[[
              line: 602
              upvalues:
                v189 (ref,  index: 1)
                arm (copy, index: 2)
            ]]
            if v189 and v189.Connected then
                v189:Disconnect()
                arm()
            end
        end
    )
end

local playClient = nil

local function playExtras(a192, a193, options)
    --[[
      name: playExtras
      line: 613
      upvalues:
        playClient (ref, index: 1)
    ]]
    if a192 then
        if not options or not options.noLayers then
            local volume = options and options.volume or 1

            if a192.layers then
                for _, layer in a192.layers do
                    local v198
                    local v199

                    if type(layer) == "table" then
                        v198 = layer[1]
                    else
                        v198 = layer
                    end

                    if type(layer) == "table" then
                        v199 = layer[2] or 1
                    else
                        v199 = 1
                    end

                    local playClient2 = playClient
                    local v201 = {noLayers = true, volume = v199 * volume, pitch = options and options.pitch, priority = options
                        and options.priority}
                    playClient2(v198, a193, v201)
                end
            end

            if a192.sequence then
                for _, v203 in a192.sequence do
                    task.delay(
                        (v203[2] or 0),
                        function()
                            --[[
                              line: 627
                              upvalues:
                                a193 (copy, index: 1)
                                playClient (ref,  index: 2)
                                v203 (copy, index: 3)
                                volume (copy, index: 4)
                            ]]
                            if typeof(a193) == "Instance" and not a193.Parent then
                                return
                            end

                            playClient(v203[1], a193, {noLayers = true, volume = (v203[3] or 1) * volume, pitch = v203[4]})
                        end
                    )
                end
            end
        end
    end
end

playClient = function(key, a205, options)
    --[[
      name: playClient
      line: 638
      upvalues:
        resolve (copy, index: 1)
        v17 (copy, index: 2)
        pickVariant (copy, index: 3)
        Sounds (copy, index: 4)
        whereToPosition (copy, index: 5)
        isServer (copy, index: 6)
        players (copy, index: 7)
        v84 (copy, index: 8)
        v85 (copy, index: 9)
        workspace (copy, index: 10)
        inTrainingZone (copy, index: 11)
        admit3D (copy, index: 12)
        acquireSound (copy, index: 13)
        soundService (copy, index: 14)
        v131 (copy, index: 15)
        v133 (copy, index: 16)
        v132 (copy, index: 17)
        scheduleEnd (copy, index: 18)
        playExtras (copy, index: 19)
    ]]
    local key2, text = resolve(key)
    if not key2 then
        if not v17[key] then
            v17[key] = true
            warn((`[Sfx] unknown sound '{key}'`))
        end

        return nil
    end

    local v209
    local v210
    local v211
    local template = if key2:IsA("Sound") then key2 else pickVariant(key2)
    if not template then
        return nil
    elseif const v213 = Sounds.Get(text) then
        v209 = v213
    else
        v209 = if const v214 = string.match(text, "^(.*)/[^/]+$") then Sounds.Get(v214) else nil
    end

    local v215, v216 = whereToPosition(a205)

    if a205 ~= nil and not v215 then
        return nil
    end

    local localPlayer, v218
    local v219, v220, v221, v222, v223 = false, false, false, false, false

    if options then
        v210 = options.priority

        if not v210 then
            v219 = true
        end
    else
        v219 = true
    end

    if v219 then
        if v209 then
            v210 = v209.priority

            if not v210 then
                v220 = true
            end
        else
            v220 = true
        end
    end

    if v220 then
        if v216 then
            if isServer then
                v222 = true
            else
                localPlayer = players.LocalPlayer
                v218 = localPlayer
                v218 = v218 and localPlayer.Character
                v221 = true
            end
        else
            v222 = true
        end
    end

    if v221 then
        v210 = false

        if v218 ~= nil then
            v210 = v216:IsDescendantOf(v218)
        end

        v223 = true
    end

    if v222 then
        v210 = false
        v223 = true
    end

    if v223 and not v210 then
        v210 = false
    end

    local timestamp = os.clock()
    local throttle = v209 and v209.throttle or 0.035
    local v226, v227 = false, false

    if const v228 = v84[text] then
        if not (timestamp - v228 < throttle) then
            v227 = true
        else
            local v229 = v85[text]

            if v215 then
                if v229 then
                    if not ((v215 - v229).Magnitude < 8) then
                        v227 = true
                    else
                        v226 = true
                    end
                else
                    v226 = true
                end
            else
                v226 = true
            end
        end
    else
        v227 = true
    end

    if v226 then
        v211 = true
    end

    if v227 then
        v84[text] = timestamp
        v85[text] = v215 or false
        v211 = false
    end

    if v211 then
        return nil
    end

    local v230 = template.RollOffMaxDistance
    local v231 = 1

    if v215 then
        local vector3 = if const camera = workspace.CurrentCamera then camera.CFrame.Position else nil
        local v234 = not vector3 and 0 or (v215 - vector3).Magnitude

        if 100 <= v230 and inTrainingZone(v215) then
            v230 = math.min(v230, 80)
            local v235 = vector3 and not inTrainingZone(vector3) and 0.45 or 1
            v231 = v235 * 0.7
        end

        if not v210 and v230 < v234 then
            return nil
        end
        if not admit3D(v234, v210) then
            return nil
        end
    end

    local sound = acquireSound(template)
    local v237 = options or {}
    sound.Volume = (template.Volume * (v237.volume or 1)) * v231
    sound.RollOffMaxDistance = v230
    local playbackSpeed = template.PlaybackSpeed * (v237.pitch or 1)

    if not v237.pitch then
        local v239 = v209 and v209.jitter
        if v239 == nil then
            local v240

            if v209 and v209.group then
                v240 = v209.group
            else
                local v241 = Sounds.groupOf(text)

                if v241 == "SFX" then
                    if const v242 = string.match(text, "^(.*)/[^/]+$") then
                        v241 = Sounds.groupOf(v242)
                    end
                end

                v240 = v241
            end

            v239 = v240 ~= "SFX" and 0 or 0.04
        end

        if 0 < v239 then
            playbackSpeed *= 1 + (((math.random() * 2) - 1) * v239)
        end
    end

    sound.PlaybackSpeed = playbackSpeed
    local v243 = v237.group
    if not v243 then
        if v209 and v209.group then
            v243 = v209.group
        else
            local v244 = Sounds.groupOf(text)

            if v244 == "SFX" then
                if const v245 = string.match(text, "^(.*)/[^/]+$") then
                    v244 = Sounds.groupOf(v245)
                end
            end

            v243 = v244
        end
    end

    local child = soundService:FindFirstChild(v243)
    sound.SoundGroup = if child and child:IsA("SoundGroup") then child else nil
    sound.TimePosition = not sound.PlaybackRegionsEnabled and 0 or sound.PlaybackRegion.Min
    local v247 = {holder = nil, released = false, tween = nil, sound = sound, template = template, pos = v215, inst = v216, priority = v210}

    if v215 then
        if v216 then
            sound.Parent = v216
        else
            local v248 = table.remove(v131)

            if not v248 or not v248.Parent then
                v248 = Instance.new("Attachment")
                v248.Name = "SfxHolder"
                v248.Parent = workspace.Terrain
            end

            v248.WorldPosition = v215
            v247.holder = v248
            sound.Parent = v248
        end
    else
        sound.Parent = soundService
    end

    v133[sound] = v247

    if v215 then
        table.insert(v132, v247)
    end

    sound:Play()
    scheduleEnd(v247)
    playExtras(v209, a205, options)

    return sound
end

local result = nil

local function getRemote()
    --[[
      name: getRemote
      line: 716
      upvalues:
        result (ref, index: 1)
    ]]
    if not result then
        local success, result2 = pcall(
            function()
                --[[
                  line: 720
                ]]
                local Net = require(script.Parent:WaitForChild("Net"))
                return Net.UnreliableEvent("SfxPlay")
            end
        )

        if success then
            result = result2
        end
    end

    return result
end

local function focusOf(a255)
    --[[
      name: focusOf
      line: 730
    ]]
    local replicationFocus = a255.ReplicationFocus

    if replicationFocus and replicationFocus:IsA("BasePart") and replicationFocus.Parent then
        return replicationFocus.Position
    end

    local v257 = a255.Character
    v257 = v257
    v257 = v257 and (v257.PrimaryPart or v257:FindFirstChild("HumanoidRootPart"))

    if v257 and v257:IsA("BasePart") then
        return v257.Position
    end

    return nil
end

local function playServer(key: string, a260, options, a262)
    --[[
      name: playServer
      line: 744
      upvalues:
        result (ref,  index: 1)
        resolve (copy, index: 2)
        v17 (copy, index: 3)
        pickVariant (copy, index: 4)
        whereToPosition (copy, index: 5)
        Sounds (copy, index: 6)
        v84 (copy, index: 7)
        v85 (copy, index: 8)
        players (copy, index: 9)
        focusOf (copy, index: 10)
    ]]
    local result2

    if result then
        result2 = result
    else
        local success, result3 = pcall(
            function()
                --[[
                  line: 720
                ]]
                local Net = require(script.Parent:WaitForChild("Net"))
                return Net.UnreliableEvent("SfxPlay")
            end
        )

        if success then
            result = result3
        end

        result2 = result
    end

    if not result2 then
        return
    end

    local key2, text = resolve(key)
    if not key2 then
        if not v17[key] then
            v17[key] = true
            warn((`[Sfx] unknown sound '{key}'`))
        end

        return
    end

    local v269
    local v270
    local v271 = if key2:IsA("Sound") then key2 else pickVariant(key2)
    local v272, v273 = whereToPosition(a260)

    if a260 ~= nil and not v272 then
        return
    end

    local v274 = "srv:" .. text

    if const v275 = Sounds.Get(text) then
        v269 = v275
    else
        v269 = if const v276 = string.match(text, "^(.*)/[^/]+$") then Sounds.Get(v276) else nil
    end

    local timestamp = os.clock()
    local throttle = v269 and v269.throttle or 0.035
    local v279, v280 = false, false

    if const v281 = v84[v274] then
        if not (timestamp - v281 < throttle) then
            v280 = true
        else
            local v282 = v85[v274]

            if v272 then
                if v282 then
                    if not ((v272 - v282).Magnitude < 8) then
                        v280 = true
                    else
                        v279 = true
                    end
                else
                    v279 = true
                end
            else
                v279 = true
            end
        end
    else
        v280 = true
    end

    if v279 then
        v270 = true
    end

    if v280 then
        v84[v274] = timestamp
        v85[v274] = v272 or false
        v270 = false
    end

    if v270 then
        return
    end

    local v283 = options or {}
    local volume = v283.volume
    local pitch = v283.pitch
    local rollOffMaxDistance = v271 and v271.RollOffMaxDistance or 150
    local v287 = rollOffMaxDistance + 40
    local v288 = a262 or v283.players

    if not v272 and not v288 then
        warn((`[Sfx] server 2D play of '{key}' needs opts.players (or Sfx.PlayFor)`))
        return
    end

    local v289 = v288 or players:GetPlayers()

    for _, v291 in v289 do
        if v291 ~= v283.except then
            if v291.Parent ~= players then
                continue
            end

            local v292 = true

            if v272 and not v288 then
                local v293 = focusOf(v291)
                v292 = v293 == nil or (v293 - v272).Magnitude <= v287
            end

            if not v292 then
                continue
            end

            result2:FireClient(v291, text, v272, v273, volume, pitch)
        end
    end
end

function v11.Play(key: string, a295, options)
    --[[
      name: Play
      line: 788
      upvalues:
        isServer (copy, index: 1)
        playServer (copy, index: 2)
        playClient (ref,  index: 3)
    ]]
    if isServer then
        playServer(key, a295, options, nil)
        return nil
    end

    return playClient(key, a295, options)
end

function v11.PlayUI(childName: string)
    --[[
      name: PlayUI
      line: 796
      upvalues:
        isServer (copy, index: 1)
        sounds (ref,  index: 2)
        replicatedStorage (copy, index: 3)
        Sounds (copy, index: 4)
        playClient (ref,  index: 5)
    ]]
    local v298
    local group

    if isServer then
        return nil
    end

    if string.find(childName, "/", 1, true) then
        v298 = childName
    else
        local sounds2

        if sounds and sounds.Parent then
            sounds2 = sounds
        else
            local assets = replicatedStorage:FindFirstChild("Assets")
            sounds = assets and assets:FindFirstChild("Sounds")
            sounds2 = sounds
        end

        if sounds2 then
            if sounds2:FindFirstChild(childName) then
                v298 = childName
            else
                v298 = if not Sounds.Get(childName) then "UI/" .. childName else childName
            end
        else
            v298 = childName
        end
    end

    local playClient2 = playClient
    local v303 = {}

    if Sounds.Get(v298) then
        group = Sounds.groupOf(v298)
        group = group or "UI"
    else
        group = "UI"
    end

    v303.group = group

    return playClient2(v298, nil, v303)
end

function v11.PlayFor(a304, key: string, a306, options)
    --[[
      name: PlayFor
      line: 811
      upvalues:
        isServer (copy, index: 1)
        playServer (copy, index: 2)
        players (copy, index: 3)
        playClient (ref,  index: 4)
    ]]
    local v308

    if typeof(a304) ~= "Instance" then
        v308 = a304
    else
        v308 = {a304}
    end

    if isServer then
        playServer(key, a306, options, v308)
        return nil
    end

    if table.find(v308, players.LocalPlayer) then
        return playClient(key, a306, options)
    end

    return nil
end

function v11.Loop(key: string, a310, options)
    --[[
      name: Loop
      line: 825
      upvalues:
        resolve (copy, index: 1)
        pickVariant (copy, index: 2)
        v17 (copy, index: 3)
        isServer (copy, index: 4)
        Sounds (copy, index: 5)
        soundService (copy, index: 6)
        tweenService (copy, index: 7)
    ]]
    local key2, text = resolve(key)
    local v314 = key2 and (if key2:IsA("Sound") then key2 else pickVariant(key2))
    if not v314 then
        if not key2 and not v17[key] then
            v17[key] = true
            warn((`[Sfx] unknown sound '{key}'`))
        end

        return function()
            --[[
              line: 832
            ]]
        end, nil
    end

    local v315

    if isServer and not a310 then
        warn((`[Sfx] server loop '{key}' needs a parent instance`))
        return function()
            --[[
              line: 836
            ]]
        end, nil
    elseif const v316 = Sounds.Get(text) then
        v315 = v316
    else
        v315 = if const v317 = string.match(text, "^(.*)/[^/]+$") then Sounds.Get(v317) else nil
    end

    local v318 = options or {}
    local instance = v314:Clone()
    instance.Looped = true
    local volume = v314.Volume * (v318.volume or 1)
    instance.PlaybackSpeed = v314.PlaybackSpeed * (v318.pitch or 1)
    local v321 = v318.group
    if not v321 then
        if v315 and v315.group then
            v321 = v315.group
        else
            local v322 = Sounds.groupOf(text)

            if v322 == "SFX" then
                if const v323 = string.match(text, "^(.*)/[^/]+$") then
                    v322 = Sounds.groupOf(v323)
                end
            end

            v321 = v322
        end
    end

    local child = soundService:FindFirstChild(v321)
    instance.SoundGroup = if child and child:IsA("SoundGroup") then child else nil
    instance.TimePosition = not instance.PlaybackRegionsEnabled and 0 or instance.PlaybackRegion.Min

    if not v318.fadeIn or not (0 < v318.fadeIn) then
        instance.Volume = volume
    else
        instance.Volume = 0
    end

    instance.Parent = a310 or soundService
    instance:Play()

    if v318.fadeIn and 0 < v318.fadeIn then
        local propertyTable = {Volume = volume}
        tweenService:Create(instance, TweenInfo.new(v318.fadeIn), propertyTable):Play()
    end

    local hasRun = false

    return function(a327: number?)
        --[[
          name: stop
          line: 857
          upvalues:
            hasRun (ref,  index: 1)
            instance (copy, index: 2)
            tweenService (copy, index: 3)
        ]]
        if hasRun then
            return
        end

        hasRun = true

        if not a327 or not (0 < a327) or not instance.Parent then
            instance:Destroy()
            return
        end

        local propertyTable = {Volume = 0}
        local tween = tweenService:Create(instance, TweenInfo.new(a327), propertyTable)
        tween.Completed:Once(
            function()
                --[[
                  line: 864
                  upvalues:
                    instance (copy, index: 1)
                ]]
                instance:Destroy()
            end
        )
        tween:Play()
    end, instance
end

function v11.Clone(key: string)
    --[[
      name: Clone
      line: 877
      upvalues:
        resolve (copy, index: 1)
        pickVariant (copy, index: 2)
        v17 (copy, index: 3)
        Sounds (copy, index: 4)
        soundService (copy, index: 5)
    ]]
    local key2, text = resolve(key)
    local v333 = key2 and (if key2:IsA("Sound") then key2 else pickVariant(key2))
    if not v333 then
        if not key2 and not v17[key] then
            v17[key] = true
            warn((`[Sfx] unknown sound '{key}'`))
        end

        return nil
    end

    local v334
    local v335
    local v336 = v333:Clone()

    if const v337 = Sounds.Get(text) then
        v334 = v337
    else
        v334 = if const v338 = string.match(text, "^(.*)/[^/]+$") then Sounds.Get(v338) else nil
    end

    if v334 and v334.group then
        v335 = v334.group
    else
        local v339 = Sounds.groupOf(text)

        if v339 == "SFX" then
            if const v340 = string.match(text, "^(.*)/[^/]+$") then
                v339 = Sounds.groupOf(v340)
            end
        end

        v335 = v339
    end

    local child = soundService:FindFirstChild(v335)
    v336.SoundGroup = if child and child:IsA("SoundGroup") then child else nil

    return v336
end

function v11.Has(text: string)
    --[[
      name: Has
      line: 891
      upvalues:
        resolve (copy, index: 1)
    ]]
    return resolve(text) ~= nil
end

function v11.Length(text: string)
    --[[
      name: Length
      line: 897
      upvalues:
        resolve (copy, index: 1)
        pickVariant (copy, index: 2)
    ]]
    local key = resolve(text)
    local v345 = key and (if key:IsA("Sound") then key else pickVariant(key))
    if not v345 then
        return 0
    end

    local v346 = v345.TimeLength

    if v346 <= 0 then
        return 0
    end

    if v345.PlaybackRegionsEnabled then
        local playbackRegion = v345.PlaybackRegion
        v346 = math.min(playbackRegion.Max, v346) - playbackRegion.Min
    end

    return math.max(v346, 0.05) / math.max(v345.PlaybackSpeed, 0.05)
end

function v11.Preload(a348)
    --[[
      name: Preload
      line: 904
      upvalues:
        resolve (copy, index: 1)
        sounds (ref,  index: 2)
        replicatedStorage (copy, index: 3)
        contentProvider (copy, index: 4)
    ]]
    task.spawn(
        function()
            --[[
              line: 905
              upvalues:
                a348 (copy, index: 1)
                resolve (copy, index: 2)
                sounds (ref,  index: 3)
                replicatedStorage (copy, index: 4)
                contentProvider (copy, index: 5)
            ]]
            local v349 = {}

            if a348 then
                for _, text in a348 do
                    if const v352 = resolve(text) then
                        if v352:IsA("Folder") then
                            for _, child in v352:GetChildren() do
                                table.insert(v349, child)
                            end
                        else
                            table.insert(v349, v352)
                        end
                    end
                end
            else
                local sounds2

                if sounds and sounds.Parent then
                    sounds2 = sounds
                else
                    local assets = replicatedStorage:FindFirstChild("Assets")
                    sounds = assets and assets:FindFirstChild("Sounds")
                    sounds2 = sounds
                end

                if sounds2 then
                    for _, descendant in sounds2:GetDescendants() do
                        if descendant:IsA("Sound") then
                            table.insert(v349, descendant)
                        end
                    end
                end
            end

            pcall(contentProvider.PreloadAsync, contentProvider, v349)
        end
    )
end

function v11.Stats()
    --[[
      name: Stats
      line: 935
      upvalues:
        v130 (copy, index: 1)
        v132 (copy, index: 2)
    ]]
    local total = 0

    for _, v361 in v130 do
        total += #v361
    end

    return {live3D = #v132, pooled = total}
end

return v11