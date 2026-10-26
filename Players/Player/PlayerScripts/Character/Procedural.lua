local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Characters_upv_1 = require(script.Parent:WaitForChild("Characters"))
local Perf_upv_1 = require(script.Parent:WaitForChild("Perf"))
local Quality_upv_1 = require(script.Parent:WaitForChild("Quality"))
local tbl_1 = {}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
function tbl_1.Track(a1, a2)
    --[[
      name: Track
      line: 90
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5[a1] = a2
end
function tbl_1.Untrack(a1)
    --[[
      name: Untrack
      line: 94
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    tbl_upv_5[a1] = nil
    tbl_upv_2[a1] = nil
end
local function rigFor(a1)
    --[[
      name: rigFor
      line: 41
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local v1 = tbl_upv_2[a1]
    if v1 and v1.root.Parent then
        return v1
    end
    local v2 = tbl_upv_3[a1]
    if v2 and os.clock() - v2 < 1 then
        return nil
    end
    tbl_upv_3[a1] = os.clock()
    local v3 = a1:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart_1 = a1:FindFirstChild("HumanoidRootPart")
    local LowerTorso_1 = a1:FindFirstChild("LowerTorso")
    local UpperTorso_1 = a1:FindFirstChild("UpperTorso")
    if v3 and HumanoidRootPart_1 and LowerTorso_1 and UpperTorso_1 and HumanoidRootPart_1:IsA("BasePart") then
        local Root_1 = LowerTorso_1:FindFirstChild("Root")
        local Waist_1 = UpperTorso_1:FindFirstChild("Waist")
        local function isJoint_1(a2)
            --[[
              name: isJoint
              line: 61
            ]]
            local v4 = (a2 ~= nil) and (a2:IsA("Motor6D") or (a2:IsA("AnimationConstraint")))
            return v4
        end
        local v5 = (Root_1 ~= nil) and (Root_1:IsA("Motor6D") or (Root_1:IsA("AnimationConstraint")))
        if v5 then
            local v6 = (Waist_1 ~= nil) and (Waist_1:IsA("Motor6D") or (Waist_1:IsA("AnimationConstraint")))
            if v6 then
                local _, v7 = HumanoidRootPart_1.CFrame:ToEulerAnglesYXZ()
                local tbl_6 = {twist = 0, yawRate = 0, yawDt = 0, bank = 0}
                tbl_6.root = HumanoidRootPart_1
                tbl_6.humanoid = v3
                tbl_6.rootJoint = Root_1
                tbl_6.waist = Waist_1
                tbl_6.lastYaw = v7
                tbl_upv_2[a1] = tbl_6
                tbl_upv_3[a1] = nil
                return tbl_6
            end
        end
        return nil
    end
    return nil
end
local function apply(a1, a2, a3, a4, a5, a6)
    --[[
      name: apply
      line: 99
    ]]
    local root_1 = a2.root
    local v8 = Vector3.new(a4.X, 0, a4.Z)
    local Magnitude_1 = v8.Magnitude
    local v9 = 0
    if a5 and Magnitude_1 > 3 and Magnitude_1 < 32 and not (a6) then
        local v10 = root_1.CFrame:VectorToObjectSpace(v8 / Magnitude_1)
        local v11 = math.atan2(-v10.X, -v10.Z)
        local v12 = ((math.abs(v11) > 1.7453292519943295) and (v11 - math.pi * math.sign(v11))) or v11
        v9 = math.clamp(v12, -1.3089969389957472, 1.3089969389957472) * math.clamp((Magnitude_1 - 3) / 5, 0, 1)
    end
    a2.twist = a2.twist + ((v9 - a2.twist) * (1 - math.exp(a3 * -10)))
    local _, v13 = root_1.CFrame:ToEulerAnglesYXZ()
    local v14 = ((v13 - a2.lastYaw) + math.pi) % math.tau - math.pi
    a2.lastYaw = v13
    a2.yawDt = a2.yawDt + a3
    if math.abs(v14) > 1e-06 then
        a2.yawRate = v14 / a2.yawDt
        a2.yawDt = 0
    elseif a2.yawDt > 0.05 then
        a2.yawRate = 0
    end
    local v15 = ((not a5) and 0) or (math.clamp((-a2.yawRate * Magnitude_1) * 0.0022, -0.14, 0.14))
    a2.bank = a2.bank + ((v15 - a2.bank) * (1 - math.exp(a3 * -8)))
    if not (math.abs(a2.twist) > 0.001) and not (math.abs(a2.bank) > 0.001) then
        return
    end
    a2.rootJoint.Transform = a2.rootJoint.Transform * CFrame.Angles(0, a2.twist, a2.bank)
    a2.waist.Transform = a2.waist.Transform * CFrame.Angles(0, -a2.twist * 0.9, -a2.bank * 0.5)
end
local function step(a1)
    --[[
      name: step
      line: 140
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
        Quality_upv_1 (copy, index: 3)
        Characters_upv_1 (copy, index: 4)
        rigFor (copy, index: 5)
        apply (copy, index: 6)
        tbl_upv_5 (copy, index: 7)
        tbl_upv_2 (copy, index: 8)
        tbl_upv_3 (copy, index: 9)
    ]]
    if a1 <= 0 then
        return
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local u1 = ((not CurrentCamera_1) and Vector3.new(0, 0, 0)) or (CurrentCamera_1.CFrame.Position)
    table.clear(tbl_upv_4)
    local u2 = Quality_upv_1.budget.twistRange * Quality_upv_1.budget.twistRange
    local function near_1(a2)
        --[[
          name: near
          line: 148
          upvalues:
            u1 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        local v16 = a2.root.Position - u1
        if not (u2 < ((v16.X * v16.X) + (v16.Y * v16.Y)) + (v16.Z * v16.Z)) and not (a2.humanoid.Health <= 0) then
            return true
        end
        a2.twist = 0
        a2.bank = 0
        return false
    end
    local v17 = nil
    local v18 = nil
    for _, value_1 in Characters_upv_1.List() do
        local v19 = rigFor(value_1)
        if not (v19) then
            continue
        end
        tbl_upv_4[value_1] = true
        v17 = v19.root.Position - u1
        if u2 < ((v17.X * v17.X) + (v17.Y * v17.Y)) + (v17.Z * v17.Z) or v19.humanoid.Health <= 0 then
            v19.twist = 0
            v19.bank = 0
            v18 = false
            if not (v18) then
                continue
            end
            v18 = v19.humanoid:GetState()
            v17 = true
            if v18 ~= Enum.HumanoidStateType.Running then
                v17 = v18 == Enum.HumanoidStateType.RunningNoPhysics
            end
            local AssemblyLinearVelocity_1 = v19.root.AssemblyLinearVelocity
            local v20 = value_1:GetAttribute("Sliding") == true
            apply(value_1, v19, a1, AssemblyLinearVelocity_1, v17, v20)
        end
        v18 = true
        if not (v18) then
            continue
        end
        v18 = v19.humanoid:GetState()
        v17 = true
        if v18 ~= Enum.HumanoidStateType.Running then
            v17 = v18 == Enum.HumanoidStateType.RunningNoPhysics
        end
        local AssemblyLinearVelocity_1 = v19.root.AssemblyLinearVelocity
        local v20 = value_1:GetAttribute("Sliding") == true
        apply(value_1, v19, a1, AssemblyLinearVelocity_1, v17, v20)
    end
    local v21 = nil
    for key_1, value_2 in tbl_upv_5 do
        if not (key_1.Parent) then
            continue
        end
        local v22 = rigFor(key_1)
        if not (v22) then
            continue
        end
        tbl_upv_4[key_1] = true
        local v23 = v22.root.Position - u1
        if u2 < ((v23.X * v23.X) + (v23.Y * v23.Y)) + (v23.Z * v23.Z) or v22.humanoid.Health <= 0 then
            v22.twist = 0
            v22.bank = 0
            v21 = false
            if not (v21) then
                continue
            end
            local v21, v24, v25, v26 = pcall(value_2)
            if not (v21) then
                continue
            end
            if typeof(v24) == "Vector3" then
                apply(key_1, v22, a1, v24, v25 == true, v26 == true)
                continue
            end
        end
        v21 = true
        if not (v21) then
            continue
        end
        local v21, v24, v25, v26 = pcall(value_2)
        if not (v21) then
            continue
        end
        if typeof(v24) == "Vector3" then
            apply(key_1, v22, a1, v24, v25 == true, v26 == true)
        end
    end
    for key_2 in tbl_upv_2 do
        if not (tbl_upv_4[key_2]) then
            tbl_upv_2[key_2] = nil
        end
    end
    for key_3 in tbl_upv_3 do
        if not (key_3.Parent) then
            tbl_upv_3[key_3] = nil
        end
    end
end
function tbl_1.Start()
    --[[
      name: Start
      line: 198
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Perf_upv_1 (copy, index: 2)
        step (copy, index: 3)
    ]]
    RunService_upv_1.PreSimulation:Connect(
        function(a1)
            --[[
              line: 199
              upvalues:
                Perf_upv_1 (copy, index: 1)
                step (copy, index: 2)
            ]]
            local v27 = Perf_upv_1.Begin()
            step(a1)
            Perf_upv_1.End("Procedural", v27)
        end
    )
end
return tbl_1