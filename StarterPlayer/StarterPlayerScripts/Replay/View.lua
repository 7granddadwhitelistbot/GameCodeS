local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Combat_upv_1 = require(Shared_1:WaitForChild("Combat"))
local tbl_upv_1 = {}
local Parent_upv_1 = script.Parent.Parent
local u1 = 5
local u2 = 7
local u3 = 21
local u4 = 8
local u5 = 0.03
local u6 = 0.002617993877991494
local Camera_1 = Shared_1:FindFirstChild("Camera")
local v1 = Camera_1 and (Camera_1:FindFirstChild("FirstPerson"))
if v1 then
    local v2 = v1:IsA("ModuleScript")
    if v2 then
        local success_1, v3 = pcall(require, v1)
        if success_1 and type(v3) == "table" then
            u1 = tonumber(v3.EYE_EASE) or u1
            u2 = tonumber(v3.STRIDE) or u2
            u3 = tonumber(v3.BOB_SPEED) or u3
            u4 = tonumber(v3.BOB_EASE) or u4
            u5 = tonumber(v3.CAM_BOB_Y) or u5
            u6 = tonumber(v3.CAM_BOB_ROLL) or u6
        end
    end
end
local u7 = nil
local function viewModel()
    --[[
      name: viewModel
      line: 53
      upvalues:
        u7 (ref,  index: 1)
        Parent_upv_1 (copy, index: 2)
    ]]
    if u7 == nil then
        u7 = false
        local Character_1 = Parent_upv_1:FindFirstChild("Character")
        local v4 = Character_1 and (Character_1:FindFirstChild("ViewModel"))
        if v4 and v4:IsA("ModuleScript") then
            local success_2, v5 = pcall(require, v4)
            if success_2 and type(v5) == "table" and type(v5.SetExternal) == "function" then
                u7 = v5
            end
        end
    end
    return u7 or nil
