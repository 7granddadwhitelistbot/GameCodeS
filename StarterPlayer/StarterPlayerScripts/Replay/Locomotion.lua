local _ = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local Parent_upv_1 = script.Parent.Parent
local AnimationIds_upv_1 = require(Parent_upv_1:WaitForChild("Character"):WaitForChild("AnimationIds"))
local tbl_upv_1 = {}
local u1 = nil
local u2 = nil
task.spawn(
    function()
        --[[
          line: 44
          upvalues:
            Parent_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            ReplicatedStorage_upv_1 (copy, index: 3)
            u2 (ref,  index: 4)
        ]]
        local success_1, v1 = pcall(
            function()
                --[[
                  line: 45
                  upvalues:
                    Parent_upv_1 (copy, index: 1)
                ]]
                return require(Parent_upv_1:WaitForChild("Character"):WaitForChild("Footsteps", 10))
            end
        )
        if success_1 and type(v1) == "table" then
            u1 = v1
        end
        local success_2, v2 = pcall(
            function()
                --[[
                  line: 51
                  upvalues:
                    ReplicatedStorage_upv_1 (copy, index: 1)
                ]]
                return require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Sfx", 10))
            end
        )
        if not success_2 or type(v2) ~= "table" then
            return
        end
        u2 = v2
    end
)
local function load(a1, a2, a3, a4)
    --[[
      name: load
      line: 59
    ]]
    if a2 and a2 ~= "" then
        local u3 = Instance.new("Animation")
        u3.Name = a4
        u3.AnimationId = a2
        local success_3, v3 = pcall(
            function()
                --[[
                  line: 66
                  upvalues:
                    a1 (copy, index: 1)
                    u3 (copy, index: 2)
                ]]
                return a1:LoadAnimation(u3)
            end
        )
        if success_3 and v3 then
            v3.Priority = a3
            v3.Looped = true
            return v3
        end
        return nil
    end
    return nil
end
function tbl_upv_1.new(a1, a2, a3)
    --[[
      name: new
      line: 77
      upvalues:
        AnimationIds_upv_1 (copy, index: 1)
        load (copy, index: 2)
    ]]
    local v4
    if a1.RigType ~= Enum.HumanoidRigType.R6 then
        v4 = AnimationIds_upv_1.R15
    else
        v4 = AnimationIds_upv_1.R6
    end
    local tbl_2 = {sliding = false, lastVy = 0, leftFoot = false, active = false, airTime = 0, jumpAt = -1, stepDist = 0, groundedAt = 0}
    tbl_2.hum = a1
    tbl_2.root = a2
    tbl_2.tracks = {}
    tbl_2.weights = {}
    tbl_2.targets = {}
    for _, value_1 in {"idle", "walk", "run", "jump", "fall"} do
        local v5 = load(a3, v4[value_1], Enum.AnimationPriority.Core, value_1)
        if v5 then
            tbl_2.tracks[value_1] = v5
            tbl_2.weights[value_1] = 0
        end
    end
    tbl_2.legs = load(a3, AnimationIds_upv_1.SlideLegs, Enum.AnimationPriority.Action2, "SlideLegs") or load(a3, AnimationIds_upv_1.SlideFallback, Enum.AnimationPriority.Movement, "SlideFallback")
    tbl_2.upper = load(a3, AnimationIds_upv_1.SlideUpper, Enum.AnimationPriority.Movement, "SlideUpper")
    return tbl_2
end
function tbl_upv_1.Stop(a1)
    --[[
      name: Stop
      line: 110
    ]]
    for key_1, value_2 in a1.tracks do
        value_2:Stop(0.2)
        a1.weights[key_1] = 0
    end
    if a1.legs then
        a1.legs:Stop(0.15)
    end
    if a1.upper then
        a1.upper:Stop(0.15)
    end
    a1.sliding = false
    a1.active = false
end
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Include
u4.IgnoreWater = true
function tbl_upv_1.SetGround(a1)
    --[[
      name: SetGround
      line: 130
      upvalues:
        u4 (copy, index: 1)
    ]]
    u4.FilterDescendantsInstances = a1
end
local function footstep(a1, a2)
    --[[
      name: footstep
      line: 134
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        Workspace_upv_1 (copy, index: 3)
        u4 (copy, index: 4)
    ]]
    if not u1 then
        return
    end
    if u2 then
        local root_1 = a1.root
        local hum_1 = a1.hum
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        if CurrentCamera_1 and (CurrentCamera_1.CFrame.Position - root_1.Position).Magnitude > 90 then
            return
        end
        local u5 = Workspace_upv_1:Raycast(root_1.Position, Vector3.new(0, -((hum_1.HipHeight + (root_1.Size.Y / 2)) + 1.5), 0), u4)
        if not u5 then
            return
        end
        local success_4, v7 = pcall(
            function()
                --[[
                  line: 148
                  upvalues:
                    u1 (ref,  index: 1)
                    u5 (copy, index: 2)
                ]]
                return u1.StepSoundName(u1.SurfaceFor(u5.Material))
            end
        )
        if success_4 and type(v7) == "string" then
            a1.leftFoot = not a1.leftFoot
            local RightVector_1 = root_1.CFrame.RightVector
            local v8 = ((a1.leftFoot) and -0.5) or 0.5
            local Play_1 = u2.Play
            local tbl_3 = {volume = 0}
            tbl_3.volume = ((a2 > 23) and 1) or 0.8
            pcall(Play_1, "Character/" .. v7, u5.Position + (RightVector_1 * v8), tbl_3)
            return
        end
    end
