local CollectionService_upv_1 = game:GetService("CollectionService")
local ContentProvider_upv_1 = game:GetService("ContentProvider")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local v1 = game:GetService("RunService")
local SoundService_upv_1 = game:GetService("SoundService")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local Sounds_upv_1 = require(script.Parent:WaitForChild("Sounds"))
local u1 = v1:IsServer()
v1 = {}
local u2 = nil
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local u3 = -math.huge
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local function getRoot()
    --[[
      name: getRoot
      line: 76
      upvalues:
        u2 (ref,  index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
    ]]
    if u2 and u2.Parent then
        return u2
    end
    local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v2 = Assets_1 and (Assets_1:FindFirstChild("Sounds"))
    u2 = v2
    return u2
end
local function relPath(a1, a2)
    --[[
      name: relPath
      line: 85
    ]]
    local tbl_5 = {}
    local v3 = a2
    while v3 and v3 ~= a1 do
        table.insert(tbl_5, 1, v3.Name)
        v3 = v3.Parent
    end
    return table.concat(tbl_5, "/")
end
local function rebuildLeafIndex(a1)
    --[[
      name: rebuildLeafIndex
      line: 95
      upvalues:
        u3 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        relPath (copy, index: 3)
    ]]
    u3 = os.clock()
    table.clear(tbl_upv_2)
    for _, value_1 in a1:GetDescendants() do
        if value_1:IsA("Sound") or value_1:IsA("Folder") then
            local v4 = tbl_upv_2[value_1.Name]
            if v4 == nil then
                tbl_upv_2[value_1.Name] = relPath(a1, value_1)
                continue
            end
            if v4 ~= relPath(a1, value_1) then
                tbl_upv_2[value_1.Name] = false
            end
        end
    end
end
local function fromManifest(a1)
    --[[
      name: fromManifest
      line: 122
      upvalues:
        tbl_upv_3 (copy, index: 1)
        Sounds_upv_1 (copy, index: 2)
    ]]
    local v5 = tbl_upv_3[a1]
    if v5 then
        return v5
    end
    local v6 = Sounds_upv_1.Get(a1)
    if not v6 then
        return nil
    end
    local v7 = v6.id
    if not (v7) and v6.variants and v6.variants[1] then
        v7 = v6.variants[1][2]
    end
    if type(v7) == "number" and not (v7 <= 0) then
        local v8 = Instance.new("Sound")
        v8.Name = string.match(a1, "([^/]+)$") or a1
        v8.SoundId = "rbxassetid://" .. v7
        v8.Volume = v6.vol or 0.5
        v8.PlaybackSpeed = v6.pitch or 1
        v8.Looped = v6.looped == true
        v7 = v6.roll or (Sounds_upv_1.ROLL.default)
        v8.RollOffMinDistance = v7[1]
        v8.RollOffMaxDistance = v7[2]
        v8.RollOffMode = Enum.RollOffMode.InverseTapered
        if v6.region then
            v8.PlaybackRegionsEnabled = true
            v8.PlaybackRegion = NumberRange.new(v6.region[1], v6.region[2])
        end
        if v6.fade then
            v8:SetAttribute("FadeOut", v6.fade)
        end
        tbl_upv_3[a1] = v8
        return v8
    end
    return nil
end
local tbl_upv_6 = {}
local function findPath(a1, a2)
    --[[
      name: findPath
      line: 110
    ]]
    local v9 = a1
    for key_1 in string.gmatch(a2, "[^/]+") do
        local v10 = v9 and (v9:FindFirstChild(key_1))
        if v10 then
            v9 = v10
            continue
        end
        return nil
    end
    return v9
end
local function resolve(a1)
    --[[
      name: resolve
      line: 161
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        u2 (ref,  index: 3)
        ReplicatedStorage_upv_1 (copy, index: 4)
        findPath (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        u3 (ref,  index: 7)
        rebuildLeafIndex (copy, index: 8)
        fromManifest (copy, index: 9)
    ]]
    local v11 = tbl_upv_1[a1]
    if v11 and v11.Parent then
        return v11, tbl_upv_6[a1] or a1
    end
    if not (u2) or not (u2.Parent) then
        local Assets_2 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
        local v12 = Assets_2 and (Assets_2:FindFirstChild("Sounds"))
        u2 = v12
    end
    if u2 then
        local v13 = findPath(u2, a1)
        local v14
        if v13 then
            v14 = a1
        else
            local v15 = string.find(a1, "/", 1, true)
            local v16 = nil
            if v15 then
                v14 = a1
            else
                if tbl_upv_2[a1] == nil and os.clock() - u3 > 3 then
                    rebuildLeafIndex(u2)
                end
                v16 = tbl_upv_2[a1]
                if v16 then
                    v13, v14 = findPath(u2, v16), v16
                else
                    v14 = a1
                end
            end
        end
        if v13 then
            if not (v13:IsA("Sound")) and not (v13:IsA("Folder")) then
                return fromManifest(a1), a1
            end
            tbl_upv_1[a1] = v13
            tbl_upv_6[a1] = v14
            return v13, v14
        end
    end
    return fromManifest(a1), a1
end
local tbl_upv_7 = {}
local function pickVariant(a1)
    --[[
      name: pickVariant
      line: 191
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    local v17 = a1:GetChildren()
    local v18 = #v17
    if v18 == 0 then
        return nil
    end
    local v19 = math.random(1, v18)
    if v18 > 1 and tbl_upv_7[a1] == v19 then
        v19 = v19 % v18 + 1
    end
    tbl_upv_7[a1] = v19
    local v20 = nil
    for n_1 = 0, v18 - 1 do
        v20 = v17[(((v19 + n_1) - 1) % v18) + 1]
        local v21 = v20:IsA("Sound")
        if not (v21) then
            continue
        end
        return v20
    end
    return nil
end
local function templateOf(a1)
    --[[
      name: templateOf
      line: 211
      upvalues:
        pickVariant (copy, index: 1)
    ]]
    if a1:IsA("Sound") then
        return a1
    end
    return (pickVariant(a1))
end
local function metaOf(a1)
    --[[
      name: metaOf
      line: 219
      upvalues:
        Sounds_upv_1 (copy, index: 1)
    ]]
    local v22 = Sounds_upv_1.Get(a1)
    if v22 then
        return v22
    end
    local v23 = string.match(a1, "^(.*)/[^/]+$")
    if v23 then
        return (Sounds_upv_1.Get(v23))
    end
    return nil
end
local function groupNameOf(a1, a2)
    --[[
      name: groupNameOf
      line: 228
      upvalues:
        Sounds_upv_1 (copy, index: 1)
    ]]
    if a2 and a2.group then
        return a2.group
    end
    local v24 = Sounds_upv_1.groupOf(a1)
    local v25 = nil
    if v24 == "SFX" then
        v25 = string.match(a1, "^(.*)/[^/]+$")
        if v25 then
            v24 = Sounds_upv_1.groupOf(v25)
        end
    end
    return v24
end
local function getGroup(a1)
    --[[
      name: getGroup
      line: 242
      upvalues:
        SoundService_upv_1 (copy, index: 1)
    ]]
    local v26 = SoundService_upv_1:FindFirstChild(a1)
    if v26 and v26:IsA("SoundGroup") then
        return v26
    end
    return nil
end
local function warnOnce(a1)
    --[[
      name: warnOnce
      line: 247
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    if (tbl_upv_4[a1]) then
        return
    end
    tbl_upv_4[a1] = true
    warn((("[Sfx] unknown sound '%*'"):format(a1)))
end
local function playLength(a1)
    --[[
      name: playLength
      line: 255
    ]]
    local TimeLength_1 = a1.TimeLength
    if TimeLength_1 <= 0 then
        return 0
    end
    if a1.PlaybackRegionsEnabled then
        local PlaybackRegion_1 = a1.PlaybackRegion
        TimeLength_1 = math.min(PlaybackRegion_1.Max, TimeLength_1) - PlaybackRegion_1.Min
    end
    return math.max(TimeLength_1, 0.05) / math.max(a1.PlaybackSpeed, 0.05)
end
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local function throttled(a1, a2, a3)
    --[[
      name: throttled
      line: 298
      upvalues:
        tbl_upv_8 (copy, index: 1)
        tbl_upv_9 (copy, index: 2)
    ]]
    local v27 = os.clock()
    local v28 = (a3 and (a3.throttle)) or 0.035
    local v29 = tbl_upv_8[a1]
    if v29 and v27 - v29 < v28 then
        local v30 = tbl_upv_9[a1]
        if a2 and v30 and not ((a2 - v30).Magnitude < 8) then
            tbl_upv_8[a1] = v27
            tbl_upv_9[a1] = a2 or false
            return false
        end
        return true
    end
    tbl_upv_8[a1] = v27
    tbl_upv_9[a1] = a2 or false
    return false
end
local tbl_upv_10 = {Master = 1, Ambient = 1, UI = 1, Music = 1, SFX = 1}
local tbl_upv_11 = {}
local function duckFactor(a1)
    --[[
      name: duckFactor
      line: 320
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    local v31 = 1
    local v32 = os.clock()
    for _, value_2 in tbl_upv_11 do
        if value_2.group ~= a1 then
            continue
        end
        if v32 < value_2.untilT then
            v31 = math.min(v31, value_2.factor)
        end
    end
    return v31
end
function v1.SetVolume(a1, a2)
    --[[
      name: SetVolume
      line: 346
      upvalues:
        tbl_upv_10 (copy, index: 1)
        u1 (copy, index: 2)
        Sounds_upv_1 (copy, index: 3)
        SoundService_upv_1 (copy, index: 4)
        duckFactor (copy, index: 5)
    ]]
    tbl_upv_10[a1] = math.clamp(a2, 0, 1)
    if not u1 then
        local v33 = nil
        if a1 ~= "Master" then
            v33 = SoundService_upv_1:FindFirstChild(a1)
            local v34 = not (v33) or not (v33:IsA("SoundGroup")) or v33
            local v35 = Sounds_upv_1.GROUPS[a1]
            if v34 and v35 then
                v34.Volume = ((v35 * (tbl_upv_10[a1] or 1)) * tbl_upv_10.Master) * duckFactor(a1)
            end
        else
            local v36 = nil
            for key_2 in Sounds_upv_1.GROUPS do
                local v37 = SoundService_upv_1:FindFirstChild(key_2)
                if not (v37) or not (v37:IsA("SoundGroup")) then
                    v36 = nil
                    v37 = Sounds_upv_1.GROUPS[key_2]
                    if not (v36) then
                        continue
                    end
                    if v37 then
                        v36.Volume = ((v37 * (tbl_upv_10[key_2] or 1)) * tbl_upv_10.Master) * duckFactor(key_2)
                        continue
                    end
                end
                v36 = v37
                v37 = Sounds_upv_1.GROUPS[key_2]
                if not (v36) then
                    continue
                end
                if v37 then
                    v36.Volume = ((v37 * (tbl_upv_10[key_2] or 1)) * tbl_upv_10.Master) * duckFactor(key_2)
                end
            end
        end
        local v38, v39 = nil, nil
        if a1 ~= "Master" then
            v38 = SoundService_upv_1:FindFirstChild(a1)
            v39 = not (v38) or not (v38:IsA("SoundGroup")) or v38
        else
            v39 = SoundService_upv_1
        end
        if v39 then
            v39:SetAttribute(((a1 ~= "Master") and "UserVolume") or "MasterVolume", tbl_upv_10[a1])
        end
    end
end
function v1.GetVolume(a1)
    --[[
      name: GetVolume
      line: 364
      upvalues:
        tbl_upv_10 (copy, index: 1)
    ]]
    return tbl_upv_10[a1] or 1
end
local function applyGroup(a1, a2)
    --[[
      name: applyGroup
      line: 331
      upvalues:
        SoundService_upv_1 (copy, index: 1)
        Sounds_upv_1 (copy, index: 2)
        tbl_upv_10 (copy, index: 3)
        duckFactor (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
    ]]
    local v40 = SoundService_upv_1:FindFirstChild(a1)
    local v41 = not (v40) or not (v40:IsA("SoundGroup")) or v40
    local v42 = Sounds_upv_1.GROUPS[a1]
    if not v41 then
        return
    end
    if v42 then
        local v43 = (v42 * (tbl_upv_10[a1] or 1)) * tbl_upv_10.Master * duckFactor(a1)
        if a2 and a2 > 0 then
            local tbl_12 = {}
            tbl_12.Volume = v43
            TweenService_upv_1:Create(v41, TweenInfo.new(a2, Enum.EasingStyle.Sine), tbl_12):Play()
        else
            v41.Volume = v43
        end
    end
end
function v1.Duck(a1, a2, a3)
    --[[
      name: Duck
      line: 369
      upvalues:
        u1 (copy, index: 1)
        tbl_upv_11 (copy, index: 2)
        applyGroup (copy, index: 3)
    ]]
    if u1 then
        return
    end
    table.insert(tbl_upv_11, {group = a1, factor = math.clamp(a2, 0, 1), untilT = os.clock() + a3})
    applyGroup(a1, 0.35)
    task.delay(
        a3,
        function()
            --[[
              line: 375
              upvalues:
                tbl_upv_11 (copy, index: 1)
                applyGroup (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            local v44 = os.clock()
            for n_2 = #tbl_upv_11, 1, -1 do
                if tbl_upv_11[n_2].untilT <= v44 then
                    table.remove(tbl_upv_11, n_2)
                end
            end
            applyGroup(a1, 0.8)
        end
    )
end
function v1.ApplyGroups()
    --[[
      name: ApplyGroups
      line: 387
      upvalues:
        Sounds_upv_1 (copy, index: 1)
        SoundService_upv_1 (copy, index: 2)
        tbl_upv_10 (copy, index: 3)
        duckFactor (copy, index: 4)
    ]]
    local v45 = nil
    for key_3 in Sounds_upv_1.GROUPS do
        local v46 = SoundService_upv_1:FindFirstChild(key_3)
        if not (v46) or not (v46:IsA("SoundGroup")) then
            v45 = nil
            v46 = Sounds_upv_1.GROUPS[key_3]
            if not (v45) then
                continue
            end
            if v46 then
                v45.Volume = ((v46 * (tbl_upv_10[key_3] or 1)) * tbl_upv_10.Master) * duckFactor(key_3)
                continue
            end
        end
        v45 = v46
        v46 = Sounds_upv_1.GROUPS[key_3]
        if not (v45) then
            continue
        end
        if v46 then
            v45.Volume = ((v46 * (tbl_upv_10[key_3] or 1)) * tbl_upv_10.Master) * duckFactor(key_3)
        end
    end
end
local tbl_upv_13 = {}
local tbl_upv_14 = {}
local tbl_upv_15 = {}
local tbl_upv_16 = {}
local release = nil
local u4 = setmetatable({}, {__mode = "k"})
local function acquireSound(a1)
    --[[
      name: acquireSound
      line: 418
      upvalues:
        tbl_upv_13 (copy, index: 1)
        u4 (copy, index: 2)
        tbl_upv_16 (copy, index: 3)
        release (ref,  index: 4)
    ]]
    local v47 = tbl_upv_13[a1]
    local v48 = nil
    if v47 then
        while #v47 > 0 do
            v48 = table.remove(v47)
            if u4[v48] then
                continue
            end
            return v48
        end
        local u5 = a1:Clone()
        u5.Looped = false
        u5.Ended:Connect(
            function()
                --[[
                  line: 430
                  upvalues:
                    tbl_upv_16 (copy, index: 1)
                    u5 (copy, index: 2)
                    release (ref,  index: 3)
                ]]
                local v49 = tbl_upv_16[u5]
                if not v49 then
                    return
                end
                release(v49)
            end
        )
        u5.Destroying:Connect(
            function()
                --[[
                  line: 436
                  upvalues:
                    u4 (copy, index: 1)
                    u5 (copy, index: 2)
                    tbl_upv_16 (copy, index: 3)
                    release (ref,  index: 4)
                ]]
                u4[u5] = true
                local v50 = tbl_upv_16[u5]
                if not v50 then
                    return
                end
                release(v50)
            end
        )
        return u5
    else
        local u5 = a1:Clone()
        u5.Looped = false
        u5.Ended:Connect(
            function()
                --[[
                  line: 430
                  upvalues:
                    tbl_upv_16 (copy, index: 1)
                    u5 (copy, index: 2)
                    release (ref,  index: 3)
                ]]
                local v49 = tbl_upv_16[u5]
                if not v49 then
                    return
                end
                release(v49)
            end
        )
        u5.Destroying:Connect(
            function()
                --[[
                  line: 436
                  upvalues:
                    u4 (copy, index: 1)
                    u5 (copy, index: 2)
                    tbl_upv_16 (copy, index: 3)
                    release (ref,  index: 4)
                ]]
                u4[u5] = true
                local v50 = tbl_upv_16[u5]
                if not v50 then
                    return
                end
                release(v50)
            end
        )
        return u5
    end
end
local function acquireHolder(a1)
    --[[
      name: acquireHolder
      line: 446
      upvalues:
        tbl_upv_14 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    local v51 = table.remove(tbl_upv_14)
    if not (v51) or not (v51.Parent) then
        v51 = Instance.new("Attachment")
        v51.Name = "SfxHolder"
        v51.Parent = Workspace_upv_1.Terrain
    end
    v51.WorldPosition = a1
    return v51
end
release = function(a1)
    --[[
      name: release
      line: 457
      upvalues:
        tbl_upv_15 (copy, index: 1)
        tbl_upv_16 (copy, index: 2)
        u4 (copy, index: 3)
        tbl_upv_13 (copy, index: 4)
        tbl_upv_14 (copy, index: 5)
    ]]
    if a1.released then
        return
    end
    a1.released = true
    if a1.tween then
        a1.tween:Cancel()
    end
    local v52 = table.find(tbl_upv_15, a1)
    if v52 then
        tbl_upv_15[v52] = tbl_upv_15[#tbl_upv_15]
        tbl_upv_15[#tbl_upv_15] = nil
    end
    local sound_upv_1 = a1.sound
    if tbl_upv_16[sound_upv_1] == a1 then
        tbl_upv_16[sound_upv_1] = nil
    end
    if pcall(
        function()
            --[[
              line: 474
              upvalues:
                sound_upv_1 (copy, index: 1)
            ]]
            sound_upv_1:Stop()
            sound_upv_1.Parent = nil
        end
    ) and not (u4[sound_upv_1]) then
        local v53 = tbl_upv_13[a1.template]
        if not (v53) then
            local tbl_17 = {}
            tbl_upv_13[a1.template] = tbl_17
            v53 = tbl_17
        end
        if #v53 < 8 then
            table.insert(v53, sound_upv_1)
        else
            sound_upv_1:Destroy()
        end
    end
    local holder_1 = a1.holder
    if not holder_1 then
        return
    end
    if not (#tbl_upv_14 < 40) or not holder_1.Parent then
        holder_1:Destroy()
    end
    table.insert(tbl_upv_14, holder_1)
end
local function cameraPosition()
    --[[
      name: cameraPosition
      line: 500
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if CurrentCamera_1 then
        return CurrentCamera_1.CFrame.Position
    end
    return nil
end
local function isLocalCharacter(a1)
    --[[
      name: isLocalCharacter
      line: 525
      upvalues:
        u1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if a1 and not (u1) then
        local LocalPlayer_1 = Players_upv_1.LocalPlayer
        local v54 = LocalPlayer_1 and (LocalPlayer_1.Character)
        local v55 = false
        if v54 ~= nil then
            v55 = a1:IsDescendantOf(v54)
        end
        return v55
    end
    return false
end
local function voicePosition(a1)
    --[[
      name: voicePosition
      line: 534
    ]]
    local inst_1 = a1.inst
    if inst_1 and inst_1.Parent then
        if inst_1:IsA("BasePart") then
            return inst_1.Position
        elseif inst_1:IsA("Attachment") then
            return inst_1.WorldPosition
        end
    end
    return a1.pos
end
local function admit3D(a1, a2)
    --[[
      name: admit3D
      line: 547
      upvalues:
        tbl_upv_15 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        release (ref,  index: 3)
    ]]
    if #tbl_upv_15 < 28 then
        return true
    end
    local v56 = Workspace_upv_1.CurrentCamera
    local v57
    if v56 then
        v57 = v56.CFrame.Position
    else
        v57 = nil
    end
    local v58 = nil
    local v59 = -1
    v56 = v58
    local v60 = nil
    local v61 = nil
    for _, value_3 in tbl_upv_15 do
        if value_3.priority then
            continue
        end
        v60 = value_3.inst
        if v60 and v60.Parent then
            if v60:IsA("BasePart") then
                v61 = v60.Position
            elseif v60:IsA("Attachment") then
                v61 = v60.WorldPosition
            else
                v61 = value_3.pos
            end
        else
            v61 = value_3.pos
        end
        if not (v61) or not (v57) then
            v60 = 0
            if v59 < v60 then
                v59, v56 = v60, value_3
                continue
            end
        end
        v60 = (v61 - v57).Magnitude
        if v59 < v60 then
            v59, v56 = v60, value_3
        end
    end
    if v56 then
        if not (a2) and not (a1 < v59) then
            return a2
        end
        release(v56)
        return true
    end
    return a2
end
local function scheduleEnd(a1)
    --[[
      name: scheduleEnd
      line: 570
      upvalues:
        tbl_upv_16 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        release (ref,  index: 3)
    ]]
    local sound_upv_2 = a1.sound
    local function arm_upv_1()
        --[[
          name: arm
          line: 572
          upvalues:
            a1 (copy, index: 1)
            sound_upv_2 (copy, index: 2)
            tbl_upv_16 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
            release (ref,  index: 5)
        ]]
        if a1.released then
            return
        end
        local TimeLength_2 = sound_upv_2.TimeLength
        local v62
        if TimeLength_2 <= 0 then
            v62 = 0
        else
            if sound_upv_2.PlaybackRegionsEnabled then
                local PlaybackRegion_2 = sound_upv_2.PlaybackRegion
                TimeLength_2 = math.min(PlaybackRegion_2.Max, TimeLength_2) - PlaybackRegion_2.Min
            end
            v62 = math.max(TimeLength_2, 0.05) / math.max(sound_upv_2.PlaybackSpeed, 0.05)
        end
        if v62 <= 0 then
            v62 = 6
        end
        local u6 = sound_upv_2:GetAttribute("FadeOut")
        if type(u6) == "number" and u6 > 0 and u6 < v62 then
            task.delay(
                v62 - u6,
                function()
                    --[[
                      line: 582
                      upvalues:
                        a1 (copy, index: 1)
                        tbl_upv_16 (copy, index: 2)
                        sound_upv_2 (copy, index: 3)
                        TweenService_upv_1 (copy, index: 4)
                        u6 (copy, index: 5)
                    ]]
                    if (a1.released) then
                        return
                    end
                    if tbl_upv_16[sound_upv_2] == a1 then
                        local tbl_18 = {Volume = 0}
                        local v63 = TweenService_upv_1:Create(sound_upv_2, TweenInfo.new(u6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), tbl_18)
                        a1.tween = v63
                        v63:Play()
                    end
                end
            )
        end
        task.delay(v62 + 0.1, release, a1)
    end
    if sound_upv_2.IsLoaded then
        arm_upv_1()
    else
        local u7 = nil
        local v64 = sound_upv_2.Loaded:Connect(
            function()
                --[[
                  line: 596
                  upvalues:
                    u7 (ref,  index: 1)
                    arm_upv_1 (copy, index: 2)
                ]]
                if u7 then
                    u7:Disconnect()
                end
                arm_upv_1()
            end
        )
        u7 = v64
        task.delay(
            5,
            function()
                --[[
                  line: 602
                  upvalues:
                    u7 (ref,  index: 1)
                    arm_upv_1 (copy, index: 2)
                ]]
                if not u7 or not u7.Connected then
                    return
                end
                u7:Disconnect()
                arm_upv_1()
            end
        )
    end
end
local playClient = nil
local function playExtras(a1, a2, a3)
    --[[
      name: playExtras
      line: 613
      upvalues:
        playClient (ref, index: 1)
    ]]
    if not a1 or a3 and a3.noLayers then
        return
    end
    local u8 = (a3 and (a3.volume)) or 1
    if a1.layers then
        local v65 = nil
        for _, value_4 in a1.layers do
            if type(value_4) ~= "table" then
                v65 = value_4
            else
                v65 = value_4[1]
            end
            local v66 = ((type(value_4) ~= "table") and 1) or (value_4[2] or 1)
            local v67 = playClient
            local tbl_19 = {pitch = 0, priority = 0, noLayers = true}
            tbl_19.volume = v66 * u8
            tbl_19.pitch = a3 and (a3.pitch)
            tbl_19.priority = a3 and (a3.priority)
            v67(v65, a2, tbl_19)
        end
    end
    if not a1.sequence then
        return
    end
    for _, value_upv_5 in a1.sequence do
        task.delay(
            value_upv_5[2] or 0,
            function()
                --[[
                  line: 627
                  upvalues:
                    a2 (copy, index: 1)
                    playClient (ref,  index: 2)
                    value_upv_5 (copy, index: 3)
                    u8 (copy, index: 4)
                ]]
                if typeof(a2) == "Instance" and not a2.Parent then
                    return
                end
                playClient(value_upv_5[1], a2, {noLayers = true, volume = (value_upv_5[3] or 1) * u8, pitch = value_upv_5[4]})
            end
        )
    end
end
local function inTrainingZone(a1)
    --[[
      name: inTrainingZone
      line: 512
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    for _, value_6 in CollectionService_upv_1:GetTagged("TrainingZone") do
        if not (value_6:IsA("BasePart")) or not (value_6:IsDescendantOf(Workspace_upv_1)) then
            continue
        end
        local v68 = value_6.CFrame:PointToObjectSpace(a1)
        local v69 = value_6.Size * 0.5
        if not (math.abs(v68.X) <= v69.X + 2) or not (math.abs(v68.Z) <= v69.Z + 2) or not (-v69.Y - 4 <= v68.Y) or not (v68.Y <= v69.Y + 10) then
            continue
        end
        return true
    end
    return false
end
local function whereToPosition(a1)
    --[[
      name: whereToPosition
      line: 267
    ]]
    local ty_1 = typeof(a1)
    if ty_1 ~= "Vector3" then
        if ty_1 ~= "CFrame" then
            if ty_1 == "Instance" then
                local v70 = a1:IsA("Model")
                local v71 = nil
                if v70 then
                    local v72 = a1.PrimaryPart or (a1:FindFirstChild("HumanoidRootPart") or (a1:FindFirstChildWhichIsA("BasePart")))
                    if v72 then
                        v71 = v72
                    else
                        return nil, nil
                    end
                else
                    v71 = a1
                end
                if v71:IsA("BasePart") then
                    return v71.Position, v71
                elseif v71:IsA("Attachment") then
                    return v71.WorldPosition, v71
                end
            end
            return nil, nil
        end
        return a1.Position, nil
    end
    return a1, nil
end
playClient = function(a1, a2, a3)
    --[[
      name: playClient
      line: 638
      upvalues:
        resolve (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        pickVariant (copy, index: 3)
        Sounds_upv_1 (copy, index: 4)
        whereToPosition (copy, index: 5)
        u1 (copy, index: 6)
        Players_upv_1 (copy, index: 7)
        tbl_upv_8 (copy, index: 8)
        tbl_upv_9 (copy, index: 9)
        Workspace_upv_1 (copy, index: 10)
        inTrainingZone (copy, index: 11)
        admit3D (copy, index: 12)
        acquireSound (copy, index: 13)
        SoundService_upv_1 (copy, index: 14)
        tbl_upv_14 (copy, index: 15)
        tbl_upv_16 (copy, index: 16)
        tbl_upv_15 (copy, index: 17)
        scheduleEnd (copy, index: 18)
        playExtras (copy, index: 19)
    ]]
    local v73, v74 = resolve(a1)
    if v73 then
        local v75
        if v73:IsA("Sound") then
            v75 = v73
        else
            v75 = pickVariant(v73)
        end
        if not v75 then
            return nil
        end
        local v76 = Sounds_upv_1.Get(v74)
        local v77 = nil
        if v76 then
            v73 = v76
        else
            v77 = string.match(v74, "^(.*)/[^/]+$")
            if v77 then
                v73 = Sounds_upv_1.Get(v77)
            else
                v73 = nil
            end
        end
        local v78, v79 = whereToPosition(a2)
        if a2 ~= nil and not (v78) then
            return nil
        end
        local v80 = nil
        if not (a3) or not (a3.priority) then
            local v81 = nil
            if v73 then
                v81 = v73.priority
                if v81 then
                    v80 = v81
                else
                    if not (v79) or u1 then
                        v80 = false
                    else
                        local LocalPlayer_2 = Players_upv_1.LocalPlayer
                        local v82 = LocalPlayer_2 and (LocalPlayer_2.Character)
                        v80 = false
                        if v82 ~= nil then
                            v80 = v79:IsDescendantOf(v82)
                        end
                    end
                    if not (v80) then
                        v80 = false
                    end
                end
            else
                if not (v79) or u1 then
                    v80 = false
                else
                    local LocalPlayer_2 = Players_upv_1.LocalPlayer
                    local v82 = LocalPlayer_2 and (LocalPlayer_2.Character)
                    v80 = false
                    if v82 ~= nil then
                        v80 = v79:IsDescendantOf(v82)
                    end
                end
                if not (v80) then
                    v80 = false
                end
            end
        end
        local v83 = os.clock()
        local v84 = (v73 and (v73.throttle)) or 0.035
        local v85 = tbl_upv_8[v74]
        local v86
        if v85 then
            local v87 = nil
            if v83 - v85 < v84 then
                v87 = tbl_upv_9[v74]
                if v78 and v87 then
                    if (v78 - v87).Magnitude < 8 then
                        v86 = true
                    else
                        tbl_upv_8[v74] = v83
                        tbl_upv_9[v74] = v78 or false
                        v86 = false
                    end
                else
                    v86 = true
                end
            else
                tbl_upv_8[v74] = v83
                tbl_upv_9[v74] = v78 or false
                v86 = false
            end
        else
            tbl_upv_8[v74] = v83
            tbl_upv_9[v74] = v78 or false
            v86 = false
        end
        if v86 then
            return nil
        end
        v86 = v75.RollOffMaxDistance
        v83 = 1
        local v88 = nil
        if v78 then
            v88 = Workspace_upv_1.CurrentCamera
            local v89
            if v88 then
                v89 = v88.CFrame.Position
            else
                v89 = nil
            end
            local v90
            if v89 then
                v90 = (v78 - v89).Magnitude
            else
                v90 = 0
            end
            if v86 >= 100 then
                local v91 = inTrainingZone(v78)
                if v91 then
                    v86 = math.min(v86, 80)
                    local v92
                    if not (v89) or inTrainingZone(v89) then
                        v92 = 1
                    else
                        v92 = 0.45
                    end
                    v83 = v92 * 0.7
                end
            end
            if not (v80) and v86 < v90 then
                return nil
            end
            local v93 = admit3D(v90, v80)
            if not v93 then
                return nil
            end
        end
        v84 = acquireSound(v75)
        v85 = a3 or {}
        v84.Volume = (v75.Volume * (v85.volume or 1)) * v83
        v84.RollOffMaxDistance = v86
        v83 = v75.PlaybackSpeed * (v85.pitch or 1)
        local v94 = nil
        if not v85.pitch then
            local v95 = v73
            if (v95 and (v73.jitter)) ~= nil then
                v86 = v95
            else
                if (v73) and (v73.group) then
                    v96 = v73.group
                else
                    v94 = Sounds_upv_1.groupOf(v74)
                    local v97, v98 = nil, nil
                    if v94 == "SFX" then
                        v98 = string.match(v74, "^(.*)/[^/]+$")
                        if v98 then
                            v97 = Sounds_upv_1.groupOf(v98)
                        end
                    end
                    v96 = v97
                end
                if v96 ~= "SFX" then
                    v86 = 0
                else
                    v86 = 0.04
                end
            end
            if v86 > 0 then
                v83 = v83 * (1 + (math.random() * 2 - 1) * v86)
            end
        end
        v84.PlaybackSpeed = v83
        v94 = v85.group
        if not (v94) then
            if (v73) and (v73.group) then
                v94 = v73.group
            else
                v83 = Sounds_upv_1.groupOf(v74)
                local v99 = nil
                if v83 == "SFX" then
                    v99 = string.match(v74, "^(.*)/[^/]+$")
                    if v99 then
                        v83 = Sounds_upv_1.groupOf(v99)
                    end
                end
                v94 = v83
            end
        end
        local v100 = SoundService_upv_1:FindFirstChild(v94)
        local v96 = not (v100) or not (v100:IsA("SoundGroup")) or v100
        v84.SoundGroup = v96
        local v101
        if v84.PlaybackRegionsEnabled then
            v101 = v84.PlaybackRegion.Min
        else
            v101 = 0
        end
        v84.TimePosition = v101
        v85 = {released = false}
        v85.sound = v84
        v85.template = nil
        v85.pos = v78
        v85.inst = v79
        v85.priority = nil
        if v78 then
            local v102 = nil
            if v79 then
                v84.Parent = v79
            else
                v102 = table.remove(tbl_upv_14)
                if not (v102) or not (v102.Parent) then
                    v102 = Instance.new("Attachment")
                    v102.Name = "SfxHolder"
                    v102.Parent = Workspace_upv_1.Terrain
                end
                v102.WorldPosition = nil
                v85.holder = v102
                v84.Parent = v102
            end
        else
            v84.Parent = SoundService_upv_1
        end
        tbl_upv_16[v84] = v85
        if v78 then
            table.insert(tbl_upv_15, v85)
        end
        v84:Play()
        scheduleEnd(v85)
        playExtras(v73, a2, a3)
        return v84
    end
    if not (tbl_upv_4[a1]) then
        tbl_upv_4[a1] = true
        warn((("[Sfx] unknown sound '%*'"):format(a1)))
    end
    return nil
end
local u9 = nil
local function getRemote()
    --[[
      name: getRemote
      line: 716
      upvalues:
        u9 (ref, index: 1)
    ]]
    if u9 then
        return u9
    end
    local success_1, v103 = pcall(function() end)
    if success_1 then
        u9 = v103
    end
    return u9
end
local function focusOf(a1)
    --[[
      name: focusOf
      line: 730
    ]]
    local ReplicationFocus_1 = a1.ReplicationFocus
    if ReplicationFocus_1 and ReplicationFocus_1:IsA("BasePart") and ReplicationFocus_1.Parent then
        return ReplicationFocus_1.Position
    end
    local Character_1 = a1.Character
    local v104 = Character_1 and (Character_1.PrimaryPart or (Character_1:FindFirstChild("HumanoidRootPart")))
    if v104 and v104:IsA("BasePart") then
        return v104.Position
    end
    return nil
end
local function playServer(a1, a2, a3, a4)
    --[[
      name: playServer
      line: 744
      upvalues:
        u9 (ref,  index: 1)
        resolve (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
        pickVariant (copy, index: 4)
        whereToPosition (copy, index: 5)
        Sounds_upv_1 (copy, index: 6)
        tbl_upv_8 (copy, index: 7)
        tbl_upv_9 (copy, index: 8)
        Players_upv_1 (copy, index: 9)
        focusOf (copy, index: 10)
    ]]
    if not (u9) then
        local success_2, v105 = pcall(
            function()
                --[[
                  line: 720
                ]]
                return require(script.Parent:WaitForChild("Net")).UnreliableEvent("SfxPlay")
            end
        )
        if success_2 then
            u9 = v105
        end
    end
    if not u9 then
        return
    end
    local v106, v107 = resolve(a1)
    local v108, v109 = nil, nil
    if v106 then
        local v110
        if v106:IsA("Sound") then
            v110 = v106
        else
            v110 = pickVariant(v106)
        end
        local v111, v112 = whereToPosition(a2)
        if a2 ~= nil and not (v111) then
            return
        end
        local v113 = "srv:" .. v107
        v108 = Sounds_upv_1.Get(v107)
        local v114, v115 = nil, nil
        if v108 then
            v114 = v108
        else
            v115 = string.match(v107, "^(.*)/[^/]+$")
            if v115 then
                v114 = Sounds_upv_1.Get(v115)
            else
                v114 = nil
            end
        end
        local v116 = os.clock()
        local v117 = (v114) and (v114.throttle) or 0.035
        v109 = tbl_upv_8[v113]
        local v118
        if v109 then
            local v119 = nil
            if v116 - v109 < v117 then
                v119 = tbl_upv_9[v113]
                if v111 and v119 then
                    if (v111 - v119).Magnitude < 8 then
                        v118 = true
                    else
                        tbl_upv_8[v113] = v116
                        tbl_upv_9[v113] = v111 or false
                        v118 = false
                    end
                else
                    v118 = true
                end
            else
                tbl_upv_8[v113] = v116
                tbl_upv_9[v113] = v111 or false
                v118 = false
            end
        else
            tbl_upv_8[v113] = v116
            tbl_upv_9[v113] = v111 or false
            v118 = false
        end
        if v118 then
            return
        end
        v118 = a3 or {}
        local volume_1 = v118.volume
        local pitch_1 = v118.pitch
        v117 = (v110 and (v110.RollOffMaxDistance)) or 150
        v110 = a4 or (v118.players)
        if not (v111) and not (v110) then
            warn((("[Sfx] server 2D play of '%*' needs opts.players (or Sfx.PlayFor)"):format(a1)))
            return
        end
        v117 = v110 or (Players_upv_1:GetPlayers())
        local v120, v121 = nil, nil
        for _, value_7 in v117 do
            if value_7 == v118.except or value_7.Parent ~= Players_upv_1 then
                continue
            end
            v120 = true
            if v111 and not (v110) then
                local v122 = focusOf(value_7)
                v121 = true
                if v122 ~= nil then
                    v121 = (v122 - v111).Magnitude <= v117 + 40
                end
                v120 = v121
            end
            if v120 then
                u9:FireClient(value_7, v107, v111, v112, volume_1, pitch_1)
            end
        end
    elseif not tbl_upv_4[a1] then
        tbl_upv_4[a1] = true
        warn((("[Sfx] unknown sound '%*'"):format(a1)))
    end
end
function v1.Play(a1, a2, a3)
    --[[
      name: Play
      line: 788
      upvalues:
        u1 (copy, index: 1)
        playServer (copy, index: 2)
        playClient (ref,  index: 3)
    ]]
    if u1 then
        playServer(a1, a2, a3, nil)
        return nil
    end
    return playClient(a1, a2, a3)
end
function v1.PlayUI(a1)
    --[[
      name: PlayUI
      line: 796
      upvalues:
        u1 (copy, index: 1)
        u2 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
        Sounds_upv_1 (copy, index: 4)
        playClient (ref,  index: 5)
    ]]
    if u1 then
        return nil
    end
    local v123 = string.find(a1, "/", 1, true)
    local v124
    if v123 then
        v124 = a1
    else
        if not (u2) or not (u2.Parent) then
            local Assets_3 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
            local v125 = Assets_3 and (Assets_3:FindFirstChild("Sounds"))
            u2 = v125
        end
        if u2 then
            local v126 = u2:FindFirstChild(a1)
            if v126 then
                v124 = a1
            else
                local v127 = Sounds_upv_1.Get(a1)
                if v127 then
                    v124 = a1
                else
                    v124 = "UI/" .. a1
                end
            end
        else
            v124 = a1
        end
    end
    local tbl_20 = {group = 0}
    tbl_20.group = Sounds_upv_1.Get(v124) and Sounds_upv_1.groupOf(v124) or "UI"
    return playClient(v124, nil, tbl_20)
end
function v1.PlayFor(a1, a2, a3, a4)
    --[[
      name: PlayFor
      line: 811
      upvalues:
        u1 (copy, index: 1)
        playServer (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        playClient (ref,  index: 4)
    ]]
    local v129
    if typeof(a1) ~= "Instance" then
        v129 = a1
    else
        v129 = {a1}
    end
    if u1 then
        playServer(a2, a3, a4, v129)
    elseif table.find(v129, Players_upv_1.LocalPlayer) then
        return playClient(a2, a3, a4)
    end
    return nil
end
function v1.Loop(a1, a2, a3)
    --[[
      name: Loop
      line: 825
      upvalues:
        resolve (copy, index: 1)
        tbl_upv_4 (copy, index: 3)
        u1 (copy, index: 4)
        Sounds_upv_1 (copy, index: 5)
        SoundService_upv_1 (copy, index: 6)
        TweenService_upv_1 (copy, index: 7)
    ]]
    local v130, v131 = resolve(a1)
    local v132
    if v130 then
        v130:IsA("Sound")
    end
    v132 = v130
    local v133, v134 = nil, nil
    if v132 then
        if u1 and not (a2) then
            warn((("[Sfx] server loop '%*' needs a parent instance"):format(a1)))
            return function()
                --[[
                  line: 836
                ]]
            end, nil
        end
        v133 = Sounds_upv_1.Get(v131)
        local v135 = nil
        if v133 then
            v130 = v133
        else
            v135 = string.match(v131, "^(.*)/[^/]+$")
            if v135 then
                v130 = Sounds_upv_1.Get(v135)
            else
                v130 = nil
            end
        end
        if not (a3) then
            local _ = {}
        end
        local u10 = v132:Clone()
        u10.Looped = true
        local v136 = v132.Volume * (a3.volume or 1)
        u10.PlaybackSpeed = v132.PlaybackSpeed * (a3.pitch or 1)
        local v137 = a3.group
        if not (v137) then
            if (v130) and (v130.group) then
                v137 = v130.group
            else
                v132 = Sounds_upv_1.groupOf(v131)
                if v132 == "SFX" then
                    v134 = string.match(v131, "^(.*)/[^/]+$")
                    if v134 then
                        v132 = Sounds_upv_1.groupOf(v134)
                    end
                end
                v137 = v132
            end
        end
        v134 = SoundService_upv_1:FindFirstChild(v137)
        u10.SoundGroup = not (v134) or not (v134:IsA("SoundGroup")) or v134
        u10.TimePosition = ((not (u10.PlaybackRegionsEnabled)) and 0) or (u10.PlaybackRegion.Min)
        if (a3.fadeIn) and (a3.fadeIn > 0) then
            u10.Volume = 0
        else
            u10.Volume = v136
        end
        u10.Parent = a2 or SoundService_upv_1
        u10:Play()
        if a3.fadeIn and a3.fadeIn > 0 then
            local tbl_21 = {}
            tbl_21.Volume = v136
            TweenService_upv_1:Create(u10, TweenInfo.new(a3.fadeIn), tbl_21):Play()
        end
        local u11 = false
        local function stop(a4)
            --[[
              name: stop
              line: 857
              upvalues:
                u11 (ref,  index: 1)
                u10 (copy, index: 2)
                TweenService_upv_1 (copy, index: 3)
            ]]
            if u11 then
                return
            end
            u11 = true
            if a4 and a4 > 0 and u10.Parent then
                local tbl_22 = {Volume = 0}
                local v140 = TweenService_upv_1:Create(u10, TweenInfo.new(a4), tbl_22)
                v140.Completed:Once(
                    function()
                        --[[
                          line: 864
                          upvalues:
                            u10 (copy, index: 1)
                        ]]
                        u10:Destroy()
                    end
                )
                v140:Play()
                return
            end
            u10:Destroy()
        end
        return stop, u10
    end
    if not (v130) and not (tbl_upv_4[a1]) then
        tbl_upv_4[a1] = true
        warn((("[Sfx] unknown sound '%*'"):format(a1)))
    end
    return function()
        --[[
          line: 832
        ]]
    end, nil
end
function v1.Clone(a1)
    --[[
      name: Clone
      line: 877
      upvalues:
        resolve (copy, index: 1)
        tbl_upv_4 (copy, index: 3)
        Sounds_upv_1 (copy, index: 4)
        SoundService_upv_1 (copy, index: 5)
    ]]
    local v141, v142 = resolve(a1)
    local v143
    if v141 then
        v141:IsA("Sound")
    end
    v143 = v141
    local v144, v145 = nil, nil
    if v143 then
        local v146 = v143:Clone()
        v144 = Sounds_upv_1.Get(v142)
        local v147 = nil
        if v144 then
            v145 = v144
        else
            v147 = string.match(v142, "^(.*)/[^/]+$")
            if v147 then
                v145 = Sounds_upv_1.Get(v147)
            else
                v145 = nil
            end
        end
        local v148
        if (v145) and (v145.group) then
            v148 = v145.group
        else
            local v149 = Sounds_upv_1.groupOf(v142)
            local v150 = nil
            if v149 == "SFX" then
                v150 = string.match(v142, "^(.*)/[^/]+$")
                if v150 then
                    v149 = Sounds_upv_1.groupOf(v150)
                end
            end
            v148 = v149
        end
        v145 = SoundService_upv_1:FindFirstChild(v148)
        v146.SoundGroup = not (v145) or not (v145:IsA("SoundGroup")) or v145
        return v146
    end
    if not (v141) and not (tbl_upv_4[a1]) then
        tbl_upv_4[a1] = true
        warn((("[Sfx] unknown sound '%*'"):format(a1)))
    end
    return nil
end
function v1.Has(a1)
    --[[
      name: Has
      line: 891
      upvalues:
        resolve (copy, index: 1)
    ]]
    local v152 = resolve(a1) ~= nil
    return v152
end
function v1.Length(a1)
    --[[
      name: Length
      line: 897
      upvalues:
        resolve (copy, index: 1)
    ]]
    local v153 = resolve(a1)
    local v154
    if v153 then
        v153:IsA("Sound")
    end
    v154 = v153
    if not v154 then
        return 0
    end
    local TimeLength_3 = v154.TimeLength
    if TimeLength_3 <= 0 then
        return 0
    end
    if v154.PlaybackRegionsEnabled then
        local PlaybackRegion_3 = v154.PlaybackRegion
        TimeLength_3 = math.min(PlaybackRegion_3.Max, TimeLength_3) - PlaybackRegion_3.Min
    end
    return math.max(TimeLength_3, 0.05) / math.max(v154.PlaybackSpeed, 0.05)
end
function v1.Preload(a1)
    --[[
      name: Preload
      line: 904
      upvalues:
        resolve (copy, index: 1)
        u2 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
        ContentProvider_upv_1 (copy, index: 4)
    ]]
    task.spawn(
        function()
            --[[
              line: 905
              upvalues:
                a1 (copy, index: 1)
                resolve (copy, index: 2)
                u2 (ref,  index: 3)
                ReplicatedStorage_upv_1 (copy, index: 4)
                ContentProvider_upv_1 (copy, index: 5)
            ]]
            local tbl_23 = {}
            if a1 then
                for _, value_8 in a1 do
                    local v155 = resolve(value_8)
                    if not (v155) then
                        continue
                    end
                    if not (v155:IsA("Folder")) then
                        table.insert(tbl_23, v155)
                        continue
                    end
                    for v157, value_9 in v155:GetChildren() do
                        table.insert(tbl_23, value_9)
                    end
                end
            else
                if not (u2) or not (u2.Parent) then
                    local Assets_4 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
                    local v156 = Assets_4 and (Assets_4:FindFirstChild("Sounds"))
                    u2 = v156
                end
                if u2 then
                    for _, value_10 in u2:GetDescendants() do
                        if value_10:IsA("Sound") then
                            table.insert(tbl_23, value_10)
                        end
                    end
                end
            end
            pcall(ContentProvider_upv_1.PreloadAsync, ContentProvider_upv_1, tbl_23)
        end
    )
end
function v1.Stats()
    --[[
      name: Stats
      line: 935
      upvalues:
        tbl_upv_13 (copy, index: 1)
        tbl_upv_15 (copy, index: 2)
    ]]
    local v157 = 0
    for _, value_11 in tbl_upv_13 do
        v157 = v157 + #value_11
    end
    local tbl_24 = {}
    tbl_24.live3D = #tbl_upv_15
    tbl_24.pooled = v157
    return tbl_24
end
return v1