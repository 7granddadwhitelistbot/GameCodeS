local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local Characters = require(script.Parent:WaitForChild("Characters"))
local Perf = require(script.Parent:WaitForChild("Perf"))
local Quality = require(script.Parent:WaitForChild("Quality"))
local v6 = {}
local v7 = {}
local v8 = {}

local function rigFor(key)
    --[[
      name: rigFor
      line: 41
      upvalues:
        v7 (copy, index: 1)
        v8 (copy, index: 2)
    ]]
    local v11 = v7[key]

    if v11 and v11.root.Parent then
        return v11
    end

    local v12 = v8[key]

    if v12 and os.clock() - v12 < 1 then
        return nil
    end

    v8[key] = os.clock()
    local humanoid = key:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = key:FindFirstChild("HumanoidRootPart")
    local lowerTorso = key:FindFirstChild("LowerTorso")
    local upperTorso = key:FindFirstChild("UpperTorso")

    if not humanoid or not humanoidRootPart or not lowerTorso or not upperTorso or not humanoidRootPart:IsA("BasePart") then
        return nil
    end

    local root = lowerTorso:FindFirstChild("Root")
    local waist = upperTorso:FindFirstChild("Waist")

    local function isJoint(a20)
        --[[
          name: isJoint
          line: 61
        ]]
        return a20 ~= nil and (a20:IsA("Motor6D") or a20:IsA("AnimationConstraint"))
    end

    local isA = root ~= nil and (root:IsA("Motor6D") or root:IsA("AnimationConstraint"))
    if isA then
        local isA2 = waist ~= nil and (waist:IsA("Motor6D") or waist:IsA("AnimationConstraint"))
        if isA2 then
            local _, lastYaw = humanoidRootPart.CFrame:ToEulerAnglesYXZ()
            local v25 = {twist = 0, bank = 0, yawDt = 0, yawRate = 0, root = humanoidRootPart, humanoid = humanoid, rootJoint = root, waist = waist, lastYaw = lastYaw}
            v7[key] = v25
            v8[key] = nil

            return v25
        end
    end

    return nil
end

local v26 = {}
local v27 = {}

function v6.Track(key, value)
    --[[
      name: Track
      line: 90
      upvalues:
        v27 (copy, index: 1)
    ]]
    v27[key] = value
end