end
local tbl_upv_2 = {active = false, phase = 0, lastBlock = false, amount = 0, speed = 0}
local tbl_upv_3 = {valid = false, first = false, bobY = 0, bobRoll = 0, yaw = 0, aimCam = false, fov = 70, pitch = 0}
local tbl_upv_4 = {visible = false, bobAmount = 0, rootY = 0, grounded = true, dt = 0, sliding = false, aiming = false, bobPhase = 0}
function tbl_upv_1.Begin(a1)
    --[[
      name: Begin
      line: 122
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    tbl_upv_1.End()
    tbl_upv_2.active = true
    tbl_upv_2.params = a1
    tbl_upv_2.eyeOff = nil
    tbl_upv_2.phase = 0
    tbl_upv_2.amount = 0
    tbl_upv_2.speed = 0
    tbl_upv_2.lastPos = nil
    tbl_upv_2.lastBlock = false
    local v6 = viewModel()
    if not v6 then
        return
    end
    pcall(v6.SetExternal, true)
end
local function setHidden(a1, a2)
    --[[
      name: setHidden
      line: 135
    ]]
    if not a1 then
        return
    end
    for _, value_1 in a1:GetDescendants() do
        if value_1:IsA("BasePart") or value_1:IsA("Decal") then
            value_1.LocalTransparencyModifier = (a2 and 1) or 0
        end
    end
end
function tbl_upv_1.End()
    --[[
      name: End
      line: 146
      upvalues:
        tbl_upv_2 (copy, index: 1)
        setHidden (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    if not tbl_upv_2.active then
        return
    end
    tbl_upv_2.active = false
    setHidden(tbl_upv_2.hiddenModel, false)
    tbl_upv_2.hiddenModel = nil
    local v7 = viewModel()
    if not v7 then
        return
    end
    pcall(v7.SetExternal, false)
end
local function event(a1, a2)
    --[[
      name: event
      line: 159
      upvalues:
        viewModel (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v8 = viewModel()
    if not v8 or not tbl_upv_2.active then
        return
    end
    pcall(v8.ExternalEvent, a1, a2)
end
function tbl_upv_1.OnFighterEvent(a1, a2, a3)
    --[[
      name: OnFighterEvent
      line: 168
      upvalues:
        tbl_upv_2 (copy, index: 1)
        Combat_upv_1 (copy, index: 2)
        viewModel (copy, index: 3)
    ]]
    if not tbl_upv_2.active then
        return
    end
    local v9
    if type(a2.weaponId) ~= "string" then
        v9 = nil
    else
        v9 = a2.weaponId
    end
    local v10 = Combat_upv_1.Kind(v9)
    local success_3, v11 = pcall(Combat_upv_1.Tuning, v9)
    if (success_3) and type(v11) == "table" then
        v9 = v11
    else
        v9 = {}
    end
    if a1 == "Swing" then
        local v12 = nil
        if a2.heavy ~= true then
            local v13, v14, v15 = nil, nil, nil
            if a2.lunge ~= true then
                local v16 = tonumber(a2.step) or 1
                local tbl_6 = {finisher = 0}
                tbl_6.step = v16
                tbl_6.finisher = v16 >= 3
                v13 = viewModel()
                if v13 and tbl_upv_2.active then
                    pcall(v13.ExternalEvent, "Swing", tbl_6)
                end
            else
                v14 = v9.lunge
                local tbl_7
                if type(v14) == "table" and type(v14.distance) == "number" and type(v14.speed) == "number" and v14.speed > 0 then
                    tbl_7 = v14.distance / v14.speed
                else
                    tbl_7 = 0.25
                end
                local tbl_8 = {}
                tbl_8.time = tbl_7
                v15 = viewModel()
                if v15 and tbl_upv_2.active then
                    pcall(v15.ExternalEvent, "Lunge", tbl_8)
                end
            end
        else
            local tbl_7 = {}
            v12 = viewModel()
            if v12 and tbl_upv_2.active then
                pcall(v12.ExternalEvent, "Heavy", tbl_7)
            end
        end
    elseif a1 == "Charge" then
        local str_1 = tostring(a2.kind)
        local v17 = a2.on == true
        local v18 = nil
        if str_1 ~= "Draw" then
            local v19, v20 = nil, nil
            if str_1 == "Throw" then
                local tbl_9 = {}
                tbl_9.on = v17
                tbl_9.time = v9.drawTime or 0.5
                v20 = viewModel()
                if v20 and tbl_upv_2.active then
                    pcall(v20.ExternalEvent, "Windup", tbl_9)
                end
            elseif str_1 == "Heavy" or str_1 == "Lunge" then
                local v13
                if str_1 ~= "Heavy" then
                    v13 = v9.lunge
                else
                    v13 = v9.heavy
                end
                local tbl_10 = {time = 0}
                tbl_10.kind = str_1
                tbl_10.on = v17
                if type(v13) ~= "table" then
                    v19 = 0.6
                else
                    v19 = v13.charge or 0.6
                end
                tbl_10.time = v19
                v19 = viewModel()
                if v19 and tbl_upv_2.active then
                    pcall(v19.ExternalEvent, "Charge", tbl_10)
                end
            end
        else
            local tbl_11 = {}
            tbl_11.on = v17
            tbl_11.time = v9.drawTime or 1
            v18 = viewModel()
            if v18 and tbl_upv_2.active then
                pcall(v18.ExternalEvent, "Draw", tbl_11)
            end
        end
    elseif a1 ~= "Projectile" then
        local v21 = nil
        if a1 == "Reload" then
            local tbl_12 = {time = 0}
            tbl_12.time = tonumber(a2.duration) or v9.reloadTime or 1.2
            v21 = viewModel()
            if v21 and tbl_upv_2.active then
                pcall(v21.ExternalEvent, "Reload", tbl_12)
            end
        elseif a1 == "Use" then
            local v23, v24 = nil, nil
            if typeof(a2.position) ~= "Vector3" then
                local tbl_13 = {on = true, time = 0}
                tbl_13.time = tonumber(a2.duration) or v9.useTime or 1
                v23 = viewModel()
                if v23 and tbl_upv_2.active then
                    pcall(v23.ExternalEvent, "Use", tbl_13)
                end
            else
                local tbl_14 = {}
                v24 = viewModel()
                if v24 and tbl_upv_2.active then
                    pcall(v24.ExternalEvent, "Place", tbl_14)
                end
            end
        elseif a1 == "Heal" then
            local tbl_15 = {on = false, done = true}
            local v26 = viewModel()
            if v26 and tbl_upv_2.active then
                pcall(v26.ExternalEvent, "Use", tbl_15)
            end
        end
    else
        local v27 = nil
        if v10 ~= "Bow" then
            local v28, v29 = nil, nil
            if Combat_upv_1.UsesAmmo(v10) then
                local tbl_16 = {aimed = false}
                tbl_16.kick = v9.kick or 2
                v28 = viewModel()
                if v28 and tbl_upv_2.active then
                    pcall(v28.ExternalEvent, "Fire", tbl_16)
                end
            else
                local tbl_17 = {}
                tbl_17.charge = a3
                v29 = viewModel()
                if v29 and tbl_upv_2.active then
                    pcall(v29.ExternalEvent, "Throw", tbl_17)
                end
            end
        else
            local tbl_18 = {}
            tbl_18.charge = a3
            v27 = viewModel()
            if v27 and tbl_upv_2.active then
                pcall(v27.ExternalEvent, "Release", tbl_18)
            end
        end
    end
end
function tbl_upv_1.Hurt(a1, a2)
    --[[
      name: Hurt
      line: 219
      upvalues:
        viewModel (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local tbl_19 = {}
    tbl_19.amount = a1
    tbl_19.blocked = a2
    local v30 = viewModel()
    if not v30 or not tbl_upv_2.active then
        return
    end
    pcall(v30.ExternalEvent, "Hurt", tbl_19)
end
function tbl_upv_1.Frame(a1, a2, a3, a4)
    --[[
      name: Frame
      line: 225
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        u3 (ref,  index: 3)
        u4 (ref,  index: 4)
        u2 (ref,  index: 5)
        u1 (ref,  index: 6)
        u5 (ref,  index: 7)
        u6 (ref,  index: 8)
    ]]
    local v31 = tbl_upv_2.active
    local v32 = nil
    if v31 then
        v32 = a2.present
        local v33 = nil
        if v32 then
            v33 = a2.view
            if v33 then
                v31 = a4
            else
                v31 = v33
            end
        else
            v31 = v32
        end
    end
    tbl_upv_3.valid = v31
    tbl_upv_3.yaw = a2.viewYaw
    tbl_upv_3.pitch = a2.viewPitch
    tbl_upv_3.fov = a2.fov
    tbl_upv_3.first = a2.first == true
    tbl_upv_3.aimCam = a2.aimCam == true
    tbl_upv_3.eye = nil
    tbl_upv_3.bobY = 0
    tbl_upv_3.bobRoll = 0
    if a2.present then
        local Position_1 = a2.cf.Position
        v31 = bit32.btest(a2.flags, 2)
        local v34 = bit32.btest(a2.flags, 4)
        local v35 = 0
        local v36 = tbl_upv_2.lastPos
        if v36 and a1 > 0 then
            local _ = Position_1 - v36
            v35 = Vector3.new((Position_1 - v36).X, 0, (Position_1 - v36).Z).Magnitude / a1
            v35 = ((v35 > 80) and 0) or v35
        end
        tbl_upv_2.lastPos = Position_1
        tbl_upv_2.speed = tbl_upv_2.speed + ((v35 - tbl_upv_2.speed) * (1 - math.exp(a1 * -12)))
        if not (v31) or v34 then
            v36 = 0
        else
            v36 = math.clamp((tbl_upv_2.speed - 1) / (u3 - 1), 0, 1.25)
        end
        tbl_upv_2.amount = tbl_upv_2.amount + ((v36 - tbl_upv_2.amount) * (1 - math.exp(-u4 * a1)))
        if v31 then
            tbl_upv_2.phase = (tbl_upv_2.phase + ((((v35 * a1) / u2) * 2) * math.pi)) % 12.566370614359172
        end
        if tbl_upv_3.valid and tbl_upv_3.first then
            v36 = a3 and (a3:FindFirstChild("Head"))
            local v37
            if (v36) and (v36:IsA("BasePart")) then
                v37 = v36.Position.Y - Position_1.Y
            else
                v37 = 1.5
            end
            v35 = v37 + 0.25
            v36 = tbl_upv_2.eyeOff
            if v36 ~= nil then
                v36 = v36 + (v35 - v36) * (1 - math.exp(-u1 * a1))
            else
                v36 = v35
            end
            tbl_upv_2.eyeOff = v36
            v35 = Vector3.new(-math.sin(tbl_upv_3.yaw), 0, -math.cos(tbl_upv_3.yaw))
            tbl_upv_3.eye = (Position_1 + Vector3.new(0, v36, 0)) - (v35 * 0.3)
            if a2.bobbing and tbl_upv_2.amount > 0 then
                tbl_upv_3.bobY = (-math.cos(tbl_upv_2.phase * 2) * 0.5) * u5 * tbl_upv_2.amount
                tbl_upv_3.bobRoll = math.sin(tbl_upv_2.phase) * u6 * tbl_upv_2.amount
            end
        else
            tbl_upv_2.eyeOff = nil
        end
    else
        tbl_upv_2.lastPos = nil
    end
    return tbl_upv_3
end
function tbl_upv_1.AfterCamera(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: AfterCamera
      line: 278
      upvalues:
        tbl_upv_2 (copy, index: 1)
        setHidden (copy, index: 2)
        viewModel (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        Combat_upv_1 (copy, index: 6)
    ]]
    if not tbl_upv_2.active then
        return
    end
    local v38
    if a5 and (a4 and (a2.present)) then
        v38 = a3
    else
        v38 = nil
    end
    if v38 ~= tbl_upv_2.hiddenModel or v38 and a6 ~= tbl_upv_2.hiddenItem then
        if tbl_upv_2.hiddenModel ~= v38 then
            setHidden(tbl_upv_2.hiddenModel, false)
        end
        setHidden(v38, true)
        tbl_upv_2.hiddenModel = v38
        tbl_upv_2.hiddenItem = a6
    end
    local v39 = bit32.btest(a2.flags, 8)
    local v40 = nil
    if v39 ~= tbl_upv_2.lastBlock then
        tbl_upv_2.lastBlock = v39
        local tbl_20 = {}
        tbl_20.on = v39
        v40 = viewModel()
        if v40 and tbl_upv_2.active then
            pcall(v40.ExternalEvent, "Block", tbl_20)
        end
    end
    local v41 = viewModel()
    if not v41 then
        return
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    v40 = nil
    if a5 and CurrentCamera_1 then
        local v42 = nil
        if tbl_upv_2.params then
            v42 = Workspace_upv_1:Spherecast(CurrentCamera_1.CFrame.Position, 0.15, CurrentCamera_1.CFrame.LookVector * 1.8, tbl_upv_2.params)
            if v42 then
                v40 = v42.Distance
            else
                v40 = nil
            end
        end
    end
    tbl_upv_4.dt = a1
    tbl_upv_4.visible = a5
    tbl_upv_4.id = a6
    local v43
    if a6 then
        v43 = Combat_upv_1.Kind(a6)
    else
        v43 = nil
    end
    tbl_upv_4.kind = v43
    tbl_upv_4.charges = a7
    tbl_upv_4.grounded = bit32.btest(a2.flags, 2)
    tbl_upv_4.rootY = a2.cf.Position.Y
    tbl_upv_4.sliding = bit32.btest(a2.flags, 4)
    tbl_upv_4.aiming = a2.aimCam == true
    tbl_upv_4.bobPhase = tbl_upv_2.phase
    tbl_upv_4.bobAmount = tbl_upv_2.amount
    tbl_upv_4.wall = v40
    pcall(v41.ExternalFrame, tbl_upv_4)
end
return tbl_upv_1