end
function tbl_upv_1.Step(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: Step
      line: 160
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u2 (ref,  index: 2)
        Workspace_upv_1 (copy, index: 3)
        footstep (copy, index: 4)
    ]]
    local v9 = nil
    if a7 then
        a1.active = true
        local hum_2 = a1.hum
        local root_2 = a1.root
        local targets_1 = a1.targets
        for key_2 in a1.tracks do
            targets_1[key_2] = 0
        end
        local Magnitude_1 = Vector3.new(a4.X, 0, a4.Z).Magnitude
        local v10 = math.max(0.5, hum_2.HipHeight / 2)
        if a5 then
            a1.groundedAt = a3
        elseif a4.Y > 8 and a3 - a1.groundedAt < 0.25 then
            a1.jumpAt = a3
        end
        if a5 or a3 - a1.groundedAt < 0.1 then
            local LookVector_1 = math.clamp((Magnitude_1 - 0.6) / 2.5, 0, 1)
            local v11 = math.clamp(((Magnitude_1 / v10) - 9) / 5, 0, 1)
            targets_1.idle = 1 - LookVector_1
            targets_1.walk = LookVector_1 * (1 - v11)
            targets_1.run = LookVector_1 * v11
            v11 = 1
            if Magnitude_1 > 1 then
                LookVector_1 = root_2.CFrame.LookVector
                v11 = (a4.X * root_2.CFrame.LookVector.X + a4.Z * root_2.CFrame.LookVector.Z) / Magnitude_1 < -0.35 and -1 or v11
            end
            v9 = a1.tracks.walk
            local run_1 = a1.tracks.run
            if v9 then
                v9:AdjustSpeed(v11 * math.clamp(Magnitude_1 / (v10 * 7.5), 0.4, 1.8))
            end
            if run_1 then
                run_1:AdjustSpeed(v11 * math.clamp(Magnitude_1 / (v10 * 16.5), 0.55, 1.7))
            end
        elseif a1.jumpAt > 0 and a3 - a1.jumpAt < 0.45 and a4.Y > -12 then
            targets_1.jump = 1
        else
            targets_1.fall = 1
        end
        v10 = 1 - math.exp(a2 * -14)
        for key_3, value_3 in a1.tracks do
            local v12 = a1.weights[key_3] + ((targets_1[key_3] or 0) - a1.weights[key_3]) * v10
            v12 = ((v12 < 0.001) and 1e-04) or v12
            a1.weights[key_3] = v12
            if value_3.IsPlaying then
                value_3:AdjustWeight(v12, 0)
            else
                value_3:Play(0, v12, value_3.Speed)
            end
        end
        if a6 ~= a1.sliding then
            a1.sliding = a6
            if a6 then
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
        if a5 then
            if a1.airTime > 0.35 and a1.lastVy < -30 then
                v10 = -a1.lastVy
                if v10 > 72 then
                    local v13 = nil
                    if u2 then
                        v13 = Workspace_upv_1.CurrentCamera
                        local v14 = root_2.Position - Vector3.new(0, hum_2.HipHeight + (root_2.Size.Y / 2), 0)
                        if not (v13) or (v13.CFrame.Position - v14).Magnitude <= 90 then
                            local v15 = math.clamp((v10 - 64) / 60, 0, 1)
                            pcall(u2.Play, ((v15 > 0.5) and "Character/LandHeavy") or "Character/Land", v14, {volume = (v15 * 0.6) + 0.35})
                        end
                    else
                        footstep(a1, 16)
                    end
                else
                    footstep(a1, 16)
                end
            end
            a1.airTime = 0
        else
            a1.airTime = a1.airTime + a2
            a1.lastVy = a4.Y
        end
        local Position_1 = root_2.Position
        if a5 and Magnitude_1 > 2 then
            local v16, v17 = nil, nil
            if a6 then
                a1.stepDist = math.min(a1.stepDist, 2.34)
            else
                v16 = a1.lastPos
                if v16 then
                    v17 = Vector3.new(Position_1.X - v16.X, 0, Position_1.Z - v16.Z).Magnitude
                    if v17 < 10 then
                        a1.stepDist = a1.stepDist + v17
                    end
                end
                if (((Magnitude_1 > 15) and 5.2) or 3.9) <= a1.stepDist then
                    a1.stepDist = 0
                    footstep(a1, Magnitude_1)
                end
            end
        else
            a1.stepDist = math.min(a1.stepDist, 2.34)
        end
        a1.lastPos = Position_1
    elseif a1.active then
        tbl_upv_1.Stop(a1)
    end
end
return tbl_upv_1