function v6.Untrack(key)
    --[[
      name: Untrack
      line: 94
      upvalues:
        v27 (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    v27[key] = nil
    v7[key] = nil
end

local function apply(key, a33, deltaTimeSim: number, a35, a36: boolean, a37: boolean)
    --[[
      name: apply
      line: 99
    ]]
    local root = a33.root
    local vector3 = Vector3.new(a35.X, 0, a35.Z)
    local magnitude = vector3.Magnitude
    local v41 = 0

    if a36 and 3 < magnitude and magnitude < 32 and not a37 then
        local objectSpaceVector = root.CFrame:VectorToObjectSpace(vector3 / magnitude)
        local v43 = math.atan2(-objectSpaceVector.X, -objectSpaceVector.Z)

        if 1.7453292519943295 < math.abs(v43) then
            v43 -= math.pi * math.sign(v43)
        end

        v41 = math.clamp(v43, -1.3089969389957472, 1.3089969389957472) * math.clamp((magnitude - 3) / 5, 0, 1)
    end

    a33.twist += ((v41 - a33.twist) * (1 - math.exp(deltaTimeSim * -10)))
    local _, lastYaw = root.CFrame:ToEulerAnglesYXZ()
    local v46 = ((lastYaw - a33.lastYaw) + math.pi) % math.tau - math.pi
    a33.lastYaw = lastYaw
    a33.yawDt += deltaTimeSim

    if not (1e-06 < math.abs(v46)) then
        if 0.05 < a33.yawDt then
            a33.yawRate = 0
        end
    else
        a33.yawRate = v46 / a33.yawDt
        a33.yawDt = 0
    end

    local yawRate = a33.yawRate
    local v48 = not a36 and 0 or math.clamp((-yawRate * magnitude) * 0.0022, -0.14, 0.14)
    a33.bank += ((v48 - a33.bank) * (1 - math.exp(deltaTimeSim * -8)))

    if 0.001 < math.abs(a33.twist) or 0.001 < math.abs(a33.bank) then
        a33.rootJoint.Transform = a33.rootJoint.Transform * CFrame.Angles(0, a33.twist, a33.bank)
        a33.waist.Transform = a33.waist.Transform * CFrame.Angles(0, -a33.twist * 0.9, -a33.bank * 0.5)
    end
end

local function step(deltaTimeSim: number)
    --[[
      name: step
      line: 140
      upvalues:
        workspace (copy, index: 1)
        v26 (copy, index: 2)
        Quality (copy, index: 3)
        Characters (copy, index: 4)
        rigFor (copy, index: 5)
        apply (copy, index: 6)
        v27 (copy, index: 7)
        v7 (copy, index: 8)
        v8 (copy, index: 9)
    ]]
    if deltaTimeSim <= 0 then
        return
    end

    local v52 = if const camera = workspace.CurrentCamera then camera.CFrame.Position else Vector3.new(0, 0, 0)
    table.clear(v26)
    local v53 = Quality.budget.twistRange * Quality.budget.twistRange

    local function near(a55)
        --[[
          name: near
          line: 148
          upvalues:
            v52 (copy, index: 1)
            v53 (copy, index: 2)
        ]]
        local v56 = a55.root.Position - v52

        if not (v53 < (v56.X * v56.X) + (v56.Y * v56.Y) + (v56.Z * v56.Z))
            and not (a55.humanoid.Health <= 0)
        then
            return true
        end

        a55.twist = 0
        a55.bank = 0

        return false
    end

    for _, key in Characters.List() do
        if const v59 = rigFor(key) then
            local v60
            v26[key] = true
            local v61 = v59.root.Position - v52

            if v53 < (v61.X * v61.X) + (v61.Y * v61.Y) + (v61.Z * v61.Z)
                or v59.humanoid.Health <= 0
            then
                v59.twist = 0
                v59.bank = 0
                v60 = false
            else
                v60 = true
            end

            if not v60 then
                continue
            end

            local state = v59.humanoid:GetState()
            local v63 = state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.RunningNoPhysics
            apply(key, v59, deltaTimeSim, v59.root.AssemblyLinearVelocity, v63, key:GetAttribute("Sliding") == true)
        end
    end

    for key, v65 in v27 do
        if key.Parent then
            local v66
            local v67 = rigFor(key)
            if not v67 then
                continue
            end

            v26[key] = true
            local v68 = v67.root.Position - v52

            if v53 < (v68.X * v68.X) + (v68.Y * v68.Y) + (v68.Z * v68.Z)
                or v67.humanoid.Health <= 0
            then
                v67.twist = 0
                v67.bank = 0
                v66 = false
            else
                v66 = true
            end

            if not v66 then
                continue
            end

            local success, result, v71, v72 = pcall(v65)
            if not success then
                continue
            end
            if typeof(result) ~= "Vector3" then
                continue
            end

            apply(key, v67, deltaTimeSim, result, v71 == true, v72 == true)
        end
    end

    for v73 in v7 do
        if not v26[v73] then
            v7[v73] = nil
        end
    end

    for v74 in v8 do
        if not v74.Parent then
            v8[v74] = nil
        end
    end
end

function v6.Start()
    --[[
      name: Start
      line: 198
      upvalues:
        runService (copy, index: 1)
        Perf (copy, index: 2)
        step (copy, index: 3)
    ]]
    runService.PreSimulation:Connect(
        function(deltaTimeSim: number)
            --[[
              line: 199
              upvalues:
                Perf (copy, index: 1)
                step (copy, index: 2)
            ]]
            local v76 = Perf.Begin()
            step(deltaTimeSim)
            Perf.End("Procedural", v76)
        end
    )
end

return v6