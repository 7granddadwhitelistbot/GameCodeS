local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Parent_upv_1 = script.Parent
local Humanoid_upv_1 = Parent_upv_1:WaitForChild("Humanoid")
local u1 = Humanoid_upv_1:FindFirstChildOfClass("Animator") or (Humanoid_upv_1:WaitForChild("Animator"))
local HumanoidRootPart_upv_1 = Parent_upv_1:WaitForChild("HumanoidRootPart")
local success_upv_1, u2 = pcall(
    function()
        --[[
          line: 27
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
        ]]
        return (require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Camera")))
    end
)
pcall(
    function()
        --[[
          line: 33
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("AnimGuard")).Watch(u1)
    end
)
local u3 = require(Players_upv_1.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Character"):WaitForChild("AnimationIds"))
local R15_1 = u3.R15
local R6_1 = u3.R6
local Emotes_upv_1 = u3.Emotes
if Humanoid_upv_1.RigType ~= Enum.HumanoidRigType.R6 then
    u3 = R15_1
else
    u3 = R6_1
end
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local function load(a1, a2, a3)
    --[[
      name: load
      line: 68
      upvalues:
        u1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    local v1 = Instance.new("Animation")
    v1.Name = a1
    v1.AnimationId = a2
    local v2 = u1:LoadAnimation(v1)
    v2.Priority = Enum.AnimationPriority.Core
    v2.Looped = a3
    tbl_upv_1[a1] = v2
    tbl_upv_2[a1] = 0
    return v2
end
for key_1, value_1 in u3 do
    local v3 = Instance.new("Animation")
    v3.Name = key_1
    v3.AnimationId = value_1
    local v4 = u1:LoadAnimation(v3)
    v4.Priority = Enum.AnimationPriority.Core
    v4.Looped = true
    tbl_upv_1[key_1] = v4
    tbl_upv_2[key_1] = 0
end
for key_2, value_2 in tbl_upv_1 do
    value_2:Play(0, 1e-04, 1)
    tbl_upv_2[key_2] = 0
    tbl_upv_3[key_2] = 1e-04
    tbl_upv_4[key_2] = 1
end
tbl_upv_2.idle = 1
tbl_upv_1.idle:AdjustWeight(1, 0)
tbl_upv_3.idle = 1
local u4 = 0
local u5 = false
local u6 = "ground"
local u7 = -1
local u8 = 0
local u9 = 0
local u10 = nil
local function stopEmote()
    --[[
      name: stopEmote
      line: 105
      upvalues:
        u10 (ref,  index: 1)
        success_upv_1 (copy, index: 2)
        u2 (copy, index: 3)
    ]]
    if not u10 then
        return
    end
    u10:Stop(0.2)
    u10 = nil
    if not success_upv_1 then
        return
    end
    u2.ResumeCharacterRotation("Emote")
end
u3 = {}
u3[Enum.HumanoidStateType.Jumping] = "air"
u3[Enum.HumanoidStateType.Freefall] = "air"
u3[Enum.HumanoidStateType.Climbing] = "climb"
u3[Enum.HumanoidStateType.Swimming] = "swim"
u3[Enum.HumanoidStateType.Seated] = "sit"
u3[Enum.HumanoidStateType.Dead] = "none"
u3[Enum.HumanoidStateType.Physics] = "none"
u3[Enum.HumanoidStateType.Ragdoll] = "none"
u3[Enum.HumanoidStateType.FallingDown] = "none"
u3[Enum.HumanoidStateType.PlatformStanding] = "none"
u3[Enum.HumanoidStateType.Running] = "ground"
u3[Enum.HumanoidStateType.RunningNoPhysics] = "ground"
u3[Enum.HumanoidStateType.Landed] = "ground"
u3[Enum.HumanoidStateType.GettingUp] = "ground"
local function startJump(a1)
    --[[
      name: startJump
      line: 134
      upvalues:
        u6 (ref,  index: 1)
        u7 (ref,  index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if u6 == "air" and u7 > 0 and os.clock() - u7 < 0.4 then
        return
    end
    u6 = "air"
    u7 = os.clock() - a1
    tbl_upv_1.jump.TimePosition = a1
end
local function enterMode(a1)
    --[[
      name: enterMode
      line: 143
      upvalues:
        u6 (ref,  index: 1)
        u7 (ref,  index: 2)
        u10 (ref,  index: 3)
        success_upv_1 (copy, index: 4)
        u2 (copy, index: 5)
    ]]
    if a1 == u6 then
        return
    end
    if a1 == "air" then
        u7 = -1
    end
    if a1 ~= "ground" and a1 ~= "sit" and u10 then
        u10:Stop(0.2)
        u10 = nil
        if success_upv_1 then
            u2.ResumeCharacterRotation("Emote")
        end
    end
    u6 = a1
end
Humanoid_upv_1.StateChanged:Connect(
    function(a1, a2)
        --[[
          line: 156
          upvalues:
            RunService_upv_1 (copy, index: 1)
            u6 (ref,  index: 2)
            u7 (ref,  index: 3)
            tbl_upv_1 (copy, index: 4)
            u10 (ref,  index: 5)
            success_upv_1 (copy, index: 6)
            u2 (copy, index: 7)
            u3 (copy, index: 8)
        ]]
        if not RunService_upv_1:IsResimulating() then
            local v5 = nil
            if a2 ~= Enum.HumanoidStateType.Jumping then
                v5 = u3[a2]
                if v5 and v5 ~= u6 then
                    if v5 == "air" then
                        u7 = -1
                    end
                    if v5 ~= "ground" and v5 ~= "sit" and u10 then
                        u10:Stop(0.2)
                        u10 = nil
                        if success_upv_1 then
                            u2.ResumeCharacterRotation("Emote")
                        end
                    end
                    u6 = v5
                end
            else
                if u6 ~= "air" or not (u7 > 0) or not (os.clock() - u7 < 0.4) then
                    u6 = "air"
                    u7 = os.clock() - 0
                    tbl_upv_1.jump.TimePosition = 0
                end
                if u10 then
                    u10:Stop(0.2)
                    u10 = nil
                    if success_upv_1 then
                        u2.ResumeCharacterRotation("Emote")
                    end
                end
            end
        end
    end
)
Humanoid_upv_1.Climbing:Connect(
    function(a1)
        --[[
          line: 171
          upvalues:
            u8 (ref, index: 1)
        ]]
        u8 = a1
    end
)
Humanoid_upv_1.Swimming:Connect(
    function(a1)
        --[[
          line: 174
          upvalues:
            u9 (ref, index: 1)
        ]]
        u9 = a1
    end
)
local u11 = script:FindFirstChild("PlayEmote")
if not (u11) then
    local v6 = Instance.new("BindableFunction")
    v6.Name = "PlayEmote"
    v6.Parent = script
    u11 = v6
end
local function inMatch()
    --[[
      name: inMatch
      line: 186
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local v7 = Players_upv_1.LocalPlayer:GetAttribute("State") == "Match"
    return v7
end
Players_upv_1.LocalPlayer:GetAttributeChangedSignal("State"):Connect(
    function()
        --[[
          line: 189
          upvalues:
            Players_upv_1 (copy, index: 1)
            u10 (ref,  index: 2)
            success_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
        ]]
        local v8 = Players_upv_1.LocalPlayer:GetAttribute("State") == "Match"
        if not v8 or not u10 then
            return
        end
        u10:Stop(0.2)
        u10 = nil
        if not success_upv_1 then
            return
        end
        u2.ResumeCharacterRotation("Emote")
    end
)
u11.OnInvoke = function(a1)
    --[[
      line: 194
      upvalues:
        u6 (ref,  index: 1)
        Humanoid_upv_1 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        Emotes_upv_1 (copy, index: 4)
        u10 (ref,  index: 5)
        success_upv_1 (copy, index: 6)
        u2 (copy, index: 7)
        u1 (copy, index: 8)
    ]]
    if u6 == "ground" and not (Humanoid_upv_1.MoveDirection.Magnitude > 0.05) then
        local v9 = Players_upv_1.LocalPlayer:GetAttribute("State") == "Match"
        if not (v9) then
            v9 = nil
            if typeof(a1) == "Instance" and (a1:IsA("Animation")) then
                v9 = a1
            elseif typeof(a1) == "string" and Emotes_upv_1[a1] then
                local v10 = Instance.new("Animation")
                v10.AnimationId = Emotes_upv_1[a1]
                v9 = v10
            end
            if not v9 then
                return false
            end
            if u10 then
                u10:Stop(0.2)
                u10 = nil
                if success_upv_1 then
                    u2.ResumeCharacterRotation("Emote")
                end
            end
            local u12 = u1:LoadAnimation(v9)
            u12.Priority = Enum.AnimationPriority.Idle
            u12:Play(0.2)
            u10 = u12
            if success_upv_1 then
                u2.SuspendCharacterRotation("Emote")
            end
            u12.Stopped:Once(
                function()
                    --[[
                      line: 217
                      upvalues:
                        u10 (ref,  index: 1)
                        u12 (copy, index: 2)
                        success_upv_1 (copy, index: 3)
                        u2 (copy, index: 4)
                    ]]
                    if u10 ~= u12 then
                        return
                    end
                    u10 = nil
                    if not success_upv_1 then
                        return
                    end
                    u2.ResumeCharacterRotation("Emote")
                end
            )
            return true
        end
    end
    return false
end
u11 = {}
local function scale()
    --[[
      name: scale
      line: 231
      upvalues:
        Parent_upv_1 (copy, index: 1)
        Humanoid_upv_1 (copy, index: 2)
    ]]
    local HumanoidRootPart_2 = Parent_upv_1:FindFirstChild("HumanoidRootPart")
    local v11 = HumanoidRootPart_2 and (HumanoidRootPart_2:GetAttribute("SHipBase"))
    local v12
    if type(v11) ~= "number" then
        v12 = Humanoid_upv_1.HipHeight
    else
        v12 = v11
    end
    return (math.max(0.5, v12 / 2))
end
local u13 = false
local tbl_upv_5 = {}
local u14 = 0
local u15 = u6
local function push()
    --[[
      name: push
      line: 246
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
        u11 (copy, index: 4)
        tbl_upv_5 (copy, index: 5)
        tbl_upv_4 (copy, index: 6)
    ]]
    for key_3, value_3 in tbl_upv_1 do
        local v13 = tbl_upv_2[key_3]
        local v14 = tbl_upv_3[key_3]
        if v13 ~= v14 and (math.abs(v13 - v14) >= 0.01 or v13 == math.max(u11[key_3] or 0, 1e-04)) then
            tbl_upv_3[key_3] = v13
            value_3:AdjustWeight(v13, 0.05)
        end
        local v15 = tbl_upv_5[key_3]
        if v15 and math.abs(v15 - tbl_upv_4[key_3]) >= 0.02 then
            tbl_upv_4[key_3] = v15
            value_3:AdjustSpeed(v15)
        end
        if not (value_3.IsPlaying) then
            value_3:Play(0, tbl_upv_3[key_3], tbl_upv_4[key_3])
        end
    end
end
RunService_upv_1.Heartbeat:Connect(
    function(a1)
        --[[
          line: 265
          upvalues:
            u13 (ref,  index: 1)
            Parent_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            u11 (copy, index: 4)
            tbl_upv_5 (copy, index: 5)
            HumanoidRootPart_upv_1 (copy, index: 6)
            Humanoid_upv_1 (copy, index: 7)
            u3 (copy, index: 8)
            u6 (ref,  index: 9)
            u7 (ref,  index: 10)
            u10 (ref,  index: 11)
            success_upv_1 (copy, index: 12)
            u2 (copy, index: 13)
            u4 (ref,  index: 14)
            u5 (ref,  index: 15)
            u8 (ref,  index: 16)
            u9 (ref,  index: 17)
            tbl_upv_2 (copy, index: 18)
            u14 (ref,  index: 19)
            u15 (ref,  index: 20)
            push (copy, index: 21)
        ]]
        if u13 or not Parent_upv_1.Parent then
            return
        end
        for key_4 in tbl_upv_1 do
            u11[key_4] = 0
        end
        table.clear(tbl_upv_5)
        local v16 = HumanoidRootPart_upv_1.AssemblyLinearVelocity
        local Magnitude_1 = Vector3.new(v16.X, 0, v16.Z).Magnitude
        local v17 = Parent_upv_1:FindFirstChild("HumanoidRootPart")
        local v18 = v17 and (v17:GetAttribute("SHipBase"))
        local v19
        if type(v18) ~= "number" then
            v19 = Humanoid_upv_1.HipHeight
        else
            v19 = v18
        end
        local v20 = math.max(0.5, v19 / 2)
        local v21 = u3[Humanoid_upv_1:GetState()]
        if v21 and v21 ~= u6 then
            if v21 == "air" and (v16.Y > 8) then
                local Gravity_1 = workspace.Gravity
                local v22 = math.clamp((math.sqrt((2 * Gravity_1) * math.max(Humanoid_upv_1.JumpHeight, 0.1)) - v16.Y) / Gravity_1, 0, 0.4)
                if u6 ~= "air" or not (u7 > 0) or not (os.clock() - u7 < 0.4) then
                    u6 = "air"
                    u7 = os.clock() - v22
                    tbl_upv_1.jump.TimePosition = v22
                end
            elseif v21 ~= u6 then
                if v21 == "air" then
                    u7 = -1
                end
                if v21 ~= "ground" and v21 ~= "sit" and u10 then
                    u10:Stop(0.2)
                    u10 = nil
                    if success_upv_1 then
                        u2.ResumeCharacterRotation("Emote")
                    end
                end
                u6 = v21
            end
        end
        if u6 == "ground" then
            v17 = math.clamp((Magnitude_1 - 0.6) / 2.5, 0, 1)
            if Humanoid_upv_1.MoveDirection.Magnitude < 0.05 then
                v17 = ((Magnitude_1 < 3) and 0) or v17
            end
            local v23 = math.clamp(((Magnitude_1 / v20) - 9) / 5, 0, 1)
            u4 = u4 + a1
            if u4 > 12 then
                u4 = 0
                local v24 = math.random() < 0.35
                u5 = v24
            end
            local v25 = (u5 and "idle2") or "idle"
            u11[v25] = 1 - v17
            u11.walk = v17 * (1 - v23)
            u11.run = v17 * v23
            local v26 = 1
            if Magnitude_1 > 1 then
                local _ = HumanoidRootPart_upv_1.CFrame.LookVector
                v26 = (v16.X * HumanoidRootPart_upv_1.CFrame.LookVector.X + v16.Z * HumanoidRootPart_upv_1.CFrame.LookVector.Z) / Magnitude_1 < -0.35 and -1 or v26
            end
            tbl_upv_5.walk = v26 * math.clamp(Magnitude_1 / (v20 * 7.5), 0.4, 1.8)
            tbl_upv_5.run = v26 * math.clamp(Magnitude_1 / (v20 * 16.5), 0.55, 1.7)
            if u10 and v17 > 0.1 and u10 then
                u10:Stop(0.2)
                u10 = nil
                if success_upv_1 then
                    u2.ResumeCharacterRotation("Emote")
                end
            end
        elseif u6 == "air" then
            local v27 = os.clock() - u7
            if u7 > 0 and v27 < 0.45 and v16.Y > -12 then
                u11.jump = 1
            else
                u11.fall = 1
            end
        elseif u6 == "climb" then
            u11.climb = 1
            tbl_upv_5.climb = math.abs(u8) > 0.1 and u8 / (v20 * 5) or 0
        elseif u6 == "swim" then
            local v29 = math.clamp((u9 - 1) / 3, 0, 1)
            u11.swim = v29
            u11.swimidle = 1 - v29
            tbl_upv_5.swim = math.clamp(u9 / 10, 0.6, 1.5)
        elseif u6 == "sit" then
            u11.sit = 1
        end
        v20 = 1 - math.exp(-14 * a1)
        local v30 = nil
        for key_5 in tbl_upv_1 do
            local v31 = u11[key_5] or 0
            v30 = tbl_upv_2[key_5] + (v31 - tbl_upv_2[key_5]) * v20
            if math.abs(v31 - v30) < 0.002 then
                v16 = v31
            else
                v16 = v30
            end
            if v16 < 0.001 then
                v30 = 1e-04
            else
                v30 = v16
            end
            tbl_upv_2[key_5] = v30
        end
        u14 = u14 + a1
        if not (u14 >= 0.05) and u6 == u15 then
            return
        end
        u14 = 0
        u15 = u6
        push()
    end
)
Humanoid_upv_1.Died:Connect(
    function()
        --[[
          line: 360
          upvalues:
            u13 (ref,  index: 1)
            u10 (ref,  index: 2)
            success_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        u13 = true
        if u10 then
            u10:Stop(0.2)
            u10 = nil
            if success_upv_1 then
                u2.ResumeCharacterRotation("Emote")
            end
        end
        for _, value_4 in tbl_upv_1 do
            value_4:Stop(0.3)
        end
    end
)