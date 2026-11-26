local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local Combat = require(shared:WaitForChild("Combat"))
local v5 = {}
local parent = script.Parent.Parent
local number = 5
local number2 = 7
local number3 = 21
local number4 = 8
local number5 = 0.03
local number6 = 0.002617993877991494
local camera = shared:FindFirstChild("Camera")
local firstPerson = camera and camera:FindFirstChild("FirstPerson")

if firstPerson and firstPerson:IsA("ModuleScript") then
    local success, result = pcall(require, firstPerson)

    if success and type(result) == "table" then
        number = tonumber(result.EYE_EASE) or number
        number2 = tonumber(result.STRIDE) or number2
        number3 = tonumber(result.BOB_SPEED) or number3
        number4 = tonumber(result.BOB_EASE) or number4
        number5 = tonumber(result.CAM_BOB_Y) or number5
        number6 = tonumber(result.CAM_BOB_ROLL) or number6
    end
end

local result = nil

local function viewModel()
    --[[
      name: viewModel
      line: 53
      upvalues:
        result (ref,  index: 1)
        parent (copy, index: 2)
    ]]
    if result == nil then
        result = false
        local instance = parent:FindFirstChild("Character")
        instance = instance and instance:FindFirstChild("ViewModel")

        if instance and instance:IsA("ModuleScript") then
            local success, result2 = pcall(require, instance)

            if success and type(result2) == "table" and type(result2.SetExternal) == "function" then
                result = result2
            end
        end
    end

    return result or nil
end

local v22 = {active = false, params = nil, eyeOff = nil, phase = 0, amount = 0, speed = 0, lastPos = nil, hiddenModel = nil, hiddenItem = nil, lastBlock = false}
local v23 = {valid = false, yaw = 0, pitch = 0, fov = 70, first = false, aimCam = false, eye = nil, bobY = 0, bobRoll = 0}
local v24 = {dt = 0, visible = false, id = nil, kind = nil, charges = nil, grounded = true, rootY = 0, sliding = false, aiming = false, bobPhase = 0, bobAmount = 0, wall = nil}

