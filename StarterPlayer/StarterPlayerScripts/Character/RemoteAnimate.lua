local Players_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Characters_upv_1 = require(script.Parent:WaitForChild("Characters"))
local Effects_upv_1 = require(script.Parent:WaitForChild("Effects"))
local Perf_upv_1 = require(script.Parent:WaitForChild("Perf"))
local AnimationIds_upv_1 = require(script.Parent:WaitForChild("AnimationIds"))
local AnimGuard_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("AnimGuard"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = RunService_upv_1:IsStudio()
local function clientAuthority()
    --[[
      name: clientAuthority
      line: 78
      upvalues:
        Workspace_upv_1 (copy, index: 1)
    ]]
    local v1 = Workspace_upv_1:GetAttribute("TribesAuthority") == "Client"
    return v1
end
local tbl_upv_2 = {}
for _, value_1 in {AnimationIds_upv_1.R15, AnimationIds_upv_1.R6} do
    for v3, value_2 in {"idle", "idle2", "walk", "run", "jump", "fall"} do
        local v2 = value_1[value_2]
        if type(v2) ~= "string" then
            continue
        end
        if v2 ~= "" then
            tbl_upv_2[v2] = true
        end
    end
end
local tbl_upv_3 = {}
tbl_upv_3[AnimationIds_upv_1.SlideLegs] = true
tbl_upv_3[AnimationIds_upv_1.SlideFallback] = true
local u2 = setmetatable({}, {__mode = "k"})
local tbl_upv_4 = {}
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Exclude
u3.RespectCanCollide = true
local u4 = setmetatable({}, {__mode = "k"})
local function guard(a1)
    --[[
      name: guard
      line: 107
      upvalues:
        u4 (copy, index: 1)
    ]]
    if not a1 then
        return
    end
    local v3 = u4[a1]
    if v3 and a1.Priority ~= v3 then
        a1.Priority = v3
    end
    if (a1.Looped) then
        return
    end
    a1.Looped = true
end
local function load(a1, a2, a3, a4)
    --[[
      name: load
      line: 120
      upvalues:
        u4 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    if a2 == "" then
        return nil
    end
    local u5 = Instance.new("Animation")
    u5.Name = a4
    u5.AnimationId = a2
    local success_1, v4 = pcall(
        function()
            --[[
              line: 127
              upvalues:
                a1 (copy, index: 1)
                u5 (copy, index: 2)
            ]]
            return a1:LoadAnimation(u5)
        end
    )
    if success_1 and v4 then
        v4.Priority = a3
        v4.Looped = true
        u4[v4] = a3
        u2[v4] = true
        return v4
    end
    return nil
end
local function muteReplicated(a1)
    --[[
      name: muteReplicated
      line: 181
      upvalues:
        u2 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    local v5 = a1.humanoid:FindFirstChildOfClass("Animator")
    if not v5 then
        return
    end
    local v6 = false
    for _, value_3 in v5:GetPlayingAnimationTracks() do
        if u2[value_3] then
            continue
        end
        local Animation_1 = value_3.Animation
        if not (Animation_1) or not (tbl_upv_2[Animation_1.AnimationId]) then
            if not (Animation_1) then
                continue
            end
            if tbl_upv_3[Animation_1.AnimationId] then
                v6 = ((value_3.WeightTarget > 0.5) and true) or v6
                continue
            end
        end
        value_3:Stop(0)
    end
    a1.replSliding = v6
end
local function setSliding(a1, a2)
    --[[
      name: setSliding
      line: 222
    ]]
    local character_1 = a1.character
    if character_1.Parent then
        local v7 = character_1:GetAttribute("Sliding") == true
        if v7 == a2 then
            return
        end
        character_1:SetAttribute("Sliding", (a2 and true) or nil)
    end
end
local u6 = setmetatable({}, {__mode = "k"})
local function guardTracks(a1)
    --[[
      name: guardTracks
      line: 235
      upvalues:
        u6 (copy, index: 1)
        AnimGuard_upv_1 (copy, index: 2)
    ]]
    local v8 = a1:FindFirstChildOfClass("Humanoid")
    local v9 = v8 and (v8:FindFirstChildOfClass("Animator"))
    if not v9 then
        return
    end
    u6[a1] = true
    AnimGuard_upv_1.Watch(v9)
end
local function destroyRig(a1)
    --[[
      name: destroyRig
      line: 267
    ]]
    local function drop_1(a2)
        --[[
          name: drop
          line: 268
        ]]
        if not a2 then
            return
        end
        pcall(function() end)
    end
    for _, value_4 in a1.tracks do
        if value_4 then
            pcall(function() end)
        end
    end
    local legs_1 = a1.legs
    if legs_1 then
        pcall(function() end)
    end
    local upper_upv_1 = a1.upper
    if upper_upv_1 then
        pcall(
            function()
                --[[
                  line: 270
                  upvalues:
                    upper_upv_1 (copy, index: 1)
                ]]
                upper_upv_1:Stop(0)
                upper_upv_1:Destroy()
            end
        )
    end
    table.clear(a1.tracks)
    a1.legs = nil
    a1.upper = nil
    if a1.slideSound then
        a1.slideSound:Destroy()
        a1.slideSound = nil
    end
    a1.active = false
end
local function stopAll(a1)
    --[[
      name: stopAll
      line: 244
    ]]
    for key_1, value_5 in a1.tracks do
        value_5:Stop(0.2)
        a1.weights[key_1] = 0
    end
    if a1.legs then
        a1.legs:Stop(0.15)
    end
    if a1.upper then
        a1.upper:Stop(0.15)
    end
    a1.sliding = false
    a1.replSliding = false
    if a1.slideSound then
        local slideSound_upv_1 = a1.slideSound
        a1.slideSound = nil
        task.spawn(
            function()
                --[[
                  line: 207
                  upvalues:
                    slideSound_upv_1 (copy, index: 1)
                ]]
                for _ = 1, 8 do
                    if slideSound_upv_1.Parent then
                        slideSound_upv_1.Volume = slideSound_upv_1.Volume * 0.7
                        task.wait(0.02)
                        continue
                    else
                        break
                    end
                end
                slideSound_upv_1:Destroy()
            end
        )
    end
    local character_2 = a1.character
    if character_2.Parent then
        local v10 = character_2:GetAttribute("Sliding") == true
        if v10 ~= false then
            character_2:SetAttribute("Sliding", nil)
        end
    end
    a1.active = false
end
local function setSlideSound(a1, a2)
    --[[
      name: setSlideSound
      line: 201
      upvalues:
        Effects_upv_1 (copy, index: 1)
    ]]
    if (not a2 or (a1.slideSound)) and not (a2) and a1.slideSound then
        local _ = a1.slideSound
        a1.slideSound = nil
        task.spawn(function() end)
    end
    a1.slideSound = Effects_upv_1.PlaySound("Slide", a1.root, {looped = true, volume = 1.2, pitchVar = 0.08})
end
local u7 = 0
local function step(a1, a2, a3)
    --[[
      name: step
      line: 290
      upvalues:
        stopAll (copy, index: 1)
        u3 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        u4 (copy, index: 4)
        setSlideSound (copy, index: 5)
        LocalPlayer_upv_1 (copy, index: 6)
    ]]
    local v11 = a1.humanoid
    local root_1 = a1.root
    local v12, v13, _, v14 = nil, nil, nil, nil
    if v11.Health <= 0 then
        if a1.active then
            stopAll(a1)
        end
    else
        a1.active = true
        local targets_1 = a1.targets
        for key_2 in a1.tracks do
            targets_1[key_2] = 0
        end
        local v15 = root_1.AssemblyLinearVelocity
        local Magnitude_1 = Vector3.new(v15.X, 0, v15.Z).Magnitude
        local LookVector_1 = root_1:GetAttribute("SHipBase")
        local v16
        if type(LookVector_1) ~= "number" then
            v16 = v11.HipHeight
        else
            v16 = LookVector_1
        end
        local v17 = math.max(0.5, v16 / 2)
        u3.FilterDescendantsInstances = {a1.character}
        local v18 = false
        v11 = (math.abs(v15.Y) < 12) and (Workspace_upv_1:Raycast(root_1.Position, Vector3.new(0, -((v18.HipHeight + (root_1.Size.Y / 2)) + 0.9), 0), u3) ~= nil)
        if v11 then
            a1.groundedAt = a3
        elseif v15.Y > 8 and a3 - a1.groundedAt < 0.25 then
            a1.jumpAt = a3
        end
        if v11 or a3 - a1.groundedAt < 0.1 then
            LookVector_1 = math.clamp((Magnitude_1 - 0.6) / 2.5, 0, 1)
            v13 = math.clamp(((Magnitude_1 / v17) - 9) / 5, 0, 1)
            targets_1.idle = 1 - LookVector_1
            targets_1.walk = LookVector_1 * (1 - v13)
            targets_1.run = LookVector_1 * v13
            v13 = 1
            if Magnitude_1 > 1 then
                LookVector_1 = root_1.CFrame.LookVector
                v13 = (v15.X * root_1.CFrame.LookVector.X + v15.Z * root_1.CFrame.LookVector.Z) / Magnitude_1 < -0.35 and -1 or v13
            end
            v12 = a1.tracks.walk
            local run_1 = a1.tracks.run
            if v12 then
                v12:AdjustSpeed(v13 * math.clamp(Magnitude_1 / (v17 * 7.5), 0.4, 1.8))
            end
            if run_1 then
                run_1:AdjustSpeed(v13 * math.clamp(Magnitude_1 / (v17 * 16.5), 0.55, 1.7))
            end
        elseif a1.jumpAt > 0 and a3 - a1.jumpAt < 0.45 and v15.Y > -12 then
            targets_1.jump = 1
        else
            targets_1.fall = 1
        end
        local v19 = 1 - math.exp(a2 * -14)
        v13 = a1.legs
        if v13 then
            v15 = u4[v13]
            if v15 and v13.Priority ~= v15 then
                v13.Priority = v15
            end
            if not (v13.Looped) then
                v13.Looped = true
            end
        end
        v13 = a1.upper
        if v13 then
            v11 = u4[v13]
            if v11 and v13.Priority ~= v11 then
                v13.Priority = v11
            end
            if not (v13.Looped) then
                v13.Looped = true
            end
        end
        for key_3, value_6 in a1.tracks do
            if value_6 then
                local v20 = u4[value_6]
                if v20 and value_6.Priority ~= v20 then
                    value_6.Priority = v20
                end
                if not (value_6.Looped) then
                    value_6.Looped = true
                end
            end
            local v21 = a1.weights[key_3] + ((targets_1[key_3] or 0) - a1.weights[key_3]) * v19
            v21 = ((v21 < 0.001) and 1e-04) or v21
            a1.weights[key_3] = v21
            if value_6.IsPlaying then
                value_6:AdjustWeight(v21, 0)
            else
                value_6:Play(0, v21, value_6.Speed)
            end
        end
        v17 = root_1:GetAttribute("SSlide") ~= nil
        if v17 ~= a1.sliding then
            a1.sliding = v17
            if v17 then
                if a1.legs then
                    a1.legs:Play(0.08, 1, 1)
                end
                if a1.upper then
                    a1.upper:Play(0.12, 1, 1)
                end
            else
                if a1.legs then
                    a1.legs:Stop(0.15)
                end
                if a1.upper then
                    a1.upper:Stop(0.15)
                end
            end
        end
        if a1.sliding then
            v17 = Magnitude_1 >= 4
        else
            v17 = a1.replSliding
            v17 = a1.replSliding and Magnitude_1 >= 4
        end
        v14 = a1.character
        if v14.Parent then
            v13 = v14:GetAttribute("Sliding") == true
            if v13 ~= v17 then
                v14:SetAttribute("Sliding", (v17 and true) or nil)
            end
        end
        local v22 = v17 and (LocalPlayer_upv_1:GetAttribute("State") == "Match")
        setSlideSound(a1, v22)
    end
end
local function build(a1, a2)
    --[[
      name: build
      line: 140
      upvalues:
        AnimationIds_upv_1 (copy, index: 1)
        load (copy, index: 2)
    ]]
    local v23 = a1:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart_1 = a1:FindFirstChild("HumanoidRootPart")
    local v24 = v23 and (v23:FindFirstChildOfClass("Animator"))
    if not v23 or not HumanoidRootPart_1 or not HumanoidRootPart_1:IsA("BasePart") or not v24 then
        return nil
    end
    local v25
    if v23.RigType ~= Enum.HumanoidRigType.R6 then
        v25 = AnimationIds_upv_1.R15
    else
        v25 = AnimationIds_upv_1.R6
    end
    local tbl_5 = {sliding = false, active = false, jumpAt = -1, groundedAt = 0, replSliding = false}
    tbl_5.character = a1
    tbl_5.humanoid = v23
    tbl_5.root = HumanoidRootPart_1
    tbl_5.tracks = {}
    tbl_5.weights = {}
    tbl_5.targets = {}
    for _, value_7 in {"idle", "walk", "run", "jump", "fall"} do
        local v26 = load(v23, v25[value_7], Enum.AnimationPriority.Core, value_7)
        if v26 then
            tbl_5.tracks[value_7] = v26
            tbl_5.weights[value_7] = 0
        end
    end
    if a2 then
        tbl_5.legs = load(v23, AnimationIds_upv_1.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs") or load(v23, AnimationIds_upv_1.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback")
        tbl_5.upper = load(v23, AnimationIds_upv_1.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")
    end
    return tbl_5
end
local function update(a1)
    --[[
      name: update
      line: 390
      upvalues:
        u7 (ref,  index: 1)
        Workspace_upv_1 (copy, index: 2)
        Characters_upv_1 (copy, index: 3)
        u1 (copy, index: 4)
        LocalPlayer_upv_1 (copy, index: 5)
        u6 (copy, index: 6)
        AnimGuard_upv_1 (copy, index: 7)
        tbl_upv_4 (copy, index: 8)
        stopAll (copy, index: 9)
        build (copy, index: 10)
        muteReplicated (copy, index: 11)
        step (copy, index: 12)
        destroyRig (copy, index: 13)
    ]]
    u7 = u7 + a1
    if u7 < 0.03333333333333333 then
        return
    end
    local v28 = math.min(u7, 0.1)
    u7 = 0
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    local Position_1 = CurrentCamera_1.CFrame.Position
    local v29 = os.clock()
    local tbl_6 = {}
    local v30, v31 = nil, nil
    local _ = nil
    for v38, value_8 in Characters_upv_1.List() do
        local v32 = Characters_upv_1.PlayerOf(value_8)
        local v33 = u1 and (value_8:HasTag("CharacterLoadTest"))
        if v32 == LocalPlayer_upv_1 then
            continue
        end
        if v32 or v33 or value_8:HasTag("Combatant") then
            if v32 == nil then
                v30 = u1 and (value_8:HasTag("ClientAuthorityTest"))
            else
                if Workspace_upv_1:GetAttribute("TribesAuthority") == "Client" then
                    local v34 = true
                    v30, v30 = v34, v34
                else
                    v30 = false
                end
                if not (v30) then
                    v30 = u1 and (value_8:HasTag("ClientAuthorityTest"))
                end
            end
            if v30 and not (u6[value_8]) then
                local v35 = value_8:FindFirstChildOfClass("Humanoid")
                local v36 = v35 and (v35:FindFirstChildOfClass("Animator"))
                if v36 then
                    u6[value_8] = true
                    AnimGuard_upv_1.Watch(v36)
                end
            end
            local HumanoidRootPart_2 = value_8:FindFirstChild("HumanoidRootPart")
            if not (HumanoidRootPart_2) or not (HumanoidRootPart_2:IsA("BasePart")) then
                continue
            end
            v31 = tbl_upv_4[value_8]
            if (HumanoidRootPart_2.Position - Position_1).Magnitude > 160 then
                if not (v31) then
                    continue
                end
                if v31.active then
                    stopAll(v31)
                end
            else
                if not v31 then
                    local v37 = build(value_8, not v30)
                    if not (v37) then
                        continue
                    end
                    tbl_upv_4[value_8] = v37
                    v31 = v37
                end
                tbl_6[value_8] = true
                if v30 then
                    muteReplicated(v31)
                end
                step(v31, v28, v29)
            end
        end
    end
    for key_4, value_9 in tbl_upv_4 do
        if not (key_4.Parent) then
            destroyRig(value_9)
            tbl_upv_4[key_4] = nil
            continue
        end
        if tbl_6[key_4] then
            continue
        end
        if value_9.active then
            stopAll(value_9)
        end
    end
end
local u8 = false
function tbl_1.Start()
    --[[
      name: Start
      line: 452
      upvalues:
        u8 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        Perf_upv_1 (copy, index: 3)
        update (copy, index: 4)
    ]]
    if u8 then
        return
    end
    u8 = true
    RunService_upv_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 457
              upvalues:
                Perf_upv_1 (copy, index: 1)
                update (copy, index: 2)
            ]]
            local v38 = Perf_upv_1.Begin()
            update(a1)
            Perf_upv_1.End("RemoteAnimate", v38)
        end
    )
end
return tbl_1