function v5.Begin(params)
    --[[
      name: Begin
      line: 122
      upvalues:
        v5 (copy, index: 1)
        v22 (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    v5.End()
    v22.active = true
    v22.params = params
    v22.eyeOff = nil
    v22.phase = 0
    v22.amount = 0
    v22.speed = 0
    v22.lastPos = nil
    v22.lastBlock = false

    if const v26 = viewModel() then
        pcall(v26.SetExternal, true)
    end
end

local function setHidden(a28, a29: boolean)
    --[[
      name: setHidden
      line: 135
    ]]
    if not a28 then
        return
    end

    for _, descendant in a28:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.LocalTransparencyModifier = a29 and 1 or 0
        end
    end
end

function v5.End()
    --[[
      name: End
      line: 146
      upvalues:
        v22 (copy, index: 1)
        setHidden (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    if not v22.active then
        return
    end

    v22.active = false
    setHidden(v22.hiddenModel, false)
    v22.hiddenModel = nil

    if const v32 = viewModel() then
        pcall(v32.SetExternal, false)
    end
end

local function event(a34, a35)
    --[[
      name: event
      line: 159
      upvalues:
        viewModel (copy, index: 1)
        v22 (copy, index: 2)
    ]]
    local v36 = viewModel()

    if v36 and v22.active then
        pcall(v36.ExternalEvent, a34, a35)
    end
end

function v5.OnFighterEvent(a37, a38, charge)
    --[[
      name: OnFighterEvent
      line: 168
      upvalues:
        v22 (copy, index: 1)
        Combat (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    local weaponId
    local v41

    if not v22.active then
        return
    end

    if type(a38.weaponId) ~= "string" then
        weaponId = nil
    else
        weaponId = a38.weaponId
    end

    local v42 = Combat.Kind(weaponId)
    local success, result = pcall(Combat.Tuning, weaponId)

    if not success or type(result) ~= "table" then
        v41 = {}
    else
        v41 = result
    end

    if a37 == "Swing" then
        local time
        local v46, v47 = false, false

        if a38.heavy ~= true then
            if a38.lunge ~= true then
                local number = tonumber(a38.step) or 1
                local v49 = {step = number, finisher = 3 <= number}
                local v50 = viewModel()

                if v50 and v22.active then
                    pcall(v50.ExternalEvent, "Swing", v49)
                    return
                end
            else
                local lunge = v41.lunge

                if type(lunge) ~= "table" then
                    v46 = true
                elseif type(lunge.distance) ~= "number" then
                    v46 = true
                elseif type(lunge.speed) ~= "number" then
                    v46 = true
                elseif not (0 < lunge.speed) then
                    v46 = true
                else
                    time = lunge.distance / lunge.speed
                    v47 = true
                end
            end
        else
            local v52 = {}
            local v53 = viewModel()

            if v53 and v22.active then
                pcall(v53.ExternalEvent, "Heavy", v52)
                return
            end
        end

        if v46 then
            time = 0.25
            v47 = true
        end

        if v47 then
            local v54 = {time = time}
            local v55 = viewModel()

            if v55 and v22.active then
                pcall(v55.ExternalEvent, "Lunge", v54)
            end
        end
    elseif a37 == "Charge" then
        local text = tostring(a38.kind)
        local on = a38.on == true

        if text == "Draw" then
            local v58 = {on = on, time = v41.drawTime or 1}
            local v59 = viewModel()

            if v59 and v22.active then
                pcall(v59.ExternalEvent, "Draw", v58)
            end
        elseif text == "Throw" then
            local v60 = {on = on, time = v41.drawTime or 0.5}
            local v61 = viewModel()

            if v61 and v22.active then
                pcall(v61.ExternalEvent, "Windup", v60)
            end
        else
            local charge2

            if text ~= "Heavy" and text ~= "Lunge" then
                return
            end

            local v63 = if text == "Heavy" then v41.heavy else v41.lunge
            local v64 = {kind = text, on = on}

            if type(v63) ~= "table" then
                charge2 = 0.6
            else
                charge2 = v63.charge or 0.6
            end

            v64.time = charge2
            local v65 = viewModel()

            if v65 and v22.active then
                pcall(v65.ExternalEvent, "Charge", v64)
            end
        end
    elseif a37 == "Projectile" then
        if v42 ~= "Bow" then
            if Combat.UsesAmmo(v42) then
                local v66 = {aimed = false, kick = v41.kick or 2}
                local v67 = viewModel()

                if v67 and v22.active then
                    pcall(v67.ExternalEvent, "Fire", v66)
                end
            else
                local v68 = {charge = charge}
                local v69 = viewModel()

                if v69 and v22.active then
                    pcall(v69.ExternalEvent, "Throw", v68)
                end
            end
        else
            local v70 = {charge = charge}
            local v71 = viewModel()

            if v71 and v22.active then
                pcall(v71.ExternalEvent, "Release", v70)
            end
        end
    elseif a37 == "Reload" then
        local v72 = {}
        local v73 = tonumber(a38.duration) or v41.reloadTime or 1.2
        v72.time = v73
        local v74 = viewModel()

        if v74 and v22.active then
            pcall(v74.ExternalEvent, "Reload", v72)
        end
    elseif a37 == "Use" then
        if typeof(a38.position) ~= "Vector3" then
            local v75 = {on = true}
            local v76 = tonumber(a38.duration) or v41.useTime or 1
            v75.time = v76
            local v77 = viewModel()

            if v77 and v22.active then
                pcall(v77.ExternalEvent, "Use", v75)
            end
        else
            local v78 = {}
            local v79 = viewModel()

            if v79 and v22.active then
                pcall(v79.ExternalEvent, "Place", v78)
            end
        end
    elseif a37 == "Heal" then
        local v80 = {on = false, done = true}
        local v81 = viewModel()

        if v81 and v22.active then
            pcall(v81.ExternalEvent, "Use", v80)
        end
    end
end

function v5.Hurt(amount, blocked)
    --[[
      name: Hurt
      line: 219
      upvalues:
        viewModel (copy, index: 1)
        v22 (copy, index: 2)
    ]]
    local v84 = {amount = amount, blocked = blocked}
    local v85 = viewModel()

    if v85 and v22.active then
        pcall(v85.ExternalEvent, "Hurt", v84)
    end
end

function v5.Frame(a86, a87, a88, a89)
    --[[
      name: Frame
      line: 225
      upvalues:
        v23 (copy, index: 1)
        v22 (copy, index: 2)
        number3 (ref,  index: 3)
        number4 (ref,  index: 4)
        number2 (ref,  index: 5)
        number (ref,  index: 6)
        number5 (ref,  index: 7)
        number6 (ref,  index: 8)
    ]]
    local clampedValue
    v23.valid = v22.active and a87.present and a87.view and a89
    v23.yaw, v23.pitch, v23.fov = a87.viewYaw, a87.viewPitch, a87.fov
    v23.first = a87.first == true
    v23.aimCam = a87.aimCam == true
    v23.eye = nil
    v23.bobY = 0
    v23.bobRoll = 0

    if not a87.present then
        v22.lastPos = nil
        return v23
    end

    local position = a87.cf.Position
    local v92 = bit32.btest(a87.flags, 2)
    local v93 = bit32.btest(a87.flags, 4)
    local v94 = 0
    local lastPos = v22.lastPos

    if lastPos and 0 < a86 then
        local v96 = position - lastPos
        v94 = Vector3.new(v96.X, 0, v96.Z).Magnitude / a86

        if 80 < v94 then
            v94 = 0
        end
    end

    v22.lastPos = position
    v22.speed += ((v94 - v22.speed) * (1 - math.exp(a86 * -12)))

    if not v92 or v93 then
        clampedValue = 0
    else
        clampedValue = math.clamp((v22.speed - 1) / (number3 - 1), 0, 1.25)
    end

    v22.amount += ((clampedValue - v22.amount) * (1 - math.exp(-number4 * a86)))

    if v92 then
        v22.phase = (v22.phase + (((v94 * a86 / number2) * 2) * math.pi)) % 12.566370614359172
    end

    if not v23.valid or not v23.first then
        v22.eyeOff = nil
    else
        local head = a88 and a88:FindFirstChild("Head")
        local v98 = if head and head:IsA("BasePart") then head.Position.Y - position.Y else 1.5
        local v99 = v98 + 0.25
        local eyeOff = v22.eyeOff
        local y = if eyeOff == nil then v99 else eyeOff + (v99 - eyeOff) * (1 - math.exp(-number * a86))
        v22.eyeOff = y
        local vector3 = Vector3.new(-math.sin(v23.yaw), 0, -math.cos(v23.yaw))
        v23.eye = position + Vector3.new(0, y, 0) - (vector3 * 0.3)

        if a87.bobbing and 0 < v22.amount then
            v23.bobY = (-math.cos(v22.phase * 2) * 0.5) * number5 * v22.amount
            v23.bobRoll = math.sin(v22.phase) * number6 * v22.amount
        end
    end

    return v23
end

function v5.AfterCamera(dt, a104, a105, a106, a107, a108, charges)
    --[[
      name: AfterCamera
      line: 278
      upvalues:
        v22 (copy, index: 1)
        setHidden (copy, index: 2)
        viewModel (copy, index: 3)
        workspace (copy, index: 4)
        v24 (copy, index: 5)
        Combat (copy, index: 6)
    ]]
    local v110

    if not v22.active then
        return
    end

    local present = a107 and a106 and a104.present
    local hiddenModel = if present then a105 else nil

    if hiddenModel ~= v22.hiddenModel or hiddenModel and a108 ~= v22.hiddenItem then
        if v22.hiddenModel ~= hiddenModel then
            setHidden(v22.hiddenModel, false)
        end

        setHidden(hiddenModel, true)
        v22.hiddenModel = hiddenModel
        v22.hiddenItem = a108
    end

    local v113 = bit32.btest(a104.flags, 8)

    if v113 ~= v22.lastBlock then
        v22.lastBlock = v113
        local v114 = {on = v113}
        local v115 = viewModel()

        if v115 and v22.active then
            pcall(v115.ExternalEvent, "Block", v114)
        end
    end

    local v116 = viewModel()
    if not v116 then
        return
    end

    local camera = workspace.CurrentCamera
    local v118 = nil

    if present then
        if camera then
            if v22.params then
                v110 = if const raycastResult = workspace:Spherecast(camera.CFrame.Position, 0.15, camera.CFrame.LookVector * 1.8, v22.params) then raycastResult.Distance else nil
            else
                v110 = v118
            end
        else
            v110 = v118
        end
    else
        v110 = v118
    end

    v24.dt = dt
    v24.visible = present
    v24.id = a108
    v24.kind = if a108 then Combat.Kind(a108) else nil
    v24.charges = charges
    v24.grounded = bit32.btest(a104.flags, 2)
    v24.rootY = a104.cf.Position.Y
    v24.sliding = bit32.btest(a104.flags, 4)
    v24.aiming = a104.aimCam == true
    v24.bobPhase = v22.phase
    v24.bobAmount = v22.amount
    v24.wall = v110
    pcall(v116.ExternalFrame, v24)
end

return v5